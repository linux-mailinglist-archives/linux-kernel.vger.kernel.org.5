Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A4785BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjHWPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbjHWPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D129E7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:14:03 -0700 (PDT)
X-UUID: ac9c951e41c711ee9cb5633481061a41-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ey8vT1EiSQ2fQqWjJUmnXbIUWTWmXmEcBtImDOT5o8Y=;
        b=DMiBr25Woe92bqUdd1BwKuXQ+e+8FcQm3AXN99NB7Lgt8znnuw/U2CVAt4EyRhaPmVhGwiwEPb/1bfzHWVXEdQwSQM9sztlL1QhVBUgkBiv33+ViPBKWcciifXZcGsZz29+22avq5qcSb/0I/XVgaoKVkzMdlETT9LjKHQYFpBs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f18dc6bd-de69-4c14-ba35-9a00191c6854,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:0f6bddee-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac9c951e41c711ee9cb5633481061a41-20230823
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1830995414; Wed, 23 Aug 2023 23:13:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 23:13:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 23:13:53 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Jassi Brar" <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 06/15] drm/mediatek: Support alpha blending in VDOSYS0
Date:   Wed, 23 Aug 2023 23:13:23 +0800
Message-ID: <20230823151332.28811-7-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230823151332.28811-1-shawn.sung@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support premultiply and coverage alpha blending modes.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 175 +++++++++++++++++++++---
 1 file changed, 155 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 8f52cc1f3fba..824f81291293 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -31,6 +31,7 @@
 #define OVL_LAYER_SMI_ID_EN				BIT(0)
 #define OVL_BGCLR_SEL_IN				BIT(2)
 #define OVL_LAYER_AFBC_EN(n)				BIT(4+n)
+#define OVL_OUTPUT_CLAMP				BIT(26)
 #define DISP_REG_OVL_ROI_BGCLR			0x0028
 #define DISP_REG_OVL_SRC_CON			0x002c
 #define DISP_REG_OVL_CON(n)			(0x0030 + 0x20 * (n))
@@ -39,10 +40,28 @@
 #define DISP_REG_OVL_PITCH_MSB(n)		(0x0040 + 0x20 * (n))
 #define OVL_PITCH_MSB_2ND_SUBBUF			BIT(16)
 #define DISP_REG_OVL_PITCH(n)			(0x0044 + 0x20 * (n))
+#define OVL_CONST_BLEND					BIT(28)
 #define DISP_REG_OVL_RDMA_CTRL(n)		(0x00c0 + 0x20 * (n))
 #define DISP_REG_OVL_RDMA_GMC(n)		(0x00c8 + 0x20 * (n))
 #define DISP_REG_OVL_ADDR_MT2701		0x0040
 #define DISP_REG_OVL_CLRFMT_EXT			0x02D0
+#define DISP_REG_OVL_CLRFMT_EXT1		0x02D8
+#define OVL_CLRFMT_EXT1_CSC_EN(n)			(1 << ((n) * 4 + 1))
+#define DISP_REG_OVL_Y2R_PARA_R0(n)		(0x0134 + 0x28 * (n))
+#define OVL_Y2R_PARA_C_CF_RMY				(GENMASK(14, 0))
+#define DISP_REG_OVL_Y2R_PARA_G0(n)		(0x013c + 0x28 * (n))
+#define OVL_Y2R_PARA_C_CF_GMU				(GENMASK(30, 16))
+#define DISP_REG_OVL_Y2R_PARA_B1(n)		(0x0148 + 0x28 * (n))
+#define OVL_Y2R_PARA_C_CF_BMV				(GENMASK(14, 0))
+#define DISP_REG_OVL_Y2R_PARA_YUV_A_0(n)	(0x014c + 0x28 * (n))
+#define OVL_Y2R_PARA_C_CF_YA				(GENMASK(10, 0))
+#define OVL_Y2R_PARA_C_CF_UA				(GENMASK(26, 16))
+#define DISP_REG_OVL_Y2R_PARA_YUV_A_1(n)	(0x0150 + 0x28 * (n))
+#define OVL_Y2R_PARA_C_CF_VA				(GENMASK(10, 0))
+#define DISP_REG_OVL_Y2R_PRE_ADD2(n)		(0x0154 + 0x28 * (n))
+#define DISP_REG_OVL_R2R_R0(n)			(0x0500 + 0x40 * (n))
+#define DISP_REG_OVL_R2R_G1(n)			(0x0510 + 0x40 * (n))
+#define DISP_REG_OVL_R2R_B2(n)			(0x0520 + 0x40 * (n))
 #define DISP_REG_OVL_ADDR_MT8173		0x0f40
 #define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
 #define DISP_REG_OVL_HDR_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n) + 0x04)
