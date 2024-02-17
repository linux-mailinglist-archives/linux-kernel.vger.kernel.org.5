Return-Path: <linux-kernel+bounces-69699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3658858D6E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29B6283846
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B881CD03;
	Sat, 17 Feb 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b="w2HDsiqh"
Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317481CAAC;
	Sat, 17 Feb 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708149881; cv=none; b=dJXW/FlCCRpkexeU2sKaQbrEBdrP5Mh/ZWaIyYzITrswKk8iS0cK/7Hpen9mnx9xPabPofHMjOvxBp3s+y5Uk//SG/HfAQT3dc6AREl2l1IP3r4HAzYsIiBV6raJ0SZ/gK3Cmo7uX5XKVB1+pSTW5gQH8G4GGpw4s4AtCC8Op5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708149881; c=relaxed/simple;
	bh=8Jo3+1fbXUjvAXRUG/kCX6FortRRxMk/ITjxwuFyDfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eLJR3+YDQ3J+A97fa4eenfzqTZvFkhk9R3672uCs65gPJFQCTaBeGkKfmqEfbZQiCo5BiTwYjvwRL20JYX+aS07hjaViCAepYfCkjzk+mMnKKUAqYG0hUc+mqZZJ382PYX7PW6KOkPHOkBBxAZI7dmTuADTpdd7xH+7w2W17E/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info; spf=pass smtp.mailfrom=altimeter.info; dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b=w2HDsiqh; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altimeter.info
Received: from lxl-9drxzh3.na.joby.aero (c-73-162-2-38.hsd1.ca.comcast.net [73.162.2.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: linux-kernel@altimeter.info)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id 2591B4486D;
	Sat, 17 Feb 2024 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altimeter.info;
	s=default; t=1708149291;
	bh=NEVBh6mOSjcsgykdJd+GkKPLBxuCjxP6gniCvpJhqx0=;
	h=Date:From:To:Cc:Subject;
	b=w2HDsiqhxJ/nvHAYljjEj3/51RC2dzdB5Qsnv4wbTPkc9X0ZzSm/mhAXht1S5FPbV
	 GJR0evMWMoITqCZCoINTeILIyM5ngoiNh49bk2yDfTAFCMgjqJiot0EHEXOP2TXHEK
	 an30HFBApCeaP7xeUdur0BWLG9chXY5SXOcqqrI4=
Date: Fri, 16 Feb 2024 21:54:47 -0800
From: Ivan Gorinov <linux-kernel@altimeter.info>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: WinWing Orion2 throttle support
Message-ID: <20240216215447.426ca3e7@lxl-9drxzh3.na.joby.aero>
Organization: altimeter.info
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

WinWing Orion2 throttle works with Linux out of box,
but the kernel sees only 16 of 47 buttons on the throttle base.

This module enables all buttons, and also adds LED controls.

Button numbers 0 .. 63 on Orion2 are reserved for throttle grip;
the throttle base buttons have numbers 64 .. 110.

Linux kernel HID subsystem only supports up to 80 buttons.

Remap throttle base buttons to numbers 32 .. 78,
reserving only numbers 0 .. 31 for buttons on the grip handle.

Changes since v2:
   - Fixed automatic line wraps added by mail client

Changes since v1:
   - Fixed formatting of descriptor byte array;
   - Using product codes of Winwing grips in config.

Signed-off-by: Ivan Gorinov <ivan.gorinov@jobyaviation.com>
---
 drivers/hid/Kconfig       |  16 +++
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-winwing.c | 229 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/hid/hid-winwing.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4c682c650704..08446c89eff6 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1236,6 +1236,22 @@ config HID_WIIMOTE
 	To compile this driver as a module, choose M here: the
 	module will be called hid-wiimote.
 
+config HID_WINWING
+	tristate "WinWing Orion2 throttle support"
+	depends on USB_HID
+	depends on NEW_LEDS
+	depends on LEDS_CLASS
+	help
+	  Support for WinWing Orion2 throttle base with the following grips:
+
+	    * TGRIP-16EX
+	    * TGRIP-18
+
+	  This driver enables all buttons and switches on the throttle base.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-winwing.
+
 config HID_XINMO
 	tristate "Xin-Mo non-fully compliant devices"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 082a728eac60..ce71b53ea6c5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -150,6 +150,7 @@ wacom-objs			:= wacom_wac.o wacom_sys.o
 obj-$(CONFIG_HID_WACOM)		+= wacom.o
 obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
 obj-$(CONFIG_HID_WIIMOTE)	+= hid-wiimote.o
+obj-$(CONFIG_HID_WINWING)	+= hid-winwing.o
 obj-$(CONFIG_HID_SENSOR_HUB)	+= hid-sensor-hub.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_SENSOR)	+= hid-sensor-custom.o
 
diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
new file mode 100644
index 000000000000..d895c82a541d
--- /dev/null
+++ b/drivers/hid/hid-winwing.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * HID driver for WinWing Orion 2 throttle
+ *
+ * Copyright (c) 2023 Ivan Gorinov
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/hidraw.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#define MAX_REPORT 16
+
+struct winwing_led {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	int number;
+};
+
+struct winwing_led_info {
+	int number;
+	int max_brightness;
+	const char *led_name;
+};
+
+static struct winwing_led_info led_info[3] = {
+	{ 0, 255, "backlight" },
+	{ 1, 1, "a-a" },
+	{ 2, 1, "a-g" },
+};
+
+struct winwing_drv_data {
+	struct hid_device *hdev;
+	__u8 *report_buf;
+	struct mutex lock;
+	unsigned int num_leds;
+	struct winwing_led leds[];
+};
+
+static int winwing_led_write(struct led_classdev *cdev,
+		enum led_brightness br)
+{
+	struct winwing_led *led = (struct winwing_led *) cdev;
+	struct winwing_drv_data *data = hid_get_drvdata(led->hdev);
+	__u8 *buf = data->report_buf;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	buf[0] = 0x02;
+	buf[1] = 0x60;
+	buf[2] = 0xbe;
+	buf[3] = 0x00;
+	buf[4] = 0x00;
+	buf[5] = 0x03;
+	buf[6] = 0x49;
+	buf[7] = led->number;
+	buf[8] = br;
+	buf[9] = 0x00;
+	buf[10] = 0;
+	buf[11] = 0;
+	buf[12] = 0;
+	buf[13] = 0;
+
+	ret = hid_hw_output_report(led->hdev, buf, 14);
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int winwing_init_led(struct hid_device *hdev,
+		struct input_dev *input)
+{
+	struct winwing_drv_data *data;
+	struct winwing_led *led;
+	int ret;
+	int i;
+
+	size_t data_size = struct_size(data, leds, 3);
+
+	data = devm_kzalloc(&hdev->dev, data_size, GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->report_buf = devm_kmalloc(&hdev->dev, MAX_REPORT, GFP_KERNEL);
+
+	if (!data->report_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < 3; i += 1) {
+		struct winwing_led_info *info = &led_info[i];
+
+		led = &data->leds[i];
+		led->hdev = hdev;
+		led->number = info->number;
+		led->cdev.max_brightness = info->max_brightness;
+		led->cdev.brightness_set_blocking = winwing_led_write;
+		led->cdev.flags = LED_HW_PLUGGABLE;
+		led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						"%s::%s",
+						dev_name(&input->dev),
+						info->led_name);
+
+		ret = devm_led_classdev_register(&hdev->dev, &led->cdev);
+		if (ret)
+			return ret;
+	}
+
+	hid_set_drvdata(hdev, data);
+
+	return ret;
+}
+
+static int winwing_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	unsigned int minor;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	minor = ((struct hidraw *) hdev->hidraw)->minor;
+
+	return 0;
+}
+
+static int winwing_input_configured(struct hid_device *hdev,
+		struct hid_input *hidinput)
+{
+	int ret;
+
+	ret = winwing_init_led(hdev, hidinput->input);
+
+	if (ret)
+		hid_err(hdev, "led init failed\n");
+
+	return ret;
+}
+
+static __u8 original_rdesc_buttons[] = {
+	0x05, 0x09, 0x19, 0x01, 0x29, 0x6F,
+	0x15, 0x00, 0x25, 0x01, 0x35, 0x00,
+	0x45, 0x01, 0x75, 0x01, 0x95, 0x6F,
+	0x81, 0x02, 0x75, 0x01, 0x95, 0x01,
+	0x81, 0x01
+};
+
+/*
+ * HID report descriptor shows 111 buttons, which exceeds maximum
+ * number of buttons (80) supported by Linux kernel HID subsystem.
+ *
+ * This module skips numbers 32-63, unused on some throttle grips.
+ */
+
+static __u8 *winwing_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+		unsigned int *rsize)
+{
+	int sig_length = sizeof(original_rdesc_buttons);
+	int unused_button_numbers = 32;
+
+	if (*rsize < 34)
+		return rdesc;
+
+	if (memcmp(rdesc + 8, original_rdesc_buttons, sig_length) == 0) {
+
+		/* Usage Maximum */
+		rdesc[13] -= unused_button_numbers;
+
+		/*  Report Count for buttons */
+		rdesc[25] -= unused_button_numbers;
+
+		/*  Report Count for padding [HID1_11, 6.2.2.9] */
+		rdesc[31] += unused_button_numbers;
+
+		hid_info(hdev, "winwing descriptor fixed\n");
+	}
+
+	return rdesc;
+}
+
+static int winwing_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *raw_data, int size)
+{
+	if (size >= 15) {
+		/* Skip buttons 32 .. 63 */
+		memmove(raw_data + 5, raw_data + 9, 6);
+
+		/* Clear the padding */
+		memset(raw_data + 11, 0, 4);
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id winwing_devices[] = {
+	{ HID_USB_DEVICE(0x4098, 0xbe62) },  /* TGRIP-18 */
+	{ HID_USB_DEVICE(0x4098, 0xbe68) },  /* TGRIP-16EX */
+	{}
+};
+
+MODULE_DEVICE_TABLE(hid, winwing_devices);
+
+static struct hid_driver winwing_driver = {
+	.name = "winwing",
+	.id_table = winwing_devices,
+	.probe = winwing_probe,
+	.input_configured = winwing_input_configured,
+	.report_fixup = winwing_report_fixup,
+	.raw_event = winwing_raw_event,
+};
+module_hid_driver(winwing_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.25.1


