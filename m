Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA9F7CA148
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjJPIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:09:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2999A1;
        Mon, 16 Oct 2023 01:08:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19AC433C7;
        Mon, 16 Oct 2023 08:08:54 +0000 (UTC)
Message-ID: <e7a9d7c8-79ea-4fbf-b37a-bf540e4ee379@xs4all.nl>
Date:   Mon, 16 Oct 2023 10:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/56] media: videobuf2: Use vb2_get_num_buffers()
 helper
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
 <20231012114642.19040-9-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012114642.19040-9-benjamin.gaignard@collabora.com>
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
> Stop using queue num_buffers field directly, instead use
> vb2_get_num_buffers().
> This prepare the replacement of num_buffers be a bitmap
> field which is need for delete buffers feature.

"This prepares for the future 'delete buffers' feature where there are
holes in the buffer indices."

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 111 ++++++++++--------
>  .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +-
>  2 files changed, 64 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 66d0f42f5691..c427aca285e3 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -429,6 +429,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>  {
> +	if (vb->vb2_queue->num_buffers)
> +		vb->vb2_queue->num_buffers--;
>  	vb->vb2_queue->bufs[vb->index] = NULL;
>  	vb->vb2_queue = NULL;
>  }
> @@ -512,12 +514,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>   */
>  static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  {
> -	unsigned int buffer;
> +	unsigned int buffer = 0;
> +	long i;
>  	struct vb2_buffer *vb;
>  
> -	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
> -	     ++buffer) {
> -		vb = vb2_get_buffer(q, buffer);
> +	for (i = vb2_get_num_buffers(q); i >= 0 && buffer < buffers; i--) {
> +		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;
>  
> @@ -528,6 +530,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  			__vb2_buf_dmabuf_put(vb);
>  		else
>  			__vb2_buf_userptr_put(vb);
> +		buffer++;
>  	}
>  }

Is there actually any reason for changing this function? We're not deleting buffers
yet, so there is no need to change this at all, not until we add that new feature.

The new code is rather confusing (complex loop condition), and it will change again
in patch 53/56 to something that makes more sense. I'd just drop this change and leave
the loop as-is (except for using vb2_get_num_buffers).

