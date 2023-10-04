Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B7B7B7F46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbjJDMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbjJDMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73EE106
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:37 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYE4qjcpMvpvRPLtFGjkbKuz071Vlys4ffOshPkJzPM=;
        b=zB4VvhF4vv/KNyy86ETm1uDqt4dNpl+dbiQYCpi/lMo7g23qLXbl+5zA2C1beMPiSDCANe
        2D7HoBlrCPy0eMmmdBOVpyOiL2ZeB7DTpwGfE21dRqWZ4mtVuYXFlDzfl97wIDSsxTq5pX
        nUuX7qltUVYUlnelarpkoRqdX4r28jCSXB31y9GZPIV4nDXa8UAhl6yqbUhcL8UqX7lt3r
        Wnhj7QLc1fPVzZy/gWASE1JaclowXo6p0LJVMKeYWsvIqMjAjqHt8RUz0f4fyHAdnqkllW
        6CMPygGZH8/cgCN3AnmoDC6mChROdKVMkFoSmb2NZGy5lmipXlts3+mw0yHbIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PYE4qjcpMvpvRPLtFGjkbKuz071Vlys4ffOshPkJzPM=;
        b=gc7NqSHIVqrsBUySm1W+IZ8NZ7pgDH+rnNSRCK+1NYOTkHPp0LqWHr7uGCFD1W1iynhq1+
        zgk4tZDZXYsdnTDw==
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
Subject: [PATCH v8 18/25] timer: Split out "get next timer interrupt" functionality
Date:   Wed,  4 Oct 2023 14:34:47 +0200
Message-Id: <20231004123454.15691-19-anna-maria@linutronix.de>
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

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v6: s/splitted/split
v5: Update commit message
v4: Fix typo in comment
---
 kernel/time/timer.c | 51 +++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4230fc6fa1ed..c3061b28214e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1976,12 +1976,12 @@ static unsigned long next_timer_interrupt(struct timer_base *base)
 	return base->next_expiry;
 }
 
-static inline unsigned long __get_next_timer_interrupt(unsigned long basej, u64 basem,
-						       struct timer_base *base_local,
-						       struct timer_base *base_global,
-						       struct timer_events *tevt)
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
 {
-	unsigned long nextevt, nextevt_local, nextevt_global;
+	unsigned long nextevt_local, nextevt_global;
 	bool local_first;
 
 	nextevt_local = next_timer_interrupt(base_local);
@@ -2000,21 +2000,6 @@ static inline unsigned long __get_next_timer_interrupt(unsigned long basej, u64
 	else
 		local_first = base_local->timers_pending;
 
-	nextevt = local_first ? nextevt_local : nextevt_global;
-
-	/*
-	 * If the @nextevt is at max. one tick away, use @nextevt and store
-	 * it in the local expiry value. The next global event is irrelevant in
-	 * this case and can be left as KTIME_MAX.
-	 */
-	if (time_before_eq(nextevt, basej + 1)) {
-		/* If we missed a tick already, force 0 delta */
-		if (time_before(nextevt, basej))
-			nextevt = basej;
-		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		return tevt->local;
-	}
-
 	/*
 	 * Update tevt->* values:
 	 *
@@ -2028,6 +2013,32 @@ static inline unsigned long __get_next_timer_interrupt(unsigned long basej, u64
 	if (base_local->timers_pending)
 		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
 
+	return local_first ? nextevt_local : nextevt_global;
+}
+
+static inline unsigned long __get_next_timer_interrupt(unsigned long basej, u64 basem,
+						       struct timer_base *base_local,
+						       struct timer_base *base_global,
+						       struct timer_events *tevt)
+{
+	unsigned long nextevt;
+
+	nextevt = fetch_next_timer_interrupt(basej, basem,
+					     base_local, base_global, tevt);
+
+	/*
+	 * If the nextevt is at max. one tick away, use the @nextevt and store
+	 * it in the local expiry value. Reset of next global event to KTIME_MAX
+	 * to make sure it is ignored.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt->global = KTIME_MAX;
+	}
+
 	return nextevt;
 }
 
-- 
2.39.2

