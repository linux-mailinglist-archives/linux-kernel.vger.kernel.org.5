Return-Path: <linux-kernel+bounces-106530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0587EFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B11C22326
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90F535B2;
	Mon, 18 Mar 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="OZZoDmhm"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C26381C8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787850; cv=none; b=bvaSU5vhZH4c+F6jMkgXLKLp2VbE68/GXwTr6SSFYbO29uWrLv/9EfJyst+qf4wzuYbui1O9p3r6zkWcM3ZD9rTitGvam9DDzVMznI6TBJH53xNl4ePGr/nSiNaFmQRZ+s9z/hIT9eDw0C8FEAh+XHJgC9i/0axh2P3qasMpvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787850; c=relaxed/simple;
	bh=zZaWLU60VAXKI+gXVr/bxrosS7QCkD5t6SJKoB/3YvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcPiRVNqLrYrCA1ilq9U/5oJPNuaQjPuNow4y+l3EhWSgazjlGqpbxD3ElxhBbyWigRK68thyY88sOg6aXhf1OU/pEUWmLE5cQ8eMdB5mESAF/ECG59aFzrOPtF1U/uWEVxe/VxsIVdrfB5bXAqPxJ5Z6rMhHVXxuKfulzngQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=OZZoDmhm; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1F19C19B66E;
	Mon, 18 Mar 2024 19:50:45 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710787845; bh=GChzgFkLSFfXOvDycrNyoENtyeaLJWvTdv+K6gnIsKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZZoDmhmfK+t1ieFt0Z0mAh1VFBu0uOdD4jOhYcfCaVZUuVVm4uxR3roXuvAgXz+4
	 P1i8xkwWEGeX6u085SC0Tqtv0V+s5O4gHXj/uE7PwhM9Sl1elT/aqnhZN0PXyzXuzH
	 vx7Lfd27+jECootcqJ+2J9gVf+/4OfEx/Bs4gcfKc1KNbq8eS5sw+CQ4LHFEvZXVAK
	 5TI5Jh/ZoEKxq8Gx/TwhvROA4x9L+hKmTaa51ILFO7p+/j7SHTksjgLQ0rpXJLki/N
	 GGablG5ybJ/M4Z7ZtQJ+UP8wxaTb9OiUxMGhzPb9LjKM1PjyMzSsWrDJHbGvbCegjJ
	 fDa2YVufm7LhQ==
Date: Mon, 18 Mar 2024 19:50:44 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Will Deacon <will@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Message-ID: <20240318195007.2a91dc87@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41571EBB261FA3B5FFCD9BAFD42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240318130447.594-1-petrtesarik@huaweicloud.com>
	<20240318130447.594-2-petrtesarik@huaweicloud.com>
	<SN6PR02MB41571EBB261FA3B5FFCD9BAFD42D2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 15:37:16 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Monday, March 18, 2024 6:05 AM
> > 
> > Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
> > alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-zero
> > bits in the original address between IO_TLB_SIZE and alloc_align_mask,
> > these bits are not preserved in the swiotlb buffer address.
> > 
> > To fix this case, increase the allocation size and use a larger offset
> > within the allocated buffer. As a result, extra padding slots may be
> > allocated before the mapping start address.
> > 
> > Set the orig_addr in these padding slots to INVALID_PHYS_ADDR, because they
> > do not correspond to any CPU buffer and the data must never be synced.  
> 
> This paragraph is now obsolete.

Right. It should now say that orig_addr already _is_ set to
INVALID_PHYS_ADDR, so attempts to sync data will be ignored.

