Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24715782C14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjHUOiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHUOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437AE3;
        Mon, 21 Aug 2023 07:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D2362D46;
        Mon, 21 Aug 2023 14:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09CBC433C7;
        Mon, 21 Aug 2023 14:38:13 +0000 (UTC)
Message-ID: <58c2ee02-153d-c046-f39f-bf39054450d0@xs4all.nl>
Date:   Mon, 21 Aug 2023 16:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 04/10] media: verisilicon: Refactor postprocessor to
 store more buffers
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
 <20230705121056.37017-5-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230705121056.37017-5-benjamin.gaignard@collabora.com>
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
> Since vb2 queue can store than VB2_MAX_FRAME buffers postprocessor
> buffer storage must be capable to store more buffers too.
> Change static dec_q array to allocated array to be capable to store
> up to queue 'max_allowed_buffers'.

Is there are reason to allocate this dynamically instead of keeping it
as an array of 64 elements? It takes a bit more memory, but it avoids
having to allocate extra memory as well.

And how was the new value of max 64 buffers calculated? What is the
reasoning behind it?

Regards,

	Hans

> Keep allocating queue 'num_buffers' at queue setup time but also allows
> to allocate postprocessors buffers on the fly.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro.h   |   7 +-
>  .../media/platform/verisilicon/hantro_drv.c   |   4 +-
>  .../media/platform/verisilicon/hantro_hw.h    |   2 +-
>  .../platform/verisilicon/hantro_postproc.c    | 103 ++++++++++++++----
>  .../media/platform/verisilicon/hantro_v4l2.c  |   2 +-
>  5 files changed, 93 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 2989ebc631cc..c8a3cf10cc64 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -461,11 +461,14 @@ hantro_get_dst_buf(struct hantro_ctx *ctx)
>  bool hantro_needs_postproc(const struct hantro_ctx *ctx,
>  			   const struct hantro_fmt *fmt);
>  
> +dma_addr_t
> +hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index);
> +
>  static inline dma_addr_t
>  hantro_get_dec_buf_addr(struct hantro_ctx *ctx, struct vb2_buffer *vb)
>  {
>  	if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> -		return ctx->postproc.dec_q[vb->index].dma;
> +		return hantro_postproc_get_dec_buf_addr(ctx, vb->index);
>  	return vb2_dma_contig_plane_dma_addr(vb, 0);
>  }
>  
> @@ -477,8 +480,8 @@ vb2_to_hantro_decoded_buf(struct vb2_buffer *buf)
>  
>  void hantro_postproc_disable(struct hantro_ctx *ctx);
>  void hantro_postproc_enable(struct hantro_ctx *ctx);
> +int hantro_postproc_init(struct hantro_ctx *ctx);
>  void hantro_postproc_free(struct hantro_ctx *ctx);
> -int hantro_postproc_alloc(struct hantro_ctx *ctx);
>  int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
>  				   struct v4l2_frmsizeenum *fsize);
>  
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 09c74a573ddb..d908559817ce 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -234,8 +234,10 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>  	 * The Kernel needs access to the JPEG destination buffer for the
>  	 * JPEG encoder to fill in the JPEG headers.
>  	 */
> -	if (!ctx->is_encoder)
> +	if (!ctx->is_encoder) {
>  		dst_vq->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
> +		dst_vq->max_allowed_buffers = 64;
> +	}
>  
>  	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>  	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index e83f0c523a30..6fd6c9d53cec 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -253,7 +253,7 @@ struct hantro_vp9_dec_hw_ctx {
>   * @dec_q:		References buffers, in decoder format.
>   */
>  struct hantro_postproc_ctx {
> -	struct hantro_aux_buf dec_q[VB2_MAX_FRAME];
> +	struct hantro_aux_buf *dec_q;
>  };
>  
>  /**
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 6437423ccf3a..9dfe3141a398 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -173,9 +173,11 @@ static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
>  void hantro_postproc_free(struct hantro_ctx *ctx)
>  {
>  	struct hantro_dev *vpu = ctx->dev;
> +	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> +	struct vb2_queue *queue = &m2m_ctx->cap_q_ctx.q;
>  	unsigned int i;
>  
> -	for (i = 0; i < VB2_MAX_FRAME; ++i) {
> +	for (i = 0; i < queue->max_allowed_buffers; ++i) {
>  		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
>  
>  		if (priv->cpu) {
> @@ -184,22 +186,21 @@ void hantro_postproc_free(struct hantro_ctx *ctx)
>  			priv->cpu = NULL;
>  		}
>  	}
> +	kfree(ctx->postproc.dec_q);
> +	ctx->postproc.dec_q = NULL;
>  }
>  
> -int hantro_postproc_alloc(struct hantro_ctx *ctx)
> +static unsigned int hantro_postproc_buffer_size(struct hantro_ctx *ctx)
>  {
> -	struct hantro_dev *vpu = ctx->dev;
> -	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> -	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> -	unsigned int num_buffers = cap_queue->num_buffers;
>  	struct v4l2_pix_format_mplane pix_mp;
>  	const struct hantro_fmt *fmt;
> -	unsigned int i, buf_size;
> +	unsigned int buf_size;
>  
>  	/* this should always pick native format */
>  	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth);
>  	if (!fmt)
> -		return -EINVAL;
> +		return 0;
> +
>  	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
>  			    ctx->src_fmt.height);
>  
> @@ -214,23 +215,85 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  		buf_size += hantro_hevc_mv_size(pix_mp.width,
>  						pix_mp.height);
>  
> -	for (i = 0; i < num_buffers; ++i) {
> -		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
> +	return buf_size;
> +}
> +
> +static int hantro_postproc_alloc(struct hantro_ctx *ctx, int index)
> +{
> +	struct hantro_dev *vpu = ctx->dev;
> +	struct hantro_aux_buf *priv = &ctx->postproc.dec_q[index];
> +	unsigned int buf_size = hantro_postproc_buffer_size(ctx);
> +
> +	if (!buf_size)
> +		return -EINVAL;
> +
> +	/*
> +	 * The buffers on this queue are meant as intermediate
> +	 * buffers for the decoder, so no mapping is needed.
> +	 */
> +	priv->attrs = DMA_ATTR_NO_KERNEL_MAPPING;
> +	priv->cpu = dma_alloc_attrs(vpu->dev, buf_size, &priv->dma,
> +				    GFP_KERNEL, priv->attrs);
> +	if (!priv->cpu)
> +		return -ENOMEM;
> +	priv->size = buf_size;
> +
> +	return 0;
> +}
> +
> +int hantro_postproc_init(struct hantro_ctx *ctx)
> +{
> +	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> +	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> +	unsigned int num_buffers = cap_queue->num_buffers;
> +	unsigned int i;
> +	int ret;
>  
> -		/*
> -		 * The buffers on this queue are meant as intermediate
> -		 * buffers for the decoder, so no mapping is needed.
> -		 */
> -		priv->attrs = DMA_ATTR_NO_KERNEL_MAPPING;
> -		priv->cpu = dma_alloc_attrs(vpu->dev, buf_size, &priv->dma,
> -					    GFP_KERNEL, priv->attrs);
> -		if (!priv->cpu)
> -			return -ENOMEM;
> -		priv->size = buf_size;
> +	if (!ctx->postproc.dec_q)
> +		ctx->postproc.dec_q = kcalloc(cap_queue->max_allowed_buffers,
> +					      sizeof(*ctx->postproc.dec_q),
> +					      GFP_KERNEL);
> +
> +	if (!ctx->postproc.dec_q)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_buffers; i++) {
> +		ret = hantro_postproc_alloc(ctx, i);
> +		if (ret)
> +			return ret;
>  	}
> +
>  	return 0;
>  }
>  
> +dma_addr_t
> +hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index)
> +{
> +	struct hantro_aux_buf *priv = &ctx->postproc.dec_q[index];
> +	unsigned int buf_size = hantro_postproc_buffer_size(ctx);
> +	struct hantro_dev *vpu = ctx->dev;
> +	int ret;
> +
> +	if (priv->size < buf_size && priv->cpu) {
> +		/* buffer is too small, release it */
> +		dma_free_attrs(vpu->dev, priv->size, priv->cpu,
> +			       priv->dma, priv->attrs);
> +		priv->cpu = NULL;
> +	}
> +
> +	if (!priv->cpu) {
> +		/* buffer not already allocated, try getting a new one */
> +		ret = hantro_postproc_alloc(ctx, index);
> +		if (ret)
> +			return 0;
> +	}
> +
> +	if (!priv->cpu)
> +		return 0;
> +
> +	return priv->dma;
> +}
> +
>  static void hantro_postproc_g1_disable(struct hantro_ctx *ctx)
>  {
>  	struct hantro_dev *vpu = ctx->dev;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 61cfaaf4e927..898e8763d63a 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -897,7 +897,7 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
>  		}
>  
>  		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt)) {
> -			ret = hantro_postproc_alloc(ctx);
> +			ret = hantro_postproc_init(ctx);
>  			if (ret)
>  				goto err_codec_exit;
>  		}

