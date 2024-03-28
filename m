Return-Path: <linux-kernel+bounces-114853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3F8891BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F16728466F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B982C7104;
	Mon, 25 Mar 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6RxAY0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940A27A859;
	Sun, 24 Mar 2024 23:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323496; cv=none; b=d+etKOtXqaFDx2xQozGh7HJecfnSmq8MXnAmzxTRpZ+TZ3wezQsWIdpk+o8NPNXRzEDOLwATArPPbeNxM/kwAgvWgsZC4MJw9OPGqi2q6yIDO5gBeYFqbc4I0K7rvZE7LcavaEONj7IK7PuILUS8UZ3tj09GdwY1DSBRjfTO6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323496; c=relaxed/simple;
	bh=dTOA1i0hR5O16Wzf2Byk5Ct+tFTOOYDBRh69BN9FK8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdq6IjWQbJGPM+pKrexUGTp8wUCVThP8WtvKpVeyiO3aITRLYr5x/PstrA/YMbzaCzwv++UGM89OOdFe7vxVn2P2dI3py0oYk0kr6ylGqJXNgp2jBP5j+M671hMbESBPMMCARse2r++oRtUTaKxCbXRKkciBFk+VpJ+reNrVZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6RxAY0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AA6C433F1;
	Sun, 24 Mar 2024 23:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323494;
	bh=dTOA1i0hR5O16Wzf2Byk5Ct+tFTOOYDBRh69BN9FK8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6RxAY0ph0GvrfhiQt/5/wyc9+5pQ90iNuWIriAuAdFWmHGOsTLc2MN2gk0ZSTH13
	 Q0pu1+sU0JgErI78R3CmE0gnNwlpZDEb6bSydSMj3pwvV2YlVbwBOyO/YP/tgsEjXk
	 gV/Z5OCWb94YdTeXS3Q84WbK/QzI/pnG1UQsMCXDJPq9OrOJgSbTEQ1ZWvoWhY48lo
	 7WBdO6ZN6g+2oqS0yDERPAk6J8y4YZSWJkBir6vjzu6LouEDG9xqMAoufa5Pu9sbsQ
	 KhRH8rk7jff54oL7xb+iwgBzbPR/VE/xiB7GXGeUuVAZUL0HLfTXW49ZsFghVoONJU
	 C7lg0pFTlv2YQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 200/317] ASoC: meson: Use dev_err_probe() helper
Date: Sun, 24 Mar 2024 19:33:00 -0400
Message-ID: <20240324233458.1352854-201-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 2ff4e003e8e105fb65c682c876a5cb0e00f854bf ]

