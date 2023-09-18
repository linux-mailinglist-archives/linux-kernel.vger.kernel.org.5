Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6A7A42D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbjIRHej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjIRHeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:34:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABEECFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695022419; x=1726558419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlfQoxCuP8sG2p4kkpY1b2EQ7BccGlB5GeB5heEQ4Is=;
  b=c9z2Ne3bcRPhO2tiwD5iKVAHOF6c45+YfA53xjhLFh4SDCHfiKFSZxPe
   B+SV7NUc0/ediSNOw4TDWjRBJmHO2Y6Ohrr/9ETZfpVOlKvGNX9DPP5ST
   iq8MnkC6UD7LmRMr2yx8AEndpAgwaCPsLPbFbDJxlSzsOWHXdBMwRzINt
   vB/Hah4RGmy2bgOXAnW9rUpBIBjPLjso0ZE4r+pRuNasLApzX0+76d1Yu
   0/bJHcL0f9ir0de7xuq4YX+d7Q3evAUq+LyRzhn6WOCVDErlqhDN3xFgl
   2AdzjCY+dLn7wOkBsVLZxNIWPEf+ny9jjRMu4aF2fB6BjxIMDiMWKnEIU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="465932097"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="465932097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="888929628"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="888929628"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by fmsmga001.fm.intel.com with ESMTP; 18 Sep 2023 00:32:52 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v3 1/3] mm: add functions folio_in_range() and folio_within_vma()
Date:   Mon, 18 Sep 2023 15:33:16 +0800
Message-Id: <20230918073318.1181104-2-fengwei.yin@intel.com>
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

It will be used to check whether the folio is mapped to specific
VMA and whether the mapping address of folio is in the range.

Also a helper function folio_within_vma() to check whether folio
is in the range of vma based on folio_in_range().

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/internal.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 346d82260964..9e2a5b32c659 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -587,6 +587,56 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
+
+/*
+ * NOTE: This function can't tell whether the folio is "fully mapped" in the
+ * range.
+ * "fully mapped" means all the pages of folio is associated with the page
+ * table of range while this function just check whether the folio range is
+ * within the range [start, end). Funcation caller nees to do page table
+ * check if it cares about the page table association.
+ *
+ * Typical usage (like mlock or madvise) is:
+ * Caller knows at least 1 page of folio is associated with page table of VMA
+ * and the range [start, end) is intersect with the VMA range. Caller wants
+ * to know whether the folio is fully associated with the range. It calls
+ * this function to check whether the folio is in the range first. Then checks
+ * the page table to know whether the folio is fully mapped to the range.
+ */
+static inline bool
+folio_within_range(struct folio *folio, struct vm_area_struct *vma,
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
+	return folio_within_range(folio, vma, vma->vm_start, vma->vm_end);
+}
+
 /*
  * mlock_vma_folio() and munlock_vma_folio():
  * should be called with vma's mmap_lock held for read or write,
-- 
2.39.2

