Return-Path: <linux-kernel+bounces-76952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46285FEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DC61C20AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49D155A39;
	Thu, 22 Feb 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cZQlKdRx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFB1552E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622030; cv=none; b=XHGOBmka0lxCbadOGSEytQ3CcdaoDzUjVRlFQ6hmfslB8PVDitX9jbFXvbMtFMDtV0IXv0p7YmuyU5NmWuswPyq4nJKw6ZSrCDdWQoz/6hEitfG35fKxLABIx0bmT/9Rw2t2oF5W5J3tEttpjRpQJgraTDYAmIviWfaLZh6TW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622030; c=relaxed/simple;
	bh=j4iGKGJvrW6Ii4mYNEtnmzZcm5bFunGVCcPlyZKcVEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmBy0z1xEtjyA02bGcrJOgYNEm9tsDKIyeJTCZatbAD7rxFv/mt+Bef9/xp0GDeZLvz0cdYRnFSt21Eu5I2apNU++Jc58uFwv0LwNVZUrIQTuhEg6SeavF2DHDadVGVhSShk+qxeBthaW7BX5jlYFhUqcOfWYu9EOCVsLpdXJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cZQlKdRx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1aaFYmWJOYjCrobR/mbIMeaCkuo57/YDbVrD4brlEWk=; b=cZQlKdRxi6wjlrIWrCdRrnIj3u
	3CPSFPfq6MAzCgGH0WXKvG+eRNjvzVSuoPl6db3PSK8GnywBDDJ7AMyQdZWGs2ys+wJDXXOr8LPIy
	sq+WgpGSgv0TH0FaGbr2twnPwcVstav37EkmQ/2p8FCntUVUjYCnFCMimz0P+6odR8vqK480HM47J
	l6Qwiiba7nH8rvb4adRZRNXJRo4gtYrZo6UYVr/UeCs10c8MRPf9+JYYX8aaTQoCw+djkRmhF3364
	tdyvPsLPu37VJYQ5MAiV9HGpUPn4lN2rrUwl48wEr7vvWLvPLqoo2HCheuUbOkOF8/XNEoGXNToHk
	q6CyZVsg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdCdn-000000049c5-06P8;
	Thu, 22 Feb 2024 17:13:47 +0000
Date: Thu, 22 Feb 2024 17:13:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] mm: remove total_mapcount()
Message-ID: <ZdeAys9D98RBaPL1@casper.infradead.org>
References: <20240222160943.622386-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222160943.622386-1-david@redhat.com>

On Thu, Feb 22, 2024 at 05:09:43PM +0100, David Hildenbrand wrote:
> We always get a head page, so we can just naturally interpret is as a folio
> (similar to other code).

memfd seems rather confused about how to iterate over the page cache.
Perhaps we could sort that out and then delete total_mapcount as a
second patch?

I haven't tested this at all, but ...

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/memfd.c b/mm/memfd.c
index d3a1ba4208c9..45e55b0e3cbe 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -29,28 +29,29 @@
 #define MEMFD_TAG_PINNED        PAGECACHE_TAG_TOWRITE
 #define LAST_SCAN               4       /* about 150ms max */
 
+static bool memfd_extra_refs(struct folio *folio)
+{
+	return folio_ref_count(folio) - folio_mapcount(folio) !=
+		folio_nr_pages(folio);
+}
+
 static void memfd_tag_pins(struct xa_state *xas)
 {
-	struct page *page;
+	struct folio *folio;
 	int latency = 0;
-	int cache_count;
 
 	lru_add_drain();
 
 	xas_lock_irq(xas);
-	xas_for_each(xas, page, ULONG_MAX) {
-		cache_count = 1;
-		if (!xa_is_value(page) &&
-		    PageTransHuge(page) && !PageHuge(page))
-			cache_count = HPAGE_PMD_NR;
-
-		if (!xa_is_value(page) &&
-		    page_count(page) - total_mapcount(page) != cache_count)
+	xas_for_each(xas, folio, ULONG_MAX) {
+		/* Can we have shadow/swap entries in memfd? */
+		if (xa_is_value(folio))
+			continue;
+
+		if (memfd_extra_refs(folio))
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
-		if (cache_count != 1)
-			xas_set(xas, page->index + cache_count);
 
-		latency += cache_count;
+		latency++;
 		if (latency < XA_CHECK_SCHED)
 			continue;
 		latency = 0;
@@ -75,7 +76,6 @@ static void memfd_tag_pins(struct xa_state *xas)
 static int memfd_wait_for_pins(struct address_space *mapping)
 {
 	XA_STATE(xas, &mapping->i_pages, 0);
-	struct page *page;
 	int error, scan;
 
 	memfd_tag_pins(&xas);
@@ -83,7 +83,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
 		int latency = 0;
-		int cache_count;
+		struct folio *folio;
 
 		if (!xas_marked(&xas, MEMFD_TAG_PINNED))
 			break;
@@ -95,16 +95,10 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
 		xas_set(&xas, 0);
 		xas_lock_irq(&xas);
-		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
+		xas_for_each_marked(&xas, folio, ULONG_MAX, MEMFD_TAG_PINNED) {
 			bool clear = true;
 
-			cache_count = 1;
-			if (!xa_is_value(page) &&
-			    PageTransHuge(page) && !PageHuge(page))
-				cache_count = HPAGE_PMD_NR;
-
-			if (!xa_is_value(page) && cache_count !=
-			    page_count(page) - total_mapcount(page)) {
+			if (memfd_extra_refs(folio)) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
@@ -118,8 +112,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			if (clear)
 				xas_clear_mark(&xas, MEMFD_TAG_PINNED);
 
-			latency += cache_count;
-			if (latency < XA_CHECK_SCHED)
+			if (++latency < XA_CHECK_SCHED)
 				continue;
 			latency = 0;
 

