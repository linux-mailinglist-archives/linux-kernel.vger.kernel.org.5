Return-Path: <linux-kernel+bounces-90965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD688707B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC371F22F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B845BF6;
	Mon,  4 Mar 2024 16:53:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61453A20
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571219; cv=none; b=Ndvaqk8aEHr/v3/dEURtBLf3oo9CCWqoOdp9yjjyBbmVpPRPvEB43BgqOshjWvJhNH3zTx0WQP0AUNJD5H1dQZ7ZGGua3t33Wau8gxTyRGYsRHXC0dyAeu7nbTnQy0xyNryUkiAalKkQUab0ReFmzo+cInCj8O/dAO1PNnAh3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571219; c=relaxed/simple;
	bh=odLag6z4EVrHLDoxIhELyF6yH/BXlNlYTSx9r0KRJf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMfO6F4yJ4ErX5yd6QQtR1iHV8tZra4JsEvnEHo2MpURgOuuw20IPbRp0MctFddDBYyFrLTlXvJLuMoThrIFVzjZYjWCFB3jw00ddj/D0Wb9xilcx1SnBcm8CUoQh1HGdCkct0xllkjTiKUfGAgReeysFZncCD7rFeqVGw7b4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260FA1FB;
	Mon,  4 Mar 2024 08:54:13 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3FB73F73F;
	Mon,  4 Mar 2024 08:53:34 -0800 (PST)
Message-ID: <b63d4332-b659-4897-83c7-04e5ad397a69@arm.com>
Date: Mon, 4 Mar 2024 16:53:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Content-Language: en-GB
To: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <20240304160210.GB21077@willie-the-truck>
 <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/03/2024 4:10 pm, Michael Kelley wrote:
> From: Will Deacon <will@kernel.org> Sent: Monday, March 4, 2024 8:02 AM
>>
>> Hi folks,
>>
>> On Mon, Mar 04, 2024 at 04:55:06PM +0100, Petr Tesařík wrote:
>>> On Mon, 4 Mar 2024 13:37:56 +0000
>>> Robin Murphy <robin.murphy@arm.com> wrote:
>>>> On 04/03/2024 11:00 am, Petr Tesařík wrote:
>>>> [...]
>>>>>> Here's my take on tying all the threads together. There are
>>>>>> four alignment combinations:
>>>>>>
>>>>>> 1. alloc_align_mask: zero; min_align_mask: zero
>>
>> Based on this ^^^ ...
>>
>>>>>> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
>>>>>> via swiotlb_map() and swiotlb_tbl_map_single()
>>>>>>
>>>>>> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
>>>>>>
>>>>>> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
>>>>>>
>>>>>> For #1, the returned physical address has no constraints if
>>>>>> the requested size is less than a page. For page size or
>>>>>> greater, the discussed historical requirement for page
>>>>>> alignment applies.
>>
>> ... and this ^^^ ...
>>
>>
>>> I believe this patch series is now good as is, except the commit
>>> message should make it clear that alloc_align_mask and min_align_mask
>>> can both be zero, but that simply means no alignment constraints.
>>
>> ... my (possibly incorrect!) reading of the thread so far is that we
>> should preserve page-aligned allocation in this case if the allocation
>> size is >= PAGE_SIZE.
>>
>> Something like the diff below, to replace this final patch?
>>
>> Will
>>
>> --->8
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index c381a7ed718f..67eac05728c0 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -992,6 +992,14 @@ static int swiotlb_search_pool_area(struct device
>> *dev, struct io_tlb_pool *pool
>>          BUG_ON(!nslots);
>>          BUG_ON(area_index >= pool->nareas);
>>
>> +       /*
>> +        * Historically, allocations >= PAGE_SIZE were guaranteed to be
>> +        * page-aligned in the absence of any other alignment requirements.
>> +        * Since drivers may be relying on this, preserve the old behaviour.
>> +        */
>> +       if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
>> +               alloc_align_mask = PAGE_SIZE - 1;
>> +
> 
> Yes, I think that should do it.

In principle it might be more logical to fudge this into 
iotlb_align_mask rather than alloc_align_mask - since that's really the 
effective behaviour to preserve for streaming mappings - and then pass 
an explicit alloc_align_mask from swiotlb_alloc() to honour the 
dma-coherent requirements. However I also wouldn't really object to not 
going that far and instead just making the comment a bit clearer that 
this is still serving both purposes.

Cheers,
Robin.

> 
> Michael
> 
>>          /*
>>           * Ensure that the allocation is at least slot-aligned and update
>>           * 'iotlb_align_mask' to ignore bits that will be preserved when
>> @@ -1006,13 +1014,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>>           */
>>          stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
>>
>> -       /*
>> -        * For allocations of PAGE_SIZE or larger only look for page aligned
>> -        * allocations.
>> -        */
>> -       if (alloc_size >= PAGE_SIZE)
>> -               stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>> -
>>          spin_lock_irqsave(&area->lock, flags);
>>          if (unlikely(nslots > pool->area_nslabs - area->used))
>>                  goto not_found;
> 

