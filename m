Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883BC7E0084
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjKCIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjKCIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:05:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA131B6;
        Fri,  3 Nov 2023 01:04:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so16472475ad.0;
        Fri, 03 Nov 2023 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698998696; x=1699603496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axKwtGrX3CjILSP9XH8F0phpKXXMKLSo8OytbKLjoeo=;
        b=nRO8RaLPCRooLGVWpbT/3uaZmV88NoaiDi/tKmSMkYfbxUO2juwiZuR++u5qcYdYps
         pG7QuOzFUlj8cOInmhJz8GdQIOJV75pzH5ljRiQUl4mKNb2H7c5wbVuEMXnntlBPbfq0
         speRzhInLEqgoxDca0L7HOUuFpKZ8MReekeombnfbMhzMbmFExvCTkzVa78NUJbSIbKZ
         wE/GkbHgYrsmk3t+fkoMADIFwxmNk8zca5Q0wMO4rPBUSTedfr7G8ZWRiSE9iMN2PKyK
         lHxEkZ4OfV30SQlV/Yzs4zokRJTwJZ651Nh2rgoG6b4iZaFb/TOTf2KyadwyRaVdtM1G
         qnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998696; x=1699603496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axKwtGrX3CjILSP9XH8F0phpKXXMKLSo8OytbKLjoeo=;
        b=X7jaXBvL6MeD37rCf4x40HC4LJquMplHAfywxmRs4So/iiBANtAOOkeI7BaNlaoUun
         lbox4tdW4eNxn31YRnFlzAAUahclE8bxWjwvO0eYVIg9Ojl8WO5qVcz7i7ygKpd+xMb1
         wgJYALB4ucYzkOhZwwM5NY1GuIwyFX4wxvbKIUp768KctefzUfbncBE5g9tl1EbrUgq9
         7Phe1xsqYlRnTM9X6p0tVHe1yl4jC28BSzwL5/zR7A9srJrsnFG04YV3C+YnIwJ8iBVW
         TuBUsXI0fk0ztrubUEzNQxsMUKGge2kHyKNJsfPWFUzpYJaCdJcYomTrMMXIULkCCVyg
         /sCQ==
X-Gm-Message-State: AOJu0Yw/9V3IjPHv6p2Y2Gbao0ePuFwALYWrUGmV3bP2pJbkFw/fYUUL
        I43M7jPGyrUmIlBfme5gojc=
X-Google-Smtp-Source: AGHT+IFM/APK48tWP7y4Wdi3KSHsYdtBIZwoKsNTtil+i8QYKTxOzhyF5qCwrdpW9T5V+VJbGfNxKw==
X-Received: by 2002:a17:90a:d497:b0:27f:ecd9:6d0e with SMTP id s23-20020a17090ad49700b0027fecd96d0emr19514519pju.34.1698998696109;
        Fri, 03 Nov 2023 01:04:56 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a72c100b002790ded9c6dsm834378pjk.31.2023.11.03.01.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:04:55 -0700 (PDT)
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
Subject: [PATCH v1 2/2] hwmon: (pmbus) Add support for MPS Multi-phase mp5990
Date:   Fri,  3 Nov 2023 16:01:27 +0800
Message-Id: <20231103080128.1204218-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103080128.1204218-1-peteryin.openbmc@gmail.com>
References: <20231103080128.1204218-1-peteryin.openbmc@gmail.com>
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
 Documentation/hwmon/index.rst  |  1 +
 Documentation/hwmon/mp5990.rst | 84 +++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |  9 ++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/mp5990.c   | 90 ++++++++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+)
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
index 000000000000..8fc4e388ff7b
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
+Device complaint with:
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
index 000000000000..c3b31af9f750
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp5990.c
@@ -0,0 +1,90 @@
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
+		/*
+		  Enforce VOUT direct format, C4h reg BIT9
+		  default val is not match vout format
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
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE,
+					PB_VOUT_MODE_DIRECT);
+	if (ret < 0)
+		return ret;
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
+		   .of_match_table = of_match_ptr(mp5990_of_match),
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

