Return-Path: <linux-kernel+bounces-81596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610E8677F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8543B251A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F54129A6D;
	Mon, 26 Feb 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO+OY0YE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC631C6B9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956852; cv=none; b=mEG09yHx1xglaHOWEjmImmPc4ROU45K7Y2nmFpApqT+GWhfspBjfj6LVh0qi6ns9eXJF+dF+XC/gzXExCnwsS5I+D/9i3vpAjwdLE5gZL23Hu9Ni0pS6hAC6qhmms0CAeXfIC3oClA067QWhSe3tBXFbzKaofIx+h+4U1uGHASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956852; c=relaxed/simple;
	bh=LlRCRH3uYk/2lkWlcthuzE6Y+YWYxlmcDmZGNRkMNp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbOZUi1MRczeZQB1GtfDpB4snitpZkj7+CgbW3ePrfG++XiSmhxyv5aLHrZpDIs8RcT8y6B9gauDvB1vNLWID5Xo0SzPLQLZyKWO+gs4LnqtyZGaAp0Zb28/hn2nwaTiueGnXVUfevXN4QKonZYHTknNF1jsj9INfSnBQfKV7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FO+OY0YE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708956847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2GkNOw5QpbIjcnEa8hertH5KYBOVS1V90XYQHHukH+0=;
	b=FO+OY0YE7/v3F5zmkawZ6ewR4/zGn5c9ZeHumWIwOT+Dgm4i6giVU/j1h0Wf7harz09U1D
	wMlS5ejG8mIc/UhQTgwtNaG/xyloXvzywIWs01cvwccynn1i0w5tqQU0gVzHEvkGZTQjA/
	NUGTvFgfgGBa5n3V36dIEE5vNKVv/Ec=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-xi-W6UmKPPiav4O4IAf97Q-1; Mon,
 26 Feb 2024 09:13:38 -0500
X-MC-Unique: xi-W6UmKPPiav4O4IAf97Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E6403C025C0;
	Mon, 26 Feb 2024 14:13:29 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 072AD1C060B1;
	Mon, 26 Feb 2024 14:13:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/2] mm/memfd: refactor memfd_tag_pins() and memfd_wait_for_pins()
Date: Mon, 26 Feb 2024 15:13:23 +0100
Message-ID: <20240226141324.278526-2-david@redhat.com>
In-Reply-To: <20240226141324.278526-1-david@redhat.com>
References: <20240226141324.278526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Both functions are the remaining users of total_mapcount(). Let's get
rid of the calls by converting the code to folios.

As it turns out, the code is unnecessarily complicated, especially:

1) We can query the number of pagecache references for a folio simply via
   folio_nr_pages(). This will handle other folio sizes in the future
   correctly.

2) The xas_set(xas, page->index + cache_count) call to increment the
   iterator for large folios is not required. Remove it.

Further, simplify the XA_CHECK_SCHED check, counting each entry exactly
once.

Memfd pages can be swapped out when using shmem; leave xa_is_value()
checks in place.

Co-developed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memfd.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index d3a1ba4208c90..7d8d3ab3fa378 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -29,29 +29,25 @@
 #define MEMFD_TAG_PINNED        PAGECACHE_TAG_TOWRITE
 #define LAST_SCAN               4       /* about 150ms max */
 
+static bool memfd_folio_has_extra_refs(struct folio *folio)
+{
+	return folio_ref_count(folio) - folio_mapcount(folio) !=
+	       folio_nr_pages(folio);
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
+		if (!xa_is_value(folio) && memfd_folio_has_extra_refs(folio))
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
-		if (cache_count != 1)
-			xas_set(xas, page->index + cache_count);
 
-		latency += cache_count;
-		if (latency < XA_CHECK_SCHED)
+		if (++latency < XA_CHECK_SCHED)
 			continue;
 		latency = 0;
 
@@ -66,16 +62,16 @@ static void memfd_tag_pins(struct xa_state *xas)
 /*
  * Setting SEAL_WRITE requires us to verify there's no pending writer. However,
  * via get_user_pages(), drivers might have some pending I/O without any active
- * user-space mappings (eg., direct-IO, AIO). Therefore, we look at all pages
+ * user-space mappings (eg., direct-IO, AIO). Therefore, we look at all folios
  * and see whether it has an elevated ref-count. If so, we tag them and wait for
  * them to be dropped.
  * The caller must guarantee that no new user will acquire writable references
- * to those pages to avoid races.
+ * to those folios to avoid races.
  */
 static int memfd_wait_for_pins(struct address_space *mapping)
 {
 	XA_STATE(xas, &mapping->i_pages, 0);
-	struct page *page;
+	struct folio *folio;
 	int error, scan;
 
 	memfd_tag_pins(&xas);
@@ -83,7 +79,6 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
 		int latency = 0;
-		int cache_count;
 
 		if (!xas_marked(&xas, MEMFD_TAG_PINNED))
 			break;
@@ -95,20 +90,15 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
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
+			if (!xa_is_value(folio) &&
+			    memfd_folio_has_extra_refs(folio)) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
-				 * found pages pinned.
+				 * found folios pinned.
 				 */
 				if (scan == LAST_SCAN)
 					error = -EBUSY;
@@ -118,8 +108,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			if (clear)
 				xas_clear_mark(&xas, MEMFD_TAG_PINNED);
 
-			latency += cache_count;
-			if (latency < XA_CHECK_SCHED)
+			if (++latency < XA_CHECK_SCHED)
 				continue;
 			latency = 0;
 
-- 
2.43.2


