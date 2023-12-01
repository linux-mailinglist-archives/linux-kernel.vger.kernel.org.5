Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9858006E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378113AbjLAJ23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378167AbjLAJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439561BD6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:24 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdBDR0/tYNJhJm6cSGNxPr1uzJXFKTmkB6lItnLpMig=;
        b=3VH7dqj99SCQxtKQ1cSHqIAwzHimk0La70Y55WoifDDH6FVLlQTD7yElldyys8j5ak6Ljq
        YM2qwCAcIoxkO3hle8SiRG4mhPdiNBC/EL0AwtvgMX4Kqp1sbL/KJu9cLEaFC1rpO7xrQr
        D42gEzHFUKk9udutpeiMZHyEuXmMHcC/OsdsNl1AYyKkSb8mRAHkzDl6n6TU3xEWUhsY3K
        usjBau79n5bQPwp4uEWs/boCxqsThIyOccM08vg6aBAC9p8HXqfiG9EV+O2fxtx/1XSuGd
        0lItm/ND1gNEZOUCslMqCpUE3+It9I2+8K80cO721GJVXTEDDgT7kZwG9JbByA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdBDR0/tYNJhJm6cSGNxPr1uzJXFKTmkB6lItnLpMig=;
        b=ObRXt5dMA2n4hQG6FSjAmMYBdk0L7rGzSvM/iGKlEi37gmbtj9rRCfhmDpjRCr0+YuSwYw
        jMbfdkMFH/57TNBQ==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v9 23/32] timers: Retrieve next expiry of pinned/non-pinned timers separately
Date:   Fri,  1 Dec 2023 10:26:45 +0100
Message-Id: <20231201092654.34614-24-anna-maria@linutronix.de>
In-Reply-To: <20231201092654.34614-1-anna-maria@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have separate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Update was required (change of preceding patches)
---
 kernel/time/timer.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 366ea26ce3ba..0d53d853ae22 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,11 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -1983,10 +1988,11 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
 	bool local_first;
+	u64 expires;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1995,7 +2001,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	if (cpu_is_offline(smp_processor_id())) {
 		if (idle)
 			*idle = true;
-		return expires;
+		return tevt.local;
 	}
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
@@ -2022,13 +2028,31 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 	nextevt = local_first ? nextevt_local : nextevt_global;
 
-	if (base_local->timers_pending || base_global->timers_pending) {
+	/*
+	 * If the @nextevt is at max. one tick away, use @nextevt and store
+	 * it in the local expiry value. The next global event is irrelevant in
+	 * this case and can be left as KTIME_MAX.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		goto unlock;
 	}
 
+	/*
+	 * Update tevt.* values:
+	 *
+	 * If the local queue expires first, then the global event can be
+	 * ignored. If the global queue is empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
@@ -2058,9 +2082,12 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		trace_timer_base_idle(base_local->is_idle, base_local->cpu);
 	}
 
+unlock:
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
+	expires = min_t(u64, tevt.local, tevt.global);
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
-- 
2.39.2

