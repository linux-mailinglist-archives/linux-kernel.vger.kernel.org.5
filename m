Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4576E79DCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbjILXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbjILXo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:44:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797B10C7;
        Tue, 12 Sep 2023 16:44:22 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694562261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A4/LB1ysOGEk5ZwuFbmf+U3jFAYBF1ikBq8KHwzzjhk=;
        b=YtL//EDOzDdTajlGBT5GT9l3tPDPOkB6rXOzu2mOyvHdXVefxPBTN5taRHkmxdc2dILJpc
        rHnOKb1Mrzg34/KkR8mzenVldhpAnpkWHWM42loI40kuHdRTPR1eE6h/ptpCj6BuzXsLjr
        CG2eu4ZJLi7yb5U37S/9UoDvKFcndYK1KWd9sf3qkllFooP7r4UILSZj8+WaAIiKt2Xzp3
        H3AvcDmTBB1F6LmunQf+WbudmpJPCO4PGkqbj+CZKrTEbHd4a7MIk9crQ0c3pRLG3/Eaj5
        ZAFMCiS9B0J7s7MYNFUIBVHB9UxVsjbr3u9RwSrW/7i/+Yv8jbd0raTjR12BIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694562261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A4/LB1ysOGEk5ZwuFbmf+U3jFAYBF1ikBq8KHwzzjhk=;
        b=p1SzfdOyKKPWow6y7doE6fHYTquz26cC8sm/t+lI4N/e8ExAgTooW32n9rHj0MJlVtVtlE
        TeE+2DL79Zb1/WCA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169456226058.27769.1331477171117371189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c641cfb5c157b6c3062a824fd8ba190bf06fb952
Gitweb:        https://git.kernel.org/tip/c641cfb5c157b6c3062a824fd8ba190bf06fb952
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:01 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Sep 2023 16:28:13 -07:00

x86/tdx: Make TDX_HYPERCALL asm similar to TDX_MODULE_CALL

Now the 'struct tdx_hypercall_args' and 'struct tdx_module_args' are
almost the same, and the TDX_HYPERCALL and TDX_MODULE_CALL asm macro
share similar code pattern too.  The __tdx_hypercall() and __tdcall()
should be unified to use the same assembly code.

As a preparation to unify them, simplify the TDX_HYPERCALL to make it
more like the TDX_MODULE_CALL.

The TDX_HYPERCALL takes the pointer of 'struct tdx_hypercall_args' as
function call argument, and does below extra things comparing to the
TDX_MODULE_CALL:

1) It sets RAX to 0 (TDG.VP.VMCALL leaf) internally;
2) It sets RCX to the (fixed) bitmap of shared registers internally;
3) It calls __tdx_hypercall_failed() internally (and panics) when the
   TDCALL instruction itself fails;
4) After TDCALL, it moves R10 to RAX to return the return code of the
   VMCALL leaf, regardless the '\ret' asm macro argument;

Firstly, change the TDX_HYPERCALL to take the same function call
arguments as the TDX_MODULE_CALL does: TDCALL leaf ID, and the pointer
to 'struct tdx_module_args'.  Then 1) and 2) can be moved to the
caller:

 - TDG.VP.VMCALL leaf ID can be passed via the function call argument;
 - 'struct tdx_module_args' is 'struct tdx_hypercall_args' + RCX, thus
   the bitmap of shared registers can be passed via RCX in the
   structure.

Secondly, to move 3) and 4) out of assembly, make the TDX_HYPERCALL
always save output registers to the structure.  The caller then can:

 - Call __tdx_hypercall_failed() when TDX_HYPERCALL returns error;
 - Return R10 in the structure as the return code of the VMCALL leaf;

With above changes, change the asm function from __tdx_hypercall() to
__tdcall_hypercall(), and reimplement __tdx_hypercall() as the C wrapper
of it.  This avoids having to add another wrapper of __tdx_hypercall()
(_tdx_hypercall() is already taken).

The __tdcall_hypercall() will be replaced with a __tdcall() variant
using TDX_MODULE_CALL in a later commit as the final goal is to have one
assembly to handle both TDCALL and TDVMCALL.

Currently, the __tdx_hypercall() asm is in '.noinstr.text'.  To keep
this unchanged, annotate __tdx_hypercall(), which is a C function now,
as 'noinstr'.

Remove the __tdx_hypercall_ret() as __tdx_hypercall() already does so.

