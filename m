Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAD77529E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHIGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHIGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:12:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814CB1BFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691561578; x=1723097578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fb4ma1U7pPZ93GdCuAzqiSTIky7nmfYMnw9psMcatoY=;
  b=b4vGX4HsVOD8V/6kHpqiO72ng9e88cYc6I9Wi9mLwFzugaZa99WU8PTW
   v+LKTZbuH0UKkASU84Mn59bX7DapwDnCCX3vmMhoC/wsD5988JAVjOj9C
   cIYOhTKGT7JnZ+XL6bjnqoe44UJi8hB7J1e4ZqYMKKTvIkuMLKsmDqLa9
   qybJLje8bA8w2z6oHVj9XzmOMyQGKpJtjJzdSPBeCaxSQdlhiAvT5Oe5A
   LuSncL44moth8EcL8PAj6Jq26eCKu+ZymnVvx/rkfo84kutavCK20FbTv
   h4prksyVvT14cL7ndjQjtak7w7BuuNAaW1h+VLEmpQ4k3xxnXsl+QKNbI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457410052"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="457410052"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731680568"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="731680568"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2023 23:12:54 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v2 2/3] mm: handle large folio when large folio in VM_LOCKED VMA range
Date:   Wed,  9 Aug 2023 14:11:04 +0800
Message-Id: <20230809061105.3369958-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809061105.3369958-1-fengwei.yin@intel.com>
References: <20230809061105.3369958-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 5d1b71010fd2..b14fb2d8b04c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -628,14 +628,10 @@ folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
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
@@ -645,17 +641,24 @@ static inline void mlock_vma_folio(struct folio *folio,
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
index 3c20d0d79905..dae0443e9ab0 100644
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
@@ -1260,7 +1294,14 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 			__page_check_anon_rmap(folio, page, vma, address);
 	}
 
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
 
 void folio_add_new_anon_rmap_range(struct folio *folio,
@@ -1371,7 +1412,9 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
 
-	mlock_vma_folio(folio, vma, compound);
+	/* See comments in page_add_anon_rmap() */
+	if (!folio_test_large(folio))
+		mlock_vma_folio(folio, vma);
 }
 
 /**
@@ -1482,7 +1525,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 	 * it's only reliable while mapped.
 	 */
 
-	munlock_vma_folio(folio, vma, compound);
+	munlock_vma_folio(folio, vma);
 }
 
 /*
@@ -1543,7 +1586,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
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