Use the dev_err_probe() helper, instead of open-coding the same
operation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20211214020843.2225831-17-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 98ac85a00f31 ("ASoC: meson: aiu: fix function pointer type mismatch")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/aiu.c               | 36 +++++++--------------
 sound/soc/meson/axg-fifo.c          | 16 +++------
 sound/soc/meson/axg-pdm.c           | 25 ++++-----------
 sound/soc/meson/axg-spdifin.c       | 17 +++-------
 sound/soc/meson/axg-spdifout.c      | 17 +++-------
 sound/soc/meson/axg-tdm-formatter.c | 50 ++++++++---------------------
 sound/soc/meson/axg-tdm-interface.c | 25 ++++-----------
 sound/soc/meson/meson-card-utils.c  |  8 ++---
 sound/soc/meson/t9015.c             | 14 +++-----
 9 files changed, 56 insertions(+), 152 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index ba15d5762b0bf..d299a70db7e59 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -218,34 +218,23 @@ static int aiu_clk_get(struct device *dev)
 	int ret;
 
 	aiu->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(aiu->pclk)) {
-		if (PTR_ERR(aiu->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu pclk\n");
-		return PTR_ERR(aiu->pclk);
-	}
+	if (IS_ERR(aiu->pclk))
+		return dev_err_probe(dev, PTR_ERR(aiu->pclk), "Can't get the aiu pclk\n");
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
-	if (IS_ERR(aiu->spdif_mclk)) {
-		if (PTR_ERR(aiu->spdif_mclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu spdif master clock\n");
-		return PTR_ERR(aiu->spdif_mclk);
-	}
+	if (IS_ERR(aiu->spdif_mclk))
+		return dev_err_probe(dev, PTR_ERR(aiu->spdif_mclk),
+				     "Can't get the aiu spdif master clock\n");
 
 	ret = aiu_clk_bulk_get(dev, aiu_i2s_ids, ARRAY_SIZE(aiu_i2s_ids),
 			       &aiu->i2s);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the i2s clocks\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't get the i2s clocks\n");
 
 	ret = aiu_clk_bulk_get(dev, aiu_spdif_ids, ARRAY_SIZE(aiu_spdif_ids),
 			       &aiu->spdif);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the spdif clocks\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 
 	ret = clk_prepare_enable(aiu->pclk);
 	if (ret) {
@@ -281,11 +270,8 @@ static int aiu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, aiu);
 
 	ret = device_reset(dev);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to reset device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index b9af2d513e096..bccfb770b3391 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -351,20 +351,12 @@ int axg_fifo_probe(struct platform_device *pdev)
 	}
 
 	fifo->pclk = devm_clk_get(dev, NULL);
-	if (IS_ERR(fifo->pclk)) {
-		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %ld\n",
-				PTR_ERR(fifo->pclk));
-		return PTR_ERR(fifo->pclk);
-	}
+	if (IS_ERR(fifo->pclk))
+		return dev_err_probe(dev, PTR_ERR(fifo->pclk), "failed to get pclk\n");
 
 	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(fifo->arb)) {
-		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get arb reset: %ld\n",
-				PTR_ERR(fifo->arb));
-		return PTR_ERR(fifo->arb);
-	}
+	if (IS_ERR(fifo->arb))
+		return dev_err_probe(dev, PTR_ERR(fifo->arb), "failed to get arb reset\n");
 
 	fifo->irq = of_irq_get(dev->of_node, 0);
 	if (fifo->irq <= 0) {
diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index bfd37d49a73ef..672e43a9729dc 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -586,7 +586,6 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axg_pdm *priv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -611,28 +610,16 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->dclk = devm_clk_get(dev, "dclk");
-	if (IS_ERR(priv->dclk)) {
-		ret = PTR_ERR(priv->dclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->dclk))
+		return dev_err_probe(dev, PTR_ERR(priv->dclk), "failed to get dclk\n");
 
 	priv->sysclk = devm_clk_get(dev, "sysclk");
-	if (IS_ERR(priv->sysclk)) {
-		ret = PTR_ERR(priv->sysclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->sysclk))
+		return dev_err_probe(dev, PTR_ERR(priv->sysclk), "failed to get dclk\n");
 
 	return devm_snd_soc_register_component(dev, &axg_pdm_component_drv,
 					       &axg_pdm_dai_drv, 1);
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index 7aaded1fc376b..245189d2ee95f 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -439,7 +439,6 @@ static int axg_spdifin_probe(struct platform_device *pdev)
 	struct axg_spdifin *priv;
 	struct snd_soc_dai_driver *dai_drv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -464,20 +463,12 @@ static int axg_spdifin_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->refclk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		ret = PTR_ERR(priv->refclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->refclk))
+		return dev_err_probe(dev, PTR_ERR(priv->refclk), "failed to get mclk\n");
 
 	dai_drv = axg_spdifin_get_dai_drv(dev, priv);
 	if (IS_ERR(dai_drv)) {
diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
index e769a5ee6e27e..3960d082e1436 100644
--- a/sound/soc/meson/axg-spdifout.c
+++ b/sound/soc/meson/axg-spdifout.c
@@ -403,7 +403,6 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axg_spdifout *priv;
 	void __iomem *regs;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -422,20 +421,12 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	}
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get pclk\n");
 
 	priv->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(priv->mclk)) {
-		ret = PTR_ERR(priv->mclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->mclk))
+		return dev_err_probe(dev, PTR_ERR(priv->mclk), "failed to get mclk\n");
 
 	return devm_snd_soc_register_component(dev, &axg_spdifout_component_drv,
 			axg_spdifout_dai_drv, ARRAY_SIZE(axg_spdifout_dai_drv));
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 4834cfd163c03..63333a2b0a9c3 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -265,7 +265,6 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	const struct axg_tdm_formatter_driver *drv;
 	struct axg_tdm_formatter *formatter;
 	void __iomem *regs;
-	int ret;
 
 	drv = of_device_get_match_data(dev);
 	if (!drv) {
@@ -292,57 +291,34 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 
 	/* Peripharal clock */
 	formatter->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(formatter->pclk)) {
-		ret = PTR_ERR(formatter->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->pclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->pclk), "failed to get pclk\n");
 
 	/* Formatter bit clock */
 	formatter->sclk = devm_clk_get(dev, "sclk");
