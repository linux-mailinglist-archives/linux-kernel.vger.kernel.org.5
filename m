Return-Path: <linux-kernel+bounces-163669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB38B6E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838651F22FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFC41C8FB6;
	Tue, 30 Apr 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGiOWVvV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37131C68B7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468760; cv=none; b=bHaR0CYo6d4eWeJiae8HMCoIbLZFmzstBmWoxKrnEPrNqVLVXiZ6icPNiJe57YIS+4d6tboTPGXqHtElBN9EJxJRUo+gHi0LNmXTzPCszmPAh/xd5YxsmoDA4hDUYwCRyk0iIsd4JG1QG7yqGRsNlcGESV3qZXQ2Tu6+DcSwrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468760; c=relaxed/simple;
	bh=IOaoHCkzMuAirmGkG57WlQLrQtka+5wgy8w8O2/LKrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntd8jcqynQRaMI8yHMP470oz2OiQaiTsrQBK5RMNekIGkqvP9ytImiJ0v6T408TF93HSBKalvy21uoUizIo76leKcQ+Bm81YAJnAVdpAJzbd1zLxl1ETqQuIso2lhJ2qRlXq1pKV3BwOwhj8IyNqkrxJnOrF04mG9OfiHVvYoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGiOWVvV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn791+67rWwiUJr/Ta/g1hShm4NiN4HCHRVNGLR9ND8=;
	b=YGiOWVvVt5hgcu7R4h80uwb0y31DROW6sfKjCT5hTdSaPqlrNqG6wgz8tgZuUDFIsQol6T
	u1FkVeZSA3Pcx9ER4mLdP+oMMlbJKV9gyCXMSqSbebK3cilkd7eWl43y95yQZUgcvQUZYQ
	BwQVh4k0zYgjLlWoYK6URu7yMVz4V5o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-4tSKRNm5NqmgwJHW6HHx_Q-1; Tue, 30 Apr 2024 05:19:14 -0400
X-MC-Unique: 4tSKRNm5NqmgwJHW6HHx_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77E980B3DD;
	Tue, 30 Apr 2024 09:19:13 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1627540C5C2;
	Tue, 30 Apr 2024 09:19:10 +0000 (UTC)
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
Subject: [PATCH v2 24/27] rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
Date: Tue, 30 Apr 2024 11:17:28 +0200
Message-ID: <20240430091740.1826862-25-vschneid@redhat.com>
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
RCU_WATCHING, replace "dyntick_idle" into "eqs" to drop the dyntick
reference.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/rcutiny.h      | 2 +-
 include/linux/rcutree.h      | 2 +-
 kernel/rcu/rcutorture.c      | 4 ++--
 kernel/rcu/tree.c            | 4 ++--
 kernel/rcu/tree_nocb.h       | 2 +-
 kernel/rcu/tree_plugin.h     | 6 +++---
 kernel/stop_machine.c        | 2 +-
 kernel/trace/trace_osnoise.c | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aeab..cf2b5a188f783 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -158,7 +158,7 @@ void rcu_scheduler_starting(void);
 static inline void rcu_end_inkernel_boot(void) { }
 static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
 static inline bool rcu_is_watching(void) { return true; }
-static inline void rcu_momentary_dyntick_idle(void) { }
+static inline void rcu_momentary_eqs(void) { }
 static inline void kfree_rcu_scheduler_running(void) { }
 static inline bool rcu_gp_might_be_stalled(void) { return false; }
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 254244202ea97..7dbde2b6f714a 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -37,7 +37,7 @@ void synchronize_rcu_expedited(void);
 void kvfree_call_rcu(struct rcu_head *head, void *ptr);
 
 void rcu_barrier(void);
-void rcu_momentary_dyntick_idle(void);
+void rcu_momentary_eqs(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cafe047d046e8..dcd1f47748a2f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2679,7 +2679,7 @@ static unsigned long rcu_torture_fwd_prog_cbfree(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(freed);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
@@ -2829,7 +2829,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 		rcu_torture_fwd_prog_cond_resched(n_launders + n_max_cbs);
 		if (tick_nohz_full_enabled()) {
 			local_irq_save(flags);
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 			local_irq_restore(flags);
 		}
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b375c6006ed6b..e4783a5d18e0d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -355,7 +355,7 @@ bool rcu_watching_zero_in_eqs(int cpu, int *vp)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-notrace void rcu_momentary_dyntick_idle(void)
+notrace void rcu_momentary_eqs(void)
 {
 	int seq;
 
@@ -365,7 +365,7 @@ notrace void rcu_momentary_dyntick_idle(void)
 	WARN_ON_ONCE(!(seq & CT_RCU_WATCHING));
 	rcu_preempt_deferred_qs(current);
 }
-EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
+EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
 
 /**
  * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3f85577bddd4e..2e0d2ff2ee8df 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -951,7 +951,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 
 
 	local_irq_save(flags);
-	rcu_momentary_dyntick_idle();
+	rcu_momentary_eqs();
 	local_irq_restore(flags);
 	/*
 	 * Disable BH to provide the expected environment.  Also, when
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f652..903e70ec39fc6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -859,7 +859,7 @@ static void rcu_qs(void)
 
 /*
  * Register an urgently needed quiescent state.  If there is an
- * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
+ * emergency, invoke rcu_momentary_eqs() to do a heavy-weight
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
@@ -879,7 +879,7 @@ void rcu_all_qs(void)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
@@ -899,7 +899,7 @@ void rcu_note_context_switch(bool preempt)
 		goto out;
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 out:
 	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a9..da821ce258ea7 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -251,7 +251,7 @@ static int multi_cpu_stop(void *data)
 			 */
 			touch_nmi_watchdog();
 		}
-		rcu_momentary_dyntick_idle();
+		rcu_momentary_eqs();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271c..a41e8a8212647 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1535,7 +1535,7 @@ static int run_osnoise(void)
 		 * This will eventually cause unwarranted noise as PREEMPT_RCU
 		 * will force preemption as the means of ending the current
 		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
+		 * rcu_momentary_eqs(), which performs a zero duration
 		 * EQS allowing PREEMPT_RCU to end the current grace period.
 		 * This call shouldn't be wrapped inside an RCU critical
 		 * section.
@@ -1547,7 +1547,7 @@ static int run_osnoise(void)
 			if (!disable_irq)
 				local_irq_disable();
 
-			rcu_momentary_dyntick_idle();
+			rcu_momentary_eqs();
 
 			if (!disable_irq)
 				local_irq_enable();
-- 
2.43.0


