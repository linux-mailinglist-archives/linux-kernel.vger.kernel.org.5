Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA657CF7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjJSMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbjJSMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94893139;
        Thu, 19 Oct 2023 05:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12E1C433CB;
        Thu, 19 Oct 2023 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716935;
        bh=GEHGTe6rFYiWYuzzhF7E1xB6zZAaH9xdzrwx/Nmj808=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmRYaHD8Ss4xqJGRjGttd2Ez3eIm5v7dMgvaQckYHR1EhHiD/bxalxyYOhADE6CYF
         pv9sC3eH9C4dC7pZbDUByJeoSIxyUajO/iVjWz0oZvJPx2wuTxt9QewagVf1+l92YS
         Miu9UbJYlH124Yl0Zmsc67DYiODAjiBYCc++FvCm7PuyCQ24hbWxue9Hvjq+hhadmD
         3pFGGLtNdaIoi1yPIrT6qrLznaP/e+TJbtx1COqngefXOtJ//YgBj4otkOrGUCbDFR
         FPVcwgiY5VBo2hI1utzZ/VozYbkaBQSUy6DQAsS/DuMw+P9ze8obPsh/1OLAVgXjg6
         cug2En7U8fTGw==
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
Subject: [PATCH 2/6] rcu: Don't redump the stalled CPU where RCU GP kthread last ran
Date:   Thu, 19 Oct 2023 14:01:58 +0200
Message-Id: <20231019120202.1216228-3-frederic@kernel.org>
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

The stacks of all stalled CPUs will be dumped in rcu_dump_cpu_stacks().
If the CPU on where RCU GP kthread last ran is stalled, its stack does
not need to be dumped again. We can search the corresponding backtrace
based on the printed CPU ID.

For example:
[   87.328275] rcu: rcu_sched kthread starved for ... ->cpu=3  <--------|
... ...                                                                 |
[   89.385007] NMI backtrace for cpu 3                         <--------|
[   89.385179] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.0+ #22 <--|
[   89.385188] Hardware name: linux,dummy-virt (DT)
[   89.385196] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   89.385204] pc : arch_cpu_idle+0x40/0xc0
[   89.385211] lr : arch_cpu_idle+0x2c/0xc0
... ...
[   89.385566] Call trace:
[   89.385574]  arch_cpu_idle+0x40/0xc0
[   89.385581]  default_idle_call+0x100/0x450
[   89.385589]  cpuidle_idle_call+0x2f8/0x460
[   89.385596]  do_idle+0x1dc/0x3d0
[   89.385604]  cpu_startup_entry+0x5c/0xb0
[   89.385613]  secondary_start_kernel+0x35c/0x520

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b5ce0580074e..fc04a8d7ce96 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -534,12 +534,14 @@ static void rcu_check_gp_kthread_starvation(void)
 		       data_race(READ_ONCE(rcu_state.gp_state)),
 		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
 		if (gpk) {
+			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			if (cpu_is_offline(cpu)) {
 				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
-			} else  {
+			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
 				pr_err("Stack dump where RCU GP kthread last ran:\n");
 				dump_cpu_task(cpu);
 			}
-- 
2.34.1

