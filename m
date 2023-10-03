Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B097B6312
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbjJCICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJCIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:01:57 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED610A1;
        Tue,  3 Oct 2023 01:01:52 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3936q77d006789;
        Tue, 3 Oct 2023 04:01:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tf0tfcvx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:01:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39381UgJ027350
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Oct 2023 04:01:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 3 Oct 2023 04:01:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 3 Oct 2023 04:01:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 3 Oct 2023 04:01:29 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.194])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 393814N0012373;
        Tue, 3 Oct 2023 04:01:24 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 2/2] drivers: hwmon: ltc2991: add driver support
Date:   Tue, 3 Oct 2023 11:00:40 +0300
Message-ID: <20231003080059.8041-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003080059.8041-1-antoniu.miclaus@analog.com>
References: <20231003080059.8041-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: UpdYXxe3QVaMoZlMzaUeuJ0Vl1ziXSuY
X-Proofpoint-ORIG-GUID: UpdYXxe3QVaMoZlMzaUeuJ0Vl1ziXSuY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310030056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for LTC2991 Octal I2C Voltage, Current, and Temperature
Monitor.

The LTC2991 is used to monitor system temperatures, voltages and
currents. Through the I2C serial interface, the eight monitors can
individually measure supply voltages and can be paired for
differential measurements of current sense resistors or temperature
sensing transistors. Additional measurements include internal
temperature and internal VCC.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/ltc2991.rst |  43 +++
 MAINTAINERS                     |   8 +
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/ltc2991.c         | 479 ++++++++++++++++++++++++++++++++
 6 files changed, 543 insertions(+)
 create mode 100644 Documentation/hwmon/ltc2991.rst
 create mode 100644 drivers/hwmon/ltc2991.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 88dadea85cfc..0ec96abe3f7d 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -121,6 +121,7 @@ Hardware Monitoring Kernel Drivers
    ltc2947
    ltc2978
    ltc2990
+   ltc2991
    ltc3815
    ltc4151
    ltc4215
diff --git a/Documentation/hwmon/ltc2991.rst b/Documentation/hwmon/ltc2991.rst
new file mode 100644
index 000000000000..9ab29dd85012
--- /dev/null
+++ b/Documentation/hwmon/ltc2991.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver ltc2991
+=====================
+
+Supported chips:
+
+  * Analog Devices LTC2991
+
+    Prefix: 'ltc2991'
+
+    Addresses scanned: I2C 0x48 - 0x4f
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2991ff.pdf
+
+Authors:
+
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices LTC2991 Octal I2C
+Voltage, Current and Temperature Monitor.
+
+The LTC2991 is used to monitor system temperatures, voltages and currents.
+Through the I2C serial interface, the eight monitors can individually measure
+supply voltages and can be paired for differential measurements of current sense
+resistors or temperature sensing transistors. Additional measurements include
+internal temperatureand internal VCC.
+
+
+sysfs-Interface
+-------------
+
+The following attributes are supported. Limits are read-only.
+
+=============== =================
+inX_input:      voltage input
+currX_input:    current input
+tempX_input:    temperature input
+=============== =================
diff --git a/MAINTAINERS b/MAINTAINERS
index b19995690904..98dd8a8e1f84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12451,6 +12451,14 @@ F:	drivers/hwmon/ltc2947-i2c.c
 F:	drivers/hwmon/ltc2947-spi.c
 F:	drivers/hwmon/ltc2947.h
 
+LTC2991 HARDWARE MONITOR DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
+F:	drivers/hwmon/ltc2991.c
+
 LTC2983 IIO TEMPERATURE DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ec38c8892158..818a67328fcd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -932,6 +932,17 @@ config SENSORS_LTC2990
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2990.
 
+config SENSORS_LTC2991
+	tristate "Analog Devices LTC2991"
+	depends on I2C
+	help
+	  If you say yes here you get support for Analog Devices LTC2991
+	  Octal I2C Voltage, Current, and Temperature Monitor. The LTC2991
+	  supports a combination of voltage, current and temperature monitoring.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2991.
+
 config SENSORS_LTC2992
 	tristate "Linear Technology LTC2992"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4ac9452b5430..f324d057535a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_SENSORS_LTC2947)	+= ltc2947-core.o
 obj-$(CONFIG_SENSORS_LTC2947_I2C) += ltc2947-i2c.o
 obj-$(CONFIG_SENSORS_LTC2947_SPI) += ltc2947-spi.o
 obj-$(CONFIG_SENSORS_LTC2990)	+= ltc2990.o
