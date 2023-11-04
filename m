Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DAC7E0EE7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjKDLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjKDLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:00:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F32D67
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:00:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCF8C433C7;
        Sat,  4 Nov 2023 10:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699095603;
        bh=yNoCGgEwrXT571CuCNX7khSC0Fmbj52tE9/NrTraAwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cklzCtqB+aQmxgUupHu7SCHFn3UGt0OoCipmS7ED71dLkH8+1pj6FNmh0p2yOUjT8
         qiTDGmMFpQh7iDVFH927gPIxOuV4f8ea6iCCe+yhcb0BXviwc9v+9PpAr8OzbEMKID
         SVrfH6lGPFGE1A/TrFIqQG30eIl3Z0IMoixd9CK8BR5iatcqHcJLm9jhDhun8VDwNS
         LBk9c+p2tqi8uT5kxLIbJcI49/FFZQU5z94cMZupeN8EurHI2ShvRYFhy419e+EghC
         3ur0bcmYJR4ZQSn6aIBCUKbjbA3mEUdJspkLr8UWaZCmiiAu99tTkiYXCuL8oGNQFs
         y52iRRoNXQIIQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, bristot@kernel.org,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v5 7/7] sched/fair: Fair server interface
Date:   Sat,  4 Nov 2023 11:59:24 +0100
Message-Id: <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1699095159.git.bristot@kernel.org>
References: <cover.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an interface for fair server setup on debugfs.

Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:

 - fair_server_runtime: set runtime in ns
 - fair_server_period: set period in ns
 - fair_server_defer: on/off for the defer mechanism

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/deadline.c |  89 +++++++++++++++---
 kernel/sched/debug.c    | 202 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c     |   6 --
 kernel/sched/sched.h    |   2 +
 4 files changed, 279 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 69ee1fbd60e4..1092ca8892e0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -321,19 +321,12 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
