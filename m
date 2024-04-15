Return-Path: <linux-kernel+bounces-144619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31C8A4871
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE75B235BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372672E401;
	Mon, 15 Apr 2024 06:54:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BD2C6B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164074; cv=none; b=bvFFScacul+/9ZDWi8im9+QEMSArKWuhhPGXTVd+aLf5o2OgfP56/xY27xdYu7qDZrRXrkR8hhZ5i5ApKdiREBP4h1oh/fJVwz0T47ZiKj13pekVoTywfEx2FJnBf5MrOXw8hppEKcZfEfPdJOVIY1Y6X+UccMfLEx1O85v0d44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164074; c=relaxed/simple;
	bh=93ZY6fAk+/FoiMTXqVJsHI9FbD2ZdEAVGbJ8j10VmQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gaq3Ofc4uqak/Zj6qM+0qk1DLYj91AcX7nxVVkA11aYGEkc/I+HXKsDEpYymlBghID02H32P/+frNx8fnjx/b63gKjD/bTM6eAev6ZgraoSIhLvDnouP+wiO+0fo9+7kMakVmzTmVLnNkO/geRjbCKqaSpFzmqgW34RyJWI7NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VHyWL4xryzwSrB;
	Mon, 15 Apr 2024 14:51:26 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AAD418009D;
	Mon, 15 Apr 2024 14:54:26 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 15 Apr
 2024 14:54:24 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <horms@kernel.org>, <mhiramat@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <shahuang@redhat.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<sumit.garg@linaro.org>, <frederic@kernel.org>, <reijiw@google.com>,
	<akihiko.odaki@daynix.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH v3 5/8] arm64: Unify exception masking at entry and exit of exception
Date: Mon, 15 Apr 2024 06:47:55 +0000
Message-ID: <20240415064758.3250209-6-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415064758.3250209-1-liaochang1@huawei.com>
References: <20240415064758.3250209-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Currently, different exception types require specific mask. For example:

  - Interrupt handlers: Mask IRQ, FIQ, and NMI on entry.
  - Synchronous handler: Restore exception masks to pre-exception value.
  - Serror handler: Mask all interrupts and Serror on entry (strictest).
  - Debug handler: Keep all exception masked as exception taken.

This patch introduces new helper functions to unify exception masking
behavior at the entry and exit of exceptions on arm64. This approach
improves code clarity and maintainability.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/daifflags.h | 81 ++++++++++++++++++-------
 arch/arm64/kernel/entry-common.c   | 96 ++++++++++++++----------------
 arch/arm64/kernel/entry.S          |  2 -
 3 files changed, 105 insertions(+), 74 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index df4c4989babd..6d391d221432 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -121,28 +121,6 @@ static inline void local_daif_restore(unsigned long flags)
 		trace_hardirqs_off();
 }
 
-/*
- * Called by synchronous exception handlers to restore the DAIF bits that were
- * modified by taking an exception.
- */
-static inline void local_daif_inherit(struct pt_regs *regs)
-{
-	unsigned long flags = regs->pstate & DAIF_MASK;
-
-	if (interrupts_enabled(regs))
-		trace_hardirqs_on();
-
-	if (system_uses_irq_prio_masking())
-		gic_write_pmr(regs->pmr_save);
-
-	/*
-	 * We can't use local_daif_restore(regs->pstate) here as
-	 * system_has_prio_mask_debugging() won't restore the I bit if it can
-	 * use the pmr instead.
-	 */
-	write_sysreg(flags, daif);
-}
-
 /*
  * For Arm64 processor support Armv8.8 or later, kernel supports three types
  * of irqflags, they used for corresponding configuration depicted as below:
@@ -381,4 +359,63 @@ static inline void local_allint_inherit(struct pt_regs *regs)
 			_allint_clear();
 	}
 }
+
+/*
+ * local_allint_disable - Disable IRQ, FIQ and NMI, with or without
+ * superpriority.
+ */
+static inline void local_allint_disable(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.daif = DAIF_PROCCTX_NOIRQ;
+	irqflags.fields.pmr = GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET;
+	irqflags.fields.allint = 1;
+	local_allint_restore(irqflags);
+}
+
+/*
+ * local_allint_mark_enabled - When the kernel enables priority masking,
+ * interrupts cannot be handled util ICC_PMR_EL1 is set to GIC_PRIO_IRQON
+ * and PSTATE.IF is cleared. This helper function indicates that interrupts
+ * remains in a semi-masked state, requring further clearing of PSTATE.IF.
+ *
+ * Kernel will give a warning, if some function try to enable semi-masked
+ * interrupt via the arch_local_irq_enable() defined in <asm/irqflags.h>.
+ *
+ * This function is typically used before handling the Debug exception.
+ */
+static inline void local_allint_mark_enabled(void)
+{
+	if (system_uses_irq_prio_masking())
+		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
+}
+
+/*
+ * local_errint_disable - Disable all types of interrupt including IRQ, FIQ,
+ * Serror and NMI, with or without superpriority.
+ */
+static inline void local_errint_disable(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.daif = DAIF_ERRCTX;
+	irqflags.fields.pmr = GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET;
+	irqflags.fields.allint = 1;
+	local_allint_restore(irqflags);
+}
+
+/*
+ * local_errint_enable - Enable all types of interrupt including IRQ, FIQ,
+ * Serror and NMI, with or without superpriority.
+ */
+static inline void local_errint_enable(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.daif = DAIF_PROCCTX;
+	irqflags.fields.pmr = GIC_PRIO_IRQON;
+	irqflags.fields.allint = 0;
+	local_allint_restore(irqflags);
+}
 #endif
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b77a15955f28..99168223508b 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -168,7 +168,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
 
