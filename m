Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A47C58D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjJKQFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjJKQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:05:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB9A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:05:28 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AC3866072FC;
        Wed, 11 Oct 2023 17:05:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697040326;
        bh=JX/FNFTRvgUjRggNucUPj/avlj5AIJtfvklHcuIrhpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOvsvP2z4ELP9LV96w8lC8IG53tbUcpfdEjCzCWhy/UHUKlqPJKxAjKU7yzF4Yy7N
         /YC08oleXh/SM7zMPX0cUpXEghvg0c950bgpJPz3XHcjo2sb972iSTv1/L3xRhurGj
         cqtbstLlprV0C0Hw/4WhEkTTMeynQsyOW7QZqYgbgGrkwUapU9I7r5hQnaIyl2f/0A
         ekkyHILY/UiLaVp9xK0pQl107nduU5BO6a+DG7nIu9xxO6KKiqcPzwa8ZDF7HKMnbZ
         gzaWCPuhM0PrsfZodIBY96FK42HFPak2R1vZO01rFQo6VmvwZro0xCeYca14c6COUA
         iyESeUwrHaw9w==
Date:   Wed, 11 Oct 2023 12:05:19 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com
Subject: Re: [PATCH v10 08/16] drm/mediatek: De-commonize disp_aal/disp_gamma
 gamma_set functions
Message-ID: <8cf3d18a-fe99-49c5-8d0c-eb5deaef79d6@notapiano>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
 <20230804072850.89365-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230804072850.89365-9-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 09:28:42AM +0200, AngeloGioacchino Del Regno wrote:
> In preparation for adding a 12-bits gamma support for the DISP_GAMMA
> IP, remove the mtk_gamma_set_common() function and move the relevant
> bits in mtk_gamma_set() for DISP_GAMMA and mtk_aal_gamma_set() for
> DISP_AAL: since the latter has no more support for gamma manipulation
> (being moved to a different IP) in newer revisions, those functions
> are about to diverge and it makes no sense to keep a common one (with
> all the complications of passing common data and making exclusions
> for device driver data) for just a few bits.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_aal.c   | 39 +++++++++++++++++++++--
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  1 -
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 34 ++++----------------
>  3 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> index bec035780db0..21b25470e9b7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> @@ -17,10 +17,18 @@
>  
>  #define DISP_AAL_EN				0x0000
>  #define AAL_EN						BIT(0)
> +#define DISP_AAL_CFG				0x0020
> +#define AAL_RELAY_MODE					BIT(0)
> +#define AAL_GAMMA_LUT_EN				BIT(1)
>  #define DISP_AAL_SIZE				0x0030
>  #define DISP_AAL_SIZE_HSIZE				GENMASK(28, 16)
>  #define DISP_AAL_SIZE_VSIZE				GENMASK(12, 0)
>  #define DISP_AAL_OUTPUT_SIZE			0x04d8
> +#define DISP_AAL_GAMMA_LUT			0x0700
> +#define DISP_AAL_GAMMA_LUT_R				GENMASK(29, 20)
> +#define DISP_AAL_GAMMA_LUT_G				GENMASK(19, 10)
> +#define DISP_AAL_GAMMA_LUT_B				GENMASK(9, 0)
> +#define DISP_AAL_LUT_BITS			10
>  #define DISP_AAL_LUT_SIZE			512
>  
>  struct mtk_disp_aal_data {
> @@ -85,9 +93,36 @@ unsigned int mtk_aal_gamma_get_lut_size(struct device *dev)
>  void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state)
>  {
>  	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
> +	struct drm_color_lut *lut;
> +	unsigned int i;
> +	u32 cfg_val;
> +
> +	/* If gamma is not supported in AAL, go out immediately */
> +	if (!(aal->data && aal->data->has_gamma))
> +		return;
> +
> +	/* Also, if there's no gamma lut there's nothing to do here. */
> +	if (!state->gamma_lut)
> +		return;
> +
> +	cfg_val = readl(aal->regs + DISP_AAL_CFG);
> +	lut = (struct drm_color_lut *)state->gamma_lut->data;
> +
> +	for (i = 0; i < DISP_AAL_LUT_SIZE; i++) {
> +		struct drm_color_lut hwlut = {
> +			.red = drm_color_lut_extract(lut[i].red, DISP_AAL_LUT_BITS),
> +			.green = drm_color_lut_extract(lut[i].green, DISP_AAL_LUT_BITS),
> +			.blue = drm_color_lut_extract(lut[i].blue, DISP_AAL_LUT_BITS)
> +		};
> +		u32 word;
> +
> +		word = FIELD_PREP(DISP_AAL_GAMMA_LUT_R, hwlut.red);
> +		word |= FIELD_PREP(DISP_AAL_GAMMA_LUT_G, hwlut.green);
> +		word |= FIELD_PREP(DISP_AAL_GAMMA_LUT_B, hwlut.blue);
> +		writel(word, (aal->regs + DISP_AAL_GAMMA_LUT) + (i * 4));
> +	}

Hi Angelo,

it looks like you're missing a

  	cfg_val |= FIELD_PREP(AAL_GAMMA_LUT_EN, 1);

to actually enable the AAL gamma table here, like was done in the common
function.

Thanks,
Nícolas

>  
> -	if (aal->data && aal->data->has_gamma)
> -		mtk_gamma_set_common(NULL, aal->regs, state);
> +	writel(cfg_val, aal->regs + DISP_AAL_CFG);
>  }
[..]
