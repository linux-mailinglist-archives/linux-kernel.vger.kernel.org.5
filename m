Return-Path: <linux-kernel+bounces-15277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D86822989
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0562D1F23DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235921862B;
	Wed,  3 Jan 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qRLTwsB3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CA18059;
	Wed,  3 Jan 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704271140;
	bh=xsmykOdkIhuKuexFzsVHGF2s5riGySaSQQKSPkKqjOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qRLTwsB3PydZSeVdhpEFKuwCZjl9rRrJkua+MZqf5k/jh7O/oekeyGPhyQNL1YO7R
	 fkpaS57swJzLaKz+tkwlVqS3w3t2EXQYeKO/E7t6ir3H4NeOQhPxFXGn7ns9xENt04
	 LXN7v7+LDglx3cuEKErRL5Gd4j8gxz1S0cD04PWpp9sQcIdIQz1mu8BYVf/fLDwaEn
	 0IdMtLmKUKoU6QhdJ2UbQpBKWsPcBgtMy6XTPTXhQJiCZYwRQEWiqdhurh4YVDjbrA
	 fg+6z+OSXk9TH4DUzgTCJKZKQP6cL1nDU1VAqRDrvrMijlGM0cfUzXccM0Lfhu0F3X
	 Ry4LU12r+X0Ng==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C15E3780480;
	Wed,  3 Jan 2024 08:39:00 +0000 (UTC)
Message-ID: <9245aafe-b165-45de-8363-fab246fb6c16@collabora.com>
Date: Wed, 3 Jan 2024 09:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] videobuf2: core: Rename min_buffers_needed field
 to vb2_queue
To: Tomasz Figa <tfiga@chromium.org>
Cc: hverkuil@xs4all.nl, mchehab@kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 kernel@collabora.com
References: <20231211133251.150999-1-benjamin.gaignard@collabora.com>
 <20231211133251.150999-2-benjamin.gaignard@collabora.com>
 <20231226082349.x5ebvmt5dpanrm4k@chromium.org>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20231226082349.x5ebvmt5dpanrm4k@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 26/12/2023 à 09:23, Tomasz Figa a écrit :
> Hi Benjamin,
>
> On Mon, Dec 11, 2023 at 02:32:49PM +0100, Benjamin Gaignard wrote:
>> Rename min_buffers_needed into min_queued_buffers and update
>> the documentation about it.
>>
> Sorry for being late to the party. I think this is generally a good idea,
> thanks for doing this! Just one comment inline.
>
> [snip]
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 40d89f29fa33..8912dff5bde3 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	/*
>>   	 * Make sure the requested values and current defaults are sane.
>>   	 */
>> -	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
>> +	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers + 1);
> Where does this + 1 come from here?
> Agreed with Hans that this change deserves its own patch with a proper
> explanation in its description.

Hans have merged this patch without this line.
Since I still aiming to add delete buffers feature I have include this change
in this series:
https://www.spinics.net/lists/linux-media/msg246289.html

Regards,
Benjamin

>
>>   	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>>   	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>>   	/*
>> @@ -917,7 +917,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	 * There is no point in continuing if we can't allocate the minimum
>>   	 * number of buffers needed by this vb2_queue.
>>   	 */
>> -	if (allocated_buffers < q->min_buffers_needed)
>> +	if (allocated_buffers < q->min_queued_buffers)
>>   		ret = -ENOMEM;
>>   
>>   	/*
>> @@ -1653,7 +1653,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>    * @q:		videobuf2 queue
>>    *
>>    * Attempt to start streaming. When this function is called there must be
>> - * at least q->min_buffers_needed buffers queued up (i.e. the minimum
>> + * at least q->min_queued_buffers queued up (i.e. the minimum
>>    * number of buffers required for the DMA engine to function). If the
>>    * @start_streaming op fails it is supposed to return all the driver-owned
>>    * buffers back to vb2 in state QUEUED. Check if that happened and if
>> @@ -1846,7 +1846,7 @@ int vb2_core_qbuf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb,
>>   	 * then we can finally call start_streaming().
>>   	 */
>>   	if (q->streaming && !q->start_streaming_called &&
>> -	    q->queued_count >= q->min_buffers_needed) {
>> +	    q->queued_count >= q->min_queued_buffers) {
>>   		ret = vb2_start_streaming(q);
>>   		if (ret) {
>>   			/*
>> @@ -2210,9 +2210,9 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (q_num_bufs < q->min_buffers_needed) {
>> -		dprintk(q, 1, "need at least %u allocated buffers\n",
>> -				q->min_buffers_needed);
>> +	if (q_num_bufs < q->min_queued_buffers) {
>> +		dprintk(q, 1, "need at least %u queued buffers\n",
> Note that the value being checked here is the number of allocated buffers,
> not queued buffers. So basically we're enforcing here that at the time
> STREAMON is called, there is enough buffers allocated to queue the minimum
> number of buffers to start streaming, but then later down we're not
> actually enforcing that they are queued - if not, the queue start_streaming
> operation is deferred until enough buffers are queued.
>
> The question is: Do we really want this to be an error? Or should we just
> be consistent with the allocated-but-not-queued case and let the
> application allocate more buffers later using CREATE_BUFS?
> (Another question: How does an application know how many buffers to
> allocate for STREAMON to work?)
>
> That said, this doesn't really affect the correctness of the patch itself.
> Just some additional oddity in the current implementation that we could
> simplify in the future.
>
>> +			q->min_queued_buffers);
>>   		return -EINVAL;
>>   	}
>>   
> [snip]
>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>> index 5557d78b6f20..f9a00b6c3c46 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -546,10 +546,13 @@ struct vb2_buf_ops {
>>    * @gfp_flags:	additional gfp flags used when allocating the buffers.
>>    *		Typically this is 0, but it may be e.g. %GFP_DMA or %__GFP_DMA32
>>    *		to force the buffer allocation to a specific memory zone.
>> - * @min_buffers_needed: the minimum number of buffers needed before
>> + * @min_queued_buffers: the minimum number of queued buffers needed before
>>    *		@start_streaming can be called. Used when a DMA engine
>>    *		cannot be started unless at least this number of buffers
>>    *		have been queued into the driver.
>> + *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers + 1
>> + *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
>> + *		modify the requested buffer count.
> Same here, this + 1 needs a proper explanation.
> Also, I don't like this API inconsistency where REQBUFS guarantees the
> right number of buffers, but CREATE_BUFS doesn't. In fact, would an
> application have a way to know how many buffers to allocate if it simply
> wants to use CREATE_BUFS?
>
> (It's generally related to the oddity that I pointed out above. Maybe we
> should let the allocation code only handle allocation constraints and not
> care about STREAMON constraints?)
>
> [snip]
>
> Best regards,
> Tomasz