Implement __tdx_hypercall() in tdx-shared.c so it can be shared with the
compressed code.

Opportunistically fix a checkpatch error complaining using space around
parenthesis '(' and ')' while moving the bitmap of shared registers to
<asm/shared/tdx.h>.

[ dhansen: quash new calls of __tdx_hypercall_ret() that showed up ]

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang%40intel.com
---
 arch/x86/boot/compressed/tdx.c    |   2 +-
 arch/x86/coco/tdx/tdcall.S        | 150 +++++++++--------------------
 arch/x86/coco/tdx/tdx-shared.c    |  43 ++++++++-
 arch/x86/coco/tdx/tdx.c           |  13 +--
 arch/x86/hyperv/ivm.c             |   4 +-
 arch/x86/include/asm/shared/tdx.h |  86 +++++++++++------
 arch/x86/kernel/asm-offsets.c     |  14 +---
 7 files changed, 160 insertions(+), 152 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 8841b94..bc03eae 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -26,7 +26,7 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 		.r14 = port,
 	};
 
-	if (__tdx_hypercall_ret(&args))
+	if (__tdx_hypercall(&args))
 		return UINT_MAX;
 
 	return args.r11;
diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index faf731d..6d76d7d 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -2,41 +2,12 @@
 #include <asm/asm-offsets.h>
 #include <asm/asm.h>
 #include <asm/frame.h>
-#include <asm/unwind_hints.h>
 
 #include <linux/linkage.h>
-#include <linux/bits.h>
 #include <linux/errno.h>
 
 #include "../../virt/vmx/tdx/tdxcall.S"
 
-/*
- * Bitmasks of exposed registers (with VMM).
- */
-#define TDX_RDX		BIT(2)
-#define TDX_RBX		BIT(3)
-#define TDX_RSI		BIT(6)
-#define TDX_RDI		BIT(7)
-#define TDX_R8		BIT(8)
-#define TDX_R9		BIT(9)
-#define TDX_R10		BIT(10)
-#define TDX_R11		BIT(11)
-#define TDX_R12		BIT(12)
-#define TDX_R13		BIT(13)
-#define TDX_R14		BIT(14)
-#define TDX_R15		BIT(15)
-
-/*
- * These registers are clobbered to hold arguments for each
- * TDVMCALL. They are safe to expose to the VMM.
- * Each bit in this mask represents a register ID. Bit field
- * details can be found in TDX GHCI specification, section
- * titled "TDCALL [TDG.VP.VMCALL] leaf".
- */
-#define TDVMCALL_EXPOSE_REGS_MASK	\
-	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
-	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
-
 .section .noinstr.text, "ax"
 
 /*
@@ -78,10 +49,13 @@ SYM_FUNC_END(__tdcall_ret)
  * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
  * instruction
  *
- * Transforms values in  function call argument struct tdx_hypercall_args @args
+ * Transforms values in  function call argument struct tdx_module_args @args
  * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
  * back in @args, if \ret is 1.
  *
+ * Depends on the caller to pass TDG.VP.VMCALL as the TDCALL leaf, and set
+ * @args::rcx to TDVMCALL_EXPOSE_REGS_MASK.
+ *
  *-------------------------------------------------------------------------
  * TD VMCALL ABI:
  *-------------------------------------------------------------------------
@@ -106,7 +80,7 @@ SYM_FUNC_END(__tdcall_ret)
  * R8-R15              - Same as above.
  *
  */
-.macro TDX_HYPERCALL ret:req
+.macro TDX_HYPERCALL
 	FRAME_BEGIN
 
 	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
@@ -116,63 +90,52 @@ SYM_FUNC_END(__tdcall_ret)
 	push %r12
 	push %rbx
 
-	/* Free RDI to be used as TDVMCALL arguments */
+	/* Move Leaf ID to RAX */
 	movq %rdi, %rax
 
+	/* Move bitmap of shared registers to RCX */
+	movq TDX_MODULE_rcx(%rsi), %rcx
+
 	/* Copy hypercall registers from arg struct: */
