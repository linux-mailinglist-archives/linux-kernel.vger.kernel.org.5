Return-Path: <linux-kernel+bounces-110108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B85885A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34411C214CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AC84A5A;
	Thu, 21 Mar 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIk4gRGx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707C684A4E;
	Thu, 21 Mar 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028998; cv=none; b=TcgJdDQcONcztISMrdEu5QTs+x+o7KdGFw43lsbwe/NvFQS7dHjlKmnLR58+LRh38x2QFGRBQ/bOveJpzTmvhS4IG+32Lf0wWNfZETFZCD0liOPYg8EkQZjn5a6boXSsMgbryjtCgowdAlVIpvLJ+bn1Zh2o2uotlsFefhoL8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028998; c=relaxed/simple;
	bh=SnT+trnOBIgAFkauK2EJaaxNT18qG8zwDsEmbwHz2AM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KT6buRtZCHKgaevtdDmu6hlikS0ytTvw/6g8fxdJVEOlyWBkhNCRF1Gs08+FDFS98lLgEzKyBPL3igeteKHaf0D6IBnVnEA1nEBPFDTgykk3JqigolZ/EwhVDgiTtCNyGyivbpbd3/UHOu0UGLuD0zHbJq8ImEkETpaChC2ZpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIk4gRGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E471CC433F1;
	Thu, 21 Mar 2024 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028998;
	bh=SnT+trnOBIgAFkauK2EJaaxNT18qG8zwDsEmbwHz2AM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIk4gRGxGxuB0x7UWZqPKMUDZb+S0UZr3oI2rzKyebKATj6NbvEHzGfG7G6hAKGJb
	 2NGOGrOrrptzH8Usy/P7BSCippt8KendICagbmwtw88RKYD5P88WwFHqUiSE5OuiRx
	 npsvSICctvPB/GbalRrxJVngfzwigvQum0wucaYi3uMY+zrp3Bw0Atpd/BWkAm/8/K
	 DbfOj3fqzxmhnGSaXUNUi8aLNA8G+t01acvH+NEnraLLfDBLs7X+bX6IThYp/6IeEv
	 aVtrpWoTsLfqe2RcQnves32RsgS8ZSrzmt9LoBmax8miFKjDZC7y5ZzNIpwEy0bTw3
	 c3EbnC0TWyBFw==
Date: Thu, 21 Mar 2024 14:49:52 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v21 1/9] media: videobuf2: Update vb2_is_busy() logic
Message-ID: <20240321144952.5effcb82@coco.lan>
In-Reply-To: <20240314153226.197445-2-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
	<20240314153226.197445-2-benjamin.gaignard@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Mar 2024 16:32:18 +0100
Benjamin Gaignard <benjamin.gaignard@collabora.com> escreveu:

> Do not rely on the number of allocated buffers to know if the
> queue is busy but on a flag set when at least one buffer has been allocated
> by REQBUFS or CREATE_BUFS ioctl.
> The flag is reset when REQBUFS is called with count = 0 or the file
> handle is closed.
> This is needed because remove buffers feature will be able to remove
> all the buffers from a queue while streaming so relying on the number
> of allocated buffers in the queue won't be possible.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
>  include/media/videobuf2-core.h                  | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index b6bf8f232f48..d8b3c04cb3b5 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -854,6 +854,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		__vb2_queue_free(q, q_num_bufs);
>  		mutex_unlock(&q->mmap_lock);
>  
> +		q->is_busy = 0;
>  		/*
>  		 * In case of REQBUFS(0) return immediately without calling
>  		 * driver's queue_setup() callback and allocating resources.
> @@ -966,6 +967,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 */
>  	*count = allocated_buffers;
>  	q->waiting_for_buffers = !q->is_output;
> +	q->is_busy = 1;
>  
>  	return 0;
>  
> @@ -1091,6 +1093,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * to the userspace.
>  	 */
>  	*count = allocated_buffers;
> +	q->is_busy = 1;
>  
>  	return 0;
>  
> @@ -2555,6 +2558,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_free(q, vb2_get_num_buffers(q));
>  	kfree(q->bufs);
>  	q->bufs = NULL;
> +	q->is_busy = 0;
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 8b86996b2719..667bf9ee1101 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -582,6 +582,7 @@ struct vb2_buf_ops {
>   *		released. Used to prevent destroying the queue by other threads.
>   * @is_multiplanar: set if buffer type is multiplanar
>   * @is_output:	set if buffer type is output
> + * @is_busy:	set if at least one buffer has been allocated at some time.
>   * @copy_timestamp: set if vb2-core should set timestamps
>   * @last_buffer_dequeued: used in poll() and DQBUF to immediately return if the
>   *		last decoded buffer was already dequeued. Set for capture queues
> @@ -647,6 +648,7 @@ struct vb2_queue {
>  	unsigned int			waiting_in_dqbuf:1;
>  	unsigned int			is_multiplanar:1;
>  	unsigned int			is_output:1;
> +	unsigned int			is_busy:1;
>  	unsigned int			copy_timestamp:1;
>  	unsigned int			last_buffer_dequeued:1;
>  
> @@ -1166,7 +1168,7 @@ static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>   */
>  static inline bool vb2_is_busy(struct vb2_queue *q)
>  {
> -	return vb2_get_num_buffers(q) > 0;
> +	return !!q->is_busy;
>  }
>  
>  /**



Thanks,
Mauro

