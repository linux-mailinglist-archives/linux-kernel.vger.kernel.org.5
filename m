Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD678776A7C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjHIUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjHIUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5A100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MG7QpnmCwLygWJ81Mn2iabAPA0zngwNBxpS2UJOPCco=; b=m/MsVKVFJXw+PWSw4nmwYAHQuS
        d8oHFeNWspaqeDl2kVqhAP5j3RrdWYh7jB4RLDDmLUbwdwFRA2W6NVS/dcBqBY3IhBVtUyR6Y/Dr9
        +1MwcXNzG0isfasfU+eF2976h96XZU1fQZumEjg4KpwuFJEB2aJOEx1YVSZuV3j7FpBmTaj4Jgf8p
        N6WrRvsRmZ//sHQEINLmKUQ4EmvryOTNr9W5bTd+0+LedkDbTUb2MT7YozlWUB28cuuUbggpWVBuL
        89+9fQxsShynNBV6JX1ynrucbiVgM1Iqpq09eoaeO3hpR1c2VonRKPd09sVWRg+vuNxU+Kr6392Io
        KANnIeFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTq1m-008LN5-HR; Wed, 09 Aug 2023 20:43:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69EED30014A;
        Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E7ED206E9BA9; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.103286845@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] sched: Simplify set_user_nice()
References: <20230809202440.012625269@infradead.org>
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

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 ++++++-------
 kernel/sched/sched.h |    5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7119,9 +7119,8 @@ static inline int rt_effective_prio(stru
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio;
-	struct rq_flags rf;
 	struct rq *rq;
+	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -7129,7 +7128,9 @@ void set_user_nice(struct task_struct *p
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = task_rq_lock(p, &rf);
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+
 	update_rq_clock(rq);
 
 	/*
@@ -7140,8 +7141,9 @@ void set_user_nice(struct task_struct *p
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
-		goto out_unlock;
+		return;
 	}
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -7164,9 +7166,6 @@ void set_user_nice(struct task_struct *p
 	 * lowered its priority, then reschedule its CPU:
 	 */
 	p->sched_class->prio_changed(rq, p, old_prio);
-
-out_unlock:
-	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1630,6 +1630,11 @@ task_rq_unlock(struct rq *rq, struct tas
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
+		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
+		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)


