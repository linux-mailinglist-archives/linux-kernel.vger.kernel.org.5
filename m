Return-Path: <linux-kernel+bounces-133147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D31899F81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC42EB21D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC016EBFD;
	Fri,  5 Apr 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7JZvnWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF016EBE4;
	Fri,  5 Apr 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327109; cv=none; b=P9/11/sz2iqG9m14BSErADndFu8jlyP4K0Fa7Qqy95lexvRsctO764JzdNPumj9+dUn0hFNL8mN3x9DKqUgmdroSuanh15HrULarRRgVZzG77+EMM/YpX5Yk7xY4eh2cLm4A5gs5dtCYbetxL5MU6cwsXsg4N0KmkdrIWj1w9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327109; c=relaxed/simple;
	bh=bZzc1/ykJ5+3qh+B1335fGeT/iPCxNqgcBFsQa28B5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sSgoaI/pGbMXu9LwsWOEUY8Bs6tXlXAIDb3yu45erVrfTnnXpR1/4YdeMCvS3YSpJpe40Z2qKpmI6XmnTIUv2JIiO5Kp344F8IA6Z+MSsIO14IJQePhhAJ0SH9EXrFviSW89soDi1cbiDMpe4eJ1mGLFEDjIQ2jQqg0L60KlTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7JZvnWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB53C433C7;
	Fri,  5 Apr 2024 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712327109;
	bh=bZzc1/ykJ5+3qh+B1335fGeT/iPCxNqgcBFsQa28B5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=C7JZvnWWHGg+jrEjxFluRGqHmF1EmO7tNy6ywbbfsW5hwOxNGteJexg65Pfj9J703
	 dd+Jf4WOMNxnDViwVP/SV/TNTlc2wqCKa1T7m0doJzmvrYAODHrgIySGcoi7+OQXo5
	 tAxyiXmpE4XFkOJ07byuDCkYv/UbSnexpQueLTvVWzCFnOhNf8wW6r8uPigHlEGUND
	 pto/E8cSIbnZ6t/pChlNHefH6+WUK6xDvDH+IHLIp0q/Xoun0RKRT0jpLbqsRPjbLG
	 g6wuzDmxK3RmPsv5TuNtxOkeF759PSU4/2vZfDzzGLILFjG6zG7coY2tY62QwwFTQf
	 nf6JcXGCv/jDg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Song Shuai <suagrfillet@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH] ftrace: riscv: move from REGS to ARGS
Date: Fri,  5 Apr 2024 14:24:53 +0000
Message-Id: <20240405142453.4187-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces riscv's support for FTRACE_WITH_REGS with support
for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
relying on stop_machine() for RISCV's implementation of ftrace.

The main relevant benefit that this change will bring for the above
use-case is that now we don't have separate ftrace_caller and
ftrace_regs_caller trampolines. This will allow the callsite to call
ftrace_caller by modifying a single instruction. Now the callsite can
do something similar to:

When not tracing:            |             When tracing:

func:                                      func:
  auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_top
  nop  <=========<Enable/Disable>=========>  jalr  t0, ftrace_caller_bottom
  [...]                                      [...]

The above assumes that we are dropping the support of calling a direct
trampoline from the callsite. We need to drop this as the callsite can't
change the target address to call, it can only enable/disable a call to
a preset target (ftrace_caller in the above diagram). We can later optimize
this by calling an intermediate dispatcher trampoline before ftrace_caller.

Currently, ftrace_regs_caller saves all CPU registers in the format of
struct pt_regs and allows the tracer to modify them. We don't need to
save all of the CPU registers because at function entry only a subset of
pt_regs is live:

|----------+----------+---------------------------------------------|
| Register | ABI Name | Description                                 |
|----------+----------+---------------------------------------------|
| x1       | ra       | Return address for traced function          |
| x2       | sp       | Stack pointer                               |
| x5       | t0       | Return address for ftrace_caller trampoline |
| x8       | s0/fp    | Frame pointer                               |
| x10-11   | a0-1     | Function arguments/return values            |
| x12-17   | a2-7     | Function arguments                          |
|----------+----------+---------------------------------------------|

See RISCV calling convention[1] for the above table.

Saving just the live registers decreases the amount of stack space
required from 288 Bytes to 112 Bytes.

Basic testing was done with this on the VisionFive 2 development board.

Note:
  - Moving from REGS to ARGS will mean that RISCV will stop supporting
    KPROBES_ON_FTRACE as it requires full pt_regs to be saved.
  - KPROBES_ON_FTRACE will be supplanted by FPROBES see [2].

