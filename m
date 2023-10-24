Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FAF7D5D68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbjJXVqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjJXVqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:46:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A75410D7;
        Tue, 24 Oct 2023 14:46:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F750C433C9;
        Tue, 24 Oct 2023 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698184001;
        bh=VF4rwPu4+YtRb7YG4mHtznxP8H/nXqrrus0i9svAMXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=au3/YmnrmAJQJG631/cxb4ORAO9pRQTWXnK7H6KnQmVugQQJmTa3DGjZcpQw9ePHJ
         VdX4Ifg7c8hlUO3kYIPVedfUuNpoouQDRjZIwigFJ5/PmE7rSzXFb9v8iDKOJcliSR
         HgWUCmh1iEQyjGwkEZxVBM6mSAlAQmfGiMlCD5A/OtOAJPxJyw+h+ApaZRgo0tcomy
         WmAMclPVf8javsIc5NZGs+kYXXeO8I0+YOzKenD/QkuKkpVtgeK7ciGyjzLbweSBWv
         4lZLEwd3THfxpNQ7GMPc5W8yr/npFOeo0iM66/n73ymQi9DO+Zs85gzU/c+TmxleVd
         5PiXlKNNqLlqw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/4] rcu/tasks: Handle new PF_IDLE semantics
Date:   Tue, 24 Oct 2023 23:46:23 +0200
Message-ID: <20231024214625.6483-3-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024214625.6483-1-frederic@kernel.org>
References: <20231024214625.6483-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit:

	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")

has changed the semantics of what is to be considered an idle task in
such a way that CPU boot code preceding the actual idle loop is excluded
from it.

This has however introduced new potential RCU-tasks stalls when either:

1) Grace period is started before init/0 had a chance to set PF_IDLE,
   keeping it stuck in the holdout list until idle ever schedules.

2) Grace period is started when some possible CPUs have never been
   online, keeping their idle tasks stuck in the holdout list until the
   CPU ever boots up.

3) Similar to 1) but with secondary CPUs: Grace period is started
   concurrently with secondary CPU booting, putting its idle task in
   the holdout list because PF_IDLE isn't yet observed on it. It stays
   then stuck in the holdout list until that CPU ever schedules. The
   effect is mitigated here by the hotplug AP thread that must run to
   bring the CPU up.

Fix this with handling the new semantics of PF_IDLE, keeping in mind
that it may or may not be set on an idle task. Take advantage of that to
strengthen the coverage of an RCU-tasks quiescent state within an idle
task, excluding the CPU boot code from it. Only the code running within
the idle loop is now a quiescent state, along with offline CPUs.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Suggested-by: Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bf5f178fe723..acf81efe5eff 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -895,10 +895,37 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
+/* Check for quiescent states since the pregp's synchronize_rcu() */
+static bool rcu_tasks_is_holdout(struct task_struct *t)
+{
+	int cpu;
+
+	/* Has the task been seen voluntarily sleeping? */
+	if (!READ_ONCE(t->on_rq))
+		return false;
+
+	cpu = task_cpu(t);
+
+	/*
+	 * Idle tasks within the idle loop or offline CPUs are RCU-tasks
+	 * quiescent states. But CPU boot code performed by the idle task
+	 * isn't a quiescent state.
+	 */
+	if (t == idle_task(cpu)) {
+		if (is_idle_task(t))
+			return false;
+
+		if (!rcu_cpu_online(cpu))
+			return false;
+	}
+
+	return true;
+}
+
 /* Per-task initial processing. */
 static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 {
-	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+	if (t != current && rcu_tasks_is_holdout(t)) {
 		get_task_struct(t);
 		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
 		WRITE_ONCE(t->rcu_tasks_holdout, true);
@@ -947,7 +974,7 @@ static void check_holdout_task(struct task_struct *t,
 
 	if (!READ_ONCE(t->rcu_tasks_holdout) ||
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
-	    !READ_ONCE(t->on_rq) ||
+	    !rcu_tasks_is_holdout(t) ||
 	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
 	     !is_idle_task(t) && READ_ONCE(t->rcu_tasks_idle_cpu) >= 0)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
-- 
2.41.0

