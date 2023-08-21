Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B9782C37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjHUOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjHUOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C8EC;
        Mon, 21 Aug 2023 07:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE85363A38;
        Mon, 21 Aug 2023 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F7C433C7;
        Mon, 21 Aug 2023 14:41:28 +0000 (UTC)
Message-ID: <1b87f062-9d5e-fa8e-3d3b-e766362c6e3b@xs4all.nl>
Date:   Mon, 21 Aug 2023 16:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 05/10] media: verisilicon: Store chroma and motion
 vectors offset
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
 <20230705121056.37017-6-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230705121056.37017-6-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 14:10, Benjamin Gaignard wrote:
> Store computed values of chroma and motion vectors offset because
> they depends on width and height values which change if the resolution
> change.

Is this a bug fix? Does this patch belong in this series?

Same actually for the next few verisilicon patches. Shouldn't they be
part of a separate 'fixes' patch series? It's confusing to see them
in this series.

Regards,

	Hans

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro.h            | 2 ++
>  drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index c8a3cf10cc64..53be00142473 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -320,6 +320,8 @@ struct hantro_vp9_decoded_buffer_info {
>  	/* Info needed when the decoded frame serves as a reference frame. */
>  	unsigned short width;
>  	unsigned short height;
> +	size_t chroma_offset;
> +	size_t mv_offset;
>  	u32 bit_depth : 4;
>  };
>  
> diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> index 6fc4b555517f..6db1c32fce4d 100644
> --- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> +++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
> @@ -158,9 +158,11 @@ static void config_output(struct hantro_ctx *ctx,
>  
>  	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
>  	hantro_write_addr(ctx->dev, G2_OUT_CHROMA_ADDR, chroma_addr);
> +	dst->vp9.chroma_offset = chroma_offset(ctx, dec_params);
>  
>  	mv_addr = luma_addr + mv_offset(ctx, dec_params);
>  	hantro_write_addr(ctx->dev, G2_OUT_MV_ADDR, mv_addr);
> +	dst->vp9.mv_offset = mv_offset(ctx, dec_params);
>  }
>  
>  struct hantro_vp9_ref_reg {
> @@ -195,7 +197,7 @@ static void config_ref(struct hantro_ctx *ctx,
>  	luma_addr = hantro_get_dec_buf_addr(ctx, &buf->base.vb.vb2_buf);
>  	hantro_write_addr(ctx->dev, ref_reg->y_base, luma_addr);
>  
> -	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
> +	chroma_addr = luma_addr + buf->vp9.chroma_offset;
>  	hantro_write_addr(ctx->dev, ref_reg->c_base, chroma_addr);
>  }
>  
> @@ -238,7 +240,7 @@ static void config_ref_registers(struct hantro_ctx *ctx,
>  	config_ref(ctx, dst, &ref_regs[2], dec_params, dec_params->alt_frame_ts);
>  
>  	mv_addr = hantro_get_dec_buf_addr(ctx, &mv_ref->base.vb.vb2_buf) +
> -		  mv_offset(ctx, dec_params);
> +		  mv_ref->vp9.mv_offset;
>  	hantro_write_addr(ctx->dev, G2_REF_MV_ADDR(0), mv_addr);
>  
>  	hantro_reg_write(ctx->dev, &vp9_last_sign_bias,

