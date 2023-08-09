Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979B776A77
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjHIUnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjHIUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C918E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vDHS8Plr2cencdpiH/auo6E776oNoOhgYdcpKlgKc4Q=; b=QbqGE4Lx8gdWzy6RliqUTtWhkm
        s5M9NXwGATxbMdMuUP26qF0Hre/8SjU0ApGKf15r8v2VPjRWFdlw3k4eUd7Q4llx6G4EJq09SkqRk
        IfPXSYlNwRlIy1VCgvqSfJyIMczXqiB2kBcbYVKnplsexPUxCiOLFqka9jzJ80yUbZLjYroxuflHZ
        IdJfF5EgkR6g7jKCrjPUAGJXEVlXEg4WLBI/C3zIQSRls6SLM51rFiRJot/r8Z+vIbV3utpSEh2+G
        uhjN1idj5CU02HX+ZZKWY6/zUNOKDPAG2VLf2rUV4ogEp+lfG6zH5DaflXK8+3tb0f1g9By5HnZeI
        Z5i/pLLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTq1m-005twJ-1n;
        Wed, 09 Aug 2023 20:43:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F02B300487;
        Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 567BA2023CC01; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.241599953@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] sched: Simplify sched_{set,get}affinity()
References: <20230809202440.012625269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   53 +++++++++++++---------------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8258,39 +8258,24 @@ long sched_setaffinity(pid_t pid, const
 {
 	struct affinity_context ac;
 	struct cpumask *user_mask;
-	struct task_struct *p;
 	int retval;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
+	CLASS(find_get_task, p)(pid);
+	if (!p)
 		return -ESRCH;
-	}
 
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
-
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			retval = -EPERM;
-			goto out_put_task;
-		}
-		rcu_read_unlock();
+		guard(rcu)();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-		goto out_put_task;
+		return retval;
 
 	/*
 	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
@@ -8300,8 +8285,7 @@ long sched_setaffinity(pid_t pid, const
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
 	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+		return -ENOMEM;
 	}
 
 	ac = (struct affinity_context){
@@ -8313,8 +8297,6 @@ long sched_setaffinity(pid_t pid, const
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
-out_put_task:
-	put_task_struct(p);
 	return retval;
 }
 
@@ -8356,28 +8338,21 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
-	unsigned long flags;
 	int retval;
 
-	rcu_read_lock();
-
-	retval = -ESRCH;
+	guard(rcu)();
 	p = find_process_by_pid(pid);
 	if (!p)
-		goto out_unlock;
+		return -ESRCH;
 
 	retval = security_task_getscheduler(p);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	guard(raw_spinlock_irqsave)(&p->pi_lock);
 	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-out_unlock:
-	rcu_read_unlock();
-
-	return retval;
+	return 0;
 }
 
 /**


