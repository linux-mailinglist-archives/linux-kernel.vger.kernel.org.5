Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AA7664EF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjG1HL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjG1HLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:11:32 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF03C2F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690528273; x=1722064273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hDGtd2tgXIan13dy2PEKZ68DXcw4gSjf8pK8pQRP1gI=;
  b=Lg3rd+VevH6UWHbFj1yVn/9CjWW7Et/34lbFAdqH9mGZTzT5/xz1muVe
   qnhPUDWwa3879cXvwmP6fykEMsWRTSHcQOs8qivWB/ivY3UPEJdOpNTqk
   THRtKEqR8f/XRla9fuBXhtHwfp/kqh9//PihcbjgbHHIOpuX4fvIYx+CN
   AshUlA3bZM4HIRs96y7S7uxHbd/3dDKRota7O6CJwuchoEJHjJLChgXd7
   7BtZPrWu+dYA62kOu1YNSxUNE5I8Yg4Zmd/N68duglT3jTRHPMmKcEvrE
   N2e56q3QwACogrTBs1DAXLTH+GoESJn/KJMxVVmw6NikvI4igLQTHHlwk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454888119"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="454888119"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="721161998"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="721161998"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 00:11:08 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com,
        hughd@google.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 1/3] mm: add functions folio_in_range() and folio_within_vma()
Date:   Fri, 28 Jul 2023 15:09:27 +0800
Message-Id: <20230728070929.2487065-2-fengwei.yin@intel.com>
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

It will be used to check whether the folio is mapped to specific
VMA and whether the mapping address of folio is in the range.

Also a helper function folio_within_vma() to check whether folio
is in the range of vma based on folio_in_range().

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 5a03bc4782a2..63de32154a48 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
+
+/*
+ * Check whether the folio is in specific range
+ *
+ * First, check whether the folio is in the range of vma.
+ * Then, check whether the folio is mapped to the range of [start, end].
+ * In the end, check whether the folio is fully mapped to the range.
+ *
+ * @pte page table pointer will be checked whether the large folio
+ *      is fully mapped to. Currently, if mremap in the middle of
+ *      large folio, the large folio could be mapped to to different
+ *      VMA and address check can't identify this situation.
+ */
+static inline bool
+folio_in_range(struct folio *folio, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, pte_t *pte)
+{
+	pte_t ptent;
+	unsigned long i, nr = folio_nr_pages(folio);
+	pgoff_t pgoff, addr;
+	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
+
+	if (start < vma->vm_start)
+		start = vma->vm_start;
+	if (end > vma->vm_end)
+		end = vma->vm_end;
+
+	pgoff = folio_pgoff(folio);
+	/* if folio start address is not in vma range */
+	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
+		return false;
+
+	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	if (addr < start || end - addr < folio_size(folio))
+		return false;
+
+	/* not necessary to check pte for none large folio */
+	if (!folio_test_large(folio))
+		return true;
+
+	if (!pte)
+		return false;
+
+	/* check whether parameter pte is associated with folio */
+	ptent = ptep_get(pte);
+	if (pte_none(ptent) || !pte_present(ptent) ||
+			pte_pfn(ptent) - folio_pfn(folio) >= nr)
+		return false;
+
+	pte -= pte_pfn(ptent) - folio_pfn(folio);
+	for (i = 0; i < nr; i++, pte++) {
+		ptent = ptep_get(pte);
+
+		if (pte_none(ptent) || !pte_present(ptent) ||
+				pte_pfn(ptent) - folio_pfn(folio) >= nr)
+			return false;
+	}
+
+	return true;
+}
+
+static inline bool
+folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
+{
+	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
+}
+
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
-- 
2.39.2

