Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE137E57E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjKHNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKHNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:22:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258CD1BEB;
        Wed,  8 Nov 2023 05:22:29 -0800 (PST)
Received: from [100.98.136.55] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E32426607688;
        Wed,  8 Nov 2023 13:22:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699449746;
        bh=keD3VyqIJlhYmPuf+KK0sz1/ewEuRUY/RM4hVjgaOp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MwnTr5tcEQ07rPmnL49bOTZBbbQXEUauQoH2hUWxYbWcILkRRUHUGI+Kfwl8ujTxZ
         X4NCiUOcZm6WGTwyNOEhNKmlPDSdYiQa33CK8x1nkxlIiBch3d4/XzOlWPFnLa5NLf
         DU3wE9CeONVPiXLY8WlLrse6MTAfW5H133jRPkgl8BpVQQbAOJQ7n5DHZQxRj9f2+l
         l0FyE14pIAevipTGcZMCmgHgo8AVIHH/u3b1yP/NE7MtKeXc6GG7BC0byfzYgDhaID
         9GFhzt8Utp/MjoIgT7L9sXnqyM13OUMoRyelQZNp9OyqInMCoEE0OyK4s/pjimKzzR
         zlas5P2+2Irxw==
Message-ID: <adc94476-8188-4569-8a39-2a1fb6b2f9dc@collabora.com>
Date:   Wed, 8 Nov 2023 14:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/56] media: videobuf2: Use vb2_get_num_buffers()
 helper
Content-Language: en-US
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-9-benjamin.gaignard@collabora.com>
 <20231108094223.rprskkeee47vaezy@chromium.org>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20231108094223.rprskkeee47vaezy@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/11/2023 à 10:42, Tomasz Figa a écrit :
