Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C247E693C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjKILKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjKILK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:10:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70250271F;
        Thu,  9 Nov 2023 03:10:26 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DBC066073ED;
        Thu,  9 Nov 2023 11:10:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699528224;
        bh=bWD04K/fqE7NHkAwkYWwh+Wb6UO3uT2z0NoApGEOIG0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fCaON4fHgKa+Bg04QqrgU+9SEwPb47ek73QwFkmjFsljFIxYcV5RyFlkyBK1DCkjr
         H03lBkFZ9FooxxqbootX2Guirmd365Pt9JfvbmAh0oZVLbHzS6nxtLCF9rHBK48FiO
         SQtMrBaY4bQoFO0B55HSRwlqRaSBRA/1lvCeI/7rGrNFaE703GpqLj1fJMJ2LHKhFH
         SHGSaVOx1E2YmVmoUZj7TI2G/CvWbL/qPdiNPGGqCKgDa9YfYgMl5m/se21LnGYYJS
         3/MGFT8NQoSkYM9i2kMICpeivrGfP0+WtSZ3ba2NqMSveNkQwAp/AdOTBahYunQGoJ
         VxFuWiZybjkNQ==
Message-ID: <05bfb164-cf25-4523-b2d6-40617f91803e@collabora.com>
Date:   Thu, 9 Nov 2023 12:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/56] media: test-drivers: Stop direct calls to queue
 num_buffers field
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
        kernel@collabora.com, Daniel Almeida <daniel.almeida@collabora.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-31-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-31-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> If 'min_buffers_needed' is set remove useless checks in queue setup
> functions.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>   drivers/media/test-drivers/visl/visl-dec.c         | 4 ++--
>   drivers/media/test-drivers/vivid/vivid-meta-cap.c  | 3 ---
>   drivers/media/test-drivers/vivid/vivid-meta-out.c  | 5 +++--
>   drivers/media/test-drivers/vivid/vivid-touch-cap.c | 5 +++--
>   drivers/media/test-drivers/vivid/vivid-vbi-cap.c   | 3 ---
>   drivers/media/test-drivers/vivid/vivid-vbi-out.c   | 3 ---
>   drivers/media/test-drivers/vivid/vivid-vid-cap.c   | 3 ---
>   drivers/media/test-drivers/vivid/vivid-vid-out.c   | 5 +----
>   8 files changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
> index ba20ea998d19..4672dc5e52bb 100644
> --- a/drivers/media/test-drivers/visl/visl-dec.c
> +++ b/drivers/media/test-drivers/visl/visl-dec.c
> @@ -287,7 +287,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>   	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>   
>   	len = 0;
> -	for (i = 0; i < out_q->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(out_q); i++) {
>   		char entry[] = "index: %u, state: %s, request_fd: %d, ";
>   		u32 old_len = len;
>   		struct vb2_buffer *vb2;
> @@ -347,7 +347,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>   	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
>   
>   	len = 0;
> -	for (i = 0; i < cap_q->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(cap_q); i++) {
>   		u32 old_len = len;
>   		struct vb2_buffer *vb2;
>   		char *q_status;
> diff --git a/drivers/media/test-drivers/vivid/vivid-meta-cap.c b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
> index 780f96860a6d..0a718d037e59 100644
> --- a/drivers/media/test-drivers/vivid/vivid-meta-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
> @@ -30,9 +30,6 @@ static int meta_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
>   		sizes[0] = size;
>   	}
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> -
>   	*nplanes = 1;
>   	return 0;
>   }
> diff --git a/drivers/media/test-drivers/vivid/vivid-meta-out.c b/drivers/media/test-drivers/vivid/vivid-meta-out.c
> index 95835b52b58f..4a569a6e58be 100644
> --- a/drivers/media/test-drivers/vivid/vivid-meta-out.c
> +++ b/drivers/media/test-drivers/vivid/vivid-meta-out.c
> @@ -18,6 +18,7 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
>   				struct device *alloc_devs[])
>   {
>   	struct vivid_dev *dev = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>   	unsigned int size =  sizeof(struct vivid_meta_out_buf);
>   
>   	if (!vivid_is_webcam(dev))
> @@ -30,8 +31,8 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
>   		sizes[0] = size;
>   	}
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 2)
> +		*nbuffers = 2 - q_num_bufs;
>   
>   	*nplanes = 1;
>   	return 0;
> diff --git a/drivers/media/test-drivers/vivid/vivid-touch-cap.c b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
> index c7f6e23df51e..4b3c6ea0afde 100644
> --- a/drivers/media/test-drivers/vivid/vivid-touch-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
> @@ -13,6 +13,7 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
>   				 struct device *alloc_devs[])
>   {
>   	struct vivid_dev *dev = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>   	struct v4l2_pix_format *f = &dev->tch_format;
>   	unsigned int size = f->sizeimage;
>   
> @@ -23,8 +24,8 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
>   		sizes[0] = size;
>   	}
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 2)
> +		*nbuffers = 2 - q_num_bufs;
>   
>   	*nplanes = 1;
>   	return 0;
> diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-cap.c b/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
> index b65b02eeeb97..3840b3a664ac 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
> @@ -134,9 +134,6 @@ static int vbi_cap_queue_setup(struct vb2_queue *vq,
>   
>   	sizes[0] = size;
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> -
>   	*nplanes = 1;
>   	return 0;
>   }
> diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-out.c b/drivers/media/test-drivers/vivid/vivid-vbi-out.c
> index cd56476902a2..434a10676417 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vbi-out.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vbi-out.c
> @@ -30,9 +30,6 @@ static int vbi_out_queue_setup(struct vb2_queue *vq,
>   
>   	sizes[0] = size;
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> -
>   	*nplanes = 1;
>   	return 0;
>   }
> diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> index 3a06df35a2d7..2804975fe278 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
> @@ -117,9 +117,6 @@ static int vid_cap_queue_setup(struct vb2_queue *vq,
>   					dev->fmt_cap->data_offset[p];
>   	}
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> -
>   	*nplanes = buffers;
>   
>   	dprintk(dev, 1, "%s: count=%d\n", __func__, *nbuffers);
> diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
> index 184a6df2c29f..24c6dc896255 100644
> --- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
> +++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
> @@ -73,12 +73,9 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
>   				       vfmt->data_offset[p] : size;
>   	}
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> -
>   	*nplanes = planes;
>   
> -	dprintk(dev, 1, "%s: count=%d\n", __func__, *nbuffers);
> +	dprintk(dev, 1, "%s: count=%u\n", __func__, vb2_get_num_buffers(vq));

I assume it can be guaranteed that *nbuffers equals vb2_get_num_buffers(vq),
because  q->min_buffers_needed is set for this queue?

Can you make it consistent with vid_cap_queue_setup() either by removing this
change to dprintk() or introducing a similar one in vid_cap_queue_setup()?

Regards,

Andrzej

>   	for (p = 0; p < planes; p++)
>   		dprintk(dev, 1, "%s: size[%u]=%u\n", __func__, p, sizes[p]);
>   	return 0;