+obj-$(CONFIG_SENSORS_LTC2991)	+= ltc2991.o
 obj-$(CONFIG_SENSORS_LTC2992)	+= ltc2992.o
 obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
 obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
new file mode 100644
index 000000000000..b5333c25cb31
--- /dev/null
+++ b/drivers/hwmon/ltc2991.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Analog Devices, Inc.
+ * Author: Antoniu Miclaus <antoniu.miclaus@analog.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <asm/unaligned.h>
+
+#define LTC2991_STATUS_LOW		0x00
+#define LTC2991_CH_EN_TRIGGER		0x01
+#define LTC2991_V1_V4_CTRL		0x06
+#define LTC2991_V5_V8_CTRL		0x07
+#define LTC2991_PWM_TH_LSB_T_INT	0x08
+#define LTC2991_PWM_TH_MSB		0x09
+#define LTC2991_CHANNEL_V_MSB(x)	(0x0A + ((x) * 2))
+#define LTC2991_CHANNEL_T_MSB(x)	(0x0A + ((x) * 4))
+#define LTC2991_CHANNEL_C_MSB(x)	(0x0C + ((x) * 4))
+#define LTC2991_T_INT_MSB		0x1A
+#define LTC2991_VCC_MSB			0x1C
+
+#define LTC2991_V7_V8_EN		BIT(7)
+#define LTC2991_V5_V6_EN		BIT(6)
+#define LTC2991_V3_V4_EN		BIT(5)
+#define LTC2991_V1_V2_EN		BIT(4)
+#define LTC2991_T_INT_VCC_EN		BIT(3)
+
+#define LTC2991_V3_V4_FILT_EN		BIT(7)
+#define LTC2991_V3_V4_TEMP_EN		BIT(5)
+#define LTC2991_V3_V4_DIFF_EN		BIT(4)
+#define LTC2991_V1_V2_FILT_EN		BIT(3)
+#define LTC2991_V1_V2_TEMP_EN		BIT(1)
+#define LTC2991_V1_V2_DIFF_EN		BIT(0)
+
+#define LTC2991_V7_V8_FILT_EN		BIT(7)
+#define LTC2991_V7_V8_TEMP_EN		BIT(5)
+#define LTC2991_V7_V8_DIFF_EN		BIT(4)
+#define LTC2991_V5_V6_FILT_EN		BIT(7)
+#define LTC2991_V5_V6_TEMP_EN		BIT(5)
+#define LTC2991_V5_V6_DIFF_EN		BIT(4)
+
+#define LTC2991_REPEAT_ACQ_EN		BIT(4)
+#define LTC2991_T_INT_FILT_EN		BIT(3)
+
+#define LTC2991_MAX_CHANNEL		4
+#define LTC2991_T_INT_CH_NR		4
+#define LTC2991_VCC_CH_NR		0
+
+static const char *const label_voltages[] = {
+	"vcc",
+	"voltage1",
+	"voltage2",
+	"voltage3",
+	"voltage4",
+	"voltage5",
+	"voltage6",
+	"voltage7",
+	"voltage8"
+};
+
+static const char *const label_temp[] = {
+	"t1",
+	"t2",
+	"t3",
+	"t4",
+	"t_int"
+};
+
+static const char *const label_curr[] = {
+	"v1-v2",
+	"v3-v4",
+	"v5-v6",
+	"v7-v8"
+};
+
+struct ltc2991_state {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	u32			r_sense_uohm[LTC2991_MAX_CHANNEL];
+	bool			temp_en[LTC2991_MAX_CHANNEL];
+};
+
+static int ltc2991_read_reg(struct ltc2991_state *st, u8 addr, u8 reg_len,
+			    int *val)
+{
+	u8 regvals[2];
+	int ret;
+
+	if (reg_len > 2 || !reg_len)
+		return -EINVAL;
+
+	ret = regmap_bulk_read(st->regmap, addr, regvals, reg_len);
+	if (ret)
+		return ret;
+
+	if (reg_len == 2)
+		*val = get_unaligned_be16(&regvals[0]);
+	else
+		*val = regvals[0];
+
+	return 0;
+}
+
+static int ltc2991_get_voltage(struct ltc2991_state *st, u32 reg, long *val)
+{
+	int reg_val, ret, offset = 0;
+
+	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg == LTC2991_VCC_MSB)
+		/* Vcc 2.5V offset */
+		offset = 2500;
+
+	/* Vx, 305.18uV/LSB */
+	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 30518,
+				 1000 * 100) + offset;
+
+	return 0;
+}
+
+static int ltc2991_read_in(struct device *dev, u32 attr, int channel, long *val)
+{
+	struct ltc2991_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_in_input:
+		if (channel == LTC2991_VCC_CH_NR)
+			reg = LTC2991_VCC_MSB;
+		else
+			reg = LTC2991_CHANNEL_V_MSB(channel - 1);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ltc2991_get_voltage(st, reg, val);
+}
+
+static int ltc2991_get_curr(struct ltc2991_state *st, u32 reg, int channel,
+			    long *val)
+{
+	int reg_val, ret;
+
+	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
+	if (ret)
+		return ret;
+
+	/* Vx-Vy, 19.075uV/LSB */
+	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 14) * 19075, 1000)
+				 / (st->r_sense_uohm[channel] / 1000);
+
+	return 0;
+}
+
+static int ltc2991_read_curr(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	struct ltc2991_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_curr_input:
+		reg = LTC2991_CHANNEL_C_MSB(channel);
+		return ltc2991_get_curr(st, reg, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ltc2991_get_temp(struct ltc2991_state *st, u32 reg, int channel,
+			    long *val)
+{
+	int reg_val, ret;
+
+	ret = ltc2991_read_reg(st, reg, 2, &reg_val);
+	if (ret)
+		return ret;
+
+	/* Temp LSB = 0.0625 Degrees */
+	*val = DIV_ROUND_CLOSEST(sign_extend32(reg_val, 12) * 1000, 16);
+
+	return 0;
+}
+
+static int ltc2991_read_temp(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	struct ltc2991_state *st = dev_get_drvdata(dev);
+	u32 reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		if (channel == LTC2991_T_INT_CH_NR)
+			reg = LTC2991_T_INT_MSB;
+		else
+			reg = LTC2991_CHANNEL_T_MSB(channel);
+
+		return ltc2991_get_temp(st, reg, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ltc2991_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_in:
+		return ltc2991_read_in(dev, attr, channel, val);
+	case hwmon_curr:
+		return ltc2991_read_curr(dev, attr, channel, val);
+	case hwmon_temp:
+		return ltc2991_read_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t ltc2991_is_visible(const void *data,
+				  enum hwmon_sensor_types type, u32 attr,
+				  int channel)
+{
+	const struct ltc2991_state *st = data;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_label:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_curr_label:
+			if (st->r_sense_uohm[channel])
+				return 0444;
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_label:
+			if (st->temp_en[channel] ||
+			    channel == LTC2991_T_INT_CH_NR)
+				return 0444;
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int ltc2991_read_string(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_temp:
+		*str = label_temp[channel];
+		break;
+	case hwmon_curr:
+		*str = label_curr[channel];
+		break;
+	case hwmon_in:
+		*str = label_voltages[channel];
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops ltc2991_hwmon_ops = {
+	.is_visible = ltc2991_is_visible,
+	.read = ltc2991_read,
+	.read_string = ltc2991_read_string,
+};
+
+static const struct hwmon_channel_info *ltc2991_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL
+			   ),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL
+			   ),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL
+			   ),
+	NULL
+};
+
+static const struct hwmon_chip_info ltc2991_chip_info = {
+	.ops = &ltc2991_hwmon_ops,
+	.info = ltc2991_info,
+};
+
+static const struct regmap_config ltc2991_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x1D,
+};
+
+static int ltc2991_init(struct ltc2991_state *st)
+{
+	struct fwnode_handle *child;
+	int ret;
+	u32 val, addr;
+	u8 v5_v8_reg_data = 0, v1_v4_reg_data = 0;
+
+	ret = devm_regulator_get_enable(&st->client->dev, "vcc");
+	if (ret)
+		return dev_err_probe(&st->client->dev, ret,
+				     "failed to enable regulator\n");
+
+	device_for_each_child_node(&st->client->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &addr);
+		if (ret < 0) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+
+		if (addr > 3) {
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+
+		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms", &val);
+		if (!ret) {
+			st->r_sense_uohm[addr] = val;
+			switch (addr) {
+			case 0:
+				v1_v4_reg_data |= LTC2991_V1_V2_DIFF_EN;
+				break;
+			case 1:
+				v1_v4_reg_data |= LTC2991_V3_V4_DIFF_EN;
+				break;
+			case 2:
+				v5_v8_reg_data |= LTC2991_V5_V6_DIFF_EN;
+				break;
+			case 3:
+				v5_v8_reg_data |= LTC2991_V7_V8_DIFF_EN;
+				break;
+			default:
+				break;
+			}
+		}
+
+		ret = fwnode_property_read_bool(child, "adi,temperature-enable");
+		if (ret) {
+			st->temp_en[addr] = ret;
+			switch (addr) {
+			case 0:
+				v1_v4_reg_data |= LTC2991_V1_V2_TEMP_EN;
+				break;
+			case 1:
+				v1_v4_reg_data |= LTC2991_V3_V4_TEMP_EN;
+				break;
+			case 2:
+				v5_v8_reg_data |= LTC2991_V5_V6_TEMP_EN;
+				break;
+			case 3:
+				v5_v8_reg_data |= LTC2991_V7_V8_TEMP_EN;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	ret = regmap_write(st->regmap, LTC2991_V5_V8_CTRL, v5_v8_reg_data);
+	if (ret)
+		return dev_err_probe(&st->client->dev, ret,
+				     "Error: Failed to set V5-V8 CTRL reg.\n");
+
+	ret = regmap_write(st->regmap, LTC2991_V1_V4_CTRL, v1_v4_reg_data);
+	if (ret)
+		return dev_err_probe(&st->client->dev, ret,
+				     "Error: Failed to set V1-V4 CTRL reg.\n");
+
+	ret = regmap_write(st->regmap, LTC2991_PWM_TH_LSB_T_INT,
+			   LTC2991_REPEAT_ACQ_EN);
+	if (ret)
+		return dev_err_probe(&st->client->dev, ret,
+				     "Error: Failed to set contiuous mode.\n");
+
+	/* Enable all channels and trigger conversions */
+	return regmap_write(st->regmap, LTC2991_CH_EN_TRIGGER,
+			    LTC2991_V7_V8_EN | LTC2991_V5_V6_EN |
+			    LTC2991_V3_V4_EN | LTC2991_V1_V2_EN |
+			    LTC2991_T_INT_VCC_EN);
+}
+
+static int ltc2991_i2c_probe(struct i2c_client *client)
+{
+	int ret;
+	struct device *hwmon_dev;
+	struct ltc2991_state *st;
+
+	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->client = client;
+	st->regmap = devm_regmap_init_i2c(client, &ltc2991_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ltc2991_init(st);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev,
+							 client->name, st,
+							 &ltc2991_chip_info,
+							 NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct of_device_id ltc2991_of_match[] = {
+	{ .compatible = "adi,ltc2991" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2991_of_match);
+
+static const struct i2c_device_id ltc2991_i2c_id[] = {
+	{ "ltc2991", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ltc2991_i2c_id);
+
+static struct i2c_driver ltc2991_i2c_driver = {
+	.driver = {
+		.name = "ltc2991",
+		.of_match_table = ltc2991_of_match,
+	},
+	.probe = ltc2991_i2c_probe,
+	.id_table = ltc2991_i2c_id,
+};
+
+module_i2c_driver(ltc2991_i2c_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2991 HWMON Driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0

