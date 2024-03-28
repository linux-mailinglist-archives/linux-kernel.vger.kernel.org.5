Return-Path: <linux-kernel+bounces-122643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573888FAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791A11C2744E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09D5FB8E;
	Thu, 28 Mar 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzEFiXoL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72405F876
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617150; cv=none; b=tQYwUfXQ628LhtOUlaLmT8P8JJX29WTy43cZjQjSQkjlkeJ74fFenLn0V3paBQuXICqMhxKw5waCdxaul0dCRwKmXlpwj4EAQ7AjzfitiirZ2rIKtAaAVgNb+uILOayRcLGCxcmn5f+BGTa1s9pEWtPnloZFL4OVCHzqX0t2Rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617150; c=relaxed/simple;
	bh=453aabz9gY4V0NB+CTB822uLwmneop0uj0nRs+yhbeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncpjql4tq3bjpS7bsmj12rfT5ME3AtxGqKOUiTuMPwUmOknsgiiJNxWKBH+T02M+tlZBrJC48T6xA8Tm6RpraVXP1luQj6YZ4B6l8HMG4fQRx9SuazSLEIyuDNUtCI+RwK1SmhFpcPeuL2YKdSchyIf/a58zh3IVVt0uDOr/o+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzEFiXoL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711617147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3BOFZe4TWqjEhb1bAaflU5nl+i6Cu2OrILowb6ESnek=;
	b=PzEFiXoLfXg8Rxylskpl5zDt/DW6PHEy3m1z0/N5JMoi83/TNzlOCQu3BcnacVwmWpkt7W
	62hCsBPjLoXYk5FHsu4vffOxHKDj1SRXAbyK+V+9Uo55/xbyAxusEIWZLCjv9bKv3upa+f
	kcH9VK92/zOafWAzNiYNDnrVc64cDfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-36l7FR52NXGgnYYGD1fFNw-1; Thu, 28 Mar 2024 05:12:22 -0400
X-MC-Unique: 36l7FR52NXGgnYYGD1fFNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 778F780026D;
	Thu, 28 Mar 2024 09:12:22 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF6BAC1576F;
	Thu, 28 Mar 2024 09:12:21 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:12:14 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v3 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <ZgU0bsJ2FEjykvju@MiWiFi-R3L-srv>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-5-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-5-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Currently, in free_area_init_core(), when initialize zone's field, a
rough value is set to zone->managed_pages. That value is calculated by
(zone->present_pages - memmap_pages).

In the meantime, add the value to nr_all_pages and nr_kernel_pages which
represent all free pages of system (only low memory or including HIGHMEM
memory separately). Both of them are gonna be used in
alloc_large_system_hash().

However, the rough calculation and setting of zone->managed_pages is
meaningless because
  a) memmap pages are allocated on units of node in sparse_init() or
     alloc_node_mem_map(pgdat); The simple (zone->present_pages -
     memmap_pages) is too rough to make sense for zone;
  b) the set zone->managed_pages will be zeroed out and reset with
     acutal value in mem_init() via memblock_free_all(). Before the
     resetting, no buddy allocation request is issued.

Here, remove the meaningless and complicated calculation of
(zone->present_pages - memmap_pages), directly set zone->managed_pages
as zone->present_pages for now. It will be adjusted in mem_init().

And also remove the assignment of nr_all_pages and nr_kernel_pages in
free_area_init_core(). Instead, call the newly added calc_nr_kernel_pages()
to count up all free but not reserved memory in memblock and assign to
nr_all_pages and nr_kernel_pages. The counting excludes memmap_pages,
and other kernel used data, which is more accurate than old way and
simpler, and can also cover the ppc required arch_reserved_kernel_pages()
case.

And also clean up the outdated code comment above free_area_init_core().
And free_area_init_core() is easy to understand now, no need to add
words to explain.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
- Change to initialize zone->managed_pages as zone->present_pages for now
  because later page_group_by_mobility_disabled need be set according to
  zone->managed_pages. Otherwise it will cause setting
  page_group_by_mobility_disabled to 1 always.

 mm/mm_init.c | 46 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index c57a7fc97a16..a4b80e8276bb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1565,15 +1565,6 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
 }
 #endif
 
-/*
- * Set up the zone data structures:
- *   - mark all pages reserved
- *   - mark all memory queues empty
- *   - clear the memory bitmaps
- *
- * NOTE: pgdat should get zeroed by caller.
- * NOTE: this function is only called during early init.
- */
 static void __init free_area_init_core(struct pglist_data *pgdat)
 {
 	enum zone_type j;
@@ -1584,41 +1575,13 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
-
-		size = zone->spanned_pages;
-		freesize = zone->present_pages;
-
-		/*
-		 * Adjust freesize so that it accounts for how much memory
-		 * is used by this zone for memmap. This affects the watermark
-		 * and per-cpu initialisations
-		 */
-		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
-			if (freesize >= memmap_pages) {
-				freesize -= memmap_pages;
-				if (memmap_pages)
-					pr_debug("  %s zone: %lu pages used for memmap\n",
-						 zone_names[j], memmap_pages);
-			} else
-				pr_warn("  %s zone: %lu memmap pages exceeds freesize %lu\n",
-					zone_names[j], memmap_pages, freesize);
-		}
-
-		if (!is_highmem_idx(j))
-			nr_kernel_pages += freesize;
-		/* Charge for highmem memmap if there are enough kernel pages */
-		else if (nr_kernel_pages > memmap_pages * 2)
-			nr_kernel_pages -= memmap_pages;
-		nr_all_pages += freesize;
+		unsigned long size = zone->spanned_pages;
 
 		/*
-		 * Set an approximate value for lowmem here, it will be adjusted
-		 * when the bootmem allocator frees pages into the buddy system.
-		 * And all highmem pages will be managed by the buddy system.
+		 * Initialize zone->managed_pages as 0 , it will be reset
+		 * when memblock allocator frees pages into buddy system.
 		 */
-		zone_init_internals(zone, j, nid, freesize);
+		zone_init_internals(zone, j, nid, zone->present_pages);
 
 		if (!size)
 			continue;
@@ -1915,6 +1878,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 		check_for_memory(pgdat);
 	}
 
+	calc_nr_kernel_pages();
 	memmap_init();
 
 	/* disable hash distribution for systems with a single node */
-- 
2.41.0


