Return-Path: <linux-kernel+bounces-80341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAB9862D83
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDABDB20F6A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01E3F9D4;
	Sun, 25 Feb 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+KU80Pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A0249F9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901744; cv=none; b=ul4W0SUN294oP+3KZNSdXBJZ3YdzXYwVCmGqk+/ekAeX9jG6r8SUASHB2zZYYABFgL9H36nwGLHImnrsalppJzBtvpGesrZMywDeJv2rgCxkZfTvtAQAYRHSkqfuKD9uNUE2mC4VChpf9RNIw8Sdb5EJBIQITklffo5hELI5bmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901744; c=relaxed/simple;
	bh=zps/wj0u7k34+pF6RPIaYiiRwL0ICoQgkvZ4JnirR2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhyWdq5WNwUvvK1TxR0wHfP3GQqaih2f+zn6nSfAZL/ZD99Pr4l0Jni5GuQsT/C5C/vRIcCE3mhFaI+/pihB/pwnvWdBrf6CVnmIqdhjCU2Zxjzg6fXW+FbXy8z9JTlAmJpB4kjKeHwHxa5DJuRlKIBXxS6f0zueTfqOR7TSRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+KU80Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF83C43390;
	Sun, 25 Feb 2024 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901744;
	bh=zps/wj0u7k34+pF6RPIaYiiRwL0ICoQgkvZ4JnirR2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+KU80PjgKyzoDFi6jUw+0IVXg8H68HmxJoiPKcqB2LJDCHKH2TAmAs4DTADUtu3F
	 hv+1p+5Ff8Y4kYRpX4UaqHW696zpPzE8TrnoB/YOfy61wWHyhH3iVQUqoko0fZyfyk
	 LQfksH/gUJd42KKz/SCKSGSPGulSvSA54X85a1m84ftUqzADL2oLscETgmz2YHwQGx
	 ridkT3lXZ3TVAX3lYsX3ABBNHPnXdA0qruE/mUswu07n0rafuWvMNqKWKTLVW4PzVO
	 /HbRY+kSssRnXlCd4JEufeZPyE/lxLYja/baQc+FMpiE9zv+btyTE4pVYobhWrvDZ7
	 EYcMLtKd7OhqQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 14/16] tick: Shut down low-res tick from dying CPU
Date: Sun, 25 Feb 2024 23:55:06 +0100
Message-ID: <20240225225508.11587-15-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timekeeping duty is handed over from the outgoing CPU within stop
machine. This works well if CONFIG_NO_HZ_COMMON=n or the tick is in
high-res mode. However in low-res dynticks mode, the tick isn't
cancelled until the clockevent is shut down, which can happen later. The
tick may therefore fire again once IRQs are re-enabled on stop machine
and until IRQs are disabled for good upon the last call to idle.

That's so many opportunities for a timekeeper to go idle and the
outgoing CPU to take over that duty. This is why
tick_nohz_idle_stop_tick() is called one last time on idle if the CPU
is seen offline: so that the timekeeping duty is handed over again in
case the CPU has re-taken the duty.

This means there are two timekeeping handovers on CPU down hotplug with
different undocumented constraints and purposes:

1) A handover on stop machine for !dynticks || highres. All online CPUs
  are guaranteed to be non-idle and the timekeeping duty can be safely
  handed-over. The hrtimer tick is cancelled so it is guaranteed that in
  dynticks mode the outgoing CPU won't take again the duty.

2) A handover on last idle call for dynticks && lowres.  Setting the
  duty to TICK_DO_TIMER_NONE makes sure that a CPU will take over the
  timekeeping.

Prepare for consolidating the handover to a single place (the first one)
with shutting down the low-res tick as well from
tick_cancel_sched_timer() as well. This will simplify the handover and
unify the tick cancellation between high-res and low-res.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-common.c |  3 ++-
 kernel/time/tick-sched.c  | 32 +++++++++++++++++++++++++-------
 kernel/time/tick-sched.h  |  4 ++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 522414089c0d..9cd09eea06d6 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -410,7 +410,8 @@ int tick_cpu_dying(unsigned int dying_cpu)
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 
-	tick_cancel_sched_timer(dying_cpu);
+	/* Make sure the CPU won't try to retake the timekeeping duty */
+	tick_sched_timer_dying(dying_cpu);
 
 	/* Remove CPU from timer broadcasting */
 	tick_offline_cpu(dying_cpu);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index dcb9f0394182..89d16b8ea2c4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -308,6 +308,14 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
+static void tick_sched_timer_cancel(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
+	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		tick_program_event(KTIME_MAX, 1);
+}
+
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
@@ -1040,10 +1048,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-			hrtimer_cancel(&ts->sched_timer);
-		else
-			tick_program_event(KTIME_MAX, 1);
+		tick_sched_timer_cancel(ts);
 		return;
 	}
 
@@ -1598,14 +1603,27 @@ void tick_setup_sched_timer(bool hrtimer)
 	tick_nohz_activate(ts);
 }
 
-void tick_cancel_sched_timer(int cpu)
+/*
+ * Shut down the tick and make sure the CPU won't try to retake the timekeeping
+ * duty before disabling IRQs in idle for the last time.
+ */
+void tick_sched_timer_dying(int cpu)
 {
+	struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	struct clock_event_device *dev = td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
-	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-		hrtimer_cancel(&ts->sched_timer);
+	/* This must happen before hrtimers are migrated! */
+	tick_sched_timer_cancel(ts);
+
+	/*
+	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
+	 * make sure not to call low-res tick handler.
+	 */
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		dev->event_handler = clockevents_handle_noop;
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index bbe72a078985..58d8d1c49dd3 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -106,9 +106,9 @@ extern struct tick_sched *tick_get_tick_sched(int cpu);
 
 extern void tick_setup_sched_timer(bool hrtimer);
 #if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
-extern void tick_cancel_sched_timer(int cpu);
+extern void tick_sched_timer_dying(int cpu);
 #else
-static inline void tick_cancel_sched_timer(int cpu) { }
+static inline void tick_sched_timer_dying(int cpu) { }
 #endif
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-- 
2.43.0


