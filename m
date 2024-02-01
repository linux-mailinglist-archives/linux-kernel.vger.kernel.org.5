Return-Path: <linux-kernel+bounces-48295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603478459B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BB289C64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376AF5D484;
	Thu,  1 Feb 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl5vs/Gt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD95336D;
	Thu,  1 Feb 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796774; cv=none; b=kDWZfrB5E+8UGITI0ASusohhdAfdiukYXmlceM1p1f/QiT3XY5fbTccfPKP4E9cH2EzY3XS1i4LwRItXtmrd7wva5T9vEyl65R8TPFPBW6F07chauEBIGdybejKF+xYiFE+7Q53DopBLkmJPVxdecvhikztPHYr4Q+NyP7H0pOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796774; c=relaxed/simple;
	bh=8pxph5DDQ1i3FUXJ1ruGLd1ysZhEeq1PElzze4t5/wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/5T3r0DApfQqUlfYkgNeC4A8ysh3+3moi2/KYGAtwgqW5jS09xHqrMmKmZJLB8FxJ+oLZ6tEcIYlYcOnN+4JmRKWyVrTP0UW7L/Q9gm3itXDMcdr//DH7jy4HMuUsb3+/X1W3185HvVFzgJtOMKP73qLtG4KowUDXaIHRBOQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl5vs/Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856FC433C7;
	Thu,  1 Feb 2024 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706796774;
	bh=8pxph5DDQ1i3FUXJ1ruGLd1ysZhEeq1PElzze4t5/wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl5vs/Gt1V98kTsMUdiLxbqaLnsDTlbUa2MngQcURrYPh2Fg2K0VVYs/LD+rZl8sc
	 uZl3EUF99D01Ce5mQrOaJFy7L/Cxt2AejodO2hRCQyjYo88U85eW0RImSYToVK9vYN
	 tFX3sD6Tdy7mXtKIqEIRtKYidJSaIxOMItZh2xYg/96Rde0B/eRWm/cr1oapYVTqDY
	 vArPT47NlmbOgqG9YOgYa5YTe9bxluWaRasrrXb/hq+RWu+q+2X9YgMVXoJFynyMwf
	 ibGYyQNa9/D6KuLh9vqy+iEMdvjJaD6Nx231JJQxvi07vzlWHAfOHWEskMuP+q77a3
	 fMgLtFTV0VuQw==
Date: Thu, 1 Feb 2024 14:12:48 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2 1/3] swiotlb: Fix allocation alignment requirement
 when searching slots
Message-ID: <20240201141248.GA15753@willie-the-truck>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-2-will@kernel.org>
 <4c9f50d2-05f9-4a37-ac50-dcd98e40e87f@arm.com>
 <20240201124634.GA15707@willie-the-truck>
 <c235493f-c28d-43cf-969f-0fb148cb5dda@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c235493f-c28d-43cf-969f-0fb148cb5dda@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 01, 2024 at 01:30:15PM +0000, Robin Murphy wrote:
> On 01/02/2024 12:46 pm, Will Deacon wrote:
> > On Wed, Jan 31, 2024 at 03:54:03PM +0000, Robin Murphy wrote:
> > > On 31/01/2024 12:25 pm, Will Deacon wrote:
> > > > Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> > > > which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> > > > checks"), causes a functional regression with vsock in a virtual machine
> > > > using bouncing via a restricted DMA SWIOTLB pool.
> > > > 
> > > > When virtio allocates the virtqueues for the vsock device using
> > > > dma_alloc_coherent(), the SWIOTLB search fails to take into account the
> > > > 8KiB buffer size and returns page-unaligned allocations if 'area->index'
> > > > was left unaligned by a previous allocation from the buffer:
> > > 
> > > Hmm, but isn't this fundamentally swiotlb_alloc()'s fault for assuming it's
> > > going to get a page-aligned address back despite asking for 0 alignment in
> > > the first place? I'm not sure SWIOTLB has ever promised implicit
> > > size-alignment, so it feels somewhat misplaced to be messing with the
> > > algorithm before fixing the obvious issue in the caller :/
> > 
> > It's hard to tell which guarantees are intentional here given that this
> > interface is all internal to swiotlb.c, but the 'alloc_align_mask'
> > parameter didn't even exist prior to e81e99bacc9f ("swiotlb: Support
> > aligned swiotlb buffers") and practically the implementation has ensured
> > page-aligned allocations for buffers >= PAGE_SIZE prior to 0eee5ae10256
> > ("swiotlb: fix slot alignment checks") by virtue of aligning the search
> > index to the stride.
> > 
> > In any case, this patch is required because the current state of
> > swiotlb_search_pool_area() conflates the DMA alignment mask, the
> > allocation alignment mask and the stride so that even if a non-zero
> > 'alloc_align_mask' is passed in, it won't necessarily be honoured.
> 
> Sure, I didn't mean to suggest there wasn't anything to fix here - if the
> existing code was intending to align to PAGE_SIZE even for a
> alloc_align_mask=0 and failing then that's clearly its own bug - I'm mostly
> being confused by the example of returning an unsuitably-aligned address for
> an 8KB dma_alloc_coherent() 75% of the time, if the end result of this fix
> is that we'll *still* return an incorrectly-aligned buffer for that same
> request 50% of the time (which just happens to be less fatal), since there
> are two separate bugs in that path.

I'll have a go at improving the commit message a bit, since I wrote that
before I'd really appreciated that we weren't returning natural alignment
(and page-alignment seems to be sufficient for whatever vsock needs).

Thanks,

Will

