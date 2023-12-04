Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5A80335C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjLDMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjLDMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3679C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701694190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzSJzRGJiA67JC2LSj70AO4fsMktt2RyVoxiOqJgZrc=;
        b=ICVkZKp/D48/5BSJk+LQLBhODJmDjanVTcvmDUyowsOKCR0w0431nt3H6Pu2RSlD8L3Y2h
        O3yZIRsK3NscqSPMR+b/upqCDjM/ryVpq7oCjEBq5MnPee4SFbgvi0CFfI/zfCMk9T8AxE
        HNeA2cG42B1KPrJJUFR8eJQ8iKP3XtE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-vPHZ6HcBMg-t08v8OdRc7Q-1; Mon, 04 Dec 2023 07:49:49 -0500
X-MC-Unique: vPHZ6HcBMg-t08v8OdRc7Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a19d1aace7cso214048166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:49:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694187; x=1702298987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zzSJzRGJiA67JC2LSj70AO4fsMktt2RyVoxiOqJgZrc=;
        b=SBJfIDrBLBPU3zawQR9uwZ9YjN3h9h7G2sm5pGnxbWKXR0P7KQOr7+9AL55AtFnDUg
         33DqpbwBHbQYnG+3HwVd2yhTV0GoQQHFU6jrMlclPMcOBXK4CTHociU4TqpSJyqxTP4i
         pQnvpd34StYqE+sRYwCPX9eucKiXJnl1w7IqBp3gam5tX1nnwDIY/6y/vYTTJM9Ab0QA
         YqommkGh99qOycf07EAw1tBeRO0ItcvhPIsapc3ynwuIOweExNmooC/B45VJ75nD6+VQ
         erCf18zzrk+W0slvcnUEcsq9wH4uT5wAngWcu+ix6AymVjrrMSQ0B0xpCtHrLMIs7KS+
         F1rQ==
X-Gm-Message-State: AOJu0YwLs1lgbh5GNxinZqe59XNhR3DfaKkFNI9hLrYIfnK319sH3WfU
        nrAtoWjE6fZFFjZkoas+xLE4Frtnh8nuX5GVDiGbwM2lhvgWRIxy19GOOZfdXEfRkvo3mpPyvyy
        NvwYIf16E4iP36Zinj1HpzAUdQwW3rZ+0
X-Received: by 2002:a17:906:34c7:b0:a19:a19a:eabb with SMTP id h7-20020a17090634c700b00a19a19aeabbmr3488285ejb.116.1701694186977;
        Mon, 04 Dec 2023 04:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRBaRY2buohA36QZZoEqI5uLZV3GZEw/+UskoFPhc7JmjDYBQj1LiPVJvrDfUqs5mmJpnYhQ==
X-Received: by 2002:a17:906:34c7:b0:a19:a19a:eabb with SMTP id h7-20020a17090634c700b00a19a19aeabbmr3488276ejb.116.1701694186416;
        Mon, 04 Dec 2023 04:49:46 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kg6-20020a17090776e600b009bf7a4d591csm5303324ejc.11.2023.12.04.04.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:49:45 -0800 (PST)
