Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AE76BDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHATlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHATlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:41:16 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1919A8;
        Tue,  1 Aug 2023 12:41:13 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 2278a89ce16b93ab; Tue, 1 Aug 2023 21:41:12 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 77F806621DD;
        Tue,  1 Aug 2023 21:41:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [RFC/RFT][PATCH v1 1/2] cpuidle: teo: Do not call tick_nohz_get_sleep_length() upfront
Date:   Tue, 01 Aug 2023 21:39:42 +0200
Message-ID: <1870608.tdWV9SEqCh@kreacher>
In-Reply-To: <4511619.LvFx2qVVIh@kreacher>
References: <4511619.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
 uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrjhgvthgrnhdrphhutghhrghlshhkihesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the cost of calling tick_nohz_get_sleep_length() may increase
in the future, reorder the code in teo_select() so it first uses the
statistics to pick up a candidate idle state and applies the utilization
heuristic to it and only then calls tick_nohz_get_sleep_length() to
obtain the sleep length value and refine the selection if necessary.

This change by itself does not cause tick_nohz_get_sleep_length() to
be called less often, but it prepares the code for subsequent changes
that will do so.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |  102 ++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 59 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -306,15 +306,10 @@ static void teo_update(struct cpuidle_dr
 	cpu_data->total += PULSE;
 }
 
-static bool teo_time_ok(u64 interval_ns)
+static bool teo_state_ok(int i, struct cpuidle_driver *drv)
 {
-	return !tick_nohz_tick_stopped() || interval_ns >= TICK_NSEC;
-}
-
-static s64 teo_middle_of_bin(int idx, struct cpuidle_driver *drv)
-{
-	return (drv->states[idx].target_residency_ns +
-		drv->states[idx+1].target_residency_ns) / 2;
+	return !tick_nohz_tick_stopped() ||
+		drv->states[i].target_residency_ns >= TICK_NSEC;
 }
 
 /**
@@ -354,6 +349,7 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
+	ktime_t delta_tick = TICK_NSEC / 2;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
 	unsigned int idx_recent_sum = 0;
@@ -363,7 +359,6 @@ static int teo_select(struct cpuidle_dri
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
-	ktime_t delta_tick;
 	bool cpu_utilized;
 	s64 duration_ns;
 	int i;
@@ -374,9 +369,11 @@ static int teo_select(struct cpuidle_dri
 	}
 
 	cpu_data->time_span_ns = local_clock();
-
-	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-	cpu_data->sleep_length_ns = duration_ns;
+	/*
+	 * Set the expected sleep length to infinity in case of an early
+	 * return.
+	 */
+	cpu_data->sleep_length_ns = KTIME_MAX;
 
 	/* Check if there is any choice in the first place. */
 	if (drv->state_count < 2) {
@@ -384,11 +381,8 @@ static int teo_select(struct cpuidle_dri
 		goto out_tick;
 	}
 
-	if (!dev->states_usage[0].disable) {
+	if (!dev->states_usage[0].disable)
 		idx = 0;
-		if (drv->states[1].target_residency_ns > duration_ns)
-			goto out_tick;
-	}
 
 	cpu_utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
 	/*
@@ -398,7 +392,7 @@ static int teo_select(struct cpuidle_dri
 	 */
 	if (drv->state_count < 3 && cpu_utilized) {
 		/* The CPU is utilized, so assume a short idle duration. */
-		duration_ns = teo_middle_of_bin(0, drv);
+		duration_ns = drv->states[1].target_residency_ns / 2;
 		/*
 		 * If state 0 is enabled and it is not a polling one, select it
 		 * right away unless the scheduler tick has been stopped, in
@@ -408,7 +402,7 @@ static int teo_select(struct cpuidle_dri
 		 * anyway.
 		 */
 		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
-		    teo_time_ok(duration_ns)) || dev->states_usage[1].disable) {
+		    teo_state_ok(0, drv)) || dev->states_usage[1].disable) {
 			idx = 0;
 			goto out_tick;
 		}
@@ -417,13 +411,7 @@ static int teo_select(struct cpuidle_dri
 		goto end;
 	}
 
