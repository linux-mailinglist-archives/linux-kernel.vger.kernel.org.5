Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6A75A843
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGTHwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGTHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:51:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F326AB;
        Thu, 20 Jul 2023 00:51:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F275660707F;
        Thu, 20 Jul 2023 08:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689839506;
        bh=jIJuDdBqpd9dYlzqbxXjWksr5/fpNfwC3vh0Df86hSA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EL6Ox+4ZM/rOi9BxMX+3fzD7YFCPDYUIq8nAOqLAksUJWrXi/UZk1mZ5a/8dB5JH5
         GsAiXRpSjA4qgNdEmczDV5UHgOC10lPTa/FxhnOkt+7vR8Xb0pC8L81bPMVOtbbz3t
         LK+na0uWDZrkaMZQaBm1hCC0+KiwPEa1bxIllpfRcYtUcy64NCHRyXWQ3jEW5mQliB
         nkfZbgYxajjmbRMu2kI9hzmv2/5zDIsqUBVbhqaM4CCLtXHSAjois5vNpQKvBxrl6m
         xOFbXf4Jc4pU5TcBjgD3ixHcIFw46qTmJ+udO++oq1J2lcJqKbCqwW3tvBdhsOVWJr
         8JJTIyb8Icxlg==
Message-ID: <32ae3716-672f-cdc2-f246-d8336ed44a68@collabora.com>
Date:   Thu, 20 Jul 2023 09:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: mdp3: Fix resource leak in a
 for_each_child_of_node() loop
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Sun Ke <sunke32@huawei.com>,
        Deepak R Varma <drv@mailo.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230720062248.37906-1-luhongfei@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230720062248.37906-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 08:23, Lu Hongfei ha scritto:
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
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index a605e80c7dc3..40c4b79a5090 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -1135,6 +1135,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>   		comp = mdp_comp_create(mdp, node, id);
>   		if (IS_ERR(comp)) {
>   			ret = PTR_ERR(comp);
> +			of_node_put(node);
>   			goto err_init_comps;
>   		}
>   

In case mdp_comp_sub_create() fails, we still want to decrease the refcount
of `node`....

...so, just call of_node_put(node) just once, at the err_init_comps label.

err_init_comps:
	mdp_comp_destroy(mdp);
	of_node_put(node);
	return ret;

Regards,
Angelo
