Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3261675AE63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGTM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGTM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:29:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298E2706
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856165; x=1721392165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=te56RLa+WPUJaVTq3uoJWXI6dxz98owIf9OhRDxCA4k=;
  b=MZOhj/Ph6VsLdD9K0LkMo/ojJZdRqUu0RcIX6I6mWXUp9NKte6kRHbov
   3NsriDSzoyuFzPDU/nO3W8SYTkB1aT/3mReGAKcnAwEXudW5ey5aVPhhe
   Zkrjpq3CGhDBKT4/Ie6fXM2jK3o3sT0RVZFopKf9GqCS0nWyxJEtoZTRi
   rnFk7Z5GKbrB6ihRpCNnHGrdTGZqu430FmOx4ryDoqsmRFL3E6EQkMXb1
   1yBRSfQETVF8mqI3ncf8TF8YxnQDb/AIWqzV1ByCxiKgLZi/ftdbHBClt
   Ut1daozKR30pywSlHm7fOlJGIyDGXgGQSvpB+n3akaAhTs9lwDRGuIDZu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356678103"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356678103"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255968"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255968"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:17 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 08/11] x86/tdx: Reimplement __tdx_hypercall() using TDX_MODULE_CALL asm
Date:   Fri, 21 Jul 2023 00:28:11 +1200
Message-ID: <e8e897256732b8920f14dedd54781a5409ebfb8d.1689855280.git.kai.huang@intel.com>
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

Now the TDX_HYPERCALL asm is basically identical to the TDX_MODULE_CALL
with both '\saved' and '\ret' enabled, with two minor things though:

1) The way to restore the structure pointer is different

The TDX_HYPERCALL uses RCX as spare to restore the structure pointer,
but the TDX_MODULE_CALL assumes no spare register can be used.  In other
words, TDX_MODULE_CALL already covers what TDX_HYPERCALL does.

2) TDX_MODULE_CALL only clears shared registers for TDH.VP.ENTER

For this just need to make that code available for the non-host case.

Thus, remove the TDX_HYPERCALL and reimplement the __tdx_hypercall()
using the TDX_MODULE_CALL.

Extend the TDX_MODULE_CALL to cover "clear shared registers" for
TDG.VP.VMCALL.  Introduce a new __tdcall_saved_ret() to replace the
temporary __tdcall_hypercall().

The __tdcall_saved_ret() can also be used for those new TDCALLs which
require more input/output registers than the basic TDCALLs do.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - The second patch (new) split from v1 "x86/tdx: Unify TDX_HYPERCALL
   and TDX_MODULE_CALL assembly"
 - Rebase to 6.5-rc2.

---
 arch/x86/coco/tdx/tdcall.S        | 132 ++----------------------------
 arch/x86/coco/tdx/tdx-shared.c    |   4 +-
 arch/x86/include/asm/shared/tdx.h |   2 +-
 arch/x86/virt/vmx/tdx/tdxcall.S   |   8 +-
 4 files changed, 15 insertions(+), 131 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 086afe888e5e..21242c28b54b 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -48,135 +48,19 @@ SYM_FUNC_START(__tdcall_ret)
 SYM_FUNC_END(__tdcall_ret)
 
 /*
- * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
- * instruction
- *
- * Transforms values in  function call argument struct tdx_module_args @args
- * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
- * back in @args, if \ret is 1.
- *
- * Depends on the caller to pass TDG.VP.VMCALL as the TDCALL leaf, and set
- * @args::rcx to TDVMCALL_EXPOSE_REGS_MASK.
- *
- *-------------------------------------------------------------------------
- * TD VMCALL ABI:
- *-------------------------------------------------------------------------
- *
- * Input Registers:
- *
- * RAX                 - TDCALL instruction leaf number (0 - TDG.VP.VMCALL)
- * RCX                 - BITMAP which controls which part of TD Guest GPR
- *                       is passed as-is to the VMM and back.
- * R10                 - Set 0 to indicate TDCALL follows standard TDX ABI
- *                       specification. Non zero value indicates vendor
- *                       specific ABI.
- * R11                 - VMCALL sub function number
- * RBX, RDX, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
- * R8-R9, R12-R15      - Same as above.
- *
- * Output Registers:
- *
- * RAX                 - TDCALL instruction status (Not related to hypercall
- *                        output).
- * RBX, RDX, RDI, RSI  - Hypercall sub function specific output values.
- * R8-R15              - Same as above.
- *
- */
-.macro TDX_HYPERCALL
-	FRAME_BEGIN
-
-	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
-	push %r15
-	push %r14
-	push %r13
-	push %r12
-	push %rbx
-
-	/* Move Leaf ID to RAX */
-	movq %rdi, %rax
-
-	/* Move bitmap of shared registers to RCX */
-	movq TDX_MODULE_rcx(%rsi), %rcx
-
-	/* Copy hypercall registers from arg struct: */
-	movq TDX_MODULE_r8(%rsi),  %r8
-	movq TDX_MODULE_r9(%rsi),  %r9
-	movq TDX_MODULE_r10(%rsi), %r10
-	movq TDX_MODULE_r11(%rsi), %r11
-	movq TDX_MODULE_r12(%rsi), %r12
-	movq TDX_MODULE_r13(%rsi), %r13
-	movq TDX_MODULE_r14(%rsi), %r14
-	movq TDX_MODULE_r15(%rsi), %r15
-	movq TDX_MODULE_rdi(%rsi), %rdi
-	movq TDX_MODULE_rbx(%rsi), %rbx
-	movq TDX_MODULE_rdx(%rsi), %rdx
-
-	pushq %rsi
-	movq TDX_MODULE_rsi(%rsi), %rsi
-
-	tdcall
-
-	/*
-	 * Restore the pointer of the structure to save output registers.
-	 *
-	 * RCX is used as bitmap of shared registers and doesn't hold any
-	 * value provided by the VMM, thus it can be used as spare to
-	 * restore the structure pointer.
-	 */
-	popq %rcx
-	movq %rsi, TDX_MODULE_rsi(%rcx)
-	movq %rcx, %rsi
-
-	movq %r8,  TDX_MODULE_r8(%rsi)
-	movq %r9,  TDX_MODULE_r9(%rsi)
-	movq %r10, TDX_MODULE_r10(%rsi)
-	movq %r11, TDX_MODULE_r11(%rsi)
-	movq %r12, TDX_MODULE_r12(%rsi)
-	movq %r13, TDX_MODULE_r13(%rsi)
-	movq %r14, TDX_MODULE_r14(%rsi)
-	movq %r15, TDX_MODULE_r15(%rsi)
-	movq %rdi, TDX_MODULE_rdi(%rsi)
-	movq %rbx, TDX_MODULE_rbx(%rsi)
-	movq %rdx, TDX_MODULE_rdx(%rsi)
-
-	/*
-	 * Zero out registers exposed to the VMM to avoid speculative execution
-	 * with VMM-controlled values. This needs to include all registers
-	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
-	 * will be restored.
-	 */
-	xor %r8d,  %r8d
-	xor %r9d,  %r9d
-	xor %r10d, %r10d
-	xor %r11d, %r11d
-	xor %rdi,  %rdi
-	xor %rsi,  %rsi
-	xor %rdx,  %rdx
-
-	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
-	pop %rbx
-	pop %r12
-	pop %r13
-	pop %r14
-	pop %r15
-
-	FRAME_END
-
-	RET
-.endm
-
-/*
+ * __tdcall_saved_ret() - Used by TDX guests to request services from the
+ * TDX module (including VMM services) using TDCALL instruction, with
+ * saving output registers to the 'struct tdx_module_args' used as input.
  *
- * __tdcall_hypercall() function ABI:
+ * __tdcall_saved_ret() function ABI:
  *
  * @fn   (RDI)	- TDCALL leaf ID, moved to RAX
  * @args (RSI)	- struct tdx_module_args for input/output
  *
- * @fn and @args::rcx from the caller must be TDG_VP_VMCALL and
- * TDVMCALL_EXPOSE_REGS_MASK respectively.
+ * All registers in @args are used as input/output registers.
  *
  * On successful completion, return the hypercall error code.
  */
