Return-Path: <linux-kernel+bounces-12554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C581F6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6321F28565D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F97466;
	Thu, 28 Dec 2023 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="ODPP343F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370D8464;
	Thu, 28 Dec 2023 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id B1ADD28C555;
	Thu, 28 Dec 2023 11:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55juLIzJETlAD2Iq4uSnuKyEBEzVTLSn40txIVsTBic=;
	b=ODPP343FJe4z0PNypV3FeCEo0gUBBcaoNjsV33Mq5BtNXuOkdqfdJGinGTm949IjRtCPrx
	d6YVr/o43xxpGmwPHH/RfinviECfsbXAw87TXmS6OsaQe69Jyg+OQJVJMUj2lR3w5Bc9ZS
	P92X8kRaa/E/UcQZicZ1Swmxv5zHCPM=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 8CB134423CE;
	Thu, 28 Dec 2023 11:02:35 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 4/5] regulator: add 88pm88x regulators driver
Date: Thu, 28 Dec 2023 10:39:13 +0100
Message-ID: <20231228100208.2932-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Support the LDO and buck regulators of the Marvell 88PM886 PMIC. Support
for 88PM880 is not included but should be easy to implement being just a
matter of defining the additional LDOs and all bucks and modifying the
88PM88X MFD driver appropriately.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/mfd/88pm88x.c                 |  15 ++
 drivers/regulator/88pm88x-regulator.c | 214 ++++++++++++++++++++++++++
 drivers/regulator/Kconfig             |   6 +
 drivers/regulator/Makefile            |   1 +
 include/linux/mfd/88pm88x.h           |  11 ++
 5 files changed, 247 insertions(+)
 create mode 100644 drivers/regulator/88pm88x-regulator.c

diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
index 69a8e39d43b3..999d0539b720 100644
--- a/drivers/mfd/88pm88x.c
+++ b/drivers/mfd/88pm88x.c
@@ -68,6 +68,21 @@ static struct mfd_cell pm886_devs[] = {
 		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
 		.resources = pm88x_onkey_resources,
 	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM88X_REGULATOR_ID_LDO2,
+		.of_compatible = "marvell,88pm88x-regulator",
+	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM88X_REGULATOR_ID_LDO15,
+		.of_compatible = "marvell,88pm88x-regulator",
+	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM886_REGULATOR_ID_BUCK2,
+		.of_compatible = "marvell,88pm88x-regulator",
+	},
 };
 
 static struct pm88x_data pm886_a1_data = {
diff --git a/drivers/regulator/88pm88x-regulator.c b/drivers/regulator/88pm88x-regulator.c
new file mode 100644
index 000000000000..8b55e1365387
--- /dev/null
+++ b/drivers/regulator/88pm88x-regulator.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/container_of.h>
+#include <linux/kernel.h>
+#include <linux/linear_range.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/mfd/88pm88x.h>
+
+#define PM88X_REG_LDO_EN1		0x09
+#define PM88X_REG_LDO_EN2		0x0a
+
+#define PM88X_REG_BUCK_EN		0x08
+
+#define PM88X_REG_LDO1_VOUT		0x20
+#define PM88X_REG_LDO2_VOUT		0x26
+#define PM88X_REG_LDO3_VOUT		0x2c
+#define PM88X_REG_LDO4_VOUT		0x32
+#define PM88X_REG_LDO5_VOUT		0x38
+#define PM88X_REG_LDO6_VOUT		0x3e
+#define PM88X_REG_LDO7_VOUT		0x44
+#define PM88X_REG_LDO8_VOUT		0x4a
+#define PM88X_REG_LDO9_VOUT		0x50
+#define PM88X_REG_LDO10_VOUT		0x56
+#define PM88X_REG_LDO11_VOUT		0x5c
+#define PM88X_REG_LDO12_VOUT		0x62
+#define PM88X_REG_LDO13_VOUT		0x68
+#define PM88X_REG_LDO14_VOUT		0x6e
+#define PM88X_REG_LDO15_VOUT		0x74
+#define PM88X_REG_LDO16_VOUT		0x7a
+
+#define PM886_REG_BUCK1_VOUT		0xa5
+#define PM886_REG_BUCK2_VOUT		0xb3
+#define PM886_REG_BUCK3_VOUT		0xc1
+#define PM886_REG_BUCK4_VOUT		0xcf
+#define PM886_REG_BUCK5_VOUT		0xdd
+
+#define PM88X_LDO_VSEL_MASK		0x0f
+#define PM88X_BUCK_VSEL_MASK		0x7f
+
+struct pm88x_regulator {
+	struct regulator_desc desc;
+	int max_uA;
+};
+
+static int pm88x_regulator_get_ilim(struct regulator_dev *rdev)
+{
+	struct pm88x_regulator *data = rdev_get_drvdata(rdev);
+
+	if (!data) {
+		dev_err(&rdev->dev, "Failed to get regulator data\n");
+		return -EINVAL;
+	}
+	return data->max_uA;
+}
+
+static const struct regulator_ops pm88x_ldo_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_current_limit = pm88x_regulator_get_ilim,
+};
+
+static const struct regulator_ops pm88x_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_current_limit = pm88x_regulator_get_ilim,
+};
+
+static const unsigned int pm88x_ldo_volt_table1[] = {
+	1700000, 1800000, 1900000, 2500000, 2800000, 2900000, 3100000, 3300000,
+};
+
+static const unsigned int pm88x_ldo_volt_table2[] = {
+	1200000, 1250000, 1700000, 1800000, 1850000, 1900000, 2500000, 2600000,
+	2700000, 2750000, 2800000, 2850000, 2900000, 3000000, 3100000, 3300000,
+};
+
+static const unsigned int pm88x_ldo_volt_table3[] = {
+	1700000, 1800000, 1900000, 2000000, 2100000, 2500000, 2700000, 2800000,
+};
+
+static const struct linear_range pm88x_buck_volt_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 79, 12500),
+	REGULATOR_LINEAR_RANGE(1600000, 80, 84, 50000),
+};
+
+static const struct linear_range pm88x_buck_volt_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 79, 12500),
+	REGULATOR_LINEAR_RANGE(1600000, 80, 114, 50000),
+};
+
+static struct pm88x_regulator pm88x_ldo2 = {
+	.desc = {
+		.name = "LDO2",
+		.id = PM88X_REGULATOR_ID_LDO2,
+		.regulators_node = "regulators",
+		.of_match = "ldo2",
+		.ops = &pm88x_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.enable_reg = PM88X_REG_LDO_EN1,
+		.enable_mask = BIT(1),
+		.volt_table = pm88x_ldo_volt_table1,
+		.n_voltages = ARRAY_SIZE(pm88x_ldo_volt_table1),
+		.vsel_reg = PM88X_REG_LDO2_VOUT,
+		.vsel_mask = PM88X_LDO_VSEL_MASK,
+	},
+	.max_uA = 100000,
+};
+
+static struct pm88x_regulator pm88x_ldo15 = {
+	.desc = {
+		.name = "LDO15",
+		.id = PM88X_REGULATOR_ID_LDO15,
+		.regulators_node = "regulators",
+		.of_match = "ldo15",
+		.ops = &pm88x_ldo_ops,
+		.type = REGULATOR_VOLTAGE,
+		.enable_reg = PM88X_REG_LDO_EN2,
+		.enable_mask = BIT(6),
+		.volt_table = pm88x_ldo_volt_table2,
+		.n_voltages = ARRAY_SIZE(pm88x_ldo_volt_table2),
+		.vsel_reg = PM88X_REG_LDO15_VOUT,
+		.vsel_mask = PM88X_LDO_VSEL_MASK,
+	},
+	.max_uA = 200000,
+};
+
+static struct pm88x_regulator pm886_buck2 = {
+	.desc = {
+		.name = "buck2",
+		.id = PM886_REGULATOR_ID_BUCK2,
+		.regulators_node = "regulators",
+		.of_match = "buck2",
+		.ops = &pm88x_buck_ops,
+		.type = REGULATOR_VOLTAGE,
+		.n_voltages = 115,
+		.linear_ranges = pm88x_buck_volt_ranges2,
+		.n_linear_ranges = ARRAY_SIZE(pm88x_buck_volt_ranges2),
+		.vsel_reg = PM886_REG_BUCK2_VOUT,
+		.vsel_mask = PM88X_BUCK_VSEL_MASK,
+		.enable_reg = PM88X_REG_BUCK_EN,
+		.enable_mask = BIT(1),
+	},
+	.max_uA = 1200000,
+};
+
+static struct pm88x_regulator *pm88x_regulators[] = {
+	[PM88X_REGULATOR_ID_LDO2] = &pm88x_ldo2,
+	[PM88X_REGULATOR_ID_LDO15] = &pm88x_ldo15,
+	[PM886_REGULATOR_ID_BUCK2] = &pm886_buck2,
+};
+
+static int pm88x_regulator_probe(struct platform_device *pdev)
+{
+	struct pm88x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config rcfg = { };
+	struct pm88x_regulator *regulator;
+	struct regulator_desc *rdesc;
+	struct regulator_dev *rdev;
+	int ret;
+
+	if (pdev->id < 0 || pdev->id == PM88X_REGULATOR_ID_BUCKS
+			|| pdev->id >= PM88X_REGULATOR_ID_SENTINEL) {
+		dev_err(&pdev->dev, "Invalid regulator ID: %d\n", pdev->id);
+		return -EINVAL;
+	}
+
+	rcfg.dev = pdev->dev.parent;
+	regulator = pm88x_regulators[pdev->id];
+	rdesc = &regulator->desc;
+	rcfg.driver_data = regulator;
+	rcfg.regmap = chip->regmaps[rdesc->id > PM88X_REGULATOR_ID_BUCKS ?
+		PM88X_REGMAP_BUCK : PM88X_REGMAP_LDO];
+	rdev = devm_regulator_register(&pdev->dev, rdesc, &rcfg);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		dev_err(&pdev->dev, "Failed to register %s: %d",
+				rdesc->name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+const struct of_device_id pm88x_regulator_of_match[] = {
+	{ .compatible = "marvell,88pm88x-regulator", },
+	{ },
+};
+
+static struct platform_driver pm88x_regulator_driver = {
+	.driver = {
+		.name = "88pm88x-regulator",
+		.of_match_table = of_match_ptr(pm88x_regulator_of_match),
+	},
+	.probe = pm88x_regulator_probe,
+};
+module_platform_driver(pm88x_regulator_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM88X PMIC regulator driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f3ec24691378..e3fffae60b4c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -81,6 +81,12 @@ config REGULATOR_88PM8607
 	help
 	  This driver supports 88PM8607 voltage regulator chips.
 
+config REGULATOR_88PM88X
+	tristate "Marvell 88PM88X voltage regulators"
+	depends on MFD_88PM88X
+	help
+	  This driver implements support for Marvell 88PM88X voltage regulators.
+
 config REGULATOR_ACT8865
 	tristate "Active-semi act8865 voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b2b059b5ee56..9c8a85b21699 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
+obj-$(CONFIG_REGULATOR_88PM88X) += 88pm88x-regulator.o
 obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
index 703e6104c1d8..edb871cc1d47 100644
--- a/include/linux/mfd/88pm88x.h
+++ b/include/linux/mfd/88pm88x.h
@@ -41,6 +41,17 @@
 
 #define PM88X_PAGE_OFFSET_LDO		1
 
+enum pm88x_regulator_id {
+	PM88X_REGULATOR_ID_LDO2,
+	PM88X_REGULATOR_ID_LDO15,
+
+	PM88X_REGULATOR_ID_BUCKS,
+
+	PM886_REGULATOR_ID_BUCK2,
+
+	PM88X_REGULATOR_ID_SENTINEL
+};
+
 enum pm88x_regmap_index {
 	PM88X_REGMAP_BASE,
 	PM88X_REGMAP_LDO,
-- 
2.43.0


