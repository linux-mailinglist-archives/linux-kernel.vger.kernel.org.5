Return-Path: <linux-kernel+bounces-39905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4B83D758
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9908229F088
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC79179AF;
	Fri, 26 Jan 2024 09:17:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C986FD1;
	Fri, 26 Jan 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260634; cv=none; b=E3APZjCuP2gwf0Tt21jJMWFXScb9aEuF2JLwDGneBN78kwcbcnRMD2GkAx4FnvTk2DVgz5NRqhHvBvBU1UvFZ4r0f6uqns36Qn/DTujz2BByAJSx5BiPzlUkowPfFLsbiYfMn3ajCQlLlhuQOs6W1ltyqGvJRDaA4cm01k8MbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260634; c=relaxed/simple;
	bh=qUQl16ag8gA3TCHOR31xrhpeVG7GQ9X7BApmSaJfwVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEfmv43h5IvAAqYj+nIZzeCfWq9CnPJYisiKcN/dusAtxhqw0RIFm5tdPlCHgKogSnzou50jyj+B0+OQe2eRxDhsln17i3CcXBCW5G4DUAF2h2cTgL9RRdOxooc8SE07mzKJHKVEUtaRnZNOl9ysQe4ER/v8CUPxuDWcWokJpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E83EC433F1;
	Fri, 26 Jan 2024 09:17:12 +0000 (UTC)
Message-ID: <326db4c8-4a54-4346-b443-c4cae4196da9@xs4all.nl>
Date: Fri, 26 Jan 2024 10:17:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 8/8] media: verisilicon: Support deleting buffers on
 capture queue
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20240119094944.26763-1-benjamin.gaignard@collabora.com>
 <20240119094944.26763-9-benjamin.gaignard@collabora.com>
 <56c1410e-7a4c-4913-823d-83b8bc0ac002@xs4all.nl>
 <1cd7c504-c384-4c9c-bedd-79cd8aed8484@collabora.com>
 <7b7170ced40d8fce4456282a87c5f70b66606d9c.camel@ndufresne.ca>
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <7b7170ced40d8fce4456282a87c5f70b66606d9c.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 17:27, Nicolas Dufresne wrote:
> Hi,
> 
> Le mercredi 24 janvier 2024 à 16:35 +0100, Benjamin Gaignard a écrit :
>> Le 24/01/2024 à 13:52, Hans Verkuil a écrit :
>>> On 19/01/2024 10:49, Benjamin Gaignard wrote:
>>>> Allow to delete buffers on capture queue because it the one which
>>>> own the decoded buffers. After a dynamic resolution change lot of
>>>> them could remain allocated but won't be used anymore so deleting
>>>> them save memory.
>>>> Do not add this feature on output queue because the buffers are
>>>> smaller, fewer and always recycled even after a dynamic resolution
>>>> change.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>   drivers/media/platform/verisilicon/hantro_drv.c  | 1 +
>>>>   drivers/media/platform/verisilicon/hantro_v4l2.c | 1 +
>>>>   2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>>>> index db3df6cc4513..f6b0a676a740 100644
>>>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>>>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>>>> @@ -248,6 +248,7 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>>>   	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>>>   	dst_vq->lock = &ctx->dev->vpu_mutex;
>>>>   	dst_vq->dev = ctx->dev->v4l2_dev.dev;
>>>> +	src_vq->supports_delete_bufs = true;
>>> As I mentioned, I remain unconvinced by this. It is just making the API inconsistent
>>> since if you support delete_bufs, then why support it for one queue only and not both?
>>
>> Because the both queues don't handle the same type of data.
>> For example for a stateless decoder, for me, it makes sense to allow delete decoded frames
>> if they won't be used anymore but that won't makes sense for bitstream buffers.
> 
> I personally think that for stateless and stateful decoder bitstream queue this
> can be useful. We currently guess the size we need, and there is no way to
> allocate bigger ones without the driver forgetting about reference frames.
> 
> In stateful, some drivers allow to split the bitstream (I tested wave5 notably),
> but I was told this is not always the case. A bit of a gray zone in that API,
> with lack of capabilities to describe it. On stateless, the entire bitstream
> slice must be in one buffer.
> 
> Though, for the asymmetry, most stateful decoders won't allow delete bufs on
> capture, because the buffers are registered in the firmware ahead of time. wave5
> can't even implement create_bufs on capture. We had an argument about having
> create_bufs on only one queue for that specific driver, as we wanted something
> upstream, we flex to removing create bufs completely. I think the all or nothing
> rule on per queue create/delete_bufs is not aligned with the reality.

I think the default should be that it supports DELETE_BUFS for both queues, but
it should still be possible to only have it on one queue.

When v18 is posted I want to play around with that, because I am not certain
what the easiest way is to implement this.

Another thing that needs to be added is a check that DELETE_BUFS is only enabled
if CREATE_BUFS is also present, it makes no sense otherwise.

Finally I want to take another look at the work required to make a CREATE_BUFS
replacement since that ioctl is horrible. Whether that will become part of this
series or done as a follow-up I am not sure about, but this series should definitely
make it possible to cleanly integrate it.

Regards,

	Hans

> 
> Nicolas
>>
>>>
>>>>   
>>>>   	return vb2_queue_init(dst_vq);
>>>>   }
>>>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> index 941fa23c211a..34eab90e8a42 100644
>>>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>>>> @@ -756,6 +756,7 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>>>>   	.vidioc_dqbuf = v4l2_m2m_ioctl_dqbuf,
>>>>   	.vidioc_prepare_buf = v4l2_m2m_ioctl_prepare_buf,
>>>>   	.vidioc_create_bufs = v4l2_m2m_ioctl_create_bufs,
>>>> +	.vidioc_delete_bufs = v4l2_m2m_ioctl_delete_bufs,
>>>>   	.vidioc_expbuf = v4l2_m2m_ioctl_expbuf,
>>>>   
>>>>   	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>>> In my view setting vidioc_delete_bufs should enable this feature, and if
>>> for some strange reason only one queue support it, then make a wrapper
>>> callback that returns an error when used with the wrong queue.
>>>
>>> Also note that patch 6/8 never checks for q->supports_delete_bufs in
>>> vb2_core_delete_bufs(), which is wrong!
>>
>> I will fix that in next version.
>> Regards,
>> Benjamin
>>
>>>
>>> Regards,
>>>
>>> 	Hans
>>>
>>
> 