-	movq TDX_HYPERCALL_r8(%rax),  %r8
-	movq TDX_HYPERCALL_r9(%rax),  %r9
-	movq TDX_HYPERCALL_r10(%rax), %r10
-	movq TDX_HYPERCALL_r11(%rax), %r11
-	movq TDX_HYPERCALL_r12(%rax), %r12
-	movq TDX_HYPERCALL_r13(%rax), %r13
-	movq TDX_HYPERCALL_r14(%rax), %r14
-	movq TDX_HYPERCALL_r15(%rax), %r15
-	movq TDX_HYPERCALL_rdi(%rax), %rdi
-	movq TDX_HYPERCALL_rsi(%rax), %rsi
-	movq TDX_HYPERCALL_rbx(%rax), %rbx
-	movq TDX_HYPERCALL_rdx(%rax), %rdx
-
-	push %rax
-
-	/* Mangle function call ABI into TDCALL ABI: */
-	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
-	xor %eax, %eax
-
-	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+	movq TDX_MODULE_r8(%rsi),  %r8
+	movq TDX_MODULE_r9(%rsi),  %r9
+	movq TDX_MODULE_r10(%rsi), %r10
+	movq TDX_MODULE_r11(%rsi), %r11
+	movq TDX_MODULE_r12(%rsi), %r12
+	movq TDX_MODULE_r13(%rsi), %r13
+	movq TDX_MODULE_r14(%rsi), %r14
+	movq TDX_MODULE_r15(%rsi), %r15
+	movq TDX_MODULE_rdi(%rsi), %rdi
+	movq TDX_MODULE_rbx(%rsi), %rbx
+	movq TDX_MODULE_rdx(%rsi), %rdx
+
+	pushq %rsi
+	movq TDX_MODULE_rsi(%rsi), %rsi
 
 	tdcall
 
 	/*
-	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
-	 * something has gone horribly wrong with the TDX module.
+	 * Restore the pointer of the structure to save output registers.
 	 *
-	 * The return status of the hypercall operation is in a separate
-	 * register (in R10). Hypercall errors are a part of normal operation
-	 * and are handled by callers.
+	 * RCX is used as bitmap of shared registers and doesn't hold any
+	 * value provided by the VMM, thus it can be used as spare to
+	 * restore the structure pointer.
 	 */
-	testq %rax, %rax
-	jne .Lpanic\@
-
-	pop %rax
-
-	.if \ret
-	movq %r8,  TDX_HYPERCALL_r8(%rax)
-	movq %r9,  TDX_HYPERCALL_r9(%rax)
-	movq %r10, TDX_HYPERCALL_r10(%rax)
-	movq %r11, TDX_HYPERCALL_r11(%rax)
-	movq %r12, TDX_HYPERCALL_r12(%rax)
-	movq %r13, TDX_HYPERCALL_r13(%rax)
-	movq %r14, TDX_HYPERCALL_r14(%rax)
-	movq %r15, TDX_HYPERCALL_r15(%rax)
-	movq %rdi, TDX_HYPERCALL_rdi(%rax)
-	movq %rsi, TDX_HYPERCALL_rsi(%rax)
-	movq %rbx, TDX_HYPERCALL_rbx(%rax)
-	movq %rdx, TDX_HYPERCALL_rdx(%rax)
-	.endif
-
-	/* TDVMCALL leaf return code is in R10 */
-	movq %r10, %rax
+	popq %rcx
+	movq %rsi, TDX_MODULE_rsi(%rcx)
+	movq %rcx, %rsi
+
+	movq %r8,  TDX_MODULE_r8(%rsi)
+	movq %r9,  TDX_MODULE_r9(%rsi)
+	movq %r10, TDX_MODULE_r10(%rsi)
+	movq %r11, TDX_MODULE_r11(%rsi)
+	movq %r12, TDX_MODULE_r12(%rsi)
+	movq %r13, TDX_MODULE_r13(%rsi)
+	movq %r14, TDX_MODULE_r14(%rsi)
+	movq %r15, TDX_MODULE_r15(%rsi)
+	movq %rdi, TDX_MODULE_rdi(%rsi)
+	movq %rbx, TDX_MODULE_rbx(%rsi)
+	movq %rdx, TDX_MODULE_rdx(%rsi)
 
 	/*
 	 * Zero out registers exposed to the VMM to avoid speculative execution
@@ -198,33 +161,20 @@ SYM_FUNC_END(__tdcall_ret)
 	FRAME_END
 
 	RET
-.Lpanic\@:
-	call __tdx_hypercall_failed
-	/* __tdx_hypercall_failed never returns */
-	REACHABLE
-	jmp .Lpanic\@
 .endm
 
 /*
  *
- * __tdx_hypercall() function ABI:
- *
- * @args  (RDI)        - struct tdx_hypercall_args for input
- *
- * On successful completion, return the hypercall error code.
- */
-SYM_FUNC_START(__tdx_hypercall)
-	TDX_HYPERCALL ret=0
-SYM_FUNC_END(__tdx_hypercall)
-
-/*
+ * __tdcall_hypercall() function ABI:
  *
- * __tdx_hypercall_ret() function ABI:
+ * @fn   (RDI)	- TDCALL leaf ID, moved to RAX
+ * @args (RSI)	- struct tdx_module_args for input/output
  *
- * @args  (RDI)        - struct tdx_hypercall_args for input and output
+ * @fn and @args::rcx from the caller must be TDG_VP_VMCALL and
+ * TDVMCALL_EXPOSE_REGS_MASK respectively.
  *
  * On successful completion, return the hypercall error code.
  */
