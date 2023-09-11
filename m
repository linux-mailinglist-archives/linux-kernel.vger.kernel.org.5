Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657F479B43A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjIKUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbjIKObM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13071E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694442617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3cTOIMHRmYHfe/wbacU8kOFvFwkAVcXQBbBkPb/EsM=;
        b=MaicUEIXsef3VTm8DHUPAZQ87hw/sNmKiGtL02WiYZ/2ubIawJFlF3mIoBq4rdAIoqzl21
        p4qata4DQtl9nbwuEPLIXNb5AUvRx1/qpKY2GgH+JgSQ3oH3mE1un9TDJADenUJHL83pqO
        851o4Ys90XEFtruiWKoqPDca627e9H8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-KpUVrK-YNvuNXtYo6zXD_g-1; Mon, 11 Sep 2023 10:30:16 -0400
X-MC-Unique: KpUVrK-YNvuNXtYo6zXD_g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a681c3470fso287620966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694442614; x=1695047414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3cTOIMHRmYHfe/wbacU8kOFvFwkAVcXQBbBkPb/EsM=;
        b=FYoVxEYBQOlyarP8XBF0Pmm4jKD8RnThijWOEoTU68IYLU4Z3a0Qlp7bP3xcPBIIZP
         pFzReg4KG5o7aVgKaXC3EyeduhKRXnL1NkydwC7ZnFDYLtQBLX4uFcp0oMFyWiBON/6k
         rAEeo6K8FNk8R7bZ0IyAwXUQ+sEoarvX0ne7lEwGuT5Ph+koeqxvRVFGkgf4f4C6RN5h
         FUkFYp03x1PHrTPMvpvXQPlHexeWEa/DE24CvOU8tgXi838yGFQUwN8+RZFlPeDebAVb
         CyhswR8MEyFeL6G+vLQWf41leXziY1H+xo7g2idrNpTC3vss61mkXU7fIlCLdWPyN/uh
         JSJg==
X-Gm-Message-State: AOJu0YxNLiU8dNLwNyx3c+HBC41Ea6L4rw0eS6OobGhrMwyQa/hq7Krp
        ZSzbPSd50BP7ulFtM2SsUnarjXkzTeAJMTH3RtKPICNN/mApUprwPNv6aohqi5xoWvyYpasFW+0
        6yPg52MH7gBJuXKhKUDcBfUq+
X-Received: by 2002:a17:906:220e:b0:99e:1358:ffdf with SMTP id s14-20020a170906220e00b0099e1358ffdfmr8254011ejs.72.1694442614225;
        Mon, 11 Sep 2023 07:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQsZ91GPN5zaTBlj9rFrZ4Fo0OIMIi0p8L08XM7kEeuZ0MthsgTcv7OSYv9QoEFAYLjO6DxQ==
X-Received: by 2002:a17:906:220e:b0:99e:1358:ffdf with SMTP id s14-20020a170906220e00b0099e1358ffdfmr8253984ejs.72.1694442613627;
        Mon, 11 Sep 2023 07:30:13 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id pv26-20020a170907209a00b00992d122af63sm5414368ejb.89.2023.09.11.07.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 07:30:12 -0700 (PDT)
Message-ID: <31a3ce1c-38fe-3767-3221-3e550ce4580a@redhat.com>
Date:   Mon, 11 Sep 2023 16:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6] Add Silicom Platform Driver
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        markgross@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20230901210252.22238-1-henryshi2018@gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230901210252.22238-1-henryshi2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henry,

Please use a proper subsystem prefix for your patch subject, e.g. :

Subject: platform/x86: Add Silicom Platform Driver

Also your charset is set to "yes" which confuses git am. for the next version
when asked for which charset to use when sending the patch please
press enter to accept the utf-8 default, do not type "yes".


