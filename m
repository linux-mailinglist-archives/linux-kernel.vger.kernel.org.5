Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E2791A72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353203AbjIDPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjIDPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B46CD4;
        Mon,  4 Sep 2023 08:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 902B5B80E74;
        Mon,  4 Sep 2023 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DDDC433C7;
        Mon,  4 Sep 2023 15:19:50 +0000 (UTC)
Message-ID: <d7bd6154-48be-8e5f-51e1-f9731bed88e2@xs4all.nl>
Date:   Mon, 4 Sep 2023 17:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 11/18] media: videobuf2: Be more flexible on the number
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
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
 <20230901124414.48497-12-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230901124414.48497-12-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 14:44, Benjamin Gaignard wrote:
> Add 'max_allowed_buffers' field in vb2_queue struct to let drivers decide
> how many buffers could be stored in a queue.
> This request 'bufs' array to be allocated at queue init time and freed
> when releasing the queue.
> By default VB2_MAX_FRAME remains the limit.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 25 +++++++++++++------
>  include/media/videobuf2-core.h                |  4 ++-
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 15b583ce0c69..dc7f6b59d237 100644
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
> @@ -862,9 +862,9 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
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
> @@ -980,7 +980,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  	bool no_previous_buffers = !q->num_buffers;
>  	int ret;
>  
> -	if (q->num_buffers == VB2_MAX_FRAME) {
> +	if (q->num_buffers == q->max_allowed_buffers) {
>  		dprintk(q, 1, "maximum number of buffers already allocated\n");
>  		return -ENOBUFS;
>  	}
> @@ -1009,7 +1009,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  			return -EINVAL;
>  	}
>  
> -	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> +	num_buffers = min(*count, q->max_allowed_buffers - q->num_buffers);
>  
>  	if (requested_planes && requested_sizes) {
>  		num_planes = requested_planes;
> @@ -2519,6 +2519,14 @@ int vb2_core_queue_init(struct vb2_queue *q)
>  
>  	q->memory = VB2_MEMORY_UNKNOWN;
>  
> +	if (!q->max_allowed_buffers)
> +		q->max_allowed_buffers = VB2_MAX_FRAME;
> +
> +	/* The maximum is limited by offset cookie encoding pattern */
> +	q->max_allowed_buffers = min_t(unsigned int, q->max_allowed_buffers, BUFFER_INDEX_MASK);

I think this should be 'BUFFER_INDEX_MASK + 1'.

> +
> +	q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
> +
>  	if (q->buf_struct_size == 0)
>  		q->buf_struct_size = sizeof(struct vb2_buffer);
>  
> @@ -2543,6 +2551,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
>  	__vb2_queue_free(q, q->num_buffers);
> +	kfree(q->bufs);
>  	mutex_unlock(&q->mmap_lock);
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
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

Regards,

	Hans
