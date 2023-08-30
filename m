Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BDD78DECD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbjH3Ta4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343634AbjH3QYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:24:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96B19A;
        Wed, 30 Aug 2023 09:24:40 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:3c80:2375:ed1d:19ee] (unknown [IPv6:2a01:e0a:120:3210:3c80:2375:ed1d:19ee])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4EA196607236;
        Wed, 30 Aug 2023 17:24:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693412678;
        bh=3iRc0vIDkB732gny/eADYyIjkSHjA9lndsmwoP+uUfM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=omyLXFj8V8MRFAqKY+M6SNa4h82gJpH5KGwI89slp4rJlVH4KbTIW3GkU/e+KWHSf
         RwSlN5KSqa+c7qW+N1mEhEWe/rhymo8TEEiiPv+rNi25YEVCzt5bzEJ8nUVVqyBwkc
         AnkeL/DRv4xq20NJ5XTILLFei9xiA76qEOw6Al++YgObbagK5e+OYiJ21LNPbJfyl6
         ObIbNW/wxRkdP2aFwD+9l8/wFrrBhYhPHr7h2jgR4DSgywZFldMZIR+b2OlZBK6FSG
         2fB4z9L40vtxJxsICaLhGJN/+qeVFmDXYN8ZgIAiHAOJcd6UB6k7BIXBub/hNLYV5D
         sdPVd25A0WpNg==
Message-ID: <73e3e87b-78d6-13b2-8a20-09a75d5f23d0@collabora.com>
Date:   Wed, 30 Aug 2023 18:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 02/10] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230824092133.39510-1-benjamin.gaignard@collabora.com>
 <20230824092133.39510-3-benjamin.gaignard@collabora.com>
 <397c6779-6153-5df2-a9f7-708bb7fcf58d@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <397c6779-6153-5df2-a9f7-708bb7fcf58d@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30/08/2023 à 15:23, Hans Verkuil a écrit :
> On 24/08/2023 11:21, Benjamin Gaignard wrote:
>> The first step before changing how vb2 buffers are stored into queue
>> is to avoid direct access to bufs arrays.
>>
>> This patch adds 2 helpers functions to add and remove vb2 buffers
>> from a queue. With these 2 and vb2_get_buffer(), bufs field of
>> struct vb2_queue becomes like a private member of the structure.
>>
>> After each call to vb2_get_buffer() we need to be sure that we get
>> a valid pointer so check the return value of all of them.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>
>> # Conflicts:
>> #	drivers/media/common/videobuf2/videobuf2-core.c
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 203 ++++++++++++++----
>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  28 ++-
>>   drivers/media/platform/amphion/vpu_dbg.c      |  22 +-
>>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   6 +-
>>   .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c |   2 +-
>>   drivers/media/platform/st/sti/hva/hva-v4l2.c  |   4 +
>>   drivers/media/test-drivers/visl/visl-dec.c    |  28 ++-
>>   .../staging/media/atomisp/pci/atomisp_ioctl.c |   2 +-
>>   8 files changed, 230 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index e06905533ef4..8aa13591b782 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -403,6 +403,37 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>>   		vb->skip_cache_sync_on_finish = 1;
>>   }
>>   
>> +/**
>> + * vb2_queue_add_buffer() - add a buffer to a queue
>> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
>> + * @vb:	pointer to &struct vb2_buffer to be added to the queue.
>> + * @index: index where add vb2_buffer in the queue
>> + */
>> +static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, int index)
>> +{
>> +	if (index < VB2_MAX_FRAME && !q->bufs[index]) {
>> +		q->bufs[index] = vb;
>> +		vb->index = index;
>> +		vb->vb2_queue = q;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * vb2_queue_remove_buffer() - remove a buffer from a queue
>> + * @q:	pointer to &struct vb2_queue with videobuf2 queue.
>> + * @vb:	pointer to &struct vb2_buffer to be removed from the queue.
>> + */
>> +static void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>> +{
>> +	if (vb->index < VB2_MAX_FRAME) {
>> +		q->bufs[vb->index] = NULL;
>> +		vb->vb2_queue = NULL;
>> +	}
>> +}
>> +
>>   /*
>>    * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
>>    * video buffer memory for all buffers/planes on the queue and initializes the
>> @@ -431,9 +462,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   		}
>>   
>>   		vb->state = VB2_BUF_STATE_DEQUEUED;
>> -		vb->vb2_queue = q;
>>   		vb->num_planes = num_planes;
>> -		vb->index = q->num_buffers + buffer;
>>   		vb->type = q->type;
>>   		vb->memory = memory;
>>   		init_buffer_cache_hints(q, vb);
>> @@ -443,7 +472,11 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   		}
>>   		call_void_bufop(q, init_buffer, vb);
>>   
>> -		q->bufs[vb->index] = vb;
>> +		if (!vb2_queue_add_buffer(q, vb, q->num_buffers + buffer)) {
>> +			dprintk(q, 1, "failed adding buffer %d to queue\n", buffer);
>> +			kfree(vb);
>> +			break;
>> +		}
>>   
>>   		/* Allocate video buffer memory for the MMAP type */
>>   		if (memory == VB2_MEMORY_MMAP) {
>> @@ -451,7 +484,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   			if (ret) {
>>   				dprintk(q, 1, "failed allocating memory for buffer %d\n",
>>   					buffer);
>> -				q->bufs[vb->index] = NULL;
>> +				vb2_queue_remove_buffer(q, vb);
>>   				kfree(vb);
>>   				break;
>>   			}
>> @@ -466,7 +499,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   				dprintk(q, 1, "buffer %d %p initialization failed\n",
>>   					buffer, vb);
>>   				__vb2_buf_mem_free(vb);
>> -				q->bufs[vb->index] = NULL;
>> +				vb2_queue_remove_buffer(q, vb);
>>   				kfree(vb);
>>   				break;
>>   			}
>> @@ -489,7 +522,7 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>>   
>>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>>   	     ++buffer) {
>> -		vb = q->bufs[buffer];
>> +		vb = vb2_get_buffer(q, buffer);
>>   		if (!vb)
>>   			continue;
>>   
>> @@ -517,7 +550,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>   	/* Call driver-provided cleanup function for each buffer, if provided */
>>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>>   	     ++buffer) {
>> -		struct vb2_buffer *vb = q->bufs[buffer];
>> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>>   
>>   		if (vb && vb->planes[0].mem_priv)
>>   			call_void_vb_qop(vb, buf_cleanup, vb);
>> @@ -557,15 +590,20 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>   		q->cnt_unprepare_streaming = 0;
>>   	}
>>   	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
>> -		struct vb2_buffer *vb = q->bufs[buffer];
>> -		bool unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
>> -				  vb->cnt_mem_prepare != vb->cnt_mem_finish ||
>> -				  vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
>> -				  vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf ||
>> -				  vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf ||
>> -				  vb->cnt_buf_queue != vb->cnt_buf_done ||
>> -				  vb->cnt_buf_prepare != vb->cnt_buf_finish ||
>> -				  vb->cnt_buf_init != vb->cnt_buf_cleanup;
>> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>> +		bool unbalanced;
>> +
>> +		if (!vb)
>> +			continue;
>> +
>> +		unbalanced = vb->cnt_mem_alloc != vb->cnt_mem_put ||
>> +			     vb->cnt_mem_prepare != vb->cnt_mem_finish ||
>> +			     vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr ||
>> +			     vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf ||
>> +			     vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf ||
>> +			     vb->cnt_buf_queue != vb->cnt_buf_done ||
>> +			     vb->cnt_buf_prepare != vb->cnt_buf_finish ||
>> +			     vb->cnt_buf_init != vb->cnt_buf_cleanup;
>>   
>>   		if (unbalanced || debug) {
> I think we should drop the '|| debug' part. It is already annoying today to see these
> messages when the debug parameter is > 0, and now the number of buffers is still
> fairly small. But if we allow a lot more buffers, then this will really spam the
> kernel log.
>
> I think this should be dropped, and we only report unbalanced buffers.
>
> And another optimization is to only report the unbalanced counters. Right now
> it reports all counters, but it is again too much spamming of the kernel log.
>
> I think this change can be done as a separate patch before this patch.
> That way it can be picked up separately from the other changes in this series.
>
>>   			pr_info("   counters for queue %p, buffer %d:%s\n",
>> @@ -597,8 +635,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>   	/* Free vb2 buffers */
>>   	for (buffer = q->num_buffers - buffers; buffer < q->num_buffers;
>>   	     ++buffer) {
>> -		kfree(q->bufs[buffer]);
>> -		q->bufs[buffer] = NULL;
>> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>> +
>> +		if (!vb)
>> +			continue;
>> +
>> +		vb2_queue_remove_buffer(q, vb);
>> +		kfree(vb);
>>   	}
>>   
>>   	q->num_buffers -= buffers;
>> @@ -634,7 +677,12 @@ static bool __buffers_in_use(struct vb2_queue *q)
>>   {
>>   	unsigned int buffer;
>>   	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
>> -		if (vb2_buffer_in_use(q, q->bufs[buffer]))
>> +		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
>> +
>> +		if (!vb)
>> +			continue;
>> +
>> +		if (vb2_buffer_in_use(q, vb))
>>   			return true;
>>   	}
>>   	return false;
>> @@ -642,7 +690,10 @@ static bool __buffers_in_use(struct vb2_queue *q)
>>   
>>   void vb2_core_querybuf(struct vb2_queue *q, unsigned int index, void *pb)
>>   {
>> -	call_void_bufop(q, fill_user_buffer, q->bufs[index], pb);
>> +	struct vb2_buffer *vb = vb2_get_buffer(q, index);
>> +
>> +	if (vb)
>> +		call_void_bufop(q, fill_user_buffer, vb, pb);
> I think that rather than passing the index (that then has to be verified)
> it is better to pass the vb2_buffer pointer directly and leave it up to
> the caller to do the index verification.
>
> Another option is to drop this function altogether and let the called
> call the fill_user_buffer function. Either works for me.
>
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_querybuf);
>>   
>> @@ -1553,7 +1604,13 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
> Here too it is better to pass the vb2_buffer pointer instead of an index.
>
> This function assumes that the index is valid, so the called actually does the
> validation. Passing the vb pointer instead of the index makes more sense
> in this new situation.
>
> This is also true for two other core functions: vb2_core_qbuf and vb2_core_expbuf.
>
>>   	struct vb2_buffer *vb;
>>   	int ret;
>>   
>> -	vb = q->bufs[index];
>> +	vb = vb2_get_buffer(q, index);
>> +
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		return -EINVAL;
>> +	}
> Changing that avoids having to add this check, so it simplifies the code.
>
> I think that this change can be done in a separate patch before this one.
>
> It makes sense to apply that regardless of the remainder of this series.
>
>> +
>>   	if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>   		dprintk(q, 1, "invalid buffer state %s\n",
>>   			vb2_state_name(vb->state));
>> @@ -1624,7 +1681,11 @@ static int vb2_start_streaming(struct vb2_queue *q)
>>   		 * correctly return them to vb2.
>>   		 */
>>   		for (i = 0; i < q->num_buffers; ++i) {
>> -			vb = q->bufs[i];
>> +			vb = vb2_get_buffer(q, i);
>> +
>> +			if (!vb)
>> +				continue;
>> +
>>   			if (vb->state == VB2_BUF_STATE_ACTIVE)
>>   				vb2_buffer_done(vb, VB2_BUF_STATE_QUEUED);
>>   		}
>> @@ -1652,7 +1713,12 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
>>   		return -EIO;
>>   	}
>>   
>> -	vb = q->bufs[index];
>> +	vb = vb2_get_buffer(q, index);
>> +
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		return -EINVAL;
>> +	}
>>   
>>   	if (!req && vb->state != VB2_BUF_STATE_IN_REQUEST &&
>>   	    q->requires_requests) {
>> @@ -2028,12 +2094,18 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>>   	 * to vb2 in stop_streaming().
>>   	 */
>>   	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
>> -		for (i = 0; i < q->num_buffers; ++i)
>> -			if (q->bufs[i]->state == VB2_BUF_STATE_ACTIVE) {
>> +		for (i = 0; i < q->num_buffers; ++i) {
>> +			struct vb2_buffer *vb = vb2_get_buffer(q, i);
>> +
>> +			if (!vb)
>> +				continue;
>> +
>> +			if (vb->state == VB2_BUF_STATE_ACTIVE) {
>>   				pr_warn("driver bug: stop_streaming operation is leaving buf %p in active state\n",
>> -					q->bufs[i]);
>> -				vb2_buffer_done(q->bufs[i], VB2_BUF_STATE_ERROR);
>> +					vb);
>> +				vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
>>   			}
>> +		}
>>   		/* Must be zero now */
>>   		WARN_ON(atomic_read(&q->owned_by_drv_count));
>>   	}
>> @@ -2067,9 +2139,14 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>>   	 * be changed, so we can't move the buf_finish() to __vb2_dqbuf().
>>   	 */
>>   	for (i = 0; i < q->num_buffers; ++i) {
>> -		struct vb2_buffer *vb = q->bufs[i];
>> -		struct media_request *req = vb->req_obj.req;
>> +		struct vb2_buffer *vb;
>> +		struct media_request *req;
>> +
>> +		vb = vb2_get_buffer(q, i);
>> +		if (!vb)
>> +			continue;
>>   
>> +		req = vb->req_obj.req;
>>   		/*
>>   		 * If a request is associated with this buffer, then
>>   		 * call buf_request_cancel() to give the driver to complete()
>> @@ -2219,7 +2296,10 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
>>   	buffer = (off >> (PLANE_INDEX_SHIFT + PAGE_SHIFT)) & MAX_BUFFERS;
>>   	plane = (off >> PAGE_SHIFT) & PLANE_INDEX_MASK;
>>   
>> -	vb = q->bufs[buffer];
>> +	vb = vb2_get_buffer(q, buffer);
>> +	if (!vb)
>> +		return -EINVAL;
>> +
>>   	if (vb->planes[plane].m.offset == off) {
>>   		*_buffer = buffer;
>>   		*_plane = plane;
>> @@ -2262,7 +2342,12 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
>>   		return -EINVAL;
>>   	}
>>   
>> -	vb = q->bufs[index];
>> +	vb = vb2_get_buffer(q, index);
>> +
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		return -EINVAL;
>> +	}
>>   
>>   	if (plane >= vb->num_planes) {
>>   		dprintk(q, 1, "buffer plane out of range\n");
>> @@ -2339,7 +2424,13 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>>   	if (ret)
>>   		goto unlock;
>>   
>> -	vb = q->bufs[buffer];
>> +	vb = vb2_get_buffer(q, buffer);
>> +
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>>   
>>   	/*
>>   	 * MMAP requires page_aligned buffers.
>> @@ -2396,7 +2487,12 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
>>   	if (ret)
>>   		goto unlock;
>>   
>> -	vb = q->bufs[buffer];
>> +	vb = vb2_get_buffer(q, buffer);
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>>   
>>   	vaddr = vb2_plane_vaddr(vb, plane);
>>   	mutex_unlock(&q->mmap_lock);
>> @@ -2625,6 +2721,7 @@ struct vb2_fileio_data {
>>   static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   {
>>   	struct vb2_fileio_data *fileio;
>> +	struct vb2_buffer *vb;
>>   	int i, ret;
>>   	unsigned int count = 0;
>>   
>> @@ -2679,7 +2776,13 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   	 * Check if plane_count is correct
>>   	 * (multiplane buffers are not supported).
>>   	 */
>> -	if (q->bufs[0]->num_planes != 1) {
>> +	vb = vb2_get_buffer(q, 0);
>> +	if (!vb) {
>> +		ret = -EBUSY;
>> +		goto err_reqbufs;
>> +	}
> This cannot happen. These fileio helper functions implement the read() support
> and all the buffer allocation happens here. Userspace can never add or delete
> buffers later, so there will never be holes. It is safe to assume that
> vb2_get_buffer(q, i) will always return a valid vb pointer for i in the range
> of 0 - q->num_buffers-1.
>
> Perhaps add a comment to that effect, but otherwise you can drop the checks.
>
>> +
>> +	if (vb->num_planes != 1) {
>>   		ret = -EBUSY;
>>   		goto err_reqbufs;
>>   	}
>> @@ -2688,12 +2791,17 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   	 * Get kernel address of each buffer.
>>   	 */
>>   	for (i = 0; i < q->num_buffers; i++) {
>> -		fileio->bufs[i].vaddr = vb2_plane_vaddr(q->bufs[i], 0);
>> +		vb = vb2_get_buffer(q, i);
>> +
>> +		if (!vb)
>> +			continue;
>> +
>> +		fileio->bufs[i].vaddr = vb2_plane_vaddr(vb, 0);
>>   		if (fileio->bufs[i].vaddr == NULL) {
>>   			ret = -EINVAL;
>>   			goto err_reqbufs;
>>   		}
>> -		fileio->bufs[i].size = vb2_plane_size(q->bufs[i], 0);
>> +		fileio->bufs[i].size = vb2_plane_size(vb, 0);
>>   	}
>>   
>>   	/*
>> @@ -2821,15 +2929,18 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>   
>>   		fileio->cur_index = index;
>>   		buf = &fileio->bufs[index];
>> -		b = q->bufs[index];
>> +		b = vb2_get_buffer(q, index);
>> +
>> +		if (!b)
>> +			return -EINVAL;
>>   
>>   		/*
>>   		 * Get number of bytes filled by the driver
>>   		 */
>>   		buf->pos = 0;
>>   		buf->queued = 0;
>> -		buf->size = read ? vb2_get_plane_payload(q->bufs[index], 0)
>> -				 : vb2_plane_size(q->bufs[index], 0);
>> +		buf->size = read ? vb2_get_plane_payload(b, 0)
>> +				 : vb2_plane_size(b, 0);
>>   		/* Compensate for data_offset on read in the multiplanar case. */
>>   		if (is_multiplanar && read &&
>>   				b->planes[0].data_offset < buf->size) {
>> @@ -2872,8 +2983,12 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>   	 * Queue next buffer if required.
>>   	 */
>>   	if (buf->pos == buf->size || (!read && fileio->write_immediately)) {
>> -		struct vb2_buffer *b = q->bufs[index];
>> +		struct vb2_buffer *b = vb2_get_buffer(q, index);
>>   
>> +		if (!b) {
>> +			dprintk(q, 1, "can't find the requested buffer\n");
>> +			return -EINVAL;
>> +		}
>>   		/*
>>   		 * Check if this is the last buffer to read.
>>   		 */
>> @@ -2899,7 +3014,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>   		 */
>>   		buf->pos = 0;
>>   		buf->queued = 1;
>> -		buf->size = vb2_plane_size(q->bufs[index], 0);
>> +		buf->size = vb2_plane_size(b, 0);
>>   		fileio->q_count += 1;
>>   		/*
>>   		 * If we are queuing up buffers for the first time, then
>> @@ -2970,7 +3085,9 @@ static int vb2_thread(void *data)
>>   		 * Call vb2_dqbuf to get buffer back.
>>   		 */
>>   		if (prequeue) {
>> -			vb = q->bufs[index++];
>> +			vb = vb2_get_buffer(q, index++);
>> +			if (!vb)
>> +				continue;
>>   			prequeue--;
>>   		} else {
>>   			call_void_qop(q, wait_finish, q);
>> @@ -2979,7 +3096,7 @@ static int vb2_thread(void *data)
>>   			call_void_qop(q, wait_prepare, q);
>>   			dprintk(q, 5, "file io: vb2_dqbuf result: %d\n", ret);
>>   			if (!ret)
>> -				vb = q->bufs[index];
>> +				vb = vb2_get_buffer(q, index);
>>   		}
>>   		if (ret || threadio->stop)
>>   			break;
>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> index c7a54d82a55e..724135d41f7f 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> @@ -383,8 +383,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (q->bufs[b->index] == NULL) {
>> -		/* Should never happen */
>> +	if (!vb2_get_buffer(q, b->index)) {
>>   		dprintk(q, 1, "%s: buffer is NULL\n", opname);
> How about:
>
>    		dprintk(q, 1, "%s: buffer %u was deleted\n", opname, b->index);
>
> although perhaps that change is more appropriate in patch 09/10?
>
> Regardless, once it is possible to delete buffers, then this message should be
> adjusted accordingly.
>
>>   		return -EINVAL;
>>   	}
>> @@ -394,7 +393,7 @@ static int vb2_queue_or_prepare_buf(struct vb2_queue *q, struct media_device *md
>>   		return -EINVAL;
>>   	}
>>   
>> -	vb = q->bufs[b->index];
>> +	vb = vb2_get_buffer(q, b->index);
> This can be moved up to the 'if (!vb2_get_buffer(q, b->index)) {' check above.
> That avoids calling vb2_get_buffer twice.
>
>>   	vbuf = to_vb2_v4l2_buffer(vb);
>>   	ret = __verify_planes_array(vb, b);
>>   	if (ret)
>> @@ -628,11 +627,18 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
>>   struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>>   {
>>   	unsigned int i;
>> +	struct vb2_buffer *vb2;
>>   
>> -	for (i = 0; i < q->num_buffers; i++)
>> -		if (q->bufs[i]->copied_timestamp &&
>> -		    q->bufs[i]->timestamp == timestamp)
>> -			return vb2_get_buffer(q, i);
> Perhaps add a comment here that this loop doesn't scale if there
> is a really large number of buffers and something more efficient
> will have to be found in that case.
>
>> +	for (i = 0; i < q->num_buffers; i++) {
>> +		vb2 = vb2_get_buffer(q, i);
>> +
>> +		if (!vb2)
>> +			continue;
>> +
>> +		if (vb2->copied_timestamp &&
>> +		    vb2->timestamp == timestamp)
>> +			return vb2;
>> +	}
>>   	return NULL;
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_find_buffer);
>> @@ -664,7 +670,13 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
>>   		dprintk(q, 1, "buffer index out of range\n");
>>   		return -EINVAL;
>>   	}
>> -	vb = q->bufs[b->index];
>> +	vb = vb2_get_buffer(q, b->index);
>> +
>> +	if (!vb) {
>> +		dprintk(q, 1, "can't find the requested buffer\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	ret = __verify_planes_array(vb, b);
>>   	if (!ret)
>>   		vb2_core_querybuf(q, b->index, b);
>> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
>> index 982c2c777484..a462d6fe4ea9 100644
>> --- a/drivers/media/platform/amphion/vpu_dbg.c
>> +++ b/drivers/media/platform/amphion/vpu_dbg.c
>> @@ -140,11 +140,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>>   
>>   	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
>>   	for (i = 0; i < vq->num_buffers; i++) {
>> -		struct vb2_buffer *vb = vq->bufs[i];
>> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +		struct vb2_buffer *vb;
>> +		struct vb2_v4l2_buffer *vbuf;
>> +
>> +		vb = vb2_get_buffer(vq, i);
>> +		if (!vb)
>> +			continue;
>>   
>>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>>   			continue;
>> +
>> +		vbuf = to_vb2_v4l2_buffer(vb);
>> +
>>   		num = scnprintf(str, sizeof(str),
>>   				"output [%2d] state = %10s, %8s\n",
>>   				i, vb2_stat_name[vb->state],
>> @@ -155,11 +162,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>>   
>>   	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>>   	for (i = 0; i < vq->num_buffers; i++) {
>> -		struct vb2_buffer *vb = vq->bufs[i];
>> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>> +		struct vb2_buffer *vb;
>> +		struct vb2_v4l2_buffer *vbuf;
>> +
>> +		vb = vb2_get_buffer(vq, i);
>> +		if (!vb)
>> +			continue;
>>   
>>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>>   			continue;
>> +
>> +		vbuf = to_vb2_v4l2_buffer(vb);
>> +
>>   		num = scnprintf(str, sizeof(str),
>>   				"capture[%2d] state = %10s, %8s\n",
>>   				i, vb2_stat_name[vb->state],
> This can be a separate patch, right? It doesn't depend on any core changes.
>
> And this can also be applied before this patch.

Hans, I would like to clarify this comment (and the following Ditto).
Are you against use vb2_get_buffer() outside core ?
or testing vb2_get_buffer() result ?
The goal of this patch was to remove all access like vq->bufs[i] and to make
sure that vb buffer are always valid.

Regards,
Benjamin

>
>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> index 621038aab116..62910a1b8a98 100644
>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>> @@ -603,7 +603,11 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>>   		return -EINVAL;
>>   	}
>>   
>> -	vb = vq->bufs[buf->index];
>> +	vb = vb2_get_buffer(vq, buf->index);
>> +	if (!vb) {
>> +		dev_err(ctx->jpeg->dev, "buffer not found\n");
>> +		return -EINVAL;
>> +	}
>>   	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
>>   	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
>>   
> Ditto.
>
>> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>> index e393e3e668f8..3d2ae0e1b5b6 100644
>> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
>> @@ -1696,7 +1696,7 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
>>   
>>   	/* update internal buffer's width/height */
>>   	for (i = 0; i < vq->num_buffers; i++) {
>> -		if (vb == vq->bufs[i]) {
>> +		if (vb == vb2_get_buffer(vq, i)) {
>>   			instance->dpb[i].width = w;
>>   			instance->dpb[i].height = h;
>>   			break;
> Ditto.
>
>> diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> index 3a848ca32a0e..326be09bdb55 100644
>> --- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> +++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> @@ -577,6 +577,10 @@ static int hva_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>>   		}
>>   
>>   		vb2_buf = vb2_get_buffer(vq, buf->index);
>> +		if (!vb2_buf) {
>> +			dev_dbg(dev, "%s buffer index %d not found\n", ctx->name, buf->index);
>> +			return -EINVAL;
>> +		}
>>   		stream = to_hva_stream(to_vb2_v4l2_buffer(vb2_buf));
>>   		stream->bytesused = buf->bytesused;
>>   	}
> Ditto.
>
>> diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
>> index 318d675e5668..ba20ea998d19 100644
>> --- a/drivers/media/test-drivers/visl/visl-dec.c
>> +++ b/drivers/media/test-drivers/visl/visl-dec.c
>> @@ -290,13 +290,20 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>>   	for (i = 0; i < out_q->num_buffers; i++) {
>>   		char entry[] = "index: %u, state: %s, request_fd: %d, ";
>>   		u32 old_len = len;
>> -		char *q_status = visl_get_vb2_state(out_q->bufs[i]->state);
>> +		struct vb2_buffer *vb2;
>> +		char *q_status;
>> +
>> +		vb2 = vb2_get_buffer(out_q, i);
>> +		if (!vb2)
>> +			continue;
>> +
>> +		q_status = visl_get_vb2_state(vb2->state);
>>   
>>   		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>>   				 entry, i, q_status,
>> -				 to_vb2_v4l2_buffer(out_q->bufs[i])->request_fd);
>> +				 to_vb2_v4l2_buffer(vb2)->request_fd);
>>   
>> -		len += visl_fill_bytesused(to_vb2_v4l2_buffer(out_q->bufs[i]),
>> +		len += visl_fill_bytesused(to_vb2_v4l2_buffer(vb2),
>>   					   &buf[len],
>>   					   TPG_STR_BUF_SZ - len);
>>   
>> @@ -342,13 +349,20 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
>>   	len = 0;
>>   	for (i = 0; i < cap_q->num_buffers; i++) {
>>   		u32 old_len = len;
>> -		char *q_status = visl_get_vb2_state(cap_q->bufs[i]->state);
>> +		struct vb2_buffer *vb2;
>> +		char *q_status;
>> +
>> +		vb2 = vb2_get_buffer(cap_q, i);
>> +		if (!vb2)
>> +			continue;
>> +
>> +		q_status = visl_get_vb2_state(vb2->state);
>>   
>>   		len += scnprintf(&buf[len], TPG_STR_BUF_SZ - len,
>>   				 "index: %u, status: %s, timestamp: %llu, is_held: %d",
>> -				 cap_q->bufs[i]->index, q_status,
>> -				 cap_q->bufs[i]->timestamp,
>> -				 to_vb2_v4l2_buffer(cap_q->bufs[i])->is_held);
>> +				 vb2->index, q_status,
>> +				 vb2->timestamp,
>> +				 to_vb2_v4l2_buffer(vb2)->is_held);
>>   
>>   		tpg_gen_text(&ctx->tpg, basep, line++ * line_height, 16, &buf[old_len]);
>>   		frame_dprintk(ctx->dev, run->dst->sequence, "%s", &buf[old_len]);
> Ditto.
>
>> diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
>> index d2174156573a..4b65c69fa60d 100644
>> --- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
>> +++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
>> @@ -1061,7 +1061,7 @@ static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
>>   	if (ret)
>>   		return ret;
>>   
>> -	vb = pipe->vb_queue.bufs[buf->index];
>> +	vb = vb2_get_buffer(&pipe->vb_queue, buf->index);
>>   	frame = vb_to_frame(vb);
>>   
>>   	buf->reserved = asd->frame_status[buf->index];
> Ditto.
>
> Background: I think it is really useful to merge a lot of the groundwork early
> on, where possible. It simplifies the remainder of the patch series.
>
> Regards,
>
> 	Hans
>
