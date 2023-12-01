Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841DF8006E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378078AbjLAJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjLAJ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40561BC6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:22 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1C4FMe7pCnDmgmGqNMXsgIVbPWX+pQUl8aT2cvTpxE=;
        b=F20CyeVDuw7jm58dTRpNRqAbUkr6ff/ZKa8JWcMJjS1xEGOEeyHQaEWSIyjb9dtKsJPOl7
        J51VieHtILw3lrPjVx/SxFIrkBv3xVrmzu018wirkiPPuCMkentQlQjSk0LX9NJeQXsS2a
        wiXf9rUilA3GKSDN/as4IYPlBFlBhTLb1VnnECsJcr8VK398l1Si0a67e1JFxOfsB7gxRw
        HGSINAF+Bw0YFNzOQTmLcxncwk05bTQmawg21ZZ8DFGSw+gUqURM0GR5+jlOxTabKjFv1s
        mMLPgavKnCIkKjeowAwjCsW9Xe46YZ1AfAWpO/dpgDEj8y0jJyegvsvCsPTEgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1C4FMe7pCnDmgmGqNMXsgIVbPWX+pQUl8aT2cvTpxE=;
        b=zimkCzW5Hc5BNNqsTiWhrRNjS1Qz+YQP0rnArDywmOir6z0bmDO27jgmpr+TsxqqusG/PV
        rfRDRQ7UyL85FzDg==
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
Subject: [PATCH v9 21/32] timers: Split next timer interrupt logic
Date:   Fri,  1 Dec 2023 10:26:43 +0100
Message-Id: <20231201092654.34614-22-anna-maria@linutronix.de>
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

Logic for getting next timer interrupt (no matter of recalculated or
already stored in base->next_expiry) is split into a separate function
"next_timer_interrupt()" to make it available for new call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: Adapt to the fix for empty timer bases.
---
 kernel/time/timer.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index b14d84f1fe50..eda4972ca862 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1951,12 +1951,29 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base,
+					  unsigned long basej)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	/*
+	 * Move next_expiry for the empty base into the future to prevent a
+	 * unnecessary raise of the timer softirq when the next_expiry value
+	 * will be reached even if there is no timer pending.
+	 */
+	if (!base->timers_pending)
+		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+
+	return base->next_expiry;
+}
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
+	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1969,24 +1986,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	}
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+	nextevt = next_timer_interrupt(base, basej);
 
 	if (base->timers_pending) {
-		nextevt = base->next_expiry;
-
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-	} else {
-		/*
-		 * Move next_expiry for the empty base into the future to
-		 * prevent a unnecessary raise of the timer softirq when the
-		 * next_expiry value will be reached even if there is no timer
-		 * pending.
-		 */
-		base->next_expiry = nextevt;
 	}
 
 	/*
-- 
2.39.2

