Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3017666AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjG1IPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjG1IO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:14:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984D10E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:14:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 184C5660704F;
        Fri, 28 Jul 2023 09:14:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690532094;
        bh=2u0/wsFge3BQH+xmqZ62PwLYaH3IHkVQ6bmaZZoo6no=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oBmGVlnP85D1wiHzRNV+MotQljwNcxh32EiHMhpZdOxo+WXXrOGMzTC84cLAo1rvu
         5WiDzf51juHFVdcu88oRebzt8Em7zwWOPQWkk07sE/EpEV+dR9IHo7/6/mpLuW0hD/
         2iucveIkR+jcyARHKCwkKwYr2lKoHQ4zPHOkajU/gjVb6JJupApanor54nyI66sG9Z
         NKgNrW6WiHOZ/x5OvbJ2CaUWLm1ZR4X5I9IUhxJV4NhRKePaJiNPdYed6HKjxPDiti
         Mfm+KnEMJOFqSEJ3pFIBQuHe+TTMgAdUpUC4xW+/XiIy1BpGreUlyTAWs/pxi64iXX
         IKuWLbwnA166Q==
Message-ID: <3dca39b3-b152-34e7-8959-78fe68e1a899@collabora.com>
Date:   Fri, 28 Jul 2023 10:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 4/4] drm/mediatek: Add DSI support for mt8188 vdosys0
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nathan Lu <nathan.lu@mediatek.com>
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
 <20230727164114.20638-5-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230727164114.20638-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/07/23 18:41, Jason-JH.Lin ha scritto:
> Add DSI as main display output for mt8188 vdosys0.
> 

I would split this commit in two:

1. drm/mediatek: dsi: Support dynamic connector selection
2. drm/mediatek: Support DSI on MT8188 VDOSYS0

Where the first one sets up the mtk_dsi driver for .encoder_index(), and
where the second one is a one-liner simply adding `{0, DDP_COMPONENT_DSI0},`
to the MT8188 main routes array.

The reason is that if you split it like that, whoever reads the commit history
will immediately understand how to add dynamic connector selection to a MTK DRM
driver, and how to perform the SoC-specific connection....

Please!

Thanks,
Angelo

> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h     | 1 +
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 1 +
>   drivers/gpu/drm/mediatek/mtk_dsi.c          | 9 +++++++++
>   4 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index 5f07037670e9..fdaa21b6a9da 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -48,6 +48,7 @@ unsigned int mtk_dpi_encoder_index(struct device *dev);
>   
>   void mtk_dsi_ddp_start(struct device *dev);
>   void mtk_dsi_ddp_stop(struct device *dev);
> +unsigned int mtk_dsi_encoder_index(struct device *dev);
>   
>   int mtk_gamma_clk_enable(struct device *dev);
>   void mtk_gamma_clk_disable(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index bc7b0a0c20db..e6a7a0b9de6c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -318,6 +318,7 @@ static const struct mtk_ddp_comp_funcs ddp_dsc = {
>   static const struct mtk_ddp_comp_funcs ddp_dsi = {
>   	.start = mtk_dsi_ddp_start,
>   	.stop = mtk_dsi_ddp_stop,
> +	.encoder_index = mtk_dsi_encoder_index,
>   };
>   
>   static const struct mtk_ddp_comp_funcs ddp_gamma = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index ecd113f9908c..9b7ca8d35f71 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -189,6 +189,7 @@ static const unsigned int mt8188_mtk_ddp_main[] = {
>   
>   static const struct mtk_drm_route mt8188_mtk_ddp_main_routes[] = {
>   	{0, DDP_COMPONENT_DP_INTF0},
> +	{0, DDP_COMPONENT_DSI0},
>   };
>   
>   static const unsigned int mt8192_mtk_ddp_main[] = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 7d5250351193..62d5362916a5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -865,6 +865,15 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>   	return ret;
>   }
>   
> +unsigned int mtk_dsi_encoder_index(struct device *dev)
> +{
> +	struct mtk_dsi *dsi = dev_get_drvdata(dev);
> +	unsigned int encoder_index = drm_encoder_index(&dsi->encoder);
> +
> +	dev_dbg(dev, "encoder index:%d", encoder_index);
> +	return encoder_index;
> +}
> +
>   static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>   {
>   	int ret;