-	if (IS_ERR(formatter->sclk)) {
-		ret = PTR_ERR(formatter->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->sclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->sclk), "failed to get sclk\n");
 
 	/* Formatter sample clock */
 	formatter->lrclk = devm_clk_get(dev, "lrclk");
-	if (IS_ERR(formatter->lrclk)) {
-		ret = PTR_ERR(formatter->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->lrclk))
+		return dev_err_probe(dev, PTR_ERR(formatter->lrclk), "failed to get lrclk\n");
 
 	/* Formatter bit clock input multiplexer */
 	formatter->sclk_sel = devm_clk_get(dev, "sclk_sel");
-	if (IS_ERR(formatter->sclk_sel)) {
-		ret = PTR_ERR(formatter->sclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk_sel: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->sclk_sel))
+		return dev_err_probe(dev, PTR_ERR(formatter->sclk_sel), "failed to get sclk_sel\n");
 
 	/* Formatter sample clock input multiplexer */
 	formatter->lrclk_sel = devm_clk_get(dev, "lrclk_sel");
-	if (IS_ERR(formatter->lrclk_sel)) {
-		ret = PTR_ERR(formatter->lrclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk_sel: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->lrclk_sel))
+		return dev_err_probe(dev, PTR_ERR(formatter->lrclk_sel),
+				     "failed to get lrclk_sel\n");
 
 	/* Formatter dedicated reset line */
 	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(formatter->reset)) {
-		ret = PTR_ERR(formatter->reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get reset: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(formatter->reset))
+		return dev_err_probe(dev, PTR_ERR(formatter->reset), "failed to get reset\n");
 
 	return devm_snd_soc_register_component(dev, drv->component_drv,
 					       NULL, 0);
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 87cac440b3693..e076ced300257 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -517,21 +517,13 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 
 	/* Bit clock provided on the pad */
 	iface->sclk = devm_clk_get(dev, "sclk");
-	if (IS_ERR(iface->sclk)) {
-		ret = PTR_ERR(iface->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(iface->sclk))
+		return dev_err_probe(dev, PTR_ERR(iface->sclk), "failed to get sclk\n");
 
 	/* Sample clock provided on the pad */
 	iface->lrclk = devm_clk_get(dev, "lrclk");
-	if (IS_ERR(iface->lrclk)) {
-		ret = PTR_ERR(iface->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(iface->lrclk))
+		return dev_err_probe(dev, PTR_ERR(iface->lrclk), "failed to get lrclk\n");
 
 	/*
 	 * mclk maybe be missing when the cpu dai is in slave mode and
@@ -542,13 +534,10 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	iface->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(iface->mclk)) {
 		ret = PTR_ERR(iface->mclk);
-		if (ret == -ENOENT) {
+		if (ret == -ENOENT)
 			iface->mclk = NULL;
-		} else {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to get mclk: %d\n", ret);
-			return ret;
-		}
+		else
+			return dev_err_probe(dev, ret, "failed to get mclk\n");
 	}
 
 	return devm_snd_soc_register_component(dev,
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 415cc0046e4b4..23ccd2a720e19 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -85,11 +85,9 @@ int meson_card_parse_dai(struct snd_soc_card *card,
 
 	ret = of_parse_phandle_with_args(node, "sound-dai",
 					 "#sound-dai-cells", 0, &args);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(card->dev, "can't parse dai %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(card->dev, ret, "can't parse dai\n");
+
 	*dai_of_node = args.np;
 
 	return snd_soc_get_dai_name(&args, dai_name);
diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 4c1349dd1e06a..a9b8c4e77d405 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -258,18 +258,12 @@ static int t9015_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		if (PTR_ERR(priv->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get core clock\n");
-		return PTR_ERR(priv->pclk);
-	}
+	if (IS_ERR(priv->pclk))
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get core clock\n");
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
-	if (IS_ERR(priv->avdd)) {
-		if (PTR_ERR(priv->avdd) != -EPROBE_DEFER)
-			dev_err(dev, "failed to AVDD\n");
-		return PTR_ERR(priv->avdd);
-	}
+	if (IS_ERR(priv->avdd))
+		return dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 
 	ret = clk_prepare_enable(priv->pclk);
 	if (ret) {
-- 
2.43.0


