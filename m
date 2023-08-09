Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F21776A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjHIUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjHIUnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3761AA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oJyDWnF7S8lcaog4Xmhyr6vhDojPiq7m8dz3r+ZsZG4=; b=FL+Tnhlx4eoL+EwLOTOjeFbtNJ
        KxhEb2/MbMqyAwLRirLMSF5cUsk6M5QY/Yq1OiVeY87YYssk92XJwFvEzZycmSFGJIV7WCug+R5nZ
        /l3nq69PGGFKGsS3QCJsK4D8aJylYMzd8xOpY51S9bMr3ZsH9tV8mejsAO82lXSm6CKe11EHXyObU
        qaYr4+rfUDT9TlwUaYoTScAU0kBVpPw760+9RNHRKPFvmsDLuCa9Ab9lwaM9fJjV/HAVPon2m6mT1
        rGmNCnIqJNsPMs/gVpkx72d/5eHlXCq98j4bWfgflizkKkEiYCLJK0n40S2GzCqN/r/jumgfxUuoS
        owhaBi5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTq1n-005twO-1C;
        Wed, 09 Aug 2023 20:43:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 141B33006F1;
        Wed,  9 Aug 2023 22:43:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A358206EC337; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.512332208@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] sched: Simplify tg_set_cfs_bandwidth()
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
 include/linux/cpu.h |    2 ++
 kernel/sched/core.c |   42 +++++++++++++++++++++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -148,6 +148,8 @@ static inline int remove_cpu(unsigned in
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
+DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
+
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10726,11 +10726,12 @@ static int tg_set_cfs_bandwidth(struct t
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
-	cpus_read_lock();
-	mutex_lock(&cfs_constraints_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&cfs_constraints_mutex);
+
 	ret = __cfs_schedulable(tg, period, quota);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	runtime_enabled = quota != RUNTIME_INF;
 	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
@@ -10740,39 +10741,38 @@ static int tg_set_cfs_bandwidth(struct t
 	 */
 	if (runtime_enabled && !runtime_was_enabled)
 		cfs_bandwidth_usage_inc();
-	raw_spin_lock_irq(&cfs_b->lock);
-	cfs_b->period = ns_to_ktime(period);
-	cfs_b->quota = quota;
-	cfs_b->burst = burst;
-
-	__refill_cfs_bandwidth_runtime(cfs_b);
-
-	/* Restart the period timer (if active) to handle new period expiry: */
-	if (runtime_enabled)
-		start_cfs_bandwidth(cfs_b);
 
-	raw_spin_unlock_irq(&cfs_b->lock);
+	scoped_guard (raw_spinlock_irq, &cfs_b->lock) {
+		cfs_b->period = ns_to_ktime(period);
+		cfs_b->quota = quota;
+		cfs_b->burst = burst;
+
+		__refill_cfs_bandwidth_runtime(cfs_b);
+
+		/*
+		 * Restart the period timer (if active) to handle new
+		 * period expiry:
+		 */
+		if (runtime_enabled)
+			start_cfs_bandwidth(cfs_b);
+	}
 
 	for_each_online_cpu(i) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[i];
 		struct rq *rq = cfs_rq->rq;
-		struct rq_flags rf;
 
-		rq_lock_irq(rq, &rf);
+		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
-		rq_unlock_irq(rq, &rf);
 	}
+
 	if (runtime_was_enabled && !runtime_enabled)
 		cfs_bandwidth_usage_dec();
-out_unlock:
-	mutex_unlock(&cfs_constraints_mutex);
-	cpus_read_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)


