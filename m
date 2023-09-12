Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46CD79D4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjILPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjILPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6B10D9;
        Tue, 12 Sep 2023 08:32:04 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:32:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tm+FkDAXj9wYi3eEkgjYGDKrH+4KdSsCxKcv24q42aA=;
        b=K6clmgoNZY13mCgjQhBP/lgfI5cKrx2mgXW53cJ+5txBOTycwu3NZfet8ke+AHir5Pk0q1
        /x+n5OZFfvF8priiqfNMWOQChcGpt5Un3UTs+2vCHr9b5ggpxfcS4SudlYyHq6NCrlrAcB
        7s+81cEyWbi8RPKWPfYpBq0Ai8/lqYcpsQ1vtKSqW2oqH/Hiena5cGZmCHZVS/3SeNUCOb
        zFWpkAO1RPfTI9rqG6z5LMDxI0eQ93OcPqZZDrVNpGBACJEJ04QxKc7bwYThJrAQhIWuf9
        R+56T4pN4N8TS5y2FWQwMrIxY4Rhyj3c/e9EfzIwDO93SgF7Xq4pK2cjy8AyGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tm+FkDAXj9wYi3eEkgjYGDKrH+4KdSsCxKcv24q42aA=;
        b=9r2Z5ZpYgbU4mmCI8fT1pp/+Ho7fYK6XAPBr3KwFJi6lw4QHQOGQlRYpbCJC0FlIijWtMj
        oifEjAPEi087JtCw==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169453272270.27769.14517629260706609170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     12f34ed8622aafd3bbd9d8aa4550dcb7016ea1e6
Gitweb:        https://git.kernel.org/tip/12f34ed8622aafd3bbd9d8aa4550dcb7016ea1e6
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:00 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 11 Sep 2023 16:33:51 -07:00

x86/tdx: Extend TDX_MODULE_CALL to support more TDCALL/SEAMCALL leafs

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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/d4785de7c392f7c5684407f6c24a73b92148ec49.1692096753.git.kai.huang%40intel.com
---
 arch/x86/coco/tdx/tdcall.S        |   4 +-
 arch/x86/include/asm/shared/tdx.h |  10 ++-
 arch/x86/kernel/asm-offsets.c     |   7 ++-
 arch/x86/virt/vmx/tdx/tdxcall.S   | 123 +++++++++++++++++++++++++++--
 4 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 56b9cd3..faf731d 100644
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
index ca8a681..669749a 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -81,12 +81,22 @@ void __tdx_hypercall_failed(void);
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
index 50383bc..1581564 100644
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
index e9e19e7..c54ea00 100644
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
 
