Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E441679DCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbjILXoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjILXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:44:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29631705;
        Tue, 12 Sep 2023 16:44:21 -0700 (PDT)
Date:   Tue, 12 Sep 2023 23:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694562260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RZfpFEZqxiG28iaHo1HAONvFQhCKjL16UIOL0uhKqPs=;
        b=bVnoVoxUkMHKWf1JaiX89ZVpggkFZ2tbqkoibPCAjy1EQ7xuQL1uAaeRPE1wdTf9Afj15S
        OjkOJS9golHl3Tt3jcLvPNKO49Gh6JkbsOr9PVn/iLMYqhNhwn0gPQVlIR5wbPffGR+LKO
        El12qUOqkzkVnOOWgszJ1bqlPoRQg8/tDwrIRQidOUOrpkU4DaaTGYcA0xv2EfAA+EK4UX
        ZQp5ClwZ/0Hva7lMY2IJcvr9EDMmFLoTqSeieYe44r22YVeu/OL5OVZFfQxtjFqVvYaPZu
        XJT1jenLdW2yW+bZ14jbYQ3jj9tnHKDA+omRasLSpRBQe+KgqVSnGeKZvQNa6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694562260;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RZfpFEZqxiG28iaHo1HAONvFQhCKjL16UIOL0uhKqPs=;
        b=DKiSDJz5RG257mXLGWgKopRLFprhb3Ai84nhA2DbRaGwtZFJgQP6U/WSFgI3Sas8xpbsaJ
        aHUdEFPk74JUoYAA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Remove 'struct tdx_hypercall_args'
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169456225971.27769.51743966979126683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     8a8544bde858e5d62d79df6baaa387e0b6587dc7
Gitweb:        https://git.kernel.org/tip/8a8544bde858e5d62d79df6baaa387e0b6587dc7
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Tue, 15 Aug 2023 23:02:03 +12:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Sep 2023 16:30:14 -07:00

x86/tdx: Remove 'struct tdx_hypercall_args'

Now 'struct tdx_hypercall_args' is basically 'struct tdx_module_args'
minus RCX.  Although from __tdx_hypercall()'s perspective RCX isn't
used as shared register thus not part of input/output registers, it's
not worth to have a separate structure just due to one register.

Remove the 'struct tdx_hypercall_args' and use 'struct tdx_module_args'
instead in __tdx_hypercall() related code.  This also saves the memory
copy between the two structures within __tdx_hypercall().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/798dad5ce24e9d745cf0e16825b75ccc433ad065.1692096753.git.kai.huang%40intel.com
---
 arch/x86/boot/compressed/tdx.c    |  4 +--
 arch/x86/coco/tdx/tdx-shared.c    | 37 +++++-------------------------
 arch/x86/coco/tdx/tdx.c           | 18 +++++++--------
 arch/x86/hyperv/ivm.c             |  6 ++---
 arch/x86/include/asm/shared/tdx.h | 25 +-------------------
 5 files changed, 23 insertions(+), 67 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index bc03eae..8451d6a 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -18,7 +18,7 @@ void __tdx_hypercall_failed(void)
 
 static inline unsigned int tdx_io_in(int size, u16 port)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
@@ -34,7 +34,7 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 
 static inline void tdx_io_out(int size, u16 port, u32 value)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 344b381..78e4132 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -70,45 +70,22 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 	return true;
 }
 
