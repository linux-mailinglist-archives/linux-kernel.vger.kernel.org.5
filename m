Return-Path: <linux-kernel+bounces-56666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E584CD58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321611C25605
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA528005D;
	Wed,  7 Feb 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rl/l+/wI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861280028
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317605; cv=none; b=hcQsLPHZnXaecLm2njgmJhf/onsvF8ua1vr3faIt9NQBkDZv45YaCSuDhmX2n3HWknoupue4NdjlFSoJOyWgESXoap/m+8ClInbVNDVqgRnkrmVZIvRcwES+q7q8rD6aHi/kDbLlTxFT9EbNhp0duss5jAI1KSk4JtaCynktr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317605; c=relaxed/simple;
	bh=jewx2tbyoHc8XkBckJRK6kMqgXG1NMO8tumrU7DXJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuAKBhYd8543jQYV+bXkkEIZbVtozajHoqstiNt3JVc9D7vok5uf33CnIW8sXWcaitJGIlFe+0K36TtmXfFc3KdeefbUNl1MPZ4n1Q3SEN5JUGi4rAr+/5PkymQuOXY9/P0Xyjzom/YXDposbnzLmidKwUBYK9yVdLQxXyqI3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rl/l+/wI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707317602;
	bh=jewx2tbyoHc8XkBckJRK6kMqgXG1NMO8tumrU7DXJMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rl/l+/wI9KF7mFOrWNFvQ17zQZL0O9OEBsMys17CWDbPl8VOKoh9GBfrUA38MUX++
	 1UP5C/Z8jH61Md4XPh78NuR6JpypkuwzAemrHmvP1TtWny+dfvhVcksfY3ALMU6/rS
	 eIvDerhdvjkvODSFEmXs04Sgcon24gMWqdQn1T0CyDAFD2lZMNC8tjgMlRI/TuYo7n
	 GCzfMGZ/U7HS4jHn9H977TAPS29114GyKT4m2TF6jTgjDPiv1yK1cs6wfDrujTQl8Q
	 mlsAyUrYXhPkhNsJ78lpO+zcRLLIK8l5TwuHE9+HxBunuNlhx46zUAPfKjg9KVM2up
	 kOi1FZuIx0ABA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1E3273782076;
	Wed,  7 Feb 2024 14:53:21 +0000 (UTC)
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
Subject: [PATCH v5 7/9] drm/mediatek: dsi: Simplify with dev_err_probe and remove gotos
Date: Wed,  7 Feb 2024 15:53:05 +0100
Message-ID: <20240207145307.1626009-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
References: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
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

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 60 +++++++++---------------------
 1 file changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b3dd6251d611..195ff4dfc3a3 100644
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


