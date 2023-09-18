Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2087A42D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbjIRHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjIRHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:34:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA7ECC8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695022432; x=1726558432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2yvamEVzhzGGtx2e9kET8hOBuj45FWaLJl5k8kbHNoc=;
  b=UTe/bYNAmIPpwlysghvAfGRTC9gCCPstTKa8HwWRMmnvFinuNfyfbZiB
   jz/Fj9eWQPrSZJH+la2a70MZvloQd0C2POumJjUAKadB/hfYHgON6S35E
   gopjWHc/6DbTcmQ5ayFWrbcJlTdMEjoIe4TcexUJ6UyW3nxiLlCOwUQHw
   iBkVSPp3CvKdJAGhg7zOTWoorgHoYlpkAigi2MzLpR7G5N6ksKnppsmHY
   kqhCPx4cr51uTtoQ4UhTD528TP9RjJLpUaK4LYZPWu/2XGG2vBNwxtyPS
   HFYLeSJ0dgIvCAVZ6d37L7rrK53EMFfYmcocU4u0LZu8fz68PSlymO0Z/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364630957"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="364630957"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815915431"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815915431"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2023 00:33:48 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v3 2/3] mm: handle large folio when large folio in VM_LOCKED VMA range
Date:   Mon, 18 Sep 2023 15:33:17 +0800
Message-Id: <20230918073318.1181104-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918073318.1181104-1-fengwei.yin@intel.com>
References: <20230918073318.1181104-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If large folio is in the range of VM_LOCKED VMA, it should be
mlocked to avoid being picked by page reclaim. Which may split
the large folio and then mlock each pages again.

Mlock this kind of large folio to prevent them being picked by
page reclaim.

For the large folio which cross the boundary of VM_LOCKED VMA
or not fully mapped to VM_LOCKED VMA, we'd better not to mlock
it. So if the system is under memory pressure, this kind of
large folio will be split and the pages ouf of VM_LOCKED VMA
can be reclaimed.

Ideally, for large folio, we should mlock it when the large folio
is fully mapped to VMA and munlock it if any page are unmampped
from VMA. But it's not easy to detect whether the large folio is
fully mapped to VMA in some cases (like add/remove rmap). So we
update mlock_vma_folio() and munlock_vma_folio() to mlock/munlock
the folio according to vma->vm_flags. Let caller to decide whether
they should call these two functions.

For add rmap, only mlock normal 4K folio and postpone large folio
handling to page reclaim phase. It is possible to reuse page table
iterator to detect whether folio is fully mapped or not during
page reclaim phase. For remove rmap, invoke munlock_vma_folio()
to munlock folio unconditionly because rmap makes folio not fully
mapped to VMA.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 23 ++++++++++--------
 mm/rmap.c     | 66 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9e2a5b32c659..c1441fd9898e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -645,14 +645,10 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
  * mlock is usually called at the end of page_add_*_rmap(), munlock at
  * the end of page_remove_rmap(); but new anon folios are managed by
  * folio_add_lru_vma() calling mlock_new_folio().
