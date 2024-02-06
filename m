Return-Path: <linux-kernel+bounces-54867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B984B495
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3C280F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB5131E2B;
	Tue,  6 Feb 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j/XEAJC3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FD130AE3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221292; cv=none; b=RuL2k5JqCtvp5J3tUAktj8XzaR4TXn4lrbhi788Fflg2OVB/rd/uPZZ/bCrc3dDIPPT4sfdMf8xZO6onc6ITgD+sFlfWHTiOPgLXJXj+RF8iQ9nWlHknt1Le5DAXmrFjw44/sn5mXv234Heu+rJcJcFC3YDTUttYNfC5rMTn0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221292; c=relaxed/simple;
	bh=yXoRgeiQ6ZbdAo4rsLu5fJfcoA4FVsw4hwaCPWMqWAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H82ad+OVz6DnEISBZynKJQpqjajoFpGEdcG/hwYMjYEyE4G6Ri5bhWNhApgkfpl5a1ourSlRiO7caBwcKbhkJfybo2fEYRHTtDGBjsdlf+GlAccXfUM2vS44YohuYloeYHrV/NhQaGo+pKQECjkC1W30faTzbKhw30omb9GOPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j/XEAJC3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707221280;
	bh=yXoRgeiQ6ZbdAo4rsLu5fJfcoA4FVsw4hwaCPWMqWAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/XEAJC3o4Pi5BjFITL3Xa3wyFVckJh3TSEjUWRS0CNYeDsvWSxkjhmACQ35mIICE
	 GTdeho7DPqK9M6qpAKYKXtp+6tstykD3FdOHZ1xJRQqi1SAbUGIYhxMn1y4qWulE5N
	 cdtGoUWxRk22E9jkpyqPONPtbpzJdjdgubxiYKiVrmmB6iLCs7SXo8mxspdc0EC5fC
	 +TqAkycTsY8ED1wbWL9tMA8VIRxhf4blg/GCXwhcGV6jmS1N+X/6jL3os2t6VFYa+M
	 4+fLEDfr24qb+upb1fvOzuRu4y0aNZ/Q4nMAUqkezJnXdKmrN8/LgQGbXTs7RVsS+K
	 qsQpqIEO+Gnfg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DFA293782089;
	Tue,  6 Feb 2024 12:07:59 +0000 (UTC)
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
Subject: [PATCH v4 8/9] drm/mediatek: dsi: Compress of_device_id entries and add sentinel
Date: Tue,  6 Feb 2024 13:07:47 +0100
Message-ID: <20240206120748.136610-9-angelogioacchino.delregno@collabora.com>
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

All entries fit in 82 columns, which is acceptable: compress all of
the mtk_dsi_of_match[] entries to a single line for each.

While at it, also add the usual sentinel comment to the last entry.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 8d407d71e9db..545c5cc071d9 100644
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


