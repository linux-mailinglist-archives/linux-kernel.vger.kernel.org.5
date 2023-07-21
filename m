Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB475C344
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGUJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGUJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BC3ABD;
        Fri, 21 Jul 2023 02:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1B8B619B0;
        Fri, 21 Jul 2023 09:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7342FC433C8;
        Fri, 21 Jul 2023 09:41:46 +0000 (UTC)
Message-ID: <48a07b61-edb6-1c2f-8299-14d346ab7b2e@xs4all.nl>
Date:   Fri, 21 Jul 2023 11:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] media: platform: mtk-mdp3: Fix resource leak in
 mdp_get_subsys_id() and mdp_comp_config()
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Sun Ke <sunke32@huawei.com>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230613032734.34099-1-luhongfei@vivo.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230613032734.34099-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu Hongfei,

On 13/06/2023 05:27, Lu Hongfei wrote:
> Add a put_device() call for the release of the object
> which was determined by a of_find_device_by_node() call
> in mdp_get_subsys_id().
> 
> Add of_node_put() call for the release of the object
> which was determined by a for_each_child_of_node() call
> in mdp_comp_config().

After merging this patch from you into our media_stage tree:

https://patchwork.linuxtv.org/project/linux-media/patch/20230530101724.31412-1-luhongfei@vivo.com/

this v3 no longer applies. So I will need a v4, I'm afraid...

Regards,

	Hans

> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
> The previous version’s Subject was:
> [PATCH v2] media: platform: mtk-mdp3: Fix resource leaks in mdp_get_subsys_id()
> 
> The modifications made compared to the previous version are as follows:
> 1. Modified the patch subject
> 2. Fix resource leak issue in mdp_comp_config()
> 
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index a605e80c7dc3..85c5f89f2ed2
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -892,13 +892,16 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
>  	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
>  	if (ret != 0) {
>  		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_device;
>  	}
>  
>  	comp->subsys_id = cmdq_reg.subsys;
>  	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
>  
> -	return 0;
> +put_device:
> +	put_device(&comp_pdev->dev);
> +	return ret;
>  }
>  
>  static void __mdp_comp_init(struct mdp_dev *mdp, struct device_node *node,
> @@ -1135,6 +1138,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  		comp = mdp_comp_create(mdp, node, id);
>  		if (IS_ERR(comp)) {
>  			ret = PTR_ERR(comp);
> +			of_node_put(node);
>  			goto err_init_comps;
>  		}
>  
> @@ -1144,6 +1148,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  		pm_runtime_enable(comp->comp_dev);
>  	}
>  
> +	of_node_put(node);
> +
>  	ret = mdp_comp_sub_create(mdp);
>  	if (ret)
>  		goto err_init_comps;

