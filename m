Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D513375AE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:35:23 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 05:35:22 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81906F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:35:22 -0700 (PDT)
From:   "Marty E. Plummer" <hanetzer@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1689854295;
        bh=QcDTd84f5Syv2zlZDzVZzw50uxA1cKbNqqF+nxsaLiA=;
        h=From:To:Subject:Date:Message-ID:Mime-Version:
         Content-Transfer-Encoding:From:Subject:To:Date:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version:
         Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=DZMAEosiWQwnb2IXM3Em5+0qiKiSvnyUymUZf3gwfWy9e8w/LFXvQIl8soY2IK5hv
         yiX+mGQRSLQMpjLQCNCzApOzAKsfKIwC137VCRUzmGrZKyP+8R5r42Lp4O8M1pEbx9
         hAk7zA/hd8cMyCaByQO75Q9zfWMzTC9irK4bZGXvA5f7ZAiRcaUz5WL5xpcd0jCyW7
         NXH1evjfbSZPjJZCnbOl07Ro6uJOQufv14wBKgmu3LiZQp9BEx6ykvhzMLiVR1OolT
         pSDLQfy71G9Fi3Do4o6+aTh1Ki1t+/Afo96IIuAW44+wtSJWmNZiPcTjVuMFgcKYD2
         UmEoctV/KFpNg==
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "Marty E. Plummer" <hanetzer@startmail.com>
Subject: [PATCH] hwmon: (pmbus) Add driver fpr Infineon IR35201
Date:   Thu, 20 Jul 2023 06:58:05 -0500
Message-ID: <20230720115805.1510279-1-hanetzer@startmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IR35201 is a dual-loop digital multi-phase buck controller designed for CPU voltage regulation.

Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
---
 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/ir35201.rst | 63 +++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |  9 ++++
 drivers/hwmon/pmbus/Makefile    |  1 +
 drivers/hwmon/pmbus/ir35201.c   | 89 +++++++++++++++++++++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 Documentation/hwmon/ir35201.rst
 create mode 100644 drivers/hwmon/pmbus/ir35201.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 042e1cf9501b..5b44a268de0d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -87,6 +87,7 @@ Hardware Monitoring Kernel Drivers
    ina3221
    inspur-ipsps1
    intel-m10-bmc-hwmon
+   ir35201
    ir35221
    ir38064
    ir36021
diff --git a/Documentation/hwmon/ir35201.rst b/Documentation/hwmon/ir35201.rst
new file mode 100644
index 000000000000..6ca34d4b02a3
--- /dev/null
+++ b/Documentation/hwmon/ir35201.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver ir35201
+=====================
+
+Supported chips:
+
+  * Infineon IR35201
+
+    Prefix: ir35201
+    Addresses scanned: -
+
+    Datasheet: Publicly available at the Infineon website
+      https://www.infineon.com/dgdl/Infineon-IR35201MTRPBF-DS-v01_00-EN.pdf?fileId=5546d462576f347501579c95d19772b5
+
+Authors:
+      - Marty E. Plummer <hanetzer@startmail.com>
+
+Description
+-----------
+
+The IR35201 is a dual-loop digital multi-phase buck controller designed for
+CPU voltage regulation.
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantiate
+devices explicitly.
+
+Sysfs attributes
+----------------
+
+======================= ===========================
+curr1_label             "iin"
+curr1_input             Measured input current
+curr1_alarm             Input fault alarm
+
+curr2_label             "iout1"
+curr2_input             Measured output current
+curr2_alarm             Output over-current alarm
+
+in1_label               "vin"
+in1_input               Measured input voltage
+in1_alarm               Input under-voltage alarm
+
+in2_label               "vout1"
+in2_input               Measured output voltage
+in2_alarm               Output over-voltage alarm
+
+power1_label            "pin"
+power1_input            Measured input power
+power1_alarm            Input under-voltage alarm
+
+power2_label            "pout1"
+power2_input            Measured output power
+
+temp1_input             Measured temperature
+temp1_alarm             Temperature alarm
+
+temp2_input             Measured other loop temperature
+temp2_alarm             Temperature alarm
+======================= ===========================
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..7180823b15bb 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
 	  This driver can also be built as a module. If so, the module will
 	  be called inspur-ipsps.
 
+config SENSORS_IR35201
+	tristate "Infineon IR35201"
+	help
+	  If you say yes here you get hardware monitoring support for the
+	  Infineon IR35201 controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ir35201.
+
 config SENSORS_IR35221
 	tristate "Infineon IR35221"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..40729dd14e7a 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
 obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
 obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
+obj-$(CONFIG_SENSORS_IR35201)	+= ir35201.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
 obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
 obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
diff --git a/drivers/hwmon/pmbus/ir35201.c b/drivers/hwmon/pmbus/ir35201.c
new file mode 100644
index 000000000000..77f77057175a
--- /dev/null
+++ b/drivers/hwmon/pmbus/ir35201.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Infineon IR35201
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+static struct pmbus_driver_info ir35201_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
+		| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
+		| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
+		| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+		| PMBUS_HAVE_STATUS_TEMP,
+};
+
+static int ir35201_probe(struct i2c_client *client)
+{
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA
+					 | I2C_FUNC_SMBUS_READ_WORD_DATA
+					 | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
+		return ret;
+	}
+	if (ret != 2 || strncmp(buf, "IR", strlen("IR"))) {
+		dev_err(&client->dev, "MFR_ID unrecognized\n");
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
+		return ret;
+	}
+	if (ret != 1 || buf[0] != 0x50) {
+		dev_err(&client->dev, "MFR_MODEL unrecognized\n");
+		return -ENODEV;
+	}
+
+	return pmbus_do_probe(client, &ir35201_info);
+}
+
+static const struct i2c_device_id ir35201_id[] = {
+	{ "ir35201", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ir35201_id);
+
+static const struct of_device_id __maybe_unused ir35201_of_id[] = {
+	{ .compatible = "infineon,ir35201" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ir35201_of_id);
+
+static struct i2c_driver ir35201_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "ir35201",
+		.of_match_table = of_match_ptr(ir35201_of_id),
+	},
+	.probe_new = ir35201_probe,
+	.id_table = ir35201_id,
+};
+
+module_i2c_driver(ir35201_driver);
+
+MODULE_AUTHOR("Marty E. Plummer <hanetzer@startmail.com>");
+MODULE_DESCRIPTION("PMBus driver for Infineon IR35201");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.41.0

