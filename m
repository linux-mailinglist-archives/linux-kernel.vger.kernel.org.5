Return-Path: <linux-kernel+bounces-66446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E06855CED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61143282F44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8406217732;
	Thu, 15 Feb 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zUMmTfvr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF5714A87
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987205; cv=none; b=Ae0G9xZuStS51ylSYBm0fWafe6PB1KK2bDkEq+UEObiEQyiY7/Nq6wTkx4kwMpok+OymTpesNMn250dkwKzQFEMgP8h1NFCsYM/mb9N9eemT7Dz4BC9WE0HLIPcOaHcaTagO6zbnALcZSBm5fJCpis9UUaHs2aRVeQwrd+3eYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987205; c=relaxed/simple;
	bh=XSolIgr5FDe9KoB4OQ4H+QA/Yd/l3BaoCY5DEBJY/mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7J/5Pqe9tRaop9YIFKMmKLFgsTH4WgHe3Zz6Qlmz7cWMkwvUifJAn1tm1724Vv8tL8SMe3ZRVQZcW8XMwBUmgBssv0Cgi3N1hVZ8tP202W7jW0V7G6XO18kA37b1ue7n7A3Y0e3DvnViJFPLMJ61cHUTP9qZwvVug63KEI9hC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zUMmTfvr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707987202;
	bh=XSolIgr5FDe9KoB4OQ4H+QA/Yd/l3BaoCY5DEBJY/mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zUMmTfvrYQcZ9VONv9rJXbrs31nlTcd98KlWPcu4JdrTAbIBz/fcsDmwYDaMjSay5
	 nHld9nvDO7M9ODtd5MnnPsIlMnTEFCMhAAiU22suAbeh6+HnQqMiKH17VzZrbNmF7x
	 pddKrrB6+7W57B+m6CQc8RDKFJM2YKOzFsPOHzBNSp6kiiHPuphOzmrHJB04pD+SGN
	 urJuskKU/aTm0FBXwvd0Q3g3OgJDXoEU/1ps36BJOIAr6vqxyqRfqPOK6M/CCLqSOI
	 D/iUGSbjUce2xrVZ4wC2/06VrQRh71VmrNsP+JvhefM1zpDkbdKxxdodoEFeeD9yPR
	 ieQL1Wvid7YEA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5670D37820B1;
	Thu, 15 Feb 2024 08:53:21 +0000 (UTC)
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
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v6 2/9] drm/mediatek: dsi: Fix DSI RGB666 formats and definitions
Date: Thu, 15 Feb 2024 09:53:09 +0100
Message-ID: <20240215085316.56835-3-angelogioacchino.delregno@collabora.com>
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

The register bits definitions for RGB666 formats are wrong in multiple
ways: first, in the DSI_PS_SEL bits region, the Packed 18-bits RGB666
format is selected with bit 1, while the Loosely Packed one is bit 2,
and second - the definition name "LOOSELY_PS_18BIT_RGB666" is wrong
because the loosely packed format is 24 bits instead!

Either way, functions mtk_dsi_ps_control_vact() and mtk_dsi_ps_control()
do not even agree on the DSI_PS_SEL bit to set in DSI_PSCTRL: one sets
loosely packed (24) on RGB666, the other sets packed (18), and the other
way around for RGB666_PACKED.

Fixing this entire stack of issues is done in one go:
 - Use the correct bit for the Loosely Packed RGB666 definition
 - Rename LOOSELY_PS_18BIT_RGB666 to LOOSELY_PS_24BIT_RGB666
 - Change ps_bpp_mode in mtk_dsi_ps_control_vact() to set:
    - Loosely Packed, 24-bits for MIPI_DSI_FMT_RGB666
    - Packed, 18-bits for MIPI_DSI_FMT_RGB666_PACKED

Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index c66e18006070..8af0afbe9e3d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -71,8 +71,8 @@
 #define DSI_PS_WC			GENMASK(13, 0)
 #define DSI_PS_SEL			GENMASK(17, 16)
 #define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
+#define PACKED_PS_18BIT_RGB666		(1 << 16)
+#define LOOSELY_PS_24BIT_RGB666		(2 << 16)
 #define PACKED_PS_24BIT_RGB888		(3 << 16)
 
 #define DSI_VSA_NL		0x20
@@ -370,10 +370,10 @@ static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
 		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
+		ps_bpp_mode |= LOOSELY_PS_24BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
 		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
@@ -427,7 +427,7 @@ static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
+		tmp_reg = LOOSELY_PS_24BIT_RGB666;
 		dsi_tmp_buf_bpp = 3;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-- 
2.43.0


