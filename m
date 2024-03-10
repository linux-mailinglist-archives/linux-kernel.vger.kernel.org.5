Return-Path: <linux-kernel+bounces-98289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC38777F1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4FA1C2074F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877F39FFB;
	Sun, 10 Mar 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkSlRJu3"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB013987D;
	Sun, 10 Mar 2024 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094512; cv=none; b=NjYdQ1rZzgpUScIjOa96bMi8jUFv1H7KSyqK8B4wojONAaMDizyNA7egIE36wnkBRDR4y51nBxWthyXOhmMTVLLqRkNJdBYFioFXnS44becs8Ijf0ZkAIJJu3jJhw6FY/pouq/mdmYbvH8Ks/bvsFEhh1tsLQz9dNQ5kWx3IGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094512; c=relaxed/simple;
	bh=4crKBraPvvRaBBmMDoK61JQqJexw8aZeCjk1a7FcGdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REyhCqIsZyNTc3LzWVBhjawoWGQAWRhVIxTio8vjU+xmeudO74i05rYVLI30WQWjuzilg9A5/CXpIJ0703EE7/wTuFQfSWzp4W0XZAV70PCNJqrXmvP3M9GUaDMJxn/iRs/Btktv7rAh6FJK0V05JYXTk/KzsKXwru/OghYKmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkSlRJu3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so1103493a12.0;
        Sun, 10 Mar 2024 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710094509; x=1710699309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5GQL6GKcHTXjgeAcHvZT+8V6Y66c0etQFUBErhRNWI=;
        b=TkSlRJu3NDZUMnQNzSIbyDYDWg9dEcUQtDdw64reg6mCop0kYpXiESanmgQ1oy1GVr
         FLbnoea4tHwrIjy1jEnxRzwHXqBY44klQvjUxeCbVhccnzAa0Er5/7FYesRSnqDjO5df
         3RN0rQXQ4zkqlLApQq4DDB6p6RwTveGzuaFnS7qizPP/NCoqAcwzrJRrUIRyNdvELNjJ
         QQ1szGpRsF3qxbkrcPWDJXRyIQaXHd/iKtqKUyzpiO4c7+KiiBdIQMgrW/JX/eU4+C8k
         KxdCVyY832kokdacaDeqdrp9LCUZ1K6+coBBCEb9vcijTL/Sxlvfju8mDb3G+uOqpEue
         4Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094509; x=1710699309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5GQL6GKcHTXjgeAcHvZT+8V6Y66c0etQFUBErhRNWI=;
        b=MaqPTpRJhHrbD7ba1b4WJomDYnpZD7aGQr87hZRABL6GAFXU29SgRm9sg8yKLRRdgi
         vq99O2N94MaC7ayB3g9a2ztkvEw4bx95GOI8Gj5xoWz3QbHaYov/LpDq/QKBSW/Oka/m
         dz+miz1s6HZugI7nyHuNG9pNRBnP58FLUk1w0FWliZlQSX4jusmXMB2qMmOEZAma6vEn
         V8b4Urt+6PGZyIDxs4UW53QV0IbeNKraEPg1EK62AgrgSAVqKtqKT7pnqDrQeixU0iL4
         5f0YJ7qirhSC7R61WRjb4MwuxB+S4UaeQjpB1Quk1qvFCNlO3+NMT9Q0z9ipT3S+g03Z
         RiFg==
X-Forwarded-Encrypted: i=1; AJvYcCV8O4wjX3WIQKTnqW/hVcjFmEoIFxUEUU6mtRiFg7Z+tIbMCN6SNrqN2ulvTgWEb6kpC+NL3NzwjKGFtt7qUZGHXn5HBX01Kv2GQcpbUKKKSdnrTrrxM8xsE/6XJMXaAOCa+4cLxwhjgAPpKxfczZ+ceY4mcGRJSgV30k46hrQ8vxMLVS4XZQm8beMKpzvul/qIImCSvcG/jXtlzoLyI27YKcytEgZzkdcjjQ==
X-Gm-Message-State: AOJu0YwGVqlSCdfRWpsAX4hvbJP8DYXHifYzXRy1R2JnhYPRJc2DIqbH
	PAUNXtU8+YROc6exx6GKYsFeL6PxB8Xe+MPtnt0xZsA2PCc7+l69
