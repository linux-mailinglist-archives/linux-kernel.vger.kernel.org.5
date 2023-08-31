Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556C978E8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbjHaIpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbjHaIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:45:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13362CE7;
        Thu, 31 Aug 2023 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693471525;
        bh=TOpHrg+THcLjDGrTsyHrj4Fe/3SIuVeJALTfT8X71I0=;
        h=From:Date:Subject:To:Cc:From;
        b=pfg1mULBM51414DN6H6SAo+iDSXQ6WNEjWg85FUSwg6DgmfYjL3r2SOyBPv9ynh8N
         Z97xOfOpEEqdZjsTqPgRUUXa7mTE0lC7xYinkwvD45o1y2PxGj/uuG3G76DIIV4IFP
         jg/H58GndOOLN3r+cJRV7A/+I5LtyXV+wka0wDb4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 31 Aug 2023 10:44:48 +0200
Subject: [PATCH] hwmon: add POWER-Z driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230831-powerz-v1-1-03979e519f52@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAP9S8GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC2ND3YL88tSiKl2j5OQkS3OLRItUU3MloOKCotS0zAqwQdGxtbUAfPg
 X61gAAAA=
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693471524; l=10059;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=TOpHrg+THcLjDGrTsyHrj4Fe/3SIuVeJALTfT8X71I0=;
 b=hyCLX2cfHW5yCX7NKzClmr8fP4PwHpiMP7RJYItFAjlrtSHUwbBPioPZQ8E8JIuz6lyCxJ4AG
 IgRuV1TQBykDkFAIdiAnaiA9bXRyCOINu225U15Vpf5f+LiV31VWO2V
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER-Z is a series of devices to monitor power characteristics of USB-C
connections and display those on a on-device display.
Some of the devices, notably KM002C and KM003C, contain an additional
port which exposes the measurements via USB.

This is a driver for this monitor port.

It was developed and tested with the KM003C.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 MAINTAINERS            |   6 ++
 drivers/hwmon/Kconfig  |  10 ++
 drivers/hwmon/Makefile |   1 +
 drivers/hwmon/powerz.c | 258 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e3419c04f27..12bcf14597c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4795,6 +4795,12 @@ X:	drivers/char/ipmi/
 X:	drivers/char/random.c
 X:	drivers/char/tpm/
 
+CHARGERLAB POWER-Z HARDWARE MONITOR DRIVER
+M:	Thomas Weißschuh <linux@weissschuh.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/powerz.c
+
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..a055f9cdef16 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -839,6 +839,16 @@ config SENSORS_JC42
 	  This driver can also be built as a module. If so, the module
 	  will be called jc42.
 
+config SENSORS_POWERZ
+	tristate "ChargerLAB POWER-Z USB-C tester");
+	depends on USB
+	help
+	  If you say yes here you get support for ChargerLAB POWER-Z series of
+	  USB-C charging testers.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called powerz.
+
 config SENSORS_POWR1220
 	tristate "Lattice POWR1220 Power Monitoring"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4ac9452b5430..019189500e5d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -176,6 +176,7 @@ obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
