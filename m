Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2E812A13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjLNIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjLNIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:10:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF796B9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702541448; x=1734077448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i8XSla6hrQt6zIq4G6Aba+318oa4y1bEQ+Pf+qR2Hcw=;
  b=ifgF2mMQjm0yl9A2LX2LdpNODtvgS7BZvj7pTxpgP/makPRUeLqwTLkb
   +PY6uBjZbAhUb2Q441jfPard2lkTLO7HcuzX/u4YZRCBipLadjlqmnZlI
   QjUCJ07gO1w2aiOMjHzkz4UD0GAF+QaiOSG19dWVUPnzjaIciVNyGv1Ss
   +jIzFYAimFjidPw5M7DYB8BZojWYVbjgaTDRHpJyv9SsTXph00ygRv+E8
   KKj+iDh+ubD7WjTV0Zh/Gt4lhuDJWvCnk05g+3fO88a1RDrwdOJ/IyFC9
   TCG94d7uacgaDlsIspaAm66+qPXGzIhl4jP+Ga4PLwZe7mRUP39bo5MYP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1903236"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1903236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803191192"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803191192"
Received: from mrejmak-mobl.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.24.154])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:10:45 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Date:   Thu, 14 Dec 2023 09:10:04 +0100
Message-ID: <20231214081039.1919328-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>

kmap() has been deprecated in favor of kmap_local_page().

Therefore, replace kmap() with kmap_local_page() in mm/memory.c.

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page-faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. The tasks can
be preempted and, when they are scheduled to run again, the kernel
virtual addresses are restored and still valid.

Obviously, thread locality implies that the kernel virtual addresses
returned by kmap_local_page() are only valid in the context of the
callers (i.e., they cannot be handed to other threads).

The use of kmap_local_page() in mm/memory.c does not break the
above-mentioned assumption, so it is allowed and preferred.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 mm/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7d9f6b685032..88377a107fbe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5852,7 +5852,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (bytes > PAGE_SIZE-offset)
 				bytes = PAGE_SIZE-offset;
 
-			maddr = kmap(page);
+			maddr = kmap_local_page(page);
 			if (write) {
 				copy_to_user_page(vma, page, addr,
 						  maddr + offset, buf, bytes);
@@ -5861,8 +5861,7 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				copy_from_user_page(vma, page, addr,
 						    buf, maddr + offset, bytes);
 			}
-			kunmap(page);
-			put_page(page);
+			unmap_and_put_page(page, maddr);
 		}
 		len -= bytes;
 		buf += bytes;
-- 
2.43.0

