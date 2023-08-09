Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982177529D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHIGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:12:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5CE1BF3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691561563; x=1723097563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KsgBZKiNNdVU9A9eEIcQRL879OD2WdX41NJw/witcyM=;
  b=fUFlKeopPGmCfmEs86Z3McO27wPCFyxaBspYLPg44SEQvj8iXhGXveYO
   ylPBFgo5wzIf/lUv0TNlFuylOBJoV8/bOEeDtxws1bkmSNytKau2a5EMv
   VirrNS08c67jBpzHMejirOQGN0wTB3dpGpHIoX9Ca4MVcP4i+asjCdDtR
   aZRbNmFhHBPBZEz+Aez1l48HDUdi+cDSauoEQoqGezm76vRof1tmJLAQs
   SZyPFITEs40iaXwQb55l932k6aDoo2ebdCPt82oEk2ANqIT1zWqZg2TRu
   TlwLXB/obCkGfZFWeaKPjU+l+YVMEjbT9A9D/RbZ8QC6sCOrZLmXynydo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="361159622"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="361159622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 23:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681553232"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="681553232"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 23:12:37 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v2 1/3] mm: add functions folio_in_range() and folio_within_vma()
Date:   Wed,  9 Aug 2023 14:11:03 +0800
Message-Id: <20230809061105.3369958-2-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809061105.3369958-1-fengwei.yin@intel.com>
References: <20230809061105.3369958-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 mm/internal.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 154da4f0d557..5d1b71010fd2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -585,6 +585,41 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
+
+static inline bool
+folio_in_range(struct folio *folio, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	pgoff_t pgoff, addr;
+	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+
+	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
+	if (start > end)
+		return false;
+
+	if (start < vma->vm_start)
+		start = vma->vm_start;
+
+	if (end > vma->vm_end)
+		end = vma->vm_end;
+
+	pgoff = folio_pgoff(folio);
+
+	/* if folio start address is not in vma range */
+	if (!in_range(pgoff, vma->vm_pgoff, vma_pglen))
+		return false;
+
+	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+
+	return !(addr < start || end - addr < folio_size(folio));
+}
+
+static inline bool
+folio_within_vma(struct folio *folio, struct vm_area_struct *vma)
+{
+	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end);
+}
+
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
-- 
2.39.2

