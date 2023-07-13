Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D5752038
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjGMLjx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjGMLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:39:13 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EDE212D;
        Thu, 13 Jul 2023 04:39:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A23A524E271;
        Thu, 13 Jul 2023 19:39:08 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 19:39:08 +0800
Received: from localhost.localdomain (183.27.98.46) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Jul
 2023 19:39:07 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v8 6/9] clk: starfive: Add StarFive JH7110 Video-Output clock driver
Date:   Thu, 13 Jul 2023 19:38:59 +0800
Message-ID: <20230713113902.56519-7-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
References: <20230713113902.56519-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.46]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
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

Add driver for the StarFive JH7110 Video-Output clock controller.
And these clock controllers should power on and enable the clocks from
SYSCRG first before registering.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-vout.c   | 239 ++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 13b4d08cbcd2..3fa983eb7d32 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -55,3 +55,11 @@ config CLK_STARFIVE_JH7110_ISP
 	help
 	  Say yes here to support the Image-Signal-Process clock controller
 	  on the StarFive JH7110 SoC.
+
+config CLK_STARFIVE_JH7110_VOUT
+	tristate "StarFive JH7110 Video-Output clock support"
+	depends on CLK_STARFIVE_JH7110_SYS && JH71XX_PMU
+	default m if ARCH_STARFIVE
+	help
+	  Say yes here to support the Video-Output clock controller
+	  on the StarFive JH7110 SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 76fb9f8d628b..841377e45bb6 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
+obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
new file mode 100644
index 000000000000..10cc1ec43925
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 Video-Output Clock Driver
+ *
+ * Copyright (C) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+#include "clk-starfive-jh7110.h"
+
+/* external clocks */
+#define JH7110_VOUTCLK_VOUT_SRC			(JH7110_VOUTCLK_END + 0)
+#define JH7110_VOUTCLK_VOUT_TOP_AHB		(JH7110_VOUTCLK_END + 1)
+#define JH7110_VOUTCLK_VOUT_TOP_AXI		(JH7110_VOUTCLK_END + 2)
+#define JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK	(JH7110_VOUTCLK_END + 3)
+#define JH7110_VOUTCLK_I2STX0_BCLK		(JH7110_VOUTCLK_END + 4)
+#define JH7110_VOUTCLK_HDMITX0_PIXELCLK		(JH7110_VOUTCLK_END + 5)
+#define JH7110_VOUTCLK_EXT_END			(JH7110_VOUTCLK_END + 6)
+
+static struct clk_bulk_data jh7110_vout_top_clks[] = {
+	{ .id = "vout_src" },
+	{ .id = "vout_top_ahb" }
+};
+
+static const struct jh71x0_clk_data jh7110_voutclk_data[] = {
+	/* divider */
+	JH71X0__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	JH71X0__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_VOUTCLK_VOUT_SRC),
+	JH71X0__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK_VOUT_SRC),
+	JH71X0__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	/* dc8200 */
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
+	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
+	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	/* LCD */
+	JH71X0_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX0,
+		    JH7110_VOUTCLK_DC8200_PIX1),
+	/* dsiTx */
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUTCLK_DSI_SYS),
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUTCLK_DSI_SYS),
+	JH71X0_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
+		    JH7110_VOUTCLK_DC8200_PIX,
+		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_VOUTCLK_TX_ESC),
+	/* mipitx DPHY */
+	JH71X0_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc", 0,
+		    JH7110_VOUTCLK_TX_ESC),
+	/* hdmi */
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
+		    JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
+		    JH7110_VOUTCLK_I2STX0_BCLK),
+	JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_VOUTCLK_APB),
+};
+
+static int jh7110_vout_top_rst_init(struct jh71x0_clk_priv *priv)
+{
+	struct reset_control *top_rst;
+
+	/* The reset should be shared and other Vout modules will use its. */
+	top_rst = devm_reset_control_get_shared(priv->dev, NULL);
+	if (IS_ERR(top_rst))
+		return dev_err_probe(priv->dev, PTR_ERR(top_rst), "failed to get top reset\n");
+
+	return reset_control_deassert(top_rst);
+}
+
+static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh71x0_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_VOUTCLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+#ifdef CONFIG_PM
+static int jh7110_voutcrg_suspend(struct device *dev)
+{
+	struct jh7110_top_sysclk *top = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
+
+	return 0;
+}
+
+static int jh7110_voutcrg_resume(struct device *dev)
+{
+	struct jh7110_top_sysclk *top = dev_get_drvdata(dev);
+
+	return clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
+}
+
+static const struct dev_pm_ops jh7110_voutcrg_pm_ops = {
+	RUNTIME_PM_OPS(jh7110_voutcrg_suspend, jh7110_voutcrg_resume, NULL)
+};
+#endif
+
+static int jh7110_voutcrg_probe(struct platform_device *pdev)
+{
+	struct jh71x0_clk_priv *priv;
+	struct jh7110_top_sysclk *top;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, reg, JH7110_VOUTCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	top = devm_kzalloc(&pdev->dev, sizeof(*top), GFP_KERNEL);
+	if (!top)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	top->top_clks = jh7110_vout_top_clks;
+	top->top_clks_num = ARRAY_SIZE(jh7110_vout_top_clks);
+	ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "failed to get top clocks\n");
+	dev_set_drvdata(priv->dev, top);
+
+	/* enable power domain and clocks */
+	pm_runtime_enable(priv->dev);
+	ret = pm_runtime_get_sync(priv->dev);
+	if (ret < 0)
+		return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
+
+	ret = jh7110_vout_top_rst_init(priv);
+	if (ret)
+		goto err_exit;
+
+	for (idx = 0; idx < JH7110_VOUTCLK_END; idx++) {
+		u32 max = jh7110_voutclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7110_voutclk_data[idx].name,
+			.ops = starfive_jh71x0_clk_ops(max),
+			.parent_data = parents,
+			.num_parents =
+				((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
+			.flags = jh7110_voutclk_data[idx].flags,
+		};
+		struct jh71x0_clk *clk = &priv->reg[idx];
+		unsigned int i;
+		const char *fw_name[JH7110_VOUTCLK_EXT_END - JH7110_VOUTCLK_END] = {
+			"vout_src",
+			"vout_top_ahb",
+			"vout_top_axi",
+			"vout_top_hdmitx0_mclk",
+			"i2stx0_bclk",
+			"hdmitx0_pixelclk"
+		};
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7110_voutclk_data[idx].parents[i];
+
+			if (pidx < JH7110_VOUTCLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx < JH7110_VOUTCLK_EXT_END)
+				parents[i].fw_name = fw_name[pidx - JH7110_VOUTCLK_END];
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & JH71X0_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
+		if (ret)
+			goto err_exit;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_voutclk_get, priv);
+	if (ret)
+		goto err_exit;
+
+	ret = jh7110_reset_controller_register(priv, "rst-vo", 4);
+	if (ret)
+		goto err_exit;
+
+	return 0;
+
+err_exit:
+	pm_runtime_put_sync(priv->dev);
+	pm_runtime_disable(priv->dev);
+	return ret;
+}
+
+static int jh7110_voutcrg_remove(struct platform_device *pdev)
+{
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id jh7110_voutcrg_match[] = {
+	{ .compatible = "starfive,jh7110-voutcrg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_voutcrg_match);
+
+static struct platform_driver jh7110_voutcrg_driver = {
+	.probe = jh7110_voutcrg_probe,
+	.remove = jh7110_voutcrg_remove,
+	.driver = {
+		.name = "clk-starfive-jh7110-vout",
+		.of_match_table = jh7110_voutcrg_match,
+		.pm = pm_ptr(&jh7110_voutcrg_pm_ops),
+	},
+};
+module_platform_driver(jh7110_voutcrg_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 Video-Output clock driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

