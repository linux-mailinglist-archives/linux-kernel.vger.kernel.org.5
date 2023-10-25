Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133D47D6F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344807AbjJYOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344631AbjJYOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:09:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6A186;
        Wed, 25 Oct 2023 07:09:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507962561adso8329398e87.0;
        Wed, 25 Oct 2023 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698242959; x=1698847759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SVLg2JlHugSU3IaNjtj7eUv+h55sIJkPWfpBUSnL5c=;
        b=UoPOWTtoUpzQvDdpbt8fx5db59sSPx/GOUajXdSfYdniZ1T7lm6aV3UlsY2XfUptcK
         uOc2xzEzseq76WRAAg45VscGBoMTQnIOJwuWs8XjB01MjwijRNzDBiyAV4Om30fGXudN
         74vBG9XgmQw75Wfulet5WOmS1c0GR8zOpnzmliWWgAvhCVCZXhmQA9N+8Zq+S/BwFEyR
         wDU6ZZbb7LcOq8J/R/zBF5ykdJ/kP6Jx8J59UrqLBi7BZQMd3OxqvaXStB51yOKhYar7
         pIt5hbshyHSV2sLyc1pg5aecNhO/8/Ysn32lAT18EHXP2dd1kUP3k2ovpxCkIodMievz
         1c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242959; x=1698847759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SVLg2JlHugSU3IaNjtj7eUv+h55sIJkPWfpBUSnL5c=;
        b=M/gObXZlqKKwUpobGJYKmqFqPvlgmQPOoTOci8toUpAVDsflKrZhDZZdI2pOWSDA10
         RKndy7rUAc2ntdM1uMmhW7S1quSqVDNG51c2vQXX014qYv5H1ydaxs+SGzEL84Q/KAGH
         M7tpsRlH5V3Pil/fBcUWw6PPkhn8KZGWV6g6/WWrcsxyaApIY1EaMTjBI6s39uQTYcsd
         UEwe+cjkjCYIerHTL/flIAliMreNaaKxUVvqIpVgOcTr9KNuRS0tC0OzFFwVU/PjiTa0
         +HtehmFdMJwciRIPPSsE1DuYZhtObRcGD8TXRVn7Q99masDU4C6ZRZgY4rR6gSPSPWtm
         7YHg==
X-Gm-Message-State: AOJu0YzHql4q3ZQNU3QIyFd2b+XbCC5qsTM5AJvt1UHy4iiwc+yLQmPq
        DcEOaZuR+5OUXjA1AiWO4Nk=
X-Google-Smtp-Source: AGHT+IEYn5e1Zza7K7/uM3735ZgUOUuqSanGCDyfWhJnmEpSLlIuWf/eGsRIGRnPV9tZelvWFzuefw==
X-Received: by 2002:ac2:53a5:0:b0:4fd:c844:6a43 with SMTP id j5-20020ac253a5000000b004fdc8446a43mr10537490lfh.43.1698242959231;
        Wed, 25 Oct 2023 07:09:19 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24e88000000b00507977e9a38sm2555680lfr.35.2023.10.25.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:09:18 -0700 (PDT)
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
Subject: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Date:   Wed, 25 Oct 2023 16:09:13 +0200
Message-Id: <20231025140915.590390-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025140915.590390-1-urezki@gmail.com>
References: <20231025140915.590390-1-urezki@gmail.com>
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
index 78554e7181dd..63e46a8f3e60 100644
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

