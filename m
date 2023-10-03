Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524367B707F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbjJCSEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbjJCSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:04:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E12BB;
        Tue,  3 Oct 2023 11:04:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so2236528a12.2;
        Tue, 03 Oct 2023 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696356246; x=1696961046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24a+mbw42cbjXBU1qU0bJoifqhTWtmSErBlgCs6Gs0c=;
        b=G8FXCr2FUdP5B8rl9RcCBm21fgnGFPWLnZ5i7hZyWONKWbZLNpCAS4kraCKBln/K17
         TqOk/sOcAY4xbv/qWCoyj0sNLPJYX2MAo/CyUFDlNVS/kV/40yI0xGeniLnlLsnXyLht
         pKOwbQ0kzoUK8qlMAJ+DGVXWcSfs0PsiZld5zBIFD0+GgXy1Z7Tv1ni0qlpVW7JdbS0k
         WwHWUTX500UKX8Hkqepvz+RcFpryGp9lGY8pbZnAFr/2mT49IxX67fOT7HAi+1mocr7y
         oArXqfbIGEwURDHTQbsgZcbgghQSjFx+6yjHQj1/NCuaN2veFuT2UN751LasBXlm44o1
         ZlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356246; x=1696961046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24a+mbw42cbjXBU1qU0bJoifqhTWtmSErBlgCs6Gs0c=;
        b=mmqacoFtCz/5JevJhOtqomoSUfXmKJGWt7INEyLpz+UotZ1CetCj941f1vHBGCtPUu
         MseMOJQRIX4tmxEvDi4WrJZIjaNRX39mno26EKHmevxZVLvVrd6wJQ0MgRLA336uiOpw
         8222q/UHCCVFosgATEZF3CegcThfSUbAGg37Ow39E6iZ7Ut0wWuSd1UofgXyjCbk2Vsc
         TaMwZ5iJ8ndXwLW6dojStgklDZnLjRKlYrGZ204+mabqwyIBnGHw1s68Kj/a74hidpHo
         OWg4NFqPVm9lpo1vkGp6aEdWRBS+dRWThiWwrrxpqLGYh0GsRxLOHrja+X+SSgCzCTxG
         RidA==
X-Gm-Message-State: AOJu0Yx+WtURbJClzpwVbPhCL3XVT3Jvb5H/cNgoOz4gpVhQWcyVrMuZ
        +6zoxLWnNlegBB0aHR7m/JY=
X-Google-Smtp-Source: AGHT+IFKCgft2LpUD1WKlaBEB8nn/G48FYN5U98YbhpMI+zaHLxyDueVn51bLkJ2gL40c+yI+hBLZQ==
X-Received: by 2002:aa7:c159:0:b0:534:78a6:36c4 with SMTP id r25-20020aa7c159000000b0053478a636c4mr13511077edp.36.1696356245499;
        Tue, 03 Oct 2023 11:04:05 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402064b00b0053782c81c69sm1181645edx.96.2023.10.03.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:04:05 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 1/1] rcu: Reduce synchronize_rcu() waiting time
Date:   Tue,  3 Oct 2023 20:04:03 +0200
Message-Id: <20231003180403.58576-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to a synchronize_rcu() can be optimized from time point of
view. Different workloads can be affected by this especially the
ones which use this API in its time critical sections.

For example if CONFIG_RCU_NOCB_CPU is set, the wakeme_after_rcu()
callback can be delayed and such delay depends on where in a nocb
list it is located.

1. On our Android devices i can easily trigger the scenario when
it is a last in the list out of ~3600 callbacks:

<snip>
  <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
...
  <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
  <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
  <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
<snip>

2. On our Android devices we use cpuset/cgroup to classify tasks
and assign them into different cgroups. For example "backgrond"
group which binds tasks only to little CPUs or "foreground" that
binds to all CPUs, i.e. tasks can be migrated between groups.

See below an example of how "surfaceflinger" task is migrated.
Initially it is located in the "system-background" cgroup which
allows to run only on little cores. In order to speedup it up
it can be temporary moved into "foreground" cgroup which allows
to use big CPUs:

cgroup_attach_task():
 -> cgroup_migrate_execute()
   -> cpuset_can_attach()
     -> percpu_down_write()
       -> rcu_sync_enter()
         -> synchronize_rcu()
   -> now move tasks to the new cgroup.
 -> cgroup_migrate_finish()

<snip>
         rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
    PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
    PERFD-SERVER-1855    [000] d..1.  7030.530383: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
   TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
<snip>

from this example it is clear that "a moving time" also depends
on how fast synchronize_rcu() completes.

3. This patch improves the synchronize_rcu() approximately by 30%-50%
on synthetic tests. Apart of that i have tested app launch of camera
app where i also see better perf. figures:

