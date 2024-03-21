Return-Path: <linux-kernel+bounces-109819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA50885614
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76831F21F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7792837E;
	Thu, 21 Mar 2024 08:53:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF0BE6E;
	Thu, 21 Mar 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011216; cv=none; b=ok4HMlaS+uv9a/4gcuDBY1vRZUyK/or3bZa2+0Hj/aP3PSn8H8GohVRrqfl5C3Vble2r0oksqOgnwEAOi+D7XW9Ab4ilm+9igrzY2Rph0/u/4hTUA+tp9XN2y5/QjAfStdJXoCLTyIlAMp2FnCpdpK+GHQLvr7oOb85kj15huqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011216; c=relaxed/simple;
	bh=b924mGehVaz7RM1Ell0G0QnlUCZl3Tnwtr/AfmvR5Z0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k4W+pcNi1dvRkwaB64Jxj6NOkKGj3fJnpcVyjl6Kv6X/qD4ZDH+ejDsqdEOLHIMCCqD1w/EP2tkzvGu+HrN9B34TGNrK2SGwovJ10parjGr/6mxICqw7Rfv/tUutXlim2j6h8kx9oviGfOm4VQp3jGRV8NtV2/m59Zc8h08wDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 356611A2438;
	Thu, 21 Mar 2024 09:53:32 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D07D71A0DED;
	Thu, 21 Mar 2024 09:53:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 650AC180222D;
	Thu, 21 Mar 2024 16:53:30 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: imx: imx8mp: Add pm_runtime support for power saving
Date: Thu, 21 Mar 2024 16:36:51 +0800
Message-Id: <1711010211-6825-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add pm_runtime support for power saving. In pm runtime suspend
state the registers will be reseted, so add registers save
in pm runtime suspend and restore them in pm runtime resume.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
changes in v3:
- remove REGS_NUM, use the ARRAY_SIZE
- merge clk_imx8mp_audiomix_drvdata and clk_hw_onecell_data together.

changes in v2:
- move pm_runtime_enable before the clk register

 drivers/clk/imx/clk-imx8mp-audiomix.c | 157 ++++++++++++++++++++++----
 1 file changed, 136 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 55ed211a5e0b..5ae33bce8ad8 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -7,10 +7,12 @@
 
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <dt-bindings/clock/imx8mp-clock.h>
 
@@ -18,6 +20,7 @@
 
 #define CLKEN0			0x000
 #define CLKEN1			0x004
+#define EARC			0x200
 #define SAI1_MCLK_SEL		0x300
 #define SAI2_MCLK_SEL		0x304
 #define SAI3_MCLK_SEL		0x308
@@ -26,6 +29,11 @@
 #define SAI7_MCLK_SEL		0x314
 #define PDM_SEL			0x318
 #define SAI_PLL_GNRL_CTL	0x400
+#define SAI_PLL_FDIVL_CTL0	0x404
+#define SAI_PLL_FDIVL_CTL1	0x408
+#define SAI_PLL_SSCG_CTL	0x40C
+#define SAI_PLL_MNIT_CTL	0x410
+#define IPG_LP_CTRL		0x504
 
 #define SAIn_MCLK1_PARENT(n)						\
 static const struct clk_parent_data					\
@@ -182,26 +190,82 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_SAIn(7)
 };
 
+static const u16 audiomix_regs[] = {
+	CLKEN0,
+	CLKEN1,
+	EARC,
+	SAI1_MCLK_SEL,
+	SAI2_MCLK_SEL,
+	SAI3_MCLK_SEL,
+	SAI5_MCLK_SEL,
+	SAI6_MCLK_SEL,
+	SAI7_MCLK_SEL,
+	PDM_SEL,
+	SAI_PLL_GNRL_CTL,
+	SAI_PLL_FDIVL_CTL0,
+	SAI_PLL_FDIVL_CTL1,
+	SAI_PLL_SSCG_CTL,
+	SAI_PLL_MNIT_CTL,
+	IPG_LP_CTRL,
+};
+
+struct clk_imx8mp_audiomix_priv {
+	void __iomem *base;
+	struct clk_hw_onecell_data *clk_hw_data;
+	u32 regs_save[ARRAY_SIZE(audiomix_regs)];
+};
+
+static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
+{
+	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
+	void __iomem *base = priv->base;
+	int i;
+
+	if (save) {
+		for (i = 0; i < ARRAY_SIZE(audiomix_regs); i++)
+			priv->regs_save[i] = readl(base + audiomix_regs[i]);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(audiomix_regs); i++)
+			writel(priv->regs_save[i], base + audiomix_regs[i]);
+	}
+}
+
 static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *priv;
