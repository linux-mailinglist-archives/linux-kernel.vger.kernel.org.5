Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455A77CB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjHOLDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjHOLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F7B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097353; x=1723633353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aU41zTMOi0OcoqQGhhkoosnRYdnzUgqsgizCGwT8EyQ=;
  b=CPPEqqAEdmedWWXk/pSGs3f+dJmuNr2PCqd4DkldcfSIjgrps/ZrZQOh
   9bfxGr1QhEmmuhwXtCxvdtRmcBcsaNlo2mjEYkKeA2/lK0FLse4NxOgqC
   5TgZrwklReXJh0oToMDQ81G9OgYhsxBFUkAxXhCh42A+nwTUrfFhiLg+H
   sI5SIos+3Hs1V5W6FuWgmkfhdERfXgLhVvUaTSBGpPoLHDXq8/eBSl/8R
   +QY6hE2OYFLjneHOhGuAYYU4Tlzfmok54wzlb6x2hKvUaTXLOlZEV5mzo
   dW7Wunki19KHOyj+UmKaATXIGKEiYkKxo3smcoq8wx2585B12nVQgTuD6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148293"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148293"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236132"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236132"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:29 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 04/12] x86/tdx: Rename __tdx_module_call() to __tdcall()
Date:   Tue, 15 Aug 2023 23:01:58 +1200
Message-ID: <785d20d99fbcd0db8262c94da6423375422d8c75.1692096753.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692096753.git.kai.huang@intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__tdx_module_call() is only used by the TDX guest to issue TDCALL to the
TDX module.  Rename it to __tdcall() to match its behaviour, e.g., it
cannot be used to make host-side SEAMCALL.

Also rename tdx_module_call() which is a wrapper of __tdx_module_call()
to tdcall().

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdcall.S        | 10 +++++-----
 arch/x86/coco/tdx/tdx-shared.c    |  2 +-
 arch/x86/coco/tdx/tdx.c           | 18 +++++++++---------
 arch/x86/include/asm/shared/tdx.h |  4 ++--
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index e5d4b7d8ecd4..6aebac08f2bf 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -40,8 +40,8 @@
 .section .noinstr.text, "ax"
 
 /*
- * __tdx_module_call()  - Used by TDX guests to request services from
- * the TDX module (does not include VMM services) using TDCALL instruction.
+ * __tdcall()  - Used by TDX guests to request services from the TDX
+ * module (does not include VMM services) using TDCALL instruction.
  *
  * Transforms function call register arguments into the TDCALL register ABI.
  * After TDCALL operation, TDX module output is saved in @out (if it is
@@ -62,7 +62,7 @@
  *
  *-------------------------------------------------------------------------
  *
- * __tdx_module_call() function ABI:
+ * __tdcall() function ABI:
  *
  * @fn  (RDI)          - TDCALL Leaf ID,    moved to RAX
  * @rcx (RSI)          - Input parameter 1, moved to RCX
@@ -77,9 +77,9 @@
  *
  * Return status of TDCALL via RAX.
  */
-SYM_FUNC_START(__tdx_module_call)
+SYM_FUNC_START(__tdcall)
 	TDX_MODULE_CALL host=0
-SYM_FUNC_END(__tdx_module_call)
+SYM_FUNC_END(__tdcall)
 
 /*
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index f10cd3e4a04e..90631abdac34 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -35,7 +35,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	}
 
 	tdcall_rcx = start | page_size;
-	if (__tdx_module_call(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
+	if (__tdcall(TDG_MEM_PAGE_ACCEPT, tdcall_rcx, 0, 0, 0, NULL))
 		return 0;
 
 	return accept_size;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 05785df66b1c..8c13944925e3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -66,10 +66,10 @@ EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
  * should only be used for calls that have no legitimate reason to fail
  * or where the kernel can not survive the call failing.
  */
-static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-				   struct tdx_module_output *out)
+static inline void tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+			  struct tdx_module_output *out)
 {
-	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
+	if (__tdcall(fn, rcx, rdx, r8, r9, out))
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
@@ -91,9 +91,9 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 {
 	u64 ret;
 
-	ret = __tdx_module_call(TDG_MR_REPORT, virt_to_phys(tdreport),
-				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
-				0, NULL);
+	ret = __tdcall(TDG_MR_REPORT, virt_to_phys(tdreport),
+			virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+			0, NULL);
 	if (ret) {
 		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
 			return -EINVAL;
@@ -152,7 +152,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
 	 */
-	tdx_module_call(TDG_VP_INFO, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_INFO, 0, 0, 0, 0, &out);
 
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
@@ -594,7 +594,7 @@ void tdx_get_ve_info(struct ve_info *ve)
 	 * Note, the TDX module treats virtual NMIs as inhibited if the #VE
 	 * valid flag is set. It means that NMI=>#VE will not result in a #DF.
 	 */
-	tdx_module_call(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
+	tdcall(TDG_VP_VEINFO_GET, 0, 0, 0, 0, &out);
 
 	/* Transfer the output parameters */
 	ve->exit_reason = out.rcx;
@@ -774,7 +774,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdx_module_call(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
+	tdcall(TDG_VM_WR, 0, TDCS_NOTIFY_ENABLES, 0, -1ULL, NULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 78f109446da6..9e3699b751ef 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -88,8 +88,8 @@ struct tdx_module_output {
 };
 
 /* Used to communicate with the TDX module */
-u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
-		      struct tdx_module_output *out);
+u64 __tdcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+	     struct tdx_module_output *out);
 
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
-- 
2.41.0

