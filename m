Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF97B50C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjJBK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbjJBK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689AB3;
        Mon,  2 Oct 2023 03:57:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A1CC433C9;
        Mon,  2 Oct 2023 10:57:16 +0000 (UTC)
Message-ID: <4e9452b9-a02c-47eb-ba8f-5949f07f707d@xs4all.nl>
Date:   Mon, 2 Oct 2023 12:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] media: platform: mtk-mdp3: fix uninitialized
 variable in mdp_path_config()
Content-Language: en-US, nl
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230922074145.11977-1-moudy.ho@mediatek.com>
 <20230922074145.11977-14-moudy.ho@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230922074145.11977-14-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 09:41, Moudy Ho wrote:
> Fix the build warnings that were detected by the linux-media
> build scripts tool:
> 
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:
> 	In function 'mdp_path_config.isra':
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:443:51:
> 	warning: 'ctx' may be used uninitialized [-Wmaybe-uninitialized]
>   443 |                    out = CFG_COMP(MT8195, ctx->param, outputs[0]);
>       |                                           ~~~^~~~~~~
> drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h:137:25: note:
> 	in definition of macro 'CFG_COMP'
>   137 |         (IS_ERR_OR_NULL(comp) ? 0 : _CFG_COMP(plat, comp, mem))
>       |                         ^~~~
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c:396:30:
> 	note: 'ctx' was declared here
>   396 |         struct mdp_comp_ctx *ctx;
>       |
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> index 15a0b944745e..4a8d941178aa 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> @@ -436,13 +436,13 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
>  		if (mdp_cfg_comp_is_dummy(path->mdp_dev, inner_id))
>  			continue;
>  
> +		ctx = &path->comps[index];
>  		if (CFG_CHECK(MT8183, p_id))
>  			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
>  		else if (CFG_CHECK(MT8195, p_id))
>  			out = CFG_COMP(MT8195, ctx->param, outputs[0]);
>  
>  		compose = path->composes[out];
> -		ctx = &path->comps[index];
>  		ret = call_op(ctx, config_frame, cmd, compose);
>  		if (ret)
>  			return ret;

Hmm, this patch really should be a separate patch on top of the media
staging branch: it is wrong there as well, except you don't get a build
warning. Other changes in this patch series caused this warning to appear,
but the actual bug is already present in the current staging code.

Regards,

	Hans
