Return-Path: <linux-kernel+bounces-88886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510486E7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ED81C25A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136020DCB;
	Fri,  1 Mar 2024 18:04:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D817BA4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316254; cv=none; b=ZUfPenXxsEu7KOXdqwbpxU9dunrE0Vvmfps/aXkk1cRISOffeOXWiyobBv/k/oeNyuEw6LccgTVgwgbkvDrjgW4LjTauGf62toxlOlCJW/cllhqslsiqEu7Nenxns/9nfvNjZhqoae6tT7fJ0hAr+ddBTaLYgE1c1oGIQfcjjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316254; c=relaxed/simple;
	bh=wm1vvnyXKFgcFNI7otyHTbvXDz55V2VsO09wlIS3jYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvDFQ8B+C7kTjADH0B5eJeh0i1zqp0F6ZN9b6ynz40rO/q+IE4iD6iOWByu2cOLDX9gRrevjIRuaksd2uVXmb+g/Z0S1Rfy96WFBY9gexC6FDL77hZ+fqnMd+G7b9vL09d3ZJy0p2OuHy+rhmRekuG77eTMs4SejuH4BuPYepDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C214C1FB;
	Fri,  1 Mar 2024 10:04:50 -0800 (PST)
Received: from [10.57.67.78] (unknown [10.57.67.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8B83F6C4;
	Fri,  1 Mar 2024 10:04:11 -0800 (PST)
Message-ID: <d4f2f99c-b8bb-4ed9-8d91-ed0f5b418425@arm.com>
Date: Fri, 1 Mar 2024 18:04:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Content-Language: en-GB
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 iommu@lists.linux.dev, Zelin Deng <zelin.deng@linux.alibaba.com>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
 <20240301082703-mutt-send-email-mst@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301082703-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 1:41 pm, Michael S. Tsirkin wrote:
> On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
>> On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
>>> On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
>>>> Not only is this idea not viable, the entire premise seems flawed - the
>>>> reasons for virtio needing to use the DMA API at all are highly likely to be
>>>> the same reasons for it needing to use the DMA API *properly* anyway.
>>>
>>> The idea has nothing to do with virtio per se
>>
>> Sure, I can see that, but if virtio is presented as the justification for
>> doing this then it's the justification I'm going to look at first. And the
>> fact is that it *does* seem to have particular significance, since having up
>> to 19 DMA addresses involved in a single transfer is very much an outlier
>> compared to typical hardware drivers.
> 
> That's a valid comment. Xuan Zhuo do other drivers do this too,
> could you check pls?
> 
>> Furthermore the fact that DMA API
>> support was retrofitted to the established virtio design means I would
>> always expect it to run up against more challenges than a hardware driver
>> designed around the expectation that DMA buffers have DMA addresses.
> 
> 
> It seems virtio can't drive any DMA changes then it's forever tainted?
> Seems unfair - we retrofitted it years ago, enough refactoring happened
> since then.

No, I'm not saying we couldn't still do things to help virtio if and 
when it does prove reasonable to do so; just that if anything it's 
*because* that retrofit is mature and fairly well polished by now that 
any remaining issues like this one are going to be found in the most 
awkward corners and thus unlikely to generalise.

FWIW in my experience it seems more common for network drivers to 
actually have the opposite problem, where knowing the DMA address of a 
buffer is easy, but keeping track of the corresponding CPU address can 
be more of a pain.

>>> - we are likely not the
>>> only driver that wastes a lot of memory (hot in cache, too) keeping DMA
>>> addresses around for the sole purpose of calling DMA unmap.  On a bunch
>>> of systems unmap is always a nop and we could save some memory if there
>>> was a way to find out. What is proposed is an API extension allowing
>>> that for anyone - not just virtio.
>>
>> And the point I'm making is that that "always" is a big assumption, and in
>> fact for the situations where it is robustly true we already have the
>> DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
>> I'd consider it rare for DMA
>> addresses to be stored in isolation, as opposed to being part of some kind
>> of buffer descriptor (or indeed struct scatterlist, for an obvious example)
>> that a driver or subsystem still has to keep track of anyway, so in general
>> I believe the scope for saving decidedly small amounts of memory at runtime
>> is also considerably less than you might be imagining.
>>
>> Thanks,
>> Robin.
> 
> 
> Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
> And I think the fact we have that mechanism is a hint that
> enough configurations could benefit from a runtime
> mechanism, too.
> 
> E.g. since you mentioned scatterlist, it has a bunch of ifdefs
> in place.

But what could that benefit be in general? It's not like we can change 
structure layouts on a per-DMA-mapping-call basis to save 
already-allocated memory... :/

Thanks,
Robin.

> 
> Of course
> - finding more examples would be benefitial to help maintainers
>    do the cost/benefit analysis
> - a robust implementation is needed
> 
> 

