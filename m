Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72E764008
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGZTzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGZTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:55:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138D2D71
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vn0i/JBWfk9tGY5FR6jOFAnRknE2zxE4bTcx/jW7l4U=; b=bqn/Z267Z+jffkewSP+VRgDJ+z
        oUrtQLRGcOg3Q9MOJtCU8tDRcqw1/wn00XrUONnhzU52gbBjWx+MxDNjl4EEs8DmgDaEAKsOGKpDl
        SKXiR2vurLSMwyuTkAY0vNOQfstluPSKEXwBPQv5gPcPa93F3LQ7QLWjnkJwxCW16nDIPQ9YQoMSm
        Jbw5A8XL1q5wUX5L6DPAhMkeXKvO0jujSK9ceFIsaLUFXcUfXCnc0yILMeu5sDIrjUL6YXfJ5Cemj
        Ehes/eO+vpzg4YPMjW8sidj9ua72Ch9V2RIyQfawzlNj3SRnbWZ+mMgz6WwATbw8T7yhOwQD4cc5J
        13gtVkBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOkao-005ynY-1Y;
        Wed, 26 Jul 2023 19:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 676F23006C6;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 137C020297BBD; Wed, 26 Jul 2023 18:49:58 +0200 (CEST)
Date:   Wed, 26 Jul 2023 18:49:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        g@hirez.programming.kicks-ass.net
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <20230726164958.GV38236@hirez.programming.kicks-ass.net>
References: <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
 <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
 <20230726161432.GW4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726161432.GW4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:14:32PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 26, 2023 at 05:53:46PM +0200, Rafael J. Wysocki wrote:
> 
> > > > That means we don't track nearly enough data to reliably tell anything
> > > > about disabling the tick or not. We should have at least one bucket
> > > > beyond TICK_NSEC for this.
> > >
> > > Quite likely.
> > 
> > So the reasoning here was that those additional bins would not be
> > necessary for idle state selection, but the problem of whether or not
> > to stop the tick is kind of separate from the idle state selection
> > problem if the target residency values for all of the idle states are
> > relatively short.  And so it should be addressed separately which
> > currently it is not.  Admittedly, this is a mistake.
> 
> Right, the C state buckets are enough to pick a state, but not to handle
> the tick thing.
> 
> The below hack boots on my ivb-ep with extra (disabled) states. Now let
> me go hack up teo to make use of that.
> 
> name		residency
> 
> POLL		0
> C1              1
> C1E             80
> C3              156
> C6              300
> TICK            1000
> POST-TICK       2000
> 

builds and boots, futher untested -- I need to see to dinner.

The idea is that teo_update() should account to the highest state if
measured_ns is 'large'.

Then, then the tick is on, see if the majority (50%) of the
hit+intercepts are below the TICK threshold, if so, don't stop the tick
and assume duration_ns = TICK_NSEC -- iow. don't call
tick_nohz_get_sleep_length().

I'll check if the below code actually does as intended once the loonies
are in bed.


---

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 987fc5f3997d..362470c8c273 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -197,7 +197,6 @@ struct teo_cpu {
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
 	unsigned long util_threshold;
-	bool utilized;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -227,7 +226,7 @@ static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
 static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i, idx_timer = 0, idx_duration = 0;
+	int i, idx_timer = 0, idx_duration = drv->state_count-1;
 	u64 measured_ns;
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
@@ -362,11 +361,12 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
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
@@ -376,36 +376,26 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-	cpu_data->sleep_length_ns = duration_ns;
+	if (!tick_nohz_tick_stopped()) {
+		for (i = 1; i < drv->state_count; i++) {
+			struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
+			struct cpuidle_state *s = &drv->states[i];
 
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
+			tick_sum += prev_bin->intercepts;
+			tick_sum += prev_bin->hits;
 
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
+			if (s->target_residency_ns >= TICK_NSEC)
+				break;
 		}
+
+		if (2*tick_sum > cpu_data->total)
+			*stop_tick = false;
 	}
 
+	if (*stop_tick)
+		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+	cpu_data->sleep_length_ns = duration_ns;
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -541,7 +531,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * If the CPU is being utilized over the threshold, choose a shallower
 	 * non-polling state to improve latency
 	 */
-	if (cpu_data->utilized)
+	if (teo_cpu_is_utilized(dev->cpu, cpu_data))
 		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
 
 end:
@@ -549,8 +539,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.
 	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
+	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) || !*stop_tick) {
 		*stop_tick = false;
 
 		/*
