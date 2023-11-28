Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400737FB376
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbjK1IBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjK1IAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799998;
        Tue, 28 Nov 2023 00:00:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso7791299e87.1;
        Tue, 28 Nov 2023 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158440; x=1701763240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCjEWa8Q2f6t37ckyMp7lNr3JFQtn/U/ClZD7LTuOUg=;
        b=AXXnuMTyb0N7xumjFXww93ZjtMgbWMphmbg+ENogVVKejEszhJFXAI3FS789kpqic8
         bsZHnNz7E9pg/Jk0q0qzXtrY7msfgnPGje2x0WWMimxbawmjsiyaMdPgj7jwcbazd2C/
         UGMym+8lxL5Gh+ZCReU6+Qin3c1ikueQTpZFrptmYBGRm7MZlUtyO7JIhq72hoPIOQos
         HVp5txnWjlFqUgY5qo5gK50ioAYftAHCLU8XNyYDVs7q9BAunqp5iCjhTYjJhcWDBitV
         5yHihsM4bREmcpiAO+TmnZhJF8vBAaBAn9pEyga5+EnkC/XDagAVGpM3k8TI0CIOT6YM
         3akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158440; x=1701763240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCjEWa8Q2f6t37ckyMp7lNr3JFQtn/U/ClZD7LTuOUg=;
        b=uqrCQ1ONq0W2lDQ5D5u1cIA8mA6szC9EHKZessk5jpQN+J8pulxwSEJD5YbpyfD9Tm
         izY2vrTUAduh1myrABxUUAZuzs+60Ne/JL19UsVlOq0YMPkbze3NMULPsPHqqQJTd7Xh
         DPB4DcAOMKGwIsUBWhd3vmPEztS8CHxQTWCvgl/+895F5S3aI8ROpIr174ZYohz/deHK
         2oliRTIV6IZc8P3Ua5TnowlPsH4LKaoDogTTev4Yg1c2ReVfaMFHrs037T1kNfkF516B
         kmp1M0NOWwT1XvhyiCiT/prQZTnkkkzvrVcJoDQic4K87gQms+4uizTEkwfOk6c0OYSu
         mZ0g==
X-Gm-Message-State: AOJu0YxvSRUCxialhGFYDTvvHL6FbQAdO7Qi6Lrlhf7XqVaw9OhnCYuN
        O0x0z8D5cAXNPU+XlqzFS4Ap+JdPM6Q=
X-Google-Smtp-Source: AGHT+IEuM/s74Np5OlgdJ9Nq72IMiFoGnCWNA+XDMCq04zLOvZLRTZaS4obMnKQ5drpdoqdD41HdDQ==
X-Received: by 2002:a19:910e:0:b0:507:a04c:1bcf with SMTP id t14-20020a19910e000000b00507a04c1bcfmr7806324lfd.58.1701158439522;
        Tue, 28 Nov 2023 00:00:39 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:39 -0800 (PST)
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
Subject: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Date:   Tue, 28 Nov 2023 09:00:30 +0100
Message-Id: <20231128080033.288050-5-urezki@gmail.com>
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

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Currently, processing of the next batch of rcu_synchronize nodes
for the new grace period, requires doing a llist reversal operation
to find the tail element of the list. This can be a very costly
operation (high number of cache misses) for a long list.

To address this, this patch introduces a "dummy-wait-node" entity.
At every grace period init, a new wait node is added to the llist.
This wait node is used as wait tail for this new grace period.