[1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf
[2] https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit@devnote2/

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/Kconfig              |   2 +-
 arch/riscv/include/asm/ftrace.h |  76 ++++++++++++--
 arch/riscv/kernel/asm-offsets.c |  18 ++++
 arch/riscv/kernel/ftrace.c      |  18 +---
 arch/riscv/kernel/mcount-dyn.S  | 171 ++++++++++----------------------
 include/linux/ftrace.h          |   3 +-
 6 files changed, 145 insertions(+), 143 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..da637fde2137 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -126,7 +126,7 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 1276d7d9ca8b..9eb31a7ea0aa 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -124,20 +124,82 @@ struct dyn_ftrace;
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define arch_ftrace_get_regs(regs) NULL
 struct ftrace_ops;
-struct ftrace_regs;
+struct ftrace_regs {
+	unsigned long epc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long s0;
+	unsigned long t1;
+	union {
+		unsigned long args[8];
+		struct {
+			unsigned long a0;
+			unsigned long a1;
+			unsigned long a2;
+			unsigned long a3;
+			unsigned long a4;
+			unsigned long a5;
+			unsigned long a6;
+			unsigned long a7;
+		};
+	};
+};
+
+static __always_inline unsigned long ftrace_regs_get_instruction_pointer(const struct ftrace_regs
+									 *fregs)
+{
+	return fregs->epc;
+}
+
+static __always_inline void ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
+								unsigned long pc)
+{
+	fregs->epc = pc;
+}
+
+static __always_inline unsigned long ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->sp;
+}
+
+static __always_inline unsigned long ftrace_regs_get_argument(struct ftrace_regs *fregs,
+							      unsigned int n)
+{
+	if (n < 8)
+		return fregs->args[n];
+	return 0;
+}
+
+static __always_inline unsigned long ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
+{
+	return fregs->a0;
+}
+
+static __always_inline void ftrace_regs_set_return_value(struct ftrace_regs *fregs,
+							 unsigned long ret)
+{
+	fregs->a0 = ret;
+}
+
+static __always_inline void ftrace_override_function_with_return(struct ftrace_regs *fregs)
+{
+	fregs->epc = fregs->ra;
+}
+
+int ftrace_regs_query_register_offset(const char *name);
+
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
 
-static inline void __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
-		regs->t1 = addr;
+	fregs->t1 = addr;
 }
-#define arch_ftrace_set_direct_caller(fregs, addr) \
-	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index a03129f40c46..b09ca5f944f7 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 #include <linux/kbuild.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/ftrace.h>
 #include <linux/suspend.h>
 #include <asm/kvm_host.h>
 #include <asm/thread_info.h>
@@ -488,4 +489,21 @@ void asm_offsets(void)
 	DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
 	OFFSET(STACKFRAME_FP, stackframe, fp);
 	OFFSET(STACKFRAME_RA, stackframe, ra);
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct ftrace_regs), STACK_ALIGN));
+	DEFINE(FREGS_EPC,	    offsetof(struct ftrace_regs, epc));
+	DEFINE(FREGS_RA,	    offsetof(struct ftrace_regs, ra));
+	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
+	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
+	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
+	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
+	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
+	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
+	DEFINE(FREGS_A3,	    offsetof(struct ftrace_regs, a3));
+	DEFINE(FREGS_A4,	    offsetof(struct ftrace_regs, a4));
+	DEFINE(FREGS_A5,	    offsetof(struct ftrace_regs, a5));
+	DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
+	DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
+#endif
 }
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..cd144b0c3008 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -127,16 +127,11 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
 				       (unsigned long)func, true, true);
