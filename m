Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B67CFEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbjJSQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346483AbjJSQBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:01:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C61B6;
        Thu, 19 Oct 2023 09:01:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso86698921fa.3;
        Thu, 19 Oct 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697731293; x=1698336093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crsWXLaNu8stpc9UbUBARmJyDhC0F5IFx1SPVWaLc2c=;
        b=SQ3CauygRpdURwJ6v1teNZG2EW8OVFKBtkwEUyKeCjQbwudAAiG/fS8C0KJdTKEQOg
         7klOinpTy1SrknV4BB+Q+8M3h8SXuSRN1cNUmQNS6xjF5vjAMa3UoBTPtxAy1GNxIV5O
         PTcSK2bgP04pD+wOBONLMJfhDIQrYq0E9M41EkvBrln9T1mMnk46yPH1adeRZMFzU+6u
         +fh4SVp7qSelXA6R/C5KeDTa/Hm30Ndxu5u13eLvNPyVV+/o8ZFz6muSNuQM2OEenAT2
         6/Ib8P0HXicTGqH/PslMXy9aDBClUDI1bLHPqexm7Gx5PyX3qwhb344EByy22vTWzpwr
         T6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731293; x=1698336093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crsWXLaNu8stpc9UbUBARmJyDhC0F5IFx1SPVWaLc2c=;
        b=w95lcSpROl1GBi9tj/oXGjYBSzYI3zFSovKWVDb7dW0lx30XeiGGmE8mLHJzVQ2/E1
         HHvT7VFMyuHMaxAWVOOAmW/qAHRBlB7Ohg1RLu5q61Ez+0XUL0zGKQVBg9cBBZBoKvoA
         irJEjRLHtMnr+NWyZUwEZQ2e2dzQyez4EuXJe+m/uBqW5lDqoxkXXgo9YmW0uie8k4wC
         LJ8hwuqwuDnGWoGP/nSe5blRkXsG+fVm47T7WydQ1os3l2s/xR7e5M/38gWGB2jBbRk6
         b1sbngyZB2WtgZHpbRsvuLW9NWcwxJSk5WKfa5lkTver7mYbudmJtp8YywM9WiMnPs3P
         OE1g==
X-Gm-Message-State: AOJu0Yzk2Dqfr09MwbY0F1FCaUfyjD1tiQrGEOo3PSP5Rze3wtxqzGmt
        9jJ5nprYNoiOmwTk4q24WO4=
X-Google-Smtp-Source: AGHT+IF6GFOb+8UoyMDw/5VN+yw2cbb6W1VxRQr+7g/jp9yTjTtnWfh6REFKshkKXAeD27oEOUzqqg==
X-Received: by 2002:a2e:3a14:0:b0:2c5:2813:5538 with SMTP id h20-20020a2e3a14000000b002c528135538mr1727956lja.21.1697731293158;
        Thu, 19 Oct 2023 09:01:33 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a37-20020a05651c212500b002b6ad323248sm1160772ljq.10.2023.10.19.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:01:32 -0700 (PDT)
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
Subject: [PATCH v4 1/1] rcu: Reduce synchronize_rcu() waiting time
Date:   Thu, 19 Oct 2023 18:01:31 +0200
Message-Id: <20231019160131.51152-1-urezki@gmail.com>
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
callback can be delayed and such delay depends on:

- where in a nocb list it is located;
- how fast previous callbacks completed.

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
    PERFD-SERVER-1855    [000] d..1.  7030.530383: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
   TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
<snip>

"A moving time" depends on how fast synchronize_rcu() completes. See
the first trace line. The migration has not occurred until the sync
was done first. Please note, number of different callbacks to be
invoked can be thousands.

3. To address this drawback, maintain a separate track that consists
of synchronize_rcu() callers only. The GP-kthread, that drivers a GP
either wake-ups a worker to drain all list or directly wakes-up end
user if it is one in the drain list.

4. This patch improves the performance of synchronize_rcu() approximately
by ~30% on synthetic tests. The real test case, camera launch time, shows
below figures(time is in milliseconds):

542 vs 489 diff: 9%
540 vs 466 diff: 13%
518 vs 468 diff: 9%
531 vs 457 diff: 13%
548 vs 475 diff: 13%
509 vs 484 diff: 4%

Synthetic test:

Hardware: x86_64 64 CPUs, 64GB of memory

- 60.000 tasks(simultaneous);
- each task does(1000 loops)
     synchronize_rcu();
     kfree(p);

default: CONFIG_RCU_NOCB_CPU: takes 323 seconds to complete all users;
patch: CONFIG_RCU_NOCB_CPU: takes 240 seconds to complete all users.

Please note, by default this functionality is OFF and the old way is
still used instead, In order to activate it, please do:

echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c     | 150 +++++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h |   2 +-
 2 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 78554e7181dd..9c7659bbd235 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,6 +1384,121 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
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
+
+	/*
+	 * In order to quickly add a batch of nodes to already
+	 * existing list, which is done, a tail is maintained.
+	 */
+	struct llist_node *wait_tail;
+} sr;
+
+/* Disable it by default. */
+static int rcu_normal_wake_from_gp = 0;
+module_param(rcu_normal_wake_from_gp, int, 0644);
+
+static void rcu_sr_normal_complete(struct llist_node *node)
+{
+	struct rcu_synchronize *rs = container_of(
+		(struct rcu_head *) node, struct rcu_synchronize, head);
+	unsigned long oldstate = (unsigned long) rs->head.func;
+
+	WARN_ONCE(!poll_state_synchronize_rcu(oldstate),
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
+ * This is hard-coded and it is a maximum number of
+ * synchronize_rcu() users(might be +1 extra), which
+ * are awaken directly by the rcu_gp_kthread(). The
+ * reset is deferred to a dedicated worker.
+ */
+#define MAX_SR_WAKE_FROM_GP 5
+
+/*
+ * Helper function for rcu_gp_cleanup().
+ */
+static void rcu_sr_normal_gp_cleanup(void)
+{
+	struct llist_node *head, *tail, *pos;
+	int i = 0;
+
+	tail = READ_ONCE(sr.wait_tail);
+	head = llist_del_all(&sr.wait);
+
+	llist_for_each_safe(pos, head, head) {
+		rcu_sr_normal_complete(pos);
+
+		if (++i == MAX_SR_WAKE_FROM_GP) {
+			/* If last, process it also. */
+			if (head && !head->next)
+				continue;
+			break;
+		}
+	}
+
+	if (head) {
+		/* Can be not empty. */
+		llist_add_batch(head, tail, &sr.done);
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
+	tail = llist_del_all(&sr.curr);
+	head = llist_reverse_order(tail);
+
+	if (!head)
+		return;
+
+	/*
+	 * A waiting list of GP should be empty on this step,
+	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
+	 * rolls it over. If not, it is a BUG, warn a user.
+	 */
+	WARN_ON_ONCE(!llist_empty(&sr.wait));
+
+	WRITE_ONCE(sr.wait_tail, tail);
+	llist_add_batch(head, tail, &sr.wait);
+}
+
+static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
+{
+	llist_add((struct llist_node *) &rs->head, &sr.curr);
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1418,6 +1533,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
+	rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
@@ -1787,6 +1903,9 @@ static noinline void rcu_gp_cleanup(void)
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	// Make synchronize_rcu() users aware of the end of old grace period.
+	rcu_sr_normal_gp_cleanup();
+
 	// If strict, make all CPUs aware of the end of the old grace period.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
@@ -3500,6 +3619,35 @@ static int rcu_blocking_is_gp(void)
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
@@ -3551,7 +3699,7 @@ void synchronize_rcu(void)
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

