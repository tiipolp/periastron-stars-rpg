local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tiipolp/attack-on-titan-revolution-autofarm/main/OrionUI%20Fixed.lua"))()

local vim = game:GetService("VirtualInputManager")
local rs = game:GetService("RunService")

local plr = game.Players.LocalPlayer
local char = plr.Character
local hrp = char.HumanoidRootPart

local freezeNPCs = false
local antiHit = false
local instaKill = false

local antiHitDetector = Instance.new("Part")
antiHitDetector.Size = Vector3.new(10, 3, 10)
antiHitDetector.Anchored = true
antiHitDetector.CanCollide = false
antiHitDetector.Transparency = 1
antiHitDetector.Parent = char

local antiHitList = {}

game:GetService("RunService").Heartbeat:Connect(function()
    if antiHit then

        for char, _ in pairs(antiHitList) do
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position, char.HumanoidRootPart.Position - (hrp.Position - char.HumanoidRootPart.Position).unit)
        end

        antiHitDetector.CFrame = hrp.CFrame
    end

    if instaKill then
        for char, _ in pairs(antiHitList) do
            if char.HealthGui.Health.Visible == true then
                char.Head:Destroy()
            end
        end

        antiHitDetector.CFrame = hrp.CFrame
    end
end)

antiHitDetector.Touched:Connect(function(hit)
    if hit.Name == "HumanoidRootPart" and hit.Parent ~= game.Players.LocalPlayer.Character then
        antiHitList[hit.Parent] = true
    end
end)

antiHitDetector.TouchEnded:Connect(function(hit)
    if hit.Name == "HumanoidRootPart" and hit.Parent ~= game.Players.LocalPlayer.Character then
        antiHitList[hit.Parent] = nil
    end
end)

local Window = OrionLib:MakeWindow({Name = "Tiipolp on v3rm"})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	TestersOnly = false
})

Main:AddToggle({
	Name = "Freeze NPCs",
	Default = true,
	Callback = function(Value)
        freezeNPCs = Value
	end    
})

Main:AddToggle({
	Name = "Anti-Hit (Makes NPCs Not Hit You)",
	Default = true,
	Callback = function(Value)
        antiHit = Value
	end    
})

Main:AddToggle({
	Name = "Insta-Kill NPC, You have to hit them at least once",
	Default = true,
	Callback = function(Value)
        instaKill = Value
	end    
})

local teleports = {}

for i,v in pairs(workspace.Teleports:GetChildren()) do
    teleports[i] = v.Name
end

Main:AddDropdown({
	Name = "Teleports",
	Default = "...",
	Options = teleports,
	Callback = function(Value)
		hrp.CFrame = workspace.Teleports[Value].CFrame
	end    
})

Main:AddButton({
	Name = "Collect XP Crystals",
	Callback = function()
        local originalPosition = hrp.CFrame

        for i,v in pairs(workspace.Special:GetChildren()) do
            if v.Name == "XpCrystal" then
                if v.Hitbox.Transparency ~= 1 then
                    hrp.CFrame = v.Hitbox.CFrame

                    local counter = 0

                    while counter < 1 do
                        vim:SendKeyEvent(true, Enum.KeyCode.A, false, nil)
                        wait(0.1)
                        vim:SendKeyEvent(false, Enum.KeyCode.A, false, nil)
                        
                        wait(0.1)

                        vim:SendKeyEvent(true, Enum.KeyCode.D, false, nil)
                        wait(0.1)
                        vim:SendKeyEvent(false, Enum.KeyCode.D, false, nil)

                        counter = counter + 1
                    end

                    wait(0.1)
                end
            end
        end

        hrp.CFrame = originalPosition
  	end
})

Main:AddButton({
	Name = "Collect Chests",
	Callback = function()
        local originalPosition = hrp.CFrame

        for i,v in pairs(workspace.Special:GetChildren()) do
            if v.Name == "Chest" then
                if v.Hitbox.Transparency ~= 1 then
                    hrp.CFrame = v.Hitbox.CFrame

                    local counter = 0

                    while counter < 1 do
                        vim:SendKeyEvent(true, Enum.KeyCode.A, false, nil)
                        wait(0.1)
                        vim:SendKeyEvent(false, Enum.KeyCode.A, false, nil)
                        
                        wait(0.1)

                        vim:SendKeyEvent(true, Enum.KeyCode.D, false, nil)
                        wait(0.1)
                        vim:SendKeyEvent(false, Enum.KeyCode.D, false, nil)

                        counter = counter + 1
                    end

                    wait(0.1)
                end
            end
        end

        hrp.CFrame = originalPosition
  	end
})

task.defer(function()
    while wait(0.5) do
        if freezeNPCs then
            for i,v in pairs(workspace.Enemies:GetDescendants()) do
                if v:IsA("Part") and v.Name == "HumanoidRootPart" and not v.Anchored then
                    v.Anchored = true
                end
            end
        else
            for i,v in pairs(workspace.Enemies:GetDescendants()) do
                if v:IsA("Part") and v.Name == "HumanoidRootPart" then
                    v.Anchored = false
                end
            end
        end
    end
end)
