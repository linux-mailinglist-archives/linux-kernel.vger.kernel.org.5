Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F77B0788
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjI0PBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjI0PBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:01:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF79192;
        Wed, 27 Sep 2023 08:01:33 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695826891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBwqXzZPblG1ncLS43lGYrnNbOnW3bAsFhI96LBlU5g=;
        b=qsABm6HZX825o3E4bTX7obwAWDl8AyY0rA8V7oM17PTAEhR6NJwhUWsVNBbMHgzWpc06MM
        mycdeStLix6qZykrVFB/LzofUfDNWAXSDgKOsIA3WCN6vSvtL0giWoSeEaPA5Hgd+BTAp1
        A2zBzx8On0FygkkIpsGZL/pYNGddFwzCBtulgbdODylPTRqm8u+xc21pqzz1w75iuy859c
        Z/3pQvI5rb7qYZkSNZT/p7q8iW7DYHyp0vpcxq4hWXbXWkyt7RfNMzNOOmaJ65EczzWZ9z
        VSNnLFJqSogHk552vtPIxwl2pqycMER3IpK7gtBrExEkzFvb3P/VZkF2mmc1wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695826891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBwqXzZPblG1ncLS43lGYrnNbOnW3bAsFhI96LBlU5g=;
        b=x/AD695BFQ3drhzQtTnKnOxEzb3gXPzTW7HsVCdOOeXlaMXmQTMMWFYVkBT++0CZfp92X+
        VLza9VVUNpyxerCg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/nohz: Don't shutdown the lowres tick from itself
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230912104406.312185-4-frederic@kernel.org>
References: <20230912104406.312185-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <169582689055.27769.5495044168356785862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4f7f4409af289715f44685f250e380ce2cbffc7e
Gitweb:        https://git.kernel.org/tip/4f7f4409af289715f44685f250e380ce2cbffc7e
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 12:44:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Sep 2023 16:58:10 +02:00

tick/nohz: Don't shutdown the lowres tick from itself

In lowres dynticks mode, just like in highres dynticks mode, when there
is no tick to program in the future, the tick eventually gets
deactivated either:

  * From the idle loop if in idle mode.
  * From the IRQ exit if in full dynticks mode.

Therefore there is no need to deactivate it from the tick itself. This
just just brings more overhead in the idle tick path for no reason.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20230912104406.312185-4-frederic@kernel.org

---
 kernel/time/tick-sched.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 95a8d1d..8e9a9dc 100644
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
 