+	struct clk_imx8mp_audiomix_priv *priv;
+	struct clk_hw_onecell_data *clk_hw_data;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct clk_hw *hw;
-	int i;
+	int i, ret;
 
 	priv = devm_kzalloc(dev,
-			    struct_size(priv, hws, IMX8MP_CLK_AUDIOMIX_END),
+			    sizeof(*priv) + struct_size(clk_hw_data, hws, IMX8MP_CLK_AUDIOMIX_END),
 			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->num = IMX8MP_CLK_AUDIOMIX_END;
+	priv->clk_hw_data = (struct clk_hw_onecell_data *)((void *)priv + sizeof(*priv));
+
+	clk_hw_data = priv->clk_hw_data;
+	clk_hw_data->num = IMX8MP_CLK_AUDIOMIX_END;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	priv->base = base;
+	dev_set_drvdata(dev, priv);
+
+	/*
+	 * pm_runtime_enable needs to be called before clk register.
+	 * That is to make core->rpm_enabled to be true for clock
+	 * usage.
+	 */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	for (i = 0; i < ARRAY_SIZE(sels); i++) {
 		if (sels[i].num_parents == 1) {
 			hw = devm_clk_hw_register_gate_parent_data(dev,
@@ -216,10 +280,12 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 				0, NULL, NULL);
 		}
 
-		if (IS_ERR(hw))
-			return PTR_ERR(hw);
+		if (IS_ERR(hw)) {
+			ret = PTR_ERR(hw);
+			goto err_clk_register;
+		}
 
-		priv->hws[sels[i].clkid] = hw;
+		clk_hw_data->hws[sels[i].clkid] = hw;
 	}
 
 	/* SAI PLL */
@@ -228,39 +294,86 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 		ARRAY_SIZE(clk_imx8mp_audiomix_pll_parents),
 		CLK_SET_RATE_NO_REPARENT, base + SAI_PLL_GNRL_CTL,
 		0, 2, 0, NULL, NULL);
-	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL] = hw;
+	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_REF_SEL] = hw;
 
 	hw = imx_dev_clk_hw_pll14xx(dev, "sai_pll", "sai_pll_ref_sel",
 				    base + 0x400, &imx_1443x_pll);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL] = hw;
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto err_clk_register;
+	}
+	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL] = hw;
 
 	hw = devm_clk_hw_register_mux_parent_data_table(dev,
 		"sai_pll_bypass", clk_imx8mp_audiomix_pll_bypass_sels,
 		ARRAY_SIZE(clk_imx8mp_audiomix_pll_bypass_sels),
 		CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 		base + SAI_PLL_GNRL_CTL, 16, 1, 0, NULL, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto err_clk_register;
+	}
+
+	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_BYPASS] = hw;
 
 	hw = devm_clk_hw_register_gate(dev, "sai_pll_out", "sai_pll_bypass",
 				       0, base + SAI_PLL_GNRL_CTL, 13,
 				       0, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	priv->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT] = hw;
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto err_clk_register;
+	}
+	clk_hw_data->hws[IMX8MP_CLK_AUDIOMIX_SAI_PLL_OUT] = hw;
 
 	hw = devm_clk_hw_register_fixed_factor(dev, "sai_pll_out_div2",
 					       "sai_pll_out", 0, 1, 2);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	if (IS_ERR(hw)) {
+		ret = PTR_ERR(hw);
+		goto err_clk_register;
+	}
+
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+					  clk_hw_data);
+	if (ret)
+		goto err_clk_register;
+
+	pm_runtime_put_sync(dev);
+	return 0;
+
+err_clk_register:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int clk_imx8mp_audiomix_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
+{
+	clk_imx8mp_audiomix_save_restore(dev, true);
 
-	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
-					   priv);
+	return 0;
 }
 
+static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
+{
+	clk_imx8mp_audiomix_save_restore(dev, false);
+
+	return 0;
+}
+
+static const struct dev_pm_ops clk_imx8mp_audiomix_pm_ops = {
+	SET_RUNTIME_PM_OPS(clk_imx8mp_audiomix_runtime_suspend,
+			   clk_imx8mp_audiomix_runtime_resume, NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+};
+
 static const struct of_device_id clk_imx8mp_audiomix_of_match[] = {
 	{ .compatible = "fsl,imx8mp-audio-blk-ctrl" },
 	{ /* sentinel */ }
@@ -269,9 +382,11 @@ MODULE_DEVICE_TABLE(of, clk_imx8mp_audiomix_of_match);
 
 static struct platform_driver clk_imx8mp_audiomix_driver = {
 	.probe	= clk_imx8mp_audiomix_probe,
+	.remove = clk_imx8mp_audiomix_remove,
 	.driver = {
 		.name = "imx8mp-audio-blk-ctrl",
 		.of_match_table = clk_imx8mp_audiomix_of_match,
+		.pm = &clk_imx8mp_audiomix_pm_ops,
 	},
 };
 
-- 
2.34.1


