Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E488E7E6BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKIN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKIN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:58:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90842272C;
        Thu,  9 Nov 2023 05:58:16 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 755FD660748C;
        Thu,  9 Nov 2023 13:58:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699538294;
        bh=n0j9/3eVxo6UWnJWYRxWHe7dch/2QnB4i+8hCYwAnrA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=COcV65NUQ7dBtKZFNoCmAm1OzQhRM1rRk8M2qNSfCYUMdGJbtJhq6RG1hfdtRM8jB
         OmS8x0uAygFFJl88aJcUxNz3xcmh2/VvtLa48wuV83En681OFkQa0kXspE1/WEHa1G
         OMeZ0lvs11I1fUT4zIw8x1e6ReIzKNz73y/HirxwAkg6VcskjoVydm45hKZNWAc61P
         9u2sskPDJbjv7A/tArpl/9Dr9DC9H5Y2s3BSX65RxLr2I0RHpKBcRsfQ/lUNrcEajy
         ZmOnEwXaY3NzIgoEEjoLkNpIGOgIVFLwGs1GTv+bLaJtlb0g3+EUGKH80Q9kaBz/Rs
         jpXlYYF9R4eTQ==
Message-ID: <588bdbac-cab5-4e5e-8f21-44d80d7df066@collabora.com>
Date:   Thu, 9 Nov 2023 14:58:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 47/56] media: verisilicon: Refactor postprocessor to
 store more buffers
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-48-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-48-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Since vb2 queue can store more than VB2_MAX_FRAME buffers, the
> postprocessor buffer storage must be capable to store more buffers too.
> Change static dec_q array to allocated array to be capable to store
> up to queue 'max_num_buffers'.
> Keep allocating queue 'num_buffers' at queue setup time but also allows
> to allocate postprocessors buffers on the fly.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/media/platform/verisilicon/hantro.h   |  7 +-
>   .../media/platform/verisilicon/hantro_drv.c   |  4 +-
>   .../media/platform/verisilicon/hantro_hw.h    |  4 +-
>   .../platform/verisilicon/hantro_postproc.c    | 93 +++++++++++++++----
>   .../media/platform/verisilicon/hantro_v4l2.c  |  2 +-
>   5 files changed, 85 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 77aee9489516..0948b04a9f8d 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -469,11 +469,14 @@ hantro_get_dst_buf(struct hantro_ctx *ctx)
>   bool hantro_needs_postproc(const struct hantro_ctx *ctx,
>   			   const struct hantro_fmt *fmt);
>   
> +dma_addr_t
> +hantro_postproc_get_dec_buf_addr(struct hantro_ctx *ctx, int index);
> +
>   static inline dma_addr_t
>   hantro_get_dec_buf_addr(struct hantro_ctx *ctx, struct vb2_buffer *vb)
>   {
>   	if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
> -		return ctx->postproc.dec_q[vb->index].dma;
> +		return hantro_postproc_get_dec_buf_addr(ctx, vb->index);
>   	return vb2_dma_contig_plane_dma_addr(vb, 0);
>   }
>   
> @@ -485,8 +488,8 @@ vb2_to_hantro_decoded_buf(struct vb2_buffer *buf)
>   
>   void hantro_postproc_disable(struct hantro_ctx *ctx);
>   void hantro_postproc_enable(struct hantro_ctx *ctx);
> +int hantro_postproc_init(struct hantro_ctx *ctx);
>   void hantro_postproc_free(struct hantro_ctx *ctx);
> -int hantro_postproc_alloc(struct hantro_ctx *ctx);
>   int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
>   				   struct v4l2_frmsizeenum *fsize);
>   
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index a9fa05ac56a9..7f5b82eb6649 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -235,8 +235,10 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>   	 * The Kernel needs access to the JPEG destination buffer for the
>   	 * JPEG encoder to fill in the JPEG headers.
>   	 */
> -	if (!ctx->is_encoder)
> +	if (!ctx->is_encoder) {
>   		dst_vq->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
> +		dst_vq->max_num_buffers = MAX_POSTPROC_BUFFERS;
> +	}
>   
>   	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>   	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index 7f33f7b07ce4..292a76ef643e 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -40,6 +40,8 @@
>   
>   #define AV1_MAX_FRAME_BUF_COUNT	(V4L2_AV1_TOTAL_REFS_PER_FRAME + 1)
>   
> +#define MAX_POSTPROC_BUFFERS	64
> +
>   struct hantro_dev;
>   struct hantro_ctx;
>   struct hantro_buf;
> @@ -336,7 +338,7 @@ struct hantro_av1_dec_hw_ctx {
>    * @dec_q:		References buffers, in decoder format.
>    */
>   struct hantro_postproc_ctx {
> -	struct hantro_aux_buf dec_q[VB2_MAX_FRAME];
> +	struct hantro_aux_buf dec_q[MAX_POSTPROC_BUFFERS];
>   };
>   
>   /**
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 8f8f17e671ce..41e93176300b 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -177,9 +177,11 @@ static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
>   void hantro_postproc_free(struct hantro_ctx *ctx)
>   {
>   	struct hantro_dev *vpu = ctx->dev;
> +	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> +	struct vb2_queue *queue = &m2m_ctx->cap_q_ctx.q;
>   	unsigned int i;
>   
> -	for (i = 0; i < VB2_MAX_FRAME; ++i) {
> +	for (i = 0; i < queue->max_num_buffers; ++i) {
>   		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
>   
>   		if (priv->cpu) {
> @@ -190,20 +192,17 @@ void hantro_postproc_free(struct hantro_ctx *ctx)
>   	}
>   }
>   
> -int hantro_postproc_alloc(struct hantro_ctx *ctx)
> +static unsigned int hantro_postproc_buffer_size(struct hantro_ctx *ctx)
>   {
> -	struct hantro_dev *vpu = ctx->dev;
> -	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> -	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> -	unsigned int num_buffers = vb2_get_num_buffers(cap_queue);
>   	struct v4l2_pix_format_mplane pix_mp;
>   	const struct hantro_fmt *fmt;
> -	unsigned int i, buf_size;
> +	unsigned int buf_size;
>   
>   	/* this should always pick native format */
>   	fmt = hantro_get_default_fmt(ctx, false, ctx->bit_depth, HANTRO_AUTO_POSTPROC);
>   	if (!fmt)
> -		return -EINVAL;
> +		return 0;
> +
>   	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
>   			    ctx->src_fmt.height);
>   
> @@ -221,23 +220,77 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>   		buf_size += hantro_av1_mv_size(pix_mp.width,
>   					       pix_mp.height);
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
> +int hantro_postproc_init(struct hantro_ctx *ctx)
> +{
> +	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> +	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> +	unsigned int num_buffers = vb2_get_num_buffers(cap_queue);
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < num_buffers; i++) {
> +		ret = hantro_postproc_alloc(ctx, i);
> +		if (ret)
> +			return ret;
>   	}
> +
>   	return 0;
>   }
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
>   static void hantro_postproc_g1_disable(struct hantro_ctx *ctx)
>   {
>   	struct hantro_dev *vpu = ctx->dev;
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index b3ae037a50f6..f0d8b165abcd 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -933,7 +933,7 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
>   		}
>   
>   		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt)) {
> -			ret = hantro_postproc_alloc(ctx);
> +			ret = hantro_postproc_init(ctx);
>   			if (ret)
>   				goto err_codec_exit;
>   		}

