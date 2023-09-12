Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109679CEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjILKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjILKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E31719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BD4C433C9;
        Tue, 12 Sep 2023 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515457;
        bh=DfGb/oQJpcnc2u0v4QarnLBwZAczc4rgBDguNVZFTUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXoO/Z54oTmdIbTn/COSHP50p6mFZ74ZsOEqTt/SgXMpYrv3qZJ+G2IcSoTrR9coG
         mbmlKCu2Lzzlj/V4fPzzEHS9iYkvDULa0ns+igEzbqmMdjj5klRN073QGxcvOwHWOh
         I0vcGz3UPmCm0UUXthSuJbWp+cXNm8vMFnspmBTUPCl6GQHy41pDiyICuy3x8vrPEr
         b7l/WsrfaqHoSq27xeAcCEFiqmqV1tKDUFyZLuGFr/NbAdjcucEXwFzU5+82kBLkpW
         Cb5b8iENoRh5G5BGFiC1MbN9Luc2fH0P55qGAF4y4BN4LspvGC+Fnln1xAdUii8dcv
         VG2c5HucFP7lw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
Subject: [PATCH 1/5] tick/nohz: Rename the tick handlers to more self-explanatory names
Date:   Tue, 12 Sep 2023 12:44:02 +0200
Message-Id: <20230912104406.312185-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912104406.312185-1-frederic@kernel.org>
References: <20230912104406.312185-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current name of the tick handlers don't tell much about what differ
between them. Use names that better reflect their role and resolution.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 87015e9deacc..b66dd0ff1153 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1366,7 +1366,7 @@ void tick_nohz_idle_exit(void)
 /*
  * The nohz low res interrupt handler
  */
-static void tick_nohz_handler(struct clock_event_device *dev)
+static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	struct pt_regs *regs = get_irq_regs();
@@ -1412,7 +1412,7 @@ static void tick_nohz_switch_to_nohz(void)
 	if (!tick_nohz_enabled)
 		return;
 
-	if (tick_switch_to_oneshot(tick_nohz_handler))
+	if (tick_switch_to_oneshot(tick_nohz_lowres_handler))
 		return;
 
 	/*
@@ -1475,7 +1475,7 @@ void tick_irq_enter(void)
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
  */
-static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 {
 	struct tick_sched *ts =
 		container_of(timer, struct tick_sched, sched_timer);
@@ -1524,7 +1524,7 @@ void tick_setup_sched_timer(void)
 	 * Emulate tick processing via per-CPU hrtimers:
 	 */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_sched_timer;
+	ts->sched_timer.function = tick_nohz_highres_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
-- 
2.34.1

