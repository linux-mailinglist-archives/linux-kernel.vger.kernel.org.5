Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3771D78E01B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbjH3TH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbjH3Nxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02BE8;
        Wed, 30 Aug 2023 06:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35781611DD;
        Wed, 30 Aug 2023 13:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B49C433C8;
        Wed, 30 Aug 2023 13:53:30 +0000 (UTC)
Message-ID: <8ee883bf-f8f8-29cb-c034-13bd142fe9f8@xs4all.nl>
Date:   Wed, 30 Aug 2023 15:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 10/10] media: v4l2: Add mem2mem helpers for DELETE_BUFS
 ioctl
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
References: <20230824092133.39510-1-benjamin.gaignard@collabora.com>
 <20230824092133.39510-11-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230824092133.39510-11-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 11:21, Benjamin Gaignard wrote:
> Create v4l2-mem2mem helpers for VIDIOC_DELETE_BUFS ioctl.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/platform/verisilicon/hantro_v4l2.c  |  1 +
>  drivers/media/test-drivers/vim2m.c            |  1 +
>  drivers/media/v4l2-core/v4l2-mem2mem.c        | 20 +++++++++++++++++++
>  include/media/v4l2-mem2mem.h                  | 12 +++++++++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index 27a1e77cca38..0fd1c2fc78c8 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>  	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
> index 3e3b424b4860..3014b8ee13d0 100644
> --- a/drivers/media/test-drivers/vim2m.c
> +++ b/drivers/media/test-drivers/vim2m.c
> @@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
>  	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_delete_buf	= v4l2_m2m_ioctl_delete_buf,

I suspect you didn't enable vim2m in your kernel config, since this
should be:

	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,

>  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 0cc30397fbad..d1d59943680f 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -831,6 +831,17 @@ int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_prepare_buf);
>  
> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> +			 struct v4l2_delete_buffers *d)
> +{
> +	struct vb2_queue *vq;
> +
> +	vq = v4l2_m2m_get_vq(m2m_ctx, d->type);
> +
> +	return vb2_delete_bufs(vq, d);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_delete_bufs);
> +
>  int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  			 struct v4l2_create_buffers *create)
>  {
> @@ -1377,6 +1388,15 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
>  
> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
> +			       struct v4l2_delete_buffers *d)
> +{
> +	struct v4l2_fh *fh = file->private_data;
> +
> +	return v4l2_m2m_delete_bufs(file, fh->m2m_ctx, d);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_delete_bufs);
> +
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
>  				struct v4l2_buffer *buf)
>  {
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index d6c8eb2b5201..161f85c42dc8 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -381,6 +381,16 @@ int v4l2_m2m_dqbuf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  int v4l2_m2m_prepare_buf(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>  			 struct v4l2_buffer *buf);
>  
> +/**
> + * v4l2_m2m_delete_bufs() - delete buffers from the queue
> + *
> + * @file: pointer to struct &file
> + * @m2m_ctx: m2m context assigned to the instance given by struct &v4l2_m2m_ctx
> + * @d: pointer to struct &v4l2_delete_buffers
> + */
> +int v4l2_m2m_delete_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
> +			 struct v4l2_delete_buffers *d);
> +
>  /**
>   * v4l2_m2m_create_bufs() - create a source or destination buffer, depending
>   * on the type
> @@ -860,6 +870,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
>  				struct v4l2_requestbuffers *rb);
>  int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
>  				struct v4l2_create_buffers *create);
> +int v4l2_m2m_ioctl_delete_bufs(struct file *file, void *priv,
> +			       struct v4l2_delete_buffers *d);
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
>  				struct v4l2_buffer *buf);
>  int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,

Regards,

	Hans