>  
> @@ -539,16 +542,20 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  {
>  	unsigned int buffer;
> +	long i;
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
>  	/* Call driver-provided cleanup function for each buffer, if provided */
> -	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = vb2_get_num_buffers(q), buffer = 0; i >= 0 && buffer < buffers; i--) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
> -		if (vb && vb->planes[0].mem_priv)
> +		if (!vb)
> +			continue;
> +		if (vb->planes[0].mem_priv) {
>  			call_void_vb_qop(vb, buf_cleanup, vb);
> +			buffer++;
> +		}
>  	}
>  
>  	/* Release video buffer memory */
> @@ -559,7 +566,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  	 * Check that all the calls were balanced during the life-time of this
>  	 * queue. If not then dump the counters to the kernel log.
>  	 */
> -	if (q->num_buffers) {
> +	if (vb2_get_num_buffers(q)) {
>  		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
>  				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
>  				  q->cnt_wait_prepare != q->cnt_wait_finish;
> @@ -585,7 +592,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  		q->cnt_stop_streaming = 0;
>  		q->cnt_unprepare_streaming = 0;
>  	}
> -	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> +	for (buffer = 0; buffer < vb2_get_num_buffers(q); buffer++) {
>  		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>  		bool unbalanced;
>  
> @@ -637,19 +644,18 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #endif
>  
>  	/* Free vb2 buffers */
> -	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = vb2_get_num_buffers(q), buffer = 0; i >= 0 && buffer < buffers; i--) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (!vb)
>  			continue;
>  
>  		vb2_queue_remove_buffer(vb);
>  		kfree(vb);
> +		buffer++;
>  	}
>  
> -	q->num_buffers -= buffers;
> -	if (!q->num_buffers) {
> +	if (!vb2_get_num_buffers(q)) {
>  		q->memory = VB2_MEMORY_UNKNOWN;
>  		INIT_LIST_HEAD(&q->queued_list);
>  	}

Same here. Only replace q->num_buffers with vb2_get_num_buffers(q), otherwise
leave it as-is.

> @@ -680,7 +686,7 @@ EXPORT_SYMBOL(vb2_buffer_in_use);
>  static bool __buffers_in_use(struct vb2_queue *q)
>  {
>  	unsigned int buffer;
> -	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> +	for (buffer = 0; buffer < vb2_get_num_buffers(q); ++buffer) {
>  		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>  
>  		if (!vb)
> @@ -806,6 +812,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		     unsigned int flags, unsigned int *count)
>  {
>  	unsigned int num_buffers, allocated_buffers, num_planes = 0;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(q);
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>  	unsigned int i;
> @@ -821,7 +828,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		return -EBUSY;
>  	}
>  
> -	if (*count == 0 || q->num_buffers != 0 ||
> +	if (*count == 0 || q_num_bufs != 0 ||
>  	    (q->memory != VB2_MEMORY_UNKNOWN && q->memory != memory) ||
>  	    !verify_coherency_flags(q, non_coherent_mem)) {
>  		/*
> @@ -839,7 +846,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * queued without ever calling STREAMON.
>  		 */
>  		__vb2_queue_cancel(q);
> -		__vb2_queue_free(q, q->num_buffers);
> +		__vb2_queue_free(q, q_num_bufs);
>  		mutex_unlock(&q->mmap_lock);
>  
>  		/*
> @@ -934,7 +941,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	if (ret < 0) {
>  		/*
>  		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> -		 * from q->num_buffers and it will reset q->memory to
> +		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
>  		__vb2_queue_free(q, allocated_buffers);
> @@ -968,10 +975,11 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned int num_planes = 0, num_buffers, allocated_buffers;
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
> -	bool no_previous_buffers = !q->num_buffers;
> -	int ret;
> +	unsigned int q_num_bufs = vb2_get_num_buffers(q);
> +	bool no_previous_buffers = !q_num_bufs;
> +	int ret = 0;
>  
> -	if (q->num_buffers == VB2_MAX_FRAME) {
> +	if (q_num_bufs == VB2_MAX_FRAME) {
>  		dprintk(q, 1, "maximum number of buffers already allocated\n");
>  		return -ENOBUFS;
>  	}
> @@ -1000,7 +1008,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			return -EINVAL;
>  	}
>  
> -	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> +	num_buffers = min(*count, VB2_MAX_FRAME - q_num_bufs);
>  
>  	if (requested_planes && requested_sizes) {
>  		num_planes = requested_planes;
> @@ -1032,7 +1040,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		num_buffers = allocated_buffers;
>  
>  		/*
> -		 * q->num_buffers contains the total number of buffers, that the
> +		 * num_buffers contains the total number of buffers, that the
>  		 * queue driver has set up
>  		 */
>  		ret = call_qop(q, queue_setup, q, &num_buffers,
> @@ -1053,7 +1061,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	if (ret < 0) {
>  		/*
>  		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> -		 * from q->num_buffers and it will reset q->memory to
> +		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
>  		__vb2_queue_free(q, allocated_buffers);
> @@ -1670,7 +1678,7 @@ static int vb2_start_streaming(struct vb2_queue *q)
>  		 * Forcefully reclaim buffers if the driver did not
>  		 * correctly return them to vb2.
>  		 */
> -		for (i = 0; i < q->num_buffers; ++i) {
> +		for (i = 0; i < vb2_get_num_buffers(q); ++i) {
>  			vb = vb2_get_buffer(q, i);
>  
>  			if (!vb)
> @@ -2076,9 +2084,8 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * to vb2 in stop_streaming().
>  	 */
>  	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
> -		for (i = 0; i < q->num_buffers; ++i) {
> +		for (i = 0; i < vb2_get_num_buffers(q); i++) {
>  			struct vb2_buffer *vb = vb2_get_buffer(q, i);
> -

Spurious line deletion?

>  			if (!vb)
>  				continue;
>  
> @@ -2120,10 +2127,9 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  	 * call to __fill_user_buffer() after buf_finish(). That order can't
>  	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>  	 */
> -	for (i = 0; i < q->num_buffers; ++i) {
> +	for (i = 0; i < vb2_get_num_buffers(q); i++) {
>  		struct vb2_buffer *vb;
>  		struct media_request *req;
> -

Spurious line deletion?

>  		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;
> @@ -2168,6 +2174,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>  
>  int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
>  {
> +	unsigned int q_num_bufs = vb2_get_num_buffers(q);
>  	int ret;
>  
>  	if (type != q->type) {
> @@ -2180,12 +2187,12 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
>  		return 0;
>  	}
>  
> -	if (!q->num_buffers) {
> +	if (!q_num_bufs) {
>  		dprintk(q, 1, "no buffers have been allocated\n");
>  		return -EINVAL;
>  	}
>  
> -	if (q->num_buffers < q->min_buffers_needed) {
> +	if (q_num_bufs < q->min_buffers_needed) {
>  		dprintk(q, 1, "need at least %u allocated buffers\n",
>  				q->min_buffers_needed);
>  		return -EINVAL;
> @@ -2513,7 +2520,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_cleanup_fileio(q);
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
> -	__vb2_queue_free(q, q->num_buffers);
> +	__vb2_queue_free(q, vb2_get_num_buffers(q));
> +	q->num_buffers = 0;
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> @@ -2542,7 +2550,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
>  	/*
>  	 * Start file I/O emulator only if streaming API has not been used yet.
>  	 */
> -	if (q->num_buffers == 0 && !vb2_fileio_is_active(q)) {
> +	if (vb2_get_num_buffers(q) == 0 && !vb2_fileio_is_active(q)) {
>  		if (!q->is_output && (q->io_modes & VB2_READ) &&
>  				(req_events & (EPOLLIN | EPOLLRDNORM))) {
>  			if (__vb2_init_fileio(q, 1))
> @@ -2580,7 +2588,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
>  	 * For output streams you can call write() as long as there are fewer
>  	 * buffers queued than there are buffers available.
>  	 */
> -	if (q->is_output && q->fileio && q->queued_count < q->num_buffers)
> +	if (q->is_output && q->fileio && q->queued_count < vb2_get_num_buffers(q))
>  		return EPOLLOUT | EPOLLWRNORM;
>  
>  	if (list_empty(&q->done_list)) {
> @@ -2629,8 +2637,8 @@ struct vb2_fileio_buf {
>   * struct vb2_fileio_data - queue context used by file io emulator
>   *
>   * @cur_index:	the index of the buffer currently being read from or
> - *		written to. If equal to q->num_buffers then a new buffer
> - *		must be dequeued.
> + *		written to. If equal to number of already queues buffers

queues -> queued

> + *		then a new buffer must be dequeued.
>   * @initial_index: in the read() case all buffers are queued up immediately
>   *		in __vb2_init_fileio() and __vb2_perform_fileio() just cycles
>   *		buffers. However, in the write() case no buffers are initially
> @@ -2640,7 +2648,7 @@ struct vb2_fileio_buf {
>   *		buffers. This means that initially __vb2_perform_fileio()
>   *		needs to know what buffer index to use when it is queuing up
>   *		the buffers for the first time. That initial index is stored
> - *		in this field. Once it is equal to q->num_buffers all
> + *		in this field. Once it is equal to num_buffers all
>   *		available buffers have been queued and __vb2_perform_fileio()
>   *		should start the normal dequeue/queue cycle.
>   *
> @@ -2690,7 +2698,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	/*
>  	 * Check if streaming api has not been already activated.
>  	 */
> -	if (q->streaming || q->num_buffers > 0)
> +	if (q->streaming || vb2_get_num_buffers(q) > 0)
>  		return -EBUSY;
>  
>  	/*
> @@ -2740,7 +2748,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  	/*
>  	 * Get kernel address of each buffer.
>  	 */
> -	for (i = 0; i < q->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(q); i++) {
>  		vb = vb2_get_buffer(q, i);
>  		WARN_ON_ONCE(!vb);
>  
> @@ -2759,18 +2767,23 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>  		/*
>  		 * Queue all buffers.
>  		 */
> -		for (i = 0; i < q->num_buffers; i++) {
> -			ret = vb2_core_qbuf(q, q->bufs[i], NULL, NULL);
> +		for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +			struct vb2_buffer *vb2 = vb2_get_buffer(q, i);
> +
> +			if (!vb2)
> +				continue;
> +
> +			ret = vb2_core_qbuf(q, vb2, NULL, NULL);
>  			if (ret)
>  				goto err_reqbufs;
>  			fileio->bufs[i].queued = 1;
>  		}
>  		/*
>  		 * All buffers have been queued, so mark that by setting
> -		 * initial_index to q->num_buffers
> +		 * initial_index to num_buffers
>  		 */
> -		fileio->initial_index = q->num_buffers;
> -		fileio->cur_index = q->num_buffers;
> +		fileio->initial_index = vb2_get_num_buffers(q);
> +		fileio->cur_index = fileio->initial_index;
>  	}
>  
>  	/*
> @@ -2964,12 +2977,12 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>  		 * If we are queuing up buffers for the first time, then
>  		 * increase initial_index by one.
>  		 */
> -		if (fileio->initial_index < q->num_buffers)
> +		if (fileio->initial_index < vb2_get_num_buffers(q))
>  			fileio->initial_index++;
>  		/*
>  		 * The next buffer to use is either a buffer that's going to be
> -		 * queued for the first time (initial_index < q->num_buffers)
> -		 * or it is equal to q->num_buffers, meaning that the next
> +		 * queued for the first time (initial_index < num_buffers)
> +		 * or it is equal to num_buffers, meaning that the next
>  		 * time we need to dequeue a buffer since we've now queued up
>  		 * all the 'first time' buffers.
>  		 */
> @@ -3016,7 +3029,7 @@ static int vb2_thread(void *data)
>  	int ret = 0;
>  
>  	if (q->is_output) {
> -		prequeue = q->num_buffers;
> +		prequeue = vb2_get_num_buffers(q);
>  		copy_timestamp = q->copy_timestamp;
>  	}
>  
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index b9df2bdae389..daa07f62c219 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -628,7 +628,7 @@ struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  	 * This loop doesn't scale if there is a really large number of buffers.
>  	 * Maybe something more efficient will be needed in this case.
>  	 */
> -	for (i = 0; i < q->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(q); i++) {
>  		vb2 = vb2_get_buffer(q, i);
>  
>  		if (!vb2)
> @@ -762,7 +762,7 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>  
>  	fill_buf_caps(q, &create->capabilities);
>  	validate_memory_flags(q, create->memory, &create->flags);
> -	create->index = q->num_buffers;
> +	create->index = vb2_get_num_buffers(q);
>  	if (create->count == 0)
>  		return ret != -EBUSY ? ret : 0;
>  

Regards,

	Hans
