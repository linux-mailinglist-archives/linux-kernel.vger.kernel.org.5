Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DCA759020
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGSIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGSIVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686D1724;
        Wed, 19 Jul 2023 01:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B166131B;
        Wed, 19 Jul 2023 08:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF22C433C9;
        Wed, 19 Jul 2023 08:21:12 +0000 (UTC)
Message-ID: <00a48d8b-2bc7-6848-886d-e09478cc0469@xs4all.nl>
Date:   Wed, 19 Jul 2023 10:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: mdp3: Fix resource leak in
 for_each_child_of_node() loop
Content-Language: en-US
To:     =?UTF-8?B?6Lev57qi6aOe?= <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>, Sun Ke <sunke32@huawei.com>,
        Deepak R Varma <drv@mailo.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230719080632.13357-1-luhongfei@vivo.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230719080632.13357-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You mailed this as an HTML email instead of ASCII. HTML emails are silently rejected by
the mailinglist, so please repost as an ASCII email, as you did before.

Thank you!

    Hans

On 19/07/2023 10:06, 路红飞 wrote:
> for_each_child_of_node should have of_node_put()
> in error path avoid resource leaks.
>
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
> Changelog:
> v1->v2:
> 1. Change the subject line of this patch to include driver name.
> 2. Remove the unneeded of_node_put.
>
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index a605e80c7dc3..40c4b79a5090 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -1135,6 +1135,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>  		comp = mdp_comp_create(mdp, node, id);
>  		if (IS_ERR(comp)) {
>  			ret = PTR_ERR(comp);
> +			of_node_put(node);
>  			goto err_init_comps;
>  		}
>  


