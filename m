Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33CE7D056D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbjJSXgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjJSXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:36:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A443918C;
        Thu, 19 Oct 2023 16:35:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2015C433C9;
        Thu, 19 Oct 2023 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697758559;
        bh=G8Ft7qYrBUqFVecE25yG9J1QI44MxA99SLR4I8DhQCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcvzMQNCuu5kN4SZyJr2LBpbsCdYKAvYqtLErvqiyMnKxHzBqlLY/lla5VggsyeoJ
         71LkIljQUmMR3q35JnmCs2jcbodm8Kb8+XuduevxCq/YNT8V1tiOlQz+9Y0VspoWWs
         STK7kNWfgOHMpUVLtsuDOwaSxR+HakakeDWK2p2fHKo+FpHS3hnt9P0sy8ocjFo2WY
         cCHyoW163m5TIkfRf/mENYHiQj0n9nMZOlvJVnDjJV9lyND0QFl1xlZAAY5lr6PG4v
         /36B3/7RGxeS2PIWOXfdtmZmxQbC+lN2DDPOkThp3TYvM7/fGvjjaqZwxHNNLm5b1v
         4ASc41AUt2mOQ==
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
Subject: [PATCH 2/4] softirq: Introduce raise_ksoftirqd_irqoff()
Date:   Fri, 20 Oct 2023 01:35:41 +0200
Message-Id: <20231019233543.1243121-3-frederic@kernel.org>
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

Provide a function to raise a softirq vector and force the wakeup of
ksoftirqd along the way, irrespective of the current interrupt context.

This is going to be used by rcutiny to fix and optimize the triggering
of quiescent states from idle.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/interrupt.h |  1 +
 kernel/softirq.c          | 71 +++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 558a1a329da9..301d2956e746 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -608,6 +608,7 @@ extern void raise_softirq_no_wake(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
+extern void raise_ksoftirqd_irqoff(unsigned int nr);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index acfed6f3701d..9c29a8ced1c3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -659,35 +659,6 @@ void irq_exit(void)
 	lockdep_hardirq_exit();
 }
 
-/*
- * This function must run with irqs disabled!
- */
-inline void raise_softirq_irqoff(unsigned int nr)
-{
-	raise_softirq_no_wake(nr);
-
-	/*
-	 * If we're in an interrupt or softirq, we're done
-	 * (this also catches softirq-disabled code). We will
-	 * actually run the softirq once we return from
-	 * the irq or softirq.
-	 *
-	 * Otherwise we wake up ksoftirqd to make sure we
-	 * schedule the softirq soon.
-	 */
-	if (!in_interrupt() && should_wake_ksoftirqd())
-		wakeup_softirqd();
-}
-
-void raise_softirq(unsigned int nr)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	raise_softirq_irqoff(nr);
-	local_irq_restore(flags);
-}
-
 void raise_softirq_no_wake(unsigned int nr)
 {
 	lockdep_assert_irqs_disabled();
@@ -695,6 +666,48 @@ void raise_softirq_no_wake(unsigned int nr)
 	or_softirq_pending(1UL << nr);
 }
 
+/*
+ * This function must run with irqs disabled!
+ */
+static inline void __raise_softirq_irqoff(unsigned int nr, bool threaded)
+{
+	raise_softirq_no_wake(nr);
+
+	if (threaded && should_wake_ksoftirqd())
+		wakeup_softirqd();
+}
+
+/*
+ * This function must run with irqs disabled!
+ */
+inline void raise_softirq_irqoff(unsigned int nr)
+{
+	bool threaded;
+	/*
+	 * If in an interrupt or softirq (servicing or disabled
+	 * section), the vector will be handled at the end of
+	 * the interrupt or softirq servicing/disabled section.
+	 * Otherwise the vector must rely on ksoftirqd.
+	 */
+	threaded = !in_interrupt();
+
+	__raise_softirq_irqoff(nr, threaded);
+}
+
+void raise_softirq(unsigned int nr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	raise_softirq_irqoff(nr);
+	local_irq_restore(flags);
+}
+
+void raise_ksoftirqd_irqoff(unsigned int nr)
+{
+	__raise_softirq_irqoff(nr, true);
+}
+
 void open_softirq(int nr, void (*action)(struct softirq_action *))
 {
 	softirq_vec[nr].action = action;
-- 
2.34.1

