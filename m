Return-Path: <linux-kernel+bounces-46360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5F843EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FB2B2ECAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE78B6DD01;
	Wed, 31 Jan 2024 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1ME7a2wR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6C78B6C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700890; cv=none; b=T79t1+eB7OHIunStzvMHiWM4RcAcT+dEVirlbmxPAPrwnVr+WqTNp/0w4oThf83gOOW5N+IPs5xIw2WPp+zJls5hKeBgpIi6Tj6UHTprNA8lAK/01ux5Wpgel2ztDqQjThduXvuD94JTGfVmk4D4t/oTjE+Mjs/ZJHFlXQTkaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700890; c=relaxed/simple;
	bh=ez/krp9UYdl/uYGqHtJoEk78GGME1WaiapUNmzMMnNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4HXzhuvAJ0ZLVOrbUUBAswgrsZOq+rQodyRki5xEWBIQbQpIRyQgheZYPiYLDnzLy4QQz2LFJBC853tECx7nee3Dc7dUrXzr4QPfd5x3ccbaam5hSi46UGcjrQ0i9Wj7C582RB2RwTdcPRZitKQA19v8Gt1yvpqw/lJYTrITkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1ME7a2wR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706700886;
	bh=ez/krp9UYdl/uYGqHtJoEk78GGME1WaiapUNmzMMnNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ME7a2wRNuV+zfLkzfeKrOeJPOz7YPHXfMD3BLKZfJA8TXF+AGHshjKmNbHpOZLSO
	 KnVooCsMsmYTA41x9Pt4RBr6Lb9m/UWkIDd7ImSg6fjB6osGrlwRCetfEQgxORQ6Js
	 vUYBsT/217En8Z7l0nhVA1fRhfwlJtPpeszFaf8opK52akAyAelc9Gg1LvUv3qtTNZ
	 Pz1dcUk/VMwvVxTxICdgdfWzl1pRCQx0LWesovFXGVOcdRbS627JibJqGL5mrp5nq5
	 JySFm4QkqfdH4/t2wBe9L0qDUp13qI6NvkkyA/OwaTduTd03zT8VJ41ZRxPp0LhDmq
	 deRoIG1Vlwevw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12D803782089;
	Wed, 31 Jan 2024 11:34:46 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH v3 6/7] drm/mediatek: dsi: Simplify with dev_err_probe and remove gotos
Date: Wed, 31 Jan 2024 12:34:33 +0100
Message-ID: <20240131113434.241929-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
References: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the functions that are called in the probe callback are
devm managed, or all but mipi_dsi_host_register(): simplify the probe
function's error paths with dev_err_probe() and remove the lonely
instance of `goto err_unregister_host` by just directly calling the
mipi_dsi_host_unregister() function in the devm_request_irq() error
path, allowing to also remove the same label.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 60 +++++++++---------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 709a65656b79..5a0f078987d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1117,64 +1117,44 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	dsi->driver_data = of_device_get_match_data(dev);
 
 	dsi->engine_clk = devm_clk_get(dev, "engine");
-	if (IS_ERR(dsi->engine_clk)) {
-		ret = PTR_ERR(dsi->engine_clk);
+	if (IS_ERR(dsi->engine_clk))
+		return dev_err_probe(dev, PTR_ERR(dsi->engine_clk),
+				     "Failed to get engine clock\n");
 
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get engine clock: %d\n", ret);
-		return ret;
-	}
 
 	dsi->digital_clk = devm_clk_get(dev, "digital");
-	if (IS_ERR(dsi->digital_clk)) {
-		ret = PTR_ERR(dsi->digital_clk);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get digital clock: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->digital_clk))
+		return dev_err_probe(dev, PTR_ERR(dsi->digital_clk),
+				     "Failed to get digital clock\n");
 
 	dsi->hs_clk = devm_clk_get(dev, "hs");
-	if (IS_ERR(dsi->hs_clk)) {
-		ret = PTR_ERR(dsi->hs_clk);
-		dev_err(dev, "Failed to get hs clock: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->hs_clk))
+		return dev_err_probe(dev, PTR_ERR(dsi->hs_clk), "Failed to get hs clock\n");
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dsi->regs = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(dsi->regs)) {
-		ret = PTR_ERR(dsi->regs);
-		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->regs))
+		return dev_err_probe(dev, PTR_ERR(dsi->regs), "Failed to ioremap memory\n");
 
 	dsi->phy = devm_phy_get(dev, "dphy");
-	if (IS_ERR(dsi->phy)) {
-		ret = PTR_ERR(dsi->phy);
-		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->phy))
+		return dev_err_probe(dev, PTR_ERR(dsi->phy), "Failed to get MIPI-DPHY\n");
 
 	irq_num = platform_get_irq(pdev, 0);
-	if (irq_num < 0) {
-		ret = irq_num;
-		return ret;
-	}
+	if (irq_num < 0)
+		return irq_num;
 
 	dsi->host.ops = &mtk_dsi_ops;
 	dsi->host.dev = dev;
 	ret = mipi_dsi_host_register(&dsi->host);
-	if (ret < 0) {
-		dev_err(dev, "failed to register DSI host: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register DSI host\n");
 
 	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), dsi);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
-		goto err_unregister_host;
+		mipi_dsi_host_unregister(&dsi->host);
+		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
 	}
 
 	init_waitqueue_head(&dsi->irq_wait_queue);
@@ -1186,10 +1166,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
 
 	return 0;
-
-err_unregister_host:
-	mipi_dsi_host_unregister(&dsi->host);
-	return ret;
 }
 
 static void mtk_dsi_remove(struct platform_device *pdev)
-- 
2.43.0


