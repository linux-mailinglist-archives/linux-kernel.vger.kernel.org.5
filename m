Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955007DEE14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbjKBIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjKBIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:17:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1C132;
        Thu,  2 Nov 2023 01:17:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD4BC433C8;
        Thu,  2 Nov 2023 08:17:45 +0000 (UTC)
Message-ID: <75bc90a5-85c3-4cac-9bf9-a868d1d052bd@xs4all.nl>
Date:   Thu, 2 Nov 2023 09:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 43/56] media: videobuf2: Be more flexible on the
 number of queue stored buffers
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
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-44-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231031163104.112469-44-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

After a lot of testing yesterday I discovered that this patch introduces a
bug. After this bug, running the test-media script will result in a lot of
unbalanced counters messages:

[Wed Nov  1 16:40:48 2023] videobuf2_common: unbalanced counters for queue ffff888115a07f00, buffer 11:
[Wed Nov  1 16:40:48 2023] videobuf2_common:      buf_init: 1 buf_cleanup: 0
[Wed Nov  1 16:40:48 2023] videobuf2_common:      alloc: 1 put: 0
[Wed Nov  1 16:40:48 2023] videobuf2_common:      get_dmabuf: 0 num_users: 0

Apparently buf_init is called, but not buf_cleanup.

I also get loads of kmemleak reports:

unreferenced object 0xffff88800eae6800 (size 2048):
  comm "v4l2-compliance", pid 652, jiffies 4294937190 (age 149.650s)
  hex dump (first 32 bytes):
    e0 52 18 0c 81 88 ff ff 00 00 00 00 02 00 00 00  .R..............
    01 00 00 00 01 00 00 00 20 2f d3 f3 3e 00 00 00  ........ /..>...
  backtrace:
    [<ffffffffacbdb08b>] __kmalloc+0x4b/0x150
    [<ffffffffc01df77a>] __vb2_queue_alloc+0x11a/0xca0 [videobuf2_common]
    [<ffffffffc01e74f5>] vb2_core_reqbufs+0x735/0xfd0 [videobuf2_common]
    [<ffffffffc046ca71>] v4l2_m2m_ioctl_reqbufs+0xc1/0x1b0 [v4l2_mem2mem]
    [<ffffffffc0231520>] __video_do_ioctl+0x8d0/0xc20 [videodev]
    [<ffffffffc0232bcc>] video_usercopy+0x48c/0xd00 [videodev]
    [<ffffffffc021e2ff>] v4l2_ioctl+0x17f/0x1f0 [videodev]
    [<ffffffffacd758ce>] __do_compat_sys_ioctl+0x13e/0x1d0
    [<ffffffffae7df992>] __do_fast_syscall_32+0x62/0xe0
    [<ffffffffae7dfb4f>] do_fast_syscall_32+0x2f/0x70
    [<ffffffffaea012ed>] entry_SYSCALL_compat_after_hwframe+0x45/0x4d

Very likely the same issue.

Unfortunately, the build script does not yet check for issues like this,
you have to manually inspect the test-media logs (found in the logs directory
after the run). It's on my TODO list.

Regards,

	Hans

