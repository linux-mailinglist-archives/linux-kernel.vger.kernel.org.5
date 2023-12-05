Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB8805241
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442182AbjLELWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442137AbjLELVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:21:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080B197;
        Tue,  5 Dec 2023 03:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701775291; x=1733311291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MXczFK3xOQViMofjzuL8bjmZe4faEq58HCGtZP2g9c=;
  b=k8vPfu5C+ebCBXTQxHaQ5fm2tXhaANd4s5q49TtYRYJArFdmec8KC9G8
   b1rskdHKFrJRL6m0F59FeVRz2u2u0HhdKctLP5hgNCEH/JVgRASrzcWz+
   jj0g+bt8Q4A4Qi+FEPt4wf+GHjTEBWoycF7FKGPAX7qGBHh/f0TWxLiNi
   CBs6gDCDrSBdCo/I7YE8L7iWXIkvatkiz8D/ilDe8dBYEt/aXmQbwxJ6f
   7w0xYz0T6ilOmGxixO4YYZAjw5jgquWWXnoA7qzgNikSx759gLw1gxmqw
   RYD/HMAtg/Y8vlCPTkXomNIErwOw7fi+QNVAf0B8Vb++UmoA7I4TV69TR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="942555"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="942555"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018192972"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018192972"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 03:21:22 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, andrew.cooper3@citrix.com,
        jiangshanlai@gmail.com, nik.borisov@suse.com, shan.kang@intel.com
Subject: [PATCH v13 21/35] x86/fred: Make exc_page_fault() work for FRED
Date:   Tue,  5 Dec 2023 02:50:10 -0800
Message-ID: <20231205105030.8698-22-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205105030.8698-1-xin3.li@intel.com>
References: <20231205105030.8698-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

On a FRED system, the faulting address (CR2) is passed on the stack,
to avoid the problem of transient state.  Thus the page fault address
is read from the FRED stack frame instead of CR2 when FRED is enabled.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Change since v12:
* No "we" in a commit message, use passive voice (Borislav Petkov).
---
 arch/x86/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ab778eac1952..7675bc067153 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/fred.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1516,8 +1517,10 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
-	unsigned long address = read_cr2();
 	irqentry_state_t state;
+	unsigned long address;
+
+	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
 	prefetchw(&current->mm->mmap_lock);
 
-- 
2.43.0