-	if (!ret) {
-		ret = __ftrace_modify_call((unsigned long)&ftrace_regs_call,
-					   (unsigned long)func, true, true);
-	}
-
 	return ret;
 }
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
@@ -178,16 +173,13 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
-	unsigned long *parent = (unsigned long *)&regs->ra;
-
-	prepare_ftrace_return(parent, ip, frame_pointer(regs));
+	prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
 }
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 extern void ftrace_graph_call(void);
 int ftrace_enable_ftrace_graph_caller(void)
 {
@@ -200,6 +192,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
 				    (unsigned long)&prepare_ftrace_return, false, true);
 }
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index b7561288e8da..745dd4c4a69c 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -56,138 +56,77 @@
 	addi	sp, sp, ABI_SIZE_ON_STACK
 	.endm
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 
 /**
-* SAVE_ABI_REGS - save regs against the pt_regs struct
-*
-* @all: tell if saving all the regs
-*
-* If all is set, all the regs will be saved, otherwise only ABI
-* related regs (a0-a7,epc,ra and optional s0) will be saved.
+* SAVE_ABI_REGS - save regs against the ftrace_regs struct
 *
 * After the stack is established,
 *
 * 0(sp) stores the PC of the traced function which can be accessed
-* by &(fregs)->regs->epc in tracing function. Note that the real
+* by &(fregs)->epc in tracing function. Note that the real
 * function entry address should be computed with -FENTRY_RA_OFFSET.
 *
 * 8(sp) stores the function return address (i.e. parent IP) that
-* can be accessed by &(fregs)->regs->ra in tracing function.
+* can be accessed by &(fregs)->ra in tracing function.
 *
 * The other regs are saved at the respective localtion and accessed
-* by the respective pt_regs member.
+* by the respective ftrace_regs member.
 *
 * Here is the layout of stack for your reference.
 *
 * PT_SIZE_ON_STACK  ->  +++++++++
 *                       + ..... +
-*                       + t3-t6 +
-*                       + s2-s11+
 *                       + a0-a7 + --++++-> ftrace_caller saved
-*                       + s1    +   +
-*                       + s0    + --+
-*                       + t0-t2 +   +
-*                       + tp    +   +
-*                       + gp    +   +
+*                       + t1    + --++++-> direct tramp address
+*                       + s0    + --+ // frame pointer
 *                       + sp    +   +
 *                       + ra    + --+ // parent IP
 *               sp  ->  + epc   + --+ // PC
 *                       +++++++++
 **/
-	.macro SAVE_ABI_REGS, all=0
-	addi	sp, sp, -PT_SIZE_ON_STACK
-
-	REG_S	t0,  PT_EPC(sp)
-	REG_S	x1,  PT_RA(sp)
-
-	// save the ABI regs
-
-	REG_S	x10, PT_A0(sp)
-	REG_S	x11, PT_A1(sp)
-	REG_S	x12, PT_A2(sp)
-	REG_S	x13, PT_A3(sp)
-	REG_S	x14, PT_A4(sp)
-	REG_S	x15, PT_A5(sp)
-	REG_S	x16, PT_A6(sp)
-	REG_S	x17, PT_A7(sp)
-
-	// save the leftover regs
+	.macro SAVE_ABI_REGS
+	mv	t4, sp			// Save original SP in T4
+	addi	sp, sp, -FREGS_SIZE_ON_STACK
 
-	.if \all == 1
-	REG_S	x2, PT_SP(sp)
-	REG_S	x3, PT_GP(sp)
-	REG_S	x4, PT_TP(sp)
-	REG_S	x5, PT_T0(sp)
-	REG_S	x6, PT_T1(sp)
-	REG_S	x7, PT_T2(sp)
-	REG_S	x8, PT_S0(sp)
-	REG_S	x9, PT_S1(sp)
-	REG_S	x18, PT_S2(sp)
-	REG_S	x19, PT_S3(sp)
-	REG_S	x20, PT_S4(sp)
-	REG_S	x21, PT_S5(sp)
-	REG_S	x22, PT_S6(sp)
-	REG_S	x23, PT_S7(sp)
-	REG_S	x24, PT_S8(sp)
-	REG_S	x25, PT_S9(sp)
-	REG_S	x26, PT_S10(sp)
-	REG_S	x27, PT_S11(sp)
-	REG_S	x28, PT_T3(sp)
-	REG_S	x29, PT_T4(sp)
-	REG_S	x30, PT_T5(sp)
-	REG_S	x31, PT_T6(sp)
-
-	// save s0 if FP_TEST defined
-
-	.else
+	REG_S	t0,  FREGS_EPC(sp)
+	REG_S	x1,  FREGS_RA(sp)
+	REG_S	t4,  FREGS_SP(sp)	// Put original SP on stack
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	REG_S	x8, PT_S0(sp)
+	REG_S	x8,  FREGS_S0(sp)
 #endif
