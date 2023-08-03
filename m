Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF77576F47F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjHCVMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHCVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:11:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01702D42;
        Thu,  3 Aug 2023 14:11:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 944377c858fec3cf; Thu, 3 Aug 2023 23:11:48 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 01AB766241A;
        Thu,  3 Aug 2023 23:11:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [RFT][PATCH v2 3/3] cpuidle: teo: Gather statistics regarding whether or not to stop the tick
Date:   Thu, 03 Aug 2023 23:11:40 +0200
Message-ID: <3258054.aeNJFYEL58@kreacher>
In-Reply-To: <5712331.DvuYhMxLoT@kreacher>
References: <5712331.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgdduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
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

Currently, if the target residency of the deepest idle state is less than
the tick period length, which is quite likely for HZ=100, and the deepest
idle state is about to be selected by the TEO idle governor, the decision
on whether or not to stop the scheduler tick is based entirely on the
time till the closest timer.  This is often insufficient, because timers
may not be in heavy use and there may be a plenty of other CPU wakeup
events between the deepest idle state's target residency and the closest
tick.

Allow the governor to count those events by making the deepest idle
state's bin effectively end at TICK_NSEC and introducing an additional
"bin" for collecting "hit" events (ie. the ones in which the measured
idle duration falls into the same bin as the time till the closest
timer) with idle duration values past TICK_NSEC.

This way the "intercepts" metric for the deepest idle state's bin
becomes nonzero in general, and so it can influence the decision on
whether or not to stop the tick possibly increasing the governor's
accuracy in that respect.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -192,6 +192,7 @@ struct teo_bin {
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
  * @next_recent_idx: Index of the next @recent_idx entry to update.
  * @recent_idx: Indices of bins corresponding to recent "intercepts".
+ * @tick_hits: Number of "hits" after TICK_NSEC.
  * @util_threshold: Threshold above which the CPU is considered utilized
  */
 struct teo_cpu {
@@ -201,6 +202,7 @@ struct teo_cpu {
 	unsigned int total;
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
+	unsigned int tick_hits;
 	unsigned long util_threshold;
 };
 
@@ -232,6 +234,7 @@ static void teo_update(struct cpuidle_dr
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int i, idx_timer = 0, idx_duration = 0;
+	s64 target_residency_ns;
 	u64 measured_ns;
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
@@ -272,7 +275,6 @@ static void teo_update(struct cpuidle_dr
 	 * fall into.
 	 */
 	for (i = 0; i < drv->state_count; i++) {
-		s64 target_residency_ns = drv->states[i].target_residency_ns;
 		struct teo_bin *bin = &cpu_data->state_bins[i];
 
 		bin->hits -= bin->hits >> DECAY_SHIFT;
@@ -280,6 +282,8 @@ static void teo_update(struct cpuidle_dr
 
 		cpu_data->total += bin->hits + bin->intercepts;
 
+		target_residency_ns = drv->states[i].target_residency_ns;
+
 		if (target_residency_ns <= cpu_data->sleep_length_ns) {
 			idx_timer = i;
 			if (target_residency_ns <= measured_ns)
@@ -295,6 +299,26 @@ static void teo_update(struct cpuidle_dr
 		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
 
 	/*
+	 * If the deepest state's target residency is below the tick length,
+	 * make a record of it to help teo_select() decide whether or not
+	 * to stop the tick.  This effectively adds an extra hits-only bin
+	 * beyond the last state-related one.
+	 */
+	if (target_residency_ns < TICK_NSEC) {
+		cpu_data->tick_hits -= cpu_data->tick_hits >> DECAY_SHIFT;
+
+		cpu_data->total += cpu_data->tick_hits;
+
+		if (TICK_NSEC <= cpu_data->sleep_length_ns) {
+			idx_timer = drv->state_count;
+			if (TICK_NSEC <= measured_ns) {
+				cpu_data->tick_hits += PULSE;
+				goto end;
+			}
+		}
+	}
+
+	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
@@ -309,6 +333,7 @@ static void teo_update(struct cpuidle_dr
 		cpu_data->recent_idx[i] = idx_duration;
 	}
 
+end:
 	cpu_data->total += PULSE;
 }
 
@@ -356,6 +381,7 @@ static int teo_select(struct cpuidle_dri
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	ktime_t delta_tick = TICK_NSEC / 2;
+	unsigned int tick_intercept_sum = 0;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
 	unsigned int idx_recent_sum = 0;
@@ -429,6 +455,8 @@ static int teo_select(struct cpuidle_dri
 		hit_sum += prev_bin->hits;
 		recent_sum += prev_bin->recent;
 
+		tick_intercept_sum = intercept_sum;
+
 		if (dev->states_usage[i].disable)
 			continue;
 
@@ -461,6 +489,8 @@ static int teo_select(struct cpuidle_dri
 		goto end;
 	}
 
+	tick_intercept_sum += cpu_data->state_bins[drv->state_count-1].intercepts;
+
 	/*
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
@@ -577,6 +607,15 @@ static int teo_select(struct cpuidle_dri
 			idx = i;
 	}
 
+	/*
+	 * If the selected state's target residency is below the tick length
+	 * and intercepts occurring before the tick length are the majority of
+	 * total wakeup events, do not stop the tick.
+	 */
+	if (drv->states[idx].target_residency_ns < TICK_NSEC &&
+	    tick_intercept_sum > cpu_data->total / 2 + cpu_data->total / 8)
+		duration_ns = TICK_NSEC / 2;
+
 end:
 	/*
 	 * Allow the tick to be stopped unless the selected state is a polling



