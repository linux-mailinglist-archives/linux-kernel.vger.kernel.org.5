Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF076B893
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjHAP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjHAP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:26:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618551FEE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:26:54 -0700 (PDT)
Date:   Tue, 1 Aug 2023 17:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690903612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e+Sq00pg9zX9idaJMZOXf7RcOUolfU9E1Ueldsmzb9U=;
        b=m6dH707acHOf42oeSBtli0Utksxr7hRisdSQmwFe+LZXavmDGKVXNgQ7Tt28USHHPTqv5J
        c0FGKtL1YytiJzHi5HrvCDq4Mlypd4B+jkfcASBnfsOkMsdOOLJJvSqcAD6c5P8mu63lD2
        NpusIGZso7La9OyrJQAHZo7C55thdVDVU0qjkQX0gObxPr+YnbKX1sJNpEJurPrwpxAhY5
        n4NyC1g5C6yetQEXav9CqzUWfHOCaBVCeh/JVdRBHk3KdC0Su2JqwZGrZ7NOaqppf+l/6Y
        uScpI44f+ImvcQRegaj6aEIEDUdTCEhiq7BBcALl267aCrwS6Cm+kuxyPWhWdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690903612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e+Sq00pg9zX9idaJMZOXf7RcOUolfU9E1Ueldsmzb9U=;
        b=QUXYg22OzS/BcPddjpaHBk91+eddU+p16HvAsQwa7jCVN+oyWZJXsJWc1dolmhnvSyKdXd
        78s4JulygIRG2qDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/rt: Don't try push tasks if there are none.
Message-ID: <20230801152648._y603AS_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a RT task X at a high priority and cyclictest on each CPU with
lower priority than X's. If X is active and each CPU wakes their own
cylictest thread then it ends in a longer rto_push storm.
A random CPU determines via balance_rt() that the CPU on which X is
running needs to push tasks. X has the highest priority, cyclictest is
next in line so there is nothing that can be done since the task with
the higher priority is not touched.

tell_cpu_to_push() increments rto_loop_next and schedules
rto_push_irq_work_func() on X's CPU. The other CPUs also increment the
loop counter and do the same. Once rto_push_irq_work_func() is active it
does nothing because it has _no_ pushable tasks on its runqueue. Then
checks rto_next_cpu() and decides to queue irq_work on the local CPU
because another CPU requested a push by incrementing the counter.

I have traces where ~30 CPUs request this ~3 times each before it
finally ends. This greatly increases X's runtime while X isn't making
much progress.

Teach rto_next_cpu() to only return CPUs which also have tasks on their
runqueue which can be pushed away. This does not reduce the
tell_cpu_to_push() invocations (rto_loop_next counter increments) but
reduces the amount of issued rto_push_irq_work_func() if nothing can be
done. As the result the overloaded CPU is blocked less often.

There are still cases where the "same job" is repeated several times
(for instance the current CPU needs to resched but didn't yet because
the irq-work is repeated a few times and so the old task remains on the
CPU) but the majority of request end in tell_cpu_to_push() before an IPI
is issued.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/rt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e50741153..338cd150973ff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2247,8 +2247,11 @@ static int rto_next_cpu(struct root_domain *rd)
 
 		rd->rto_cpu = cpu;
 
-		if (cpu < nr_cpu_ids)
+		if (cpu < nr_cpu_ids) {
+			if (!has_pushable_tasks(cpu_rq(cpu)))
+				continue;
 			return cpu;
+		}
 
 		rd->rto_cpu = -1;
 
-- 
2.40.1
