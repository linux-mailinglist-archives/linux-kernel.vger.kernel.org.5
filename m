Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA747705D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHDQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHDQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:22:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A3B2;
        Fri,  4 Aug 2023 09:22:49 -0700 (PDT)
Date:   Fri, 4 Aug 2023 18:22:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691166167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iySTVOckX9+4B55Jdn4fzCaqPXIiAN5/63bxAu4lyw4=;
        b=ythTYkDpds9hd67Ha1URqBnnVwFpvK16gbl1DEvs5CCE1Oqt3333BMliHMF74WJTHQk9m7
        O2X2G9yqEZW86UgR8JcfXgFHdhIxjGMBNoGAGc6LtwPYOiSMfPdghfHwzz1mEiesuvwZU5
        C9/EqSyr/glp1XoBQSSLM1JorQW/BDvgcc1Q/NEBQCiqilmLW0PXCpzX4+aH7mL4CxA1Qs
        ISWbenaM4zmdbtOReFI/y59WUXgD344C0BAtWBmEgouwdaN17iG7JK9hb/VHcFSG2JMgWC
        Slh5b+OiBM8Ue0irBU4xmirwbFqRm5VI3a2YXI68hlwl8UlERNGBNZrQnEOphw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691166167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iySTVOckX9+4B55Jdn4fzCaqPXIiAN5/63bxAu4lyw4=;
        b=zy/PdL6QpRcolOXixY1i95ogR7Q+5jPzUIXaw2Uk0ITaSQcQAfep4tsbydynTpaVNWLbFN
        V6HjYG9s74gbEZAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.5-rc4-rt2
Message-ID: <20230804162246.CUJllMTk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.5-rc4-rt2 patch set. 

Changes since v6.5-rc4-rt1:

  - Don't tell a CPU to push tasks for RT balancing if there are no
    tasks that can be pushed.

  - Preempt the timer softirq if it is PI boosted. This is to see how it
    works and to start discussion with upstream how to proceed with the
    underlying issue.

  - Remove a mutex in x86'microcode and ASoC's mt8186 code which were
    causing "unused variable" warning during RT build.

  - Update a comment in ptrace code while reposting the relevant patch.

Known issues
     None

The delta patch against v6.5-rc4-rt1 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/incr/patch-6.5-rc4-rt1-rt2.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.5-rc4-rt2

The RT patch against v6.5-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patch-6.5-rc4-rt2.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.5/older/patches-6.5-rc4-rt2.tar.xz

Sebastian

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0ba1067f4e5f1..de49b9cd8077a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2276,8 +2276,7 @@ void store_cpu_caps(struct cpuinfo_x86 *curr_info)
  * @prev_info:	CPU capabilities stored before an update.
  *
  * The microcode loader calls this upon late microcode load to recheck features,
- * only when microcode has been updated. Caller holds microcode_mutex and CPU
- * hotplug lock.
+ * only when microcode has been updated. Caller holds and CPU hotplug lock.
  *
  * Return: None
  */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3de0dd49..2f9d35744bc41 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -54,15 +54,12 @@ LIST_HEAD(microcode_cache);
  *
  * All non cpu-hotplug-callback call sites use:
  *
- * - microcode_mutex to synchronize with each other;
  * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
  * updated at any particular moment of time.
  */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
-	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
-	mutex_unlock(&microcode_mutex);
-
 put:
 	cpus_read_unlock();
 
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index fc53e0ad56d90..448bbef474564 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -35,8 +35,10 @@ static inline void local_bh_enable(void)
 
 #ifdef CONFIG_PREEMPT_RT
 extern bool local_bh_blocked(void);
+extern void softirq_preempt(void);
 #else
 static inline bool local_bh_blocked(void) { return false; }
+static inline void softirq_preempt(void) { }
 #endif
 
 #endif /* _LINUX_BH_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 973172547c125..7b235881a0ad0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1892,6 +1892,7 @@ static inline int dl_task_check_affinity(struct task_struct *p, const struct cpu
 }
 #endif
 
+extern bool task_is_pi_boosted(const struct task_struct *p);
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6991e1982f8d9..2276b5d882380 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8965,6 +8965,21 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
+/*
+ * task_is_pi_boosted - Check if task has been PI boosted.
+ * @p:	Task to check.
+ *
+ * Return true if task is subject to priority inheritance.
+ */
+bool task_is_pi_boosted(const struct task_struct *p)
+{
+	int prio = p->prio;
+
+	if (!rt_prio(prio))
+		return false;
+	return prio != p->normal_prio;
+}
+
 /**
  * yield - yield the current processor to other threads.
  *
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e50741153..338cd150973ff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2247,8 +2247,11 @@ static int rto_next_cpu(struct root_domain *rd)
 
 		rd->rto_cpu = cpu;
 
-		if (cpu < nr_cpu_ids)
+		if (cpu < nr_cpu_ids) {
+			if (!has_pushable_tasks(cpu_rq(cpu)))
+				continue;
 			return cpu;
+		}
 
 		rd->rto_cpu = -1;
 
diff --git a/kernel/signal.c b/kernel/signal.c
index d41eafca39687..6c9af878bd6ed 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2334,8 +2334,12 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * between unlock and schedule() and so improving the performance since
 	 * the ptracer has no reason to sleep.
 	 *
-	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
-	 * within the preempt-disable section.
+	 * On PREEMPT_RT locking tasklist_lock does not disable preemption.
+	 * Therefore the task can be preempted (after
+	 * do_notify_parent_cldstop()) before unlocking tasklist_lock so there
+	 * is no benefit in doing this. The optimisation is harmful on
+	 * PEEMPT_RT because the spinlock_t (in cgroup_enter_frozen()) must not
+	 * be acquired with disabled preemption.
 	 */
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 623985f188336..334232227c43c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -247,6 +247,19 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+void softirq_preempt(void)
+{
+	if (WARN_ON_ONCE(!preemptible()))
+		return;
+
+	if (WARN_ON_ONCE(__this_cpu_read(softirq_ctrl.cnt) != SOFTIRQ_OFFSET))
+		return;
+
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	/* preemption point */
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
 /*
  * Invoked from ksoftirqd_run() outside of the interrupt disabled section
  * to acquire the per CPU local lock for reentrancy protection.
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7cad6fe3c035c..b3fbe97d1e342 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1470,9 +1470,16 @@ static inline void timer_base_unlock_expiry(struct timer_base *base)
  */
 static void timer_sync_wait_running(struct timer_base *base)
 {
-	if (atomic_read(&base->timer_waiters)) {
+	bool need_preempt;
+
+	need_preempt = task_is_pi_boosted(current);
+	if (need_preempt || atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
+
+		if (need_preempt)
+			softirq_preempt();
+
 		spin_lock(&base->expiry_lock);
 		raw_spin_lock_irq(&base->lock);
 	}
diff --git a/localversion-rt b/localversion-rt
index 6f206be67cd28..c3054d08a1129 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt1
+-rt2
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
index 539e3a023bc4e..70ec101890d36 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-clk.c
@@ -13,8 +13,6 @@
 #include "mt8186-afe-clk.h"
 #include "mt8186-audsys-clk.h"
 
-static DEFINE_MUTEX(mutex_request_dram);
-
 static const char *aud_clks[CLK_NUM] = {
 	[CLK_AFE] = "aud_afe_clk",
 	[CLK_DAC] = "aud_dac_clk",
