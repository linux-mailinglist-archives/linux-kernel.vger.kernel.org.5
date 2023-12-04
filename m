Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2D80367E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbjLDOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbjLDOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281B02114
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxWJm4ToHrNF66jwBix2CbkD6YpwBU1ELf60FTyZZ+4=;
        b=ftV0rr66scZ4ka3hzLm2lC+THPiAvYpmGaDqhawWFaiR9kBE7Ctp9AQrwGsGqEdZs/7sd2
        o61qZi/8g3gE3wt3Tz7pL6DJV+rSJD23h00168NiHVd5dWEaDPz8kYG8p2zmjjLn0DxVyF
        6A1BZI3iGKHaM3tu11okOUYMgH2vEfw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-T-_XZXA9MVC5F6_MoTvAnQ-1; Mon,
 04 Dec 2023 09:22:50 -0500
X-MC-Unique: T-_XZXA9MVC5F6_MoTvAnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7448B3C100C8;
        Mon,  4 Dec 2023 14:22:49 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6C602026D4C;
        Mon,  4 Dec 2023 14:22:47 +0000 (UTC)
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
Subject: [PATCH RFC 32/39] mm/rmap: remove page_remove_rmap()
Date:   Mon,  4 Dec 2023 15:21:39 +0100
Message-ID: <20231204142146.91437-33-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
 mm/internal.h        |  2 +-
 mm/memory-failure.c  |  4 ++--
 mm/rmap.c            | 23 ++---------------------
 4 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index dd4ffb1d8ae04..bdbfb11638e4f 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -239,8 +239,6 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, unsigned int nr,
 	folio_add_file_rmap_ptes(folio, page, 1, vma)
 void folio_add_file_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
-void page_remove_rmap(struct page *, struct vm_area_struct *,
-		bool compound);
 void folio_remove_rmap_ptes(struct folio *, struct page *, unsigned int nr,
 		struct vm_area_struct *);
 #define folio_remove_rmap_pte(folio, page, vma) \
@@ -384,7 +382,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  *
  * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
  * to duplicate a mapping, but instead to prepare for KSM or temporarily
- * unmapping a page (swap, migration) via page_remove_rmap().
+ * unmapping a page (swap, migration) via folio_remove_rmap_*().
  *
  * Marking the page shared can only fail if the page may be pinned; device
  * private pages cannot get pinned and consequently this function cannot fail.
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5f..43dca750c5afc 100644
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
index 660c21859118e..d0251cba84795 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2317,8 +2317,8 @@ int memory_failure(unsigned long pfn, int flags)
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
index 4a0114d04ab48..8e86024953c03 100644
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
  */
@@ -1451,25 +1451,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
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
 		struct page *page, unsigned int nr_pages,
 		struct vm_area_struct *vma, enum rmap_mode mode)
-- 
2.41.0

