Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D497F15AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjKTO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjKTO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:28:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95EAA0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700490523; x=1732026523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wXfYH9PEJHi5SE6jMxUu9uOPBnqBdEjEY0c0DJLAYZY=;
  b=NpEmC0BpHwAGvVNTwP2NVDIotU9nTHdQUxMUZ+QEaV73LOVL8OYomuHS
   DTJXKiaMR12Rk9JjevjZYtQo+eqtjObHGpnThnIh5HAA6AOiw8Om7KVo3
   3cFhe2fbxLTO3L0/lM35ZmmEjLydY052gkNfPo7i2JtkQSKMpkPKtjkw8
   AOO+KFQSwxTiC99pEeSg9C5Ygyyoh3nkBS3HMjgT3YKtUu3yfY+dtvEnx
   ncm5VXE9xGU1ORi1qNZxHDSPiXMGRKRHRPwEOqGctC6EuT3KssCwASEmf
   oFocns88ZPxJvnN5dHpUejInjXso7fRwkIsxoBzKP9MStsbnhOd0CI7Q2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390485710"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="390485710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:28:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097758447"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1097758447"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.12.244])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:28:41 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm/page_poison: Replace kmap_atomic() with kmap_local_page()
Date:   Mon, 20 Nov 2023 15:28:23 +0100
Message-ID: <20231120142836.7219-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap_atomic() with kmap_local_page().

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

The code blocks between the mappings and un-mappings do not rely on the
above-mentioned side effects of kmap_atomic(), so that mere replacements
of the old API with the new one is all that they require (i.e., there is
no need to explicitly call pagefault_disable() and/or preempt_disable()).

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 mm/page_poison.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index b4f456437b7e..3e9037363cf9 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -21,13 +21,13 @@ early_param("page_poison", early_page_poison_param);
 
 static void poison_page(struct page *page)
 {
-	void *addr = kmap_atomic(page);
+	void *addr = kmap_local_page(page);
 
 	/* KASAN still think the page is in-use, so skip it. */
 	kasan_disable_current();
 	memset(kasan_reset_tag(addr), PAGE_POISON, PAGE_SIZE);
 	kasan_enable_current();
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 
 void __kernel_poison_pages(struct page *page, int n)
@@ -77,7 +77,7 @@ static void unpoison_page(struct page *page)
 {
 	void *addr;
 
-	addr = kmap_atomic(page);
+	addr = kmap_local_page(page);
 	kasan_disable_current();
 	/*
 	 * Page poisoning when enabled poisons each and every page
@@ -86,7 +86,7 @@ static void unpoison_page(struct page *page)
 	 */
 	check_poison_mem(page, kasan_reset_tag(addr), PAGE_SIZE);
 	kasan_enable_current();
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 }
 
 void __kernel_unpoison_pages(struct page *page, int n)
-- 
2.42.0

