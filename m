Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679D76404E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGZUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGZUKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F91272B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hfpF0MlIi5qyQQVYwuMI3LPZ43WeU1gqs6bIcz+hgDo=; b=cuivzJkq6IxDKNOrSzDFBcQPc+
        uP2d7gDwExZOVy7cEA0WvpYQqFnbr6s2WtbDv0DokrMaOUPjblwZH2zfU2cpkVKHTLaywLANBZUoI
        wpHhzj4c1D22SFseQ6EY53BdI77csx747R0hTCj700wREDBlEOaIi7dQJLBIVpqIS4lU4Cw7c/69r
        4e8SSqpVOeu9r/MbK0cublMW1MzjQwNC6k+1duAWz4j6OcNlGUkVbNQrve4AAAoU4iW1Yi05JzPAB
        5JUe5DN1b7yh8Hv3vPn451tzjudOk+LS9SEgPczY7/OkypsFfP7sDRUqE8G6DiLtekUaDIm/6NCSg
        j4t4VS4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOkpR-006oNQ-IH; Wed, 26 Jul 2023 20:09:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F494300164;
        Wed, 26 Jul 2023 22:09:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3719A21BD3681; Wed, 26 Jul 2023 22:09:49 +0200 (CEST)
Date:   Wed, 26 Jul 2023 22:09:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Message-ID: <20230726200949.GA3869356@hirez.programming.kicks-ass.net>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <f84ecbee-cb2a-d574-422-b357f0d4ca2@linutronix.de>
 <CAJZ5v0hLprrBhfqMRUhStvmm3D_xaSLxmNOYB4sfhLSzLYeR-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hLprrBhfqMRUhStvmm3D_xaSLxmNOYB4sfhLSzLYeR-w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:30:01PM +0200, Rafael J. Wysocki wrote:

> > - The governors teo and menu do the tick_nohz_next_event() check even if
> >   the CPU is fully loaded and but the check is not for free.
> 
> Let me have a loot at teo in that respect.
> 
> The problem is when tick_nohz_get_sleep_length() should not be called.
> The easy case is when the governor would select the shallowest idle
> state without taking it into account, but what about the deeper ones?
> I guess this depends on the exit latency of the current candidate idle
> state, but what exit latency would be low enough?  I guess 2 us would
> be fine, but what about 10 us, or even 20 us for that matter?

The patch I send here:

  https://lkml.kernel.org/r/20230726164958.GV38236@hirez.programming.kicks-ass.net

(which was stuck in a mailqueue :/) tries to address that.

Additionally, I think we can do something like this on top of all that,
stop going deeper when 66% of wakeups is at or below the current state.


--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -362,6 +362,7 @@ static int teo_select(struct cpuidle_dri
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
 	unsigned int tick_sum = 0;
+	unsigned int thresh_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
@@ -396,6 +397,8 @@ static int teo_select(struct cpuidle_dri
 		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
+	thresh_sum = 2 * cpu_data->total / 3; /* 66% */
+
 	/*
 	 * Find the deepest idle state whose target residency does not exceed
 	 * the current sleep length and the deepest idle state not deeper than
@@ -426,6 +429,9 @@ static int teo_select(struct cpuidle_dri
 		if (s->target_residency_ns > duration_ns)
 			break;
 
+		if (intercept_sum + hit_sum > thresh_sum)
+			break;
+
 		idx = i;
 
 		if (s->exit_latency_ns <= latency_req)
