Return-Path: <linux-kernel+bounces-163638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718268B6E07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956B1B22F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841EA128820;
	Tue, 30 Apr 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgzraMoF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57961127B68
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468695; cv=none; b=IcoEMQMfcNlCPvKjJZhTldJd/5GHESYp/x61KIcClxajaFrEPozwBIUcdxPK7bWCjGarY98VpcE+UDjp2UidizpVjNGmFNdUM0uu3KXNQNKB3KLtYzlIGiEtJS2T/YWtAGN1bu96DrwklGO9TM5ijtTJ6CWB+UtO+wCXxpRdZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468695; c=relaxed/simple;
	bh=Ja1ED46WgVnvWwML+MgdqnCcyB3o0ANZxFG2vxwCLQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5lt8SU5dJcgNwd8fL7TZ9l2L5ni+XIU0oTjHCQjGrLDpehCvjBYHMGdwy4llClG9fe/p2vXVF8xBRpJ1gbu3lrJVAstDFnoT9qbWsrREy1G51z89yurbKX8d0QCjqj6FkMUNEY9y74IH7j2dv4hawyjMdGWpiynEWPiwF2hl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgzraMoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDODcq1rwfWi96WG53da0E3MiuOFbZ6/kk8vvrnWpMI=;
	b=DgzraMoFXax/8mcAuVEAeCudojSBAHlbImUog4iGV1pFpuwfJK/C320YpftIE08/x3lMDA
	5WtOQsQpDOVyW4tjSc4r+052c68Uuh8JzNfQ6dL9u3ifUkp4XTntqh4yU6n2XBzjaaFNSB
	HsatGzEQGk402Ef/9sXZkmizs7+ADtw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308--T3vzZk-P9CO3UgI-B8gEQ-1; Tue,
 30 Apr 2024 05:18:10 -0400
X-MC-Unique: -T3vzZk-P9CO3UgI-B8gEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CB4629ABA0D;
	Tue, 30 Apr 2024 09:18:09 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E08492BC7;
	Tue, 30 Apr 2024 09:18:05 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 01/27] treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
Date: Tue, 30 Apr 2024 11:17:05 +0200
Message-ID: <20240430091740.1826862-2-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Context tracking state related symbols currently use a mix of the
CONTEXT_ (e.g. CONTEXT_KERNEL) and CT_SATE_ (e.g. CT_STATE_MASK) prefixes.

Clean up the naming and make the ctx_state enum use the CT_STATE_ prefix.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/Kconfig                           |  2 +-
 arch/arm64/kernel/entry-common.c       |  2 +-
 arch/powerpc/include/asm/interrupt.h   |  6 +++---
 arch/powerpc/kernel/interrupt.c        |  6 +++---
 arch/powerpc/kernel/syscall.c          |  2 +-
 arch/x86/entry/common.c                |  2 +-
 include/linux/context_tracking.h       | 16 ++++++++--------
 include/linux/context_tracking_state.h | 20 ++++++++++----------
 include/linux/entry-common.h           |  2 +-
 kernel/context_tracking.c              | 12 ++++++------
 kernel/entry/common.c                  |  2 +-
 kernel/sched/core.c                    |  4 ++--
 12 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 93d5010dfc92e..1289f30bb137a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -845,7 +845,7 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	  Architecture neither relies on exception_enter()/exception_exit()
 	  nor on schedule_user(). Also preempt_schedule_notrace() and
 	  preempt_schedule_irq() can't be called in a preemptible section