-SYM_FUNC_START(__tdcall_hypercall)
-	TDX_HYPERCALL
-SYM_FUNC_END(__tdcall_hypercall)
+SYM_FUNC_START(__tdcall_saved_ret)
+	TDX_MODULE_CALL host=0 ret=1 saved=1
+SYM_FUNC_END(__tdcall_saved_ret)
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 13139ee171c8..20e8794762e1 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -89,11 +89,11 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args)
 	};
 
 	/*
-	 * Failure of __tdcall_hypercall() indicates a failure of the TDVMCALL
+	 * Failure of __tdcall_saved_ret() indicates a failure of the TDVMCALL
 	 * mechanism itself and that something has gone horribly wrong with
 	 * the TDX module.  __tdx_hypercall_failed() never returns.
 	 */
-	if (__tdcall_hypercall(TDG_VP_VMCALL, &margs))
+	if (__tdcall_saved_ret(TDG_VP_VMCALL, &margs))
 		__tdx_hypercall_failed();
 
 	args->r8  = margs.r8;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index da5205daa53d..188e8bf3332c 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -81,6 +81,7 @@ struct tdx_module_args {
 /* Used to communicate with the TDX module */
 u64 __tdcall(u64 fn, struct tdx_module_args *args);
 u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_saved_ret(u64 fn, struct tdx_module_args *args);
 
 /*
  * Used in __tdx_hypercall() to pass down and get back registers' values of
@@ -104,7 +105,6 @@ struct tdx_hypercall_args {
 };
 
 /* Used to request services from the VMM */
-u64 __tdcall_hypercall(u64 fn, struct tdx_module_args *args);
 u64 __tdx_hypercall(struct tdx_hypercall_args *args);
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index 42f9225a530d..3ed6d8b8d2a9 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -143,10 +143,10 @@
 	movq %r11, TDX_MODULE_r11(%rsi)
 .endif	/* \ret */
 
-.if \host && \saved && \ret
+.if \saved && \ret
 	/*
-	 * Clear registers shared by guest for VP.ENTER to prevent
-	 * speculative use of guest's values, including those are
+	 * Clear registers shared by guest for VP.VMCALL/VP.ENTER to prevent
+	 * speculative use of guest's/VMM's values, including those are
 	 * restored from the stack.
 	 *
 	 * See arch/x86/kvm/vmx/vmenter.S:
@@ -171,7 +171,7 @@
 	xorl %r15d, %r15d
 	xorl %ebx,  %ebx
 	xorl %edi,  %edi
-.endif	/* \host && \ret && \host */
+.endif	/* \ret && \host */
 
 .if \host
 .Lout\@:
-- 
2.41.0

