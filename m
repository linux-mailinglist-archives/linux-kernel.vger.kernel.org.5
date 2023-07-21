Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B075C341
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGUJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjGUJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F03A87
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932496; x=1721468496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cu8lT3oOEGsTcv6kJqkYTpbtDaklUJpbsDBtNyUKlKw=;
  b=NPdJMpy4bZwjJPH6rtVAZkrw5vcqK7ajUQhRNip187YeZL9tdrlc65wi
   LzODMzFZ2BUKDDwxntXdesEyCkLMfcbOmP9vv+KUneBK7Rq1zQ5JZFbB4
   QLoraSwsmD78ctusocsUV5OxANRBMmW4f8/dbCzhNTE3ipBxvZltFWU4E
   bfZd0lto9Hfyg7MPBQa5n7BqXg/ELhvvmVvIIgCFNk7GwBDbi+DNZjapj
   bAT992MXGIgGaLw1bMfzZikxqdjLfIDl2+PfKcY15AR6B7tFlZbtYXxIv
   vQ3ov33RAztM48nzSlFBQTrZ/aLlEWqluNIBSHe634PYX/zTynQmk7/yY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397874364"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="397874364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971386942"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971386942"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2023 02:40:59 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, yuzhao@google.com,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and flush page table entries
Date:   Fri, 21 Jul 2023 17:40:41 +0800
Message-Id: <20230721094043.2506691-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721094043.2506691-1-fengwei.yin@intel.com>
References: <20230721094043.2506691-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in function madvise_cold_or_pageout_pte_range(), the
young bit of pte/pmd is cleared notify subscripter.

Using notify-able API to make sure the subscripter is signaled about
the young bit clearing.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/madvise.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f12933ebcc24..b236e201a738 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 		}
 
-		if (pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
-			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-		}
-
+		pmdp_clear_flush_young_notify(vma, addr, pmd);
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
 		if (folio_test_active(folio))
@@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-		if (pte_young(ptent)) {
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			ptent = pte_mkold(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-		}
-
+		ptep_clear_flush_young_notify(vma, addr, pte);
 		/*
 		 * We are deactivating a folio for accelerating reclaiming.
 		 * VM couldn't reclaim the folio unless we clear PG_young.
-- 
2.39.2

