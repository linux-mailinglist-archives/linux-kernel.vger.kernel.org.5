Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4846E7A95F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjIUQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjIUQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:13 -0400
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E024CDC;
        Thu, 21 Sep 2023 09:57:24 -0700 (PDT)
Received: from localhost.localdomain (ip5f5be8a2.dynamic.kabel-deutschland.de [95.91.232.162])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id 50D653FF34;
        Thu, 21 Sep 2023 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1695314987;
        bh=RzlbRSpZLsCE3Ip05jeUYPfcw1iLZoyYZBXFEI1zC8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=EefAc1m/e4UWJf6f2LVksM+6VXiHWGu9+6ni3nhUtDKwADRAtL4ocXI1DSaM9x1Nv
         OOaBbz2iUEklEZtBvRsQt1sCXZueeMWsoYLPLY4qgoI7U3Mk5tWI/x7CCW0EUydtz+
         l3iz9UHgT8sF0D+7t7m/ynl7fXB0D1WcT7HMIgObpF+EGVljTYMI7HSP073w63PbUk
         9A1zkhINcxahtIyt9nqsTCP0O2dC7VlQwZAK7jmzmQIoxJumuu6dzFowRx7fTVpOqg
         heizRrRvYHFHdhxDQ0y2ZQBxTmATAV7fYbWP70lxeVhIKC1/0JpxHnaO1dW0LudXOC
         YgSRfjd8ifUhg==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     jikos@kernel.org
Cc:     sergeantsagara@protonmail.com, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        johannes@gnu-linux.rocks, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: [PATCH v7] HID: mcp2200: added driver for GPIOs of MCP2200
Date:   Thu, 21 Sep 2023 18:49:28 +0200
Message-ID: <20230921164928.170383-1-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a gpiochip compatible driver to control the 8 GPIOs of
the MCP2200 by using the HID interface.

Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
default).

The driver was tested while also using the UART of the chip. Setting
and reading the GPIOs has no effect on the UART communication. However,
a reset is triggered after the CONFIGURE command. If the GPIO Direction
is constantly changed, this will affect the communication at low baud
rates. This is a hardware problem of the MCP2200 and is not caused by
the driver.

Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
---
 drivers/hid/Kconfig       |   9 +
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   1 +
 drivers/hid/hid-mcp2200.c | 392 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 drivers/hid/hid-mcp2200.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 0cea301cc9a9..3c14644b593d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1298,6 +1298,15 @@ config HID_ALPS
 	Say Y here if you have a Alps touchpads over i2c-hid or usbhid
 	and want support for its special functionalities.
 
+config HID_MCP2200
+	tristate "Microchip MCP2200 HID USB-to-GPIO bridge"
+	depends on USB_HID && GPIOLIB
+	help
+	  Provides GPIO functionality over USB-HID through MCP2200 device.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-mcp2200.ko.
+
 config HID_MCP2221
 	tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
 	depends on USB_HID && I2C
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 8a06d0f840bc..082a728eac60 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
 obj-$(CONFIG_HID_MACALLY)	+= hid-macally.o
 obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
 obj-$(CONFIG_HID_MALTRON)	+= hid-maltron.o
+obj-$(CONFIG_HID_MCP2200)	+= hid-mcp2200.o
 obj-$(CONFIG_HID_MCP2221)	+= hid-mcp2221.o
 obj-$(CONFIG_HID_MAYFLASH)	+= hid-mf.o
 obj-$(CONFIG_HID_MEGAWORLD_FF)	+= hid-megaworld.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7e499992a793..bb87ad4eb2aa 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -915,6 +915,7 @@
 #define USB_DEVICE_ID_PICK16F1454	0x0042
 #define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
 #define USB_DEVICE_ID_LUXAFOR		0xf372
