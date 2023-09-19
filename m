Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830DB7A674A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjISOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjISOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC1BC;
        Tue, 19 Sep 2023 07:50:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD8C433C8;
        Tue, 19 Sep 2023 14:50:14 +0000 (UTC)
Message-ID: <bc908b9e-00a8-4e62-8391-36da7b401d3d@xs4all.nl>
Date:   Tue, 19 Sep 2023 16:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/49] media: core: Rework how create_buf index
 returned value is computed
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
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-21-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-21-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 15:32, Benjamin Gaignard wrote:
> When DELETE_BUFS will be introduced holes could created in bufs array.

could -> can be

> To be able to reuse these unused indices reworking how create->index
> is set is mandatory.
> Let __vb2_queue_alloc() decide which first index is correct and
> forward this to the caller.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 24 +++++++++++++------
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 17 +++++++------
>  include/media/videobuf2-core.h                |  4 +++-
>  3 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 70b6b8f8c390..a4c2fae8705d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -443,15 +443,24 @@ static void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			     unsigned int num_buffers, unsigned int num_planes,
> -			     const unsigned plane_sizes[VB2_MAX_PLANES])
> +			     const unsigned plane_sizes[VB2_MAX_PLANES],
> +			     unsigned int *first)

I would rename 'first' to 'first_index',

>  {
>  	unsigned int buffer, plane;
>  	struct vb2_buffer *vb;
> +	unsigned long first_index;

and this to just plain 'index'.

>  	int ret;
>  
>  	/* Ensure that q->num_buffers+num_buffers is below q->max_allowed_buffers */
>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    q->max_allowed_buffers - q->num_buffers);
> +			    q->max_allowed_buffers - vb2_get_num_buffers(q));
> +
> +	first_index = vb2_get_num_buffers(q);
> +
> +	if (first_index >= q->max_allowed_buffers)
> +		return 0;

I don't think this can ever happen, drop this check.

> +
> +	*first = first_index;
>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -472,7 +481,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  		}
>  		call_void_bufop(q, init_buffer, vb);
>  
> -		if (!vb2_queue_add_buffer(q, vb, q->num_buffers + buffer)) {
> +		if (!vb2_queue_add_buffer(q, vb, first_index++)) {

The reason for renaming is that seeing 'first_index++' here is really weird.
But 'index++' makes sense.

>  			dprintk(q, 1, "failed adding buffer %d to queue\n", buffer);
>  			kfree(vb);
>  			break;
> @@ -832,7 +841,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned int q_num_bufs = vb2_get_num_buffers(q);
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
> -	unsigned int i;
> +	unsigned int i, first;

Rename to first_index as well.

>  	int ret = 0;
>  
>  	if (q->streaming) {
> @@ -919,7 +928,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	/* Finally, allocate buffers and video memory */
>  	allocated_buffers =
> -		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
> +		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first);
>  	if (allocated_buffers == 0) {
>  		dprintk(q, 1, "memory allocation failed\n");
>  		ret = -ENOMEM;
> @@ -993,7 +1002,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>  int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			 unsigned int flags, unsigned int *count,
>  			 unsigned int requested_planes,
> -			 const unsigned int requested_sizes[])
> +			 const unsigned int requested_sizes[],
> +			 unsigned int *first)

first_index

>  {
>  	unsigned int num_planes = 0, num_buffers, allocated_buffers;
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
> @@ -1055,7 +1065,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	/* Finally, allocate buffers and video memory */
>  	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
> -				num_planes, plane_sizes);
> +				num_planes, plane_sizes, first);
>  	if (allocated_buffers == 0) {
>  		dprintk(q, 1, "memory allocation failed\n");
>  		ret = -ENOMEM;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 3eb707abc26b..a88abcea2921 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -762,7 +762,6 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>  
>  	fill_buf_caps(q, &create->capabilities);
>  	validate_memory_flags(q, create->memory, &create->flags);
> -	create->index = q->num_buffers;

I don't think this can be dropped. If create->count == 0, then this should
be the current number of created buffers according to the spec.

>  	if (create->count == 0)
>  		return ret != -EBUSY ? ret : 0;
>  
> @@ -804,11 +803,16 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
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
> +	ret = vb2_core_create_bufs(q, create->memory,
> +				   create->flags,
> +				   &create->count,
> +				   requested_planes,
> +				   requested_sizes,
> +				   &create->index);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vb2_create_bufs);
>  
> @@ -1036,7 +1040,6 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
>  	int res = vb2_verify_memory_type(vdev->queue, p->memory,
>  			p->format.type);
>  
> -	p->index = vdev->queue->num_buffers;

Ditto.

>  	fill_buf_caps(vdev->queue, &p->capabilities);
>  	validate_memory_flags(vdev->queue, p->memory, &p->flags);
>  	/*
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 1ecaf4b5a76f..19c93d8eb7c8 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -803,6 +803,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>   * @count: requested buffer count.
>   * @requested_planes: number of planes requested.
>   * @requested_sizes: array with the size of the planes.
> + * @first: index of the first created buffer

Not quite true: it is the index of the first created buffer, and
all allocated buffers have indices in the range [first..first+count)

Or something along those lines.

>   *
>   * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
>   * called internally by VB2 by an API-specific handler, like
> @@ -819,7 +820,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			 unsigned int flags, unsigned int *count,
>  			 unsigned int requested_planes,
> -			 const unsigned int requested_sizes[]);
> +			 const unsigned int requested_sizes[],
> +			 unsigned int *first);
>  
>  /**
>   * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace

Regards,

	Hans
