Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1AF80D04F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbjLKP72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbjLKP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:58:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619DCB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702310304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX1pXuuGCFSgne2iWx/veTQmI+PIa0/pNoky6wKmMd0=;
        b=J7tFFTC7KTwNnDMqe/WpYzR1ivyyVvJR13Fa0tKJr4gNiaJbwRd1NOLjg5G/kLe0QSkRoO
        PiAjn/NTdhCtgKerpkKFnI6kYb2Po3yY+8PLR9tBuiHe/UetzHjTL3ej6NedCz5s8LPqdk
        j/dRHr92mSAVyRDQT/HVMy+sQ55Iu18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-6fAsG4HZNcWrnusNEcf0NQ-1; Mon, 11 Dec 2023 10:58:21 -0500
X-MC-Unique: 6fAsG4HZNcWrnusNEcf0NQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5105985A589;
        Mon, 11 Dec 2023 15:58:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4221121306;
        Mon, 11 Dec 2023 15:58:18 +0000 (UTC)
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
Subject: [PATCH v1 33/39] mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
Date:   Mon, 11 Dec 2023 16:56:46 +0100
Message-ID: <20231211155652.131054-34-david@redhat.com>
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

Let's convert page_dup_file_rmap() like the other rmap functions. As there
is only a single caller, convert that single caller right away and remove
page_dup_file_rmap().

Add folio_dup_file_rmap_ptes() right away, we want to perform rmap
baching during fork() soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 59 ++++++++++++++++++++++++++++++++++++++++----
 mm/memory.c          |  2 +-
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0f4eecd03bdc..df60e44fecad 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -311,6 +311,60 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 	atomic_dec(&folio->_entire_mapcount);
 }
 
+static __always_inline void __folio_dup_file_rmap(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_mode mode)
+{
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
+
+	switch (mode) {
+	case RMAP_MODE_PTE:
+		do {
+			atomic_inc(&page->_mapcount);
+		} while (page++, --nr_pages > 0);
+		break;
+	case RMAP_MODE_PMD:
+		atomic_inc(&folio->_entire_mapcount);
+		break;
+	}
+}
+
+/**
+ * folio_dup_file_rmap_ptes - duplicate PTE mappings of a page range of a folio
+ * @folio:	The folio to duplicate the mappings of
+ * @page:	The first page to duplicate the mappings of
+ * @nr_pages:	The number of pages of which the mapping will be duplicated
+ *
+ * The page range of the folio is defined by [page, page + nr_pages)
+ *
+ * The caller needs to hold the page table lock.
+ */
+static inline void folio_dup_file_rmap_ptes(struct folio *folio,
+		struct page *page, int nr_pages)
+{
+	__folio_dup_file_rmap(folio, page, nr_pages, RMAP_MODE_PTE);
+}
+#define folio_dup_file_rmap_pte(folio, page) \
+	folio_dup_file_rmap_ptes(folio, page, 1)
+
+/**
+ * folio_dup_file_rmap_pmd - duplicate a PMD mapping of a page range of a folio
+ * @folio:	The folio to duplicate the mapping of
+ * @page:	The first page to duplicate the mapping of
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock.
+ */
+static inline void folio_dup_file_rmap_pmd(struct folio *folio,
+		struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_MODE_PTE);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
@@ -325,11 +379,6 @@ static inline void __page_dup_rmap(struct page *page, bool compound)
 	}
 }
 
-static inline void page_dup_file_rmap(struct page *page, bool compound)
-{
-	__page_dup_rmap(page, compound);
-}
-
 /**
  * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
  *			    anonymous page
diff --git a/mm/memory.c b/mm/memory.c
index 9a5724cf895f..42a0b7b41b86 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -965,7 +965,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		rss[MM_ANONPAGES]++;
 	} else if (page) {
 		folio_get(folio);
-		page_dup_file_rmap(page, false);
+		folio_dup_file_rmap_pte(folio, page);
 		rss[mm_counter_file(page)]++;
 	}
 
-- 
2.43.0