> On Tue, Oct 31, 2023 at 05:30:16PM +0100, Benjamin Gaignard wrote:
>> Stop using queue num_buffers field directly, instead use
>> vb2_get_num_buffers().
>> This prepares for the future 'delete buffers' feature where there are
>> holes in the buffer indices.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 92 +++++++++++--------
>>   .../media/common/videobuf2/videobuf2-v4l2.c   |  4 +-
>>   2 files changed, 54 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index b406a30a9b35..c5c5ae4d213d 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -444,13 +444,14 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   			     unsigned int num_buffers, unsigned int num_planes,
>>   			     const unsigned plane_sizes[VB2_MAX_PLANES])
>>   {
>> +	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>>   	unsigned int buffer, plane;
>>   	struct vb2_buffer *vb;
>>   	int ret;
>>   
>>   	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
>>   	num_buffers = min_t(unsigned int, num_buffers,
>> -			    VB2_MAX_FRAME - q->num_buffers);
>> +			    VB2_MAX_FRAME - q_num_buffers);
> I guess it's safe in this specific situation, but was there any reason
> behind not just calling vb2_get_num_buffers() directly here?
>
>>   
>>   	for (buffer = 0; buffer < num_buffers; ++buffer) {
>>   		/* Allocate vb2 buffer structures */
>> @@ -470,7 +471,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   			vb->planes[plane].min_length = plane_sizes[plane];
>>   		}
>>   
>> -		vb2_queue_add_buffer(q, vb, q->num_buffers + buffer);
>> +		vb2_queue_add_buffer(q, vb, q_num_buffers + buffer);
> In this case it should also be fine, but actually now this is a loop and if
> somone doesn't know what the other code in the loop does, one could be
> concerned that the num buffers actually could have changed, but we still
> use the cached one that we got at the beginning of the function.
>
> (Ideally I'd imagine vb2_queue_add_buffer() to append the buffer
> at the end of the queue and increment the num_buffers internally, but it
> doesn't have to happen now, as this series is already quite complex...)

That will be the case later in the series when I replace num_buffers field
by a bitmap. Until that I prefer to limit the changes in this loop.

>
>>   		call_void_bufop(q, init_buffer, vb);
>>   
>>   		/* Allocate video buffer memory for the MMAP type */
> [snip]
>> @@ -2513,7 +2519,8 @@ void vb2_core_queue_release(struct vb2_queue *q)
>>   	__vb2_cleanup_fileio(q);
>>   	__vb2_queue_cancel(q);
>>   	mutex_lock(&q->mmap_lock);
>> -	__vb2_queue_free(q, q->num_buffers);
>> +	__vb2_queue_free(q, vb2_get_num_buffers(q));
>> +	q->num_buffers = 0;
> Unrelated change?

No because I found a case where q->num_buffers wasn't correctly reset while testing.

>
>>   	mutex_unlock(&q->mmap_lock);
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>> @@ -2542,7 +2549,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
>>   	/*
>>   	 * Start file I/O emulator only if streaming API has not been used yet.
>>   	 */
>> -	if (q->num_buffers == 0 && !vb2_fileio_is_active(q)) {
>> +	if (vb2_get_num_buffers(q) == 0 && !vb2_fileio_is_active(q)) {
>>   		if (!q->is_output && (q->io_modes & VB2_READ) &&
>>   				(req_events & (EPOLLIN | EPOLLRDNORM))) {
>>   			if (__vb2_init_fileio(q, 1))
>> @@ -2580,7 +2587,7 @@ __poll_t vb2_core_poll(struct vb2_queue *q, struct file *file,
>>   	 * For output streams you can call write() as long as there are fewer
>>   	 * buffers queued than there are buffers available.
>>   	 */
>> -	if (q->is_output && q->fileio && q->queued_count < q->num_buffers)
>> +	if (q->is_output && q->fileio && q->queued_count < vb2_get_num_buffers(q))
>>   		return EPOLLOUT | EPOLLWRNORM;
>>   
>>   	if (list_empty(&q->done_list)) {
>> @@ -2629,8 +2636,8 @@ struct vb2_fileio_buf {
>>    * struct vb2_fileio_data - queue context used by file io emulator
>>    *
>>    * @cur_index:	the index of the buffer currently being read from or
>> - *		written to. If equal to q->num_buffers then a new buffer
>> - *		must be dequeued.
>> + *		written to. If equal to number of already queued buffers
>> + *		then a new buffer must be dequeued.
> Hmm, that's a significant meaning change compared to the original text. Is
> it indended?

Does "If equal to number of buffers in the vb2_queue then a new buffer must be dequeued."
sound better for you ?

>
>>    * @initial_index: in the read() case all buffers are queued up immediately
>>    *		in __vb2_init_fileio() and __vb2_perform_fileio() just cycles
>>    *		buffers. However, in the write() case no buffers are initially
>> @@ -2640,7 +2647,7 @@ struct vb2_fileio_buf {
>>    *		buffers. This means that initially __vb2_perform_fileio()
>>    *		needs to know what buffer index to use when it is queuing up
>>    *		the buffers for the first time. That initial index is stored
>> - *		in this field. Once it is equal to q->num_buffers all
>> + *		in this field. Once it is equal to num_buffers all
> It's not clear what num_buffers means here. Would it make sense to instead
> say "number of buffers in the vb2_queue"?

Yes I will change that

>
>>    *		available buffers have been queued and __vb2_perform_fileio()
>>    *		should start the normal dequeue/queue cycle.
>>    *
>> @@ -2690,7 +2697,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   	/*
>>   	 * Check if streaming api has not been already activated.
>>   	 */
>> -	if (q->streaming || q->num_buffers > 0)
>> +	if (q->streaming || vb2_get_num_buffers(q) > 0)
>>   		return -EBUSY;
>>   
>>   	/*
>> @@ -2740,7 +2747,7 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   	/*
>>   	 * Get kernel address of each buffer.
>>   	 */
>> -	for (i = 0; i < q->num_buffers; i++) {
>> +	for (i = 0; i < vb2_get_num_buffers(q); i++) {
>>   		/* vb can never be NULL when using fileio. */
>>   		vb = vb2_get_buffer(q, i);
>>   
>> @@ -2759,18 +2766,23 @@ static int __vb2_init_fileio(struct vb2_queue *q, int read)
>>   		/*
>>   		 * Queue all buffers.
>>   		 */
>> -		for (i = 0; i < q->num_buffers; i++) {
>> -			ret = vb2_core_qbuf(q, q->bufs[i], NULL, NULL);
>> +		for (i = 0; i < vb2_get_num_buffers(q); i++) {
>> +			struct vb2_buffer *vb2 = vb2_get_buffer(q, i);
>> +
>> +			if (!vb2)
>> +				continue;
>> +
>> +			ret = vb2_core_qbuf(q, vb2, NULL, NULL);
>>   			if (ret)
>>   				goto err_reqbufs;
>>   			fileio->bufs[i].queued = 1;
>>   		}
> Doesn't this part belong to the previous patch that changes q->bufs[x] to
> vb2_get_buffer()?

Yes I will change that too.

>
>>   		/*
>>   		 * All buffers have been queued, so mark that by setting
>> -		 * initial_index to q->num_buffers
>> +		 * initial_index to num_buffers
> What num_buffers?

I will use your wording: "the number of buffers in the vb2_queue"

>
>>   		 */
>> -		fileio->initial_index = q->num_buffers;
>> -		fileio->cur_index = q->num_buffers;
>> +		fileio->initial_index = vb2_get_num_buffers(q);
>> +		fileio->cur_index = fileio->initial_index;
>>   	}
>>   
>>   	/*
>> @@ -2964,12 +2976,12 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>   		 * If we are queuing up buffers for the first time, then
>>   		 * increase initial_index by one.
>>   		 */
>> -		if (fileio->initial_index < q->num_buffers)
>> +		if (fileio->initial_index < vb2_get_num_buffers(q))
>>   			fileio->initial_index++;
>>   		/*
>>   		 * The next buffer to use is either a buffer that's going to be
>> -		 * queued for the first time (initial_index < q->num_buffers)
>> -		 * or it is equal to q->num_buffers, meaning that the next
>> +		 * queued for the first time (initial_index < num_buffers)
>> +		 * or it is equal to num_buffers, meaning that the next
> What num_buffers?

Same here

>
> Best regards,
> Tomasz
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
