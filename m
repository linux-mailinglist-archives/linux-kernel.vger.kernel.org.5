Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD377CB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjHOLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjHOLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0420B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692097359; x=1723633359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rc25uROOylHBTrNt5a5W6dVQiCwghURi3gSxTitGPUQ=;
  b=UHwOTKQh3AHiDV3lJt+KIdwRi0TomYgrHzMCDMMghUwUvJCjokeFRInB
   5eWo/7knh7oTWvMWkxtbXXb862WNCmClgA8JsjXC1vl+uxWsTkDiBAmJE
   qJmK6LjDEKSpRsWnQTgF5FGTesVoqIturJShnWhFyJgwIgrTzV5lReJUx
   fmoLuB2TfLsDpl/5YfK97FD+vsBev0E1h4r6VK3IRFLyQxUZf+bcEXGPV
   Q5yU/BZhQyCvE0FTj7Pq4t6TcZpYn7HX1fIExR0GUH/fB0zM0CS5ed50c
   OyifvpPdnnYrqfs+JWO+phT9JGSWxPDZ1TkUqPM0W4iKYXT6lnise4ZTc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436148324"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436148324"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="763236155"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="763236155"
Received: from fwafula-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.73.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 04:02:36 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v4 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs
Date:   Tue, 15 Aug 2023 23:02:00 +1200
Message-ID: <d4785de7c392f7c5684407f6c24a73b92148ec49.1692096753.git.kai.huang@intel.com>
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

The TDX guest live migration support (TDX 1.5) adds new TDCALL/SEAMCALL
leaf functions.  Those new TDCALLs/SEAMCALLs take additional registers
for input (R10-R13) and output (R12-R13).  TDG.SERVTD.RD is an example.

Also, the current TDX_MODULE_CALL doesn't aim to handle TDH.VP.ENTER
SEAMCALL, which monitors the TDG.VP.VMCALL in input/output registers
when it returns in case of VMCALL from TDX guest.

With those new TDCALLs/SEAMCALLs and the TDH.VP.ENTER covered, the
TDX_MODULE_CALL macro basically needs to handle the same input/output
registers as the TDX_HYPERCALL does.  And as a result, they also share
similar logic in the assembly, thus should be unified to use one common
assembly.

Extend the TDX_MODULE_CALL asm to support the new TDCALLs/SEAMCALLs and
also the TDH.VP.ENTER SEAMCALL.  Eventually it will be unified with the
TDX_HYPERCALL.

The new input/output registers fit with the "callee-saved" registers in
the x86 calling convention.  Add a new "saved" parameter to support
those new TDCALLs/SEAMCALLs and TDH.VP.ENTER and keep the existing
TDCALLs/SEAMCALLs minimally impacted.

For TDH.VP.ENTER, after it returns the registers shared by the guest
contain guest's values.  Explicitly clear them to prevent speculative
use of guest's values.

