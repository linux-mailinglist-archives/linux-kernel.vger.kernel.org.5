Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647B07EBF16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjKOJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjKOJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA0114;
        Wed, 15 Nov 2023 01:04:53 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDYsmJeTGcPNQRpxou+VlALaTQpSQyDGIv5As9gc9js=;
        b=ZHxLno14T3avnGOVyQTCdzFl0NZd4WrHfom2xm6W+LRn6s44QG/fR2s15IQTZyL/R4LVqO
        A43uskeZlox9JOhSmeGmtPVoGd7AQWXpSbQjnQA+MfIs76pM1vX8R5W6xARsqMbNHBmMSN
        5ApBswkP53wLdPp/ccM1FufZxBCnEyo/g+LtBiaoIlIx5pKgopv9JFA3tWH131lLqcX0yk
        U6OAHb8uiX73W+mK011TxKW/lP3b4b6bF4UkAas8Bu6dW9yGq84+WldxvvrG6vgvt88VyF
        XBE2cxa6kmEIntK/FjB5PCxHolb06fbot1+tL8zeiF8yY94c0sa9RZNrkZa9kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDYsmJeTGcPNQRpxou+VlALaTQpSQyDGIv5As9gc9js=;
        b=JABlld+YPwGieHBg10FDZpvApvNp0M2m+ruOMUGncTgXZa0gPB79foxhYO1IF6UDRMirN5
        4l0kO/86gAGIvPBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Collect sched_dl_entity initialization
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <51acc695eecf0a1a2f78f9a044e11ffd9b316bcf.1699095159.git.bristot@kernel.org>
References: <51acc695eecf0a1a2f78f9a044e11ffd9b316bcf.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Message-ID: <170003909113.391.17311843360585530525.tip-bot2@tip-bot2>
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

Commit-ID:     9e07d45c5210f5dd6701c00d55791983db7320fa
Gitweb:        https://git.kernel.org/tip/9e07d45c5210f5dd6701c00d55791983db7320fa
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 04 Nov 2023 11:59:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:50 +01:00

sched/deadline: Collect sched_dl_entity initialization

Create a single function that initializes a sched_dl_entity.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/51acc695eecf0a1a2f78f9a044e11ffd9b316bcf.1699095159.git.bristot@kernel.org
---
 kernel/sched/core.c     |  5 +----
 kernel/sched/deadline.c | 22 +++++++++++++++-------
 kernel/sched/sched.h    |  5 +----
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9d5099d..966631f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4511,10 +4511,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
-	RB_CLEAR_NODE(&p->dl.rb_node);
-	init_dl_task_timer(&p->dl);
-	init_dl_inactive_task_timer(&p->dl);
-	__dl_clear_params(p);
+	init_dl_entity(&p->dl);
 
 	INIT_LIST_HEAD(&p->rt.run_list);
 	p->rt.timeout		= 0;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de79719..e80bb88 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -335,6 +335,8 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void __dl_clear_params(struct sched_dl_entity *dl_se);
+
 /*
  * The utilization of a task cannot be immediately removed from
  * the rq active utilization (running_bw) when the task blocks.
@@ -434,7 +436,7 @@ static void task_non_contending(struct task_struct *p)
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 			raw_spin_unlock(&dl_b->lock);
-			__dl_clear_params(p);
+			__dl_clear_params(dl_se);
 		}
 
 		return;
@@ -1183,7 +1185,7 @@ unlock:
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
@@ -1389,7 +1391,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		raw_spin_lock(&dl_b->lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 		raw_spin_unlock(&dl_b->lock);
-		__dl_clear_params(p);
+		__dl_clear_params(dl_se);
 
 		goto unlock;
 	}
@@ -1405,7 +1407,7 @@ unlock:
 	return HRTIMER_NORESTART;
 }
 
-void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
+static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
@@ -2957,10 +2959,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
 /*
  * This function clears the sched_dl_entity static params.
  */
-void __dl_clear_params(struct task_struct *p)
+static void __dl_clear_params(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	dl_se->dl_runtime		= 0;
 	dl_se->dl_deadline		= 0;
 	dl_se->dl_period		= 0;
@@ -2978,6 +2978,14 @@ void __dl_clear_params(struct task_struct *p)
 #endif
 }
 
+void init_dl_entity(struct sched_dl_entity *dl_se)
+{
+	RB_CLEAR_NODE(&dl_se->rb_node);
+	init_dl_task_timer(dl_se);
+	init_dl_inactive_task_timer(dl_se);
+	__dl_clear_params(dl_se);
+}
+
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6703e9e..3c62df1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -273,8 +273,6 @@ struct rt_bandwidth {
 	unsigned int		rt_period_active;
 };
 
-void __dl_clear_params(struct task_struct *p);
-
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -2427,8 +2425,7 @@ extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
-extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
+extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
