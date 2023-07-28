Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA87664F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjG1HMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjG1HLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:11:55 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECD3C03
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690528299; x=1722064299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MK9O8/4a3BabvdoGe2yFp5MoF/EC/SVzWLogYQWhbR8=;
  b=aziYUI/MWVRk6qA2oQFyB8mzvsJDyLXUXsOwfKI5A/gYSNC0sN8A4yAi
   ZcNLUxvNFj47TDg2dvJo9eaotmayzPKSfnPLThjG1c3zuHn43antlOCIk
   RLQiL1VNxqxWbswL5WMmh+ZgUbEDGJstQXNB0Xirki+AFBmw83Klgf9k1
   xWYlaWHleOUkr9t1WAwCjpLMyx4zYn61l2G5BTFu+G+bOYKcUJqsP+01U
   Jg0jMBAoGrakU1h7NWEmfg65xdlUutaBfcoDnflJbC17/iAj8F1RU341M
   woIjFveTSfyuh1xtEpQy7G2wqPZHydro/3nws36F7BlAQslGy95FQTM8E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454888240"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454888240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="721162234"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="721162234"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 00:11:35 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com,
        hughd@google.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 3/3] mm: mlock: update mlock_pte_range to handle large folio
Date:   Fri, 28 Jul 2023 15:09:29 +0800
Message-Id: <20230728070929.2487065-4-fengwei.yin@intel.com>
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

Current kernel only lock base size folio during mlock syscall.
Add large folio support with following rules:
  - Only mlock large folio when it's in VM_LOCKED VMA range
    and fully mapped to page table.

    fully mapped folio is required to handle the case that
    mremap happens in the middle of large folio and split
    pages of large folio to two different VMA.

  - munlock will apply to the large folio which is in VMA range
    or cross the VMA boundary.

    This is required to handle the case that the large folio is
    mlocked, later the VMA is split in the middle of large folio.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/mlock.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c21..8056f9176b70 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -305,6 +305,50 @@ void munlock_folio(struct folio *folio)
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
+	if (!pte)
+		return count;
+
+	for (i = 0; i < count; i++, pte++) {
+		pte_t entry = ptep_get(pte);
+
+		if (pte_none(entry) || !pte_present(entry))
+			break;
+		if (pte_pfn(entry) - pfn >= nr)
+			break;
+	}
+
+	return i;
+}
+
+static inline bool should_mlock_folio(struct folio *folio,
+				struct vm_area_struct *vma, pte_t *pte)
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
+	return !(vma->vm_flags & VM_LOCKED) ||
+			folio_within_vma(folio, vma, pte);
+}
+
 static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 			   unsigned long end, struct mm_walk *walk)
 
@@ -314,6 +358,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_t *start_pte, *pte;
 	pte_t ptent;
 	struct folio *folio;
+	unsigned int step = 1;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -334,6 +379,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
+
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
 		if (!pte_present(ptent))
@@ -341,12 +387,19 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
-		if (folio_test_large(folio))
-			continue;
+
+		step = folio_mlock_step(folio, pte, addr, end);
+		if (!should_mlock_folio(folio, vma, pte))
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

