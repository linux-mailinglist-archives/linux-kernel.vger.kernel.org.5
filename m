Return-Path: <linux-kernel+bounces-7002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2681A068
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ECD1F21256
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D338F9E;
	Wed, 20 Dec 2023 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NSnjvO65"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B037D18
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703080652;
	bh=YE4rVheJi9RiBpz74kRowAaD1u+38Nqkvny8szX9Jjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSnjvO65LHJWlObLa/kmD7uhjkyfcuGE3pc1tL+ydpVWYy6YVMGrSeBMWWwP9q1bk
	 sGsGBBqwW5R67V1BnTAXyWgNyZf4zCaHAAMOiTBCUjE5PHKRF6BULqmxB0BOiBwZ/P
	 LIaBawdxoqKSw5C2aGrx+ox0FGzFXdzL6hFaDWMelg8sU0A6JpzZZmAtOryuy38z9c
	 W3goaiyihrEjTfrzBDapURVB8U/rwuaxHuNn6UjCVzX9Fjmm0ctZHjS4ZI6wGKlpCa
	 6Wf6rb/V36EpWees+zRm5CsPkffHQuOyHJUk+8aKPuRLQoZ/7zASLaK2PZCOLtXlrI
	 yYpmWO308EsoQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F01463781FED;
	Wed, 20 Dec 2023 13:57:31 +0000 (UTC)
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
Subject: [PATCH v2 2/4] drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
Date: Wed, 20 Dec 2023 14:57:20 +0100
Message-ID: <20231220135722.192080-3-angelogioacchino.delregno@collabora.com>
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

Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
merge the two in one mtk_dsi_ps_control() function by adding one
function parameter `config_vact` which, when true, writes the VACT
related registers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++---------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 23d2c5be8dbb..b618e2e31022 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -352,40 +352,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
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
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
-		break;
-	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
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
@@ -417,36 +383,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
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
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		tmp_reg = PACKED_PS_18BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
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
@@ -522,7 +492,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
 
-	mtk_dsi_ps_control(dsi);
+	mtk_dsi_ps_control(dsi, false);
 }
 
 static void mtk_dsi_start(struct mtk_dsi *dsi)
@@ -667,7 +637,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
-	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_ps_control(dsi, true);
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-- 
2.43.0


