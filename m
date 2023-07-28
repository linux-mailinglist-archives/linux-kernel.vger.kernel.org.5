Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557237671B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjG1QRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjG1QRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:17:00 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36B24203;
        Fri, 28 Jul 2023 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690561019; x=1722097019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yoKWUZ9b4nmnub08HwQjvgeLWWLSNJ2JgO+gF3lpB1A=;
  b=CZcI4X1U8P7Y6XJO6xlGSXHGlQMiHD9rPNZck58FSN8nncAFQQMgbmNu
   jCISWaFwMwgvLPUP+hmKqe35kblQjHtdteADtbFuReEKvkJWrr94Oymjy
   oyT1nSK8XXpsJoN9xK4HC9/fRSb3MGMb0BwbzkZka/bxsBiOF7lvSiEdc
   PtKYrjyUHtNME3H+5vtvgg7VTJ/VdHY2wrNXNz0f4j5eP0cLC/bH0EK2d
   3nm+SS6qblhRxb56LOaXRPF5NveRN33gS4bMOSs5SK7GdDRi9JBjjlGHk
   eyH5NjazktxjQErFjc1xqUld33Tq9KWmSOmHliXE4X3HXPRFY7Ffp1KIP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432442967"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432442967"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851267434"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851267434"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 09:15:35 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, minchan@kernel.org, yuzhao@google.com,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 1/2] madvise: don't use mapcount() against large folio for sharing check
Date:   Sat, 29 Jul 2023 00:13:55 +0800
Message-Id: <20230728161356.1784568-2-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728161356.1784568-1-fengwei.yin@intel.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
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

The commit
07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to
use folios") replaced the page_mapcount() with folio_mapcount() to
check whether the folio is shared by other mapping.

But it's not correct for large folio. folio_mapcount() returns the
total mapcount of large folio which is not suitable to detect whether
the folio is shared.

Use folio_estimated_sharers() which returns a estimated number of
shares. That means it's not 100% correct. But it should be OK for
madvise case here.

Fixes: 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Yu Zhao <yuzhao@google.com>
---
 mm/madvise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 886f06066622..148b46beb039 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -383,7 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapcount(folio) != 1)
+		if (folio_estimated_sharers(folio) != 1)
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -457,7 +457,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
-- 
2.39.2