On 31/10/2023 17:30, Benjamin Gaignard wrote:
> Add 'max_num_buffers' field in vb2_queue struct to let drivers decide
> how many buffers could be stored in a queue.
> This require 'bufs' array to be allocated at queue init time and freed
> when releasing the queue.
> By default VB2_MAX_FRAME remains the limit.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 41 +++++++++++++++----
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +--
>  include/media/videobuf2-core.h                | 10 ++++-
>  3 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index c5c5ae4d213d..72ef7179d80a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -416,7 +416,7 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> -	WARN_ON(index >= VB2_MAX_FRAME || q->bufs[index]);
> +	WARN_ON(index >= q->max_num_buffers || q->bufs[index]);
>  
>  	q->bufs[index] = vb;
>  	vb->index = index;
> @@ -449,9 +449,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	struct vb2_buffer *vb;
>  	int ret;
>  
> -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> +	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */
>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    VB2_MAX_FRAME - q_num_buffers);
> +			    q->max_num_buffers - q_num_buffers);
>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -813,7 +813,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>  	unsigned int i;
> -	int ret;
> +	int ret = 0;
>  
>  	if (q->streaming) {
>  		dprintk(q, 1, "streaming active\n");
> @@ -857,17 +857,22 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
>  	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
> -	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
> +	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*
>  	 * Set this now to ensure that drivers see the correct q->memory value
>  	 * in the queue_setup op.
>  	 */
>  	mutex_lock(&q->mmap_lock);
> +	if (!q->bufs)
> +		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +	if (!q->bufs)
> +		ret = -ENOMEM;
>  	q->memory = memory;
>  	mutex_unlock(&q->mmap_lock);
> +	if (ret)
> +		return ret;
>  	set_queue_coherency(q, non_coherent_mem);
>  
>  	/*
> @@ -976,7 +981,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	bool no_previous_buffers = !q_num_bufs;
>  	int ret = 0;
>  
> -	if (q_num_bufs == VB2_MAX_FRAME) {
> +	if (q->num_buffers == q->max_num_buffers) {
>  		dprintk(q, 1, "maximum number of buffers already allocated\n");
>  		return -ENOBUFS;
>  	}
> @@ -993,7 +998,13 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 */
>  		mutex_lock(&q->mmap_lock);
>  		q->memory = memory;
> +		if (!q->bufs)
> +			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +		if (!q->bufs)
> +			ret = -ENOMEM;
>  		mutex_unlock(&q->mmap_lock);
> +		if (ret)
> +			return ret;
>  		q->waiting_for_buffers = !q->is_output;
>  		set_queue_coherency(q, non_coherent_mem);
>  	} else {
> @@ -1005,7 +1016,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			return -EINVAL;
>  	}
>  
> -	num_buffers = min(*count, VB2_MAX_FRAME - q_num_bufs);
> +	num_buffers = min(*count, q->max_num_buffers - q_num_bufs);
>  
>  	if (requested_planes && requested_sizes) {
>  		num_planes = requested_planes;
> @@ -2465,6 +2476,12 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	/*
>  	 * Sanity check
>  	 */
> +	if (!q->max_num_buffers)
> +		q->max_num_buffers = VB2_MAX_FRAME;
> +
> +	/* The maximum is limited by offset cookie encoding pattern */
> +	q->max_num_buffers = min_t(unsigned int, q->max_num_buffers, MAX_BUFFER_INDEX);
> +
>  	if (WARN_ON(!q)			  ||
>  	    WARN_ON(!q->ops)		  ||
>  	    WARN_ON(!q->mem_ops)	  ||
> @@ -2474,6 +2491,10 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  	    WARN_ON(!q->ops->buf_queue))
>  		return -EINVAL;
>  
> +	if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||
> +	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
> +		return -EINVAL;
> +
>  	if (WARN_ON(q->requires_requests && !q->supports_requests))
>  		return -EINVAL;
>  
> @@ -2519,7 +2540,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_cleanup_fileio(q);
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
> -	__vb2_queue_free(q, vb2_get_num_buffers(q));
> +	__vb2_queue_free(q, q->max_num_buffers);
> +	kfree(q->bufs);
> +	q->bufs = NULL;
>  	q->num_buffers = 0;
>  	mutex_unlock(&q->mmap_lock);
>  }
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 7d798fb15c0b..f3cf4b235c1f 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -627,7 +627,7 @@ struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  	 * This loop doesn't scale if there is a really large number of buffers.
>  	 * Maybe something more efficient will be needed in this case.
>  	 */
> -	for (i = 0; i < vb2_get_num_buffers(q); i++) {
> +	for (i = 0; i < q->max_num_buffers; i++) {
>  		vb2 = vb2_get_buffer(q, i);
>  
>  		if (!vb2)
> @@ -1142,7 +1142,7 @@ int _vb2_fop_release(struct file *file, struct mutex *lock)
>  
>  	if (lock)
>  		mutex_lock(lock);
> -	if (file->private_data == vdev->queue->owner) {
> +	if (!vdev->queue->owner || file->private_data == vdev->queue->owner) {
>  		vb2_queue_release(vdev->queue);
>  		vdev->queue->owner = NULL;
>  	}
> @@ -1270,7 +1270,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
>  	 */
>  	get_device(&vdev->dev);
>  	video_unregister_device(vdev);
> -	if (vdev->queue && vdev->queue->owner) {
> +	if (vdev->queue) {
>  		struct mutex *lock = vdev->queue->lock ?
>  			vdev->queue->lock : vdev->lock;
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 8f9d9e4af5b1..e77a397195f2 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -558,6 +558,7 @@ struct vb2_buf_ops {
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures
>   * @num_buffers: number of allocated/used buffers
> + * @max_num_buffers: upper limit of number of allocated/used buffers
>   * @queued_list: list of buffers currently queued from userspace
>   * @queued_count: number of buffers queued and ready for streaming.
>   * @owned_by_drv_count: number of buffers owned by the driver
> @@ -619,8 +620,9 @@ struct vb2_queue {
>  	struct mutex			mmap_lock;
>  	unsigned int			memory;
>  	enum dma_data_direction		dma_dir;
> -	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
> +	struct vb2_buffer		**bufs;
>  	unsigned int			num_buffers;
> +	unsigned int			max_num_buffers;
>  
>  	struct list_head		queued_list;
>  	unsigned int			queued_count;
> @@ -1248,6 +1250,12 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  						unsigned int index)
>  {
> +	if (!q->bufs)
> +		return NULL;
> +
> +	if (index >= q->max_num_buffers)
> +		return NULL;
> +
>  	if (index < q->num_buffers)
>  		return q->bufs[index];
>  	return NULL;

