Return-Path: <linux-kernel+bounces-50119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B384747D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5606B1F2B149
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582B148301;
	Fri,  2 Feb 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="lhM618jh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2ioDS5k"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A7146913
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890580; cv=none; b=B5s3JbPJ0ZCJE0Zf9X3igsUzEmsmZJ5UVcyOe8188iNxRnhgE+o5cAP6UvRK47H52s2A0ius/qdG9yCINd9m2ohdqOKqX2KLking8ue6tbmO4AntWnqXH9o+oEQB6x9f9iRVj44t1wQGi5TA4j8ERMM+qsTarCgqYrNpq+Jtu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890580; c=relaxed/simple;
	bh=Sjbq/9flKHP26VVIXKLKU/3PClA3qMbkP4jOAHyqFxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmZjSjOp96oGKTjflvfzE0fgzrFDgCXn2hLL+dptkP2lKmHtSRWGW2HgBoBMouMDZi5cdBUshRWT+fdE84aKXuyPPfGabldmr2ZuWrd6/UPEs7mQd699h2l+q6AVAbWOM2XKpYubIdVcZw0yyroa7EnQbzuEuiSZrKXXHWB0VZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=lhM618jh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2ioDS5k; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id B700A5C0114;
	Fri,  2 Feb 2024 11:16:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 11:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1706890577; x=1706976977; bh=o4ZHby28qW9Br68l3xQuwrxRewdgnvINZod
	3R2hEUmA=; b=lhM618jhymHQnFbLbCt+r46OvZFgJtpfYZ3fhNFVgoCcA4vTC2Q
	g9EO99bpRcHozcg/vMH9orlQP8aHtaZAr1awhEGRIaaGXXum3Km9pmXcBTgGsY52
	1+pPA9sAlyrIqoxDey32ZXg4Te+KQL5O/uZkHLWB94pDA83hfmCYeky2i9qPj3Zp
	WMpql6Wsmi1imreyNZj+Mh5pFKZpQm/1ReljfsaCG836ZR4guEdvx9M5cebwzNF8
	uhvWaxD52rKjpnuRlOgbLwl39Bs9TS9DRB8Cv/1iCvbG+eKi6DMAy3xJDddtwfCr
	qs/j38QqYk4wIOjozpn7zpU7zgMjaS5Jcmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706890577; x=1706976977; bh=o4ZHby28qW9Br68l3xQuwrxRewdgnvINZod
	3R2hEUmA=; b=e2ioDS5kjM6BcqcbT+gOOout9yH+3tSdGcVMChoY906dfx34kLi
	fntipjO2M5+S3PYf6NMKP79nH3jLLlNdRr6CoO9t2SSVUTI44IXyoAwAi1H0gmQd
	f8PP9Mrt3TsZjBNxiE12j+RM92qYm8nAc9HQPAd6TjZbRvq91qVeBKBX+kZJRSzt
	o7S5ZP/yXjaKpX7x9YS3hoRJz53h3/KYIbGYWNAoFQ30QFYeDXzd7gyR3PLiIAo6
	6kD5QOVLN3U05YnaR1bAlI8RLRUCbVWJQwPze6WZi8edqHXZiI1D4vih+Mfv77om
	MFBAAFlZK3FXyEcx9RJsr2R2ptDH/LMOYbw==
X-ME-Sender: <xms:URW9ZbVjdkXJikiSCKGhund9hKZi0gMIaUbBPpv9_zQDth87iFFSXw>
    <xme:URW9ZTkuzxnr3JR60UTCPi0V4bZ9oTQob4jP8bWGDBvv4jE6auyLIEVzWspnmnOTM
    7N4J3oQWXXF15dScA>