-	  while context tracking is CONTEXT_USER. This feature reflects a sane
+	  while context tracking is CT_STATE_USER. This feature reflects a sane
 	  entry implementation where the following requirements are met on
 	  critical entry code, ie: before user_exit() or after user_enter():
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b77a15955f28b..3fcd9d080bf2a 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -103,7 +103,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
 static __always_inline void __enter_from_user_mode(void)
 {
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	CT_WARN_ON(ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
 	trace_hardirqs_off_finish();
 	mte_disable_tco_entry(current);
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 7b610864b3645..dcb4bd8529f68 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -177,7 +177,7 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		kuap_lock();
-		CT_WARN_ON(ct_state() != CONTEXT_USER);
+		CT_WARN_ON(ct_state() != CT_STATE_USER);
 		user_exit_irqoff();
 
 		account_cpu_user_entry();
@@ -189,8 +189,8 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 		 * so avoid recursion.
 		 */
 		if (TRAP(regs) != INTERRUPT_PROGRAM)
-			CT_WARN_ON(ct_state() != CONTEXT_KERNEL &&
-				   ct_state() != CONTEXT_IDLE);
+			CT_WARN_ON(ct_state() != CT_STATE_KERNEL &&
+				   ct_state() != CT_STATE_IDLE);
 		INT_SOFT_MASK_BUG_ON(regs, is_implicit_soft_masked(regs));
 		INT_SOFT_MASK_BUG_ON(regs, arch_irq_disabled_regs(regs) &&
 					   search_kernel_restart_table(regs->nip));
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e8..af62ec974b970 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -266,7 +266,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	unsigned long ret = 0;
 	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
 
-	CT_WARN_ON(ct_state() == CONTEXT_USER);
+	CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	kuap_assert_locked();
 
@@ -344,7 +344,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	BUG_ON(regs_is_unrecoverable(regs));
 	BUG_ON(arch_irq_disabled_regs(regs));
-	CT_WARN_ON(ct_state() == CONTEXT_USER);
+	CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	/*
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
@@ -386,7 +386,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64) &&
 	    TRAP(regs) != INTERRUPT_PROGRAM &&
 	    TRAP(regs) != INTERRUPT_PERFMON)
-		CT_WARN_ON(ct_state() == CONTEXT_USER);
+		CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	kuap = kuap_get_and_assert_locked();
 
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index f6f868e817e63..be159ad4b77bd 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -27,7 +27,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 
 	trace_hardirqs_off(); /* finish reconciling */
 
-	CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
+	CT_WARN_ON(ct_state() == CT_STATE_KERNEL);
 	user_exit_irqoff();
 
 	BUG_ON(regs_is_unrecoverable(regs));
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6356060caaf31..f42a125093e54 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -150,7 +150,7 @@ early_param("ia32_emulation", ia32_emulation_override_cmdline);
 #endif
 
 /*
- * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
+ * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
  */
 static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 {
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 6e76b9dba00e7..28fcfa1849032 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -26,26 +26,26 @@ extern void user_exit_callable(void);
 static inline void user_enter(void)
 {
 	if (context_tracking_enabled())
-		ct_user_enter(CONTEXT_USER);
+		ct_user_enter(CT_STATE_USER);
 
 }
 static inline void user_exit(void)
 {
 	if (context_tracking_enabled())
-		ct_user_exit(CONTEXT_USER);
+		ct_user_exit(CT_STATE_USER);
 }
 
 /* Called with interrupts disabled.  */
 static __always_inline void user_enter_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_enter(CONTEXT_USER);
+		__ct_user_enter(CT_STATE_USER);
 
 }
 static __always_inline void user_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_exit(CONTEXT_USER);
+		__ct_user_exit(CT_STATE_USER);
 }
 
 static inline enum ctx_state exception_enter(void)
@@ -57,7 +57,7 @@ static inline enum ctx_state exception_enter(void)
 		return 0;
 
 	prev_ctx = __ct_state();
-	if (prev_ctx != CONTEXT_KERNEL)
+	if (prev_ctx != CT_STATE_KERNEL)
 		ct_user_exit(prev_ctx);
 
 	return prev_ctx;
@@ -67,7 +67,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 {
 	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK) &&
 	    context_tracking_enabled()) {
-		if (prev_ctx != CONTEXT_KERNEL)
+		if (prev_ctx != CT_STATE_KERNEL)
 			ct_user_enter(prev_ctx);
 	}
 }
