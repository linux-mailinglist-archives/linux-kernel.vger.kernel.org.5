Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6378C80366E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjLDOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjLDOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8401BE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQM7ysAYyclyPUNvOCqkfLGmI+LHJSTCFqaARoijbyI=;
        b=e6h5zBuAAW7H7PK+BGyWpP0Qqlp1si+h8QuLO9BIzvs9bGkKlOjPIAXY2AleOxmEX22dsf
        5dP79PdZzNNGxaFvfbyG7A3IueuPnwNd2ezMArmgcaJb9jfsVxq3PAFwIncTmABRmgVExf
        RozZn0pXlbWP49Pmr4vt3Kxuhav+Th0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-6HiWY7_OOd6JGbhIhUP00g-1; Mon,
 04 Dec 2023 09:22:28 -0500
X-MC-Unique: 6HiWY7_OOd6JGbhIhUP00g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 207872825E9C;
        Mon,  4 Dec 2023 14:22:28 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EADB2026D4C;
        Mon,  4 Dec 2023 14:22:26 +0000 (UTC)
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
Subject: [PATCH RFC 21/39] mm/rmap: remove page_add_anon_rmap()
Date:   Mon,  4 Dec 2023 15:21:28 +0100
Message-ID: <20231204142146.91437-22-david@redhat.com>
In-Reply-To: <20231204142146.91437-1-david@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

All users are gone, remove it and all traces.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h |  2 --
 mm/rmap.c            | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9e1c197f50199..865d83148852d 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -235,8 +235,6 @@ void folio_add_anon_rmap_ptes(struct folio *, struct page *, unsigned int nr,
 	folio_add_anon_rmap_ptes(folio, page, 1, vma, address, flags)
 void folio_add_anon_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *, unsigned long address, rmap_t flags);
-void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long address, rmap_t flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
 		unsigned long address);
 void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
diff --git a/mm/rmap.c b/mm/rmap.c
index 85bea11e9266b..4cb9d8b7d1d65 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1238,7 +1238,7 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 	 * The page's anon-rmap details (mapping and index) are guaranteed to
 	 * be set up correctly at this point.
 	 *
-	 * We have exclusion against page_add_anon_rmap because the caller
+	 * We have exclusion against folio_add_anon_rmap_*() because the caller
 	 * always holds the page locked.
 	 *
 	 * We have exclusion against page_add_new_anon_rmap because those pages
@@ -1251,29 +1251,6 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 		       page);
 }
 
-/**
- * page_add_anon_rmap - add pte mapping to an anonymous page
- * @page:	the page to add the mapping to
- * @vma:	the vm area in which the mapping is added
- * @address:	the user virtual address mapped
- * @flags:	the rmap flags
- *
- * The caller needs to hold the pte lock, and the page must be locked in
- * the anon_vma case: to serialize mapping,index checking after setting,
- * and to ensure that PageAnon is not being upgraded racily to PageKsm
- * (but PageKsm is never downgraded to PageAnon).
- */
-void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
-		unsigned long address, rmap_t flags)
-{
-	struct folio *folio = page_folio(page);
-
-	if (likely(!(flags & RMAP_COMPOUND)))
-		folio_add_anon_rmap_pte(folio, page, vma, address, flags);
-	else
-		folio_add_anon_rmap_pmd(folio, page, vma, address, flags);
-}
-
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		struct page *page, unsigned int nr_pages,
 		struct vm_area_struct *vma, unsigned long address, rmap_t flags,
@@ -1384,7 +1361,7 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  *
- * Like page_add_anon_rmap() but must only be called on *new* folios.
+ * Like folio_add_anon_rmap_*() but must only be called on *new* folios.
  * This means the inc-and-test can be bypassed.
  * The folio does not have to be locked.
  *
@@ -1432,7 +1409,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
-	/* See comments in page_add_anon_rmap() */
+	/* See comments in folio_add_anon_rmap_*() */
 	if (!folio_test_large(folio))
 		mlock_vma_folio(folio, vma);
 }
@@ -1546,7 +1523,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully
-	 * unmapped, but that might overwrite a racing page_add_anon_rmap
+	 * unmapped, but that might overwrite a racing folio_add_anon_rmap_*()
 	 * which increments mapcount after us but sets mapping before us:
 	 * so leave the reset to free_pages_prepare, and remember that
 	 * it's only reliable while mapped.
-- 
2.41.0

