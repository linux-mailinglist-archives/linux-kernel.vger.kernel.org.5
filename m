Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3780ED86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjLLN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjLLN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:27:19 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBEF3;
        Tue, 12 Dec 2023 05:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702387641;
        bh=0tiP4C6j3nPpwwBDA8CElSa/FRmWHJ0rT18IdY5QwUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d6g969f8omCxYQdo7HlUZUe7r1BUINP4N/LK2oyrCJY3EYRMUE+Nhhrd7W0qg84fp
         4m2d2fwgeXwcmQpbBibnm7wIyVSW4d6Q+QcB6B5UO7zJ3x+ECfot522PvvaAVENOoa
         1cQvXA7rKdHHjsudorhrWiR6X96x63GO3zYIbtDzXAYFZWLVBMy+LZrULd7DeRttph
         JpidxkyTHLk8/mUZZHD7kifEulhdhqZVMzACn9zqU0UnCMsUHza+30DsFPUnk54jsI
         tME/GkMS7y0So/KmuKZIhyBaTvzciSEM9VPqg/8XVeDmZPyb5u7RXWFIDFZ5n7shVR
         4au0sSFLcPXzQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 508853781462;
        Tue, 12 Dec 2023 13:27:20 +0000 (UTC)
Message-ID: <8f2c5728-0be2-415e-bccb-798c4a22e853@collabora.com>
Date:   Tue, 12 Dec 2023 14:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] drm/mediatek: Set DRM mode configs accordingly
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        Fei Shao <fshao@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
 <20231212121957.19231-6-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231212121957.19231-6-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/23 13:19, Hsiao Chien Sung ha scritto:
> Set DRM mode configs limitation accroding to the
> hardware capabilities.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 28 ++++++++++++++++++--------
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h |  1 +
>   2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 5d551bff6b3f..a4b740420ebb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -304,6 +304,7 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
>   	.conn_routes = mt8188_mtk_ddp_main_routes,
>   	.conn_routes_num = ARRAY_SIZE(mt8188_mtk_ddp_main_routes),
>   	.mmsys_dev_num = 2,
> +	.max_pitch = GENMASK(15, 0),
>   };
>   
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
> @@ -318,6 +319,7 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
>   	.main_path = mt8195_mtk_ddp_main,
>   	.main_len = ARRAY_SIZE(mt8195_mtk_ddp_main),
>   	.mmsys_dev_num = 2,
> +	.max_pitch = GENMASK(15, 0),
>   };
>   
>   static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
> @@ -325,6 +327,7 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
>   	.ext_len = ARRAY_SIZE(mt8195_mtk_ddp_ext),
>   	.mmsys_id = 1,
>   	.mmsys_dev_num = 2,
> +	.max_pitch = GENMASK(15, 0),
>   };
>   
>   static const struct of_device_id mtk_drm_of_ids[] = {
> @@ -463,16 +466,16 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>   	if (ret)
>   		goto put_mutex_dev;
>   
> -	drm->mode_config.min_width = 64;
> -	drm->mode_config.min_height = 64;
> -
>   	/*
> -	 * set max width and height as default value(4096x4096).
> -	 * this value would be used to check framebuffer size limitation
> -	 * at drm_mode_addfb().
> +	 * Set default values for drm mode config
> +	 * these values will be referenced by drm_mode_addfb() as
> +	 * frame buffer size limitation.
>   	 */
> -	drm->mode_config.max_width = 4096;
> -	drm->mode_config.max_height = 4096;
> +	drm->mode_config.min_width = 1;
> +	drm->mode_config.min_height = 1;
> +	drm->mode_config.cursor_width = 512;
> +	drm->mode_config.cursor_height = 512;
> +
>   	drm->mode_config.funcs = &mtk_drm_mode_config_funcs;
>   	drm->mode_config.helper_private = &mtk_drm_mode_config_helpers;
>   
> @@ -502,6 +505,15 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>   		for (j = 0; j < private->data->mmsys_dev_num; j++) {
>   			priv_n = private->all_drm_private[j];
>   
> +			if (priv_n->data->max_pitch) {
> +				/* Save 4 bytes for the color depth (pitch = width x bpp) */

This comment is confusing. Did you mean 4 *bits*? Four bytes is 32 bits.

Also, I'd change the last part to "(pitch = [ width or height ] x bpp)"

> +				drm->mode_config.max_width  = priv_n->data->max_pitch >> 2;
> +				drm->mode_config.max_height = priv_n->data->max_pitch >> 2;
> +			} else {
> +				drm->mode_config.max_width = 4096;
> +				drm->mode_config.max_height = 4096;
> +			}
> +
>   			if (i == 0 && priv_n->data->main_len) {
>   				ret = mtk_drm_crtc_create(drm, priv_n->data->main_path,
>   							  priv_n->data->main_len, j,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index d2efd715699f..3d6c1f58a7ec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -41,6 +41,7 @@ struct mtk_mmsys_driver_data {
>   	bool shadow_register;
>   	unsigned int mmsys_id;
>   	unsigned int mmsys_dev_num;
> +	u32 max_pitch;

Is it expected to have a max_pitch > 0xFFFF on newer SoCs?
If not, please change this to u16.

Regards,
Angelo
