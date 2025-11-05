project "hidapi"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"
	
	warnings "Off"

	targetdir ("%{wks.location}/bin/%{outputdir}/%{prj.name}")
	objdir ("%{wks.location}/bin-int/%{outputdir}/%{prj.name}")

	files { "hidapi/*.c", "hidapi/*.h" }
	includedirs { "hidapi" }

	filter "system:windows"
		systemversion "latest"
		defines { "HIDAPI_WINDOWS" }
		files { "windows/hid.c" }

	filter "system:linux"
		pic "on"
		systemversion "latest"
		defines { "HIDAPI_LINUX" }
		files { "linux/hid.c" }
		links { "pthread", "udev" }

	filter "system:macosx"
		defines { "HIDAPI_MACOSX" }
		files { "mac/hid.c" }
		links { "IOKit.framework", "CoreFoundation.framework" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "On"
		optimize "Off"

	filter "configurations:Release"
		runtime "Release"
		symbols "On"
		optimize "On"

	filter "configurations:Dist"
		runtime "Release"
		symbols "Off"
		optimize "Speed"
