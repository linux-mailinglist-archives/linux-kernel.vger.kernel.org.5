Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9242D797698
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjIGQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbjIGQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3F6E81
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:10:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 24F376607311;
        Thu,  7 Sep 2023 13:31:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694089911;
        bh=g5wgXvE+PnsiQfgNy85QLupMTPAmTtmiCVWhPvcvY1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xxjv4s9PLbIBMvCBuYS/tJJ2uN4q1h6s4aGXm8H45urPu9grw8UPMwt0bJ0b0mCFR
         57/gAftiJdhjz3uLTgvQn6thqUfzCkkn2f4ym4fcxGqEY3db8j0I9Cm8Bhs8G7ENym
         dZfpDnj01qXbtRyU4QD9chk0xySiOcS9Tj1UvdId5lNZhxA4OR/y093dhABmwMBAZA
         AJnaFqks4twtThgVCHeVHmdkIUW4buxLQ0oyo0QPZNKyrjlL82nT0ptG3+Lg7VynbQ
         LrB1fmHIJ39tNTLEU9KzzMOGHrGxZkwGnKcf+Fz8lMoMR/qMCXHGaCj5hDP3wX+XOe
         qrCXDJzUyb/cQ==
Message-ID: <8c56474f-4df8-10b0-d223-1f83099d73a5@collabora.com>
Date:   Thu, 7 Sep 2023 14:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 12/15] drm/mediatek: Support CRC in VDOSYS1
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
 <20230823151332.28811-13-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230823151332.28811-13-shawn.sung@mediatek.com>
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
> We choose Mixer as CRC generator in VDOSYS1 since
> its frame done event will trigger vblanks, we can know
> when is safe to retrieve CRC of the frame.
> 
> In VDOSYS1, there's no image procession after Mixer,
> unlike OVL in VDOSYS0, Mixer's CRC will include all the
> effects that are applied to the frame.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h       |   1 +
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |  10 ++
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |   1 +
>   drivers/gpu/drm/mediatek/mtk_ethdr.c          | 120 ++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_ethdr.h          |   4 +
>   5 files changed, 136 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index d2753360ae1e..014086d4d7ca 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -127,6 +127,7 @@ unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev);
>   struct device *mtk_ovl_adaptor_dma_dev_get(struct device *dev);
>   const u32 *mtk_ovl_adaptor_get_formats(struct device *dev);
>   size_t mtk_ovl_adaptor_get_num_formats(struct device *dev);
> +u32 mtk_ovl_adaptor_crc_cnt(struct device *dev);
>   
>   void mtk_rdma_bypass_shadow(struct device *dev);
>   int mtk_rdma_clk_enable(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index c0a38f5217ee..64f98b26f4ce 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -159,6 +159,13 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
>   	mtk_ethdr_layer_config(ethdr, idx, state, cmdq_pkt);
>   }
>   
> +u32 mtk_ovl_adaptor_crc_cnt(struct device *dev)
> +{
> +	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> +
> +	return mtk_ethdr_crc_cnt(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0]);
> +}
> +
>   void mtk_ovl_adaptor_config(struct device *dev, unsigned int w,
>   			    unsigned int h, unsigned int vrefresh,
>   			    unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> @@ -274,6 +281,9 @@ void mtk_ovl_adaptor_register_vblank_cb(struct device *dev, void (*vblank_cb)(vo
>   
>   	mtk_ethdr_register_vblank_cb(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0],
>   				     vblank_cb, vblank_cb_data);
> +
> +	mtk_ethdr_register_crtc(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0],
> +				(struct drm_crtc *)vblank_cb_data);
>   }
>   
>   void mtk_ovl_adaptor_unregister_vblank_cb(struct device *dev)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 1b747a34a06b..143136491607 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -398,6 +398,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
>   	.clk_enable = mtk_ovl_adaptor_clk_enable,
>   	.clk_disable = mtk_ovl_adaptor_clk_disable,
>   	.config = mtk_ovl_adaptor_config,
> +	.crc_cnt = mtk_ovl_adaptor_crc_cnt,
>   	.start = mtk_ovl_adaptor_start,
>   	.stop = mtk_ovl_adaptor_stop,
>   	.layer_nr = mtk_ovl_adaptor_layer_nr,
> diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> index 3058c122a4c3..9e341d86d9f9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
> @@ -24,6 +24,9 @@
>   #define MIX_FME_CPL_INTEN			BIT(1)
>   #define MIX_INTSTA			0x8
>   #define MIX_EN				0xc
> +#define MIX_TRIG			0x10
> +#define MIX_TRIG_CRC_EN				BIT(8)
> +#define MIX_TRIG_CRC_RST			BIT(9)
>   #define MIX_RST				0x14
>   #define MIX_ROI_SIZE			0x18
>   #define MIX_DATAPATH_CON		0x1c
> @@ -39,6 +42,11 @@
>   #define PREMULTI_SOURCE				(3 << 12)
>   #define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
>   #define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
> +
> +/* CRC register offsets for odd and even lines */
> +#define MIX_CRC_O			0x110
> +#define MIX_CRC_E			0x114
> +
>   #define MIX_FUNC_DCM0			0x120
>   #define MIX_FUNC_DCM1			0x124
>   #define MIX_FUNC_DCM_ENABLE			0xffffffff
> @@ -70,6 +78,9 @@ struct mtk_ethdr_comp {
>   	struct device		*dev;
>   	void __iomem		*regs;
>   	struct cmdq_client_reg	cmdq_base;
> +	struct cmdq_client *cmdq_client;
> +	struct cmdq_pkt *cmdq_pkt;
> +	u32 cmdq_event;
>   };
>   
>   struct mtk_ethdr {
> @@ -80,6 +91,9 @@ struct mtk_ethdr {
>   	void			*vblank_cb_data;
>   	int			irq;
>   	struct reset_control	*reset_ctl;
> +	struct drm_crtc		*crtc;
> +	const u32		*crcs;
> +	size_t			crc_cnt;
>   };
>   
>   static const char * const ethdr_clk_str[] = {
> @@ -98,6 +112,95 @@ static const char * const ethdr_clk_str[] = {
>   	"vdo_be_async",
>   };
>   
> +static const u32 ethdr_crcs[] = {
> +	MIX_CRC_O,
> +	MIX_CRC_E,
> +};
> +
> +u32 mtk_ethdr_crc_cnt(struct device *dev)
> +{
> +	struct mtk_ethdr *priv = dev_get_drvdata(dev);
> +
> +	return (u32)priv->crc_cnt;
> +}
> +
> +void mtk_ethdr_register_crtc(struct device *dev, struct drm_crtc *crtc)
> +{
> +	struct mtk_ethdr *priv = dev_get_drvdata(dev);
> +
> +	priv->crtc = crtc;
> +}
> +
> +static void mtk_ethdr_crc_loop_start(struct device *dev)
> +{
> +	int i;
> +	struct mtk_ethdr *priv;
> +	struct mtk_ethdr_comp *mixer;
> +	struct mtk_drm_crtc *mtk_crtc;

You can initialize those variables at declaration time, since there's no
check in between initializations.

> +
> +	priv = dev_get_drvdata(dev);
> +	mixer = &priv->ethdr_comp[ETHDR_MIXER];
> +	mtk_crtc = container_of(priv->crtc, struct mtk_drm_crtc, base);
> +
> +	if (!mixer->cmdq_event || mixer->cmdq_client)
> +		return;
> +
> +	mixer->cmdq_client = cmdq_mbox_create(dev, 0);
> +	if (IS_ERR(mixer->cmdq_client)) {
> +		pr_err("failed to create mailbox client\n");

Is there any way to *guarantee* that this won't fail?

> +		return;
> +	}
> +	mixer->cmdq_pkt = cmdq_pkt_create(mixer->cmdq_client, PAGE_SIZE);
> +	if (!mixer->cmdq_pkt) {
> +		pr_err("failed to create cmdq packet\n");
> +		return;
> +	}
> +

Regards,
Angelo

