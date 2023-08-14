Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0777BC82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjHNPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjHNPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F810C1;
        Mon, 14 Aug 2023 08:08:07 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDBBLrQiUI949l0/QFU5QO+sFl+OnZWaMOm9rfnBDlc=;
        b=EioAf7K9NRdIg3o5RHW+Q9YUjr4GhLLnKTOiTV+GUIahs8zoax5QwlY5r9V4RnD/rNS5Wy
        5HzYdUO72dUvgqhp9Om9ns9HX71DRkz8cQhY3ZwV4NJvNNYQffiVzcfR9WWM2HNtpseQUO
        IcIi4QQe8IWXLleefPiQwnOdbKhe1N6zRa4Ff/aigh2SuHFyROV01S3U6k+HxSC0PvBQJj
        9X0XF2qGwMEOMsmwcYB63uOzgq4pIct1v5y3HjvBV3GkDRgwOIp3nRP40I2uPbyKK7HT4M
        xwLCS0WmoiyCSMKfG9NewmCOYfPEFMM0yq5aTp2GVkDhE8PHcXTpfYT0/N39Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDBBLrQiUI949l0/QFU5QO+sFl+OnZWaMOm9rfnBDlc=;
        b=mDzlwZiM4X/73Pq3RNBt4CWOPnIoZrG5PqrOticMBIZieuQTo/mzRPjIKsn8+2Rwkf/7Fa
        r0mnB+8CUwNt4rDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify wake_up_if_idle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.032678917@infradead.org>
References: <20230801211812.032678917@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568576.27769.17983708536271256088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4eb054f92b066ec0a0cba6896ee8eff4c91dfc9e
Gitweb:        https://git.kernel.org/tip/4eb054f92b066ec0a0cba6896ee8eff4c91dfc9e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:25 +02:00

sched: Simplify wake_up_if_idle()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.032678917@infradead.org
---
 kernel/sched/core.c  | 20 ++++++--------------
 kernel/sched/sched.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 66478a6..65ebf43 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3939,21 +3939,13 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 void wake_up_if_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
-
-	rcu_read_lock();
 
-	if (!is_idle_task(rcu_dereference(rq->curr)))
-		goto out;
-
-	rq_lock_irqsave(rq, &rf);
-	if (is_idle_task(rq->curr))
-		resched_curr(rq);
-	/* Else CPU is not idle, do nothing here: */
-	rq_unlock_irqrestore(rq, &rf);
-
-out:
-	rcu_read_unlock();
+	guard(rcu)();
+	if (is_idle_task(rcu_dereference(rq->curr))) {
+		guard(rq_lock_irqsave)(rq);
+		if (is_idle_task(rq->curr))
+			resched_curr(rq);
+	}
 }
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c299a58..3a01b7a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1705,6 +1705,21 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	raw_spin_rq_unlock(rq);
 }
 
+DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
+		    rq_lock(_T->lock, &_T->rf),
+		    rq_unlock(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
+		    rq_lock_irq(_T->lock, &_T->rf),
+		    rq_unlock_irq(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
+		    rq_lock_irqsave(_T->lock, &_T->rf),
+		    rq_unlock_irqrestore(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
 static inline struct rq *
 this_rq_lock_irq(struct rq_flags *rf)
 	__acquires(rq->lock)
