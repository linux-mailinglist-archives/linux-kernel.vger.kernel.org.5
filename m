Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8967C5D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjJKTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjJKTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:00:45 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0494
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:00:39 -0700 (PDT)
Received: from wse.fritz.box (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPA id D2AC22FC004D;
        Wed, 11 Oct 2023 21:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697050836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FLgOGjNzjHjvqXXkrWOdcFA6E5SE15uw8kWmlY3RHZM=;
        b=At/F+ln5WUsDCFuR0oS30ih+0dD4e4IEIu5mt0va8sDQeFSPDnVI0zMaj0rorj9qj51vPa
        4ZfHrkW+XPoTPNfkFtwc13Ip5xpFhhBwY6UzF2RT25BS3nx2AlpBDwp3bM2t5XI+Zw4twi
        mHvRqL8dhGEPDrCfqf5CVhtgD5p9XLc=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH] leds: rgb: Implement per-key keyboard backlight for several TUXEDO devices
Date:   Wed, 11 Oct 2023 21:00:16 +0200
Message-Id: <20231011190017.1230898-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoffer Sandberg <cs@tuxedo.de>

Implement per-key keyboard backlight in the leds sysfs interface for
several TUXEDO devices using the ite8291 controller.

There are however some known short comings:
- The sysfs leds interface does only allow to write one key at a time. The
controller however can only update row wise or the whole keyboard at once
(whole keyboard update is currently not implemented). This means that even
when you want to updated a whole row, the whole row is actually updated
once for each key. So you actually write up to 18x as much as would be
required.
- When you want to update the brightness of the whole keyboard you have to
write 126 sysfs entries, which inherently is somewhat slow, especially when
using a slider that is live updating the brightness.
- While the controller manages up to 126 leds, not all are actually
populated. However the unused are not grouped at the end but also in
between. To not have dead sysfs entries, this would require manual testing
for each implemented device to see which leds are used and some kind of
bitmap in the driver to sort out the unconnected ones.
- It is not communicated to userspace which led entry controls which key
exactly

Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
---
 drivers/leds/rgb/Kconfig               |   9 +
 drivers/leds/rgb/Makefile              |   1 +
 drivers/leds/rgb/leds-tuxedo-ite8291.c | 451 +++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-tuxedo-ite8291.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 183bccc06cf3..c263ae94c137 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -51,4 +51,13 @@ config LEDS_MT6370_RGB
 	  This driver can also be built as a module. If so, the module
 	  will be called "leds-mt6370-rgb".
 
+config LEDS_TUXEDO_ITE8291
+	tristate "KBL Support for TUXEDO devices using ite8291"
+	help
+	  Say Y here to enable keyboard backlight support for TUXEDO devices
+	  using ite8291.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "leds-tuxedo-ite8291".
+
 endif # LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index c11cc56384e7..5a7447609732 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_LEDS_GROUP_MULTICOLOR)	+= leds-group-multicolor.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
