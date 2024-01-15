Return-Path: <linux-kernel+bounces-26145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30B82DBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A041C21C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639E717745;
	Mon, 15 Jan 2024 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yxGVM2oC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42621802F;
	Mon, 15 Jan 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705330302;
	bh=g+StIxvq82tSJvUDXgISma5Vkpx6YsoK57uQwS4s7j0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yxGVM2oCjZsKYoxjdfGj6f5jokak+3DjRR/OH5eQQVzBV/Tupld/28Va8IyZZpoyF
	 Wu6dtCWDgJUNmqQZJ+zy+GGg03TNhrbazV7eD2gw3Q8ROWqnqFbRF0SXLhoggE0EKA
	 rwFZJ6PbMBEKMBom2M7wVyJIqBBNgFz3npO0URqBg2OYrZaeWR1BkC9LX6CtowH9Uj
	 oXUe5BlLZNqCS/zGPIMSYBJgZcbgFc44CoiiCX5WVTRZCPBgBr0Pukbhddj08tmd99
	 fyj2PuIN/y3TNtEtWCXjjwaMUfPy3ua6wDl4Yov3b6G5rdTMqaJWpNGA/GDsfLMxtp
	 MqiR+4fJD9Itg==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A89053781F80;
	Mon, 15 Jan 2024 14:51:41 +0000 (UTC)
Message-ID: <8f683397-f0e2-4701-9a4b-5b5c32d25915@collabora.com>
Date: Mon, 15 Jan 2024 15:51:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 4/8] media: core: Add bitmap manage bufs array entries
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
 <20231215090813.15610-5-benjamin.gaignard@collabora.com>
 <94e9f612-5daf-414a-a8b9-26330e697884@xs4all.nl>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <94e9f612-5daf-414a-a8b9-26330e697884@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/01/2024 à 13:21, Hans Verkuil a écrit :
> On 15/12/2023 10:08, Benjamin Gaignard wrote:
>> Add a bitmap field to know which of bufs array entries are
>> used or not.
>> Remove no more used num_buffers field from queue structure.
>> Use bitmap_find_next_zero_area() to find the first possible
>> range when creating new buffers to fill the gaps.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 37 ++++++++++++++++---
>>   include/media/videobuf2-core.h                | 17 +++++----
>>   2 files changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index cd2b9e51b9b0..9509535a980c 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -421,11 +421,12 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>>    */
>>   static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>>   {
>> -	WARN_ON(index >= q->max_num_buffers || q->bufs[index] || vb->vb2_queue);
>> +	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
>>   
>>   	q->bufs[index] = vb;
>>   	vb->index = index;
>>   	vb->vb2_queue = q;
>> +	set_bit(index, q->bufs_bitmap);
>>   }
>>   
>>   /**
>> @@ -434,6 +435,7 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>>    */
>>   static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>>   {
>> +	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
>>   	vb->vb2_queue->bufs[vb->index] = NULL;
>>   	vb->vb2_queue = NULL;
>>   }
>> @@ -462,7 +464,8 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   	num_buffers = min_t(unsigned int, num_buffers,
>>   			    q->max_num_buffers - vb2_get_num_buffers(q));
>>   
>> -	index = vb2_get_num_buffers(q);
>> +	index = bitmap_find_next_zero_area(q->bufs_bitmap, q->max_num_buffers,
>> +					   0, num_buffers, 0);
> Shouldn't this check if this call fails to find an area of 'num_buffers' 0-bits?
> Or, alternatively, keep reducing num_buffers until it finds a free range. I'm
> not sure what is best.

I will add a check on the return value. If it can't allocate the requested number of buffers
it will fail. Userspace can decide if it wants to try allocated less buffers or not.

