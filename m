Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9E753A60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjGNMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjGNMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741B30FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDC761CF8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF1C433C8;
        Fri, 14 Jul 2023 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336540;
        bh=5aN+Q3oPnafKIF2T8wfhM6z+hA+r3+neTwc70S52vG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ezahMPheOD63bR1r/oq88CH2vQRpZI5Byj8Fnh9pW29M7BWLpyJ4SEoC9127ahOy+
         V8daIhJFQieJdx9MqSve3W9uSzCd5jRMLEFdjd8mZNyqGyj220pJP0NQCvK929Qf5W
         iYPG8HBnh2pSv6bgEkiCizEOC1Uxyh/fK2SR9r7y+bAmR+59VpMjytaMXh5gZ0Lyu2
         +905GRsd4V5N32w/fppNIUbJjbj+RbQfDXEyJWaIz8kNSmOyMoaiULSsoUjBoJ6EOM
         mVjKL71NOcBrn+oZ29tMxZ02QJnLpWxmKFTCu1VzUozn0C03DbNv3RliTbtGbGqTg5
         im99tuTCdEQXg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] tick/nohz: Rename the tick handlers to more self-explanatory names
Date:   Fri, 14 Jul 2023 14:08:50 +0200
Message-Id: <20230714120852.23573-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714120852.23573-1-frederic@kernel.org>
References: <20230714120852.23573-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 89055050d1ac..a7b5960258f2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1355,7 +1355,7 @@ void tick_nohz_idle_exit(void)
 /*
  * The nohz low res interrupt handler
  */
-static void tick_nohz_handler(struct clock_event_device *dev)
+static void tick_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	struct pt_regs *regs = get_irq_regs();
@@ -1401,7 +1401,7 @@ static void tick_nohz_switch_to_nohz(void)
 	if (!tick_nohz_enabled)
 		return;
 
-	if (tick_switch_to_oneshot(tick_nohz_handler))
+	if (tick_switch_to_oneshot(tick_lowres_handler))
 		return;
 
 	/*
@@ -1464,7 +1464,7 @@ void tick_irq_enter(void)
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
  */
-static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
+static enum hrtimer_restart tick_highres_handler(struct hrtimer *timer)
 {
 	struct tick_sched *ts =
 		container_of(timer, struct tick_sched, sched_timer);
@@ -1513,7 +1513,7 @@ void tick_setup_sched_timer(void)
 	 * Emulate tick processing via per-CPU hrtimers:
 	 */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function = tick_sched_timer;
+	ts->sched_timer.function = tick_highres_handler;
 
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
-- 
2.34.1

