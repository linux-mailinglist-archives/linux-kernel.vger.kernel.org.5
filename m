Return-Path: <linux-kernel+bounces-68941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB57858231
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8041F22BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A9212FB30;
	Fri, 16 Feb 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ2AVVwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD012D770;
	Fri, 16 Feb 2024 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099999; cv=none; b=LYbihIk37TNqKBVOa5a8VJy6r6irZgoLk4byqabC2UZp7Ne6ui7JPdjhkwY3oLQZ6ddhsYVNFFNsyk4hCS6BNHw3hBlznLjsfuKZk6GMQpDjrDSQXQcG9H6SMIFeaoEUGDW65fH+MF+7NZ8qvTyB33ngbgz3MyAzdqgdSSj0zCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099999; c=relaxed/simple;
	bh=0C9+pCgjxRMOl9W9M/RJQspbO81gdJ2Y5+OCFt5kwAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoV3Sp4kkpKAZEudGTRBi1Ale0uBx48kMrjKFf3THWhCZNUagFyxmQ/h+NrM/3OdBN362aQMmV/f+z55DxF90sZjq9RDEa47TCMjXk1NTJeHVuHLGQYoOYVNmvhmn1EwkUgkXu+seSDSV5lEmvnrJWcdLCnymgQPuDxHhzHmhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ2AVVwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585B0C433C7;
	Fri, 16 Feb 2024 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708099998;
	bh=0C9+pCgjxRMOl9W9M/RJQspbO81gdJ2Y5+OCFt5kwAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQ2AVVwaKgHAtfDxbKsFun3Cxph1v1ovRg2RMHIfxNpeAFMxZoBEOaPhg+KMRRTFM
	 dLRVSYRF1YV2rMCcilm14ixVSLxgl1pfJyn5kLRar+fPcQITEyDRQG3ehlzAljPYF2
	 0Z39Z/YUMeaeipQ00UVGpvdYRSjtImymJsFsrnozJG3a+dkvLQn22ewV5tlTro2cyf
	 qQBkStYqVNzmodLKgIfctm15lIX3C6B+Bw7ZCBViG6f3pse+iE6j3E/YIMwBNWZxN2
	 Azgk3l0gu6/rm8sOJZr7FAlI2Yak86+3NTqkyi8VIituSoZpvE8MgpL59ggOqSjqva
	 DBapcF2ROFIgQ==
Date: Fri, 16 Feb 2024 16:13:12 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240216161312.GA2203@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
 <20240215163544.GA821@willie-the-truck>
 <Zc6rr/LleQ2krkyg@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6rr/LleQ2krkyg@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Nicolin,

Thanks for sharing all the logs, .config etc.

On Thu, Feb 15, 2024 at 04:26:23PM -0800, Nicolin Chen wrote:
> On Thu, Feb 15, 2024 at 04:35:45PM +0000, Will Deacon wrote:
> > On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:
> > > On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> > > > On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > > > > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > > > And it seems to get worse, as even a 64KB mapping is failing:
> > > > [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> > > >
> > > > With a printk, I found the iotlb_align_mask isn't correct:
> > > >    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> > > >
> > > > But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> > > > mapping..
> > >
> > > Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
> > > are 2KiB aligned. I'll try plugging in some of the constants you have
> > > here, as something definitely isn't right...
> > 
> > Sorry, another ask: please can you print 'orig_addr' in the case of the
> > failing allocation?
> 
> I added nvme_print_sgl() in the nvme-pci driver before its
> dma_map_sgtable() call, so the orig_addr isn't aligned with
> PAGE_SIZE=64K or NVME_CTRL_PAGE_SIZE=4K:
>  sg[0] phys_addr:0x0000000105774600 offset:17920 length:512 dma_address:0x0000000000000000 dma_length:0
> 
> Also attaching some verbose logs, in case you'd like to check:
>    nvme 0000:00:01.0: swiotlb_area_find_slots: dma_get_min_align_mask 0xfff, IO_TLB_SIZE 0xfffff7ff
>    nvme 0000:00:01.0: swiotlb_area_find_slots: alloc_align_mask 0xffff, iotlb_align_mask 0x7ff
>    nvme 0000:00:01.0: swiotlb_area_find_slots: stride 0x20, max 0xffff
>    nvme 0000:00:01.0: swiotlb_area_find_slots: tlb_addr=0xbd830000, iotlb_align_mask=0x7ff, alloc_align_mask=0xffff
> => nvme 0000:00:01.0: swiotlb_area_find_slots: orig_addr=0x105774600, iotlb_align_mask=0x7ff

With my patches, I think 'iotlb_align_mask' will be 0x800 here, so this
particular allocation might be alright, however I think I'm starting to
see the wider problem. The IOMMU code is asking for a 64k-aligned
allocation so that it can map it safely, but at the same time
dma_get_min_align_mask() is asking for congruence in the 4k NVME page
offset. Now, because we're going to allocate a 64k-aligned mapping and
offset it, I think the NVME alignment will just fall out in the wash and
checking the 'orig_addr' (which includes the offset) is wrong.

So perhaps this diff (which I'm sadly not able to test) will help? You'll
want to apply it on top of my other patches. The idea is to ignore the
bits of 'orig_addr' which will be aligned automatically by offseting from
the aligned allocation. I fixed the max() thing too, although that's only
an issue for older kernels.

Cheers,

Will

--->8

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 283eea33dd22..4a000d97f568 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
        dma_addr_t tbl_dma_addr =
                phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
        unsigned long max_slots = get_max_slots(boundary_mask);
-       unsigned int iotlb_align_mask =
-               dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
+       unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
        unsigned int nslots = nr_slots(alloc_size), stride;
        unsigned int offset = swiotlb_align_offset(dev, orig_addr);
        unsigned int index, slots_checked, count = 0, i;
@@ -993,6 +992,9 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
        BUG_ON(!nslots);
        BUG_ON(area_index >= pool->nareas);

+       alloc_align_mask |= (IO_TLB_SIZE - 1);
+       iotlb_align_mask &= ~alloc_align_mask;
+
        /*
         * For mappings with an alignment requirement don't bother looping to
         * unaligned slots once we found an aligned one.
@@ -1004,7 +1006,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
         * allocations.
         */
        if (alloc_size >= PAGE_SIZE)
-               stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
+               stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);

        spin_lock_irqsave(&area->lock, flags);
        if (unlikely(nslots > pool->area_nslabs - area->used))


