Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D57BA592
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbjJEQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbjJEQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7850629B0D;
        Thu,  5 Oct 2023 07:42:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C973EC116AF;
        Thu,  5 Oct 2023 08:43:19 +0000 (UTC)
Message-ID: <b7c19673-a3bd-449a-9e84-49a68c89b0ea@xs4all.nl>
Date:   Thu, 5 Oct 2023 10:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: mediatek: vcodec: Handle encoder vsi NULL
 pointer case
Content-Language: en-US, nl
To:     Irui Wang <irui.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maoguang Meng <maoguang.meng@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
 <20230926101909.15030-2-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230926101909.15030-2-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 12:19, Irui Wang wrote:
> There will be a kernel null pointer exception if 'vsi' is NULL, check
> 'vsi' is not NULL before assign it to encoder instance.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../platform/mediatek/vcodec/encoder/venc/venc_h264_if.c     | 5 +++++
>  .../platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c      | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> index a68dac72c4e4..385bcc0d14f3 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
> @@ -597,6 +597,11 @@ static int h264_enc_init(struct mtk_vcodec_enc_ctx *ctx)
>  	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_SYS);
>  
>  	ret = vpu_enc_init(&inst->vpu_inst);
> +	if (!inst->vpu_inst.vsi) {
> +		mtk_venc_err(ctx, "share buffer is NULL");
> +		kfree(inst);
> +		return -EFAULT;
> +	}

Shouldn't this check be done in vpu_enc_init?

It looks weird that a function can return 0, but there is still an
error that needs to be checked manually afterwards.

Regards,

	Hans

>  
>  	if (MTK_ENC_IOVA_IS_34BIT(ctx))
>  		inst->vsi_34 = (struct venc_h264_vsi_34 *)inst->vpu_inst.vsi;
> diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
> index 05abca91e742..23ca0d93324f 100644
> --- a/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
> @@ -326,6 +326,11 @@ static int vp8_enc_init(struct mtk_vcodec_enc_ctx *ctx)
>  	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VENC_LT_SYS);
>  
>  	ret = vpu_enc_init(&inst->vpu_inst);
> +	if (!inst->vpu_inst.vsi) {
> +		mtk_venc_err(ctx, "share buffer is NULL");
> +		kfree(inst);
> +		return -EFAULT;
> +	}
>  
>  	inst->vsi = (struct venc_vp8_vsi *)inst->vpu_inst.vsi;
>  

