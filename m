Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26C08006F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378260AbjLAJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378126AbjLAJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:28:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6641BFE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:26 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWHMK6r5kBUJ9iV8cP/TU68Vsy3sDvddkiKO4TwUZlc=;
        b=QMhs93p2ZCm6/MJxUMJdkxY/fBy9yYF7JUtsxSHtc9PYue8MZ0SoTHBdgGncOOxORk0ako
        vL2tnp0171mhN/4n/ReEYLl/a3R6Z/zdScU2QBslAWcu1KSe4vZ+h5iv0arm6+pF4t+FeB
        NjTheIExH1dDjaJXiRJsT4vg4FMpVT27Wiuihfby106yl2uG6MuiyJfHPXoRVnihspDN6Y
        SFZd19aQtV1uHqBTmaAUH80vC9KQsqfY6IqczyD0Sp+K85mgP6sQgx6Te5oltDezegw1H0
        luV9XbDyrXLtx5BGc7S0R3jPEnug9EJnE2fhRH49c0HGea35EpV2UQ/Z1rlS9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWHMK6r5kBUJ9iV8cP/TU68Vsy3sDvddkiKO4TwUZlc=;
        b=xZTklOBzQvP69gCnFqvs8Dq2tLlMJcoPnlLizYK7DoNtiWj3CrGJ5Pba/DvLj/dMeYpxV6
        VDw0ycerZCa3TDCQ==
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
        "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v9 26/32] timers: Restructure internal locking
Date:   Fri,  1 Dec 2023 10:26:48 +0100
Message-Id: <20231201092654.34614-27-anna-maria@linutronix.de>
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

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

Move the locking out from __run_timers() to the call sites, so the
protected section can be extended at the call site. Preparatory patch for
changing the NOHZ timer placement to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2cff43c10329..b0fa8afe9059 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2230,11 +2230,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (time_before(jiffies, base->next_expiry))
-		return;
-
-	timer_base_lock_expiry(base);
-	raw_spin_lock_irq(&base->lock);
+	lockdep_assert_held(&base->lock);
 
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
@@ -2258,21 +2254,36 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+}
+
+static void __run_timer_base(struct timer_base *base)
+{
+	if (time_before(jiffies, base->next_expiry))
+		return;
+
+	timer_base_lock_expiry(base);
+	raw_spin_lock_irq(&base->lock);
+	__run_timers(base);
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
 
+static void run_timer_base(int index)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[index]);
+
+	__run_timer_base(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-
-	__run_timers(base);
+	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		run_timer_base(BASE_GLOBAL);
+		run_timer_base(BASE_DEF);
 	}
 }
 
-- 
2.39.2

