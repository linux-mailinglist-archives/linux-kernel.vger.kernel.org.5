Return-Path: <linux-kernel+bounces-77692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E519C86090F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1474B1C21B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770EBE6F;
	Fri, 23 Feb 2024 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AobUl9Ky"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6371170E;
	Fri, 23 Feb 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656862; cv=none; b=YQTwBuvjtq7hyOe/kfKBUfc4dnCH+vPRR5/No16ubzTZ4W/JUsMfq2QmqXwB1qi53iZYl7ZI4LPrWg/oUxObmDsoERHxAOgidzCFkmjNmAEzmscL2myC0AT9Piv6BX8OoOrfcTIRpywINdMYFgRSwmeed9sWYaEYDZ6kOE+uTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656862; c=relaxed/simple;
	bh=XuuoVzrhOaZuZRtv+gArnbPL0EB9aVakv8qH/P7q0iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXIL5lQBO85GoUO2Om5vPdThddm5K3xJl5qUNWhiFzzUoEQhEU5g7+MC7z7/lnaD1g72pk7JfSbmGfo8S+t/wjVdsfN1m8rU0KDIu/R6jzyslFR1KboKnNvio/pjOOTnijmDgfZbnOZpI3B07FlywDhXsi7r6wwSNQuMVgt0ZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AobUl9Ky; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708656860; x=1740192860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XuuoVzrhOaZuZRtv+gArnbPL0EB9aVakv8qH/P7q0iY=;
  b=AobUl9KyW/St/T0R0ilam7c1H+Gv8iXEthQ8zi2F/anfmLfmbohxyg3v
   nJA73q/bqlDqJGtVHlLi1jAR+tM2ukT25KkG9GYaGC8BHsN31ccROzzvH
   GXyTGrgw9KWZvTVNwc2RnIpvtIieO64ULdgfegFWRoiF3643xDmEN5pYj
   YnDvE8JPvF/iO/sR+IKOokP6Fc2RnKBlZ2oXYVDxW1KhudpGvJSrnVfCI
   GUdDSRK+131DeZgzmhXjHRno84B2g8XWUjjfG+FhSdPZdu8TRX+Smn5Y5
   K6zziE85wm/aCGBp/d8gpcq4zV0WiIn4sjjBqa/+9AdZT4Z0gXPoTotjj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3082972"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3082972"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 18:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6142042"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 18:54:19 -0800
Message-ID: <4fe0e878-11df-48da-8593-c862fd272ccd@linux.intel.com>
Date: Thu, 22 Feb 2024 18:54:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: Add wmi driver for Casper Excalibur
 laptops. Odd line breaks was because I have used scripts/Lindent without
 checking, I'm sorry for that. And for my weird rgb led API: This kind of
 design was also used in drivers/platform/x86/dell/alienware-wmi.c:239, but
 mine differs as it doesn't create different attributes for different leds.
 That is because driver doesn't know how many leds there are, to know how many
 leds there are it should check processor information (whether it's 10th gen
 or 11th). I don't think include/linux/mod_devicetable.h supports that. If
 there is a way to differentiate cpus, please let me know. And even if it knew
 how many leds there are, having different attributes can be cumbersome
 because there's no way of reading leds. And also user can change led state
 without notifying os (with some hotkey). But I'm open to further discussion.
 And thanks for all of your careful reviewing. It helped me to learn more.
Content-Language: en-US
To: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com, linux@roeck-us.net, pavel@ucw.cz, lee@kernel.org
References: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240222214815.245280-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/22/24 1:48 PM, Mustafa Ekşi wrote:
> Adding wmi driver for Casper Excalibur Laptops:
> This driver implements a ledclass_dev device for keyboard backlight
> and hwmon driver to read fan speed and (also write) pwm mode. NEW_LEDS is
> selected because this driver introduces new leds, and LEDS_CLASS is selected
> because this driver implements a led class device. All of Casper Excalibur
> Laptops are supported but fan speeds has a bug for older generations.

Please fix your subject line. It looks like you have included responses
to the previous comments in the subject line. Please go through the
https://docs.kernel.org/process/submitting-patches.html for the
guidelines

