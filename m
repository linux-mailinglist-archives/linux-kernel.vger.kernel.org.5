Return-Path: <linux-kernel+bounces-45951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672F84384B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDB28A3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8854F8B;
	Wed, 31 Jan 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao1n+YSN"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C758207;
	Wed, 31 Jan 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687432; cv=none; b=r0DaNCUUygmmjEM2gtCedQ0TcJMgM+ANHoBuLUbBB6W+fl6/YP3xSuDaTE89uDNDlQAIcGEeqnuGlKDzKPqqNfDpzx46qXYPZwl8d4uo60WhZXt7+OtPPWIL7Fs/plFgUFmi/dz+ekMI99T5maQ0H20yx8JZ/ASu31P9jwb4b3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687432; c=relaxed/simple;
	bh=A7FxfgGUZ1Ea4HK47SATKtXknBluFNyXpleD2XD7Q1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kz96xkk8e60nixXjLDJEVJBBkHgMnOpKM7lPiRwMhxMQSA2Sxyop7T1B7hpyUvkf3YXyuzT3elgg0WNdpvRAcW+LzAo6aJb09aobAA0wSAyomRze89yDtPUErotzXsrLZM77snc99e0QiL2kx/AUIdUh/X38wgJ5jGpDUEtVw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao1n+YSN; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a7682486aso569666eaf.2;
        Tue, 30 Jan 2024 23:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706687429; x=1707292229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0xOZEV/Rr23dhKDycSh6fOgys7EP0KNcjGuQiwLIj0=;
        b=Ao1n+YSNM1OluGQQSi6jW89LulU8xWF9w2nHsGvxXTN2W4895iXKAlmZCSijXp8/SB
         tBQEfEQeaJJe+p4XJCr0m4YejJ7ClLtXt8XaWSdoby9d0ISOUbrMrnDNOPkpRPBLuuLE
         zl02XtLHEopXU4GW2PXpy7E/16IaLG1ZTr2ROVfm4DDSVIKAej3EGO93WikDl+pPi8EY
         ATtd1b5Gqa72tbiSOmXtXeN6TEE7YDDnoB+Y5M0keLX9O2QK96S6bMHzFbthoNCDgAuO
         McJIN+ta6EbB8rnkahJ/ClWzNJANDDkLFj1NlbgAXsnZdVVznf7whlH3wshCtQhlkTO2
         cl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687429; x=1707292229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0xOZEV/Rr23dhKDycSh6fOgys7EP0KNcjGuQiwLIj0=;
        b=qmmSWeYC7VCJGCQdIWUqOJF/rQIBI54iYqSyQKCzLAmoxlZ/LKIuoMGt7ag3RcK2BJ
         aVbQ7Hp6Qao4D6Q+kpvU4oNbu35g3uMWSJ8oVe0eerb2bFnf04u9koS5CIXFvgwmTqj2
         KgKUTZjOVxdDcWqYQSkvPSzNww2LXgyF4HBDjF/vkcd52HYXAVWLQz5cxBRlWPU9rOP+
         BPonDBHUuJuKu9ilJ7gPw/xaYsoLv/3fe6voWlnMTncvKm6qBmcJDQLWrIM8y5Wly+sR
         wVNgLK6QMKcruTNHHkF7H17AcQHCjfRH8dFmLwC2L73YEurrt6n3KJf0wy7d8K8tEe/y
         QOxA==
X-Gm-Message-State: AOJu0YwE7hXfb/zGabH7q5X1xBsrI5DUiFuOtfD8Yp1xcDxoNdeJqq9i
	U5ROVhWFDG2dkjV6y2nR4yWY2yzVHKF8RURvjIKPbMQxGSE6jSRH
X-Google-Smtp-Source: AGHT+IHabSggSc4445HO5B10knrQ2Bw3Eh0MgMVbdxAL5HEGiZjx5qzk5B6ITAaEDXj+/7L65ZhBCA==
X-Received: by 2002:a05:6358:5912:b0:178:b0c5:25e3 with SMTP id g18-20020a056358591200b00178b0c525e3mr108865rwf.3.1706687429518;
        Tue, 30 Jan 2024 23:50:29 -0800 (PST)
Received: from charles-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006dde3053cdasm9164953pfi.133.2024.01.30.23.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:50:29 -0800 (PST)
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
Subject: [PATCH v4 2/2] hwmon: Add driver for MPS MPQ8785 Synchronous Step-Down Converter
Date: Wed, 31 Jan 2024 15:48:22 +0800
Message-Id: <20240131074822.2962078-2-ythsu0511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131074822.2962078-1-ythsu0511@gmail.com>
References: <20240131074822.2962078-1-ythsu0511@gmail.com>
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
Change in v4:
    1.Return an error if reading VOUT_MODE fails.
---
 Documentation/hwmon/index.rst   |  1 +
 Documentation/hwmon/mpq8785.rst | 94 +++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig     |  9 ++++
 drivers/hwmon/pmbus/Makefile    |  1 +
 drivers/hwmon/pmbus/mpq8785.c   | 89 +++++++++++++++++++++++++++++++
 5 files changed, 194 insertions(+)
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
index 000000000000..b9405dac7b09
--- /dev/null
+++ b/drivers/hwmon/pmbus/mpq8785.c
@@ -0,0 +1,89 @@
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
+	if (vout_mode < 0 || vout_mode == 0xff)
+		return vout_mode < 0 ? vout_mode : -ENODEV;
+	switch (vout_mode >> 5) {
+	case 0:
+		info->format[PSC_VOLTAGE_OUT] = linear;
+		break;
+	case 1:
+	case 2:
+		info->format[PSC_VOLTAGE_OUT] = direct,
+		info->m[PSC_VOLTAGE_OUT] = 64;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = 1;
+		break;
+	default:
+		return -ENODEV;
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


