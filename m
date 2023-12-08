Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20C380AB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjLHRqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:45:59 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E3F123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:46:03 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id Bev8rCdaRbmKlBev9rpX9g; Fri, 08 Dec 2023 18:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702057562;
        bh=ByKgwV0x98pBzWeiac+KymXWEnZBqPMwaQaFwL44V+Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ceq2K8ctrwCikyi2+51iwfoElOvQwgC2ibR4RTajv//9DiURJyAAJYtf2pTjeF1qY
         5nH1RltEGRRtNCe22MWpXGvOEoSvfGDs2xqawkKniJNCxp/D//Szsx4iibWP+So2qf
         R2brmrl2gVxPT5wt5Snwzf9NwRmaRuO8MjbAqWVb6HpsZSkBTpzenHNJ9ZyVUR6za4
         VCJUtbXYRnQPp4WJigV/6GfP7mBMeRc270SAh+xkrrFxWWsdXZLMjuDR5ggn1pXP4K
         Lf6xNqjNpICO1Sa638GGioe60JkFkrLdiwcUoSRy3pOsRcGePjx/sQ4nTvd2vKDXbT
         GYsfc+yWcBixQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 Dec 2023 18:46:02 +0100
X-ME-IP: 92.140.202.140
Message-ID: <26dd45f4-8fb7-476f-b8ec-9cb685a138ef@wanadoo.fr>
Date:   Fri, 8 Dec 2023 18:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] drm/amd/display: replace kzalloc and memcpy
 with kmemdup
To:     yang.guang5@zte.com.cn, harry.wentland@amd.com
Cc:     jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn,
        cgel.zte@gmail.com, sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        xinhui.pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        wenjing.liu@amd.com, jun.lei@amd.com, qingqing.zhuo@amd.com,
        alvin.lee2@amd.com, samson.tam@amd.com, aric.cyr@amd.com,
        chiawen.huang@amd.com, gabe.teeger@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <202312081044568085747@zte.com.cn>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202312081044568085747@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/12/2023 à 03:44, yang.guang5@zte.com.cn a écrit :
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Convert kzalloc/memcpy operations to memdup makes for
> cleaner code and avoids memcpy() failures

Hi,

usually, function's names are written with () in commit description. 
(i.e. kzalloc()/memcpy()).

memdup should be kmemdup().

Finally the proposed change does not avoid memcpy() failures. Should it 
fail (what does it mean in this context?), kmemdup() would behave 
exactly the same.

> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 76b47f178127..867e1a0fdef6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2264,12 +2264,10 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx)
> 
>   #ifdef CONFIG_DRM_AMD_DC_FP
>   	if (new_ctx->bw_ctx.dml2) {
> -		dml2 = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
> -		if (!dml2)
> -			return NULL;
> -
> -		memcpy(dml2, src_ctx->bw_ctx.dml2, sizeof(struct dml2_context));
> -		new_ctx->bw_ctx.dml2 = dml2;
> +		dml2 = kmemdup(src_ctx->bw_ctx.dml2, sizeof(struct dml2_context), GFP_KERNEL);

sizeof(struct dml2_context) could be sizeof(*dlm2) to be less verbose.

CJ

> +		if (!dml2)
> +			return NULL;
> +		new_ctx->bw_ctx.dml2 = dml2;
>   	}
>   #endif
> 

