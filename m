Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABE7903AC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350828AbjIAWhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjIAWhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD091;
        Fri,  1 Sep 2023 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693607819;
        bh=v+8hkqBSakqP2kZ/KXJw/X7W4OMieUUolqePbDQPA9A=;
        h=From:Date:Subject:To:Cc:From;
        b=ozYvazTHw0sphbDmbHG5K6xljSSKwgzAUihuftz4isEkNqX3REvTpSeTwNaHPUg59
         6rGU0TtQcoEIOvVv09A34Tm9EXBj8EFJBoMhwnuone1ymJb8Twq7A7m0wUMxTBYaFx
         93Fju13ExvJ2L/JPY/fjynGbdO0RSGdk7TS3cccs=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 02 Sep 2023 00:36:55 +0200
Subject: [PATCH v3] hwmon: add POWER-Z driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230902-powerz-v3-1-ed78d450c6c3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIZn8mQC/22MMRKCMBBFr8JsbRySGCFU3sOxgLCYbYDJYlAZ7
 m6gxfL9+e8twBgIGapsgYCRmIY+gT5l4HzdP1FQmxhUrnReainGYcbwFcq5xhZlXaIpIJ3HgB2
 999D9kdgTT0P47N0ot/WQiFJIkWtbWDTSdkbdZiRmdv7lzz1OsHWi+u+q5Bp3Vc7oFpv2cnDXd
 f0B3BC1C90AAAA=
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-usb@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693607819; l=13037;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v+8hkqBSakqP2kZ/KXJw/X7W4OMieUUolqePbDQPA9A=;
 b=SoJnmCm2r5WYtromwrmsr9/GSyPskWLLVlzdqgtzwjREYwaxwRpKe3LJC4eSNcBeS1zHpEx6Y
 Gu3PjaxJFP9CEARNcS8TkNnjLhYQLxszzwBPYmInj1q6aWSKRnpQ86u
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
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
 Documentation/hwmon/powerz.rst |  27 ++++
 MAINTAINERS                    |   7 +
 drivers/hwmon/Kconfig          |  10 ++
 drivers/hwmon/Makefile         |   1 +
 drivers/hwmon/powerz.c         | 288 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 334 insertions(+)

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
index 000000000000..530fff68ca6e
--- /dev/null
+++ b/Documentation/hwmon/powerz.rst
@@ -0,0 +1,27 @@
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
diff --git a/MAINTAINERS b/MAINTAINERS
index fcbb106aaa57..153c6fe0a725 100644
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
index 000000000000..6209339e5414
--- /dev/null
+++ b/drivers/hwmon/powerz.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
+#define DRIVER_NAME	"powerz"
+#define POWERZ_EP_CMD_OUT	0x01
+#define POWERZ_EP_DATA_IN	0x81
+
+/* as printed on the device itself */
+#define POWERZ_MAX_VOLTAGE	50000
+#define POWERZ_MAX_CURRENT	6000
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
+			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_AVERAGE |
+			   HWMON_I_MIN | HWMON_I_MAX,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_AVERAGE |
+			   HWMON_C_MIN | HWMON_I_MAX),
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
+	if (type == hwmon_curr && attr == hwmon_curr_label) {
+		*str = "IBUS";
+	} else if (type == hwmon_in && attr == hwmon_in_label) {
+		if (channel == 0)
+			*str = "VBUS";
+		else if (type == hwmon_in && attr == hwmon_in_label && channel == 1)
+			*str = "VCC1";
+		else if (type == hwmon_in && attr == hwmon_in_label && channel == 2)
+			*str = "VCC2";
+		else if (type == hwmon_in && attr == hwmon_in_label && channel == 3)
+			*str = "VDP";
+		else if (type == hwmon_in && attr == hwmon_in_label && channel == 4)
+			*str = "VDM";
+		else if (type == hwmon_in && attr == hwmon_in_label && channel == 5)
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
+	lockdep_assert_held(&priv->mutex);
+
+	priv->status = -ETIMEDOUT;
+	reinit_completion(&priv->completion);
+
+	priv->transfer_buffer[0] = 0x0c;
+	priv->transfer_buffer[1] = 0x00;
+	priv->transfer_buffer[2] = 0x02;
+	priv->transfer_buffer[3] = 0x00;
+
+	usb_fill_bulk_urb(priv->urb, udev, usb_sndbulkpipe(udev, POWERZ_EP_CMD_OUT),
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
+		return -EIO; /* disconnected */
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
+		else if (attr == hwmon_curr_min)
+			*val = -POWERZ_MAX_CURRENT;
+		else if (attr == hwmon_curr_max)
+			*val = POWERZ_MAX_CURRENT;
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
+		} else if (attr == hwmon_in_min && channel == 0) {
+			*val = -POWERZ_MAX_VOLTAGE;
+		} else if (attr == hwmon_in_max && channel == 0) {
+			*val = POWERZ_MAX_VOLTAGE;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
+		*val =
+		    ((long)data->temp[1]) * 2000 +
+		    ((long)data->temp[0]) * 1000 / 128;
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
base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
change-id: 20230831-powerz-2ccb978a8e57

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

