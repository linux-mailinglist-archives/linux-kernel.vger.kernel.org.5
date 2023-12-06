Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A60806F24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378216AbjLFLwx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbjLFLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:52:30 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904971FE9;
        Wed,  6 Dec 2023 03:51:51 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 253EB24E317;
        Wed,  6 Dec 2023 19:51:50 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 19:51:50 +0800
Received: from jsia-virtual-machine.localdomain (175.136.135.142) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 6 Dec 2023 19:51:43 +0800
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
Subject: [PATCH v1 12/16] clk: starfive: Add JH8100 System-South-West clock generator driver
Date:   Wed, 6 Dec 2023 19:49:56 +0800
Message-ID: <20231206115000.295825-13-jeeheng.sia@starfivetech.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for JH8100 System-South-West clock generator.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/clk/starfive/Kconfig             |   8 ++
 drivers/clk/starfive/jh8100/Makefile     |   1 +
 drivers/clk/starfive/jh8100/clk-sys-sw.c | 136 +++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/clk/starfive/jh8100/clk-sys-sw.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index acd530c3897b..2d8a1e0fae8a 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -97,3 +97,11 @@ config CLK_STARFIVE_JH8100_SYS_NE
 	help
 	  Say yes here to support the System-North-East clock controller on the StarFive JH8100
 	  SoC.
+
+config CLK_STARFIVE_JH8100_SYS_SW
+	bool "StarFive JH8100 System-South-West clock support"
+	depends on CLK_STARFIVE_JH8100_SYS
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the System-South-West clock controller on the StarFive JH8100
+	  SoC.
diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starfive/jh8100/Makefile
index 164c1d55b97c..5c14bff5c541 100644
--- a/drivers/clk/starfive/jh8100/Makefile
+++ b/drivers/clk/starfive/jh8100/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+= clk-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NW)	+= clk-sys-nw.o
 obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_NE)	+= clk-sys-ne.o
+obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS_SW)        += clk-sys-sw.o
diff --git a/drivers/clk/starfive/jh8100/clk-sys-sw.c b/drivers/clk/starfive/jh8100/clk-sys-sw.c
new file mode 100644
index 000000000000..d88dd8741b5d
--- /dev/null
+++ b/drivers/clk/starfive/jh8100/clk-sys-sw.c
@@ -0,0 +1,136 @@
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
+#define SYSCRG_SW_CLK_APB_BUS		(SYSCRG_SW_CLK_END + 0)
+#define SYSCRG_SW_CLK_VDEC_ROOT		(SYSCRG_SW_CLK_END + 1)
+#define SYSCRG_SW_CLK_FLEXNOC1		(SYSCRG_SW_CLK_END + 2)
+
+static const struct starfive_clk_data jh8100_syscrg_sw_clk_data[] = {
+	/* jpeg */
+	STARFIVE__DIV(SYSCRG_SW_CLK_JPEG_AXI, "sys_sw_clk_jpeg_axi", 20,
+		      SYSCRG_SW_CLK_VDEC_ROOT),
+	STARFIVE_GATE(SYSCRG_SW_CLK_VC9000DJ_AXI, "sys_sw_clk_vc9000dj_axi",
+		      CLK_IGNORE_UNUSED, SYSCRG_SW_CLK_JPEG_AXI),
+	STARFIVE_GDIV(SYSCRG_SW_CLK_VC9000DJ_VDEC, "sys_sw_clk_vc9000dj_vdec",
+		      CLK_IGNORE_UNUSED, 40, SYSCRG_SW_CLK_VDEC_ROOT),
+	STARFIVE_GATE(SYSCRG_SW_CLK_VC9000DJ_APB, "sys_sw_clk_vc9000dj_apb",
+		      CLK_IGNORE_UNUSED, SYSCRG_SW_CLK_APB_BUS),
+	/* video dec */
+	STARFIVE__DIV(SYSCRG_SW_CLK_VDEC_AXI, "sys_sw_clk_vdec_axi", 20,
+		      SYSCRG_SW_CLK_VDEC_ROOT),
+	STARFIVE_GATE(SYSCRG_SW_CLK_VC9000D_AXI, "sys_sw_clk_vc9000d_axi", CLK_IGNORE_UNUSED,
+		      SYSCRG_SW_CLK_VDEC_AXI),
+	STARFIVE_GDIV(SYSCRG_SW_CLK_VC9000D_VDEC, "sys_sw_clk_vc9000d_vdec",
+		      CLK_IGNORE_UNUSED, 40, SYSCRG_SW_CLK_FLEXNOC1),
+	STARFIVE_GATE(SYSCRG_SW_CLK_VC9000D_APB, "sys_sw_clk_vc9000d_apb", CLK_IGNORE_UNUSED,
+		      SYSCRG_SW_CLK_APB_BUS),
+	/* icg_en */
+	STARFIVE_GATE(SYSCRG_SW_CLK_JPEG_ICG_EN, "sys_sw_clk_jpeg_en", 0,
+		      SYSCRG_SW_CLK_VDEC_ROOT),
+	STARFIVE_GATE(SYSCRG_SW_CLK_VDEC_ICG_EN, "sys_sw_clk_vdec_en", 0,
+		      SYSCRG_SW_CLK_VDEC_AXI),
+};
+
+static struct clk_hw *jh8100_syscrg_sw_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct starfive_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < SYSCRG_SW_CLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh8100_syscrg_sw_probe(struct platform_device *pdev)
+{
+	struct starfive_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, SYSCRG_SW_CLK_END),
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
+	for (idx = 0; idx < SYSCRG_SW_CLK_END; idx++) {
+		u32 max = jh8100_syscrg_sw_clk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh8100_syscrg_sw_clk_data[idx].name,
+			.ops = starfive_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & STARFIVE_CLK_MUX_MASK) >> STARFIVE_CLK_MUX_SHIFT) + 1,
+			.flags = jh8100_syscrg_sw_clk_data[idx].flags,
+		};
+		struct starfive_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh8100_syscrg_sw_clk_data[idx].parents[i];
+
+			if (pidx < SYSCRG_SW_CLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == SYSCRG_SW_CLK_APB_BUS)
+				parents[i].fw_name = "sys_clk_apb_bus";
+			else if (pidx == SYSCRG_SW_CLK_VDEC_ROOT)
+				parents[i].fw_name = "sys_clk_vdec_root";
+			else if (pidx == SYSCRG_SW_CLK_FLEXNOC1)
+				parents[i].fw_name = "sys_clk_flexnoc1";
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
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh8100_syscrg_sw_clk_get, priv);
+	if (ret)
+		return ret;
+
+	return jh8100_reset_controller_register(priv, "rst-sys-sw", 3);
+}
+
+static const struct of_device_id jh8100_syscrg_sw_match[] = {
+	{ .compatible = "starfive,jh8100-syscrg-sw" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver jh8100_syscrg_sw_driver = {
+	.driver = {
+		.name = "clk-starfive-jh8100-sys-sw",
+		.of_match_table = jh8100_syscrg_sw_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(jh8100_syscrg_sw_driver, jh8100_syscrg_sw_probe);
-- 
2.34.1

