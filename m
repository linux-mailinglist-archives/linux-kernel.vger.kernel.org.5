Return-Path: <linux-kernel+bounces-7003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62F81A069
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00DE1C2299C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752843984E;
	Wed, 20 Dec 2023 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KX9gZAfh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680438DE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703080653;
	bh=+gGuh2AikNqJLddeHR6us0n26EBnilTO10PFnNdMe9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KX9gZAfhox22IOqvwYu2wn2vGnc4LjjaX/9Im0XWfmBMX1ioLoNevCy2JHGZd/YwX
	 3IvCJcqe1XnUaIN1qHBpxbkElaOkHytST0npVQgvCAjDUqsotxQoOoab2Vm1x/IxQY
	 vO4eb9btCsDzXSQhC3O/O7BTbQ+VnM2TBSDeIqtiYgv3UxAwjFTc+/tCDEn39r3vSo
	 bvEZ1mbYn9cQJh9WbSm+AKxO3tu/GPWjwXsiXpmDfYpqV8S08FAZGRi+3zhPAzB8fm
	 MAPQOKpAAN4oCdxPVDY5bqhO1xM0nCGAkgVFO4XyLtxBdPWfgcoWgehYT6Qc+DEVUo
	 iRDyxEFR6jCBA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 099B53781FF1;
	Wed, 20 Dec 2023 13:57:32 +0000 (UTC)
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
Subject: [PATCH v2 3/4] drm/mediatek: dsi: Use bitfield macros where useful
Date: Wed, 20 Dec 2023 14:57:21 +0100
Message-ID: <20231220135722.192080-4-angelogioacchino.delregno@collabora.com>
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

Instead of open coding bitshifting for various register fields,
use the bitfield macro FIELD_PREP(): this allows to enhance the
human readability, decrease likeliness of mistakes (and register
field overflowing) and also to simplify the code.
The latter is especially seen in mtk_dsi_rxtx_control(), where
it was possible to change a switch to a short for loop and to
also remove the need to check for maximum DSI lanes == 4 thanks
to the FIELD_PREP macro masking the value.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 95 ++++++++++++++++--------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b618e2e31022..2ba6cd129150 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -70,16 +70,19 @@
 #define DSI_PSCTRL		0x1c
 #define DSI_PS_WC			GENMASK(14, 0)
 #define DSI_PS_SEL			GENMASK(19, 16)
-#define PACKED_PS_16BIT_RGB565		(0 << 16)
-#define LOOSELY_PS_18BIT_RGB666		(1 << 16)
-#define PACKED_PS_18BIT_RGB666		(2 << 16)
-#define PACKED_PS_24BIT_RGB888		(3 << 16)
+#define PACKED_PS_16BIT_RGB565		0
+#define LOOSELY_PS_18BIT_RGB666		1
+#define PACKED_PS_18BIT_RGB666		2
+#define PACKED_PS_24BIT_RGB888		3
 
 #define DSI_VSA_NL		0x20
 #define DSI_VBP_NL		0x24
 #define DSI_VFP_NL		0x28
 #define DSI_VACT_NL		0x2C
+#define VACT_NL				GENMASK(14, 0)
 #define DSI_SIZE_CON		0x38
+#define DSI_HEIGHT				GENMASK(30, 16)
+#define DSI_WIDTH				GENMASK(14, 0)
 #define DSI_HSA_WC		0x50
 #define DSI_HBP_WC		0x54
 #define DSI_HFP_WC		0x58
@@ -254,14 +257,23 @@ static void mtk_dsi_phy_timconfig(struct mtk_dsi *dsi)
 	timing->clk_hs_zero = timing->clk_hs_trail * 4;
 	timing->clk_hs_exit = 2 * timing->clk_hs_trail;
 
