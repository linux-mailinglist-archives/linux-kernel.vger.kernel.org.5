Return-Path: <linux-kernel+bounces-75597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD785EBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5DE283E89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185ED128817;
	Wed, 21 Feb 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx13Zf7F"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815F33F7;
	Wed, 21 Feb 2024 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553782; cv=none; b=Or6uL6eynBw8g02haqcUBzDsPihY4crNoF6ZbXJWvlNkhF2gr0a3G6ej+wu2xXuY2uPfchlEdW2rzHePJ304JyfhJE28ObV+e2vfH4jKcXGK2cQaIVlaStex9RWda5OiRFqPko3cTcKCCkcK2qV7n8YKXA3ojx8R0LvOxVDt2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553782; c=relaxed/simple;
	bh=92A/FQNEOeYUfA/tzbKKNwdBx+m5/2Y7u7hNmkKY7LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iplsRaAbEfyzP+lmyCbUuMiy4hMw+eVnPc+nSQU3PRY+R0ypbYBGuzZALzeKcIyCOXV/XbGY5qNs6IF/PRvfuzwJNKBcyynhozIRb2YFRh+YVWzsCZwaYntbeZlkVSbMMKGAruS3Bdr8V2N2mIPMtSdphCRN/QOKEPfwPSu9IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx13Zf7F; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso7621841a12.3;
        Wed, 21 Feb 2024 14:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708553778; x=1709158578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGXI1qn9Z1dSha0cStAfJapWTzaiJv1vOT3oKvWGnLs=;
        b=Bx13Zf7F60Eo8mDYFq8fR/r1Z0j/2MCZD4sHDJ/1B9y6bbld5jJ1lGpOP+00xXClRN
         d36LYw197Dza9SFkxZzPFqSjz3wbiql7sLWj1DXY+8WRt8rivAUen1tsEWf9riAFOECN
         lHLPCHBJdhOzk6juuVp6P+mh9GffPdPy4GKNP4nzFEKf8dJZhJHtKahZGAD6+eHM3WL9
         NIumjH5a+JAyZj6/JR6ZRy28D08WsUCTn4h7IHBXdgTaKMIRRsEPu8ZtXztZMboIrVG1
         n9B089/kDCTz5ePsXMZ/DYoW5V6lNsPhHF/1hWQB7hkX4QrsxuZnNA24JWzE+2sZw6sz
         Cvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553778; x=1709158578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGXI1qn9Z1dSha0cStAfJapWTzaiJv1vOT3oKvWGnLs=;
        b=Mb+wyk+kebgPBTxHPTEXOwMJgPTWpIKFamHe4Nb2egu2eaL5K8CadqM7D/1kDvFRLK
         CWBnrF8XyutV6o7qd1Sex3H1FG0REzGkJje1Uk62p3llCe+65qoAD7IA0qhWOa0PAI5V
         kj/4TSVvklg0m/j9D6OmDRxcQmdmaOwSmLkBLmupcZxaF6pP/wOw3vBBt0RkD7n29Eoq
         rAC3HFkQBxyEQvLZqk+7UJAGG3c8bCaIxma/ATFP1ieJ5ax9lZqGX10waMHArMKXLbt/
         N3o1KAbN1mLzXK4r17nDg1fLrSDtXNXqAa4V0mYb99OcpSBSHFAI/qn/FdbUXWxdLrHx
         P+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWs10d+6wPpaKsfS3ABk/sod4LSLXq7DEmWTn+1NjQsTGtzxyWb+EIXxJgHlrpVplWr2g//NEyTC3R0r0sha6wtT0UBuqG8V+BY2a04n+KkvuRAALpwxL98VOMltxYf26bTxnZyXYFJvZdrq4ufG6EbkpiW525SkOahBqNS+6ESPkbLSzZcDsa9I+Qkjhi4
X-Gm-Message-State: AOJu0YxSiRS9r9eAN4gDUtQ6wRiP+n43SNR/1ckGAEH5eH6wbfG9iSqb
	kOUi/Zp9J1nkAEIoehgLrTvev0G8WPAEtuxR2GjIu2GqI4gndR1L
X-Google-Smtp-Source: AGHT+IFQRkW+CSbZu0M2eDhZCosaaAu0XE3luEcyp3w3MF2CCwZ4K04fB0OCxYQnJKEdEzDTwu1Yrg==
X-Received: by 2002:a50:cdd8:0:b0:563:eca6:733c with SMTP id h24-20020a50cdd8000000b00563eca6733cmr10190797edj.15.1708553778002;
        Wed, 21 Feb 2024 14:16:18 -0800 (PST)
Received: from localhost.localdomain ([94.120.90.19])
        by smtp.gmail.com with ESMTPSA id cf28-20020a0564020b9c00b00564761ca19fsm3260680edb.29.2024.02.21.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:16:17 -0800 (PST)