This allows lockless additions of new rcu_synchronize nodes in the
rcu_sr_normal_add_req(), while the cleanup work executes and does
the progress. The dummy nodes are removed on next round of cleanup
work execution.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 kernel/rcu/tree.c | 270 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 233 insertions(+), 37 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 975621ef40e3..d7b48996825f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,25 +1384,173 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
- * There are three lists for handling synchronize_rcu() users.
- * A first list corresponds to new coming users, second for users
- * which wait for a grace period and third is for which a grace
- * period is passed.
+ * There is a single llist, which is used for handling
+ * synchronize_rcu() users' enqueued rcu_synchronize nodes.
+ * Within this llist, there are two tail pointers:
+ *
+ * wait tail: Tracks the set of nodes, which need to
+ *            wait for the current GP to complete.
+ * done tail: Tracks the set of nodes, for which grace
+ *            period has elapsed. These nodes processing
+ *            will be done as part of the cleanup work
+ *            execution by a kworker.
+ *
+ * At every grace period init, a new wait node is added
+ * to the llist. This wait node is used as wait tail
+ * for this new grace period. Given that there are a fixed
+ * number of wait nodes, if all wait nodes are in use
+ * (which can happen when kworker callback processing
+ * is delayed) and additional grace period is requested.
+ * This means, a system is slow in processing callbacks.
+ *
+ * TODO: If a slow processing is detected, a first node
+ * in the llist should be used as a wait-tail for this
+ * grace period, therefore users which should wait due
+ * to a slow process are handled by _this_ grace period
+ * and not next.
+ *
+ * Below is an illustration of how the done and wait
+ * tail pointers move from one set of rcu_synchronize nodes
+ * to the other, as grace periods start and finish and
+ * nodes are processed by kworker.
+ *
+ *
+ * a. Initial llist callbacks list:
+ *
+ * +----------+           +--------+          +-------+
+ * |          |           |        |          |       |
+ * |   head   |---------> |   cb2  |--------->| cb1   |
+ * |          |           |        |          |       |
+ * +----------+           +--------+          +-------+
+ *
+ *
+ *
+ * b. New GP1 Start:
+ *
+ *                    WAIT TAIL
+ *                      |
+ *                      |
+ *                      v
+ * +----------+     +--------+      +--------+        +-------+
+ * |          |     |        |      |        |        |       |
+ * |   head   ------> wait   |------>   cb2  |------> |  cb1  |
+ * |          |     | head1  |      |        |        |       |
+ * +----------+     +--------+      +--------+        +-------+
+ *
+ *
+ *
+ * c. GP completion:
+ *
+ * WAIT_TAIL == DONE_TAIL
+ *
+ *                   DONE TAIL
+ *                     |
+ *                     |
+ *                     v
+ * +----------+     +--------+      +--------+        +-------+
+ * |          |     |        |      |        |        |       |
+ * |   head   ------> wait   |------>   cb2  |------> |  cb1  |
+ * |          |     | head1  |      |        |        |       |
+ * +----------+     +--------+      +--------+        +-------+
+ *
+ *
+ *
+ * d. New callbacks and GP2 start:
+ *
+ *                    WAIT TAIL                          DONE TAIL
+ *                      |                                 |
+ *                      |                                 |
+ *                      v                                 v
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ * |          |     |      |    |      |    |      |    |     |    |     |    |     |
+ * |   head   ------> wait |--->|  cb4 |--->| cb3  |--->|wait |--->| cb2 |--->| cb1 |
+ * |          |     | head2|    |      |    |      |    |head1|    |     |    |     |
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ *
+ *
+ *
+ * e. GP2 completion:
+ *
+ * WAIT_TAIL == DONE_TAIL
+ *                   DONE TAIL
+ *                      |
+ *                      |
+ *                      v
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ * |          |     |      |    |      |    |      |    |     |    |     |    |     |
+ * |   head   ------> wait |--->|  cb4 |--->| cb3  |--->|wait |--->| cb2 |--->| cb1 |
+ * |          |     | head2|    |      |    |      |    |head1|    |     |    |     |
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ *
+ *
+ * While the llist state transitions from d to e, a kworker
+ * can start executing rcu_sr_normal_gp_cleanup_work() and
+ * can observe either the old done tail (@c) or the new
+ * done tail (@e). So, done tail updates and reads need
+ * to use the rel-acq semantics. If the concurrent kworker
+ * observes the old done tail, the newly queued work
+ * execution will process the updated done tail. If the
+ * concurrent kworker observes the new done tail, then
+ * the newly queued work will skip processing the done
+ * tail, as workqueue semantics guarantees that the new
+ * work is executed only after the previous one completes.
+ *
+ * f. kworker callbacks processing complete:
+ *
+ *
+ *                   DONE TAIL
+ *                     |
+ *                     |
+ *                     v
+ * +----------+     +--------+
+ * |          |     |        |
+ * |   head   ------> wait   |
+ * |          |     | head2  |
+ * +----------+     +--------+
+ *
  */
 static struct sr_normal_state {
 	struct llist_head srs_next;	/* request a GP users. */
-	struct llist_head srs_wait;	/* wait for GP users. */
-	struct llist_head srs_done;	/* ready for GP users. */
-
-	/*
-	 * In order to add a batch of nodes to already
-	 * existing srs-done-list, a tail of srs-wait-list
-	 * is maintained.
-	 */
-	struct llist_node *srs_wait_tail;
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 } sr;
 
