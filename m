Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8089777529F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHIGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjHIGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:13:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5B1FC2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691561592; x=1723097592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGJZorJ3E6t3J456VFnC+I2HIJq1tAE/jnA+v0QWpWc=;
  b=Hr2JpL1caYU705SMZJSn6bm/iZhOlO5AAPLcbuD9xr8OjXbu1EDWlpOa
   AIhx26qSfqQb7ymCNu2QitQOD7DuJ5ahaNVNAQmQWeuL3vsdRJG6GK8oY
   GStsYhvXugcLtMGkWpc3FLRLEVHC9juAVCGeSoa4aqipIzoyegtYHODAx
   Fxi/1rEu/QHs2y0svmyO4UgMxotEmf31pcGTrcb9mqyK2ryQFqJ8WUXIz
   teoIIg+2RBhczlBhDXZJfflyK06A759GI38W83KIRRFCidq7QBHJiV7KY
   mp5hECwR1JV6xy9EWIkIBH42w0QD9zC22PTrgDQulZve8zQnBj31iuNh7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457410065"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="457410065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731680634"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="731680634"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2023 23:13:08 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle large folio
Date:   Wed,  9 Aug 2023 14:11:05 +0800
Message-Id: <20230809061105.3369958-4-fengwei.yin@intel.com>
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

Current kernel only lock base size folio during mlock syscall.
Add large folio support with following rules:
  - Only mlock large folio when it's in VM_LOCKED VMA range
    and fully mapped to page table.

    fully mapped folio is required as if folio is not fully
    mapped to a VM_LOCKED VMA, if system is in memory pressure,
    page reclaim is allowed to pick up this folio, split it
    and reclaim the pages which are not in VM_LOCKED VMA.

  - munlock will apply to the large folio which is in VMA range
    or cross the VMA boundary.

    This is required to handle the case that the large folio is
    mlocked, later the VMA is split in the middle of large folio.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/mlock.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 06bdfab83b58..1da1996745e7 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -305,6 +305,58 @@ void munlock_folio(struct folio *folio)
 	local_unlock(&mlock_fbatch.lock);
 }
 
+static inline unsigned int folio_mlock_step(struct folio *folio,
+		pte_t *pte, unsigned long addr, unsigned long end)
+{
+	unsigned int count, i, nr = folio_nr_pages(folio);
+	unsigned long pfn = folio_pfn(folio);
+	pte_t ptent = ptep_get(pte);
+
+	if (!folio_test_large(folio))
+		return 1;
+
+	count = pfn + nr - pte_pfn(ptent);
+	count = min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
+
+	for (i = 0; i < count; i++, pte++) {
+		pte_t entry = ptep_get(pte);
+
+		if (!pte_present(entry))
+			break;
+		if (pte_pfn(entry) - pfn >= nr)
+			break;
+	}
+
+	return i;
+}
+
+static inline bool allow_mlock_munlock(struct folio *folio,
+		struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned int step)
+{
+	/*
+	 * For unlock, allow munlock large folio which is partially
+	 * mapped to VMA. As it's possible that large folio is
+	 * mlocked and VMA is split later.
+	 *
+	 * During memory pressure, such kind of large folio can
+	 * be split. And the pages are not in VM_LOCKed VMA
+	 * can be reclaimed.
+	 */
+	if (!(vma->vm_flags & VM_LOCKED))
+		return true;
+
+	/* folio not in range [start, end), skip mlock */
+	if (!folio_in_range(folio, vma, start, end))
+		return false;
+
+	/* folio is not fully mapped, skip mlock */
+	if (step != folio_nr_pages(folio))
+		return false;
+
+	return true;
+}
+
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 			   unsigned long end, struct mm_walk *walk)
 
@@ -314,6 +366,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *start_pte, *pte;
 	pte_t ptent;
 	struct folio *folio;
+	unsigned int step = 1;
+	unsigned long start = addr;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -334,6 +388,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
+
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
 		if (!pte_present(ptent))
@@ -341,12 +396,19 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
-		if (folio_test_large(folio))
-			continue;
+
+		step = folio_mlock_step(folio, pte, addr, end);
+		if (!allow_mlock_munlock(folio, vma, start, end, step))
+			goto next_entry;
+
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
 			munlock_folio(folio);
+
+next_entry:
+		pte += step - 1;
+		addr += (step - 1) << PAGE_SHIFT;
 	}
 	pte_unmap(start_pte);
 out:
-- 
2.39.2

