Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1F7664F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjG1HMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjG1HLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:11:41 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725C422A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690528285; x=1722064285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSd/zYXrNe6G/TyNoyJX1Y9vNt38Z30KKrdYuOwbs5U=;
  b=CmWMzXSya3FiCkiG8mzrdvN0iFs90cJ8ROVs5FRo5iLfz6PWlkgSF5Ib
   A8I19dv+qsA9SUjiUn/T1VfdW79yARTyWkC7rWIkOE69VMkTWwxdkD2Fh
   F/5ZYAg7zrfX+tgWuga/5hcKFiO/3RYQDra02LdeVNC3mqYzAZq2hQMxX
   kuOtJyg71uJ+iq7d7zqpWxKucXifVw2Euh2BqY2EIHpoNOY3E8dHJ15KH
   DV2Azwp92TzsVZ2olXQ8+CxJvLFokvEqJDNaRh0NhTe+V8xl8ArKz+6yI
   pENssW5TV5//fIN/7/P7ubIJXiMfiTvhfxqLxr2bk3wKBuAKIiq+YnRMB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454888196"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454888196"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="721162102"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="721162102"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 00:11:22 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com,
        hughd@google.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 2/3] mm: handle large folio when large folio in VM_LOCKED VMA range
Date:   Fri, 28 Jul 2023 15:09:28 +0800
Message-Id: <20230728070929.2487065-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728070929.2487065-1-fengwei.yin@intel.com>
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

For the large folio which cross the boundary of VM_LOCKED VMA,
we'd better not to mlock it. So if the system is under memory
pressure, this kind of large folio will be split and the pages
ouf of VM_LOCKED VMA can be reclaimed.

for page_add_anon_rmap() and page_add_file_rmap(), we only mlock
the folio if it's not large folio. The reason to do so is that
these functions can be called couple of times for a large folio
and each call just covered piece of large folio. If folio is
mlocked multiple time, the folio->mlock_count can be imbalance.
Delay the folio mlock to page reclaim phase. As only mlock folio
once for sure in page reclaim phase.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 18 +++++++++---------
 mm/rmap.c     | 27 ++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 63de32154a48..6c6fb1f3e4c1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,14 +662,10 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
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
+			struct vm_area_struct *vma, pte_t *pte)
 {
 	/*
 	 * The VM_SPECIAL check here serves two purposes.
@@ -680,16 +676,20 @@ static inline void mlock_vma_folio(struct folio *folio,
 	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
 	 */
 	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
-	    (compound || !folio_test_large(folio)))
+	    folio_within_vma(folio, vma, pte))
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
+	 * To handle the case that a mlocked large folio is unmapped from VMA
+	 * piece by piece, allow munlock the large folio which is partially
+	 * mapped to VMA.
+	 */
+	if (unlikely(vma->vm_flags & VM_LOCKED))
 		munlock_folio(folio);
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 54124f18e0e4..1d8f048fbed8 100644
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
@@ -811,10 +812,22 @@ static bool folio_referenced_one(struct folio *folio,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if ((vma->vm_flags & VM_LOCKED) &&
-		    (!folio_test_large(folio) || !pvmw.pte)) {
+		if (vma->vm_flags & VM_LOCKED) {
+			if (!folio_within_vma(folio, vma, pvmw.pte)) {
+				/*
+				 * For large folio cross VMA boundaries, it's
+				 * expected to be picked  by page reclaim. But
+				 * should skip reference of pages which are in
+				 * the range of VM_LOCKED vma. As page reclaim
+				 * should just count the reference of pages out
+				 * the range of VM_LOCKED vma.
+				 */
+				pra->mapcount--;
+				continue;
+			}
+
 			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma, !pvmw.pte);
+			mlock_vma_folio(folio, vma, pvmw.pte);
 			page_vma_mapped_walk_done(&pvmw);
 			pra->vm_flags |= VM_LOCKED;
 			return false; /* To break the loop */
@@ -1253,7 +1266,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 			__page_check_anon_rmap(folio, page, vma, address);
 	}
 
-	mlock_vma_folio(folio, vma, compound);
+	mlock_vma_folio(folio, vma, NULL);
 }
 
 /**
@@ -1344,7 +1357,7 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
-	mlock_vma_folio(folio, vma, compound);
+	mlock_vma_folio(folio, vma, NULL);
 }
 
 /**
@@ -1383,7 +1396,7 @@ static void __remove_rmap_finish(struct folio *folio,
 	 * it's only reliable while mapped.
 	 */
 
-	munlock_vma_folio(folio, vma, compound);
+	munlock_vma_folio(folio, vma);
 }
 
 /**
@@ -1557,7 +1570,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
 			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma, false);
+			mlock_vma_folio(folio, vma, pvmw.pte);
 			page_vma_mapped_walk_done(&pvmw);
 			ret = false;
 			break;
-- 
2.39.2

