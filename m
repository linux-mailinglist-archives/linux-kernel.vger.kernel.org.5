Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163697E5678
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjKHMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbjKHMoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:44:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F01BF0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=knxggHqPTlhd43d7Uw7Cyj/GXM5IL414IJsbF/Ox+MU=; b=gNX0r/2K22CNvAtxv8dRtl8Rw/
        /l2p7m0dg74Z77KdUFK4cpfpWd1rZW2cgVh4bHLYFT63I832kyeJ8SQoqDRgNHen/+wRB6o4T4BPL
        QXA0pjkv3f/tsRYcK7QSbQssSvaJPAV+asXxbUovcC1P/11nhWGt0EzhCO7w2qd5AZHiX5y8L8uCi
        cIPgBzsZtzQHOkB20AERxsp5gPbCsuy+spABhNOiHZTd1gJ+nMTxicThnpv6Cl8E8H+ziQwSP20bQ
        8pco5ZScLxtNEpV5LJEi2pl4nunkrLcTDokW9OUwlGcTEiRJWXx4Mw/TabUA5VrFjsVZnZOMP0v3Y
        W7jrgtUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0hua-0013dY-UB; Wed, 08 Nov 2023 12:44:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A0C730049D; Wed,  8 Nov 2023 13:44:01 +0100 (CET)
Date:   Wed, 8 Nov 2023 13:44:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:50:28PM +0100, Daniel Bristot de Oliveira wrote:
> > The code is not doing what I intended because I thought it was doing overload
> > control on the replenishment, but it is not (my bad).
> > 
> 
> I am still testing but... it is missing something like this (famous last words).
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1092ca8892e0..6e2d21c47a04 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -842,6 +842,8 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>   * runtime, or it just underestimated it during sched_setattr().
>   */
>  static int start_dl_timer(struct sched_dl_entity *dl_se);
> +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
> +
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
> @@ -852,9 +854,18 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	/*
>  	 * This could be the case for a !-dl task that is boosted.
>  	 * Just go with full inherited parameters.
> +	 *
> +	 * Or, it could be the case of a zerolax reservation that
> +	 * was not able to consume its runtime in background and
> +	 * reached this point with current u > U.
> +	 *
> +	 * In both cases, set a new period.
>  	 */
> -	if (dl_se->dl_deadline == 0)
> -		replenish_dl_new_period(dl_se, rq);
> +	if (dl_se->dl_deadline == 0 ||
> +		(dl_se->dl_zerolax_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
> +			dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
> +			dl_se->runtime = pi_of(dl_se)->dl_runtime;
> +	}
> 
>  	if (dl_se->dl_yielded && dl_se->runtime > 0)
>  		dl_se->runtime = 0;

Should we rather not cap the runtime, something like so?

Because the above also causes period drift, which we do not want.

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 58b542bf2893..1453a2cd0680 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -829,10 +829,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
  */
 static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
+	struct sched_dl_entity *pi_se = pi_of(dl_se);
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
+	u64 dl_runtime = pi_se->dl_runtime;
 
-	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
+	WARN_ON_ONCE(dl_runtime <= 0);
 
 	/*
 	 * This could be the case for a !-dl task that is boosted.
@@ -851,10 +853,13 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * arbitrary large.
 	 */
 	while (dl_se->runtime <= 0) {
-		dl_se->deadline += pi_of(dl_se)->dl_period;
-		dl_se->runtime += pi_of(dl_se)->dl_runtime;
+		dl_se->deadline += pi_se->dl_period;
+		dl_se->runtime += dl_runtime;
 	}
 
+	if (dl_se->zerolax && dl_se->runtime > dl_runtime)
+		dl_se->runtime = dl_runtime;
+
 	/*
 	 * At this point, the deadline really should be "in
 	 * the future" with respect to rq->clock. If it's
