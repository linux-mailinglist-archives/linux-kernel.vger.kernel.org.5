Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496875FB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGXP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGXP5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:57:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635758E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690214236; x=1721750236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ECnmIZRK76SlIiCRyT4Ym1T9771ErnINKZxbxO8WZEg=;
  b=c9b8WnCZcpx1uUmgijjDcZWGLljABRam9TxdJRg8LuOO52/m5pXhSulS
   Ioi0LvEO1MHW5VEndrEG6fiAG1IFSXMb3kZG8yLrs9o/cVREKuR9ibmog
   0zPVfX5Nv3eUB9Mt2nLHRrXE3Zl2NJ23heh7fpWkrz9Z/GwJuaGeOtEU3
   y6JGNWimdC2sSHBtpYvx1OOJRf44Tbnlq6lLZZzoWIg2LztsxkW71Frks
   KOmhDUa796Law1A2FK3ax6UNIoUXrpaNF/ZOqBVYWl0757urIzWchOfvR
   oGKaKadXJrsrsdCC89/gRwH+pAfkxp1MfQUW+3PmyOLb+5aSu323XYzna
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357478799"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="357478799"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 08:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="725770275"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="725770275"
Received: from asmaaabd-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 08:57:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9A2ED103A25; Mon, 24 Jul 2023 18:57:10 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yingcong Wu <yingcong.wu@intel.com>
Subject: [PATCH] x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
Date:   Mon, 24 Jul 2023 18:57:06 +0300
Message-ID: <20230724155706.29900-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yingcong has noticed that on 5-level paging machine VDSO and VVAR VMAs
are placed above 47-bit border:

8000001a9000-8000001ad000 r--p 00000000 00:00 0                          [vvar]
8000001ad000-8000001af000 r-xp 00000000 00:00 0                          [vdso]

It might confused users who not aware about 5-level paging and expect
all userspace addresses to be under 47-bit border.

So far I only saw it triggered with ASLR disabled, but I guess it can be
also triggered with ASLR enabled if the layout gets randomized just right.

The problem happens due to custom placement for the VMAs in the VDSO
code: vdso_addr() tries to place them above stack and checks the result
against TASK_SIZE_MAX which is wrong. TASK_SIZE_MAX set to 56-bit border
on 5-level paging machines. Use DEFAULT_MAP_WINDOW instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Yingcong Wu <yingcong.wu@intel.com>
Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
---
 arch/x86/entry/vdso/vma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 11a5c68d1218..7645730dc228 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -299,8 +299,8 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 
 	/* Round the lowest possible end address up to a PMD boundary. */
 	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= TASK_SIZE_MAX)
-		end = TASK_SIZE_MAX;
+	if (end >= DEFAULT_MAP_WINDOW)
+		end = DEFAULT_MAP_WINDOW;
 	end -= len;
 
 	if (end > start) {
-- 
2.41.0

