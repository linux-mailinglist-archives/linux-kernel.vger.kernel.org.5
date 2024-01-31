Return-Path: <linux-kernel+bounces-45797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5345F843653
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFDC1F2819D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E13DBBF;
	Wed, 31 Jan 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gm7KvZNk"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04C3DB8C;
	Wed, 31 Jan 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680653; cv=none; b=u6gs9g/cGGgwIkv8Rm1t9e/uT4Ad3vF1ID79U8S5CO7ydWUBjs7+OVYPPVDDJS3MkcCZRHonMqhhwqqtjrXRAkP29LXcGamf86lWsYlpG7WPHSSSH/3vXx8hoLLoy/i/JMUeh0uOCe0nag1R0lolEBhkqZzVFBOXMy8xrg79gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680653; c=relaxed/simple;
	bh=yExbTaxNujpw4MVvw6DMvGP2n9jHMUjfnafp46vGVVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sRPSwU2TcO03mdOvYmvTo3PBa2aHGTGFLS3ETsLhh2akeCkTMJ+CnnkYOJYZpxAM9zA4IGxEUNeO82t/FYBWi0LNwtWtNfzMvnEWUf7ffmPsZga7ohoVdnlx4VawBqRV3r2eCLUd6rM1L3/kbll8b+ETEMLu65mxILijjwvkWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gm7KvZNk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de0ba30994so400853b3a.1;
        Tue, 30 Jan 2024 21:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706680651; x=1707285451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwfM1rJCcQryVjF8O0WNubhcGyoUuP04qt8oaDsGtxo=;
        b=Gm7KvZNkpb2JQY+2Wx8+IdWD97aI0tLgCglD24Q0xq0xiGpOiQblALbjqhvUyRyNNw
         +sVprWLFNr3kvZxs268dOP+7N2gCiHQmkBVhiu0wE/RmwIXeF6hTzPqW3pPZ7Gy8dXgz
         8RVkiDluP4v4N/O/yfXhF8PVa8j5WCo1S4r19ks+/MlqEO1KE9VTSIMFYlp97keV8qls
         hrcitQXb+MNMxkolLCH4gpidPJ/K0AH4fwcGcJuz8CYIlor/PGix+xVCbL+k/8Ec3h2f
         sHemtFfYO+Np2Cwl8qgURgb0BM4R3udNyDTMtaXKYKabnn65mymufpaHHIjg7LfIGGKo
         sELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680651; x=1707285451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwfM1rJCcQryVjF8O0WNubhcGyoUuP04qt8oaDsGtxo=;
        b=MuRkhPFI8c+QnQxVKTSJamW5UXYxyF556FZ9thc6YYSG2N927fGEZkOs1tRZEYuX8+
         Fzi/FNBxoCHbjNYMDbatPP2uDyErrJ4h4eLgu+DcI3ZmlaZzHQ1oeUFqKy7BC869/zXZ
         U8TwPZoywaJeZzvXHPfmnsczogxtZ7od5ZIzElyRE3GnWYlU7qj4ruNRRVvr8FcCDd+2
         S97gM8UqVXbZTaHaZTnKE7nCPUeLmzvSahksWJwH7b1W1wLwd0kPxgNsddF6XoO+v6Zc
         +DiPj1G3XXQu4JyD1qADIxMgvB7jkB/WIL2xJrFoebtAgbYkWSLV70r0nFO8BZnbW6Pk
         Y4bA==
X-Gm-Message-State: AOJu0Ywkr9N2ahXZj+VPMjzGcbkTHkmkdCBeGcL0EvTFp51U+G970zMl
	NDN9zdRFzhnBjgWibLkWOUyg11nC15pv/Yf5me9+5weqtGyOcgj5
X-Google-Smtp-Source: AGHT+IGyY4WvXEhqhD6fYTqwlagg2XzApmRAkpxMfsTtKj47HL+X08KbKcSgirmJSNLfug0CcR+9PA==
X-Received: by 2002:a05:6a00:981:b0:6d9:a074:659f with SMTP id u1-20020a056a00098100b006d9a074659fmr4506003pfg.13.1706680651313;
        Tue, 30 Jan 2024 21:57:31 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006ddddc7701fsm8904385pfd.4.2024.01.30.21.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:57:31 -0800 (PST)
From: Charles Hsu <ythsu0511@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	Delphine_CC_Chiu@Wiwynn.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Charles Hsu <ythsu0511@gmail.com>
Subject: [PATCH v3 1/2] hwmon: Add driver for MPS MPQ8785 Synchronous Step-Down Converter
Date: Wed, 31 Jan 2024 13:55:25 +0800
Message-Id: <20240131055526.2700452-1-ythsu0511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for mpq8785 device from Monolithic Power Systems, Inc.
(MPS) vendor. This is synchronous step-down controller.

Signed-off-by: Charles Hsu <ythsu0511@gmail.com>

---
Change in v1:
    Initial patchset.
Change in v2:
    1.Add pmbus support status registers.
    2.Add mpq8785 in trivial-devices.yaml.
    3.Remove format[PSC_VOLTAGE_OUT].
    4.Fix MODULE_DESCRIPTION.
Change in v3:
    1.Identify vout_mode.
    2.Separate dt-binding.
