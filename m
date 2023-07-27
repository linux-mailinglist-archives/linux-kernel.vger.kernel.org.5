Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F0C765C62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjG0TtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjG0TtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:04 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AE30DB;
        Thu, 27 Jul 2023 12:48:58 -0700 (PDT)
Received: from [2001:a61:6209:7f01:c80a:ff:fe00:19d] (helo=cs-wrt.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpa
        id 1qP6yk-0001K4-Fn; Thu, 27 Jul 2023 21:48:54 +0200
From:   =?UTF-8?q?Carsten=20Spie=C3=9F?= <mail@carsten-spiess.de>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Carsten=20Spie=C3=9F?= <mail@carsten-spiess.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (isl28022) new driver for ISL28022 power monitor
Date:   Thu, 27 Jul 2023 21:48:12 +0200
Message-Id: <20230727194813.2245116-2-mail@carsten-spiess.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727194813.2245116-1-mail@carsten-spiess.de>
References: <20230727194813.2245116-1-mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690487338;08bc3630;
X-HE-SMSGID: 1qP6yk-0001K4-Fn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for Renesas ISL28022 power monitor with I2C interface.
The device monitors voltage, current via shunt resistor
and calculated power.

Signed-off-by: Carsten Spieß <mail@carsten-spiess.de>
---
 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/isl28022.rst |  63 ++++
 MAINTAINERS                      |   7 +
 drivers/hwmon/Kconfig            |  11 +
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/isl28022.c         | 496 +++++++++++++++++++++++++++++++
 6 files changed, 579 insertions(+)
 create mode 100644 Documentation/hwmon/isl28022.rst
 create mode 100644 drivers/hwmon/isl28022.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index d11924667f76..c9548fc5c40e 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -90,6 +90,7 @@ Hardware Monitoring Kernel Drivers
    ir35221
    ir38064
    ir36021
+   isl28022
    isl68137
    it87
    jc42
diff --git a/Documentation/hwmon/isl28022.rst b/Documentation/hwmon/isl28022.rst
new file mode 100644
index 000000000000..8d4422a2dacd
--- /dev/null
+++ b/Documentation/hwmon/isl28022.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver isl28022
+======================
+
+Supported chips:
+
+  * Renesas ISL28022
+
+    Prefix: 'isl28022'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the Renesas website
+
+	       https://www.renesas.com/us/en/www/doc/datasheet/isl28022.pdf
+
+Author:
+    Carsten Spieß <mail@carsten-spiess.de>
+
+Description
+-----------
+
+The ISL28022 is a power monitor with I2C interface. The device monitors
+voltage, current via shunt resistor and calculated power.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+device explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+The shunt value in micro-ohms, shunt voltage range and averaging can be set
+with device properties.
+Please refer to the Documentation/devicetree/bindings/hwmon/isl,isl28022.yaml
+for bindings if the device tree is used.
+
+The driver supports only shunt and bus continuous ADC mode at 15bit resolution.
+Averaging can be set from 1 to 128 samples (power of 2) on both channels.
+Shunt voltage range of 40, 80, 160 or 320mV is allowed
+The bus voltage range is 60V fixed.
+
+Sysfs entries
+-------------
+
+The following attributes are supported. All attributes are read-only.
+
+======================= =======================================================
+in0_input		bus voltage (milli Volt)
+
+curr1_input		current (milli Ampere)
+power1_input		power (micro Watt)
+======================= =======================================================
+
+Debugfs entries
+---------------
+
+The following attributes are supported. All attributes are read-only.
+
+======================= =======================================================
+shunt_voltage		shunt voltage (micro Volt)
+======================= =======================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 7abb5710e1bb..b02e3b991676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11065,6 +11065,13 @@ F:	drivers/isdn/Makefile
 F:	drivers/isdn/hardware/
 F:	drivers/isdn/mISDN/
 
+ISL28022 HARDWARE MONITORING DRIVER
+M:	Carsten Spieß <mail@carsten-spiess.de>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/isl28022.rst
+F:	drivers/hwmon/isl28022.c
+
 ISOFS FILESYSTEM
 M:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2913299c2c9e..3049c519e6ac 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -800,6 +800,17 @@ config SENSORS_CORETEMP
 	  sensor inside your CPU. Most of the family 6 CPUs
 	  are supported. Check Documentation/hwmon/coretemp.rst for details.
 
+config SENSORS_ISL28022
+	tristate "Renesas ISL28022"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for ISL28022 power monitor.
+	  Check Documentation/hwmon/isl28022.rst for details.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called isl28022.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on !PPC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index ff6bfd109c72..4046fed7f48d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_INA238)	+= ina238.o
 obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
 obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
+obj-$(CONFIG_SENSORS_ISL28022)	+= isl28022.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
diff --git a/drivers/hwmon/isl28022.c b/drivers/hwmon/isl28022.c
new file mode 100644
index 000000000000..18b4481d5ff6
--- /dev/null
+++ b/drivers/hwmon/isl28022.c
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * isl28022.c - driver for Renesas ISL28022 power monitor chip monitoring
+ *
+ * Copyright (c) 2023 Carsten Spieß <mail@carsten-spiess.de>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/util_macros.h>
+#include <linux/regulator/consumer.h>
+
+/* ISL28022 registers */
+#define ISL28022_REG_CONFIG	0x00
+#define ISL28022_REG_SHUNT	0x01
+#define ISL28022_REG_BUS	0x02
+#define ISL28022_REG_POWER	0x03
+#define ISL28022_REG_CURRENT	0x04
+#define ISL28022_REG_CALIB	0x05
+#define ISL28022_REG_SHUNT_THR	0x06
+#define ISL28022_REG_BUS_THR	0x07
+#define ISL28022_REG_INT	0x08
+#define ISL28022_REG_AUX	0x09
+#define ISL28022_REG_MAX	ISL28022_REG_AUX
+
+/* ISL28022 config flags */
+/* mode flags */
+#define ISL28022_MODE_SHIFT	0
+#define ISL28022_MODE_MASK	0x0007
+
+#define ISL28022_MODE_PWR_DOWN	0x0
+#define ISL28022_MODE_TRG_S	0x1
+#define ISL28022_MODE_TRG_B	0x2
+#define ISL28022_MODE_TRG_SB	0x3
+#define ISL28022_MODE_ADC_OFF	0x4
+#define ISL28022_MODE_CONT_S	0x5
+#define ISL28022_MODE_CONT_B	0x6
+#define ISL28022_MODE_CONT_SB	0x7
+
+/* shunt ADC settings */
+#define ISL28022_SADC_SHIFT	3
+#define ISL28022_SADC_MASK	0x0078
+
+#define ISL28022_BADC_SHIFT	7
+#define ISL28022_BADC_MASK	0x0780
+
+#define ISL28022_ADC_12		0x0	/* 12 bit ADC */
+#define ISL28022_ADC_13		0x1	/* 13 bit ADC */
+#define ISL28022_ADC_14		0x2	/* 14 bit ADC */
+#define ISL28022_ADC_15		0x3	/* 15 bit ADC */
+#define ISL28022_ADC_15_1	0x8	/* 15 bit ADC, 1 sample */
+#define ISL28022_ADC_15_2	0x9	/* 15 bit ADC, 2 samples */
+#define ISL28022_ADC_15_4	0xA	/* 15 bit ADC, 4 samples */
+#define ISL28022_ADC_15_8	0xB	/* 15 bit ADC, 8 samples */
+#define ISL28022_ADC_15_16	0xC	/* 15 bit ADC, 16 samples */
+#define ISL28022_ADC_15_32	0xD	/* 15 bit ADC, 32 samples */
+#define ISL28022_ADC_15_64	0xE	/* 15 bit ADC, 64 samples */
+#define ISL28022_ADC_15_128	0xF	/* 15 bit ADC, 128 samples */
+
+/* shunt voltage range */
+#define ISL28022_PG_SHIFT	11
+#define ISL28022_PG_MASK	0x1800
+
+#define ISL28022_PG_40		0x0	/* +/-40 mV */
+#define ISL28022_PG_80		0x1	/* +/-80 mV */
+#define ISL28022_PG_160		0x2	/* +/-160 mV */
+#define ISL28022_PG_320		0x3	/* +/-3200 mV */
+
+/* bus voltage range */
+#define ISL28022_BRNG_SHIFT	13
+#define ISL28022_BRNG_MASK	0x6000
+
+#define ISL28022_BRNG_16	0x0	/* 16 V */
+#define ISL28022_BRNG_32	0x1	/* 32 V */
+#define ISL28022_BRNG_60	0x3	/* 60 V */
+
+/* reset */
+#define ISL28022_RESET		0x8000
+
+struct isl28022_data {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*debugfs;
+#endif
+	u32			shunt;
+	u32			gain;
+	u32			average;
+	u16			config;
+	u16			calib;
+};
+
+static int isl28022_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct isl28022_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	int err;
+
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			err = regmap_read(data->regmap,
+					  ISL28022_REG_BUS, &regval);
+			if (err < 0)
+				return err;
+			/* driver supports only 60V mode (BRNG 11) */
+			*val = (long)(((u16)regval) & 0xFFFC);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			err = regmap_read(data->regmap,
+					  ISL28022_REG_CURRENT, &regval);
+			if (err < 0)
+				return err;
+			*val = ((long)regval * 1250L * (long)data->gain) /
+				(long)data->shunt;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			err = regmap_read(data->regmap,
+					  ISL28022_REG_POWER, &regval);
+			if (err < 0)
+				return err;
+			*val = ((51200000L * ((long)data->gain)) /
+				(long)data->shunt) * (long)regval;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static umode_t isl28022_is_visible(const void *data, enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			return 0444;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			return 0444;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			return 0444;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *isl28022_info[] = {
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT),	/* channel 0: bus voltage (mV) */
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT),	/* channel 1: current (mA) */
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT),	/* channel 1: power (µW) */
+	NULL
+};
+
+static const struct hwmon_ops isl28022_hwmon_ops = {
+	.is_visible = isl28022_is_visible,
+	.read = isl28022_read,
+};
+
+static const struct hwmon_chip_info isl28022_chip_info = {
+	.ops = &isl28022_hwmon_ops,
+	.info = isl28022_info,
+};
+
+static bool isl28022_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL28022_REG_CONFIG:
+	case ISL28022_REG_CALIB:
+	case ISL28022_REG_SHUNT_THR:
+	case ISL28022_REG_BUS_THR:
+	case ISL28022_REG_INT:
+	case ISL28022_REG_AUX:
+		return true;
+	}
+
+	return false;
+}
+
+static bool isl28022_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL28022_REG_CONFIG:
+	case ISL28022_REG_SHUNT:
+	case ISL28022_REG_BUS:
+	case ISL28022_REG_POWER:
+	case ISL28022_REG_CURRENT:
+	case ISL28022_REG_INT:
+	case ISL28022_REG_AUX:
+		return true;
+	}
+	return true;
+}
+
+static const struct regmap_config isl28022_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = ISL28022_REG_MAX,
+	.writeable_reg = isl28022_is_writeable_reg,
+	.volatile_reg = isl28022_is_volatile_reg,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static const struct i2c_device_id isl28022_ids[] = {
+	{ "isl28022", 0},
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, isl28022_ids);
+
+#ifdef CONFIG_DEBUG_FS
+static int shunt_voltage_show(struct seq_file *seqf, void *unused)
+{
+	struct isl28022_data *data = seqf->private;
+	unsigned int regval;
+	int err;
+
+	err = regmap_read(data->regmap,
+			  ISL28022_REG_SHUNT, &regval);
+	if (err)
+		return err;
+
+	/* print shunt voltage in micro volt  */
+	seq_printf(seqf, "%d\n", regval * 10);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(shunt_voltage);
+
+static struct dentry *isl28022_debugfs_root;
+
+static void isl28022_debugfs_remove(void *res)
+{
+	debugfs_remove_recursive(res);
+}
+
+static int isl28022_debugfs_init(struct isl28022_data *data)
+{
+	char name[16];
+	int err;
+	struct dentry *entry;
+
+	scnprintf(name, sizeof(name), "%d-%04hx", data->client->adapter->nr, data->client->addr);
+
+	data->debugfs = debugfs_create_dir(name, isl28022_debugfs_root);
+	if (IS_ERR(data->debugfs))
+		return PTR_ERR(data->debugfs);
+
+	err = devm_add_action_or_reset(&data->client->dev, isl28022_debugfs_remove, data->debugfs);
+	if (err)
+		return err;
+
+	entry = debugfs_create_file("shunt_voltage", 0444, data->debugfs, data,
+			    &shunt_voltage_fops);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS*/
+
+/*
+ * read property values and make consistency checks.
+ *
+ * following values for shunt range and resistor are allowed:
+ *   40 mV -> gain 1, shunt min.  800 micro ohms
+ *   80 mV -> gain 2, shunt min. 1600 micro ohms
+ *  160 mV -> gain 4, shunt min. 3200 micro ohms
+ *  320 mV -> gain 8, shunt min. 6400 micro ohms
+ */
+static int isl28022_read_properties(struct device *dev, struct isl28022_data *data)
+{
+	u32 val;
+	int err;
+
+	err = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &val);
+	if (err == -ENODATA)
+		val = 10000;
+	else if (err < 0)
+		return err;
+	data->shunt = val;
+
+	err = device_property_read_u32(dev, "renesas,shunt-range-microvolt", &val);
+	if (err == -ENODATA)
+		val = 320000;
+	else if (err < 0)
+		return err;
+	switch (val) {
+	case 40000:
+		data->gain = 1;
+		if (data->shunt < 800)
+			goto shunt_invalid;
+		break;
+	case 80000:
+		data->gain = 2;
+		if (data->shunt < 1600)
+			goto shunt_invalid;
+		break;
+	case 160000:
+		data->gain = 4;
+		if (data->shunt < 3200)
+			goto shunt_invalid;
+		break;
+	case 320000:
+		data->gain = 8;
+		if (data->shunt < 6400)
+			goto shunt_invalid;
+		break;
+	default:
+		dev_err(dev, "renesas,shunt-range-microvolt invalid value %d\n", val);
+		return -EINVAL;
+	}
+
+	err = device_property_read_u32(dev, "renesas,average-samples", &val);
+	if (err == -ENODATA)
+		val = 1;
+	else if (err < 0)
+		return err;
+	if ((val > 128) || (BIT(__ffs(val)) != val)) {
+		dev_err(dev, "renesas,average-samples invalid value %d\n", val);
+		return -EINVAL;
+	}
+	data->average = val;
+
+	return 0;
+
+shunt_invalid:
+	dev_err(dev, "renesas,shunt-resistor-microvolt invalid value %d\n", data->shunt);
+	return -EINVAL;
+}
+
+/*
+ * write configuration and calibration registers
+ *
+ * The driver supports only shunt and bus continuous ADC mode at 15bit resolution
+ * with averaging from 1 to 128 samples (pow of 2) on both channels.
+ * Shunt voltage gain 1,2,4 or 8 is allowed.
+ * The bus voltage range is 60V fixed.
+ */
+static int isl28022_config(struct isl28022_data *data)
+{
+	int err;
+
+	data->config = (ISL28022_MODE_CONT_SB << ISL28022_MODE_SHIFT) |
+			(ISL28022_BRNG_60 << ISL28022_BRNG_SHIFT) |
+			(__ffs(data->gain) << ISL28022_PG_SHIFT) |
+			((ISL28022_ADC_15_1 + __ffs(data->average)) << ISL28022_SADC_SHIFT) |
+			((ISL28022_ADC_15_1 + __ffs(data->average)) << ISL28022_BADC_SHIFT);
+
+	data->calib = data->shunt ? 0x8000 / data->gain : 0;
+
+	err = regmap_write(data->regmap, ISL28022_REG_CONFIG, data->config);
+	if (err < 0)
+		return err;
+
+	err = regmap_write(data->regmap, ISL28022_REG_CALIB, data->calib);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int isl28022_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct isl28022_data *data;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	data = devm_kzalloc(dev, sizeof(struct isl28022_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+
+	err = isl28022_read_properties(dev, data);
+	if (err)
+		return err;
+
+	data->regmap = devm_regmap_init_i2c(client, &isl28022_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	err = isl28022_config(data);
+	if (err)
+		return err;
+
+#ifdef CONFIG_DEBUG_FS
+	err = isl28022_debugfs_init(data);
+	if (err)
+		return err;
+#endif
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "isl28022_hwmon",
+							 data, &isl28022_chip_info, NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused isl28022_of_match[] = {
+	{ .compatible = "renesas,isl28022"},
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(of, isl28022_of_match);
+
+static struct i2c_driver isl28022_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "isl28022",
+	},
+	.probe_new	= isl28022_probe,
+	.id_table	= isl28022_ids,
+};
+
+#ifdef CONFIG_DEBUG_FS
+static int __init
+isl28022_init(void)
+{
+	int err;
+
+	isl28022_debugfs_root = debugfs_create_dir("isl28022", NULL);
+	err = i2c_add_driver(&isl28022_driver);
+	if (!err)
+		return 0;
+
+	debugfs_remove_recursive(isl28022_debugfs_root);
+	return err;
+}
+
+static void __exit
+isl28022_exit(void)
+{
+	i2c_del_driver(&isl28022_driver);
+	debugfs_remove_recursive(isl28022_debugfs_root);
+}
+
+module_init(isl28022_init);
+module_exit(isl28022_exit);
+#else /* CONFIG_DEBUG_FS */
+module_i2c_driver(isl28022_driver);
+#endif /* CONFIG_DEBUG_FS */
+
+MODULE_AUTHOR("Carsten Spieß <mail@carsten-spiess.de>");
+MODULE_DESCRIPTION("ISL28022 driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

