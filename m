Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42E380D04B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjLKP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbjLKP6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED26118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yS0UIUzy1DjqGivo1HlVZbIDQrX5/8+loO66ukrqS7A=;
        b=fc43Z2yApnuURWYJD0nbLA/R4X3gN/hjCs6xzR1r+oDX2Fkv+bP8S5d4X7c/Gy1Ai8upxj
        P1uRK+F6oVcy7I6ts6rhD3PWOqCcL8HiZiXCysVbuszJZhwGmn1QYuKKLRY3dBc16OJER0
        Lw6K7tIgM1mk/dLvVZoEz+POeEFoFE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-rMmu2rhaOL6tNMECz-xHBQ-1; Mon, 11 Dec 2023 10:58:18 -0500
X-MC-Unique: rMmu2rhaOL6tNMECz-xHBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241BA848A83;
        Mon, 11 Dec 2023 15:58:18 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA331121306;
        Mon, 11 Dec 2023 15:58:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 32/39] mm/rmap: remove page_remove_rmap()
Date:   Mon, 11 Dec 2023 16:56:45 +0100
Message-ID: <20231211155652.131054-33-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a266dc0ef99e..0f4eecd03bdc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -244,8 +244,6 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
-void page_remove_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
@@ -392,7 +390,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  *
  * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
  * to duplicate a mapping, but instead to prepare for KSM or temporarily
- * unmapping a page (swap, migration) via page_remove_rmap().
+ * unmapping a page (swap, migration) via folio_remove_rmap_*().
  *
  * Marking the page shared can only fail if the page may be pinned; device
  * private pages cannot get pinned and consequently this function cannot fail.
diff --git a/mm/filemap.c b/mm/filemap.c
index c0d7e1d7eea2..beff3865465a 100644
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
index 222e63b2dea4..a94355e70bd7 100644
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
index d8c853b35dbb..01af9295c47c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2316,8 +2316,8 @@ int memory_failure(unsigned long pfn, int flags)
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
index 233432f08e36..b08dd7d6779d 100644
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
@@ -1499,25 +1499,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
 		enum rmap_mode mode)
-- 
2.43.0

