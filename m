Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E08006D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378029AbjLAJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378004AbjLAJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703D10F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:08 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl8/xzU+GiuSpXdMfzNJncPixT2cuPm0ChHCjye17qI=;
        b=PRcshUeiqQBP6Ypl/4igU9gnAZax/WZ9o6XJmRkijSQlV8N4QjPU98SYISHBREqA75uWZe
        aXLpTqOnLIMMSJtBYXQmc9vf6PUTFIdnVOz1ssiOQTEDoFR/CgOrgEXe6urDrJO3mAyMOZ
        CnXf0fRTJBCt/jCRZ09/255zi7frJtW4JTzBXU4m3SuzthrUHV2wDxvgqhxrl/ebelKOPs
        8+OOkyFutkDdkDCpN3W0Cap8wApvWQSwQCdI0nIAKfgUSjYLhsPGYaaWgOTaY6tPN0rP28
        fpvOInjCw9cXNbhxFLhb7yxte3vgMP/miUKuEACWllOZLXZawL5HAxaL+esNsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl8/xzU+GiuSpXdMfzNJncPixT2cuPm0ChHCjye17qI=;
        b=Sb+rjhnebJJIO1g9BgSS4qyOLxH+tt5Barqeak47ZCMSmExPUqtDHBEroBlyuhU1DJydwt
        x7ySNlMzzhm9QdCg==
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
Subject: [PATCH v9 02/32] tick/sched: Cleanup confusing variables
Date:   Fri,  1 Dec 2023 10:26:24 +0100
Message-Id: <20231201092654.34614-3-anna-maria@linutronix.de>
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

tick_nohz_stop_tick() contains the expires (u64 variable) and tick
(ktime_t) variable. In the beginning the value of expires is written to
tick. Afterwards none of the variables is changed. They are only used for
checks.

Drop the not required variable tick and use always expires instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Fix typo in commit message
---
 kernel/time/tick-sched.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5c28cc80fd25..89517cfb6510 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -887,7 +887,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono = ts->timer_expires_base;
 	u64 expires = ts->timer_expires;
-	ktime_t tick = expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
@@ -910,7 +909,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	/* Skip reprogram of event if it's not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
-		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
+		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
 
 		WARN_ON_ONCE(1);
@@ -935,7 +934,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
-	ts->next_tick = tick;
+	ts->next_tick = expires;
 
 	/*
 	 * If the expiration time == KTIME_MAX, then we simply stop
@@ -950,11 +949,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
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

