Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76137905F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350073AbjIBHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351831AbjIBHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:47:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23EE1990;
        Sat,  2 Sep 2023 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693640823;
        bh=kuL19AUN3p9jZFs6r0T6c7FaWnXvfHqd+zQXZddevj8=;
        h=From:Date:Subject:To:Cc:From;
        b=AKUKKGGntZt209kQuiS3ciD5+i3ij6Q5dhQ0HCe8Hxl4wlACmDFd8ZvxPcPF7eLq7
         cWy8FjiM3ZLfcMAz61CkLUhHe+FUJM7uqs4i/AIFzr1k24Z1GDzmrWcXxtht5GHOT1
         eM1fKwaayIUPMT2z/lK/obd+c7GaIiqBrozTQGBk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 02 Sep 2023 09:47:01 +0200
Subject: [PATCH v4] hwmon: add POWER-Z driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHTo8mQC/23MzRKCIBSG4VtxWEfDjwi06j6aFgrHYKMOGFaO9
 x66qIUuvzPneWcUIXiI6FLMKEDy0fddHuWpQMbV3QOwt3kjRhgnilM89BOED2bGNFqqWoGQKD8
 PAVr/2kK3e97Ox7EP762b6HrdJRLFFBOupQZBdSvYdQIfYzTu6c4djGjtJHZsWbbCVMwIbqGx5
 aHlf6sJ+1meLVipbCmIqQzf2WVZvuQp7gYZAQAA
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-usb@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693640822; l=12685;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kuL19AUN3p9jZFs6r0T6c7FaWnXvfHqd+zQXZddevj8=;
 b=SP1KNY3bsaorvAq84HpHo2n25kPUIi5nfNy1zZyUgVG+CLYOIqe/5ZubHqv0oIIIAURmSFLXo
 tb/2E6d7b4XCK+0C+L6a/rbUC51ttLOXiBbXPGE6I0+UFCAnMA56E4S
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

POWER-Z is a series of devices to monitor power characteristics of
USB-C connections and display those on a on-device display.
Some of the devices, notably KM002C and KM003C, contain an additional
port which exposes the measurements via USB.

This is a driver for this monitor port.

It was developed and tested with the KM003C.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v4:
- address Guenters review comments
  - drop lockdep annotations
  - drop unnecessary priv->status assignment
  - drop constant min/max reporting
  - drop unnecessary typecasts around temp
- drop redundant comparisions in read() callbacks
- Link to v3: https://lore.kernel.org/r/20230902-powerz-v3-1-ed78d450c6c3@weissschuh.net

Changes in v3:
- CC linux-usb list
- address Guenters review comments
  - simplify hwmon chip name
  - drop member "intf" from struct powerz_priv
  - use devm-APIs
  - return EOPNOTSUPP for invalid channels
  - rework if-else chaining in read functions
  - integrate transfer context into struct powerz_priv
  - simplify logic and return value of powerz_read_data
  - fix naming of struct powerz_sensor_data members
  - explicitly include all necessary header files
  - add doc
- simplify URB completion callbacks a bit
- fix indentation
- add support for VDD channel
- add support for VBUS/IBUS min/max as printed on the device itself
- allocate single URB as part of struct powerz_priv
- kill in-flight URBs on disconnect
- Link to v2: https://lore.kernel.org/r/20230831-powerz-v2-1-5c62c53debd4@weissschuh.net

Changes in v2:
- fix syntax error in Kconfig
- avoid double free of urb in case of failure
- Link to v1: https://lore.kernel.org/r/20230831-powerz-v1-1-03979e519f52@weissschuh.net
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/powerz.rst |  30 +++++
 MAINTAINERS                    |   7 ++
 drivers/hwmon/Kconfig          |  10 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/powerz.c         | 269 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 318 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 88dadea85cfc..10a54644557d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -178,6 +178,7 @@ Hardware Monitoring Kernel Drivers
    peci-cputemp
    peci-dimmtemp
    pmbus
+   powerz
    powr1220
    pxe1610
    pwm-fan
