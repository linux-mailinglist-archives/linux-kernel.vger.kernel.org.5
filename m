Return-Path: <linux-kernel+bounces-48153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F8845805
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EE61F279CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291286644;
	Thu,  1 Feb 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV3GV92r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3286625;
	Thu,  1 Feb 2024 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791600; cv=none; b=pGAIdHjw7bGxMMqm0+iipA1fIIWcFboHoL1wn8u2560aM3SqauGUOFRUv8TjhTCxxZ2JRL0gFKqLcurrh3YTsyIhV9GxJwlYHQIFs8/uBaZfkk8oNdElXwUFOmD3qz87cABIg2R2tj7p31VHzBbVYDx67Hhmb5i6T1uGeH9NaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791600; c=relaxed/simple;
	bh=Ozs8J41000u00dB2ZIw83RqiiLRy3YYbyXOG40NYRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPrt9CRVsahKGthiPmGpULgSi5YiN1SgyCInAizN4d3tQvX53FztfVH8WqmjRmz9k22ZHMX8smjG2hnPnApLOItxR490aXpzXMUsaAfhcWRDKUaoF07FAaUV6s2HXASmtlWQxqH2OX6aq4NG8zRYjByrWD9fjQN7VoQ66myqWKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV3GV92r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D524C433C7;
	Thu,  1 Feb 2024 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791600;
	bh=Ozs8J41000u00dB2ZIw83RqiiLRy3YYbyXOG40NYRg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gV3GV92rSzety+2LaA+j5pbLeIEYqtkmO44ZOu0MTkg0cPMuXy3hjhnzAzwjvq29p
	 4X0bOmPvXzEmQE1svyww0as4u0/Laz6fcso/6LKZP+Y5geI9NnWrw1NTuI8fkY/Smc
	 XFsocQFRcqGXoKTP2kK6pVSnS9ANsA4wmbm0n+m1xBF41xMj6c0VZBp7YTuRLNmM3C
	 oMQqtUNq+6PXFVTjAhrP+EPKD1Jw4V3FS4lWWbpgfZD25hwFYPGUMsSmp+id9FgMjL
	 m51uTRmObMJGlBaC2ZfDd43Os6eBTMGnEliRPo+FFvJFqNxQgapyGPHC+QbdcffhVW
	 J7JTpEWbx4mRg==
Date: Thu, 1 Feb 2024 12:46:34 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Fix allocation alignment requirement
 when searching slots
Message-ID: <20240201124634.GA15707@willie-the-truck>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-2-will@kernel.org>
 <4c9f50d2-05f9-4a37-ac50-dcd98e40e87f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9f50d2-05f9-4a37-ac50-dcd98e40e87f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Robin,

Cheers for having a look.

On Wed, Jan 31, 2024 at 03:54:03PM +0000, Robin Murphy wrote:
> On 31/01/2024 12:25 pm, Will Deacon wrote:
> > Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> > which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> > checks"), causes a functional regression with vsock in a virtual machine
> > using bouncing via a restricted DMA SWIOTLB pool.
> > 
> > When virtio allocates the virtqueues for the vsock device using
> > dma_alloc_coherent(), the SWIOTLB search fails to take into account the
> > 8KiB buffer size and returns page-unaligned allocations if 'area->index'
> > was left unaligned by a previous allocation from the buffer:
> 
> Hmm, but isn't this fundamentally swiotlb_alloc()'s fault for assuming it's
> going to get a page-aligned address back despite asking for 0 alignment in
> the first place? I'm not sure SWIOTLB has ever promised implicit
> size-alignment, so it feels somewhat misplaced to be messing with the
> algorithm before fixing the obvious issue in the caller :/

It's hard to tell which guarantees are intentional here given that this
interface is all internal to swiotlb.c, but the 'alloc_align_mask'
parameter didn't even exist prior to e81e99bacc9f ("swiotlb: Support
aligned swiotlb buffers") and practically the implementation has ensured
page-aligned allocations for buffers >= PAGE_SIZE prior to 0eee5ae10256
("swiotlb: fix slot alignment checks") by virtue of aligning the search
index to the stride.

In any case, this patch is required because the current state of
swiotlb_search_pool_area() conflates the DMA alignment mask, the
allocation alignment mask and the stride so that even if a non-zero
'alloc_align_mask' is passed in, it won't necessarily be honoured.

For example, I just gave it a spin with only patch #3 and then this log:

> >   # Final address in brackets is the SWIOTLB address returned to the caller
> >   | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)

Becomes:

  | virtio-pci 0000:00:07.0: alloc_size 0x2000, iotlb_align_mask 0x1800 stride 0x4: got slot 1645-1649/7168 (0x98326800)

So even though the stride is correct, we still end up with a 2KiB aligned
allocation.

Cheers,

Will

