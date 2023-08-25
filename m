Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCB788E43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHYSKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjHYSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808151BF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692987037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrBWE7gLV3gdYOwuqDxnLxb8n9IPkKOACA7XtApmVIA=;
        b=pvAhKb4POo0xn/2YS95w0YMRCWBZqOhIwM3VPMlABD3kmOxrw/LRd9aXZCQK6o2vwguMNt
        0X7XMIPVYQIpuyb+GqfZDy3Q150/lcdDieLsAsQ0nbli7CNTJOo1YHgD4k8Bg6cuIXVjnd
        9iWtrdGLqam1SjvgwLTGSTpunoRixT/ieO4kEIPEZqdpwX8e+CHhQkXjh/ueZm/l2+Nr8C
        Qpez1ffJFzLpbgU9nX/Qa8V7QdzWYh7VSUQsZDbco53FmGt4TimPg59c6r0vm/Zg8tuo5F
        a+qMuX3g9LNOKtclrAfihTOfO6Q5QI3MOMYy0+tGmOtrLmb+iQHYmtHp7pmGpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692987037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrBWE7gLV3gdYOwuqDxnLxb8n9IPkKOACA7XtApmVIA=;
        b=JwznRK/95g0m1Q6vQMQ22/b41a58RR8j1o4hyuZ9CtNSIZKQN2HtS/CuPwPvbH8IG8Z82z
        jzFEB0z2+aAF26AQ==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v2 3/6] sched: Extract __schedule_loop()
Date:   Fri, 25 Aug 2023 20:10:30 +0200
Message-Id: <20230825181033.504534-4-bigeasy@linutronix.de>
In-Reply-To: <20230825181033.504534-1-bigeasy@linutronix.de>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There are currently two implementations of this basic __schedule()
loop, and there is soon to be a third.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-2-bigeasy@linutronix=
.de
Link: https://lore.kernel.org/r/20230815111430.288063671@infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bca53ff9d8182..901766a88afc3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6785,16 +6785,21 @@ static void sched_update_worker(struct task_struct =
*tsk)
 	}
 }
=20
+static __always_inline void __schedule_loop(unsigned int sched_mode)
+{
+	do {
+		preempt_disable();
+		__schedule(sched_mode);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+
 asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk =3D current;
=20
 	sched_submit_work(tsk);
-	do {
-		preempt_disable();
-		__schedule(SM_NONE);
-		sched_preempt_enable_no_resched();
-	} while (need_resched());
+	__schedule_loop(SM_NONE);
 	sched_update_worker(tsk);
 }
 EXPORT_SYMBOL(schedule);
@@ -6858,11 +6863,7 @@ void __sched schedule_preempt_disabled(void)
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
--=20
2.40.1

