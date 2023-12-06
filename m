Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA99806F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378011AbjLFLxV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378212AbjLFLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:52:50 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E94B1991;
        Wed,  6 Dec 2023 03:52:07 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D6F9380E1;
        Wed,  6 Dec 2023 19:52:05 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:52:05 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:58 +0800
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
Subject: [PATCH v1 14/16] clk: starfive: Add JH8100 Always-On clock generator driver
Date:   Wed, 6 Dec 2023 19:49:58 +0800
Message-ID: <20231206115000.295825-15-jeeheng.sia@starfivetech.com>
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

Add support for JH8100 Always-On clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig          |   8 +
 drivers/clk/starfive/jh8100/Makefile  |   1 +
 drivers/clk/starfive/jh8100/clk-aon.c | 275 ++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/clk/starfive/jh8100/clk-aon.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 2d8a1e0fae8a..7a8bb958f915 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -105,3 +105,11 @@ config CLK_STARFIVE_JH8100_SYS_SW
 	help
 	  Say yes here to support the System-South-West clock controller on the StarFive JH8100
 	  SoC.
+
+config CLK_STARFIVE_JH8100_AON
+	bool "StarFive JH8100 Always-On clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the Always-On clock controller on the StarFive JH8100
+	  SoC.
diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
index 5c14bff5c541..1decc43de0d3 100644
--- a/drivers/clk/starfive/jh8100/Makefile
+++ b/drivers/clk/starfive/jh8100/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NW)	+= clk-sys-nw.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NE)	+= clk-sys-ne.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_SW)        += clk-sys-sw.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_AON)		+= clk-aon.o
diff --git a/drivers/clk/starfive/jh8100/clk-aon.c b/drivers/clk/starfive/jh8100/clk-aon.c
new file mode 100644
index 000000000000..95c10d5a9552
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-aon.c
@@ -0,0 +1,275 @@
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
+#define AONCRG_CLK_OSC			(AONCRG_CLK_END + 0)
+#define AONCRG_CLK_GMAC0_RMII_FUNC	(AONCRG_CLK_END + 1)
+#define AONCRG_CLK_AON_50		(AONCRG_CLK_END + 2)
+#define AONCRG_CLK_GMAC0_RGMII_FUNC	(AONCRG_CLK_END + 3)
+#define AONCRG_CLK_AON_125		(AONCRG_CLK_END + 4)
+#define AONCRG_CLK_AON_2000		(AONCRG_CLK_END + 5)
+#define AONCRG_CLK_AON_200		(AONCRG_CLK_END + 6)
+#define AONCRG_CLK_AON_667		(AONCRG_CLK_END + 7)
+#define AONCRG_CLK_RTC			(AONCRG_CLK_END + 8)
+
+static const struct starfive_clk_data jh8100_aoncrg_clk_data[] = {
+	/* source */
+	STARFIVE__MUX(AONCRG_CLK_GMAC0_RMII_REFIN, "aon_clk_gmac0_rmii_refin", 2,
+		      AONCRG_CLK_GMAC0_RMII_FUNC, AONCRG_CLK_AON_50),
+	STARFIVE__MUX(AONCRG_CLK_GMAC0_RGMII_RXIN, "aon_clk_gmac0_rgmii_rxin", 2,
+		      AONCRG_CLK_GMAC0_RGMII_FUNC, AONCRG_CLK_AON_125),
+	STARFIVE__DIV(AONCRG_CLK_GMAC0_GTXCLK, "aon_clk_gmac0_gtxclk", 50,
+		      AONCRG_CLK_AON_125),
+	STARFIVE__DIV(AONCRG_CLK_AON_1000, "aon_clk_aon_1000", 2,
+		      AONCRG_CLK_AON_2000),
+	STARFIVE__DIV(AONCRG_CLK_AON_400, "aon_clk_aon_400", 5,
+		      AONCRG_CLK_AON_2000),
+	STARFIVE__MUX(AONCRG_CLK_AON_400_POSTOSC, "aon_clk_aon_400_postosc", 2,
+		      AONCRG_CLK_OSC, AONCRG_CLK_AON_400),
+	STARFIVE__DIV(AONCRG_CLK_AON_500, "aon_clk_aon_500", 4,
+		      AONCRG_CLK_AON_2000),
+	STARFIVE__MUX(AONCRG_CLK_AON_500_POSTOSC, "aon_clk_aon_500_postosc", 2,
+		      AONCRG_CLK_OSC, AONCRG_CLK_AON_500),
+	STARFIVE__DIV(AONCRG_CLK_XSPI_PHY, "aon_clk_xspi_phy", 4,
+		      AONCRG_CLK_AON_200),
+	STARFIVE__DIV(AONCRG_CLK_AON_100, "aon_clk_aon_100", 2,
+		      AONCRG_CLK_AON_200),
+	STARFIVE__MUX(AONCRG_CLK_AON_100_POSTOSC, "aon_clk_aon_100_postosc", 2,
+		      AONCRG_CLK_OSC, AONCRG_CLK_AON_100),
+	STARFIVE__MUX(AONCRG_CLK_AON_50_POSTOSC, "aon_clk_aon_50_postosc", 2,
+		      AONCRG_CLK_OSC, AONCRG_CLK_AON_50),
+	STARFIVE_GATE(AONCRG_CLK_DDR50_POSTOCC_ICG, "aon_clk_ddr50_postocc", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_50_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_DDR100_POSTOCC_ICG, "aon_clk_ddr100_postocc", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_100),
+	/* pufrt */
+	STARFIVE_GATE(AONCRG_CLK_PUFRT_APB, "aon_clk_pufrt_apb", CLK_IS_CRITICAL,
+		      AONCRG_CLK_OSC),
+	/* rtc hms */
+	STARFIVE_GATE(AONCRG_CLK_RTC_HMS_APB, "aon_clk_rtc_hms_apb", 0,
+		      AONCRG_CLK_OSC),
+	STARFIVE__DIV(AONCRG_CLK_RTC_INTERNAL, "aon_clk_rtc_internal", 1020,
+		      AONCRG_CLK_OSC),
+	STARFIVE__MUX(AONCRG_CLK_RTC_HMS_OSC32K, "aon_clk_rtc_hms_osc32k", 2,
+		      AONCRG_CLK_RTC, AONCRG_CLK_RTC_INTERNAL),
+	STARFIVE_GATE(AONCRG_CLK_RTC_HMS_CAL, "aon_clk_rtc_hms_cal", 0,
+		      AONCRG_CLK_OSC),
+	/* gmac5_axi128 */
+	STARFIVE_GATE(AONCRG_CLK_GMAC0_AXI128_AHB, "aon_clk_gmac0_axi128_ahb",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_GMAC0_AXI128_MSTRCLK, "aon_clk_gmac0_axi128_mstrclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_667),
+	STARFIVE_GATE(AONCRG_CLK_GMAC0_AXI128_AXI, "aon_clk_gmac0_axi128_axi",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_400_POSTOSC),
+	STARFIVE__DIV(AONCRG_CLK_GMAC0_RMII_RTX, "aon_clk_gmac0_rmii_rtx", 30,
+		      AONCRG_CLK_GMAC0_RMII_REFIN),
+	STARFIVE_GMUX(AONCRG_CLK_GMAC0_AXI128_TX, "aon_clk_gmac0_axi128_tx",
+		      CLK_IGNORE_UNUSED, 2, AONCRG_CLK_GMAC0_GTXCLK,
+		      AONCRG_CLK_GMAC0_RMII_RTX),
+	STARFIVE_GINV(AONCRG_CLK_GMAC0_AXI128_TX_INV, "aon_clk_gmac0_axi128_tx_inv",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_GMAC0_AXI128_TX),
+	STARFIVE__MUX(AONCRG_CLK_GMAC0_AXI128_RX, "aon_clk_gmac0_axi128_rx", 2,
+		      AONCRG_CLK_GMAC0_RGMII_RXIN, AONCRG_CLK_GMAC0_RMII_RTX),
+	STARFIVE__INV(AONCRG_CLK_GMAC0_AXI128_RX_INV, "aon_clk_gmac0_axi128_rx_inv",
+		      AONCRG_CLK_GMAC0_AXI128_RX),
+	STARFIVE_GATE(AONCRG_CLK_GMAC0_GTXC, "aon_clk_gmac0_gtxc", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_GMAC0_GTXCLK),
+	/* xspi */
+	STARFIVE_GATE(AONCRG_CLK_XSPI_AXI, "aon_clk_xspi_axi", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_XSPI_APB, "aon_clk_xspi_apb", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GMUX(AONCRG_CLK_XSPI_XSPI_PHY, "aon_clk_xspi_xspi_phy", CLK_IGNORE_UNUSED, 2,
+		      AONCRG_CLK_OSC, AONCRG_CLK_XSPI_PHY),
+	/* tvsensor */
+	STARFIVE_GATE(AONCRG_CLK_TVSENSOR_PCLK, "aon_clk_tvsensor_pclk", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_TVSENSOR_TSADC, "aon_clk_tvsensor_tsadc", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GDIV(AONCRG_CLK_TVSENSOR_BG, "aon_clk_tvsensor_bg",
+		      CLK_IGNORE_UNUSED, 3, AONCRG_CLK_OSC),
+	/* meu */
+	STARFIVE_GATE(AONCRG_CLK_MEU_PCLK_AP, "aon_clk_meu_pclk_ap", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_MEU_PCLK_SCP, "aon_clk_meu_pclk_scp", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_MEU_MEM_AXI, "aon_clk_meu_mem_axi", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_AON_200),
+	/* aximem_128b */
+	STARFIVE_GATE(AONCRG_CLK_AXIMEM_128B_ACLK, "aon_clk_aximem_128b_aclk", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_200),
+	/* apb2bisr */
+	STARFIVE_GATE(AONCRG_CLK_APB2BISR_APB, "aon_clk_apb2bisr_apb", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_APB2BISR_BISR, "aon_clk_apb2bisr_bisr", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	/* emmc */
+	STARFIVE_GATE(AONCRG_CLK_EMMC_S_PCLK, "aon_clk_emmc_s_pclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_50_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_EMMC_MSTRCLK, "aon_clk_emmc_mstrclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_667),
+	STARFIVE_GATE(AONCRG_CLK_EMMC, "aon_clk_emmc",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_EMMC_SDMCLK, "aon_clk_emmc_sdmclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_EMMC_SDPHY_PCLK, "aon_clk_emmc_sdphy_pclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_50_POSTOSC),
+	/* sdio */
+	STARFIVE_GATE(AONCRG_CLK_SDIO0_PCLK, "aon_clk_sdio0_pclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_50_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_SDIO0_MSTRCLK, "aon_clk_sdio0_mstrclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_667),
+	STARFIVE_GATE(AONCRG_CLK_SDIO0, "aon_clk_sdio0",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_SDIO0_SDMCLK, "aon_clk_sdio0_sdmclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_SDIO0_SDPHY_PCLK, "aon_clk_sdio0_sdphy_pclk",
+		      CLK_IGNORE_UNUSED, AONCRG_CLK_AON_50_POSTOSC),
+	/* top */
+	STARFIVE_GATE(AONCRG_CLK_HCLK, "aon_clk_hclk", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_200),
+	STARFIVE_GATE(AONCRG_CLK_ACLK, "aon_clk_aclk", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_500_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_PERF_MSTRCLK, "aon_clk_perf_mstrclk", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_667),
+	STARFIVE_GATE(AONCRG_CLK_PERF_SLVCLK, "aon_clk_perf_slvclk", CLK_IS_CRITICAL,
+		      AONCRG_CLK_AON_500_POSTOSC),
+	STARFIVE_GDIV(AONCRG_CLK_GCLK0, "aon_clk_gclk0",
+		      CLK_IS_CRITICAL, 100, AONCRG_CLK_AON_1000),
+	STARFIVE_GATE(AONCRG_CLK_GCLK_OSC, "aon_clk_gclk_osc", CLK_IS_CRITICAL,
+		      AONCRG_CLK_OSC),
+	/* icg_en */
+	STARFIVE_GATE(AONCRG_CLK_RTC_ICG_EN, "aon_clk_rtc_en", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_GMAC0_ICG_EN, "aon_clk_gmac0_en", 0,
+		      AONCRG_CLK_GMAC0_GTXCLK),
+	STARFIVE_GATE(AONCRG_CLK_XSPI_ICG_EN, "aon_clk_xspi_en", 0,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_TVSENSOR0_ICG_EN, "aon_clk_tvsensor0_en", 0,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_MEU_ICG_EN, "aon_clk_meu_en", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_APB2BISR_ICG_EN, "aon_clk_apb2bisr_en", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_OSC),
+	STARFIVE_GATE(AONCRG_CLK_EMMC_ICG_EN, "aon_clk_emmc_en", 0,
+		      AONCRG_CLK_AON_50_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_SDIO0_ICG_EN, "aon_clk_sdio0_en", 0,
+		      AONCRG_CLK_AON_50_POSTOSC),
+	STARFIVE_GATE(AONCRG_CLK_TOP_ICG_EN, "aon_clk_top_en", CLK_IGNORE_UNUSED,
+		      AONCRG_CLK_AON_500_POSTOSC),
+};
+
+static struct clk_hw *jh8100_aoncrg_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < AONCRG_CLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int __init jh8100_aoncrg_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, AONCRG_CLK_END),
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
+	for (idx = 0; idx < AONCRG_CLK_END; idx++) {
+		u32 max = jh8100_aoncrg_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_aoncrg_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_aoncrg_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_aoncrg_clk_data[idx].parents[i];
+
+			if (pidx < AONCRG_CLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == AONCRG_CLK_OSC)
+				parents[i].fw_name = "clk_osc";
+			else if (pidx == AONCRG_CLK_GMAC0_RMII_FUNC)
+				parents[i].fw_name = "clk_gmac0_rmii_func";
+			else if (pidx == AONCRG_CLK_AON_50)
+				parents[i].fw_name = "clk_aon50";
+			else if (pidx == AONCRG_CLK_GMAC0_RGMII_FUNC)
+				parents[i].fw_name = "clk_gmac0_rgmii_func";
+			else if (pidx == AONCRG_CLK_AON_125)
+				parents[i].fw_name = "clk_aon125";
+			else if (pidx == AONCRG_CLK_AON_2000)
+				parents[i].fw_name = "clk_aon2000";
+			else if (pidx == AONCRG_CLK_AON_200)
+				parents[i].fw_name = "clk_aon200";
+			else if (pidx == AONCRG_CLK_AON_667)
+				parents[i].fw_name = "clk_aon667";
+			else if (pidx == AONCRG_CLK_RTC)
+				parents[i].fw_name = "clk_rtc";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_aoncrg_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-aon", 4);
+}
+
+static const struct of_device_id jh8100_aoncrg_match[] = {
+	{ .compatible = "starfive,jh8100-aoncrg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_aoncrg_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-aon",
+		.of_match_table = jh8100_aoncrg_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_aoncrg_driver, jh8100_aoncrg_probe);
-- 
2.34.1

