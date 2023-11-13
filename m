Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A77EA09E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjKMPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjKMPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:52:26 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5ED1728;
        Mon, 13 Nov 2023 07:52:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so40856955ad.0;
        Mon, 13 Nov 2023 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699890742; x=1700495542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGWunBoOAmKhHVGBNXmLXecareAz0Mh9iiom0qVpKsE=;
        b=efiCWBwRJwO25JZ01tR5Q0gC7sKzIv7xOWA3P4MGdIPloqBbh6L7MyS/Dh16TcXCXg
         aOz2klmfWBaBZGmnVhoq10sUbKZQtaP7SgRaCp7qcv150LcK3b8TgzEmQ+CJUFlTkqio
         rhRK9VtvPZUCokHwqVw5HkoH5WCulw0QwgNZC/SL8NZv3+QIKN5GF5UzyBOJqK/Qd5Wy
         ocleSSPEZWC4BUzK5TkxuYPyoXPyoQMW1omdn3CVGvOpTwsC+1A37ejSbP4b9diQsfXg
         wQpmogtXMkxMkYhLjMqkkFaO9sOVhdi40t7wZAacwk4QgUjpPZegjHA58fN8Re8BNSyw
         e0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890742; x=1700495542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGWunBoOAmKhHVGBNXmLXecareAz0Mh9iiom0qVpKsE=;
        b=HOF+FctdwFrQ4qSABvAzMaNZktPBswhnU6VD4O0TCzWT8ZYzSHrKo9cpKHBLflclB6
         0JgU+l1nvRU+FMnbpizkLr6Pb89wccRN5LaI1edU8CK5T43gXGdSidLA3Pu/IFM8jw5S
         7SGUnaTortTt/2Yt5aF8+3k6+6NH8IHitlFruVxDLcI55HS/sTjWMLM5T6z/CzvomewX
         FvCM3UmMTgIiStE8x33cN68FtRh7pF/s0O8Sh/RKUE1j0mi+nQIY43Xm3yaOv0nFW5vQ
         1sr6Cbqcp4qTunUomVmCmaubK92p3IEITUiKidHIpUt5WCEGKwg7tRTR4Kknxgqt2D57
         2mZg==
X-Gm-Message-State: AOJu0YxXYarrVnLgDGavlMXJX0WipLbxI96XcJ2+Z+b/Im4w9Bw+yO0s
        rRhFU1ptSby6zdAFrSrBeE8=
X-Google-Smtp-Source: AGHT+IHPK95Y0jTsYoZpz1kAidQYw18LQDzKDYhMvbYR/Ou/QfUIFyBbSQ70pqGwpRyHGLNItPwf8Q==
X-Received: by 2002:a17:903:32c7:b0:1cc:4828:9b07 with SMTP id i7-20020a17090332c700b001cc48289b07mr9702445plr.0.1699890742023;
        Mon, 13 Nov 2023 07:52:22 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001c5076ae6absm4155925plb.126.2023.11.13.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:52:21 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: (pmbus) Add support for MPS Multi-phase mp5990
Date:   Mon, 13 Nov 2023 23:50:08 +0800
Message-Id: <20231113155008.2147090-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
vendor. This is a Hot-Swap Controller.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp5990.rst |  84 ++++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |   9 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp5990.c   | 177 +++++++++++++++++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/hwmon/mp5990.rst
 create mode 100644 drivers/hwmon/pmbus/mp5990.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 042e1cf9501b..8c70e10fc795 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -157,6 +157,7 @@ Hardware Monitoring Kernel Drivers
    mp2888
    mp2975
    mp5023
+   mp5990
    nct6683
    nct6775
    nct7802
diff --git a/Documentation/hwmon/mp5990.rst b/Documentation/hwmon/mp5990.rst
new file mode 100644
index 000000000000..6f2f0c099d44
--- /dev/null
+++ b/Documentation/hwmon/mp5990.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp5990
+====================
+
+Supported chips:
+
+  * MPS MP5990
+
+    Prefix: 'mp5990'
+
+  * Datasheet
+
+    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp5990.html
+
+Author:
+
+	Peter Yin <peteryin.openbmc@gmail.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP5990 Hot-Swap Controller.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
+
+Device supports direct and linear format for reading input voltage,
+output voltage, output current, input power and temperature.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_max**
+
+**in1_max_alarm**
+
+**in1_min**
+
+**in1_min_alarm**
+
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_alarm**
+
+The driver provides the following attributes for output current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr1_alarm**
+
+**curr1_max**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+**power1_alarm**
+
+The driver provides the following attributes for temperature:
+
+**temp1_input**
+
+**temp1_max**
+
+**temp1_max_alarm**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..65a116f7744d 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -326,6 +326,15 @@ config SENSORS_MP5023
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5023.
 