@@ -52,13 +71,19 @@
 #define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
 #define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
 
-#define OVL_CON_BYTE_SWAP	BIT(24)
-#define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
-#define OVL_CON_CLRFMT_RGB	(1 << 12)
-#define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
-#define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
-#define OVL_CON_CLRFMT_UYVY	(4 << 12)
-#define OVL_CON_CLRFMT_YUYV	(5 << 12)
+#define OVL_CON_CLRFMT_MAN		BIT(23)
+#define OVL_CON_BYTE_SWAP		BIT(24)
+#define OVL_CON_RGB_SWAP		BIT(25)
+#define OVL_CON_MTX_AUTO_DIS		BIT(26)
+#define OVL_CON_MTX_EN			BIT(27)
+#define OVL_CON_CLRFMT_RGB		(1 << 12)
+#define OVL_CON_CLRFMT_RGBA8888		(2 << 12)
+#define OVL_CON_CLRFMT_ARGB8888		(3 << 12)
+#define OVL_CON_CLRFMT_PARGB8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_CLRFMT_MAN)
+#define OVL_CON_CLRFMT_UYVY		(4 << 12)
+#define OVL_CON_CLRFMT_YUYV		(5 << 12)
+#define OVL_CON_MTX_YUV_TO_RGB		(6 << 16)
+#define OVL_CON_MTX_PROGRAMMABLE	(8 << 16)
 #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
 					0 : OVL_CON_CLRFMT_RGB)
 #define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
@@ -72,6 +97,22 @@
 #define	OVL_CON_VIRT_FLIP	BIT(9)
 #define	OVL_CON_HORZ_FLIP	BIT(10)
 
+static inline bool is_10bit_rgb(u32 fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB2101010:
+	case DRM_FORMAT_ARGB2101010:
+	case DRM_FORMAT_RGBX1010102:
+	case DRM_FORMAT_RGBA1010102:
+	case DRM_FORMAT_XBGR2101010:
+	case DRM_FORMAT_ABGR2101010:
+	case DRM_FORMAT_BGRX1010102:
+	case DRM_FORMAT_BGRA1010102:
+		return true;
+	}
+	return false;
+}
+
 static const u32 mt8173_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
