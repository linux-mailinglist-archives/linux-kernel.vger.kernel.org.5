Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6EF7E62F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjKIEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjKIEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:51:08 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051BF26AE;
        Wed,  8 Nov 2023 20:51:05 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1eb7a8e9dd0so241687fac.3;
        Wed, 08 Nov 2023 20:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699505462; x=1700110262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGGNBzEmDwLCmCeF+BF2lSFyKjl0VHCNvq4NKl4HYq0=;
        b=lnamVj+qoYTo4ToZOzTROLOOWOScCgRBoM0gwajTXMBy5hrHU11W5jTGtvBPz1t3eK
         uv+QxOrOkzmEKttyVm2aX0AQEiqC8Lf0oY/VRrpMGnyy/fNTBZGRpbw8B3fiSGnse4iy
         bbqyBkVpK2sCyheEMHGrYF2ccw//LVcD6LGtPD+VwEtrIzvs/2gy1c8SV69qBC+FcSsk
         Vd2EqmMt81UyAEMcIfthL9ExW1/O9qYamPNAR/Sl4iUpHdobbHi9oMq/ZHZEOMdbB95p
         Y7k3GOq0YrgAB5YGAGSN/c0c1ITzzCcksPOovgv1C6118rFf1yOXXPyUAXO+xLIO99Gq
         LN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699505462; x=1700110262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGGNBzEmDwLCmCeF+BF2lSFyKjl0VHCNvq4NKl4HYq0=;
        b=KZy+sJOWSKaCxUT2lsvI/eC2Llo1IBwNCCGsdX2alnlbTfkmEwufXba9AR7ipw3d5l
         dIdDy/GgE7MPO7E6aHPhO1PxWNw+IMm9PK1O2jS6WlrP+zIRmp/lewe7rpMzda3+IYMI
         K4UqIQEMmIz6sosHsPRyrra2pX4QYvOV0sTmN2wMu1owq5awpW9jQqWSb0BUA87kpWwS
         wGs17w6Ln7e6m62PVjEoqkGoitoxDqTYGttStv5Seg/jYYtB105HFvz9yjMAflnQDdu5
         nfpXpaZpVF20ucIGabIxs6Z5EGYm635j3J+TGRXSx47otCD5yJcqNThCOopIlQS54CXg
         iN1Q==
X-Gm-Message-State: AOJu0YwsR0m5AARD4jxWnyEo+5D3tvw/GeSgVh2A9ElSZHuqCzyaNo7l
        B5DEZ1SrgNwirrkfkrT0GZg=
X-Google-Smtp-Source: AGHT+IHYTKeZvifAhG7xLuzZDBu6daMdLBcSru8velNUH89o+9nGIFmqmDSsHfW5mkgiSyLAlboosg==
X-Received: by 2002:a05:6870:de15:b0:1bf:6ec:dd4d with SMTP id qg21-20020a056870de1500b001bf06ecdd4dmr4211085oab.28.1699505462465;
        Wed, 08 Nov 2023 20:51:02 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id q189-20020a6343c6000000b005bcebc93d7asm3869035pga.47.2023.11.08.20.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 20:51:02 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (pmbus) Add support for MPS Multi-phase mp5990
Date:   Thu,  9 Nov 2023 12:48:43 +0800
Message-Id: <20231109044844.614007-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109044844.614007-1-peteryin.openbmc@gmail.com>
References: <20231109044844.614007-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
vendor. This is a Hot-Swap Controller.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/hwmon/index.rst  |  1 +
 Documentation/hwmon/mp5990.rst | 84 +++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |  9 ++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/mp5990.c   | 86 ++++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+)
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
index 000000000000..d2da0f767530
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
+Device supports direct format for reading input voltage, output voltage,
+output current, input power and temperature.
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
index 000000000000..fb3ac9c5d44e
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp5990.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MPS MP5990 Hot-Swap Controller
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+static int mp5990_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/* The datasheet does not support the VOUT command,
+		 * but the device responds with a default value of 0x17.
+		 * In the standard, 0x17 represents linear mode. However,
+		 * for the MP5990, the VOUT linear mode is linear11, not linear16.
+		 * Therefore, we should enforce the VOUT in the direct format.
+		 */
+		return PB_VOUT_MODE_DIRECT;
+	default:
+		return -ENODATA;
+	}
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
+};
+
+static int mp5990_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &mp5990_info);
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