+config SENSORS_MP5990
+	tristate "MPS MP5990"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP5990.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp5990.
+
 config SENSORS_MPQ7932_REGULATOR
 	bool "Regulator support for MPQ7932"
 	depends on SENSORS_MPQ7932 && REGULATOR
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..212d9ca0acc9 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
+obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
diff --git a/drivers/hwmon/pmbus/mp5990.c b/drivers/hwmon/pmbus/mp5990.c
new file mode 100644
index 000000000000..2d721b6acfb8
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp5990.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MPS MP5990 Hot-Swap Controller
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+#define MP5990_EFUSE_CFG	(0xC4)
+#define MP5990_VOUT_FORMAT	BIT(9)
+
+struct mp5990_data {
+	struct pmbus_driver_info info;
+	u8 vout_mode;
+	u8 vout_linear_exponent;
+};
+
+#define to_mp5990_data(x)  container_of(x, struct mp5990_data, info)
+
+static int mp5990_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp5990_data *data = to_mp5990_data(info);
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		if (data->vout_mode == linear) {
+			/*
+			 * The VOUT format is linear11, not linear16.
+			 * We should enforce the VOUT in linear mode and
+			 * return exponent value.
+			 */
+			return data->vout_linear_exponent;
+		}
+
+		/*
+		 * The datasheet does not support the VOUT command,
+		 * but the device responds with a default value of 0x17.
+		 * In the standard, 0x17 represents linear mode. However,
+		 * Therefore, we should enforce the VOUT in the direct format
+		 * when format use default direct mode.
+		 */
+		return PB_VOUT_MODE_DIRECT;
+
+	default:
+		return -ENODATA;
+	}
+}
+
+static int mp5990_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp5990_data *data = to_mp5990_data(info);
+	int ret;
+	s32 mantissa;
+
+	switch (reg) {
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+		/*
+		 * Because the VOUT mode is linear11 and not linear16,
+		 * we disregard bits[15:11] and report based on the VOUT mode.
+		 */
+		if (data->vout_mode == linear) {
+			mantissa = ((s16)((ret & 0x7ff) << 5)) >> 5;
+			ret = mantissa;
+		}
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static struct pmbus_driver_info mp5990_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_VOLTAGE_IN] = 32,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 0,
+	.m[PSC_VOLTAGE_OUT] = 32,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 0,
+	.m[PSC_CURRENT_OUT] = 16,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 0,
+	.m[PSC_POWER] = 1,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 0,
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	.func[0] =
+		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
+	.read_byte_data = mp5990_read_byte_data,
+	.read_word_data = mp5990_read_word_data,
+};
+
+static int mp5990_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp5990_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp5990_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp5990_info, sizeof(*info));
+	info = &data->info;
+
+	/* Read Vout Config */
+	ret = i2c_smbus_read_word_data(client, MP5990_EFUSE_CFG);
+	if (ret < 0) {
+		dev_err(&client->dev, "Can't get vout mode.");
+		return ret;
+	}
+
+	/*
+	 * EFUSE_CFG (0xC4) bit9=1 is linear mode, bit=0 is direct mode.
+	 */
+	if (ret & MP5990_VOUT_FORMAT) {
+		data->vout_mode = linear;
+		data->info.format[PSC_VOLTAGE_IN] = linear;
+		data->info.format[PSC_VOLTAGE_OUT] = linear;
+		data->info.format[PSC_CURRENT_OUT] = linear;
+		data->info.format[PSC_POWER] = linear;
+		ret = i2c_smbus_read_word_data(client, PMBUS_READ_VOUT);
+		if (ret < 0) {
+			dev_err(&client->dev, "Can't get vout exponent.");
+			return ret;
+		}
+		data->vout_linear_exponent = (u8)((ret >> 11) & 0x1f);
+	} else {
+		data->vout_mode = direct;
+	}
+	return pmbus_do_probe(client, info);
+}
+
+static const struct of_device_id mp5990_of_match[] = {
+	{ .compatible = "mps,mp5990" },
+	{}
+};
+
+static const struct i2c_device_id mp5990_id[] = {
+	{"mp5990", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mp5990_id);
+
+static struct i2c_driver mp5990_driver = {
+	.driver = {
+		   .name = "mp5990",
+		   .of_match_table = mp5990_of_match,
+	},
+	.probe = mp5990_probe,
+	.id_table = mp5990_id,
+};
+module_i2c_driver(mp5990_driver);
+
+MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
+MODULE_DESCRIPTION("PMBus driver for MP5990 HSC");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1