+static bool rcu_sr_is_wait_head(struct llist_node *node)
+{
+	return &(sr.srs_wait_nodes)[0].node <= node &&
+		node <= &(sr.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
+}
+
+static struct llist_node *rcu_sr_get_wait_head(void)
+{
+	struct sr_wait_node *sr_wn;
+	int i;
+
+	for (i = 0; i < SR_NORMAL_GP_WAIT_HEAD_MAX; i++) {
+		sr_wn = &(sr.srs_wait_nodes)[i];
+
+		if (!atomic_cmpxchg_acquire(&sr_wn->inuse, 0, 1))
+			return &sr_wn->node;
+	}
+
+	return NULL;
+}
+
+static void rcu_sr_put_wait_head(struct llist_node *node)
+{
+	struct sr_wait_node *sr_wn = container_of(node, struct sr_wait_node, node);
+	atomic_set_release(&sr_wn->inuse, 0);
+}
+
 /* Disabled by default. */
 static int rcu_normal_wake_from_gp;
 module_param(rcu_normal_wake_from_gp, int, 0644);
@@ -1423,14 +1571,44 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 {
-	struct llist_node *done, *rcu, *next;
+	struct llist_node *done, *rcu, *next, *head;
 
-	done = llist_del_all(&sr.srs_done);
+	/*
+	 * This work execution can potentially execute
+	 * while a new done tail is being updated by
+	 * grace period kthread in rcu_sr_normal_gp_cleanup().
+	 * So, read and updates of done tail need to
+	 * follow acq-rel semantics.
+	 *
+	 * Given that wq semantics guarantees that a single work
+	 * cannot execute concurrently by multiple kworkers,
+	 * the done tail list manipulations are protected here.
+	 */
+	done = smp_load_acquire(&sr.srs_done_tail);
 	if (!done)
 		return;
 
-	llist_for_each_safe(rcu, next, done)
-		rcu_sr_normal_complete(rcu);
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
+	head = done->next;
+	done->next = NULL;
+
+	/*
+	 * The dummy node, which is pointed to by the
+	 * done tail which is acq-read above is not removed
+	 * here.  This allows lockless additions of new
+	 * rcu_synchronize nodes in rcu_sr_normal_add_req(),
+	 * while the cleanup work executes. The dummy
+	 * nodes is removed, in next round of cleanup
+	 * work execution.
+	 */
+	llist_for_each_safe(rcu, next, head) {
+		if (!rcu_sr_is_wait_head(rcu)) {
+			rcu_sr_normal_complete(rcu);
+			continue;
+		}
+
+		rcu_sr_put_wait_head(rcu);
+	}
 }
 static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
 
@@ -1439,43 +1617,56 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *head, *tail;
+	struct llist_node *wait_tail;
 
-	if (llist_empty(&sr.srs_wait))
+	wait_tail = sr.srs_wait_tail;
+	if (wait_tail == NULL)
 		return;
 
-	tail = READ_ONCE(sr.srs_wait_tail);
-	head = __llist_del_all(&sr.srs_wait);
+	sr.srs_wait_tail = NULL;
+	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
 
-	if (head) {
-		/* Can be not empty. */
-		llist_add_batch(head, tail, &sr.srs_done);
+	// concurrent sr_normal_gp_cleanup work might observe this update.
+	smp_store_release(&sr.srs_done_tail, wait_tail);
+	ASSERT_EXCLUSIVE_WRITER(sr.srs_done_tail);
+
+	if (wait_tail)
 		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
-	}
 }
 
 /*
  * Helper function for rcu_gp_init().
  */
-static void rcu_sr_normal_gp_init(void)
+static bool rcu_sr_normal_gp_init(void)
 {
-	struct llist_node *head, *tail;
+	struct llist_node *first;
+	struct llist_node *wait_head;
+	bool start_new_poll = false;
 
-	if (llist_empty(&sr.srs_next))
-		return;
+	first = READ_ONCE(sr.srs_next.first);
+	if (!first || rcu_sr_is_wait_head(first))
+		return start_new_poll;
+
+	wait_head = rcu_sr_get_wait_head();
+	if (!wait_head) {
+		// Kick another GP to retry.
+		start_new_poll = true;
+		return start_new_poll;
+	}
 
-	tail = llist_del_all(&sr.srs_next);
-	head = llist_reverse_order(tail);
+	/* Inject a wait-dummy-node. */
+	llist_add(wait_head, &sr.srs_next);
 
 	/*
-	 * A waiting list of GP should be empty on this step,
-	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
+	 * A waiting list of rcu_synchronize nodes should be empty on
+	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
 	 * rolls it over. If not, it is a BUG, warn a user.
 	 */
-	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
+	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
+	sr.srs_wait_tail = wait_head;
+	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
 
-	WRITE_ONCE(sr.srs_wait_tail, tail);
-	__llist_add_batch(head, tail, &sr.srs_wait);
+	return start_new_poll;
 }
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
@@ -1493,6 +1684,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
+	bool start_new_poll;
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1517,11 +1709,15 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	rcu_sr_normal_gp_init();
+	start_new_poll = rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	// New poll request after rnp unlock
+	if (start_new_poll)
+		(void) start_poll_synchronize_rcu();
+
 	/*
 	 * Apply per-leaf buffered online and offline operations to
 	 * the rcu_node tree. Note that this new grace period need not
-- 
2.39.2

