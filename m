Return-Path: <linux-kernel+bounces-111468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F258886CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15064282F53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137A45BFD;
	Fri, 22 Mar 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoImSUIL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62504501D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113745; cv=none; b=BlKH+opGzHkSwBcHLOPeN6N2spD30r4qWz1HNpbf2f1UgI7ekor5tFdjojpHvsdnA8AYyskQhf1+zefJMbNHPQSaiu+Kl0eX6ItxZfgrJwo0i82uV6AFZuQ8M64/52pH8mMn+TlAXVPGDplEPwQv9zlb51BIRuImGAGy8YDIdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113745; c=relaxed/simple;
	bh=XB8l+qkDjq1bktRiPkHSEy0MWwrdCflzuugZDaqqMFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ4DTgB8mJFpR4UZTnwuenUNVrHUC41UtGjmyqnyinJJoZ8ynh4RFcfOr9DuYl8L97SevYqba5hXcjJmmZ9E+5Ch7hXMlmlqwJ55p/gIpgvTtxgPmQwPuMsfEKUuVfhre3t2j35lrX9qnBxNTSUiw1U73nBbhz3JUyAEoOfc+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoImSUIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05192C433F1;
	Fri, 22 Mar 2024 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113745;
	bh=XB8l+qkDjq1bktRiPkHSEy0MWwrdCflzuugZDaqqMFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoImSUILzhNhjDkkha9QAOJcmO/qenR2mapPH5sJ7SUIm51Lo2JGb8jU+SKzCh/sk
	 bkOdgLvMoCN2daZJgkQOHY7NAl/Ae9/388Yey4ByRtIb8iotwg+Z6qYTywSn2cJd5f
	 xjvqpwieHRd6Tkf6Ct1K7r4502mW+4ZN4a9ZYovTT7mxzV8IOl6wv15pznIcWaRKpJ
	 twHg26cqkgo2sC41oe2Qd2o/UFR/K6lcaolydvfj5Hmqk34S1+ljx6d1GMid61A/ZM
	 VLZRu2ccUFhCR7C7De6fR5mVGxnT+LByT0JRP6qJVH9C5i7wOW7CeczrGoFSLDafiz
	 xkCPQ9Ui4TCfA==
Date: Fri, 22 Mar 2024 14:22:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Alex Shi <alexs@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Barry Song <song.bao.hua@hisilicon.com>
Subject: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
Message-ID: <Zf2GDjekyemQKn7I@lothringen>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf1sSv/6mQHJuJ8G@lothringen>

