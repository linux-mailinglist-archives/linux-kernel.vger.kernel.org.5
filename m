Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DF806F18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377981AbjLFLwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377860AbjLFLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:51:38 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD910C0;
        Wed,  6 Dec 2023 03:51:20 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B8B0C7FFE;
        Wed,  6 Dec 2023 19:51:18 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:18 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:11 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <emil.renner.berthing@canonical.com>,
        <hal.feng@starfivetech.com>, <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH v1 08/16] clk: starfive: Add JH8100 System-North-West clock generator driver
Date:   Wed, 6 Dec 2023 19:49:52 +0800
Message-ID: <20231206115000.295825-9-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [175.136.135.142]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for JH8100 System-North-West clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig             |   8 +
 drivers/clk/starfive/jh8100/Makefile     |   1 +
 drivers/clk/starfive/jh8100/clk-sys-nw.c | 268 +++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/clk/starfive/jh8100/clk-sys-nw.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index d8c7b9bb3895..e55f783d73ac 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -81,3 +81,11 @@ config CLK_STARFIVE_JH8100_SYS
 	default ARCH_STARFIVE
 	help
 	  Say yes here to support the System clock controller on the StarFive JH8100 SoC.
+
+config CLK_STARFIVE_JH8100_SYS_NW
+	bool "StarFive JH8100 System-North-West clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the System-North-West clock controller on the StarFive JH8100
+	  SoC.
diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
index af6a09e220d3..eca7970a0e45 100644
--- a/drivers/clk/starfive/jh8100/Makefile
+++ b/drivers/clk/starfive/jh8100/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 # StarFive JH8100 Clock
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NW)	+= clk-sys-nw.o
diff --git a/drivers/clk/starfive/jh8100/clk-sys-nw.c b/drivers/clk/starfive/jh8100/clk-sys-nw.c
new file mode 100644
index 000000000000..a200ea4d4020
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-sys-nw.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 System Clock Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+#include "clk-starfive-jh8100.h"
+
+/* external clocks */
+#define SYSCRG_NW_CLK_OSC				(SYSCRG_NW_CLK_END + 0)
+#define SYSCRG_NW_CLK_APB_BUS				(SYSCRG_NW_CLK_END + 1)
+#define SYSCRG_NW_CLK_APB_BUS_PER4			(SYSCRG_NW_CLK_END + 2)
+#define SYSCRG_NW_CLK_SPI_CORE_100			(SYSCRG_NW_CLK_END + 3)
+#define SYSCRG_NW_CLK_ISP_2X				(SYSCRG_NW_CLK_END + 4)
+#define SYSCRG_NW_CLK_ISP__AXI				(SYSCRG_NW_CLK_END + 5)
+#define SYSCRG_NW_CLK_VOUT_ROOT0			(SYSCRG_NW_CLK_END + 6)
+#define SYSCRG_NW_CLK_VOUT_ROOT1			(SYSCRG_NW_CLK_END + 7)
+#define SYSCRG_NW_CLK_VOUT_SCAN__ATS			(SYSCRG_NW_CLK_END + 8)
+#define SYSCRG_NW_CLK_VOUT_DC__CORE			(SYSCRG_NW_CLK_END + 9)
+#define SYSCRG_NW_CLK_VOUT__AXI				(SYSCRG_NW_CLK_END + 10)
+#define SYSCRG_NW_CLK_AXI_400				(SYSCRG_NW_CLK_END + 11)
+#define SYSCRG_NW_CLK_DVP_EXT				(SYSCRG_NW_CLK_END + 12)
+#define SYSCRG_NW_CLK_ISP_DPHY_TAP_TCK_EXT		(SYSCRG_NW_CLK_END + 13)
+#define SYSCRG_NW_CLK_GLB_EXT				(SYSCRG_NW_CLK_END + 14)
+#define SYSCRG_NW_CLK_VOUT_MIPI_DPHY_TAP_TCK_EXT	(SYSCRG_NW_CLK_END + 15)
+#define SYSCRG_NW_CLK_VOUT_EDP_TAP_TCK_EXT		(SYSCRG_NW_CLK_END + 16)
+#define SYSCRG_NW_CLK_SPI_IN2_EXT			(SYSCRG_NW_CLK_END + 17)
+#define SYSCRG_NW_CLK_PERH_ROOT_PREOSC			(SYSCRG_NW_CLK_END + 18)
+#define SYSCRG_NW_CLK_AHB_VOUT				(SYSCRG_NW_CLK_END + 19)
+#define SYSCRG_NW_CLK_PLL5_OUT				(SYSCRG_NW_CLK_END + 20)
+
+static const struct starfive_clk_data jh8100_syscrg_nw_clk_data[] = {
+	/* root */
+	STARFIVE__DIV(SYSCRG_NW_CLK_PLL5_DIV2, "sys_nw_clk_pll5_div2", 2,
+		      SYSCRG_NW_CLK_PLL5_OUT),
+	STARFIVE_GDIV(SYSCRG_NW_CLK_GCLK5, "sys_nw_clk_gclk5", CLK_IS_CRITICAL, 120,
+		      SYSCRG_NW_CLK_PLL5_DIV2),
+	/* gpio */
+	STARFIVE_GATE(SYSCRG_NW_CLK_GPIO_100, "sys_nw_clk_gpio_100",
+		      CLK_IS_CRITICAL, SYSCRG_NW_CLK_PLL5_OUT),
+	STARFIVE_GATE(SYSCRG_NW_CLK_GPIO_50, "sys_nw_clk_gpio_50",
+		      CLK_IS_CRITICAL, SYSCRG_NW_CLK_PLL5_OUT),
+	STARFIVE_GATE(SYSCRG_NW_CLK_GPIO_150, "sys_nw_clk_gpio_150",
+		      CLK_IS_CRITICAL, SYSCRG_NW_CLK_PLL5_OUT),
+	STARFIVE_GDIV(SYSCRG_NW_CLK_GPIO_60, "sys_nw_clk_gpio_60", CLK_IS_CRITICAL, 30,
+		      SYSCRG_NW_CLK_PLL5_OUT),
+	/* iomux */
+	STARFIVE_GATE(SYSCRG_NW_CLK_IOMUX_WEST_PCLK, "sys_nw_clk_iomux_west_pclk", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	/* i2c */
+	STARFIVE_GATE(SYSCRG_NW_CLK_I2C6_APB, "sys_nw_clk_i2c6_apb", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GATE(SYSCRG_NW_CLK_I2C7_APB, "sys_nw_clk_i2c7_apb", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	/* spi */
+	STARFIVE_GATE(SYSCRG_NW_CLK_SPI2_APB, "sys_nw_clk_spi2_apb", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GATE(SYSCRG_NW_CLK_SPI2_CORE, "sys_nw_clk_spi2_core", 0,
+		      SYSCRG_NW_CLK_SPI_CORE_100),
+	STARFIVE__MUX(SYSCRG_NW_CLK_SPI2_SCLK_IN, "sys_nw_clk_spi2_sclk_in", 2,
+		      SYSCRG_NW_CLK_SPI_IN2_EXT, SYSCRG_NW_CLK_GPIO_100),
+	/* smbus */
+	STARFIVE_GATE(SYSCRG_NW_CLK_SMBUS1_APB, "sys_nw_clk_smbus1_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GDIV(SYSCRG_NW_CLK_SMBUS1_CORE, "sys_nw_clk_smbus1_core", CLK_IGNORE_UNUSED, 120,
+		      SYSCRG_NW_CLK_PERH_ROOT_PREOSC),
+	/* isp */
+	STARFIVE__MUX(SYSCRG_NW_CLK_ISP_DVP, "sys_nw_clk_isp_dvp", 2,
+		      SYSCRG_NW_CLK_DVP_EXT, SYSCRG_NW_CLK_GPIO_150),
+	STARFIVE_GATE(SYSCRG_NW_CLK_ISP_CORE_2X, "sys_nw_clk_isp_core_2x", 0,
+		      SYSCRG_NW_CLK_ISP_2X),
+	STARFIVE_GATE(SYSCRG_NW_CLK_ISP_AXI, "sys_nw_clk_isp_axi", 0,
+		      SYSCRG_NW_CLK_ISP__AXI),
+	STARFIVE__MUX(SYSCRG_NW_CLK_ISP_DPHY_TAP_TCK, "sys_nw_clk_isp_dphy_tap_tck", 2,
+		      SYSCRG_NW_CLK_ISP_DPHY_TAP_TCK_EXT, SYSCRG_NW_CLK_GLB_EXT),
+	STARFIVE_GATE(SYSCRG_NW_CLK_FLEXNOC_ISPSLV, "sys_nw_clk_flexnoc_ispslv", 0,
+		      SYSCRG_NW_CLK_ISP__AXI),
+	/* vout */
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_PIX0, "sys_nw_clk_vout_pix0", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_VOUT_ROOT0),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_PIX1, "sys_nw_clk_vout_pix1", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_VOUT_ROOT1),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_SCAN_ATS, "sys_nw_clk_vout_scan_ats",
+		      CLK_IGNORE_UNUSED, SYSCRG_NW_CLK_VOUT_SCAN__ATS),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_DC_CORE, "sys_nw_clk_vout_dc_core",
+		      CLK_IGNORE_UNUSED, SYSCRG_NW_CLK_VOUT_DC__CORE),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_APB, "sys_nw_clk_vout_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_APB_BUS),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_DSI, "sys_nw_clk_vout_dsi", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_AXI_400),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_AHB, "sys_nw_clk_vout_ahb", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_AHB_VOUT),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_AXI, "sys_nw_clk_vout_axi", CLK_IGNORE_UNUSED,
+		      SYSCRG_NW_CLK_VOUT__AXI),
+	STARFIVE__MUX(SYSCRG_NW_CLK_VOUT_MIPI_DPHY_TAP_TCK,
+		      "sys_nw_clk_vout_mipi_dphy_tap_tck", 2,
+		      SYSCRG_NW_CLK_VOUT_MIPI_DPHY_TAP_TCK_EXT,
+		      SYSCRG_NW_CLK_GLB_EXT),
+	STARFIVE__MUX(SYSCRG_NW_CLK_VOUT_EDP_PHY_TAP_TCK,
+		      "sys_nw_clk_vout_edp_phy_tap_tck", 2,
+		      SYSCRG_NW_CLK_VOUT_EDP_TAP_TCK_EXT, SYSCRG_NW_CLK_GLB_EXT),
+	/* uart */
+	STARFIVE__DIV(SYSCRG_NW_CLK_UART5_CORE_PREOSC, "sys_nw_clk_uart5_core_preosc",
+		      131071, SYSCRG_NW_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NW_CLK_UART5_APB, "sys_nw_clk_uart5_apb", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GMUX(SYSCRG_NW_CLK_UART5_CORE, "sys_nw_clk_uart5_core", 0, 2,
+		      SYSCRG_NW_CLK_OSC, SYSCRG_NW_CLK_UART5_CORE_PREOSC),
+	STARFIVE__DIV(SYSCRG_NW_CLK_UART6_CORE_PREOSC, "sys_nw_clk_uart6_core_preosc",
+		      131071, SYSCRG_NW_CLK_PERH_ROOT_PREOSC),
+	STARFIVE_GATE(SYSCRG_NW_CLK_UART6_APB, "sys_nw_clk_uart6_apb", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GMUX(SYSCRG_NW_CLK_UART6_CORE, "sys_nw_clk_uart6_core", 0, 2,
+		      SYSCRG_NW_CLK_OSC, SYSCRG_NW_CLK_UART6_CORE_PREOSC),
+	/* icg_en */
+	STARFIVE_GATE(SYSCRG_NW_CLK_SPI2_ICG_EN, "sys_nw_clk_spi2_en", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GATE(SYSCRG_NW_CLK_SMBUS1_ICG_EN, "sys_nw_clk_smbus1_en", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GATE(SYSCRG_NW_CLK_ISP_ICG_EN, "sys_nw_clk_isp_en", 0,
+		      SYSCRG_NW_CLK_ISP__AXI),
+	STARFIVE_GATE(SYSCRG_NW_CLK_VOUT_ICG_EN, "sys_nw_clk_vout_en", 0,
+		      SYSCRG_NW_CLK_VOUT_ROOT0),
+	STARFIVE_GATE(SYSCRG_NW_CLK_UART5_ICG_EN, "sys_nw_clk_uart5_en", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+	STARFIVE_GATE(SYSCRG_NW_CLK_UART6_ICG_EN, "sys_nw_clk_uart6_en", 0,
+		      SYSCRG_NW_CLK_APB_BUS_PER4),
+};
+
+struct clk_hw *jh8100_syscrg_nw_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < SYSCRG_NW_CLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_syscrg_nw_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, SYSCRG_NW_CLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	/* 24MHz -> 1500.0MHz */
+	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "clk_pll5_out",
+							 "clk_osc", 0, 125, 2);
+	if (IS_ERR(priv->pll[0]))
+		return PTR_ERR(priv->pll[0]);
+
+	for (idx = 0; idx < SYSCRG_NW_CLK_END; idx++) {
+		u32 max = jh8100_syscrg_nw_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_syscrg_nw_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_syscrg_nw_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_syscrg_nw_clk_data[idx].parents[i];
+
+			if (pidx < SYSCRG_NW_CLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == SYSCRG_NW_CLK_OSC)
+				parents[i].fw_name = "clk_osc";
+			else if (pidx == SYSCRG_NW_CLK_APB_BUS)
+				parents[i].fw_name = "sys_clk_apb_bus";
+			else if (pidx == SYSCRG_NW_CLK_APB_BUS_PER4)
+				parents[i].fw_name = "sys_clk_apb_bus_per4";
+			else if (pidx == SYSCRG_NW_CLK_SPI_CORE_100)
+				parents[i].fw_name = "sys_clk_spi_core_100";
+			else if (pidx == SYSCRG_NW_CLK_ISP_2X)
+				parents[i].fw_name = "sys_clk_isp_2x";
+			else if (pidx == SYSCRG_NW_CLK_ISP__AXI)
+				parents[i].fw_name = "sys_clk_isp_axi";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_ROOT0)
+				parents[i].fw_name = "sys_clk_vout_root0";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_ROOT1)
+				parents[i].fw_name = "sys_clk_vout_root1";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_SCAN__ATS)
+				parents[i].fw_name = "sys_clk_vout_scan_ats";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_DC__CORE)
+				parents[i].fw_name = "sys_clk_vout_dc_core";
+			else if (pidx == SYSCRG_NW_CLK_VOUT__AXI)
+				parents[i].fw_name = "sys_clk_vout_axi";
+			else if (pidx == SYSCRG_NW_CLK_AXI_400)
+				parents[i].fw_name = "sys_clk_axi_400";
+			else if (pidx == SYSCRG_NW_CLK_DVP_EXT)
+				parents[i].fw_name = "clk_dvp_ext";
+			else if (pidx == SYSCRG_NW_CLK_ISP_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_isp_dphy_tap_tck_ext";
+			else if (pidx == SYSCRG_NW_CLK_GLB_EXT)
+				parents[i].fw_name = "clk_glb_ext_clk";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_MIPI_DPHY_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_vout_mipi_dphy_tap_tck_ext";
+			else if (pidx == SYSCRG_NW_CLK_VOUT_EDP_TAP_TCK_EXT)
+				parents[i].fw_name = "clk_vout_edp_tap_tck_ext";
+			else if (pidx == SYSCRG_NW_CLK_SPI_IN2_EXT)
+				parents[i].fw_name = "clk_spi_in2_ext";
+			else if (pidx == SYSCRG_NW_CLK_PERH_ROOT_PREOSC)
+				parents[i].fw_name = "sys_clk_perh_root_preosc";
+			else if (pidx == SYSCRG_NW_CLK_AHB_VOUT)
+				parents[i].fw_name = "sys_clk_ahb_vout";
+			else
+				parents[i].hw = priv->pll[pidx - SYSCRG_NW_CLK_PLL5_OUT];
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & STARFIVE_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_syscrg_nw_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys-nw", 1);
+}
+
+static const struct of_device_id jh8100_syscrg_nw_match[] = {
+	{ .compatible = "starfive,jh8100-syscrg-nw" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_nw_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sys-nw",
+		.of_match_table = jh8100_syscrg_nw_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_nw_driver, jh8100_syscrg_nw_probe);
-- 
2.34.1