>
> Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
> ---
>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 315 ++++++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/platform/x86/casper-wmi.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed4d386853..d0142a75d2c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4723,6 +4723,12 @@ S:	Maintained
>  W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
>  F:	drivers/net/wireless/ath/carl9170/
>  
> +CASPER EXCALIBUR WMI DRIVER
> +M:	Mustafa Ekşi <mustafa.eskieksi@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/casper-wmi.c
> +
>  CAVIUM I2C DRIVER
>  M:	Robert Richter <rric@kernel.org>
>  S:	Odd Fixes
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bdd302274b9..ebef9c9dfb6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called sel3350-platform.
>  
> +config CASPER_WMI
> +	tristate "Casper Excalibur Laptop WMI driver"
> +	depends on ACPI_WMI
> +	depends on HWMON
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	help
> +	  Say Y here if you want to support WMI-based fan speed reporting,
> +	  power management and keyboard backlight support on Casper Excalibur
> +	  Laptops.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called casper-wmi.
> +
>  endif # X86_PLATFORM_DEVICES
>  
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 1de432e8861..4b527dd44ad 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>  obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
>  obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
> +obj-$(CONFIG_CASPER_WMI)		+= casper-wmi.o
>  
>  # Acer
>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
> diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/casper-wmi.c
> new file mode 100644
> index 00000000000..012ebda195d
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include <linux/bitops.h>
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <acpi/acexcep.h>
> +#include <linux/bitfield.h>
> +#include <linux/sysfs.h>
> +
> +#define CASPER_WMI_GUID "644C5791-B7B0-4123-A90B-E93876E0DAAD"
> +
> +#define CASPER_READ 0xfa00
> +#define CASPER_WRITE 0xfb00
> +#define CASPER_GET_HARDWAREINFO 0x0200
> +#define CASPER_SET_LED 0x0100
> +#define CASPER_POWERPLAN 0x0300
> +
> +#define CASPER_KEYBOARD_LED_1 0x03
> +#define CASPER_KEYBOARD_LED_2 0x04
> +#define CASPER_KEYBOARD_LED_3 0x05
> +#define CASPER_ALL_KEYBOARD_LEDS 0x06
> +#define CASPER_CORNER_LEDS 0x07
> +
> +#define CASPER_LED_ID    0xF00000000
> +#define CASPER_LED_MODE  0x0F0000000
> +#define CASPER_LED_ALPHA 0x00F000000
> +
> +struct casper_wmi_args {
> +	u16 a0, a1;
> +	u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +static u32 casper_last_color;
> +static u8 casper_last_led;
> +
> +static int casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
> +			      u32 data)
> +{
> +	struct casper_wmi_args wmi_args = {
> +		.a0 = CASPER_WRITE,
> +		.a1 = a1,
> +		.a2 = led_id,
> +		.a3 = data
> +	};
> +	struct acpi_buffer input = {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};

I would add an empty line here.

> +	if (ACPI_FAILURE(wmidev_block_set(wdev, 0, &input)))
> +		return -EINVAL;

Same as above.

> +	return 0;
> +}
> +
> +static ssize_t led_control_show(struct device *dev, struct device_attribute
> +				*attr, char *buf)
> +{
> +	return sysfs_emit("%u%08x\n", buf, casper_last_led,
> +		       casper_last_color);
> +}
> +
> +/*
> + * Format wanted from user is a hexadecimal 36-bit integer: most significant
> + * 4 bits are led_id, next 4 bits are mode and next 4 bits are brightness,
> + * next 24 bits are rgb value. 64 bits
> + * IMARRGGBB
> + */
> +static ssize_t led_control_store(struct device *dev, struct device_attribute
> +				 *attr, const char *buf, size_t count)
> +{
> +	if (strlen(buf) != 10)
> +		return -EINVAL;
Why 10? use a macro for it.
> +	u64 user_input;

Please declare the variable at the top of the function.

> +	/*
> +	 * 16-base selected for ease of writing color codes. I chose 64 bit and
> +	 * kstrtou64 because format I use determined fits into 64 bit.
> +	 */
> +	int ret = kstrtou64(buf, 16, &user_input);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * led_id can't exceed 255 but it can vary among newer versions and
> +	 * other models.
> +	 */
> +	u8 led_id = FIELD_GET(CASPER_LED_ID, user_input);
> +	ret = casper_set(to_wmi_device(dev->parent), CASPER_SET_LED,
> +			led_id, (u32) user_input);
> +	if (ret)
> +		return ret;
> +	if (led_id != CASPER_CORNER_LEDS) {
> +		casper_last_color = (u32) user_input;
> +		casper_last_led = led_id;
> +	}
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(led_control);
> +
> +static struct attribute *casper_kbd_led_attrs[] = {
> +	&dev_attr_led_control.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(casper_kbd_led);
> +
> +static void set_casper_backlight_brightness(struct led_classdev *led_cdev,
> +					    enum led_brightness brightness)
> +{
> +	// Setting any of the keyboard leds' brightness sets brightness of all
> +	u32 bright_prep = FIELD_PREP(CASPER_LED_ALPHA, brightness);
> +	u32 color_no_alpha = casper_last_color&~CASPER_LED_ALPHA;
> +
> +	casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
> +		       CASPER_KEYBOARD_LED_1, color_no_alpha | bright_prep
> +	);
> +}
> +
> +static enum led_brightness get_casper_backlight_brightness(struct led_classdev
> +							   *led_cdev)
> +{
> +	return FIELD_GET(CASPER_LED_ALPHA, casper_last_color);
> +}
> +
> +static struct led_classdev casper_kbd_led = {
> +	.name = "casper::kbd_backlight",
> +	.brightness = 0,
> +	.brightness_set = set_casper_backlight_brightness,
> +	.brightness_get = get_casper_backlight_brightness,
> +	.max_brightness = 2,
> +	.groups = casper_kbd_led_groups,
> +};
> +
> +static int casper_query(struct wmi_device *wdev, u16 a1,
> +				struct casper_wmi_args *out)
> +{
> +	struct casper_wmi_args wmi_args = {
> +		.a0 = CASPER_READ,
> +		.a1 = a1
> +	};
> +	struct acpi_buffer input = {
> +		(acpi_size) sizeof(struct casper_wmi_args),
> +		&wmi_args
> +	};
> +
> +	acpi_status ret = wmidev_block_set(wdev, 0, &input);
> +	if (ACPI_FAILURE(ret))
> +		return -EIO;
> +
> +	union acpi_object *obj = wmidev_block_query(wdev, 0);
> +	if (obj->type != ACPI_TYPE_BUFFER) // obj will be int (0x10) on failure
> +		return -EINVAL;

You don't need to free obj here?

> +	if (obj->buffer.length != 32)
> +		return -EIO;

Please use defines for constant values.

> +
> +	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
> +	kfree(obj);
Add a empty line here.
> +	return ret;
> +}
> +
> +static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return 0444;

How about S_IRUSR | S_IRGRP | S_IROTH ?

> +	case hwmon_pwm:
> +		return 0644;

Same as above.

> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long *val)
> +{
> +	struct casper_wmi_args out = { 0 };
> +	struct wmi_device *wdev = to_wmi_device(dev->parent);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		ret = casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);

