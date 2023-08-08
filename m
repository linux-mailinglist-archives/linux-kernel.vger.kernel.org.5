Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551C7735F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHHBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjHHBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:32:51 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939091BC1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:32:27 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 68AFC2C023C;
        Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1691458343;
        bh=odut2rMybDUaZwiPlXJk/jPXgTPLSa53DePx4z5p/hs=;
        h=From:To:Cc:Subject:Date:From;
        b=BvZYiafPFnXHdRPanRiCO1KOgc/lfBA+CAAwzgk58AsILf3fCAr7ahZgbe3QvEWU4
         27z7PYDx9BY8kFgdnUzthXgU9A5I7v7jRvoGaKcolzZ44Y6HqfhkkJIDcrFFxoZOOa
         GKgm8aEGuxHgGWgm2ZF8VGsFoHIeY4Y/rptV7c6kfaKfRdQppHWM0AaCH0UT0JViYa
         mcDEY5GNTWdgFRakxT+6ldwSJ77n/I4uJt87xp4o2Qb7NaH7cI9TFw2M0jFm3iKXk2
         f40WTfW23VLOUGjqt80dK1dw8H0yJA/ouaXK+WESNLJJ2h/gDUAWWTfPDXWDLf924D
         St4u/daosoN3w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64d19b270000>; Tue, 08 Aug 2023 13:32:23 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.10])
        by pat.atlnz.lc (Postfix) with ESMTP id 43A4F13ED7B;
        Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 4702644495; Tue,  8 Aug 2023 13:32:23 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 1/2] hwmon: Add driver for EMC181x temperature sensors
Date:   Tue,  8 Aug 2023 13:31:56 +1200
Message-ID: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=boIy+3Si c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=UttIx32zK-AA:10 a=X7RGDZ3zAAAA:8 a=BH4MrEww_7vcI7yO7vkA:9 a=gtnApEKZh2gql3vmNaCt:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a HWMON driver for the EMC1812, EMC1813, EMC1814,
EMC1815 and EMC1833 temperature sensor chips from microchip. Does not
currently support the alert outputs.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Co-developed-by: Mathew McBride <matt@traverse.com.au>
Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 drivers/hwmon/Kconfig   |  10 ++
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/emc181x.c | 296 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 drivers/hwmon/emc181x.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 307477b8a371..196d91494536 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1820,6 +1820,16 @@ config SENSORS_EMC1403
 	  Threshold values can be configured using sysfs.
 	  Data from the different diodes are accessible via sysfs.
=20
+config SENSORS_EMC181X
+	tristate "SMSC EMC181X thermal sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the SMSC EMC181X
+	  temperature monitoring chip.
+
+	  Data from the different diodes are accessible via sysfs.
+
 config SENSORS_EMC2103
 	tristate "SMSC EMC2103"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3f4b0fda0998..bcea887dfe17 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_SENSORS_DRIVETEMP)	+=3D drivetemp.o
 obj-$(CONFIG_SENSORS_DS620)	+=3D ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+=3D emc1403.o
+obj-$(CONFIG_SENSORS_EMC181X)	+=3D emc181x.o
 obj-$(CONFIG_SENSORS_EMC2103)	+=3D emc2103.o
 obj-$(CONFIG_SENSORS_EMC2305)	+=3D emc2305.o
 obj-$(CONFIG_SENSORS_EMC6W201)	+=3D emc6w201.o
