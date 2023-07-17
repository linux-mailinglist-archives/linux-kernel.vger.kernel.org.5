Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E375639B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjGQM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGQM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:58:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6ED10CF;
        Mon, 17 Jul 2023 05:57:41 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyp8SW9fPKvymKp02vvtkcYqY11RKymqENoP2oThiHY=;
        b=oqLBGxYRO0/tIsKdQnooTlx+mtnPnE9nVYhYqOX2lXiJajGyW5xm20/T/EBQkewdlmoTUr
        6/QaWs+9heRNy6w3q/GFWmTXkmAv4SDyJvL0WTwTacrDUA9c675N8ft0FuGdKPbGP6STRq
        7MYrqpw6sDH8HZNJyaZBhgdxDzbmJIdHbAj827yCzxIJzc28S8xjbWDtrCeI1rTSkpGhEz
        /CZb9lDaTSfeIInPcRANhXbSUQgB317f09P8TP44u+J0U7qRGgoRees8pc2biakYazpTYY
        x2IytUVNVV07JEWQY0EwZ85YJZ1uoCpzN+eK2XTarLQi58VIcvkahWq+4sbjkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyp8SW9fPKvymKp02vvtkcYqY11RKymqENoP2oThiHY=;
        b=p3Dur/RsOl0KCQ3JZhpyW9cjAOrB7KHybvp9rDBGz6B5UmmqJwHUKoNU3hdqEu+Ej2HpCt
        PaRAQVh07U7KRmCA==
From:   "tip-bot2 for Cruz Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: introduce sched_core_idle_cpu()
Cc:     Cruz Zhao <CruzZhao@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <168959857473.28540.17999305003559332771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     548796e2e70b44b4661fd7feee6eb239245ff1f8
Gitweb:        https://git.kernel.org/tip/548796e2e70b44b4661fd7feee6eb239245ff1f8
Author:        Cruz Zhao <CruzZhao@linux.alibaba.com>
AuthorDate:    Thu, 29 Jun 2023 12:02:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:50 +02:00

sched/core: introduce sched_core_idle_cpu()

As core scheduling introduced, a new state of idle is defined as
force idle, running idle task but nr_running greater than zero.

If a cpu is in force idle state, idle_cpu() will return zero. This
result makes sense in some scenarios, e.g., load balance,
showacpu when dumping, and judge the RCU boost kthread is starving.

But this will cause error in other scenarios, e.g., tick_irq_exit():
When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
not become 1, which became 0 in tick_nohz_irq_enter().
ts->idle_sleeptime won't update in function update_ts_time_stats(), if
ts->idle_active is 0, which should be 1. And this bug will result that
ts->idle_sleeptime is less than the actual value, and finally will
result that the idle time in /proc/stat is less than the actual value.

To solve this problem, we introduce sched_core_idle_cpu(), which
returns 1 when force idle. We audit all users of idle_cpu(), and
change idle_cpu() into sched_core_idle_cpu() in function
tick_irq_exit().

v2-->v3: Only replace idle_cpu() with sched_core_idle_cpu() in
function tick_irq_exit(). And modify the corresponding commit log.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/1688011324-42406-1-git-send-email-CruzZhao@linux.alibaba.com
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 13 +++++++++++++
 kernel/softirq.c      |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde8..efc9f4b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2433,9 +2433,11 @@ extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
+extern int sched_core_idle_cpu(int cpu);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
+static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2291f9d..83e3654 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7383,6 +7383,19 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_SCHED_CORE
+int sched_core_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (sched_core_enabled(rq) && rq->curr == rq->idle)
+		return 1;
+
+	return idle_cpu(cpu);
+}
+
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * This function computes an effective utilization for the given CPU, to be
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34c..210cf5f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -612,7 +612,7 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
