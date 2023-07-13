Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05855752625
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGMPIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjGMPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:07:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D612D77
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689260875; x=1720796875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KgsM9imYCYm5fiz4MTQMJQkXw1eDr2ok+54qm0QdHss=;
  b=Tj4EjNOKX6ts6EVy/R1Zs/RPD/IYbUrsUkZ/PM1DUdsTF0hffhctAFkE
   t9X+igghZ5c2h3/tdv7P1YCzBiUY8nInP/TG/ub5p6kEm33VyLAx+9efS
   eVqHDgjneEzMz+ULEPlbl2YqFb933xpb/D0epnsICbUeo+FlLiWrLk9YY
   xBKJu1eDKji3PtZL64nzD1MRY4SSVCULpgDOtOry1ZBrq/f/Y7UNERLL1
   7q+Kn4aI8y7zpIGdsXdqprVItCfJwOhnNeR51cLQgJ5yxvlm42jYyTU0k
   N6FqR+ZfTXQi/NLsQG5bbOo8H7b+kwGFsFLWfTR2cW4s1JKUqN2Tbayss
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="367856639"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="367856639"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:05:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052666472"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="1052666472"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2023 08:05:53 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range() support large folio
Date:   Thu, 13 Jul 2023 23:05:58 +0800
Message-Id: <20230713150558.200545-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Current madvise_cold_or_pageout_pte_range() has two problems for
large folio support:
  - Using folio_mapcount() with large folio prevent large folio from
    picking up.
  - If large folio is in the range requested, shouldn't split it
    in madvise_cold_or_pageout_pte_range().

Fix them by:
  - Use folio_estimated_sharers() with large folio
  - If large folio is in the range requested, don't split it. Leave
    to page reclaim phase.

For large folio cross boundaries of requested range, skip it if it's
page cache. Try to split it if it's anonymous folio. If splitting
fails, skip it.

The main reason to call folio_referenced() is to clear the yong of
conresponding PTEs. So in page reclaim phase, there is good chance
the folio can be reclaimed.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
This patch is based on mlock large folio support rfc2 as it depends
on the folio_in_range() added by that patchset

Also folio_op_size() can be unitfied with get_folio_mlock_step().

Testing done:
  - kselftest: No new regression introduced.

 mm/madvise.c | 133 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 49 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 38382a5d1e393..5748cf098235d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -31,6 +31,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/kernel.h>
 
 #include <asm/tlb.h>
 
@@ -339,6 +340,35 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline bool skip_current_entry(struct folio *folio, bool pageout_anon)
+{
+	if (!folio)
+		return true;
+
+	if (folio_is_zone_device(folio))
+		return true;
+
+	if (!folio_test_lru(folio))
+		return true;
+
+	if (pageout_anon && !folio_test_anon(folio))
+		return true;
+
+	if (folio_test_unevictable(folio))
+		return true;
+
+	return false;
+}
+
+static inline unsigned int folio_op_size(struct folio *folio, pte_t pte,
+		unsigned long addr, unsigned long end)
+{
+	unsigned int nr;
+
+	nr = folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
+	return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -353,6 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
 	bool pageout_anon_only_filter;
+	unsigned long start = addr;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -383,7 +414,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -442,78 +473,60 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
 
-		if (pte_none(ptent))
-			continue;
-
-		if (!pte_present(ptent))
+		if (pte_none(ptent) || !pte_present(ptent))
 			continue;
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (skip_current_entry(folio, pageout_anon_only_filter))
 			continue;
 
 		/*
-		 * Creating a THP page is expensive so split it only if we
-		 * are sure it's worth. Split it if we are only owner.
+		 * Split large folio if it's anonymous and cross the
+		 * boundaries of request range.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
+			int err, step;
+
+			if (folio_estimated_sharers(folio) != 1)
+				continue;
+
+			if (folio_in_range(folio, vma, start, end))
+				goto pageout_cold_folio;
 
-			if (folio_mapcount(folio) != 1)
-				break;
-			if (pageout_anon_only_filter && !folio_test_anon(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
 			folio_get(folio);
+			step = folio_op_size(folio, ptent, addr, end);
+			if (!folio_test_anon(folio) || !folio_trylock(folio)) {
+				folio_put(folio);
+				goto next_folio;
+			}
+
 			arch_leave_lazy_mmu_mode();
 			pte_unmap_unlock(start_pte, ptl);
 			start_pte = NULL;
 			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-			if (err)
-				break;
+
 			start_pte = pte =
 				pte_offset_map_lock(mm, pmd, addr, &ptl);
 			if (!start_pte)
 				break;
 			arch_enter_lazy_mmu_mode();
-			pte--;
-			addr -= PAGE_SIZE;
-			continue;
-		}
 
-		/*
-		 * Do not interfere with other mappings of this folio and
-		 * non-LRU folio.
-		 */
-		if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
+			/* Skip the folio if split fails */
+			if (!err)
+				step = 0;
+next_folio:
+			pte += step - 1;
+			addr += (step - 1) << PAGE_SHIFT;
 			continue;
+		}
 
-		if (pageout_anon_only_filter && !folio_test_anon(folio))
+		/* Do not interfere with other mappings of this folio */
+		if (folio_mapcount(folio) != 1)
 			continue;
 
-		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
-		if (pte_young(ptent)) {
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			ptent = pte_mkold(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-		}
-
-		/*
-		 * We are deactivating a folio for accelerating reclaiming.
-		 * VM couldn't reclaim the folio unless we clear PG_young.
-		 * As a side effect, it makes confuse idle-page tracking
-		 * because they will miss recent referenced history.
-		 */
-		folio_clear_referenced(folio);
-		folio_test_clear_young(folio);
-		if (folio_test_active(folio))
-			folio_set_workingset(folio);
+pageout_cold_folio:
 		if (pageout) {
 			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
@@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		arch_leave_lazy_mmu_mode();
 		pte_unmap_unlock(start_pte, ptl);
 	}
-	if (pageout)
-		reclaim_pages(&folio_list);
+
+	if (pageout) {
+		LIST_HEAD(reclaim_list);
+
+		while (!list_empty(&folio_list)) {
+			int refs;
+			unsigned long flags;
+			struct mem_cgroup *memcg = folio_memcg(folio);
+
+			folio = lru_to_folio(&folio_list);
+			list_del(&folio->lru);
+
+			refs = folio_referenced(folio, 0, memcg, &flags);
+
+			if ((flags & VM_LOCKED) || (refs == -1)) {
+				folio_putback_lru(folio);
+				continue;
+			}
+
+			folio_test_clear_referenced(folio);
+			list_add(&folio->lru, &reclaim_list);
+		}
+		reclaim_pages(&reclaim_list);
+	}
 	cond_resched();
 
 	return 0;
-- 
2.39.2

