Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67E76BF41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHAVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjHAVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4C35A8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=XnCmIaNvJgB5bekhtHHcxeVW5sv9v7ogZHNowp3XnxU=; b=grhO7SXHynJfVX9hhJuZZMTp7F
        2h7GK1gVLNebfvh7OneKfz6GSmm7RHut5djU0eFNRKHMe2FRvhg+FzBwaJ78Uo0sHHH6LkF8AT80w
        g8y0RsK9+1Iu6n7w3Vh6NUEZFwqA63p3VTG0yK8h+GjE9tvSqg4mpVxmiGV6jeSfsUWArAdJhsqOk
        3O+CLGk4lfoghVPNgVudI1bsdSVYBKmW/6tUF3Mh0mn3bMfl3PRjv16/jTB5L479Ad3d+Z9bAFUUh
        EpRpYKlW9aKWPGtO5oraXAa0wyinNXesFXZ3SFNSHMg/77OLUg0ZKcEVgKqNGl0dzBvsJ58Z5jKYf
        KEGfVo+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqm-00EvTo-06;
        Tue, 01 Aug 2023 21:24:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C3463008C6;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4473A2029F9EC; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.032678917@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] sched: Simplify wake_up_if_idle()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   20 ++++++--------------
 kernel/sched/sched.h |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 14 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3872,21 +3872,13 @@ static void __ttwu_queue_wakelist(struct
 void wake_up_if_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
-	rcu_read_lock();
-
-	if (!is_idle_task(rcu_dereference(rq->curr)))
-		goto out;
-
-	rq_lock_irqsave(rq, &rf);
-	if (is_idle_task(rq->curr))
-		resched_curr(rq);
-	/* Else CPU is not idle, do nothing here: */
-	rq_unlock_irqrestore(rq, &rf);
-
-out:
-	rcu_read_unlock();
+	guard(rcu)();
+	if (is_idle_task(rcu_dereference(rq->curr))) {
+		guard(rq_lock_irqsave)(rq);
+		if (is_idle_task(rq->curr))
+			resched_curr(rq);
+	}
 }
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1678,6 +1678,21 @@ rq_unlock(struct rq *rq, struct rq_flags
 	raw_spin_rq_unlock(rq);
 }
 
+DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
+		    rq_lock(_T->lock, &_T->rf),
+		    rq_unlock(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
+		    rq_lock_irq(_T->lock, &_T->rf),
+		    rq_unlock_irq(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
+DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
+		    rq_lock_irqsave(_T->lock, &_T->rf),
+		    rq_unlock_irqrestore(_T->lock, &_T->rf),
+		    struct rq_flags rf)
+
 static inline struct rq *
 this_rq_lock_irq(struct rq_flags *rf)
 	__acquires(rq->lock)


