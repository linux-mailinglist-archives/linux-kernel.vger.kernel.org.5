Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E577A7447
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjITHg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjITHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767D4C9;
        Wed, 20 Sep 2023 00:36:13 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695195372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkErl+ldBpVOFQLYfLc4+s4u3o3sDTlBynk6F5XnIVI=;
        b=HkzMRkQSyu1diMapdr8DdhMVRj/xoen19An/M+ulL9V5LBukkwEsOjCScfw1V2bBzeSAFy
        /5fARBSnaznDK1OLsb40dI27c0TSUuGG+MJd7M2vVBwuq9Ayry6YhGbgG1Jbg2P7kVhbx1
        +Fc3NWe7HFKv30sO6EASKmMzZKT6XKoNLwyjovIN3PHKhLk96H7cL+7TemPJAeHK9O4G6X
        36dvCAG1PnhoVNd8h1X9fml3z21jy7TKg/Fdn2zdFICH8+7VH6OR/LSvhCJvdixdFhnhgf
        rHYYZAmngjrwPozRpw23A82v1e/KkWhQvt401cbT2Jq0Wu+RzV2ltVYNtdI5DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695195372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkErl+ldBpVOFQLYfLc4+s4u3o3sDTlBynk6F5XnIVI=;
        b=e700XXZ40ze5dCUWGbIhuB/MSvQBeQ8jmQ6OzNwby3kDYHqGZmqVgPIM7Tz8kHKbpq5YSC
        rkQmMD0ZCmcldzAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Extract __schedule_loop()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230908162254.999499-4-bigeasy@linutronix.de>
References: <20230908162254.999499-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169519537134.27769.9940843211389031126.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     de1474b46d889ee0367f6e71d9adfeb0711e4a8d
Gitweb:        https://git.kernel.org/tip/de1474b46d889ee0367f6e71d9adfeb0711e4a8d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 08 Sep 2023 18:22:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Sep 2023 09:31:12 +02:00

sched: Extract __schedule_loop()

There are currently two implementations of this basic __schedule()
loop, and there is soon to be a third.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230908162254.999499-4-bigeasy@linutronix.de
---
 kernel/sched/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d555640..1ea7ba5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6770,16 +6770,21 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-asmlinkage __visible void __sched schedule(void)
+static __always_inline void __schedule_loop(unsigned int sched_mode)
 {
-	struct task_struct *tsk = current;
-
-	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(SM_NONE);
+		__schedule(sched_mode);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
+}
+
+asmlinkage __visible void __sched schedule(void)
+{
+	struct task_struct *tsk = current;
+
+	sched_submit_work(tsk);
+	__schedule_loop(SM_NONE);
 	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
@@ -6843,11 +6848,7 @@ void __sched schedule_preempt_disabled(void)
 #ifdef CONFIG_PREEMPT_RT
 void __sched notrace schedule_rtlock(void)
 {
-	do {
-		preempt_disable();
-		__schedule(SM_RTLOCK_WAIT);
-		sched_preempt_enable_no_resched();
-	} while (need_resched());
+	__schedule_loop(SM_RTLOCK_WAIT);
 }
 NOKPROBE_SYMBOL(schedule_rtlock);
 #endif
