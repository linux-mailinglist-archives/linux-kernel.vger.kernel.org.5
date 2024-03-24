Return-Path: <linux-kernel+bounces-112796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73936887E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF1A1F20E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2851B951;
	Sun, 24 Mar 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvrVNXCz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA71B59E;
	Sun, 24 Mar 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303996; cv=none; b=KHj7R7ma6ZUWgH4VSS0SZr7e485IIsXrl5d9m+lPQ42XdOiYZ9Pi/37F+WWL6oyjWSPIcF9tO2+O2xJl/lwdwOOHUz+K58UgwOR91x7yseYJzGHgUEd3SxoxaAixY2MVHh2vphbHOGkI3nE7Gtn89uAj4MYrguqq/QZOQIaMkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303996; c=relaxed/simple;
	bh=esMAJfXtF6xRMbCcLO6EXxgRZJ8ZGH4qpw0ioCwFUfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioNJT4CVzREN6gp6TNbq0iaOriwNH2bakwr7X4klMHryDCdApRLo/x9gyd45nmDsnFjvM2EPD5lLN7JXCjHQA4Kq8GSFdZme0/EBrnk6iELI1/tpr01lcTiCX7lNz04iqhb4DxLpOij7Xr6xMYkYl5S5rcpE5TpfILaHBIH1Y7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvrVNXCz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e6777af4so6649263e87.2;
        Sun, 24 Mar 2024 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711303992; x=1711908792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVKai4VA282Y035HozYUDfR3mkdl8bntb3DRIC6hufA=;
        b=TvrVNXCz5Hq2j9ozVn4ykeyu7Q7YRXBSu2iya51oCxZYds1zG9PMZw0nSGeQH9dvlv
         ccoLgvyy9qWo8mZ0ABmDH0n3I1sfcQDdz3l9EHEdiKKXeRDVZ5YARV7AbPnchKBlHXFg
         AXo9Vvrhg5X5xVC/NcAQMGjWS0Cv3OL+2lC43niJVd+tEnuo2sJkqGOo8oR8LXceswZr
         NVe+IPmIcD8t5m75gfvN8LzIR0iW403zgk5nndDm4qhekrwbTCEg+jVLagVneLoCOkYO
         /YDzUyLPE3ZfX4R2XZOOutq7YY61BgG0oYqvLDiqq+qdXXFxHofBu2t+RMq7fKIod6Gh
         KDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711303992; x=1711908792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVKai4VA282Y035HozYUDfR3mkdl8bntb3DRIC6hufA=;
        b=V4g4+oNi+Tv4l2sgAoQAeEo8AiGJpZUykMcuus8Sz3gt+EfgJlF0NYggazkNzKgRy/
         l5o6ghFJZ/0G1hRMAuO7aMJYO/3I/YQ3CnSy/0KBxshAYEkX5sv2fe6VRIC6k1G86Zdq
         tKaMivA70jlemYr1yHpWSyGkV//5+WeB0CLgPGIBRsE+Dmd7XUDBdTdjPUi0VBmU1KHh
         HVsUMFUMKUxHstpUejBW7j3GFv58FQd2l1ChOak/2IhpdvY/++YSMRYeMfq18IeHfxCF
         HB5JRUiwtszyN9l05OrVy7J0cxBcp5Rme7hn1WHVy4APuFVdpbpmePV83JAvxneE+DJv
         vnmw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRJ2/rM9su/QyWKwQN98QuanZaWs7Cxq39aGxZqRvvtXFd8fClZTRtCSbdG2AsM9fELZ0GuAvOq+PMPwIECa/m+FSiA7dYJWlSblcdsDX+x23u8Pnp3kXPjavdszXS+XE9l+Sth06afdPQsIQ3RjWM8ee59J5Bwse6NEZhoWPFbnsxIPiAiQDhOOI2qfrnyW4HC7PsWP55ovBiVRfihUFwqD4ZP0d6q/OJA==
X-Gm-Message-State: AOJu0YyLPoSA+YbJCqb7nZu/mlD+0SRdHB+pe5CVISsbpGMFk1Hln1Dj
	QV7dwMT2RrI3lANKw+zNX6A5JMNqMbrEhdTswJ0OQfTCIj3m8kHv
