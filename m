Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E0788E42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjHYSKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjHYSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:10:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F81BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:10:37 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692987036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEoQnpkaIgYq157v25Ctv6kJ87J+vk1fYfyBSQDYO/0=;
        b=uo8JcZipsORIpF8dlE7y/7vDxbAwmSYLmLKQP5lMdqNCKP6/V1fYaDk6Zy/cZpB5blI4Gy
        PROBGvIGEd35oqm8iDATPP1shknrb/fEdaOA9u62jEj7x2r+vLGxDnqbLs3gvgKQAJ6f74
        M/HZBD/YNT9GQlFvYPAFmSu1tDaI28JCJpqw9Adr66uobfi7uDdU/VfJObid/Hjv92hKQ9
        Oaks7xWLR3vzrvB7tqItFS3SWb0W6Rb5FYnUjIVEKSn/mLxH+ocH3bl50GXclpkIL3o8Q5
        yKna1Vdm92bvRryDLLiWDGf1oRyrLg2Hmqlxd88Recbg5S0q0l3y5XQwL6R2Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692987036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEoQnpkaIgYq157v25Ctv6kJ87J+vk1fYfyBSQDYO/0=;
        b=TLjhCS5WG1HXzi4nFO57WHjXmdGMu2EjVPARJ+MG1nuItGhykC50pvUlqsKpHZjWCkC8XV
        a5eelGXVUT2e2NAA==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v2 1/6] sched: Constrain locks in sched_submit_work()
Date:   Fri, 25 Aug 2023 20:10:28 +0200
Message-Id: <20230825181033.504534-2-bigeasy@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

Even though sched_submit_work() is ran from preemptible context,
it is discouraged to have it use blocking locks due to the recursion
potential.

Enforce this.

Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230815111430.154558666@infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c739..bca53ff9d8182 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6735,11 +6735,18 @@ void __noreturn do_task_dead(void)
=20
 static inline void sched_submit_work(struct task_struct *tsk)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
=20
 	if (task_is_running(tsk))
 		return;
=20
+	/*
+	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
+	 * will use a blocking primitive -- which would lead to recursion.
+	 */
+	lock_map_acquire_try(&sched_map);
+
 	task_flags =3D tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
@@ -6764,6 +6771,8 @@ static inline void sched_submit_work(struct task_stru=
ct *tsk)
 	 * make sure to submit it to avoid deadlocks.
 	 */
 	blk_flush_plug(tsk->plug, true);
+
+	lock_map_release(&sched_map);
 }
=20
 static void sched_update_worker(struct task_struct *tsk)
--=20
2.40.1

