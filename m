Return-Path: <linux-kernel+bounces-163643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48F8B6E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14A41F230FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A912129E8A;
	Tue, 30 Apr 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5HkKA0X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581B12882C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468710; cv=none; b=T4BxR5D+pvHoG5lt0SE8JW6I/8TLIHeLz/vhe3bpHvd4ajdI3p0Zpb/6YyY36wa8qp525t+tgUVn4u6KOJqp2XQajDMDwEFAQQ1popXuQYKeBKTJY1T+hJVslqOgFgndCH/sQ9/cVMElFGI7kmyg6LeYESrTCCdnkVKHa2z0Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468710; c=relaxed/simple;
	bh=x1AyfeU/dYaYjaeNNUHoVUJoeqcm9AlNkWoqOGYy63I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zki046EIYIAouhrZeLkR6SpKfjqAcg6sAhlKf5nvBQhvRJuYwmo1RK5Zbcz5EnvoL+//m0UteqaF/m4Lf0PR8QGAZFGUw7Yh9ZEAoT8w8AF123THI1fdX/+k6aqV9C9mWoE29c+rQMYoWpKmAjYFVx+1vi3arJV5ZN+1mZW70e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5HkKA0X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXQy90AST059wOFCRAtXHdG3xHlU1ZzuXKQdGg5EjjQ=;
	b=h5HkKA0XqonS5n8H1Ql09jxQPv2vSls6ydPElhCj2BVZLMG07xracxISTDoV5Q96DFdKJm
	Q4ubjqouKxmrufsZ/DuXEbNXS+RexwYhLPtk34Rgkv0EVdboNxnJuzyKp0RebqHC4xlATD
	HciRUvxykRbkl12TMSV25Zv00oW96WI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-IE2pKSUhPWCymcIEbKPd3g-1; Tue, 30 Apr 2024 05:18:23 -0400
X-MC-Unique: IE2pKSUhPWCymcIEbKPd3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46BAB89A7E2;
	Tue, 30 Apr 2024 09:18:23 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D2F40C5C3;
	Tue, 30 Apr 2024 09:18:20 +0000 (UTC)
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
Subject: [PATCH v2 06/27] context_tracking, rcu: Rename struct context_tracking .dynticks_nesting into .nesting
Date: Tue, 30 Apr 2024 11:17:10 +0200
Message-ID: <20240430091740.1826862-7-vschneid@redhat.com>
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

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Data-Structures/Data-Structures.rst     | 10 +++++-----
 include/linux/context_tracking_state.h                 |  6 +++---
 include/trace/events/rcu.h                             |  2 +-
 kernel/context_tracking.c                              | 10 +++++-----
 kernel/rcu/tree.c                                      |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index b34990c7c3778..57ffc33d3cce2 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -935,7 +935,7 @@ This portion of the rcu_data structure is declared as follows:
 
 ::
 
-     1   long dynticks_nesting;
+     1   long nesting;
      2   long dynticks_nmi_nesting;
      3   atomic_t dynticks;
      4   bool rcu_need_heavy_qs;
@@ -945,7 +945,7 @@ These fields in the rcu_data structure maintain the per-CPU dyntick-idle
 state for the corresponding CPU. The fields may be accessed only from
 the corresponding CPU (and from tracing) unless otherwise stated.
 
-The ``->dynticks_nesting`` field counts the nesting depth of process
+The ``->nesting`` field counts the nesting depth of process
 execution, so that in normal circumstances this counter has value zero
 or one. NMIs, irqs, and tracers are counted by the
 ``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
@@ -960,9 +960,9 @@ process-level transitions.
 However, it turns out that when running in non-idle kernel context, the
 Linux kernel is fully capable of entering interrupt handlers that never
 exit and perhaps also vice versa. Therefore, whenever the
-``->dynticks_nesting`` field is incremented up from zero, the
+``->nesting`` field is incremented up from zero, the
 ``->dynticks_nmi_nesting`` field is set to a large positive number, and
