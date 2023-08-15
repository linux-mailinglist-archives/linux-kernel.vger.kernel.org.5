Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157C77CB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjHOLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjHOLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54630107
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Cuoqo+L2mdz7teHEcB9Kr2BTzQAt+EJM1BOiUmzm59k=; b=JqDCIbiuGn170E9HOU0//FELEk
        tSr4SQtmr/LD7gx6B3zuXDWJzBiypuS2i4DQYhGeYJyE0U80uxZwx2Qg6yy72HiaaYP0cOvlyArCL
        txFJUiK7ZUJqg6sz0FNhE4p6qbhIH6fx6jf3LkV1BRts4mPW2JVpIvvx6OrNlWDw5rzRxP/O2N3ct
        I3yTRs+kBO8nL2O+soRjTUbyPOuWPZePp2DGvluj6NAYN+sX2ayeRCeExWPds5Ma4hjgMQWJWWHRV
        4HlqlWX6q+LifTgbCv7ZGrMBIs3f97i58Hhn98HvrNkgZeQet1YHbDcWnCHqypNZtpMKYkA1dmSLK
        vYeV6wBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVs2c-007rqR-3R; Tue, 15 Aug 2023 11:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 173893005A2;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F15802074B3D9; Tue, 15 Aug 2023 13:16:48 +0200 (CEST)
Message-ID: <20230815111430.220899937@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 2/6] locking/rtmutex: Avoid unconditional slowpath for DEBUG_RT_MUTEXES
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With DEBUG_RT_MUTEXES enabled the fast-path rt_mutex_cmpxchg_acquire()
always fails and all lock operations take the slow path.

Provide a new helper inline rt_mutex_try_acquire() which maps to
rt_mutex_cmpxchg_acquire() in the non-debug case. For the debug case
it invokes rt_mutex_slowtrylock() which can acquire a non-contended
rtmutex under full debug coverage.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-4-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c     |   21 ++++++++++++++++++++-
 kernel/locking/ww_rt_mutex.c |    2 +-
 2 files changed, 21 insertions(+), 2 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -218,6 +218,11 @@ static __always_inline bool rt_mutex_cmp
 	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	return rt_mutex_cmpxchg_acquire(lock, NULL, current);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -297,6 +302,20 @@ static __always_inline bool rt_mutex_cmp
 
 }
 
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock);
+
+static __always_inline bool rt_mutex_try_acquire(struct rt_mutex_base *lock)
+{
+	/*
+	 * With debug enabled rt_mutex_cmpxchg trylock() will always fail.
+	 *
+	 * Avoid unconditionally taking the slow path by using
+	 * rt_mutex_slow_trylock() which is covered by the debug code and can
+	 * acquire a non-contended rtmutex.
+	 */
+	return rt_mutex_slowtrylock(lock);
+}
+
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
@@ -1755,7 +1774,7 @@ static int __sched rt_mutex_slowlock(str
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
 
 	return rt_mutex_slowlock(lock, NULL, state);
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -62,7 +62,7 @@ __ww_rt_mutex_lock(struct ww_mutex *lock
 	}
 	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
 
-	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+	if (likely(rt_mutex_try_acquire(&rtm->rtmutex))) {
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(lock, ww_ctx);
 		return 0;


