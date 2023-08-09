Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1E7762DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjHIOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjHIOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:46:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBE2110;
        Wed,  9 Aug 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691592378; x=1723128378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nat6JIpKlbNyaE2SmtvG1qRCszoGjlyVBGDav8zdJFs=;
  b=BBovHaA8b6u5OGs6B2AXPziLc9QFSB8FJ/iiT9pvhDj7h/gul2Ci2eHg
   UMAlYjAdULgGJJA4hblimEThnXofy/6hzGv0HL0iOQjTkXjHwd5FKm+14
   SuYQCSWLuACCVwNXnj+Rm2FbloTXiXq537Qtr4HX2vqX3M3iyyjzObAF5
   ZW4v4rbY1yCTsOarUzMv0FKH5LR3fnVXjc5hmZnwGYppDUcSPw9cLpWxJ
   xZBsJOCBtdRJXGZpA8klIvEoTqSxHX9rHc8a+fn10cPiSW15pxpEuCQ0O
   vh4mN04lnclRWPI664VooVKAMGewMaFUynudz7dHNfMWVKnVlGRtQcLy7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371127925"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="371127925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905676169"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="905676169"
Received: from jmhendri-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.40.58])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 07:46:11 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8E85310A257; Wed,  9 Aug 2023 17:46:07 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christina Schimpe <christina.schimpe@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
Date:   Wed,  9 Aug 2023 17:46:00 +0300
Message-ID: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GDB uses /proc/PID/mem to access memory of the target process. GDB
doesn't untag addresses manually, but relies on kernel to do the right
thing.

mem_rw() of procfs uses access_remote_vm() to get data from the target
process. It worked fine until recent changes in __access_remote_vm()
that now checks if there's VMA at target address using raw address.

Untag the address before looking up the VMA.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Christina Schimpe <christina.schimpe@intel.com>
Fixes: eee9c708cc89 ("gup: avoid stack expansion warning for known-good case")
Cc: stable@vger.kernel.org
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..3be9db30db32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5701,6 +5701,9 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 	if (mmap_read_lock_killable(mm))
 		return 0;
 
+	/* Untag the address before looking up the VMA */
+	addr = untagged_addr_remote(mm, addr);
+
 	/* Avoid triggering the temporary warning in __get_user_pages */
 	if (!vma_lookup(mm, addr) && !expand_stack(mm, addr))
 		return 0;
-- 
2.41.0

