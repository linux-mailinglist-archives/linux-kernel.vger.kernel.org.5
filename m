Return-Path: <linux-kernel+bounces-23416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE782AC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34350B23318
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E6E14F79;
	Thu, 11 Jan 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qk+I+0Dx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3B14F62;
	Thu, 11 Jan 2024 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970372;
	bh=AMVfzvbVKztx/7y6kdCGWvpZXOG+ZdfCsQ9HsmGMSIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qk+I+0DxAYUMmqa4SXs2yQNDEr8U9KFs2met++sPRrAGr9Sv8ukwt5HOmrMslZ1b/
	 C8gok5VsWBPtXV+T38iN7/ogRpLsVSWbXRN7Lb7Ut714tTRoLCRRlpfMw9GtJvcqTj
	 fwUvnljf4hrlDGINcL0v6lLnfJ22gP2G1iYV94ya+8jhgU5a0UzBweWPJ+QGF+R7TN
	 XJkTvLgVkz+XLA6MV/Bb5fHToJfW0gNcJysA9P0lCXXFl2enyOS3rrUltQ5JFXEXX0
	 s4N1UbVY+stgZdg4nG7rRkiyFH/TO78m1+9AWXJOXqsb4164xAbxlZBQ/3c0JFsvDH
	 LidQhyG5J8XVQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21F8E3781F8E;
	Thu, 11 Jan 2024 10:52:51 +0000 (UTC)
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
Subject: [PATCH 1/7] ASoC: mediatek: mt8173-afe-pcm: Convert to devm_pm_runtime_enable()
Date: Thu, 11 Jan 2024 11:52:41 +0100
Message-ID: <20240111105247.117766-2-angelogioacchino.delregno@collabora.com>
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

Switch from pm_runtime_enable() to devm_pm_runtime_enable() to simplify
the probe function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 24 ++++++++--------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index b6291b7c811e..ea611730de9c 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1117,11 +1117,11 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, afe);
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret) {
 		ret = mt8173_afe_runtime_resume(&pdev->dev);
 		if (ret)
-			goto err_pm_disable;
+			return ret;
 	}
 
 	afe->reg_back_up_list = mt8173_afe_backup_list;
@@ -1133,19 +1133,17 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 					 &mtk_afe_pcm_platform,
 					 NULL, 0);
 	if (ret)
-		goto err_pm_disable;
+		return ret;
 
 	comp_pcm = devm_kzalloc(&pdev->dev, sizeof(*comp_pcm), GFP_KERNEL);
-	if (!comp_pcm) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!comp_pcm)
+		return -ENOMEM;
 
 	ret = snd_soc_component_initialize(comp_pcm,
 					   &mt8173_afe_pcm_dai_component,
 					   &pdev->dev);
 	if (ret)
-		goto err_pm_disable;
+		return ret;
 
 #ifdef CONFIG_DEBUG_FS
 	comp_pcm->debugfs_prefix = "pcm";
@@ -1155,7 +1153,7 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 				    mt8173_afe_pcm_dais,
 				    ARRAY_SIZE(mt8173_afe_pcm_dais));
 	if (ret)
-		goto err_pm_disable;
+		return ret;
 
 	comp_hdmi = devm_kzalloc(&pdev->dev, sizeof(*comp_hdmi), GFP_KERNEL);
 	if (!comp_hdmi) {
@@ -1191,18 +1189,12 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 err_cleanup_components:
 	snd_soc_unregister_component(&pdev->dev);
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
 static void mt8173_afe_pcm_dev_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
-
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mt8173_afe_runtime_suspend(&pdev->dev);
 }
 
 static const struct of_device_id mt8173_afe_pcm_dt_match[] = {
-- 
2.43.0


