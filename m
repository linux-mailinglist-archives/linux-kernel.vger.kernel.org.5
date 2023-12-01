Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6A8006E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378153AbjLAJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378071AbjLAJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:27:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00B173B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:18 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701422837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nS3of1gsjpadmlTzOeKtxhnS0y1kmX6N3aik41bHBiA=;
        b=jd8JdSo6RSMAzUQGD0eFZtqqXum4T5DNbkhKfHsGgfKrpZeYgvPMRbitqOvajGAVnOXjI6
        CUwVNu95rNCy/L5GzK63NOh365EDVDrf9ayAK4msa7dXSpEa80xXUWomRi6duxWLFm+VbM
        qCr1hrcESNQGxbIdSVpGa6B5nMD7U+enDcqohqFlaqh/MYvEqE3lCzl2P2uDwny8GJ0pZb
        e+Y7Q5UkpxPIXt7kcmWi+U4AE9QBHs0PlQvwXPRBOBrT+RaB+0SEBxJG882s2281fx76As
        0B3s31n61vB24z+VP0fxZkI3ZAtKnfsQ0JzpWsdc4wBnNvNXxSgu/bYlY0W5kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701422837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nS3of1gsjpadmlTzOeKtxhnS0y1kmX6N3aik41bHBiA=;
        b=XvAVoft42FnLB6t8nWzHoq+keWMNp0u+ZuAOQmacO5++zBupzj5qe3N+KJ0loGqLT7o1ZZ
        rrBvtWXBA6WYHMAg==
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
Subject: [PATCH v9 16/32] timers: Optimization for timer_base_try_to_set_idle()
Date:   Fri,  1 Dec 2023 10:26:38 +0100
Message-Id: <20231201092654.34614-17-anna-maria@linutronix.de>
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

When tick is stopped also the timer base is_idle flag is set. When
reentering the timer_base_try_to_set_idle() with the tick stopped, there is
no need to check whether the timer base needs to be set idle again. When a
timer was enqueued in the meantime, this is already handled by the
nohz_get_next_event() call which was executed before tick_nohz_stop_tick().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v9: New, as this optimization was splitted from the patch before.
---
 kernel/time/tick-sched.c |  2 +-
 kernel/time/timer.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e1cdb7c6966..c6b415052c56 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -886,7 +886,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	bool timer_idle;
+	bool timer_idle = ts->tick_stopped;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index df6558f62e6f..177bcde8a2c0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1996,13 +1996,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
- * @idle:	pointer to store the value of timer_base->is_idle
+ * @idle:	pointer to store the value of timer_base->is_idle on return;
+ *		*idle contains the information whether tick was already stopped
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX is
+ * returned as well.
  */
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 {
+	if (*idle)
+		return KTIME_MAX;
+
 	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
-- 
2.39.2

