Return-Path: <linux-kernel+bounces-49440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29396846A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7591F217D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752218C28;
	Fri,  2 Feb 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anlPeXsQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953F18658
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861448; cv=none; b=YJ5SdYelmP32V3WJ9ZZmuEQZOpdyetACuqhFFboobVH/WYEk3LU0/x64cqEJ/+Swre4jfMrJqoUsk5Pk8PIfKhoLwYG5UlfqE4J2l188PynAWB3PSBt9NjHsOMG1+W+IEO15KRTfHJg1XhJ9tI89XMSXFmtW4io3/L7lCIJTmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861448; c=relaxed/simple;
	bh=Zk2mQ+ZW7M5p5xaR77pQtedUVa3RgHq4JSSfbueXse4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2ZVtPYSX020Xt22N2wuUOqxIo2zw9UvY61WwQufs54BhuxnGMHuysEc9avSt0ASYJrBtBdhZYn/eUVhTqArO2GEJ+PAlgn8ZXIiDTUYLWNB+IbzMNcLg4HHTdcOqxYIRYRy6ONVOr1vOB3Dj7nSSTlaK1BurPK6r72EF7w+OlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anlPeXsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWiW15gYCd0qq5hmfxU5I8UTcZTFW4ysIqeBM84iI5Y=;
	b=anlPeXsQPG37DeisH0PRA/kAA1MDRcU5pHlNSWKRmnKqAMxVRn/smSrQ4OOUP9hHhpUsoN
	/odbLvP0hFbwrcRtPPAmNICScyZh4pKqEqSJengL7AMvaV2K6JhZRv0AVDcGJPZUmnZ2Tu
	MxmtIYHc9+CmBkSagrIHiyszppRqHS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-tjCGo5PvMb2pCh-tcMxXTQ-1; Fri,
 02 Feb 2024 03:10:43 -0500
X-MC-Unique: tjCGo5PvMb2pCh-tcMxXTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F00E22812FFA;
	Fri,  2 Feb 2024 08:10:42 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A3ADC2590E;
	Fri,  2 Feb 2024 08:10:40 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Segall <bsegall@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH v2 2/5] sched: Note schedule() invocations at return-to-user with SM_USER
Date: Fri,  2 Feb 2024 09:09:17 +0100
Message-ID: <20240202080920.3337862-3-vschneid@redhat.com>
In-Reply-To: <20240202080920.3337862-1-vschneid@redhat.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

task_struct.in_return_to_user is currently updated via atomic operations in
schedule_usermode().

However, one can note:
o .in_return_to_user is only updated for the current task
o There are no remote (smp_processor_id() != task_cpu(p)) accesses to
  .in_return_to_user

Add schedule_with_mode() to factorize schedule() with different flags to
pass down to __schedule_loop().

Add SM_USER to denote schedule() calls from return-to-userspace points.

Update .in_return_to_user from within the preemption-disabled, rq_lock-held
part of __schedule().

Suggested-by: Benjamin Segall <bsegall@google.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/sched.h |  2 +-
 kernel/sched/core.c   | 43 ++++++++++++++++++++++++++++++++-----------
 kernel/sched/fair.c   | 17 ++++++++++++++++-
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4a0105d1eaa21..1b6f17b2150a6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1544,7 +1544,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
-	atomic_t			in_return_to_user;
+	int				in_return_to_user;
 #endif
 	/*
 	 * New fields for task_struct should be added above here, so that
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7c028fad5a89..54e6690626b13 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4531,7 +4531,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	INIT_LIST_HEAD(&p->se.kernel_node);
-	atomic_set(&p->in_return_to_user, 0);
+	p->in_return_to_user            = false;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -5147,6 +5147,9 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 
 static inline void finish_lock_switch(struct rq *rq)
 {
+#ifdef CONFIG_CFS_BANDWIDTH
+	current->in_return_to_user = false;
+#endif
 	/*
 	 * If we are tracking spinlock dependencies then we have to
 	 * fix up the runqueue lock - which gets 'carried over' from
@@ -6562,6 +6565,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 #define SM_PREEMPT		0x1
 #define SM_RTLOCK_WAIT		0x2
 
+/*
+ * Special case for CFS_BANDWIDTH where we need to know if the call to
+ * __schedule() is directely preceding an entry into userspace.
+ * It is removed from the mode argument as soon as it is used to not go against
+ * the SM_MASK_PREEMPT optimisation below.
+ */
+#ifdef CONFIG_CFS_BANDWIDTH
+# define SM_USER                0x4
+#else
+# define SM_USER                SM_NONE
+#endif
+
 #ifndef CONFIG_PREEMPT_RT
 # define SM_MASK_PREEMPT	(~0U)
 #else
