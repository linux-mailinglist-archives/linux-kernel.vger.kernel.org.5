Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC7CA0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPHuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:50:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288E5A1;
        Mon, 16 Oct 2023 00:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC912C433C7;
        Mon, 16 Oct 2023 07:50:10 +0000 (UTC)
Message-ID: <6d170a34-a70b-4f0a-9c5f-47f8c036ed45@xs4all.nl>
Date:   Mon, 16 Oct 2023 09:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/56] media: videobuf2: Access vb2_queue bufs array
 through helper functions
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
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-6-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012114642.19040-6-benjamin.gaignard@collabora.com>
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

On 12/10/2023 13:45, Benjamin Gaignard wrote:
> This patch adds 2 helpers functions to add and remove vb2 buffers
> from a queue. With these 2 and vb2_get_buffer(), bufs field of
> struct vb2_queue becomes like a private member of the structure.
> 
> After each call to vb2_get_buffer() we need to be sure that we get
> a valid pointer in preparation for when buffers can be deleted.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 151 +++++++++++++-----
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  51 ++++--
>  2 files changed, 146 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 968b7c0e7934..66d0f42f5691 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -408,6 +408,31 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>  		vb->skip_cache_sync_on_finish = 1;
>  }
>  
> +/**
> + * vb2_queue_add_buffer() - add a buffer to a queue
> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> + * @vb:	pointer to &struct vb2_buffer to be added to the queue.
> + * @index: index where add vb2_buffer in the queue
> + */
> +static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
> +{
> +	WARN_ON(index >= VB2_MAX_FRAME || q->bufs[index]);
> +
> +	q->bufs[index] = vb;
> +	vb->index = index;
> +	vb->vb2_queue = q;
> +}
> +
> +/**
> + * vb2_queue_remove_buffer() - remove a buffer from a queue
> + * @vb:	pointer to &struct vb2_buffer to be removed from the queue.
> + */
> +static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
> +{
> +	vb->vb2_queue->bufs[vb->index] = NULL;
> +	vb->vb2_queue = NULL;
> +}
> +
>  /*
>   * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
>   * video buffer memory for all buffers/planes on the queue and initializes the
> @@ -436,9 +461,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  		}
>  
>  		vb->state = VB2_BUF_STATE_DEQUEUED;
> -		vb->vb2_queue = q;
>  		vb->num_planes = num_planes;
> -		vb->index = q->num_buffers + buffer;
>  		vb->type = q->type;
>  		vb->memory = memory;
>  		init_buffer_cache_hints(q, vb);
> @@ -446,9 +469,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			vb->planes[plane].length = plane_sizes[plane];
>  			vb->planes[plane].min_length = plane_sizes[plane];
>  		}
> -		call_void_bufop(q, init_buffer, vb);
>  
> -		q->bufs[vb->index] = vb;
> +		vb2_queue_add_buffer(q, vb, q->num_buffers + buffer);
> +		call_void_bufop(q, init_buffer, vb);
>  
>  		/* Allocate video buffer memory for the MMAP type */
>  		if (memory == VB2_MEMORY_MMAP) {
> @@ -456,7 +479,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			if (ret) {
>  				dprintk(q, 1, "failed allocating memory for buffer %d\n",
>  					buffer);
> -				q->bufs[vb->index] = NULL;
> +				vb2_queue_remove_buffer(vb);
>  				kfree(vb);
>  				break;
>  			}
> @@ -471,7 +494,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  				dprintk(q, 1, "buffer %d %p initialization failed\n",
>  					buffer, vb);
>  				__vb2_buf_mem_free(vb);
> -				q->bufs[vb->index] = NULL;
> +				vb2_queue_remove_buffer(vb);
>  				kfree(vb);
>  				break;
>  			}
> @@ -494,7 +517,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  
>  	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>  	     ++buffer) {
> -		vb = q->bufs[buffer];
> +		vb = vb2_get_buffer(q, buffer);
>  		if (!vb)
>  			continue;
>  
> @@ -522,7 +545,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  	/* Call driver-provided cleanup function for each buffer, if provided */
>  	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>  	     ++buffer) {
> -		struct vb2_buffer *vb = q->bufs[buffer];
> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>  
>  		if (vb && vb->planes[0].mem_priv)
>  			call_void_vb_qop(vb, buf_cleanup, vb);
> @@ -563,15 +586,20 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		q->cnt_unprepare_streaming = 0;
>  	}
>  	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> -		struct vb2_buffer *vb = q->bufs[buffer];
> -		bool unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
> -				  vb->cnt_mem_prepare != vb->cnt_mem_finish ||
> -				  vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
> -				  vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf ||
> -				  vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf ||
> -				  vb->cnt_buf_queue != vb->cnt_buf_done ||
> -				  vb->cnt_buf_prepare != vb->cnt_buf_finish ||
> -				  vb->cnt_buf_init != vb->cnt_buf_cleanup;
> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +		bool unbalanced;
> +
> +		if (!vb)
> +			continue;
> +
> +		unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
> +			     vb->cnt_mem_prepare != vb->cnt_mem_finish ||
> +			     vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
> +			     vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf ||
> +			     vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf ||
> +			     vb->cnt_buf_queue != vb->cnt_buf_done ||
> +			     vb->cnt_buf_prepare != vb->cnt_buf_finish ||
> +			     vb->cnt_buf_init != vb->cnt_buf_cleanup;
>  
>  		if (unbalanced) {
>  			pr_info("unbalanced counters for queue %p, buffer %d:\n",
> @@ -611,8 +639,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  	/* Free vb2 buffers */
>  	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>  	     ++buffer) {
> -		kfree(q->bufs[buffer]);
> -		q->bufs[buffer] = NULL;
> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +
> +		if (!vb)
> +			continue;
> +
> +		vb2_queue_remove_buffer(vb);
> +		kfree(vb);
>  	}
>  
>  	q->num_buffers -= buffers;
> @@ -648,7 +681,12 @@ static bool __buffers_in_use(struct vb2_queue *q)
>  {
>  	unsigned int buffer;
>  	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> -		if (vb2_buffer_in_use(q, q->bufs[buffer]))
> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +
> +		if (!vb)
> +			continue;
> +
> +		if (vb2_buffer_in_use(q, vb))
>  			return true;
>  	}
>  	return false;
> @@ -1633,7 +1671,11 @@ static int vb2_start_streaming(struct vb2_queue *q)
>  		 * correctly return them to vb2.
>  		 */
>  		for (i = 0; i < q->num_buffers; ++i) {
> -			vb = q->bufs[i];
> +			vb = vb2_get_buffer(q, i);
> +
> +			if (!vb)
> +				continue;
> +
>  			if (vb->state == VB2_BUF_STATE_ACTIVE)
>  				vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED);
>  		}
> @@ -2034,12 +2076,18 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * to vb2 in stop_streaming().
>  	 */
>  	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
> -		for (i = 0; i < q->num_buffers; ++i)
> -			if (q->bufs[i]->state == VB2_BUF_STATE_ACTIVE) {
> -				pr_warn("driver bug: stop_streaming operation is leaving buf %p in active state\n",
> -					q->bufs[i]);
> -				vb2_buffer_done(q->bufs[i], VB2_BUF_STATE_ERROR);
> +		for (i = 0; i < q->num_buffers; ++i) {
> +			struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +
> +			if (!vb)
> +				continue;
> +
> +			if (vb->state == VB2_BUF_STATE_ACTIVE) {
> +				pr_warn("driver bug: stop_streaming operation is leaving buffer %u in active state\n",
> +					vb->index);
> +				vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
>  			}
> +		}
>  		/* Must be zero now */
>  		WARN_ON(atomic_read(&q->owned_by_drv_count));
>  	}
> @@ -2073,9 +2121,14 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>  	 */
>  	for (i = 0; i < q->num_buffers; ++i) {
> -		struct vb2_buffer *vb = q->bufs[i];
> -		struct media_request *req = vb->req_obj.req;
> +		struct vb2_buffer *vb;
> +		struct media_request *req;
>  
> +		vb = vb2_get_buffer(q, i);
> +		if (!vb)
> +			continue;
> +
> +		req = vb->req_obj.req;
>  		/*
>  		 * If a request is associated with this buffer, then
>  		 * call buf_request_cancel() to give the driver to complete()
> @@ -2224,10 +2277,12 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
>  	buffer = (offset >> PLANE_INDEX_SHIFT) & BUFFER_INDEX_MASK;
>  	*plane = (offset >> PAGE_SHIFT) & PLANE_INDEX_MASK;
>  
> -	if (buffer >= q->num_buffers || *plane >= q->bufs[buffer]->num_planes)
> +	*vb = vb2_get_buffer(q, buffer);
> +	if (!*vb)
> +		return -EINVAL;
> +	if (*plane >= (*vb)->num_planes)
>  		return -EINVAL;
>  
> -	*vb = q->bufs[buffer];
>  	return 0;
>  }
>  
> @@ -2615,6 +2670,7 @@ struct vb2_fileio_data {
>  static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  {
>  	struct vb2_fileio_data *fileio;
> +	struct vb2_buffer *vb;
>  	int i, ret;
>  	unsigned int count = 0;
>  
> @@ -2665,11 +2721,18 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	if (ret)
>  		goto err_kfree;
>  
> +	/*
> +	 * Userspace can never add or delete buffers later, so there
> +	 * will never be holes. It is safe to assume that vb2_get_buffer(q, 0)
> +	 * will always return a valid vb pointer
> +	 */
> +	vb = vb2_get_buffer(q, 0);
> +
>  	/*
>  	 * Check if plane_count is correct
>  	 * (multiplane buffers are not supported).
>  	 */
> -	if (q->bufs[0]->num_planes != 1) {
> +	if (vb->num_planes != 1) {
>  		ret = -EBUSY;
>  		goto err_reqbufs;
>  	}
> @@ -2678,12 +2741,15 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	 * Get kernel address of each buffer.
>  	 */
>  	for (i = 0; i < q->num_buffers; i++) {
> -		fileio->bufs[i].vaddr = vb2_plane_vaddr(q->bufs[i], 0);
> +		vb = vb2_get_buffer(q, i);
> +		WARN_ON_ONCE(!vb);

This is weird. You warn if NULL, then the next call will kernel oops on it.

This really can't happen, just drop this line.

If for some reason you think this is really helpful, then return a proper
error instead of just continuing into a kernel oops.

Perhaps replace it with a simple:

		/* vb can never be NULL when using fileio. */

> +
> +		fileio->bufs[i].vaddr = vb2_plane_vaddr(vb, 0);
>  		if (fileio->bufs[i].vaddr == NULL) {
>  			ret = -EINVAL;
>  			goto err_reqbufs;
>  		}
> -		fileio->bufs[i].size = vb2_plane_size(q->bufs[i], 0);
> +		fileio->bufs[i].size = vb2_plane_size(vb, 0);
>  	}
>  
>  	/*
> @@ -2811,15 +2877,17 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  
>  		fileio->cur_index = index;
>  		buf = &fileio->bufs[index];
> -		b = q->bufs[index];
> +
> +		/* b can never be NULL when using fileio. */
> +		b = vb2_get_buffer(q, index);

Huh, this function is the only one that calls the struct vb2_buffer pointer
'b' instead of 'vb'. This is a bit confusing since the convention is to
call struct v4l2_buffer 'b'.

Can you rename 'b' to 'vb' in this function? No need to do this in a separate
patch, I think it is OK to do it here.

Regards,

	Hans

>  
>  		/*
>  		 * Get number of bytes filled by the driver
>  		 */
>  		buf->pos = 0;
>  		buf->queued = 0;
> -		buf->size = read ? vb2_get_plane_payload(q->bufs[index], 0)
> -				 : vb2_plane_size(q->bufs[index], 0);
> +		buf->size = read ? vb2_get_plane_payload(b, 0)
> +				 : vb2_plane_size(b, 0);
>  		/* Compensate for data_offset on read in the multiplanar case. */
>  		if (is_multiplanar && read &&
>  				b->planes[0].data_offset < buf->size) {
> @@ -2862,7 +2930,8 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  	 * Queue next buffer if required.
>  	 */
>  	if (buf->pos == buf->size || (!read && fileio->write_immediately)) {
> -		struct vb2_buffer *b = q->bufs[index];
> +		/* b can never be NULL when using fileio. */
> +		struct vb2_buffer *b = vb2_get_buffer(q, index);

Ditto.

>  
>  		/*
>  		 * Check if this is the last buffer to read.
> @@ -2889,7 +2958,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  		 */
>  		buf->pos = 0;
>  		buf->queued = 1;
> -		buf->size = vb2_plane_size(q->bufs[index], 0);
> +		buf->size = vb2_plane_size(b, 0);
>  		fileio->q_count += 1;
>  		/*
>  		 * If we are queuing up buffers for the first time, then
> @@ -2960,7 +3029,9 @@ static int vb2_thread(void *data)
>  		 * Call vb2_dqbuf to get buffer back.
>  		 */
>  		if (prequeue) {
> -			vb = q->bufs[index++];
> +			vb = vb2_get_buffer(q, index++);
> +			if (!vb)
> +				continue;
>  			prequeue--;
>  		} else {
>  			call_void_qop(q, wait_finish, q);
> @@ -2969,7 +3040,7 @@ static int vb2_thread(void *data)
>  			call_void_qop(q, wait_prepare, q);
>  			dprintk(q, 5, "file io: vb2_dqbuf result: %d\n", ret);
>  			if (!ret)
> -				vb = q->bufs[index];
> +				vb = vb2_get_buffer(q, index);
>  		}
>  		if (ret || threadio->stop)
>  			break;
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 697c8a9f98cd..3395e702ad1f 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -383,9 +383,9 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>  		return -EINVAL;
>  	}
>  
> -	if (q->bufs[b->index] == NULL) {
> -		/* Should never happen */
> -		dprintk(q, 1, "%s: buffer is NULL\n", opname);
> +	vb = vb2_get_buffer(q, b->index);
> +	if (!vb) {
> +		dprintk(q, 1, "%s: buffer %u is NULL\n", opname,  b->index);
>  		return -EINVAL;
>  	}
>  
> @@ -394,7 +394,6 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>  		return -EINVAL;
>  	}
>  
> -	vb = q->bufs[b->index];
>  	vbuf = to_vb2_v4l2_buffer(vb);
>  	ret = __verify_planes_array(vb, b);
>  	if (ret)
> @@ -628,11 +627,22 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
>  struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  {
>  	unsigned int i;
> +	struct vb2_buffer *vb2;
>  
> -	for (i = 0; i < q->num_buffers; i++)
> -		if (q->bufs[i]->copied_timestamp &&
> -		    q->bufs[i]->timestamp == timestamp)
> -			return vb2_get_buffer(q, i);
> +	/*
> +	 * This loop doesn't scale if there is a really large number of buffers.
> +	 * Maybe something more efficient will be needed in this case.

this -> that

> +	 */
> +	for (i = 0; i < q->num_buffers; i++) {
> +		vb2 = vb2_get_buffer(q, i);
> +
> +		if (!vb2)
> +			continue;
> +
> +		if (vb2->copied_timestamp &&
> +		    vb2->timestamp == timestamp)
> +			return vb2;
> +	}
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(vb2_find_buffer);
> @@ -660,11 +670,12 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
>  		return -EINVAL;
>  	}
>  
> -	if (b->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> +	vb = vb2_get_buffer(q, b->index);
> +	if (!vb) {
> +		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
>  		return -EINVAL;
>  	}
> -	vb = q->bufs[b->index];
> +
>  	ret = __verify_planes_array(vb, b);
>  	if (!ret)
>  		vb2_core_querybuf(q, vb, b);
> @@ -734,11 +745,11 @@ int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>  	if (b->flags & V4L2_BUF_FLAG_REQUEST_FD)
>  		return -EINVAL;
>  
> -	if (b->index >= q->num_buffers) {
> -		dprintk(q, 1, "buffer index out of range\n");
> +	vb = vb2_get_buffer(q, b->index);
> +	if (!vb) {
> +		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
>  		return -EINVAL;
>  	}
> -	vb = q->bufs[b->index];
>  
>  	ret = vb2_queue_or_prepare_buf(q, mdev, b, true, NULL);
>  
> @@ -822,7 +833,11 @@ int vb2_qbuf(struct vb2_queue *q, struct media_device *mdev,
>  		dprintk(q, 1, "buffer index out of range\n");
>  		return -EINVAL;
>  	}
> -	vb = q->bufs[b->index];
> +	vb = vb2_get_buffer(q, b->index);
> +	if (!vb) {
> +		dprintk(q, 1, "can't find the requested buffer %u\n", b->index);
> +		return -EINVAL;
> +	}
>  
>  	ret = vb2_queue_or_prepare_buf(q, mdev, b, false, &req);
>  	if (ret)
> @@ -893,7 +908,11 @@ int vb2_expbuf(struct vb2_queue *q, struct v4l2_exportbuffer *eb)
>  		dprintk(q, 1, "buffer index out of range\n");
>  		return -EINVAL;
>  	}
> -	vb = q->bufs[eb->index];
> +	vb = vb2_get_buffer(q, eb->index);
> +	if (!vb) {
> +		dprintk(q, 1, "can't find the requested buffer %u\n", eb->index);
> +		return -EINVAL;
> +	}
>  
>  	return vb2_core_expbuf(q, &eb->fd, eb->type, vb,
>  				eb->plane, eb->flags);

Regards,

	Hans