On 9/1/23 23:02, Henry Shi wrote:
> The Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products is a 
> software solution designed to facilitate the efficient management
> and control of devices through the integration of various Linux
> frameworks. This platform driver provides seamless support for
> device management via the Linux LED framework, GPIO framework,
> Hardware Monitoring (HWMON), and device attributes. The Silicom
> platform driver's compatibility with these Linux frameworks allows
> applications to access and control Cordoba family devices using
> existing software that is compatible with these frameworks. This
> compatibility simplifies the development process, reduces
> dependencies on proprietary solutions, and promotes
> interoperability with other Linux-based systems and software.

Some of this commit message feels more like an advertisement
then a proper commit message.

For the next version I suggest you use something like this:

"""
Add Silicom platform (silicom-platform) Linux driver for Swisscom
Business Box (Swisscom BB) as well as Cordoba family products.

This platform driver provides support for various functions via
the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
and device attributes.

Signed-off-by: Henry Shi <henryshi2018@gmail.com>
"""


> Changes from v1 to v2:
> ===========================

The changelog should be below a "---" cut-line and that "---" cut-line
should be below your Signed-off-by, changing the entire commit msg to
something like this:

"""
platform/x86: Add Silicom Platform Driver

Add Silicom platform (silicom-platform) Linux driver for Swisscom
Business Box (Swisscom BB) as well as Cordoba family products.

This platform driver provides support for various functions via
the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
and device attributes.

Signed-off-by: Henry Shi <henryshi2018@gmail.com>
---
Changes from v1 to v2:
===========================
...
...
"""


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
> change from patch vv5 to v6 (current patch)
> ===========================================
> 
> changes suggested by Guenter Roeck <groeck7@gmail.com>:
> .Removed checkpath warnings. 
> .Resoved dependencies between CONFIG_HWMON and CONFIG_SILICOM_PLATFORM.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---
>  drivers/platform/x86/Kconfig            |   24 +
>  drivers/platform/x86/Makefile           |    1 +
>  drivers/platform/x86/silicom-platform.c | 1053 +++++++++++++++++++++++
>  3 files changed, 1078 insertions(+)
>  create mode 100644 drivers/platform/x86/silicom-platform.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 22052031c719..aba2d45f7ccd 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -188,6 +188,30 @@ config ACER_WMI
>  	  If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
>  	  here.
>  
> +config SILICOM_PLATFORM
> +	tristate "Silicom Edge Networking device support"
> +	depends on HWMON
> +	select LEDS_CLASS_MULTICOLOR
> +	help
> +	  This option enables support for the LEDs/GPIO/etc downstream of the
> +	  embedded controller on Silicom "Cordoba" hardware and derivatives.
> +
> +	  The Silicom platform (silicom-platform) Linux driver for Swisscom
> +	  Business Box (Swisscom BB) as well as Cordoba family products is a
> +	  software solution designed to facilitate the efficient management
> +	  and control of devices through the integration of various Linux
> +	  frameworks. This platform driver provides seamless support for
> +	  device management via the Linux LED framework, GPIO framework,
> +	  Hardware Monitoring (HWMON), and device attributes. The Silicom
> +	  platform driver's compatibility with these Linux frameworks allows
> +	  applications to access and control Cordoba family devices using
> +	  existing software that is compatible with these frameworks. This
> +	  compatibility simplifies the development process, reduces
> +	  dependencies on proprietary solutions, and promotes
> +	  interoperability with other Linux-based systems and software.
> +
> +	  If you have a Silicom network appliance, say Y or M here.
> +

This Kconfig entry should be grouped together with the other industrial PC
entries, please put this below the:

source "drivers/platform/x86/siemens/Kconfig"

line.

Also same comment as the commit message, please change this to:

config SILICOM_PLATFORM
       tristate "Silicom Edge Networking device support"
       depends on HWMON
       select LEDS_CLASS_MULTICOLOR
       help
         This option enables support for the LEDs/GPIO/etc downstream of the
         embedded controller on Silicom "Cordoba" hardware and derivatives.

         This platform driver provides support for various functions via
         the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
         and device attributes.

         If you have a Silicom network appliance, say Y or M here.