X-Google-Smtp-Source: AGHT+IGXMo9Sy4ucMV8yi++t3cJ7VjV6RI4ryeSep+wqM8jkT/+ju30LewMb7lwEyEpISgUdtOqUkA==
X-Received: by 2002:a05:6512:1cc:b0:513:e7a0:5aa5 with SMTP id f12-20020a05651201cc00b00513e7a05aa5mr4313751lfp.51.1711303991439;
        Sun, 24 Mar 2024 11:13:11 -0700 (PDT)
Received: from localhost.localdomain ([94.120.85.57])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170906adcd00b00a4750131edasm1085504ejb.206.2024.03.24.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:13:11 -0700 (PDT)
From: mustafa <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	pavel@ucw.cz,
	lee@kernel.org,
	mustafa.eskieksi@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 1/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Sun, 24 Mar 2024 21:12:01 +0300
Message-ID: <20240324181201.87882-2-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
References: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>

This wmi driver supports Casper Excalibur laptops' changing keyboard
backlight, reading fan speeds and changing power profiles. Multicolor
led device is used for backlight, platform_profile for power management
and hwmon for fan speeds. It supports both old (10th gen or older) and
new (11th gen or newer) laptops. It uses x86_match_cpu to check if the
laptop is old or new.
This driver's Multicolor keyboard backlight API is very similar to Rishit
Bansal's proposed API.

Signed-off-by: Mustafa Ekşi <mustafa.eskieksi@gmail.com>
---
Changes in v5:
 - Added mutex_destroy to casper_wmi_probe error handling
 - casper_multicolor_register now sets all leds to CASPER_DEFAULT_COLOR
 - Some minor changes
Changes in v4:
 - Renamed casper_driver to casper_drv
 - Moved all global variables to casper_drv struct. Devices access
  casper_drv via wdev's driver_data.
 - Removed struct led_cache, because only its u32 array was used. It is
   replaced with color_cache.
 - Added mutex_locks in casper_set and casper_query, so they now accept
   casper_drv instead of wmi_device as argument.
 - Changed endianess conversion in hwmon_read to something sparse doesn't
   complain about.
 - Moved registrations of multicolor leds and platform profile to their
   own functions. This makes casper_wmi_probe more readable.
 - Added .no_singleton to wmi_device.
 - Some minor changes.
