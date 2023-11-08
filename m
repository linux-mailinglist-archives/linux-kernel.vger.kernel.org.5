Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EA7E4F0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjKHCpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjKHCo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:44:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4976F10FE;
        Tue,  7 Nov 2023 18:44:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c3077984e8so5517589b3a.0;
        Tue, 07 Nov 2023 18:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699411495; x=1700016295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZudMX4nOXZmGvKZLpfgxbBa/Rc2Sk+8QJnkXYry9bY=;
        b=AY1uwZx3jWwRIStq7qfh6mSTdun5NYlrLkd0M6BrGF5HhTbqdS8iNdmvzNUQyHtwp/
         bopAorCFAT9FrVjkx2DDA7mxGP2X2jIKfJbM8p2x6kpMYCh7EO1RReSj2axqbnNlLjA8
         Wlw82OXMuJy1oFmb6XztfN6jEMA5mT+IzJrawZ1/zfiXJrvQg1Ypx7TNUzlF2Oo4YdOA
         DSVNr1yNwhBPFRaioefk4rz/t8mr6axerxLl0VyK+4D1+Xs/3YYB4Rye9bGSPUdEyAMY
         J09NzNeUurhXrJr/O/+J/mSta9KBvN7t/KyM3rRpD0Ut9zsRImPkLDoQub2wVNVLvUUn
         F/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411495; x=1700016295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZudMX4nOXZmGvKZLpfgxbBa/Rc2Sk+8QJnkXYry9bY=;
        b=wYdV7RMM/bSszOx8T1JlGpNheGg2d8If07eM3jSSGEd7yccMuNElgVSh+5D4hGstVS
         gapDbFenEf+eEUA/MgsX7t/8mdN7lWZYPbHPxChszo8FdnSBUbpbC3HacO4MkXaVk8E+
         mC3shxB9OOpDR14+0xM6I6/kEU1kcorJDm6SyUgIjx+UnGopCyqFw/a7fWS7JNHeldmT
         5f2qYeYOed/bzhMjf50olKRjqHcrm2RJ4o40bNyOB05NBohIoTlXhpelgkpBP4dJAqHG
         4sTPiHNi/3NDush5X/ocr5lJuHGutpHv/zo6HSCYV78RTHS8pwZr/SZIod6pQtMNxe2J
         h1/Q==
X-Gm-Message-State: AOJu0YzvrBw6XnJ4LqbhZFG2rYVR5bsupsQ/iEMrYZCzoBqKABxVjnOG
        Y6wZ8/FmOt0U7kY7n2suz1o=
X-Google-Smtp-Source: AGHT+IGCQb2apPsKAH+RLJ+/tbLg+2vN/7UC7n2fDvavWdA7R7itMJoA2Dv9zz8JME2ELE9lrsJSww==
X-Received: by 2002:a05:6a20:9143:b0:182:11b2:b982 with SMTP id x3-20020a056a20914300b0018211b2b982mr807208pzc.27.1699411494634;
        Tue, 07 Nov 2023 18:44:54 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027d8300b001c62e3e1286sm501681plm.166.2023.11.07.18.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:44:54 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
X-Google-Original-From: Peter Yin <peter.yin@quantatw.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: (pmbus) Add support for MPS Multi-phase mp2856/mp2857 controller
Date:   Wed,  8 Nov 2023 10:42:19 +0800
Message-Id: <20231108024222.2026546-3-peter.yin@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108024222.2026546-1-peter.yin@quantatw.com>
References: <20231108024222.2026546-1-peter.yin@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Yin <peteryin.openbmc@gmail.com>

