Return-Path: <linux-kernel+bounces-99626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5C878AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3E1C2162D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30475820D;
	Mon, 11 Mar 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3QKdCO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1412433CC;
	Mon, 11 Mar 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197357; cv=none; b=JM9FipOjq/aChUwscMR1/8ER1i5PYOIGJI5xiF76b8KzfZYGRwIMB6LXqE19AObHRvRz+WaCuuChyqkwXl8MZDGb+ZzSQZjKXvbNwlSOOi/I4I/7+bKLfWM+VuBY9Ta082je1v0dkk+HF3q0edjQChS+yfJOkAkxR3PVut4Lpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197357; c=relaxed/simple;
	bh=4x5JZYqHqdYVcamVAyLlqhcsKG8VLNeJTDI/33dxYjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAtr42J+X4oEjPCmfxW++XlT/DWtgiJRQceenpa4MctaTEuJEUbWrQ01hYYgb6v1rDSwXJp1fSdowDmimexQLRYlHfmCD0PZR6nDrPa4ixoMbvexhkqhxv99hO4Dl80fNGmq0y8qRHQIkUk8CUwtUbjovVfpBa/v7Xzhzs5MI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3QKdCO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A3CC433C7;
	Mon, 11 Mar 2024 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197356;
	bh=4x5JZYqHqdYVcamVAyLlqhcsKG8VLNeJTDI/33dxYjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3QKdCO8OEHpC2I9zB5WhxNWKTIQT2TLVJ1wNuoQpDTz1DhrWcvo/TeN5UTHU3xjq
	 Tqduy8Z8XGnw+97Jtn0zm3+JzRWVyqOj+ITmQrPLcuiJaSj8fi3kteBg0OSXvjhs3Q
	 Z1CtVXUD76TOs/xOrGBAImIEAUjix6OX/NKddKPBCuftkUAovpkBALaQWX29w8O7NH
	 wn7xOWzDURamytMIfgtrArXlr+LxK5r/biv09nQniXlBLRsBW3ChkwB8SjQVX3Oh9b
	 YlDtMtE71edYmdIGcRA3yAl3FR3dgYNoLzFyMVTC7gRqVSrxgQH7+xm3XYpwbK7g6K
	 S0qNTbW1e3d8g==
Date: Mon, 11 Mar 2024 22:49:11 +0000
From: Will Deacon <will@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <20240311224910.GA28426@willie-the-truck>
References: <20240308152829.25754-1-will@kernel.org>
 <20240308152829.25754-5-will@kernel.org>
 <20240311210507.217daf8b@meshulam.tesarici.cz>
 <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote:
> From: Petr Tesařík <petr@tesarici.cz>
> > On Fri,  8 Mar 2024 15:28:27 +0000
> > Will Deacon <will@kernel.org> wrote:
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index c20324fba814..c381a7ed718f 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > >  	dma_addr_t tbl_dma_addr =
> > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > >  	unsigned long max_slots = get_max_slots(boundary_mask);
> > > -	unsigned int iotlb_align_mask =
> > > -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > > +	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
> > >  	unsigned int nslots = nr_slots(alloc_size), stride;
> > >  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > >  	unsigned int index, slots_checked, count = 0, i;
> > > @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > >  	BUG_ON(!nslots);
> > >  	BUG_ON(area_index >= pool->nareas);
> > >
> > > +	/*
> > > +	 * Ensure that the allocation is at least slot-aligned and update
> > > +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> > > +	 * offsetting into the allocation.
> > > +	 */
> > > +	alloc_align_mask |= (IO_TLB_SIZE - 1);
> > > +	iotlb_align_mask &= ~alloc_align_mask;
> > > +
> > 
> > I have started writing the KUnit test suite, and the results look
> > incorrect to me for this case.
> > 
> > I'm calling swiotlb_tbl_map_single() with:
> > 
> > * alloc_align_mask = 0xfff
> > * a device with min_align_mask = 0xfff
> > * the 12 lowest bits of orig_addr are 0xfa0
> > 
> > The min_align_mask becomes zero after the masking added by this patch,
> > and the 12 lowest bits of the returned address are 0x7a0, i.e. not
> > equal to 0xfa0.
> 
> The address returned by swiotlb_tbl_map_single() is the slot index
> converted to an address, plus the offset modulo the min_align_mask for
> the device.  The local variable "offset" in swiotlb_tbl_map_single()
> should be 0xfa0.  The slot index should be an even number to meet
> the alloc_align_mask requirement.  And the pool->start address should
> be at least page aligned, producing a page-aligned address *before* the
> offset is added. Can you debug which of these isn't true for the case
> you are seeing?

I was just looking into this, and I think the problem starts because
swiotlb_align_offset() doesn't return the offset modulo the min_align_mask,
but instead returns the offset *into the slot*:

	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);

so this presumably lops off bit 11 without adjusting the slot number.

I don't think swiotlb_find_slots() should be handling this though; it's
more about how swiotlb_tbl_map_single() puts the address back together
again.

> > In other words, the min_align_mask constraint is not honored. Of course,
> > given the above values, it is not possible to honor both min_align_mask
> > and alloc_align_mask. 
> 
> When orig_addr is specified and min_align_mask is set, alloc_align_mask
> governs the address of the _allocated_ space, which is not necessarily the
> returned physical address.  The min_align_mask may dictate some
> pre-padding of size "offset" within the allocated space, and the returned
> address is *after* that pre-padding.  In this way, both can be honored.

I agree, modulo the issue with the offset calculation.

Will

