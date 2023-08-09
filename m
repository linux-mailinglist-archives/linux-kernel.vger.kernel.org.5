Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B16776316
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjHIOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHIOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:53:36 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D918DC;
        Wed,  9 Aug 2023 07:53:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3ac8deb2c7e4b6a8; Wed, 9 Aug 2023 16:53:32 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 155F46625DB;
        Wed,  9 Aug 2023 16:53:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFT] [PATCH v1] cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases
Date:   Wed, 09 Aug 2023 16:53:31 +0200
Message-ID: <5708364.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrleeggdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
 lhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrjhgvthgrnhdrphhutghhrghlshhkihesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the cost of calling tick_nohz_get_sleep_length() may increase
in the future, reorder the code in menu_select() so it first uses the
statistics to determine the expected idle duration.  If that value is
higher than RESIDENCY_THRESHOLD_NS, tick_nohz_get_sleep_length() will
be called to obtain the time till the closest timer and refine the
idle duration prediction if necessary.

This causes the governor to always take the full overhead of
get_typical_interval() with the assumption that the cost will be
amortized by skipping the tick_nohz_get_sleep_length() call in the
cases when the predicted idle duration is relatively very small.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a counterpart of the following two teo commits:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-cpuidle-teo&id=06b80d45d3f94b1bbd3ee02bf3e007f55ed3e120
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-cpuidle-teo&id=57c51179c203de17cf17e357d0e56c04f5e2494a

and it is based on top of

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm-cpuidle-teo&id=9ebff7f2e77dc1cf7a143f6eee2852b6380096e5

Later today I will expose a git branch with all of the recent cpuidle governor
changes related to the tick_nohz_get_sleep_length() avoidance.

---
 drivers/cpuidle/governors/gov.h  |   14 ++++++++
 drivers/cpuidle/governors/menu.c |   66 +++++++++++++++++++++------------------
 drivers/cpuidle/governors/teo.c  |    2 +
 3 files changed, 53 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -19,6 +19,8 @@
 #include <linux/sched/stat.h>
 #include <linux/math64.h>
 
+#include "gov.h"
+
 #define BUCKETS 12
 #define INTERVAL_SHIFT 3
 #define INTERVALS (1UL << INTERVAL_SHIFT)
@@ -166,8 +168,7 @@ static void menu_update(struct cpuidle_d
  * of points is below a threshold. If it is... then use the
  * average of these 8 points as the estimated value.
  */
-static unsigned int get_typical_interval(struct menu_device *data,
-					 unsigned int predicted_us)
+static unsigned int get_typical_interval(struct menu_device *data)
 {
 	int i, divisor;
 	unsigned int min, max, thresh, avg;
@@ -195,13 +196,6 @@ again:
 		}
 	}
 
-	/*
-	 * If the result of the computation is going to be discarded anyway,
-	 * avoid the computation altogether.
-	 */
-	if (min >= predicted_us)
-		return UINT_MAX;
-
 	if (divisor == INTERVALS)
 		avg = sum >> INTERVAL_SHIFT;
 	else
@@ -267,7 +261,6 @@ static int menu_select(struct cpuidle_dr
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
-	unsigned int predicted_us;
 	u64 predicted_ns;
 	u64 interactivity_req;
 	unsigned int nr_iowaiters;
@@ -279,16 +272,41 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	/* determine the expected residency time, round up */
-	delta = tick_nohz_get_sleep_length(&delta_tick);
-	if (unlikely(delta < 0)) {
-		delta = 0;
-		delta_tick = 0;
-	}
-	data->next_timer_ns = delta;
-
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
-	data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
+
+	/* Find the shortest expected idle interval. */
+	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
+	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
+		unsigned int timer_us;
+
+		/* Determine the time till the closest timer. */
+		delta = tick_nohz_get_sleep_length(&delta_tick);
+		if (unlikely(delta < 0)) {
+			delta = 0;
+			delta_tick = 0;
+		}
+
+		data->next_timer_ns = delta;
+		data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
+
+		/* Round up the result for half microseconds. */
+		timer_us = div_u64((RESOLUTION * DECAY * NSEC_PER_USEC) / 2 +
+					data->next_timer_ns *
+						data->correction_factor[data->bucket],
+				   RESOLUTION * DECAY * NSEC_PER_USEC);
+		/* Use the lowest expected idle interval to pick the idle state. */
+		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
+	} else {
+		/*
+		 * Because the next timer event is not going to be determined
+		 * in this case, assume that without the tick the closest timer
+		 * will be in distant future and that the closest tick will occur
+		 * after 1/2 of the tick period.
+		 */
+		data->next_timer_ns = KTIME_MAX;
+		delta_tick = TICK_NSEC / 2;
+		data->bucket = which_bucket(KTIME_MAX, nr_iowaiters);
+	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
 	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
@@ -303,16 +321,6 @@ static int menu_select(struct cpuidle_dr
 		return 0;
 	}
 
-	/* Round up the result for half microseconds. */
-	predicted_us = div_u64(data->next_timer_ns *
-			       data->correction_factor[data->bucket] +
-			       (RESOLUTION * DECAY * NSEC_PER_USEC) / 2,
-			       RESOLUTION * DECAY * NSEC_PER_USEC);
-	/* Use the lowest expected idle interval to pick the idle state. */
-	predicted_ns = (u64)min(predicted_us,
-				get_typical_interval(data, predicted_us)) *
-				NSEC_PER_USEC;
-
 	if (tick_nohz_tick_stopped()) {
 		/*
 		 * If the tick is already stopped, the cost of possible short
Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -140,6 +140,8 @@
 #include <linux/sched/topology.h>
 #include <linux/tick.h>
 
+#include "gov.h"
+
 /*
  * The number of bits to shift the CPU's capacity by in order to determine
  * the utilized threshold.
Index: linux-pm/drivers/cpuidle/governors/gov.h
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpuidle/governors/gov.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Common definitions for cpuidle governors. */
+
+#ifndef __CPUIDLE_GOVERNOR_H
+#define __CPUIDLE_GOVERNOR_H
+
+/*
+ * Idle state target residency threshold used for deciding whether or not to
+ * check the time till the closest expected timer event.
+ */
+#define RESIDENCY_THRESHOLD_NS	(15 * NSEC_PER_USEC)
+
+#endif /* __CPUIDLE_GOVERNOR_H */