@@ -89,12 +130,20 @@ static const u32 mt8173_formats[] = {
 static const u32 mt8195_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB2101010,
 	DRM_FORMAT_ARGB2101010,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX1010102,
 	DRM_FORMAT_BGRA1010102,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_RGBX1010102,
+	DRM_FORMAT_RGBA1010102,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_BGR888,
 	DRM_FORMAT_RGB565,
@@ -208,14 +257,14 @@ void mtk_ovl_clk_disable(struct device *dev)
 void mtk_ovl_start(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+	unsigned int reg = 0;
 
 	if (ovl->data->smi_id_en) {
-		unsigned int reg;
-
 		reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
 		reg = reg | OVL_LAYER_SMI_ID_EN;
-		writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
 	}
+	reg |= OVL_OUTPUT_CLAMP;
+	writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
 	writel_relaxed(0x1, ovl->regs + DISP_REG_OVL_EN);
 }
 
@@ -254,9 +303,7 @@ static void mtk_ovl_set_bit_depth(struct device *dev, int idx, u32 format,
 	reg = readl(ovl->regs + DISP_REG_OVL_CLRFMT_EXT);
 	reg &= ~OVL_CON_CLRFMT_BIT_DEPTH_MASK(idx);
 
-	if (format == DRM_FORMAT_RGBA1010102 ||
-	    format == DRM_FORMAT_BGRA1010102 ||
-	    format == DRM_FORMAT_ARGB2101010)
+	if (is_10bit_rgb(format))
 		bit_depth = OVL_CON_CLRFMT_10_BIT;
 
 	reg |= OVL_CON_CLRFMT_BIT_DEPTH(bit_depth, idx);
@@ -357,7 +404,8 @@ void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
 		      DISP_REG_OVL_RDMA_CTRL(idx));
 }
 
