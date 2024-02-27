Return-Path: <linux-kernel+bounces-83970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BB486A0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960451C23E53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151414A4DC;
	Tue, 27 Feb 2024 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLPA0oQr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC794D5A2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709064959; cv=none; b=SkGYrVtOzlM7KoJ7EBxd9YuV2tdWh7+Adz55lfHNXxUoeJ6QpJufJMr44Jc+zZCVenrfrA0XC/zY5pxpgHWDujpC7KS90eTyyD7S9gz9SqitCy5soR9n8soUmEtUi3K4JxYRCPTXihJLZU5+l4y2eYtuyYpvK+smEN3QqvrNSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709064959; c=relaxed/simple;
	bh=VK5ZLickJUjOy7+jY9XOUhZboq1Ll5OCYEdvttHFqc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSecLwc1ZURD3cVymyKWA6QSKLkCIROid3Nai1D0zsBgkfpU67TpDSBofZJB0kDSu369OiZcFlBj9UowkRpvBUVRCwe/IVkcx95k2TdVlQNuFi4FrXWsQ9ra1Y0ItCVUl7kJ3Pzsekn1+nyJSD8AKjFC+GQp53LI1+0+6shCuoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLPA0oQr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709064955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Autf58lTUMoeQMpAqwvW0HpwA5+93miRhkjagXxn3PE=;
	b=hLPA0oQrcyBuQp8nt/82hII/S3MUdHa7aw+llG3E8Wk5lyaAyHtMUJH5U4y4LLMsea2CSl
	qYl29NOCsq6N44jH9K0Kk4XZz7oFRbpqVCacjKNkBJu8WmK1rXwo/AGodRTDw7739SB/ea
	cSHUJMwFLaZNGcjxD7O+SR9IUPNmiHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-1EfyVbW4OGWoPUVT6EhhTg-1; Tue, 27 Feb 2024 15:15:51 -0500
X-MC-Unique: 1EfyVbW4OGWoPUVT6EhhTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4272811E81;
	Tue, 27 Feb 2024 20:15:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.77])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F08A40C122C;
	Tue, 27 Feb 2024 20:15:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v1] mm: convert folio_estimated_sharers() to folio_likely_mapped_shared()
Date: Tue, 27 Feb 2024 21:15:48 +0100
Message-ID: <20240227201548.857831-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Callers of folio_estimated_sharers() only care about "mapped shared vs.
mapped exclusively", not the exact estimate of sharers. Let's consolidate
and unify the condition users are checking. While at it clarify the
semantics and extend the discussion on the fuzziness.

Use the "likely mapped shared" terminology to better express what the
(adjusted) function actually checks.

Whether a partially-mappable folio is more likely to not be partially
mapped than partially mapped is debatable. In the future, we might be able
to improve our estimate for partially-mappable folios, though.

