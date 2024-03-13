Return-Path: <linux-kernel+bounces-101381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D281A87A65D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429D6B206B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536533EA83;
	Wed, 13 Mar 2024 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0FkK1zw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC53DBBA;
	Wed, 13 Mar 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327723; cv=none; b=ci0272XuVPfhpBg3Z5KH4lwC97SdRwH3XWYE4MJtAl3V9dLnvUsBUfhYvCJptcYbPs7gm70CbOwMc7oY9zDwnUeeH9a3DoEl5snZ5TPpbjiVPRhcvpZ3A4mNy0x46K8pqLASWyHzQ+VBHUecNgYFcHOOW0B5z27mWjJp0RHi9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327723; c=relaxed/simple;
	bh=XrN+FNQ9ZEEOf2BtHxTjYdpx2CTwrk9qIo8k7imhpew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/SH4lOaFZgRc3o3PqOFH4n3MzWCY/JZTBMoCi6SqNEJMQemmqcnxbSEcunJzqx4Dn8n11Wa2FIwy0eHotcvH9wtnvh4wUinSTAsRhZ01XFenmtEDsT46prL2iUYyM8C+N3+Z6GKF2fzKtwyjT71wyiOE9M9r1Vy9mi838+5WIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0FkK1zw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710327719;
	bh=XrN+FNQ9ZEEOf2BtHxTjYdpx2CTwrk9qIo8k7imhpew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0FkK1zwssncZKvB15gtH6Th/fg/MPk7GBaTiHk+dVZS+VVcPzvsTrn0lGU/S4+6t
	 fxCnc0mK1M199vk1pVtJlgSwtae0kh0W3qb2r+Je7bBtjx/+OPJObJ3ZArEEkXpOzm
	 Ie6jjS8vITIamYQcH/9rEAh1DestdRMa+24n5stN1j/2gWgZlFqCmvJ1AuuQJPb9dL
	 twAIrB8H1dBEznf5SsBb1oMei6gTVySlNOtpwW/gLoXMHC3uZ3xq8rYQh7QZc1lvNd
	 lp/6ipRBZF3tGgZxLgFpf8HSTQlRFpEE+gdTMwva5CiX5FFsu+er2SpItHuXFN31xy
	 UDX+4p09JXaUA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC5613782079;
	Wed, 13 Mar 2024 11:01:57 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 01/22] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
Date: Wed, 13 Mar 2024 12:01:26 +0100
Message-ID: <20240313110147.1267793-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from pm_runtime_enable() to devm_pm_runtime_enable(), allowing
to remove all gotos from the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c | 46 ++++++++--------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index bdd1e91824d9..794419d16b01 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2217,21 +2217,20 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	/* regmap init */
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(afe->regmap)) {
 		dev_err(dev, "could not get regmap from parent\n");
-		ret = PTR_ERR(afe->regmap);
-		goto err_pm_disable;
+		return PTR_ERR(afe->regmap);
 	}
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
 	if (ret) {
 		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* enable clock for regcache get default value from hw */
@@ -2241,7 +2240,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -2254,10 +2253,8 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->memif_size = MT8192_MEMIF_NUM;
 	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
 				  GFP_KERNEL);
-	if (!afe->memif) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->memif)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->memif_size; i++) {
 		afe->memif[i].data = &memif_data[i];
@@ -2271,26 +2268,22 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->irqs_size = MT8192_IRQ_NUM;
 	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
 				 GFP_KERNEL);
-	if (!afe->irqs) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->irqs)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->irqs_size; i++)
 		afe->irqs[i].irq_data = &irq_data[i];
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id < 0) {
-		ret = irq_id;
-		goto err_pm_disable;
-	}
+	if (irq_id < 0)
+		return irq_id;
 
 	ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
 	if (ret) {
 		dev_err(dev, "could not request_irq for Afe_ISR_Handle\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* init sub_dais */
@@ -2301,7 +2294,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
 				 i, ret);
-			goto err_pm_disable;
+			return ret;
 		}
 	}
 
@@ -2310,7 +2303,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
 			 ret);
-		goto err_pm_disable;
+		return ret;
 	}
 
 	/* others */
@@ -2329,7 +2322,7 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 					      &mt8192_afe_component, NULL, 0);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -2338,15 +2331,10 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 					      afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_dai_component\n");
-		goto err_pm_disable;
+		return ret;
 	}
 
 	return 0;
-
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
 }
 
 static void mt8192_afe_pcm_dev_remove(struct platform_device *pdev)
-- 
2.44.0


