Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06737F8635
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjKXWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjKXWct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:32:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8321BD2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:32:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12448C433CB;
        Fri, 24 Nov 2023 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700865172;
        bh=EVmYFcQRtRqs/jn3gEWSri/kyXx/B+VGrmgyGEWXJ1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNVRPsBEfcRPpE1NgeqTaUNReFI/47tRe7hMPfCPcbXIperxi5Nm8V6Y+qJ67BzzK
         UO5BUefTkpk6nSk4x9pTJHkFtsAGiX8CF+u00My6GTx/dqRC8f9ZKv8ALqUKxreiHp
         a90rE9LdX2/bKdtIZfqY52sRMmvZSO4Zd2YDyFx6tF72H14hjDGP5xDBalSWtNErcg
         iZIPsU5ZxOc6vbVycnLLq5hU0w6v0vAp23AtyxfvadzG3TEUZnZCevR9DsxS0G7PQO
         QBpnNBP+hyd5c2hNULOYFDTVkzaLnWCz6YZQ/PYvuoppl6rLYBEH0lrHKqvvsYTKFq
         6Nsxc4OF0NxqA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/7] cpuidle: s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
Date:   Fri, 24 Nov 2023 23:32:23 +0100
Message-ID: <20231124223226.24249-5-frederic@kernel.org>
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

In order to further distinguish software and hardware TIF_NEED_RESCHED
polling cpuidle states, rename CPUIDLE_FLAG_POLLING to
CPUIDLE_FLAG_POLLING_SOFT before introducing CPUIDLE_FLAG_POLLING_HARD
and tag mwait users with it.

This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
kinds of TIF_NEED_RESCHED polling states while keeping a necessary
distinction for the governors between software loops polling on
TIF_NEED_RESCHED and hardware monitored writes to thread flags.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/driver-api/pm/cpuidle.rst | 2 +-
 drivers/cpuidle/cpuidle-powernv.c       | 2 +-
 drivers/cpuidle/cpuidle-pseries.c       | 4 ++--
 drivers/cpuidle/governors/ladder.c      | 4 ++--
 drivers/cpuidle/governors/menu.c        | 8 ++++----
 drivers/cpuidle/governors/teo.c         | 8 ++++----
 drivers/cpuidle/poll_state.c            | 2 +-
 include/linux/cpuidle.h                 | 2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/pm/cpuidle.rst b/Documentation/driver-api/pm/cpuidle.rst
index d477208604b8..5ad10dad8033 100644
--- a/Documentation/driver-api/pm/cpuidle.rst
+++ b/Documentation/driver-api/pm/cpuidle.rst
@@ -192,7 +192,7 @@ governors for computations related to idle state selection:
 
 :c:member:`flags`
 	Flags representing idle state properties.  Currently, governors only use
-	the ``CPUIDLE_FLAG_POLLING`` flag which is set if the given object
+	the ``CPUIDLE_FLAG_POLLING_SOFT`` flag which is set if the given object
 	does not represent a real idle state, but an interface to a software
 	"loop" that can be used in order to avoid asking the processor to enter
 	any idle state at all.  [There are other flags used by the ``CPUIdle``
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..675b8eb81ebd 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -158,7 +158,7 @@ static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = snooze_loop,
-		.flags = CPUIDLE_FLAG_POLLING },
+		.flags = CPUIDLE_FLAG_POLLING_SOFT },
 };
 
 static int powernv_cpuidle_cpu_online(unsigned int cpu)
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 14db9b7d985d..4e08c9a39172 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -271,7 +271,7 @@ static struct cpuidle_state dedicated_states[NR_DEDICATED_STATES] = {
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = &snooze_loop,
-		.flags = CPUIDLE_FLAG_POLLING },
+		.flags = CPUIDLE_FLAG_POLLING_SOFT },
 	{ /* CEDE */
 		.name = "CEDE",
 		.desc = "CEDE",
@@ -290,7 +290,7 @@ static struct cpuidle_state shared_states[] = {
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = &snooze_loop,
-		.flags = CPUIDLE_FLAG_POLLING },
+		.flags = CPUIDLE_FLAG_POLLING_SOFT },
 	{ /* Shared Cede */
 		.name = "Shared Cede",
 		.desc = "Shared Cede",
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 8e9058c4ea63..a5f462b60d50 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -69,7 +69,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_idx = dev->last_state_idx;
-	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
+	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING_SOFT ? 1 : 0;
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	s64 last_residency;
 
@@ -133,7 +133,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev)
 {
 	int i;
-	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
+	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING_SOFT ? 1 : 0;
 	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
 	struct ladder_device_state *lstate;
 	struct cpuidle_state *state;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b96e3da0fedd..98ec067805b6 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -320,7 +320,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 * it right away and keep the tick running if state[0] is a
 		 * polling one.
 		 */
-		*stop_tick = !(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
+		*stop_tick = !(drv->states[0].flags & CPUIDLE_FLAG_POLLING_SOFT);
 		return 0;
 	}
 
@@ -365,7 +365,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 			 * Use a physical idle state, not busy polling, unless
 			 * a timer is going to trigger soon enough.
 			 */
-			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING_SOFT) &&
 			    s->exit_latency_ns <= latency_req &&
 			    s->target_residency_ns <= data->next_timer_ns) {
 				predicted_ns = s->target_residency_ns;
@@ -411,7 +411,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.
 	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING_SOFT) ||
 	     predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
 		*stop_tick = false;
 
@@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		 * duration predictor do a better job next time.
 		 */
 		measured_ns = 9 * MAX_INTERESTING / 10;
-	} else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING) &&
+	} else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING_SOFT) &&
 		   dev->poll_time_limit) {
 		/*
 		 * The CPU exited the "polling" state due to a time limit, so
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c59c5..f86e16d0ffac 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -354,7 +354,7 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
 
 	for (i = state_idx - 1; i >= 0; i--) {
 		if (dev->states_usage[i].disable ||
-				(no_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING))
+				(no_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING_SOFT))
 			continue;
 
 		state_idx = i;
@@ -426,7 +426,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 * all.  If state 1 is disabled, though, state 0 must be used
 		 * anyway.
 		 */
-		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING_SOFT) &&
 		    teo_state_ok(0, drv)) || dev->states_usage[1].disable) {
 			idx = 0;
 			goto out_tick;
@@ -584,7 +584,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * the current candidate state is low enough and skip the timers
 	 * check in that case too.
 	 */
-	if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+	if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING_SOFT) &&
 	    drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
 		goto out_tick;
 
@@ -616,7 +616,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * one or the expected idle duration is shorter than the tick period
 	 * length.
 	 */
-	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING_SOFT) &&
 	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
 		return idx;
 
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..a2fe173de117 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -57,6 +57,6 @@ void cpuidle_poll_state_init(struct cpuidle_driver *drv)
 	state->target_residency_ns = 0;
 	state->power_usage = -1;
 	state->enter = poll_idle;
-	state->flags = CPUIDLE_FLAG_POLLING;
+	state->flags = CPUIDLE_FLAG_POLLING_SOFT;
 }
 EXPORT_SYMBOL_GPL(cpuidle_poll_state_init);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..66b59868622c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -78,7 +78,7 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_NONE       	(0x00)
-#define CPUIDLE_FLAG_POLLING		BIT(0) /* polling state */
+#define CPUIDLE_FLAG_POLLING_SOFT		BIT(0) /* polling state */
 #define CPUIDLE_FLAG_COUPLED		BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP 	BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
-- 
2.42.1

