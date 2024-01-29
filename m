Return-Path: <linux-kernel+bounces-43546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E172F84155B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4721F243F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C00159569;
	Mon, 29 Jan 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFFELB86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775B3C463;
	Mon, 29 Jan 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565922; cv=none; b=uxZxtJHUwNJukajeNtKR8PgdxbAPLwiKdDi2P82hxcHPboo1ZO7S6lP7nJvO1RNbzX8Dn/Gk4i9Tode5NxL+m8UcPJZhT/V4BxET4rXzSP9BaUWAK0LVkSHFcN11eje2/nRBc3mYZql8cf+GQ/G6qriFmSQAAVeNyIceUWtbnng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565922; c=relaxed/simple;
	bh=GE+ipPS+Akwq8xvWGQYr0R9LHwbwVo+fTLwIpkdrwvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBni4z/YW4HhETS+BdvwsTJwKIwOL8MF1ZfDqIleRNHeEhDW1ljDQCBiH+oQS+BAt6YqGpV4DpPx9xCK04FWyEwMEdRnn+9Wxr7NmNbVFRkI+ePwo2Zsbe0BAfKLov67aPaWOOUz8EIzIrB5hvsBPILTmqWlogZJuRWOXl5SZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFFELB86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5F4C433C7;
	Mon, 29 Jan 2024 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706565921;
	bh=GE+ipPS+Akwq8xvWGQYr0R9LHwbwVo+fTLwIpkdrwvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFFELB86mwfB7vGhV62Wkut02615w/PTVUMsP7wzyzH4NHB/aWs0VMgUhLrqEc9xl
	 OhkLgHPMZJ5jL9FX53054Im717pEp6uXWeaueKFbpGhyW2NoiXgE3Pc/TB3HKj99lA
	 sqVqy9qtJA/LfqCKGzq5/fJYQwBI5gz+yWCk4qGcl2ZCwaeUlDHaINCmH7C9r2VkTk
	 Ri/vzfKj3GdlBjH+WypVHNZZpY1JNnV/TwqvxqmMF88rbYdS6xdVyTwv9lsYLTM+oh
	 HkDS2nRKjL2Gv53ooJrJxSmKOLNeUq2nbaV73GGsjloniVtKju/Xp6YQfyNDFnIMXA
	 phi4SM/Rjzcsg==
Date: Mon, 29 Jan 2024 22:05:16 +0000
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
Message-ID: <20240129220516.GA12808@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
 <20240126151956.10014-2-will@kernel.org>
 <20240126180127.1a3fc4e6@meshulam.tesarici.cz>
 <20240129193250.GB12631@willie-the-truck>
 <20240129214034.4beb4258@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129214034.4beb4258@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 29, 2024 at 09:40:34PM +0100, Petr Tesařík wrote:
> On Mon, 29 Jan 2024 19:32:50 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > On Fri, Jan 26, 2024 at 06:01:27PM +0100, Petr Tesařík wrote:
> > > On Fri, 26 Jan 2024 15:19:55 +0000
> > > Will Deacon <will@kernel.org> wrote:  
> > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > index b079a9a8e087..25febb9e670c 100644
> > > > --- a/kernel/dma/swiotlb.c
> > > > +++ b/kernel/dma/swiotlb.c
> > > > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > > >  	unsigned long max_slots = get_max_slots(boundary_mask);
> > > >  	unsigned int iotlb_align_mask =
> > > > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > > > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);  
> > > 
> > > Good. So, iotlb_align_mask now specifies how many low bits of orig_addr
> > > should be preserved in the bounce buffer address, ignoring the offset
> > > within the TLB slot...  
> > 
> > Yup, this is basically restoring the old behaviour.
> > 
> > > >  	unsigned int nslots = nr_slots(alloc_size), stride;
> > > >  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > > >  	unsigned int index, slots_checked, count = 0, i;
> > > > @@ -998,14 +998,13 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > > >  	 * allocations.
> > > >  	 */
> > > >  	if (alloc_size >= PAGE_SIZE)
> > > > -		iotlb_align_mask |= ~PAGE_MASK;
> > > > -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> > > > +		alloc_align_mask |= ~PAGE_MASK;  
> > > 
> > > ...and alloc_align_mask specifies the desired TLB slot alignment.  
> > 
> > Yes, although actually I'm now wondering whether there's another bug here
> > in that we don't return naturally aligned buffers for allocations bigger
> > than a page. I think that was broken in 0eee5ae10256 ("swiotlb: fix slot
> > alignment checks") because that stopped aligning the initial search index
> > to the stride (which was in turn previously aligned to the allocation size).
> 
> The question is whether there is any NEED that allocations bigger than
> a page are naturally aligned. For my part, I don't see why there should
> be, but I might be missing something.

I think some drivers rely on that. As per core-api/dma-api-howto.rst:

  (Using Consistent DMA mappings::dma_alloc_coherent())
  | The CPU virtual address and the DMA address are both guaranteed to
  | be aligned to the smallest PAGE_SIZE order which is greater than or
  | equal to the requested size.

I've certainly written code that relies on it and the swiotlb logic used
to honour that requirement.

> > > >  	/*
> > > >  	 * For mappings with an alignment requirement don't bother looping to
> > > >  	 * unaligned slots once we found an aligned one.
> > > >  	 */
> > > > -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > > > +	stride = (max(alloc_align_mask, iotlb_align_mask) >> IO_TLB_SHIFT) + 1;  
> > > 
> > > I'm not quite sure about this one.
> > > 
> > > And I'm not even sure all combinations make sense!
> > > 
> > > For example, take these values:
> > > 
> > > *         TLB_SIZE ==              0x800  (2K)
> > > * alloc_align_mask == 0xffffffffffffc000  (16K alignment, could be page size)
> > > * iotlb_align_mask == 0xffffffffffff0000  (64K alignment)
> > > *        orig_addr == 0x0000000000001234
> > > 
> > > Only the lowest 16 bits are relevant for the alignment check.
> > > Device alignment requires 0x1000.
> > > Alloc alignment requires one of 0x0000, 0x4000, 0x8000, or 0xc000.
> > > Obviously, such allocation must always fail...  
> > 
> > Having an iotlb_align_mask with all those upper bits set looks wrong to me.
> > Is that the same "braino" as bbb73a103fbb?
> 
> I must always stop and think at least twice before I can be sure
> whether a "mask" has the high bits set, or the low bits set...
> 
> On an x86, PAGE_SHIFT is 12, PAGE_SIZE is 1UL << PAGE_SHIFT or 0x1000,
> PAGE_MASK is ~(PAGE_SIZE-1)) or 0xfffffffffffff000, and there's one
> more bitwise negation, so you're right. Both masks above should be
> inverted, and using max() to find the stride is correct.

Heh. It's not straightforward, is it?

Will

