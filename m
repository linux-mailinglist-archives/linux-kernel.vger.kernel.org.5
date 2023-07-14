Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645E0753A62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjGNMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjGNMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF92212B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAB1B61CF1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58240C433CB;
        Fri, 14 Jul 2023 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336543;
        bh=nUjt9aPIm8t8zpCcFZjv3pXhHtLHcHwW+ZKfovq5PGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EELJSa6dEHGyMIPSwoSdvUpZm/AQsox03og/2qj+DWzf101pcI642XDG3WektyVaN
         Up2r9pkCt/JsJ+uVAS8qFHYS9q47Vl0auU+lk5wG1K4i0nXHEViENcW+PaUUjtEcO0
         I0jp1jssPkj3Jw6hEQOlX8ED2NO/9PvKaEIG/qBLXWrn2yLoOmCw0+wuZvWbClBFWS
         qHrsbu/BS9vZNPeTJKpc1tLBS/fqB9mAhFrazZOeo40+nKK/LISOXEvWDkjx1COIAG
         6WvBimR4igEcq/Q2+o2NdTmwbdUrUgS9zPOq4TX3IDFJsX+BliqACR+lg7nnRcegQ7
         +EkBl5Y66fdOQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Date:   Fri, 14 Jul 2023 14:08:52 +0200
Message-Id: <20230714120852.23573-4-frederic@kernel.org>
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
index dd25da8531f4..101251e103be 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1392,18 +1392,16 @@ static void tick_lowres_handler(struct clock_event_device *dev)
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
@@ -1508,7 +1506,11 @@ static enum hrtimer_restart tick_highres_handler(struct hrtimer *timer)
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

