Return-Path: <linux-kernel+bounces-106145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75287E9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF02820DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF6238DF2;
	Mon, 18 Mar 2024 13:06:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F338385;
	Mon, 18 Mar 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767198; cv=none; b=eCDkf2vW3Etp6rsl6m3LhArWj24ZXYgmMGPMi9nXNcpgqwqEU1uxgfgKWB+7zAKCaWDZiwpnzqzAmDHyZZyvZxXD4j7k9jSL6BnmOQEOxUjjODte9NoFKl1xtiOsWeQF2qu31W6bPpdMfOygm4VFBrwCMgE3T7X86bbiqVoaxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767198; c=relaxed/simple;
	bh=WrAEeEsm2dnWpOkvKTcEiN05vIFPd1XTg8CXuJ0xj24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iw5GfTA3CZu8nfQ9VvAJ0FcSqnpazVUISjUUKuzMF7SOcxXyYMApV0lZgv3XZt7hEqdffxyPhNUIjgmzYU/B6BTFPEDzY7DNkiWqNSc/soNOsXNSu3k9tlnYdhCHmAy4pr64xxccAnwYfN+jDnBtxtxDFjjVz7ugjm+YCF8yDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA6C43390;
	Mon, 18 Mar 2024 13:06:34 +0000 (UTC)
Message-ID: <00fe576e-df97-4cae-9937-d8e9272cf5e0@xs4all.nl>
Date: Mon, 18 Mar 2024 14:06:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 3/9] media: test-drivers: Set REQBUFS minimum number
 of buffers
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org,
 tfiga@chromium.org, m.szyprowski@samsung.com, ezequiel@vanguardiasur.com.ar,
 p.zabel@pengutronix.de, nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
 <20240314153226.197445-4-benjamin.gaignard@collabora.com>
 <43d27ed7-94ff-4916-b1f3-07204b2f54ab@xs4all.nl>
In-Reply-To: <43d27ed7-94ff-4916-b1f3-07204b2f54ab@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 11:06 am, Hans Verkuil wrote:
> Hi Benjamin,
> 
> On 14/03/2024 4:32 pm, Benjamin Gaignard wrote:
>> Instead of using 'min_queued_buffers' field to specify the
>> minimum number of buffers to be allocated when calling REQBUF
>> use 'min_reqbufs_allocation' field which is dedicated to this
>> purpose.
>>
>> While at it rename vivid_create_queue() parameter.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>  drivers/media/test-drivers/vimc/vimc-capture.c | 2 +-
>>  drivers/media/test-drivers/vivid/vivid-core.c  | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
>> index 2a2d19d23bab..97693561f1e4 100644
>> --- a/drivers/media/test-drivers/vimc/vimc-capture.c
>> +++ b/drivers/media/test-drivers/vimc/vimc-capture.c
>> @@ -432,7 +432,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
>>  	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
>>  		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
>>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> -	q->min_queued_buffers = 2;
>> +	q->min_reqbufs_allocation = 2;
>>  	q->lock = &vcapture->lock;
>>  	q->dev = v4l2_dev->dev;
>>  
>> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
>> index 159c72cbb5bf..11b8520d9f57 100644
>> --- a/drivers/media/test-drivers/vivid/vivid-core.c
>> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
>> @@ -861,7 +861,7 @@ static const struct media_device_ops vivid_media_ops = {
>>  static int vivid_create_queue(struct vivid_dev *dev,
>>  			      struct vb2_queue *q,
>>  			      u32 buf_type,
>> -			      unsigned int min_queued_buffers,
>> +			      unsigned int min_reqbufs_allocation,
>>  			      const struct vb2_ops *ops)
>>  {
>>  	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE && dev->multiplanar)
>> @@ -898,7 +898,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
>>  	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
>>  						  &vb2_vmalloc_memops;
>>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> -	q->min_queued_buffers = supports_requests[dev->inst] ? 0 : min_queued_buffers;
>> +	q->min_reqbufs_allocation = min_reqbufs_allocation;
>>  	q->lock = &dev->mutex;
>>  	q->dev = dev->v4l2_dev.dev;
>>  	q->supports_requests = supports_requests[dev->inst];
> 
> How did you test this series? If I run the test-media script using the patch
> v4l2-compliance (the v9 series) I get two failures. Both are traced to code
> in vivid: meta_out_queue_setup() and touch_cap_queue_setup():
> 
> Both have this code:
> 
>         if (*nplanes) {
>                 if (sizes[0] < size)
>                         return -EINVAL;
>         } else {
>                 sizes[0] = size;
>         }
> 
>         if (q_num_bufs + *nbuffers < 2)
>                 *nbuffers = 2 - q_num_bufs;
> 
>         *nplanes = 1;
>         return 0;
> 
> It's the *nbuffers assignment that is wrong. Looking at vivid-core.c I see
> that vivid_create_queue() is called with min_reqbufs_allocation set to 1 for
> these two devices. I think that should be 2, and then the code above can
> be dropped.

Note that if that 'if (q_num_bufs + *nbuffers < 2)' is dropped, then you
should also drop the q_num_bufs assignment at the beginning of the function
since that is now no longer used.

Regards,

	Hans

> 
> It is probably best to post a v21.1 3/9 patch only.
> 
> Regards,
> 
> 	Hans
> 
> 
> 