+#define USB_DEVICE_ID_MCP2200		0x00df
 #define USB_DEVICE_ID_MCP2221		0x00dd
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
new file mode 100644
index 000000000000..bf57f7f6caa0
--- /dev/null
+++ b/drivers/hid/hid-mcp2200.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MCP2200 - Microchip USB to GPIO bridge
+ *
+ * Copyright (c) 2023, Johannes Roith <johannes@gnu-linux.rocks>
+ *
+ * Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22228A.pdf
+ * App Note for HID: https://ww1.microchip.com/downloads/en/DeviceDoc/93066A.pdf
+ */
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/hid.h>
+#include <linux/hidraw.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include "hid-ids.h"
+
+/* Commands codes in a raw output report */
+#define SET_CLEAR_OUTPUTS	0x08
+#define CONFIGURE		0x10
+#define READ_EE			0x20
+#define WRITE_EE		0x40
+#define READ_ALL		0x80
+
+/* MCP GPIO direction encoding */
+enum MCP_IO_DIR {
+	MCP2200_DIR_OUT = 0x00,
+	MCP2200_DIR_IN  = 0x01,
+};
+
+/* Altternative pin assignments */
+#define TXLED		2
+#define RXLED		3
+#define USBCFG		6
+#define SSPND		7
+#define MCP_NGPIO	8
+
+/* CMD to set or clear a GPIO output */
+struct mcp_set_clear_outputs {
+	u8 cmd;
+	u8 dummys1[10];
+	u8 set_bmap;
+	u8 clear_bmap;
+	u8 dummys2[3];
+} __packed;
+
+/* CMD to configure the IOs */
+struct mcp_configure {
+	u8 cmd;
+	u8 dummys1[3];
+	u8 io_bmap;
+	u8 config_alt_pins;
+	u8 io_default_val_bmap;
+	u8 config_alt_options;
+	u8 baud_h;
+	u8 baud_l;
+	u8 dummys2[6];
+} __packed;
+
+/* CMD to read all parameters */
+struct mcp_read_all {
+	u8 cmd;
+	u8 dummys[15];
+} __packed;
+
+/* Response to the read all cmd */
+struct mcp_read_all_resp {
+	u8 cmd;
+	u8 eep_addr;
+	u8 dummy;
+	u8 eep_val;
+	u8 io_bmap;
+	u8 config_alt_pins;
+	u8 io_default_val_bmap;
+	u8 config_alt_options;
+	u8 baud_h;
+	u8 baud_l;
+	u8 io_port_val_bmap;
+	u8 dummys[5];
+} __packed;
+
+struct mcp2200 {
+	struct hid_device *hdev;
+	struct mutex lock;
+	struct completion wait_in_report;
+	u8 gpio_dir;
+	u8 gpio_val;
+	u8 gpio_inval;
+	u8 baud_h;
+	u8 baud_l;
+	u8 config_alt_pins;
+	u8 gpio_reset_val;
+	u8 config_alt_options;
+	int status;
+	struct gpio_chip gc;
+	u8 hid_report[16];
+};
+
+/* this executes the READ_ALL cmd */
+static int mcp_cmd_read_all(struct mcp2200 *mcp)
+{
+	struct mcp_read_all *read_all;
+	int len, t;
+
+	reinit_completion(&mcp->wait_in_report);
+
+	mutex_lock(&mcp->lock);
+
+	read_all = (struct mcp_read_all *) mcp->hid_report;
+	read_all->cmd = READ_ALL;
+	len = hid_hw_output_report(mcp->hdev, (u8 *) read_all,
+				   sizeof(struct mcp_read_all));
+
+	mutex_unlock(&mcp->lock);
+
+	if (len != sizeof(struct mcp_read_all))
+		return -EINVAL;
+
+	t = wait_for_completion_timeout(&mcp->wait_in_report,
+					msecs_to_jiffies(4000));
+	if (!t)
+		return -ETIMEDOUT;
+
+	/* return status, negative value if wrong response was received */
+	return mcp->status;
+}
+
+static void mcp_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+			     unsigned long *bits)
+{
+	struct mcp2200 *mcp = gpiochip_get_data(gc);
+	u8 value;
+	int status;
+	struct mcp_set_clear_outputs *cmd;
+
+	mutex_lock(&mcp->lock);
+	cmd = (struct mcp_set_clear_outputs *) mcp->hid_report;
+
+	value = mcp->gpio_val & ~*mask;
+	value |= (*mask & *bits);
+
+	cmd->cmd = SET_CLEAR_OUTPUTS;
+	cmd->set_bmap = value;
+	cmd->clear_bmap = ~(value);
+
+	status = hid_hw_output_report(mcp->hdev, (u8 *) cmd,
+		       sizeof(struct mcp_set_clear_outputs));
+
+	if (status == sizeof(struct mcp_set_clear_outputs))
+		mcp->gpio_val = value;
+
+	mutex_unlock(&mcp->lock);
+}
+
+static void mcp_set(struct gpio_chip *gc, unsigned int gpio_nr, int value)
+{
+	unsigned long mask = 1 << gpio_nr;
+	unsigned long bmap_value = value << gpio_nr;
+
+	mcp_set_multiple(gc, &mask, &bmap_value);
+}
+
+static int mcp_get_multiple(struct gpio_chip *gc, unsigned long *mask,
+		unsigned long *bits)
+{
+	u32 val;
+	struct mcp2200 *mcp = gpiochip_get_data(gc);
+	int status;
+
+	status = mcp_cmd_read_all(mcp);
+	if (status)
+		return status;
+
+	val = mcp->gpio_inval;
+	*bits = (val & *mask);
+	return 0;
+}
+
+static int mcp_get(struct gpio_chip *gc, unsigned int gpio_nr)
+{
+	unsigned long mask = 0, bits = 0;
+
+	mask = (1 << gpio_nr);
+	mcp_get_multiple(gc, &mask, &bits);
+	return bits > 0;
+}
+
+static int mcp_get_direction(struct gpio_chip *gc, unsigned int gpio_nr)
+{
+	struct mcp2200 *mcp = gpiochip_get_data(gc);
+
+	return (mcp->gpio_dir & (MCP2200_DIR_IN << gpio_nr))
+		? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
+}
+
+static int mcp_set_direction(struct gpio_chip *gc, unsigned int gpio_nr,
+			     enum MCP_IO_DIR io_direction)
+{
+	struct mcp2200 *mcp = gpiochip_get_data(gc);
+	struct mcp_configure *conf;
+	int status;
+	/* after the configure cmd we will need to set the outputs again */
+	unsigned long mask = ~(mcp->gpio_dir); /* only set outputs */
+	unsigned long bits = mcp->gpio_val;
+	/* Offsets of alternative pins in config_alt_pins, 0 is not used */
+	u8 alt_pin_conf[8] = {SSPND, USBCFG, 0, 0, 0, 0, RXLED, TXLED};
+	u8 config_alt_pins = mcp->config_alt_pins;
+
+	/* Read in the reset baudrate first, we need it later */
+	status = mcp_cmd_read_all(mcp);
+	if (status != 0)
+		return status;
+
+	mutex_lock(&mcp->lock);
+	conf = (struct mcp_configure  *) mcp->hid_report;
+
+	/* configure will reset the chip! */
+	conf->cmd = CONFIGURE;
+	conf->io_bmap = (mcp->gpio_dir & ~(1 << gpio_nr))
+		| (io_direction << gpio_nr);
+	/* Don't overwrite the reset parameters */
+	conf->baud_h = mcp->baud_h;
+	conf->baud_l = mcp->baud_l;
+	conf->config_alt_options = mcp->config_alt_options;
+	conf->io_default_val_bmap = mcp->gpio_reset_val;
+	/* Adjust alt. func if necessary */
+	if (alt_pin_conf[gpio_nr])
+		config_alt_pins &= ~(1 << alt_pin_conf[gpio_nr]);
+	conf->config_alt_pins = config_alt_pins;
+
+	status = hid_hw_output_report(mcp->hdev, (u8 *) conf,
+				      sizeof(struct mcp_set_clear_outputs));
+
+	if (status == sizeof(struct mcp_set_clear_outputs)) {
+		mcp->gpio_dir = conf->io_bmap;
+		mcp->config_alt_pins = config_alt_pins;
+	} else {
+		mutex_unlock(&mcp->lock);
+		return -EIO;
+	}
+
+	mutex_unlock(&mcp->lock);
+
+	/* Configure CMD will clear all IOs -> rewrite them */
+	mcp_set_multiple(gc, &mask, &bits);
+	return 0;
+}
+
+static int mcp_direction_input(struct gpio_chip *gc, unsigned int gpio_nr)
+{
+	return mcp_set_direction(gc, gpio_nr, MCP2200_DIR_IN);
+}
+
+static int mcp_direction_output(struct gpio_chip *gc, unsigned int gpio_nr,
+				int value)
+{
+	int ret;
+	unsigned long mask, bmap_value;
+
+	mask = 1 << gpio_nr;
+	bmap_value = value << gpio_nr;
+
+	ret = mcp_set_direction(gc, gpio_nr, MCP2200_DIR_OUT);
+	if (!ret)
+		mcp_set_multiple(gc, &mask, &bmap_value);
+	return ret;
+}
+
+static const struct gpio_chip template_chip = {
+	.label			= "mcp2200",
+	.owner			= THIS_MODULE,
+	.get_direction		= mcp_get_direction,
+	.direction_input	= mcp_direction_input,
+	.direction_output	= mcp_direction_output,
+	.set			= mcp_set,
+	.set_multiple		= mcp_set_multiple,
+	.get			= mcp_get,
+	.get_multiple		= mcp_get_multiple,
+	.base			= -1,
+	.ngpio			= MCP_NGPIO,
+	.can_sleep		= true,
+};
+
+/*
+ * MCP2200 uses interrupt endpoint for input reports. This function
+ * is called by HID layer when it receives i/p report from mcp2200,
+ * which is actually a response to the previously sent command.
+ */
+static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
+		u8 *data, int size)
+{
+	struct mcp2200 *mcp = hid_get_drvdata(hdev);
+	struct mcp_read_all_resp *all_resp;
+
+	switch (data[0]) {
+	case READ_ALL:
+		all_resp = (struct mcp_read_all_resp *) data;
+		mcp->status = 0;
+		mcp->gpio_inval = all_resp->io_port_val_bmap;
+		mcp->baud_h = all_resp->baud_h;
+		mcp->baud_l = all_resp->baud_l;
+		mcp->gpio_reset_val = all_resp->io_default_val_bmap;
+		mcp->config_alt_pins = all_resp->config_alt_pins;
+		mcp->config_alt_options = all_resp->config_alt_options;
+		break;
+	default:
+		mcp->status = -EIO;
+		break;
+	}
+
+	complete(&mcp->wait_in_report);
+	return 0;
+}
+
+static int mcp2200_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct mcp2200 *mcp;
+
+	mcp = devm_kzalloc(&hdev->dev, sizeof(*mcp), GFP_KERNEL);
+	if (!mcp)
+		return -ENOMEM;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "can't parse reports\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "can't start hardware\n");
+		return ret;
+	}
+
+	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n", hdev->version >> 8,
+			hdev->version & 0xff, hdev->name, hdev->phys);
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "can't open device\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	mutex_init(&mcp->lock);
+	init_completion(&mcp->wait_in_report);
+	hid_set_drvdata(hdev, mcp);
+	mcp->hdev = hdev;
+
+	mcp->gc = template_chip;
+	mcp->gc.parent = &hdev->dev;
+
+	ret = devm_gpiochip_add_data(&hdev->dev, &mcp->gc, mcp);
+	if (ret < 0) {
+		hid_err(hdev, "Unable to register gpiochip\n");
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mcp2200_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id mcp2200_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_MCP2200) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, mcp2200_devices);
+
+static struct hid_driver mcp2200_driver = {
+	.name		= "mcp2200",
+	.id_table	= mcp2200_devices,
+	.probe		= mcp2200_probe,
+	.remove		= mcp2200_remove,
+	.raw_event	= mcp2200_raw_event,
+};
+
+/* Register with HID core */
+module_hid_driver(mcp2200_driver);
+
+MODULE_AUTHOR("Johannes Roith <johannes@gnu-linux.rocks>");
+MODULE_DESCRIPTION("MCP2200 Microchip HID USB to GPIO bridge");
+MODULE_LICENSE("GPL");
-- 
2.42.0

