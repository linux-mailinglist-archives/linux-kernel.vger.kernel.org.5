Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7E75C348
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGUJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGUJmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:42:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606F3C15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932522; x=1721468522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7g87XRsxPlXPl3gcejHKFouz+BtPVkulKmHSjYpyg4=;
  b=ORWw3mM01xHKBC6eLy4RNDIuKIs11uVTECYRFvLmxExpiFibTbKTgeRm
   E+VBzTFmwmABflGJJiiJ9qfi6iIDOYEpGfKCVEYnu6qk6BFtxRiePmfH0
   XTYQ8jPMldl8zvmG2RLb6H9BR25FPtPZrv4ZC2V9NnFP2zuyUgwpnB1Yh
   chzQ4n3r6so14OAl/OuVRsDuearPvaUEBjgtalMUawKKbpHs4y4+ANs7o
   wgQO+yWk6TODwPhU/QcgZiTLii2sdzByFkzmobBOmIr4mzej/Eu0CMtOM
   +jpbK0SPlKDZ7O8dCpcSRPDsCSUCb2xNfkA0pfgQnH9yZnw2CZoI/GWqo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346575496"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346575496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838480297"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838480297"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 02:41:26 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, yuzhao@google.com,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 4/4] madvise: avoid trying to split large folio always in cold_pageout
Date:   Fri, 21 Jul 2023 17:40:43 +0800
Message-Id: <20230721094043.2506691-5-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721094043.2506691-1-fengwei.yin@intel.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current madvise_cold_or_pageout_pte_range() always tries to split
large folio.

Avoid trying to split large folio always by:
  - if large folio is in the request range, don't split it. Leave
    to page reclaim to decide whether the large folio needs be
    split.
  - if large folio crosses boundaries of request range, skip it if
    it's page cache. Try to split it if it's anonymous large folio.
    If failed to split it, just skip it.

Invoke folio_referenced() to clear the A bit for large folio. As it
will acquire pte lock, just do it after release pte lock.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h |  10 +++++
 mm/madvise.c  | 118 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 93 insertions(+), 35 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c7dd15d8de3e..cd1ff348d690 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -586,6 +586,16 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
 
+static inline unsigned int
+folio_op_size(struct folio *folio, pte_t pte,
+		unsigned long addr, unsigned long end)
+{
+	unsigned int nr;
+
+	nr = folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
+	return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
+}
+
 static inline bool
 folio_in_range(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
diff --git a/mm/madvise.c b/mm/madvise.c
index b236e201a738..71af370c3251 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -339,6 +339,23 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline bool skip_cur_entry(struct folio *folio, bool pageout_anon_only)
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
+	if (pageout_anon_only && !folio_test_anon(folio))
+		return true;
+
+	return false;
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -352,7 +369,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
+	LIST_HEAD(reclaim_list);
 	bool pageout_anon_only_filter;
+	unsigned long start = addr;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -442,54 +461,90 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (skip_cur_entry(folio, pageout_anon_only_filter))
 			continue;
 
 		/*
-		 * Creating a THP page is expensive so split it only if we
-		 * are sure it's worth. Split it if we are only owner.
+		 * Split large folio only if it's anonymous, cross the
+		 * boundaries of request range and we are likely the
+		 * only onwer.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
+			int err, step;
 
 			if (folio_estimated_sharers(folio) != 1)
-				break;
-			if (pageout_anon_only_filter && !folio_test_anon(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
+				continue;
+			if (folio_in_range(folio, vma, start, end))
+				goto pageout_cold_folio;
+			if (!folio_test_anon(folio) || !folio_trylock(folio))
+				continue;
+
 			folio_get(folio);
+			step = folio_op_size(folio, ptent, addr, end);
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
+			/* split success. retry the same entry */
+			if (!err)
+				step = 0;
+
+			/*
+			 * Split fails, jump over the whole folio to avoid
+			 * grabbing same folio but fails to split it again
+			 * and again.
+			 */
+			pte += step - 1;
+			addr += (step - 1) << PAGE_SHIFT;
 			continue;
+		}
 
-		if (pageout_anon_only_filter && !folio_test_anon(folio))
+		/* Do not interfere with other mappings of this folio */
+		if (folio_mapcount(folio) != 1)
 			continue;
 
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 		ptep_clear_flush_young_notify(vma, addr, pte);
+
+pageout_cold_folio:
+		if (folio_isolate_lru(folio)) {
+			if (folio_test_unevictable(folio))
+				folio_putback_lru(folio);
+			else
+				list_add(&folio->lru, &folio_list);
+		}
+	}
+
+	if (start_pte) {
+		arch_leave_lazy_mmu_mode();
+		pte_unmap_unlock(start_pte, ptl);
+	}
+
+	while (!list_empty(&folio_list)) {
+		folio = lru_to_folio(&folio_list);
+		list_del(&folio->lru);
+
+		if (folio_test_large(folio)) {
+			int refs;
+			unsigned long flags;
+			struct mem_cgroup *memcg = folio_memcg(folio);
+
+			refs = folio_referenced(folio, 0, memcg, &flags);
+			if ((flags & VM_LOCKED) || (refs == -1)) {
+				folio_putback_lru(folio);
+				continue;
+			}
+		}
+
 		/*
 		 * We are deactivating a folio for accelerating reclaiming.
 		 * VM couldn't reclaim the folio unless we clear PG_young.
@@ -501,22 +556,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_active(folio))
 			folio_set_workingset(folio);
 		if (pageout) {
-			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
-					folio_putback_lru(folio);
-				else
-					list_add(&folio->lru, &folio_list);
-			}
-		} else
-			folio_deactivate(folio);
+			list_add(&folio->lru, &reclaim_list);
+		} else {
+			folio_clear_active(folio);
+			folio_putback_lru(folio);
+		}
 	}
 
-	if (start_pte) {
-		arch_leave_lazy_mmu_mode();
-		pte_unmap_unlock(start_pte, ptl);
-	}
 	if (pageout)
-		reclaim_pages(&folio_list);
+		reclaim_pages(&reclaim_list);
 	cond_resched();
 
 	return 0;
-- 
2.39.2

