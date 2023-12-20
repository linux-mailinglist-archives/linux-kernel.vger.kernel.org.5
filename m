Return-Path: <linux-kernel+bounces-7600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C983A81AAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0820F1C22A64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82851C2A;
	Wed, 20 Dec 2023 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYZUI4eA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358776902
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FS6TinGTKiO3H/lfNCqQPkYyWdSgfpvkK+CFwNOsPIw=;
	b=DYZUI4eAzbE/81PlcrPVDpDIIbYgaOcyDvRpBkFWonR2IC2NxbZz6E7CIILjM8lYsbbQ3t
	YBe8Ur1EeUDY7/wY0fsRTKAu25MPdwN5nfMGNnK8ydUXQi4p9o6qsNoNq6r1WvlQ3882Wx
	D4sKYGPym9V+M+iKy+qAA8gqQ5H6Dvw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-hNtzcJbYOtScYX6nbBDUnA-1; Wed,
 20 Dec 2023 17:46:34 -0500
X-MC-Unique: hNtzcJbYOtScYX6nbBDUnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6BF838425AF;
	Wed, 20 Dec 2023 22:46:33 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC8F40C6EB9;
	Wed, 20 Dec 2023 22:46:31 +0000 (UTC)
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
Subject: [PATCH v2 33/40] mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
Date: Wed, 20 Dec 2023 23:44:57 +0100
Message-ID: <20231220224504.646757-34-david@redhat.com>
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
index fef369e37039a..7607f862e795d 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -308,6 +308,60 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 	atomic_dec(&folio->_entire_mapcount);
 }
 
+static __always_inline void __folio_dup_file_rmap(struct folio *folio,
+		struct page *page, int nr_pages, enum rmap_level level)
+{
+	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
+
+	switch (level) {
+	case RMAP_LEVEL_PTE:
+		do {
+			atomic_inc(&page->_mapcount);
+		} while (page++, --nr_pages > 0);
+		break;
+	case RMAP_LEVEL_PMD:
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
+	__folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
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
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
 static inline void __page_dup_rmap(struct page *page, bool compound)
 {
 	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
@@ -322,11 +376,6 @@ static inline void __page_dup_rmap(struct page *page, bool compound)
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
index eda2181275d9b..dc2a8e6858179 100644
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


