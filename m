Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094AF7F8638
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjKXWdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjKXWdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:33:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45421BE2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:33:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32778C433CB;
        Fri, 24 Nov 2023 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700865180;
        bh=qkwnYSoqlBcfb84gH/3LY3O2XgUdAI1yXrt+QgVwpng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LG5Q5EEgKX6cIW/WbSemc+jpnC4AVH6XFhH2IavHYRsaAdG4Yf+u7scHj7+B1U+6v
         xAy6ws8g/2QZl9G9qSIivZfAAFEPDvLaEuigQutSypLnKxUcY7qegY5zBggdPdK5mM
         z0/EUYh2gJ00egk/QgMjyJQAAnXHEv6Ubxa7m8wa9lXW2EnpwOYlhxQmPMusty05N7
         tBwsmU262FNzth+F8s3JnhxTU7QRrb25NzWeROZxbquU5igA3thQ+tVAKccsE2imGA
         4zsxcSoRgJUEWm/QC/O8cjb2+EireCnBmjStyIuN4gdVp1mYDxLynBoxICn14o/EXz
         JCheLVxxPDzAA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/7] cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle states
Date:   Fri, 24 Nov 2023 23:32:26 +0100
Message-ID: <20231124223226.24249-8-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
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

Software polling idle states set again TIF_NR_POLLING and clear it upon
exit. This involves error prone duplicated code and wasted cycles
performing atomic operations, sometimes RmW fully ordered.

To avoid this, benefit instead from the same generic TIF_NR_POLLING
handling that is currently in use for hardware polling states.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 10 ----------
 drivers/cpuidle/cpuidle-pseries.c | 11 -----------
 drivers/cpuidle/cpuidle.c         |  4 ++--
 drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 675b8eb81ebd..b88bbf7ead41 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -71,8 +71,6 @@ static int snooze_loop(struct cpuidle_device *dev,
 {
 	u64 snooze_exit_time;
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
 	local_irq_enable();
 
 	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
@@ -81,21 +79,13 @@ static int snooze_loop(struct cpuidle_device *dev,
 	HMT_very_low();
 	while (!need_resched()) {
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
-			/*
-			 * Task has not woken up but we are exiting the polling
-			 * loop anyway. Require a barrier after polling is
-			 * cleared to order subsequent test of need_resched().
-			 */
-			clear_thread_flag(TIF_POLLING_NRFLAG);
 			dev->poll_time_limit = true;
-			smp_mb();
 			break;
 		}
 	}
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 4e08c9a39172..0ae76512b740 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -39,8 +39,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 {
 	u64 snooze_exit_time;
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
 	pseries_idle_prolog();
 	raw_local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
@@ -50,21 +48,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		HMT_low();
 		HMT_very_low();
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
-			/*
-			 * Task has not woken up but we are exiting the polling
-			 * loop anyway. Require a barrier after polling is
-			 * cleared to order subsequent test of need_resched().
-			 */
 			dev->poll_time_limit = true;
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-			smp_mb();
 			break;
 		}
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
-
 	raw_local_irq_disable();
 
 	pseries_idle_epilog();
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 49078cc83f4a..9eb811b5d8b6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -236,8 +236,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		broadcast = false;
 	}
 
-	polling = target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
-
+	polling = (target_state->flags & (CPUIDLE_FLAG_POLLING_SOFT |
+					  CPUIDLE_FLAG_POLLING_HARD));
 	/*
 	 * If the target state doesn't poll on need_resched(), this is
 	 * the last check after which further TIF_NEED_RESCHED remote setting
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index a2fe173de117..3bfa251b344a 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -13,35 +13,29 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	u64 time_start = local_clock_noinstr();
+	unsigned int loop_count = 0;
+	u64 limit;
 
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
-	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
 
-		limit = cpuidle_poll_time(drv, dev);
+	limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
+	while (!need_resched()) {
+		cpu_relax();
+		if (loop_count++ < POLL_IDLE_RELAX_COUNT)
+			continue;
 
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
+		loop_count = 0;
+		if (local_clock_noinstr() - time_start > limit) {
+			dev->poll_time_limit = true;
+			break;
 		}
 	}
 	raw_local_irq_disable();
 
-	current_clr_polling();
-
 	return index;
 }
 
-- 
2.42.1

