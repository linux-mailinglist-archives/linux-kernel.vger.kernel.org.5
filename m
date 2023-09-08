Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E928A798AA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbjIHQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245034AbjIHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C03D1FDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:04 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwUwmUlH3g9zQEW7d2rAilsnYPzclWIyRWrBB3Q075A=;
        b=cEGa+x70PHbU5kxzK0/7lDCu23itAk3KvdE5jtcMhvj5FEYwHXlvFlba0rfAEmroV++28X
        4y9xdTayo0KaMjsc00nGNeuZaLVm7QH1xK4r/36wU920RRksHKZheeNABv68MYii0XRu1d
        j7ozsqsSkDz7Gq9WqYBlm4hs3kFycgTgjRGnZ28hLCO8HkanDvHXfjd1uYr/Qr+J0vAkya
        FG5trYXv8aTKsITiMQPXTNEDFDpHPcSZzO+7nc+F/3KGr7FTCLvTAOQUZcy7t0m0vRtUu0
        fC8L5dhrdpTaFHgpbkLyvPE3t1ZmLdiLNYcYW8MkZM+YB8li8c1jsKxCJlPx0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwUwmUlH3g9zQEW7d2rAilsnYPzclWIyRWrBB3Q075A=;
        b=YtWjObXrviPmAWxd0YiKCkf5WxNrMYJhCwU9jOKr8R1ozaEZtjXffAOeV4Y5E1KV0/AAM6
        BbkD+XBM2EjgE+Cw==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 3/7] sched: Extract __schedule_loop()
Date:   Fri,  8 Sep 2023 18:22:50 +0200
Message-Id: <20230908162254.999499-4-bigeasy@linutronix.de>
In-Reply-To: <20230908162254.999499-1-bigeasy@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lore.kernel.org/r/20230825181033.504534-4-bigeasy@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d55564097bd86..1ea7ba53aad24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6770,16 +6770,21 @@ static void sched_update_worker(struct task_struct =
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
--=20
2.40.1

