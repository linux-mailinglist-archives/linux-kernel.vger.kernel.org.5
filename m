Return-Path: <linux-kernel+bounces-76859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B536385FDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB68287056
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010A153513;
	Thu, 22 Feb 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRAxo2uc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6F153514
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618191; cv=none; b=eOEzPCurOF/dlko++LwYeVyPV8R/Us7TQ6k0HiDMw0rel4I+T+AzbLq/CyQ9R2FFXGiJUn9cc9wotnMfWYQ8SwUv73BRUEuYx8jt0CFG/cIKJnfasMg+m0cct08Q9Wnh/Yth/YpKHENUSY9vfxK2eb95SAfzaTBCrcZfyiW1XcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618191; c=relaxed/simple;
	bh=UkOdVM5iQvkkHtQecrvn4Z1rTT8INH507Llo2gl78QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1nGTtghT0Oyt29wwTdAq3q9a28Rr7+c1RrmfZzpfATozw97mGn/sxUZbmKfLNkJuGI+U3vlC4YomlnLeL3TxSFML8BjJKD+Rd2Q9HttA8fG0CBI63+etIiszzb1qOTjuhfwe8ie1npqF/B7zinTvCaDtebfiC4Ez1a7mHsGO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRAxo2uc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708618188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WUdidtCwvNxI4MXqkhDzpFFrMP8MQ9qo1Vo++/exepg=;
	b=dRAxo2uc2kUDp6uBsefCcdJMLrW8W7KrNaNPINsAaBLYKQAuEhX0mC/209eY/jJSTFGzi8
	pUj4TBrhER6N3YpSanfrBtjQUFLxsQn207WVAMt30qwHGtM0bi4/Mg0j9aonoSQRVq1vQb
	/B6wzzCG2/YW/sKG35sm+I/9MF8HkBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-vCeQ0Lt5OvuE7nUtaq2fKg-1; Thu, 22 Feb 2024 11:09:46 -0500
X-MC-Unique: vCeQ0Lt5OvuE7nUtaq2fKg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24F4B10726A2;
	Thu, 22 Feb 2024 16:09:46 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 895472864;
	Thu, 22 Feb 2024 16:09:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v1] mm: remove total_mapcount()
Date: Thu, 22 Feb 2024 17:09:43 +0100
Message-ID: <20240222160943.622386-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

mm/memfd.c is that last remaining user of total_mapcount().  Let's
convert memfd_tag_pins() and memfd_wait_for_pins() to use folios
instead of pages, so we can remove total_mapcount() for good.

We always get a head page, so we can just naturally interpret is as a folio
(similar to other code).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Did a quick test with write-sealing a memfd backed by THP. Seems to work
as it used to.

---
 include/linux/mm.h |  9 +--------
 mm/memfd.c         | 34 ++++++++++++++++++----------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f4825d82965..49e22a2f6ccc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1183,7 +1183,7 @@ static inline int is_vmalloc_or_module_addr(const void *x)
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
  * debugging purposes - it does not include PTE-mapped sub-pages; look
- * at folio_mapcount() or page_mapcount() or total_mapcount() instead.
+ * at folio_mapcount() or page_mapcount() instead.
  */
 static inline int folio_entire_mapcount(struct folio *folio)
 {
@@ -1243,13 +1243,6 @@ static inline int folio_mapcount(struct folio *folio)
 	return folio_total_mapcount(folio);
 }
 
-static inline int total_mapcount(struct page *page)
-{
-	if (likely(!PageCompound(page)))
-		return atomic_read(&page->_mapcount) + 1;
-	return folio_total_mapcount(page_folio(page));
-}
-
 static inline bool folio_large_is_mapped(struct folio *folio)
 {
 	/*
diff --git a/mm/memfd.c b/mm/memfd.c
index d3a1ba4208c9..0a6c1a6ee03b 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -31,24 +31,25 @@
 
 static void memfd_tag_pins(struct xa_state *xas)
 {
-	struct page *page;
+	struct folio *folio;
 	int latency = 0;
 	int cache_count;
 
 	lru_add_drain();
 
 	xas_lock_irq(xas);
-	xas_for_each(xas, page, ULONG_MAX) {
+	xas_for_each(xas, folio, ULONG_MAX) {
 		cache_count = 1;
-		if (!xa_is_value(page) &&
-		    PageTransHuge(page) && !PageHuge(page))
+		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+		    !xa_is_value(folio) && folio_test_large(folio) &&
+		    !folio_test_hugetlb(folio))
 			cache_count = HPAGE_PMD_NR;
 
-		if (!xa_is_value(page) &&
-		    page_count(page) - total_mapcount(page) != cache_count)
+		if (!xa_is_value(folio) && cache_count !=
+		    folio_ref_count(folio) - folio_mapcount(folio))
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
 		if (cache_count != 1)
-			xas_set(xas, page->index + cache_count);
+			xas_set(xas, folio->index + cache_count);
 
 		latency += cache_count;
 		if (latency < XA_CHECK_SCHED)
@@ -66,16 +67,16 @@ static void memfd_tag_pins(struct xa_state *xas)
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
@@ -95,20 +96,21 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 
 		xas_set(&xas, 0);
 		xas_lock_irq(&xas);
-		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
+		xas_for_each_marked(&xas, folio, ULONG_MAX, MEMFD_TAG_PINNED) {
 			bool clear = true;
 
 			cache_count = 1;
-			if (!xa_is_value(page) &&
-			    PageTransHuge(page) && !PageHuge(page))
+			if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+			    !xa_is_value(folio) && folio_test_large(folio) &&
+			    !folio_test_hugetlb(folio))
 				cache_count = HPAGE_PMD_NR;
 
-			if (!xa_is_value(page) && cache_count !=
-			    page_count(page) - total_mapcount(page)) {
+			if (!xa_is_value(folio) && cache_count !=
+			    folio_ref_count(folio) - folio_mapcount(folio)) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
-				 * found pages pinned.
+				 * found folios pinned.
 				 */
 				if (scan == LAST_SCAN)
 					error = -EBUSY;
-- 
2.43.2


