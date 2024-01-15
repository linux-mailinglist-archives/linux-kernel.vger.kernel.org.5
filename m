Return-Path: <linux-kernel+bounces-26146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB182DBED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F78B1C21B87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB91799D;
	Mon, 15 Jan 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VW24nS01"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C80175B2;
	Mon, 15 Jan 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705330378;
	bh=KQMB7mKdx5/qe7tsYUhh6uo1d+3USvCqx2LoeH99DVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VW24nS01X+PqwS/o1fPcSMENdVBl5GXQSpFDgYg8JF8mF0PEp33NUDWE6CIkktgDs
	 iOrBqLYT3zus82a2TzYAehbryvb5ZZIkyTqze9sc4EaPCUG42+Dx+6oF5ObpNHhIsS
	 U2mrSKKKkgkkh9bxtEUeseo5NYTnlOV+8ZOcZsbUnVT4SwraaSBN9imWB8aLKtShvj
	 6XKGz59/prAnggRA5eq3UWnjvj+3qFGOuh8DI+q6DsaV3SR7oOfTKy1tPceFVWWusv
	 TdFN/MiVrPeDAuzwbjc+X3CoAPZXAdHhzC+YfwOvSvhNisJzqTYqPrOhtCBibiKkV7
	 sDFWkttktDp6Q==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE1EC3781F80;
	Mon, 15 Jan 2024 14:52:57 +0000 (UTC)
Message-ID: <2d9296a1-1fbc-4d85-b147-90f8f10c8f5f@collabora.com>
Date: Mon, 15 Jan 2024 15:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/8] media: core: Rework how create_buf index returned
 value is computed
