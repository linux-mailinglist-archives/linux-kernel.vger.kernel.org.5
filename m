Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0527FB371
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjK1IAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbjK1IAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD0CB;
        Tue, 28 Nov 2023 00:00:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bbb78efb5so372898e87.3;
        Tue, 28 Nov 2023 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158437; x=1701763237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BsRDUs/wYt2ci1VcBpz4SJheODmui3/KELJxnudBXg=;
        b=Uz+j2EkXwZk+5VMMOPsa7J0g4mavGHnsCvbsedTmnUrH/vxUzWTMGWqANSJafcx3u9
         bwvrcMbbb9ceauPpBrg+g8taVx9FnnbxPj2/ybM1g03ciE/TRAv/hQVNww29GcAo7Pmg
         dyqU+Wthq/ecL0EorDRTn2XNM+/5KrowHfb5ryGTR7//lHddGDQKF8v3bDIBiOeEPD/z
         ZxLB6kqz8hVFjkXUuNGHOXNB2BFH6LJ1AB6bI3uNQNdJhm+WWjnsIKgtU4lPW6FqqJyj
         xcz1q7pX3W2kqxRGRtxUOWCyRgXZN/pqwhM3CTjOPb3L4StIkbluExx4bsnnalwfmAqC
         V3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158437; x=1701763237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BsRDUs/wYt2ci1VcBpz4SJheODmui3/KELJxnudBXg=;
        b=AlIl8NdiKm4zRKK+8ZaJP1i4Nh+k3xTR0nhBHDRI+KXvWa85EGWgefEbxgzS6XEM+3
         3a75aASRg5NpHKE1mY0Wfm3t9rbN94V15ULKMsLLzD4RiJrL2bXZcGjFdlvnjFa1fy9R
         ju1ZtUQG6VZbRAnzCkqfCLnTx5OfC/aXw9kvtmxXyWOjIb2OtmkM4kC03OCvIYjULQK6
         43QNorekJ7bGe+B76ldkIFEprufBPtzzlxpgT+EkMorV7WSvvd1nUWsMithi2Z/GsIQh
         TBDG0ycmXepL7GqMEecPTzxwqyEUKvO1vsA6EvPPuLdzYEmCYP/bi/rel7XnzE9VR+Ie
         GREA==
X-Gm-Message-State: AOJu0YzM/S5AB42V6F/g22+1UG3qlMWpR7DFMOr1ShUcC4y2o+/TyQHd
        Yzpl5isrwzVqf2eo+4XkzSs=
X-Google-Smtp-Source: AGHT+IH9AKjFYiSSwd4Gl/X8xCmeiuE6ev0b1jilePlkMzKYVASLtbE6S3FbybnDTVZn4LqRpYskDw==
X-Received: by 2002:a05:6512:38cf:b0:503:3781:ac32 with SMTP id p15-20020a05651238cf00b005033781ac32mr8391110lft.41.1701158436996;
        Tue, 28 Nov 2023 00:00:36 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:36 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3 1/7] rcu: Reduce synchronize_rcu() latency
Date:   Tue, 28 Nov 2023 09:00:27 +0100
Message-Id: <20231128080033.288050-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to a synchronize_rcu() can be optimized from a latency
point of view. Workloads which depend on this can benefit of it.

The delay of wakeme_after_rcu() callback, which unblocks a waiter,
depends on several factors:

- how fast a process of offloading is started. Combination of:
    - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
    - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
    - other.
- when started, invoking path is interrupted due to:
    - time limit;
    - need_resched();
    - if limit is reached.
- where in a nocb list it is located;
- how fast previous callbacks completed;

Example:

1. On our embedded devices i can easily trigger the scenario when
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

2. We use cpuset/cgroup to classify tasks and assign them into
different cgroups. For example "backgrond" group which binds tasks
only to little CPUs or "foreground" which makes use of all CPUs.
Tasks can be migrated between groups by a request if an acceleration
is needed.

See below an example how "surfaceflinger" task gets migrated.
Initially it is located in the "system-background" cgroup which
allows to run only on little cores. In order to speed it up it
can be temporary moved into "foreground" cgroup which allows
to use big/all CPUs:

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
   TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
<snip>

"Boosting a task" depends on synchronize_rcu() latency:

- first trace shows a completion of synchronize_rcu();
- second shows attaching a task to a new group;
- last shows a final step when migration occurs.

3. To address this drawback, maintain a separate track that consists
of synchronize_rcu() callers only. After completion of a grace period
users are deferred to a dedicated worker to process requests.

4. This patch reduces the latency of synchronize_rcu() approximately
by ~30-40% on synthetic tests. The real test case, camera launch time,
shows(time is in milliseconds):

1-run 542 vs 489 improvement 9%
2-run 540 vs 466 improvement 13%
3-run 518 vs 468 improvement 9%
4-run 531 vs 457 improvement 13%
5-run 548 vs 475 improvement 13%
6-run 509 vs 484 improvement 4%

Synthetic test(no "noise" from other callbacks):
Hardware: x86_64 64 CPUs, 64GB of memory
Linux-6.6

