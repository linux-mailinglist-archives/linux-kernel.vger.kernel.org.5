Return-Path: <linux-kernel+bounces-110139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD3885A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B341F22579
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09585934;
	Thu, 21 Mar 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZMnogwr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37085280;
	Thu, 21 Mar 2024 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030710; cv=none; b=dawlhkjKFgPINNrqbu1bbSl86FQL0GIPI7HiSy1WIs3ylWDD3USrg1ma5L360d41JXFNQ2jM/BRGdLsMjmDk+9sC6iA6f6FU+DYv0NUR2GITTBf2i/YnTdA2BBLA1TmgZr/ztBY00GaS7DAnIv0LKfWYfGMgKHLdJ6LPiIQ04W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030710; c=relaxed/simple;
	bh=SDO7qPP6ZsNzqu78xYUr1l3JsU+PyDTyhVPo9sOmhuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJaSSgsDYfCwFul0ba9U9I4BFN0piiRIrrKOqPjDoNNkRnCrqzVsRjoaqfm+XFGiXhxHxgJcaWNXalcbSnvc5UJqn8YZGxNjvrRz7k9K4MTPMuNVTVgmp80Ql4bJbPspZf9XpO135Iykae5OJQojJ9QBM72AwyUw0BHN75Al1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZMnogwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFD5C433F1;
	Thu, 21 Mar 2024 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711030710;
	bh=SDO7qPP6ZsNzqu78xYUr1l3JsU+PyDTyhVPo9sOmhuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qZMnogwrs/CBKkTDRs5jxlpA647IAtVFh47Bxb8j+wLJuAraTPgSiVLnM0dG+KjgS
	 EYoKzKtBsP5ryZ+Sic50I/lVCZp+83FMKdVVq8Wd8ZGZddkS7vMmy0DPOGgclllci7
	 rpt/5+3ZFBiJC5FAD24Q/AjX23sV/xKVUOxQmdjUEQHh8pnQZSMYMF7fJK+sXLSBcR
	 2wFBLFFJKIPXNLl6HtqsU+TJViCXvtev3uik+juVxO+oHrFsiJZZiexGs6reqNPRRI
	 Sp6sT3jYw9GxWPFB+2xG09ODDndkB9HCmFDrDuCiglAdQlq1ZUxmOOEB1dyijlecNY
	 W+vDZde09zHww==
Date: Thu, 21 Mar 2024 15:18:24 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v21 6/9] media: core: Free range of buffers
Message-ID: <20240321151824.282798de@coco.lan>
In-Reply-To: <20240314153226.197445-7-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
	<20240314153226.197445-7-benjamin.gaignard@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Mar 2024 16:32:23 +0100
Benjamin Gaignard <benjamin.gaignard@collabora.com> escreveu:

> Improve __vb2_queue_free() and __vb2_free_mem() to free
> range of buffers and not only the last few buffers.
> Introduce starting index to be flexible on range and change the loops
> according to this parameter.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Patches 4-6 require some testing and better check.

I'm ok with the general concept of such changes, so:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 56 +++++++++----------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index ec81426d4d79..009cea95d662 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -540,17 +540,16 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  }
>  
>  /*
> - * __vb2_free_mem() - release all video buffer memory for a given queue
> + * __vb2_free_mem() - release video buffer memory for a given range of
> + * buffers in a given queue
>   */
> -static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> +	unsigned int i;
>  	struct vb2_buffer *vb;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>  
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;
>  
> @@ -565,35 +564,33 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  }
>  
>  /*
> - * __vb2_queue_free() - free buffers at the end of the queue - video memory and
> + * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
>   * related information, if no buffers are left return the queue to an
>   * uninitialized state. Might be called even if the queue has already been freed.
>   */
> -static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
> +	unsigned int i;
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
>  	/* Call driver-provided cleanup function for each buffer, if provided */
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (vb && vb->planes[0].mem_priv)
>  			call_void_vb_qop(vb, buf_cleanup, vb);
>  	}
>  
>  	/* Release video buffer memory */
> -	__vb2_free_mem(q, buffers);
> +	__vb2_free_mem(q, start, count);
>  
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  	/*
>  	 * Check that all the calls were balanced during the life-time of this
>  	 * queue. If not then dump the counters to the kernel log.
>  	 */
> -	if (q_num_buffers) {
> +	if (vb2_get_num_buffers(q)) {
>  		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
>  				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
>  				  q->cnt_wait_prepare != q->cnt_wait_finish;
> @@ -619,8 +616,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		q->cnt_stop_streaming = 0;
>  		q->cnt_unprepare_streaming = 0;
>  	}
> -	for (buffer = 0; buffer < vb2_get_num_buffers(q); buffer++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  		bool unbalanced;
>  
>  		if (!vb)
> @@ -637,7 +634,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  
>  		if (unbalanced) {
>  			pr_info("unbalanced counters for queue %p, buffer %d:\n",
> -				q, buffer);
> +				q, i);
>  			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
>  				pr_info("     buf_init: %u buf_cleanup: %u\n",
>  					vb->cnt_buf_init, vb->cnt_buf_cleanup);
> @@ -671,9 +668,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #endif
>  
>  	/* Free vb2 buffers */
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (!vb)
>  			continue;
> @@ -713,7 +709,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
>  static bool __buffers_in_use(struct vb2_queue *q)
>  {
>  	unsigned int buffer;
> -	for (buffer = 0; buffer < vb2_get_num_buffers(q); ++buffer) {
> +	for (buffer = 0; buffer < q->max_num_buffers; ++buffer) {
>  		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>  
>  		if (!vb)
> @@ -899,7 +895,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * queued without ever calling STREAMON.
>  		 */
>  		__vb2_queue_cancel(q);
> -		__vb2_queue_free(q, q_num_bufs);
> +		__vb2_queue_free(q, 0, q->max_num_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  
>  		q->is_busy = 0;
> @@ -1001,7 +997,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return ret;
>  	}
> @@ -1126,7 +1122,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, *first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return -ENOMEM;
>  	}
> @@ -1741,7 +1737,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
>  		 * Forcefully reclaim buffers if the driver did not
>  		 * correctly return them to vb2.
>  		 */
> -		for (i = 0; i < vb2_get_num_buffers(q); ++i) {
> +		for (i = 0; i < q->max_num_buffers; ++i) {
>  			vb = vb2_get_buffer(q, i);
>  
>  			if (!vb)
> @@ -2147,7 +2143,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * to vb2 in stop_streaming().
>  	 */
>  	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
> -		for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +		for (i = 0; i < q->max_num_buffers; i++) {
>  			struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  			if (!vb)
> @@ -2191,7 +2187,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * call to __fill_user_buffer() after buf_finish(). That order can't
>  	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>  	 */
> -	for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +	for (i = 0; i < q->max_num_buffers; i++) {
>  		struct vb2_buffer *vb;
>  		struct media_request *req;
>  
> @@ -2618,7 +2614,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_cleanup_fileio(q);
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
> -	__vb2_queue_free(q, vb2_get_num_buffers(q));
> +	__vb2_queue_free(q, 0, q->max_num_buffers);
>  	vb2_core_free_buffers_storage(q);
>  	q->is_busy = 0;
>  	mutex_unlock(&q->mmap_lock);



Thanks,
Mauro