>  source "drivers/platform/x86/amd/Kconfig"
>  
>  config ADV_SWBUTTON
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2cafe51ec4d8..9355ebbc56ca 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_SERIAL_MULTI_INSTANTIATE)	+= serial-multi-instantiate.o
>  obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
>  obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
>  obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
> +obj-$(CONFIG_SILICOM_PLATFORM)		+= silicom-platform.o
>  obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets/
>  
>  # Intel uncore drivers
> diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
> new file mode 100644
> index 000000000000..4ca68c589f03
> --- /dev/null
> +++ b/drivers/platform/x86/silicom-platform.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// silicom-platform.c - Silicom MEC170x platform driver
> +//
> +// Copyright (C) 2023 Henry Shi <henrys@silicom-usa.com>
> +#include <linux/dmi.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/hwmon.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +
> +#define MEC_EFUSE_LSB_ADDR 0x28
> +#define MEC_POWER_CYCLE_ADDR 0x24
> +#define MEC_PORT_OFFSET_MASK 0xfc
> +#define MEC_PORT_CHANNEL_MASK 0x7
> +#define MEC_DATA_OFFSET_MASK 0x03
> +#define MEC_GPIO_IN_POS 0x08
> +#define MEC_IO_BASE 0x0800
> +#define MEC_IO_LEN 0x8
> +#define MEC_ADDR ((MEC_IO_BASE) + 0x02)
> +#define MEC_DATA_OFFSET(offset) ((MEC_IO_BASE) + 0x04 + (offset))
> +#define EC_ADDR_LSB MEC_ADDR
> +#define EC_ADDR_MSB ((MEC_IO_BASE) + MEC_DATA_OFFSET_MASK)
> +#define SILICOM_MEC_MAGIC 0x5a
> +#define OFFSET_BIT_TO_CHANNEL(off, bit) ((((off) + 0x014) << 3) | (bit))
> +#define CHANNEL_TO_OFFSET(chan) (((chan) >> 3) - 0x14)
> +#define MEC_VERSION_MAJOR GENMASK(15, 14)
> +#define MEC_VERSION_MINOR GENMASK(13, 8)
> +#define IO_REG_BANK 0x0
> +#define DEFAULT_CHAN_LO 0
> +#define DEFAULT_CHAN_HI 0
> +#define DEFAULT_CHAN_LO_T 0xc
> +
> +static DEFINE_MUTEX(mec_io_mutex);
> +static struct device *my_dev;
> +static int efuse_status;
> +static int mec_uc_version;
> +static int power_cycle;
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
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */
> +	outb(FIELD_GET(GENMASK(31, 3), offset) & MEC_PORT_OFFSET_MASK, MEC_ADDR);
> +
> +	/* Get the current register */
> +	reg = inb(MEC_DATA_OFFSET(FIELD_GET(GENMASK(31, 3), offset) & MEC_DATA_OFFSET_MASK));
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
> +	u8 reg;
> +
> +	mutex_lock(&mec_io_mutex);
> +	/* Get the dword offset from the channel */
> +	outb(FIELD_GET(GENMASK(31, 3), channel) & MEC_PORT_OFFSET_MASK, MEC_ADDR);
> +
> +	/* Get the current port settings */
> +	reg = inb(MEC_DATA_OFFSET(FIELD_GET(GENMASK(31, 3), channel) & MEC_DATA_OFFSET_MASK));
> +	/* Outputs are active low, so clear the bit for on, or set it for off */
> +	if (on)
> +		reg &= ~(1 << (channel & MEC_PORT_CHANNEL_MASK));
> +	else
> +		reg |= 1 << (channel & MEC_PORT_CHANNEL_MASK);
> +	/* Write back the updated register */
> +	outb(reg, MEC_DATA_OFFSET(FIELD_GET(GENMASK(31, 3), channel) & MEC_DATA_OFFSET_MASK));
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
> +				enum led_brightness brightness)

