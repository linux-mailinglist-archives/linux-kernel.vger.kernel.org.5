Return-Path: <linux-kernel+bounces-75806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D618185EF41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A1284036
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD514A8F;
	Thu, 22 Feb 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH5+Bwx0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D310F9;
	Thu, 22 Feb 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569693; cv=none; b=IOfYQiR3rLH7eMPsYYfPMeK91e9b5Px4kQ5Hvep7kY+uMtE5t/Ml6rKmYZtqr31ofupxzP0cP6sIlDFN5bY1zISwaEHgQf7ZmoPgQEHAEIUdtUQ411HhnnYdidZ11uJzVTCYABIL/QC33Q1UvIqXPB1Vb4eAX5LurkaLqDu0D2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569693; c=relaxed/simple;
	bh=IWBWxBYJmFyQVnGRv38FFSekIZLP2aPDTIxxaVSPYBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcUcR1Pmm8ef8n/qWV47Cs+7op0NWzhNvziN8jSgcA7U9A54u7mWM9HGIYfwzfJ/1WYxM6KInB0iHW/MHi67jVfsB4fb+y1kxI7xLkStYkMKhUM76bg2ZDTBFU4YUrg19zxtYBBnBWILxaS+unscxXdpoD8oz8IMhvYjLZQE8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH5+Bwx0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708569691; x=1740105691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWBWxBYJmFyQVnGRv38FFSekIZLP2aPDTIxxaVSPYBE=;
  b=WH5+Bwx0iP66SM/BRqa13OzJSK8IjUpPpHXSAqf0tTv4rfekiHi6nFu2
   F2jq2JdqVN4LerBLxj6eSf9f5rlzgPhSxJDyUBqBzzzlmF0S9fYpWxHqK
   HxZlayL5G2XxHXM3u9mh5/9DvYIk/Hjg6U+YsOqmQUQMvJgDvslr/Tjaz
   My5os0LT+zBkKH0vwFnDv2x9Do4b20VqAK9UOGWrqrwa4qsU3JZRQPg+8
   RPdJ2wT+jKFighTO9q4rJ1WrQy8j9gWsmE2JDe/WkOH7tAJco9kFSTgiP
   8vxTEScCWBhTGjBbJKd0gJddBFYU8fTbHJyZuWNsJRTBc916mkmCfkO6a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13329326"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13329326"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:41:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="827453680"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="827453680"