X-Google-Smtp-Source: AGHT+IF3weW7bN1uhorkMsW5+sFR9BcAJ+ue9b0UcJOdnghAW55xb+cchW+gjlREcINR2D8DCjQROA==
X-Received: by 2002:a50:d483:0:b0:567:e812:e44e with SMTP id s3-20020a50d483000000b00567e812e44emr3098891edi.18.1710094508740;
        Sun, 10 Mar 2024 11:15:08 -0700 (PDT)
Received: from localhost.localdomain ([94.120.90.19])
        by smtp.gmail.com with ESMTPSA id q17-20020a056402033100b00566d6e30f1fsm2074601edw.31.2024.03.10.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:15:08 -0700 (PDT)
From: mustafa <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mustafa.eskieksi@gmail.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org
Cc: rishitbansal0@gmail.com
Subject: [PATCH v3 1/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Sun, 10 Mar 2024 21:14:29 +0300
Message-ID: <20240310181429.59451-2-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240310181429.59451-1-mustafa.eskieksi@gmail.com>
References: <20240310181429.59451-1-mustafa.eskieksi@gmail.com>
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
 - Changed casper_set and casper_query returns Linux error code rather than
   acpi_status.
 - replaced complicated bit operations with FIELD_GET.
 - Fixed some indentation and spacing.
 - Broke fan speeds further.
 - Moved module metadata to the end of the file.
---
 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 +
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 639 ++++++++++++++++++++++++++++++
 4 files changed, 660 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aabf1c15bb..e4cb770c990 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4724,6 +4724,12 @@ S:	Maintained
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
index bdd302274b9..4f951bcac1a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1127,6 +1127,20 @@ config SEL3350_PLATFORM
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
index 00000000000..80e1e2b16fb
--- /dev/null
+++ b/drivers/platform/x86/casper-wmi.c
@@ -0,0 +1,639 @@
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
+#include <linux/sysfs.h>
+#include <linux/platform_profile.h>
+#include <linux/led-class-multicolor.h>
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
+const char * const zone_names[CASPER_LED_COUNT] = {
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
+	CASPER_NEW_HIGH_PEROFRMANCE	= 0,
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
+struct casper_wmi_driver {
+	struct wmi_device *wdev;
+	struct platform_profile_handler handler;
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
+struct casper_led_cache {
+	u32 colors[CASPER_LED_COUNT];
+	u8 last_keyboard_led;
+};
+
+static struct casper_led_cache led_cache = {
+	.colors = {
+		CASPER_DEFAULT_COLOR, CASPER_DEFAULT_COLOR,
+		CASPER_DEFAULT_COLOR, CASPER_DEFAULT_COLOR,
+	},
+	.last_keyboard_led = CASPER_ALL_KEYBOARD_LEDS,
+};
+
+static struct casper_quirk_entry *quirk_applied;
+static struct led_classdev_mc *casper_kbd_mcled_info;
+
+static struct mc_subled casper_kbd_mcled_sub[CASPER_LED_COUNT][1] = {
+	{
+		{
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 2,
+			.intensity = CASPER_DEFAULT_COLOR
+		}
+	},
+	{
+		{
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 2,
+			.intensity = CASPER_DEFAULT_COLOR
+		}
+	},
+	{
+		{
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 2,
+			.intensity = CASPER_DEFAULT_COLOR
+		}
+	},
+	{
+		{
+			.color_index = LED_COLOR_ID_RGB,
+			.brightness = 2,
+			.intensity = CASPER_DEFAULT_COLOR
+		}
+	},
+};
+
+static int casper_set(struct wmi_device *wdev, u16 a1, u8 led_id, u32 data)
+{
+	acpi_status ret;
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
+	ret = wmidev_block_set(wdev, 0, &input);
+	if (ACPI_FAILURE(ret))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int casper_query(struct wmi_device *wdev, u16 a1,
+			struct casper_wmi_args *out)
+{
+	union acpi_object *obj;
+	struct casper_wmi_args wmi_args;
+	struct acpi_buffer input;
+	int ret;
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
+	ret = wmidev_block_set(wdev, 0, &input);
+	if (ACPI_FAILURE(ret))
+		return -EIO;
+
+	obj = wmidev_block_query(wdev, 0);
+	if (IS_ERR_OR_NULL(obj))
+		return -EIO;
+
+	if (obj->type != ACPI_TYPE_BUFFER) { // obj will be 0x10 on failure
+		ret = -EINVAL;
+		goto out;
+	}
+	if (obj->buffer.length != sizeof(struct casper_wmi_args)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	memcpy(out, obj->buffer.pointer, sizeof(struct casper_wmi_args));
+
+out:
+	kfree(obj);
+	return ret;
+}
+
+static enum led_brightness get_casper_brightness(struct led_classdev *led_cdev)
+{
+	struct wmi_device *wdev = to_wmi_device(led_cdev->dev->parent);
+	struct casper_wmi_args hardware_alpha = {0};
+
+	if (strcmp(led_cdev->name, zone_names[3]) == 0)
+		return FIELD_GET(CASPER_LED_ALPHA, led_cache.colors[3]);
+
+	casper_query(wdev, CASPER_GET_HARDWAREINFO, &hardware_alpha);
+
+	return hardware_alpha.a6;
+}
+
+static void set_casper_brightness(struct led_classdev *led_cdev,
+				  enum led_brightness brightness)
+{
+	u32 bright_with_mode, bright_prep, led_data, led_data_no_alpha;
+	struct wmi_device *wdev = to_wmi_device(led_cdev->dev->parent);
+	int ret;
+	size_t zone;
+	u8 zone_to_change;
+
+	for (size_t i = 0; i < CASPER_LED_COUNT; i++)
+		if (strcmp(led_cdev->name, zone_names[i]) == 0)
+			zone = i;
+
+	if (zone == 3)
+		zone_to_change = CASPER_CORNER_LEDS;
+	else
+		zone_to_change = zone + CASPER_KEYBOARD_LED_1;
+
+	led_data_no_alpha = casper_kbd_mcled_info[zone].subled_info[0].intensity
+			    & ~CASPER_LED_ALPHA;
+	if ((led_cache.colors[zone] & ~CASPER_LED_ALPHA) == led_data_no_alpha)
+		bright_with_mode = brightness | LED_NORMAL;
+	else
+		bright_with_mode = get_casper_brightness(led_cdev) | LED_NORMAL;
+
+	bright_prep = FIELD_PREP(CASPER_LED_ALPHA, bright_with_mode);
+	led_data = bright_prep | led_data_no_alpha;
+	ret = casper_set(wdev, CASPER_SET_LED, zone_to_change, led_data);
+	if (ret)
+		return;
+
+	led_cache.colors[zone] = led_data;
+}
+
+static int casper_platform_profile_get(struct platform_profile_handler *pprof,
+				       enum platform_profile_option *profile)
+{
+	struct casper_wmi_driver *drv = container_of(pprof,
+						     struct casper_wmi_driver,
+						     handler);
+	struct casper_wmi_args ret_buff = {0};
+	int ret;
+
+	ret = casper_query(drv->wdev, CASPER_POWERPLAN, &ret_buff);
+	if (ret)
+		return ret;
+
+	if (quirk_applied->new_power_scheme) {
+		switch (ret_buff.a2) {
+		case CASPER_NEW_HIGH_PEROFRMANCE:
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
+	struct casper_wmi_driver *drv = container_of(pprof,
+						     struct casper_wmi_driver,
+						     handler);
+	enum casper_power_profile_old prf_old;
+	enum casper_power_profile_new prf_new;
+
+	if (quirk_applied->new_power_scheme) {
+
+		switch (profile) {
+		case PLATFORM_PROFILE_PERFORMANCE:
+			prf_new = CASPER_NEW_HIGH_PEROFRMANCE;
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
+		return casper_set(drv->wdev, CASPER_POWERPLAN, prf_new, 0);
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
+	return casper_set(drv->wdev, CASPER_POWERPLAN, prf_old, 0);
+}
+
+static umode_t casper_wmi_hwmon_is_visible(const void *drvdata,
+					   enum hwmon_sensor_types type,
+					   u32 attr, int channel)
+{
+	if (type == hwmon_fan)
+		return 0444;
+
+	return 0;
+}
+
+static int casper_wmi_hwmon_read(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long *val)
+{
+	struct casper_wmi_args out = { 0 };
+	struct wmi_device *wdev = to_wmi_device(dev->parent);
+	int ret;
+
+	if (type != hwmon_fan)
+		return -EOPNOTSUPP;
+
+	ret = casper_query(wdev, CASPER_GET_HARDWAREINFO, &out);
+	if (ret)
+		return ret;
+
+	switch (channel) {
+	case CASPER_FAN_CPU:
+		if (quirk_applied->big_endian_fans)
+			*val = be16_to_cpu((u16) out.a4);
+		else
+			*val = out.a5;
+		break;
+	case CASPER_FAN_GPU:
+		if (quirk_applied->big_endian_fans)
+			*val = be16_to_cpu((u16) out.a5);
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
+	if (type != hwmon_fan)
+		return -EOPNOTSUPP;
+
+	switch (channel) {
+	case CASPER_FAN_CPU:
+		*str = "cpu_fan_speed";
+		break;
+	case CASPER_FAN_GPU:
+		*str = "gpu_fan_speed";
+		break;
+	}
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
+/*
+ * These quirks don't get stored in quirk_applied.
+ */
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
+static int casper_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *hwmon_dev;
+	struct casper_wmi_driver *drv;
+	const struct x86_cpu_id *gen_id;
+	const struct dmi_system_id *dmi_id;
+	int ret;
+
+	gen_id = x86_match_cpu(casper_gen);
+	if (!gen_id)
+		return -ENODEV;
+
+	quirk_applied = (struct casper_quirk_entry *) gen_id->driver_data;
+
+	dmi_id = dmi_first_match(casper_quirks);
+	if (!dmi_id)
+		return -ENODEV;
+
+	quirk_applied->no_power_profiles = ((struct casper_quirk_entry *)
+		dmi_id->driver_data)->no_power_profiles;
+
+	casper_kbd_mcled_info = devm_kzalloc(&wdev->dev,
+		sizeof(*casper_kbd_mcled_info)*CASPER_LED_COUNT, GFP_KERNEL);
+	if (casper_kbd_mcled_info == NULL)
+		return -ENOMEM;
+
+	for (size_t i = 0; i < CASPER_LED_COUNT; i++) {
+		casper_kbd_mcled_info[i] = (struct led_classdev_mc) {
+			.led_cdev = {
+				.name = zone_names[i],
+				.brightness = 0,
+				.max_brightness = 2,
+				.brightness_set = &set_casper_brightness,
+				.brightness_get = &get_casper_brightness,
+				.color = LED_COLOR_ID_RGB,
+			},
+			.num_colors = ARRAY_SIZE(casper_kbd_mcled_sub[i]),
+			.subled_info = casper_kbd_mcled_sub[i]
+		};
+
+		ret = devm_led_classdev_multicolor_register(&wdev->dev,
+						&casper_kbd_mcled_info[i]);
+		if (ret)
+			return -ENODEV;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
+						"casper_wmi", wdev,
+						&casper_wmi_hwmon_chip_info,
+						NULL);
+	if (IS_ERR_OR_NULL(hwmon_dev))
+		return -ENODEV;
+
+	if (!quirk_applied->no_power_profiles) {
+		drv = devm_kzalloc(&wdev->dev, sizeof(*drv), GFP_KERNEL);
+		if (drv == NULL)
+			return -ENOMEM;
+		drv->wdev = wdev;
+		dev_set_drvdata(&wdev->dev, drv);
+
+		drv->handler.profile_get = casper_platform_profile_get;
+		drv->handler.profile_set = casper_platform_profile_set;
+
+		set_bit(PLATFORM_PROFILE_LOW_POWER, drv->handler.choices);
+		set_bit(PLATFORM_PROFILE_BALANCED, drv->handler.choices);
+		if (!quirk_applied->new_power_scheme)
+			set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+				drv->handler.choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, drv->handler.choices);
+
+		ret = platform_profile_register(&drv->handler);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void casper_wmi_remove(struct wmi_device *wdev)
+{
+	if (!quirk_applied->no_power_profiles)
+		platform_profile_remove();
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
+	.remove = &casper_wmi_remove,
+};
+
+module_wmi_driver(casper_wmi_driver);
+MODULE_DEVICE_TABLE(wmi, casper_wmi_id_table);
+
+MODULE_AUTHOR("Mustafa Ekşi <mustafa.eskieksi@gmail.com>");
+MODULE_DESCRIPTION("Casper Excalibur Laptop WMI driver");
+MODULE_LICENSE("GPL");
-- 
2.44.0


