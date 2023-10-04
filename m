Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D27B7F42
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbjJDMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242376AbjJDMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695AFC6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:32 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvV/GTzIlX0Cx+6nbNdm3uB0dglqhwMGFjF0Qs3Csts=;
        b=anbpNzaF4gSVJYCje1CvoII4DNAP+K00Xko6363w/r9C54Ss9u48ITN+CsVTms4TpahdsJ
        tqXY+v2mOpyUmHytzorE+MN5OXdzM1pMN55anRLPCyT8+XviZTOU2ABl6PossHk6ybWaRi
        18beY7ITHPVkMfQ5dXhnFBQClLLxWmuu4vWZF29jMC1vajgVmiwOBZwVEFwgJX2iazzGJa
        Z5plhNpKRuTYIZv4vceHtVZQRxrYEb2Ee8FwqOLhcfeA4r6IqBuMtqK4n7upOmqPG+plgJ
        +q9c86bL7B+EFiGxEkzNi0Jkn1b4K1/aCdDFIm3rhIk6f6ByVGj0fi193VtoTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvV/GTzIlX0Cx+6nbNdm3uB0dglqhwMGFjF0Qs3Csts=;
        b=N6cePmuxnggtkUWqTVBUfH7Yjf0o6ukWOKrXHR0Pj/o5cOdJIlIgadV9XxYYQdHtONDg3i
        +QqgcHp36b0UjsAg==
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
Subject: [PATCH v8 09/25] timer: Split out get next timer functionality
Date:   Wed,  4 Oct 2023 14:34:38 +0200
Message-Id: <20231004123454.15691-10-anna-maria@linutronix.de>
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

Split out get next timer functionality to make it reusable in other
places. Thereby the order of getting the next expiry, forwarding the base
clock and mark timer bases as idle, is changed. This change of order
shouldn't have any impact, as nothing inside the function relies on the
idle value or the updated timer base clock.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 18f8aac9b19a..f443aa807fbc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,6 +1911,24 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static inline unsigned long __get_next_timer_interrupt(unsigned long basej,
+						       struct timer_base *base)
+{
+	unsigned long nextevt;
+
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+	nextevt = base->next_expiry;
+
+	if (base->timers_pending) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+	}
+
+	return nextevt;
+}
+
 /**
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
@@ -1933,9 +1951,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		return expires;
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
+	nextevt = __get_next_timer_interrupt(basej, base);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1952,14 +1968,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 */
 	base->is_idle = time_after(nextevt, basej + 1);
 
-	if (base->timers_pending) {
-		/* If we missed a tick already, force 0 delta */
-		if (time_before(nextevt, basej))
-			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-	}
 	raw_spin_unlock(&base->lock);
 
+	expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
-- 
2.39.2

