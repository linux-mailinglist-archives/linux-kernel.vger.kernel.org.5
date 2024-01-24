Return-Path: <linux-kernel+bounces-37269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF86783AD89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A8D1F221F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60807C083;
	Wed, 24 Jan 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hp5K+VmK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6627A73A;
	Wed, 24 Jan 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110759; cv=none; b=YTkrq8/Feb16h8zU5n5nJ1/FD8keTdn1xaiT1ETtrWY2iuVuNDVbmsOwbnWyX2y2+qmWJRDnZ6uOw/F7yfQPAjCX0pY/GyLjCFzLphF7Kxxeruf9/AaQZuzJhvwHoKjIAyc+XnpXvM2g/h7PxAe9Sz+PSbV9qxzhmt4frOWOZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110759; c=relaxed/simple;
	bh=hc4wzRn+HPe6CX5z3svV7CtMNGCVeM7/COQFs/wm/P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TMGjUi7rJGdUfnHtDpr5ba+ggd8LpFD0svjh+9JIsUvmAXBj99YPAclJqLuiac/SAwtEdZVou8NpAyDV8128OEBfv5fgaWUhuyAAKnNTpZAB2QxRUuCcGr/ar7JhajTXu0kqPOeLnTIqGC5mulM25Xve0foZpEKyaktnXBBMzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hp5K+VmK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OFcpxb028401;
	Wed, 24 Jan 2024 09:38:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706110731;
	bh=VYB3w4Afxxk7ZxsxdbFHBZxDZtm5HgnyDACANemk/HA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hp5K+VmKgMzCKiox/P8x7IRTHKtASxB052sR4Tup5FjEQPF8LXNfrGzXpPpmO1WyA
	 h/nAmltZNEkjMHmioMJp4Ue8ppOU6DRRH/o0WIR/jCqg+8XSfv0q8k+Gqg1Na9p6KQ
	 KrXHZl0M85XdaCaUHmS7EqS+raifOrClXnFlZe1M=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OFcpJv019724
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 09:38:51 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 09:38:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 09:38:51 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OFcoKX129004;
	Wed, 24 Jan 2024 09:38:50 -0600
Message-ID: <715efa1f-c3a4-4952-b72c-ca7f466e3ccb@ti.com>
Date: Wed, 24 Jan 2024 09:38:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH v5 1/6] dma-buf: Add
 dma_buf_{begin,end}_access()
To: Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?=
	<ckoenig.leichtzumerken@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal
	<sumit.semwal@linaro.org>
CC: Daniel Vetter <daniel@ffwll.ch>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        <linux-doc@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>, <linux-media@vger.kernel.org>
References: <20240119141402.44262-1-paul@crapouillou.net>
 <20240119141402.44262-2-paul@crapouillou.net>
 <8035f515-591f-4c87-bf0a-23d5705d9b1c@gmail.com>
 <442f69f31ece6d441f3dc41c3dfeb4dcf52c00b8.camel@crapouillou.net>
 <0b6b8738-9ea3-44fa-a624-9297bd55778f@amd.com>
 <e4620acdf24628d904cedcb0030d78b14559f337.camel@crapouillou.net>
 <85a89505-edeb-4619-86c1-157f7abdd190@amd.com>
 <0fe2755fb320027234c086bcc88fd107855234c5.camel@crapouillou.net>
 <577501f9-9d1c-4f8d-9882-7c71090e5ef3@amd.com>
 <7928c0866ac5b2bfaaa56ad3422bedc9061e0f7b.camel@crapouillou.net>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <7928c0866ac5b2bfaaa56ad3422bedc9061e0f7b.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 4:58 AM, Paul Cercueil wrote:
> Hi Christian,
> 
> Le mardi 23 janvier 2024 à 14:28 +0100, Christian König a écrit :
>>   Am 23.01.24 um 14:02 schrieb Paul Cercueil:
>>   
>>> [SNIP]
>>>   
>>>>   
>>>>>    
>>>>>>   
>>>>>> That an exporter has to call extra functions to access his
>>>>>> own
>>>>>> buffers
>>>>>> is a complete no-go for the design since this forces
>>>>>> exporters
>>>>>> into
>>>>>> doing extra steps for allowing importers to access their
>>>>>> data.
>>>>>>   
>>>>>   
>>>>> Then what about we add these dma_buf_{begin,end}_access(), with
>>>>> only
>>>>> implementations for "dumb" exporters e.g. udmabuf or the dmabuf
>>>>> heaps?
>>>>> And only importers (who cache the mapping and actually care
>>>>> about
>>>>> non-
>>>>> coherency) would have to call these.
>>>>>   
>>>>   
>>>> No, the problem is still that you would have to change all
>>>> importers
>>>> to
>>>> mandatory use dma_buf_begin/end.
>>>>
>>>> But going a step back caching the mapping is irrelevant for
>>>> coherency.
>>>> Even if you don't cache the mapping you don't get coherency.
>>>>   
>>>   
>>> You actually do - at least with udmabuf, as in that case
>>> dma_buf_map_attachment() / dma_buf_unmap_attachment() will handle
>>> cache
>>> coherency when the SGs are mapped/unmapped.
>>>   
>>   
>>   Well I just double checked the source in 6.7.1 and I can't see
>> udmabuf doing anything for cache coherency in map/unmap.
>>   
>>   All it does is calling dma_map_sgtable() and dma_unmap_sgtable() to
>> create and destroy the SG table and those are not supposed to sync
>> anything to the CPU cache.
>>   
>>   In other words drivers usually use DMA_ATTR_SKIP_CPU_SYNC here, it's
>> just that this is missing from udmabuf.
> 
> Ok.
>   
>>>   
>>> The problem was then that dma_buf_unmap_attachment cannot be called
>>> before the dma_fence is signaled, and calling it after is already
>>> too
>>> late (because the fence would be signaled before the data is
>>> sync'd).
>>>   
>>   
>>   Well what sync are you talking about? CPU sync? In DMA-buf that is
>> handled differently.
>>   
>>   For importers it's mandatory that they can be coherent with the
>> exporter. That usually means they can snoop the CPU cache if the
>> exporter can snoop the CPU cache.
> 
> I seem to have such a system where one device can snoop the CPU cache
> and the other cannot. Therefore if I want to support it properly, I do
> need cache flush/sync. I don't actually try to access the data using
> the CPU (and when I do, I call the sync start/end ioctls).
> 

If you don't access the data using the CPU, then how did the data
end up in the CPU caches? If you have a device that can write-allocate
into your CPU cache, but some other device in the system cannot snoop
that data back out then that is just broken and those devices cannot
reasonably share buffers..

Now we do have systems where some hardware can snoop CPU(or L3) caches
and others cannot, but they will not *allocate* into those caches
(unless they also have the ability to sync them without CPU in the loop).

Your problem may be if you are still using udmabuf driver as your
DMA-BUF exporter, which as said before is broken (and I just sent some
patches with a few fixes just for you :)). For udmabuf, data starts
in the CPU domain (in caches) and is only ever synced for the CPU,
not for attached devices. So in this case the writing device might
update those cache lines but a non-snooping reader would never see
those updates.