diff --git a/Documentation/hwmon/powerz.rst b/Documentation/hwmon/powerz.rst
new file mode 100644
index 000000000000..317084e0b76b
--- /dev/null
+++ b/Documentation/hwmon/powerz.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver POWERZ
+====================
+
+Supported chips:
+
+  * ChargerLAB POWER-Z KM003C
+
+    Prefix: 'powerz'
+
+    Addresses scanned: -
+
+Author:
+
+  - Thomas Weißschuh <linux@weissschuh.net>
+
+Description
+-----------
+
+This driver implements support for the ChargerLAB POWER-Z USB-C power testing
+family.
+
+The device communicates with the custom protocol over USB.
+
+The channel labels exposed via hwmon match the labels used by the on-device
+display and the official POWER-Z PC software.
+
+As current can flow in both directions through the tester the sign of the
+channel "curr1_input" (label "IBUS") indicates the direction.
diff --git a/MAINTAINERS b/MAINTAINERS
index 29a3fd26017c..3a815980b03a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4795,6 +4795,13 @@ X:	drivers/char/ipmi/
 X:	drivers/char/random.c
 X:	drivers/char/tpm/
 
+CHARGERLAB POWER-Z HARDWARE MONITOR DRIVER
+M:	Thomas Weißschuh <linux@weissschuh.net>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/powerz.rst
+F:	drivers/hwmon/powerz.c
+
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..12af9f9cfd9f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -839,6 +839,16 @@ config SENSORS_JC42
 	  This driver can also be built as a module. If so, the module
 	  will be called jc42.
 
