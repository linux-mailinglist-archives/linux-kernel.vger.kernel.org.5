Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802B77CB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbjHOLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjHOLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850DEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1lUumChi5BZurWbM1ZwmbgCultJMd6yfxKko3hnfLig=; b=lG9KBIs7JXgnU+RLGph9vLo6MS
        aWQkzsSoV+5f8ts049ALYR8an3BvIYAm1MgSvq9gNvt+HnRQP+wYcSDcYBLVAfwBuAEDLeuozqZwc
        JcAi5z8jq7xj0ddWyIyxXk2NefVVizliGBuyafx+40X1iS4ayDijsisXR5W4m0crxpcxaSYtlfN8G
        HlCYBvJaP0wwyNcqAoOHmRIPB05k++ICkLY0HCep/aZ/hkNN8GT/A+g7wX+3qLkgZhJafpC9zmRfw
        kqO9BV4+t/MMzBenl5ep2HWLxzzY8WbooIg8VpWBidn70UrbmTnJN3YaIjBL8WY3gUoGPWHSJlLN6
        rqHxWYkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVs2c-007rqP-90; Tue, 15 Aug 2023 11:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 220753007AF;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 082222074B3D6; Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Message-ID: <20230815111430.355375399@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 4/6] sched: Provide rt_mutex specific scheduler helpers
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

With PREEMPT_RT there is a rt_mutex recursion problem where
sched_submit_work() can use an rtlock (aka spinlock_t). More
specifically what happens is:

  mutex_lock() /* really rt_mutex */
    ...
      __rt_mutex_slowlock_locked()
	task_blocks_on_rt_mutex()
          // enqueue current task as waiter
          // do PI chain walk
        rt_mutex_slowlock_block()
          schedule()
            sched_submit_work()
              ...
              spin_lock() /* really rtlock */
                ...
                  __rt_mutex_slowlock_locked()
                    task_blocks_on_rt_mutex()
                      // enqueue current task as waiter *AGAIN*
                      // *CONFUSION*

Fix this by making rt_mutex do the sched_submit_work() early, before
it enqueues itself as a waiter -- before it even knows *if* it will
wait.

[[ basically Thomas' patch but with different naming and a few asserts
   added ]]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h    |    3 +++
 include/linux/sched/rt.h |    4 ++++
 kernel/sched/core.c      |   36 ++++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -906,6 +906,9 @@ struct task_struct {
 	 * ->sched_remote_wakeup gets used, so it can be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+#ifdef CONFIG_RT_MUTEXES
+	unsigned			sched_rt_mutex:1;
+#endif
 
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -30,6 +30,10 @@ static inline bool task_is_realtime(stru
 }
 
 #ifdef CONFIG_RT_MUTEXES
+extern void rt_mutex_pre_schedule(void);
+extern void rt_mutex_schedule(void);
+extern void rt_mutex_post_schedule(void);
+
 /*
  * Must hold either p->pi_lock or task_rq(p)->lock.
  */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6738,9 +6738,6 @@ static inline void sched_submit_work(str
 	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
 
-	if (task_is_running(tsk))
-		return;
-
 	/*
 	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
 	 * will use a blocking primitive -- which would lead to recursion.
@@ -6798,7 +6795,12 @@ asmlinkage __visible void __sched schedu
 {
 	struct task_struct *tsk = current;
 
-	sched_submit_work(tsk);
+#ifdef CONFIG_RT_MUTEXES
+	lockdep_assert(!tsk->sched_rt_mutex);
+#endif
+
+	if (!task_is_running(tsk))
+		sched_submit_work(tsk);
 	__schedule_loop(SM_NONE);
 	sched_update_worker(tsk);
 }
@@ -7059,6 +7061,32 @@ static void __setscheduler_prio(struct t
 
 #ifdef CONFIG_RT_MUTEXES
 
+/*
+ * Would be more useful with typeof()/auto_type but they don't mix with
+ * bit-fields. Since it's a local thing, use int. Keep the generic sounding
+ * name such that if someone were to implement this function we get to compare
+ * notes.
+ */
+#define fetch_and_set(x, v) ({ int _x = (x); (x) = (v); _x; })
+
+void rt_mutex_pre_schedule(void)
+{
+	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
+	sched_submit_work(current);
+}
+
+void rt_mutex_schedule(void)
+{
+	lockdep_assert(current->sched_rt_mutex);
+	__schedule_loop(SM_NONE);
+}
+
+void rt_mutex_post_schedule(void)
+{
+	sched_update_worker(current);
+	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
+}
+
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
 {
 	if (pi_task)


