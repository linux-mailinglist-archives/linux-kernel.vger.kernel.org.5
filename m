Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7C7B7F35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjJDMfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjJDMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C1ABF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:27 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZHSfoxNVfe828MrfNDKWiKa0rU0JZbDLb7SUO4brts=;
        b=XKS1DMu/waoOHui1J6PmDLbV3W5XSSy+sqIC/BixILtS8JJQAtNGc7wFqsXwk4os7DeJBI
        gIvdpDDtQYAy5CDTO1uuvPwtJYkyGGxkDj/B7B+/M3yIxdCiDvoouIEa/d2BFQELmjo+8C
        E9MNouWmy42JTVdrwvvoSZEFHvU0iMj7+H8DOwrz8/BO6WboqMR/el3Qr9jk0Esn9D5RcR
        SlKq93yYc2Ib6Uq/O2yw9RUWMGN3wxS8Yx3HCU05bGXsnG7rk0aipwsxT266Y4xl/sjiqA
        aNtkeuCN6lLuKQmB91ySFoLNfjzI9W3cCNkV5plz/KnFFmFsHKhL6pMEHZjzAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZHSfoxNVfe828MrfNDKWiKa0rU0JZbDLb7SUO4brts=;
        b=tbs8E8IzWgWCFdOYwM8uWCeZ8Q6ekfq3O5YC6QDuLtnXEf0o2yjyED6kp87FJBA1RoAHpm
        Y8aaEpV1MmJ6OvBg==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v8 01/25] tick/sched: Cleanup confusing variables
Date:   Wed,  4 Oct 2023 14:34:30 +0200
Message-Id: <20231004123454.15691-2-anna-maria@linutronix.de>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick_nohz_stop_tick() contains the expires (u64 variable) and tick
(ktime_t) variable. In the beginning the value of expires is written to
tick. Afterwards non of the variables is changed. They are only used for
checks.

Drop the not required variable tick and use always expires instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8e9a9dcf60d5..bdad2abdc0c7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -886,7 +886,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono = ts->timer_expires_base;
 	u64 expires = ts->timer_expires;
-	ktime_t tick = expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
@@ -909,7 +908,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	/* Skip reprogram of event if its not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
-		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
+		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
 
 		WARN_ON_ONCE(1);
@@ -934,7 +933,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
-	ts->next_tick = tick;
+	ts->next_tick = expires;
 
 	/*
 	 * If the expiration time == KTIME_MAX, then we simply stop
@@ -949,11 +948,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
-		hrtimer_start(&ts->sched_timer, tick,
+		hrtimer_start(&ts->sched_timer, expires,
 			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
-		hrtimer_set_expires(&ts->sched_timer, tick);
-		tick_program_event(tick, 1);
+		hrtimer_set_expires(&ts->sched_timer, expires);
+		tick_program_event(expires, 1);
 	}
 }
 
-- 
2.39.2

