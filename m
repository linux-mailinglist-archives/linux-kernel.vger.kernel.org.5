Return-Path: <linux-kernel+bounces-56668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E584CD5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735AFB23D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63681217;
	Wed,  7 Feb 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oF4PmVlL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213480BE0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317607; cv=none; b=RGvyRjx/Eyun7U+OqhE7OIYeDyiScNINPQPSCebk8Zdn+b5g6Mn3A2ur7SHT8fI4akTgTi1rGmW60u7Nmma5kviyGYUvLZc14ZOez6H8BUbCCf9B7PUm1Ha/EVQnCKMdo4ULh5FVh+9lJvmgVAq0nuvzL/firDM0XRiKsJygYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317607; c=relaxed/simple;
	bh=t314JYLEkG/5o9HpK7I9qR3Mx0x17vEhEBxIxc/bWK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqji/wGbDeuZH1Lj/2L5nddbIeyrHG7ObhAT9k0pVWxt4korjyKVNpRl16gVHWodJ6LNrcnLjF9IxJjxeanZdYp1y9KU+ciV3DupNwWtqf2kt5QqvADN7s9cWNM7s2SnWN7SyRaLeYA+JPoxSA1i6DrAAFVXP5lLSAnZ54y9UZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oF4PmVlL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707317604;
	bh=t314JYLEkG/5o9HpK7I9qR3Mx0x17vEhEBxIxc/bWK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oF4PmVlLOMnmfRKhI8wyvjtZ3sH/fa/3SrHXuaP6e3Mt4yv/Q3OKS1J9GSOuywgM0
	 vlsP197c+IMOPSCPdiQZGi+othum7S8Y+zr/jzNt+mc6SIYlp7LMCAFHrk4Uy72alm
	 JNVaOwzNowWBeE4RtrbJ8MMMZl9ugfOBdLrh+USCt+AqLSk5DDw7OcZOBa80SuZeqQ
	 m1oHMSMmts2NOcg+w5/igadWrpU/Wyt9JUnOrz6kve0ctieqPYyppGkvEqIICeG/T4
	 sihnDa35bP8mRMYrRaCFF8b+AiP+ELenXwq5YKo4l0rNFPuMpZYVYZLSlIIOACS8rW
	 OGAc9ncs4fqHA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A925378207B;
	Wed,  7 Feb 2024 14:53:23 +0000 (UTC)
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
Subject: [PATCH v5 9/9] drm/mediatek: dsi: Use mipi_dsi_pixel_format_to_bpp() helper function
Date: Wed,  7 Feb 2024 15:53:07 +0100
Message-ID: <20240207145307.1626009-10-angelogioacchino.delregno@collabora.com>
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

Instead of open coding, use the mipi_dsi_pixel_format_to_bpp() helper
function from drm_mipi_dsi.h in mtk_dsi_poweron() and for validation
in mtk_dsi_bridge_mode_valid().

Note that this function changes the behavior of this driver: previously,
in case of unknown formats, it would (wrongly) assume that it should
account for a 24-bits format - now it will return an error and refuse
to set clocks and/or enable the DSI.

This is done because setting the wrong data rate will only produce a
garbage output that the display will misinterpret both because this
driver doesn't actually provide any extra-spec format support and/or
because the data rate (hence, the HS clock) will be wrong.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b644505de98a..9501f4019199 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -598,19 +598,12 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	if (++dsi->refcount != 1)
 		return 0;
 
-	switch (dsi->format) {
-	case MIPI_DSI_FMT_RGB565:
-		bit_per_pixel = 16;
-		break;
-	case MIPI_DSI_FMT_RGB666_PACKED:
-		bit_per_pixel = 18;
-		break;
-	case MIPI_DSI_FMT_RGB666:
-	case MIPI_DSI_FMT_RGB888:
-	default:
-		bit_per_pixel = 24;
-		break;
+	ret = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (ret < 0) {
+		dev_err(dev, "Unknown MIPI DSI format %d\n", dsi->format);
+		return ret;
 	}
+	bit_per_pixel = ret;
 
 	dsi->data_rate = DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel,
 					  dsi->lanes);
@@ -793,12 +786,11 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_mode *mode)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
-	u32 bpp;
+	int bpp;
 
-	if (dsi->format == MIPI_DSI_FMT_RGB565)
-		bpp = 16;
-	else
-		bpp = 24;
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (bpp < 0)
+		return MODE_ERROR;
 
 	if (mode->clock * bpp / dsi->lanes > 1500000)
 		return MODE_CLOCK_HIGH;
-- 
2.43.0


