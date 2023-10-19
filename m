Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA47CF7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345511AbjJSMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbjJSMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA85193;
        Thu, 19 Oct 2023 05:02:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16BAC433C9;
        Thu, 19 Oct 2023 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716932;
        bh=3y9CeNYUlIJW5JcYaNHy3H8Dnbv10KviDi7g0Akst9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pT1BJ9EYiFJuh1grJANBeWldKA8R12Y2yhHwv6Qd/kmSR2BPN3hP3jRVRAQkGrzmc
         su74tO3dzxd9/oVp/MpTByCpaGK3yikim86Qpl8A8gdeCfbN2DOdIcfYTJIvD4Vr/m
         MEUueOLZeMVBxIkMB0WNM1jx/3FU9tOrz8sW6RkEak7WdQcxtOh/EiWqwK28mWdX9v
         NbAMjBEL9EyPX/wFGr/b0u2229GShll0d7zpKPS8c8Tnf7HAgx+HpsdAljmArcaZ5V
         kvwyrBLq4nWqIPondsqPUQlJmOULpKp2eea9BeF+38S+Yh45pToDnCoIE3Gm2HwoeH
         c1hVUW/cwkhnA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/6] rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
Date:   Thu, 19 Oct 2023 14:01:57 +0200
Message-Id: <20231019120202.1216228-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120202.1216228-1-frederic@kernel.org>
References: <20231019120202.1216228-1-frederic@kernel.org>
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

From: Zhen Lei <thunder.leizhen@huawei.com>

The rcu_check_gp_kthread_starvation() function uses task_cpu() to sample
the last CPU that the grace-period kthread ran on, and task_cpu() samples
the thread_info structure's ->cpu field.  But this field will always
contain a number corresponding to a CPU that was online some time in
the past, thus never a negative number.  This invariant is checked by
a WARN_ON_ONCE() in set_task_cpu().

This means that if the grace-period kthread exists, that is, if the "gpk"
local variable is non-NULL, the "cpu" local variable will be non-negative.
This in turn means that the existing check for non-negative "cpu" is
redundant with the enclosing check for non-NULL "gpk".

This commit threefore removes the redundant check of "cpu".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_stall.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6f06dc12904a..b5ce0580074e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -537,13 +537,11 @@ static void rcu_check_gp_kthread_starvation(void)
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
-			if (cpu >= 0) {
-				if (cpu_is_offline(cpu)) {
-					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
-				} else  {
-					pr_err("Stack dump where RCU GP kthread last ran:\n");
-					dump_cpu_task(cpu);
-				}
+			if (cpu_is_offline(cpu)) {
+				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
+			} else  {
+				pr_err("Stack dump where RCU GP kthread last ran:\n");
+				dump_cpu_task(cpu);
 			}
 			wake_up_process(gpk);
 		}
-- 
2.34.1

