Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE277D5D67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjJXVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbjJXVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:46:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17440E8;
        Tue, 24 Oct 2023 14:46:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D70CC433CA;
        Tue, 24 Oct 2023 21:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698183997;
        bh=55r/JWo6Uc73yf5DqaZWWtL9jn0mpU9zwuvJddzRrBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJwBiK2zpYQrDryXd6sMwPwBHy1iWVHeuLLm1/SKdspkdlBLaYb177rzprEGFzQFC
         d/2ylslU8EmC2+4Sxk4BW38uhxydzZeW+CDALQ60QUQXXXMYjKOENLFfZDMsQ7glEN
         8TPMKcAiWCjVXy86PTUMPR4BEzvx+20j7GxF0ihu6H1skiQnZQQdkTR+l8JG5Oe8yb
         qTLqfRwx7ExEu1za8vQIQvLUB4dJIgVHGysKG9CVdjrd+GFhiUBp0cCxXA3ht+hfqb
         Yy0yzvn+ueDYrOWnH1UYuicR+p70IkpRclVnhpdORftbhzg+rh52jd3Uz8zDi6+0G/
         yVG9Kidh8eqhw==
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
Subject: [PATCH 1/4] rcu: Introduce rcu_cpu_online()
Date:   Tue, 24 Oct 2023 23:46:22 +0200
Message-ID: <20231024214625.6483-2-frederic@kernel.org>
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

Export the RCU point of view as to when a CPU is considered offline
(ie: when does RCU consider that a CPU is sufficiently down in the
hotplug process to not feature any possible read side).

This will be used by RCU-tasks whose vision of an offline CPU should
reasonably match the one of RCU core.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcu.h  | 2 ++
 kernel/rcu/tree.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0d866eaa4cc8..b531c33e9545 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -500,6 +500,7 @@ static inline void rcu_expedite_gp(void) { }
 static inline void rcu_unexpedite_gp(void) { }
 static inline void rcu_async_hurry(void) { }
 static inline void rcu_async_relax(void) { }
+static inline bool rcu_cpu_online(int cpu) { return true; }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_gp_is_normal(void);     /* Internal RCU use. */
 bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
@@ -509,6 +510,7 @@ void rcu_unexpedite_gp(void);
 void rcu_async_hurry(void);
 void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
+bool rcu_cpu_online(int cpu);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 700524726079..fd21c1506092 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4202,6 +4202,13 @@ static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
 	return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
 }
 
+bool rcu_cpu_online(int cpu)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	return rcu_rdp_cpu_online(rdp);
+}
+
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
 
 /*
-- 
2.41.0