I'm not saying there isn't a need for these new {begin,end}_access()
functions. I can think of a few interesting usecases, but as you
say below that would be good to work out in a different series.

Andrew

> 
>>   For exporters you can implement the begin/end CPU access functions
>> which allows you to implement something even if your exporting device
>> can't snoop the CPU cache.
> 
> That only works if the importers call the begin_cpu_access() /
> end_cpu_access(), which they don't.
> 
>   
>>> Daniel / Sima suggested then that I cache the mapping and add new
>>> functions to ensure cache coherency, which is what these patches
>>> are
>>> about.
>>>   
>>   
>>   Yeah, I've now catched up on the latest mail. Sorry I haven't seen
>> that before.
>>   
>>   
>>>   
>>>
>>>   
>>>>   
>>>> In other words exporters are not require to call sync_to_cpu or
>>>> sync_to_device when you create a mapping.
>>>>
>>>> What exactly is your use case here? And why does coherency
>>>> matters?
>>>>   
>>>   
>>> My use-case is, I create DMABUFs with udmabuf, that I attach to
>>> USB/functionfs with the interface introduced by this patchset. I
>>> attach
>>> them to IIO with a similar interface (being upstreamed in
>>> parallel),
>>> and transfer data from USB to IIO and vice-versa in a zero-copy
>>> fashion.
>>>
>>> This works perfectly fine as long as the USB and IIO hardware are
>>> coherent between themselves, which is the case on most of our
>>> boards.
>>> However I do have a board (with a Xilinx Ultrascale SoC) where it
>>> is
>>> not the case, and cache flushes/sync are needed. So I was trying to
>>> rework these new interfaces to work on that system too.
>>>   
>>   
>>   Yeah, that sounds strongly like one of the use cases we have
>> rejected so far.
>>   
>>   
>>   
>>>   
>>> If this really is a no-no, then I am fine with the assumption that
>>> devices sharing a DMABUF must be coherent between themselves; but
>>> that's something that should probably be enforced rather than
>>> assumed.
>>>
>>> (and I *think* there is a way to force coherency in the
>>> Ultrascale's
>>> interconnect - we're investigating it)
>>>   
>>   
>>   What you can do is that instead of using udmabuf or dma-heaps is
>> that the device which can't provide coherency act as exporters of the
>> buffers.
>>   
>>   The exporter is allowed to call sync_for_cpu/sync_for_device on it's
>> own buffers and also gets begin/end CPU access notfications. So you
>> can then handle coherency between the exporter and the CPU.
> 
> But again that would only work if the importers would call
> begin_cpu_access() / end_cpu_access(), which they don't, because they
> don't actually access the data using the CPU.
> 
> Unless you mean that the exporter can call sync_for_cpu/sync_for_device
> before/after every single DMA transfer so that the data appears
> coherent to the importers, without them having to call
> begin_cpu_access() / end_cpu_access().
> 
> In which case - this would still demultiply the complexity; my USB-
> functionfs interface here (and IIO interface in the separate patchset)
> are not device-specific, so I'd rather keep them importers.
>   
>>   If you really don't have coherency between devices then that would
>> be a really new use case and we would need much more agreement on how
>> to do this.
> 
> [snip]
> 
> Agreed. Desiging a good generic solution would be better.
> 
> With that said...
> 
> Let's keep it out of this USB-functionfs interface for now. The
> interface does work perfectly fine on platforms that don't have
> coherency problems. The coherency issue in itself really is a
> tangential issue.
> 
> So I will send a v6 where I don't try to force the cache coherency -
> and instead assume that the attached devices are coherent between
> themselves.
> 
> But it would be even better to have a way to detect non-coherency and
> return an error on attach.
> 
> Cheers,
> -Paul

