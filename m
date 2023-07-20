Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609275AE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGTM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGTM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:29:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53B268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856145; x=1721392145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjyKUSxUu0YbF2UY8xPw2MEYR5ARwiPrBkhlDv5TQjQ=;
  b=gyWrzxC0QZ6yPLcm6JHS5EmiVeEZDXNOAzkJ0okHucrsc748d0OgG3sx
   TYHOeBp9iFbVjcAWw/GnY1flsNK4IF5o/hPrnTqA0cmoLi/9cQUfm0L54
   hPvKIDjTEi5iKJiDcZKo+Rk0H/wWTpuKUKu+hmPtoD1mrVeh4ly56qRaK
   FEoPiHEh08uGkL0w+N1QpJzpQgG11GrYHENU6ptRUS2xY7euJ0gwK45OT
   3ZoxQ3oSieLib5MH/38m+DqNYccsXdMLaMWfb9iyOpQprqQydzcLANqo8
   mJHu8v35lRkbpt85DIx5/0kS/E2zb2ep7rWNcTCHenJ+Byn4+ptIdNS2s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356677999"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356677999"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255895"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255895"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:01 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 04/11] x86/tdx: Rename __tdx_module_call() to __tdcall()
Date:   Fri, 21 Jul 2023 00:28:07 +1200
Message-ID: <02c6899566deb107f1d8b0daa4f65bb5f2c103e8.1689855280.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689855280.git.kai.huang@intel.com>
References: <cover.1689855280.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---

v1 -> v2:
 - Rebase to 6.5-rc2.

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

