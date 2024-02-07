Return-Path: <linux-kernel+bounces-56662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA3084CD54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669EA28C4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C287FBAE;
	Wed,  7 Feb 2024 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h1vJn5ad"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A447F470
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317600; cv=none; b=cfnvrH6/EFydPQBBy3R+syS2V23pLAMPuLBUfZgN0R0jlBPpnDyYSSlx3GMS0jo+MU25GgHjaF31OQ0v4VO2Btnd/qiPz5X8x6/8/gDLuwPsvIt6px3TAV08RKWbXH3qib/ZQDc6eyBHPUnL/4AbOV9fxUhNQWjaeKm36e8T36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317600; c=relaxed/simple;
	bh=jGk/KNxt01mLk7K8ftidsFFvgZjFPmjzURhw+205rOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4L+FPiiPSonW3NVjuVR0NYD/SiRThyENH3/FL1jwlUtkArWtewkBb9DhEDJ0Lr45Kuvm6sOefiw1vT7RjP5Ulin6mc735MokvNiXWzSitXx8u5vo+Y1fWkofGRVViGAYFQIeDW5W1XA6TwP5FABzp94HJ67wcfzm5P7e0HEcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h1vJn5ad; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707317597;
	bh=jGk/KNxt01mLk7K8ftidsFFvgZjFPmjzURhw+205rOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1vJn5adtIQgUiJTXALxWctWQYA23NNfNQasSD9P+BAt94eWCdLeE1kvP+NnG7E6k
	 FP4AAkZF+K57imDYePkOiH1c8dmtoYFjOalaSKTHFKE+8BHd21ENCLhEUOkQRBBdin
	 STnPebQFCEf+uNV/SXMbQj9fLVgmmqnM5fStUGgdujLvxQXlNww8Nwe9B+7LMsC4an
	 1J/YhYC9RoAPegTYsAyreWvtpiEJ9fgytLlvrMr98/+I05zHFyCkIOnD853s8rCt8+
	 F2+VWNIk/4l9zvZ4IQuf2iE5RUOm+jDnrvuIQohVQEBPV17rA/lKZ/Ifq+QxKKy2Y/
	 lASxIT3Bca8gg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B34A23782076;
	Wed,  7 Feb 2024 14:53:16 +0000 (UTC)
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
Subject: [PATCH v5 3/9] drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
Date: Wed,  7 Feb 2024 15:53:01 +0100
Message-ID: <20240207145307.1626009-4-angelogioacchino.delregno@collabora.com>
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

Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
merge the two in one mtk_dsi_ps_control() function by adding one
function parameter `config_vact` which, when true, writes the VACT
related registers.

Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++---------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 8af0afbe9e3d..7d38e9500700 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -351,40 +351,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
 	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
 }
 
-static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
-{
-	struct videomode *vm = &dsi->vm;
-	u32 dsi_buf_bpp, ps_wc;
-	u32 ps_bpp_mode;
-
-	if (dsi->format == MIPI_DSI_FMT_RGB565)
-		dsi_buf_bpp = 2;
-	else
-		dsi_buf_bpp = 3;
-
-	ps_wc = vm->hactive * dsi_buf_bpp;
-	ps_bpp_mode = ps_wc;
-
-	switch (dsi->format) {
-	case MIPI_DSI_FMT_RGB888:
-		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
-		break;
-	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= LOOSELY_PS_24BIT_RGB666;
-		break;
-	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
-		break;
-	case MIPI_DSI_FMT_RGB565:
-		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
-		break;
-	}
-
-	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
-	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
-	writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
-}
-
 static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 {
 	u32 tmp_reg;
@@ -416,36 +382,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
 }
 
-static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
+static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
 {
-	u32 dsi_tmp_buf_bpp;
-	u32 tmp_reg;
+	struct videomode *vm = &dsi->vm;
+	u32 dsi_buf_bpp, ps_wc;
+	u32 ps_bpp_mode;
+
+	if (dsi->format == MIPI_DSI_FMT_RGB565)
+		dsi_buf_bpp = 2;
+	else
+		dsi_buf_bpp = 3;
+
+	ps_wc = vm->hactive * dsi_buf_bpp;
+	ps_bpp_mode = ps_wc;
 
 	switch (dsi->format) {
 	case MIPI_DSI_FMT_RGB888:
-		tmp_reg = PACKED_PS_24BIT_RGB888;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_24BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= LOOSELY_PS_24BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		tmp_reg = PACKED_PS_18BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
-		tmp_reg = PACKED_PS_16BIT_RGB565;
-		dsi_tmp_buf_bpp = 2;
-		break;
-	default:
-		tmp_reg = PACKED_PS_24BIT_RGB888;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
 		break;
 	}
 
-	tmp_reg += dsi->vm.hactive * dsi_tmp_buf_bpp & DSI_PS_WC;
-	writel(tmp_reg, dsi->regs + DSI_PSCTRL);
+	if (config_vact) {
+		writel(vm->vactive, dsi->regs + DSI_VACT_NL);
+		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
+	}
+	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
 }
 
 static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
@@ -521,7 +491,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
 
-	mtk_dsi_ps_control(dsi);
+	mtk_dsi_ps_control(dsi, false);
 }
 
 static void mtk_dsi_start(struct mtk_dsi *dsi)
@@ -666,7 +636,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
-	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_ps_control(dsi, true);
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-- 
2.43.0


