Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714DC767002
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjG1PBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjG1PBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:01:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156452115;
        Fri, 28 Jul 2023 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+Z8qBsQzscQ1mZHZVoaPDJfcq+No0YKyjdsder5ud9I=; b=W6oXjZ0aoO2yeDXfHR9eMXbO+u
        y6WhZVFJfLLShQxstyvRdHuQFwpGGFr1lzEFzmp8Viq9u2D+bJD03uZnSDxbqYk0zjRXli/f82YVo
        NVDGB4YEFXiaY9ioq2AtGBj6uxKPsigidnCMlsFNpsUqrZUMf7Qjti6ImiRnqFNotrc18sFYetz7+
        tAS9+N+rgvWXs4ASmOM9dMdQLldVUal+3ufTnGvlsbSURAZlfLaQCUA5fEgiCiT0DaC7nuUkDON+C
        ImKVn1td048fSTiINjIyTtv6/ifByiQLVLMbWGqmyjbvFTnNx7yOJqELMDl1tr48dl0xn8RhiNMbi
        lXcFOlGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPOxY-008ar0-NX; Fri, 28 Jul 2023 15:00:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D154308CC4;
        Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 235E12C8FCA8C; Fri, 28 Jul 2023 17:00:51 +0200 (CEST)
Message-ID: <20230728145808.902892871@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jul 2023 16:55:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
References: <20230728145515.990749537@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With cpuidle having added a TICK bucket, TEO will account all TICK and
longer idles there. This means we can now make an informed decision
about stopping the tick. If the sum of 'hit+intercepts' of all states
below the TICK bucket is more than 50%, it is most likely we'll not
reach the tick this time around either, so stopping the tick doesn't
make sense.

If we don't stop the tick, don't bother calling
tick_nohz_get_sleep_length() and assume duration is no longer than a
tick (could be improved to still look at the current pending time and
timers).

Since we have this extra state, remove the state_count based early
decisions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/governors/teo.c |   97 ++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 63 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -139,6 +139,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/topology.h>
 #include <linux/tick.h>
+#include "../cpuidle.h"
 
 /*
  * The number of bits to shift the CPU's capacity by in order to determine
@@ -197,7 +198,6 @@ struct teo_cpu {
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
 	unsigned long util_threshold;
-	bool utilized;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -276,11 +276,11 @@ static void teo_update(struct cpuidle_dr
 
 		cpu_data->total += bin->hits + bin->intercepts;
 
-		if (target_residency_ns <= cpu_data->sleep_length_ns) {
+		if (target_residency_ns <= cpu_data->sleep_length_ns)
 			idx_timer = i;
-			if (target_residency_ns <= measured_ns)
-				idx_duration = i;
-		}
+
+		if (target_residency_ns <= measured_ns)
+			idx_duration = i;
 	}
 
 	i = cpu_data->next_recent_idx++;
@@ -362,11 +362,12 @@ static int teo_select(struct cpuidle_dri
 	unsigned int recent_sum = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
+	unsigned int tick_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
 	ktime_t delta_tick;
-	s64 duration_ns;
+	s64 duration_ns = TICK_NSEC;
 	int i;
 
 	if (dev->last_state_idx >= 0) {
@@ -376,36 +377,26 @@ static int teo_select(struct cpuidle_dri
 
 	cpu_data->time_span_ns = local_clock();
 
-	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-	cpu_data->sleep_length_ns = duration_ns;
+	/* Should we stop the tick? */
+	for (i = 1; i < drv->state_count; i++) {
+		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
+		struct cpuidle_state *s = &drv->states[i];
 
-	/* Check if there is any choice in the first place. */
-	if (drv->state_count < 2) {
-		idx = 0;
-		goto end;
-	}
-	if (!dev->states_usage[0].disable) {
-		idx = 0;
-		if (drv->states[1].target_residency_ns > duration_ns)
-			goto end;
-	}
+		tick_sum += prev_bin->intercepts;
+		tick_sum += prev_bin->hits;
 
-	cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
-	/*
-	 * If the CPU is being utilized over the threshold and there are only 2
-	 * states to choose from, the metrics need not be considered, so choose
-	 * the shallowest non-polling state and exit.
-	 */
-	if (drv->state_count < 3 && cpu_data->utilized) {
-		for (i = 0; i < drv->state_count; ++i) {
-			if (!dev->states_usage[i].disable &&
-			    !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
-				idx = i;
-				goto end;
-			}
-		}
+		if (s->target_residency_ns >= SHORT_TICK_NSEC)
+			break;
 	}
 
+	if (2*tick_sum > cpu_data->total)
+		*stop_tick = false;
+
+	/* If we do stop the tick, ask for the next timer. */
+	if (*stop_tick)
+		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+	cpu_data->sleep_length_ns = duration_ns;
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -446,13 +437,13 @@ static int teo_select(struct cpuidle_dri
 		idx_recent_sum = recent_sum;
 	}
 
-	/* Avoid unnecessary overhead. */
-	if (idx < 0) {
-		idx = 0; /* No states enabled, must use 0. */
-		goto end;
-	} else if (idx == idx0) {
-		goto end;
-	}
+	/* No states enabled, must use 0 */
+	if (idx < 0)
+		return 0;
+
+	/* No point looking for something shallower than the first enabled state */
+	if (idx == idx0)
+		return idx;
 
 	/*
 	 * If the sum of the intercepts metric for all of the idle states
@@ -541,29 +532,9 @@ static int teo_select(struct cpuidle_dri
 	 * If the CPU is being utilized over the threshold, choose a shallower
 	 * non-polling state to improve latency
 	 */
-	if (cpu_data->utilized)
+	if (teo_cpu_is_utilized(dev->cpu, cpu_data))
 		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
 
-end:
-	/*
-	 * Don't stop the tick if the selected state is a polling one or if the
-	 * expected idle duration is shorter than the tick period length.
-	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
-		*stop_tick = false;
-
-		/*
-		 * The tick is not going to be stopped, so if the target
-		 * residency of the state to be returned is not within the time
-		 * till the closest timer including the tick, try to correct
-		 * that.
-		 */
-		if (idx > idx0 &&
-		    drv->states[idx].target_residency_ns > delta_tick)
-			idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
-	}
-
 	return idx;
 }
 


