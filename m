Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9233379CEA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjILKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjILKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621E1723
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DDC433C7;
        Tue, 12 Sep 2023 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694515458;
        bh=VCFbnQWF4lBKNsyVMLqdG0QZaSmJF0XJv43q7YI+WJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij0CYZgaVcSp8NNMGm/8zBEDL0iwV2PKmBd1Nm5k3o6P+Qp2yBJ98gBJSnUMfe9nb
         IflZHmMYS+fwdXrzegZVbXuI6GQrB2I4JL5Xmdx+wOlS7AR5HJCWHAuWM4bCbrrWqi
         02ZQa72WsGXDf9LUvHsU8c+M/1+1WryFlODfmXHVHCOkJ+RXj5v3EH1FRDgJvkliYq
         q8ZLvYU+gbFuaVnioZnoiLTBklfsQdkbENaNEs5cEw5Bci7FoM58SXmigmJjR5LRgI
         tMDPLfpiTdWgqPWqvuGih3IHvGRHV4civS8KaQ3ooUdCegwF6guIvM+5X45PvJWRzZ
         HumGu/L4k3BRA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com
Subject: [PATCH 2/5] tick/nohz: Update obsolete comments
Date:   Tue, 12 Sep 2023 12:44:03 +0200
Message-Id: <20230912104406.312185-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912104406.312185-1-frederic@kernel.org>
References: <20230912104406.312185-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments are obsolete enough to assume that IRQ exit restarts the
tick in idle or RCU is turned on at the same time as the tick, among
other details.

Update them and add more.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b66dd0ff1153..95a8d1d118a2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1175,12 +1175,23 @@ void tick_nohz_idle_enter(void)
 }
 
 /**
- * tick_nohz_irq_exit - update next tick event from interrupt exit
+ * tick_nohz_irq_exit - Notify the tick about IRQ exit
  *
- * When an interrupt fires while we are idle and it doesn't cause
- * a reschedule, it may still add, modify or delete a timer, enqueue
- * an RCU callback, etc...
- * So we need to re-calculate and reprogram the next tick event.
+ * A timer may have been added/modified/deleted either by the current IRQ,
+ * or by another place using this IRQ as a notification. This IRQ may have
+ * also updated the RCU callback list. These events may require a
+ * re-evaluation of the next tick. Depending on the context:
+ *
+ * 1) If the CPU is idle and no resched is pending, just proceed with idle
+ *    time accounting. The next tick will be re-evaluated on the next idle
+ *    loop iteration.
+ *
+ * 2) If the CPU is nohz_full:
+ *
+ *    2.1) If there is any tick dependency, restart the tick if stopped.
+ *
+ *    2.2) If there is no tick dependency, (re-)evaluate the next tick and
+ *         stop/update it accordingly.
  */
 void tick_nohz_irq_exit(void)
 {
@@ -1330,11 +1341,20 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 }
 
 /**
- * tick_nohz_idle_exit - restart the idle tick from the idle task
+ * tick_nohz_idle_exit - Update the tick upon idle task exit
+ *
+ * When the idle task exits, update the tick depending on the
+ * following situations:
+ *
+ * 1) If the CPU is not in nohz_full mode (most cases), then
+ *    restart the tick.
+ *
+ * 2) If the CPU is in nohz_full mode (corner case):
+ *   2.1) If the tick can be kept stopped (no tick dependencies)
+ *        then re-eavaluate the next tick and try to keep it stopped
+ *        as long as possible.
+ *   2.2) If the tick has dependencies, restart the tick.
  *
- * Restart the idle tick when the CPU is woken up from idle
- * This also exit the RCU extended quiescent state. The CPU
- * can use RCU again after this function is called.
  */
 void tick_nohz_idle_exit(void)
 {
@@ -1364,7 +1384,13 @@ void tick_nohz_idle_exit(void)
 }
 
 /*
- * The nohz low res interrupt handler
+ * In low-resolution mode, the tick handler must be implemented directly
+ * at the clockevent level. hrtimer can't be used instead because its
+ * infrastructure actually relies on the tick itself as a backend in
+ * low-resolution mode (see hrtimer_run_queues()).
+ *
+ * This low-resolution handler still makes use of some hrtimer APIs meanwhile
+ * for commodity with expiration calculation and forwarding.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
-- 
2.34.1

