Return-Path: <linux-kernel+bounces-23422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1882AC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA631F26BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8415AFE;
	Thu, 11 Jan 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OumW6osQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073D15AC5;
	Thu, 11 Jan 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970379;
	bh=INSFLjKGWUsq8D7Gv8F3E/m7g3Zw056cbg7I8BkqRIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OumW6osQ54b6FN4QQ5pFj7u91fs0CI6pFd0zZ+wlCvnEn8f3OWOs8vW2JcClOCh2j
	 poZAzt8E2OIhTSxn+C3TyiMlBjvTzOVJv4pUepYve7s1dvMaCxJd9BdSc10mIi+B6B
	 cxCnVYBMpwTcPwxodsHKcKrBOICZ6SevL8dySA5jiZlwu08PnLVq7O8Lqm6s6hlfin
	 S5WP+d/I/rwkRxQSiLcYgbTHqC14ncBil6IkuuSozoNsPG41F6tp2GaolSXnNTKiFd
	 Xrg785MqlGJ5kEfFv/QfcNdcZuA+Wv46lp3kSj50YaTukvS0ffctf7xYZ+kEFHUMIo
	 8fTIVjiX9lVXw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D541F3781FCB;
	Thu, 11 Jan 2024 10:52:58 +0000 (UTC)
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
Subject: [PATCH 7/7] ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new() callback
Date: Thu, 11 Jan 2024 11:52:47 +0100
Message-ID: <20240111105247.117766-8-angelogioacchino.delregno@collabora.com>
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

As we're calling devm_pm_runtime_enable() in the probe function of this
driver we don't need to disable it on remove as that's devm managed:
drop the .remove_new() callback entirely.

While at it, also add the sentinel comment to the last of_device_id
entry.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 620d7ade1992..de848d872ce6 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3193,16 +3193,9 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
-{
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mt8195_afe_runtime_suspend(&pdev->dev);
-}
-
 static const struct of_device_id mt8195_afe_pcm_dt_match[] = {
-	{.compatible = "mediatek,mt8195-audio", },
-	{},
+	{ .compatible = "mediatek,mt8195-audio" },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mt8195_afe_pcm_dt_match);
 
@@ -3218,7 +3211,6 @@ static struct platform_driver mt8195_afe_pcm_driver = {
 		   .pm = &mt8195_afe_pm_ops,
 	},
 	.probe = mt8195_afe_pcm_dev_probe,
-	.remove_new = mt8195_afe_pcm_dev_remove,
 };
 
 module_platform_driver(mt8195_afe_pcm_driver);
-- 
2.43.0