Add support for mp2856/mp2857 device from Monolithic Power Systems, Inc.
(MPS) vendor. This is a dual-loop, digital, multi-phase,
modulation controller.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp2856.rst | 101 ++++++++++
 drivers/hwmon/pmbus/Kconfig    |   9 +
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp2856.c   | 327 +++++++++++++++++++++++++++++++++
 5 files changed, 439 insertions(+)
 create mode 100644 Documentation/hwmon/mp2856.rst
 create mode 100644 drivers/hwmon/pmbus/mp2856.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 042e1cf9501b..44183a3382f6 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -154,6 +154,7 @@ Hardware Monitoring Kernel Drivers
    mcp3021
    menf21bmc
    mlxreg-fan
+   mp2856
    mp2888
    mp2975
    mp5023
diff --git a/Documentation/hwmon/mp2856.rst b/Documentation/hwmon/mp2856.rst
new file mode 100644
index 000000000000..6bd8392f6994
--- /dev/null
+++ b/Documentation/hwmon/mp2856.rst
@@ -0,0 +1,101 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp2856
+====================
+
+Supported chips:
+
+  * MPS MP2856
+
+    Prefix: 'mp2856'
+
+  * MPS MP2857
+
+    Prefix: 'mp2857'
+
+Author:
+
+	Peter Yin <peter.yin@quantatw.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+vendor dual-loop, digital, multi-phase controller MP2856/MP2857
+
+This device:
+
+- Supports up to two power rail.
+- Supports two pages 0 and 1 for and also pages 2 for configuration.
+- Can configured VOUT readout in direct or VID format and allows
+  setting of different formats on rails 1 and 2. For VID the following
+  protocols are available: AMD SVI3 mode with 5-mV/LSB.
+
+Device supports:
+
+- SVID interface.
+- AVSBus interface.
+
+Device complaint with:
+
+- PMBus rev 1.3 interface.
+
+Device supports direct format for reading output current, output voltage,
+input and output power and temperature.
+Device supports linear format for reading input voltage and input power.
+Device supports VID and direct formats for reading output voltage.
+The below VID modes are supported: AMD SVI3.
+
+The driver provides the next attributes for the current:
+The driver exports the following attributes via the 'sysfs' files, where
+
+- indexes 1  for "iin";
+- indexes 2, 3 for "iout";
+
+**curr[1-3]_alarm**
+
+**curr[1-3]_input**
+
+**curr[1-3]_label**
+
+The driver provides the next attributes for the voltage:
+The driver exports the following attributes via the 'sysfs' files, where
+
+- indexes 1 for "vin";
+- indexes 2, 3 for "vout";
+
+**in[1-3]_crit**
+
+**in[1-3]_crit_alarm**
+
+**in[1-3]_input**
+
+**in[1-3]_label**
+
+**in[1-3]_lcrit**
+
+**in[1-3]_lcrit_alarm**
+
+The driver provides the next attributes for the power:
+The driver exports the following attributes via the 'sysfs' files, where
+
+- indexes 1 for "pin";
+- indexes 2, 3 for "pout";
+
+**power[1-3]_alarm**
+
+**power[1-3]_input**
+
+**power[1-3]_label**
+
+The driver provides the next attributes for the temperature:
+
+**temp[1-2]_crit**
+
+**temp[1-2]_crit_alarm**
+
+**temp[1-2]_input**
+
+**temp[1-2]_max**
+
+**temp[1-2]_max_alarm**
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 270b6336b76d..40ad02b459de 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -299,6 +299,15 @@ config SENSORS_MAX8688
 	  This driver can also be built as a module. If so, the module will
 	  be called max8688.
 
+config SENSORS_MP2856
+	tristate "MPS MP2856"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP2856 MP2857 Dual Loop Digital Multi-Phase Controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp2856.
+
 config SENSORS_MP2888
 	tristate "MPS MP2888"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 84ee960a6c2d..0f35047b451f 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
 obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