+obj-$(CONFIG_LEDS_TUXEDO_ITE8291)	+= leds-tuxedo-ite8291.o
diff --git a/drivers/leds/rgb/leds-tuxedo-ite8291.c b/drivers/leds/rgb/leds-tuxedo-ite8291.c
new file mode 100644
index 000000000000..b77d45804cd0
--- /dev/null
+++ b/drivers/leds/rgb/leds-tuxedo-ite8291.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2022 TUXEDO Computers GmbH <tux@tuxedocomputers.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+#include <linux/hid.h>
+#include <linux/dmi.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/of.h>
+
+#define LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_MAX	0x32
+#define LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_DEFAULT	0x32
+
+#define LEDS_TUXEDO_ITE8291_BRIGHTNESS_MAX		0xff
+#define LEDS_TUXEDO_ITE8291_BRIGHTNESS_DEFAULT		0x00
+
+#define LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_RED		0xff
+#define LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_GREEN		0xff
+#define LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_BLUE		0xff
+
+#define LEDS_TUXEDO_ITE8291_ROWS			6
+#define LEDS_TUXEDO_ITE8291_COLUMNS			21
+
+// Data length needs one byte (0x00) initial padding for the sending function and one byte (also
+// seemingly 0x00) before the color data starts
+#define LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING		(1 + 1)
+#define LEDS_TUXEDO_ITE8291_ROW_DATA_LENGTH		(LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + \
+							(LEDS_TUXEDO_ITE8291_COLUMNS * 3))
+
+#define LEDS_TUXEDO_ITE8291_PARAM_MODE_USER		0x33
+
+typedef u8 row_data_t[LEDS_TUXEDO_ITE8291_ROWS][LEDS_TUXEDO_ITE8291_ROW_DATA_LENGTH];
+
+struct leds_tuxedo_ite8291_driver_data_t {
+	row_data_t row_data;
+	struct led_classdev_mc mcled_cdevs[LEDS_TUXEDO_ITE8291_ROWS][LEDS_TUXEDO_ITE8291_COLUMNS];
+	struct mc_subled mcled_cdevs_subleds[LEDS_TUXEDO_ITE8291_ROWS][LEDS_TUXEDO_ITE8291_COLUMNS][3];
+};
+
+/**
+ * Set color for specified [row, column] in row based data structure
+ *
+ * @param row_data Data structure to fill
+ * @param row Row number 0 - 5
+ * @param column Column number 0 - 20
+ * @param red Red brightness 0x00 - 0xff
+ * @param green Green brightness 0x00 - 0xff
+ * @param blue Blue brightness 0x00 - 0xff
+ *
+ * @returns 0 on success, otherwise error
+ */
+static int leds_tuxedo_ite8291_set_row_data(row_data_t row_data, int row, int column,
+					    u8 red, u8 green, u8 blue)
+{
+	int column_index_red, column_index_green, column_index_blue;
+
+	if (row < 0 || row >= LEDS_TUXEDO_ITE8291_ROWS ||
+	    column < 0 || column >= LEDS_TUXEDO_ITE8291_COLUMNS)
+		return -EINVAL;
+
+	column_index_red =
+		LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (2 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
+	column_index_green =
+		LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (1 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
+	column_index_blue =
+		LEDS_TUXEDO_ITE8291_ROW_DATA_PADDING + (0 * LEDS_TUXEDO_ITE8291_COLUMNS) + column;
+
+	row_data[row][column_index_red] = red;
+	row_data[row][column_index_green] = green;
+	row_data[row][column_index_blue] = blue;
+
+	return 0;
+}
+
+/**
+ * Just a generic helper function to reduce boilerplate code
+ */
+static int leds_tuxedo_ite8291_hid_feature_report_set(struct hid_device *hdev, u8 *data, size_t len)
+{
+	int result;
+	u8 *buf;
+
+	buf = kmemdup(data, len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	result = hid_hw_raw_request(hdev, buf[0], buf, len, HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	kfree(buf);
+
+	return result;
+}
+
+/**
+ * Update brightness of the whole keyboard. Only used for initialization as this doesn't allow per
+ * key brightness control. That is implemented with RGB value scaling.
+ */
+static int leds_tuxedo_ite8291_write_brightness(struct hid_device *hdev, u8 brightness)
+{
+	int result;
+	u8 brightness_capped = brightness > LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_MAX ?
+			       LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_MAX : brightness;
+	u8 ctrl_set_brightness[8] = {0x08, 0x02, LEDS_TUXEDO_ITE8291_PARAM_MODE_USER, 0x00,
+				     brightness_capped, 0x00, 0x00, 0x00};
+
+	result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_set_brightness,
+							    sizeof(ctrl_set_brightness));
+	if (result < 0)
+		return result;
+
+	return 0;
+}
+
+/**
+ * Update color of a singular row from row_data. This is the smallest unit this device allows to
+ * write. Changes are applied when the last row (row_index == 5) is written.
+ */
+static int leds_tuxedo_ite8291_write_row(struct hid_device *hdev, row_data_t row_data,
+					 int row_index)
+{
+	int result;
+	u8 ctrl_announce_row_data[8] = {0x16, 0x00, row_index, 0x00, 0x00, 0x00, 0x00, 0x00};
+
+	result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_announce_row_data,
+							    sizeof(ctrl_announce_row_data));
+	if (result < 0)
+		return result;
+
+	result = hid_hw_output_report(hdev, row_data[row_index], sizeof(row_data[row_index]));
+	if (result < 0)
+		return result;
+
+	return 0;
+}
+
+/**
+ * Write color and brightness to the whole keyboard from row data. Note that per key brightness is
+ * encoded in the RGB values of the row_data and the gobal brightness is a fixed value.
+ */
+static int leds_tuxedo_ite8291_write_all(struct hid_device *hdev, row_data_t row_data)
+{
+	int result, row_index;
+
+	if (hdev == NULL)
+		return -ENODEV;
+
+	result = leds_tuxedo_ite8291_write_brightness(hdev,
+						      LEDS_TUXEDO_ITE8291_GLOBAL_BRIGHTNESS_DEFAULT);
+	if (result < 0)
+		return result;
+
+	for (row_index = 0; row_index < LEDS_TUXEDO_ITE8291_ROWS; ++row_index) {
+		result = leds_tuxedo_ite8291_write_row(hdev, row_data, row_index);
+		if (result < 0)
+			return result;
+	}
+
+	return 0;
+}
+
+static int leds_tuxedo_ite8291_write_state(struct hid_device *hdev)
+{
+	struct leds_tuxedo_ite8291_driver_data_t *driver_data = hid_get_drvdata(hdev);
+
+	return leds_tuxedo_ite8291_write_all(hdev, driver_data->row_data);
+}
+
+static int leds_tuxedo_ite8291_write_off(struct hid_device *hdev)
+{
+	int result;
+	u8 ctrl_write_off[8] = {0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+
+	result = leds_tuxedo_ite8291_hid_feature_report_set(hdev, ctrl_write_off,
+							    sizeof(ctrl_write_off));
+	if (result < 0)
+		return result;
+
+	return 0;
+}
+
+static int leds_tuxedo_ite8291_start_hw(struct hid_device *hdev)
+{
+	int result;
+
+	result = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (result < 0)
+		goto err_start;
+
+	result = hid_hw_power(hdev, PM_HINT_FULLON);
+	if (result < 0)
+		goto err_power;
+
+	result = hid_hw_open(hdev);
+	if (result)
+		goto err_open;
+
+	return 0;
+
+err_open:
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+err_power:
+	hid_hw_stop(hdev);
+err_start:
+	return result;
+}
+
+static void leds_tuxedo_ite8291_stop_hw(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_power(hdev, PM_HINT_NORMAL);
+	hid_hw_stop(hdev);
+}
+
+static void leds_tuxedo_ite8291_leds_set_brightness_mc(struct led_classdev *led_cdev,
+						       enum led_brightness brightness)
+{
+	int result, row, column;
+	struct led_classdev_mc *mcled_cdev = lcdev_to_mccdev(led_cdev);
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = to_hid_device(dev);
+	struct leds_tuxedo_ite8291_driver_data_t *driver_data = hid_get_drvdata(hdev);
+
+	led_mc_calc_color_components(mcled_cdev, brightness);
+
+	row = mcled_cdev->subled_info[0].channel / LEDS_TUXEDO_ITE8291_COLUMNS;
+	column = mcled_cdev->subled_info[0].channel % LEDS_TUXEDO_ITE8291_COLUMNS;
+
+	result = leds_tuxedo_ite8291_set_row_data(driver_data->row_data, row, column,
+						  mcled_cdev->subled_info[0].brightness,
+						  mcled_cdev->subled_info[1].brightness,
+						  mcled_cdev->subled_info[2].brightness);
+	if (result < 0)
+		return;
+
+	// As a performance optimization, try to write the smallest required unit
+	result = leds_tuxedo_ite8291_write_row(hdev, driver_data->row_data, row);
+	if (result < 0)
+		return;
+
+	// Changes are applied on every write of the last row. So, if a different row was written,
+	// also write the last row.
+	if (row != LEDS_TUXEDO_ITE8291_ROWS - 1) {
+		result = leds_tuxedo_ite8291_write_row(hdev, driver_data->row_data,
+						       LEDS_TUXEDO_ITE8291_ROWS - 1);
+		if (result < 0)
+			return;
+	}
+
+	led_cdev->brightness = brightness;
+}
+
+static int leds_tuxedo_ite8291_register_leds(struct hid_device *hdev)
+{
+	int result, i, j, k, l;
+	struct leds_tuxedo_ite8291_driver_data_t *driver_data = hid_get_drvdata(hdev);
+
+	for (i = 0; i < LEDS_TUXEDO_ITE8291_ROWS; ++i) {
+		for (j = 0; j < LEDS_TUXEDO_ITE8291_COLUMNS; ++j) {
+			driver_data->mcled_cdevs[i][j].led_cdev.name =
+				"rgb:" LED_FUNCTION_KBD_BACKLIGHT;
+			driver_data->mcled_cdevs[i][j].led_cdev.max_brightness =
+				LEDS_TUXEDO_ITE8291_BRIGHTNESS_MAX;
+			driver_data->mcled_cdevs[i][j].led_cdev.brightness_set =
+				&leds_tuxedo_ite8291_leds_set_brightness_mc;
+			driver_data->mcled_cdevs[i][j].led_cdev.brightness =
+				LEDS_TUXEDO_ITE8291_BRIGHTNESS_DEFAULT;
+			driver_data->mcled_cdevs[i][j].num_colors =
+				3;
+			driver_data->mcled_cdevs[i][j].subled_info =
+				driver_data->mcled_cdevs_subleds[i][j];
+			driver_data->mcled_cdevs[i][j].subled_info[0].color_index =
+				LED_COLOR_ID_RED;
+			driver_data->mcled_cdevs[i][j].subled_info[0].intensity =
+				LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_RED;
+			driver_data->mcled_cdevs[i][j].subled_info[0].channel =
+				LEDS_TUXEDO_ITE8291_COLUMNS * i + j;
+			driver_data->mcled_cdevs[i][j].subled_info[1].color_index =
+				LED_COLOR_ID_GREEN;
+			driver_data->mcled_cdevs[i][j].subled_info[1].intensity =
+				LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_GREEN;
+			driver_data->mcled_cdevs[i][j].subled_info[1].channel =
+				LEDS_TUXEDO_ITE8291_COLUMNS * i + j;
+			driver_data->mcled_cdevs[i][j].subled_info[2].color_index =
+				LED_COLOR_ID_BLUE;
+			driver_data->mcled_cdevs[i][j].subled_info[2].intensity =
+				LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_BLUE;
+			driver_data->mcled_cdevs[i][j].subled_info[2].channel =
+				LEDS_TUXEDO_ITE8291_COLUMNS * i + j;
+
+			result = devm_led_classdev_multicolor_register(&hdev->dev,
+								       &driver_data->mcled_cdevs[i][j]);
+			if (result < 0) {
+				for (k = 0; k <= i; ++k) {
+					for (l = 0; l <= j; ++l) {
+						devm_led_classdev_multicolor_unregister(&hdev->dev,
+											&driver_data->mcled_cdevs[i][j]);
+					}
+				}
+				return result;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void leds_tuxedo_ite8291_unregister_leds(struct hid_device *hdev)
+{
+	int i, j;
+	struct leds_tuxedo_ite8291_driver_data_t *driver_data = hid_get_drvdata(hdev);
+
+	for (i = 0; i < LEDS_TUXEDO_ITE8291_ROWS; ++i) {
+		for (j = 0; j < LEDS_TUXEDO_ITE8291_COLUMNS; ++j) {
+			devm_led_classdev_multicolor_unregister(&hdev->dev,
+								&driver_data->mcled_cdevs[i][j]);
+		}
+	}
+}
+
+static int leds_tuxedo_ite8291_device_add(struct hid_device *hdev)
+{
+	int result, i, j;
+	u8 default_brightness_red, default_brightness_green, default_brightness_blue;
+	struct leds_tuxedo_ite8291_driver_data_t *driver_data;
+
+	driver_data = devm_kzalloc(&hdev->dev, sizeof(*driver_data), GFP_KERNEL);
+	if (!driver_data)
+		return -ENOMEM;
+	hid_set_drvdata(hdev, driver_data);
+
+	default_brightness_red = LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_RED *
+				 LEDS_TUXEDO_ITE8291_BRIGHTNESS_DEFAULT /
+				 LEDS_TUXEDO_ITE8291_BRIGHTNESS_MAX;
+	default_brightness_green = LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_GREEN *
+				   LEDS_TUXEDO_ITE8291_BRIGHTNESS_DEFAULT /
+				   LEDS_TUXEDO_ITE8291_BRIGHTNESS_MAX;
+	default_brightness_blue = LEDS_TUXEDO_ITE8291_COLOR_DEFAULT_BLUE *
+				  LEDS_TUXEDO_ITE8291_BRIGHTNESS_DEFAULT /
+				  LEDS_TUXEDO_ITE8291_BRIGHTNESS_MAX;
+	for (i = 0; i < LEDS_TUXEDO_ITE8291_ROWS; ++i) {
+		for (j = 0; j < LEDS_TUXEDO_ITE8291_COLUMNS; ++j) {
+			leds_tuxedo_ite8291_set_row_data(driver_data->row_data, i, j,
+							 default_brightness_red,
+							 default_brightness_green,
+							 default_brightness_blue);
+		}
+	}
+
+	result = leds_tuxedo_ite8291_write_state(hdev);
+	if (result < 0)
+		return result;
+
+	result = leds_tuxedo_ite8291_register_leds(hdev);
+	if (result < 0)
+		return result;
+
+	return 0;
+}
+
+static int leds_tuxedo_ite8291_device_remove(struct hid_device *hdev)
+{
+	leds_tuxedo_ite8291_unregister_leds(hdev);
+	leds_tuxedo_ite8291_write_off(hdev);
+
+	return 0;
+}
+
+static const struct dmi_system_id leds_tuxedo_ite8291_whitelist[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+		},
+	},
+	{ }
+};
+
+static int leds_tuxedo_ite8291_probe(struct hid_device *hdev,
+				     const struct hid_device_id *id __always_unused)
+{
+	int result;
+
+	// The ite8291 can be used quite differently. To ensure that this driver doesn't do bogus
+	// things, limit it to tested devices. Done via DMI matching as for the time being this
+	// driver is for internal keyboard backlights only.
+	if (!dmi_check_system(leds_tuxedo_ite8291_whitelist))
+		return -ENODEV;
+
+	result = hid_parse(hdev);
+	if (result < 0)
+		return result;
+
+	result = leds_tuxedo_ite8291_start_hw(hdev);
+	if (result < 0)
+		return result;
+
+	result = leds_tuxedo_ite8291_device_add(hdev);
+	if (result != 0)
+		return result;
+
+	return 0;
+}
+
+static void leds_tuxedo_ite8291_remove(struct hid_device *hdev)
+{
+	leds_tuxedo_ite8291_device_remove(hdev);
+	leds_tuxedo_ite8291_stop_hw(hdev);
+}
+
+#ifdef CONFIG_PM
+static int leds_tuxedo_ite8291_suspend(struct hid_device *hdev,
+				       pm_message_t message __always_unused)
+{
+	return leds_tuxedo_ite8291_write_off(hdev);
+}
+
+static int leds_tuxedo_ite8291_resume(struct hid_device *hdev)
+{
+	return leds_tuxedo_ite8291_write_state(hdev);
+}
+
+static int leds_tuxedo_ite8291_reset_resume(struct hid_device *hdev)
+{
+	return leds_tuxedo_ite8291_write_state(hdev);
+}
+#endif
+
+static const struct hid_device_id leds_tuxedo_ite8291_id_table[] = {
+	// Tongfang internal keyboard backlights
+	{ HID_USB_DEVICE(0x048d, 0x6004) },
+	{ HID_USB_DEVICE(0x048d, 0x600a) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, leds_tuxedo_ite8291_id_table);
+
+static struct hid_driver leds_tuxedo_ite8291 = {
+	.name = "leds-tuxedo-ite8291",
+	.id_table = leds_tuxedo_ite8291_id_table,
+	.probe = leds_tuxedo_ite8291_probe,
+	.remove = leds_tuxedo_ite8291_remove,
+#ifdef CONFIG_PM
+	.suspend = leds_tuxedo_ite8291_suspend,
+	.resume = leds_tuxedo_ite8291_resume,
+	.reset_resume = leds_tuxedo_ite8291_reset_resume
+#endif
+};
+module_hid_driver(leds_tuxedo_ite8291);
+
+MODULE_AUTHOR("TUXEDO Computers GmbH <tux@tuxedocomputers.com>");
+MODULE_DESCRIPTION("Driver for ITE Device(8291) RGB LED keyboard backlight.");
+MODULE_LICENSE("GPL");
-- 
2.34.1