-static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
+static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
+				    unsigned int blend_mode)
 {
 	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
 	 * is defined in mediatek HW data sheet.
@@ -376,17 +424,37 @@ static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
 		return OVL_CON_CLRFMT_RGB888(ovl) | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_RGBX8888:
 	case DRM_FORMAT_RGBA8888:
+		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
+		       OVL_CON_CLRFMT_ARGB8888 :
+		       OVL_CON_CLRFMT_PARGB8888;
+	case DRM_FORMAT_RGBX1010102:
+	case DRM_FORMAT_RGBA1010102:
 		return OVL_CON_CLRFMT_ARGB8888;
 	case DRM_FORMAT_BGRX8888:
 	case DRM_FORMAT_BGRA8888:
+		return OVL_CON_BYTE_SWAP |
+		       (blend_mode == DRM_MODE_BLEND_COVERAGE ?
+		       OVL_CON_CLRFMT_ARGB8888 :
+		       OVL_CON_CLRFMT_PARGB8888);
+	case DRM_FORMAT_BGRX1010102:
 	case DRM_FORMAT_BGRA1010102:
 		return OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
+		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
+		       OVL_CON_CLRFMT_RGBA8888 :
+		       OVL_CON_CLRFMT_PARGB8888;
+	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_ARGB2101010:
 		return OVL_CON_CLRFMT_RGBA8888;
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
+		return OVL_CON_RGB_SWAP |
+		       (blend_mode == DRM_MODE_BLEND_COVERAGE ?
+		       OVL_CON_CLRFMT_RGBA8888 :
+		       OVL_CON_CLRFMT_PARGB8888);
+	case DRM_FORMAT_XBGR2101010:
+	case DRM_FORMAT_ABGR2101010:
 		return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_UYVY:
 		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;
@@ -408,6 +476,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	unsigned int fmt = pending->format;
 	unsigned int offset = (pending->y << 16) | pending->x;
 	unsigned int src_size = (pending->height << 16) | pending->width;
+	unsigned int blend_mode = state->base.pixel_blend_mode;
+	unsigned int ignore_pixel_alpha = 0;
 	unsigned int con;
 	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
 	union overlay_pitch {
@@ -420,14 +490,79 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 
 	overlay_pitch.pitch = pitch;
 
-	if (!pending->enable) {
+	if (!pending->enable || !pending->width || !pending->height) {
 		mtk_ovl_layer_off(dev, idx, cmdq_pkt);
 		return;
 	}
 
-	con = ovl_fmt_convert(ovl, fmt);
-	if (state->base.fb && state->base.fb->format->has_alpha)
-		con |= OVL_CON_AEN | OVL_CON_ALPHA;
+	con = ovl_fmt_convert(ovl, fmt, blend_mode);
+	if (state->base.fb) {
+		con |= OVL_CON_AEN;
+		con |= state->base.alpha & 0xff;
+	}
+
+	if (blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
+	    (state->base.fb && !state->base.fb->format->has_alpha))
+		ignore_pixel_alpha = OVL_CONST_BLEND;
+
+	/* need to do Y2R and R2R to reduce 10bit data to 8bit for CRC calculation */
+	if (ovl->data->supports_clrfmt_ext) {
+		u32 y2r_coef = 0, y2r_offset = 0, r2r_coef = 0, csc_en = 0;
+
+		if (is_10bit_rgb(fmt)) {
+			con |= OVL_CON_MTX_AUTO_DIS | OVL_CON_MTX_EN | OVL_CON_MTX_PROGRAMMABLE;
+
+			/* Y2R coef setting: bit 13 is 2^1, bit 12 is 2^0, bit 11 is 2^-1, ... */
+			y2r_coef = BIT(10);	/* bit 10 is 2^-2 = 0.25 */
+			y2r_offset = 0x7fe;	/* -1 in 10bit */
+			/* R2R coef setting: bit 19 is 2^1, bit 18 is 2^0, bit 17 is 2^-1, ... */
+			r2r_coef = BIT(20);	/* bit 20 is 2^2 = 4 */
+			csc_en = OVL_CLRFMT_EXT1_CSC_EN(idx);	/* CSC_EN is for R2R */
+
+			/*
+			 * 1. YUV input data - 1 and shift right for 2 bits to remove it
+			 * [R']   [0.25    0    0]   [Y in - 1]
+			 * [G'] = [   0 0.25    0] * [U in - 1]
+			 * [B']   [   0    0 0.25]   [V in - 1]
+			 *
+			 * 2. shift left for 2 bit letting the last 2 bits become 0
+			 * [R out]   [ 4  0  0]   [R']
+			 * [G out] = [ 0  4  0] * [G']
+			 * [B out]   [ 0  0  4]   [B']
+			 */
+		}
+
+		mtk_ddp_write_mask(cmdq_pkt, y2r_coef,
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_R0(idx),
+				   OVL_Y2R_PARA_C_CF_RMY);
+		mtk_ddp_write_mask(cmdq_pkt, (y2r_coef << 16),
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_G0(idx),
+				   OVL_Y2R_PARA_C_CF_GMU);
+		mtk_ddp_write_mask(cmdq_pkt, y2r_coef,
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_B1(idx),
+				   OVL_Y2R_PARA_C_CF_BMV);
+
+		mtk_ddp_write_mask(cmdq_pkt, y2r_offset,
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_0(idx),
+				   OVL_Y2R_PARA_C_CF_YA);
+		mtk_ddp_write_mask(cmdq_pkt, (y2r_offset << 16),
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_0(idx),
+				   OVL_Y2R_PARA_C_CF_UA);
+		mtk_ddp_write_mask(cmdq_pkt, y2r_offset,
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_1(idx),
+				   OVL_Y2R_PARA_C_CF_VA);
+
+		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_R0(idx));
+		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_G1(idx));
+		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_B2(idx));
+
+		mtk_ddp_write_mask(cmdq_pkt, csc_en,
+				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_CLRFMT_EXT1,
+				   OVL_CLRFMT_EXT1_CSC_EN(idx));
+	}
 
 	if (pending->rotation & DRM_MODE_REFLECT_Y) {
 		con |= OVL_CON_VIRT_FLIP;
@@ -444,8 +579,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 
 	mtk_ddp_write_relaxed(cmdq_pkt, con, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_CON(idx));
-	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb, &ovl->cmdq_reg, ovl->regs,
-			      DISP_REG_OVL_PITCH(idx));
+	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb | ignore_pixel_alpha,
+			      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH(idx));
 	mtk_ddp_write_relaxed(cmdq_pkt, src_size, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_SRC_SIZE(idx));
 	mtk_ddp_write_relaxed(cmdq_pkt, offset, &ovl->cmdq_reg, ovl->regs,
-- 
2.18.0

