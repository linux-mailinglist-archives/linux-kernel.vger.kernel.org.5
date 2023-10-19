Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8E7D056E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbjJSXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbjJSXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:36:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19D11D;
        Thu, 19 Oct 2023 16:36:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71A5C433C7;
        Thu, 19 Oct 2023 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697758563;
        bh=dFLlbmcwk20GgIBfNZC+zS71NZd8v6vjwcVszfRzl3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0MThQ7u+sfp4jgen87T3Ojc9/LZ4+Ib4ysdidYB5VkASFBaj3DtTqJ4JDqj0jP58
         Y0N1CZtiW0bCl7tGqFJSYgzC3ADPVwhDkki7uOT+D9L6hMpuQFVgciUxSwDYNYZTGA
         YE0iWsUuznM1F9VB2uF7HSES9tKxTYqdpqcOCkqiFbzpA3BxG3aAQEHG12R6ap46XK
         4KS/wzBS2ta3bSfCwanFWn9f3kNb83k5erF3BNrCp2RVJEUOxwzC6W05BruDdawb+d
         0IgcI1Qr+xNz1RhJagW26kcB6yNa54vJupF6rG8DFxG9qSaOBzyaIuXp869QQRx1d9
         eVD/wSSpuPe0g==
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
Subject: [PATCH 3/4] rcu: Make tiny RCU use ksoftirqd to trigger a QS from idle
Date:   Fri, 20 Oct 2023 01:35:42 +0200
Message-Id: <20231019233543.1243121-4-frederic@kernel.org>
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

The commit:

	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")

fixed an issue where rcutiny would request a quiescent state with
setting TIF_NEED_RESCHED in early boot when init/0 has the PF_IDLE flag
set but interrupts aren't enabled yet. A subsequent call to
cond_resched() would then enable IRQs too early.

When callbacks are enqueued in idle, RCU currently performs the
following:

1) Call resched_cpu() to trigger exit from idle and go through the
   scheduler to call rcu_note_context_switch() -> rcu_qs()

2) rcu_qs() notes the quiescent state and raises RCU_SOFTIRQ if there
   is a callback, waking up ksoftirqd since it isn't called from an
   interrupt.

However the call to resched_cpu() can opportunistically be replaced and
optimized with raising RCU_SOFTIRQ and forcing ksoftirqd wakeup instead.

It's worth noting that RCU grace period polling while idle is then
suboptimized but such a usecase can be considered very rare or even
non-existent.

The advantage of this optimization is that it also works if PF_IDLE is
set early because ksoftirqd is created way after IRQs are enabled on
boot and it can't be awaken before its creation. If
raise_ksoftirqd_irqoff() is called after the first scheduling point
but before kostfirqd is created, nearby voluntary schedule calls are
expected to provide the desired quiescent state and in the worst case
the first launch of ksoftirqd is close enough on the first initcalls.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tiny.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index fec804b79080..9460e4e9d84c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -190,12 +190,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	local_irq_save(flags);
 	*rcu_ctrlblk.curtail = head;
 	rcu_ctrlblk.curtail = &head->next;
-	local_irq_restore(flags);
 
 	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_qs() */
-		resched_cpu(0);
+		/*
+		 * Force resched to trigger a QS and handle callbacks right after.
+		 * This also takes care of avoiding too early rescheduling on boot.
+		 */
+		raise_ksoftirqd_irqoff(RCU_SOFTIRQ);
 	}
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -228,8 +231,16 @@ unsigned long start_poll_synchronize_rcu(void)
 	unsigned long gp_seq = get_state_synchronize_rcu();
 
 	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_qs() */
-		resched_cpu(0);
+		unsigned long flags;
+
+		/*
+		 * Force resched to trigger a QS. This also takes care of avoiding
+		 * too early rescheduling on boot. It's suboptimized but GP
+		 * polling on idle isn't expected much as a usecase.
+		 */
+		local_irq_save(flags);
+		raise_ksoftirqd_irqoff(RCU_SOFTIRQ);
+		local_irq_restore(flags);
 	}
 	return gp_seq;
 }
-- 
2.34.1

