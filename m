Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB29753A61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjGNMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjGNMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07CC358C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:09:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753DA61D0A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E65C433CA;
        Fri, 14 Jul 2023 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689336541;
        bh=/slFP8PnGWA7H6MNZcZEGi/oCv3llKDnLYsTqJrggjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFL3GL+i9SEmh6xzehP3qYrtCSQOb0b6FNgdVcFZjKbCZejrXkHygNSLEHjLu/kk4
         qhI/CZrbrLA7K1543AHyXbq8FNOEu11/ENta+gfatziIz20qyAkQX1XM+mofdK31Kg
         IgHa+hp86NexxnQSwTYekodb/dTkFRAdotYw6avQ+RBIjPqkeO1s91brUbpL59B8vZ
         mOyv0Q8ofr51/pZ6FKS/byFQIaGWGLE8xW5LWAz0aF75pqItc2/+Pc5hgDVrri+9nk
         pFnva78vZkH5p0fUXbSg3EGnob9wrxhJ0sayjglGlmXWOXCRdCsCZcjY7Iic2Lzm2f
         02hW7WDbZ39Eg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/3] tick/nohz: Update obsolete comments
Date:   Fri, 14 Jul 2023 14:08:51 +0200
Message-Id: <20230714120852.23573-3-frederic@kernel.org>
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

Some comments are obsolete enough to assume that IRQ exit restarts the
tick in idle or RCU is turned on at the same time as the tick, among
other details.

Update them and add more.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a7b5960258f2..dd25da8531f4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1164,12 +1164,23 @@ void tick_nohz_idle_enter(void)
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
@@ -1319,11 +1330,20 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
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
@@ -1353,7 +1373,13 @@ void tick_nohz_idle_exit(void)
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
 static void tick_lowres_handler(struct clock_event_device *dev)
 {
-- 
2.34.1