>>   
>>   	*first_index = index;
>>   
>> @@ -664,7 +667,6 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>   		kfree(vb);
>>   	}
>>   
>> -	q->num_buffers -= buffers;
>>   	if (!vb2_get_num_buffers(q)) {
>>   		q->memory = VB2_MEMORY_UNKNOWN;
>>   		INIT_LIST_HEAD(&q->queued_list);
>> @@ -882,6 +884,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   		q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
>>   	if (!q->bufs)
>>   		ret = -ENOMEM;
>> +
>> +	if (!q->bufs_bitmap)
>> +		q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
>> +	if (!q->bufs_bitmap) {
>> +		ret = -ENOMEM;
>> +		kfree(q->bufs);
>> +		q->bufs = NULL;
>> +	}
>>   	q->memory = memory;
>>   	mutex_unlock(&q->mmap_lock);
>>   	if (ret)
>> @@ -951,7 +961,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	}
>>   
>>   	mutex_lock(&q->mmap_lock);
>> -	q->num_buffers = allocated_buffers;
>>   
>>   	if (ret < 0) {
>>   		/*
>> @@ -978,6 +987,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	mutex_lock(&q->mmap_lock);
>>   	q->memory = VB2_MEMORY_UNKNOWN;
>>   	mutex_unlock(&q->mmap_lock);
>> +	kfree(q->bufs);
>> +	q->bufs = NULL;
>> +	bitmap_free(q->bufs_bitmap);
>> +	q->bufs_bitmap = NULL;
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>> @@ -1014,9 +1027,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   		q->memory = memory;
>>   		if (!q->bufs)
>>   			q->bufs = kcalloc(q->max_num_buffers, sizeof(*q->bufs), GFP_KERNEL);
>> -		if (!q->bufs)
>> +		if (!q->bufs) {
>>   			ret = -ENOMEM;
>> +			goto unlock;
>> +		}
>> +		if (!q->bufs_bitmap)
>> +			q->bufs_bitmap = bitmap_zalloc(q->max_num_buffers, GFP_KERNEL);
>> +		if (!q->bufs_bitmap) {
>> +			ret = -ENOMEM;
>> +			kfree(q->bufs);
>> +			q->bufs = NULL;
>> +		}
> The same code is used in reqbufs and create_bufs, so perhaps creating a helper
> function is better.

I will add vb2_core_allocated_queue_buffers_storage() and vb2_core_free_queue_buffers_storage().

>
>>   		mutex_unlock(&q->mmap_lock);
>> +unlock:
>>   		if (ret)
>>   			return ret;
>>   		q->waiting_for_buffers = !q->is_output;
>> @@ -1078,7 +1101,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	}
>>   
>>   	mutex_lock(&q->mmap_lock);
>> -	q->num_buffers += allocated_buffers;
>>   
>>   	if (ret < 0) {
>>   		/*
>> @@ -2567,6 +2589,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
>>   	__vb2_queue_free(q, vb2_get_num_buffers(q));
>>   	kfree(q->bufs);
>>   	q->bufs = NULL;
>> +	bitmap_free(q->bufs_bitmap);
>> +	q->bufs_bitmap = NULL;
>> +
> And perhaps also a helper function to free the memory.
>
>>   	mutex_unlock(&q->mmap_lock);
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>> index 607f2ba7a905..e4c1fc7ae82f 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -346,8 +346,8 @@ struct vb2_buffer {
>>    *			describes the requested number of planes and sizes\[\]
>>    *			contains the requested plane sizes. In this case
>>    *			\*num_buffers are being allocated additionally to
>> - *			q->num_buffers. If either \*num_planes or the requested
>> - *			sizes are invalid callback must return %-EINVAL.
>> + *			the buffers already in the queue. If either \*num_planes
> already in the queue -> already allocated
>
>> + *			or the requested sizes are invalid callback must return %-EINVAL.
>>    * @wait_prepare:	release any locks taken while calling vb2 functions;
>>    *			it is called before an ioctl needs to wait for a new
>>    *			buffer to arrive; required to avoid a deadlock in
>> @@ -572,7 +572,7 @@ struct vb2_buf_ops {
>>    * @memory:	current memory type used
>>    * @dma_dir:	DMA mapping direction.
>>    * @bufs:	videobuf2 buffer structures
>> - * @num_buffers: number of allocated/used buffers
>> + * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
>>    * @max_num_buffers: upper limit of number of allocated/used buffers.
>>    *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
>>    *		     for backward compatibility.
>> @@ -639,7 +639,7 @@ struct vb2_queue {
>>   	unsigned int			memory;
>>   	enum dma_data_direction		dma_dir;
>>   	struct vb2_buffer		**bufs;
>> -	unsigned int			num_buffers;
>> +	unsigned long			*bufs_bitmap;
>>   	unsigned int			max_num_buffers;
>>   
>>   	struct list_head		queued_list;
>> @@ -1168,7 +1168,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>>    */
>>   static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>>   {
>> -	return q->num_buffers;
>> +	if (!q->bufs_bitmap)
>> +		return 0;
>> +
>> +	return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
> I'd invert the test:
>
> 	if (q->bufs_bitmap)
> 		return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
> 	return 0;
>
> It's a little bit easier to read.
>
>>   }
>>   
>>   /**
>> @@ -1271,13 +1274,13 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
>>   static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>>   						unsigned int index)
>>   {
>> -	if (!q->bufs)
>> +	if (!q->bufs_bitmap)
> Can you ever have q->bufs set, but not q->bufs_bitmap?
>
> I think the original check is just fine.
>
> It is probably a good idea to perhaps clarify this in the @bufs documentation:
> if it is non-NULL, then bufs_bitmap is also non-NULL.
>
> And ensure that where you allocate and assign these fields that bufs_bitmap
> is always non-NULL when assigning q->bufs. Then it is enough to just test
> q->bufs to be certain both bufs and bufs_bitmap are non-NULL.

I will add that in the documentation.

>
>>   		return NULL;
>>   
>>   	if (index >= q->max_num_buffers)
>>   		return NULL;
>>   
>> -	if (index < q->num_buffers)
>> +	if (test_bit(index, q->bufs_bitmap))
>>   		return q->bufs[index];
>>   	return NULL;
>>   }
> Adding support for deleting buffers also causes a odd change in behavior
> of CREATE_BUFS w.r.t. the index field of struct v4l2_create_buffers:
> when adding new buffers, the index field is indeed the starting buffer index,
> as per the documentation. But if count == 0, then the index field returns
> the total number of allocated buffers, which is really something different.
>
> I think the documentation of VIDIOC_CREATE_BUFS should be updated to clearly
> state that if count == 0, then 'index' is set to the total number of
> allocated buffers.
>
> I really hate VIDIOC_CREATE_BUFS, and I do plan an RFC with a proposal for
> an alternative API.
>
> Regards,
>
> 	Hans
>

