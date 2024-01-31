Return-Path: <linux-kernel+bounces-46742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09F844372
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9085E1C231EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963412A14C;
	Wed, 31 Jan 2024 15:54:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C280BEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716449; cv=none; b=myF0FjcC89X5cK5E1AQlYd9v/kVDTB26undNUiR3X6M/ViwUuuUzUiHcIWdzhew+YuDbJyLudlrCVTs0cSLb3ntTI/jhxjr0zp2++di+2hAntg66iTrWhlW8lu8yQ8Ss3XDZPs3IWCUTe9zIyZfjlI0obYNeqmz+0hIkm/Ks76Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716449; c=relaxed/simple;
	bh=mldqjE1Pc7pvM56+X+UXfoNDx5BOel/dXPvqQok+9yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQMdbxJMNY8ruv2GNWgAIJU4r7FRruzGxeFkTcw6VfD7E9pbUfQP/uBSPcCXHmXTAFsSN+5GEpk0OeHC23dFkoMh5ND9gR76RPm8n3eKyQL1AS6ey4Tgs1IjapWc5633Gbk4WrrBS80iNMcdilKgxXxozeYqT3JYXHD/+Wa5IjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71801DA7;
	Wed, 31 Jan 2024 07:54:49 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DEAA3F762;
	Wed, 31 Jan 2024 07:54:05 -0800 (PST)
Message-ID: <4c9f50d2-05f9-4a37-ac50-dcd98e40e87f@arm.com>
Date: Wed, 31 Jan 2024 15:54:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] swiotlb: Fix allocation alignment requirement when
 searching slots
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-2-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240131122543.14791-2-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2024 12:25 pm, Will Deacon wrote:
> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> checks"), causes a functional regression with vsock in a virtual machine
> using bouncing via a restricted DMA SWIOTLB pool.
> 
> When virtio allocates the virtqueues for the vsock device using
> dma_alloc_coherent(), the SWIOTLB search fails to take into account the
> 8KiB buffer size and returns page-unaligned allocations if 'area->index'
> was left unaligned by a previous allocation from the buffer:

Hmm, but isn't this fundamentally swiotlb_alloc()'s fault for assuming 
it's going to get a page-aligned address back despite asking for 0 
alignment in the first place? I'm not sure SWIOTLB has ever promised 
implicit size-alignment, so it feels somewhat misplaced to be messing 
with the algorithm before fixing the obvious issue in the caller :/

Cheers,
Robin.

>   # Final address in brackets is the SWIOTLB address returned to the caller
>   | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
>   | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
>   | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
> 
> This ends in tears (typically buffer corruption and/or a hang) because
> swiotlb_alloc() blindly returns a pointer to the 'struct page'
> corresponding to the allocation and therefore the first half of the page
> ends up being allocated twice.
> 
> Fix the problem by treating the allocation alignment separately to any
> additional alignment requirements from the device, using the maximum
> of the two as the stride to search the buffer slots.
> 
> Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..56cc08b1fbd6 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>   		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>   	unsigned long max_slots = get_max_slots(boundary_mask);
>   	unsigned int iotlb_align_mask =
> -		dma_get_min_align_mask(dev) | alloc_align_mask;
> +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>   	unsigned int nslots = nr_slots(alloc_size), stride;
>   	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>   	unsigned int index, slots_checked, count = 0, i;
> @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>   	BUG_ON(!nslots);
>   	BUG_ON(area_index >= pool->nareas);
>   
> +	/*
> +	 * For mappings with an alignment requirement don't bother looping to
> +	 * unaligned slots once we found an aligned one.
> +	 */
> +	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> +
>   	/*
>   	 * For allocations of PAGE_SIZE or larger only look for page aligned
>   	 * allocations.
>   	 */
>   	if (alloc_size >= PAGE_SIZE)
> -		iotlb_align_mask |= ~PAGE_MASK;
> -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> -
> -	/*
> -	 * For mappings with an alignment requirement don't bother looping to
> -	 * unaligned slots once we found an aligned one.
> -	 */
> -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> +		stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>   
>   	spin_lock_irqsave(&area->lock, flags);
>   	if (unlikely(nslots > pool->area_nslabs - area->used))
> @@ -1015,14 +1014,16 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>   	index = area->index;
>   
>   	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> -		slot_index = slot_base + index;
> +		phys_addr_t tlb_addr;
>   
> -		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> +		slot_index = slot_base + index;
> +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> +
> +		if ((tlb_addr & alloc_align_mask) ||
> +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
> +				  (orig_addr & iotlb_align_mask))) {
>   			index = wrap_area_index(pool, index + 1);
>   			slots_checked++;
> -			continue;
>   		}
>   
>   		if (!iommu_is_span_boundary(slot_index, nslots,

