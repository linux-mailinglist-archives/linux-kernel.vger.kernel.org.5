Return-Path: <linux-kernel+bounces-100031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941DC879112
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5941F239E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218778277;
	Tue, 12 Mar 2024 09:38:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C2D30B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236324; cv=none; b=QRiwq36jnlpPMIcmuoND8qID4yxDtFTXJhcQGVklYgdLZfofMZK3fapfOHrhZkHdae2kaBLupcyKXmokA7X6Fjc7Yw8DB63T+hLlq/8d0buaE3Llcr1qjsEj2AiUGLKQCww/VnuUtpRfwxPUEXMxhc43k6C2ttNS4RxhJoSjkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236324; c=relaxed/simple;
	bh=qKB2e4KvlaahfJ0jugZCW6834bmBlv3uxTQj8tjym5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMD+aPmd3cRgBpi8fR9szwhDkvBXVXSQahJqFQjJg4AHjWoorsBhASHXyh00MGsnYXwnvHW64lXCsJKLAYqhHRUkBuK6C6RTqy3erGkEN/VkU6vegXN+JeIPaeSnbUKa8woyk18xcz2hS9v84Cx96KVk7bVglzxKDnSQhebCzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0098C1007;
	Tue, 12 Mar 2024 02:39:16 -0700 (PDT)
Received: from [10.57.52.44] (unknown [10.57.52.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB70B3F762;
	Tue, 12 Mar 2024 02:38:37 -0700 (PDT)
Message-ID: <2612acb1-48f9-4117-ae06-9b8f430034ca@arm.com>
Date: Tue, 12 Mar 2024 09:38:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both allocation
 and DMA masks are present
Content-Language: en-GB
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Will Deacon <will@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, Nicolin Chen
 <nicolinc@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-5-will@kernel.org>
 <20240311210507.217daf8b@meshulam.tesarici.cz>
 <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240311224910.GA28426@willie-the-truck>
 <20240312095223.7a05d5b8@meshulam.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240312095223.7a05d5b8@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-12 8:52 am, Petr Tesařík wrote:
> On Mon, 11 Mar 2024 22:49:11 +0000
> Will Deacon <will@kernel.org> wrote:
> 
>> On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote:
>>> From: Petr Tesařík <petr@tesarici.cz>
>>>> On Fri,  8 Mar 2024 15:28:27 +0000
>>>> Will Deacon <will@kernel.org> wrote:
>>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>>>> index c20324fba814..c381a7ed718f 100644
>>>>> --- a/kernel/dma/swiotlb.c
>>>>> +++ b/kernel/dma/swiotlb.c
>>>>> @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>>>>>   	dma_addr_t tbl_dma_addr =
>>>>>   		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>>>>>   	unsigned long max_slots = get_max_slots(boundary_mask);
>>>>> -	unsigned int iotlb_align_mask =
>>>>> -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>>>>> +	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
>>>>>   	unsigned int nslots = nr_slots(alloc_size), stride;
>>>>>   	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>>>>>   	unsigned int index, slots_checked, count = 0, i;
>>>>> @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>>>>>   	BUG_ON(!nslots);
>>>>>   	BUG_ON(area_index >= pool->nareas);
>>>>>
>>>>> +	/*
>>>>> +	 * Ensure that the allocation is at least slot-aligned and update
>>>>> +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
>>>>> +	 * offsetting into the allocation.
>>>>> +	 */
>>>>> +	alloc_align_mask |= (IO_TLB_SIZE - 1);
>>>>> +	iotlb_align_mask &= ~alloc_align_mask;
>>>>> +
>>>>
>>>> I have started writing the KUnit test suite, and the results look
>>>> incorrect to me for this case.
>>>>
>>>> I'm calling swiotlb_tbl_map_single() with:
>>>>
>>>> * alloc_align_mask = 0xfff
>>>> * a device with min_align_mask = 0xfff
>>>> * the 12 lowest bits of orig_addr are 0xfa0
>>>>
>>>> The min_align_mask becomes zero after the masking added by this patch,
>>>> and the 12 lowest bits of the returned address are 0x7a0, i.e. not
>>>> equal to 0xfa0.
>>>
>>> The address returned by swiotlb_tbl_map_single() is the slot index
>>> converted to an address, plus the offset modulo the min_align_mask for
>>> the device.  The local variable "offset" in swiotlb_tbl_map_single()
>>> should be 0xfa0.  The slot index should be an even number to meet
>>> the alloc_align_mask requirement.  And the pool->start address should
>>> be at least page aligned, producing a page-aligned address *before* the
>>> offset is added. Can you debug which of these isn't true for the case
>>> you are seeing?
>>
>> I was just looking into this, and I think the problem starts because
>> swiotlb_align_offset() doesn't return the offset modulo the min_align_mask,
>> but instead returns the offset *into the slot*:
>>
>> 	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
>>
>> so this presumably lops off bit 11 without adjusting the slot number.
> 
> Yes. You will never see an offset bigger than IO_TLB_SIZE.
> 
>> I don't think swiotlb_find_slots() should be handling this though; it's
>> more about how swiotlb_tbl_map_single() puts the address back together
>> again.
>>>> In other words, the min_align_mask constraint is not honored. Of course,
>>>> given the above values, it is not possible to honor both min_align_mask
>>>> and alloc_align_mask.
>>>
>>> When orig_addr is specified and min_align_mask is set, alloc_align_mask
>>> governs the address of the _allocated_ space, which is not necessarily the
>>> returned physical address.  The min_align_mask may dictate some
>>> pre-padding of size "offset" within the allocated space, and the returned
>>> address is *after* that pre-padding.  In this way, both can be honored.
>>
>> I agree, modulo the issue with the offset calculation.
> 
> *sigh*
> 
> This is exactly what I tried to suggest here:
> 
>    https://lore.kernel.org/linux-iommu/20240301180853.5ac20b27@meshulam.tesarici.cz/
> 
> To which Robin Murphy replied:
> 
>> That doesn't make sense - a caller asks to map some range of kernel
>> addresses and they get back a corresponding range of DMA addresses; they
>> cannot make any reasonable assumptions about DMA addresses *outside*
>> that range.
> 
> It sounded like a misunderstanding back then already, but in light of
> the present findings, should I send the corresponding patch after all?

No, that comment was in reference to the idea of effectively forcing 
alloc_align_mask in order to honour min_align_mask - specifically that 
the reasoning given for it was spurious, but it's clear now it would 
also simply exacerbate this problem.

Simply put, if min_align_mask is specified alone, SWIOTLB can allocate a 
roughly-aligned range of slots such that the bounce offset is always 
less than IO_TLB_SIZE from the start of the allocation; if both 
min_align_mask and alloc_align_mask are specified, then the bounce 
offset may be larger than IO_TLB_SIZE, and SWIOTLB needs to be able to 
handle that correctly. There is still no benefit in forcing the latter 
case to happen more often than it needs to.

Thanks,
Robin.