+config SENSORS_POWERZ
+	tristate "ChargerLAB POWER-Z USB-C tester"
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
index 000000000000..a764b128f6d1
--- /dev/null
+++ b/drivers/hwmon/powerz.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
+#define DRIVER_NAME	"powerz"
+#define POWERZ_EP_CMD_OUT	0x01
+#define POWERZ_EP_DATA_IN	0x81
+
+struct powerz_sensor_data {
+	u8 _unknown_1[8];
+	__le32 V_bus;
+	__le32 I_bus;
+	__le32 V_bus_avg;
+	__le32 I_bus_avg;
+	u8 _unknown_2[8];
+	u8 temp[2];
+	__le16 V_cc1;
+	__le16 V_cc2;
+	__le16 V_dp;
+	__le16 V_dm;
+	__le16 V_dd;
+	u8 _unknown_3[4];
+} __packed;
+
+struct powerz_priv {
+	char transfer_buffer[64];	/* first member to satisfy DMA alignment */
+	struct mutex mutex;
+	struct completion completion;
+	struct urb *urb;
+	int status;
+};
+
+static const struct hwmon_channel_info *const powerz_info[] = {
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_AVERAGE,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_AVERAGE),
+	    HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
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
+	if (type == hwmon_curr && attr == hwmon_curr_label) {
+		*str = "IBUS";
+	} else if (type == hwmon_in && attr == hwmon_in_label) {
+		if (channel == 0)
+			*str = "VBUS";
+		else if (channel == 1)
+			*str = "VCC1";
+		else if (channel == 2)
+			*str = "VCC2";
+		else if (channel == 3)
+			*str = "VDP";
+		else if (channel == 4)
+			*str = "VDM";
+		else if (channel == 5)
+			*str = "VDD";
+		else
+			return -EOPNOTSUPP;
+	} else if (type == hwmon_temp && attr == hwmon_temp_label) {
+		*str = "TEMP";
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static void powerz_usb_data_complete(struct urb *urb)
+{
+	struct powerz_priv *priv = urb->context;
+
+	complete(&priv->completion);
+}
+
+static void powerz_usb_cmd_complete(struct urb *urb)
+{
+	struct powerz_priv *priv = urb->context;
+
+	usb_fill_bulk_urb(urb, urb->dev,
+			  usb_rcvbulkpipe(urb->dev, POWERZ_EP_DATA_IN),
+			  priv->transfer_buffer, sizeof(priv->transfer_buffer),
+			  powerz_usb_data_complete, priv);
+
+	priv->status = usb_submit_urb(urb, GFP_ATOMIC);
+	if (priv->status)
+		complete(&priv->completion);
+}
+
+static int powerz_read_data(struct usb_device *udev, struct powerz_priv *priv)
+{
+	int ret;
+
+	reinit_completion(&priv->completion);
+
+	priv->transfer_buffer[0] = 0x0c;
+	priv->transfer_buffer[1] = 0x00;
+	priv->transfer_buffer[2] = 0x02;
+	priv->transfer_buffer[3] = 0x00;
+
+	usb_fill_bulk_urb(priv->urb, udev,
+			  usb_sndbulkpipe(udev, POWERZ_EP_CMD_OUT),
+			  priv->transfer_buffer, 4, powerz_usb_cmd_complete,
+			  priv);
+	ret = usb_submit_urb(priv->urb, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_interruptible_timeout
+	    (&priv->completion, msecs_to_jiffies(5))) {
+		usb_kill_urb(priv->urb);
+		return -EIO;
+	}
+
+	if (priv->urb->actual_length < sizeof(struct powerz_sensor_data))
+		return -EIO;
+
+	return priv->status;
+}
+
+static int powerz_read(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long *val)
+{
+	struct usb_interface *intf = to_usb_interface(dev->parent);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct powerz_priv *priv = usb_get_intfdata(intf);
+	struct powerz_sensor_data *data;
+	int ret;
+
+	if (!priv)
+		return -EIO;	/* disconnected */
+
+	mutex_lock(&priv->mutex);
+	ret = powerz_read_data(udev, priv);
+	if (ret)
+		goto out;
+
+	data = (struct powerz_sensor_data *)priv->transfer_buffer;
+
+	if (type == hwmon_curr) {
+		if (attr == hwmon_curr_input)
+			*val = ((s32)le32_to_cpu(data->I_bus)) / 1000;
+		else if (attr == hwmon_curr_average)
+			*val = ((s32)le32_to_cpu(data->I_bus_avg)) / 1000;
+		else
+			ret = -EOPNOTSUPP;
+	} else if (type == hwmon_in) {
+		if (attr == hwmon_in_input) {
+			if (channel == 0)
+				*val = le32_to_cpu(data->V_bus) / 1000;
+			else if (channel == 1)
+				*val = le16_to_cpu(data->V_cc1) / 10;
+			else if (channel == 2)
+				*val = le16_to_cpu(data->V_cc2) / 10;
+			else if (channel == 3)
+				*val = le16_to_cpu(data->V_dp) / 10;
+			else if (channel == 4)
+				*val = le16_to_cpu(data->V_dm) / 10;
+			else if (channel == 5)
+				*val = le16_to_cpu(data->V_dd) / 10;
+			else
+				ret = -EOPNOTSUPP;
+		} else if (attr == hwmon_in_average && channel == 0) {
+			*val = le32_to_cpu(data->V_bus_avg) / 1000;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
+		*val = data->temp[1] * 2000 + data->temp[0] * 1000 / 128;
+	} else {
+		ret = -EOPNOTSUPP;
+	}
+
+out:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+
+static const struct hwmon_ops powerz_hwmon_ops = {
+	.is_visible = powerz_is_visible,
+	.read = powerz_read,
+	.read_string = powerz_read_string,
+};
+
+static const struct hwmon_chip_info powerz_chip_info = {
+	.ops = &powerz_hwmon_ops,
+	.info = powerz_info,
+};
+
+static int powerz_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)
+{
+	struct powerz_priv *priv;
+	struct device *hwmon_dev;
+	struct device *parent;
+
+	parent = &intf->dev;
+
+	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!priv->urb)
+		return -ENOMEM;
+	mutex_init(&priv->mutex);
+	priv->status = -ETIMEDOUT;
+	init_completion(&priv->completion);
+
+	hwmon_dev =
+	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
+						 &powerz_chip_info, NULL);
+	usb_set_intfdata(intf, priv);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static void powerz_disconnect(struct usb_interface *intf)
+{
+	struct powerz_priv *priv = usb_get_intfdata(intf);
+
+	mutex_lock(&priv->mutex);
+	usb_kill_urb(priv->urb);
+	usb_free_urb(priv->urb);
+	mutex_unlock(&priv->mutex);
+}
+
+static const struct usb_device_id powerz_id_table[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(0x5FC9, 0x0063, 0x00) },	/* ChargerLAB POWER-Z KM003C */
+	{ }
+};
+
+MODULE_DEVICE_TABLE(usb, powerz_id_table);
+
+static struct usb_driver powerz_driver = {
+	.name = DRIVER_NAME,
+	.id_table = powerz_id_table,
+	.probe = powerz_probe,
+	.disconnect = powerz_disconnect,
+};
+
+module_usb_driver(powerz_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_DESCRIPTION("ChargerLAB POWER-Z USB-C tester");

---
base-commit: bd30fe6a7d9b72e73c5ac9109cbc3066dde08034
change-id: 20230831-powerz-2ccb978a8e57

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

