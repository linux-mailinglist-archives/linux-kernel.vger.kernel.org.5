Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDB876EDCA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjHCPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjHCPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:16:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0066E77
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691075792; x=1722611792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/nVvtIp70+FSePc0879BDHNt5uW/EgkRqUTXM82sSno=;
  b=cWDWhnC3OUokidSSVHBK2/I17p1Wb/lbBqa19EnWSBqGTAvx4YZ2D2hg
   DvF4DKUSZ9qsQLcDKoo1al3AmKC5etHwlU7s2qcMXFaFbwhsLLaW7fLMQ
   SkaC3MSm1Wt84EUZdqQI9pqUJZaxmx2cVvO7Vch4B4bKOgXe4/QFtTkRl
   orujQH4R6J5wjWWhlQcbyZOc+kFtUYcpo6F2gHBpXJI5J7XG5yyFu5Lgj
   WLQzmCT3Mb5LeMJn0MD7YNl/Lf0ZP9Rg0T264rxMlZqaxZuFYa1QVvb9c
   1mgvZ3ogPPmk59G69vMZjapI0GqNzSx+JGcriMnvMEAIRdIa+8+kCu+5Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="354833962"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354833962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="903418183"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="903418183"
Received: from sosterlu-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.209.233])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:16:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CBB2E109FCF; Thu,  3 Aug 2023 18:16:13 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yingcong Wu <yingcong.wu@intel.com>
Subject: [PATCHv2] x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
Date:   Thu,  3 Aug 2023 18:16:09 +0300
Message-ID: <20230803151609.22141-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yingcong has noticed that on the 5-level paging machine, VDSO and VVAR
VMAs are placed above the 47-bit border:

8000001a9000-8000001ad000 r--p 00000000 00:00 0                          [vvar]
8000001ad000-8000001af000 r-xp 00000000 00:00 0                          [vdso]

This might confuse users who are not aware of 5-level paging and expect
all userspace addresses to be under the 47-bit border.

So far problem has only been triggered with ASLR disabled, although it
may also occur with ASLR enabled if the layout is randomized in a just
right way.

The problem happens due to custom placement for the VMAs in the VDSO
code: vdso_addr() tries to place them above the stack and checks the
result against TASK_SIZE_MAX, which is wrong. TASK_SIZE_MAX is set to
the 56-bit border on 5-level paging machines. Use DEFAULT_MAP_WINDOW
instead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Yingcong Wu <yingcong.wu@intel.com>
Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
---
v2:
 - Fix commit message: grammar and passive voice

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