diff --git a/drivers/hwmon/pmbus/mp2856.c b/drivers/hwmon/pmbus/mp2856.c
new file mode 100644
index 000000000000..b72a46cb6e9b
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2856.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS2856/2857
+ * Monolithic Power Systems VR Controllers
+ *
+ * Copyright (C) 2023 Quanta Computer lnc.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+/* Vendor specific registers. */
+#define MP2856_MFR_SLOPE_TRIM3		0x1d
+#define MP2856_MFR_VR_MULTI_CONFIG_R1	0x0d
+#define MP2856_MFR_VR_MULTI_CONFIG_R2	0x1d
+#define MP2856_MUL1_CUR_SCALE_R1	0x0b
+#define MP2856_MUL1_CUR_SCALE_R2	0x1b
+#define MP2856_MFR_DC_LOOP_CTRL		0x59
+#define MP2856_MFR_VR_CONFIG1		0x68
+#define MP2856_MFR_READ_IOUT_PK		0x90
+#define MP2856_MFR_READ_POUT_PK		0x91
+#define MP2856_MFR_PROTECT_SET		0xc5
+#define MP2856_MFR_RESO_SET		0x5e
+#define MP2856_MFR_OVP_TH_SET		0xe5
+#define MP2856_MFR_UVP_SET		0xe6
+
+#define MP2856_VID_EN			BIT(11)
+#define MP2856_DRMOS_KCS		GENMASK(15, 12)
+#define MP2856_VID_SCALE		5
+#define MP2856_VIN_UV_LIMIT_UNIT	8
+#define MP2856_PWR_EXPONENT_BIT		GENMASK(10, 6)
+
+#define MP2856_MAX_PHASE_RAIL1		12
+#define MP2856_MAX_PHASE_RAIL2		6
+#define MP2856_PAGE_NUM			2
+
+#define MP2856_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | \
+				 PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | \
+				 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP)
+
+#define MP2856_RAIL2_MAX_PHASE		4
+
+struct mp2856_data {
+	struct pmbus_driver_info info;
+	int vout_format[MP2856_PAGE_NUM];
+};
+
+#define to_mp2856_data(x)  container_of(x, struct mp2856_data, info)
+
+static int
+mp2856_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
+			u16 mask)
+{
+	int ret = pmbus_read_word_data(client, page, phase, reg);
+
+	return (ret > 0) ? ret & mask : ret;
+}
+
+static int
+mp2856_vid2linear(int val)
+{
+	return 500 + (val - 1) * 10;
+}
+
+static int mp2856_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2856_data *data = to_mp2856_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_VOUT:
+		ret = mp2856_read_word_helper(client, page, phase, reg,
+					      GENMASK(11, 0));
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * READ_VOUT can be provided in VID or linear format. This
+		 * provided in a linear format. In case format is VID - convert
+		 * to linear.
+		 */
+		if (data->vout_format[page] == vid)
+			ret = mp2856_vid2linear(ret);
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
+static int mp2856_identify_multiphase_rail2(struct i2c_client *client)
+{
+	int ret;
+
+	/*
+	 * Identify multiphase for rail 2 - could be from 0 to 1.
+	 * In case phase number is zero – only page zero is supported
+	 */
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
+	if (ret < 0)
+		return ret;
+
+	/* Identify multiphase for rail 2 - could be from 0 to 1. */
+	ret = i2c_smbus_read_word_data(client, MP2856_MFR_VR_MULTI_CONFIG_R2);
+	if (ret < 0)
+		return ret;
+
+	ret &= GENMASK(2, 0);
+	return (ret >= MP2856_RAIL2_MAX_PHASE) ? MP2856_RAIL2_MAX_PHASE : ret;
+}
+
+static int
+mp2856_identify_vid(struct i2c_client *client, struct mp2856_data *data,
+		    struct pmbus_driver_info *info, u32 reg, int page,
+		    u32 imvp_bit)
+{
+	int ret;
+
+	/* Identify VID mode and step selection. */
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	if (ret & imvp_bit) {
+		info->vrm_version[page] = vr13;
+	} else {
+		//workaround for chip power scale issue
+		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_read_word_data(client,
+					       MP2856_MUL1_CUR_SCALE_R1);
+		if (ret < 0)
+			return ret;
+
+		ret &= ~MP2856_PWR_EXPONENT_BIT;
+		ret = i2c_smbus_write_word_data(client,
+						MP2856_MUL1_CUR_SCALE_R1, ret);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_read_word_data(client,
+					       MP2856_MUL1_CUR_SCALE_R2);
+		if (ret < 0)
+			return ret;
+
+		ret &= ~MP2856_PWR_EXPONENT_BIT;
+		ret = i2c_smbus_write_word_data(client,
+						MP2856_MUL1_CUR_SCALE_R2, ret);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int
+mp2856_identify_rails_vid(struct i2c_client *client, struct mp2856_data *data,
+			  struct pmbus_driver_info *info)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 1. */
+	ret = mp2856_identify_vid(client, data, info,
+				  MP2856_MFR_RESO_SET, 0,
+				  MP2856_VID_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 2, if connected. */
+	if (info->phases[1])
+		ret = mp2856_identify_vid(client, data, info,
+					  MP2856_MFR_RESO_SET, 1,
+					  MP2856_VID_EN);
+	return ret;
+}
+
+static int
+mp2856_identify_vout_format(struct i2c_client *client,
+			    struct mp2856_data *data, int page)
+{
+	int ret;
+	int val;
+
+	ret = i2c_smbus_read_word_data(client, MP2856_MFR_RESO_SET);
+	if (ret < 0)
+		return ret;
+
+	val = (ret & GENMASK(11, 11)) >> 11;
+	switch (val) {
+	case 0:
+		data->vout_format[page] = vid;
+		break;
+	default:
+		data->vout_format[page] = linear;
+		break;
+	}
+	return 0;
+}
+
+static int
+mp2856_vout_per_rail_config_get(struct i2c_client *client,
+				struct mp2856_data *data,
+				struct pmbus_driver_info *info)
+{
+	int i, ret;
+
+	for (i = 0; i < data->info.pages; i++) {
+		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Get VOUT format for READ_VOUT command : VID or direct.
+		 * Pages on same device can be configured with different
+		 * formats.
+		 */
+		ret = mp2856_identify_vout_format(client, data, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct pmbus_driver_info mp2856_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
+		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
+	.read_word_data = mp2856_read_word_data,
+};
+
+static int mp2856_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp2856_data *data;
+	int ret;
+
+	/*
+	 * MP2856/MP2857 devices may not stay in page 0 during device
+	 * probe which leads to probe failure (read status word failed).
+	 * So let's set the device to page 0 at the beginning.
+	 */
+	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2856_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2856_info, sizeof(*info));
+	info = &data->info;
+
+	/* Identify multiphase configuration for rail 2. */
+	ret = mp2856_identify_multiphase_rail2(client);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		/* Two rails are connected. */
+		data->info.pages = MP2856_PAGE_NUM;
+		data->info.phases[1] = ret;
+		data->info.func[1] = MP2856_RAIL2_FUNC;
+	}
+
+	ret = mp2856_identify_rails_vid(client, data, info);
+	if (ret < 0)
+		return ret;
+
+	/* Obtain offsets, maximum and format for vout. */
+	ret = mp2856_vout_per_rail_config_get(client, data, info);
+	if (ret)
+		return ret;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id mp2856_id[] = {
+	{"mp2856", 0},
+	{"mp2857", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, mp2856_id);
+
+static const struct of_device_id __maybe_unused mp2856_of_match[] = {
+	{.compatible = "mps,mp2856"},
+	{.compatible = "mps,mp2857"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2856_of_match);
+
+static struct i2c_driver mp2856_driver = {
+	.driver = {
+		.name = "mp2856",
+		.of_match_table = mp2856_of_match,
+	},
+	.probe = mp2856_probe,
+	.id_table = mp2856_id,
+};
+
+module_i2c_driver(mp2856_driver);
+
+MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP2856/MP2857 device");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1