Note that we will now consistently detect "mapped shared" only if the
first subpage is actually mapped multiple times. When the first subpage
is not mapped, we will consistently detect it as "mapped exclusively".
This change should currently only affect the usage in
madvise_free_pte_range() and queue_folios_pte_range() for large folios: if
the first page was already unmapped, we would have skipped the folio.

Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 46 ++++++++++++++++++++++++++++++++++++----------
 mm/huge_memory.c   |  2 +-
 mm/madvise.c       |  6 +++---
 mm/memory.c        |  2 +-
 mm/mempolicy.c     | 14 ++++++--------
 mm/migrate.c       |  8 ++++----
 6 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f4825d829656..795c89632265f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2147,21 +2147,47 @@ static inline size_t folio_size(struct folio *folio)
 }
 
 /**
- * folio_estimated_sharers - Estimate the number of sharers of a folio.
+ * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
+ *				tables of more than one MM
  * @folio: The folio.
  *
- * folio_estimated_sharers() aims to serve as a function to efficiently
- * estimate the number of processes sharing a folio. This is done by
- * looking at the precise mapcount of the first subpage in the folio, and
- * assuming the other subpages are the same. This may not be true for large
- * folios. If you want exact mapcounts for exact calculations, look at
- * page_mapcount() or folio_total_mapcount().
+ * This function checks if the folio is currently mapped into more than one
+ * MM ("mapped shared"), or if the folio is only mapped into a single MM
+ * ("mapped exclusively").
  *
- * Return: The estimated number of processes sharing a folio.
+ * As precise information is not easily available for all folios, this function
+ * estimates the number of MMs ("sharers") that are currently mapping a folio
+ * using the number of times the first page of the folio is currently mapped
+ * into page tables.
+ *
+ * For small anonymous folios (except KSM folios) and anonymous hugetlb folios,
+ * the return value will be exactly correct, because they can only be mapped
+ * at most once into an MM, and they cannot be partially mapped.
+ *
+ * For other folios, the result can be fuzzy:
+ * (a) For partially-mappable large folios (THP), the return value can wrongly
+ *     indicate "mapped exclusively" (false negative) when the folio is
+ *     only partially mapped into at least one MM.
+ * (b) For pagecache folios (including hugetlb), the return value can wrongly
+ *     indicate "mapped shared" (false positive) when two VMAs in the same MM
+ *     cover the same file range.
+ * (c) For (small) KSM folios, the return value can wrongly indicate "mapped
+ *     shared" (false negative), when the folio is mapped multiple times into
+ *     the same MM.
+ *
+ * Further, this function only considers current page table mappings that
+ * are tracked using the folio mapcount(s). It does not consider:
+ * (1) If the folio might get mapped in the (near) future (e.g., swapcache,
+ *     pagecache, temporary unmapping for migration).
+ * (2) If the folio is mapped differently (VM_PFNMAP).
+ * (3) If hugetlb page table sharing applies. Callers might want to check
+ *     hugetlb_pmd_shared().
+ *
+ * Return: Whether the folio is estimated to be mapped into more than one MM.
  */
-static inline int folio_estimated_sharers(struct folio *folio)
+static inline bool folio_likely_mapped_shared(struct folio *folio)
 {
-	return page_mapcount(folio_page(folio, 0));
+	return page_mapcount(folio_page(folio, 0)) > 1;
 }
 
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 50d146eb248ff..4d10904fef70c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1829,7 +1829,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_estimated_sharers(folio) != 1)
+	if (folio_likely_mapped_shared(folio))
 		goto out;
 
 	if (!folio_trylock(folio))
diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158c..32a534d200219 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -366,7 +366,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_estimated_sharers(folio) != 1)
+		if (folio_likely_mapped_shared(folio))
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_estimated_sharers(folio) > 1)
+			if (folio_likely_mapped_shared(folio))
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
@@ -677,7 +677,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_estimated_sharers(folio) != 1)
+			if (folio_likely_mapped_shared(folio))
 				break;
 			if (!folio_trylock(folio))
 				break;
diff --git a/mm/memory.c b/mm/memory.c
index 1c45b6a42a1b9..8394a9843ca06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5173,7 +5173,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (folio_estimated_sharers(folio) > 1 && (vma->vm_flags & VM_SHARED))
+	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f60b4c99f1302..0b92fde395182 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -642,12 +642,11 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * To check if the folio is shared, ideally we want to make sure
-	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated sharers of the folio instead.
+	 * See folio_likely_mapped_shared() on possible imprecision when we
+	 * cannot easily detect if a folio is shared.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (folio_estimated_sharers(folio) == 1 && !hugetlb_pmd_shared(pte)))
+	    (!folio_likely_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
 		if (!isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:
@@ -1032,11 +1031,10 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * To check if the folio is shared, ideally we want to make sure
-	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated sharers of the folio instead.
+	 * See folio_likely_mapped_shared() on possible imprecision when we
+	 * cannot easily detect if a folio is shared.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
+	if ((flags & MPOL_MF_MOVE_ALL) || !folio_likely_mapped_shared(folio)) {
 		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
 			node_stat_mod_folio(folio,
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f13..35d376969f8b9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2568,11 +2568,11 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	/*
 	 * Don't migrate file folios that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
-	 * To check if the folio is shared, ideally we want to make sure
-	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated mapcount of the folio instead.
+	 *
+	 * See folio_likely_mapped_shared() on possible imprecision when we
+	 * cannot easily detect if a folio is shared.
 	 */
-	if (folio_estimated_sharers(folio) != 1 && folio_is_file_lru(folio) &&
+	if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
-- 
2.43.2