542 vs 489 diff: 9%
540 vs 466 diff: 13%
518 vs 468 diff: 9%
531 vs 457 diff: 13%
548 vs 475 diff: 13%
509 vs 484 diff: 4%

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c     | 151 +++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h |   2 +-
 2 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78554e7181dd..a347c1f98f11 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,6 +1384,122 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+/*
+ * There are three lists for handling synchronize_rcu() users.
+ * A first list corresponds to new coming users, second for users
+ * which wait for a grace period and third is for which a grace
+ * period is passed.
+ */
+static struct sr_normal_state {
+	struct llist_head curr;	/* request a GP users. */
+	struct llist_head wait;	/* wait for GP users. */
+	struct llist_head done;	/* ready for GP users. */
+	struct llist_node *curr_tail;
+	struct llist_node *wait_tail;
+	atomic_t active;
+} sr;
+
+/* Enable it by default. */
+static int rcu_normal_wake_from_gp = 1;
+module_param(rcu_normal_wake_from_gp, int, 0644);
+
+static void rcu_sr_normal_complete(struct llist_node *node)
+{
+	struct rcu_synchronize *rs = container_of(
+		(struct rcu_head *) node, struct rcu_synchronize, head);
+	unsigned long oldstate = (unsigned long) rs->head.func;
+
+	if (!poll_state_synchronize_rcu(oldstate))
+		WARN_ONCE(1, "A full grace period is not passed yet: %lu",
+			rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+
+	/* Finally. */
+	complete(&rs->completion);
+}
+
+static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
+{
+	struct llist_node *done, *rcu, *next;
+
+	done = llist_del_all(&sr.done);
+	if (!done)
+		return;
+
+	llist_for_each_safe(rcu, next, done)
+		rcu_sr_normal_complete(rcu);
+}
+static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
+
+/*
+ * Helper function for rcu_gp_cleanup().
+ */
+static void rcu_sr_normal_gp_cleanup(void)
+{
+	struct llist_node *first, *tail;
+
+	tail = READ_ONCE(sr.wait_tail);
+	first = llist_del_all(&sr.wait);
+	if (!first)
+		return;
+
+	/* Only one user? */
+	if (!first->next) {
+		rcu_sr_normal_complete(first);
+		return;
+	}
+
+	/* Can be not empty. */
+	llist_add_batch(first, tail, &sr.done);
+	queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
+}
+
+/*
+ * Helper function for rcu_gp_init().
+ */
+static void rcu_sr_normal_gp_init(void)
+{
+	struct llist_node *llnode, *rcu;
+	int ret;
+
+	if (llist_empty(&sr.curr))
+		return;
+
+	/*
+	 * A waiting list of GP should be empty on this step,
+	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
+	 * rolls it over. If not, it is a BUG, warn a user.
+	 */
+	WARN_ON_ONCE(!llist_empty(&sr.wait));
+
+	/*
+	 * Obtain a tail of current active users. It is guaranteed
+	 * that if we are only one active user and the list is not
+	 * empty, the tail has already been updated.
+	 */
+	ret = atomic_inc_return(&sr.active);
+	WRITE_ONCE(sr.wait_tail, (ret == 1) ? READ_ONCE(sr.curr_tail):NULL);
+	llnode = llist_del_all(&sr.curr);
+	atomic_dec(&sr.active);
+
+	if (ret != 1) {
+		llist_for_each(rcu, llnode) {
+			if (!rcu->next)
+				WRITE_ONCE(sr.wait_tail, rcu);
+		}
+	}
+
+	llist_add_batch(llnode, READ_ONCE(sr.wait_tail), &sr.wait);
+}
+
+static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
+{
+	atomic_inc(&sr.active);
+	if (llist_add((struct llist_node *) &rs->head, &sr.curr))
+		/* Set the tail. Only first and one user can do that. */
+		WRITE_ONCE(sr.curr_tail, (struct llist_node *) &rs->head);
+	atomic_dec(&sr.active);
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1420,6 +1536,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
+	rcu_sr_normal_gp_init();
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -1787,6 +1904,9 @@ static noinline void rcu_gp_cleanup(void)
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	// Make synchronize_rcu() users aware of the end of old grace period.
+	rcu_sr_normal_gp_cleanup();
+
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
@@ -3500,6 +3620,35 @@ static int rcu_blocking_is_gp(void)
 	return true;
 }
 
+/*
+ * Helper function for the synchronize_rcu() API.
+ */
+static void synchronize_rcu_normal(void)
+{
+	struct rcu_synchronize rs;
+
+	if (READ_ONCE(rcu_normal_wake_from_gp)) {
+		init_rcu_head_on_stack(&rs.head);
+		init_completion(&rs.completion);
+
+		/*
+		 * This code might be preempted, therefore take a GP
+		 * snapshot before adding a request.
+		 */
+		rs.head.func = (void *) get_state_synchronize_rcu();
+		rcu_sr_normal_add_req(&rs);
+
+		/* Kick a GP and start waiting. */
+		(void) start_poll_synchronize_rcu();
+
+		/* Now we can wait. */
+		wait_for_completion(&rs.completion);
+		destroy_rcu_head_on_stack(&rs.head);
+	} else {
+		wait_rcu_gp(call_rcu_hurry);
+	}
+}
+
 /**
  * synchronize_rcu - wait until a grace period has elapsed.
  *
@@ -3551,7 +3700,7 @@ void synchronize_rcu(void)
 		if (rcu_gp_is_expedited())
 			synchronize_rcu_expedited();
 		else
-			wait_rcu_gp(call_rcu_hurry);
+			synchronize_rcu_normal();
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d7cea5d591f..279a37beb05a 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -987,7 +987,7 @@ void synchronize_rcu_expedited(void)
 
 	/* If expedited grace periods are prohibited, fall back to normal. */
 	if (rcu_gp_is_normal()) {
-		wait_rcu_gp(call_rcu_hurry);
+		synchronize_rcu_normal();
 		return;
 	}
 
-- 
2.30.2

