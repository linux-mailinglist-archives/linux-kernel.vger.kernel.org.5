Return-Path: <linux-kernel+bounces-7606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943D81AABE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E41283062
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C34AF83;
	Wed, 20 Dec 2023 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gon69BVo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1C6A000
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97Mkj9KBAth/M3QAsUCGduTq4AF8YjGPbQx442c84RA=;
	b=gon69BVo6BIEoRgOuz1aJnujxH8zvCUpYPbjN23vf7RrtDRg0N8dFDNqqwLoUHQwWKnJnB
	C0nGhMmNhyAlwjXKjdcaa0S/P4DCA2r1ZXZO9hJuNf/+o9dUtPMSD9ROBMOejVmBm2JvX8
	cYT9LvMh727e7GWlTTPSPbNLmfl5IM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-w_aS-3J-PiOb71UIJo4vXQ-1; Wed, 20 Dec 2023 17:46:50 -0500
X-MC-Unique: w_aS-3J-PiOb71UIJo4vXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C361019C89;
	Wed, 20 Dec 2023 22:46:49 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 28EFF40C6EB9;
	Wed, 20 Dec 2023 22:46:47 +0000 (UTC)
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
Subject: [PATCH v2 39/40] mm/rmap: rename COMPOUND_MAPPED to ENTIRELY_MAPPED
Date: Wed, 20 Dec 2023 23:45:03 +0100
Message-ID: <20231220224504.646757-40-david@redhat.com>
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
index cf81272a6b8b6..93c9239b9ebe2 100644
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
index 29589bc3f046d..188807d2aebc5 100644
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
index 6209e65985a26..f5d43edad529a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1172,7 +1172,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
 				first = atomic_inc_return_relaxed(mapped);
-				first = (first < COMPOUND_MAPPED);
+				first = (first < ENTIRELY_MAPPED);
 			}
 
 			if (first)
@@ -1182,15 +1182,15 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 	case RMAP_LEVEL_PMD:
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
@@ -1433,7 +1433,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
+		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		SetPageAnonExclusive(&folio->page);
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
 	}
@@ -1514,7 +1514,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			last = atomic_add_negative(-1, &page->_mapcount);
 			if (last && folio_test_large(folio)) {
 				last = atomic_dec_return_relaxed(mapped);
-				last = (last < COMPOUND_MAPPED);
+				last = (last < ENTIRELY_MAPPED);
 			}
 
 			if (last)
@@ -1524,15 +1524,15 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	case RMAP_LEVEL_PMD:
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