@@ -75,7 +75,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 static __always_inline bool context_tracking_guest_enter(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_enter(CONTEXT_GUEST);
+		__ct_user_enter(CT_STATE_GUEST);
 
 	return context_tracking_enabled_this_cpu();
 }
@@ -83,7 +83,7 @@ static __always_inline bool context_tracking_guest_enter(void)
 static __always_inline void context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_exit(CONTEXT_GUEST);
+		__ct_user_exit(CT_STATE_GUEST);
 }
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bbff5f7f88030..f1c53125edee2 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -10,18 +10,18 @@
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
 enum ctx_state {
-	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
-	CONTEXT_KERNEL		= 0,
-	CONTEXT_IDLE		= 1,
-	CONTEXT_USER		= 2,
-	CONTEXT_GUEST		= 3,
-	CONTEXT_MAX		= 4,
+	CT_STATE_DISABLED	= -1,	/* returned by ct_state() if unknown */
+	CT_STATE_KERNEL		= 0,
+	CT_STATE_IDLE		= 1,
+	CT_STATE_USER		= 2,
+	CT_STATE_GUEST		= 3,
+	CT_STATE_MAX		= 4,
 };
 
 /* Even value for idle, else odd. */
-#define RCU_DYNTICKS_IDX CONTEXT_MAX
+#define RCU_DYNTICKS_IDX CT_STATE_MAX
 
-#define CT_STATE_MASK (CONTEXT_MAX - 1)
+#define CT_STATE_MASK (CT_STATE_MAX - 1)
 #define CT_DYNTICKS_MASK (~CT_STATE_MASK)
 
 struct context_tracking {
@@ -123,14 +123,14 @@ static inline bool context_tracking_enabled_this_cpu(void)
  *
  * Returns the current cpu's context tracking state if context tracking
  * is enabled.  If context tracking is disabled, returns
- * CONTEXT_DISABLED.  This should be used primarily for debugging.
+ * CT_STATE_DISABLED.  This should be used primarily for debugging.
  */
 static __always_inline int ct_state(void)
 {
 	int ret;
 
 	if (!context_tracking_enabled())
-		return CONTEXT_DISABLED;
+		return CT_STATE_DISABLED;
 
 	preempt_disable();
 	ret = __ct_state();
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d9..1e50cdb83ae50 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -108,7 +108,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
 
 	instrumentation_begin();
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 70ae70d038233..21f2cf90ed0bf 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -317,7 +317,7 @@ void noinstr ct_nmi_enter(void)
 void noinstr ct_idle_enter(void)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CONTEXT_IDLE);
+	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CT_STATE_IDLE);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
@@ -335,7 +335,7 @@ void noinstr ct_idle_exit(void)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
+	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CT_STATE_IDLE);
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
@@ -485,7 +485,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * user_exit() or ct_irq_enter(). Let's remove RCU's dependency
 			 * on the tick.
 			 */
-			if (state == CONTEXT_USER) {
+			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				trace_user_enter(0);
 				vtime_user_enter(current);
@@ -621,7 +621,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * run a RCU read side critical section anytime.
 			 */
 			ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
-			if (state == CONTEXT_USER) {
+			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
 				trace_user_exit(0);
@@ -634,12 +634,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CT_STATE_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CT_STATE_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc385880..5b6934e23c21d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -182,7 +182,7 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long nr = syscall_get_nr(current, regs);
 
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
 
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6d..35dd462a55abe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5980,7 +5980,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
-	SCHED_WARN_ON(ct_state() == CONTEXT_USER);
+	SCHED_WARN_ON(ct_state() == CT_STATE_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
@@ -6875,7 +6875,7 @@ asmlinkage __visible void __sched schedule_user(void)
 	 * we find a better solution.
 	 *
 	 * NB: There are buggy callers of this function.  Ideally we
-	 * should warn if prev_state != CONTEXT_USER, but that will trigger
+	 * should warn if prev_state != CT_STATE_USER, but that will trigger
 	 * too frequently to make sense yet.
 	 */
 	enum ctx_state prev_state = exception_enter();
-- 
2.43.0