Please set your editor to tabs being TAB chars with a width of 8 and
then align the start of extra function parameters to directly after the ( of the line
above. E.g.:

static void silicom_mec_led_mc_brightness_set(struct led_classdev *led_cdev,
					      enum led_brightness brightness)

So the e from enum is now directly below the s of struct.

You MUST fix this for all your functions, where the indentation of this
is all over the place.

> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		silicom_mec_port_set(mc_cdev->subled_info[i].channel,
> +		mc_cdev->subled_info[i].brightness);
> +	}
> +}
> +
> +static int silicom_gpio_get_direction(struct gpio_chip *gc,
> +				unsigned int offset)
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
> +				unsigned int offset)
> +{
> +	int direction = silicom_gpio_get_direction(gc, offset);
> +
> +	return direction == GPIO_LINE_DIRECTION_IN ? 0 : -EINVAL;
> +}
> +
> +static void silicom_gpio_set(struct gpio_chip *gc,
> +							unsigned int offset,
> +							int value)
> +{
> +	u8 *channels = gpiochip_get_data(gc);
> +	int direction = silicom_gpio_get_direction(gc, offset);
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
> +							unsigned int offset,
> +							int value)
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
> +			.name = "multicolor:wan",
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
> +			.name = "multicolor:sys",
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
> +			.name = "multicolor:stat1",
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
> +			.name = "multicolor:stat2",
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
> +			.name = "multicolor:stat3",
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
> +	/* We're using a mutex to protect the indirect access, so we can sleep
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
> +	/* The original generic cordoba does not have the last 4 outputs of the
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
> +			.name = "multicolor:fp_left",
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
> +			.name = "multicolor:fp_center",
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
> +			.name = "multicolor:fp_right",
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
> +static struct platform_driver silicom_platform_driver = {
> +	.driver = {
> +		.name = "silicom-platform",
> +	},
> +};
> +
> +static ssize_t efuse_status_show(struct device *dev,
> +								struct device_attribute *attr,
> +								char *buf)
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
> +	return sprintf(buf, "%d\n", efuse_status);
> +}
> +
> +static ssize_t uc_version_show(struct device *dev,
> +								struct device_attribute *attr,
> +								char *buf)
> +{
> +	u32 reg;
> +	int uc_version;
> +
> +	mutex_lock(&mec_io_mutex);
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(DEFAULT_CHAN_LO, EC_ADDR_LSB);
> +
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +	uc_version = FIELD_GET(GENMASK(15, 8), reg);
> +	if (uc_version >= 192)
> +		pr_err("uc version not supported\n");
> +
> +	uc_version = FIELD_GET(MEC_VERSION_MAJOR, reg) * CENTI +
> +				FIELD_GET(MEC_VERSION_MINOR, reg);
> +
> +	mec_uc_version = uc_version;
> +	return sprintf(buf, "%d\n", mec_uc_version);
> +}
> +
> +static ssize_t power_cycle_show(struct device *dev,
> +								struct device_attribute *attr,
> +								char *buf)
> +{
> +	return sprintf(buf, "%d\n", power_cycle);
> +}
> +
> +static void powercycle_uc(void)
> +{
> +	mutex_lock(&mec_io_mutex);
> +	/* Select memory region */
> +	outb(IO_REG_BANK, EC_ADDR_MSB);
> +	outb(MEC_POWER_CYCLE_ADDR, EC_ADDR_LSB);
> +
> +	/* Set to 1 for current data from the address */
> +	outb(1, MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +}
> +
> +static ssize_t power_cycle_store(struct device *dev,
> +								struct device_attribute *attr,
> +								const char *buf, size_t count)
> +{
> +	if (sscanf(buf, "%du", &power_cycle) != 1) {
> +		dev_err(dev, "Failed to read power_cycle\n");
> +		return -EINVAL;
> +	}
> +	if (power_cycle > 0)
> +		powercycle_uc();
> +
> +	return count;
> +}
> +
> +static struct device_attribute my_dev_attr[] = {
> +	{
> +		.attr = {.name = "efuse_status", .mode = 0644},
> +		.show = efuse_status_show,
> +		.store = NULL
> +	},
> +	{
> +		.attr = {.name = "uc_version", .mode = 0644},
> +		.show = uc_version_show,
> +		.store = NULL
> +	},
> +	{
> +		.attr = {.name = "power_cycle", .mode = 0644},
> +		.show = power_cycle_show,
> +		.store = power_cycle_store
> +	},
> +};
> +
> +static int __init silicom_mc_leds_register(struct device *dev,
> +				const struct led_classdev_mc *mc_leds)
> +{
> +	struct led_classdev_mc *led;
> +	int i, err;
> +	int size = sizeof(struct mc_subled);
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
> +		if (err) {
> +			dev_err(dev, "Failed to register[%d]: %d\n", i, err);
> +			return err;
> +		}
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
> +	/* Get current data from the address */
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
> +	/* Get current data from the address */
> +	reg = inl(MEC_DATA_OFFSET(DEFAULT_CHAN_LO));
> +	mutex_unlock(&mec_io_mutex);
> +
> +	return FIELD_GET(GENMASK(31, 16), reg) * CENTI;
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
> +					  enum hwmon_sensor_types type,
> +					  u32 attr, int channel)
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
> +					enum hwmon_sensor_types type,
> +					u32 attr, int channel,
> +					long *val)
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
> +					enum hwmon_sensor_types type,
> +					u32 attr, int channel,
> +					const char **str)
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
> +	int i, err;
> +	u8 magic, ver;
> +	struct device *hwmon_dev;
> +	const char *name = "Silocom_Fan_Monitor";
> +	const char *dev_name = "Silicom_platform";
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
> +									silicom_gpio_channels);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register gpiochip: %d\n", err);
> +		return err;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, name, NULL,
> +				&silicom_chip_info, NULL);
> +	err = PTR_ERR_OR_ZERO(hwmon_dev);
> +	if (err) {
> +		dev_err(&device->dev, "Failed to register hwmon_dev: %d\n", err);
> +		return err;
> +	}
> +
> +	my_dev = root_device_register(dev_name);
> +	for (i = 0; i < ARRAY_SIZE(my_dev_attr); i++) {
> +		err = sysfs_create_file(&my_dev->kobj, &my_dev_attr[i].attr);
> +		if (err) {
> +			pr_debug("failed to create /sys/devices/Silicom_platform\n");
> +			break;
> +		}
> +	}

