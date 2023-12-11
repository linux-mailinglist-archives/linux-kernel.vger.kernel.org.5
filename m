Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7480D056
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjLKQAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344754AbjLKP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C980173B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kCOKQnn/YILhh4/y6F4VVgOwWNItKHStdMCkjwZ7+g=;
        b=gNXV28fxHJ0DMq3uCRbTfg/h02R+XOG4iZwBZH3CJEWWBHnA/KF3EUbdbHzheJuLmxXBrW
        dgIJEfH4Iw6oseOWOY6OvhCK8whw/OX2OJACyhVa7R6TfHUTnBJcINDT0sWqR8/ZMOnhh6
        lpN/WM2ro3TK8Lbu65Bcfd+wwsln+lc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-PqgcZlcINPWhAdvqUvsCRQ-1; Mon, 11 Dec 2023 10:58:35 -0500
X-MC-Unique: PqgcZlcINPWhAdvqUvsCRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F70848A68;
        Mon, 11 Dec 2023 15:58:34 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F28F81121306;
        Mon, 11 Dec 2023 15:58:32 +0000 (UTC)
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
Subject: [PATCH v1 39/39] mm/rmap: rename COMPOUND_MAPPED to ENTIRELY_MAPPED
Date:   Mon, 11 Dec 2023 16:56:52 +0100
Message-ID: <20231211155652.131054-40-david@redhat.com>
In-Reply-To: <20231211155652.131054-1-david@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

We removed all "bool compound" and RMAP_COMPOUND parameters. Let's
remove the remaining "compound" terminology by making COMPOUND_MAPPED
match the "folio->_entire_mapcount" terminology, renaming it to
ENTIRELY_MAPPED.

ENTIRELY_MAPPED is only used when the whole folio is mapped using a single
page table entry (e.g., a single PMD mapping a PMD-sized THP). For now,
we don't support mapping any THP bigger than that, so ENTIRELY_MAPPED
only applies to PMD-mapped PMD-sized THP only.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst |  2 +-
 mm/internal.h                  |  6 +++---
 mm/rmap.c                      | 18 +++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index cf81272a6b8b..93c9239b9ebe 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -117,7 +117,7 @@ pages:
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
     folio->_entire_mapcount and also increment/decrement
-    folio->_nr_pages_mapped by COMPOUND_MAPPED when _entire_mapcount
+    folio->_nr_pages_mapped by ENTIRELY_MAPPED when _entire_mapcount
     goes from -1 to 0 or 0 to -1.
 
   - map/unmap of individual pages with PTE entry increment/decrement
diff --git a/mm/internal.h b/mm/internal.h
index 29589bc3f046..188807d2aebc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -54,12 +54,12 @@ void page_writeback_init(void);
 
 /*
  * If a 16GB hugetlb folio were mapped by PTEs of all of its 4kB pages,
- * its nr_pages_mapped would be 0x400000: choose the COMPOUND_MAPPED bit
+ * its nr_pages_mapped would be 0x400000: choose the ENTIRELY_MAPPED bit
  * above that range, instead of 2*(PMD_SIZE/PAGE_SIZE).  Hugetlb currently
  * leaves nr_pages_mapped at 0, but avoid surprise if it participates later.
  */
-#define COMPOUND_MAPPED		0x800000
-#define FOLIO_PAGES_MAPPED	(COMPOUND_MAPPED - 1)
+#define ENTIRELY_MAPPED		0x800000
+#define FOLIO_PAGES_MAPPED	(ENTIRELY_MAPPED - 1)
 
 /*
  * Flags passed to __show_mem() and show_free_areas() to suppress output in
diff --git a/mm/rmap.c b/mm/rmap.c
index 45296739236f..53753834a10d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1173,7 +1173,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
 				first = atomic_inc_return_relaxed(mapped);
-				first = (first < COMPOUND_MAPPED);
+				first = (first < ENTIRELY_MAPPED);
 			}
 
 			if (first)
@@ -1183,15 +1183,15 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 	case RMAP_MODE_PMD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
 		if (first) {
-			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
-			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
+			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
+			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
 				*nr_pmdmapped = folio_nr_pages(folio);
 				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of a remove and another add? */
 				if (unlikely(nr < 0))
 					nr = 0;
 			} else {
-				/* Raced ahead of a remove of COMPOUND_MAPPED */
+				/* Raced ahead of a remove of ENTIRELY_MAPPED */
 				nr = 0;
 			}
 		}
@@ -1434,7 +1434,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
+		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		SetPageAnonExclusive(&folio->page);
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
 	}
@@ -1516,7 +1516,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			last = atomic_add_negative(-1, &page->_mapcount);
 			if (last && folio_test_large(folio)) {
 				last = atomic_dec_return_relaxed(mapped);
-				last = (last < COMPOUND_MAPPED);
+				last = (last < ENTIRELY_MAPPED);
 			}
 
 			if (last)
@@ -1526,15 +1526,15 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	case RMAP_MODE_PMD:
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
-			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
-			if (likely(nr < COMPOUND_MAPPED)) {
+			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
+			if (likely(nr < ENTIRELY_MAPPED)) {
 				nr_pmdmapped = folio_nr_pages(folio);
 				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
 				/* Raced ahead of another remove and an add? */
 				if (unlikely(nr < 0))
 					nr = 0;
 			} else {
-				/* An add of COMPOUND_MAPPED raced ahead */
+				/* An add of ENTIRELY_MAPPED raced ahead */
 				nr = 0;
 			}
 		}
-- 
2.43.0