- 10K tasks(simultaneous);
- each task does(1000 loops)
     synchronize_rcu();
     kfree(p);

default: CONFIG_RCU_NOCB_CPU: takes 54 seconds to complete all users;
patch: CONFIG_RCU_NOCB_CPU: takes 35 seconds to complete all users.

Running 60K gives approximately same results on my setup. Please note
it is without any interaction with another type of callbacks, otherwise
it will impact a lot a default case.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c     | 135 +++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h |   2 +-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..57cfa467697b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,6 +1384,105 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+/*
+ * There are three lists for handling synchronize_rcu() users.
+ * A first list corresponds to new coming users, second for users
+ * which wait for a grace period and third is for which a grace
+ * period is passed.
+ */
+static struct sr_normal_state {
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_head srs_wait;	/* wait for GP users. */
+	struct llist_head srs_done;	/* ready for GP users. */
+
+	/*
+	 * In order to add a batch of nodes to already
+	 * existing srs-done-list, a tail of srs-wait-list
+	 * is maintained.
+	 */
+	struct llist_node *srs_wait_tail;
+} sr;
+
+/* Disabled by default. */
+static int rcu_normal_wake_from_gp;
+module_param(rcu_normal_wake_from_gp, int, 0644);
+
+static void rcu_sr_normal_complete(struct llist_node *node)
+{
+	struct rcu_synchronize *rs = container_of(
+		(struct rcu_head *) node, struct rcu_synchronize, head);
+	unsigned long oldstate = (unsigned long) rs->head.func;
+
+	WARN_ONCE(!rcu_gp_is_expedited() && !poll_state_synchronize_rcu(oldstate),
+		"A full grace period is not passed yet: %lu",
+		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+
+	/* Finally. */
+	complete(&rs->completion);
+}
+
+static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
+{
+	struct llist_node *done, *rcu, *next;
+
+	done = llist_del_all(&sr.srs_done);
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
+	struct llist_node *head, *tail;
+
+	if (llist_empty(&sr.srs_wait))
+		return;
+
+	tail = READ_ONCE(sr.srs_wait_tail);
+	head = __llist_del_all(&sr.srs_wait);
+
+	if (head) {
+		/* Can be not empty. */
+		llist_add_batch(head, tail, &sr.srs_done);
+		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
+	}
+}
+
+/*
+ * Helper function for rcu_gp_init().
+ */
+static void rcu_sr_normal_gp_init(void)
+{
+	struct llist_node *head, *tail;
+
+	if (llist_empty(&sr.srs_next))
+		return;
+
+	tail = llist_del_all(&sr.srs_next);
+	head = llist_reverse_order(tail);
+
+	/*
+	 * A waiting list of GP should be empty on this step,
+	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
+	 * rolls it over. If not, it is a BUG, warn a user.
+	 */
+	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
+
+	WRITE_ONCE(sr.srs_wait_tail, tail);
+	__llist_add_batch(head, tail, &sr.srs_wait);
+}
+
+static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
+{
+	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1418,6 +1517,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
+	rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
@@ -1775,6 +1875,9 @@ static noinline void rcu_gp_cleanup(void)
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	// Make synchronize_rcu() users aware of the end of old grace period.
+	rcu_sr_normal_gp_cleanup();
+
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
@@ -3487,6 +3590,36 @@ static int rcu_blocking_is_gp(void)
 	return true;
 }
 
+/*
+ * Helper function for the synchronize_rcu() API.
+ */
+static void synchronize_rcu_normal(void)
+{
+	struct rcu_synchronize rs;
+
+	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
+		wait_rcu_gp(call_rcu_hurry);
+		return;
+	}
+
+	init_rcu_head_on_stack(&rs.head);
+	init_completion(&rs.completion);
+
+	/*
+	 * This code might be preempted, therefore take a GP
+	 * snapshot before adding a request.
+	 */
+	rs.head.func = (void *) get_state_synchronize_rcu();
+	rcu_sr_normal_add_req(&rs);
+
+	/* Kick a GP and start waiting. */
+	(void) start_poll_synchronize_rcu();
+
+	/* Now we can wait. */
+	wait_for_completion(&rs.completion);
+	destroy_rcu_head_on_stack(&rs.head);
+}
+
 /**
  * synchronize_rcu - wait until a grace period has elapsed.
  *
@@ -3538,7 +3671,7 @@ void synchronize_rcu(void)
 		if (rcu_gp_is_expedited())
 			synchronize_rcu_expedited();
 		else
-			wait_rcu_gp(call_rcu_hurry);
+			synchronize_rcu_normal();
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8239b39d945b..53cc1d389f96 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -983,7 +983,7 @@ void synchronize_rcu_expedited(void)
 
 	/* If expedited grace periods are prohibited, fall back to normal. */
 	if (rcu_gp_is_normal()) {
-		wait_rcu_gp(call_rcu_hurry);
+		synchronize_rcu_normal();
 		return;
 	}
 
-- 
2.39.2

