Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CB27B7F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbjJDMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbjJDMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:35:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC4C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:35:31 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696422930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxpi78IDwxZZgGLEvaVUb//vKcdGLGnLWfwEyUx5Nmw=;
        b=BDLOxBrpk3OptCr9bdEYLu1NT+9K7T/RiwoEvkZ/7gmRSnp35L1Ky0L5I76iA0nT6WpyF/
        /UAflRMfwUegkPMshVRxDOX46Ng8CXg+0RjKSp/JD2ZfmUJWF9HQP4JG0d0gHiPQO3XDKU
        CRAtp0MTRbGrsi04whb4Q2ET2AKv4V/35kS1QR0LIvvXkwump5FR6wUEgQV7bpRHOjPkhe
        W3ZaAJsdUFWBJ4WjU4cNDcyE5jk21IpJU1lECmoFHmKS0Shy1EWc5eGhkr6LeAyqL1kAh2
        7qHcP0n+Y6206fWDV9dDpDFhzqn/y8ODkl0V/hSIapte4S78tQBHOzW+/jS05g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696422930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxpi78IDwxZZgGLEvaVUb//vKcdGLGnLWfwEyUx5Nmw=;
        b=ZjvV/Gf61Hjp7Rgy1OmNsLZBFCK3wKahqbT70dfSzdcmtdWYmwpBuE+3dGglFB3SyiNNCP
        Nks9H9Zliz8MaGCA==
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
Subject: [PATCH v8 08/25] timer: Rework idle logic
Date:   Wed,  4 Oct 2023 14:34:37 +0200
Message-Id: <20231004123454.15691-9-anna-maria@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

To improve readability of the code, split base->idle calculation and
expires calculation into separate parts.

Thereby the following subtle change happens if the next event is just one
jiffy ahead and the tick was already stopped: Originally base->is_idle
remains true in this situation. Now base->is_idle turns to false. This may
spare an IPI if a timer is enqueued remotely to an idle CPU that is going
to tick on the next jiffy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v4: Change condition to force 0 delta and update commit message (Frederic)
---
 kernel/time/timer.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dc58c479d35a..18f8aac9b19a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1943,21 +1943,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 */
 	__forward_timer_base(base, basej);
 
-	if (time_before_eq(nextevt, basej)) {
-		expires = basem;
-		base->is_idle = false;
-	} else {
-		if (base->timers_pending)
-			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		/*
-		 * If we expect to sleep more than a tick, mark the base idle.
-		 * Also the tick is stopped so any added timer must forward
-		 * the base clk itself to keep granularity small. This idle
-		 * logic is only maintained for the BASE_STD base, deferrable
-		 * timers may still see large granularity skew (by design).
-		 */
-		if ((expires - basem) > TICK_NSEC)
-			base->is_idle = true;
+	/*
+	 * Base is idle if the next event is more than a tick away. Also
+	 * the tick is stopped so any added timer must forward the base clk
+	 * itself to keep granularity small. This idle logic is only
+	 * maintained for the BASE_STD base, deferrable timers may still
+	 * see large granularity skew (by design).
+	 */
+	base->is_idle = time_after(nextevt, basej + 1);
+
+	if (base->timers_pending) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
 	raw_spin_unlock(&base->lock);
 
-- 
2.39.2

