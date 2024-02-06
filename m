Return-Path: <linux-kernel+bounces-54863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385184B491
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2984EB250E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A5130E44;
	Tue,  6 Feb 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SHK1PNlO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D1130AC1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221289; cv=none; b=M/eVbF2Drh43gIUOJE5fzhAwnziKZTQA3bGEzR4c9UgBXIZ8twDKPDqj51sH2edXZCnTkNUfghMomwPsbioL7KFqYa1GCyHAGRGTfAcDjriRLuBsaM7h4xc2mN6s9bDzVFeliWrQnWxctFWJybFR0jfEouB1ri4Uuk+zLUO4+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221289; c=relaxed/simple;
	bh=mccYyS90vn45+hq6oaGnHGsB4mCj/z4kAT02aNdMkKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5Tp94eYomSk4p8CQvKZI4hrIyH+wBxErXu07KerBLDgicI1/votE75i1aQsNVdYIzTUk6QZhC2mFVByZflueQwkXdiHr6x+idaeO+Q8z+6KOcLcTwUTCiKvSvJIyAqveMfpyw2NZHInjyT/zb74W9x50FiUxwXGD3rlwWKQoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SHK1PNlO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707221277;
	bh=mccYyS90vn45+hq6oaGnHGsB4mCj/z4kAT02aNdMkKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHK1PNlOMVl1mXpVM4zFaFL9oQ/LgGbvtTDCS5/yt4hwbtDPOUdEicpGaGzGgVFwO
	 KdtSHY+MzWrHkV5RPGAB9VoXDDWgELLXzoTMh1q9RA+EbkKFAqbwvElpCNRhSBPmSB
	 qz/GsWHu64p89/aHJqlXt84muFf5rSVBavjj0o/bXPxb5uJE/+EkeuNrvx2tUI/BJP
	 CoMukns/Iwp4wuvPKDEIdigpZKT/rC1jO1PgUNp+06rdR/78P3Lo92aXskLrdEav2a
	 GL8xXRfa2jdrah9w2cKp8rhWspsIV1NmC7HDC1++5TF2+IucLsxI+Axb+k3KCNO1eV
	 YN0ljG2y1gWxw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D71B83782080;
	Tue,  6 Feb 2024 12:07:56 +0000 (UTC)
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
Subject: [PATCH v4 5/9] drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ
Date: Tue,  6 Feb 2024 13:07:44 +0100
Message-ID: <20240206120748.136610-6-angelogioacchino.delregno@collabora.com>
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

In mtk_dsi_phy_timconfig(), we're dividing the `data_rate` variable,
expressed in Hz to retrieve a value in MHz: instead of open-coding,
use the HZ_PER_MHZ definition, available in linux/units.h.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 26c221737387..5e383ca00ba8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -13,6 +13,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/units.h>
 
 #include <video/mipi_display.h>
 #include <video/videomode.h>
@@ -238,7 +239,7 @@ static void mtk_dsi_mask(struct mtk_dsi *dsi, u32 offset, u32 mask, u32 data)
 static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 {
 	u32 timcon0, timcon1, timcon2, timcon3;
-	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, 1000000);
+	u32 data_rate_mhz = DIV_ROUND_UP(dsi->data_rate, HZ_PER_MHZ);
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 
 	timing->lpx = (60 * data_rate_mhz / (8 * 1000)) + 1;
-- 
2.43.0


