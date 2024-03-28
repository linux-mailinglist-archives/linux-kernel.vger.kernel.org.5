Return-Path: <linux-kernel+bounces-122732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A588FC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B6B1F2CAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5625FB90;
	Thu, 28 Mar 2024 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8iqTLUC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F91DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619627; cv=none; b=uYHyEBwla4hbI/fOGhDR8mIjUWW2eWbu+pvseG9B/P+WC6kk46/mYYcigtIiEZtpZZEPr0+kAruaD7xoJZq7I3lIVhptl7ma0wt3LQp/8KV5NsXp0fXeIFEQK2LHs1ecRXGgS9ehzP0u0RSexhOJf9AKxD0k/3Nmgrx6NvO0+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619627; c=relaxed/simple;
	bh=Wm6m/5NnyZXHRXMhf1wtzYJHCSsEEotxxLtlnt6uvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMvTTEmG101SR/GpSSnkuole4Hbgfd75p/YUm0ndDbwlg0EdHDz63Zvs4clL81b3CGKewA/84f6taqEqVbKJ8bMwKLSzlUtxy3xGrj8gBkdhCoQ2NcGR2dkhSEqiKZraFS6vhEtsfZ1XadzZCJpiLZqwJWyF3vUz7/A+Xyvrz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8iqTLUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB673C433F1;
	Thu, 28 Mar 2024 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619627;
	bh=Wm6m/5NnyZXHRXMhf1wtzYJHCSsEEotxxLtlnt6uvfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8iqTLUC1Z26MKdfJFwiRCqyZ18YCrF2/CkvVqkztwWhlapXzOnK8juK0WNjLR9iW
	 HXOGboOQdgVSPZXdvbkhoq+lPLuwkOIHMdoKUwjQa4SEpGeppm7+4A/tlFYKA16FrZ
	 sXBSBnlfAWKvrEz12xKLtOd06KdMUKIN7XUImcuBCySQQiUKQx4Dj9YgG9RN7pbUf9
	 QojdrgaTUPDnRwZxkQ2dkXCTfUq30Iz4R9ZcF+P9QIpdq6Ao4G9EM6TPWC4kZlZXcY
	 QRX8PzVwyBv3YFaWCmk4d/KiMNzCOMYaGEMNmqXYiEJZ8fRQEA0npvcQ7ezBAo/DG2
	 EnoyUzrQaXCzw==
Date: Thu, 28 Mar 2024 11:53:03 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <ZgU9_zpuIOu2b_gT@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-5-bhe@redhat.com>
 <ZgUrJuatQqAT0QA1@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgUrJuatQqAT0QA1@MiWiFi-R3L-srv>

On Thu, Mar 28, 2024 at 04:32:38PM +0800, Baoquan He wrote:
> On 03/25/24 at 10:56pm, Baoquan He wrote:
> >  
> >  		/*
> > -		 * Set an approximate value for lowmem here, it will be adjusted
> > -		 * when the bootmem allocator frees pages into the buddy system.
> > -		 * And all highmem pages will be managed by the buddy system.
> > +		 * Initialize zone->managed_pages as 0 , it will be reset
> > +		 * when memblock allocator frees pages into buddy system.
> >  		 */
> > -		zone_init_internals(zone, j, nid, freesize);
> > +		zone_init_internals(zone, j, nid, 0);
> 
> Here, we should initialize zone->managed_pages as zone->present_pages
> because later page_group_by_mobility_disabled need be set according to
> zone->managed_pages. Otherwise page_group_by_mobility_disabled will be
> set to 1 always. I will sent out v3.

With zone->managed_pages set to zone->present_pages we won't account for
the reserved memory for initialization of page_group_by_mobility_disabled.

As watermarks are still not initialized at the time build_all_zonelists()
is called, we may use nr_all_pages - nr_kernel_pages instead of
nr_free_zone_pages(), IMO.
 
> From a17b0921b4bd00596330f61ee9ea4b82386a9fed Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Thu, 28 Mar 2024 16:20:15 +0800
> Subject: [PATCH] mm/mm_init.c: set zone's ->managed_pages as ->present_pages
>  for now
> Content-type: text/plain
> 
> Because page_group_by_mobility_disabled need be set according to zone's
> managed_pages later.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index cc24e7958c0c..dd875f943cbb 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1561,7 +1561,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		 * Initialize zone->managed_pages as 0 , it will be reset
>  		 * when memblock allocator frees pages into buddy system.
>  		 */
> -		zone_init_internals(zone, j, nid, 0);
> +		zone_init_internals(zone, j, nid, zone->present_pages);
>  
>  		if (!size)
>  			continue;
> -- 
> 2.41.0
> 
> 
> >  
> >  		if (!size)
> >  			continue;
> > @@ -1915,6 +1878,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> >  		check_for_memory(pgdat);
> >  	}
> >  
> > +	calc_nr_kernel_pages();
> >  	memmap_init();
> >  
> >  	/* disable hash distribution for systems with a single node */
> > -- 
> > 2.41.0
> > 
> 

-- 
Sincerely yours,
Mike.