Please do not manually create a sysfs dir and then manually register your
sysfs-attributes there.

Instead define a platform_driver struct and set the .driver.dev_groups of
of that. See drivers/platform/x86/wmi.c for an exampe.

After this you can remove the creation + destruction of my_dev as well
as the sysfs_create_file() and sysfs_remove_file() calls. This will
then all be taken care of by the device-driver-core.


> +
> +	return err;
> +}
> +
> +static int __init silicom_platform_info_init(const struct dmi_system_id *id)
> +{
> +	struct silicom_platform_info *info = id->driver_data;
> +
> +	dev_info(&silicom_platform_dev->dev, "Detected %s\n", id->ident);

Please switch to pr_info here so that you don't need to setup
the silicom_platform_dev before doing the DMI checks.

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

Please move the: MODULE_DEVICE_TABLE() line to directly after
this table, resulting in:

	{ },
};
MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids);


> +
> +static int __init silicom_platform_init(void)
> +{
> +	struct device *dev;
> +	int err;
> +
> +	/* register a platform device to act as the parent for LEDS, etc. */
> +	silicom_platform_dev = platform_device_register_simple("silicom-platform",
> +			-1, NULL, 0);
> +	if (IS_ERR(silicom_platform_dev)) {
> +		err = PTR_ERR(silicom_platform_dev);
> +		pr_err("failed to register silicom-platform device: %d\n", err);
> +		return err;
> +	}
> +	dev = &silicom_platform_dev->dev;
> +
> +	err = dmi_check_system(silicom_dmi_ids);
> +	if (err == 0) {
> +		dev_err(dev, "No DMI match for this platform\n");
> +		err = -ENODEV;
> +		goto silicom_dmi_check_err;
> +	}

Please make the dmi_check_system() check the first thing you do in
silicom_platform_init(), then you can just directly return ENODEV,
with the need for a goto for cleanup.


> +
> +	/* Directly probe the platform driver in init since this isn't a
> +	 * hotpluggable device.  That means we don't need to register a driver
> +	 * that needs to wait around in memory on the chance a matching device
> +	 * would get added.  Instead run once in __init so that we can free all
> +	 * those resources when the __init region is wiped
> +	 */
> +	err = platform_driver_probe(&silicom_platform_driver, silicom_platform_probe);
> +	if (err) {
> +		dev_err(dev, "Failed to probe platform driver %d\n", err);
> +		goto silicom_init_probe_err;
> +	}
> +	return 0;

Instead of separate platform_device creation + driver registration please
switch to using platform_create_bundle().

> +
> +silicom_init_probe_err:
> +	if (my_dev) {
> +		root_device_unregister(my_dev);
> +		my_dev = NULL;
> +	}
> +
> +silicom_dmi_check_err:
> +	if (silicom_platform_dev) {
> +		platform_device_unregister(silicom_platform_dev);
> +		silicom_platform_dev = NULL;
> +	}
> +	return err;
> +}
> +
> +static void __exit silicom_platform_exit(void)
> +{
> +	int i;
> +
> +	if (silicom_platform_dev) {
> +		platform_device_unregister(silicom_platform_dev);
> +		platform_driver_unregister(&silicom_platform_driver);
> +	}
> +
> +	if (my_dev) {
> +		for (i = 0; i < ARRAY_SIZE(my_dev_attr); i++)
> +			sysfs_remove_file(&my_dev->kobj, &my_dev_attr[i].attr);
> +		root_device_unregister(my_dev);
> +	}
> +	mutex_destroy(&mec_io_mutex);

You should not call mutex_destroy() on global static mutex, please drop this.

Together with my other suggested changes this should result in the
init/exit code looking something like this:

	{ },
};
MODULE_DEVICE_TABLE(dmi, silicom_dmi_ids);