Message-ID: <9f32a00a-398f-4a25-a288-2b0d0291f736@redhat.com>
Date:   Mon, 4 Dec 2023 13:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15] platform/x86: Add Silicom Platform Driver
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20231124200334.5318-1-henryshi2018@gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231124200334.5318-1-henryshi2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/23 21:03, Henry Shi wrote:
> platform/x86: Add Silicom Platform Driver
> 
> Add Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products.
> 
> This platform driver provides support for various functions via
> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> and device attributes.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

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
> 
> Changes from v1 to v2:
> ===========================
> 
> Suggested by Hans de Goede <hdegoede@redhat.com>
> .Use git send-email to submit patch.
> .patch contents should be in message body.
> .Kconfig bit for the driver should be in drivers/platform/x86/Kconfig.
> 
> changes from patch v2 to v3
> ===========================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>
> .Removed unnecessary include file linux/thermal.h.
> .Removed EXPORT_SYMBOL for mutex lock/unlock function.
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> .Remove extra new line in code on multiple position.
> .Use table instead of space in code.
> .Uss Linux defined bit operation MACRO define.
> .Removed local variable in rpm_get().
> .Corrected typo in comments.
> .Corrected incorrect indentation.
> .Removed unnecessary comments in silicom_mc_leds_register().
> .Rewrite efuse_status_show() to used defined variable and removed 
> uncessary local variables.
> .Rewrite uc_version_show() to used defined variable and removed 
> uncessary local variables.
> .Removed unused MACRO define: #define CHANNEL_TO_BIT(chan) ((chan) & 0x07).
> .Rewrite powercycle_uc() to used defined variable and removed uncessary 
> local variables.
> .use GENMASK() and use FIELD_GET() instead of bit shift.
> .Added define for constant 0x28 used in  efuse_status_show().
> .Added define for constant 0x0 used in  uc_version_show().
> .Added define for constant 0x0 used in  powercycle_uc().
> .Rearrange functions to avoid uncessary pre-define.
> .Rewrite rpm_get() to used defined variable and removed uncessary 
> local variables.
> .Rewrite temp_get() to used defined variable and removed uncessary 
> local variables.
> .Use FIELD_GET instead of bit shift in temp_get().
> .Used #define for constant variable 0/1.
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .use "if (!led->subled_info)" instead of
> "if (IS_ERR_OR_NULL(led->subled_info))
> "in silicom_mc_leds_register
> 
> changes from patch v3 to v4
> ===========================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Rewrite silicom_mec_led/gpip_set/get() functions to use two newly created
> silicom_mec_port_get()/silicom_mec_port_set() which have common code.
> .Remove duplicate code in silicom_mec_port_get()
> .Rewrite uc_version_show() to use Linux bit operation MACRO, and add
> logic to check un-supported register value.
> .Added "#define MEC_EFUSE_LSB_ADDR 0x28" and "#define
> MEC_POWER_CYCLE_ADDR 0x24"
> .Added "#define MEC_VERSION_MAJOR GENMASK(15, 14)" and "#define
> MEC_VERSION_MINOR GENMASK(13, 8)".
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .Used a local variable to store "sizeof(struct mc_subled)" in function
> silicom_mc_leds_register().
> 
> change from patch v4 to v5
> ===========================================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>:
> .Corrected return value in temp_get() to return 1/10000th degree.
> .Removed local variable struct silicom_fan_control_data *ctl in
> silicom_fan_control_read_fan(),
> removed storing rpm value to ctl variable.
> .Removed local variable struct silicom_fan_control_data *ctl in 
> silicom_fan_control_read_temp(),
> .removed storing rpm value to ctl variable.
> .Changed return string in silicom_fan_control_read_labels() to 
> specific string for Silicom platform driver.
> .Removed silicom_fan_control_data structure.
> .Removed static variable mec_io_base and mec_io_len, and added
> "#define MEC_IO_BASE 0x0800 and #define MEC_IO_LEN 0x8".
> .Removed ".write = NULL" in silicom_fan_control_hwmon_ops
> structure defination.
> .Removed unnecessary function silicom_fan_control_write().
> .Removed unnecessary check for silicom_led_info in function
> silicom_platform_probe.
> .Removed unnecessary local variable "silicom_fan_control_data *ctl"
> in silicom_platform_probe().
> .Clean out driver initialization error handling in
> silicom_platform_init();
> .Add patch version and changelog for patch submission.
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Rename "#define MEC_DATA(offset) to "#define MEC_DATA_OFFSET(offset).
> .Use constant defined in include/linux/units.h instead of a literal.
> .return directly instead of go to err condition when
> platform_device_register_simple() failed.
> .Remove unnecessary check for silicom_led_info and silicom_gpiochip.
> .Use a local variable to how multiple use of array size.
> .Align the arguments to the same column in
> silicom_mec_led_mc_brightness_set.
> .Add patch version and changelog that shows version to version changes
> for patch submission.
> 
> Changes suggested by Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> .Use "sizeof(*led)" instead of "sizeof(struct led_classdev_mc)"
> .Use "if (!led)" instead of "if (IS_ERR_OR_NULL(led))" 
> .Removed unnecessary error message:
> "dev_err(dev, "Failed to alloc led_classdev_mc[%d]:
> %ld\n", i, PTR_ERR(led)).
> 
> change from patch vv5 to v6
> ===========================================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>:
> .Removed checkpath warnings. 
> .Resoved dependencies between CONFIG_HWMON and CONFIG_SILICOM_PLATFORM.
> 
> change from patch v6 to v7
> ===========================================
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Usa a proper subsystem prefix for this patch subject:
> Subject: platform/x86: Add Silicom Platform Driver.
> 
> change from patch v7 to v8
> ===========================================
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Chnage commit message of this driver.
> .Adjust location of change log and signed-off-by.
> .Change "config SILICOM_PLATFORM" and help contents location,
> and put it to source "drivers/platform/x86/siemens/Kconfig".
> .Set editor tab to 8 and align the start of extra function
> parameters to directly after (. This should be applied for
> all function.
> .Do not manually create a sysfs dir and register sysfs attribute,
> instead define a platform_driver structure.
> .Move MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids) directly after
> table declaration.
> .Using pr_info() instead of dev_info() in function
> silicom_platform_info_init().
> .Made dmi_check_system() check the first thing to do in
> silicom_platform_init().
> .Instead of separate platform_device creation + driver registration,
> switched to using platform_create_bundle().
> .Removed mutex_destroy(&mec_io_mutex).
> 
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Too many GENMASK() within to code itself, need put them to
> #define. Removed all GENMASK() in c functions.
> 
> change from patch v8 to v9
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Just do the same (like MEC_VERSION_MAJOR) with all places in the where
> you previously had GENMASK() in the code (currently MEC_GET_BITS()
> is there, obviously, but it should go away and be replaced with
> FIELD_GET(GOODPREFIX_GOODNAME, ...))).
> .This is sysfs so it's odd to print pr_err() like that here. If the driver
> does not support those versions at all, the probe should fail. If driver is
> fine but just doesn't know how to interpret such a version, you should
> return -Esomething here. Driver returns -EINVAL here.
> .Replace CENTI with 100
> .Align FIELD_GET()s to the same column for line 661.
> .Change variables efuse_status, mec_uc_version, power_cycle to unsigned
> int from int.
> 
> changes suggested by Hans de Goede <hdegoede@redhat.com>:
> .Please add a Documentation/ABI/testing/sysfs-platform-silicom
> file to document driver specific the sysfs attributes of this driver.
> .Like with the Kconfig part, group this together with the other industrial
> PC drivers we have at the end of the Makefile after Siemens
> Simatic Industrial PCs.
> 
> change from patch v9 to v10
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Added missing newline in kernel document file.
> .Changed the order #define to make sure they are in increasing order.
> .Removed printing in init function silicom_platform_info_init();
> .Changed #define name MEC_PREFIX_HIGH_BYTES to MEC_TEMPERATURE.
> .Removed dev_err(dev, "Failed to register[%d]: %d\n", i, err)
> in function silicom_mc_leds_register() before ruturn err.
> .Changed %du to %u in function power_cycle_store(...).
> .Chnaged sprintf() to sysfs_emit().
> .Changed start point for multi-line comments.
> .Added empty line to seperate #define.
> .Remove parenthesis around MEC_IO_BASE.
> .Changed #define EC_ADDR_MSB (MEC_IO_BASE + 0x3), use
> a constant value instead of MEC_DATA_OFFSET_MASK.
> .Changed define name MEC_PREFIX_NAME to MEC_PORT_LOC.
> .Changed define MEC_PREFIX_HIGH_BYTES to MEC_TEMP_LOC.
> .Removed "PREFIX" from define name, changed
> MEC_PREFIX_SEC_BYTE to MEC_VERSION_LOC.
> 
> change from patch v10 to v11
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Don't print anything when userspace gives an invalid value,
> just return -EINVAL in function power_cycle_store().
> .The includes should be in alphabethical order.
> .Just make the calculation once and store into a local variable
> in function silicom_mec_port_set().
> .Use GENMASK for MEC_PORT_OFFSET_MASK, MEC_PORT_CHANNEL_MASK,
> MEC_DATA_OFFSET_MASK.
> .Rename MEC_PORT_LOC to MEC_PORT_DWORD_OFFSET.
> .Add local variable to function silicom_mec_port_set() and
> silicom_mec_port_get() to make the code less heavy to read.
> .Allgned defines start from same column mostly.
> .Kernel test robot WARNING sys/devices/platform/silicom-platform/hwmon/hwmon1/
> is defined 4 times.
> 
> change from patch v11 to v12
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> Several editorial things:
> .Put the subdir headers separately.
> .Add more new line in define section.
> .Use () around all macro arguments to be on the safe side.
> .Add new line and remove comment in function silicom_mec_port_get().
> .Add new line and remove comment in function silicom_mec_port_set().
> .Remove unnecessary comment in function temp_get(), rpm_get().
> 
> change from patch v12 to v13
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Put parenthesis in #define MEC_DATA_OFFSET(offset).
> .Remove unnecessary local variable *name and correct typo.
> .Use lower case for driver name.
> .Use reverse xmas tree order for function variables.
> 
> Changes suggested by Randy Dunlap <rdunlap@infradead.org>:
> .Added "depends on GPIOLIB" in Kconfig.
> .Added default value for power_cycle file.
> .Added scale of temperature returned by temp1_input.
> .Correct editorlal issue in sysfs-platform-silicom.
> .Removed extra parenthesis around MEC_IO_BASE.
> .More indentation in silicom_mec_led_mc_brightness_set().
> 
> .Kernel test robot WARNING: unmet direct dependencies detected for
> LEDS_CLASS_MULTICOLOR.
> 
> change from patch v13 to v14
> ===========================================
> 
> Changes suggested by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>:
> .Removed unnecessary comments in silicom_platform_init().
> .Removed parenthesis for #define EC_ADDR_MSB.
> .Ues depneds on instead of select for LEDS_CLASS_MULTICOLOR.
> .Corrected editorial issue in sysfs-platform-silicom file.
> .Modified power_cycle_store() to update power_cycle value
> after checking it's OK to take the mutex. 
> 
> change from patch v14 to v15 (Current)
> ===========================================
> 
> Changes suggested by Barnabás Pőcze <pobrn@protonmail.com>:
> .Removed unnecessary hwmon attributes fan, temp.
> .Removed unnecessary led, led-multicoloer attributes.
> .Changed led_classdev_xxx device name from "multicolor:"
> to "platled::" to conform with leds-class.rst.
> 
>  .../ABI/testing/sysfs-platform-silicom        |   31 +
>  drivers/platform/x86/Kconfig                  |   15 +
>  drivers/platform/x86/Makefile                 |    3 +
>  drivers/platform/x86/silicom-platform.c       | 1004 +++++++++++++++++
>  4 files changed, 1053 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-silicom
>  create mode 100644 drivers/platform/x86/silicom-platform.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-silicom b/Documentation/ABI/testing/sysfs-platform-silicom
> new file mode 100644
> index 000000000000..2a8815f31aea
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-silicom
> @@ -0,0 +1,31 @@
> +What:		/sys/devices/platform/silicom-platform/uc_version
> +Date:		November 2023
> +KernelVersion:	6.7
> +Contact:	Henry Shi <henrys@silicom-usa.com>
> +Description:
> +		This file allows to read microcontroller firmware
> +		version of current platform.
> +
> +What:		/sys/devices/platform/silicom-platform/power_cycle
> +Date:		November 2023
> +KernelVersion:	6.7
> +Contact:	Henry Shi <henrys@silicom-usa.com>
> +		This file allow user to power cycle the platform.
> +		Default value is 0; when set to 1, it powers down
> +		the platform, waits 5 seconds, then powers on the
> +		device. It returns to default value after power cycle.
> +
> +		0 - default value.
> +
> +What:		/sys/devices/platform/silicom-platform/efuse_status
> +Date:		November 2023
> +KernelVersion:	6.7
> +Contact:	Henry Shi <henrys@silicom-usa.com>
> +Description:
> +		This file is read only. It returns the current
> +		OTP status:
> +
> +		0 - not programmed.
> +		1 - programmed.
> +
> +
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 2a1070543391..3e58e49d8214 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1076,6 +1076,21 @@ config INTEL_SCU_IPC_UTIL
>  
>  source "drivers/platform/x86/siemens/Kconfig"
>  
> +config SILICOM_PLATFORM
> +	tristate "Silicom Edge Networking device support"
> +	depends on HWMON
> +	depends on GPIOLIB
> +	depends on LEDS_CLASS_MULTICOLOR
> +	help
> +	  This option enables support for the LEDs/GPIO/etc downstream of the
> +	  embedded controller on Silicom "Cordoba" hardware and derivatives.
> +
> +	  This platform driver provides support for various functions via
> +	  the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> +	  and device attributes.
> +
> +	  If you have a Silicom network appliance, say Y or M here.
> +
>  config WINMATE_FM07_KEYS
>  	tristate "Winmate FM07/FM07P front-panel keys driver"
>  	depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index b457de5abf7d..8fdb0c7d8ca1 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -133,6 +133,9 @@ obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
>  # Siemens Simatic Industrial PCs
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= siemens/
>  
> +# Silicom
> +obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o
> +
>  # Winmate
>  obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>  
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
> new file mode 100644
> index 000000000000..84b92b3f9f4b
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1004 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// silicom-platform.c - Silicom MEC170x platform driver
> +//
> +// Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +#include <linux/gpio/driver.h>
> +
> +#define MEC_POWER_CYCLE_ADDR 0x24
> +#define MEC_EFUSE_LSB_ADDR   0x28
> +#define MEC_GPIO_IN_POS      0x08
> +#define MEC_IO_BASE          0x0800
> +#define MEC_IO_LEN           0x8
> +#define IO_REG_BANK          0x0
> +#define DEFAULT_CHAN_LO      0
> +#define DEFAULT_CHAN_HI      0
> +#define DEFAULT_CHAN_LO_T    0xc
> +#define MEC_ADDR             (MEC_IO_BASE + 0x02)
> +#define EC_ADDR_LSB          MEC_ADDR
> +#define SILICOM_MEC_MAGIC    0x5a
> +
> +#define MEC_PORT_CHANNEL_MASK GENMASK(2, 0)
> +#define MEC_PORT_DWORD_OFFSET GENMASK(31, 3)
> +#define MEC_DATA_OFFSET_MASK  GENMASK(1, 0)
> +#define MEC_PORT_OFFSET_MASK  GENMASK(7, 2)
> +
> +#define MEC_TEMP_LOC          GENMASK(31, 16)
> +#define MEC_VERSION_LOC       GENMASK(15, 8)
> +#define MEC_VERSION_MAJOR     GENMASK(15, 14)
> +#define MEC_VERSION_MINOR     GENMASK(13, 8)
> +
> +#define EC_ADDR_MSB           (MEC_IO_BASE + 0x3)
> +#define MEC_DATA_OFFSET(offset) (MEC_IO_BASE + 0x04 + (offset))
> +
> +#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) | (bit))
> +#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)
> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static unsigned int efuse_status;
> +static unsigned int mec_uc_version;
> +static unsigned int power_cycle;
> +
> +static const struct hwmon_channel_info *silicom_fan_control_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +struct silicom_platform_info {
> +	int io_base;
> +	int io_len;
> +	struct led_classdev_mc *led_info;
> +	struct gpio_chip *gpiochip;
> +	u8 *gpio_channels;
> +	u16 ngpio;
> +};
> +
> +static const char * const plat_0222_gpio_names[] = {
> +	"AUTOM0_SFP_TX_FAULT",
> +	"SLOT2_LED_OUT",
> +	"SIM_M2_SLOT2_B_DET",
> +	"SIM_M2_SLOT2_A_DET",
> +	"SLOT1_LED_OUT",
> +	"SIM_M2_SLOT1_B_DET",
> +	"SIM_M2_SLOT1_A_DET",
> +	"SLOT0_LED_OUT",
> +	"WAN_SFP0_RX_LOS",
> +	"WAN_SFP0_PRSNT_N",
> +	"WAN_SFP0_TX_FAULT",
> +	"AUTOM1_SFP_RX_LOS",
> +	"AUTOM1_SFP_PRSNT_N",
> +	"AUTOM1_SFP_TX_FAULT",
> +	"AUTOM0_SFP_RX_LOS",
> +	"AUTOM0_SFP_PRSNT_N",
> +	"WAN_SFP1_RX_LOS",
> +	"WAN_SFP1_PRSNT_N",
> +	"WAN_SFP1_TX_FAULT",
> +	"SIM_M2_SLOT1_MUX_SEL",
> +	"W_DISABLE_M2_SLOT1_N",
> +	"W_DISABLE_MPCIE_SLOT0_N",
> +	"W_DISABLE_M2_SLOT0_N",
> +	"BT_COMMAND_MODE",
> +	"WAN_SFP1_TX_DISABLE",
> +	"WAN_SFP0_TX_DISABLE",
> +	"AUTOM1_SFP_TX_DISABLE",
> +	"AUTOM0_SFP_TX_DISABLE",
> +	"SIM_M2_SLOT2_MUX_SEL",
> +	"W_DISABLE_M2_SLOT2_N",
> +	"RST_CTL_M2_SLOT_1_N",
> +	"RST_CTL_M2_SLOT_2_N",
> +	"PM_USB_PWR_EN_BOT",
> +	"PM_USB_PWR_EN_TOP",
> +};
> +
> +static u8 plat_0222_gpio_channels[] = {
> +	OFFSET_BIT_TO_CHANNEL(0x00, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x00, 7),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x01, 7),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x02, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x09, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 3),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 4),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 5),
> +	OFFSET_BIT_TO_CHANNEL(0x0a, 6),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 0),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 1),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 2),
> +	OFFSET_BIT_TO_CHANNEL(0x0b, 3),
> +};
> +
> +static struct platform_device *silicom_platform_dev;
> +static struct led_classdev_mc *silicom_led_info __initdata;
> +static struct gpio_chip *silicom_gpiochip __initdata;
> +static u8 *silicom_gpio_channels __initdata;
> +
> +static int silicom_mec_port_get(unsigned int offset)
> +{
> +	unsigned short mec_data_addr;
> +	unsigned short mec_port_addr;
> +	u8 reg;
> +
> +	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_DATA_OFFSET_MASK;
> +	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, offset) & MEC_PORT_OFFSET_MASK;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(mec_port_addr, MEC_ADDR);
> +	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return (reg >> (offset & MEC_PORT_CHANNEL_MASK)) & 0x01;
> +}
> +
> +static enum led_brightness silicom_mec_led_get(int channel)
> +{
> +	/* Outputs are active low */
> +	return silicom_mec_port_get(channel) ? LED_OFF : LED_ON;
> +}
> +
> +static void silicom_mec_port_set(int channel, int on)
> +{
> +
> +	unsigned short mec_data_addr;
> +	unsigned short mec_port_addr;
> +	u8 reg;
> +
> +	mec_data_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_DATA_OFFSET_MASK;
> +	mec_port_addr = FIELD_GET(MEC_PORT_DWORD_OFFSET, channel) & MEC_PORT_OFFSET_MASK;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(mec_port_addr, MEC_ADDR);
> +	reg = inb(MEC_DATA_OFFSET(mec_data_addr));
> +	/* Outputs are active low, so clear the bit for on, or set it for off */
> +	if (on)
> +		reg &= ~(1 << (channel & MEC_PORT_CHANNEL_MASK));
> +	else
> +		reg |= 1 << (channel & MEC_PORT_CHANNEL_MASK);
> +	outb(reg, MEC_DATA_OFFSET(mec_data_addr));
> +	mutex_unlock(&mec_io_mutex);
> +}
> +
> +static enum led_brightness silicom_mec_led_mc_brightness_get(struct led_classdev *led_cdev)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> +	enum led_brightness brightness = LED_OFF;
> +	int i;
> +
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		mc_cdev->subled_info[i].brightness =
> +			silicom_mec_led_get(mc_cdev->subled_info[i].channel);
> +		/* Mark the overall brightness as LED_ON if any of the subleds are on */
> +		if (mc_cdev->subled_info[i].brightness != LED_OFF)
> +			brightness = LED_ON;
> +	}
> +
> +	return brightness;
> +}
> +
> +static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_cdev,
> +					      enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		silicom_mec_port_set(mc_cdev->subled_info[i].channel,
> +				     mc_cdev->subled_info[i].brightness);
> +	}
> +}
> +
> +static int silicom_gpio_get_direction(struct gpio_chip *gc,
> +				      unsigned int offset)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +
> +	/* Input registers have offsets between [0x00, 0x07] */
> +	if (CHANNEL_TO_OFFSET(channels[offset]) < MEC_GPIO_IN_POS)
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
> +}
> +
> +static int silicom_gpio_direction_input(struct gpio_chip *gc,
> +					unsigned int offset)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +
> +	return direction == GPIO_LINE_DIRECTION_IN ? 0 : -EINVAL;
> +}
> +
> +static void silicom_gpio_set(struct gpio_chip *gc,
> +			     unsigned int offset,
> +			     int value)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +	u8 *channels = gpiochip_get_data(gc);
> +	int channel = channels[offset];
> +
> +	if (direction == GPIO_LINE_DIRECTION_IN)
> +		return;
> +
> +	if (value)
> +		silicom_mec_port_set(channel, 0);
> +	else if (value == 0)
> +		silicom_mec_port_set(channel, 1);
> +	else
> +		pr_err("Wrong argument value: %d\n", value);
> +}
> +
> +static int silicom_gpio_direction_output(struct gpio_chip *gc,
> +					 unsigned int offset,
> +					 int value)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +
> +	if (direction == GPIO_LINE_DIRECTION_IN)
> +		return -EINVAL;
> +
> +	silicom_gpio_set(gc, offset, value);
> +
> +	return 0;
> +}
> +
> +static int silicom_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +	int channel = channels[offset];
> +
> +	return silicom_mec_port_get(channel);
> +}
> +
> +static struct mc_subled plat_0222_wan_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_WHITE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 7),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_YELLOW,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 6),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 5),
> +	},
> +};
> +
> +static struct mc_subled plat_0222_sys_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_WHITE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 4),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_AMBER,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 3),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 2),
> +	},
> +};
> +
> +static struct mc_subled plat_0222_stat1_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 1),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0c, 0),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 7),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_YELLOW,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 6),
> +	},
> +};
> +
> +static struct mc_subled plat_0222_stat2_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 5),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 4),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 3),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_YELLOW,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 2),
> +	},
> +};
> +
> +static struct mc_subled plat_0222_stat3_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 1),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0d, 0),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0e, 1),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_YELLOW,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x0e, 0),
> +	},
> +};
> +
> +static struct led_classdev_mc plat_0222_mc_led_info[] __initdata = {
> +	{
> +		.led_cdev = {
> +			.name = "platled::wan",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(plat_0222_wan_mc_subled_info),
> +		.subled_info = plat_0222_wan_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::sys",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(plat_0222_sys_mc_subled_info),
> +		.subled_info = plat_0222_sys_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::stat1",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(plat_0222_stat1_mc_subled_info),
> +		.subled_info = plat_0222_stat1_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::stat2",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(plat_0222_stat2_mc_subled_info),
> +		.subled_info = plat_0222_stat2_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::stat3",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(plat_0222_stat3_mc_subled_info),
> +		.subled_info = plat_0222_stat3_mc_subled_info,
> +	},
> +	{ },
> +};
> +
> +static struct gpio_chip silicom_gpio_chip = {
> +	.label = "silicom-gpio",
> +	.get_direction = silicom_gpio_get_direction,
> +	.direction_input = silicom_gpio_direction_input,
> +	.direction_output = silicom_gpio_direction_output,
> +	.get = silicom_gpio_get,
> +	.set = silicom_gpio_set,
> +	.base = -1,
> +	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
> +	.names = plat_0222_gpio_names,
> +	/*
> +	 * We're using a mutex to protect the indirect access, so we can sleep
> +	 * if the lock blocks
> +	 */
> +	.can_sleep = true,
> +};
> +
> +static struct silicom_platform_info silicom_plat_0222_cordoba_info __initdata = {
> +	.io_base = MEC_IO_BASE,
> +	.io_len = MEC_IO_LEN,
> +	.led_info = plat_0222_mc_led_info,
> +	.gpiochip = &silicom_gpio_chip,
> +	.gpio_channels = plat_0222_gpio_channels,
> +	/*
> +	 * The original generic cordoba does not have the last 4 outputs of the
> +	 * plat_0222 variant, the rest are the same, so use the same longer list,
> +	 * but ignore the last entries here
> +	 */
> +	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
> +
> +};
> +
> +static struct mc_subled cordoba_fp_left_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 6),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 5),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 7),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_AMBER,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 4),
> +	},
> +};
> +
> +static struct mc_subled cordoba_fp_center_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 7),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 4),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 3),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_AMBER,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 6),
> +	},
> +};
> +
> +static struct mc_subled cordoba_fp_right_mc_subled_info[] __initdata = {
> +	{
> +		.color_index = LED_COLOR_ID_RED,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 2),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_GREEN,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 1),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_BLUE,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x08, 0),
> +	},
> +	{
> +		.color_index = LED_COLOR_ID_AMBER,
> +		.brightness = 1,
> +		.intensity = 0,
> +		.channel = OFFSET_BIT_TO_CHANNEL(0x09, 5),
> +	},
> +};
> +
> +static struct led_classdev_mc cordoba_mc_led_info[] __initdata = {
> +	{
> +		.led_cdev = {
> +			.name = "platled::fp_left",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(cordoba_fp_left_mc_subled_info),
> +		.subled_info = cordoba_fp_left_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::fp_center",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(cordoba_fp_center_mc_subled_info),
> +		.subled_info = cordoba_fp_center_mc_subled_info,
> +	},
> +	{
> +		.led_cdev = {
> +			.name = "platled::fp_right",
> +			.brightness = 0,
> +			.max_brightness = 1,
> +			.brightness_set = silicom_mec_led_mc_brightness_set,
> +			.brightness_get = silicom_mec_led_mc_brightness_get,
> +		},
> +		.num_colors = ARRAY_SIZE(cordoba_fp_right_mc_subled_info),
> +		.subled_info = cordoba_fp_right_mc_subled_info,
> +	},
> +	{ },
> +};
> +
> +static struct silicom_platform_info silicom_generic_cordoba_info __initdata = {
> +	.io_base = MEC_IO_BASE,
> +	.io_len = MEC_IO_LEN,
> +	.led_info = cordoba_mc_led_info,
> +	.gpiochip = &silicom_gpio_chip,
> +	.gpio_channels = plat_0222_gpio_channels,
> +	.ngpio = ARRAY_SIZE(plat_0222_gpio_channels),
> +};
> +
> +/*
> + * sysfs interface
> + */
> +static ssize_t efuse_status_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(MEC_EFUSE_LSB_ADDR, EC_ADDR_LSB);
> +
> +	/* Get current data from the address */
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	efuse_status = reg & 0x1;
> +
> +	return sysfs_emit(buf, "%u\n", efuse_status);
> +}
> +static DEVICE_ATTR_RO(efuse_status);
> +
> +static ssize_t uc_version_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	int uc_version;
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO, EC_ADDR_LSB);
> +
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +	uc_version = FIELD_GET(MEC_VERSION_LOC, reg);
> +	if (uc_version >= 192)
> +		return -EINVAL;
> +
> +	uc_version = FIELD_GET(MEC_VERSION_MAJOR, reg) * 100 +
> +		     FIELD_GET(MEC_VERSION_MINOR, reg);
> +
> +	mec_uc_version = uc_version;
> +
> +	return sysfs_emit(buf, "%u\n", mec_uc_version);
> +}
> +static DEVICE_ATTR_RO(uc_version);
> +
> +static ssize_t power_cycle_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", power_cycle);
> +}
> +
> +static void powercycle_uc(void)
> +{
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(MEC_POWER_CYCLE_ADDR, EC_ADDR_LSB);
> +
> +	/* Set to 1 for current data from the address */
> +	outb(1, MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +}
> +
> +static ssize_t power_cycle_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	int rc;
> +	unsigned int power_cycle_cmd;
> +
> +	rc = kstrtou32(buf, 0, &power_cycle_cmd);
> +	if (rc)
> +		return -EINVAL;
> +
> +	if (power_cycle_cmd > 0) {
> +		mutex_lock(&mec_io_mutex);
> +		power_cycle = power_cycle_cmd;
> +		powercycle_uc();
> +		mutex_unlock(&mec_io_mutex);
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(power_cycle);
> +
> +static struct attribute *silicom_attrs[] = {
> +	&dev_attr_efuse_status.attr,
> +	&dev_attr_uc_version.attr,
> +	&dev_attr_power_cycle.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(silicom);
> +
> +static struct platform_driver silicom_platform_driver = {
> +	.driver = {
> +		.name = "silicom-platform",
> +		.dev_groups = silicom_groups,
> +	},
> +};
> +
> +static int __init silicom_mc_leds_register(struct device *dev,
> +					   const struct led_classdev_mc *mc_leds)
> +{
> +	int size = sizeof(struct mc_subled);
> +	struct led_classdev_mc *led;
> +	int i, err;
> +
> +	for (i = 0; mc_leds[i].led_cdev.name; i++) {
> +
> +		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
> +		if (!led)
> +			return -ENOMEM;
> +		memcpy(led, &mc_leds[i], sizeof(*led));
> +
> +		led->subled_info = devm_kzalloc(dev, led->num_colors * size, GFP_KERNEL);
> +		if (!led->subled_info)
> +			return -ENOMEM;
> +		memcpy(led->subled_info, mc_leds[i].subled_info, led->num_colors * size);
> +
> +		err = devm_led_classdev_multicolor_register(dev, led);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 rpm_get(void)
> +{
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO_T, EC_ADDR_LSB);
> +	reg = inw(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return reg;
> +}
> +
> +static u32 temp_get(void)
> +{
> +	u32 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO_T, EC_ADDR_LSB);
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return FIELD_GET(MEC_TEMP_LOC, reg) * 100;
> +}
> +
> +static umode_t silicom_fan_control_fan_is_visible(const u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_label:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static umode_t silicom_fan_control_temp_is_visible(const u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_label:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int silicom_fan_control_read_fan(struct device *dev, u32 attr, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		*val = rpm_get();
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int silicom_fan_control_read_temp(struct device *dev, u32 attr, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		*val = temp_get();
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t silicom_fan_control_is_visible(const void *data,
> +					      enum hwmon_sensor_types type,
> +					      u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return silicom_fan_control_fan_is_visible(attr);
> +	case hwmon_temp:
> +		return silicom_fan_control_temp_is_visible(attr);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int silicom_fan_control_read(struct device *dev,
> +				    enum hwmon_sensor_types type,
> +				    u32 attr, int channel,
> +				    long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return silicom_fan_control_read_fan(dev, attr, val);
> +	case hwmon_temp:
> +		return silicom_fan_control_read_temp(dev, attr, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int silicom_fan_control_read_labels(struct device *dev,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel,
> +					   const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		*str = "Silicom_platfomr: Fan Speed";
> +		return 0;
> +	case hwmon_temp:
> +		*str = "Silicom_platform: Thermostat Sensor";
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops silicom_fan_control_hwmon_ops = {
> +	.is_visible = silicom_fan_control_is_visible,
> +	.read = silicom_fan_control_read,
> +	.read_string = silicom_fan_control_read_labels,
> +};
> +
> +static const struct hwmon_chip_info silicom_chip_info = {
> +	.ops = &silicom_fan_control_hwmon_ops,
> +	.info = silicom_fan_control_info,
> +};
> +
> +static int __init silicom_platform_probe(struct platform_device *device)
> +{
> +	struct device *hwmon_dev;
> +	u8 magic, ver;
> +	int err;
> +
> +	if (!devm_request_region(&device->dev, MEC_IO_BASE, MEC_IO_LEN, "mec")) {
> +		dev_err(&device->dev, "couldn't reserve MEC io ports\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Sanity check magic number read for EC */
> +	outb(IO_REG_BANK, MEC_ADDR);
> +	magic = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	ver = inb(MEC_DATA_OFFSET(DEFAULT_CHAN_HI));
> +	dev_dbg(&device->dev, "EC magic 0x%02x, version 0x%02x\n", magic, ver);
> +
> +	if (magic != SILICOM_MEC_MAGIC) {
> +		dev_err(&device->dev, "Bad EC magic 0x%02x!\n", magic);
> +		return -ENODEV;
> +	}
> +
> +	err = silicom_mc_leds_register(&device->dev, silicom_led_info);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register LEDs\n");
> +		return err;
> +	}
> +
> +	err = devm_gpiochip_add_data(&device->dev, silicom_gpiochip,
> +				     silicom_gpio_channels);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register gpiochip: %d\n", err);
> +		return err;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, "silicom_fan", NULL,
> +							 &silicom_chip_info, NULL);
> +	err = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register hwmon_dev: %d\n", err);
> +		return err;
> +	}
> +
> +	return err;
> +}
> +
> +static int __init silicom_platform_info_init(const struct dmi_system_id *id)
> +{
> +	struct silicom_platform_info *info = id->driver_data;
> +
> +	silicom_led_info = info->led_info;
> +	silicom_gpio_channels = info->gpio_channels;
> +	silicom_gpiochip = info->gpiochip;
> +	silicom_gpiochip->ngpio = info->ngpio;
> +
> +	return 1;
> +}
> +
> +static const struct dmi_system_id silicom_dmi_ids[] __initconst = {
> +	{
> +		.callback = silicom_platform_info_init,
> +		.ident = "Silicom Cordoba (Generic)",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +			DMI_MATCH(DMI_BOARD_NAME, "80300-0214-G"),
> +		},
> +		.driver_data = &silicom_generic_cordoba_info,
> +	},
> +	{
> +		.callback = silicom_platform_info_init,
> +		.ident = "Silicom Cordoba (Generic)",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +			DMI_MATCH(DMI_BOARD_NAME, "80500-0214-G"),
> +		},
> +		.driver_data = &silicom_generic_cordoba_info,
> +	},
> +	{
> +		 .callback = silicom_platform_info_init,
> +		 .ident = "Silicom Cordoba (plat_0222)",
> +		 .matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Silicom"),
> +			DMI_MATCH(DMI_BOARD_NAME, "80300-0222-G"),
> +		 },
> +		.driver_data = &silicom_plat_0222_cordoba_info,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids);
> +
> +static int __init silicom_platform_init(void)
> +{
> +	if (!dmi_check_system(silicom_dmi_ids)) {
> +		pr_err("No DMI match for this platform\n");
> +		return -ENODEV;
> +	}
> +	silicom_platform_dev = platform_create_bundle(&silicom_platform_driver,
> +						      silicom_platform_probe,
> +						      NULL, 0, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(silicom_platform_dev);
> +}
> +
> +static void __exit silicom_platform_exit(void)
> +{
> +	platform_device_unregister(silicom_platform_dev);
> +	platform_driver_unregister(&silicom_platform_driver);
> +}
> +
> +module_init(silicom_platform_init);
> +module_exit(silicom_platform_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Henry Shi <henrys@silicom-usa.com>");
> +MODULE_DESCRIPTION("Platform driver for Silicom network appliances");

