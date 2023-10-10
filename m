Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEBC7BF987
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjJJLTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:19:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3894
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:19:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698B3C433C7;
        Tue, 10 Oct 2023 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936746;
        bh=zU0LXqhZFVW275Flvqu9nIJkeJ5BNN719MMdwkLYr1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mswsa8DRMtWdrYZ3R1nvq+cv5oz6bCYZxRuOorvv3uqq14G102EW9lfZ+1wbOr0Lg
         iz1xn3pOvNVtYg8QfS2fnnTWWGXr+dQ5vZw4Xf6W0/IYdDEPGkNzmU9vTd8QopQ24q
         WUrJfG4BdvUhipiiHcbqpaT8ggfAuj+cE0KSV2DeOTN64SSLg6WgGb8BsegEJfnb6d
         OEEfVxO4OFPL0S3uTeDJv1mQgWodS+WHNH5ZnmPp85xDo/+MKg755/8TqtywRI+YGf
         8KdYkCYPfBzMESdhVTQ46CbMSYHEHLIB/U4/k/uvSeYvSApD5PX2Xg/tHmIAZcd3Uz
         AsWKpT+JH1Zsg==
Date:   Tue, 10 Oct 2023 13:19:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 08/25] timer: Rework idle logic
Message-ID: <ZSUzJpeT86pQ8YcY@lothringen>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-9-anna-maria@linutronix.de>
 <878r8bphn6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r8bphn6.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:15:09AM +0200, Thomas Gleixner wrote:
> On Wed, Oct 04 2023 at 14:34, Anna-Maria Behnsen wrote:
> >  
> > -	if (time_before_eq(nextevt, basej)) {
> > -		expires = basem;
> > -		base->is_idle = false;
> > -	} else {
> > -		if (base->timers_pending)
> > -			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
> > -		/*
> > -		 * If we expect to sleep more than a tick, mark the base idle.
> > -		 * Also the tick is stopped so any added timer must forward
> > -		 * the base clk itself to keep granularity small. This idle
> > -		 * logic is only maintained for the BASE_STD base, deferrable
> > -		 * timers may still see large granularity skew (by design).
> > -		 */
> > -		if ((expires - basem) > TICK_NSEC)
> > -			base->is_idle = true;
> > +	/*
> > +	 * Base is idle if the next event is more than a tick away. Also
> > +	 * the tick is stopped so any added timer must forward the base clk
> > +	 * itself to keep granularity small. This idle logic is only
> > +	 * maintained for the BASE_STD base, deferrable timers may still
> > +	 * see large granularity skew (by design).
> > +	 */
> > +	base->is_idle = time_after(nextevt, basej + 1);
> 
> This is wrongly ordered. base->is_idle must be updated _after_
> evaluating base->timers_pending because the below can change nextevt,
> no?
> 
> > +	if (base->timers_pending) {
> > +		/* If we missed a tick already, force 0 delta */
> > +		if (time_before(nextevt, basej))
> > +			nextevt = basej;
> > +		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;

I suspect it doesn't matter in pratice: base->is_idle will remain false
if it's before/equal jiffies.

Still it hurts the eyes so I agree the re-ordering should happen here and
this will even simplify a bit the next patch.

Thanks.


> Thanks,
> 
>         tglx