Note most TDX live migration related SEAMCALLs may also clobber AVX*
state ("AVX, AVX2 and AVX512 state: may be reset to the architectural
INIT state" -- see TDH.EXPORT.MEM for example).  And TDH.VP.ENTER also
clobbers XMM0-XMM15 when the corresponding bit is set in RCX.  Don't
handle them in the TDX_MODULE_CALL macro but let the caller save and
restore when needed.

This is basically based on Peter's code.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

v3 -> v4:
 - Removed unnecessary 'movq %rax, %rsi'. - Kirill
 - Changed '%rsi' -> 'RSI' in the comments. - Kirill
 - Added Kirill's Reviewed-by tag

v2 -> v3:
 - No change.

v1 -> v2:
 - xorq %rcx, %rcx -> xorl %eax, %eax to save the REX prefix
 - Minor improvement in comments and changelog.


---
 arch/x86/coco/tdx/tdcall.S        |   4 +
 arch/x86/include/asm/shared/tdx.h |  10 +++
 arch/x86/kernel/asm-offsets.c     |   7 ++
 arch/x86/virt/vmx/tdx/tdxcall.S   | 123 ++++++++++++++++++++++++++++--
 4 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 56b9cd32895e..faf731d2b66a 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -48,6 +48,8 @@
  * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
  * @args (RSI)	- struct tdx_module_args for input
  *
+ * Only RCX/RDX/R8-R11 are used as input registers.
+ *
  * Return status of TDCALL via RAX.
  */
 SYM_FUNC_START(__tdcall)
@@ -64,6 +66,8 @@ SYM_FUNC_END(__tdcall)
  * @fn   (RDI)	- TDCALL Leaf ID, moved to RAX
  * @args (RSI)	- struct tdx_module_args for input and output
  *
+ * Only RCX/RDX/R8-R11 are used as input/output registers.
+ *
  * Return status of TDCALL via RAX.
  */
 SYM_FUNC_START(__tdcall_ret)
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 3606463ebf6f..4468988adec5 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -79,12 +79,22 @@ void __tdx_hypercall_failed(void);
  * software only structure and not part of the TDX module/VMM ABI
  */
 struct tdx_module_args {
+	/* callee-clobbered */
 	u64 rcx;
 	u64 rdx;
 	u64 r8;
 	u64 r9;
+	/* extra callee-clobbered */
 	u64 r10;
 	u64 r11;
+	/* callee-saved + rdi/rsi */
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u64 rbx;
+	u64 rdi;
+	u64 rsi;
 };
 
 /* Used to communicate with the TDX module */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 50383bc46dd7..1581564a67b7 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -74,6 +74,13 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
 	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
 	OFFSET(TDX_MODULE_r11, tdx_module_args, r11);
+	OFFSET(TDX_MODULE_r12, tdx_module_args, r12);
+	OFFSET(TDX_MODULE_r13, tdx_module_args, r13);
+	OFFSET(TDX_MODULE_r14, tdx_module_args, r14);
+	OFFSET(TDX_MODULE_r15, tdx_module_args, r15);
+	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
+	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
+	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
 
 	BLANK();
 	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
index e9e19e7d77f8..c54ea009b241 100644
--- a/arch/x86/virt/vmx/tdx/tdxcall.S
+++ b/arch/x86/virt/vmx/tdx/tdxcall.S
@@ -23,17 +23,25 @@
  *-------------------------------------------------------------------------
  * Input Registers:
  *
- * RAX                 - TDCALL/SEAMCALL Leaf number.
- * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific input registers.
+ * RAX                        - TDCALL/SEAMCALL Leaf number.
+ * RCX,RDX,RDI,RSI,RBX,R8-R15 - TDCALL/SEAMCALL Leaf specific input registers.
  *
  * Output Registers:
  *
- * RAX                 - TDCALL/SEAMCALL instruction error code.
- * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
+ * RAX                        - TDCALL/SEAMCALL instruction error code.
+ * RCX,RDX,RDI,RSI,RBX,R8-R15 - TDCALL/SEAMCALL Leaf specific output registers.
  *
  *-------------------------------------------------------------------------
+ *
+ * So while the common core (RAX,RCX,RDX,R8-R11) fits nicely in the
+ * callee-clobbered registers and even leaves RDI,RSI free to act as a
+ * base pointer, some leafs (e.g., VP.ENTER) make a giant mess of things.
+ *
+ * For simplicity, assume that anything that needs the callee-saved regs
+ * also tramples on RDI,RSI.  This isn't strictly true, see for example
+ * TDH.EXPORT.MEM.
  */
-.macro TDX_MODULE_CALL host:req ret=0
+.macro TDX_MODULE_CALL host:req ret=0 saved=0
 	FRAME_BEGIN
 
 	/* Move Leaf ID to RAX */
@@ -47,6 +55,35 @@
 	movq	TDX_MODULE_r10(%rsi), %r10
 	movq	TDX_MODULE_r11(%rsi), %r11
 
+.if \saved
+	/*
+	 * Move additional input regs from the structure.  For simplicity
+	 * assume that anything needs the callee-saved regs also tramples
+	 * on RDI/RSI (see VP.ENTER).
+	 */
+	/* Save those callee-saved GPRs as mandated by the x86_64 ABI */
+	pushq	%rbx
+	pushq	%r12
+	pushq	%r13
+	pushq	%r14
+	pushq	%r15
+
+	movq	TDX_MODULE_r12(%rsi), %r12
+	movq	TDX_MODULE_r13(%rsi), %r13
+	movq	TDX_MODULE_r14(%rsi), %r14
+	movq	TDX_MODULE_r15(%rsi), %r15
+	movq	TDX_MODULE_rbx(%rsi), %rbx
+
+.if \ret
+	/* Save the structure pointer as RSI is about to be clobbered */
+	pushq	%rsi
+.endif
+
+	movq	TDX_MODULE_rdi(%rsi), %rdi
+	/* RSI needs to be done at last */
+	movq	TDX_MODULE_rsi(%rsi), %rsi
+.endif	/* \saved */
+
 .if \host
 	seamcall
 	/*
@@ -66,6 +103,36 @@
 .endif
 
 .if \ret
+.if \saved
+	/*
+	 * Restore the structure from stack to save the output registers
+	 *
+	 * In case of VP.ENTER returns due to TDVMCALL, all registers are
+	 * valid thus no register can be used as spare to restore the
+	 * structure from the stack (see "TDH.VP.ENTER Output Operands
+	 * Definition on TDCALL(TDG.VP.VMCALL) Following a TD Entry").
+	 * For this case, need to make one register as spare by saving it
+	 * to the stack and then manually load the structure pointer to
+	 * the spare register.
+	 *
+	 * Note for other TDCALLs/SEAMCALLs there are spare registers
+	 * thus no need for such hack but just use this for all.
+	 */
+	pushq	%rax		/* save the TDCALL/SEAMCALL return code */
+	movq	8(%rsp), %rax	/* restore the structure pointer */
+	movq	%rsi, TDX_MODULE_rsi(%rax)	/* save RSI */
+	popq	%rax		/* restore the return code */
+	popq	%rsi		/* pop the structure pointer */
+
+	/* Copy additional output regs to the structure  */
+	movq %r12, TDX_MODULE_r12(%rsi)
+	movq %r13, TDX_MODULE_r13(%rsi)
+	movq %r14, TDX_MODULE_r14(%rsi)
+	movq %r15, TDX_MODULE_r15(%rsi)
+	movq %rbx, TDX_MODULE_rbx(%rsi)
+	movq %rdi, TDX_MODULE_rdi(%rsi)
+.endif	/* \saved */
+
 	/* Copy output registers to the structure */
 	movq %rcx, TDX_MODULE_rcx(%rsi)
 	movq %rdx, TDX_MODULE_rdx(%rsi)
@@ -73,17 +140,61 @@
 	movq %r9,  TDX_MODULE_r9(%rsi)
 	movq %r10, TDX_MODULE_r10(%rsi)
 	movq %r11, TDX_MODULE_r11(%rsi)
-.endif
+.endif	/* \ret */
+
+.if \host && \saved && \ret
+	/*
+	 * Clear registers shared by guest for VP.ENTER to prevent
+	 * speculative use of guest's values, including those are
+	 * restored from the stack.
+	 *
+	 * See arch/x86/kvm/vmx/vmenter.S:
+	 *
+	 * In theory, a L1 cache miss when restoring register from stack
+	 * could lead to speculative execution with guest's values.
+	 *
+	 * Note: RBP/RSP are not used as shared register.  RSI has been
+	 * restored already.
+	 *
+	 * XOR is cheap, thus unconditionally do for all leafs.
+	 */
+	xorl %ecx,  %ecx
+	xorl %edx,  %edx
+	xorl %r8d,  %r8d
+	xorl %r9d,  %r9d
+	xorl %r10d, %r10d
+	xorl %r11d, %r11d
+	xorl %r12d, %r12d
+	xorl %r13d, %r13d
+	xorl %r14d, %r14d
+	xorl %r15d, %r15d
+	xorl %ebx,  %ebx
+	xorl %edi,  %edi
+.endif	/* \host && \ret && \host */
 
 .if \host
 .Lout\@:
 .endif
+
+.if \saved
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	popq	%r15
+	popq	%r14
+	popq	%r13
+	popq	%r12
+	popq	%rbx
+.endif	/* \saved */
+
 	FRAME_END
 	RET
 
 .if \host
 .Lseamcall_vmfailinvalid\@:
 	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+.if \ret && \saved
+	/* pop the unused structure pointer back to RSI */
+	popq %rsi
+.endif
 	jmp .Lout\@
 .endif	/* \host */
 
-- 
2.41.0

