Return-Path: <linux-kernel+bounces-54865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE284B493
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24B91F27E00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94E130E5F;
	Tue,  6 Feb 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nt24JE8o"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1C130AE0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221290; cv=none; b=IzpmPBkcZ6JDUEVN4OcY0gw+VcS4K4p484g3e8kK+T2fAKvf6naM56aMyrL4mp3GLvqzv+HiUUXcyvVfOqvq0SrW4h01W+qOjDe5C7P+k+rwX8309yvE5FUPpwpKsjSEUFXyZMEs9DQY2x/ayttAKU0UwnqyZL5RJb3DPQ6JtoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221290; c=relaxed/simple;
	bh=KQ+9GSduM0u+BUTeEpV9c56+NpNaqgdR1oTlNOSuCF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOfSCBzTEQrCeIK9cE9Eo47Ka4dJTMJDaY9EJT4XjpuXqlildNBtuOoq52qtecm9QzxBu3lWz7+JBjt7KbPtxHCUX49qE0lkRjNqCm+QT1bIP3ZulNDZ3u6NBMLfDqsLd7fbNTCYIsUvYzdzdDZR5VQjj79GH0dZnzOqcKQ7Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nt24JE8o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707221278;
	bh=KQ+9GSduM0u+BUTeEpV9c56+NpNaqgdR1oTlNOSuCF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt24JE8oU7BA+nXkjDzVtZvgXIrhXRzpqMjiUUskZAFWbXbS9voNSX3dSltaGYYot
	 tKSp2Wq48Zer+Cge6JN7JWbf4WEd2N4KyKHHMpxD8IVaq5izcTVPBb6FL0UJhcqyxX
	 qtQZB+1K+nd6T9mRM5tSwU5lvDmdae0cJC9ziupTMRT4WTF3rVUK/yDEAfOEf+sn1f
	 t6tIA8kRRZQcidZp7/u/s53dsNj5iHwkWEK26DwR+TJwY9mnehydz+OaP7A3SbqotP
	 NnuueyFnYtukJRNm2AirHJzjShBRBU++LqjmP4fDHpTGuGx+EfNB7SBMAHqdzQFszY
	 TZ4mkQc5q2yFQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D94B03782083;
	Tue,  6 Feb 2024 12:07:57 +0000 (UTC)
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
Subject: [PATCH v4 6/9] drm/mediatek: dsi: Register DSI host after acquiring clocks and PHY
Date: Tue,  6 Feb 2024 13:07:45 +0100
Message-ID: <20240206120748.136610-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5e383ca00ba8..6ee01626d55c 100644
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


