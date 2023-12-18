Return-Path: <linux-kernel+bounces-4477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCCB817E05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B441C20FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB479956;
	Mon, 18 Dec 2023 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8J2LrPG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61A79944;
	Mon, 18 Dec 2023 23:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F3FC433D9;
	Mon, 18 Dec 2023 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941569;
	bh=FjnYKWmKazFNSVW61ol8hhKh2qDPsvgWNQgyqkISaA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8J2LrPGtoGQcZ1ZvOzNwBrc2kpjH28ttt/sL3uw0zBI2iBEVxxQfynVn3lDyDk9N
	 1t5z5Yw4arepFW3hGmvgFTg3/DZfofyYJ4reEfO/qx9llQctX6HMLKNxOUo+Tf5hyz
	 l7iywMPD6S3TZxGCjZhnRyo/mJbIJCJYS3h2hjbGjTQVS8J0QR0VCKYBx0KqaP3w/G
	 EQiKFdixyevxwCsm85+DjiPdIua6uCPZVT4ucU/Nlw7gw3KdMVbLVIDiCIPBpjaGfw
	 CHlBnagO7M2QWUAPXbzTYEf/wXU17zp1GzVwWal4b6fLKa3CTBU8Aqf9JWqCRdtHT+
	 uL36thz7eMxvg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Date: Tue, 19 Dec 2023 00:19:15 +0100
Message-ID: <20231218231916.11719-3-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231218231916.11719-1-frederic@kernel.org>
References: <20231218231916.11719-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CPU goes idle for the last time during the CPU down hotplug
process, RCU reports a final quiescent state for the current CPU. If
this quiescent state propagates up to the top, some tasks may then be
woken up to complete the grace period: the main grace period kthread
and/or the expedited main workqueue (or kworker).

If those kthreads have a SCHED_FIFO policy, the wake up can indirectly
arm the RT bandwith timer to the local offline CPU. Since this happens
after hrtimers have been migrated at CPUHP_AP_HRTIMERS_DYING stage, the
timer gets ignored. Therefore if the RCU kthreads are waiting for RT
bandwidth to be available, they may never be actually scheduled.

This triggers TREE03 rcutorture hangs:

	 rcu: INFO: rcu_preempt self-detected stall on CPU
	 rcu:     4-...!: (1 GPs behind) idle=9874/1/0x4000000000000000 softirq=0/0 fqs=20 rcuc=21071 jiffies(starved)
	 rcu:     (t=21035 jiffies g=938281 q=40787 ncpus=6)
	 rcu: rcu_preempt kthread starved for 20964 jiffies! g938281 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
	 rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
	 rcu: RCU grace-period kthread stack dump:
	 task:rcu_preempt     state:R  running task     stack:14896 pid:14    tgid:14    ppid:2      flags:0x00004000
	 Call Trace:
	  <TASK>
	  __schedule+0x2eb/0xa80
	  schedule+0x1f/0x90
	  schedule_timeout+0x163/0x270
	  ? __pfx_process_timeout+0x10/0x10
	  rcu_gp_fqs_loop+0x37c/0x5b0
	  ? __pfx_rcu_gp_kthread+0x10/0x10
	  rcu_gp_kthread+0x17c/0x200
	  kthread+0xde/0x110
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork+0x2b/0x40
	  ? __pfx_kthread+0x10/0x10
	  ret_from_fork_asm+0x1b/0x30
	  </TASK>

The situation can't be solved with just unpinning the timer. The hrtimer
infrastructure and the nohz heuristics involved in finding the best
remote target for an unpinned timer would then also need to handle
enqueues from an offline CPU in the most horrendous way.

So fix this on the RCU side instead and defer the wake up to an online
CPU if it's too late for the local one.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c     | 34 +++++++++++++++++++++++++++++++++-
 kernel/rcu/tree_exp.h |  3 +--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ac3c846105f..157f3ca2a9b5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1013,6 +1013,38 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 	return needmore;
 }
 
+static void swake_up_one_online_ipi(void *arg)
+{
+	struct swait_queue_head *wqh = arg;
+
+	swake_up_one(wqh);
+}
+
+static void swake_up_one_online(struct swait_queue_head *wqh)
+{
+	int cpu = get_cpu();
+
+	/*
+	 * If called from rcutree_report_cpu_starting(), wake up
+	 * is dangerous that late in the CPU-down hotplug process. The
+	 * scheduler might queue an ignored hrtimer. Defer the wake up
+	 * to an online CPU instead.
+	 */
+	if (unlikely(cpu_is_offline(cpu))) {
+		int target;
+
+		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
+					 cpu_online_mask);
+
+		smp_call_function_single(target, swake_up_one_online_ipi,
+					 wqh, 0);
+		put_cpu();
+	} else {
+		put_cpu();
+		swake_up_one(wqh);
+	}
+}
+
 /*
  * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
  * interrupt or softirq handler, in which case we just might immediately
@@ -1037,7 +1069,7 @@ static void rcu_gp_kthread_wake(void)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
-	swake_up_one(&rcu_state.gp_wq);
+	swake_up_one_online(&rcu_state.gp_wq);
 }
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6d7cea5d591f..2ac440bc7e10 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -173,7 +173,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
 	return ret;
 }
 
-
 /*
  * Report the exit from RCU read-side critical section for the last task
  * that queued itself during or before the current expedited preemptible-RCU
@@ -201,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				swake_up_one(&rcu_state.expedited_wq);
+				swake_up_one_online(&rcu_state.expedited_wq);
 			}
 			break;
 		}
-- 
2.42.1


