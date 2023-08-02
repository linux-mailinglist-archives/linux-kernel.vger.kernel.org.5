Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BE76CEB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjHBNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjHBNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:31:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B02690;
        Wed,  2 Aug 2023 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6U0TKuKXrlOoIUDQ5shVBrCtBNLJq3+WFZcswjHGIas=; b=jF3QA3R+FU2BVbcTtrdX7BmbsT
        kQjgCqDuI7Ao572IhkkUlGo37pjSWJJhXhZQYhD0b0U0HjS+O8JirD0sPl9cyOHe8DJwiYFELAHQM
        8Nv67xq9fV9gEhVxs5RutYYfcqujldqUK0jJn2KPHlO8cx44u/OOSP+PIMNL6p/5IszceRN5PSqXb
        gzZlKs7dpWYG7faIBj/w7W7Y1CeF+mkRAYaUNxpo6dOVKi+cyu6ea/HslbuD8Oq9R2IiylaC0i54D
        cyLvPWpCEk7VIL9rqH3tXCJRvgV8x5hvHBxtwHPGTF7edGAfxH45cEbj8vB25BeHNPe06W1DWU5zs
        B5iW5y3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRBwZ-00FxfA-1v;
        Wed, 02 Aug 2023 13:31:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C0AB3008C6;
        Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0527D2107D7E5; Wed,  2 Aug 2023 15:31:15 +0200 (CEST)
Message-ID: <20230802132925.755164086@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 15:24:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: [RFC][PATCH v2 4/5] cpuidle/teo: Avoid tick_nohz_next_event()
References: <20230802132431.254614419@infradead.org>
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

Use the new tick_get_sleep_length() call in conjunction with the new
TICK state to elide tick_nohz_next_event() when possible.

Specifically, start the state selection using the existing next timer
(tick or earlier). And only when state selection lands on the TICK
state ask for the NOHZ next timer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/governors/teo.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -139,6 +139,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/topology.h>
 #include <linux/tick.h>
+#include "../cpuidle.h"
 
 /*
  * The number of bits to shift the CPU's capacity by in order to determine
@@ -363,8 +364,7 @@ static int teo_select(struct cpuidle_dri
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
-	ktime_t delta_tick;
-	s64 duration_ns;
+	s64 duration_ns, tick_ns;
 	int i;
 
 	if (dev->last_state_idx >= 0) {
@@ -374,8 +374,7 @@ static int teo_select(struct cpuidle_dri
 
 	cpu_data->time_span_ns = local_clock();
 
-	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
-	cpu_data->sleep_length_ns = duration_ns;
+	duration_ns = tick_ns = tick_get_sleep_length(false);
 
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
@@ -407,6 +406,14 @@ static int teo_select(struct cpuidle_dri
 		if (s->target_residency_ns > duration_ns)
 			break;
 
+		if (s->target_residency_ns == SHORT_TICK_NSEC) {
+			/*
+			 * We hit the tick state, see if it makes sense to
+			 * disable the tick and go deeper still.
+			 */
+			duration_ns = tick_get_sleep_length(true);
+		}
+
 		idx = i;
 
 		if (s->exit_latency_ns <= latency_req)
@@ -417,6 +424,8 @@ static int teo_select(struct cpuidle_dri
 		idx_recent_sum = recent_sum;
 	}
 
+	cpu_data->sleep_length_ns = duration_ns;
+
 	/* Avoid unnecessary overhead. */
 	if (idx < 0) {
 		idx = 0; /* No states enabled, must use 0. */
@@ -531,8 +540,8 @@ static int teo_select(struct cpuidle_dri
 		 * that.
 		 */
 		if (idx > idx0 &&
-		    drv->states[idx].target_residency_ns > delta_tick)
-			idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
+		    drv->states[idx].target_residency_ns > tick_ns)
+			idx = teo_find_shallower_state(drv, dev, idx, tick_ns, false);
 	}
 
 	return idx;