-	/*
-	 * Find the deepest idle state whose target residency does not exceed
-	 * the current sleep length and the deepest idle state not deeper than
-	 * the former whose exit latency does not exceed the current latency
-	 * constraint.  Compute the sums of metrics for early wakeup pattern
-	 * detection.
-	 */
+	/* Compute the sums of metrics for early wakeup pattern detection. */
 	for (i = 1; i < drv->state_count; i++) {
 		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
 		struct cpuidle_state *s = &drv->states[i];
@@ -439,19 +427,15 @@ static int teo_select(struct cpuidle_dri
 		if (dev->states_usage[i].disable)
 			continue;
 
-		if (idx < 0) {
-			idx = i; /* first enabled state */
-			idx0 = i;
-		}
-
-		if (s->target_residency_ns > duration_ns)
-			break;
+		if (idx < 0)
+			idx0 = i; /* first enabled state */
 
 		idx = i;
 
 		if (s->exit_latency_ns <= latency_req)
 			constraint_idx = i;
 
+		/* Save the sums for the current state. */
 		idx_intercept_sum = intercept_sum;
 		idx_hit_sum = hit_sum;
 		idx_recent_sum = recent_sum;
@@ -479,13 +463,11 @@ static int teo_select(struct cpuidle_dri
 	 * all of the deeper states, or the sum of the numbers of recent
 	 * intercepts over all of the states shallower than the candidate one
 	 * is greater than a half of the number of recent events taken into
-	 * account, the CPU is likely to wake up early, so find an alternative
-	 * idle state to select.
+	 * account, a shallower idle state is likely to be a better choice.
 	 */
 	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
 	alt_recent = idx_recent_sum > NR_RECENT / 2;
 	if (alt_recent || alt_intercepts) {
-		s64 first_suitable_span_ns = duration_ns;
 		int first_suitable_idx = idx;
 
 		/*
@@ -494,44 +476,39 @@ static int teo_select(struct cpuidle_dri
 		 * cases (both with respect to intercepts overall and with
 		 * respect to the recent intercepts only) in the past.
 		 *
-		 * Take the possible latency constraint and duration limitation
-		 * present if the tick has been stopped already into account.
+		 * Take the possible duration limitation present if the tick
+		 * has been stopped already into account.
 		 */
 		intercept_sum = 0;
 		recent_sum = 0;
 
 		for (i = idx - 1; i >= 0; i--) {
 			struct teo_bin *bin = &cpu_data->state_bins[i];
-			s64 span_ns;
 
 			intercept_sum += bin->intercepts;
 			recent_sum += bin->recent;
 
-			span_ns = teo_middle_of_bin(i, drv);
-
 			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
 			    (!alt_intercepts ||
 			     2 * intercept_sum > idx_intercept_sum)) {
-				if (teo_time_ok(span_ns) &&
-				    !dev->states_usage[i].disable) {
+				/*
+				 * Use the current state unless it is too
+				 * shallow or disabled, in which case take the
+				 * first enabled state that is deep enough.
+				 */
+				if (teo_state_ok(i, drv) &&
+				    !dev->states_usage[i].disable)
 					idx = i;
-					duration_ns = span_ns;
-				} else {
-					/*
-					 * The current state is too shallow or
-					 * disabled, so take the first enabled
-					 * deeper state with suitable time span.
-					 */
+				else
 					idx = first_suitable_idx;
-					duration_ns = first_suitable_span_ns;
-				}
+
 				break;
 			}
 
 			if (dev->states_usage[i].disable)
 				continue;
 
-			if (!teo_time_ok(span_ns)) {
+			if (!teo_state_ok(i, drv)) {
 				/*
 				 * The current state is too shallow, but if an
 				 * alternative candidate state has been found,
@@ -543,7 +520,6 @@ static int teo_select(struct cpuidle_dri
 				break;
 			}
 
-			first_suitable_span_ns = span_ns;
 			first_suitable_idx = i;
 		}
 	}
@@ -562,14 +538,22 @@ static int teo_select(struct cpuidle_dri
 	 * not sufficiently large.
 	 */
 	if (cpu_utilized) {
-		s64 span_ns;
+		i = teo_find_shallower_state(drv, dev, idx, KTIME_MAX, true);
+		if (teo_state_ok(i, drv))
+			idx = i;
+	}
 
-		i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
-		span_ns = teo_middle_of_bin(i, drv);
-		if (teo_time_ok(span_ns)) {
+	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+	cpu_data->sleep_length_ns = duration_ns;
+
+	/*
+	 * If the closest expected timer is before the terget residency of the
+	 * candidate state, a shallower one needs to be found.
+	 */
+	if (drv->states[idx].target_residency_ns > duration_ns) {
+		i = teo_find_shallower_state(drv, dev, idx, duration_ns, false);
+		if (teo_state_ok(i, drv))
 			idx = i;
-			duration_ns = span_ns;
-		}
 	}
 
 end:



