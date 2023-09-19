Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6787A634F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjISMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:42:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DFE3;
        Tue, 19 Sep 2023 05:42:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2FCC433C8;
        Tue, 19 Sep 2023 12:42:23 +0000 (UTC)
Message-ID: <c58cdf5a-7176-457e-98f3-85606cec7f09@xs4all.nl>
Date:   Tue, 19 Sep 2023 14:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/49] media: videobuf2: Be more flexible on the number
 of queue stored buffers
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
 <20230914133323.198857-13-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-13-benjamin.gaignard@collabora.com>
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
> Add 'max_allowed_buffers' field in vb2_queue struct to let drivers decide
> how many buffers could be stored in a queue.
> This request 'bufs' array to be allocated at queue init time and freed
> when releasing the queue.
> By default VB2_MAX_FRAME remains the limit.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 40 ++++++++++++++-----
>  .../media/common/videobuf2/videobuf2-v4l2.c   |  4 +-
>  include/media/videobuf2-core.h                |  4 +-
>  3 files changed, 35 insertions(+), 13 deletions(-)

After this patch I would like to see a patches adding support for this to
vicodec and vivid. For vivid it might be a good idea to mix this: say
the video output remains at 32 buffers, but video capture can do more.

And the swradio device should be able to handle quite a lot more (try
1024 there) since these buffers are quite small (32 kB).

The vicodec driver can increase it to 64, just as the verisilicon driver
does.

This makes it easy to do compliance testing for this new feature.

Regards,

	Hans

> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index afe76577acc1..ee4df7c68397 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -411,7 +411,7 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   */
>  static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> -	if (index < VB2_MAX_FRAME && !q->bufs[index]) {
> +	if (index < q->max_allowed_buffers && !q->bufs[index]) {
>  		q->bufs[index] = vb;
>  		vb->index = index;
>  		vb->vb2_queue = q;
> @@ -428,7 +428,7 @@ static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>  {
> -	if (vb->index < VB2_MAX_FRAME) {
> +	if (vb->index < q->max_allowed_buffers) {
>  		q->bufs[vb->index] = NULL;
>  		vb->vb2_queue = NULL;
>  	}
> @@ -449,9 +449,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  	struct vb2_buffer *vb;
>  	int ret;
>  
> -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> +	/* Ensure that q->num_buffers+num_buffers is below q->max_allowed_buffers */
>  	num_buffers = min_t(unsigned int, num_buffers,
> -			    VB2_MAX_FRAME - q->num_buffers);
> +			    q->max_allowed_buffers - q->num_buffers);
>  
>  	for (buffer = 0; buffer < num_buffers; ++buffer) {
>  		/* Allocate vb2 buffer structures */
> @@ -814,7 +814,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>  	unsigned int i;
> -	int ret;
> +	int ret = 0;
>  
>  	if (q->streaming) {
>  		dprintk(q, 1, "streaming active\n");
> @@ -858,17 +858,23 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
> +	WARN_ON(q->min_buffers_needed > q->max_allowed_buffers);
>  	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
> -	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
> +	num_buffers = min_t(unsigned int, num_buffers, q->max_allowed_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*
>  	 * Set this now to ensure that drivers see the correct q->memory value
>  	 * in the queue_setup op.
>  	 */
>  	mutex_lock(&q->mmap_lock);
> +	if (!q->bufs)
> +		q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +	if (!q->bufs)
> +		ret = -ENOMEM;
>  	q->memory = memory;
>  	mutex_unlock(&q->mmap_lock);
> +	if (ret)
> +		return ret;
>  	set_queue_coherency(q, non_coherent_mem);
>  
>  	/*
> @@ -974,9 +980,9 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>  	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>  	bool no_previous_buffers = !q->num_buffers;
> -	int ret;
> +	int ret = 0;
>  
> -	if (q->num_buffers == VB2_MAX_FRAME) {
> +	if (q->num_buffers == q->max_allowed_buffers) {
>  		dprintk(q, 1, "maximum number of buffers already allocated\n");
>  		return -ENOBUFS;
>  	}
> @@ -993,7 +999,13 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 */
>  		mutex_lock(&q->mmap_lock);
>  		q->memory = memory;
> +		if (!q->bufs)
> +			q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +		if (!q->bufs)
> +			ret = -ENOMEM;
>  		mutex_unlock(&q->mmap_lock);
> +		if (ret)
> +			return ret;
>  		q->waiting_for_buffers = !q->is_output;
>  		set_queue_coherency(q, non_coherent_mem);
>  	} else {
> @@ -1005,7 +1017,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			return -EINVAL;
>  	}
>  
> -	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> +	num_buffers = min(*count, q->max_allowed_buffers - q->num_buffers);
>  
>  	if (requested_planes && requested_sizes) {
>  		num_planes = requested_planes;
> @@ -2515,6 +2527,12 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  
> +	if (!q->max_allowed_buffers)
> +		q->max_allowed_buffers = VB2_MAX_FRAME;
> +
> +	/* The maximum is limited by offset cookie encoding pattern */
> +	q->max_allowed_buffers = min_t(unsigned int, q->max_allowed_buffers, BUFFER_INDEX_MASK + 1);
> +
>  	if (q->buf_struct_size == 0)
>  		q->buf_struct_size = sizeof(struct vb2_buffer);
>  
> @@ -2539,6 +2557,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, q->num_buffers);
> +	kfree(q->bufs);
> +	q->bufs = NULL;
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index f460cac560f6..87c2d5916960 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -1156,7 +1156,7 @@ int _vb2_fop_release(struct file *file, struct mutex *lock)
>  
>  	if (lock)
>  		mutex_lock(lock);
> -	if (file->private_data == vdev->queue->owner) {
> +	if (!vdev->queue->owner || file->private_data == vdev->queue->owner) {
>  		vb2_queue_release(vdev->queue);
>  		vdev->queue->owner = NULL;
>  	}
> @@ -1284,7 +1284,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
>  	 */
>  	get_device(&vdev->dev);
>  	video_unregister_device(vdev);
> -	if (vdev->queue && vdev->queue->owner) {
> +	if (vdev->queue) {
>  		struct mutex *lock = vdev->queue->lock ?
>  			vdev->queue->lock : vdev->lock;
>  
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index cd3ff1cd759d..97153c69583f 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -558,6 +558,7 @@ struct vb2_buf_ops {
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures
>   * @num_buffers: number of allocated/used buffers
> + * @max_allowed_buffers: upper limit of number of allocated/used buffers
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
> +	unsigned int			max_allowed_buffers;
>  
>  	struct list_head		queued_list;
>  	unsigned int			queued_count;

