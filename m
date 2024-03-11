Return-Path: <linux-kernel+bounces-99037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A78782A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB481F24DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4466481C0;
	Mon, 11 Mar 2024 15:01:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4247F41
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169286; cv=none; b=ZLG0mQHsIVd91AIBNnTXhS0eno5ftUbqkg1od+jcJJ45qkEnheu5wnnnTu4QjiYFYZGRMeF7Ik4iU3TIrS2Dn6+gfzCjapt4ME8EaQaofwAJUzz4p1H8YO0IIk706yyI0pgonJ27zjQAzSh27T2DxNjGFaURXcu0K5WUrTUgsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169286; c=relaxed/simple;
	bh=i8N9AeOLlOU3zHXlKW31HNI+AQCrILnV7S/8j95cLC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGhn75yTDJbJO9m76JmWl4Vmaz132yH5h1xI/VYcUKDD1zd40kdxiDcBF3Mr7DveIcwvoxaDuqMCGJYE0+gx1XPZIJ9+mEwQWayOV02Q53k07acGZ5JLm53MjxOfsXACmpXuxqozXHMwC+VjGX/t8ikEh6gukuRc+KZbkR4ruyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FEE3153B;
	Mon, 11 Mar 2024 08:02:01 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267053F64C;
	Mon, 11 Mar 2024 08:01:22 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
Date: Mon, 11 Mar 2024 15:00:58 +0000
Message-Id: <20240311150058.1122862-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311150058.1122862-1-ryan.roberts@arm.com>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
folio that is fully and contiguously mapped in the pageout/cold vm
range. This change means that large folios will be maintained all the
way to swap storage. This both improves performance during swap-out, by
eliding the cost of splitting the folio, and sets us up nicely for
maintaining the large folio when it is swapped back in (to be covered in
a separate series).

Folios that are not fully mapped in the target range are still split,
but note that behavior is changed so that if the split fails for any
reason (folio locked, shared, etc) we now leave it as is and move to the
next pte in the range and continue work on the proceeding folios.
Previously any failure of this sort would cause the entire operation to
give up and no folios mapped at higher addresses were paged out or made
cold. Given large folios are becoming more common, this old behavior
would have likely lead to wasted opportunities.

While we are at it, change the code that clears young from the ptes to
use ptep_test_and_clear_young(), which is more efficent than
get_and_clear/modify/set, especially for contpte mappings on arm64,
where the old approach would require unfolding/refolding and the new
approach can be done in place.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/madvise.c | 89 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 38 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 547dcd1f7a39..56c7ba7bd558 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	LIST_HEAD(folio_list);
 	bool pageout_anon_only_filter;
 	unsigned int batch_count = 0;
+	int nr;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
-	for (; addr < end; pte++, addr += PAGE_SIZE) {
+	for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
+		nr = 1;
 		ptent = ptep_get(pte);
 
 		if (++batch_count == SWAP_CLUSTER_MAX) {
@@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		/*
-		 * Creating a THP page is expensive so split it only if we
-		 * are sure it's worth. Split it if we are only owner.
+		 * If we encounter a large folio, only split it if it is not
+		 * fully mapped within the range we are operating on. Otherwise
+		 * leave it as is so that it can be swapped out whole. If we
+		 * fail to split a folio, leave it in place and advance to the
+		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
-
-			if (folio_estimated_sharers(folio) > 1)
-				break;
-			if (pageout_anon_only_filter && !folio_test_anon(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
-			folio_get(folio);
-			arch_leave_lazy_mmu_mode();
-			pte_unmap_unlock(start_pte, ptl);
-			start_pte = NULL;
-			err = split_folio(folio);
-			folio_unlock(folio);
-			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
-			pte--;
-			addr -= PAGE_SIZE;
-			continue;
+			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
+						FPB_IGNORE_SOFT_DIRTY;
+			int max_nr = (end - addr) / PAGE_SIZE;
+
+			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
+					     fpb_flags, NULL);
+
+			if (nr < folio_nr_pages(folio)) {
+				int err;
+
+				if (folio_estimated_sharers(folio) > 1)
+					continue;
+				if (pageout_anon_only_filter && !folio_test_anon(folio))
+					continue;
+				if (!folio_trylock(folio))
+					continue;
+				folio_get(folio);
+				arch_leave_lazy_mmu_mode();
+				pte_unmap_unlock(start_pte, ptl);
+				start_pte = NULL;
+				err = split_folio(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+				if (err)
+					continue;
+				start_pte = pte =
+					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				if (!start_pte)
+					break;
+				arch_enter_lazy_mmu_mode();
+				nr = 0;
+				continue;
+			}
 		}
 
 		/*
 		 * Do not interfere with other mappings of this folio and
-		 * non-LRU folio.
+		 * non-LRU folio. If we have a large folio at this point, we
+		 * know it is fully mapped so if its mapcount is the same as its
+		 * number of pages, it must be exclusive.
 		 */
-		if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
+		if (!folio_test_lru(folio) ||
+		    folio_mapcount(folio) != folio_nr_pages(folio))
 			continue;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
 			continue;
 
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
-		if (!pageout && pte_young(ptent)) {
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			ptent = pte_mkold(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+		if (!pageout) {
+			for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
+				if (ptep_test_and_clear_young(vma, addr, pte))
+					tlb_remove_tlb_entry(tlb, pte, addr);
+			}
 		}
 
 		/*
-- 
2.25.1


