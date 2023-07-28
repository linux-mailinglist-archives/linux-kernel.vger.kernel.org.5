Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72A7671AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjG1QQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjG1QQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:16:04 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85274495;
        Fri, 28 Jul 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690560954; x=1722096954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BrOxNMR67qVjTh31EvN6swY79AWjbm/yuEvrka6JwLk=;
  b=Bx93Gn62Ao7K22b9ZrdhENFQp506SfkfJ1L4L+lpju0JXDcgR/5/M8ts
   R2705USmIZuvZiFKTfBk4foJCy3auz+Hpsp9kWwYPhisU1IRLzkq2mukB
   /BARqLL5DnuRTJ9GO7OQoHXAeBdHNyEYYgFn2INksHxEWlFRUKDHVA2/P
   WiDbgQs9ZrE17x6cUM/sUgPj5+e+HbPMu6iRqJQQ0efR2XvBQONdE6DH6
   GgZRwbKZpPnI5BWJLC6eEY3R1c1p+XFAB/FZjtWd7teyPdTrw4lWXFBFT
   9G2AD7My68B4w+hWoGTFDdioXPoPynN9Mhjiv7NkSIlEgW1mc+88OV7vT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="399566016"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="399566016"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="974142248"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="974142248"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2023 09:15:51 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, minchan@kernel.org, yuzhao@google.com,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 2/2] madvise: don't use mapcount() against large folio for sharing check
Date:   Sat, 29 Jul 2023 00:13:56 +0800
Message-Id: <20230728161356.1784568-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728161356.1784568-1-fengwei.yin@intel.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
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

The commits
98b211d6415f ("madvise: convert madvise_free_pte_range() to use
a folio")
fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to
use a folio")

replaced the page_mapcount() with folio_mapcount() to check whether
the folio is shared by other mapping.

But it's not correct for large folio. folio_mapcount() returns the
total mapcount of large folio which is not suitable to detect whether
the folio is shared.

Use folio_estimated_sharers() which returns a estimated number of
shares. That means it's not 100% correct. But it should be OK for
madvise case here.

Fixes: 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a folio")
Fixes: fc986a38b670 ("mm: huge_memory: convert madvise_free_huge_pmd to use a folio")
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Reviewed-by: Yu Zhao <yuzhao@google.com>
---
 mm/huge_memory.c | 2 +-
 mm/madvise.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..68c890875257 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1613,7 +1613,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_mapcount(folio) != 1)
+	if (folio_estimated_sharers(folio) != 1)
 		goto out;
 
 	if (!folio_trylock(folio))
diff --git a/mm/madvise.c b/mm/madvise.c
index 148b46beb039..55bdf641abfa 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -678,7 +678,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapcount(folio) != 1)
+			if (folio_estimated_sharers(folio) != 1)
 				break;
 			if (!folio_trylock(folio))
 				break;
-- 
2.39.2

