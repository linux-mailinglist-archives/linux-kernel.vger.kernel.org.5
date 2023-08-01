Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6376B5BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHANZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjHANZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036A2683
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F61961594
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4767C433C9;
        Tue,  1 Aug 2023 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896299;
        bh=rdh2v8ubgWirANjBqQeINfRDtrMu7AmbvfgkqLxk0ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eg8Wsrw5hhHyNuQV0Y6edeuyltWCE4/vwspiKaXOia1pjtO644tTGTaOJ4UmbAXoH
         rhQfXc0vC+L0z6dqLCXrZKJb5TyV0VDLXhQCSqPKPNBhlYp8od3LSXJ7ct6zYYTS+1
         bMqrSBbA2Reu++Eulkkw+tVEmB0Xqdhw34BP4GGdfuO5vCW7lmb+XPjShz1/sva7Q6
         ESsceLV2WEluWAt56iBfc68isurryOxCW1erhZ+g9K9C9aRh5cSAOTNBRhpKbhrH81
         Na3OoRxbeq2wS9Fi3g8nX2KGaI0N8gZuSPBnVkrfDcQjgOaVrOsTq2CvukqOMM1BZh
         E8dBg1bEfGepQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 5/6] timers: Introduce soft-interruptible timers
Date:   Tue,  1 Aug 2023 15:24:40 +0200
Message-Id: <20230801132441.559222-6-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most timers are unrelated to networking or other softirq vectors (RCU,
NET_*, HRTIMER, TASKLET, ...). Yet when a timer batch is executing,
other softirq vectors have to wait for the timers batch completion
even though there is nothing to synchronize against most callbacks.

However there is no automatic way to determine if a timer callback is
safely soft-interruptible by other vectors. So the only long term viable
approach to solve this is to adopt a progressive push down solution
similar to the one used for getting rid of the big kernel lock.

Introduce a new TIMER_SOFTINTERRUPTIBLE flag which tells the timer
subsystem that a callback is safely soft-interruptible by other vectors,
either because it's completely unrelated to them or because it uses the
appropriate local_bh_disable()/spin_lock_bh() on narrowed-down regions.

Once all timers are dealt with after a few years, it will become
possible to run timers out of the softirqs processing.

It's worth noting though that if the softirq infrastructure supports
soft-interruption of a TIMER_SOFTINTERRUPTIBLE timer, it doesn't allow
yet a TIMER_SOFTINTERRUPTIBLE timer to soft-interrupt other vectors,
even though nothing prevents from it to happen from a correctness point
of view, more tweaks are needed to support that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/timer.h |  5 +++--
 kernel/time/timer.c   | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 9162f275819a..fbe40bacc8c3 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -61,13 +61,14 @@ struct timer_list {
  * should be placed on a particular CPU, then add_timer_on() has to be
  * used.
  */
-#define TIMER_CPUMASK		0x0003FFFF
+#define TIMER_CPUMASK		0x0001FFFF /* If 1 more bit is needed, flags must be 64 */
+#define TIMER_SOFTINTERRUPTIBLE	0x00020000
 #define TIMER_MIGRATING		0x00040000
 #define TIMER_BASEMASK		(TIMER_CPUMASK | TIMER_MIGRATING)
 #define TIMER_DEFERRABLE	0x00080000
 #define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
-#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
+#define TIMER_INIT_FLAGS	(TIMER_SOFTINTERRUPTIBLE | TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 #define TIMER_ARRAYSHIFT	22
 #define TIMER_ARRAYMASK		0xFFC00000
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7cad6fe3c035..1e43f54def0e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1676,6 +1676,7 @@ static void call_timer_fn(struct timer_list *timer,
 			  unsigned long baseclk)
 {
 	int count = preempt_count();
+	bool softinterruptible = false;
 
 #ifdef CONFIG_LOCKDEP
 	/*
@@ -1689,6 +1690,17 @@ static void call_timer_fn(struct timer_list *timer,
 
 	lockdep_copy_map(&lockdep_map, &timer->lockdep_map);
 #endif
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_SOFTIRQ_DISABLED_MASK) &&
+	    timer->flags & TIMER_SOFTINTERRUPTIBLE)
+		softinterruptible = true;
+
+	if (softinterruptible) {
+		local_bh_vec_disable(1 << TIMER_SOFTIRQ);
+		local_bh_exit();
+	}
+
 	/*
 	 * Couple the lock chain with the lock chain at
 	 * timer_delete_sync() by acquiring the lock_map around the fn()
@@ -1702,6 +1714,12 @@ static void call_timer_fn(struct timer_list *timer,
 
 	lock_map_release(&lockdep_map);
 
+	if (softinterruptible) {
+		local_bh_enter();
+		local_bh_vec_enable(1 << TIMER_SOFTIRQ);
+	}
+
+
 	if (count != preempt_count()) {
 		WARN_ONCE(1, "timer: %pS preempt leak: %08x -> %08x\n",
 			  fn, count, preempt_count());
-- 
2.34.1