new file mode 100644
index 000000000000..898ab4c2516d
--- /dev/null
+++ b/drivers/hwmon/powerz.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/completion.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#define DRIVER_NAME	"powerz"
+#define POWERZ_EP_CMD_OUT	0x01
+#define POWERZ_EP_DATA_IN	0x81
+
+struct powerz_sensor_data {
+	u8 _unknown_1[8];
+	__le32 Vbus;
+	__le32 Ibus;
+	__le32 Vbus_avg;
+	__le32 Ibus_avg;
+	u8 _unknown_2[8];
+	u8 temp[2];
+	__le16 cc1;
+	__le16 cc2;
+	__le16 dp;
+	__le16 dm;
+	u8 _unknown_3[6];
+} __packed;
+
+struct powerz_priv {
+	struct device *hwmon_dev;
+	struct usb_interface *intf;
+};
+
+static const struct hwmon_channel_info * const powerz_info[] = {
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_AVERAGE,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_AVERAGE),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static umode_t powerz_is_visible(const void *data, enum hwmon_sensor_types type,
+				 u32 attr, int channel)
+{
+	return 0444;
+}
+
+static int powerz_read_string(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, const char **str)
+{
+	if (type == hwmon_curr && attr == hwmon_curr_label)
+		*str = "bus";
+	else if (type == hwmon_in && attr == hwmon_in_label && channel == 0)
+		*str = "bus";
+	else if (type == hwmon_in && attr == hwmon_in_label && channel == 1)
+		*str = "cc1";
+	else if (type == hwmon_in && attr == hwmon_in_label && channel == 2)
+		*str = "cc2";
+	else if (type == hwmon_in && attr == hwmon_in_label && channel == 3)
+		*str = "dp";
+	else if (type == hwmon_in && attr == hwmon_in_label && channel == 4)
+		*str = "dm";
+	else if (type == hwmon_temp && attr == hwmon_temp_label)
+		*str = "temp";
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+struct powerz_usb_ctx {
+	char transfer_buffer[64];
+	struct completion completion;
+	int status;
+};
+
+static void powerz_usb_data_complete(struct urb *urb)
+{
+	struct powerz_usb_ctx *ctx = urb->context;
+
+	ctx->status = 0;
+	complete(&ctx->completion);
+}
+
+static void powerz_usb_cmd_complete(struct urb *urb)
+{
+	struct powerz_usb_ctx *ctx = urb->context;
+	int ret;
+
+	usb_fill_bulk_urb(urb, urb->dev, usb_rcvbulkpipe(urb->dev, POWERZ_EP_DATA_IN),
+			  ctx->transfer_buffer, sizeof(ctx->transfer_buffer),
+			  powerz_usb_data_complete, ctx);
+
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret) {
+		usb_free_urb(urb);
+		ctx->status = ret;
+		complete(&ctx->completion);
+	}
+}
+
+static struct powerz_sensor_data *powerz_read_data(struct usb_device *udev,
+						   struct powerz_usb_ctx *ctx)
+{
+	struct urb *urb;
+	int r;
+
+	ctx->status = -ETIMEDOUT;
+	init_completion(&ctx->completion);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->transfer_buffer[0] = 0x0c;
+	ctx->transfer_buffer[1] = 0x00;
+	ctx->transfer_buffer[2] = 0x02;
+	ctx->transfer_buffer[3] = 0x00;
+
+	usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, POWERZ_EP_CMD_OUT),
+			  ctx->transfer_buffer, 4, powerz_usb_cmd_complete, ctx);
+	r = usb_submit_urb(urb, GFP_KERNEL);
+	if (r) {
+		usb_free_urb(urb);
+		return ERR_PTR(r);
+	}
+
+	if (!wait_for_completion_interruptible_timeout(&ctx->completion, msecs_to_jiffies(5))) {
+		usb_kill_urb(urb);
+		usb_free_urb(urb);
+		return ERR_PTR(-EIO);
+	}
+
+	if (ctx->status) {
+		usb_free_urb(urb);
+		return ERR_PTR(ctx->status);
+	}
+
+	if (urb->actual_length < (sizeof(struct powerz_sensor_data))) {
+		usb_free_urb(urb);
+		return ERR_PTR(-EIO);
+	}
+
+	usb_free_urb(urb);
+	return (struct powerz_sensor_data *)(ctx->transfer_buffer);
+}
+
+static int powerz_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+		       int channel, long *val)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct powerz_sensor_data *data;
+	struct powerz_usb_ctx *ctx;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	data = powerz_read_data(udev, ctx);
+	if (IS_ERR(data)) {
+		kfree(ctx);
+		return PTR_ERR(data);
+	}
+
+	if (type == hwmon_curr && attr == hwmon_curr_input)
+		*val =  ((s32)le32_to_cpu(data->Ibus)) / 1000;
+	else if (type == hwmon_curr && attr == hwmon_curr_average)
+		*val =  ((s32)le32_to_cpu(data->Ibus_avg)) / 1000;
+	else if (type == hwmon_in && attr == hwmon_in_input && channel == 0)
+		*val =  le32_to_cpu(data->Vbus) / 1000;
+	else if (type == hwmon_in && attr == hwmon_in_average && channel == 0)
+		*val =  le32_to_cpu(data->Vbus_avg) / 1000;
+	else if (type == hwmon_in && attr == hwmon_in_input && channel == 1)
+		*val =  le16_to_cpu(data->cc1) / 10;
+	else if (type == hwmon_in && attr == hwmon_in_input && channel == 2)
+		*val =  le16_to_cpu(data->cc2) / 10;
+	else if (type == hwmon_in && attr == hwmon_in_input && channel == 3)
+		*val =  le16_to_cpu(data->dp) / 10;
+	else if (type == hwmon_in && attr == hwmon_in_input && channel == 4)
+		*val =  le16_to_cpu(data->dm) / 10;
+	else if (type == hwmon_temp && attr == hwmon_temp_input)
+		*val = ((long)data->temp[1]) * 2000 + ((long)data->temp[0]) * 1000 / 128;
+	else
+		return -EINVAL;
+
+	kfree(ctx);
+
+	return 0;
+}
+
+static const struct hwmon_ops powerz_hwmon_ops = {
+	.is_visible  = powerz_is_visible,
+	.read        = powerz_read,
+	.read_string = powerz_read_string,
+};
+
+static const struct hwmon_chip_info powerz_chip_info = {
+	.ops  = &powerz_hwmon_ops,
+	.info = powerz_info,
+};
+
+static int powerz_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct powerz_priv *priv;
+	struct device *parent;
+	const char *name;
+	int ret;
+
+	parent = &intf->dev;
+
+	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	name = devm_hwmon_sanitize_name(parent, udev->product ?: DRIVER_NAME);
+	priv->hwmon_dev = hwmon_device_register_with_info(parent, name,
+							  priv,
+							  &powerz_chip_info,
+							  NULL);
+	ret = PTR_ERR_OR_ZERO(priv->hwmon_dev);
+	priv->intf = intf;
+	usb_set_intfdata(intf, priv);
+
+	return ret;
+}
+
+static void powerz_disconnect(struct usb_interface *intf)
+{
+	struct powerz_priv *priv = usb_get_intfdata(intf);
+
+	hwmon_device_unregister(priv->hwmon_dev);
+}
+
+static const struct usb_device_id powerz_id_table[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) }, /* ChargerLAB POWER-Z KM003C */
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, powerz_id_table);
+
+static struct usb_driver powerz_driver = {
+	.name       = DRIVER_NAME,
+	.id_table   = powerz_id_table,
+	.probe      = powerz_probe,
+	.disconnect = powerz_disconnect,
+};
+module_usb_driver(powerz_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_DESCRIPTION("ChargerLAB POWER-Z USB-C tester");

---
base-commit: b97d64c722598ffed42ece814a2cb791336c6679
change-id: 20230831-powerz-2ccb978a8e57

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

