-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

t=0
x=96
y=24

hud = {}

-- vaisseau
p = {
	x = 10,
	y = 10,
	r = 0,
	pb = 1,
	canShoot = true,
	fireDelay = 15,		--nombre de tire par seconde
	powerLoadBar = 1, 					-- rotation du vaisseau
	overLoadLow = 0.1, --baisse du overload
	overload = 10,			-- si le vaisseau tir trop il est en surcharge
	maxOverlaod = 100,
	shield = 0,
	dash = 0,				-- deux coup de fleche et le vaisseau dashera dans la direction de la fleche
}


fDelay = 0 --permet de gerrer le delay des shoot
bullets = {}


function TIC()
	t=t+1


	cls(9)
	
	
	p:controller()

--DRAW --
	p:fireDraw()
	p:draw()
	hud:bar()

end


function p:fire()
	if p.overload > 234 then
		p.canShoot = false	
	end

	p.overload = p.overload + p.powerLoadBar

	fDelay = fDelay + 1
	local b = {
		spr = 16,
		x = p.x + 2,
		y = p.y + 1,
		dx = 3,
		dy = 0
	}
	if fDelay > p.fireDelay then
		fDelay = 0
		table.insert(bullets, b)
	end
end

function p:fireDraw()
	for i, b in pairs(bullets) do
		spr(b.spr, b.x, b.y, 0)
		if b.x > 235 then
			table.remove( bullets, i )
		end
	end
end

function overload()
	if p.overload > 5 then
		p.overload = p.overload - p.overLoadLow
	else
		p.canShoot = true
	end
	
end


function p:controller()
	if btn(0) then p.y=p.y-1 end
	if btn(1) then p.y=p.y+1 end 
	if btn(2) then p.x=p.x-1 end
	if btn(3) then p.x=p.x+1 end
	
	--shot function
	overload()
	for _, b in pairs(bullets) do
		b.x = b.x + b.dx
		b.y = b.y + b.dy
	end
	
	if btn(4) and p.canShoot then
		p:fire()
	end

end



function p:draw()
	spr(0,p.x,p.y,0)
end


function hud:bar()
	--fuel bar
	rect(2,2,235,3,8)
	--overload
	rect(2,5,235,2,14) --barre arriere plan	
	rect(2,5,p.overload,2,6) --barre pleine
end


-- <PALETTE>
-- 000:140c1c44243430346d4e4a4e854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

-- <TILES>
-- 000:0000000000000000000000000200000002222200022222200220000002000000
-- 016:00000000000000000000000000000000ee000000000000000000000000000000
-- </TILES>

-- <SPRITES>
-- 000:0000000000000000000000000050000000500500005555000055000000000000
-- </SPRITES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000600000000000c0000000e000a0000000d00080000000c00000007000000000000000000040000000c0000000000080000000c0000000b00304000000000
-- </SFX>

