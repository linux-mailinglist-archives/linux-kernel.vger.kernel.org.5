Return-Path: <linux-kernel+bounces-27147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6882EB35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E9A1C22EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803812B9F;
	Tue, 16 Jan 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hklNV1fF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA0312B97
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F66C433F1;
	Tue, 16 Jan 2024 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705395628;
	bh=di/4fMjfr6Qyln0B/UJqaBwpqtAPoZXkJ8p/k1oNafw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hklNV1fFN5eLri4NfL+3V9gE5akiVw5GC5qfmWJrOJgIe/0OgrBA88PLZdwcQ2TnL
	 NMxykHRst2G33UAwtW2S+gB54g0d7ynHHt0jO3nkgPdZqDLpIHXN2oOFQYyY/dcq8O
	 7Bc/gn/BYJOZeNdfL3Da9m851xUT4LGjp53eu1Molfld2Rvde8QVQH1ACz1svNE1dd
	 83h8DAu8JipA583K64Q6n9I1e7YSEOpqLd88wt4yJk98ckAH05EKRkrifAvdlCT2D1
	 dnK4iCvRmz9AI7KT6yXVPmhhrrEK+L+mpgm/Kr0J9zdfUXqa7xUuOp00p3CQrptDmy
	 2MF0CJGGMq+3A==
Date: Tue, 16 Jan 2024 16:47:36 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: still create swiotlb buffer for kmalloc()
 bouncing if required
Message-ID: <ZaZCqAir6BdiN80K@xhacker>
References: <20231202134224.4029-1-jszhang@kernel.org>
 <aea8222e-ec0a-4844-abd0-7fe102bc2bec@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aea8222e-ec0a-4844-abd0-7fe102bc2bec@ghiti.fr>

On Tue, Jan 16, 2024 at 09:23:47AM +0100, Alexandre Ghiti wrote:
> Hi Jisheng,
> 
> On 02/12/2023 14:42, Jisheng Zhang wrote:
> > After commit f51f7a0fc2f4 ("riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC
> > for !dma_coherent"), for non-coherent platforms with less than 4GB
> > memory, we rely on users to pass "swiotlb=mmnn,force" kernel parameters
> > to enable DMA bouncing for unaligned kmalloc() buffers. Now let's go
> > further: If no bouncing needed for ZONE_DMA, let kernel automatically
> > allocate 1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing on
> > non-coherent platforms, so that no need to pass "swiotlb=mmnn,force"
> > any more.
> 
> IIUC, DMA_BOUNCE_UNALIGNED_KMALLOC is enabled for all non-coherent
> platforms, even those with less than 4GB of memory. But the DMA bouncing
> (which is necessary to enable kmalloc-8/16/32/96...) was not enabled unless
> the user specified "swiotlb=mmnn,force" on the kernel command line. But does
> that mean that if the user did not specify "swiotlb=mmnn,force", the
> kmalloc-8/16/32/96 were enabled anyway and the behaviour was wrong (by lack
> of DMA bouncing)?

Hi Alex,

For coherent platforms, kmalloc-8/16/32/96 was enabled.

For non-coherent platforms, if memory is more than 4GB, kmalloc-8/16/32/96 was enabled.

For non-coherent platforms, if memory is less than 4GB, kmalloc-8/16/32/96 was not
enabled. If users want kmalloc-8/16/32/96, we rely on users to pass "swiotlb=mmnn,force"

This patch tries to remove the "swiotlb=mmnn,force" requirement for the
last case. After this patch, kernel automatically uses "1MB swiotlb buffer per
1GB of RAM for kmalloc() bouncing" by default.

So this is an enhancement.

Thanks
> 
> I'm trying to understand if that's a fix or an enhancement.
> 
> Thanks,
> 
> Alex
> 
> 
> > 
> > The math of "1MB swiotlb buffer per 1GB of RAM for kmalloc() bouncing"
> > is taken from arm64. Users can still force smaller swiotlb buffer by
> > passing "swiotlb=mmnn".
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > 
> > since v2:
> >   - fix build error if CONFIG_RISCV_DMA_NONCOHERENT=n
> > 
> >   arch/riscv/include/asm/cache.h |  2 +-
> >   arch/riscv/mm/init.c           | 16 +++++++++++++++-
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> > index 2174fe7bac9a..570e9d8acad1 100644
> > --- a/arch/riscv/include/asm/cache.h
> > +++ b/arch/riscv/include/asm/cache.h
> > @@ -26,8 +26,8 @@
> >   #ifndef __ASSEMBLY__
> > -#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> >   extern int dma_cache_alignment;
> > +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> >   #define dma_get_cache_alignment dma_get_cache_alignment
> >   static inline int dma_get_cache_alignment(void)
> >   {
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 2e011cbddf3a..cbcb9918f721 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -162,11 +162,25 @@ static void print_vm_layout(void) { }
> >   void __init mem_init(void)
> >   {
> > +	bool swiotlb = max_pfn > PFN_DOWN(dma32_phys_limit);
> >   #ifdef CONFIG_FLATMEM
> >   	BUG_ON(!mem_map);
> >   #endif /* CONFIG_FLATMEM */
> > -	swiotlb_init(max_pfn > PFN_DOWN(dma32_phys_limit), SWIOTLB_VERBOSE);
> > +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb &&
> > +	    dma_cache_alignment != 1) {
> > +		/*
> > +		 * If no bouncing needed for ZONE_DMA, allocate 1MB swiotlb
> > +		 * buffer per 1GB of RAM for kmalloc() bouncing on
> > +		 * non-coherent platforms.
> > +		 */
> > +		unsigned long size =
> > +			DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
> > +		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
> > +		swiotlb = true;
> > +	}
> > +
> > +	swiotlb_init(swiotlb, SWIOTLB_VERBOSE);
> >   	memblock_free_all();
> >   	print_vm_layout();

