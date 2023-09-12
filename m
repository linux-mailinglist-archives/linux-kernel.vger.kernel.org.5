Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CC79CEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjILKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjILKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC4172E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52499C433C8;
        Tue, 12 Sep 2023 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515460;
        bh=8IMEGNQxJUVrw2F/l3GmN1Ldd+1Byg1w8yqybgZALh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEbvCx9uyF/x3U3frcNYdc0orFnxJFUZf6M65+NQ6QlTsM0zyiPtq33dJaI5zvgYq
         3cA/hKUI7sBb8mYwLRFR2XMCSZ7+msxco0rRRkt9b8A2/xU1sr13E23dZC4zrut+xK
         HO0U+BjZqCW6XqlrCfWeLWcIWM0M1tsVMSpX/ziQumN3H7OGFjs++AR3BZLop5vWHG
         wI9Z/EeoOlPuw8p2fY95zQR0K0MATtZL3ca6JP9GqZ1+9RSR6lfpoSeUdeZD0PowRe
         vjbZz3TzGJZIPgeGezEFrQc9an1xqTqUf35Q5mhoz84fTZqWm07At91+Ksyh/JdwQf
         Il+4zUKLz0v1w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/5] tick/nohz: Don't shutdown the lowres tick from itself
Date:   Tue, 12 Sep 2023 12:44:04 +0200
Message-Id: <20230912104406.312185-4-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912104406.312185-1-frederic@kernel.org>
References: <20230912104406.312185-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lowres dynticks mode, just like in highres dynticks mode, when there
is no tick to program in the future, the tick eventually gets
deactivated either:

* From the idle loop if in idle mode.
* From the IRQ exit if in full dynticks mode.

Therefore there is no need to deactivate it from the tick itself. This
just just brings more overhead in the idle tick path for no reason.

Fixes: 62c1256d5447 ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 95a8d1d118a2..8e9a9dcf60d5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1403,18 +1403,16 @@ static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
 
-	if (unlikely(ts->tick_stopped)) {
-		/*
-		 * The clockevent device is not reprogrammed, so change the
-		 * clock event device to ONESHOT_STOPPED to avoid spurious
-		 * interrupts on devices which might not be truly one shot.
-		 */
-		tick_program_event(KTIME_MAX, 1);
-		return;
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (likely(!ts->tick_stopped)) {
+		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1519,7 +1517,11 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 	else
 		ts->next_tick = 0;
 
-	/* No need to reprogram if we are in idle or full dynticks mode */
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-- 
2.34.1

