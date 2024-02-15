Return-Path: <linux-kernel+bounces-66437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22A855CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F6F1C22253
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8113AC6;
	Thu, 15 Feb 2024 08:41:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A38134AE;
	Thu, 15 Feb 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986516; cv=none; b=IsJTngyAQF4MMmrb+sAX330cnmzk6zRAXFcgnIc990pp1w028OaX9NpkLGZpRD74kEp6dEQWlRTtUNlOIM5ODz45/JtcwNFkGZzXGkQSdJHf6SGWTovxxMWk4mE4y9oSlOav1kWkhLx0e6h6smCIGTL4pQXdgEl6ad+jaft7gMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986516; c=relaxed/simple;
	bh=PcyfrcT0IrCS8x6Y/PVw4INOqDeIejn279MqRbP73tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrrmWbf/ETatMxXkbHSMHIzQ0kMLUytfsahg4KC44zrAa1xtZna5SvF6Rl1IxA7DNl1AFxleWCEeit8bJV5wOQ1c5WAPuRm7FS/bCn38jp6DUlOMAHFrOvuNyxVD3hI4HqrnRS6Q95gx4DlqDCOavoIV4nIaRQx5uCkjwm+4L5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E5C433C7;
	Thu, 15 Feb 2024 08:41:54 +0000 (UTC)
Message-ID: <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
Date: Thu, 15 Feb 2024 09:41:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
Content-Language: en-US, nl
To: Randy Li <ayaka@soulik.info>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: mchehab@kernel.org, Hsia-Jun Li <randy.li@synaptics.com>,
 sebastian.fricke@collabora.com, alexious@zju.edu.cn,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210180414.49184-1-randy.li@synaptics.com>
 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/02/2024 04:16, Randy Li wrote:
> 
> On 2024/2/15 04:38, Nicolas Dufresne wrote:
>> Hi,
>>
>>>   media: v4l2-mem2mem: fix mem order in last buf
>> mem order ? Did you mean call order ?
> std::memory_order
>>
>> Le dimanche 11 février 2024 à 02:04 +0800, Hsia-Jun Li a écrit :
>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>
>>> The has_stopped property in struct v4l2_m2m_ctx is operated
>>> without a lock protecction. Then the userspace calls to
>>                   protection   When ?                   ~~
> Access to those 3 booleans you mentioned later.
>>> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
>>> a critical section issue.
>> As there is no locking, there is no critical section, perhaps a better phrasing
>> could help.
> 
> "concurrent accesses to shared resources can lead to unexpected or erroneous behavior, so parts of the program where the shared resource is accessed need to be protected in ways that avoid the
> concurrent access."
> 
> It didn't say we need a lock here.
> 
>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>> ---
>>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> index 75517134a5e9..f1de71031e02 100644
>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
>>>                      struct vb2_v4l2_buffer *vbuf)
>>>   {
>>>       vbuf->flags |= V4L2_BUF_FLAG_LAST;
>>> -    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>> -
>>>       v4l2_m2m_mark_stopped(m2m_ctx);
>>> +
>>> +    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>> While it most likely fix the issue while testing, since userspace most likely
>> polls on that queue and don't touch the driver until the poll was signalled, I
>> strongly believe this is insufficient. When I look at vicodec and wave5, they
>> both add a layer of locking on top of the mem2mem framework to fix this issue.
> 
> Maybe a memory barrier is enough. Since vb2_buffer_done() itself would invoke the (spin)lock operation.
> 
> When the poll() returns in userspace, the future operation for those three boolean variables won't happen before the lock.
> 
>> I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 booleans
>> accessed in many places that aren't in any known atomic context. I think it
>> would be nice to remove the spurious locking in drivers and try and fix this
>> issue in the framework itself.
> I tend to not introduce more locks here. There is a spinlock in m2m_ctx which is a pain in the ass, something we could reuse it to save our CPU but it just can't be access.

I think the root cause is something else.

Let me say first of all that swapping the order of the two calls does make sense:
before returning the buffer you want to mark the queue as stopped.

But the real problem is that for drivers using the mem2mem framework the streaming
ioctls can be serialized with a different lock than the VIDIOC_DE/ENCODER_CMD ioctls.

The reason for that is that those two ioctls are not marked with INFO_FL_QUEUE,
but I think they should. These ioctls are really part of the streaming ioctls
and should all use the same lock.

Note that for many drivers the same mutex is used for the streaming ioctls as for
all other ioctls, but it looks like at least the venus driver uses separate mutexes.

With that change in v4l2-core/v4l2-ioctl.c I don't believe any locking is needed,
since it should always be serialized by the same top-level mutex.

The v4l2_ioctl_get_lock() function in v4l2-ioctl.c is the one that selects which
mutex to use for a given ioctl.

Regards,

	Hans

>>
>> Nicolas
>>
>>>   }
>>>   EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
>>>   
> 