Content-Language: en-US
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20231215090813.15610-1-benjamin.gaignard@collabora.com>
 <20231215090813.15610-4-benjamin.gaignard@collabora.com>
 <ea069946-adb2-4ab2-b40a-06d11846d9ee@xs4all.nl>
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <ea069946-adb2-4ab2-b40a-06d11846d9ee@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 15/01/2024 à 13:11, Hans Verkuil a écrit :
> On 15/12/2023 10:08, Benjamin Gaignard wrote:
>> When DELETE_BUFS will be introduced holes could created in bufs array.
>> To be able to reuse these unused indices reworking how create->index
>> is set is mandatory.
>> Let __vb2_queue_alloc() decide which first index is correct and
>> forward this to the caller.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++-------
>>   .../media/common/videobuf2/videobuf2-v4l2.c   | 20 +++++++++++------
>>   include/media/videobuf2-core.h                |  5 ++++-
>>   3 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index a183edf11586..cd2b9e51b9b0 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -447,11 +447,12 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>>    */
>>   static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   			     unsigned int num_buffers, unsigned int num_planes,
>> -			     const unsigned plane_sizes[VB2_MAX_PLANES])
>> +			     const unsigned int plane_sizes[VB2_MAX_PLANES],
>> +			     unsigned int *first_index)
>>   {
>> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>>   	unsigned int buffer, plane;
>>   	struct vb2_buffer *vb;
>> +	unsigned long index;
>>   	int ret;
>>   
>>   	/*
>> @@ -459,7 +460,11 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   	 * in the queue is below q->max_num_buffers
>>   	 */
>>   	num_buffers = min_t(unsigned int, num_buffers,
>> -			    q->max_num_buffers - q_num_buffers);
>> +			    q->max_num_buffers - vb2_get_num_buffers(q));
>> +
>> +	index = vb2_get_num_buffers(q);
>> +
>> +	*first_index = index;
>>   
>>   	for (buffer = 0; buffer < num_buffers; ++buffer) {
>>   		/* Allocate vb2 buffer structures */
>> @@ -479,7 +484,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   			vb->planes[plane].min_length = plane_sizes[plane];
>>   		}
>>   
>> -		vb2_queue_add_buffer(q, vb, q_num_buffers + buffer);
>> +		vb2_queue_add_buffer(q, vb, index++);
>>   		call_void_bufop(q, init_buffer, vb);
>>   
>>   		/* Allocate video buffer memory for the MMAP type */
>> @@ -820,7 +825,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	unsigned int q_num_bufs = vb2_get_num_buffers(q);
>>   	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>>   	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
>> -	unsigned int i;
>> +	unsigned int i, first_index;
>>   	int ret = 0;
>>   
>>   	if (q->streaming) {
>> @@ -906,7 +911,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   
>>   	/* Finally, allocate buffers and video memory */
>>   	allocated_buffers =
>> -		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
>> +		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first_index);
>>   	if (allocated_buffers == 0) {
>>   		dprintk(q, 1, "memory allocation failed\n");
>>   		ret = -ENOMEM;
>> @@ -980,7 +985,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>>   int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   			 unsigned int flags, unsigned int *count,
>>   			 unsigned int requested_planes,
>> -			 const unsigned int requested_sizes[])
>> +			 const unsigned int requested_sizes[],
>> +			 unsigned int *first_index)
>>   {
>>   	unsigned int num_planes = 0, num_buffers, allocated_buffers;
>>   	unsigned plane_sizes[VB2_MAX_PLANES] = { };
>> @@ -1042,7 +1048,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   
>>   	/* Finally, allocate buffers and video memory */
>>   	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
>> -				num_planes, plane_sizes);
>> +				num_planes, plane_sizes, first_index);
>>   	if (allocated_buffers == 0) {
>>   		dprintk(q, 1, "memory allocation failed\n");
>>   		ret = -ENOMEM;
>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> index 54d572c3b515..3c0c423c5674 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>> @@ -797,11 +797,16 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
>>   	for (i = 0; i < requested_planes; i++)
>>   		if (requested_sizes[i] == 0)
>>   			return -EINVAL;
>> -	return ret ? ret : vb2_core_create_bufs(q, create->memory,
>> -						create->flags,
>> -						&create->count,
>> -						requested_planes,
>> -						requested_sizes);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = vb2_core_create_bufs(q, create->memory,
>> +				   create->flags,
>> +				   &create->count,
>> +				   requested_planes,
>> +				   requested_sizes,
>> +				   &create->index);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_create_bufs);
>>   
>> @@ -1029,15 +1034,16 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
>>   	int res = vb2_verify_memory_type(vdev->queue, p->memory,
>>   			p->format.type);
>>   
>> -	p->index = vdev->queue->num_buffers;
>>   	fill_buf_caps(vdev->queue, &p->capabilities);
>>   	validate_memory_flags(vdev->queue, p->memory, &p->flags);
> While reviewing this, I think I found a bug in the current code:
>
> vb2_create_bufs() sets V4L2_BUF_CAP_SUPPORTS_MAX_NUM_BUFFERS, but
> if p->count == 0, then that function isn't called...
>
>>   	/*
>>   	 * If count == 0, then just check if memory and type are valid.
>>   	 * Any -EBUSY result from vb2_verify_memory_type can be mapped to 0.
>>   	 */
>> -	if (p->count == 0)
>> +	if (p->count == 0) {
>> +		p->index = vb2_get_num_buffers(vdev->queue);
>>   		return res != -EBUSY ? res : 0;
> ...instead it just falls in this 'if'.
>
> It would be better to refactor this so that vb2_ioctl_create_bufs()
> relies on vb2_create_bufs for most of the work.
>
> The reason for the messy code is that if p->count == 0, then it
> should ignore any EBUSY results, since that should always work.
>
> Alternatively, just copy the code from vb2_create_bufs here so the
> flag is properly set.
>
> In any case, fixing this is a separate patch that should go to v6.8.

Do you want this new patch to be in the next version of this series or completely
separated ?

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>> +	}
>>   	if (res)
>>   		return res;
>>   	if (vb2_queue_is_busy(vdev->queue, file))
>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>> index 7b84b4e2e273..607f2ba7a905 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -821,6 +821,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>    * @count: requested buffer count.
>>    * @requested_planes: number of planes requested.
>>    * @requested_sizes: array with the size of the planes.
>> + * @first_index: index of the first created buffer, all allocated buffers have
>> + *		 indices in the range [first..first+count]
>>    *
>>    * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
>>    * called internally by VB2 by an API-specific handler, like
>> @@ -837,7 +839,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   			 unsigned int flags, unsigned int *count,
>>   			 unsigned int requested_planes,
>> -			 const unsigned int requested_sizes[]);
>> +			 const unsigned int requested_sizes[],
>> +			 unsigned int *first_index);
>>   
>>   /**
>>    * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace

