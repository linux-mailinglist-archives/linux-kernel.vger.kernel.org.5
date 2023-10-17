Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38C7CBFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjJQJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJQJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:54:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8E98;
        Tue, 17 Oct 2023 02:54:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F417E66072C1;
        Tue, 17 Oct 2023 10:54:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697536488;
        bh=NoA0ng3JfV0OOvXcz/5VAeD4o0dv2LFKChO1tDMB2GM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FTElaSfoz1wL+01mKTPBnqSj2r/6nZri6MkG4G94zTGTHW7NhL2lodUrmjIgkpi5K
         dOCkzMONt8mrawvty7aolrUyInRzHvd9pGOf1VxS4t4fgz9kAIuM1tQjEMaKA319N1
         FNf35ocFQBj+5ser1F1aRrh+Hqpv9sYOOWMCprDAvHeP02uGTjpO7D6p6+mxeAtfVC
         QspqnqSNOEwZWN2SyB7Fra1w/McbOf6i8JtHFmuLzld6Dy+tSDy/jSvDzgEE6INDwb
         ijEEOp5awxw3lggYq42i5lCBXSkQCzDSNENdUpVt/IGGC3y7gQ6c/wRRD0WP1ruzxi
         cnhCQe7c0wVsg==
Message-ID: <fef1cae9-057c-4946-b9d3-27a799fefc5d@collabora.com>
Date:   Tue, 17 Oct 2023 11:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 22/23] drm/mediatek: Power on devices in OVL adaptor
 when atomic enable
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
 <20231016104010.3270-23-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016104010.3270-23-shawn.sung@mediatek.com>
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
> Different from OVL, OVL adaptor is a pseudo device so we didn't
> define it in the device tree, consequently, pm_runtime_resume_and_get()
> called by .atomic_enable() powers on no device in OVL adaptor and
> leads to power outage in the corresponding IOMMU.
> 
> To resolve the issue, we implement a function to power on the RDMAs
> in OVL adaptor, and the system will make sure the IOMMU is powered on
> as well because of the device link (iommus) in the RDMA nodes in DTS.
> 
> Fixes: 5db12f5d843b ("media: drm/mediatek: Add pm runtime support for ovl and rdma")
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  4 ++
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 62 +++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 28 +++------
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   |  2 +
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   | 20 ++++++
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       | 16 +++++
>   6 files changed, 111 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index e2b602037ac3..c44f5b31bab5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -109,6 +109,8 @@ void mtk_ovl_adaptor_connect(struct device *dev, struct device *mmsys_dev,
>   			     unsigned int next);
>   void mtk_ovl_adaptor_disconnect(struct device *dev, struct device *mmsys_dev,
>   				unsigned int next);
> +int mtk_ovl_adaptor_power_on(struct device *dev);
> +void mtk_ovl_adaptor_power_off(struct device *dev);
>   int mtk_ovl_adaptor_clk_enable(struct device *dev);
>   void mtk_ovl_adaptor_clk_disable(struct device *dev);
>   void mtk_ovl_adaptor_config(struct device *dev, unsigned int w,
> @@ -150,6 +152,8 @@ void mtk_rdma_disable_vblank(struct device *dev);
>   const u32 *mtk_rdma_get_formats(struct device *dev);
>   size_t mtk_rdma_get_num_formats(struct device *dev);
>   
> +int mtk_mdp_rdma_power_on(struct device *dev);
> +void mtk_mdp_rdma_power_off(struct device *dev);
>   int mtk_mdp_rdma_clk_enable(struct device *dev);
>   void mtk_mdp_rdma_clk_disable(struct device *dev);
>   void mtk_mdp_rdma_start(struct device *dev, struct cmdq_pkt *cmdq_pkt);
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index b80425360e76..8de57a5f5518 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -98,6 +98,8 @@ static const struct mtk_ddp_comp_funcs _padding = {
>   };
>   
>   static const struct mtk_ddp_comp_funcs _rdma = {
> +	.power_on = mtk_mdp_rdma_power_on,
> +	.power_off = mtk_mdp_rdma_power_off,
>   	.clk_enable = mtk_mdp_rdma_clk_enable,
>   	.clk_disable = mtk_mdp_rdma_clk_disable,
>   };
> @@ -241,6 +243,66 @@ void mtk_ovl_adaptor_stop(struct device *dev)
>   	}
>   }
>   
> +/**
> + * mtk_ovl_adaptor_power_on - Power on devices in OVL adaptor
> + * @dev: device to be powered on
> + *
> + * Different from OVL, OVL adaptor is a pseudo device so
> + * we didn't define it in the device tree, pm_runtime_resume_and_get()
> + * called by .atomic_enable() power on no device in OVL adaptor,
> + * we have to implement a function to do the job instead.
> + *
> + * returns:
> + * zero on success, errno on failures.

You're almost there! There's just one mistake making this invalid kerneldoc;
change to...

  * Return: Zero for success or negative number for failure.

https://docs.kernel.org/doc-guide/kernel-doc.html

> + */
> +int mtk_ovl_adaptor_power_on(struct device *dev)
> +{
> +	int i, ret;
> +	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
> +		if (!ovl_adaptor->ovl_adaptor_comp[i] ||
> +		    !comp_matches[i].funcs->power_on)
> +			continue;
> +
> +		/*
> +		 * do not power on the devices that don't define
> +		 * .power_off() function
> +		 */
> +		if (!comp_matches[i].funcs->power_off) {
> +			dev_warn(dev, ".power_off() is undefined\n");
> +			continue;
> +		}
> +
> +		ret = comp_matches[i].funcs->power_on(ovl_adaptor->ovl_adaptor_comp[i]);
> +		if (ret < 0) {
> +			mtk_ovl_adaptor_power_off(dev);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * mtk_ovl_adaptor_power_off - Power off devices in OVL adaptor
> + * @dev: device to be powered off
> + *
> + * call .power_off() function if defined

  * Calls the .power_off() ovl_adaptor component callback if it is present.

> + */

Regards,
Angelo

