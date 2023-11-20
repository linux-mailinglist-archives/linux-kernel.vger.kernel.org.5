Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31D57F159D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjKTOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKTOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:24:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8068CA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:24:26 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371801211"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371801211"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742740746"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="742740746"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.12.244])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:24:23 -0800
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm/memory: Use kmap_local_page() in __wp_page_copy_user()
Date:   Mon, 20 Nov 2023 15:24:05 +0100
Message-ID: <20231120142418.6977-1-fmdefrancesco@gmail.com>
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

From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>

kmap_atomic() has been deprecated in favor of kmap_local_{folio,page}.

Therefore, replace kmap_atomic() with kmap_local_page in
__wp_page_copy_user().

kmap_atomic() disables preemption in !PREEMPT_RT kernels and
unconditionally disables also page-faults. My limited knowledge of the
implementation of __wp_page_copy_user() makes me think that the latter
side effect is still needed here, but kmap_local_page() is implemented
not to disable page-faults.

So, in addition to the conversion to local mapping, add explicit
pagefault_disable() / pagefault_enable() between mapping and un-mapping.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 mm/memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..0ba63007c580 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2835,7 +2835,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	 * just copying from the original user address. If that
 	 * fails, we just zero-fill it. Live with it.
 	 */
-	kaddr = kmap_atomic(dst);
+	kaddr = kmap_local_page(dst);
+	pagefault_disable();
 	uaddr = (void __user *)(addr & PAGE_MASK);
 
 	/*
@@ -2903,7 +2904,8 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 pte_unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-	kunmap_atomic(kaddr);
+	pagefault_enable();
+	kunmap_local(kaddr);
 	flush_dcache_page(dst);
 
 	return ret;
-- 
2.42.0