Changes in v3:
 - Replaced led_control attribute with multicolor led interface.
 - Added struct led_cache, instead of storing only last color change.
 - Added dmi list to prevent registering platform_profile driver in models
   that doesn't have this feature.
 - Added a x86_cpu_id to differentiate older laptops that are reporting
   fan speeds in big-endian. Also newer laptops have a different power
   profile scheme. I'm using x86_cpu_id because they don't have a
   difference in model names, only in cpu generations (the official driver
   download page makes you select your cpu's generation too).
 - Removed hwmon_pwm device in favor of platform_profile driver. It
   indirectly affects fans' speed but they also affect frequency and
   power consumption as well.
 - Replaced handwritten masks with GENMASK equivalents.
 - Replaced led_classdev_register with
   devm_led_classdev_multicolor_register. This should solve the bug
   where led_classdev remains registered even if casper_wmi_probe
   returns -ENODEV.
 - Removed select NEW_LEDS and LEDS_CLASS, because it creates recursive
   dependencies.
 - And some minor changes.
Changes in v2:
 - Added masks for
 - Changed casper_set and casper_query returns Linux error code rather
   than acpi_status.
 - replaced complicated bit operations with FIELD_GET.
 - Fixed some indentation and spacing.
 - Broke fan speeds further.
 - Moved module metadata to the end of the file.
---
 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 +
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
 4 files changed, 662 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb08..78f908449ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4761,6 +4761,12 @@ S:	Maintained
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
index 7e9251fc334..e671ccbf23a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1122,6 +1122,20 @@ config SEL3350_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called sel3350-platform.
 
+config CASPER_WMI
+	tristate "Casper Excalibur Laptop WMI driver"
+	depends on ACPI_WMI
+	depends on HWMON
+	depends on LEDS_CLASS_MULTICOLOR
+	select ACPI_PLATFORM_PROFILE
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
index 00000000000..e86def01753
--- /dev/null
+++ b/drivers/platform/x86/casper-wmi.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/bits.h>
+#include <linux/bitops.h>
+#include <linux/acpi.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+#include <linux/wmi.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <acpi/acexcep.h>
+#include <linux/bitfield.h>
+#include <linux/platform_profile.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/types.h>
+#include <linux/mutex_types.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/container_of.h>
+
+#include <linux/dmi.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
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
+#define CASPER_LED_COUNT 4
+
+static const char * const zone_names[CASPER_LED_COUNT] = {
+	"casper::kbd_zoned_backlight-right",
+	"casper::kbd_zoned_backlight-middle",
+	"casper::kbd_zoned_backlight-left",
+	"casper::kbd_zoned_backlight-corners",
+};
+
+#define CASPER_LED_ALPHA GENMASK(31, 24)
+#define CASPER_LED_RED	 GENMASK(23, 16)
+#define CASPER_LED_GREEN GENMASK(15, 8)
+#define CASPER_LED_BLUE  GENMASK(7, 0)
+#define CASPER_DEFAULT_COLOR (CASPER_LED_RED | CASPER_LED_GREEN | \
+			      CASPER_LED_BLUE)
+#define CASPER_FAN_CPU 0
+#define CASPER_FAN_GPU 1
+
+enum casper_power_profile_old {
+	CASPER_HIGH_PERFORMANCE = 1,
+	CASPER_GAMING		= 2,
+	CASPER_TEXT_MODE	= 3,
+	CASPER_POWERSAVE	= 4
+};
+
+enum casper_power_profile_new {
+	CASPER_NEW_HIGH_PERFORMANCE	= 0,
+	CASPER_NEW_GAMING		= 1,
+	CASPER_NEW_AUDIO		= 2
+};
+
+struct casper_quirk_entry {
+	bool big_endian_fans;
+	bool no_power_profiles;
+	bool new_power_scheme;
+};
+
+struct casper_drv {
+	struct platform_profile_handler handler;
+	struct mutex casper_mutex;
+	u32 color_cache[CASPER_LED_COUNT];
+	struct led_classdev_mc *casper_kbd_mc;
+	struct mc_subled *subleds;
+	struct wmi_device *wdev;
+	struct casper_quirk_entry *quirk_applied;
+};
+
+struct casper_wmi_args {
+	u16 a0, a1;
+	u32 a2, a3, a4, a5, a6, a7, a8;
+};
+
+enum casper_led_mode {
+	LED_NORMAL = 0x10,
+	LED_BLINK = 0x20,
+	LED_FADE = 0x30,
+	LED_HEARTBEAT = 0x40,
+	LED_REPEAT = 0x50,
+	LED_RANDOM = 0x60
+};
+
+static int casper_set(struct casper_drv *drv, u16 a1, u8 led_id, u32 data)
+{
+	acpi_status ret = 0;
+	struct casper_wmi_args wmi_args;
+	struct acpi_buffer input;
+
+	wmi_args = (struct casper_wmi_args) {
+		.a0 = CASPER_WRITE,
+		.a1 = a1,
+		.a2 = led_id,
+		.a3 = data
+	};
+
+	input = (struct acpi_buffer) {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+
+	mutex_lock(&drv->casper_mutex);
+
+	ret = wmidev_block_set(drv->wdev, 0, &input);
+	if (ACPI_FAILURE(ret))
+		ret = -EIO;
+
+	mutex_unlock(&drv->casper_mutex);
+	return ret;
+}
+
+static int casper_query(struct casper_drv *drv, u16 a1,
+			struct casper_wmi_args *out)
+{
+	union acpi_object *obj;
+	struct casper_wmi_args wmi_args;
+	struct acpi_buffer input;
+	int ret = 0;
+
+	wmi_args = (struct casper_wmi_args) {
+		.a0 = CASPER_READ,
+		.a1 = a1
+	};
+	input = (struct acpi_buffer) {
+		(acpi_size) sizeof(struct casper_wmi_args),
+		&wmi_args
+	};
+
+	mutex_lock(&drv->casper_mutex);
+
+	ret = wmidev_block_set(drv->wdev, 0, &input);
+	if (ACPI_FAILURE(ret)) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	obj = wmidev_block_query(drv->wdev, 0);
+	if (!obj) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	if (obj->type != ACPI_TYPE_BUFFER) { // obj will be 0x10 on failure
+		ret = -EINVAL;
+		goto freeobj;
+	}
+	if (obj->buffer.length != sizeof(struct casper_wmi_args)) {
+		ret = -EIO;
+		goto freeobj;
+	}
+
+	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
+
+freeobj:
+	kfree(obj);
+unlock:
+	mutex_unlock(&drv->casper_mutex);
+	return ret;
+}
+
+static enum led_brightness get_casper_brightness(struct led_classdev *led_cdev)
+{
+	struct casper_drv *drv = dev_get_drvdata(led_cdev->dev->parent);
+	struct casper_wmi_args hardware_alpha = {0};
+
+	if (strcmp(led_cdev->name, zone_names[3]) == 0)
+		return FIELD_GET(CASPER_LED_ALPHA, drv->color_cache[3]);
+
+	casper_query(drv, CASPER_GET_HARDWAREINFO, &hardware_alpha);
+
+	return hardware_alpha.a6;
+}
+
+static void set_casper_brightness(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	u32 bright_with_mode, bright_prep, led_data, led_data_no_alpha;
+	struct casper_drv *drv;
+	int ret;
+	size_t zone;
+	u8 zone_to_change;
+
+	drv = dev_get_drvdata(led_cdev->dev->parent);
+
+	for (size_t i = 0; i < CASPER_LED_COUNT; i++)
+		if (strcmp(led_cdev->name, zone_names[i]) == 0)
+			zone = i;
+	if (zone == 3)
+		zone_to_change = CASPER_CORNER_LEDS;
+	else
+		zone_to_change = zone + CASPER_KEYBOARD_LED_1;
+
+	led_data_no_alpha = drv->subleds[zone].intensity & ~CASPER_LED_ALPHA;
+
+	if ((drv->color_cache[zone] & ~CASPER_LED_ALPHA) == led_data_no_alpha)
+		bright_with_mode = brightness | LED_NORMAL;
+	else
+		bright_with_mode = get_casper_brightness(led_cdev) | LED_NORMAL;
+
+	bright_prep = FIELD_PREP(CASPER_LED_ALPHA, bright_with_mode);
+	led_data = bright_prep | led_data_no_alpha;
+	ret = casper_set(drv, CASPER_SET_LED, zone_to_change, led_data);
+	if (ret)
+		return;
+
+	drv->color_cache[zone] = led_data;
+}
+
+static int casper_platform_profile_get(struct platform_profile_handler *pprof,
+				       enum platform_profile_option *profile)
+{
+	struct casper_drv *drv = container_of(pprof, struct casper_drv,
+					      handler);
+	struct casper_wmi_args ret_buff = {0};
+	int ret;
+
+	ret = casper_query(drv, CASPER_POWERPLAN, &ret_buff);
+	if (ret)
+		return ret;
+
+	if (drv->quirk_applied->new_power_scheme) {
+		switch (ret_buff.a2) {
+		case CASPER_NEW_HIGH_PERFORMANCE:
+			*profile = PLATFORM_PROFILE_PERFORMANCE;
+			break;
+		case CASPER_NEW_GAMING:
+			*profile = PLATFORM_PROFILE_BALANCED;
+			break;
+		case CASPER_NEW_AUDIO:
+			*profile = PLATFORM_PROFILE_LOW_POWER;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	switch (ret_buff.a2) {
+	case CASPER_HIGH_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case CASPER_GAMING:
+		*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
+		break;
+	case CASPER_TEXT_MODE:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case CASPER_POWERSAVE:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int casper_platform_profile_set(struct platform_profile_handler *pprof,
+				       enum platform_profile_option profile)
+{
+	struct casper_drv *drv = container_of(pprof, struct casper_drv,
+					      handler);
+	enum casper_power_profile_old prf_old;
+	enum casper_power_profile_new prf_new;
+
+	if (drv->quirk_applied->new_power_scheme) {
+
+		switch (profile) {
+		case PLATFORM_PROFILE_PERFORMANCE:
+			prf_new = CASPER_NEW_HIGH_PERFORMANCE;
+			break;
+		case PLATFORM_PROFILE_BALANCED:
+			prf_new = CASPER_NEW_GAMING;
+			break;
+		case PLATFORM_PROFILE_LOW_POWER:
+			prf_new = CASPER_NEW_AUDIO;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return casper_set(drv, CASPER_POWERPLAN, prf_new, 0);
+	}
+
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		prf_old = CASPER_HIGH_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
+		prf_old = CASPER_GAMING;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		prf_old = CASPER_TEXT_MODE;
+		break;
+	case PLATFORM_PROFILE_LOW_POWER:
+		prf_old = CASPER_POWERSAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return casper_set(drv, CASPER_POWERPLAN, prf_old, 0);
+}
+
+static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	return 0444;
+}
+
+static int casper_wmi_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long *val)
+{
+	struct casper_wmi_args out = { 0 };
+	struct casper_drv *drv = dev_get_drvdata(dev->parent);
+	int ret;
+
+	ret = casper_query(drv, CASPER_GET_HARDWAREINFO, &out);
+	if (ret)
+		return ret;
+
+	switch (channel) {
+	case CASPER_FAN_CPU:
+		if (drv->quirk_applied->big_endian_fans)
+			*val = be16_to_cpu(*(__be16 *)&out.a4);
+		else
+			*val = out.a5;
+		break;
+	case CASPER_FAN_GPU:
+		if (drv->quirk_applied->big_endian_fans)
+			*val = be16_to_cpu(*(__be16 *)&out.a5);
+		else
+			*val = out.a5;
+		break;
+	}
+
+	return 0;
+}
+
+static int casper_wmi_hwmon_read_string(struct device *dev,
+					enum hwmon_sensor_types type, u32 attr,
+					int channel, const char **str)
+{
+	if (channel == CASPER_FAN_CPU)
+		*str = "cpu_fan_speed";
+	else if (channel == CASPER_FAN_GPU)
+		*str = "gpu_fan_speed";
+	return 0;
+}
+
+static const struct hwmon_ops casper_wmi_hwmon_ops = {
+	.is_visible = &casper_wmi_hwmon_is_visible,
+	.read = &casper_wmi_hwmon_read,
+	.read_string = &casper_wmi_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info *const casper_wmi_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info casper_wmi_hwmon_chip_info = {
+	.ops = &casper_wmi_hwmon_ops,
+	.info = casper_wmi_hwmon_info,
+};
+
+static struct casper_quirk_entry gen_older_than_11 = {
+	.big_endian_fans = true,
+	.new_power_scheme = false
+};
+
+static struct casper_quirk_entry gen_newer_than_11 = {
+	.big_endian_fans = false,
+	.new_power_scheme = true
+};
+
+static const struct x86_cpu_id casper_gen[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, &gen_older_than_11),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, &gen_older_than_11),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, &gen_newer_than_11),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, &gen_newer_than_11),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, &gen_newer_than_11),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, &gen_newer_than_11),
+	{}
+};
+
+static struct casper_quirk_entry quirk_no_power_profile = {
+	.no_power_profiles = true
+};
+
+static struct casper_quirk_entry quirk_has_power_profile = {
+	.no_power_profiles = false
+};
+
+static const struct dmi_system_id casper_quirks[] = {
+	{
+		.ident = "CASPER EXCALIBUR G650",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G650")
+		},
+		.driver_data = &quirk_no_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G670",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G670")
+		},
+		.driver_data = &quirk_no_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G750",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G750")
+		},
+		.driver_data = &quirk_no_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G770",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G770")
+		},
+		.driver_data = &quirk_has_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G780",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G780")
+		},
+		.driver_data = &quirk_has_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G870",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G870")
+		},
+		.driver_data = &quirk_has_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G900",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G900")
+		},
+		.driver_data = &quirk_has_power_profile
+	},
+	{
+		.ident = "CASPER EXCALIBUR G911",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,
+				  "CASPER BILGISAYAR SISTEMLERI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EXCALIBUR G911")
+		},
+		.driver_data = &quirk_has_power_profile
+	},
+	{ }
+};
+
+static int casper_platform_profile_register(struct casper_drv *drv)
+{
+	drv->handler.profile_get = casper_platform_profile_get;
+	drv->handler.profile_set = casper_platform_profile_set;
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, drv->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, drv->handler.choices);
+	if (!drv->quirk_applied->new_power_scheme)
+		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+			drv->handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, drv->handler.choices);
+
+	return platform_profile_register(&drv->handler);
+}
+
+static int casper_multicolor_register(struct casper_drv *drv)
+{
+	int ret = 0;
+
+	drv->casper_kbd_mc = devm_kcalloc(&drv->wdev->dev,
+		CASPER_LED_COUNT, sizeof(*drv->casper_kbd_mc), GFP_KERNEL);
+
+	drv->subleds = devm_kcalloc(&drv->wdev->dev,
+		CASPER_LED_COUNT, sizeof(struct mc_subled *), GFP_KERNEL);
+	if (!drv->casper_kbd_mc || !drv->subleds)
+		return -ENOMEM;
+
+	for (size_t i = 0; i < CASPER_LED_COUNT; i++) {
+		drv->subleds[i] = (struct mc_subled) {
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 2,
+			.intensity = CASPER_DEFAULT_COLOR
+		};
+		drv->casper_kbd_mc[i] = (struct led_classdev_mc) {
+			.led_cdev = {
+				.name = zone_names[i],
+				.brightness = 0,
+				.max_brightness = 2,
+				.brightness_set = &set_casper_brightness,
+				.brightness_get = &get_casper_brightness,
+				.color = LED_COLOR_ID_RGB,
+			},
+			.num_colors = 1,
+			.subled_info = &drv->subleds[i]
+		};
+
+		ret = devm_led_classdev_multicolor_register(&drv->wdev->dev,
+						&drv->casper_kbd_mc[i]);
+		if (ret)
+			return -ENODEV;
+		drv->color_cache[i] = CASPER_DEFAULT_COLOR;
+	}
+
+	// Setting leds to the default color
+	ret = casper_set(drv, CASPER_SET_LED, CASPER_ALL_KEYBOARD_LEDS,
+			 CASPER_DEFAULT_COLOR);
+	if (ret)
+		return ret;
+
+	ret = casper_set(drv, CASPER_SET_LED, CASPER_CORNER_LEDS,
+			 CASPER_DEFAULT_COLOR);
+	return ret;
+}
+
+static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *hwmon_dev;
+	struct casper_drv *drv;
+	const struct x86_cpu_id *gen_id;
+	const struct dmi_system_id *dmi_id;
+	struct casper_quirk_entry *pp_quirk;
+	int ret;
+
+	drv = devm_kzalloc(&wdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, drv);
+
+	gen_id = x86_match_cpu(casper_gen);
+	if (!gen_id)
+		return -ENODEV;
+
+	drv->quirk_applied = (struct casper_quirk_entry *)gen_id->driver_data;
+
+	dmi_id = dmi_first_match(casper_quirks);
+	if (!dmi_id)
+		return -ENODEV;
+
+	pp_quirk = (struct casper_quirk_entry *)dmi_id->driver_data;
+	drv->quirk_applied->no_power_profiles = pp_quirk->no_power_profiles;
+
+	mutex_init(&drv->casper_mutex);
+
+	ret = casper_multicolor_register(drv);
+	if (ret)
+		goto destroy;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
+						"casper_wmi", wdev,
+						&casper_wmi_hwmon_chip_info,
+						NULL);
+	if (IS_ERR(hwmon_dev)) {
+		ret = PTR_ERR(hwmon_dev);
+		goto destroy;
+	}
+
+	if (!drv->quirk_applied->no_power_profiles) {
+		ret = casper_platform_profile_register(drv);
+		if (ret)
+			goto destroy;
+	}
+
+	return 0;
+destroy:
+	mutex_destroy(&drv->casper_mutex);
+	return ret;
+}
+
+static void casper_wmi_remove(struct wmi_device *wdev)
+{
+	struct casper_drv *drv = dev_get_drvdata(&wdev->dev);
+
+	mutex_destroy(&drv->casper_mutex);
+	if (!drv->quirk_applied->no_power_profiles)
+		platform_profile_remove();
+}
+
+static const struct wmi_device_id casper_wmi_id_table[] = {
+	{ CASPER_WMI_GUID, NULL },
+	{ }
+};
+
+static struct wmi_driver casper_drv = {
+	.driver = {
+		.name = "casper-wmi",
+	},
+	.id_table = casper_wmi_id_table,
+	.probe = casper_wmi_probe,
+	.remove = &casper_wmi_remove,
+	.no_singleton = true,
+};
+
+module_wmi_driver(casper_drv);
+MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
+
+MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
+MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
+MODULE_LICENSE("GPL");
-- 
2.44.0


