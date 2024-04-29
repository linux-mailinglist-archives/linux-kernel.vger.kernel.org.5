Return-Path: <linux-kernel+bounces-162044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4808C8B5523
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6614F1C2132F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A573716F;
	Mon, 29 Apr 2024 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgBok8Pp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341412DF84
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386221; cv=none; b=BSS1XArwSTEUcMzPHGaRUb5RHtJ+AmiXAhZLNDoa2B+z2qBU5lch71KJY9iwOtZqp56/axJhL0AdPYyFlina2kljvoUExb3ywRJT+/NSndBg3nDtgy+Fy+Bbcllz23mGiRP5L6xf8MCa8W3Kdg33IneHKBlb6Y6IieRTpD5NBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386221; c=relaxed/simple;
	bh=x5a09vghPrGe9v/WbCl6gH8cNdI8xfz13rXGD7/fYd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kqu4J9TESYCBtckUtN7GYlXZseA3T7UjJqbhKUbJJKl+ajrBS7Bbypsn0RxValSSq8ectdiCEYPIYP4qWcGMEaLJDXX0X4vJKT+Py77OAPY+AdcdubyGg5Q3nyqthLVVuORn2YZDkmOw+2tb/8Id6fPhIh5DdujKZ++fwe10o3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgBok8Pp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714386218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFz1mKVH4XDJ+A7o7XuKUhmUrD6K5WvSG5J+VCFf+LU=;
	b=cgBok8PpjgoxRCqmL8WKTmED3hWGzzaR+JvFQkqk/ORcKGq+ahsZ2IIHdi4lYhX9yuxz+A
	RMDb4nqwk877JSadp9YA2+Bp9OZWKnbS1GAFZMB3gGi1T80T5XSveFfmvp4SnEBvTOMlPh
	OlymLVkk7yruhLOBNRp/w6FkLqzcmQI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-j2I4lHoeMTuGENBSV8ioow-1; Mon, 29 Apr 2024 06:23:36 -0400
X-MC-Unique: j2I4lHoeMTuGENBSV8ioow-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a52539e4970so280832066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386215; x=1714991015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFz1mKVH4XDJ+A7o7XuKUhmUrD6K5WvSG5J+VCFf+LU=;
        b=UrhJYnPbHiMk4QN+terOVQkvh5ZrJ+noGofzmFTgrhJSRBRPiHeZm2Whzpn68xzqDt
         dcejOQWFRunXt9tc5mY+wV32zj2fWisuq5je5EBLzuNk1qb5HODv+nIn78zvk1j993gJ
         DaZMHfZ/rk0Jm6hCR4ngC/yj9WZPwMeW71Ki3Qu5bbrPI7IW9en59E6doKsfBXV3J2AA
         3Pagh1P3Jkuvq8jebqyQUFLqKo+aSsBBg9rwjFy+7rRhRerGW/y+jdwx2ZmpnSHc3v7D
         DStiQac6P/5Ctwp9THjPa5cPhA97mK0I6Bd55BtMAmmhVEKKSylUkgSu3JFDL2W+wviI
         v1fw==
X-Forwarded-Encrypted: i=1; AJvYcCWYdetHOGXu1FLPQ0ebWpyne3RB1DxE0bWMo4B1I1ZFDsZufZ82ZW2vstINHXsEi2w6HBFmdDz6Yf+2dG4/kAJ+YF6GNT+HKe+3SW5w
X-Gm-Message-State: AOJu0Yy3Icyt0PlYoxKd8/RjNiDR/PvhB01VqTEUPFUh1nvhODQpjX34
	L42JZaknOU8Gaw6iD4YfUfGqtb9F51TFrd0W+jjQ3YU4SYurgaFz9AFYI3hAKpuUrajPwOHez8h
	WBBSZd6imI/36BdZYDATC2NQ63OtM2oFjxm/n2E1P+R3wXhA1rjr6fSuPAFkrBA==
