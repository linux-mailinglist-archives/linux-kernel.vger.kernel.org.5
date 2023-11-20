Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F50A7F156C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjKTOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:16:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE8A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:16:11 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458122911"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458122911"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="759795431"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="759795431"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.12.244])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:16:05 -0800
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Fabio De Francesco <fabio.maria.de.francesco@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: [PATCH] mm/util: Use kmap_local_page() in memcmp_pages()
Date:   Mon, 20 Nov 2023 15:15:27 +0100
Message-ID: <20231120141554.6612-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL,
        SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio De Francesco <fabio.maria.de.francesco@intel.com>

kmap_atomic() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap_atomic() with kmap_local_page() in
memcmp_pages().

kmap_atomic() is implemented like a kmap_local_page() which also
disables page-faults and preemption (the latter only in !PREEMPT_RT
kernels). The kernel virtual addresses returned by these two API are
only valid in the context of the callers (i.e., they cannot be handed to
other threads).

With kmap_local_page() the mappings are per thread and CPU local like
in kmap_atomic(); however, they can handle page-faults and can be called
from any context (including interrupts). The tasks that call
kmap_local_page() can be preempted and, when they are scheduled to run
again, the kernel virtual addresses are restored and are still valid.

In memcmp_pages(), the block of code between the mapping and un-mapping
does not depend on the above-mentioned side effects of kmap_aatomic(), so
that mere replacements of the old API with the new one is all that is
required (i.e., there is no need to explicitly call pagefault_disable()
and/or preempt_disable()).

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 mm/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 744b4d7e3fae..5a6a9802583b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1047,11 +1047,11 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 	char *addr1, *addr2;
 	int ret;
 
-	addr1 = kmap_atomic(page1);
-	addr2 = kmap_atomic(page2);
+	addr1 = kmap_local_page(page1);
+	addr2 = kmap_local_page(page2);
 	ret = memcmp(addr1, addr2, PAGE_SIZE);
-	kunmap_atomic(addr2);
-	kunmap_atomic(addr1);
+	kunmap_local(addr2);
+	kunmap_local(addr1);
 	return ret;
 }
 
-- 
2.42.0

