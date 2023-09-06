Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3939793726
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIFIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIFIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:30:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BAFCF0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T8Uuz6VyKLhtFP77+E/zROxsYYyhyJxlyyyKVMGBzJY=; b=RIiBY4flpF6/kJkKZouKKJGhnk
        8JSB5TKav6zthwd/vSqSodk331L7a8C7hp6wMwcBrMfnPvHv3iUC1JA6don6cUXe3UvcayDzWL2sD
        nPGEIFrl2CFXDbdThbsK3oLax3qL3N1fACYFzmYfGWFOaxgoM2DYAFrlAt0eumAIyCu19sfedtC4G
        xXGqibVDecCCeFCZdSsHnYkaAiP19cX2QI/vRzfBI5lgXMCu8Zv3SLdij9PnTyQmMt4uH3kLY9jz/
        3J3giyyt8tVqlukUIrytMjzoC8hWSo67pHfmaBISgsp7uFjSJrs2KXPBY0npBvGA+9mYjFWurNuvb
        SqU8aHTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdnv6-000gXn-JD; Wed, 06 Sep 2023 08:29:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D6D43003F2; Wed,  6 Sep 2023 10:29:52 +0200 (CEST)
Date:   Wed, 6 Sep 2023 10:29:52 +0200
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
Message-ID: <20230906082952.GB38741@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:24:40PM +0200, Daniel Bristot de Oliveira wrote:
> On 9/5/23 15:42, Peter Zijlstra wrote:
> > On Thu, Aug 31, 2023 at 10:28:57PM +0200, Daniel Bristot de Oliveira wrote:
> >> +void dl_server_start(struct sched_dl_entity *dl_se, int defer)
> >>  {
> >> +	if (dl_se->server_state != DL_SERVER_STOPPED) {
> >> +		WARN_ON_ONCE(!(on_dl_rq(dl_se) || dl_se->dl_throttled));
> >> +		return;
> >> +	}
> >> +
> >> +	if (defer) {
> >> +		/*
> >> +		 * Postpone the replenishment to the (next period - the execution time)

perhaps explicitly mention zero-laxity here, then we all know what is
meant, no?

> >> +		 *
> >> +		 * With this in place, we have two cases:
> >> +		 *
> >> +		 * On the absence of DL tasks:
> >> +		 *	The server will start at the replenishment time, getting
> >> +		 *	its runtime before now + period. This is the expected
> >> +		 *	throttling behavior.
> >> +		 *
> >> +		 * In the presense of DL tasks:
> >> +		 *	The server will be replenished, and then it will be
> >> +		 *	schedule according to EDF, not breaking SCHED_DEADLINE.
> >> +		 *
> >> +		 *	In the first cycle the server will be postponed at most
> >> +		 *	at period + period - runtime at most. But then the
> >> +		 *	server will receive its runtime/period.
> >> +		 *
> >> +		 *	The server will, however, run on top of any RT task, which
> >> +		 *	is the expected throttling behavior.
> >> +		 */
> >> +		dl_se->deadline = rq_clock(dl_se->rq) + dl_se->dl_period - dl_se->dl_runtime;
> > 
> > I was confused by this, but this is an instance of
> > replenish_dl_new_period(), where we explicitly do not preserve the
> > period.
> 
> yeah, it is two operations in one (so not straight forward). It sets
> the period as the now - runtime, so..

Right. I'll just attribute it to me being generally confused about
everything after holidays ;-)

The thing that tripped me was that the use of rq_clock() breaks
periodicy, except of course you want/need that when you start a new
activation.

> >> +		/* Zero the runtime */
> >> +		dl_se->runtime = 0;
> >> +		/* throttle the server */
> >> +		dl_se->dl_throttled = 1;
> 
> as the server is throttled, it will set the replenishing timer for now - runtime + period because
> of the deadline.

Yeah, it's a wee hack to move it to the zero-laxity point. I was
considering if it makes sense to push that down and make it available
for all DL tasks, but I'm not sure..

> > I'm thinking this is wrong -- ISTR there definite benefits to explicit
> > slack time scheduling, meaning the server should also run while DL tasks
> > are on.
> 
> I can add the check to enable it also in the presence of DL tasks, we just need
> to have consider that the dl server is a dl task as well when disabling.

Why not keep what was there, always run the thing when there's FAIR
tasks around? Or do you see severe overhead from running it with only
FAIR tasks on?

> It is a benefit because it will fix the case in which a CPU full of DL tasks
> (possible with global).
> 
> Additionally, running the server when there are only fair tasks
> > is mostly harmless, right? So why this change?
> 
> Rhe problem is that we never know when a RT one will arrive :-/
> 
> E.g., only fair tasks, server enabled. All fine :-) Then an RT arrives, and gets
> postponed by the server... RT people complaining (for those thinking on adding
> a server for RT, we will have a similar problem as we have with throttling today +
> DL has no fixed priority).

Well, the thing is, the moment you run DL tasks on that machine those RT
tasks will get delayed *anyway*. RT people need to stop pretending FIFO
is the highest class.

But yeah, I can see why they might get upset if the time is then used to
run FAIR tasks while their RT task gets to wait.

> We will still face the same problem with defferable server, and the example is the same,
> just with a shift in the RT arrival. e.g., only fair task for (server period - runtime),
> then the server gets enabled, and a 1us after the RT arrives and gets postponed... again.
> 
> So the need to enable it only after the dispatch of a kind of RT (or DL to be added)
> tasks that can cause starvation.
> 
> We could simplify it by enabling only on RT/DL arrival but... if there is nothing to
> starve... it is not needed anyways so less overhead avoiding the enqueue...

So one thing we could do is have update_curr_fair() decrement
fair_server's runtime and yield the period then it hits 0 (and capping
it at 0, not allowing it to go negative or so).

That way you only force the situation when FAIR hasn't had it's allotted
time this perio, and only for as much as to make up for the time it
lacks.

> > 
> > One of the benefits was -- IIRC, that we no longer need to subtract some
> > random margin from the reservation limit, but there were more I think.
> > 
> 
> We can simplify things because we can start ignoring the rt throttling limit when
> there is no need to throttle... like on grub (but, only after we remove the rt
> throttling).
> 
> Thoughts?

The moment the fair server is there (these patches) you should also kill
the throttling. It doesn't make sense to have both.

