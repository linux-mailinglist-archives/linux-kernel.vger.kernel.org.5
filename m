Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD879790F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbjIGRBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjIGRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:00:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ECBCE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:00:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE0666607306;
        Thu,  7 Sep 2023 13:10:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694088639;
        bh=KYpsq2UvYZvdd7LghBblS+axzJqNybWQJLN8JFHG7r0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A1YFeesC/PFZ3lJx8i6Qh7hm4Zl1VoPfkP2cwD9gXcgncIkXOJnwKa18Z7tDkNr92
         xWz7fkn3H3JvyumQEz6mex45h4eYG5lmDrrkPozjHWA0X0JAFQVWFJJxNERge1iyhC
         d/TAigPKsC6i2oY0e1jhsC/KeCvtdvF/Eh/ju2dxV1BbwqLlCp2Kx+8A8R+7aZTXWk
         dPUH9PdFwN0JEZiOdKY20vYQiZpOPD3b+kkJSJbBceV2f66wBueZe7Hsh787tqwAvd
         tfA4APliOPTp5uHYX3xTp6OoDdA6bSLDsZrEpfLNDhxHeOd2EoYyeSxpb27phAl3Hb
         SWJcl0vtv7R8A==
Message-ID: <f0ea9863-e3f0-7a34-9287-15bb2800a0ed@collabora.com>
Date:   Thu, 7 Sep 2023 14:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/15] drm/mediatek: Support alpha blending in VDOSYS0
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
 <20230823151332.28811-7-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-7-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/08/23 17:13, Hsiao Chien Sung ha scritto:
> Support premultiply and coverage alpha blending modes.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 175 +++++++++++++++++++++---
>   1 file changed, 155 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 8f52cc1f3fba..824f81291293 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -31,6 +31,7 @@
>   #define OVL_LAYER_SMI_ID_EN				BIT(0)
>   #define OVL_BGCLR_SEL_IN				BIT(2)
>   #define OVL_LAYER_AFBC_EN(n)				BIT(4+n)
> +#define OVL_OUTPUT_CLAMP				BIT(26)
>   #define DISP_REG_OVL_ROI_BGCLR			0x0028
>   #define DISP_REG_OVL_SRC_CON			0x002c
>   #define DISP_REG_OVL_CON(n)			(0x0030 + 0x20 * (n))
> @@ -39,10 +40,28 @@
>   #define DISP_REG_OVL_PITCH_MSB(n)		(0x0040 + 0x20 * (n))
>   #define OVL_PITCH_MSB_2ND_SUBBUF			BIT(16)
>   #define DISP_REG_OVL_PITCH(n)			(0x0044 + 0x20 * (n))
> +#define OVL_CONST_BLEND					BIT(28)
>   #define DISP_REG_OVL_RDMA_CTRL(n)		(0x00c0 + 0x20 * (n))
>   #define DISP_REG_OVL_RDMA_GMC(n)		(0x00c8 + 0x20 * (n))
>   #define DISP_REG_OVL_ADDR_MT2701		0x0040
>   #define DISP_REG_OVL_CLRFMT_EXT			0x02D0
> +#define DISP_REG_OVL_CLRFMT_EXT1		0x02D8
> +#define OVL_CLRFMT_EXT1_CSC_EN(n)			(1 << ((n) * 4 + 1))

I'd prefer reading (1 << (((n) * 4) + 1) ... but no strong opinions.

