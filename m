Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C7B75AE65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGTMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGTM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:29:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F130E2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689856174; x=1721392174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YEbrpqxDeNxFsY1HDeP7iHhWD4JGdZ0gsDdoqmQzleU=;
  b=PWstHa48pAyLbx3imAHqvs2C3srVZmwIqxeXtgo80bCa+mxqcHAlsQ4v
   2hIYwVCDlhGE1uwyOAKGVtu6Le3qyTN8IxZ9GsObKHVzXa3Gkut4f/JaZ
   XYS+1Uap6no63gMalMcp0lT+eFf0zaxUkkAAPNiU5d/azqrJbdf1xFgE7
   YlR1xEo/b5R5wxexglUGouGA7TuexPoWBVz+ECmAue8HDW4vGNIxewiSr
   bUVGg/1WI2aM9eMrmMpX3RoNpIXXb7E1crVG+lmcDzaR/wiQG/A88fP3R
   wNgS2SRcK3N1iuz8flrUWiufKm7dhGqom1YdFsQV5tJXFXJhQ1JbV7ESR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356678124"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="356678124"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898255976"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898255976"
Received: from moorer9x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.157.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 05:29:20 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com, kai.huang@intel.com
Subject: [PATCH v2 09/11] x86/tdx: Remove 'struct tdx_hypercall_args'
Date:   Fri, 21 Jul 2023 00:28:12 +1200
Message-ID: <7cd441f86d5da65c496761a8c25c929727fa41d8.1689855280.git.kai.huang@intel.com>
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

Now 'struct tdx_hypercall_args' is basically 'struct tdx_module_args'
minus RCX.  Although from __tdx_hypercall()'s perspective RCX isn't
used as shared register thus not part of input/output registers, it's
not worth to have a separate structure just due to one register.

Remove the 'struct tdx_hypercall_args' and use 'struct tdx_module_args'
instead in __tdx_hypercall() related code.  This also saves the memory
copy between the two structures within __tdx_hypercall().

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v1 -> v2:
 - The third patch (new) split from v1 "x86/tdx: Unify TDX_HYPERCALL
   and TDX_MODULE_CALL assembly"
 - Rebase to 6.5-rc2.

---
 arch/x86/boot/compressed/tdx.c    |  4 ++--
 arch/x86/coco/tdx/tdx-shared.c    | 37 ++++++-------------------------
 arch/x86/coco/tdx/tdx.c           | 16 ++++++-------
 arch/x86/include/asm/shared/tdx.h | 25 ++-------------------
 4 files changed, 19 insertions(+), 63 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index bc03eae2c560..8451d6a1030c 100644
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
index 20e8794762e1..9b04959e6c5e 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -70,45 +70,22 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 	return true;
 }
 
-u64 __tdx_hypercall(struct tdx_hypercall_args *args)
+u64 __tdx_hypercall(struct tdx_module_args *args)
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
index aba58484ba10..125dda0b7827 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -46,7 +46,7 @@ void __tdx_hypercall_failed(void)
 long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		       unsigned long p3, unsigned long p4)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = nr,
 		.r11 = p1,
 		.r12 = p2,
@@ -106,7 +106,7 @@ EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
 static void __noreturn tdx_panic(const char *msg)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = TDVMCALL_REPORT_FATAL_ERROR,
 		.r12 = 0, /* Error code: 0 is Panic */
@@ -228,7 +228,7 @@ static int ve_instr_len(struct ve_info *ve)
 
 static u64 __cpuidle __halt(const bool irq_disabled)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_HLT),
 		.r12 = irq_disabled,
@@ -272,7 +272,7 @@ void __cpuidle tdx_safe_halt(void)
 
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_MSR_READ),
 		.r12 = regs->cx,
@@ -293,7 +293,7 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_MSR_WRITE),
 		.r12 = regs->cx,
@@ -313,7 +313,7 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 
 static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_CPUID),
 		.r12 = regs->ax,
@@ -355,7 +355,7 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 
 static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
 		.r12 = size,
@@ -484,7 +484,7 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
 static bool handle_in(struct pt_regs *regs, int size, int port)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
 		.r12 = size,
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 188e8bf3332c..74fc466dfdcd 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -83,29 +83,8 @@ u64 __tdcall(u64 fn, struct tdx_module_args *args);
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
@@ -113,7 +92,7 @@ u64 __tdx_hypercall(struct tdx_hypercall_args *args);
  */
 static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 {
-	struct tdx_hypercall_args args = {
+	struct tdx_module_args args = {
 		.r10 = TDX_HYPERCALL_STANDARD,
 		.r11 = fn,
 		.r12 = r12,
-- 
2.41.0