- *
- * @compound is used to include pmd mappings of THPs, but filter out
- * pte mappings of THPs, which cannot be consistently counted: a pte
- * mapping of the THP head cannot be distinguished by the page alone.
  */
 void mlock_folio(struct folio *folio);
 static inline void mlock_vma_folio(struct folio *folio,
-			struct vm_area_struct *vma, bool compound)
+				struct vm_area_struct *vma)
 {
 	/*
 	 * The VM_SPECIAL check here serves two purposes.
@@ -662,17 +658,24 @@ static inline void mlock_vma_folio(struct folio *folio,
 	 *    file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
 	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
 	 */
-	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED))
 		mlock_folio(folio);
 }
 
 void munlock_folio(struct folio *folio);
 static inline void munlock_vma_folio(struct folio *folio,
-			struct vm_area_struct *vma, bool compound)
+					struct vm_area_struct *vma)
 {
-	if (unlikely(vma->vm_flags & VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	/*
+	 * munlock if the function is called. Ideally, we should only
+	 * do munlock if any page of folio is unmapped from VMA and
+	 * cause folio not fully mapped to VMA.
+	 *
+	 * But it's not easy to confirm that's the situation. So we
+	 * always munlock the folio and page reclaim will correct it
+	 * if it's wrong.
+	 */
+	if (unlikely(vma->vm_flags & VM_LOCKED))
 		munlock_folio(folio);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 789a2beb8b3a..e4b92e585df9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -798,6 +798,7 @@ struct folio_referenced_arg {
 	unsigned long vm_flags;
 	struct mem_cgroup *memcg;
 };
+
 /*
  * arg: folio_referenced_arg will be passed
  */
@@ -807,17 +808,33 @@ static bool folio_referenced_one(struct folio *folio,
 	struct folio_referenced_arg *pra = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
 	int referenced = 0;
+	unsigned long start = address, ptes = 0;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if ((vma->vm_flags & VM_LOCKED) &&
-		    (!folio_test_large(folio) || !pvmw.pte)) {
-			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma, !pvmw.pte);
-			page_vma_mapped_walk_done(&pvmw);
-			pra->vm_flags |= VM_LOCKED;
-			return false; /* To break the loop */
+		if (vma->vm_flags & VM_LOCKED) {
+			if (!folio_test_large(folio) || !pvmw.pte) {
+				/* Restore the mlock which got missed */
+				mlock_vma_folio(folio, vma);
+				page_vma_mapped_walk_done(&pvmw);
+				pra->vm_flags |= VM_LOCKED;
+				return false; /* To break the loop */
+			}
+			/*
+			 * For large folio fully mapped to VMA, will
+			 * be handled after the pvmw loop.
+			 *
+			 * For large folio cross VMA boundaries, it's
+			 * expected to be picked  by page reclaim. But
+			 * should skip reference of pages which are in
+			 * the range of VM_LOCKED vma. As page reclaim
+			 * should just count the reference of pages out
+			 * the range of VM_LOCKED vma.
+			 */
+			ptes++;
+			pra->mapcount--;
+			continue;
 		}
 
 		if (pvmw.pte) {
@@ -842,6 +859,23 @@ static bool folio_referenced_one(struct folio *folio,
 		pra->mapcount--;
 	}
 
+	if ((vma->vm_flags & VM_LOCKED) &&
+			folio_test_large(folio) &&
+			folio_within_vma(folio, vma)) {
+		unsigned long s_align, e_align;
+
+		s_align = ALIGN_DOWN(start, PMD_SIZE);
+		e_align = ALIGN_DOWN(start + folio_size(folio) - 1, PMD_SIZE);
+
+		/* folio doesn't cross page table boundary and fully mapped */
+		if ((s_align == e_align) && (ptes == folio_nr_pages(folio))) {
+			/* Restore the mlock which got missed */
+			mlock_vma_folio(folio, vma);
+			pra->vm_flags |= VM_LOCKED;
+			return false; /* To break the loop */
+		}
+	}
+
 	if (referenced)
 		folio_clear_idle(folio);
 	if (folio_test_clear_young(folio))
@@ -1252,7 +1286,14 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
 			 folio);
 
-	mlock_vma_folio(folio, vma, compound);
+	/*
+	 * For large folio, only mlock it if it's fully mapped to VMA. It's
+	 * not easy to check whether the large folio is fully mapped to VMA
+	 * here. Only mlock normal 4K folio and leave page reclaim to handle
+	 * large folio.
+	 */
+	if (!folio_test_large(folio))
+		mlock_vma_folio(folio, vma);
 }
 
 /**
@@ -1352,7 +1393,9 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
-	mlock_vma_folio(folio, vma, compound);
+	/* See comments in page_add_anon_rmap() */
+	if (!folio_test_large(folio))
+		mlock_vma_folio(folio, vma);
 }
 
 /**
@@ -1463,7 +1506,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	 * it's only reliable while mapped.
 	 */
 
-	munlock_vma_folio(folio, vma, compound);
+	munlock_vma_folio(folio, vma);
 }
 
 /*
@@ -1524,7 +1567,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
 			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma, false);
+			if (!folio_test_large(folio))
+				mlock_vma_folio(folio, vma);
 			page_vma_mapped_walk_done(&pvmw);
 			ret = false;
 			break;
-- 
2.39.2