-whenever the ``->dynticks_nesting`` field is decremented down to zero,
+whenever the ``->nesting`` field is decremented down to zero,
 the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
 the number of misnested interrupts is not sufficient to overflow the
 counter, this approach corrects the ``->dynticks_nmi_nesting`` field
@@ -992,7 +992,7 @@ code.
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why not simply combine the ``->dynticks_nesting`` and                 |
+| Why not simply combine the ``->nesting`` and                 |
 | ``->dynticks_nmi_nesting`` counters into a single counter that just   |
 | counts the number of reasons that the corresponding CPU is non-idle?  |
 +-----------------------------------------------------------------------+
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index ad6570ffeff3c..65290e7677e6c 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -39,7 +39,7 @@ struct context_tracking {
 	atomic_t state;
 #endif
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-	long dynticks_nesting;		/* Track process nesting level. */
+	long nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
 #endif
 };
@@ -77,14 +77,14 @@ static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 
 static __always_inline long ct_dynticks_nesting(void)
 {
-	return __this_cpu_read(context_tracking.dynticks_nesting);
+	return __this_cpu_read(context_tracking.nesting);
 }
 
 static __always_inline long ct_dynticks_nesting_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
-	return ct->dynticks_nesting;
+	return ct->nesting;
 }
 
 static __always_inline long ct_dynticks_nmi_nesting(void)
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 31b3e0d3e65f7..4066b6d51e46a 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -469,7 +469,7 @@ TRACE_EVENT(rcu_stall_warning,
  * polarity: "Start", "End", "StillNonIdle" for entering, exiting or still not
  *            being in dyntick-idle mode.
  * context: "USER" or "IDLE" or "IRQ".
- * NMIs nested in IRQs are inferred with dynticks_nesting > 1 in IRQ context.
+ * NMIs nested in IRQs are inferred with nesting > 1 in IRQ context.
  *
  * These events also take a pair of numbers, which indicate the nesting
  * depth before and after the event of interest, and a third number that is
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 738a9ff4f1f51..ddf9cfa58039f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -28,7 +28,7 @@
 
 DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-	.dynticks_nesting = 1,
+	.nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 #endif
 	.state = ATOMIC_INIT(CT_RCU_WATCHING),
@@ -131,7 +131,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 		     ct_dynticks_nesting() == 0);
 	if (ct_dynticks_nesting() != 1) {
 		// RCU will still be watching, so just do accounting and leave.
-		ct->dynticks_nesting--;
+		ct->nesting--;
 		return;
 	}
 
@@ -145,7 +145,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
 	instrumentation_end();
-	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	WRITE_ONCE(ct->nesting, 0); /* Avoid irq-access tearing. */
 	// RCU is watching here ...
 	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
@@ -170,7 +170,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		// RCU was already watching, so just do accounting and leave.
-		ct->dynticks_nesting++;
+		ct->nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
@@ -184,7 +184,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 
 	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	WRITE_ONCE(ct->dynticks_nesting, 1);
+	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
 	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5f6400a97471b..7f3fa9bb34e92 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -388,7 +388,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
-			 "RCU dynticks_nesting counter underflow!");
+			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
@@ -596,7 +596,7 @@ void rcu_irq_exit_check_preempt(void)
 	lockdep_assert_irqs_disabled();
 
 	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
-			 "RCU dynticks_nesting counter underflow/zero!");
+			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  dynticks_nmi_nesting counter\n");
@@ -4797,7 +4797,7 @@ rcu_boot_init_percpu_data(int cpu)
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
-	WARN_ON_ONCE(ct->dynticks_nesting != 1);
+	WARN_ON_ONCE(ct->nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
@@ -4891,7 +4891,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->qlen_last_fqs_check = 0;
 	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
 	rdp->blimit = blimit;
-	ct->dynticks_nesting = 1;	/* CPU not up, no tearing. */
+	ct->nesting = 1;	/* CPU not up, no tearing. */
 	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
-- 
2.43.0


