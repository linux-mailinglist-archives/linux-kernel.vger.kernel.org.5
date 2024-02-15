Return-Path: <linux-kernel+bounces-66450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D603B855CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074F11C21B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041B1B950;
	Thu, 15 Feb 2024 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GihAzmcR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D51862F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987210; cv=none; b=MbeSv9irBpsAm4Cpq/XxPNR6E8WfjIkCCSEO/s9toOCEuMynyIPnxyqYKVUnXCx7sHaKaCAOJrvY+/C4Y4Bvw0LLsB8vyNs4I5ezmIhG814dI0/WYexeQlfrHSV6AocH9jNb99BHOi3RZnHlFSHz0EKqdjb+WLWuGGfhQMrnScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987210; c=relaxed/simple;
	bh=FRESMp3mK4eodAj8xjfDcef8szgxRgcVu5YmFtftXyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8b+ti736S76MGhguHMQ43vXWRKvdlH6wU/zTW/OtTxu/J3NvxKAvy+AchYglHsqbZVvLdu2RawLItElnWXB7v5kTH3ZhKju1P+pkifeoXyjMsSiMykuj2gP+d10GvVwr75s6LyoYYwpe47RyQWTz8osZOtHcTXqo9GVgobBmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GihAzmcR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987207;
	bh=FRESMp3mK4eodAj8xjfDcef8szgxRgcVu5YmFtftXyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GihAzmcRQtelmlonlqcek5RcDvKnPxRMGKXClrbScSctBOAl53vro6pUvY9r/IYNn
	 CLVmwd2lJ9F4LW5x1L9u4E276B78qXIlwbCZMcrw3AJtw4lGWQPuVTnNlbbIbDFHSg
	 /+G98VqjqPwer6+rzCK9rDItgBM8ewgSb3XrFYghAiu7QBZneKED7fE/g+YVvFu5Mo
	 oDNOAjVe2oVu3K6O9oiKMynAc3xB80uWCK92ntopwqZq62CGkYKA+AWksNNBy6qeZ0
	 uLiMcfreqKaeb5Q2N9dcZ96OpLild8kTB1vUUlDjU7kq4nld8wdhEoKblxG4Y28EB1
	 C9iP0w87ebFmw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64B3D37820B1;
	Thu, 15 Feb 2024 08:53:26 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: fshao@chromium.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v6 6/9] drm/mediatek: dsi: Register DSI host after acquiring clocks and PHY
Date: Thu, 15 Feb 2024 09:53:13 +0100
Message-ID: <20240215085316.56835-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registering the dsi host with its ops before getting dsi->regs is
simply wrong: even though there's nothing (for now) asynchronously
calling those ops before the end of the probe function, installing
ops that are using iospace(s) and clocks before even initializing
those is too fragile.

Register the DSI host after getting clocks, iospace and PHY.
This wil also allow to simplify the error paths in a later commit.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 52758cab0abf..b3dd6251d611 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1114,14 +1114,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	if (!dsi)
 		return -ENOMEM;
 
-	dsi->host.ops = &mtk_dsi_ops;
-	dsi->host.dev = dev;
-	ret = mipi_dsi_host_register(&dsi->host);
-	if (ret < 0) {
-		dev_err(dev, "failed to register DSI host: %d\n", ret);
-		return ret;
-	}
-
 	dsi->driver_data = of_device_get_match_data(dev);
 
 	dsi->engine_clk = devm_clk_get(dev, "engine");
@@ -1130,7 +1122,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get engine clock: %d\n", ret);
-		goto err_unregister_host;
+		return ret;
 	}
 
 	dsi->digital_clk = devm_clk_get(dev, "digital");
@@ -1139,14 +1131,14 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get digital clock: %d\n", ret);
-		goto err_unregister_host;
+		return ret;
 	}
 
 	dsi->hs_clk = devm_clk_get(dev, "hs");
 	if (IS_ERR(dsi->hs_clk)) {
 		ret = PTR_ERR(dsi->hs_clk);
 		dev_err(dev, "Failed to get hs clock: %d\n", ret);
-		goto err_unregister_host;
+		return ret;
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1154,20 +1146,28 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->regs)) {
 		ret = PTR_ERR(dsi->regs);
 		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
-		goto err_unregister_host;
+		return ret;
 	}
 
 	dsi->phy = devm_phy_get(dev, "dphy");
 	if (IS_ERR(dsi->phy)) {
 		ret = PTR_ERR(dsi->phy);
 		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
-		goto err_unregister_host;
+		return ret;
 	}
 
 	irq_num = platform_get_irq(pdev, 0);
 	if (irq_num < 0) {
 		ret = irq_num;
-		goto err_unregister_host;
+		return ret;
+	}
+
+	dsi->host.ops = &mtk_dsi_ops;
+	dsi->host.dev = dev;
+	ret = mipi_dsi_host_register(&dsi->host);
+	if (ret < 0) {
+		dev_err(dev, "failed to register DSI host: %d\n", ret);
+		return ret;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
-- 
2.43.0


