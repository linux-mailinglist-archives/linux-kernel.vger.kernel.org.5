Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851FA8006EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbjLAJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378025AbjLAJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:28:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B51BE2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:25 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uvz4yBwpNSi6fkT+oXIwoWMRBUwA4W1/FjhD6j61hx8=;
        b=qMsRwsr+tm2NABELd3xGyoIvs9Q3nKC7dA+P1bwnlmoDT+38yK2pUvPofS2GsHFXVt1295
        HLaoAEa2mvXXxrwoBYDdvGli/++GZR+ZlkxXl6ewYb2ZbP77HoKfsEkiSiERJVGHfPUfkc
        sIvtIy0a3bwOVEnQVH/GBNHgGNiouQ70U2o+efM9AwjPrNKIXSnFQaQEn2QGhVLg+OwriT
        86PuSupt2sL8tiDwd/TwQjJlybwK5x5Ya1ZGxjsBN4mZucPh9YxFI+GIi1FKFGgieAXDMv
        BAx2JlsD2U8C5nD8a1aLR8JCCNgq+5CP2wfh9Thj/lLlvXL2ISNL4GV0Go+zKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uvz4yBwpNSi6fkT+oXIwoWMRBUwA4W1/FjhD6j61hx8=;
        b=L2MRucXc33ide4+3K4Tl8jxU6vJKiCjEajaGrRk0LYhWnwHLfvl45rw41XC9DgrZmjhbtH
        ODBBm8bO2hjr5RAg==
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
Subject: [PATCH v9 24/32] timers: Split out "get next timer interrupt" functionality
Date:   Fri,  1 Dec 2023 10:26:46 +0100
Message-Id: <20231201092654.34614-25-anna-maria@linutronix.de>
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

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Update was required (change of preceding patches)
v6: s/splitted/split
v5: Update commit message
v4: Fix typo in comment
---
 kernel/time/timer.c | 64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0d53d853ae22..fc376e06980e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1985,30 +1985,13 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	return base->next_expiry;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-					     bool *idle)
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
 {
-	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
-	struct timer_base *base_local, *base_global;
 	bool local_first;
-	u64 expires;
-
-	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
-	 */
-	if (cpu_is_offline(smp_processor_id())) {
-		if (idle)
-			*idle = true;
-		return tevt.local;
-	}
-
-	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
-
-	raw_spin_lock(&base_local->lock);
-	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
 	nextevt_local = next_timer_interrupt(base_local, basej);
 	nextevt_global = next_timer_interrupt(base_global, basej);
@@ -2037,8 +2020,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto unlock;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		return nextevt;
 	}
 
 	/*
@@ -2048,10 +2031,40 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * ignored. If the global queue is empty, nothing to do either.
 	 */
 	if (!local_first && base_global->timers_pending)
-		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
 
 	if (base_local->timers_pending)
-		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return nextevt;
+}
+
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
+{
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	struct timer_base *base_local, *base_global;
+	unsigned long nextevt;
+	u64 expires;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
+		return tevt.local;
+	}
+
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt = fetch_next_timer_interrupt(basej, basem, base_local,
+					     base_global, &tevt);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -2082,7 +2095,6 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		trace_timer_base_idle(base_local->is_idle, base_local->cpu);
 	}
 
-unlock:
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
-- 
2.39.2