-	.endif
+	REG_S	x6,  FREGS_T1(sp)
+
+	// save the arguments
+	REG_S	x10, FREGS_A0(sp)
+	REG_S	x11, FREGS_A1(sp)
+	REG_S	x12, FREGS_A2(sp)
+	REG_S	x13, FREGS_A3(sp)
+	REG_S	x14, FREGS_A4(sp)
+	REG_S	x15, FREGS_A5(sp)
+	REG_S	x16, FREGS_A6(sp)
+	REG_S	x17, FREGS_A7(sp)
 	.endm
 
 	.macro RESTORE_ABI_REGS, all=0
-	REG_L	t0, PT_EPC(sp)
-	REG_L	x1, PT_RA(sp)
-	REG_L	x10, PT_A0(sp)
-	REG_L	x11, PT_A1(sp)
-	REG_L	x12, PT_A2(sp)
-	REG_L	x13, PT_A3(sp)
-	REG_L	x14, PT_A4(sp)
-	REG_L	x15, PT_A5(sp)
-	REG_L	x16, PT_A6(sp)
-	REG_L	x17, PT_A7(sp)
-
-	.if \all == 1
-	REG_L	x2, PT_SP(sp)
-	REG_L	x3, PT_GP(sp)
-	REG_L	x4, PT_TP(sp)
-	REG_L	x6, PT_T1(sp)
-	REG_L	x7, PT_T2(sp)
-	REG_L	x8, PT_S0(sp)
-	REG_L	x9, PT_S1(sp)
-	REG_L	x18, PT_S2(sp)
-	REG_L	x19, PT_S3(sp)
-	REG_L	x20, PT_S4(sp)
-	REG_L	x21, PT_S5(sp)
-	REG_L	x22, PT_S6(sp)
-	REG_L	x23, PT_S7(sp)
-	REG_L	x24, PT_S8(sp)
-	REG_L	x25, PT_S9(sp)
-	REG_L	x26, PT_S10(sp)
-	REG_L	x27, PT_S11(sp)
-	REG_L	x28, PT_T3(sp)
-	REG_L	x29, PT_T4(sp)
-	REG_L	x30, PT_T5(sp)
-	REG_L	x31, PT_T6(sp)
-
-	.else
+	REG_L	t0, FREGS_EPC(sp)
+	REG_L	x1, FREGS_RA(sp)
 #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	REG_L	x8, PT_S0(sp)
+	REG_L	x8, FREGS_S0(sp)
 #endif
-	.endif
-	addi	sp, sp, PT_SIZE_ON_STACK
+	REG_L	x6,  FREGS_T1(sp)
+
+	// restore the arguments
+	REG_L	x10, FREGS_A0(sp)
+	REG_L	x11, FREGS_A1(sp)
+	REG_L	x12, FREGS_A2(sp)
+	REG_L	x13, FREGS_A3(sp)
+	REG_L	x14, FREGS_A4(sp)
+	REG_L	x15, FREGS_A5(sp)
+	REG_L	x16, FREGS_A6(sp)
+	REG_L	x17, FREGS_A7(sp)
+
+	addi	sp, sp, FREGS_SIZE_ON_STACK
 	.endm
 
 	.macro PREPARE_ARGS
@@ -198,9 +137,9 @@
 	mv	a3, sp
 	.endm
 
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
-#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 SYM_FUNC_START(ftrace_caller)
 	SAVE_ABI
 
@@ -227,33 +166,23 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jr	t0
 SYM_FUNC_END(ftrace_caller)
 
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
-SYM_FUNC_START(ftrace_regs_caller)
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
+SYM_FUNC_START(ftrace_caller)
 	mv	t1, zero
-	SAVE_ABI_REGS 1
+	SAVE_ABI_REGS
 	PREPARE_ARGS
 
-SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
-	RESTORE_ABI_REGS 1
+	RESTORE_ABI_REGS
 	bnez	t1, .Ldirect
 	jr	t0
 .Ldirect:
 	jr	t1
-SYM_FUNC_END(ftrace_regs_caller)
-
-SYM_FUNC_START(ftrace_caller)
-	SAVE_ABI_REGS 0
-	PREPARE_ARGS
-
-SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
-
-	RESTORE_ABI_REGS 0
-	jr	t0
 SYM_FUNC_END(ftrace_caller)
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 SYM_CODE_START(ftrace_stub_direct_tramp)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..1272264d2e9e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -822,7 +822,8 @@ static inline int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 extern int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr);
 
 #if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) || \
-	defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS)
+	defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) || \
+	defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)
 /**
  * ftrace_modify_call - convert from one addr to another (no nop)
  * @rec: the call site record (e.g. mcount/fentry)
-- 
2.40.1


