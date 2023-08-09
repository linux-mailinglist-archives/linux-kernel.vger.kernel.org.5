Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C332F776A7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjHIUny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHIUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0E100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8IwM37e642EshGkaM591nsICKeU24b96IU4dYucK72I=; b=kDEI41ex5Qh1PMu+3DWS1pMzNz
        Rv/FhSgsDqJmwVpzh91ZxD+ZHqMLjogyP4nUNOaqVK0JHb7V37r6yi8buTfyryfZXc01wbWpRWjnX
        Fz4qvaigovDAa9B1tInSSU1K9kYgwuYSxDUrDvM+JQ+ERiEM8gzDaUMdRv8lBFbKqxZA+NQRt34di
        7j/S0xrZIaqtb2CVchdhrg+4NPxNVju4LGDdurNwebasCDohKc5rKzaryYfwfzDt5626MefDu/ODo
        8/Z1uUS/a+9EfVCihNOCQoGHw4pGO7vkD6UD95jEM4lw0k7hQjQBbwc5h17fXKGK81IMac2SFSBdY
        YV75oCrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTq1n-008LN8-Cb; Wed, 09 Aug 2023 20:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1411630058D;
        Wed,  9 Aug 2023 22:43:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5E715206EC339; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.378325194@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sched: Simplify sched_rr_get_interval()
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
 kernel/sched/core.c |   40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8941,38 +8941,30 @@ SYSCALL_DEFINE1(sched_get_priority_min,
 
 static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 {
-	struct task_struct *p;
-	unsigned int time_slice;
-	struct rq_flags rf;
-	struct rq *rq;
+	unsigned int time_slice = 0;
 	int retval;
 
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
-
-	rq = task_rq_lock(p, &rf);
-	time_slice = 0;
-	if (p->sched_class->get_rr_interval)
-		time_slice = p->sched_class->get_rr_interval(rq, p);
-	task_rq_unlock(rq, p, &rf);
+	scoped_guard (rcu) {
+		struct task_struct *p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
+
+		scoped_guard (task_rq_lock, p) {
+			struct rq *rq = scope.rq;
+			if (p->sched_class->get_rr_interval)
+				time_slice = p->sched_class->get_rr_interval(rq, p);
+		}
+	}
 
-	rcu_read_unlock();
 	jiffies_to_timespec64(time_slice, t);
 	return 0;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 /**


