Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB08006E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378064AbjLAJ1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378050AbjLAJ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF8171C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:14 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjHpvhdurB+xA/Q5Qjg90zYVhHrCM9ixI3FXScsHyt8=;
        b=KKGSI58SUmBD5Umq/6Q4hIqdbuQjSnzca6zjvAccM2ulw1J6bMv4sXp813ZrMIM1hVtQVH
        MspT53qWCRzuqvVxUVkoZ04eH80zx/S7MKiw82z+OJKUhRBCi4XQI0/1WlXc2sqf13LW5W
        IliQXqnyGckto5IWaqLX7GyU0+RzB8zepKOF/AnVpcJ+6MNpR5HCo26arlDmQf94v6jG3J
        wUax+CBx48cBjE5Axx9p7sO19r8k8gYwRvLBrc5EXDJDpWBcX66pOL4Ys/OiTDUdjW/xc+
        t8UrhivzaOHFUQCi/N8COFa/nSqBBhaGOO7CG3xoQe4tqPVGSUhVWd0rxerE7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjHpvhdurB+xA/Q5Qjg90zYVhHrCM9ixI3FXScsHyt8=;
        b=Aml3ir39NvV+AcjCiHTJCqqN6AvMpP5DwCTpdnC7/AHu45ZPNUabml56+ThbNpQsMZFpb2
        eyfv64zM1EqeFwBg==
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
Subject: [PATCH v9 11/32] timers: Rework idle logic
Date:   Fri,  1 Dec 2023 10:26:33 +0100
Message-Id: <20231201092654.34614-12-anna-maria@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

To improve readability of the code, split base->idle calculation and
expires calculation into separate parts. While at it, update the comment
about timer base idle marking.

Thereby the following subtle change happens if the next event is just one
jiffy ahead and the tick was already stopped: Originally base->is_idle
remains true in this situation. Now base->is_idle turns to false. This may
spare an IPI if a timer is enqueued remotely to an idle CPU that is going
to tick on the next jiffy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v9: Re-ordering to not hurt the eyes and update comment
v4: Change condition to force 0 delta and update commit message (Frederic)
---
 kernel/time/timer.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fee42dda8237..0826018d9873 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1943,22 +1943,23 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
+	if (base->timers_pending) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
+
+	/*
+	 * Base is idle if the next event is more than a tick away.
+	 *
+	 * If the base is marked idle then any timer add operation must forward
+	 * the base clk itself to keep granularity small. This idle logic is
+	 * only maintained for the BASE_STD base, deferrable timers may still
+	 * see large granularity skew (by design).
+	 */
+	base->is_idle = time_after(nextevt, basej + 1);
+
 	trace_timer_base_idle(base->is_idle, base->cpu);
 	raw_spin_unlock(&base->lock);
 
-- 
2.39.2

