Return-Path: <linux-kernel+bounces-66265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD485597D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AF51F2C9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23C6FD2;
	Thu, 15 Feb 2024 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="c+cgp3Sk"
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9138D;
	Thu, 15 Feb 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967525; cv=none; b=MYSt5Q6EYzrA740cynMEyrZi3fZ96xT78JJez99P0Wxrn3D6rX9MzyQmvM7Oi6tMJiY1KCVipC+zhmhzqxoOVeqtQfgpBCxW2PQG86FwrICta07Ld17S/BSaeonHcj47hg1OZnhpN1wihWUc6iJJ6YQIY1sWg90+iJjNkeL6RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967525; c=relaxed/simple;
	bh=QRTneIcWg5vU9jdq7Rpt6DeMeZg1EmrsBxMFImT+B6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjUrMheGLfW/J84DEQs5gO+3iPjxVa/tanIvlUC/qHJ+8no8DdQKs8U/imDgtk0qSIRTcRShTYgk2MHfrQlNsbIh/OGiz8oCI61JrsIAUkBql9YMCtYkioELSeECOlY1XeGxXkCAJdSprxD6gf0hBJ4BGZ4OhkTbZZkow77IZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=c+cgp3Sk; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from [192.168.10.7] (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id EC2A12FE714;
	Thu, 15 Feb 2024 12:15:27 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info EC2A12FE714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1707966930; bh=aH50rFraaCRdc5hvH2MqbJ63B91M1/DEldo2KgKsQfo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c+cgp3SknYJ0XrDMF8TUzLl7RbtQaiobqy82PoTpL3e2pADa13V+m4AvZeYuX6b64
	 QW2rf9TfyWCM943Z7mp2TxEo3VapOemJ6o6GPz+WTT0dboIheS6CpkT2tvl2JwOPDl
	 Otd9Hx2RljBdRLx3UaH8rOmjkUALrcY/joEnAoFk=
Message-ID: <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
Date: Thu, 15 Feb 2024 11:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 Hsia-Jun Li <randy.li@synaptics.com>, sebastian.fricke@collabora.com,
 alexious@zju.edu.cn, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210180414.49184-1-randy.li@synaptics.com>
 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
Content-Language: en-US
From: Randy Li <ayaka@soulik.info>
In-Reply-To: <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/2/15 04:38, Nicolas Dufresne wrote:
> Hi,
>
>>   media: v4l2-mem2mem: fix mem order in last buf
> mem order ? Did you mean call order ?
std::memory_order
>
> Le dimanche 11 février 2024 à 02:04 +0800, Hsia-Jun Li a écrit :
>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>
>> The has_stopped property in struct v4l2_m2m_ctx is operated
>> without a lock protecction. Then the userspace calls to
>                   protection   When ?                   ~~
Access to those 3 booleans you mentioned later.
>> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
>> a critical section issue.
> As there is no locking, there is no critical section, perhaps a better phrasing
> could help.

"concurrent accesses to shared resources can lead to unexpected or 
erroneous behavior, so parts of the program where the shared resource is 
accessed need to be protected in ways that avoid the concurrent access."

It didn't say we need a lock here.

>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> index 75517134a5e9..f1de71031e02 100644
>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
>>   			       struct vb2_v4l2_buffer *vbuf)
>>   {
>>   	vbuf->flags |= V4L2_BUF_FLAG_LAST;
>> -	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>> -
>>   	v4l2_m2m_mark_stopped(m2m_ctx);
>> +
>> +	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
> While it most likely fix the issue while testing, since userspace most likely
> polls on that queue and don't touch the driver until the poll was signalled, I
> strongly believe this is insufficient. When I look at vicodec and wave5, they
> both add a layer of locking on top of the mem2mem framework to fix this issue.

Maybe a memory barrier is enough. Since vb2_buffer_done() itself would 
invoke the (spin)lock operation.

When the poll() returns in userspace, the future operation for those 
three boolean variables won't happen before the lock.

> I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 booleans
> accessed in many places that aren't in any known atomic context. I think it
> would be nice to remove the spurious locking in drivers and try and fix this
> issue in the framework itself.
I tend to not introduce more locks here. There is a spinlock in m2m_ctx 
which is a pain in the ass, something we could reuse it to save our CPU 
but it just can't be access.
>
> Nicolas
>
>>   }
>>   EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
>>   