-	timcon0 = timing->lpx | timing->da_hs_prepare << 8 |
-		  timing->da_hs_zero << 16 | timing->da_hs_trail << 24;
-	timcon1 = timing->ta_go | timing->ta_sure << 8 |
-		  timing->ta_get << 16 | timing->da_hs_exit << 24;
-	timcon2 = 1 << 8 | timing->clk_hs_zero << 16 |
-		  timing->clk_hs_trail << 24;
-	timcon3 = timing->clk_hs_prepare | timing->clk_hs_post << 8 |
-		  timing->clk_hs_exit << 16;
+	timcon0 = FIELD_PREP(LPX, timing->lpx) |
+		  FIELD_PREP(HS_PREP, timing->da_hs_prepare) |
+		  FIELD_PREP(HS_ZERO, timing->da_hs_zero) |
+		  FIELD_PREP(HS_TRAIL, timing->da_hs_trail);
+
+	timcon1 = FIELD_PREP(TA_GO, timing->ta_go) |
+		  FIELD_PREP(TA_SURE, timing->ta_sure) |
+		  FIELD_PREP(TA_GET, timing->ta_get) |
+		  FIELD_PREP(DA_HS_EXIT, timing->da_hs_exit);
+
+	timcon2 = FIELD_PREP(DA_HS_SYNC, 1) |
+		  FIELD_PREP(CLK_ZERO, timing->clk_hs_zero) |
+		  FIELD_PREP(CLK_TRAIL, timing->clk_hs_trail);
+
+	timcon3 = FIELD_PREP(CLK_HS_PREP, timing->clk_hs_prepare) |
+		  FIELD_PREP(CLK_HS_POST, timing->clk_hs_post) |
+		  FIELD_PREP(CLK_HS_EXIT, timing->clk_hs_exit);
 
 	writel(timcon0, dsi->regs + DSI_PHY_TIMECON0);
 	writel(timcon1, dsi->regs + DSI_PHY_TIMECON1);
@@ -354,69 +366,61 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
 
 static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 {
-	u32 tmp_reg;
+	u32 regval, tmp_reg = 0;
+	u8 i;
 
-	switch (dsi->lanes) {
-	case 1:
-		tmp_reg = 1 << 2;
-		break;
-	case 2:
-		tmp_reg = 3 << 2;
-		break;
-	case 3:
-		tmp_reg = 7 << 2;
-		break;
-	case 4:
-		tmp_reg = 0xf << 2;
-		break;
-	default:
-		tmp_reg = 0xf << 2;
-		break;
-	}
+	/* Number of DSI lanes (max 4 lanes), each bit enables one DSI lane. */
+	for (i = 0; i < dsi->lanes; i++)
+		tmp_reg |= BIT(i);
+
+	regval = FIELD_PREP(LANE_NUM, tmp_reg);
 
 	if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
-		tmp_reg |= HSTX_CKLP_EN;
+		regval |= HSTX_CKLP_EN;
 
 	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
-		tmp_reg |= DIS_EOT;
+		regval |= DIS_EOT;
 
-	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
+	writel(regval, dsi->regs + DSI_TXRX_CTRL);
 }
 
 static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
 {
-	struct videomode *vm = &dsi->vm;
-	u32 dsi_buf_bpp, ps_wc;
-	u32 ps_bpp_mode;
+	u32 dsi_buf_bpp, ps_val, ps_wc, vact_nl;
 
 	if (dsi->format == MIPI_DSI_FMT_RGB565)
 		dsi_buf_bpp = 2;
 	else
 		dsi_buf_bpp = 3;
 
-	ps_wc = vm->hactive * dsi_buf_bpp;
-	ps_bpp_mode = ps_wc;
+	/* Word count */
+	ps_wc = FIELD_PREP(DSI_PS_WC, dsi->vm.hactive * dsi_buf_bpp);
+	ps_val = ps_wc;
 
+	/* Pixel Stream type */
 	switch (dsi->format) {
+	default:
+		/* fallthrough */
 	case MIPI_DSI_FMT_RGB888:
-		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
+		ps_val |= FIELD_PREP(DSI_PS_SEL, PACKED_PS_24BIT_RGB888);
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
+		ps_val |= FIELD_PREP(DSI_PS_SEL, PACKED_PS_18BIT_RGB666);
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
+		ps_val |= FIELD_PREP(DSI_PS_SEL, LOOSELY_PS_18BIT_RGB666);
 		break;
 	case MIPI_DSI_FMT_RGB565:
-		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
+		ps_val |= FIELD_PREP(DSI_PS_SEL, PACKED_PS_16BIT_RGB565);
 		break;
 	}
 
 	if (config_vact) {
-		writel(vm->vactive, dsi->regs + DSI_VACT_NL);
+		vact_nl = FIELD_PREP(VACT_NL, dsi->vm.vactive);
+		writel(vact_nl, dsi->regs + DSI_VACT_NL);
 		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
 	}
-	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
+	writel(ps_val, dsi->regs + DSI_PSCTRL);
 }
 
 static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
@@ -443,7 +447,8 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
 
 	if (dsi->driver_data->has_size_ctl)
-		writel(vm->vactive << 16 | vm->hactive,
+		writel(FIELD_PREP(DSI_HEIGHT, vm->vactive) |
+		       FIELD_PREP(DSI_WIDTH, vm->hactive),
 		       dsi->regs + DSI_SIZE_CON);
 
 	horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
-- 
2.43.0