On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
> On Thu, Mar 21, 2024 at 05:47:59AM -0700, Paul E. McKenney wrote:
> [ 1484.955213] WARNING: CPU: 6 PID: 162 at kernel/time/hrtimer.c:1088 enqueue_hrtimer+0x6f/0x80
> [ 1484.962513] Modules linked in:
> [ 1484.966476] CPU: 6 PID: 162 Comm: rcu_torture_rea Not tainted 6.8.0 #25
> [ 1484.972975] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [ 1484.977653] RIP: 0010:enqueue_hrtimer+0x6f/0x80
> [ 1484.978679] Code: a3 05 75 6a b7 01 73 bd 48 8b 05 e4 47 b5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 eb bd ff ff 48 8b 03 f6 40 10 10 75 a5 90 <0f> 0b 90 eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
> [ 1484.983136] RSP: 0000:ffffa553805cfd70 EFLAGS: 00010046
> [ 1484.984386] RAX: ffff8c395f260440 RBX: ffff8c395f260480 RCX: ffff8c395f260440
> [ 1484.986121] RDX: 0000000000000000 RSI: ffff8c395f260480 RDI: ffffa553805cfde0
> [ 1484.987704] RBP: ffffa553805cfde0 R08: 0000000000000001 R09: 000000000000fc03
> [ 1484.989513] R10: 0000000000000001 R11: ffff8c3941248e40 R12: 0000000000000040
> [ 1484.991116] R13: ffff8c395f260480 R14: ffff8c395f260480 R15: ffff8c395f260440
> [ 1484.992835] FS:  0000000000000000(0000) GS:ffff8c395f380000(0000) knlGS:0000000000000000
> [ 1484.994683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1484.995985] CR2: 0000000000000000 CR3: 000000001a62c000 CR4: 00000000000006f0
> [ 1484.997789] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1484.999376] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1485.001177] Call Trace:
> [ 1485.002388]  <TASK>
> [ 1485.002923]  ? __warn+0x78/0x120
> [ 1485.003641]  ? enqueue_hrtimer+0x6f/0x80
> [ 1485.004641]  ? report_bug+0xf1/0x1d0
> [ 1485.005537]  ? handle_bug+0x40/0x70
> [ 1485.006318]  ? exc_invalid_op+0x13/0x70
> [ 1485.007167]  ? asm_exc_invalid_op+0x16/0x20
> [ 1485.008117]  ? enqueue_hrtimer+0x6f/0x80
> [ 1485.009131]  hrtimer_start_range_ns+0x258/0x2f0
> [ 1485.010153]  ? __pfx_rcu_torture_reader+0x10/0x10
> [ 1485.011185]  schedule_hrtimeout_range_clock+0x96/0x120
> [ 1485.012394]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [ 1485.013502]  stutter_wait+0x7f/0x90
> [ 1485.014319]  rcu_torture_reader+0x10e/0x280
> [ 1485.015240]  ? __pfx_rcu_torture_timer+0x10/0x10
> [ 1485.016317]  ? kthread+0xc6/0xf0
> [ 1485.017169]  ? __pfx_rcu_torture_reader+0x10/0x10
> [ 1485.018215]  kthread+0xc6/0xf0
> [ 1485.018899]  ? __pfx_kthread+0x10/0x10
> [ 1485.019703]  ret_from_fork+0x2b/0x40
> [ 1485.020546]  ? __pfx_kthread+0x10/0x10
> [ 1485.021428]  ret_from_fork_asm+0x1b/0x30
> [ 1485.022295]  </TASK>
> 
> This happens within the following loop
> 
> 	for_each_domain(cpu, sd) {
> 		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> 			if (cpu == i)
> 				continue;
> 
> 			if (!idle_cpu(i))
> 				return i;
> 		}
> 	}
> 
> An offline CPU is returned from there. Which is not supposed to happen
> as it's within an RCU read side. But I can't manage to find where those
> rq->sd things are modified when a CPU is offlining. The code path is hard
> to follow. Adding some scheduler people involved in topology just in case.
> Investigation continues...

So I just tried a simple test. I applied the following PoF patch, under the
assumption that right after the exit of takedown_cpu(), the target CPU is
offline and all CPUs must see the updates perfomed by the now dead target
CPU. I expect also that the target CPU should have removed itself from the
scheduling domains (though I don't know where that happens in the maze):

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..2e0580abc73a 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,6 +9,7 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern void sched_assert_online_domains(int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..3424d1d40142 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1024,7 +1024,7 @@ void clear_tasks_mm_cpumask(int cpu)
 }
 
 /* Take this CPU down. */
-static int take_cpu_down(void *_param)
+int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..57f483fc1037 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1055,6 +1055,22 @@ void resched_cpu(int cpu)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_NO_HZ_COMMON
+void sched_assert_online_domains(int cpu)
+{
+	struct sched_domain *sd;
+	int i;
+
+	rcu_read_lock();
+	for_each_domain(cpu, sd) {
+		for_each_cpu(i, sched_domain_span(sd)) {
+			if (cpu == i)
+				continue;
+
+			WARN_ON_ONCE(cpu_is_offline(i));
+		}
+	}
+	rcu_read_unlock();
+}
 /*
  * In the semi idle case, use the nearest busy CPU for migrating timers
  * from an idle CPU.  This is good for power-savings.
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..354806156bd9 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/nmi.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/nohz.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -199,6 +200,8 @@ notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
 	cpu_relax();
 }
 
+extern int take_cpu_down(void *_param);
+
 /* This is the cpu_stop function which stops the CPU. */
 static int multi_cpu_stop(void *data)
 {
@@ -255,6 +258,8 @@ static int multi_cpu_stop(void *data)
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
+	if (!is_active && msdata->fn == take_cpu_down)
+		sched_assert_online_domains(smp_processor_id());
 	return err;
 }
 
Then with that patch I ran TREE07, just some short iterations:

tools/testing/selftests/rcutorture/bin/kvm.sh --configs "10*TREE07" --allcpus --bootargs "rcutorture.onoff_interval=200" --duration 2

And the warning triggers very quickly. At least since v6.3 but maybe since
earlier. Is this expected behaviour or am I right to assume that
for_each_domain()/sched_domain_span() shouldn't return an offline CPU?

Thanks.

