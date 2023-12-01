Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBD8006DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378018AbjLAJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378055AbjLAJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A521725
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:15 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZi/SXfoi2GICSzM+IYBAVSlO8Hm1DXEFr76jQHYOZ0=;
        b=lPUu/u3782O76F4tssDfbbwJSu1UYJWRXA1YF1HFvK1m8kbs0zLQsUh/Qrq0SympHt1Xn4
        fWs6pLLsziRXsDGGtVSkmgIluUmEPyOt49N0oJuW1GpqQsDrQiTwLCGHDYPxL2sHNl8pO8
        uZrfXgDRa3Soql/IDz++WAZHigpe67VrkWm7MrhlkMdDJb1cuTVJRBpNVrj0k0qs67dVi3
        SnfBc962XKiwdxw27XZSz4hJUgXOfPYnpxuSOBDbSvDj36Sfa0N/0H08AMFC8K3OePFC/t
        LsAllTQBY9b+fu99vTafsfRYXEb2PxTXLZsynXnrqJJ34TflfOYmg29flJ7ItA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZi/SXfoi2GICSzM+IYBAVSlO8Hm1DXEFr76jQHYOZ0=;
        b=DGxDnst2vjquka22zFxBnL29sukEirkFvC4s2bWFecYQdCP9TQh2tKsQYBTAwCLj3xIhX6
        heDteX2CRHR+6lAg==
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
Subject: [PATCH v9 12/32] timers: Fix nextevt calculation when no timers are pending
Date:   Fri,  1 Dec 2023 10:26:34 +0100
Message-Id: <20231201092654.34614-13-anna-maria@linutronix.de>
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

When no timer is queued into an empty timer base, the next_expiry will not
be updated. It was originally calculated as

  base->clk + NEXT_TIMER_MAX_DELTA

When the timer base stays empty long enough (> NEXT_TIMER_MAX_DELTA), the
next_expiry value of the empty base suggests that there is a timer pending
soon. This might be more a kind of a theoretical problem, but the fix
doesn't hurt.

Use only base->next_expiry value as nextevt when timers are
pending. Otherwise nextevt will be jiffies + NEXT_TIMER_MAX_DELTA. As all
information is in place, update base->next_expiry value of the empty timer
base as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New patch
---
 kernel/time/timer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0826018d9873..4dffe966424c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1922,8 +1922,8 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1935,7 +1935,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
 		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1944,10 +1943,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	__forward_timer_base(base, basej);
 
 	if (base->timers_pending) {
+		nextevt = base->next_expiry;
+
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+	} else {
+		/*
+		 * Move next_expiry for the empty base into the future to
+		 * prevent a unnecessary raise of the timer softirq when the
+		 * next_expiry value will be reached even if there is no timer
+		 * pending.
+		 */
+		base->next_expiry = nextevt;
 	}
 
 	/*
-- 
2.39.2

