Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771E773646
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHHCLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjHHCK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:10:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A81711;
        Mon,  7 Aug 2023 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691460653; x=1722996653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0sX9zQ55/pnapaBgwBXw+8hFPy7SpHzYq+j/u0jVVw=;
  b=joHMlYxPWu5ShZUS3ILS82ZCwlpnmi4lVi9vegrtgdysZxfHyxdrnQ/D
   BgazzmrzTSeruioIdqjDbJ2m+SurGkS8iPoZpMBmyTePexgZhwskY8B11
   Bxlp/KKRbOgkunLaSF338P+TrHTdOD7+AZZ24CkASRQF7dx/gxMbMbQaW
   lh/TR72cOLj2VtPBe6gKCDuhvLP+CUuDM9qfZQewLtP9+Dqu6XPwdZEFm
   waVmeP0UbDZ7ekGPUU4LU4CqPQuMvAhd6afKPDBwDH/gUgCPHoiu4Cq1i
   IzZCjUIH3facI05fgHwNFaPgUMSbD7KQ16NKzkoVtir5m45n8/rgufyY/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373453505"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373453505"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 19:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977689341"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977689341"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2023 19:10:49 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, minchan@kernel.org, yuzhao@google.com,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v2 1/3] madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
Date:   Tue,  8 Aug 2023 10:09:15 +0800
Message-Id: <20230808020917.2230692-2-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808020917.2230692-1-fengwei.yin@intel.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
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

Commit 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range()
to use folios") replaced the page_mapcount() with folio_mapcount() to
check whether the folio is shared by other mapping.

It's not correct for large folio. folio_mapcount() returns the total
mapcount of large folio which is not suitable to detect whether the folio
is shared.

Use folio_estimated_sharers() which returns a estimated number of shares.
That means it's not 100% correct. It should be OK for madvise case here.

User-visible effects is that the THP is skipped when user call madvise.
But the correct behavior is THP should be split and processed then.

NOTE: this change is a temporary fix to reduce the user-visible effects
before the long term fix from David is ready.

Fixes: 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
Cc: stable@vger.kernel.org
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1d7933933e31..49af35e2d99a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -383,7 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -459,7 +459,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
-- 
2.39.2