-	local_daif_mask();
+	local_allint_mask();
 
 	lockdep_sys_exit();
 }
@@ -428,9 +428,9 @@ static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
 	unsigned long far = read_sysreg(far_el1);
 
 	enter_from_kernel_mode(regs);
-	local_daif_inherit(regs);
+	local_allint_inherit(regs);
 	do_mem_abort(far, esr, regs);
-	local_daif_mask();
+	local_allint_mask();
 	exit_to_kernel_mode(regs);
 }
 
@@ -439,33 +439,36 @@ static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
 	unsigned long far = read_sysreg(far_el1);
 
 	enter_from_kernel_mode(regs);
-	local_daif_inherit(regs);
+	local_allint_inherit(regs);
 	do_sp_pc_abort(far, esr, regs);
-	local_daif_mask();
+	local_allint_mask();
 	exit_to_kernel_mode(regs);
 }
 
 static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
-	local_daif_inherit(regs);
+	local_allint_inherit(regs);
 	do_el1_undef(regs, esr);
-	local_daif_mask();
+	local_allint_mask();
 	exit_to_kernel_mode(regs);
 }
 
 static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
-	local_daif_inherit(regs);
+	local_allint_inherit(regs);
 	do_el1_bti(regs, esr);
-	local_daif_mask();
+	local_allint_mask();
 	exit_to_kernel_mode(regs);
 }
 
 static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 {
-	unsigned long far = read_sysreg(far_el1);
+	unsigned long far;
+
+	local_allint_mark_enabled();
+	far = read_sysreg(far_el1);
 
 	arm64_enter_el1_dbg(regs);
 	if (!cortex_a76_erratum_1463225_debug_handler(regs))
@@ -476,9 +479,9 @@ static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
 static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_kernel_mode(regs);
-	local_daif_inherit(regs);
+	local_allint_inherit(regs);
 	do_el1_fpac(regs, esr);
-	local_daif_mask();
+	local_allint_mask();
 	exit_to_kernel_mode(regs);
 }
 
@@ -543,7 +546,7 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
-	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+	local_allint_disable();
 
 	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
 		__el1_pnmi(regs, handler);
@@ -565,7 +568,7 @@ asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
 
-	local_daif_restore(DAIF_ERRCTX);
+	local_errint_disable();
 	arm64_enter_nmi(regs);
 	do_serror(regs, esr);
 	arm64_exit_nmi(regs);
