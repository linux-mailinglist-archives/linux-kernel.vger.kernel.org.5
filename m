Return-Path: <linux-kernel+bounces-7599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68281AAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BE28214D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20A57895;
	Wed, 20 Dec 2023 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwkyu+BP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAC55C36
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vX4HFQixyHeUqudW1I+7GoOAzQbfOI98S0mk8R6Q4EQ=;
	b=Iwkyu+BPE5jnsbkbdG+s+crY+49jyinQTbt46QkHZZz6Fg0Q9ud4lMzJ4BrKCqpNzwpXv0
	6qwjdcSaeCf6kIEB7ScjPpJ4leftLN4PEi1mIuT2HD8LRvvGGiknwWgfCpJjGOVPotr03t
	baOo+hggxJVwH2ao7eVw2OJJ3SB+FL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-1zduYvExPhKGzCC_CaEsSA-1; Wed, 20 Dec 2023 17:46:31 -0500
X-MC-Unique: 1zduYvExPhKGzCC_CaEsSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDE6C185A783;
	Wed, 20 Dec 2023 22:46:30 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1364A40C6EB9;
	Wed, 20 Dec 2023 22:46:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 32/40] mm/rmap: remove page_remove_rmap()
Date: Wed, 20 Dec 2023 23:44:56 +0100
Message-ID: <20231220224504.646757-33-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

All callers are gone, let's remove it and some leftover traces.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  4 +---
 mm/filemap.c         | 10 +++++-----
 mm/internal.h        |  2 +-
 mm/memory-failure.c  |  4 ++--
 mm/rmap.c            | 23 ++---------------------
 5 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 57e045093f047..fef369e37039a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -241,8 +241,6 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
-void page_remove_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
@@ -389,7 +387,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  *
  * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
  * to duplicate a mapping, but instead to prepare for KSM or temporarily
- * unmapping a page (swap, migration) via page_remove_rmap().
+ * unmapping a page (swap, migration) via folio_remove_rmap_*().
  *
  * Marking the page shared can only fail if the page may be pinned; device
  * private pages cannot get pinned and consequently this function cannot fail.
diff --git a/mm/filemap.c b/mm/filemap.c
index 67ba56ecdd32a..c8dafe70d4cce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -113,11 +113,11 @@
  *    ->i_pages lock		(try_to_unmap_one)
  *    ->lruvec->lru_lock	(follow_page->mark_page_accessed)
  *    ->lruvec->lru_lock	(check_pte_range->isolate_lru_page)
- *    ->private_lock		(page_remove_rmap->set_page_dirty)
- *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
- *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
- *    ->inode->i_lock		(page_remove_rmap->set_page_dirty)
- *    ->memcg->move_lock	(page_remove_rmap->folio_memcg_lock)
+ *    ->private_lock		(folio_remove_rmap_pte->set_page_dirty)
+ *    ->i_pages lock		(folio_remove_rmap_pte->set_page_dirty)
+ *    bdi.wb->list_lock		(folio_remove_rmap_pte->set_page_dirty)
+ *    ->inode->i_lock		(folio_remove_rmap_pte->set_page_dirty)
+ *    ->memcg->move_lock	(folio_remove_rmap_pte->folio_memcg_lock)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
diff --git a/mm/internal.h b/mm/internal.h
index 222e63b2dea48..a94355e70bd78 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -651,7 +651,7 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
  * under page table lock for the pte/pmd being added or removed.
  *
  * mlock is usually called at the end of page_add_*_rmap(), munlock at
- * the end of page_remove_rmap(); but new anon folios are managed by
+ * the end of folio_remove_rmap_*(); but new anon folios are managed by
  * folio_add_lru_vma() calling mlock_new_folio().
  */
 void mlock_folio(struct folio *folio);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5a23da5eb8c1e..a0d9b4ac7d545 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2315,8 +2315,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * We use page flags to determine what action should be taken, but
 	 * the flags can be modified by the error containment action.  One
 	 * example is an mlocked page, where PG_mlocked is cleared by
-	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
-	 * correctly, we save a copy of the page flags at this time.
+	 * folio_remove_rmap_*() in try_to_unmap_one(). So to determine page
+	 * status correctly, we save a copy of the page flags at this time.
 	 */
 	page_flags = p->flags;
 
diff --git a/mm/rmap.c b/mm/rmap.c
index a3ec2be484cfc..3ee254a996221 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -470,7 +470,7 @@ void __init anon_vma_init(void)
 /*
  * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
  *
- * Since there is no serialization what so ever against page_remove_rmap()
+ * Since there is no serialization what so ever against folio_remove_rmap_*()
  * the best this function can do is return a refcount increased anon_vma
  * that might have been relevant to this page.
  *
@@ -487,7 +487,7 @@ void __init anon_vma_init(void)
  * [ something equivalent to page_mapped_in_vma() ].
  *
  * Since anon_vma's slab is SLAB_TYPESAFE_BY_RCU and we know from
- * page_remove_rmap() that the anon_vma pointer from page->mapping is valid
+ * folio_remove_rmap_*() that the anon_vma pointer from page->mapping is valid
  * if there is a mapcount, we can dereference the anon_vma after observing
  * those.
  *
@@ -1498,25 +1498,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
-/**
- * page_remove_rmap - take down pte mapping from a page
- * @page:	page to remove mapping from
- * @vma:	the vm area from which the mapping is removed
- * @compound:	uncharge the page as compound or small page
- *
- * The caller needs to hold the pte lock.
- */
-void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
-		bool compound)
-{
-	struct folio *folio = page_folio(page);
-
-	if (likely(!compound))
-		folio_remove_rmap_pte(folio, page, vma);
-	else
-		folio_remove_rmap_pmd(folio, page, vma);
-}
-
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
-- 
2.43.0


