Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79912758F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGSHng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGSHm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11461FE8;
        Wed, 19 Jul 2023 00:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642F160F19;
        Wed, 19 Jul 2023 07:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9EC433C7;
        Wed, 19 Jul 2023 07:41:54 +0000 (UTC)
Message-ID: <1dfd0643-bec6-5360-bbd1-968848b760f9@xs4all.nl>
Date:   Wed, 19 Jul 2023 09:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: Fix resource leaks in for_each_child_of_node()
 loops
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Sun Ke <sunke32@huawei.com>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     opensource.kernel@vivo.com
References: <20230530094541.23396-1-luhongfei@vivo.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230530094541.23396-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu Hongfei,

Please add the driver name to the subject line: 'media: mdp3:'!

On 30/05/2023 11:45, Lu Hongfei wrote:
> for_each_child_of_node should have of_node_put() avoid resource leaks.
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 3 +++
>  1 file changed, 3 insertions(+)
>  mode change 100644 => 100755 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index 19a4a085f73a..5a6a61d68cba
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -1128,6 +1128,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  		comp = mdp_comp_create(mdp, node, id);
>  		if (IS_ERR(comp)) {
>  			ret = PTR_ERR(comp);
> +			of_node_put(node);

This is needed,

>  			goto err_init_comps;
>  		}
>  
> @@ -1137,6 +1138,8 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  		pm_runtime_enable(comp->comp_dev);
>  	}
>  
> +	of_node_put(node);
> +

but not this one. The for_each_child_of_node loop ended, so node == NULL and
there is nothing to put.

Regards,

	Hans

>  	ret = mdp_comp_sub_create(mdp);
>  	if (ret)
>  		goto err_init_comps;