@@ -6646,6 +6661,14 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq_lock(rq, &rf);
 	smp_mb__after_spinlock();
 
+#ifdef CONFIG_CFS_BANDWIDTH
+	if (sched_mode & SM_USER) {
+		prev->in_return_to_user = true;
+		sched_mode &= ~SM_USER;
+	}
+#endif
+	SCHED_WARN_ON(sched_mode & SM_USER);
+
 	/* Promote REQ to ACT */
 	rq->clock_update_flags <<= 1;
 	update_rq_clock(rq);
@@ -6807,7 +6830,7 @@ static __always_inline void __schedule_loop(unsigned int sched_mode)
 	} while (need_resched());
 }
 
-asmlinkage __visible void __sched schedule(void)
+static __always_inline void schedule_with_mode(unsigned int sched_mode)
 {
 	struct task_struct *tsk = current;
 
@@ -6817,22 +6840,20 @@ asmlinkage __visible void __sched schedule(void)
 
 	if (!task_is_running(tsk))
 		sched_submit_work(tsk);
-	__schedule_loop(SM_NONE);
+	__schedule_loop(sched_mode);
 	sched_update_worker(tsk);
 }
+
+asmlinkage __visible void __sched schedule(void)
+{
+	schedule_with_mode(SM_NONE);
+}
 EXPORT_SYMBOL(schedule);
 
 asmlinkage __visible void __sched schedule_usermode(void)
 {
 #ifdef CONFIG_CFS_BANDWIDTH
-	/*
-	 * This is only atomic because of this simple implementation. We could
-	 * do something with an SM_USER to avoid other-cpu scheduler operations
-	 * racing against these writes.
-	 */
-	atomic_set(&current->in_return_to_user, true);
-	schedule();
-	atomic_set(&current->in_return_to_user, false);
+	schedule_with_mode(SM_USER);
 #else
 	schedule();
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1808459a5acc..96504be6ee14a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6631,7 +6631,22 @@ static void enqueue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int c
 
 static bool is_kernel_task(struct task_struct *p)
 {
-	return sysctl_sched_cfs_bandwidth_kernel_bypass && !atomic_read(&p->in_return_to_user);
+	/*
+	 * The flag is updated within __schedule() with preemption disabled,
+	 * under the rq lock, and only when the task is current.
+	 *
+	 * Holding the rq lock for that task's CPU is thus sufficient for the
+	 * value to be stable, if the task is enqueued.
+	 *
+	 * If the task is dequeued, then task_cpu(p) *can* change, but this
+	 * so far only happens in enqueue_task_fair() which means either:
+	 * - the task is being activated, its CPU has been set previously in ttwu()
+	 * - the task is going through a "change" cycle (e.g. sched_move_task()),
+	 *   the pi_lock is also held so the CPU is stable.
+	 */
+	lockdep_assert_rq_held(cpu_rq(task_cpu(p)));
+
+	return sysctl_sched_cfs_bandwidth_kernel_bypass && !p->in_return_to_user;
 }
 
 /*
-- 
2.43.0


