Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A617F8006DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378079AbjLAJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378034AbjLAJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D610F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:13 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gO/udsWQ+bQJ+e/QIsLEl2DMKpANRb9evAUW1EC/BoI=;
        b=eIQqB/WQldigQLY0Gair11m9tMLsVtE1Ib3/oPytcBEd0/qDyfDCkRvTegLi/ZOrzT7FAp
        m6oEWHBnwrgAMkh9+bzPfsxav1MuLLAhzI9oyKAjTVdcqH2yPJXlWIy6lJF+SCwvcwKr1X
        7Pp+MFb8jhvlCfqGjEwPSRKuAt9kEkCnabNBehpLjPbkXIZ8K5IoNUljS6/u50/eSfQgUf
        VSThVmxWrJu8mpM5Qi5/FgIUXg+bYlY8yit7NI2v3s5jB8u5yF0EAH4bk1q8dEM325dil4
        5dNv4T2hfHZdbg62aF0lh9ESjOV1r6Dbv991Z5BpJBgmgLhuWM8DC8/sKkvU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gO/udsWQ+bQJ+e/QIsLEl2DMKpANRb9evAUW1EC/BoI=;
        b=DLkvoQ1hQ176JTziAZ/kfHhh7nRRJW7GCXqvS2BDCpVLtS0WNM3KRr3h6ZYLXNylsajT5P
        e48W33DVK1JYzuDw==
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
Subject: [PATCH v9 08/32] timers: Clarify check in forward_timer_base()
Date:   Fri,  1 Dec 2023 10:26:30 +0100
Message-Id: <20231201092654.34614-9-anna-maria@linutronix.de>
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

The current check whether a forward of the timer base is required can be
simplified by using an already existing comparison function which is easier
to read. The related comment is outdated and was not updated when the check
changed in commit 36cd28a4cdd0 ("timers: Lower base clock forwarding
threshold").

Use time_before_eq() for the check and replace the comment by copying the
comment from the same check inside get_next_timer_interrupt(). Move the
precious information of the outdated comment to the proper place in
__run_timers().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Move precious information of outdated comment to proper place (as
    suggested by Frederic)
---
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3ca706db1d20..66bac56909ba 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,11 +944,10 @@ static inline void forward_timer_base(struct timer_base *base)
 	unsigned long jnow = READ_ONCE(jiffies);
 
 	/*
-	 * No need to forward if we are close enough below jiffies.
-	 * Also while executing timers, base->clk is 1 offset ahead
-	 * of jiffies to avoid endless requeuing to current jiffies.
+	 * Check whether we can forward the base. We can only do that when
+	 * @basej is past base->clk otherwise we might rewind base->clk.
 	 */
-	if ((long)(jnow - base->clk) < 1)
+	if (time_before_eq(jnow, base->clk))
 		return;
 
 	/*
@@ -2015,6 +2014,10 @@ static inline void __run_timers(struct timer_base *base)
 		 */
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
+		/*
+		 * While executing timers, base->clk is set 1 offset ahead of
+		 * jiffies to avoid endless requeuing to current jiffies.
+		 */
 		base->clk++;
 		next_expiry_recalc(base);
 
-- 
2.39.2

