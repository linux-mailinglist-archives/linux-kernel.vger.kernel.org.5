Return-Path: <linux-kernel+bounces-105751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13887E3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CDC281163
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733522337;
	Mon, 18 Mar 2024 06:53:27 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984D1CA89;
	Mon, 18 Mar 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744807; cv=none; b=q+Vs0/rS/4YndAX2eT3WKaMqqhUAwuyYcJ+kLXWwlSUr1/Nnw73xSdQXTk8CaD/RIRFR6CRRkYOjOzw/aJb4jO3BTRHH1SdnMzOIS8ZmHiZnXL6fb+Oegchx9xRrbYBgOk0QS2Ir2QO4vHKKVL+2khmhTsJtliWYoXDgOosju5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744807; c=relaxed/simple;
	bh=4m/ohYPMa+0mBDHTTy2RJmhezQAAKT1R6j2wsefkv94=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Y9elhtDZUigP/9U0ZRCkWTKLPGi086z/b0ucz/WnqBamc0HRedUlx3ApYgWgxjWm1nGFI/6itpQnnXwA3wRW65Og+ayX+WL7gO0HDQ2zaWOOcHiRbnl1lKFdKlZvpCVe+aX1uERlP13SQLhmqxbEBhvpPjn7NsS21pM7IVy4yHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9589D1A0BA3;
	Mon, 18 Mar 2024 07:53:18 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 337111A0580;
	Mon, 18 Mar 2024 07:53:18 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 77ACD183AC0B;
	Mon, 18 Mar 2024 14:53:16 +0800 (+08)
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
Subject: [PATCH] clk: imx: imx8mp: Add pm_runtime support for power saving
Date: Mon, 18 Mar 2024 14:36:51 +0800
Message-Id: <1710743811-1698-1-git-send-email-shengjiu.wang@nxp.com>
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
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 99 ++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 55ed211a5e0b..d2bf53e2aacf 100644
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
@@ -26,6 +29,12 @@
 #define SAI7_MCLK_SEL		0x314
 #define PDM_SEL			0x318
 #define SAI_PLL_GNRL_CTL	0x400
+#define SAI_PLL_FDIVL_CTL0	0x404
+#define SAI_PLL_FDIVL_CTL1	0x408
+#define SAI_PLL_SSCG_CTL	0x40C
+#define SAI_PLL_MNIT_CTL	0x410
+#define IPG_LP_CTRL		0x504
+#define REGS_NUM		16
 
 #define SAIn_MCLK1_PARENT(n)						\
 static const struct clk_parent_data					\
@@ -182,13 +191,65 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_SAIn(7)
 };
 
+struct clk_imx8mp_audiomix_regs {
+	u32 regs_num;
+	u32 regs_off[];
+};
+
+static const struct clk_imx8mp_audiomix_regs audiomix_regs = {
+	.regs_num = REGS_NUM,
+	.regs_off = {
+		CLKEN0,
+		CLKEN1,
+		EARC,
+		SAI1_MCLK_SEL,
+		SAI2_MCLK_SEL,
+		SAI3_MCLK_SEL,
+		SAI5_MCLK_SEL,
+		SAI6_MCLK_SEL,
+		SAI7_MCLK_SEL,
+		PDM_SEL,
+		SAI_PLL_GNRL_CTL,
+		SAI_PLL_FDIVL_CTL0,
+		SAI_PLL_FDIVL_CTL1,
+		SAI_PLL_SSCG_CTL,
+		SAI_PLL_MNIT_CTL,
+		IPG_LP_CTRL
+	},
+};
+
+struct clk_imx8mp_audiomix_drvdata {
+	void __iomem *base;
+	u32 regs_save[REGS_NUM];
+};
+
+static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
+{
+	struct clk_imx8mp_audiomix_drvdata *drvdata = dev_get_drvdata(dev);
+	void __iomem *base = drvdata->base;
+	int i;
+
+	if (save) {
+		for (i = 0; i < audiomix_regs.regs_num; i++)
+			drvdata->regs_save[i] = readl(base + audiomix_regs.regs_off[i]);
+	} else {
+		for (i = 0; i < audiomix_regs.regs_num; i++)
+			writel(drvdata->regs_save[i], base + audiomix_regs.regs_off[i]);
+	}
+}
+
 static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 {
+	struct clk_imx8mp_audiomix_drvdata *drvdata;
 	struct clk_hw_onecell_data *priv;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct clk_hw *hw;
-	int i;
+	int i, ret;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
 
 	priv = devm_kzalloc(dev,
 			    struct_size(priv, hws, IMX8MP_CLK_AUDIOMIX_END),
@@ -202,6 +263,9 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	drvdata->base = base;
+	dev_set_drvdata(dev, drvdata);
+
 	for (i = 0; i < ARRAY_SIZE(sels); i++) {
 		if (sels[i].num_parents == 1) {
 			hw = devm_clk_hw_register_gate_parent_data(dev,
@@ -257,10 +321,38 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 
-	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
-					   priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+					  priv);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+	clk_imx8mp_audiomix_save_restore(&pdev->dev, true);
+
+	return 0;
 }
 
+static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
+{
+	clk_imx8mp_audiomix_save_restore(dev, true);
+
+	return 0;
+}
+
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
@@ -272,6 +364,7 @@ static struct platform_driver clk_imx8mp_audiomix_driver = {
 	.driver = {
 		.name = "imx8mp-audio-blk-ctrl",
 		.of_match_table = clk_imx8mp_audiomix_of_match,
+		.pm = &clk_imx8mp_audiomix_pm_ops,
 	},
 };
 
-- 
2.34.1


