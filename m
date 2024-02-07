Return-Path: <linux-kernel+bounces-56667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A29D84CD59
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503081C20AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647A7F7DF;
	Wed,  7 Feb 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bKzC1Xai"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3F80055
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317606; cv=none; b=eizHl/DHlT8ZtyKw8UOlFNI5EwEIFM2wBmWwR848Q5EiDFxH/m+rwR5enYteEvhDH7jttB1INj0uETWDXaBzvGyDVTW9FoQRq1ksUsuxebixFr4TGSMWZVmHUvIWr5SO13zVf2XSuUbAM3LZXfxqU3fKVLyn6dmCIHjOpcaD1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317606; c=relaxed/simple;
	bh=2kYcQ73m5VVQx0p8fzsV+YSRRDCiNyzlRkXbM24wCGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAti/iwLpsEz33g0zava1hZEqt5q8ID4dOgjsYLnda7/t0VzAbSrmZ7ewauw2ZBulxGzSrvBeByXjrf07uKfIPw1eDDly/4hFSj9bAUEZ3vGRRzZizcz9bAuo1/I/RmoDCEwhJM3MwujpQmWI5G1XBAQX+KdvPQrJ7+u3Lf44PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bKzC1Xai; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707317603;
	bh=2kYcQ73m5VVQx0p8fzsV+YSRRDCiNyzlRkXbM24wCGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKzC1Xaiw97+37hOfHTOji0jR1tlMRRnzGZjhU11+FJd5FgdqbxVCUZ6GWPD0dnA5
	 WqaN6wrKGyd6vKT3CkhBuC6xeuULRGauy6rzPoKd0i4UjXhI60OI0g1Hk8JwkvXLWa
	 uqOH1pf5+dTTPqc73cRSVJTg0Bim10BEYb8AQQhqaA1gzMe2VBKEr3A0W5ftNU5Ts0
	 vxefUnywiRy3Em4LLGYeIRx7Cg1+lqagziAAb+XvUO8GD3S+3RPFmBGXmkeNX2Ca3h
	 NA07lccWa6Zf4P2hJOTXiHXgWuIHTefTrXCx8foAbQs3q6rX9xHTXzjv3GZchu8rXW
	 aH/NAPI0B2ozw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2EC6B3782073;
	Wed,  7 Feb 2024 14:53:22 +0000 (UTC)
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
Subject: [PATCH v5 8/9] drm/mediatek: dsi: Compress of_device_id entries and add sentinel
Date: Wed,  7 Feb 2024 15:53:06 +0100
Message-ID: <20240207145307.1626009-9-angelogioacchino.delregno@collabora.com>
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

All entries fit in 82 columns, which is acceptable: compress all of
the mtk_dsi_of_match[] entries to a single line for each.

While at it, also add the usual sentinel comment to the last entry.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 195ff4dfc3a3..b644505de98a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1204,17 +1204,12 @@ static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
 };
 
 static const struct of_device_id mtk_dsi_of_match[] = {
-	{ .compatible = "mediatek,mt2701-dsi",
-	  .data = &mt2701_dsi_driver_data },
-	{ .compatible = "mediatek,mt8173-dsi",
-	  .data = &mt8173_dsi_driver_data },
-	{ .compatible = "mediatek,mt8183-dsi",
-	  .data = &mt8183_dsi_driver_data },
-	{ .compatible = "mediatek,mt8186-dsi",
-	  .data = &mt8186_dsi_driver_data },
-	{ .compatible = "mediatek,mt8188-dsi",
-	  .data = &mt8188_dsi_driver_data },
-	{ },
+	{ .compatible = "mediatek,mt2701-dsi", .data = &mt2701_dsi_driver_data },
+	{ .compatible = "mediatek,mt8173-dsi", .data = &mt8173_dsi_driver_data },
+	{ .compatible = "mediatek,mt8183-dsi", .data = &mt8183_dsi_driver_data },
+	{ .compatible = "mediatek,mt8186-dsi", .data = &mt8186_dsi_driver_data },
+	{ .compatible = "mediatek,mt8188-dsi", .data = &mt8188_dsi_driver_data },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
 
-- 
2.43.0


