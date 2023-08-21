Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9165782208
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 05:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHUDyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 23:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHUDyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 23:54:20 -0400
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB98E;
        Sun, 20 Aug 2023 20:54:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436301|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00601071-0.000366896-0.993622;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=like@awinic.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.ULtK41Q_1692590046;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.ULtK41Q_1692590046)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 11:54:09 +0800
From:   like@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com,
        wangweidong.a@awinic.com, Alec Li <like@awinic.com>
Subject: [PATCH v5 1/2] regulator: aw37503: add regulator driver for Awinic AW37503
Date:   Mon, 21 Aug 2023 03:53:54 +0000
Message-ID: <20230821035355.1269976-2-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821035355.1269976-1-like@awinic.com>
References: <20230821035355.1269976-1-like@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alec Li <like@awinic.com>

Add regulator driver for the device Awinic AW37503 which is single
inductor - dual output power supply device. AW37503 device is
designed to support general positive/negative driven applications
like TFT display panels.

AW37503 regulator driver supports to enable/disable and set voltage
on its output.

Signed-off-by: Alec Li <like@awinic.com>
---
 drivers/regulator/Kconfig             |   8 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/aw37503-regulator.c | 240 ++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/regulator/aw37503-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 823f8e6e4801..62756526cfa2 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -178,6 +178,14 @@ config REGULATOR_ATC260X
 	  ATC260x PMICs. This will enable support for all the software
 	  controllable DCDC/LDO regulators.
 
+config REGULATOR_AW37503
+	tristate "Awinic AW37503 Dual Output Power regulators"
+	depends on I2C && GPIOLIB
+	select REGMAP_I2C
+	help
+	  This driver supports AW37503 single inductor - dual output
+	  power supply specifically designed for display panels.
+
 config REGULATOR_AXP20X
 	tristate "X-POWERS AXP20X PMIC Regulators"
 	depends on MFD_AXP20X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 15e0d614ff66..f0e5cf7350a4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_REGULATOR_ARM_SCMI) += scmi-regulator.o
 obj-$(CONFIG_REGULATOR_AS3711) += as3711-regulator.o
 obj-$(CONFIG_REGULATOR_AS3722) += as3722-regulator.o
 obj-$(CONFIG_REGULATOR_ATC260X) += atc260x-regulator.o
+obj-$(CONFIG_REGULATOR_AW37503) += aw37503-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) += axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) += bcm590xx-regulator.o
 obj-$(CONFIG_REGULATOR_BD71815)	+= bd71815-regulator.o
