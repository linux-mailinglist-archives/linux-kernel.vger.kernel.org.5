Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA67A679A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjISPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjISPJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:09:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3530994;
        Tue, 19 Sep 2023 08:09:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634C8C433C8;
        Tue, 19 Sep 2023 15:09:44 +0000 (UTC)
Message-ID: <7a437626-f3f1-4828-9852-8332b02f7a34@xs4all.nl>
Date:   Tue, 19 Sep 2023 17:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 46/49] media: core: Free range of buffers
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
 <20230914133323.198857-47-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-47-benjamin.gaignard@collabora.com>
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

On 14/09/2023 15:33, Benjamin Gaignard wrote:
> Improve __vb2_queue_free() and __vb2_free_mem() to free
> range of buffers and not only the last few buffers.
> Intoduce starting index to be flexible on range and change the loops
> according to this parameters.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 30 +++++++++----------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index c5d4a388331b..88cdf4dcb07c 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -527,13 +527,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  /*
>   * __vb2_free_mem() - release all video buffer memory for a given queue
>   */
> -static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer = 0;
> -	long i = q->max_allowed_buffers;
> +	unsigned int i, buffer = 0;
>  	struct vb2_buffer *vb;
>  
> -	for (i = q->max_allowed_buffers; i >= 0 && buffer < buffers; i--) {
> +	for (i = start; i < q->max_allowed_buffers && buffer < count; i++) {
>  		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;

Isn't there a 'buffer++' missing here?

> @@ -550,19 +549,18 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  }
>  
>  /*
> - * __vb2_queue_free() - free buffers at the end of the queue - video memory and
> + * __vb2_queue_free() - free count buffers from start index of the queue - video memory and
>   * related information, if no buffers are left return the queue to an
>   * uninitialized state. Might be called even if the queue has already been freed.
>   */
> -static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> -	long i = q->max_allowed_buffers;
> +	unsigned int i, buffer;
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
>  	/* Call driver-provided cleanup function for each buffer, if provided */
> -	for (i = q->max_allowed_buffers, buffer = 0; i >= 0 && buffer < buffers; i--) {
> +	for (i = start, buffer = 0; i < q->max_allowed_buffers && buffer < count; i++) {
>  		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (!vb)

Same issue, 'buffer' is never incremented.

> @@ -574,7 +572,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  	}
>  
>  	/* Release video buffer memory */
> -	__vb2_free_mem(q, buffers);
> +	__vb2_free_mem(q, start, count);
>  
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  	/*
> @@ -659,8 +657,8 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #endif
>  
>  	/* Free vb2 buffers */
> -	for (i = q->max_allowed_buffers, buffer = 0; i > 0 && buffer < buffers; i--) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start, buffer = 0; i < q->max_allowed_buffers && buffer < count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
>  		if (!vb)
>  			continue;

Ditto.

> @@ -884,7 +882,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * queued without ever calling STREAMON.
>  		 */
>  		__vb2_queue_cancel(q);
> -		__vb2_queue_free(q, q_num_bufs);
> +		__vb2_queue_free(q, 0, q_num_bufs);
>  		mutex_unlock(&q->mmap_lock);
>  
>  		/*
> @@ -995,7 +993,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, 0, allocated_buffers);

Shouldn't we use 'first_index' here instead of '0'?

>  		mutex_unlock(&q->mmap_lock);
>  		return ret;
>  	}
> @@ -1135,7 +1133,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  		 * from already queued buffers and it will reset q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
> -		__vb2_queue_free(q, allocated_buffers);
> +		__vb2_queue_free(q, 0, allocated_buffers);

Ditto.

>  		mutex_unlock(&q->mmap_lock);
>  		return -ENOMEM;
>  	}
> @@ -2617,7 +2615,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
>  	__vb2_cleanup_fileio(q);
>  	__vb2_queue_cancel(q);
>  	mutex_lock(&q->mmap_lock);
> -	__vb2_queue_free(q, q->max_allowed_buffers);
> +	__vb2_queue_free(q, 0, q->max_allowed_buffers);
>  	kfree(q->bufs);
>  	q->bufs = NULL;
>  	bitmap_free(q->bufs_map);

Regards,

	Hans
