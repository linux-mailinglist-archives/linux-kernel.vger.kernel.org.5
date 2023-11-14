Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE17EB6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjKNTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjKNTiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:38:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6B10D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:38:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3054C433C9;
        Tue, 14 Nov 2023 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699990726;
        bh=AI6BXRLyDCRzfgTcAPcBGNu2Xr1HniWMknoBjvYmHug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9T3QtOfwyMU3SM/xpQ/Glx/rMUj5Plw6/3/0jabnR7kXRucPmXtaqD7J5jFCUn41
         oxM9PHRB/h3uCCnw33AuBgmcE8xk7xj+4tIzJTIykuS6tssltjN2WiQg2LQiCCoNZ7
         wZTIq6PY48L30SmyEo9A0JX/mHxpibSL3/Qi7WV6uEP3H3kBeTOfU9df70r8xKDNTs
         pLQ1rULivGrP1b1aYrQLQRUIpVXsjDrDFauE/ajgFac79dbCxR0om9zv5cZ1tYf/DV
         94l1q7oQDep6BYh1w1Osnyx6zgxrByT9+SOLzTzFbVWLwrCLdIcgVzcFXochoSzalG
         eGDZu7ibPoFUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/2] sched/cpuidle: Comment about timers requirements VS idle handler
Date:   Tue, 14 Nov 2023 14:38:39 -0500
Message-ID: <20231114193840.4041-2-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114193840.4041-1-frederic@kernel.org>
References: <20231114193840.4041-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing explanation concerning IRQs re-enablement constraints in
the cpuidle path against timers.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f8374ddbb..31231925f1ec 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -258,6 +258,36 @@ static void do_idle(void)
 	while (!need_resched()) {
 		rmb();
 
+		/*
+		 * Interrupts shouldn't be re-enabled from that point on until
+		 * the CPU sleeping instruction is reached. Otherwise an interrupt
+		 * may fire and queue a timer that would be ignored until the CPU
+		 * wakes from the sleeping instruction. And testing need_resched()
+		 * doesn't tell about pending needed timer reprogram.
+		 *
+		 * Several cases to consider:
+		 *
+		 * - SLEEP-UNTIL-PENDING-INTERRUPT based instructions such as
+		 *   "wfi" or "mwait" are fine because they can be entered with
+		 *   interrupt disabled.
+		 *
+		 * - sti;mwait() couple is fine because the interrupts are
+		 *   re-enabled only upon the execution of mwait, leaving no gap
+		 *   in-between.
+		 *
+		 * - ROLLBACK based idle handlers with the sleeping instruction
+		 *   called with interrupts enabled are NOT fine. In this scheme
+		 *   when the interrupt detects it has interrupted an idle handler,
+		 *   it rolls back to its beginning which performs the
+		 *   need_resched() check before re-executing the sleeping
+		 *   instruction. This can leak a pending needed timer reprogram.
+		 *   If such a scheme is really mandatory due to the lack of an
+		 *   appropriate CPU sleeping instruction, then a FAST-FORWARD
+		 *   must instead be applied: when the interrupt detects it has
+		 *   interrupted an idle handler, it must resume to the end of
+		 *   this idle handler so that the generic idle loop is iterated
+		 *   again to reprogram the tick.
+		 */
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
-- 
2.42.1

