Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F507B7F45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbjJDMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242388AbjJDMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F0FE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:37 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2oLs1aq9wqZoLE3N9pO7i2Jg8pkH2UAvQ/YD0cSS3w=;
        b=ErrEdK5o4fLjNOKgR1xLbb+lqKbZXJX4q+elFfDJDA//0AWfEsqGosv6wzPLQwjZPQ7bKu
        zWclerP4eKvrN4mAIYaUqpyzZZHqL3ULIsjADaDkEZQTPZatbMvYgO6gVOk0DWtulh+hiU
        GZ9xGY/kz+d3oLfEO5rFjzToqXZxzcPYLsnkP0ogcZjQnM1MlWEjtFC/87/5gyYD+3H4HV
        9cCtiBBH+mmNMHPfMPeKzVBiCB5JYYTJB1hJeHlKFIj/pFdZ9R0FwbTEaYWS0nVEh6+71u
        DoMpZ07XeR7/EWdlN1lUtXaQCqan+KMw8KWn/tGPKaixi0Gtonmqjo9qEYikPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2oLs1aq9wqZoLE3N9pO7i2Jg8pkH2UAvQ/YD0cSS3w=;
        b=GAjl7C54dXXudkkC69QtWxiFiXq0RXPiPnqm0zbhDHbxYRfSZfRqBLIwnbsd53fRUtFV5f
        a2BbuSzQvpntn3BA==
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
Subject: [PATCH v8 17/25] timer: Retrieve next expiry of pinned/non-pinned timers separately
Date:   Wed,  4 Oct 2023 14:34:46 +0200
Message-Id: <20231004123454.15691-18-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/time/timer.c | 48 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1cd214c2f3f1..4230fc6fa1ed 100644
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
@@ -1971,9 +1976,10 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 	return base->next_expiry;
 }
 
-static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
+static inline unsigned long __get_next_timer_interrupt(unsigned long basej, u64 basem,
 						       struct timer_base *base_local,
-						       struct timer_base *base_global)
+						       struct timer_base *base_global,
+						       struct timer_events *tevt)
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	bool local_first;
@@ -1996,12 +2002,32 @@ static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
 
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
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		return tevt->local;
 	}
 
+	/*
+	 * Update tevt->* values:
+	 *
+	 * If the local queue expires first, then the global event can
+	 * be ignored. If the global queue is empty, nothing to do
+	 * either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
 	return nextevt;
 }
 
@@ -2015,16 +2041,15 @@ static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
 	if (cpu_is_offline(smp_processor_id()))
-		return expires;
+		return KTIME_MAX;
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
@@ -2032,14 +2057,14 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
-	nextevt = __get_next_timer_interrupt(basej, base_local, base_global);
+	__get_next_timer_interrupt(basej, basem, base_local, base_global, &tevt);
 
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-	expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+	tevt.local = min_t(u64, tevt.local, tevt.global);
 
-	return cmp_next_hrtimer_event(basem, expires);
+	return cmp_next_hrtimer_event(basem, tevt.local);
 }
 
 /**
@@ -2055,6 +2080,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  */
 u64 timer_set_idle(unsigned long basej, u64 basem, bool *idle)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	struct timer_base *base_local, *base_global;
 	unsigned long nextevt;
 
@@ -2073,7 +2099,7 @@ u64 timer_set_idle(unsigned long basej, u64 basem, bool *idle)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
-	nextevt = __get_next_timer_interrupt(basej, base_local, base_global);
+	nextevt = __get_next_timer_interrupt(basej, basem, base_local, base_global, &tevt);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -2097,7 +2123,7 @@ u64 timer_set_idle(unsigned long basej, u64 basem, bool *idle)
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-	return basem + (u64)(nextevt - basej) * TICK_NSEC;
+	return min_t(u64, tevt.local, tevt.global);
 }
 
 /**
-- 
2.39.2