From: =?UTF-8?q?Mustafa=20Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: mustafa.eskieksi@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Subject: [PATCH] Add wmi driver support for Casper Excalibur laptops.
Date: Thu, 22 Feb 2024 01:15:49 +0300
Message-ID: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
---
 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 344 ++++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d386853..d0142a75d2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4723,6 +4723,12 @@ S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
 F:	drivers/net/wireless/ath/carl9170/
 
+CASPER EXCALIBUR WMI DRIVER
+M:	Mustafa Ekşi <mustafa.eskieksi@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/casper-wmi.c
+
 CAVIUM I2C DRIVER
 M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bdd302274b9..ebef9c9dfb6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called sel3350-platform.
 
+config CASPER_WMI
+	tristate "Casper Excalibur Laptop WMI driver"
+	depends on ACPI_WMI
+	depends on HWMON
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  Say Y here if you want to support WMI-based fan speed reporting,
+	  power management and keyboard backlight support on Casper Excalibur
+	  Laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called casper-wmi.
+
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1de432e8861..4b527dd44ad 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
+obj-$(CONFIG_CASPER_WMI)		+= casper-wmi.o
 
 # Acer
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
diff --git a/drivers/platform/x86/casper-wmi.c b/drivers/platform/x86/casper-wmi.c
new file mode 100644
index 00000000000..aae08202b19
--- /dev/null
+++ b/drivers/platform/x86/casper-wmi.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/acpi.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/hwmon.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/dmi.h>
+#include <acpi/acexcep.h>
+
+MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
+MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
+MODULE_LICENSE("GPL");
+
+#define CASPER_WMI_GUID "644C5791-B7B0-4123-A90B-E93876E0DAAD"
+
+#define CASPER_READ 0xfa00
+#define CASPER_WRITE 0xfb00
+#define CASPER_GET_HARDWAREINFO 0x0200
+#define CASPER_SET_LED 0x0100
+#define CASPER_POWERPLAN 0x0300
+
+#define CASPER_KEYBOARD_LED_1 0x03
+#define CASPER_KEYBOARD_LED_2 0x04
+#define CASPER_KEYBOARD_LED_3 0x05
+#define CASPER_ALL_KEYBOARD_LEDS 0x06
+#define CASPER_CORNER_LEDS 0x07
+
+struct casper_wmi_args {
+	u16 a0, a1;
+	u32 a2, a3, a4, a5, a6, a7, a8;
+};
+
+static u32 casper_last_color;
+static u8 casper_last_led;
+
+static acpi_status casper_set(struct wmi_device *wdev, u16 a1, u8 led_id,
+			      u32 data)
+{
+	struct casper_wmi_args wmi_args = {
+		.a0 = CASPER_WRITE,
+		.a1 = a1,
+		.a2 = led_id,
+		.a3 = data
+	};
+	struct acpi_buffer input = {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+	return wmidev_block_set(wdev, 0, &input);
+}
+
+static ssize_t led_control_show(struct device *dev, struct device_attribute
+				*attr, char *buf)
+{
+	return sprintf("%u%08x\n", buf, casper_last_led,
+		       casper_last_color);
+}
+
+
+// input is formatted as "IMARRGGBB", I: led_id, M: mode, A: brightness, ...
+static ssize_t led_control_store(struct device *dev, struct device_attribute
+				 *attr, const char *buf, size_t count)
+{
+	u64 tmp;
+	int ret;
+
+	ret = kstrtou64(buf, 16, &tmp);
+
+	if (ret)
+		return ret;
+
+	u8 led_id = (tmp >> (8 * 4))&0xFF;
+
+	ret =
+	    casper_set(to_wmi_device(dev->parent), CASPER_SET_LED, led_id,
+		       (u32) tmp
+	    );
+	if (ACPI_FAILURE(ret)) {
+		dev_err(dev, "casper-wmi ACPI status: %d\n", ret);
+		return ret;
+	}
+	if (led_id != CASPER_CORNER_LEDS) {
+		casper_last_color = (u32) tmp;
+		casper_last_led = led_id;
+	}
+	return count;
+}
+
+static DEVICE_ATTR_RW(led_control);
+
+static struct attribute *casper_kbd_led_attrs[] = {
+	&dev_attr_led_control.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(casper_kbd_led);
+
+static void set_casper_backlight_brightness(struct led_classdev *led_cdev,
+					    enum led_brightness brightness)
+{
+	// Setting any of the keyboard leds' brightness sets brightness of all
+	acpi_status ret =
+	    casper_set(to_wmi_device(led_cdev->dev->parent), CASPER_SET_LED,
+		       CASPER_KEYBOARD_LED_1,
+		       (casper_last_color & 0xF0FFFFFF) |
+		       (((u32) brightness) << 24)
+	    );
+
+	if (ret != 0)
+		dev_err(led_cdev->dev,
+			"Couldn't set brightness acpi status: %d\n", ret);
+}
+
+static enum led_brightness get_casper_backlight_brightness(struct led_classdev
+							   *led_cdev)
+{
+	return (casper_last_color&0x0F000000)>>24;
+}
+
+static struct led_classdev casper_kbd_led = {
+	.name = "casper::kbd_backlight",
+	.brightness = 0,
+	.brightness_set = set_casper_backlight_brightness,
+	.brightness_get = get_casper_backlight_brightness,
+	.max_brightness = 2,
+	.groups = casper_kbd_led_groups,
+};
+
+static acpi_status casper_query(struct wmi_device *wdev, u16 a1,
+				struct casper_wmi_args *out)
+{
+	struct casper_wmi_args wmi_args = {
+		.a0 = CASPER_READ,
+		.a1 = a1
+	};
+	struct acpi_buffer input = {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+
+	acpi_status ret = wmidev_block_set(wdev, 0, &input);
+
+	if (ACPI_FAILURE(ret)) {
+		dev_err(&wdev->dev,
+			"Could not query acpi status: %u", ret);
+		return ret;
+	}
+
+	union acpi_object *obj = wmidev_block_query(wdev, 0);
+
+	if (obj == NULL) {
+		dev_err(&wdev->dev,
+			"Could not query hardware information");
+		return AE_ERROR;
+	}
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_err(&wdev->dev, "Return type is not a buffer");
+		return AE_TYPE;
+	}
+
+	if (obj->buffer.length != 32) {
+		dev_err(&wdev->dev, "Return buffer is not long enough");
+		return AE_ERROR;
+	}
+	memcpy(out, obj->buffer.pointer, 32);
+	kfree(obj);
+	return ret;
+}
+
+static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return 0444;
+	case hwmon_pwm:
+		return 0644;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static int casper_wmi_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long *val)
+{
+	struct casper_wmi_args out = { 0 };
+
+	switch (type) {
+	case hwmon_fan:
+		acpi_status ret = casper_query(to_wmi_device(dev->parent),
+					       CASPER_GET_HARDWAREINFO, &out);
+
+		if (ACPI_FAILURE(ret))
+			return ret;
+
+		if (channel == 0) { // CPU fan
+			u32 cpu_fanspeed = out.a4;
+
+			cpu_fanspeed <<= 8;
+			cpu_fanspeed += out.a4 >> 8;
+			*val = (long) cpu_fanspeed;
+		} else if (channel == 1) { // GPU fan
+			u32 gpu_fanspeed = out.a5;
+
+			gpu_fanspeed <<= 8;
+			gpu_fanspeed += out.a5 >> 8;
+			*val = (long) gpu_fanspeed;
+		}
+		return 0;
+	case hwmon_pwm:
+		casper_query(to_wmi_device(dev->parent), CASPER_POWERPLAN,
+			     &out);
+		if (channel == 0)
+			*val = (long)out.a2;
+		else
+			return -EOPNOTSUPP;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int casper_wmi_hwmon_read_string(struct device *dev,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_fan:
+		switch (channel) {
+		case 0:
+			*str = "cpu_fan_speed";
+			break;
+		case 1:
+			*str = "gpu_fan_speed";
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int casper_wmi_hwmon_write(struct device *dev,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel, long val)
+{
+	acpi_status ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		if (channel != 0)
+			return -EOPNOTSUPP;
+		ret =
+		    casper_set(to_wmi_device(dev->parent), CASPER_POWERPLAN,
+			       val, 0);
+
+		if (ACPI_FAILURE(ret)) {
+			dev_err(dev, "Couldn't set power plan, acpi_status: %d",
+				ret);
+			return -EINVAL;
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops casper_wmi_hwmon_ops = {
+	.is_visible = &casper_wmi_hwmon_is_visible,
+	.read = &casper_wmi_hwmon_read,
+	.read_string = &casper_wmi_hwmon_read_string,
+	.write = &casper_wmi_hwmon_write
+};
+
+static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_MODE),
+	NULL
+};
+
+static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
+	.ops = &casper_wmi_hwmon_ops,
+	.info = casper_wmi_hwmon_info,
+};
+
+static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *hwmon_dev;
+
+	// All Casper Excalibur Laptops use this GUID
+	if (!wmi_has_guid(CASPER_WMI_GUID))
+		return -ENODEV;
+
+	hwmon_dev =
+	    devm_hwmon_device_register_with_info(&wdev->dev, "casper_wmi", wdev,
+						 &casper_wmi_hwmon_chip_info,
+						 NULL);
+
+	acpi_status result = led_classdev_register(&wdev->dev, &casper_kbd_led);
+
+	if (result != 0)
+		return -ENODEV;
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+	}
+
+static void casper_wmi_remove(struct wmi_device *wdev)
+{
+	led_classdev_unregister(&casper_kbd_led);
+}
+
+static const struct wmi_device_id casper_wmi_id_table[] = {
+	{ CASPER_WMI_GUID, NULL },
+	{ }
+};
+
+static struct wmi_driver casper_wmi_driver = {
+	.driver = {
+		   .name = "casper-wmi",
+		    },
+	.id_table = casper_wmi_id_table,
+	.probe = casper_wmi_probe,
+	.remove = &casper_wmi_remove
+};
+
+module_wmi_driver(casper_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
-- 
2.43.2