static DEVICE_ATTR_RO(efuse_status);
static DEVICE_ATTR_RO(uc_version);
static DEVICE_ATTR_RW(power_cycle);

static struct attribute *silicom_attrs[] = {
	&dev_attr_efuse_status.attr,
	&dev_attr_uc_version.attr,
	&dev_attr_power_cycle.attr,
	NULL,
};
ATTRIBUTE_GROUPS(silicom);

static struct platform_driver silicom_platform_driver = {
	.driver = {
		.name = "silicom-platform",
		.dev_groups = silicom_groups,
	},
};

static int __init silicom_platform_init(void)
{
	if (!dmi_check_system(silicom_dmi_ids)) {
		pr_err("No DMI match for this platform\n");
		return -ENODEV;
	}

	silicom_platform_dev = platform_create_bundle(&silicom_platform_driver,
						      silicom_platform_probe,
						      NULL, 0, NULL, 0);

	return PTR_ERR_OR_ZERO(silicom_platform_dev);
}

static void __exit silicom_platform_exit(void)
{
	platform_device_unregister(silicom_platform_dev);
	platform_driver_unregister(&silicom_platform_driver);
}




> +}
> +
> +module_init(silicom_platform_init);
> +module_exit(silicom_platform_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Henry Shi <henrys@silicom-usa.com>");
> +MODULE_DESCRIPTION("Platform driver for Silicom network appliances");

Regards,

Hans



