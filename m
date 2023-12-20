Return-Path: <linux-kernel+bounces-7004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7D581A06A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F0A1C22C23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504463A29A;
	Wed, 20 Dec 2023 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OYnNlcpS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F838F90
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703080654;
	bh=oCsTlzOS6oSxRGdJ1goQg2w9teTFYwuxwEp7xWcBwpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYnNlcpS/D8peXYscsbSFXGU+HqzinoYLzgDTqfkWAMdO/6abvAMZXnB9VVW7SKuE
	 9J1G1vaJokfATNAds7XzLU7nhvaJFnt9ZKOxtqYm2AZTrKpFgtpk7S6dkqCi1V+Lk2
	 oDYTvEZnsUdod5gV/17Ep0ufzVMPgUfXwwfNkyiinuoanLIWxzFdFMJJGhPwJGeSTt
	 eY4M/1pVbRXMLeOiyJu3h68Z4u7F6dwD02NZQ+0OhKaZ16QUFuvHcan8PpjkpGd9fk
	 uD5EtEnxcA8s3KMCDIjO44QZ16vUL71U59o7YkwBpZUVMcUdzDgNqJ9+CWWJfKCrha
	 Tvcgd0NmqRdrg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 063993781F8C;
	Wed, 20 Dec 2023 13:57:33 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 4/4] drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
Date: Wed, 20 Dec 2023 14:57:22 +0100
Message-ID: <20231220135722.192080-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220135722.192080-1-angelogioacchino.delregno@collabora.com>
References: <20231220135722.192080-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtk_dsi_phy_timconfig(), we're dividing the `data_rate` variable,
expressed in Hz to retrieve a value in MHz: instead of open-coding,
use the HZ_PER_MHZ definition, available in linux/units.h.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 2ba6cd129150..b9a37407f3b4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -12,6 +12,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #include <video/mipi_display.h>
 #include <video/videomode.h>
@@ -237,7 +238,7 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
+	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, HZ_PER_MHZ);
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
 	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
-- 
2.43.0


