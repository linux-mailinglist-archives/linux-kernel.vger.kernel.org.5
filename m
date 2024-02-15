Return-Path: <linux-kernel+bounces-66452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3187855CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7431928BE11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3A1BDCF;
	Thu, 15 Feb 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WbHtbgpF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190251B95A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987212; cv=none; b=e3Redn3oRSgRgA75AxDQowtmm5Lp6F710GRIb8hkBm1hprwt0LnIO9KvBSGV2pPI0eg0BovcW3vMYZuAJxQW9x1K4BEhHQqueCrDTsjONMp/Qp/we0VhvGY01vyRTqPW0oHshvV/eGjWPxgDYm/0/oRj3yZC2t7SSLb2ta4++5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987212; c=relaxed/simple;
	bh=2kYcQ73m5VVQx0p8fzsV+YSRRDCiNyzlRkXbM24wCGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kL3tP/FDCmQ+jU5sn3iTcZeyTQkfctHpwLYaFIXLDnDwk9/RJ7WrzbQIDHw/mkn0GeqPLSMfXQtNAIiI+8hWk8rIBjnUZUrskhtomEcyCfzePFGaYMd7NoJcluYhUuZgDJlIfvwno4pO2ErhgFNOe0UCylm5TFXLUD69XH9XjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WbHtbgpF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987209;
	bh=2kYcQ73m5VVQx0p8fzsV+YSRRDCiNyzlRkXbM24wCGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbHtbgpFJWFjURzyiWBYTuYd1nJqdFtctwVM3Q5+TK6PjXKFZNn3IItKPOxpx2u2D
	 HcxZVuLWZCl+PFx+tGk5X8E0UKa6lHm25sWsDDSjAEX80CM+b0lx70vdIXEicB1hzt
	 CtrA0f6NBDj4oabmDbvSSZzB2wVoBo3VklJjsmcIhYeGPen1kxt9HMn6m8w2azFQ5O
	 +znL/bmTFIc6e+BJ1vOFje1sGKRsk7Wy6VilW1bz+h6l0rfCNOT3sA4PK1GdWoHdfF
	 e7c6GqSONJLguwcmZpHEHAXy0j73hRkQitVpqqLpfDhiYYfc/CuwU/wamNevLpWJ8I
	 edtzAtpR4lfsg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8B4037820B6;
	Thu, 15 Feb 2024 08:53:28 +0000 (UTC)
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
Subject: [PATCH v6 8/9] drm/mediatek: dsi: Compress of_device_id entries and add sentinel
Date: Thu, 15 Feb 2024 09:53:15 +0100
Message-ID: <20240215085316.56835-9-angelogioacchino.delregno@collabora.com>
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


