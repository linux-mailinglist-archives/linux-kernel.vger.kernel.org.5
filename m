Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D977CB92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjHOLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbjHOLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164B1990
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jIATRXokMqv3fKd3yng/qiYyxL1zmrgrCIzNFpO3mYI=; b=TbHzre3Y9shV9EOcIjiw1v5uv+
        74nCkV4RNCD6WqgqiedyMegiZ4bsVpOdWO3yjdEIdp+aTTbfUs2XV6Im5bwkNaGlMzybj5bZef2yb
        6J+MijCndJK6L/hxOCoKhC1czPCeRwnUYCBOQxouPrJSK+vVlClvtEQctd3nzOLyK5+DOA8pNMVc0
        imU5vAdBq3YqPbQrx/onO5qSYuVojVWKQDrjhNd4oHgF86VAJJlU2kNDJ603IVjjGdgqz/dY0fbOs
        niLhEhODfo1dVyflCHtMJCqqrolqvf+zJq2s4/6ltxM9U5W3HgmSLxcQELIQjZs3kc4tDmC4GtBsG
        9b6bvr5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVs2c-007rqW-SQ; Tue, 15 Aug 2023 11:16:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C3163008AC;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EE4C2074B3DF; Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Message-ID: <20230815111430.488430699@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 6/6] locking/rtmutex: Add a lockdep assert to catch potential nested blocking
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

There used to be a BUG_ON(current->pi_blocked_on) in the lock acquisition
functions, but that vanished in one of the rtmutex overhauls.

Bring it back in form of a lockdep assert to catch code paths which take
rtmutex based locks with current::pi_blocked_on != NULL.

Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230427111937.2745231-5-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c     |    2 ++
 kernel/locking/rwbase_rt.c   |    2 ++
 kernel/locking/spinlock_rt.c |    2 ++
 3 files changed, 6 insertions(+)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1774,6 +1774,8 @@ static int __sched rt_mutex_slowlock(str
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (likely(rt_mutex_try_acquire(lock)))
 		return 0;
 
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -131,6 +131,8 @@ static int __sched __rwbase_read_lock(st
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
 
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -37,6 +37,8 @@
 
 static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
 {
+	lockdep_assert(!current->pi_blocked_on);
+
 	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
 		rtlock_slowlock(rtm);
 }