Not checking the ret?

> +		/*
> +		 * a4 and a5 is little endian in older laptops (with 10th gen
> +		 * cpus or older) and big endian in newer ones. I don't think
> +		 * dmi has something for cpu information. Also, defining a
> +		 * dmi_list just for this seems like an overkill. This problem
> +		 * can be solved in userspace too.
> +		 */
> +		if (channel == 0) // CPU fan
> +			*val = out.a4;
> +		else if (channel == 1) // GPU fan
> +			*val = out.a5;

empty line here

> +		return 0;
> +	case hwmon_pwm:
> +		ret = casper_query(wdev, CASPER_POWERPLAN, &out);
> +		if (ret) // power plan count varies generations.
> +			return ret;
> +		if (channel == 0)
> +			*val = out.a2;
> +		return 0;
> +	default:
> +		return -ENODEV;

EINVAL or ENOTSUPP?

> +	}
> +}
> +
> +static int casper_wmi_hwmon_read_string(struct device *dev,
> +					enum hwmon_sensor_types type, u32 attr,
> +					int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (channel) {
> +		case 0:
> +			*str = "cpu_fan_speed";
> +			break;
> +		case 1:
> +			*str = "gpu_fan_speed";
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
> +		break;
> +	default:
> +		return -ENODEV;
> +	}

Same as above function

> +	return 0;
> +}
> +
> +static int casper_wmi_hwmon_write(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long val)
> +{
> +	acpi_status ret;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		if (val > 5 || val < 0)

Use macro for constant values. It is not clear why you check for 0..5

> +			return -EINVAL;
> +		ret = casper_set(to_wmi_device(dev->parent),
> +				 CASPER_POWERPLAN, val, 0);
> +		if (ret)
> +			return ret;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops casper_wmi_hwmon_ops = {
> +	.is_visible = &casper_wmi_hwmon_is_visible,
> +	.read = &casper_wmi_hwmon_read,
> +	.read_string = &casper_wmi_hwmon_read_string,
> +	.write = &casper_wmi_hwmon_write
> +};
> +
> +static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
> +	.ops = &casper_wmi_hwmon_ops,
> +	.info = casper_wmi_hwmon_info,
> +};
> +
> +static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct device *hwmon_dev;
> +
> +	if (ACPI_FAILURE(led_classdev_register(&wdev->dev, &casper_kbd_led)))
> +		return -ENODEV;
> +	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
> +						"casper_wmi", wdev,
> +						&casper_wmi_hwmon_chip_info,
> +						NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void casper_wmi_remove(struct wmi_device *wdev)
> +{
> +	led_classdev_unregister(&casper_kbd_led);
> +}
> +
> +static const struct wmi_device_id casper_wmi_id_table[] = {
> +	{ CASPER_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver casper_wmi_driver = {
> +	.driver = {
> +		   .name = "casper-wmi",
> +		    },
> +	.id_table = casper_wmi_id_table,
> +	.probe = casper_wmi_probe,
> +	.remove = &casper_wmi_remove,
> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
> +
> +MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


