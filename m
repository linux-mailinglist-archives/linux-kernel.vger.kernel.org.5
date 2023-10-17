Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2D7CBFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjJQJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjJQJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:44:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5836E98;
        Tue, 17 Oct 2023 02:44:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D078C66072C1;
        Tue, 17 Oct 2023 10:44:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697535896;
        bh=yx63KVkLH1o5DUDZrBN8lhi6q9U2dwYv3+7BafhDl/U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fhBYPuhBEtzpRp8x1vGX0Aem3Kl+EavYbolJeARnW6Jo5YX2MDLi/WNr4YHowVz7I
         Ae+Kqn26gGeNmFgXpyR7X9Y6drMEP56VeFSWacFgta4LUfV/T7B1rF0iGStwsfdLVq
         digqRgI1QMqHEcG0qRuFO6PTsS93pgCoMdYZ4YIUHzR8Svqjq7rWDzjyJqnIn7hjh+
         uVgLWwpQJ5CHEtoQH8CTRRGeElXJIRHaCXQJhO9MoCBbnkGf351bELWqCb+1oNyfiC
         wPW0iv0+qjx2p432tMJxdGxOP1SVSPNwKIe8UPx7NMppGekMvGQDyFr9foGuj6cAaF
         HuueE8FaPYUBw==
Message-ID: <dfa95116-d430-48f4-8f36-0c0461d3b7ac@collabora.com>
Date:   Tue, 17 Oct 2023 11:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/23] drm/mediatek: Support MT8188 Padding in display
 driver
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
 <20231016104010.3270-18-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016104010.3270-18-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/10/23 12:40, Hsiao Chien Sung ha scritto:
> Padding is a new display module on MT8188, it provides ability
> to add pixels to width and height of a layer with specified colors.
> 
> Due to hardware design, Mixer in VDOSYS1 requires width of a layer
> to be 2-pixel-align, or 4-pixel-align when ETHDR is enabled,
> we need Padding to deal with odd width.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/Makefile       |   3 +-
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h |   4 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
>   drivers/gpu/drm/mediatek/mtk_padding.c  | 160 ++++++++++++++++++++++++
>   5 files changed, 168 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_padding.c
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index d4d193f60271..5e4436403b8d 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -16,7 +16,8 @@ mediatek-drm-y := mtk_disp_aal.o \
>   		  mtk_dsi.o \
>   		  mtk_dpi.o \
>   		  mtk_ethdr.o \
> -		  mtk_mdp_rdma.o
> +		  mtk_mdp_rdma.o \
> +		  mtk_padding.o
>   
>   obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
>   
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index bf06ccb65652..e2b602037ac3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -159,4 +159,8 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
>   const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
>   size_t mtk_mdp_rdma_get_num_formats(struct device *dev);
>   
> +int mtk_padding_clk_enable(struct device *dev);
> +void mtk_padding_clk_disable(struct device *dev);
> +void mtk_padding_start(struct device *dev);
> +void mtk_padding_stop(struct device *dev);
>   #endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cdce165c092e..62e6e9785443 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -1025,6 +1025,7 @@ static struct platform_driver * const mtk_drm_drivers[] = {
>   	&mtk_dsi_driver,
>   	&mtk_ethdr_driver,
>   	&mtk_mdp_rdma_driver,
> +	&mtk_padding_driver,
>   };
>   
>   static int __init mtk_drm_init(void)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 8dca68ea1b94..d2efd715699f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -72,5 +72,5 @@ extern struct platform_driver mtk_dpi_driver;
>   extern struct platform_driver mtk_dsi_driver;
>   extern struct platform_driver mtk_ethdr_driver;
>   extern struct platform_driver mtk_mdp_rdma_driver;
> -
> +extern struct platform_driver mtk_padding_driver;
>   #endif /* MTK_DRM_DRV_H */
> diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
> new file mode 100644
> index 000000000000..fa2e7fc9c7bd
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_padding.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +

..snip..

> +
> +static const struct of_device_id mtk_padding_driver_dt_match[] = {
> +	{ .compatible = "mediatek,mt8188-padding" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_padding_driver_dt_match);
> +
> +struct platform_driver mtk_padding_driver = {
> +	.probe		= mtk_padding_probe,
> +	.remove		= mtk_padding_remove,
> +	.driver		= {
> +		.name	= "mediatek-padding",

Please let's be consistent with the driver names, this should be
"mediatek-disp-padding".

After changing that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

