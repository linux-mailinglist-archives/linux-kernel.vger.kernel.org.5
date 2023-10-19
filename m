Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A02E7CF7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbjJSMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjJSMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC747196;
        Thu, 19 Oct 2023 05:02:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F88C433C9;
        Thu, 19 Oct 2023 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716943;
        bh=ShCXAwxxAgan1qRtdZgfmeLTKWI3nAC2NT8Wlxximew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dts7cxLin6moTJ4VS6MB8iwZruk43SsPTZw8Y7xGuQiusfPVRvoSKElmb9+PswaGw
         HmuXE35MmGzGFvK0MHpqfkROEdfJ4FzPcJjAKixSSKyCn1j6RjzCwzeaRvr1cblqXh
         zm+3o/B//sdxbV0f1p6/RF/DbJR7AKZe1DP+Jgts8bFI8cdYvlswOAxBdpMeCy9NTP
         eXaen7P8rM6eNO8B6+TUgrUSgjA/xs0uFqf9L7DHTdslcCOQW+N4DtZZnLq7yk7+6o
         6zlbD3ixKQ+pqDRRhltG5Y7vqwdOcn3iHdWCxlTfIA/xKsbi3k9xfnWjLAJijAfrWk
         wm98opZP+BGig==
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
Subject: [PATCH 5/6] rcutorture: Add test of RCU CPU stall notifiers
Date:   Thu, 19 Oct 2023 14:02:01 +0200
Message-Id: <20231019120202.1216228-6-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit registers an RCU CPU stall notifier when testing RCU CPU
stalls.  The notifier logs a message similar to the following:

	rcu_torture_stall_nf: v=1, duration=21001.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ade42d6a9d9b..1830cacac01d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/rcu_notifier.h>
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <uapi/linux/sched/types.h>
@@ -2428,6 +2429,16 @@ static int rcutorture_booster_init(unsigned int cpu)
 	return 0;
 }
 
+static int rcu_torture_stall_nf(struct notifier_block *nb, unsigned long v, void *ptr)
+{
+	pr_info("%s: v=%lu, duration=%lu.\n", __func__, v, (unsigned long)ptr);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rcu_torture_stall_block = {
+	.notifier_call = rcu_torture_stall_nf,
+};
+
 /*
  * CPU-stall kthread.  It waits as specified by stall_cpu_holdoff, then
  * induces a CPU stall for the time specified by stall_cpu.
@@ -2435,9 +2446,14 @@ static int rcutorture_booster_init(unsigned int cpu)
 static int rcu_torture_stall(void *args)
 {
 	int idx;
+	int ret;
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
+	ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
+	if (ret)
+		pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
+			__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
 	if (stall_cpu_holdoff > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
@@ -2481,6 +2497,11 @@ static int rcu_torture_stall(void *args)
 		cur_ops->readunlock(idx);
 	}
 	pr_alert("%s end.\n", __func__);
+	if (!ret) {
+		ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
+		if (ret)
+			pr_info("%s: rcu_stall_chain_notifier_unregister() returned %d.\n", __func__, ret);
+	}
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
-- 
2.34.1

