Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94E47C8536
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjJMMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjJMMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:00:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E459128;
        Fri, 13 Oct 2023 04:59:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A8EC433CA;
        Fri, 13 Oct 2023 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198386;
        bh=FQagvd3jim1vzLZluSHTIHqE/ZMRbbrLCQrXxKWYGq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heTtGtSecdsKYa7W/R1Z1z0SeOVDjYpQoDiPFINWnTuMzEiwro6TdB2AJ2E1nasyv
         /rUdpOgREj3kz73+hwtOZVonmWj1tgEz9Ox0diafReZahnnCNQh0ioxskwXb/j96/z
         qsM027GELQ42gdQvvLelfGRfuw9gn4Ydk/SkRj0RisnoS6Ih8rpGZXn3TNNAk83jB5
         fiaudv4Ny0QD0cyGyUTYXLI9fqJYdfjkdlyYz9RMVKf9shSq+okffjMrLgQ2WCRYKR
         023ipCxZezIXwWDvAB5G06Uifv5yUR7QMxPGDy5y5B54gR1EoVwA0nJb94m9hdK18i
         Wlg9YIpDberpw==
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
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: [PATCH 13/18] rcu: Assume rcu_report_dead() is always called locally
Date:   Fri, 13 Oct 2023 13:58:57 +0200
Message-Id: <20231013115902.1059735-14-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
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

rcu_report_dead() has to be called locally by the CPU that is going to
exit the RCU state machine. Passing a cpu argument here is error-prone
and leaves the possibility for a racy remote call.

Use local access instead.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/kernel/smp.c  | 2 +-
 include/linux/rcupdate.h | 2 +-
 kernel/cpu.c             | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 960b98b43506..8fa646c90c67 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -401,7 +401,7 @@ void __noreturn cpu_die_early(void)
 
 	/* Mark this CPU absent */
 	set_cpu_present(cpu, 0);
-	rcu_report_dead(cpu);
+	rcu_report_dead();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 		update_cpu_boot_status(CPU_KILL_ME);
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..aa351ddcbe8d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -122,7 +122,7 @@ static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 void rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
-void rcu_report_dead(unsigned int cpu);
+void rcu_report_dead(void);
 void rcutree_migrate_callbacks(int cpu);
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74ee..076e75fed8bb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1388,7 +1388,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
-	rcu_report_dead(smp_processor_id());
+	rcu_report_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
 	 * We cannot call complete after rcu_report_dead() so we delegate it
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8c2954502e55..2e1e7eadf2cc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4560,11 +4560,11 @@ void rcu_cpu_starting(unsigned int cpu)
  * from the outgoing CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
  */
-void rcu_report_dead(unsigned int cpu)
+void rcu_report_dead(void)
 {
 	unsigned long flags;
 	unsigned long mask;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	/*
-- 
2.34.1

