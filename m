Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71037574FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGRHIY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGRHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:08:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C51A2;
        Tue, 18 Jul 2023 00:08:09 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9B7D424E2D4;
        Tue, 18 Jul 2023 15:08:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 15:08:06 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 15:08:05 +0800
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>
CC:     Minda Chen <minda.chen@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/2] phy: starfive: Add mipi dphy rx support
Date:   Tue, 18 Jul 2023 00:08:03 -0700
Message-ID: <20230718070803.16660-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718070803.16660-1-changhuang.liang@starfivetech.com>
References: <20230718070803.16660-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mipi dphy rx support for the StarFive JH7110 SoC. It is used to
transfer CSI camera data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                               |   7 +
 drivers/phy/starfive/Kconfig              |   9 +
 drivers/phy/starfive/Makefile             |   5 +-
 drivers/phy/starfive/phy-jh7110-dphy-rx.c | 232 ++++++++++++++++++++++
 4 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 drivers/phy/starfive/phy-jh7110-dphy-rx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 38927b9ce712..f849e8e3f765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20116,6 +20116,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
 
+STARFIVE JH7110 DPHY RX DRIVER
+M:	Jack Zhu <jack.zhu@starfivetech.com>
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
+F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
+
 STARFIVE JH7110 MMC/SD/SDIO DRIVER
 M:	William Qiu <william.qiu@starfivetech.com>
 S:	Supported
diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index da9a98cdf7e3..a560533a674e 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -3,6 +3,15 @@
 # Phy drivers for StarFive platforms
 #
 
+config PHY_STARFIVE_JH7110_DPHY_RX
+	tristate "StarFive JH7110 D-PHY RX support"
+	select GENERIC_PHY
+	select GENERIC_PHY_MIPI_DPHY
+	help
+	  Choose this option if you have a StarFive D-PHY in your
+	  system. If M is selected, the module will be called
+	  phy-jh7110-dphy-rx.ko.
+
 config PHY_STARFIVE_JH7110_PCIE
 	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index 1c62d93e3280..b391018b7c47 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)	+= phy-jh7110-pcie.o
-obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)	+= phy-jh7110-usb.o
+obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
+obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
+obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
diff --git a/drivers/phy/starfive/phy-jh7110-dphy-rx.c b/drivers/phy/starfive/phy-jh7110-dphy-rx.c
new file mode 100644
index 000000000000..037a9e0263cd
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-dphy-rx.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * StarFive JH7110 DPHY RX driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Jack Zhu <jack.zhu@starfivetech.com>
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define STF_DPHY_APBCFGSAIF_SYSCFG(x)		(x)
+
+#define STF_DPHY_ENABLE_CLK			BIT(6)
+#define STF_DPHY_ENABLE_CLK1			BIT(7)
+#define STF_DPHY_ENABLE_LAN0			BIT(8)
+#define STF_DPHY_ENABLE_LAN1			BIT(9)
+#define STF_DPHY_ENABLE_LAN2			BIT(10)
+#define STF_DPHY_ENABLE_LAN3			BIT(11)
+#define STF_DPHY_LANE_SWAP_CLK			GENMASK(22, 20)
+#define STF_DPHY_LANE_SWAP_CLK1			GENMASK(25, 23)
+#define STF_DPHY_LANE_SWAP_LAN0			GENMASK(28, 26)
+#define STF_DPHY_LANE_SWAP_LAN1			GENMASK(31, 29)
+
+#define STF_DPHY_LANE_SWAP_LAN2			GENMASK(2, 0)
+#define STF_DPHY_LANE_SWAP_LAN3			GENMASK(5, 3)
+#define STF_DPHY_PLL_CLK_SEL			GENMASK(21, 12)
+#define STF_DPHY_PRECOUNTER_IN_CLK		GENMASK(29, 22)
+
+#define STF_DPHY_PRECOUNTER_IN_CLK1		GENMASK(7, 0)
+#define STF_DPHY_PRECOUNTER_IN_LAN0		GENMASK(15, 8)
+#define STF_DPHY_PRECOUNTER_IN_LAN1		GENMASK(23, 16)
+#define STF_DPHY_PRECOUNTER_IN_LAN2		GENMASK(31, 24)
+
+#define STF_DPHY_PRECOUNTER_IN_LAN3		GENMASK(7, 0)
+#define STF_DPHY_RX_1C2C_SEL			BIT(8)
+
+#define STF_MAP_LANES_NUM			6
+
+struct regval {
+	u32 addr;
+	u32 val;
+};
+
+struct stf_dphy_info {
+	/**
+	 * @maps:
+	 *
+	 * Physical lanes and logic lanes mapping table.
+	 *
+	 * The default order is:
+	 * [clk lane0, data lane 0, data lane 1, data lane 2, date lane 3, clk lane 1]
+	 */
+	u8 maps[STF_MAP_LANES_NUM];
+};
+
+struct stf_dphy {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *cfg_clk;
+	struct clk *ref_clk;
+	struct clk *tx_clk;
+	struct reset_control *rstc;
+	struct regulator *mipi_0p9;
+	struct phy *phy;
+	const struct stf_dphy_info *info;
+};
+
+static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	const struct stf_dphy_info *info = dphy->info;
+
+	writel(FIELD_PREP(STF_DPHY_ENABLE_CLK, 1) |
+	       FIELD_PREP(STF_DPHY_ENABLE_CLK1, 1) |
+	       FIELD_PREP(STF_DPHY_ENABLE_LAN0, 1) |
+	       FIELD_PREP(STF_DPHY_ENABLE_LAN1, 1) |
+	       FIELD_PREP(STF_DPHY_ENABLE_LAN2, 1) |
+	       FIELD_PREP(STF_DPHY_ENABLE_LAN3, 1) |
+	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK, info->maps[0]) |
+	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK1, info->maps[5]) |
+	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN0, info->maps[1]) |
+	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN1, info->maps[2]),
+	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(188));
+
+	writel(FIELD_PREP(STF_DPHY_LANE_SWAP_LAN2, info->maps[3]) |
+	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN3, info->maps[4]) |
+	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK, 8),
+	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(192));
+
+	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK1, 8) |
+	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN0, 7) |
+	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN1, 7) |
+	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN2, 7),
+	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(196));
+
+	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN3, 7),
+	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(200));
+
+	return 0;
+}
+
+static int stf_dphy_power_on(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dphy->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_enable(dphy->mipi_0p9);
+	if (ret) {
+		pm_runtime_put(dphy->dev);
+		return ret;
+	}
+
+	clk_set_rate(dphy->cfg_clk, 99000000);
+	clk_set_rate(dphy->ref_clk, 49500000);
+	clk_set_rate(dphy->tx_clk, 19800000);
+	reset_control_deassert(dphy->rstc);
+
+	return 0;
+}
+
+static int stf_dphy_power_off(struct phy *phy)
+{
+	struct stf_dphy *dphy = phy_get_drvdata(phy);
+
+	reset_control_assert(dphy->rstc);
+
+	regulator_disable(dphy->mipi_0p9);
+
+	pm_runtime_put_sync(dphy->dev);
+
+	return 0;
+}
+
+static const struct phy_ops stf_dphy_ops = {
+	.configure = stf_dphy_configure,
+	.power_on  = stf_dphy_power_on,
+	.power_off = stf_dphy_power_off,
+};
+
+static int stf_dphy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct stf_dphy *dphy;
+
+	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
+	if (!dphy)
+		return -ENOMEM;
+
+	dphy->info = of_device_get_match_data(&pdev->dev);
+
+	dev_set_drvdata(&pdev->dev, dphy);
+	dphy->dev = &pdev->dev;
+
+	dphy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dphy->regs))
+		return PTR_ERR(dphy->regs);
+
+	dphy->cfg_clk = devm_clk_get(&pdev->dev, "cfg");
+	if (IS_ERR(dphy->cfg_clk))
+		return PTR_ERR(dphy->cfg_clk);
+
+	dphy->ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(dphy->ref_clk))
+		return PTR_ERR(dphy->ref_clk);
+
+	dphy->tx_clk = devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(dphy->tx_clk))
+		return PTR_ERR(dphy->tx_clk);
+
+	dphy->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(dphy->rstc))
+		return PTR_ERR(dphy->rstc);
+
+	dphy->mipi_0p9 = devm_regulator_get(&pdev->dev, "mipi_0p9");
+	if (IS_ERR(dphy->mipi_0p9))
+		return PTR_ERR(dphy->mipi_0p9);
+
+	dphy->phy = devm_phy_create(&pdev->dev, NULL, &stf_dphy_ops);
+	if (IS_ERR(dphy->phy)) {
+		dev_err(&pdev->dev, "Failed to create PHY\n");
+		return PTR_ERR(dphy->phy);
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	phy_set_drvdata(dphy->phy, dphy);
+	phy_provider = devm_of_phy_provider_register(&pdev->dev,
+						     of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct stf_dphy_info starfive_dphy_info = {
+	.maps = {4, 0, 1, 2, 3, 5},
+};
+
+static const struct of_device_id stf_dphy_dt_ids[] = {
+	{
+		.compatible = "starfive,jh7110-dphy-rx",
+		.data = &starfive_dphy_info,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, stf_dphy_dt_ids);
+
+static struct platform_driver stf_dphy_driver = {
+	.probe = stf_dphy_probe,
+	.driver = {
+		.name	= "starfive-dphy-rx",
+		.of_match_table = stf_dphy_dt_ids,
+	},
+};
+module_platform_driver(stf_dphy_driver);
+
+MODULE_AUTHOR("Jack Zhu <jack.zhu@starfivetech.com>");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 DPHY RX driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

