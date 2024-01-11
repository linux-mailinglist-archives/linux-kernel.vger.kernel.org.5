Return-Path: <linux-kernel+bounces-23419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1382AC87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BEC1F239EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0F156F6;
	Thu, 11 Jan 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3oiXd7rI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21B156C7;
	Thu, 11 Jan 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970377;
	bh=cS3iWx2ZcmgtyFlp+ugoE4KjZQAyQugEDmx4+ox8BZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=3oiXd7rILSK3f0uwWTdD2JU3mMEjow9Z/QtutW2OSVLF0k8m17MhaC4Vbsy7UX2Q2
	 VVZXfDfdDqfJrp1zWxI2+Cd2O9QzjRQ0qRxsOe/v4Fw8SY8iSGtoCz2BF0yk2gpS1z
	 Mchc8PSNkAEG2ekPrBxbX43UkQ7Pbst2eRpgdMUNEFBGAZlsFA1+XgzleMIUy0OFKb
	 rYctpBQ7WDbxGcgErJshofpl9h2ymUXfdeGWrEr06yDpJXYaLE5dnrWavk0n55llgB
	 HcT+nsRvhVcDkotl24VgfpyG12U7XwOFXBjvz8MJuJlpX4ZU7TOP3Z/2RWXvwLkL77
	 wvRHXIh+oN2gg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 47EB337811D1;
	Thu, 11 Jan 2024 10:52:56 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ribalda@chromium.org,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	kuninori.morimoto.gx@renesas.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	trevor.wu@mediatek.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 5/7] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
Date: Thu, 11 Jan 2024 11:52:45 +0100
Message-ID: <20240111105247.117766-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
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
2.43.0


