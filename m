Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAC782E73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjHUQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjHUQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:29:17 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A4FD;
        Mon, 21 Aug 2023 09:29:15 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37LEGgWE010872;
        Mon, 21 Aug 2023 12:28:54 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3skvcqc7xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 12:28:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 37LGSqkD055702
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 12:28:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Aug 2023 12:28:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Aug 2023 12:28:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Aug 2023 12:28:51 -0400
Received: from HYB-a2JJhsYKAxD.ad.analog.com (HYB-a2JJhsYKAxD.ad.analog.com [10.25.72.79])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 37LGSQsp012468;
        Mon, 21 Aug 2023 12:28:38 -0400
From:   Gokhan Celik <gokhan.celik@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Gokhan Celik <gokhan.celik@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gokhan Celik <Gokhan.Celik@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] drivers: regulator: Add MAX77503 regulator driver
Date:   Mon, 21 Aug 2023 19:28:21 +0300
Message-ID: <b45b07c3bdbfac1608b171f96aa0ae4ca5a0dd82.1692634090.git.gokhan.celik@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692634090.git.gokhan.celik@analog.com>
References: <cover.1692634090.git.gokhan.celik@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SvH2lX2qulJ1nb4aTtsJmFyHDYjlHc1P
X-Proofpoint-GUID: SvH2lX2qulJ1nb4aTtsJmFyHDYjlHc1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308210153
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX77503 buck converter driver.

Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>
---
 drivers/regulator/Kconfig              |  10 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/max77503-regulator.c | 137 +++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/regulator/max77503-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 823f8e6e4801..dbd2053774e9 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -556,6 +556,16 @@ config REGULATOR_MAX597X
 	  The MAX5970/5978 is a smart switch with no output regulation, but
 	  fault protection and voltage and current monitoring capabilities.
 
+config REGULATOR_MAX77503
+	tristate "Analog Devices MAX77503 Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver controls a Analog Devices MAX77503 14V input, 1.5A
+	  high-efficiency buck converter via I2C bus.
+	  Say M here if you want to include support for the regulator as a
+	  module.
+
 config REGULATOR_MAX77541
 	tristate "Analog Devices MAX77541/77540 Regulator"
 	depends on MFD_MAX77541
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 15e0d614ff66..b5b724699b51 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
+obj-$(CONFIG_REGULATOR_MAX77503) += max77503-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77541) += max77541-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
diff --git a/drivers/regulator/max77503-regulator.c b/drivers/regulator/max77503-regulator.c
new file mode 100644
index 000000000000..4a6ba4dd2acd
--- /dev/null
+++ b/drivers/regulator/max77503-regulator.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Analog Devices, Inc.
+ * ADI regulator driver for MAX77503.
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/util_macros.h>
+
+#define MAX77503_REG_CFG			0x00
+#define MAX77503_REG_VOUT			0x01
+
+#define MAX77503_BIT_EN				BIT(0)
+#define MAX77503_BIT_CURR_LIM		BIT(3)
+#define MAX77503_BIT_ADEN			BIT(6)
+
+#define MAX77503_BITS_SOFT_START	GENMASK(5, 4)
+#define MAX77503_BITS_MX_VOUT		GENMASK(7, 0)
+
+#define MAX77503_AD_ENABLED			0x1
+#define MAX77503_AD_DISABLED		0x0
+
+struct max77503_dev {
+	struct device *dev;
+	struct device_node *of_node;
+	struct regulator_desc desc;
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config max77503_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x2,
+};
+
+static const struct regulator_ops max77503_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_ascend,
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_soft_start = regulator_set_soft_start_regmap,
+};
+
+static const struct linear_range max77503_buck_ranges[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x54, 50000)
+};
+
+static const unsigned int max77503_current_limit_table[] = {
+	500000, 2000000
+};
+
+static const struct regulator_desc max77503_regulators_desc = {
+	.name = "max77503",
+	.enable_reg = MAX77503_REG_CFG,
+	.enable_mask = MAX77503_BIT_EN,
+	.ops = &max77503_buck_ops,
+	.type = REGULATOR_VOLTAGE,
+	.linear_ranges = max77503_buck_ranges,
+	.n_linear_ranges = ARRAY_SIZE(max77503_buck_ranges),
+	.vsel_reg = MAX77503_REG_VOUT,
+	.vsel_mask = MAX77503_BITS_MX_VOUT,
+	.soft_start_reg = MAX77503_REG_CFG,
+	.soft_start_mask = MAX77503_BITS_SOFT_START,
+	.active_discharge_reg = MAX77503_REG_CFG,
+	.active_discharge_mask = MAX77503_BIT_ADEN,
+	.active_discharge_off = MAX77503_AD_DISABLED,
+	.active_discharge_on = MAX77503_AD_ENABLED,
+	.csel_reg = MAX77503_REG_CFG,
+	.csel_mask = MAX77503_BIT_CURR_LIM,
+	.curr_table = max77503_current_limit_table,
+	.n_current_limits = ARRAY_SIZE(max77503_current_limit_table),
+	.owner = THIS_MODULE,
+};
+
+static int max77503_regulator_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+
+	config.dev = dev;
+	config.of_node = dev->of_node;
+	config.regmap = devm_regmap_init_i2c(client, &max77503_regmap_config);
+	if (IS_ERR(config.regmap)) {
+		dev_err(dev, "Failed to init regmap");
+		return PTR_ERR(config.regmap);
+	}
+
+	rdev = devm_regulator_register(dev, &max77503_regulators_desc, &config);
+	if (IS_ERR(rdev)) {
+		dev_err(dev, "Failed to register regulator MAX77503");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_max77503_match_tbl[] = {
+	{ .compatible = "adi,max77503", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, of_max77503_match_tbl);
+
+static const struct i2c_device_id max77503_regulator_id[] = {
+	{"max77503"},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, max77503_regulator_id);
+
+static struct i2c_driver max77503_regulator_driver = {
+	.driver = {
+		.name = "max77503",
+		.of_match_table = of_max77503_match_tbl
+	},
+	.probe = max77503_regulator_probe,
+	.id_table = max77503_regulator_id,
+};
+
+module_i2c_driver(max77503_regulator_driver);
+
+MODULE_AUTHOR("Gokhan Celik <Gokhan.Celik@analog.com>");
+MODULE_DESCRIPTION("MAX77503 regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

