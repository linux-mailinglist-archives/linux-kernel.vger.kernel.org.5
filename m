Return-Path: <linux-kernel+bounces-110132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC6885A77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71895B20C47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59384FDC;
	Thu, 21 Mar 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9LSOP0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B794134CD;
	Thu, 21 Mar 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030551; cv=none; b=sheSzR08NI57weeQ/QABcLosfTYH/VxoNZ/CDImjTBR3vEjoApYGj4x4SoZSQnIscXTL8roRlYUgcUDcDBFjcSz4ggIp/vmQzXAOdWfE/1Rpjynah5znijGuzqFJAS6I+5qZlYje2YadqmEd6C6DG6ITYr9msYMHCQJNpe2kxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030551; c=relaxed/simple;
	bh=L3lq+ETcf12qcpdKNu6RlHZekLNVMxMcPuLI5QDjXpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtY3iZyeSl9sDyh1WHLFgdbC2WN+0H+nGqwAKakDEW+Cvfzk4VLJZypaYdQw+MgbMN7gb9TpOcbqBfYM0PwoKrdte06qV8uqQ0+7xn3IEfDn2j9prQdciEDbKaxf7U70io0hl/N34vQQe86o/bRLzo8rWcdGZYLEozASeqMh3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9LSOP0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A446C433F1;
	Thu, 21 Mar 2024 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711030550;
	bh=L3lq+ETcf12qcpdKNu6RlHZekLNVMxMcPuLI5QDjXpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9LSOP0fxK6fVeoW1AQdVTEDyXQupwYUXQdlY6cKjI9o2JSNYNufTw67NgTY+W4vv
	 riOZwrCUanyvg7+1DFFouMwu6RTtf5YBfjpzeK/zmOGJ/TZMxuk64iSWz1ELHkP7UA
	 d2fpxTSCVLBJPzptWu5fA+9NF7BcLvaWBmJa0BVDRthC3juUMXXydhT8FRfBWwc1PA
	 LjfNxatT0HLUo6g0vF4zJZPLZqi4vfwV0rqK+sdhFGGu1mnPsWrpdDOT6aB3tfXeyN
	 wYB579kVGD1Pbe3cqr0miJrFl31Vf5Ju27GATEZsaIkOwvu7Sp9AaSpYiqQiyQKHKm
	 slWQSNTho/0CQ==
Date: Thu, 21 Mar 2024 15:15:45 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v21 8/9] media: v4l2: Add mem2mem helpers for
 REMOVE_BUFS ioctl
Message-ID: <20240321151545.0e293d3e@coco.lan>
In-Reply-To: <20240314153226.197445-9-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
	<20240314153226.197445-9-benjamin.gaignard@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Mar 2024 16:32:25 +0100
Benjamin Gaignard <benjamin.gaignard@collabora.com> escreveu:

> Create v4l2-mem2mem helpers for VIDIOC_REMOVE_BUFS ioctl and
> make test drivers use it.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
> changes in version 21:
> - In v4l2_m2m_ioctl_remove_bufs() check if the queue exists and
>   if it type macth request type.
> - Do not set vidioc_remove_bufs for vim2m driver.
> 
>  drivers/media/test-drivers/vicodec/vicodec-core.c |  1 +
>  drivers/media/test-drivers/vimc/vimc-capture.c    |  1 +
>  drivers/media/test-drivers/visl/visl-video.c      |  1 +
>  drivers/media/test-drivers/vivid/vivid-core.c     |  1 +
>  drivers/media/v4l2-core/v4l2-mem2mem.c            | 15 +++++++++++++++
>  include/media/v4l2-mem2mem.h                      |  2 ++
>  6 files changed, 21 insertions(+)
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
> index 75517134a5e9..eb22d6172462 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -1386,6 +1386,21 @@ int v4l2_m2m_ioctl_create_bufs(struct file *file, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_ioctl_create_bufs);
>  
> +int v4l2_m2m_ioctl_remove_bufs(struct file *file, void *priv,
> +			       struct v4l2_remove_buffers *remove)
> +{
> +	struct v4l2_fh *fh = file->private_data;
> +	struct vb2_queue *q = v4l2_m2m_get_vq(fh->m2m_ctx, remove->type);
> +
> +	if (!q)
> +		return -EINVAL;
> +	if (q->type != remove->type)
> +		return -EINVAL;
> +
> +	return vb2_core_remove_bufs(q, remove->index, remove->count);
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



Thanks,
Mauro