X-ME-Received: <xmr:URW9ZXY8qiJxLOXO3Qgh60vu_dnQB6V1cnUWvCa_9GDJ17y52gAnnbUl1bKgzeNZb8mV4_Yk3AXZuKv0QMlDVcT0p58B0BnPneTGO296ldJH9RdbHauxI98E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:URW9ZWUueQp5CZPimEnySS7A1k0wCTmzrA-Ac3rcJKFKC55GwiBwjg>
    <xmx:URW9ZVlDp-z1MP4Ay7UgZYkQzDSUlen9lL9IFrvHMYyP6CxF8OYm9A>
    <xmx:URW9ZTc_rM5kvsvrrdWUxJUlekQCmyTmx1KdfTaoAMsOoT5ijPqVeQ>
    <xmx:URW9ZUeFX57nBFQ2Ivhy-KuJQ6O53UggwEe2Rak0HJaqJuhu18ynHQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 11:16:16 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/3] mm/compaction: add support for >0 order folio memory compaction.
Date: Fri,  2 Feb 2024 11:15:53 -0500
Message-ID: <20240202161554.565023-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202161554.565023-1-zi.yan@sent.com>
References: <20240202161554.565023-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Before last commit, memory compaction only migrates order-0 folios and
skips >0 order folios. Last commit splits all >0 order folios during
compaction. This commit migrates >0 order folios during compaction by
keeping isolated free pages at their original size without splitting them
into order-0 pages and using them directly during migration process.

What is different from the prior implementation:
1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
   lists, where each page list stores free pages in the same order.
2. All free pages are not post_alloc_hook() processed nor buddy pages,
   although their orders are stored in first page's private like buddy
   pages.
3. During migration, in new page allocation time (i.e., in
   compaction_alloc()), free pages are then processed by post_alloc_hook().
   When migration fails and a new page is returned (i.e., in
   compaction_free()), free pages are restored by reversing the
   post_alloc_hook() operations using newly added
   free_pages_prepare_fpi_none().

Step 3 is done for a latter optimization that splitting and/or merging free
pages during compaction becomes easier.

Note: without splitting free pages, compaction can end prematurely due to
migration will return -ENOMEM even if there is free pages. This happens
when no order-0 free page exist and compaction_alloc() return NULL.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 149 +++++++++++++++++++++++++++++-------------------
 mm/internal.h   |   9 ++-
 mm/page_alloc.c |   6 ++
 3 files changed, 104 insertions(+), 60 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e43e898d2c77..58a4e3fb72ec 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -66,45 +66,67 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
-static unsigned long release_freepages(struct list_head *freelist)
+static void init_page_list(struct page_list *p)
 {
-	struct page *page, *next;
-	unsigned long high_pfn = 0;
-
-	list_for_each_entry_safe(page, next, freelist, lru) {
-		unsigned long pfn = page_to_pfn(page);
-		list_del(&page->lru);
-		__free_page(page);
-		if (pfn > high_pfn)
-			high_pfn = pfn;
-	}
-
-	return high_pfn;
+	INIT_LIST_HEAD(&p->pages);
+	p->nr_pages = 0;
 }
 
-static void split_map_pages(struct list_head *list)
+static void split_map_pages(struct page_list *freepages)
 {
-	unsigned int i, order, nr_pages;
+	unsigned int i, order, total_nr_pages;
 	struct page *page, *next;
 	LIST_HEAD(tmp_list);
 
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
+		total_nr_pages = freepages[order].nr_pages * (1 << order);
+		freepages[order].nr_pages = 0;
+
+		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
+			unsigned int nr_pages;
+
+			list_del(&page->lru);
 
-		order = page_private(page);
-		nr_pages = 1 << order;
+			nr_pages = 1 << order;
 
-		post_alloc_hook(page, order, __GFP_MOVABLE);
-		if (order)
-			split_page(page, order);
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			if (order)
+				split_page(page, order);
 
-		for (i = 0; i < nr_pages; i++) {
-			list_add(&page->lru, &tmp_list);
-			page++;
+			for (i = 0; i < nr_pages; i++) {
+				list_add(&page->lru, &tmp_list);
+				page++;
+			}
 		}
+		freepages[0].nr_pages += total_nr_pages;
+		list_splice_init(&tmp_list, &freepages[0].pages);
 	}
+}
 
