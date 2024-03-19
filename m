Return-Path: <linux-kernel+bounces-107825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB94F880224
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BBD28339B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326E84A55;
	Tue, 19 Mar 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1gFlxcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6881ADE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865093; cv=none; b=VGq/IErYg2faIwg92HNNZ/rQKxl7LRHn8mj1a+6Qgcso/V7Bp7lWqWSDBM0KczBH6AoafbgRCU5xeU0P0L+lkztSAkFpHgurshGYK0iWIUUeNGvSMdmjRP7GhCTcxDap8tn60Bj4j75XthLOhc8CmzbZOyFMRtg5j3E/GHThQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865093; c=relaxed/simple;
	bh=d0rUTsfB2PCFWi1NwKDB0tLU9VzNlX5I7JRarfxcQ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMzmr74e4JbCRP04vq6SqM7PsQNpcZ/dI5Elg38ZgRY32J8icktdblTZiNIu/RXFs+u8wbjjVDz5khx0ujzAbRA5YoWUi4z89W6TG+eAV2LsVX2yRBm7mnVO3XzbEff9JLFXcR2g0WBRa7J2D7/xKv0BKC8qitsuR8Lc0kBRP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1gFlxcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183B0C433F1;
	Tue, 19 Mar 2024 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710865093;
	bh=d0rUTsfB2PCFWi1NwKDB0tLU9VzNlX5I7JRarfxcQ3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1gFlxcwZtWV6mPCa6DoyMtNy+ryKBDf7VvGjK1BHFSa7zvNqAfMh0onxw6Esp6QA
	 PdtPaEq244NK/VR1baqWWmr8Jm5lRiiOFlxLy2BJ7+L/3dh8ky56lsuVQ8qPWv9USw
	 Fwx2xeEIeFlW+EmLzc4lDe+1kcdZz9NegjmvJzwVdrcqyAomgfUR+EfajNg58N06A/
	 pR9Q+uxTUj59w9eCDo3wfS4g4NZHs3j3oXAv+Xuzc/pGvsiAM6GhhJFfnju+oGBDou
	 nnbyNOrGIxWsBdHElN/Q4Dk6etROiiRyPNGkSwzuM6j7bLC4/rAgVHGYdzoj9yHVFI
	 BOLZTacLYrKLA==
Date: Tue, 19 Mar 2024 18:17:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <Zfm6gzhKUehLwM5-@kernel.org>
References: <20240318142138.783350-1-bhe@redhat.com>
 <20240318142138.783350-5-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318142138.783350-5-bhe@redhat.com>

On Mon, Mar 18, 2024 at 10:21:36PM +0800, Baoquan He wrote:
> Currently, in free_area_init_core(), when initialize zone's field, a
> rough value is set to zone->managed_pages. That value is calculated by
> (zone->present_pages - memmap_pages).
> 
> In the meantime, add the value to nr_all_pages and nr_kernel_pages which
> represent all free pages of system (only low memory or including HIGHMEM
> memory separately). Both of them are gonna be used in
> alloc_large_system_hash().
> 
> However, the rough calculation and setting of zone->managed_pages is
> meaningless because
>   a) memmap pages are allocated on units of node in sparse_init() or
>      alloc_node_mem_map(pgdat); The simple (zone->present_pages -
>      memmap_pages) is too rough to make sense for zone;
>   b) the set zone->managed_pages will be zeroed out and reset with
>      acutal value in mem_init() via memblock_free_all(). Before the
>      resetting, no buddy allocation request is issued.
> 
> Here, remove the meaningless and complicated calculation of
> (zone->present_pages - memmap_pages), directly set zone->present_pages to
> zone->managed_pages. It will be adjusted in mem_init().

Do you mean "set zone->managed_pages to zone->present_pages"?

I think we can just set zone->managed_pages to 0 in free_area_init_core().
Anyway it will be reset before the first use.
 
> And also remove the assignment of nr_all_pages and nr_kernel_pages in
> free_area_init_core(). Instead, call the newly added calc_nr_kernel_pages()
> to count up all free but not reserved memory in memblock and assign to
> nr_all_pages and nr_kernel_pages. The counting excludes memmap_pages,
> and other kernel used data, which is more accurate than old way and
> simpler, and can also cover the ppc required arch_reserved_kernel_pages()
> case.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/mm_init.c | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index c57a7fc97a16..55a2b886b7a6 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1584,41 +1584,14 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  
>  	for (j = 0; j < MAX_NR_ZONES; j++) {
>  		struct zone *zone = pgdat->node_zones + j;
> -		unsigned long size, freesize, memmap_pages;
> -
> -		size = zone->spanned_pages;
> -		freesize = zone->present_pages;
> -
> -		/*
> -		 * Adjust freesize so that it accounts for how much memory
> -		 * is used by this zone for memmap. This affects the watermark
> -		 * and per-cpu initialisations
> -		 */
> -		memmap_pages = calc_memmap_size(size, freesize);
> -		if (!is_highmem_idx(j)) {
> -			if (freesize >= memmap_pages) {
> -				freesize -= memmap_pages;
> -				if (memmap_pages)
> -					pr_debug("  %s zone: %lu pages used for memmap\n",
> -						 zone_names[j], memmap_pages);
> -			} else
> -				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
> -					zone_names[j], memmap_pages, freesize);
> -		}
> -
> -		if (!is_highmem_idx(j))
> -			nr_kernel_pages += freesize;
> -		/* Charge for highmem memmap if there are enough kernel pages */
> -		else if (nr_kernel_pages > memmap_pages * 2)
> -			nr_kernel_pages -= memmap_pages;
> -		nr_all_pages += freesize;
> +		unsigned long size = zone->spanned_pages;
>  
>  		/*
> -		 * Set an approximate value for lowmem here, it will be adjusted
> -		 * when the bootmem allocator frees pages into the buddy system.
> -		 * And all highmem pages will be managed by the buddy system.
> +		 * Set the zone->managed_pages as zone->present_pages roughly, it
> +		 * be zeroed out and reset when memblock allocator frees pages into
> +		 * buddy system.
>  		 */
> -		zone_init_internals(zone, j, nid, freesize);
> +		zone_init_internals(zone, j, nid, zone->present_pages);
>  
>  		if (!size)
>  			continue;
> @@ -1915,6 +1888,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  		check_for_memory(pgdat);
>  	}
>  
> +	calc_nr_kernel_pages();
>  	memmap_init();
>  
>  	/* disable hash distribution for systems with a single node */
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.

