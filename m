Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA77D5D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjJXVq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344477AbjJXVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:46:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101AE8;
        Tue, 24 Oct 2023 14:46:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE75DC433C7;
        Tue, 24 Oct 2023 21:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698184009;
        bh=AqHnLeB5xem2kiRsFLowge6w/ot0AAmqtV9xGzicirc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDaO3ZmCJO3fKoF+gIfWqQroBqbgxx5f8hX2+JrCOc4JsdJNI38tcDbzDbxDd9IiD
         lQQjafqLkkawzo6WRYBYq6iBDRLc6rw/K82bL4QufhCMuuMtuiIDHLj1HTZLkWwhv0
         Y7mPAxMD5NRzchUhYgtYdpyVNGyV6qMUsXDOOPc0ShJDQv6YARd0YrIOFvg4uFaCm6
         1ngaB9X+/AarJdFS3TRUPmWau++XTxbJE6uZMiH0YYWipraB8z3fgsqMiLJkFXYbza
         ZaAmHAP183sCvV3XzoyR81WsOfdotWNwXasO1UWQeKF/ElKrOC4OzjJFDnqlnpa/LJ
         dKFkktu+IKyVw==
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
Subject: [PATCH 4/4] sched: Exclude CPU boot code from PF_IDLE area
Date:   Tue, 24 Oct 2023 23:46:25 +0200
Message-ID: <20231024214625.6483-5-frederic@kernel.org>
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
such a way that only the actual idle loop is accounted as PF_IDLE. The
intent is to exclude the CPU boot code from that coverage.

However this doesn't clear the flag when the CPU goes down. Therefore
when the CPU goes up again, its boot code is part of the PF_IDLE zone.

Make sure this flag behave consistently and clear the flag when a CPU
exits from the idle loop. If anything, RCU-tasks relies on it to exclude
CPU boot code from its quiescent states.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched.h | 2 +-
 kernel/cpu.c          | 4 ++++
 kernel/sched/idle.c   | 1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8885be2c143e..ad18962b921d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1945,7 +1945,7 @@ extern struct task_struct *idle_task(int cpu);
  */
 static __always_inline bool is_idle_task(const struct task_struct *p)
 {
-	return !!(p->flags & PF_IDLE);
+	return !!(READ_ONCE(p->flags) & PF_IDLE);
 }
 
 extern struct task_struct *curr_task(int cpu);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3b9d5c7eb4a2..3a1991010f4e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	WRITE_ONCE(current->flags, current->flags & ~PF_IDLE);
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+
 	rcutree_report_cpu_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
@@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	WRITE_ONCE(current->flags, current->flags | PF_IDLE);
+
 	/* Happens for the boot cpu */
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
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
2.41.0