-	list_splice(&tmp_list, list);
+static unsigned long release_free_list(struct page_list *freepages)
+{
+	int order;
+	unsigned long high_pfn = 0;
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
+		struct page *page, *next;
+
+		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
+			unsigned long pfn = page_to_pfn(page);
+
+			list_del(&page->lru);
+			/*
+			 * Convert free pages into post allocation pages, so
+			 * that we can free them via __free_page.
+			 */
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			__free_pages(page, order);
+			if (pfn > high_pfn)
+				high_pfn = pfn;
+		}
+		freepages[order].nr_pages = 0;
+	}
+	return high_pfn;
 }
 
 #ifdef CONFIG_COMPACTION
@@ -583,7 +605,7 @@ static bool compact_unlock_should_abort(spinlock_t *lock,
 static unsigned long isolate_freepages_block(struct compact_control *cc,
 				unsigned long *start_pfn,
 				unsigned long end_pfn,
-				struct list_head *freelist,
+				struct page_list *freelist,
 				unsigned int stride,
 				bool strict)
 {
@@ -657,7 +679,8 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		nr_scanned += isolated - 1;
 		total_isolated += isolated;
 		cc->nr_freepages += isolated;
-		list_add_tail(&page->lru, freelist);
+		list_add_tail(&page->lru, &freelist[order].pages);
+		freelist[order].nr_pages++;
 
 		if (!strict && cc->nr_migratepages <= cc->nr_freepages) {
 			blockpfn += isolated;
@@ -722,7 +745,11 @@ isolate_freepages_range(struct compact_control *cc,
 			unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
-	LIST_HEAD(freelist);
+	int order;
+	struct page_list tmp_freepages[NR_PAGE_ORDERS];
+
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
+		init_page_list(&tmp_freepages[order]);
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -753,7 +780,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, &freelist, 0, true);
+					block_end_pfn, tmp_freepages, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -770,15 +797,15 @@ isolate_freepages_range(struct compact_control *cc,
 		 */
 	}
 
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(&freelist);
-
 	if (pfn < end_pfn) {
 		/* Loop terminated early, cleanup. */
-		release_freepages(&freelist);
+		release_free_list(tmp_freepages);
 		return 0;
 	}
 
+	/* __isolate_free_page() does not map the pages */
+	split_map_pages(tmp_freepages);
+
 	/* We don't use freelists for anything. */
 	return pfn;
 }
@@ -1481,7 +1508,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	if (!page)
 		return;
 
-	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
+	isolate_freepages_block(cc, &start_pfn, end_pfn, cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
 	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
@@ -1610,7 +1637,8 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				nr_scanned += nr_isolated - 1;
 				total_isolated += nr_isolated;
 				cc->nr_freepages += nr_isolated;
-				list_add_tail(&page->lru, &cc->freepages);
+				list_add_tail(&page->lru, &cc->freepages[order].pages);
+				cc->freepages[order].nr_pages++;
 				count_compact_events(COMPACTISOLATED, nr_isolated);
 			} else {
 				/* If isolation fails, abort the search */
@@ -1687,13 +1715,12 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
 	unsigned long block_end_pfn;	/* end of current pageblock */
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
-	struct list_head *freelist = &cc->freepages;
 	unsigned int stride;
 
 	/* Try a small search of the free lists for a candidate */
 	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
-		goto splitmap;
+		return;
 
 	/*
 	 * Initialise the free scanner. The starting point is where we last
@@ -1753,7 +1780,7 @@ static void isolate_freepages(struct compact_control *cc)
 
 		/* Found a block suitable for isolating free pages from. */
 		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, freelist, stride, false);
+					block_end_pfn, cc->freepages, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn == block_end_pfn)
@@ -1794,10 +1821,6 @@ static void isolate_freepages(struct compact_control *cc)
 	 * and the loop terminated due to isolate_start_pfn < low_pfn
 	 */
 	cc->free_pfn = isolate_start_pfn;
-
-splitmap:
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(freelist);
 }
 
 /*
@@ -1808,23 +1831,22 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
+	int order = folio_order(src);
 
-	/* this makes migrate_pages() split the source page and retry */
-	if (folio_test_large(src) > 0)
-		return NULL;
-
-	if (list_empty(&cc->freepages)) {
+	if (!cc->freepages[order].nr_pages) {
 		isolate_freepages(cc);
-
-		if (list_empty(&cc->freepages))
+		if (!cc->freepages[order].nr_pages)
 			return NULL;
 	}
 
-	dst = list_entry(cc->freepages.next, struct folio, lru);
+	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
+	cc->freepages[order].nr_pages--;
 	list_del(&dst->lru);
-	cc->nr_freepages--;
-
-	return dst;
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	if (order)
+		prep_compound_page(&dst->page, order);
+	cc->nr_freepages -= 1 << order;
+	return page_rmappable_folio(&dst->page);
 }
 
 /*
@@ -1835,9 +1857,17 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 static void compaction_free(struct folio *dst, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
+	int order = folio_order(dst);
+	struct page *page = &dst->page;
+
+	folio_set_count(dst, 0);
+	free_pages_prepare_fpi_none(page, order);
 
-	list_add(&dst->lru, &cc->freepages);
-	cc->nr_freepages++;
+	INIT_LIST_HEAD(&dst->lru);
+
+	list_add(&dst->lru, &cc->freepages[order].pages);
+	cc->freepages[order].nr_pages++;
+	cc->nr_freepages += 1 << order;
 }
 
 /* possible outcome of isolate_migratepages */
