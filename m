Return-Path: <linux-kernel+bounces-103214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65087BC76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4D9284968
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833126F50A;
	Thu, 14 Mar 2024 12:04:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C26F074;
	Thu, 14 Mar 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417880; cv=none; b=nrgdKpdfDqJZLPtTPNWPBako4ngM4Dv3bD8eS7jYnQobPYZaVvDLCfaMntd35AOMPjE+QQfJaS/90xXWdjci12EfgckFZQSZVBQP3yyqZakr5PHDTtJVm8JsL+9GcHoFmtcv3em+kg0/4WoTujQYWdvd3Y8ljIyP+IYvk8CdEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417880; c=relaxed/simple;
	bh=cONaQ7d7Q2GLBQPyhquHIdTOVLFCZyNi9PQTrGVS8Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOIatDrPncCp19r6c+7Uv0g5rrGMJ8bSKduknmkgI78ORC6ImOqEEsi1uuWZoQ9d7a8+bMFCGYa1ZAduzDZr6tZfGpVjhvEB976/tDhgim1QBsEjAmJM+OltRyiwEpI2TtmOioxRV/5jRq6msxtArbPi9PiVsXLSuEDUupSa/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331BEC43390;
	Thu, 14 Mar 2024 12:04:37 +0000 (UTC)
Message-ID: <d0cf027e-9793-4e56-80ed-6260c2d05af8@xs4all.nl>
Date: Thu, 14 Mar 2024 13:04:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 8/9] media: v4l2: Add mem2mem helpers for REMOVE_BUFS
 ioctl
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org,
 tfiga@chromium.org, m.szyprowski@samsung.com, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20240221155435.100093-1-benjamin.gaignard@collabora.com>
 <20240221155435.100093-9-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240221155435.100093-9-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 4:54 pm, Benjamin Gaignard wrote:
> Create v4l2-mem2mem helpers for VIDIOC_REMOVE_BUFS ioctl and
> make test drivers use it.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/test-drivers/vicodec/vicodec-core.c |  1 +
>  drivers/media/test-drivers/vim2m.c                |  1 +
>  drivers/media/test-drivers/vimc/vimc-capture.c    |  1 +
>  drivers/media/test-drivers/visl/visl-video.c      |  1 +
>  drivers/media/test-drivers/vivid/vivid-core.c     |  1 +
>  drivers/media/v4l2-core/v4l2-mem2mem.c            | 10 ++++++++++
>  include/media/v4l2-mem2mem.h                      |  2 ++
>  7 files changed, 17 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
> index e13f5452b927..3e011fe62ae1 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1345,6 +1345,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
>  	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
>  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
> +	.vidioc_remove_bufs	= v4l2_m2m_ioctl_remove_bufs,
>  
>  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
>  	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
> index 3e3b424b4860..14aff4ad576b 100644
> --- a/drivers/media/test-drivers/vim2m.c
> +++ b/drivers/media/test-drivers/vim2m.c
> @@ -960,6 +960,7 @@ static const struct v4l2_ioctl_ops vim2m_ioctl_ops = {
>  	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
>  	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_remove_bufs	= v4l2_m2m_ioctl_remove_bufs,
>  	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>  
>  	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
> diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
> index 97693561f1e4..ba7550b8ba7e 100644
> --- a/drivers/media/test-drivers/vimc/vimc-capture.c
> +++ b/drivers/media/test-drivers/vimc/vimc-capture.c
> @@ -221,6 +221,7 @@ static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
>  	.vidioc_expbuf = vb2_ioctl_expbuf,
>  	.vidioc_streamon = vb2_ioctl_streamon,
>  	.vidioc_streamoff = vb2_ioctl_streamoff,
> +	.vidioc_remove_bufs = vb2_ioctl_remove_bufs,
>  };
>  
>  static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
> diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
> index b9a4b44bd0ed..f8d970319764 100644
> --- a/drivers/media/test-drivers/visl/visl-video.c
> +++ b/drivers/media/test-drivers/visl/visl-video.c
> @@ -539,6 +539,7 @@ const struct v4l2_ioctl_ops visl_ioctl_ops = {
>  	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
>  	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
>  	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
> +	.vidioc_remove_bufs		= v4l2_m2m_ioctl_remove_bufs,
>  
>  	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
>  	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 11b8520d9f57..771392f67dda 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -769,6 +769,7 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
>  	.vidioc_expbuf			= vb2_ioctl_expbuf,
>  	.vidioc_streamon		= vb2_ioctl_streamon,
>  	.vidioc_streamoff		= vb2_ioctl_streamoff,
> +	.vidioc_remove_bufs		= vb2_ioctl_remove_bufs,
>  
>  	.vidioc_enum_input		= vivid_enum_input,
>  	.vidioc_g_input			= vivid_g_input,
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index 75517134a5e9..ba21c60f1ed3 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -1386,6 +1386,16 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
>  
> +int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
> +			       struct v4l2_remove_buffers *remove)
> +{
> +	struct v4l2_fh *fh = file->private_data;
> +

Check if remove->type matches the type of the vb2_queue and return
-EINVAL if it isn't.

Regards,

	Hans

> +	return vb2_core_remove_bufs(v4l2_m2m_get_vq(fh->m2m_ctx, remove->type),
> +				    remove->index, remove->count);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_remove_bufs);
> +
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *priv,
>  				struct v4l2_buffer *buf)
>  {
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index 7f1af1f7f912..0af330cf91c3 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -867,6 +867,8 @@ int v4l2_m2m_ioctl_reqbufs(struct file *file, void *priv,
>  				struct v4l2_requestbuffers *rb);
>  int v4l2_m2m_ioctl_create_bufs(struct file *file, void *fh,
>  				struct v4l2_create_buffers *create);
> +int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
> +			       struct v4l2_remove_buffers *d);
>  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
>  				struct v4l2_buffer *buf);
>  int v4l2_m2m_ioctl_expbuf(struct file *file, void *fh,

Regards,

	Hans

