Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED67D056F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbjJSXgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbjJSXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:36:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017318A;
        Thu, 19 Oct 2023 16:36:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1AAC433CB;
        Thu, 19 Oct 2023 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697758566;
        bh=SRJb9h+7LIx0+8pFOh4ACdoNOIWr+SDM51E4mSRaHRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thbIHCBuTzwshUBgP4oE3WpBPBX/sHqzNus6LSOjGCnc+iREVAB3PRd5cGTPUtG90
         rn40Yzh2FxHCTw8qAPCQ43znSvmGBkAK6Px6ifHhYyVF8YFMMUu8X0BGIajFntpPnh
         +8sxBf5TGEgifiSUPwyq+Nm2ej6yAh2oXuoNRqID5b+MttWoOAODJTwpQWG+aPCxKL
         Wa+5mtFGOApxGtFdsYgeh5mQAaaVn3uISiOsF9qZm/65yJFQsY68DAgmC0x7mBcLPR
         yK8zLr346hQ5QwZlZE8wpCChG4KsvVzOPabJj8uWge87VAWcI5vZXULvfpNpK0N/Ej
         OC1n6qchNxN/A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/4] Revert "kernel/sched: Modify initial boot task idle setup"
Date:   Fri, 20 Oct 2023 01:35:43 +0200
Message-Id: <20231019233543.1243121-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019233543.1243121-1-frederic@kernel.org>
References: <20231019233543.1243121-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that rcutiny can deal with early boot PF_IDLE setting, revert
commit cff9b2332ab762b7e0586c793c431a8f2ea4db04.

This fixes several subtle issues introduced on RCU-tasks(-trace):

1) RCU-tasks stalls when:

   1.1 Grace period is started before init/0 had a chance to set PF_IDLE,
       keeping it stuck in the holdout list until idle ever schedules.

   1.2 Grace period is started when some possible CPUs have never been
       online, keeping their idle tasks stuck in the holdout list until
       the CPU ever boots up.

   1.3 Similar to 1.1 but with secondary CPUs: Grace period is started
       concurrently with secondary CPU booting, putting its idle task in
       the holdout list because PF_IDLE isn't yet observed on it. It
       stays then stuck in the holdout list until that CPU ever
       schedules. The effect is mitigated here by all the smpboot
       kthreads and the hotplug AP thread that must run to bring the
       CPU up.

2) Spurious warning on RCU task trace that assumes offline CPU's idle
   task is always PF_IDLE.

More issues have been found in RCU-tasks related to PF_IDLE which should
be fixed with later changes as those are not regressions:

3) The RCU-Tasks semantics consider the idle loop as a quiescent state,
   however:

   3.1 The boot code preceding the idle entry is included in this
       quiescent state. Especially after the completion of kthreadd_done
       after which init/1 can launch userspace concurrently. The window
       is tiny before PF_IDLE is set but it exists.

   3.2 Similarly, the boot code preceding the idle entry on secondary
       CPUs is wrongly accounted as RCU tasks quiescent state.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/idle.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad960f97e4e1..b02dcbe98024 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc6..342f58a329f5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,7 +373,6 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
-- 
2.34.1