-SYM_FUNC_START(__tdx_hypercall_ret)
-	TDX_HYPERCALL ret=1
-SYM_FUNC_END(__tdx_hypercall_ret)
+SYM_FUNC_START(__tdcall_hypercall)
+	TDX_HYPERCALL
+SYM_FUNC_END(__tdcall_hypercall)
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index a7396d0..b47c8cc 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -69,3 +69,46 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 
 	return true;
 }
+
+noinstr u64 __tdx_hypercall(struct tdx_hypercall_args *args)
+{
+	struct tdx_module_args margs = {
+		.rcx = TDVMCALL_EXPOSE_REGS_MASK,
+		.rdx = args->rdx,
+		.r8  = args->r8,
+		.r9  = args->r9,
+		.r10 = args->r10,
+		.r11 = args->r11,
+		.r12 = args->r12,
+		.r13 = args->r13,
+		.r14 = args->r14,
+		.r15 = args->r15,
+		.rbx = args->rbx,
+		.rdi = args->rdi,
+		.rsi = args->rsi,
+	};
+
+	/*
+	 * Failure of __tdcall_hypercall() indicates a failure of the TDVMCALL
+	 * mechanism itself and that something has gone horribly wrong with
+	 * the TDX module.  __tdx_hypercall_failed() never returns.
+	 */
+	if (__tdcall_hypercall(TDG_VP_VMCALL, &margs))
+		__tdx_hypercall_failed();
+
+	args->r8  = margs.r8;
+	args->r9  = margs.r9;
+	args->r10 = margs.r10;
+	args->r11 = margs.r11;
+	args->r12 = margs.r12;
+	args->r13 = margs.r13;
+	args->r14 = margs.r14;
+	args->r15 = margs.r15;
+	args->rdi = margs.rdi;
+	args->rsi = margs.rsi;
+	args->rbx = margs.rbx;
+	args->rdx = margs.rdx;
+
+	/* TDVMCALL leaf return code is in R10 */
+	return args->r10;
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0741a9d..26b6c3d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,7 +38,7 @@
 #define TDREPORT_SUBTYPE_0	0
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
-noinstr void __tdx_hypercall_failed(void)
+noinstr void __noreturn __tdx_hypercall_failed(void)
 {
 	instrumentation_begin();
 	panic("TDVMCALL failed. TDX module bug?");
@@ -285,7 +285,7 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
-	if (__tdx_hypercall_ret(&args))
+	if (__tdx_hypercall(&args))
 		return -EIO;
 
 	regs->ax = lower_32_bits(args.r11);
@@ -339,7 +339,7 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	 * ABI can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
-	if (__tdx_hypercall_ret(&args))
+	if (__tdx_hypercall(&args))
 		return -EIO;
 
 	/*
@@ -366,8 +366,9 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r15 = *val,
 	};
 
-	if (__tdx_hypercall_ret(&args))
+	if (__tdx_hypercall(&args))
 		return false;
+
 	*val = args.r11;
 	return true;
 }
@@ -500,7 +501,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	success = !__tdx_hypercall_ret(&args);
+	success = !__tdx_hypercall(&args);
 
 	/* Update part of the register affected by the emulated instruction */
 	regs->ax &= ~mask;
@@ -729,7 +730,7 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 			.r13 = end - start };
 
 		u64 map_fail_paddr;
-		u64 ret = __tdx_hypercall_ret(&args);
+		u64 ret = __tdx_hypercall(&args);
 
 		if (ret != TDVMCALL_STATUS_RETRY)
 			return !ret;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8c6bf07..e489835 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -404,7 +404,7 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 		.r12 = msr,
 	};
 
