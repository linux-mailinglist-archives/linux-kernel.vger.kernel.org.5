Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DBF7BFA89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJJL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJJL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF11C4;
        Tue, 10 Oct 2023 04:59:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11956C433C9;
        Tue, 10 Oct 2023 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939188;
        bh=glrA/NSJlcH7U+M885gEF/l+fOqb3Q+HVQRs7NsZOT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fb3L1l57Mv3evugY4hyyesMCFEfc8CbjShKC3FqdHpFYgNH8PNKC6pjOVmvXbXaeC
         tD0bxibYHjllUcZTUxe1B2lS7cJoW3mLm8bWoo0wVCgd8MRN0DtxdivUxqxU1X7oAL
         /BCrf566nWVrq0Qvi6GChA6KUm8LQNmuZ1h6z/X3kJKLguYup/jIlL1EbwKP6Pmtes
         5XRrLw2iEb3S63TbMQZREAh+Y9fZj9Oy79WjAl1YFmAtScbzKVMnsex2b4T0YlFnQ+
         TLNM7DJxlHshJBdy4EVhfD6Hk5JITK0SfxpQAo0aA3DglbTumpR5zKsvdk6iMcPF9d
         mferUxjepKADA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 05/23] torture: Move rcutorture_sched_setaffinity() out of rcutorture
Date:   Tue, 10 Oct 2023 13:59:03 +0200
Message-Id: <20231010115921.988766-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcutorture_sched_setaffinity() function is needed by locktorture,
so move its declaration from rcu.h to torture.h and rename it to the
more generic torture_sched_setaffinity() name.

Please note that use of this function is still restricted to torture
tests, and of those, currently only rcutorture and locktorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/torture.h | 5 +++++
 kernel/rcu/rcu.h        | 4 ----
 kernel/rcu/rcutorture.c | 2 +-
 kernel/rcu/update.c     | 8 ++++----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 017f0f710815..c98d0c83d117 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -121,10 +121,15 @@ void _torture_stop_kthread(char *m, struct task_struct **tp);
 #define torture_stop_kthread(n, tp) \
 	_torture_stop_kthread("Stopping " #n " task", &(tp))
 
+/* Scheduler-related definitions. */
 #ifdef CONFIG_PREEMPTION
 #define torture_preempt_schedule() __preempt_schedule()
 #else
 #define torture_preempt_schedule()	do { } while (0)
 #endif
 
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_MODULE(CONFIG_LOCK_TORTURE_TEST)
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
+#endif
+
 #endif /* __LINUX_TORTURE_H */
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 98e13be411af..567bd3d72e39 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -568,10 +568,6 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
 
-#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
-long rcutorture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
-#endif
-
 #ifdef CONFIG_TINY_SRCU
 
 static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ade42d6a9d9b..7e82fb887d09 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -810,7 +810,7 @@ static void synchronize_rcu_trivial(void)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		torture_sched_setaffinity(current->pid, cpumask_of(cpu));
 		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
 	}
 }
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 9d3c2e6ba667..c534d6806d3d 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -525,17 +525,17 @@ EXPORT_SYMBOL_GPL(do_trace_rcu_torture_read);
 	do { } while (0)
 #endif
 
-#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST) || IS_ENABLED(CONFIG_LOCK_TORTURE_TEST) || IS_MODULE(CONFIG_LOCK_TORTURE_TEST)
 /* Get rcutorture access to sched_setaffinity(). */
-long rcutorture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	int ret;
 
 	ret = sched_setaffinity(pid, in_mask);
-	WARN_ONCE(ret, "%s: sched_setaffinity() returned %d\n", __func__, ret);
+	WARN_ONCE(ret, "%s: sched_setaffinity(%d) returned %d\n", __func__, pid, ret);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
+EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
 #endif
 
 #ifdef CONFIG_RCU_STALL_COMMON
-- 
2.34.1

