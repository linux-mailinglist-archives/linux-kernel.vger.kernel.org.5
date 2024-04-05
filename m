Return-Path: <linux-kernel+bounces-133424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FA89A37C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29519284D00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDAA171E4A;
	Fri,  5 Apr 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iixnUawi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D68172761
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338118; cv=none; b=rhVXlqw0Z+Let5EMo027jiGdnClUUkb6aLcApgAy5JWICgFJBfKfOsC+vChdQWLaIWN5s8o9E1UI6O5eIsI4VRZ2xhSNZLXsfeRRwDZwCBJ7L2UtLXLXSC6CDXXBTBdOuSrOXk4K/CRcSwPxhdiKEWKt+AkF6zkbOmiYqRAjP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338118; c=relaxed/simple;
	bh=38MnuOR+fbynRkefesi1jVKTa5oG4c9AUn/MGCJwoM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8+Ac+qSlRoUJ6QO5abtxAMgsgaVV1wgllf3COKotwdHdu3tivNAT7P7JnkSAQUFTY0RyZYr+6ZVN0iVURiyKZXORPXSdWPgMSWwEOK47ocTthkeevHm9bfbwWubvm6BOMgCc25E6THP8k+11TRqbRjlaqSqGmckUD65kzakA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iixnUawi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F141CC433C7;
	Fri,  5 Apr 2024 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338118;
	bh=38MnuOR+fbynRkefesi1jVKTa5oG4c9AUn/MGCJwoM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iixnUawi+l4UuT2ebEAecJ9t1WIiUhUWPCRt9du+ckkn7G0HQlW743d6bZ7lpchAK
	 5cv1VI7D5aea9oka2+rN7B3rlpR8/ce/lDzZcFoeHK3xdGM/YM3MfWdY2rZKXYZ6wx
	 ttRjswqCaRCH8BOEEVCKfGEXVEVOWspE+opJjsvI9iqRGqy5KuF2C5lcqqNmKaV+Tf
	 qJ81DKgiLLdF7lUbLD+mYYZke23EN18jBR1N2AVENDRs0Pl5LyVqRAARGTgDRGOGYz
	 UfgLssrhcup/YUgztCctWDN7Uls+1Idkiwd5CY/KWNv2/QFlVhz8o4SZzjvEByiqCN
	 8psRrlwpEj78A==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V6 3/6] sched/fair: Fair server interface
Date: Fri,  5 Apr 2024 19:28:02 +0200
Message-ID: <1abba9e7f47ad4a5dfd8b2dfb59aa607983cdce4.1712337227.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712337227.git.bristot@kernel.org>
References: <cover.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an interface for fair server setup on debugfs.

Each CPU has three files under /debug/sched/fair_server/cpu{ID}:

 - runtime: set runtime in ns
 - period:  set period in ns
 - defer:   on/off for the defer mechanism

This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to set
bounds on admission control.

The interface also add the server to the dl bandwidth accounting.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/deadline.c | 111 ++++++++++++++++++----
 kernel/sched/debug.c    | 206 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |   3 +
 kernel/sched/topology.c |   8 ++
 4 files changed, 311 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6ea9c05711ce..dd38370aa276 100644
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
@@ -1191,6 +1196,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 	u64 fw;
 
 	rq_lock(rq, &rf);
+
+	if (!dl_se->dl_runtime) {
+		goto unlock;
+	}
+
 	if (dl_se->dl_throttled) {
 		sched_clock_tick();
 		update_rq_clock(rq);
@@ -1617,11 +1627,17 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	/*
+	 * XXX: the apply do not work fine at the init phase for the
+	 * fair server because things are not yet set. We need to improve
+	 * this before getting generic.
+	 */
 	if (!dl_server(dl_se)) {
 		/* Disabled */
-		dl_se->dl_runtime = 0;
-		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
-		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+		u64 runtime = 0;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
@@ -1656,6 +1672,67 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick = pick;
 }
 
+void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	u64 new_bw = dl_se->dl_bw;
+	struct dl_bw *dl_b;
+	int cpu = cpu_of(rq);
+
+	dl_b = dl_bw_of(cpu_of(rq));
+	raw_spin_lock(&dl_b->lock);
+
+	__dl_add(dl_b, new_bw, dl_bw_cpus(cpu));
+
+	raw_spin_unlock(&dl_b->lock);
+}
+
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
+	dl_se->dl_runtime = runtime;
+	dl_se->dl_deadline = period;
+	dl_se->dl_period = period;
+
+	dl_se->runtime = 0;
+	dl_se->deadline = 0;
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
index 8d5d98a5834d..5da3297270cd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,8 +333,212 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+enum dl_param {
+	DL_RUNTIME = 0,
+	DL_PERIOD,
+	DL_DEFER
+};
+
+static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+
+static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
+				       size_t cnt, loff_t *ppos, enum dl_param param)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	u64 runtime, period, defer;
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
+		defer = rq->fair_server.dl_defer;
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
+		case DL_DEFER:
+			if (defer == value)
+				goto out;
+			defer = value;
+			break;
+		}
+
+		if (runtime > period ||
+		    period > fair_server_period_max ||
+		    period < fair_server_period_min ||
+		    defer > 1) {
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
+		 * The defer does not change utilization, so just
+		 * setting it is enough.
+		 */
+		if (rq->fair_server.dl_defer != defer) {
+			rq->fair_server.dl_defer = defer;
+		} else {
+			retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+			if (retval)
+				cnt = retval;
+		}
+
+		if (!runtime)
+			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
+					cpu_of(rq));
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
+	case DL_DEFER:
+		value = rq->fair_server.dl_defer;
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
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_DEFER);
+}
+
+static int sched_fair_server_defer_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_DEFER);
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
+	struct dentry *d_fair;
+	unsigned long cpu;
+
+	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
+	if (!d_fair)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_fair);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+		debugfs_create_file("defer", 0644, d_cpu, (void *) cpu, &fair_server_defer_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -374,6 +578,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_fair_server_init();
+
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e70e17be83c3..a80a236da57c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -343,6 +343,9 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
+extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
+extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
+		    u64 runtime, u64 period, bool init);
 
 #ifdef CONFIG_CGROUP_SCHED
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..ecb089c4967f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -517,6 +517,14 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
+	/*
+	 * Because the rq is not a task, dl_add_task_root_domain() did not
+	 * move the fair server bw to the rd if it already started.
+	 * Add it now.
+	 */
+	if (rq->fair_server.dl_server)
+		__dl_server_attach_root(&rq->fair_server, rq);
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.44.0