diff --git a/drivers/hwmon/emc181x.c b/drivers/hwmon/emc181x.c
new file mode 100644
index 000000000000..364d2bfb15ca
--- /dev/null
+++ b/drivers/hwmon/emc181x.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip/SMSC EMC181x Temperature monitor
+ *
+ * Copyright (C) 2018-2019 Traverse Technologies
+ * Author: Mathew McBride <matt@traverse.com.au>
+ *
+ * Copyright (C) 2023 Allied Telesis Labs
+ * Author: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/of_device.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define EMC1812_ID	0x81
+#define EMC1813_ID	0x87
+#define EMC1814_ID	0x84
+#define EMC1815_ID	0x85
+#define EMC1833_ID	0x83
+
+#define MICROCHIP_ID	0x54
+
+#define EMC181X_STATUS_REG	0x02
+#define EMC181X_CONFIG_REG	0x03
+#define EMC181X_DIODE_DATA_BASE	0x60
+#define EMC181X_PID_REG		0xfd
+#define EMC181X_SMSC_ID_REG	0xfe
+#define EMC181X_REVISION_REG	0xff
+
+/* Adjustable address type is 0x7c, 0x5c, 0x4c, 0x6c, 0x1c, 0x3c */
+/* Fixed address is either 0x4c or 0x45 */
+static const unsigned short emc181x_address_list[] =3D {
+	0x7c, 0x5c, 0x4c, 0x6c, 0x1c, 0x3c, 0x45, I2C_CLIENT_END
+};
+
+enum chips {
+	emc1812, emc1813,
+	emc1814, emc1815,
+	emc1833,
+};
+
+struct emc181x_data {
+	struct i2c_client *i2c;
+	enum chips type;
+	bool is_extended_range;
+};
+
+static int emc181x_read(struct device *dev, enum hwmon_sensor_types type=
,
+			u32 attr, int channel, long *val)
+{
+	struct emc181x_data *data =3D dev_get_drvdata(dev);
+	struct i2c_client *i2c =3D data->i2c;
+
+	u8 channel_reg =3D 0;
+	s32 channel_deg =3D 0;
+	s32 channel_frac =3D 0;
+
+	if (type !=3D hwmon_temp)
+		return -EOPNOTSUPP;
+	if (channel > 4)
+		return -EINVAL;
+
+	channel_reg =3D EMC181X_DIODE_DATA_BASE + (channel * 0x02);
+	channel_deg =3D i2c_smbus_read_byte_data(i2c, channel_reg);
+	if (channel_deg < 0)
+		return channel_deg;
+	if (data->is_extended_range)
+		channel_deg -=3D 64;
+
+	channel_frac =3D i2c_smbus_read_byte_data(i2c, channel_reg + 0x01);
+	if (channel_frac < 0)
+		return channel_frac;
+
+	*val =3D ((channel_deg << 3) | (channel_frac >> 5)) * 125;
+	return 0;
+}
+
+static umode_t emc181x_is_visible(const void *drvdata, enum hwmon_sensor=
_types type,
+				  u32 attr, int channel)
+{
+	if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_input)
+		return 0444;
+	else
+		return 0;
+}
+
+static const struct hwmon_channel_info *emc1812_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_channel_info *emc1813_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_channel_info *emc1814_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT,
+			   HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_channel_info *emc1815_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT,
+			   HWMON_T_INPUT, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops emc181x_ops =3D {
+	.is_visible =3D emc181x_is_visible,
+	.read =3D emc181x_read,
+};
+
+static const struct hwmon_chip_info emc181x_chip_info[] =3D {
+	[emc1812] =3D {
+		.ops =3D &emc181x_ops,
+		.info =3D emc1812_info,
+	},
+	[emc1813] =3D {
+		.ops =3D &emc181x_ops,
+		.info =3D emc1813_info,
+	},
+	[emc1814] =3D {
+		.ops =3D &emc181x_ops,
+		.info =3D emc1814_info,
+	},
+	[emc1815] =3D {
+		.ops =3D &emc181x_ops,
+		.info =3D emc1815_info,
+	},
+	[emc1833] =3D {
+		.ops =3D &emc181x_ops,
+		.info =3D emc1813_info,
+	},
+};
+
+static const struct i2c_device_id emc181x_i2c_id[] =3D {
+	{ "emc1812", emc1812 },
+	{ "emc1813", emc1813 },
+	{ "emc1814", emc1814 },
+	{ "emc1815", emc1815 },
+	{ "emc1833", emc1833 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, emc181x_i2c_id);
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int emc181x_i2c_detect(struct i2c_client *client,
+		       struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter =3D client->adapter;
+	int pid, id, rev;
+	const char *name;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	/* Determine the chip type */
+	id =3D i2c_smbus_read_byte_data(client, EMC181X_SMSC_ID_REG);
+	if (id < 0)
+		return id;
+	if (id !=3D MICROCHIP_ID)
+		return -ENODEV;
+	pid =3D i2c_smbus_read_byte_data(client, EMC181X_PID_REG);
+	if (pid < 0)
+		return pid;
+	rev =3D i2c_smbus_read_byte_data(client, EMC181X_REVISION_REG);
+	if (rev < 0)
+		return rev;
+
+	switch (pid) {
+	case EMC1812_ID:
+		name =3D emc181x_i2c_id[emc1812].name;
+		break;
+	case EMC1813_ID:
+		name =3D emc181x_i2c_id[emc1813].name;
+		break;
+	case EMC1814_ID:
+		name =3D emc181x_i2c_id[emc1814].name;
+		break;
+	case EMC1815_ID:
+		name =3D emc181x_i2c_id[emc1815].name;
+		break;
+	case EMC1833_ID:
+		name =3D emc181x_i2c_id[emc1833].name;
+		break;
+	default:
+		return -ENODEV;
+	}
+	strscpy(info->type, name, I2C_NAME_SIZE);
+
+	dev_dbg(&client->dev,
+		"Detected device %s at 0x%02x with COMPANY: 0x%02x and PID: 0x%02x REV=
: 0x%02x\n",
+		name, client->addr, id, pid, rev);
+
+	return 0;
+}
+
+static int emc181x_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct device *hwmon_dev;
+	struct emc181x_data *data;
+	s32 regval;
+	u8 config;
+
+	data =3D devm_kzalloc(dev, sizeof(struct emc181x_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->i2c =3D client;
+	if (dev_fwnode(dev)) {
+		data->type =3D (enum chips)device_get_match_data(dev);
+		data->is_extended_range =3D device_property_present(dev, "emc181x,exte=
nded-range");
+	} else
+		data->type =3D i2c_match_id(emc181x_i2c_id, client)->driver_data;
+
+	regval =3D i2c_smbus_read_byte_data(client, EMC181X_CONFIG_REG);
+	if (regval < 0) {
+		dev_dbg(dev, "Failed to read config reg %d", regval);
+		return regval;
+	}
+
+	/* By default, extended range is disabled in the EMC181X,
+	 * if enabled we need to set this in the CONFIG register.
+	 */
+	config =3D regval & ~0x04;
+	if (data->is_extended_range)
+		config |=3D 0x04;
+
+	dev_dbg(dev, "EMC181X setting CONFIG to %d\n", config);
+	if (config !=3D regval)
+		i2c_smbus_write_byte_data(client, EMC181X_CONFIG_REG, config);
+
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev,
+			client->name,
+			data,
+			&emc181x_chip_info[data->type],
+			NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id __maybe_unused emc181x_of_match[] =3D {
+	{
+		.compatible =3D "microchip,emc1812",
+		.data =3D (void *)emc1812
+	},
+	{
+		.compatible =3D "microchip,emc1813",
+		.data =3D (void *)emc1813
+	},
+	{
+		.compatible =3D "microchip,emc1814",
+		.data =3D (void *)emc1814
+	},
+	{
+		.compatible =3D "microchip,emc1815",
+		.data =3D (void *)emc1815
+	},
+	{
+		.compatible =3D "microchip,emc1833",
+		.data =3D (void *)emc1833
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, emc181x_of_match);
+
+static struct i2c_driver emc181x_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "emc181x",
+		.of_match_table =3D of_match_ptr(emc181x_of_match),
+	},
+	.probe =3D emc181x_i2c_probe,
+	.id_table =3D emc181x_i2c_id,
+	.detect =3D emc181x_i2c_detect,
+	.address_list =3D emc181x_address_list,
+};
+
+module_i2c_driver(emc181x_i2c_driver);
+
+MODULE_DESCRIPTION("EMC181X Sensor Driver");
+MODULE_AUTHOR("Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>");
+MODULE_LICENSE("GPL");
--=20
2.41.0