@@ -2461,6 +2491,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
 	unsigned int nr_succeeded = 0;
+	int order;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2470,7 +2501,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	cc->total_free_scanned = 0;
 	cc->nr_migratepages = 0;
 	cc->nr_freepages = 0;
-	INIT_LIST_HEAD(&cc->freepages);
+	for (order = 0; order < NR_PAGE_ORDERS; order++)
+		init_page_list(&cc->freepages[order]);
 	INIT_LIST_HEAD(&cc->migratepages);
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
@@ -2656,7 +2688,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	 * so we don't leave any returned pages behind in the next attempt.
 	 */
 	if (cc->nr_freepages > 0) {
-		unsigned long free_pfn = release_freepages(&cc->freepages);
+		unsigned long free_pfn = release_free_list(cc->freepages);
 
 		cc->nr_freepages = 0;
 		VM_BUG_ON(free_pfn == 0);
@@ -2675,7 +2707,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
-	VM_BUG_ON(!list_empty(&cc->freepages));
 	VM_BUG_ON(!list_empty(&cc->migratepages));
 
 	return ret;
diff --git a/mm/internal.h b/mm/internal.h
index 1e29c5821a1d..c6ea449c5353 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -447,6 +447,8 @@ extern void prep_compound_page(struct page *page, unsigned int order);
 
 extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
+extern bool free_pages_prepare_fpi_none(struct page *page, unsigned int order);
+
 extern int user_min_free_kbytes;
 
 extern void free_unref_page(struct page *page, unsigned int order);
@@ -473,6 +475,11 @@ int split_free_page(struct page *free_page,
 /*
  * in mm/compaction.c
  */
+
+struct page_list {
+	struct list_head	pages;
+	unsigned long		nr_pages;
+};
 /*
  * compact_control is used to track pages being migrated and the free pages
  * they are being migrated to during memory compaction. The free_pfn starts
@@ -481,7 +488,7 @@ int split_free_page(struct page *free_page,
  * completes when free_pfn <= migrate_pfn
  */
 struct compact_control {
-	struct list_head freepages;	/* List of free pages to migrate to */
+	struct page_list freepages[NR_PAGE_ORDERS];	/* List of free pages to migrate to */
 	struct list_head migratepages;	/* List of pages being migrated */
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5be4cd8f6b5a..c7c135e6d5ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1179,6 +1179,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	return true;
 }
 
+__always_inline bool free_pages_prepare_fpi_none(struct page *page,
+			unsigned int order)
+{
+	return free_pages_prepare(page, order, FPI_NONE);
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
-- 
2.43.0