> +#define DISP_REG_OVL_Y2R_PARA_R0(n)		(0x0134 + 0x28 * (n))
> +#define OVL_Y2R_PARA_C_CF_RMY				(GENMASK(14, 0))
> +#define DISP_REG_OVL_Y2R_PARA_G0(n)		(0x013c + 0x28 * (n))
> +#define OVL_Y2R_PARA_C_CF_GMU				(GENMASK(30, 16))
> +#define DISP_REG_OVL_Y2R_PARA_B1(n)		(0x0148 + 0x28 * (n))
> +#define OVL_Y2R_PARA_C_CF_BMV				(GENMASK(14, 0))
> +#define DISP_REG_OVL_Y2R_PARA_YUV_A_0(n)	(0x014c + 0x28 * (n))
> +#define OVL_Y2R_PARA_C_CF_YA				(GENMASK(10, 0))
> +#define OVL_Y2R_PARA_C_CF_UA				(GENMASK(26, 16))
> +#define DISP_REG_OVL_Y2R_PARA_YUV_A_1(n)	(0x0150 + 0x28 * (n))
> +#define OVL_Y2R_PARA_C_CF_VA				(GENMASK(10, 0))
> +#define DISP_REG_OVL_Y2R_PRE_ADD2(n)		(0x0154 + 0x28 * (n))
> +#define DISP_REG_OVL_R2R_R0(n)			(0x0500 + 0x40 * (n))
> +#define DISP_REG_OVL_R2R_G1(n)			(0x0510 + 0x40 * (n))
> +#define DISP_REG_OVL_R2R_B2(n)			(0x0520 + 0x40 * (n))
>   #define DISP_REG_OVL_ADDR_MT8173		0x0f40
>   #define DISP_REG_OVL_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n))
>   #define DISP_REG_OVL_HDR_ADDR(ovl, n)		((ovl)->data->addr + 0x20 * (n) + 0x04)
> @@ -52,13 +71,19 @@
>   #define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
>   #define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
>   
> -#define OVL_CON_BYTE_SWAP	BIT(24)
> -#define OVL_CON_MTX_YUV_TO_RGB	(6 << 16)
> -#define OVL_CON_CLRFMT_RGB	(1 << 12)
> -#define OVL_CON_CLRFMT_RGBA8888	(2 << 12)
> -#define OVL_CON_CLRFMT_ARGB8888	(3 << 12)
> -#define OVL_CON_CLRFMT_UYVY	(4 << 12)
> -#define OVL_CON_CLRFMT_YUYV	(5 << 12)
> +#define OVL_CON_CLRFMT_MAN		BIT(23)
> +#define OVL_CON_BYTE_SWAP		BIT(24)
> +#define OVL_CON_RGB_SWAP		BIT(25)
> +#define OVL_CON_MTX_AUTO_DIS		BIT(26)
> +#define OVL_CON_MTX_EN			BIT(27)
> +#define OVL_CON_CLRFMT_RGB		(1 << 12)
> +#define OVL_CON_CLRFMT_RGBA8888		(2 << 12)
> +#define OVL_CON_CLRFMT_ARGB8888		(3 << 12)
> +#define OVL_CON_CLRFMT_PARGB8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_CLRFMT_MAN)
> +#define OVL_CON_CLRFMT_UYVY		(4 << 12)
> +#define OVL_CON_CLRFMT_YUYV		(5 << 12)
> +#define OVL_CON_MTX_YUV_TO_RGB		(6 << 16)
> +#define OVL_CON_MTX_PROGRAMMABLE	(8 << 16)
>   #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
>   					0 : OVL_CON_CLRFMT_RGB)
>   #define OVL_CON_CLRFMT_RGB888(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
> @@ -72,6 +97,22 @@
>   #define	OVL_CON_VIRT_FLIP	BIT(9)
>   #define	OVL_CON_HORZ_FLIP	BIT(10)
>   
> +static inline bool is_10bit_rgb(u32 fmt)
> +{
> +	switch (fmt) {
> +	case DRM_FORMAT_XRGB2101010:
> +	case DRM_FORMAT_ARGB2101010:
> +	case DRM_FORMAT_RGBX1010102:
> +	case DRM_FORMAT_RGBA1010102:
> +	case DRM_FORMAT_XBGR2101010:
> +	case DRM_FORMAT_ABGR2101010:
> +	case DRM_FORMAT_BGRX1010102:
> +	case DRM_FORMAT_BGRA1010102:
> +		return true;
> +	}
> +	return false;
> +}
> +
>   static const u32 mt8173_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_ARGB8888,
> @@ -89,12 +130,20 @@ static const u32 mt8173_formats[] = {
>   static const u32 mt8195_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XRGB2101010,
>   	DRM_FORMAT_ARGB2101010,
>   	DRM_FORMAT_BGRX8888,
>   	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_BGRX1010102,
>   	DRM_FORMAT_BGRA1010102,
>   	DRM_FORMAT_ABGR8888,
>   	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_XBGR2101010,
> +	DRM_FORMAT_ABGR2101010,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_RGBX1010102,
> +	DRM_FORMAT_RGBA1010102,
>   	DRM_FORMAT_RGB888,
>   	DRM_FORMAT_BGR888,
>   	DRM_FORMAT_RGB565,
> @@ -208,14 +257,14 @@ void mtk_ovl_clk_disable(struct device *dev)
>   void mtk_ovl_start(struct device *dev)
>   {
>   	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
> +	unsigned int reg = 0;
>   
>   	if (ovl->data->smi_id_en) {
> -		unsigned int reg;
> -
>   		reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
>   		reg = reg | OVL_LAYER_SMI_ID_EN;
> -		writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
>   	}
> +	reg |= OVL_OUTPUT_CLAMP;

Uhm, I wonder if clearing out the register and setting only the OVL_OUTPUT_CLAMP
bit is is intentional, or if you wanted to do, instead...

	u32 reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
	if (ovl->data->smi_id_en)
		reg |= OVL_LAYER_SMI_ID_EN;

	reg |= OVL_OUTPUT_CLAMP
	writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);

> +	writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
>   	writel_relaxed(0x1, ovl->regs + DISP_REG_OVL_EN);
>   }
>   
> @@ -254,9 +303,7 @@ static void mtk_ovl_set_bit_depth(struct device *dev, int idx, u32 format,
>   	reg = readl(ovl->regs + DISP_REG_OVL_CLRFMT_EXT);
>   	reg &= ~OVL_CON_CLRFMT_BIT_DEPTH_MASK(idx);
>   
> -	if (format == DRM_FORMAT_RGBA1010102 ||
> -	    format == DRM_FORMAT_BGRA1010102 ||
> -	    format == DRM_FORMAT_ARGB2101010)
> +	if (is_10bit_rgb(format))
>   		bit_depth = OVL_CON_CLRFMT_10_BIT;
>   
>   	reg |= OVL_CON_CLRFMT_BIT_DEPTH(bit_depth, idx);
> @@ -357,7 +404,8 @@ void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
>   		      DISP_REG_OVL_RDMA_CTRL(idx));
>   }
>   
> -static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
> +static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
> +				    unsigned int blend_mode)
>   {
>   	/* The return value in switch "MEM_MODE_INPUT_FORMAT_XXX"
>   	 * is defined in mediatek HW data sheet.
> @@ -376,17 +424,37 @@ static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
>   		return OVL_CON_CLRFMT_RGB888(ovl) | OVL_CON_BYTE_SWAP;
>   	case DRM_FORMAT_RGBX8888:
>   	case DRM_FORMAT_RGBA8888:
> +		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
> +		       OVL_CON_CLRFMT_ARGB8888 :
> +		       OVL_CON_CLRFMT_PARGB8888;
> +	case DRM_FORMAT_RGBX1010102:
> +	case DRM_FORMAT_RGBA1010102:
>   		return OVL_CON_CLRFMT_ARGB8888;
>   	case DRM_FORMAT_BGRX8888:
>   	case DRM_FORMAT_BGRA8888:
> +		return OVL_CON_BYTE_SWAP |
> +		       (blend_mode == DRM_MODE_BLEND_COVERAGE ?
> +		       OVL_CON_CLRFMT_ARGB8888 :
> +		       OVL_CON_CLRFMT_PARGB8888);
> +	case DRM_FORMAT_BGRX1010102:
>   	case DRM_FORMAT_BGRA1010102:
>   		return OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP;
>   	case DRM_FORMAT_XRGB8888:
>   	case DRM_FORMAT_ARGB8888:
> +		return blend_mode == DRM_MODE_BLEND_COVERAGE ?
> +		       OVL_CON_CLRFMT_RGBA8888 :
> +		       OVL_CON_CLRFMT_PARGB8888;
> +	case DRM_FORMAT_XRGB2101010:
>   	case DRM_FORMAT_ARGB2101010:
>   		return OVL_CON_CLRFMT_RGBA8888;
>   	case DRM_FORMAT_XBGR8888:
>   	case DRM_FORMAT_ABGR8888:
> +		return OVL_CON_RGB_SWAP |
> +		       (blend_mode == DRM_MODE_BLEND_COVERAGE ?
> +		       OVL_CON_CLRFMT_RGBA8888 :
> +		       OVL_CON_CLRFMT_PARGB8888);
> +	case DRM_FORMAT_XBGR2101010:
> +	case DRM_FORMAT_ABGR2101010:
>   		return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
>   	case DRM_FORMAT_UYVY:
>   		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;
> @@ -408,6 +476,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   	unsigned int fmt = pending->format;
>   	unsigned int offset = (pending->y << 16) | pending->x;
>   	unsigned int src_size = (pending->height << 16) | pending->width;
> +	unsigned int blend_mode = state->base.pixel_blend_mode;
> +	unsigned int ignore_pixel_alpha = 0;
>   	unsigned int con;
>   	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
>   	union overlay_pitch {
> @@ -420,14 +490,79 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   
>   	overlay_pitch.pitch = pitch;
>   
> -	if (!pending->enable) {
> +	if (!pending->enable || !pending->width || !pending->height) {
>   		mtk_ovl_layer_off(dev, idx, cmdq_pkt);
>   		return;
>   	}
>   
> -	con = ovl_fmt_convert(ovl, fmt);
> -	if (state->base.fb && state->base.fb->format->has_alpha)
> -		con |= OVL_CON_AEN | OVL_CON_ALPHA;
> +	con = ovl_fmt_convert(ovl, fmt, blend_mode);
> +	if (state->base.fb) {
> +		con |= OVL_CON_AEN;
> +		con |= state->base.alpha & 0xff;
> +	}
> +
> +	if (blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
> +	    (state->base.fb && !state->base.fb->format->has_alpha))
> +		ignore_pixel_alpha = OVL_CONST_BLEND;
> +
> +	/* need to do Y2R and R2R to reduce 10bit data to 8bit for CRC calculation */
> +	if (ovl->data->supports_clrfmt_ext) {
> +		u32 y2r_coef = 0, y2r_offset = 0, r2r_coef = 0, csc_en = 0;
> +
> +		if (is_10bit_rgb(fmt)) {
> +			con |= OVL_CON_MTX_AUTO_DIS | OVL_CON_MTX_EN | OVL_CON_MTX_PROGRAMMABLE;
> +
> +			/* Y2R coef setting: bit 13 is 2^1, bit 12 is 2^0, bit 11 is 2^-1, ... */
> +			y2r_coef = BIT(10);	/* bit 10 is 2^-2 = 0.25 */
> +			y2r_offset = 0x7fe;	/* -1 in 10bit */

Is it possible to calculate this with a macro, instead of hardcoding the 0x7fe value?

Regards,
Angelo

> +			/* R2R coef setting: bit 19 is 2^1, bit 18 is 2^0, bit 17 is 2^-1, ... */
> +			r2r_coef = BIT(20);	/* bit 20 is 2^2 = 4 */
> +			csc_en = OVL_CLRFMT_EXT1_CSC_EN(idx);	/* CSC_EN is for R2R */
> +
> +			/*
> +			 * 1. YUV input data - 1 and shift right for 2 bits to remove it
> +			 * [R']   [0.25    0    0]   [Y in - 1]
> +			 * [G'] = [   0 0.25    0] * [U in - 1]
> +			 * [B']   [   0    0 0.25]   [V in - 1]
> +			 *
> +			 * 2. shift left for 2 bit letting the last 2 bits become 0
> +			 * [R out]   [ 4  0  0]   [R']
> +			 * [G out] = [ 0  4  0] * [G']
> +			 * [B out]   [ 0  0  4]   [B']
> +			 */
> +		}
> +
> +		mtk_ddp_write_mask(cmdq_pkt, y2r_coef,
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_R0(idx),
> +				   OVL_Y2R_PARA_C_CF_RMY);
> +		mtk_ddp_write_mask(cmdq_pkt, (y2r_coef << 16),
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_G0(idx),
> +				   OVL_Y2R_PARA_C_CF_GMU);
> +		mtk_ddp_write_mask(cmdq_pkt, y2r_coef,
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_B1(idx),
> +				   OVL_Y2R_PARA_C_CF_BMV);
> +
> +		mtk_ddp_write_mask(cmdq_pkt, y2r_offset,
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_0(idx),
> +				   OVL_Y2R_PARA_C_CF_YA);
> +		mtk_ddp_write_mask(cmdq_pkt, (y2r_offset << 16),
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_0(idx),
> +				   OVL_Y2R_PARA_C_CF_UA);
> +		mtk_ddp_write_mask(cmdq_pkt, y2r_offset,
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_Y2R_PARA_YUV_A_1(idx),
> +				   OVL_Y2R_PARA_C_CF_VA);
> +
> +		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
> +				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_R0(idx));
> +		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
> +				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_G1(idx));
> +		mtk_ddp_write_relaxed(cmdq_pkt, r2r_coef,
> +				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_R2R_B2(idx));
> +
> +		mtk_ddp_write_mask(cmdq_pkt, csc_en,
> +				   &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_CLRFMT_EXT1,
> +				   OVL_CLRFMT_EXT1_CSC_EN(idx));
> +	}
>   
>   	if (pending->rotation & DRM_MODE_REFLECT_Y) {
>   		con |= OVL_CON_VIRT_FLIP;
> @@ -444,8 +579,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   
>   	mtk_ddp_write_relaxed(cmdq_pkt, con, &ovl->cmdq_reg, ovl->regs,
>   			      DISP_REG_OVL_CON(idx));
> -	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb, &ovl->cmdq_reg, ovl->regs,
> -			      DISP_REG_OVL_PITCH(idx));
> +	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb | ignore_pixel_alpha,
> +			      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH(idx));
>   	mtk_ddp_write_relaxed(cmdq_pkt, src_size, &ovl->cmdq_reg, ovl->regs,
>   			      DISP_REG_OVL_SRC_SIZE(idx));
>   	mtk_ddp_write_relaxed(cmdq_pkt, offset, &ovl->cmdq_reg, ovl->regs,