---
 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/mpq8785.rst | 94 +++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |  9 ++++
 drivers/hwmon/pmbus/Makefile    |  1 +
 drivers/hwmon/pmbus/mpq8785.c   | 91 +++++++++++++++++++++++++++++++
 5 files changed, 196 insertions(+)
 create mode 100644 Documentation/hwmon/mpq8785.rst
 create mode 100644 drivers/hwmon/pmbus/mpq8785.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c7ed1f73ac06..085ad6ca9b05 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -163,6 +163,7 @@ Hardware Monitoring Kernel Drivers
    mp2975
    mp5023
    mp5990
+   mpq8785
    nct6683
    nct6775
    nct7802
diff --git a/Documentation/hwmon/mpq8785.rst b/Documentation/hwmon/mpq8785.rst
new file mode 100644
index 000000000000..bf8176b87086
--- /dev/null
+++ b/Documentation/hwmon/mpq8785.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver mpq8785
+=======================
+
+Supported chips:
+
+  * MPS MPQ8785
+
+    Prefix: 'mpq8785'
+
+Author: Charles Hsu <ythsu0511@gmail.com>
+
+Description
+-----------
+
+The MPQ8785 is a fully integrated, PMBus-compatible, high-frequency, synchronous
+buck converter. The MPQ8785 offers a very compact solution that achieves up to
+40A output current per phase, with excellent load and line regulation over a
+wide input supply range. The MPQ8785 operates at high efficiency over a wide
+output current load range.
+
+The PMBus interface provides converter configurations and key parameters
+monitoring.
+
+The MPQ8785 adopts MPS's proprietary multi-phase digital constant-on-time (MCOT)
+control, which provides fast transient response and eases loop stabilization.
+The MCOT scheme also allows multiple MPQ8785 devices to be connected in parallel
+with excellent current sharing and phase interleaving for high-current
+applications.
+
+Fully integrated protection features include over-current protection (OCP),
+over-voltage protection (OVP), under-voltage protection (UVP), and
+over-temperature protection (OTP).
+
+The MPQ8785 requires a minimal number of readily available, standard external
+components, and is available in a TLGA (5mmx6mm) package.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
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
+**in1_crit**
+
+**in1_crit_alarm**
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
+**curr1_max**
+
+**curr1_max_alarm**
+
+**curr1_crit**
+
+**curr1_crit_alarm**
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
index 294808f5240a..557ae0c414b0 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -377,6 +377,15 @@ config SENSORS_MPQ7932
 	  This driver can also be built as a module. If so, the module will
 	  be called mpq7932.
 
+config SENSORS_MPQ8785
+	tristate "MPS MPQ8785"
+	help
+	  If you say yes here you get hardware monitoring functionality support
+	  for power management IC MPS MPQ8785.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mpq8785.
+
 config SENSORS_PIM4328
 	tristate "Flex PIM4328 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index cf8a76744545..f14ecf03ad77 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
+obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
diff --git a/drivers/hwmon/pmbus/mpq8785.c b/drivers/hwmon/pmbus/mpq8785.c
new file mode 100644
index 000000000000..b5bfc5d8a96b
--- /dev/null
+++ b/drivers/hwmon/pmbus/mpq8785.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MPS MPQ8785 Step-Down Converter
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+static int mpq8785_identify(struct i2c_client *client,
+			    struct pmbus_driver_info *info)
+{
+	int vout_mode;
+
+	vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (vout_mode >= 0 && vout_mode != 0xff) {
+		switch (vout_mode >> 5) {
+		case 0:
+			info->format[PSC_VOLTAGE_OUT] = linear;
+			break;
+		case 1:
+		case 2:
+			/* Direct mode or VID mode: Vout_Actual = READ_VOUT*LSB,
+			   LSB = 1.5625 mV/LSB */
+			info->format[PSC_VOLTAGE_OUT] = direct,
+			info->m[PSC_VOLTAGE_OUT] = 64;
+			info->b[PSC_VOLTAGE_OUT] = 0;
+			info->R[PSC_VOLTAGE_OUT] = 1;
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+};
+
+static struct pmbus_driver_info mpq8785_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_VOLTAGE_IN] = 4,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 1,
+	.m[PSC_CURRENT_OUT] = 16,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 0,
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	.func[0] =
+		PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
+		PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+	.identify = mpq8785_identify,
+};
+
+static int mpq8785_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &mpq8785_info);
+};
+
+static const struct i2c_device_id mpq8785_id[] = {
+	{ "mpq8785", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, mpq8785_id);
+
+static const struct of_device_id __maybe_unused mpq8785_of_match[] = {
+	{ .compatible = "mps,mpq8785" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpq8785_of_match);
+
+static struct i2c_driver mpq8785_driver = {
+	.driver = {
+		   .name = "mpq8785",
+		   .of_match_table = of_match_ptr(mpq8785_of_match),
+	},
+	.probe_new = mpq8785_probe,
+	.id_table = mpq8785_id,
+};
+
+module_i2c_driver(mpq8785_driver);
+
+MODULE_AUTHOR("Charles Hsu <ythsu0511@gmail.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MPQ8785");
+MODULE_LICENSE("GPL");
-- 
2.34.1