Received: from mstewart-mobl.amr.corp.intel.com (HELO [10.209.73.168]) ([10.209.73.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:41:30 -0800
Message-ID: <2826ee8d-9cc9-4f24-a797-48f704f0ea84@linux.intel.com>
Date: Wed, 21 Feb 2024 18:41:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add wmi driver support for Casper Excalibur laptops.
Content-Language: en-US
To: =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: jdelvare@suse.com, linux@roeck-us.net
References: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/21/24 2:15 PM, Mustafa Ekşi wrote:
> Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
> ---

Please add some commit log about the driver. Like what it supports,
who uses it , etc.

>  MAINTAINERS                       |   6 +
>  drivers/platform/x86/Kconfig      |  14 ++
>  drivers/platform/x86/Makefile     |   1 +
>  drivers/platform/x86/casper-wmi.c | 344 ++++++++++++++++++++++++++++++
>  4 files changed, 365 insertions(+)
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

In commit log, add some info about why you are selecting the NEW_LEDS
and LEDS_CLASS.

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
> index 00000000000..aae08202b19
> --- /dev/null
> +++ b/drivers/platform/x86/casper-wmi.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/acpi.h>
> +#include <linux/leds.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/hwmon.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/dmi.h>
> +#include <acpi/acexcep.h>
> +
> +MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
> +MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
> +MODULE_LICENSE("GPL");
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
> +struct casper_wmi_args {
> +	u16 a0, a1;
> +	u32 a2, a3, a4, a5, a6, a7, a8;
> +};
> +
> +static u32 casper_last_color;
> +static u8 casper_last_led;
> +
> +static acpi_status casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
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
> +	return wmidev_block_set(wdev, 0, &input);
> +}
> +
> +static ssize_t led_control_show(struct device *dev, struct device_attribute
> +				*attr, char *buf)
> +{
> +	return sprintf("%u%08x\n", buf, casper_last_led,
> +		       casper_last_color);
> +}
> +
> +
> +// input is formatted as "IMARRGGBB", I: led_id, M: mode, A: brightness, ...
> +static ssize_t led_control_store(struct device *dev, struct device_attribute
> +				 *attr, const char *buf, size_t count)
> +{
> +	u64 tmp;
> +	int ret;
> +
> +	ret = kstrtou64(buf, 16, &tmp);
> +
above empty line is not needed
> +	if (ret)
> +		return ret;
> +
> +	u8 led_id = (tmp >> (8 * 4))&0xFF;
Why not 32 ?
> +
> +	ret =
> +	    casper_set(to_wmi_device(dev->parent), CASPER_SET_LED, led_id,
> +		       (u32) tmp
> +	    );
Since it returns acpi_status, I would define a new variable to test it.
> +	if (ACPI_FAILURE(ret)) {
> +		dev_err(dev, "casper-wmi ACPI status: %d\n", ret);
> +		return ret;
> +	}
> +	if (led_id != CASPER_CORNER_LEDS) {
> +		casper_last_color = (u32) tmp;
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
> +	acpi_status ret =
> +	    casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
> +		       CASPER_KEYBOARD_LED_1,
> +		       (casper_last_color & 0xF0FFFFFF) |
> +		       (((u32) brightness) << 24)
> +	    );
> +
> +	if (ret != 0)
> +		dev_err(led_cdev->dev,
> +			"Couldn't set brightness acpi status: %d\n", ret);
> +}
> +
> +static enum led_brightness get_casper_backlight_brightness(struct led_classdev
> +							   *led_cdev)
> +{
> +	return (casper_last_color&0x0F000000)>>24;
> +}

I recommend adding defines for all magic numbers you have used.

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
> +static acpi_status casper_query(struct wmi_device *wdev, u16 a1,
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
> +
> +	if (ACPI_FAILURE(ret)) {
> +		dev_err(&wdev->dev,
> +			"Could not query acpi status: %u", ret);
> +		return ret;
> +	}
> +
> +	union acpi_object *obj = wmidev_block_query(wdev, 0);
> +
> +	if (obj == NULL) {
> +		dev_err(&wdev->dev,
> +			"Could not query hardware information");
> +		return AE_ERROR;
> +	}
> +	if (obj->type != ACPI_TYPE_BUFFER) {
> +		dev_err(&wdev->dev, "Return type is not a buffer");
> +		return AE_TYPE;
> +	}
> +
> +	if (obj->buffer.length != 32) {
> +		dev_err(&wdev->dev, "Return buffer is not long enough");
> +		return AE_ERROR;
> +	}
> +	memcpy(out, obj->buffer.pointer, 32);
> +	kfree(obj);
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
> +	case hwmon_pwm:
> +		return 0644;
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
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		acpi_status ret = casper_query(to_wmi_device(dev->parent),
> +					       CASPER_GET_HARDWAREINFO, &out);
> +
> +		if (ACPI_FAILURE(ret))
> +			return ret;
> +
> +		if (channel == 0) { // CPU fan
> +			u32 cpu_fanspeed = out.a4;
> +
> +			cpu_fanspeed <<= 8;
> +			cpu_fanspeed += out.a4 >> 8;
> +			*val = (long) cpu_fanspeed;
> +		} else if (channel == 1) { // GPU fan
> +			u32 gpu_fanspeed = out.a5;
> +
> +			gpu_fanspeed <<= 8;
> +			gpu_fanspeed += out.a5 >> 8;
> +			*val = (long) gpu_fanspeed;
> +		}
> +		return 0;
> +	case hwmon_pwm:
> +		casper_query(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +			     &out);
> +		if (channel == 0)
> +			*val = (long)out.a2;
> +		else
> +			return -EOPNOTSUPP;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
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
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
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
> +		if (channel != 0)
> +			return -EOPNOTSUPP;
> +		ret =
> +		    casper_set(to_wmi_device(dev->parent), CASPER_POWERPLAN,
> +			       val, 0);
> +
> +		if (ACPI_FAILURE(ret)) {
> +			dev_err(dev, "Couldn't set power plan, acpi_status: %d",
> +				ret);
> +			return -EINVAL;
> +		}
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
> +	// All Casper Excalibur Laptops use this GUID
> +	if (!wmi_has_guid(CASPER_WMI_GUID))
> +		return -ENODEV;
> +
> +	hwmon_dev =
> +	    devm_hwmon_device_register_with_info(&wdev->dev, "casper_wmi", wdev,
> +						 &casper_wmi_hwmon_chip_info,
> +						 NULL);
> +
> +	acpi_status result = led_classdev_register(&wdev->dev, &casper_kbd_led);
> +
> +	if (result != 0)
> +		return -ENODEV;
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +	}
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
> +	.remove = &casper_wmi_remove
> +};
> +
> +module_wmi_driver(casper_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


