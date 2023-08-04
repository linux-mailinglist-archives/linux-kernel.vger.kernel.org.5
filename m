Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB976FF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHDLax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHDLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:30:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA43E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:30:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691148646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T2AeWiya68KJLNtsfeN+eBKy/0/70O9BggovBkInGY=;
        b=TMbtZKjleCooMYS4uB+lFWSsOnrkfX78pGv4mnOlxMBKg3E2ejw5zXx0u3O6gMNvieET3J
        04ATwz6F+0bDOXBWORbVMRd8OJAAccCU4CWW4K6uPliemgFaKdv7BGUUhByp+XLMLA+9ns
        1HsIoYmrY1yzqNWCpYmpA9wWKGZWR4rWpp3QgtIN+6EtfYTUakId2RVn6tGcDRz6SK2jb0
        cWjoXqT9vE0NmHUsdlBLnGltEBavXcuWF8YCgvOPGbA+azZnx2EtSqfweNQjuPMZg14I9E
        fWA0NlOc04Zdqf7F5lTvaAQgq+IS1SqEROuTeer8O5CfIbS8fxi8NHdqDXXiWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691148646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T2AeWiya68KJLNtsfeN+eBKy/0/70O9BggovBkInGY=;
        b=t4Ak2F4YBaw6B5zQGDc8F5Hl/F8C2wCrFjOfUK3CFag/dBDbS/qZKLFT52bbDHmN1EYuQZ
        I/hCb6EvOE6K6LAg==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/3] sched/core: Provide a method to check if a task is PI-boosted.
Date:   Fri,  4 Aug 2023 13:30:37 +0200
Message-Id: <20230804113039.419794-2-bigeasy@linutronix.de>
In-Reply-To: <20230804113039.419794-1-bigeasy@linutronix.de>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a method to check if a task inherited the priority from another
task. This happens if a task owns a lock which is requested by a task
with higher priority. This can be used as a hint to add a preemption
point to the critical section.

Provide a function which reports true if the task is PI-boosted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb06..77fd274133750 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1887,6 +1887,7 @@ static inline int dl_task_check_affinity(struct task_=
struct *p, const struct cpu
 }
 #endif
=20
+extern bool task_is_pi_boosted(const struct task_struct *p);
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c739..132f06522efa0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8886,6 +8886,21 @@ static inline void preempt_dynamic_init(void) { }
=20
 #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
=20
+/*
+ * task_is_pi_boosted - Check if task has been PI boosted.
+ * @p:	Task to check.
+ *
+ * Return true if task is subject to priority inheritance.
+ */
+bool task_is_pi_boosted(const struct task_struct *p)
+{
+	int prio =3D p->prio;
+
+	if (!rt_prio(prio))
+		return false;
+	return prio !=3D p->normal_prio;
+}
+
 /**
  * yield - yield the current processor to other threads.
  *
--=20
2.40.1

