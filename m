Return-Path: <linux-kernel+bounces-43413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FA484138A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80981B22D12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B574E1BA;
	Mon, 29 Jan 2024 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSrkougg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E02E834;
	Mon, 29 Jan 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556776; cv=none; b=g5v5DPkZN2TyXPoZxq/DcxXQ7y8k09/QmIQ3c1JUNN0RDlcCQI7XeAs7iR6vJRklpJlL+9pHCcMqYvOqRetjKRtp6PaB6sJhUVvCXxvJvdRKAHX+xHhoQmU8R2iYCbwc8FPuuz8BIhXMRBH7kCeLfuY8JrHFfjP0a+ZOnW8EtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556776; c=relaxed/simple;
	bh=e6mp+P1n+MD3N4nOABL2qLlj5/FDmrpQ5T8NP6dsLAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al38AKnJv+VgylHAd6mZeBKetqQFmLkXK/BHef9/Sh5h81LyJjpj7Qo20zdtMhOh9LmWN8NO3l0KwNFz9b7mpG2dqMiJ/tjvXKtIjb3Swxr95BaFWrD3vJlUBu+qsLFsHTSjfeIdtLq7bFEh6j/81ycRyo0Q/hrYITMq5XNQ3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSrkougg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21208C433C7;
	Mon, 29 Jan 2024 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706556775;
	bh=e6mp+P1n+MD3N4nOABL2qLlj5/FDmrpQ5T8NP6dsLAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSrkouggTFEUXeQ71Ee9FWeMZdrxJjzRsuL00L3YVYyj6gghEHzuZYXqAWTK05daP
	 LLuAsjzb6T5apHAOvfw5kf5W+gPYVrNWH2lmAlZ2EeyAzi31G6sF7MUy66q064RoDo
	 0PfvxxQ9DPyopyj7GFrbQWM1InrOIw4HpAs921KICZbSs/mCNBb3SK2++inuTAnWnO
	 JG5u4xyYypRe4pmfURBa3/ltpksLaH7Akmp3U4Z7GryeHZRRgz5tlKOk/rq8l7WwiV
	 NZ0KXXXHLQPCXQTSk9+h0FNVxgRAbkJX1v0X9ONu73xnsYy+M6tDyJnfDz2q7A/pVT
	 wdzkU9GD8RICw==
Date: Mon, 29 Jan 2024 19:32:50 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] swiotlb: Fix allocation alignment requirement when
 searching slots
Message-ID: <20240129193250.GB12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126151956.10014-2-will@kernel.org>
 <20240126180127.1a3fc4e6@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126180127.1a3fc4e6@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 26, 2024 at 06:01:27PM +0100, Petr Tesařík wrote:
> On Fri, 26 Jan 2024 15:19:55 +0000
> Will Deacon <will@kernel.org> wrote:
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b079a9a8e087..25febb9e670c 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> >  	unsigned long max_slots = get_max_slots(boundary_mask);
> >  	unsigned int iotlb_align_mask =
> > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> 
> Good. So, iotlb_align_mask now specifies how many low bits of orig_addr
> should be preserved in the bounce buffer address, ignoring the offset
> within the TLB slot...

Yup, this is basically restoring the old behaviour.

> >  	unsigned int nslots = nr_slots(alloc_size), stride;
> >  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> >  	unsigned int index, slots_checked, count = 0, i;
> > @@ -998,14 +998,13 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >  	 * allocations.
> >  	 */
> >  	if (alloc_size >= PAGE_SIZE)
> > -		iotlb_align_mask |= ~PAGE_MASK;
> > -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> > +		alloc_align_mask |= ~PAGE_MASK;
> 
> ...and alloc_align_mask specifies the desired TLB slot alignment.

Yes, although actually I'm now wondering whether there's another bug here
in that we don't return naturally aligned buffers for allocations bigger
than a page. I think that was broken in 0eee5ae10256 ("swiotlb: fix slot
alignment checks") because that stopped aligning the initial search index
to the stride (which was in turn previously aligned to the allocation size).

> >  	/*
> >  	 * For mappings with an alignment requirement don't bother looping to
> >  	 * unaligned slots once we found an aligned one.
> >  	 */
> > -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > +	stride = (max(alloc_align_mask, iotlb_align_mask) >> IO_TLB_SHIFT) + 1;
> 
> I'm not quite sure about this one.
> 
> And I'm not even sure all combinations make sense!
> 
> For example, take these values:
> 
> *         TLB_SIZE ==              0x800  (2K)
> * alloc_align_mask == 0xffffffffffffc000  (16K alignment, could be page size)
> * iotlb_align_mask == 0xffffffffffff0000  (64K alignment)
> *        orig_addr == 0x0000000000001234
> 
> Only the lowest 16 bits are relevant for the alignment check.
> Device alignment requires 0x1000.
> Alloc alignment requires one of 0x0000, 0x4000, 0x8000, or 0xc000.
> Obviously, such allocation must always fail...

Having an iotlb_align_mask with all those upper bits set looks wrong to me.
Is that the same "braino" as bbb73a103fbb?

> >  	spin_lock_irqsave(&area->lock, flags);
> >  	if (unlikely(nslots > pool->area_nslabs - area->used))
> > @@ -1015,15 +1014,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >  	index = area->index;
> >  
> >  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> > +		phys_addr_t tlb_addr;
> > +
> >  		slot_index = slot_base + index;
> > +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> > +
> > +		if (tlb_addr & alloc_align_mask)
> > +			goto next_slot;
> 
> Awww, come on. So your code jumps to a label and then inserts an
> unconditional continue just before that label? I'm sure we'll find a
> cleaner way to convey the loop logic. What about this:
> 
> 		if ((tlb_addr & alloc_align_mask) != 0 ||
> 		    (orig_addr && (tlb_addr & io_tlb_align_mask !=
> 				   orig_addr & iotlb_align_mask))) {
> 			index = wrap_area_index(pool, index + 1);
> 			slots_checked++;
> 			continue;
> 		}

I'm hoping I can drop the alloc_align_mask check entirely if I restore
the alignment of the index.

> But yes, this patch looks like it should finally do the right thing.

I don't think we're quite there yet. I'll spin a v2.

Thanks for the review,

Will

