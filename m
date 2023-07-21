Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358E575C340
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjGUJl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGUJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1630F1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932495; x=1721468495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AU+Bax7o8AGRnodMI5F/Lc+z+q2VSKWl4dvqmzGnJLE=;
  b=iZMfpCQs0IQzGDYY5PTn/Emw2jQjTzz9N9j8O1n1BgCpio0lOgQuzTMb
   JcodfBT+obN1a6x7YdnLkPGE5i++HaYfnNJFkk+x4FMt7O++IK6lbMFvJ
   xjQDL1N88rp5CrhoxucYfqHme/NBv3CDcNw7gAz3WgDN8mg+WphcxbBGs
   kp3aPxjCLUTno9S8J0Ha/+NpRwWHFtrYWVHoknrX3TiERjat8lKofER/L
   j/Fl6EWOZcUaoJ8d53fWbQ50PlekX9tCdvhsj5Q64K6JnqPLUe1/uxBPD
   ACx1p6aEIF06uFHdmGy+wh5amNrNtusHFU3rE03AOsfYpWPaKuoRRCe9B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397874321"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="397874321"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898661109"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898661109"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 02:40:46 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, yuzhao@google.com,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 1/4] madvise: not use mapcount() against large folio for sharing check
Date:   Fri, 21 Jul 2023 17:40:40 +0800
Message-Id: <20230721094043.2506691-2-fengwei.yin@intel.com>
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

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/madvise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 38382a5d1e39..f12933ebcc24 100644
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
@@ -682,7 +682,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (!folio_trylock(folio))
 				break;
-- 
2.39.2

