Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AB77CB94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbjHOLSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjHOLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A0FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/OF/BmdJj0OmjRhPOEFIGjmXpUiq2nX3+Wsu8AwP0Fc=; b=YF0BmO7qGOi9eSckTqSRhR8jsO
        4nbsSR3YfN1TGH1IrxoUEQ/k0AzciiHTMutaiAxbVOgqS+7Lvzn0+1HApUDpgts361vbNOdFahL+9
        z2geFLLgmS/1ADQxzDpeNdgZIniv0svxFPPtxmp9NnqerE53Pj2VWY31ALsoiZrya1qKMvZRe2A/U
        0J4B+NUiK+0hCnMJwLYeaTDEKo6Dba6O27ilESVrH4vwv+n3lBBWjtkhWL1RU1Kh4t7NjMIzZE33Q
        k6Ou8Nbxnz1kxlQhHfQrQII2ctMhyhPt/hN+DWdVY+N/6H58cQC34jV/IxU5oAR/vlivz4TfCH0iE
        vxDXSMqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVs2c-00Bo44-0J;
        Tue, 15 Aug 2023 11:16:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B33730075E;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 030702074B3DB; Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Message-ID: <20230815111430.288063671@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 3/6] sched: Extract __schedule_loop()
References: <20230815110121.117752409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There are currently two implementations of this basic __schedule()
loop, and there is soon to be a third.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-2-bigeasy@linutronix.de
---
 kernel/sched/core.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6787,16 +6787,21 @@ static void sched_update_worker(struct t
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
@@ -6860,11 +6865,7 @@ void __sched schedule_preempt_disabled(v
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


