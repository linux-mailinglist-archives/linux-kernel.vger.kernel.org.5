Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F6E7BBCBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjJFQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjJFQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:32:19 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13413A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:32:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso95530539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696609937; x=1697214737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8G0hEi3sViDEeMdUucLIOFGKXB5eQCr7rlPFWn6W/Zw=;
        b=qOMaAnd+zGrQWM+6HK4Bkq+fR5sM9nfU4flBGlosdFX9V0UrkObxrHPOLdJHQG0DV/
         DJmyjz0hibcU4+AHHNSVYB+ET8rff2zOCxgeQ6maeEEFx/y/QH3aG8UtFvx97t8NXrFe
         HxOZI71qeqTOLtXnxR+ZPJDLr3Kf2NImiydGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696609937; x=1697214737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G0hEi3sViDEeMdUucLIOFGKXB5eQCr7rlPFWn6W/Zw=;
        b=mEEJYENRs5Btnb3XTIaOmGrspYK9vW1vXAzlIiAlBL9B0JDsoAwrmG3enQ/RH+XQ9m
         IyILresfM+WcS5bjPi4bRrmpww3X8+ZHrLS85nLq2V8/04n06+TOWIEPLPFISCzoitpQ
         Zgp6XG7taRmHF/c1wzzdEBdmkOd8tHPf47Fz5mDrRPbvkNmuNcE1WuTCIDx4F7PmUfcY
         Y8lEHnLlvetxm6KwaXuNVS1LZFamSgVrbJmyFr0wHcGKGa2f109/IltAevOWQrEYkPAl
         7AAn4RBtVmNN2B1YLnTuiL7Tcz1T6wAyWgFLS0pwrlalM8xEpYkfatUu3s/RJBLbxAjR
         9h2w==
X-Gm-Message-State: AOJu0Yz7TvGd59JCpBATrcRPNe9s+D1acPE0hiHFPP2AYHrFCvHt1sbz
        1sLZt82tLKfKOQTN6gTvUlMJ6Q==
X-Google-Smtp-Source: AGHT+IFQQFK/TIXJRJp6rsw2KqctNYY4KVzolM8CYRKzrezzAvND5v7pAAiO6W3pU8etkBGtmCl7XQ==
X-Received: by 2002:a5d:9946:0:b0:790:96ab:785 with SMTP id v6-20020a5d9946000000b0079096ab0785mr9840853ios.7.1696609937256;
        Fri, 06 Oct 2023 09:32:17 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id u26-20020a02cbda000000b0042b4f1c08desm489363jaq.27.2023.10.06.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:32:16 -0700 (PDT)
Date:   Fri, 6 Oct 2023 16:32:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
Message-ID: <20231006163216.GA2188081@google.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <ZR/mvd8Uw8PG+jx0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/mvd8Uw8PG+jx0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:51:41PM +0200, Ingo Molnar wrote:
> 
> * Joel Fernandes (Google) <joel@joelfernandes.org> wrote:
> 
> > From: Vineeth Pillai <vineethrp@google.com>
> > 
> > Whenever a CPU stops its tick, it now requires another idle CPU to handle the
> > balancing for it because it can't perform its own periodic load balancing.
> > This means it might need to update 'nohz.next_balance' to 'rq->next_balance' if
> > the upcoming nohz-idle load balancing is too distant in the future. This update
> > process is done by triggering an ILB, as the general ILB handler
> > (_nohz_idle_balance) that manages regular nohz balancing also refreshes
> > 'nohz.next_balance' by looking at the 'rq->next_balance' of all other idle CPUs
> > and selecting the smallest value.
> > 

[...snip...]

