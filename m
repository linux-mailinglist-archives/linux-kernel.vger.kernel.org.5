Return-Path: <linux-kernel+bounces-36845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0B83A7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CBC284A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF691B28D;
	Wed, 24 Jan 2024 11:20:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9231AACD;
	Wed, 24 Jan 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095245; cv=none; b=j1cMJrZyqNXeYKYNKbkPXohEQeMaFET+kfTn4hUMmHU8wlol8IY641mhI56Cmoro7NNCOlk9GkIf+mV0Rai5O5rwYfL1yDAuxZ0l1ZPVPmRgf5Oc17T2qaaRxGQGjY+m/NWOD8QFqMYCBCJBkdo/Q2it2ZFlvW6gSEPe1LU4gP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095245; c=relaxed/simple;
	bh=7tAlxSEo3LUrd1O1N9kYVj4VPR1cODaPUHsVy/v33Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FboG3saepplJGp16Rql6Gyx/3Tqyg/WUSPf+Dave3ZcCrKgIGEgAdyfpU01UQjWlcPRYf1sjM915xClwq2yL1Bn9VdLpKQenBCDX4MuEiCj+ODCDN0jjY3/0gV5wq5Q3rq3jhEkk3csOrRaHqucaXpF2Ls7BRyPoL6PcIl8OIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D01C433B1;
	Wed, 24 Jan 2024 11:20:43 +0000 (UTC)
Message-ID: <5a0451f9-4d44-4389-b66e-00053f6ea1ee@xs4all.nl>
Date: Wed, 24 Jan 2024 12:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/8] media: core: Rework how create_buf index returned
 value is computed
Content-Language: en-US, nl
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-4-benjamin.gaignard@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20240119094944.26763-4-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 10:49, Benjamin Gaignard wrote:
> When DELETE_BUFS will be introduced holes could created in bufs array.
> To be able to reuse these unused indices reworking how create->index
> is set is mandatory.
> Let __vb2_queue_alloc() decide which first index is correct and
> forward this to the caller.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 17:
> - rework documentation
>  .../media/common/videobuf2/videobuf2-core.c    | 18 +++++++++++++-----
>  .../media/common/videobuf2/videobuf2-v4l2.c    | 14 +++++++++-----
>  include/media/videobuf2-core.h                 |  5 ++++-
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index d74e93d00f58..fd5ac2845018 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -442,12 +442,15 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>   * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
>   * video buffer memory for all buffers/planes on the queue and initializes the
>   * queue
> + * @first_index: index of the first created buffer, all allocated buffers have

allocated -> newly allocated

> + *		 indices in the range [first..first+count]

That should be: [first_index..first_index+count-1]

>   *
>   * Returns the number of buffers successfully allocated.
>   */
>  static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			     unsigned int num_buffers, unsigned int num_planes,
> -			     const unsigned plane_sizes[VB2_MAX_PLANES])
> +			     const unsigned int plane_sizes[VB2_MAX_PLANES],
> +			     unsigned int *first_index)
>  {
>  	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>  	unsigned int buffer, plane;
> @@ -461,6 +464,8 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	num_buffers = min_t(unsigned int, num_buffers,
>  			    q->max_num_buffers - q_num_buffers);
>  
> +	*first_index = q_num_buffers;
> +
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
>  		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
> @@ -820,7 +825,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned int q_num_bufs = vb2_get_num_buffers(q);
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
> -	unsigned int i;
> +	unsigned int i, first_index;
>  	int ret = 0;
>  
>  	if (q->streaming) {
> @@ -906,8 +911,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	/* Finally, allocate buffers and video memory */
>  	allocated_buffers =
> -		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
> +		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first_index);
>  	if (allocated_buffers == 0) {
> +		/* There shouldn't be any buffers allocated, so first_index == 0 */
> +		WARN_ON(first_index);
>  		dprintk(q, 1, "memory allocation failed\n");
>  		ret = -ENOMEM;
>  		goto error;
> @@ -980,7 +987,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>  int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			 unsigned int flags, unsigned int *count,
>  			 unsigned int requested_planes,
> -			 const unsigned int requested_sizes[])
> +			 const unsigned int requested_sizes[],
> +			 unsigned int *first_index)
>  {
>  	unsigned int num_planes = 0, num_buffers, allocated_buffers;
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
> @@ -1042,7 +1050,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	/* Finally, allocate buffers and video memory */
>  	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
> -				num_planes, plane_sizes);
> +				num_planes, plane_sizes, first_index);
>  	if (allocated_buffers == 0) {
>  		dprintk(q, 1, "memory allocation failed\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index c575198e8354..03e8080a68a8 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -795,11 +795,15 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>  	for (i = 0; i < requested_planes; i++)
>  		if (requested_sizes[i] == 0)
>  			return -EINVAL;
> -	return ret ? ret : vb2_core_create_bufs(q, create->memory,
> -						create->flags,
> -						&create->count,
> -						requested_planes,
> -						requested_sizes);
> +	if (ret)
> +		return ret;
> +
> +	return vb2_core_create_bufs(q, create->memory,
> +				    create->flags,
> +				    &create->count,
> +				    requested_planes,
> +				    requested_sizes,
> +				    &create->index);
>  }
>  EXPORT_SYMBOL_GPL(vb2_create_bufs);
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index fe3423ff3807..e29ff77814d3 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -821,6 +821,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>   * @count: requested buffer count.
>   * @requested_planes: number of planes requested.
>   * @requested_sizes: array with the size of the planes.
> + * @first_index: index of the first created buffer, all allocated buffers have
> + *		 indices in the range [first..first+count]

Same changes needed as in the source comments.

>   *
>   * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
>   * called internally by VB2 by an API-specific handler, like
> @@ -837,7 +839,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			 unsigned int flags, unsigned int *count,
>  			 unsigned int requested_planes,
> -			 const unsigned int requested_sizes[]);
> +			 const unsigned int requested_sizes[],
> +			 unsigned int *first_index);
>  
>  /**
>   * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace

Regards,

	Hans