X-Received: by 2002:a17:906:6d3:b0:a51:a288:5af9 with SMTP id v19-20020a17090606d300b00a51a2885af9mr5832275ejb.51.1714386214973;
        Mon, 29 Apr 2024 03:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkOwatt9+6Oy+GAc3xg79aqtFn82lEnJmzRpANlCFm6Qhru4n1GWf9Fd7Ot+KB2g9uztlRHw==
X-Received: by 2002:a17:906:6d3:b0:a51:a288:5af9 with SMTP id v19-20020a17090606d300b00a51a2885af9mr5832261ejb.51.1714386214515;
        Mon, 29 Apr 2024 03:23:34 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906398200b00a4df061728fsm13708459eje.83.2024.04.29.03.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:23:34 -0700 (PDT)
Message-ID: <965c8921-45fc-47e7-a678-e0c0b8935d65@redhat.com>
Date: Mon, 29 Apr 2024 12:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi: Add MSI WMI Platform driver
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com
Cc: teackot@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240421191145.3189-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240421191145.3189-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/21/24 9:11 PM, Armin Wolf wrote:
> Add a new driver for the MSI WMI Platform interface. The underlying
> ACPI WMI interface supports many features, but so far only reading
> of fan speed sensors is implemented.
> 
> The driver was reverse-engineered based on a user request to the
> lm-sensors project, see the github issue for details.
> 
> The ACPI WMI interface used by this driver seems to use the same
> embedded controller interface as the msi-ec driver, but supports
> automatic discovery of supported machines without relying on a
> DMI whitelist.
> 
> The driver was tested by the user who created the github issue.
> 
> Closes: https://github.com/lm-sensors/lm-sensors/issues/475
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  .../ABI/testing/debugfs-msi-wmi-platform      |  14 +
>  .../wmi/devices/msi-wmi-platform.rst          | 194 ++++++++
>  MAINTAINERS                                   |   8 +
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/msi-wmi-platform.c       | 428 ++++++++++++++++++
>  6 files changed, 656 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-msi-wmi-platform
>  create mode 100644 Documentation/wmi/devices/msi-wmi-platform.rst
>  create mode 100644 drivers/platform/x86/msi-wmi-platform.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-msi-wmi-platform b/Documentation/ABI/testing/debugfs-msi-wmi-platform
> new file mode 100644
> index 000000000000..71f9992168d8
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-msi-wmi-platform
> @@ -0,0 +1,14 @@
> +What:		/sys/kernel/debug/msi-wmi-platform-<wmi_device_name>/*
> +Date:		April 2024
> +KernelVersion:	6.10
> +Contact:	Armin Wolf <W_Armin@gmx.de>
> +Description:
> +		This file allows to execute the associated WMI method with the same name.
> +
> +		To start the execution, write a  buffer containing the method arguments
> +		at file offset 0. Partial writes or writes at a different offset are not
> +		supported.
> +
> +		The buffer returned by the WMI method can then be read from the file.
> +
> +		See Documentation/wmi/devices/msi-wmi-platform.rst for details.
> diff --git a/Documentation/wmi/devices/msi-wmi-platform.rst b/Documentation/wmi/devices/msi-wmi-platform.rst
> new file mode 100644
> index 000000000000..29b1b2e6d42c
> --- /dev/null
> +++ b/Documentation/wmi/devices/msi-wmi-platform.rst
> @@ -0,0 +1,194 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===================================================
> +MSI WMI Platform Features driver (msi-wmi-platform)
> +===================================================
> +
> +Introduction
> +============
> +
> +Many MSI notebooks support various features like reading fan sensors. This features are controlled
> +by the embedded controller, with the ACPI firmware exposing a standard ACPI WMI interface on top
> +of the embedded controller interface.
> +
> +WMI interface description
> +=========================
> +
> +The WMI interface description can be decoded from the embedded binary MOF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> +  [WMI, Locale("MS\0x409"),
> +   Description("This class contains the definition of the package used in other classes"),
> +   guid("{ABBC0F60-8EA1-11d1-00A0-C90629100000}")]
> +  class Package {
> +    [WmiDataId(1), read, write, Description("16 bytes of data")] uint8 Bytes[16];
> +  };
> +
> +  [WMI, Locale("MS\0x409"),
> +   Description("This class contains the definition of the package used in other classes"),
> +   guid("{ABBC0F63-8EA1-11d1-00A0-C90629100000}")]
> +  class Package_32 {
> +    [WmiDataId(1), read, write, Description("32 bytes of data")] uint8 Bytes[32];
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
> +   Description("Class used to operate methods on a package"),
> +   guid("{ABBC0F6E-8EA1-11d1-00A0-C90629100000}")]
> +  class MSI_ACPI {
> +    [key, read] string InstanceName;
> +    [read] boolean Active;
> +
> +    [WmiMethodId(1), Implemented, read, write, Description("Return the contents of a package")]
> +    void GetPackage([out, id(0)] Package Data);
> +
> +    [WmiMethodId(2), Implemented, read, write, Description("Set the contents of a package")]
> +    void SetPackage([in, id(0)] Package Data);
> +
> +    [WmiMethodId(3), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_EC([out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(4), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_EC([in, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(5), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_BIOS([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(6), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_BIOS([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(7), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_SMBUS([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(8), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_SMBUS([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(9), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_MasterBattery([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(10), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_MasterBattery([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(11), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_SlaveBattery([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(12), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_SlaveBattery([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(13), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Temperature([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(14), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Temperature([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(15), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Thermal([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(16), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Thermal([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(17), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Fan([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(18), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Fan([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(19), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Device([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(20), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Device([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(21), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Power([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(22), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Power([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(23), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Debug([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(24), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Debug([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(25), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_AP([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(26), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_AP([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(27), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_Data([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(28), Implemented, read, write, Description("Set the contents of a package")]
> +    void Set_Data([in, out, id(0)] Package_32 Data);
> +
> +    [WmiMethodId(29), Implemented, read, write, Description("Return the contents of a package")]
> +    void Get_WMI([out, id(0)] Package_32 Data);
> +  };
> +
> +Due to a peculiarity in how Windows handles the ``CreateByteField()`` ACPI operator (errors only
> +happen when a invalid byte field is ultimately accessed), all methods require a 32 byte input
> +buffer, even if the Binay MOF says otherwise.
> +
> +The input buffer contains a single byte to select the subfeature to be accessed and 31 bytes of
> +input data, the meaning of which depends on the subfeature being accessed.
> +
> +The output buffer contains a singe byte which signals success or failure (``0x00`` on failure)
> +and 31 bytes of output data, the meaning if which depends on the subfeature being accessed.
> +
> +WMI method Get_EC()
> +-------------------
> +
> +Returns embedded controller information, the selected subfeature does not matter. The output
> +data contains a flag byte and a 28 byte controller firmware version string.
> +
> +The first 4 bits of the flag byte contain the minor version of the embedded controller interface,
> +with the next 2 bits containing the major version of the embedded controller interface.
> +
> +The 7th bit signals if the embedded controller page chaged (exact meaning is unknown), and the
> +last bit signals if the platform is a Tigerlake platform.
> +
> +The MSI software seems to only use this interface when the last bit is set.
> +
> +WMI method Get_Fan()
> +--------------------
> +
> +Fan speed sensors can be accessed by selecting subfeature ``0x00``. The output data contains
> +up to four 16-bit fan speed readings in big-endian format. Most machines do not support all
> +four fan speed sensors, so the remaining reading are hardcoded to ``0x0000``.
> +
> +The fan RPM readings can be calculated with the following formula:
> +
> +        RPM = 480000 / <fan speed reading>
> +
> +If the fan speed reading is zero, then the fan RPM is zero too.
> +
> +WMI method Get_WMI()
> +--------------------
> +
> +Returns the version of the ACPI WMI interface, the selected subfeature does not matter.
> +The output data contains two bytes, the first one contains the major version and the last one
> +contains the minor revision of the ACPI WMI interface.
> +
> +The MSI software seems to only use this interface when the major version is greater than two.
> +
> +Reverse-Engineering the MSI WMI Platform interface
> +==================================================
> +
> +.. warning:: Randomly poking the embedded controller interface can potentially cause damage
> +             to the machine and other unwanted side effects, please be careful.
> +
> +The underlying embedded controller interface is used by the ``msi-ec`` driver, and it seems
> +that many methods just copy a part of the embedded controller memory into the output buffer.
> +
> +This means that the remaining WMI methods can be reverse-engineered by looking which part of
> +the embedded controller memory is accessed by the ACPI AML code. The driver also supports a
> +debugfs interface for directly executing WMI methods. Additionally, any safety checks regarding
> +unsupported hardware can be disabled by loading the module with ``force=true``.
> +
> +More information about the MSI embedded controller interface can be found at the
> +`msi-ec project <https://github.com/BeardOverflow/msi-ec>`_.
> +
> +Special thanks go to github user `glpnk` for showing how to decode the fan speed readings.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fb0fa67576d..846187625552 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15041,6 +15041,14 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Orphan
>  F:	drivers/platform/x86/msi-wmi.c
> 
> +MSI WMI PLATFORM FEATURES
> +M:	Armin Wolf <W_Armin@gmx.de>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-msi-wmi-platform
> +F:	Documentation/wmi/devices/msi-wmi-platform.rst
> +F:	drivers/platform/x86/msi-wmi-platform.c
> +
>  MSI001 MEDIA DRIVER
>  L:	linux-media@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 168b57df0a6a..b744f18bbfa7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -698,6 +698,17 @@ config MSI_WMI
>  	 To compile this driver as a module, choose M here: the module will
>  	 be called msi-wmi.
> 
> +config MSI_WMI_PLATFORM
> +	tristate "MSI WMI Platform features"
> +	depends on ACPI_WMI
> +	depends on HWMON
> +	help
> +	  Say Y here if you want to have support for WMI-based platform features
> +	  like fan sensor access on MSI machines.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called msi-wmi-platform.
> +
>  config XO15_EBOOK
>  	tristate "OLPC XO-1.5 ebook switch"
>  	depends on OLPC || COMPILE_TEST
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 8076bf3a7e83..26b8af55738b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_QUICKSTART)  += quickstart.o
>  obj-$(CONFIG_MSI_EC)		+= msi-ec.o
>  obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
>  obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
> +obj-$(CONFIG_MSI_WMI_PLATFORM)	+= msi-wmi-platform.o
> 
>  # OLPC
>  obj-$(CONFIG_XO15_EBOOK)	+= xo15-ebook.o
> diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x86/msi-wmi-platform.c
> new file mode 100644
> index 000000000000..436fb91a47db
> --- /dev/null
> +++ b/drivers/platform/x86/msi-wmi-platform.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Linux driver for WMI platform features on MSI notebooks.
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#define pr_format(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/device/driver.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/rwsem.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define DRIVER_NAME	"msi-wmi-platform"
> +
> +#define MSI_PLATFORM_GUID	"ABBC0F6E-8EA1-11d1-00A0-C90629100000"
> +
> +#define MSI_WMI_PLATFORM_INTERFACE_VERSION	2
> +
> +#define MSI_PLATFORM_WMI_MAJOR_OFFSET	1
> +#define MSI_PLATFORM_WMI_MINOR_OFFSET	2
> +
> +#define MSI_PLATFORM_EC_FLAGS_OFFSET	1
> +#define MSI_PLATFORM_EC_MINOR_MASK	GENMASK(3, 0)
> +#define MSI_PLATFORM_EC_MAJOR_MASK	GENMASK(5, 4)
> +#define MSI_PLATFORM_EC_CHANGED_PAGE	BIT(6)
> +#define MSI_PLATFORM_EC_IS_TIGERLAKE	BIT(7)
> +#define MSI_PLATFORM_EC_VERSION_OFFSET	2
> +
> +static bool force;
> +module_param_unsafe(force, bool, 0);
> +MODULE_PARM_DESC(force, "Force loading without checking for supported WMI interface versions");
> +
> +enum msi_wmi_platform_method {
> +	MSI_PLATFORM_GET_PACKAGE	= 0x01,
> +	MSI_PLATFORM_SET_PACKAGE	= 0x02,
> +	MSI_PLATFORM_GET_EC		= 0x03,
> +	MSI_PLATFORM_SET_EC		= 0x04,
> +	MSI_PLATFORM_GET_BIOS		= 0x05,
> +	MSI_PLATFORM_SET_BIOS		= 0x06,
> +	MSI_PLATFORM_GET_SMBUS		= 0x07,
> +	MSI_PLATFORM_SET_SMBUS		= 0x08,
> +	MSI_PLATFORM_GET_MASTER_BATTERY = 0x09,
> +	MSI_PLATFORM_SET_MASTER_BATTERY = 0x0a,
> +	MSI_PLATFORM_GET_SLAVE_BATTERY	= 0x0b,
> +	MSI_PLATFORM_SET_SLAVE_BATTERY	= 0x0c,
> +	MSI_PLATFORM_GET_TEMPERATURE	= 0x0d,
> +	MSI_PLATFORM_SET_TEMPERATURE	= 0x0e,
> +	MSI_PLATFORM_GET_THERMAL	= 0x0f,
> +	MSI_PLATFORM_SET_THERMAL	= 0x10,
> +	MSI_PLATFORM_GET_FAN		= 0x11,
> +	MSI_PLATFORM_SET_FAN		= 0x12,
> +	MSI_PLATFORM_GET_DEVICE		= 0x13,
> +	MSI_PLATFORM_SET_DEVICE		= 0x14,
> +	MSI_PLATFORM_GET_POWER		= 0x15,
> +	MSI_PLATFORM_SET_POWER		= 0x16,
> +	MSI_PLATFORM_GET_DEBUG		= 0x17,
> +	MSI_PLATFORM_SET_DEBUG		= 0x18,
> +	MSI_PLATFORM_GET_AP		= 0x19,
> +	MSI_PLATFORM_SET_AP		= 0x1a,
> +	MSI_PLATFORM_GET_DATA		= 0x1b,
> +	MSI_PLATFORM_SET_DATA		= 0x1c,
> +	MSI_PLATFORM_GET_WMI		= 0x1d,
> +};
> +
> +struct msi_wmi_platform_debugfs_data {
> +	struct wmi_device *wdev;
> +	enum msi_wmi_platform_method method;
> +	struct rw_semaphore buffer_lock;	/* Protects debugfs buffer */
> +	size_t length;
> +	u8 buffer[32];
> +};
> +
> +static const char * const msi_wmi_platform_debugfs_names[] = {
> +	"get_package",
> +	"set_package",
> +	"get_ec",
> +	"set_ec",
> +	"get_bios",
> +	"set_bios",
> +	"get_smbus",
> +	"set_smbus",
> +	"get_master_battery",
> +	"set_master_battery",
> +	"get_slave_battery",
> +	"set_slave_battery",
> +	"get_temperature",
> +	"set_temperature",
> +	"get_thermal",
> +	"set_thermal",
> +	"get_fan",
> +	"set_fan",
> +	"get_device",
> +	"set_device",
> +	"get_power",
> +	"set_power",
> +	"get_debug",
> +	"set_debug",
> +	"get_ap",
> +	"set_ap",
> +	"get_data",
> +	"set_data",
> +	"get_wmi"
> +};
> +
> +static int msi_wmi_platform_parse_buffer(union acpi_object *obj, u8 *output, size_t length)
> +{
> +	if (obj->type != ACPI_TYPE_BUFFER)
> +		return -ENOMSG;
> +
> +	if (obj->buffer.length != length)
> +		return -EPROTO;
> +
> +	if (!obj->buffer.pointer[0])
> +		return -EIO;
> +
> +	memcpy(output, obj->buffer.pointer, obj->buffer.length);
> +
> +	return 0;
> +}
> +
> +static int msi_wmi_platform_query(struct wmi_device *wdev, enum msi_wmi_platform_method method,
> +				  u8 *input, size_t input_length, u8 *output, size_t output_length)
> +{
> +	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_buffer in = {
> +		.length = input_length,
> +		.pointer = input
> +	};
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret;
> +
> +	if (!input_length || !output_length)
> +		return -EINVAL;
> +
> +	status = wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj = out.pointer;
> +	if (!obj)
> +		return -ENODATA;
> +
> +	ret = msi_wmi_platform_parse_buffer(obj, output, output_length);
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static umode_t msi_wmi_platform_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static int msi_wmi_platform_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct wmi_device *wdev = dev_get_drvdata(dev);
> +	u8 input[32] = { 0 };
> +	u8 output[32];
> +	u16 data;
> +	int ret;
> +
> +	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_FAN, input, sizeof(input), output,
> +				     sizeof(output));
> +	if (ret < 0)
> +		return ret;
> +
> +	data = get_unaligned_be16(&output[channel * 2 + 1]);
> +	if (!data)
> +		*val = 0;
> +	else
> +		*val = 480000 / data;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops msi_wmi_platform_ops = {
> +	.is_visible = msi_wmi_platform_is_visible,
> +	.read = msi_wmi_platform_read,
> +};
> +
> +static const struct hwmon_channel_info * const msi_wmi_platform_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info msi_wmi_platform_chip_info = {
> +	.ops = &msi_wmi_platform_ops,
> +	.info = msi_wmi_platform_info,
> +};
> +
> +static ssize_t msi_wmi_platform_write(struct file *fp, const char __user *input, size_t length,
> +				      loff_t *offset)
> +{
> +	struct seq_file *seq = fp->private_data;
> +	struct msi_wmi_platform_debugfs_data *data = seq->private;
> +	u8 payload[32] = { };
> +	ssize_t ret;
> +
> +	/* Do not allow partial writes */
> +	if (*offset != 0)
> +		return -EINVAL;
> +
> +	/* Do not allow incomplete command buffers */
> +	if (length != data->length)
> +		return -EINVAL;
> +
> +	ret = simple_write_to_buffer(payload, sizeof(payload), offset, input, length);
> +	if (ret < 0)
> +		return ret;
> +
> +	down_write(&data->buffer_lock);
> +	ret = msi_wmi_platform_query(data->wdev, data->method, payload, data->length, data->buffer,
> +				     data->length);
> +	up_write(&data->buffer_lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return length;
> +}
> +
> +static int msi_wmi_platform_show(struct seq_file *seq, void *p)
> +{
> +	struct msi_wmi_platform_debugfs_data *data = seq->private;
> +	int ret;
> +
> +	down_read(&data->buffer_lock);
> +	ret = seq_write(seq, data->buffer, data->length);
> +	up_read(&data->buffer_lock);
> +
> +	return ret;
> +}
> +
> +static int msi_wmi_platform_open(struct inode *inode, struct file *fp)
> +{
> +	struct msi_wmi_platform_debugfs_data *data = inode->i_private;
> +
> +	/* The seq_file uses the last byte of the buffer for detecting buffer overflows */
> +	return single_open_size(fp, msi_wmi_platform_show, data, data->length + 1);
> +}
> +
> +static const struct file_operations msi_wmi_platform_debugfs_fops = {
> +	.owner = THIS_MODULE,
> +	.open = msi_wmi_platform_open,
> +	.read = seq_read,
> +	.write = msi_wmi_platform_write,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static void msi_wmi_platform_debugfs_remove(void *data)
> +{
> +	struct dentry *dir = data;
> +
> +	debugfs_remove_recursive(dir);
> +}
> +
> +static void msi_wmi_platform_debugfs_add(struct wmi_device *wdev, struct dentry *dir,
> +					 const char *name, enum msi_wmi_platform_method method)
> +{
> +	struct msi_wmi_platform_debugfs_data *data;
> +	struct dentry *entry;
> +
> +	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;
> +
> +	data->wdev = wdev;
> +	data->method = method;
> +	init_rwsem(&data->buffer_lock);
> +
> +	/* The ACPI firmware for now always requires a 32 byte input buffer due to
> +	 * a peculiarity in how Windows handles the CreateByteField() ACPI operator.
> +	 */
> +	data->length = 32;
> +
> +	entry = debugfs_create_file(name, 0600, dir, data, &msi_wmi_platform_debugfs_fops);
> +	if (IS_ERR(entry))
> +		devm_kfree(&wdev->dev, data);
> +}
> +
> +static void msi_wmi_platform_debugfs_init(struct wmi_device *wdev)
> +{
> +	struct dentry *dir;
> +	char dir_name[64];
> +	int ret, method;
> +
> +	scnprintf(dir_name, ARRAY_SIZE(dir_name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
> +
> +	dir = debugfs_create_dir(dir_name, NULL);
> +	if (IS_ERR(dir))
> +		return;
> +
> +	ret = devm_add_action_or_reset(&wdev->dev, msi_wmi_platform_debugfs_remove, dir);
> +	if (ret < 0)
> +		return;
> +
> +	for (method = MSI_PLATFORM_GET_PACKAGE; method <= MSI_PLATFORM_GET_WMI; method++)
> +		msi_wmi_platform_debugfs_add(wdev, dir, msi_wmi_platform_debugfs_names[method - 1],
> +					     method);
> +}
> +
> +static int msi_wmi_platform_hwmon_init(struct wmi_device *wdev)
> +{
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&wdev->dev, "msi_wmi_platform", wdev,
> +						    &msi_wmi_platform_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> +
> +static int msi_wmi_platform_ec_init(struct wmi_device *wdev)
> +{
> +	u8 input[32] = { 0 };
> +	u8 output[32];
> +	u8 flags;
> +	int ret;
> +
> +	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_EC, input, sizeof(input), output,
> +				     sizeof(output));
> +	if (ret < 0)
> +		return ret;
> +
> +	flags = output[MSI_PLATFORM_EC_FLAGS_OFFSET];
> +
> +	dev_dbg(&wdev->dev, "EC RAM version %lu.%lu\n",
> +		FIELD_GET(MSI_PLATFORM_EC_MAJOR_MASK, flags),
> +		FIELD_GET(MSI_PLATFORM_EC_MINOR_MASK, flags));
> +	dev_dbg(&wdev->dev, "EC firmware version %.28s\n",
> +		&output[MSI_PLATFORM_EC_VERSION_OFFSET]);
> +
> +	if (!(flags & MSI_PLATFORM_EC_IS_TIGERLAKE)) {
> +		if (!force)
> +			return -ENODEV;
> +
> +		dev_warn(&wdev->dev, "Loading on a non-Tigerlake platform\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int msi_wmi_platform_init(struct wmi_device *wdev)
> +{
> +	u8 input[32] = { 0 };
> +	u8 output[32];
> +	int ret;
> +
> +	ret = msi_wmi_platform_query(wdev, MSI_PLATFORM_GET_WMI, input, sizeof(input), output,
> +				     sizeof(output));
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(&wdev->dev, "WMI interface version %u.%u\n",
> +		output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
> +		output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
> +
> +	if (output[MSI_PLATFORM_WMI_MAJOR_OFFSET] != MSI_WMI_PLATFORM_INTERFACE_VERSION) {
> +		if (!force)
> +			return -ENODEV;
> +
> +		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface version (%u.%u)\n",
> +			 output[MSI_PLATFORM_WMI_MAJOR_OFFSET],
> +			 output[MSI_PLATFORM_WMI_MINOR_OFFSET]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int msi_wmi_platform_probe(struct wmi_device *wdev, const void *context)
> +{
> +	int ret;
> +
> +	ret = msi_wmi_platform_init(wdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = msi_wmi_platform_ec_init(wdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	msi_wmi_platform_debugfs_init(wdev);
> +
> +	return msi_wmi_platform_hwmon_init(wdev);
> +}
> +
> +static const struct wmi_device_id msi_wmi_platform_id_table[] = {
> +	{ MSI_PLATFORM_GUID, NULL },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(wmi, msi_wmi_platform_id_table);
> +
> +static struct wmi_driver msi_wmi_platform_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = msi_wmi_platform_id_table,
> +	.probe = msi_wmi_platform_probe,
> +	.no_singleton = true,
> +};
> +module_wmi_driver(msi_wmi_platform_driver);
> +
> +MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
> +MODULE_DESCRIPTION("MSI WMI platform features");
> +MODULE_LICENSE("GPL");
> --
> 2.39.2
> 