> >  kernel/sched/fair.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb225921bbca..2ece55f32782 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
> >  	/*
> >  	 * Ensures that if nohz_idle_balance() fails to observe our
> >  	 * @idle_cpus_mask store, it must observe the @has_blocked
> > -	 * and @needs_update stores.
> > +	 * stores.
> >  	 */
> >  	smp_mb__after_atomic();
> >  
> >  	set_cpu_sd_state_idle(cpu);
> >  
> > -	WRITE_ONCE(nohz.needs_update, 1);
> >  out:
> >  	/*
> >  	 * Each time a cpu enter idle, we assume that it has blocked load and
> > @@ -11945,21 +11944,25 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> >  }
> >  
> >  /*
> > - * Check if we need to run the ILB for updating blocked load before entering
> > - * idle state.
> > + * Check if we need to run the ILB for updating blocked load and/or updating
> > + * nohz.next_balance before entering idle state.
> >   */
> >  void nohz_run_idle_balance(int cpu)
> >  {
> >  	unsigned int flags;
> >  
> > -	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> > +	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> > +
> > +	if (!flags)
> > +		return;
> >  
> >  	/*
> >  	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
> >  	 * (ie NOHZ_STATS_KICK set) and will do the same.
> >  	 */
> > -	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> > -		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> > +	if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> > +	    !need_resched())
> > +		_nohz_idle_balance(cpu_rq(cpu), flags);
> >  }
> >  
> >  static void nohz_newidle_balance(struct rq *this_rq)
> > @@ -11977,6 +11980,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >  	if (this_rq->avg_idle < sysctl_sched_migration_cost)
> >  		return;
> >  
> > +	/* If rq->next_balance before nohz.next_balance, trigger ILB */
> > +	if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance)))
> > +		atomic_or(NOHZ_NEXT_KICK, nohz_flags(this_cpu));
> > +
> >  	/* Don't need to update blocked load of idle CPUs*/
> >  	if (!READ_ONCE(nohz.has_blocked) ||
> >  	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> 
> Ok, judging by your IPI reduction numbers this is definitely an 
> optimization we want to do.

Great, thanks.

> The patch does make _nohz_idle_balance() run more parallel, as previously 
> it would be generally run by the first-idle CPU in nohz.idle_cpus_mask (at 
> least for next_balance updates), but I think it's still SMP-safe, as all 
> key data structure updates are already rq-locked AFAICS.

Yes true, we are looking into the parallelism aspect more and will update on
how it goes. Ideally, we'd like to ensure that nohz.next_balance is set to
the earliest rq->next_balance even in the presence of concurrency.

Theoretically, we feel the parallelism should not increase more than the
current code but we'll look more into it.

> One thing I noticed is that we now use nohz.needs_update only in a single 
> remaining case, when _nohz_idle_balance() "self-defers":
> 
>                 /*
>                  * If this CPU gets work to do, stop the load balancing
>                  * work being done for other CPUs. Next load
>                  * balancing owner will pick it up.
>                  */
>                 if (need_resched()) {
>                         if (flags & NOHZ_STATS_KICK)
>                                 has_blocked_load = true;
>                         if (flags & NOHZ_NEXT_KICK)
>                                 WRITE_ONCE(nohz.needs_update, 1);
>                         goto abort;
>                 }
> 
> Getting a need-resched flag set on this CPU is a pretty dubious reason to 
> skip an ILB run IMO, and we could do entirely without that complication, 
> allowing us to remove the nohz.needs_update flag handling logic altogether?

Yes you are right I think, we can continue doing the ILB run in the case we
are only doing lighter-weight stats update and not full-blown idle balancing.

if (need_resched() && (flags & NOHZ_BALANCE_KICK))
	goto abort;

That way we can get rid of the needs_update variable as well, as you and
Vincent pointed out. We could also add this as a separate patch in a series.
Thanks for pointing out this idea.

> If we do that then the !need_resched() flag needs to go from 
> nohz_run_idle_balance() too:
> 
>         /*
>          * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
>          * (ie NOHZ_STATS_KICK set) and will do the same.
>          */
>         if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
>             !need_resched())
>                 _nohz_idle_balance(cpu_rq(cpu), flags);
> 
> ... if I'm reading the code right that is.

Yes, that sounds right.

We will work more on this and post the next revision soon. Thank you!

 - Joel & Vineeth

