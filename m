Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18576BF3C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjHAVZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18F35A5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z/QyOBDSEB+zoR9GPvKsSeTCgad9VvZXAWajjLt+jzo=; b=Al/Ax4if19A7a2TrJQQAx5hfN3
        jqg+ksC+d20UaRIoWyI9FVSvx17aviTARLX3DxpTKJO7DNGF8MSnXB4mXyz7+rlnD8gTBntWtLV/K
        hAE6NSmjeMqZqHkdudwwOa8osYGnJq9Z38p0Bve15z5ihBn6bYNZmexYZS6dvTzC9d9gIk/PzL15F
        Y6VzxwEZXQinghsVeWDd1BAs2xUPy7ET2DfI7GoTkaVtUOdzCeD+ReoItHAbcno31GqJAqBl9WZDo
        4FMje4CiSik7YQwcStueiaJPQ1dRuceH1JtbaVo8peHJv0nfT54H88ZRtJvgVv6ZCW/z+N06y61Mg
        hoCUurHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqm-00EvTp-0A;
        Tue, 01 Aug 2023 21:24:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A81130083E;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4047520292D01; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211811.964370836@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] sched: Simplify: migrate_swap_stop()
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
 kernel/sched/core.c  |   23 +++++++----------------
 kernel/sched/sched.h |   20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3258,7 +3258,6 @@ static int migrate_swap_stop(void *data)
 {
 	struct migration_swap_arg *arg = data;
 	struct rq *src_rq, *dst_rq;
-	int ret = -EAGAIN;
 
 	if (!cpu_active(arg->src_cpu) || !cpu_active(arg->dst_cpu))
 		return -EAGAIN;
@@ -3266,33 +3265,25 @@ static int migrate_swap_stop(void *data)
 	src_rq = cpu_rq(arg->src_cpu);
 	dst_rq = cpu_rq(arg->dst_cpu);
 
-	double_raw_lock(&arg->src_task->pi_lock,
-			&arg->dst_task->pi_lock);
-	double_rq_lock(src_rq, dst_rq);
+	guard(double_raw_spinlock)(&arg->src_task->pi_lock, &arg->dst_task->pi_lock);
+	guard(double_rq_lock)(src_rq, dst_rq);
 
 	if (task_cpu(arg->dst_task) != arg->dst_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (task_cpu(arg->src_task) != arg->src_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	__migrate_swap_task(arg->src_task, arg->dst_cpu);
 	__migrate_swap_task(arg->dst_task, arg->src_cpu);
 
-	ret = 0;
-
-unlock:
-	double_rq_unlock(src_rq, dst_rq);
-	raw_spin_unlock(&arg->dst_task->pi_lock);
-	raw_spin_unlock(&arg->src_task->pi_lock);
-
-	return ret;
+	return 0;
 }
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2572,6 +2572,12 @@ static inline void double_rq_clock_clear
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
 #endif
 
+#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
+static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2) \
+{ class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;	\
+  _lock; return _t; }
+
 #ifdef CONFIG_SMP
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
@@ -2701,6 +2707,16 @@ static inline void double_raw_lock(raw_s
 	raw_spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
 }
 
+static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+{
+	raw_spin_unlock(l1);
+	raw_spin_unlock(l2);
+}
+
+DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
+		    double_raw_lock(_T->lock, _T->lock2),
+		    double_raw_unlock(_T->lock, _T->lock2))
+
 /*
  * double_rq_unlock - safely unlock two runqueues
  *
@@ -2758,6 +2774,10 @@ static inline void double_rq_unlock(stru
 
 #endif
 
+DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
+		    double_rq_lock(_T->lock, _T->lock2),
+		    double_rq_unlock(_T->lock, _T->lock2))
+
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 


