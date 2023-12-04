Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794B3803688
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345303AbjLDO01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjLDO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49F30C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fiJf6xaTCn9hTJUSpG0inAWeRQ8SaM/ZLU1i30jXpOI=;
        b=asngjzMlhUU39DZx8hK0LeWM/KllccQY6HZzT294anYLK9LdIA71uEj3s5gGq8qD1epNdq
        MYnfJTpXsM+Lbc3/MquA/QILABOPLl+uMXI9HFcEpmjFHfffi/z3rVYQaEdOanYodWNjJh
        en8w42Ajh2Jq/HkqogoQnNp/q9YWQJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-gWsSkqhfMSOvilQ5o3bMzQ-1; Mon, 04 Dec 2023 09:23:25 -0500
X-MC-Unique: gWsSkqhfMSOvilQ5o3bMzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53AF1811E82;
        Mon,  4 Dec 2023 14:22:51 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.195.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD95F2026D4C;
        Mon,  4 Dec 2023 14:22:49 +0000 (UTC)
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
Subject: [PATCH RFC 33/39] mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
Date:   Mon,  4 Dec 2023 15:21:40 +0100
Message-ID: <20231204142146.91437-34-david@redhat.com>
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

Let's convert page_dup_file_rmap() like the other rmap functions. As there
is only a single caller, convert that single caller right away and remove
page_dup_file_rmap().

Add folio_dup_file_rmap_ptes() right away, we want to perform rmap
baching during fork() soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 56 ++++++++++++++++++++++++++++++++++++++++----
 mm/memory.c          |  2 +-
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bdbfb11638e4f..21d72cc602adc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -303,6 +303,57 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 	atomic_dec(&folio->_entire_mapcount);
 }
 
+static inline void __folio_dup_rmap(struct folio *folio, struct page *page,
+		unsigned int nr_pages, enum rmap_mode mode)
+{
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
+
+	if (likely(mode == RMAP_MODE_PTE)) {
+		do {
+			atomic_inc(&page->_mapcount);
+		} while (page++, --nr_pages > 0);
+	} else if (mode == RMAP_MODE_PMD) {
+		atomic_inc(&folio->_entire_mapcount);
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
+		struct page *page, unsigned int nr_pages)
+{
+	__folio_dup_rmap(folio, page, nr_pages, RMAP_MODE_PTE);
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
+	__folio_dup_rmap(folio, page, HPAGE_PMD_NR, RMAP_MODE_PTE);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
@@ -317,11 +368,6 @@ static inline void __page_dup_rmap(struct page *page, bool compound)
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
index 8c4f98bb617fa..eaab6a2e14eba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -961,7 +961,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		rss[MM_ANONPAGES]++;
 	} else if (page) {
 		folio_get(folio);
-		page_dup_file_rmap(page, false);
+		folio_dup_file_rmap_pte(folio, page);
 		rss[mm_counter_file(page)]++;
 	}
 
-- 
2.41.0