@@ -576,7 +579,7 @@ static void noinstr el0_da(struct pt_regs *regs, unsigned long esr)
 	unsigned long far = read_sysreg(far_el1);
 
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_mem_abort(far, esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -594,7 +597,7 @@ static void noinstr el0_ia(struct pt_regs *regs, unsigned long esr)
 		arm64_apply_bp_hardening();
 
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_mem_abort(far, esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -602,7 +605,7 @@ static void noinstr el0_ia(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_fpsimd_acc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_fpsimd_acc(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -610,7 +613,7 @@ static void noinstr el0_fpsimd_acc(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_sve_acc(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -618,7 +621,7 @@ static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_sme_acc(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -626,7 +629,7 @@ static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_fpsimd_exc(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -634,7 +637,7 @@ static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_sys(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_sys(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -647,7 +650,7 @@ static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
 		arm64_apply_bp_hardening();
 
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_sp_pc_abort(far, esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -655,7 +658,7 @@ static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_sp_pc_abort(regs->sp, esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -663,7 +666,7 @@ static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_undef(regs, esr);
 	exit_to_user_mode(regs);
 }
@@ -671,7 +674,7 @@ static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_bti(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_bti(regs);
 	exit_to_user_mode(regs);
 }
@@ -679,7 +682,7 @@ static void noinstr el0_bti(struct pt_regs *regs)
 static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_mops(regs, esr);
 	exit_to_user_mode(regs);
 }
@@ -687,7 +690,7 @@ static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	bad_el0_sync(regs, 0, esr);
 	exit_to_user_mode(regs);
 }
@@ -695,11 +698,14 @@ static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
 static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
 {
 	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
-	unsigned long far = read_sysreg(far_el1);
+	unsigned long far;
+
+	local_allint_mark_enabled();
+	far = read_sysreg(far_el1);
 
 	enter_from_user_mode(regs);
 	do_debug_exception(far, esr, regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	exit_to_user_mode(regs);
 }
 
@@ -708,7 +714,7 @@ static void noinstr el0_svc(struct pt_regs *regs)
 	enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
 	fp_user_discard();
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_svc(regs);
 	exit_to_user_mode(regs);
 }
@@ -716,7 +722,7 @@ static void noinstr el0_svc(struct pt_regs *regs)
 static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_fpac(regs, esr);
 	exit_to_user_mode(regs);
 }
@@ -785,7 +791,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 {
 	enter_from_user_mode(regs);
 
-	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+	local_allint_disable();
 
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
@@ -797,24 +803,14 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	exit_to_user_mode(regs);
 }
 
-static void noinstr __el0_irq_handler_common(struct pt_regs *regs)
-{
-	el0_interrupt(regs, handle_arch_irq);
-}
-
 asmlinkage void noinstr el0t_64_irq_handler(struct pt_regs *regs)
 {
-	__el0_irq_handler_common(regs);
-}
-
-static void noinstr __el0_fiq_handler_common(struct pt_regs *regs)
-{
-	el0_interrupt(regs, handle_arch_fiq);
+	el0_interrupt(regs, handle_arch_irq);
 }
 
 asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
 {
-	__el0_fiq_handler_common(regs);
+	el0_interrupt(regs, handle_arch_fiq);
 }
 
 static void noinstr __el0_error_handler_common(struct pt_regs *regs)
@@ -822,11 +818,11 @@ static void noinstr __el0_error_handler_common(struct pt_regs *regs)
 	unsigned long esr = read_sysreg(esr_el1);
 
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_ERRCTX);
+	local_errint_disable();
 	arm64_enter_nmi(regs);
 	do_serror(regs, esr);
 	arm64_exit_nmi(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	exit_to_user_mode(regs);
 }
 
@@ -839,7 +835,7 @@ asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
 static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
 {
 	enter_from_user_mode(regs);
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_cp15(esr, regs);
 	exit_to_user_mode(regs);
 }
@@ -848,7 +844,7 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 	cortex_a76_erratum_1463225_svc_handler();
-	local_daif_restore(DAIF_PROCCTX);
+	local_errint_enable();
 	do_el0_svc_compat(regs);
 	exit_to_user_mode(regs);
 }
@@ -899,12 +895,12 @@ asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 
 asmlinkage void noinstr el0t_32_irq_handler(struct pt_regs *regs)
 {
-	__el0_irq_handler_common(regs);
+	el0_interrupt(regs, handle_arch_irq);
 }
 
 asmlinkage void noinstr el0t_32_fiq_handler(struct pt_regs *regs)
 {
-	__el0_fiq_handler_common(regs);
+	el0_interrupt(regs, handle_arch_fiq);
 }
 
 asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ef0e127b149..0b311fefedc2 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -316,8 +316,6 @@ alternative_else_nop_endif
 
 	mrs_s	x20, SYS_ICC_PMR_EL1
 	str	x20, [sp, #S_PMR_SAVE]
-	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
-	msr_s	SYS_ICC_PMR_EL1, x20
 
 .Lskip_pmr_save\@:
 #endif
-- 
2.34.1


