Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9977A8699
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjITObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjITObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:31:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC95B9;
        Wed, 20 Sep 2023 07:31:02 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:def9:8f6c:3807:7d89] (unknown [IPv6:2a01:e0a:120:3210:def9:8f6c:3807:7d89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC9F76600B9D;
        Wed, 20 Sep 2023 15:31:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695220261;
        bh=qSxCMCW4YAsLR2FIqziFq6kIetJZ96LBazqTUvh3JSE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WwrgS797Z2sNCnhv7CF1QbkVYbXZWXZWW2Semdqrfj+CIOX8RAUG9urjunXsJpaUQ
         bhVQ1YJ/5HxJFiNaUgv+0UcMAClUThvV12CgUsSFeZdmXoLcT7taol1Y1aUZHuSgmO
         lWQaJnofjNTAYvkLRInzcET0Mxkwi9LU8AeJ+lRgsVeG5pMMO+Sg67LUvRuhlrzVKQ
         9lo/eIi+TUiMzBpG/6Fn5HBpgPHoepBFlI7145/QTAFhtHJgqYH64P5tdv8rVzQBnh
         2JTNKf8SrZvLXd0dvZqgyMcHg0H+TN9IUKPF/HbGafOIVtJt/RDYhg0RGKmJM40G/+
         7Ekw+hJKYoTBA==
Message-ID: <20b6b93e-eef8-3d7b-a3c2-795f220059d4@collabora.com>
Date:   Wed, 20 Sep 2023 16:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 45/49] media: core: Add bitmap manage bufs array
 entries
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
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-46-benjamin.gaignard@collabora.com>
 <1142bbb4-b8f1-44ec-962e-9347a231782f@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <1142bbb4-b8f1-44ec-962e-9347a231782f@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/09/2023 à 17:00, Hans Verkuil a écrit :
> On 14/09/2023 15:33, Benjamin Gaignard wrote:
>> Add a bitmap field to know which of bufs array entries are
>> used or not.
>> Remove no more used num_buffers field from queue structure.
>> Use bitmap_find_next_zero_area() to find the first possible
>> range when creating new buffers to fill the gaps.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   .../media/common/videobuf2/videobuf2-core.c   | 55 +++++++++++++++----
>>   include/media/videobuf2-core.h                |  9 ++-
>>   2 files changed, 51 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index a4c2fae8705d..c5d4a388331b 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -411,10 +411,11 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>>    */
>>   static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>>   {
>> -	if (index < q->max_allowed_buffers && !q->bufs[index]) {
>> +	if (index < q->max_allowed_buffers && !test_bit(index, q->bufs_map)) {
> I think bufs_bitmap would be a better name.

Ok I will change it

>
>>   		q->bufs[index] = vb;
>>   		vb->index = index;
>>   		vb->vb2_queue = q;
>> +		set_bit(index, q->bufs_map);
>>   		return true;
>>   	}
>>   
>> @@ -428,9 +429,10 @@ static bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>>    */
>>   static void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
>>   {
>> -	if (vb->index < q->max_allowed_buffers) {
>> +	if (vb->index < q->max_allowed_buffers && test_bit(vb->index, q->bufs_map)) {
> As mentioned in past reviews, I think these tests can be dropped, it makes no
> sense that these ever fail.

I will drop them.

>
>>   		q->bufs[vb->index] = NULL;
>>   		vb->vb2_queue = NULL;
>> +		clear_bit(vb->index, q->bufs_map);
>>   	}
>>   }
>>   
>> @@ -451,11 +453,12 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>>   	unsigned long first_index;
>>   	int ret;
>>   
>> -	/* Ensure that q->num_buffers+num_buffers is below q->max_allowed_buffers */
>> +	/* Ensure that the number of already queue + num_buffers is below q->max_allowed_buffers */
> Hmm, how about:
>
> 	/* Ensure that vb2_get_num_buffers(q) + num_buffers is no more than q->max_allowed_buffers */

sure

>
>>   	num_buffers = min_t(unsigned int, num_buffers,
>>   			    q->max_allowed_buffers - vb2_get_num_buffers(q));
>>   
>> -	first_index = vb2_get_num_buffers(q);
>> +	first_index = bitmap_find_next_zero_area(q->bufs_map, q->max_allowed_buffers,
>> +						 0, num_buffers, 0);
>>   
>>   	if (first_index >= q->max_allowed_buffers)
>>   		return 0;
>> @@ -675,7 +678,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>>   
>>   struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q, unsigned int index)
>>   {
>> -	if (index < q->num_buffers)
>> +	if (!q->bufs_map || !q->bufs)
>> +		return NULL;
> I don't think this can ever happen.

I got kernel crash without them.
I will keep them.

>
>> +
>> +	if (index >= q->max_allowed_buffers)
>> +		return NULL;
>> +
>> +	if (test_bit(index, q->bufs_map))
>>   		return q->bufs[index];
>>   	return NULL;
>>   }
>> @@ -683,7 +692,10 @@ EXPORT_SYMBOL_GPL(vb2_get_buffer);
>>   
>>   unsigned int vb2_get_num_buffers(struct vb2_queue *q)
>>   {
>> -	return q->num_buffers;
>> +	if (!q->bufs_map)
>> +		return 0;
> Ditto.
>
>> +
>> +	return bitmap_weight(q->bufs_map, q->max_allowed_buffers);
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_get_num_buffers);
>>   
>> @@ -899,6 +911,14 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   		q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
>>   	if (!q->bufs)
>>   		ret = -ENOMEM;
>> +
>> +	if (!q->bufs_map)
>> +		q->bufs_map = bitmap_zalloc(q->max_allowed_buffers, GFP_KERNEL);
>> +	if (!q->bufs_map) {
>> +		ret = -ENOMEM;
>> +		kfree(q->bufs);
>> +		q->bufs = NULL;
>> +	}
>>   	q->memory = memory;
>>   	mutex_unlock(&q->mmap_lock);
>>   	if (ret)
>> @@ -968,7 +988,6 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	}
>>   
>>   	mutex_lock(&q->mmap_lock);
>> -	q->num_buffers = allocated_buffers;
>>   
>>   	if (ret < 0) {
>>   		/*
>> @@ -995,6 +1014,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	mutex_lock(&q->mmap_lock);
>>   	q->memory = VB2_MEMORY_UNKNOWN;
>>   	mutex_unlock(&q->mmap_lock);
>> +	kfree(q->bufs);
>> +	q->bufs = NULL;
>> +	bitmap_free(q->bufs_map);
>> +	q->bufs_map = NULL;
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
>> @@ -1031,9 +1054,19 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   		q->memory = memory;
>>   		if (!q->bufs)
>>   			q->bufs = kcalloc(q->max_allowed_buffers, sizeof(*q->bufs), GFP_KERNEL);
>> -		if (!q->bufs)
>> +		if (!q->bufs) {
>> +			ret = -ENOMEM;
>> +			goto unlock;
>> +		}
>> +		if (!q->bufs_map)
>> +			q->bufs_map = bitmap_zalloc(q->max_allowed_buffers, GFP_KERNEL);
>> +		if (!q->bufs_map) {
>>   			ret = -ENOMEM;
>> +			kfree(q->bufs);
>> +			q->bufs = NULL;
>> +		}
>>   		mutex_unlock(&q->mmap_lock);
>> +unlock:
>>   		if (ret)
>>   			return ret;
>>   		q->waiting_for_buffers = !q->is_output;
>> @@ -1095,7 +1128,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	}
>>   
>>   	mutex_lock(&q->mmap_lock);
>> -	q->num_buffers += allocated_buffers;
>>   
>>   	if (ret < 0) {
>>   		/*
>> @@ -2588,6 +2620,9 @@ void vb2_core_queue_release(struct vb2_queue *q)
>>   	__vb2_queue_free(q, q->max_allowed_buffers);
>>   	kfree(q->bufs);
>>   	q->bufs = NULL;
>> +	bitmap_free(q->bufs_map);
>> +	q->bufs_map = NULL;
>> +
>>   	mutex_unlock(&q->mmap_lock);
>>   }
>>   EXPORT_SYMBOL_GPL(vb2_core_queue_release);
>> @@ -2944,7 +2979,7 @@ static size_t __vb2_perform_fileio(struct vb2_queue *q, char __user *data, size_
>>   	 * Check if we need to dequeue the buffer.
>>   	 */
>>   	index = fileio->cur_index;
>> -	if (index >= q->num_buffers) {
>> +	if (!test_bit(index, q->bufs_map)) {
>>   		struct vb2_buffer *b;
>>   
>>   		/*
>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>> index 19c93d8eb7c8..734437236cc4 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -557,7 +557,7 @@ struct vb2_buf_ops {
>>    * @memory:	current memory type used
>>    * @dma_dir:	DMA mapping direction.
>>    * @bufs:	videobuf2 buffer structures
>> - * @num_buffers: number of allocated/used buffers
>> + * @bufs_map:	bitmap to manage bufs entries.
>>    * @max_allowed_buffers: upper limit of number of allocated/used buffers
>>    * @queued_list: list of buffers currently queued from userspace
>>    * @queued_count: number of buffers queued and ready for streaming.
>> @@ -621,7 +621,7 @@ struct vb2_queue {
>>   	unsigned int			memory;
>>   	enum dma_data_direction		dma_dir;
>>   	struct vb2_buffer		**bufs;
>> -	unsigned int			num_buffers;
>> +	unsigned long			*bufs_map;
>>   	unsigned int			max_allowed_buffers;
>>   
>>   	struct list_head		queued_list;
>> @@ -1151,7 +1151,10 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>>    */
>>   static inline bool vb2_is_busy(struct vb2_queue *q)
>>   {
>> -	return (q->num_buffers > 0);
>> +	if (!q->bufs_map)
>> +		return false;
> I don't think this can happen.
>
>> +
>> +	return (bitmap_weight(q->bufs_map, q->max_allowed_buffers) > 0);
> How about:
>
> 	return vb2_get_num_buffers(q) > 0;

vb2_get_num_buffers is defined in videobuf2-core.c, I'm not sure that
an inline function could depend of a module function.

Regards,
Benjamin

>
>>   }
>>   
>>   /**
> Regards,
>
> 	Hans
>