diff --git a/drivers/regulator/aw37503-regulator.c b/drivers/regulator/aw37503-regulator.c
new file mode 100644
index 000000000000..e01ef6ad3eb8
--- /dev/null
+++ b/drivers/regulator/aw37503-regulator.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// AWINIC AW37503 Regulator Driver
+//
+// Copyright (C) 2023 awinic. All Rights Reserved
+//
+// Author: <like@awinic.com>
+
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define AW37503_REG_VPOS		0x00
+#define AW37503_REG_VNEG		0x01
+#define AW37503_REG_APPS		0x03
+#define AW37503_REG_CONTROL		0x04
+#define AW37503_REG_WPRTEN		0x21
+
+#define AW37503_VOUT_MASK		0x1F
+#define AW37503_VOUT_N_VOLTAGE		0x15
+#define AW37503_VOUT_VMIN		4000000
+#define AW37503_VOUT_VMAX		6000000
+#define AW37503_VOUT_STEP		100000
+
+#define AW37503_REG_APPS_DIS_VPOS	BIT(1)
+#define AW37503_REG_APPS_DIS_VNEG	BIT(0)
+
+#define AW37503_REGULATOR_ID_VPOS	0
+#define AW37503_REGULATOR_ID_VNEG	1
+#define AW37503_MAX_REGULATORS		2
+
+struct aw37503_reg_pdata {
+	struct gpio_desc *en_gpiod;
+	int ena_gpio_state;
+};
+
+struct aw37503_regulator {
+	struct device *dev;
+	struct aw37503_reg_pdata reg_pdata[AW37503_MAX_REGULATORS];
+};
+
+static int aw37503_regulator_enable(struct regulator_dev *rdev)
+{
+	struct aw37503_regulator *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	struct aw37503_reg_pdata *rpdata = &chip->reg_pdata[id];
+	int ret;
+
+	if (!IS_ERR(rpdata->en_gpiod)) {
+		gpiod_set_value_cansleep(rpdata->en_gpiod, 1);
+		rpdata->ena_gpio_state = 1;
+	}
+
+	/* Hardware automatically enable discharge bit in enable */
+	if (rdev->constraints->active_discharge ==
+			REGULATOR_ACTIVE_DISCHARGE_DISABLE) {
+		ret = regulator_set_active_discharge_regmap(rdev, false);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to disable active discharge: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aw37503_regulator_disable(struct regulator_dev *rdev)
+{
+	struct aw37503_regulator *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	struct aw37503_reg_pdata *rpdata = &chip->reg_pdata[id];
+
+	if (!IS_ERR(rpdata->en_gpiod)) {
+		gpiod_set_value_cansleep(rpdata->en_gpiod, 0);
+		rpdata->ena_gpio_state = 0;
+	}
+
+	return 0;
+}
+
+static int aw37503_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct aw37503_regulator *chip = rdev_get_drvdata(rdev);
+	int id = rdev_get_id(rdev);
+	struct aw37503_reg_pdata *rpdata = &chip->reg_pdata[id];
+
+	if (!IS_ERR(rpdata->en_gpiod))
+		return rpdata->ena_gpio_state;
+
+	return 1;
+}
+
+static const struct regulator_ops aw37503_regulator_ops = {
+	.enable = aw37503_regulator_enable,
+	.disable = aw37503_regulator_disable,
+	.is_enabled = aw37503_regulator_is_enabled,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+};
+
+static int aw37503_of_parse_cb(struct device_node *np,
+				const struct regulator_desc *desc,
+				struct regulator_config *config)
+{
+	struct aw37503_regulator *chip = config->driver_data;
+	struct aw37503_reg_pdata *rpdata = &chip->reg_pdata[desc->id];
+	int ret;
+
+	rpdata->en_gpiod = devm_fwnode_gpiod_get(chip->dev, of_fwnode_handle(np),
+						 "enable", GPIOD_OUT_LOW,
+						 "enable");
+
+	if (IS_ERR(rpdata->en_gpiod)) {
+		ret = PTR_ERR(rpdata->en_gpiod);
+
+		/* Ignore the error other than probe defer */
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		return 0;
+	}
+
+	return 0;
+}
+
+#define AW37503_REGULATOR_DESC(_id, _name)		\
+	[AW37503_REGULATOR_ID_##_id] = {		\
+		.name = "aw37503-"#_name,		\
+		.supply_name = "vin",			\
+		.id = AW37503_REGULATOR_ID_##_id,	\
+		.of_match = of_match_ptr(#_name),	\
+		.of_parse_cb = aw37503_of_parse_cb,	\
+		.ops = &aw37503_regulator_ops,		\
+		.n_voltages = AW37503_VOUT_N_VOLTAGE,	\
+		.min_uV = AW37503_VOUT_VMIN,		\
+		.uV_step = AW37503_VOUT_STEP,		\
+		.enable_time = 500,			\
+		.vsel_mask = AW37503_VOUT_MASK,	\
+		.vsel_reg = AW37503_REG_##_id,		\
+		.active_discharge_off = 0,			\
+		.active_discharge_on = AW37503_REG_APPS_DIS_##_id, \
+		.active_discharge_mask = AW37503_REG_APPS_DIS_##_id, \
+		.active_discharge_reg = AW37503_REG_APPS, \
+		.type = REGULATOR_VOLTAGE,		\
+		.owner = THIS_MODULE,			\
+	}
+
+static const struct regulator_desc aw_regs_desc[AW37503_MAX_REGULATORS] = {
+	AW37503_REGULATOR_DESC(VPOS, outp),
+	AW37503_REGULATOR_DESC(VNEG, outn),
+};
+
+static const struct regmap_range aw37503_no_reg_ranges[] = {
+	regmap_reg_range(AW37503_REG_CONTROL + 1,
+			 AW37503_REG_WPRTEN - 1),
+};
+
+static const struct regmap_access_table aw37503_no_reg_table = {
+	.no_ranges = aw37503_no_reg_ranges,
+	.n_no_ranges = ARRAY_SIZE(aw37503_no_reg_ranges),
+};
+
+static const struct regmap_config aw37503_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= AW37503_REG_WPRTEN,
+	.rd_table	= &aw37503_no_reg_table,
+	.wr_table	= &aw37503_no_reg_table,
+};
+
+static int aw37503_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct aw37503_regulator *chip;
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	struct regulator_config config = { };
+	int id;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &aw37503_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init regmap\n");
+
+	i2c_set_clientdata(client, chip);
+	chip->dev = dev;
+
+	config.regmap = regmap;
+	config.dev = dev;
+	config.driver_data = chip;
+
+	for (id = 0; id < AW37503_MAX_REGULATORS; ++id) {
+		rdev = devm_regulator_register(dev, &aw_regs_desc[id],
+					       &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register regulator %s\n",
+					     aw_regs_desc[id].name);
+	}
+	return 0;
+}
+
+static const struct i2c_device_id aw37503_id[] = {
+	{.name = "aw37503",},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, aw37503_id);
+
+static const struct of_device_id aw37503_of_match[] = {
+	{.compatible = "awinic,aw37503",},
+	{ /* Sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, aw37503_of_match);
+
+static struct i2c_driver aw37503_i2c_driver = {
+	.driver = {
+		.name = "aw37503",
+		.of_match_table = aw37503_of_match,
+	},
+	.probe_new = aw37503_probe,
+	.id_table = aw37503_id,
+};
+
+module_i2c_driver(aw37503_i2c_driver);
+
+MODULE_DESCRIPTION("aw37503 regulator driver");
+MODULE_AUTHOR("Alec Li <like@awinic.com>");
+MODULE_LICENSE("GPL");
-- 
2.41.0