-noinstr u64 __tdx_hypercall(struct tdx_hypercall_args *args)
+noinstr u64 __tdx_hypercall(struct tdx_module_args *args)
 {
-	struct tdx_module_args margs = {
-		.rcx = TDVMCALL_EXPOSE_REGS_MASK,
-		.rdx = args->rdx,
-		.r8  = args->r8,
-		.r9  = args->r9,
-		.r10 = args->r10,
-		.r11 = args->r11,
-		.r12 = args->r12,
-		.r13 = args->r13,
-		.r14 = args->r14,
-		.r15 = args->r15,
-		.rbx = args->rbx,
-		.rdi = args->rdi,
-		.rsi = args->rsi,
-	};
+	/*
+	 * For TDVMCALL explicitly set RCX to the bitmap of shared registers.
+	 * The caller isn't expected to set @args->rcx anyway.
+	 */
+	args->rcx = TDVMCALL_EXPOSE_REGS_MASK;
 
 	/*
 	 * Failure of __tdcall_saved_ret() indicates a failure of the TDVMCALL
 	 * mechanism itself and that something has gone horribly wrong with
 	 * the TDX module.  __tdx_hypercall_failed() never returns.
 	 */
-	if (__tdcall_saved_ret(TDG_VP_VMCALL, &margs))
+	if (__tdcall_saved_ret(TDG_VP_VMCALL, args))
 		__tdx_hypercall_failed();
 
-	args->r8  = margs.r8;
-	args->r9  = margs.r9;
-	args->r10 = margs.r10;
-	args->r11 = margs.r11;
-	args->r12 = margs.r12;
-	args->r13 = margs.r13;
-	args->r14 = margs.r14;
-	args->r15 = margs.r15;
-	args->rdi = margs.rdi;
-	args->rsi = margs.rsi;
-	args->rbx = margs.rbx;
-	args->rdx = margs.rdx;
-
 	/* TDVMCALL leaf return code is in R10 */
 	return args->r10;
 }
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26b6c3d..3e6dbd2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -48,7 +48,7 @@ noinstr void __noreturn __tdx_hypercall_failed(void)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = nr,
 		.r11 = p1,
 		.r12 = p2,
@@ -108,7 +108,7 @@ EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
 static void __noreturn tdx_panic(const char *msg)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
 		.r12 = 0, /* Error code: 0 is Panic */
@@ -230,7 +230,7 @@ static int ve_instr_len(struct ve_info *ve)
 
 static u64 __cpuidle __halt(const bool irq_disabled)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_HLT),
 		.r12 = irq_disabled,
@@ -274,7 +274,7 @@ void __cpuidle tdx_safe_halt(void)
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_MSR_READ),
 		.r12 = regs->cx,
@@ -295,7 +295,7 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
 		.r12 = regs->cx,
@@ -315,7 +315,7 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_CPUID),
 		.r12 = regs->ax,
@@ -357,7 +357,7 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
 		.r12 = size,
@@ -486,7 +486,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
@@ -723,7 +723,7 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	}
 
 	while (retry_count < max_retries_per_page) {
-		struct tdx_hypercall_args args = {
+		struct tdx_module_args args = {
 			.r10 = TDX_HYPERCALL_STANDARD,
 			.r11 = TDVMCALL_MAP_GPA,
 			.r12 = start,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index e489835..c1088d3 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -384,7 +384,7 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 #ifdef CONFIG_INTEL_TDX_GUEST
 static void hv_tdx_msr_write(u64 msr, u64 val)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = EXIT_REASON_MSR_WRITE,
 		.r12 = msr,
@@ -398,7 +398,7 @@ static void hv_tdx_msr_write(u64 msr, u64 val)
 
 static void hv_tdx_msr_read(u64 msr, u64 *val)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = EXIT_REASON_MSR_READ,
 		.r12 = msr,
@@ -414,7 +414,7 @@ static void hv_tdx_msr_read(u64 msr, u64 *val)
 
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 {
-	struct tdx_hypercall_args args = { };
+	struct tdx_module_args args = { };
 
 	args.r10 = control;
 	args.rdx = param1;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index f53a419..b69886e 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -85,29 +85,8 @@ u64 __tdcall(u64 fn, struct tdx_module_args *args);
 u64 __tdcall_ret(u64 fn, struct tdx_module_args *args);
 u64 __tdcall_saved_ret(u64 fn, struct tdx_module_args *args);
 
-/*
- * Used in __tdx_hypercall() to pass down and get back registers' values of
- * the TDCALL instruction when requesting services from the VMM.
- *
- * This is a software only structure and not part of the TDX module/VMM ABI.
- */
-struct tdx_hypercall_args {
-	u64 r8;
-	u64 r9;
-	u64 r10;
-	u64 r11;
-	u64 r12;
-	u64 r13;
-	u64 r14;
-	u64 r15;
-	u64 rdi;
-	u64 rsi;
-	u64 rbx;
-	u64 rdx;
-};
-
 /* Used to request services from the VMM */
-u64 __tdx_hypercall(struct tdx_hypercall_args *args);
+u64 __tdx_hypercall(struct tdx_module_args *args);
 
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
@@ -115,7 +94,7 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args);
  */
 static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = fn,
 		.r12 = r12,
