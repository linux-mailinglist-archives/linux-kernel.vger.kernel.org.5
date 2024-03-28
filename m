Return-Path: <linux-kernel+bounces-123105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78847890234
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E064293B95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A728912BEA5;
	Thu, 28 Mar 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEGxisbI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B181ABE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637216; cv=none; b=fT/Yu0OVf7GDNTVrwk66zVS/HkoUySrvHYyILmZHHGcJN+pNI8lAxqPiLwVAXddNUFerGX1kbKPko4yca+iYU3woSbbkZloCbftpK8klKuPQY8Efn470H82Haco1KPZ2JL8aE/cv4Sc0HNlsOXQP39OzlmFWYRuyWvHOOWHuE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637216; c=relaxed/simple;
	bh=GBmw0u0sk6raQ2641DnVvOuLU698WOt7jEDcGyiJFg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdJlwXH93d2OtpbFl0clkxczQkihH8RrG+oJtPuEZO4A5gebSfkzgCLF5RYyTr10ahxJ1tlgGTrznhb0EzUiow3qztrhDJNUOeA+53nYPa4gdA30V+O5r+a7oUGcBQdm7RR1bfjnahDss3BFX4CsucasvsjZic+oiDKgd8kqVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEGxisbI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711637213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPAuSkYgy+MUhS8KdVZMaOcLOllCqbF/NxocVA82LN4=;
	b=OEGxisbIvkcODE/KYGbXLdMJX1OcpXd4c8b9WzIOiTzQyQlS+Lq4+qVJ3cqIub4lhBZKkZ
	/PzGTH1u+IT7C+DO/GTZFceXrffpVYQdzB30YQvKf6gjClpvY0YVKaoyPYuGOLpvPKfmJK
	dQy9Hg4UAxAE1jxZfKQXleqcC/B/JFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-PInHT43-PY2c36tojWgsHg-1; Thu, 28 Mar 2024 10:46:50 -0400
X-MC-Unique: PInHT43-PY2c36tojWgsHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E226801906;
	Thu, 28 Mar 2024 14:46:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FD432024517;
	Thu, 28 Mar 2024 14:46:48 +0000 (UTC)
Date: Thu, 28 Mar 2024 22:46:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <ZgWCzx7+OxPgFIaU@MiWiFi-R3L-srv>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-5-bhe@redhat.com>
 <ZgUrJuatQqAT0QA1@MiWiFi-R3L-srv>
 <ZgU9_zpuIOu2b_gT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgU9_zpuIOu2b_gT@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/28/24 at 11:53am, Mike Rapoport wrote:
> On Thu, Mar 28, 2024 at 04:32:38PM +0800, Baoquan He wrote:
> > On 03/25/24 at 10:56pm, Baoquan He wrote:
> > >  
> > >  		/*
> > > -		 * Set an approximate value for lowmem here, it will be adjusted
> > > -		 * when the bootmem allocator frees pages into the buddy system.
> > > -		 * And all highmem pages will be managed by the buddy system.
> > > +		 * Initialize zone->managed_pages as 0 , it will be reset
> > > +		 * when memblock allocator frees pages into buddy system.
> > >  		 */
> > > -		zone_init_internals(zone, j, nid, freesize);
> > > +		zone_init_internals(zone, j, nid, 0);
> > 
> > Here, we should initialize zone->managed_pages as zone->present_pages
> > because later page_group_by_mobility_disabled need be set according to
> > zone->managed_pages. Otherwise page_group_by_mobility_disabled will be
> > set to 1 always. I will sent out v3.
> 
> With zone->managed_pages set to zone->present_pages we won't account for
> the reserved memory for initialization of page_group_by_mobility_disabled.

The old zone->managed_pages didn't account for the reserved pages
either. It's calculated by (zone->present_pages - memmap_pages). memmap
pages only is only a very small portion, e.g on x86_64, 4K page size,
assuming size of struct page is 64, then it's 1/64 of system memory.
On arm64, 64K page size, it's 1/1024 of system memory.

And about the setting of page_group_by_mobility_disabled, the compared
value pageblock_nr_pages * MIGRATE_TYPES which is very small. On x86_64,
it's 4M*6=24M; on arm64 with 64K size and 128M*6=768M which should be
the biggest among ARCH-es. 

	if (vm_total_pages < (pageblock_nr_pages * MIGRATE_TYPES)) 
                page_group_by_mobility_disabled = 1;
        else    
                page_group_by_mobility_disabled = 0;

So page_group_by_mobility_disabled could be set to 1 only on system with
very little memory which is very rarely seen. And setting
zone->managed_pages as zone->present_pages is very close to its old
value: (zone->present_pages - memmap_pages). Here we don't need be very
accurate, just a rough value.

> 
> As watermarks are still not initialized at the time build_all_zonelists()
> is called, we may use nr_all_pages - nr_kernel_pages instead of
> nr_free_zone_pages(), IMO.

nr_all_pages should be fine if we take this way. nr_kernel_pages is a
misleading name, it's all low memory pages excluding kernel reserved
apges. nr_all_pages is all memory pages including highmema and exluding
kernel reserved pages.

Both is fine to me. The first one is easier, simply setting
zone->managed_pages as zone->present_pages. The 2nd way is a little more
accurate.

>  
> > From a17b0921b4bd00596330f61ee9ea4b82386a9fed Mon Sep 17 00:00:00 2001
> > From: Baoquan He <bhe@redhat.com>
> > Date: Thu, 28 Mar 2024 16:20:15 +0800
> > Subject: [PATCH] mm/mm_init.c: set zone's ->managed_pages as ->present_pages
> >  for now
> > Content-type: text/plain
> > 
> > Because page_group_by_mobility_disabled need be set according to zone's
> > managed_pages later.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/mm_init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index cc24e7958c0c..dd875f943cbb 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1561,7 +1561,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
> >  		 * Initialize zone->managed_pages as 0 , it will be reset
> >  		 * when memblock allocator frees pages into buddy system.
> >  		 */
> > -		zone_init_internals(zone, j, nid, 0);
> > +		zone_init_internals(zone, j, nid, zone->present_pages);
> >  
> >  		if (!size)
> >  			continue;
> > -- 
> > 2.41.0
> > 
> > 
> > >  
> > >  		if (!size)
> > >  			continue;
> > > @@ -1915,6 +1878,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> > >  		check_for_memory(pgdat);
> > >  	}
> > >  
> > > +	calc_nr_kernel_pages();
> > >  	memmap_init();
> > >  
> > >  	/* disable hash distribution for systems with a single node */
> > > -- 
> > > 2.41.0
> > > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 


