Return-Path: <linux-kernel+bounces-163639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FD8B6E08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F35B21E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDB127E31;
	Tue, 30 Apr 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8uPqxwB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DE1292CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468700; cv=none; b=UDowp7IpYpFgnjtCxeEHypGn8rS73XyynrhNsmvQ7mc334K1Fp/99LRWfaQfvBGd0tMaeiFqlq2W+ro9NV029QulzjRJy1erQ65NOIzeJp2t8vC6BB60dvVp79EBNXGOqM/rZx3zpZzAit4ePhY1yxFmOQDqBUDLk5J5tm3ZW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468700; c=relaxed/simple;
	bh=Jkb9EnW7KJJWQPCXWZ7+fqlyh6FVyXt/G10deCM6JUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUcE+pMWVchfL7hbHH5BXIZYwZL/JgOC8js9+eYsdpkXKgThoATkQE5jmnOoo6qDF8JFq2MKK1X9Nzq60FEx1q8HwqvoHfxOxUb7snqlquKban7GEWpFLoHWE3IaC20DdycD0CZsXrlM0oz31gNERQD5VK1Di0nCdeTNsWvjrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8uPqxwB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmFcbdfw7yMnCu5UmJGdDPcav9/8FYIzdG1/SV9AqiY=;
	b=F8uPqxwBL6/QDVDATHxXNq7KAgW9BZ2gck3jbshcDm2IXoEA0w001zDnuDVA8bUmYf6ywm
	YFII6OnfS1ACWLI04Qjwt2DIcZfXjRVSgBPAIm+yCA5MyOPitVhapRBZua8wxtecHb9K1B
	hEPDAqQJeIPCzJAdNNX1Vet4+6r5VfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-brgU1gkYMMCOIsrit2JQ2w-1; Tue, 30 Apr 2024 05:18:13 -0400
X-MC-Unique: brgU1gkYMMCOIsrit2JQ2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8205F89A7E0;
	Tue, 30 Apr 2024 09:18:12 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA485492BC7;
	Tue, 30 Apr 2024 09:18:09 +0000 (UTC)
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
Subject: [PATCH v2 02/27] context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
Date: Tue, 30 Apr 2024 11:17:06 +0200
Message-ID: <20240430091740.1826862-3-vschneid@redhat.com>
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

The symbols relating to the CT_STATE part of context_tracking.state are now
all prefixed with CT_STATE.

The RCU dynticks counter part of that atomic variable still involves
symbols with different prefixes, align them all to be prefixed with
CT_RCU_WATCHING.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking.h       |  6 +++---
 include/linux/context_tracking_state.h | 12 ++++++------
 kernel/context_tracking.c              | 22 +++++++++++-----------
 kernel/rcu/tree.c                      | 12 ++++++------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 28fcfa1849032..a6c36780cc3bd 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -119,7 +119,7 @@ extern void ct_idle_exit(void);
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & RCU_DYNTICKS_IDX);
+	return !(raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING);
 }
 
 /*
@@ -142,7 +142,7 @@ static __always_inline bool warn_rcu_enter(void)
 	preempt_disable_notrace();
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 		ret = true;
-		ct_state_inc(RCU_DYNTICKS_IDX);
+		ct_state_inc(CT_RCU_WATCHING);
 	}
 
 	return ret;
@@ -151,7 +151,7 @@ static __always_inline bool warn_rcu_enter(void)
 static __always_inline void warn_rcu_exit(bool rcu)
 {
 	if (rcu)
-		ct_state_inc(RCU_DYNTICKS_IDX);
+		ct_state_inc(CT_RCU_WATCHING);
 	preempt_enable_notrace();
 }
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f1c53125edee2..94d6a935af3be 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -18,11 +18,11 @@ enum ctx_state {
 	CT_STATE_MAX		= 4,
 };
 
-/* Even value for idle, else odd. */
-#define RCU_DYNTICKS_IDX CT_STATE_MAX
+/* Odd value for watching, else even. */
+#define CT_RCU_WATCHING CT_STATE_MAX
 
 #define CT_STATE_MASK (CT_STATE_MAX - 1)