-static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+static void dl_rq_change_utilization(struct rq *rq, struct sched_dl_entity *dl_se, u64 new_bw)
 {
-	struct rq *rq;
-
-	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
-
-	if (task_on_rq_queued(p))
-		return;
+	if (dl_se->dl_non_contending) {
+		sub_running_bw(dl_se, &rq->dl);
+		dl_se->dl_non_contending = 0;
 
-	rq = task_rq(p);
-	if (p->dl.dl_non_contending) {
-		sub_running_bw(&p->dl, &rq->dl);
-		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
 		 * timer cannot be canceled, inactive_task_timer()
@@ -341,13 +334,25 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	}
-	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
+	__sub_rq_bw(dl_se->dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+{
+	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
+
+	if (task_on_rq_queued(p))
+		return;
+
+	dl_rq_change_utilization(task_rq(p), &p->dl, new_bw);
+}
+
 static void __dl_clear_params(struct sched_dl_entity *dl_se);
 
 /*
@@ -1508,10 +1513,22 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	/*
+	 * XXX: the apply do not work fine at the init phase for the
+	 * fair server because things are not yet set. We need to improve
+	 * this before getting generic.
+	 */
 	if (!dl_server(dl_se)) {
+		u64 runtime = 50 * NSEC_PER_MSEC;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_zerolax = 1;
 		dl_se->dl_server = 1;
 		setup_new_dl_entity(dl_se);
 	}
+
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 }
 
@@ -1532,6 +1549,50 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick = pick;
 }
 
+int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
+{
+	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	u64 new_bw = to_ratio(period, runtime);
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	unsigned long cap;
+	int retval = 0;
+	int cpus;
+
+	dl_b = dl_bw_of(cpu);
+	raw_spin_lock(&dl_b->lock);
+	cpus = dl_bw_cpus(cpu);
+	cap = dl_bw_capacity(cpu);
+
+	if (__dl_overflow(dl_b, cap, old_bw, new_bw)) {
+		retval = -EBUSY;
+		goto out;
+	}
+
+	if (init) {
+		__add_rq_bw(new_bw, &rq->dl);
+		__dl_add(dl_b, new_bw, cpus);
+	} else {
+		__dl_sub(dl_b, dl_se->dl_bw, cpus);
+		__dl_add(dl_b, new_bw, cpus);
+
+		dl_rq_change_utilization(rq, dl_se, new_bw);
+	}
+
+	rq->fair_server.dl_runtime = runtime;
+	rq->fair_server.dl_deadline  = period;
+	rq->fair_server.dl_period  = period;
+
+	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
+
+out:
+	raw_spin_unlock(&dl_b->lock);
+
+	return retval;
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4580a450700e..bd7ad6b8d3de 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,8 +333,208 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+enum dl_param {
+	DL_RUNTIME = 0,
+	DL_PERIOD,
+	DL_ZEROLAX
+};
+
+static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+
+static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
+				       size_t cnt, loff_t *ppos, enum dl_param param)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	u64 runtime, period, zerolax;
+	struct rq *rq = cpu_rq(cpu);
+	size_t err;
+	int retval;
+	u64 value;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
+	if (err)
+		return err;
+
+	scoped_guard (rq_lock_irqsave, rq) {
+
+		runtime  = rq->fair_server.dl_runtime;
+		period = rq->fair_server.dl_period;
+		zerolax = rq->fair_server.dl_zerolax;
+
+		switch (param) {
+		case DL_RUNTIME:
+			if (runtime == value)
+				goto out;
+			runtime = value;
+			break;
+		case DL_PERIOD:
+			if (value == period)
+				goto out;
+			period = value;
+			break;
+		case DL_ZEROLAX:
+			if (zerolax == value)
+				goto out;
+			zerolax = value;
+			break;
+		}
+
+		if (runtime > period
+				|| period > fair_server_period_max
+				|| period < fair_server_period_min
+				|| zerolax > 1) {
+			cnt = -EINVAL;
+			goto out;
+		}
+
+		if (rq->cfs.h_nr_running) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
+
+		/*
+		 * The zerolax does not change utilization, so just
+		 * setting it is enough.
+		 */
+		if (rq->fair_server.dl_zerolax != zerolax) {
+			rq->fair_server.dl_zerolax = zerolax;
+		} else {
+			retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+			if (retval)
+				cnt = retval;
+		}
+
+		if (rq->cfs.h_nr_running)
+			dl_server_start(&rq->fair_server);
+	}
+
+out:
+	*ppos += cnt;
+	return cnt;
+}
+
+static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+	u64 value;
+
+	switch (param) {
+	case DL_RUNTIME:
+		value = rq->fair_server.dl_runtime;
+		break;
+	case DL_PERIOD:
+		value = rq->fair_server.dl_period;
+		break;
+	case DL_ZEROLAX:
+		value = rq->fair_server.dl_zerolax;
+	}
+
+	seq_printf(m, "%llu\n", value);
+	return 0;
+
+}
+
+static ssize_t
+sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_runtime_fops = {
+	.open		= sched_fair_server_runtime_open,
+	.write		= sched_fair_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t
+sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+}
+
+static int sched_fair_server_period_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_PERIOD);
+}
+
+static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_period_fops = {
+	.open		= sched_fair_server_period_open,
+	.write		= sched_fair_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t
+sched_fair_server_defer_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_ZEROLAX);
+}
+
+static int sched_fair_server_defer_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_ZEROLAX);
+}
+
+static int sched_fair_server_defer_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_defer_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_defer_fops = {
+	.open		= sched_fair_server_defer_open,
+	.write		= sched_fair_server_defer_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
+static void debugfs_fair_server_init(void)
+{
+	long cpu;
+	struct dentry *rq_dentry;
+
+	rq_dentry = debugfs_create_dir("rq", debugfs_sched);
+	if (!rq_dentry)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%ld", cpu);
+		d_cpu = debugfs_create_dir(buf, rq_dentry);
+
+		debugfs_create_file("fair_server_runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("fair_server_period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+		debugfs_create_file("fair_server_defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -374,6 +574,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_fair_server_init();
+
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 399237cd9f59..5434c52f470d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8419,12 +8419,6 @@ void fair_server_init(struct rq *rq)
 	struct sched_dl_entity *dl_se = &rq->fair_server;
 
 	init_dl_entity(dl_se);
-
-	dl_se->dl_runtime = 50 * NSEC_PER_MSEC;
-	dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
-	dl_se->dl_period = 1000 * NSEC_PER_MSEC;
-	dl_se->dl_zerolax = 1;
-
 	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec0e288c8e06..312b31df5860 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -341,6 +341,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_pick_f pick);
 
 extern void fair_server_init(struct rq *);
+extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
+		    u64 runtime, u64 period, bool init);
 
 #ifdef CONFIG_CGROUP_SCHED
 
-- 
2.40.1

