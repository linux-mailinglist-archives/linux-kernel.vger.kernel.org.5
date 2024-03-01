Return-Path: <linux-kernel+bounces-88871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61886E7CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DC91F27B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61512B72;
	Fri,  1 Mar 2024 17:54:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F038516FF5F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315651; cv=none; b=klbxnRgzYbQrBZQJ25nANcGeNTLUU/lF7U1yDD49oEm5jw6AkzMc0zZJ2shQv1FjPHavu8MMHY8XkUcZzOpa6w1n4aPTeC0TPOYgjBCrSZ2EaICvE3KyJjXWDKqcH9UZx2SJmLIWU+YHm+DjKRKm1DER2fVVYXt2wMnfPaUYFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315651; c=relaxed/simple;
	bh=dhV8UcMzuIMIEciXJWv9lg+qF4UzGIqBhO24KteMsZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP+BIYF9x89dLl8B86g10L5D1kyBG1RG+zI/+kXEjlqbYMVGRZBOKC081sAXFg6dGv92cCXhpMuACOENlJzx6ZyQARxlNHXGKzygLRWVZrV8IM09VfxadOfpXVik+kaEAdhUt3geYGqmrDz2lTsQidaIdc05a9fE8uHdOoCUuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558C0139F;
	Fri,  1 Mar 2024 09:54:47 -0800 (PST)
Received: from [10.57.67.78] (unknown [10.57.67.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F573F6C4;
	Fri,  1 Mar 2024 09:54:07 -0800 (PST)
Message-ID: <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
Date: Fri, 1 Mar 2024 17:54:06 +0000
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
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Christoph Hellwig <hch@lst.de>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229133346.GA7177@lst.de>
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240301180853.5ac20b27@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-01 5:08 pm, Petr Tesařík wrote:
> On Fri, 1 Mar 2024 16:39:27 +0100
> Petr Tesařík <petr@tesarici.cz> wrote:
> 
>> On Thu, 29 Feb 2024 16:47:56 +0100
>> Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote:
>>>> Any thoughts on how that historical behavior should apply if
>>>> the DMA min_align_mask is non-zero, or the alloc_align_mask
>>>> parameter to swiotbl_tbl_map_single() is non-zero? As currently
>>>> used, alloc_align_mask is page aligned if the IOMMU granule is
>>>>> = PAGE_SIZE. But a non-zero min_align_mask could mandate
>>>> returning a buffer that is not page aligned. Perhaps do the
>>>> historical behavior only if alloc_align_mask and min_align_mask
>>>> are both zero?
>>>
>>> I think the driver setting min_align_mask is a clear indicator
>>> that the driver requested a specific alignment and the defaults
>>> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
>>> I'd have to tak a closer look at how it is used.
>>
>> I'm not sure it helps in this discussion, but let me dive into a bit
>> of ancient history to understand how we ended up here.
>>
>> IIRC this behaviour was originally motivated by limitations of PC AT
>> hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
>> usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
>> added a page register, but it was on a separate chip and it did not
>> increment when the 8237 address rolled over back to zero. Effectively,
>> the page register selected a 64K-aligned window of 64K buffers.
>> Consequently, DMA buffers could not cross a 64K physical boundary.
>>
>> Thanks to how the buddy allocator works, the 64K-boundary constraint
>> was satisfied by allocation size, and drivers took advantage of it when
>> allocating device buffers. IMO software bounce buffers simply followed
>> the same logic that worked for buffers allocated by the buddy allocator.
>>
>> OTOH min_align_mask was motivated by NVME which prescribes the value of
>> a certain number of low bits in the DMA address (for simplicity assumed
>> to be identical with the same bits in the physical address).
>>
>> The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
>> IIUC it is used to guarantee that unaligned transactions do not share
>> the IOMMU granule with another device. This whole thing is weird,
>> because swiotlb_tbl_map_single() is called like this:
>>
>>                  aligned_size = iova_align(iovad, size);
>>                  phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
>>                                                iova_mask(iovad), dir, attrs);
>>
>> Here:
>>
>> * alloc_size = iova_align(iovad, size)
>> * alloc_align_mask = iova_mask(iovad)
>>
>> Now, iova_align() rounds up its argument to a multiple of iova granule
>> and iova_mask() is simply "granule - 1". This works, because granule
>> size must be a power of 2, and I assume it must also be >= PAGE_SIZE.
>>
>> In that case, the alloc_align_mask argument is not even needed if you
>> adjust the code to match documentation---the resulting buffer will be
>> aligned to a granule boundary by virtue of having a size that is a
>> multiple of the granule size.
>>
>> To sum it up:
>>
>> 1. min_align_mask is by far the most important constraint. Devices will
>>     simply stop working if it is not met.
>> 2. Alignment to the smallest PAGE_SIZE order which is greater than or
>>     equal to the requested size has been documented, and some drivers
>>     may rely on it.
>> 3. alloc_align_mask is a misguided fix for a bug in the above.
>>
>> Correct me if anything of the above is wrong.
> 
> I thought about it some more, and I believe I know what should happen
> if the first two constraints appear to be mutually exclusive.
> 
> First, the alignment based on size does not guarantee that the resulting
> physical address is aligned. In fact, the lowest IO_TLB_SHIFT bits must
> be always identical to the original buffer address.
> 
> Let's take an example request like this:
> 
>     TLB_SIZE       = 0x00000800
>     min_align_mask = 0x0000ffff
>     orig_addr      = 0x....1234
>     alloc_size     = 0x00002800
> 
> Minimum alignment mask requires to keep the 1234 at the end. Allocation
> size requires a buffer that is aligned to 16K. Of course, there is no
> 16K-aligned slot with slot_address & 0x7ff == 0x200, but if IO_TLB_SHIFT
> was 14, it would be slot_address & 0x3fff == 0 (low IO_TLB_SHIFT are
> masked off). Since the SWIOTLB API does not guarantee any specific
> value of IO_TLB_SHIFT, callers cannot rely on it. That means 0x1234 is a
> perfectly valid bounce buffer address for this example.
> 
> The caller may rightfully expect that the 16K granule containing the
> bounce buffer is not shared with any other user. For the above case I
> suggest to increase the allocation size to 0x4000 already in
> swiotlb_tbl_map_single() and treat 0x1234 as the offset from the slot
> address.

That doesn't make sense - a caller asks to map some range of kernel 
addresses and they get back a corresponding range of DMA addresses; they 
cannot make any reasonable assumptions about DMA addresses *outside* 
that range. In the example above, the caller has explicitly chosen not 
to map the range xxx0000-xxx1234; if they expect the device to actually 
access bytes in the DMA range yyy0000-yyy1234, then they should have 
mapped the whole range starting from xxx0000 and it is their own error.

SWIOTLB does not and cannot provide any memory protection itself, so 
there is no functional benefit to automatically over-allocating, all it 
will do is waste slots. iommu-dma *can* provide memory protection 
between individual mappings via additional layers that SWIOTLB doesn't 
know about, so in that case it's iommu-dma's responsibility to 
explicitly manage whatever over-allocation is necessary at the SWIOTLB 
level to match the IOMMU level.

Thanks,
Robin.