-#define CT_DYNTICKS_MASK (~CT_STATE_MASK)
+#define CT_RCU_WATCHING_MASK (~CT_STATE_MASK)
 
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
@@ -58,21 +58,21 @@ static __always_inline int __ct_state(void)
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
 static __always_inline int ct_dynticks(void)
 {
-	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_DYNTICKS_MASK;
+	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return atomic_read(&ct->state) & CT_DYNTICKS_MASK;
+	return atomic_read(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
 static __always_inline int ct_dynticks_cpu_acquire(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return atomic_read_acquire(&ct->state) & CT_DYNTICKS_MASK;
+	return atomic_read_acquire(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
 static __always_inline long ct_dynticks_nesting(void)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 21f2cf90ed0bf..9f009de83cc8e 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -31,7 +31,7 @@ DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #endif
-	.state = ATOMIC_INIT(RCU_DYNTICKS_IDX),
+	.state = ATOMIC_INIT(CT_RCU_WATCHING),
 };
 EXPORT_SYMBOL_GPL(context_tracking);
 
@@ -90,7 +90,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & RCU_DYNTICKS_IDX));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
 }
 
 /*
@@ -110,7 +110,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & RCU_DYNTICKS_IDX));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
 }
 
 /*
@@ -236,7 +236,7 @@ void noinstr ct_nmi_exit(void)
 	instrumentation_end();
 
 	// RCU is watching here ...
-	ct_kernel_exit_state(RCU_DYNTICKS_IDX);
+	ct_kernel_exit_state(CT_RCU_WATCHING);
 	// ... but is no longer watching here.
 
 	if (!in_nmi())
@@ -277,7 +277,7 @@ void noinstr ct_nmi_enter(void)
 			rcu_dynticks_task_exit();
 
 		// RCU is not watching here ...
-		ct_kernel_enter_state(RCU_DYNTICKS_IDX);
+		ct_kernel_enter_state(CT_RCU_WATCHING);
 		// ... but is watching here.
 
 		instrumentation_begin();
@@ -317,7 +317,7 @@ void noinstr ct_nmi_enter(void)
 void noinstr ct_idle_enter(void)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CT_STATE_IDLE);
+	ct_kernel_exit(false, CT_RCU_WATCHING + CT_STATE_IDLE);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
@@ -335,7 +335,7 @@ void noinstr ct_idle_exit(void)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CT_STATE_IDLE);
+	ct_kernel_enter(false, CT_RCU_WATCHING - CT_STATE_IDLE);
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
@@ -504,7 +504,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * CPU doesn't need to maintain the tick for RCU maintenance purposes
 			 * when the CPU runs in userspace.
 			 */
-			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
+			ct_kernel_exit(true, CT_RCU_WATCHING + state);
 
 			/*
 			 * Special case if we only track user <-> kernel transitions for tickless
@@ -534,7 +534,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
 				 * with NMIs. OTOH we don't care about ordering here since
-				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
+				 * RCU only requires CT_RCU_WATCHING increments to be fully
 				 * ordered.
 				 */
 				raw_atomic_add(state, &ct->state);
@@ -620,7 +620,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * Exit RCU idle mode while entering the kernel because it can
 			 * run a RCU read side critical section anytime.
 			 */
-			ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
+			ct_kernel_enter(true, CT_RCU_WATCHING - state);
 			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
@@ -644,7 +644,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
 				 * with NMIs. OTOH we don't care about ordering here since
-				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
+				 * RCU only requires CT_RCU_WATCHING increments to be fully
 				 * ordered.
 				 */
 				raw_atomic_sub(state, &ct->state);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2fe08e6186b4d..84befc91799a3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -291,9 +291,9 @@ void rcu_softirq_qs(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	if (ct_dynticks() & RCU_DYNTICKS_IDX)
+	if (ct_dynticks() & CT_RCU_WATCHING)
 		return;
-	ct_state_inc(RCU_DYNTICKS_IDX);
+	ct_state_inc(CT_RCU_WATCHING);
 }
 
 /*
@@ -312,7 +312,7 @@ static int rcu_dynticks_snap(int cpu)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & RCU_DYNTICKS_IDX);
+	return !(snap & CT_RCU_WATCHING);
 }
 
 /*
@@ -334,7 +334,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = ct_dynticks_cpu(cpu) & ~RCU_DYNTICKS_IDX;
+	snap = ct_dynticks_cpu(cpu) & ~CT_RCU_WATCHING;
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
@@ -360,9 +360,9 @@ notrace void rcu_momentary_dyntick_idle(void)
 	int seq;
 
 	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	seq = ct_state_inc(2 * RCU_DYNTICKS_IDX);
+	seq = ct_state_inc(2 * CT_RCU_WATCHING);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(seq & RCU_DYNTICKS_IDX));
+	WARN_ON_ONCE(!(seq & CT_RCU_WATCHING));
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
-- 
2.43.0


