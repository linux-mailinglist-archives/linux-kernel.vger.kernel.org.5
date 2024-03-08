Return-Path: <linux-kernel+bounces-97363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7763A876978
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7850B225E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F128DA6;
	Fri,  8 Mar 2024 17:17:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC118C3D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918278; cv=none; b=Y9utaLc7yB7P0d82Q9caasGXsyw4BwBn//VzdXQL8upZsmFrZWYWglofGRlk9mspmm7+19L7KoWXOAzMYgLo6xHlMKVizifDtJsvZNPXousvErOQRlODqMeBqP/HTuQ/UJq048CoaBMLQ4Vh4dRbQhJl3A2sTUoaFFbkmaXUC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918278; c=relaxed/simple;
	bh=R0ZoDUsMvU/ouvoac+/ZPdcDX3tABzDhbGOcPnBYCZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlRU3fSz4iBHPVxAWgNum6/hMA/bx3WShbyP/RGg036kFubwMJ5A79TmVPeyinQm4tpN20XK+JMSJuvUIR6ftP5/EAUG41rRPvI/4gNmNWY1fiUlRw67kYvKQ/MhuEiIubyOvxQvJjhC8kGgZIAQ3mY7SawKsQoelmBn1qmzzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 760F8C15;
	Fri,  8 Mar 2024 09:18:31 -0800 (PST)
Received: from [10.57.68.92] (unknown [10.57.68.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09533F738;
	Fri,  8 Mar 2024 09:17:52 -0800 (PST)
Message-ID: <9597a3ea-b71f-46bd-bc72-1d19e81dcfb5@arm.com>
Date: Fri, 8 Mar 2024 17:17:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings >=
 PAGE_SIZE
Content-Language: en-GB
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-7-will@kernel.org>
 <5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
 <20240308173816.5351ea58@meshulam.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240308173816.5351ea58@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-08 4:38 pm, Petr Tesařík wrote:
> On Fri, 8 Mar 2024 16:08:01 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2024-03-08 3:28 pm, Will Deacon wrote:
>>> For swiotlb allocations >= PAGE_SIZE, the slab search historically
>>> adjusted the stride to avoid checking unaligned slots. This had the
>>> side-effect of aligning large mapping requests to PAGE_SIZE, but that
>>> was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
>>>
>>> Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
>>> alignment for swiotlb mappings >= PAGE_SIZE.
>>
>> This seems clear enough to keep me happy now, thanks! And apologies that
>> I managed to confuse even myself in the previous thread...
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> I thought we agreed that this stricter alignment is unnecessary:
> 
>    https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/

No, that was about dma_alloc_coherent() again (and TBH I'm not sure we 
should actually relax it anyway, since there definitely are callers who 
rely on size-alignment beyond PAGE_SIZE, however they're typically going 
to be using the common implementations which end up in alloc_pages() or 
CMA and so do offer that, rather than the oddball ones which don't - 
e.g. we're never going to be allocating SMMUv3 Stream Tables out of some 
restricted pool via the emergency swiotlb_alloc() path). If anywhere, 
the place to argue that point would be patch #3 (which as mentioned I'd 
managed to forget about before...)

This one's just about preserving a SWIOTLB-specific behaviour which has 
the practical effect of making SWIOTLB a bit less visible to dma_map_*() 
callers. The impact of keeping this is fairly low, so seems preferable 
to the risk of facing issues 2 or 3 years down the line when someone 
finally upgrades their distro and their data gets eaten because it turns 
out some obscure driver should really have been updated to use 
min_align_mask.

Thanks,
Robin.

> But if everybody else wants to have it...
> 
> Petr T
> 
>>> Reported-by: Michael Kelley <mhklinux@outlook.com>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>    kernel/dma/swiotlb.c | 18 +++++++++++-------
>>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index c381a7ed718f..c5851034523f 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>>>    	BUG_ON(!nslots);
>>>    	BUG_ON(area_index >= pool->nareas);
>>>    
>>> +	/*
>>> +	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
>>> +	 * page-aligned in the absence of any other alignment requirements.
>>> +	 * 'alloc_align_mask' was later introduced to specify the alignment
>>> +	 * explicitly, however this is passed as zero for streaming mappings
>>> +	 * and so we preserve the old behaviour there in case any drivers are
>>> +	 * relying on it.
>>> +	 */
>>> +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
>>> +		alloc_align_mask = PAGE_SIZE - 1;
>>> +
>>>    	/*
>>>    	 * Ensure that the allocation is at least slot-aligned and update
>>>    	 * 'iotlb_align_mask' to ignore bits that will be preserved when
>>> @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>>>    	 */
>>>    	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>>>    
>>> -	/*
>>> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
>>> -	 * allocations.
>>> -	 */
>>> -	if (alloc_size >= PAGE_SIZE)
>>> -		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>>> -
>>>    	spin_lock_irqsave(&area->lock, flags);
>>>    	if (unlikely(nslots > pool->area_nslabs - area->used))
>>>    		goto not_found;
>>
> 

