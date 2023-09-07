Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8B79736B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjIGPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbjIGPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E31BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RjXBaYQlxoVEsb5ze9snhwcx64pFZvH1DMGKyQslckM=; b=vQQ7b0b7Im7JdkC91txBI9PoFR
        taZUmWninr2D15OkDBgioMMO2ZXOVVGOtkGK9yS5OeAIyVu7TxYN+wi3KkPjUGKyTf4GnhU2fWDdf
        CZqrKTMjzMnjZpAsbmjz4saaKL8Rij921qQ1tfaYphb3KSNbUJxJJVBv1iGhgVtprmxPEbGscewcq
        fImPGKJsDGGF/tNHO/ZgL3PF++5jB+mB/vksS12FtGC9v/cbdn/om3w/tJo4IoRp/D5KOPgLc8+uG
        XwQ9Z+nTQWu9Q9H0eWlV5ZDpO76xPQ+kPUetpgV+dB8uFibzbi5qtta6W4eGiw1Bg5lYmpR+33FP7
        eqNd0DPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeA30-009PAU-2v; Thu, 07 Sep 2023 08:07:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41721300687; Thu,  7 Sep 2023 10:07:29 +0200 (CEST)
Date:   Thu, 7 Sep 2023 10:07:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Message-ID: <20230907080729.GA16872@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:

> > Yeah, it's a wee hack to move it to the zero-laxity point. I was
> > considering if it makes sense to push that down and make it available
> > for all DL tasks, but I'm not sure..
> 
> It might be useful in the future, like when DL dominates all other schedulers, so
> we can have a way to schedule a deferred work, like kworkers... :-) But it might be
> too early for that..

So... that scheme I was pushing where we unconditionally decrement
fair_server.dl_runtime from update_curr_fair(), that relies on it being
a proper zero-laxity scheduler, and doesn't work with the proposed defer
hack.

That is, it relies on dl_runtime > 0 during throttle, and you explicitly
set it 0.

Now, I've not looked at all this code in detail in a minute, but would
not something like the below work?

AFAICT the regular dl_task_timer() callback works to make it go, because
replenish will see positive runtime (or not, when already consumed) and
DTRT.


Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -657,6 +657,7 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_zerolax        : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
Index: linux-2.6/kernel/sched/deadline.c
===================================================================
--- linux-2.6.orig/kernel/sched/deadline.c
+++ linux-2.6/kernel/sched/deadline.c
@@ -895,6 +895,16 @@ static void replenish_dl_entity(struct s
 		dl_se->dl_yielded = 0;
 	if (dl_se->dl_throttled)
 		dl_se->dl_throttled = 0;
+
+	/*
+	 * If this is a zero-laxity task, and we're before the zero-laxity
+	 * point, throttle it.
+	 */
+	if (dl_se->dl_zerolax &&
+	    dl_time_before(dl_se->deadline - dl_se->runtime, rq_clock(rq))) {
+		if (!is_dl_boosted(dl_se) && start_dl_timer(dl_se))
+			dl_se->dl_throttled = 1;
+	}
 }
 
 /*
@@ -1078,7 +1088,12 @@ static int start_dl_timer(struct sched_d
 	 * that it is actually coming from rq->clock and not from
 	 * hrtimer's time base reading.
 	 */
-	act = ns_to_ktime(dl_next_period(dl_se));
+	if (dl_se->dl_zerolax && !dl_se->dl_throttled) {
+		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
+	} else {
+		act = ns_to_ktime(dl_next_period(dl_se));
+	}
+
 	now = hrtimer_cb_get_time(timer);
 	delta = ktime_to_ns(now) - rq_clock(rq);
 	act = ktime_add_ns(act, delta);
@@ -1794,6 +1809,13 @@ enqueue_dl_entity(struct sched_dl_entity
 		setup_new_dl_entity(dl_se);
 	}
 
+	/*
+	 * If we are still throttled, eg. we got replenished but are a
+	 * zero-laxity task and still got to wait, don't enqueue.
+	 */
+	if (dl_se->dl_throttled)
+		return;
+
 	__enqueue_dl_entity(dl_se);
 }
 