-	u64 ret = __tdx_hypercall_ret(&args);
+	u64 ret = __tdx_hypercall(&args);
 
 	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
 		*val = 0;
@@ -420,7 +420,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 	args.rdx = param1;
 	args.r8  = param2;
 
-	(void)__tdx_hypercall_ret(&args);
+	(void)__tdx_hypercall(&args);
 
 	return args.r11;
 }
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 669749a..85493c4 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -11,6 +11,7 @@
 #define TDX_IDENT		"IntelTDX    "
 
 /* TDX module Call Leaf IDs */
+#define TDG_VP_VMCALL			0
 #define TDG_VP_INFO			1
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
@@ -26,9 +27,64 @@
 
 #define TDVMCALL_STATUS_RETRY		1
 
+/*
+ * Bitmasks of exposed registers (with VMM).
+ */
+#define TDX_RDX		BIT(2)
+#define TDX_RBX		BIT(3)
+#define TDX_RSI		BIT(6)
+#define TDX_RDI		BIT(7)
+#define TDX_R8		BIT(8)
+#define TDX_R9		BIT(9)
+#define TDX_R10		BIT(10)
+#define TDX_R11		BIT(11)
+#define TDX_R12		BIT(12)
+#define TDX_R13		BIT(13)
+#define TDX_R14		BIT(14)
+#define TDX_R15		BIT(15)
+
+/*
+ * These registers are clobbered to hold arguments for each
+ * TDVMCALL. They are safe to expose to the VMM.
+ * Each bit in this mask represents a register ID. Bit field
+ * details can be found in TDX GHCI specification, section
+ * titled "TDCALL [TDG.VP.VMCALL] leaf".
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK	\
+	(TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+	 TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
+
 #ifndef __ASSEMBLY__
 
 /*
+ * Used in __tdcall*() to gather the input/output registers' values of the
+ * TDCALL instruction when requesting services from the TDX module. This is a
+ * software only structure and not part of the TDX module/VMM ABI
+ */
+struct tdx_module_args {
+	/* callee-clobbered */
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	/* extra callee-clobbered */
+	u64 r10;
+	u64 r11;
+	/* callee-saved + rdi/rsi */
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u64 rbx;
+	u64 rdi;
+	u64 rsi;
+};
+
+/* Used to communicate with the TDX module */
+u64 __tdcall(u64 fn, struct tdx_module_args *args);
+u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
+
+/*
  * Used in __tdx_hypercall() to pass down and get back registers' values of
  * the TDCALL instruction when requesting services from the VMM.
  *
@@ -50,8 +106,8 @@ struct tdx_hypercall_args {
 };
 
 /* Used to request services from the VMM */
+u64 __tdcall_hypercall(u64 fn, struct tdx_module_args *args);
 u64 __tdx_hypercall(struct tdx_hypercall_args *args);
-u64 __tdx_hypercall_ret(struct tdx_hypercall_args *args);
 
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
@@ -75,34 +131,6 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
 
-/*
- * Used in __tdcall*() to gather the input/output registers' values of the
- * TDCALL instruction when requesting services from the TDX module. This is a
- * software only structure and not part of the TDX module/VMM ABI
- */
-struct tdx_module_args {
-	/* callee-clobbered */
-	u64 rcx;
-	u64 rdx;
-	u64 r8;
-	u64 r9;
-	/* extra callee-clobbered */
-	u64 r10;
-	u64 r11;
-	/* callee-saved + rdi/rsi */
-	u64 r12;
-	u64 r13;
-	u64 r14;
-	u64 r15;
-	u64 rbx;
-	u64 rdi;
-	u64 rsi;
-};
-
-/* Used to communicate with the TDX module */
-u64 __tdcall(u64 fn, struct tdx_module_args *args);
-u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
-
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
 
 /*
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 1581564..6913b37 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -83,20 +83,6 @@ static void __used common(void)
 	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
 
 	BLANK();
-	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
-	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
-	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
-	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
-	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
-	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
-	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
-	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
-	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
-	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
-	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
-	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
-
-	BLANK();
 	OFFSET(BP_scratch, boot_params, scratch);
 	OFFSET(BP_secure_boot, boot_params, secure_boot);
 	OFFSET(BP_loadflags, boot_params, hdr.loadflags);
