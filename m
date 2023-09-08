Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2098798AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbjIHQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbjIHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108A1FCF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:03 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBSf3JAvBodQOJU5koQ6BIwri4EQhJKJSEVrlYiAIjM=;
        b=XjToC34+GvOXbPPH0Apm/0m14hSDHiRnyWj/QiLAnPENq8Zd4px+YNUHuMz1+nK0eTr1hk
        THh82Wo5Q458TlvIrnjGwUwvL4eeZ+ZyvmuYJ6E0MBeVWFHhiSEF7oUuoQtkHpSn+CwZg1
        3pkCL2/H8en+Ns3Vrkl24WAtBCRLpu1LHepLnHFaxHuJHgTH0ICW/E/iJFWprY5N/frshh
        //PCi9iYTMdqnRbhLVSWjeLuacd9f0dhLiADmHNDBeDX5bscWGQPdXtygkMgPtwD3pzEfw
        xL7iuGtn2VofkFkKAd75bhzvTTBlh6+N2mHbo1ZJOaNtCii6sIksL7G9NV0xqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBSf3JAvBodQOJU5koQ6BIwri4EQhJKJSEVrlYiAIjM=;
        b=NpuGVYhPfHxu2rVtpLLVPCs/91pOsXeVOSCpc9X8y90QgnJl8XldQoKe0Dy/fF0b3wVcKq
        RYY9+Lw4Wm3kDbAA==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 1/7] sched: Constrain locks in sched_submit_work()
Date:   Fri,  8 Sep 2023 18:22:48 +0200
Message-Id: <20230908162254.999499-2-bigeasy@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

Even though sched_submit_work() is ran from preemptible context,
it is discouraged to have it use blocking locks due to the recursion
potential.

Enforce this.

Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230815111430.154558666@infradead.org
Link: https://lore.kernel.org/r/20230825181033.504534-2-bigeasy@linutronix.=
de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9e..d55564097bd86 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6720,11 +6720,18 @@ void __noreturn do_task_dead(void)
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
@@ -6749,6 +6756,8 @@ static inline void sched_submit_work(struct task_stru=
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