> > 
> > The padding slots should be automatically released when the buffer is
> > unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
> > DMA buffer slot, not the first padding slot. Save the number of padding
> > slots in struct io_tlb_slot and use it to adjust the slot index in
> > swiotlb_release_slots(), so all allocated slots are properly freed.
> > 
> > Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
> > Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
> > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > ---
> >  kernel/dma/swiotlb.c | 35 +++++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 86fe172b5958..aefb05ff55e7 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -69,11 +69,14 @@
> >   * @alloc_size:	Size of the allocated buffer.
> >   * @list:	The free list describing the number of free entries available
> >   *		from each index.
> > + * @pad_slots:	Number of preceding padding slots. Valid only in the first
> > + *		allocated non-padding slot.
> >   */
> >  struct io_tlb_slot {
> >  	phys_addr_t orig_addr;
> >  	size_t alloc_size;
> > -	unsigned int list;
> > +	unsigned short list;
> > +	unsigned short pad_slots;
> >  };
> > 
> >  static bool swiotlb_force_bounce;
> > @@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> >  					 mem->nslabs - i);
> >  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> >  		mem->slots[i].alloc_size = 0;
> > +		mem->slots[i].pad_slots = 0;
> >  	}
> > 
> >  	memset(vaddr, 0, bytes);
> > @@ -1328,11 +1332,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  		unsigned long attrs)
> >  {
> >  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> > -	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > +	unsigned int offset;
> >  	struct io_tlb_pool *pool;
> >  	unsigned int i;
> >  	int index;
> >  	phys_addr_t tlb_addr;
> > +	unsigned short pad_slots;
> > 
> >  	if (!mem || !mem->nslabs) {
> >  		dev_warn_ratelimited(dev,
> > @@ -1349,6 +1354,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> >  	}
> > 
> > +	/*
> > +	 * Calculate buffer pre-padding within the allocated space. Use it to
> > +	 * preserve the low bits of the original address according to device's
> > +	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
> > +	 * (whichever is bigger); higher bits of the original address are
> > +	 * preserved by selecting a suitable IO TLB slot.
> > +	 */
> > +	offset = orig_addr & dma_get_min_align_mask(dev) &
> > +		(alloc_align_mask | (IO_TLB_SIZE - 1));
> >  	index = swiotlb_find_slots(dev, orig_addr,
> >  				   alloc_size + offset, alloc_align_mask, &pool);
> >  	if (index == -1) {
> > @@ -1364,6 +1378,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  	 * This is needed when we sync the memory.  Then we sync the buffer if
> >  	 * needed.
> >  	 */
> > +	pad_slots = offset / IO_TLB_SIZE;
> > +	offset %= IO_TLB_SIZE;
> > +	index += pad_slots;
> > +	pool->slots[index].pad_slots = i;  
> 
> The above line should be:
> 	pool->slots[index].pad_slots = pad_slots;

Doh. Yes, I rewrote it a few times and then forgot to change this.

How did it even pass the test suite?

Thank you for the review.

Petr T

> >  	for (i = 0; i < nr_slots(alloc_size + offset); i++)
> >  		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
> >  	tlb_addr = slot_addr(pool->start, index) + offset;
> > @@ -1385,12 +1403,16 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> >  	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
> >  	unsigned long flags;
> >  	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
> > -	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> > -	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
> > -	int aindex = index / mem->area_nslabs;
> > -	struct io_tlb_area *area = &mem->areas[aindex];
> > +	int index, nslots, aindex;
> > +	struct io_tlb_area *area;
> >  	int count, i;
> > 
> > +	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> > +	index -= mem->slots[index].pad_slots;
> > +	nslots = nr_slots(mem->slots[index].alloc_size + offset);
> > +	aindex = index / mem->area_nslabs;
> > +	area = &mem->areas[aindex];
> > +
> >  	/*
> >  	 * Return the buffer to the free list by setting the corresponding
> >  	 * entries to indicate the number of contiguous entries available.
> > @@ -1413,6 +1435,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> >  		mem->slots[i].list = ++count;
> >  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> >  		mem->slots[i].alloc_size = 0;
> > +		mem->slots[i].pad_slots = 0;
> >  	}
> > 
> >  	/*
> > --
> > 2.34.1  
> 


