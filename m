Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEBE7BBD32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjJFQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJFQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:47:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF2184
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:46:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fca042ec0so95216439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696610804; x=1697215604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUEhW6+BD62ukRk7cyuW+qq/HbiZNK3QK+6OmmBkfkw=;
        b=H4z7ZAz3NeZBDoN73YBXpLH4yTo/DybCAzovGQxDYmrHtiN8QjWuHC+FV7mZjsi5hL
         aOlox+Z6ekrVG5rve05DeKMMpjMXmr5P1nNcY8jbJMQDuZUfsirAS4Z/jl/SFKk84TKK
         wOslfw41S40zuIcgAEtHW3LD0BEnT/77a1Kf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610804; x=1697215604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUEhW6+BD62ukRk7cyuW+qq/HbiZNK3QK+6OmmBkfkw=;
        b=Ei/YyH41g7MF5kyQz4510mMt0lJW1vqXNVfcMstJoIsoBstF5uwudxLj/Y3PC8ybRJ
         RidXQlLDZpYCdRyejITE+GLBwPm8RPfHZZgY4Uy23UWEl2SNZM214lxleJTqDCk6Rm6k
         FMpPYwbFyOa+eX6H7tLacgDPGcpvkYQ0tIy/1sjeXmYBIsTKworBjnNhrCk8DL0ZMUYc
         s1y9LNjVnO2BlXolgwMTRdA++MZrz6LjOMP5gGn2zVNCk3iOaCK85g0/nhFrR17Pbt2p
         ZWdARh5bF39Y+WUQfu4KvmtXTbgeAgfsUzYvNlO8HJx4/se+EIVUppmpbKRGzoaJ4zIs
         Ybew==
X-Gm-Message-State: AOJu0Yx9kuGcI4eWHBRajGZtfbN2EUDflzpRJT7s1HmA7mlDSgcr9Iu0
        a0w8zqgBNx6mT/azgV+HnwMAeA==
X-Google-Smtp-Source: AGHT+IGUxcSwszQA6RTlMCdq9Hi405ccUR8Ll1+CDy3nUlMs2+fZMVyfHOfECmnMpd8Y3ZTKpcKWfw==
X-Received: by 2002:a5d:9743:0:b0:79f:96db:f33d with SMTP id c3-20020a5d9743000000b0079f96dbf33dmr9426665ioo.9.1696610804633;
        Fri, 06 Oct 2023 09:46:44 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id 8-20020a5d9c48000000b007836c7e8dccsm659831iof.17.2023.10.06.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:46:44 -0700 (PDT)
Date:   Fri, 6 Oct 2023 16:46:43 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <20231006164643.GB2188081@google.com>
References: <20231005161727.1855004-1-joel@joelfernandes.org>
 <CAKfTPtC8Qhr+jjXmwdxCNE5f3etuqg=WpZ6icUFpT9Lg+-pwmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC8Qhr+jjXmwdxCNE5f3etuqg=WpZ6icUFpT9Lg+-pwmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Oct 06, 2023 at 03:46:44PM +0200, Vincent Guittot wrote:
[...]
> > ---
> >  kernel/sched/fair.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cb225921bbca..2ece55f32782 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11786,13 +11786,12 @@ void nohz_balance_enter_idle(int cpu)
> >         /*
> >          * Ensures that if nohz_idle_balance() fails to observe our
> >          * @idle_cpus_mask store, it must observe the @has_blocked
> > -        * and @needs_update stores.
> > +        * stores.
> >          */
> >         smp_mb__after_atomic();
> >
> >         set_cpu_sd_state_idle(cpu);
> >
> > -       WRITE_ONCE(nohz.needs_update, 1);
> 
> the set of needs_updat here is the main way to set nohz.needs_update
> and trigger an update of next_balance so it would be good to explain
> why we still need to keep it instead r removing it entirely

Ok, we are thinking of getting rid of it as Ingo suggested.

> >  out:
> >         /*
> >          * Each time a cpu enter idle, we assume that it has blocked load and
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
> >         unsigned int flags;
> >
> > -       flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
> > +       flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK | NOHZ_NEXT_KICK, nohz_flags(cpu));
> > +
> > +       if (!flags)
> > +               return;
> >
> >         /*
> >          * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
> >          * (ie NOHZ_STATS_KICK set) and will do the same.
> >          */
> > -       if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> > -               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> > +       if ((flags == (flags & (NOHZ_NEXT_KICK | NOHZ_NEWILB_KICK))) &&
> > +           !need_resched())
> > +               _nohz_idle_balance(cpu_rq(cpu), flags);
> 
> This breaks the update of the blocked load.
> nohz_newidle_balance() only sets NOHZ_NEWILB_KICK (and not
> NOHZ_STATS_KICK) when it wants to update blocked load before going
> idle but it then sets NOHZ_STATS_KICK when calling_nohz_idle_balance()
> . We only clear NOHZ_NEWILB_KICK  when fetching flags but we test if
> other bits have been set by a pending softirq which will do the same.

Yes, we realized this just after sending the RFC. Will fix, thank you!

> That's why we use NOHZ_NEWILB_KICK and not NOHZ_STATS_KICK directly.
> Similarly you can't directly use NOHZ_NEXT_KICK.

This is not an issue actually, as NEXT_KICK is only set by this path
(nohz_newidle_balance()) after this patch. The NEWILB_KICK and STATS_KICK
case is different where it can be updated in more than 1 path. Right?

> Also note that _nohz_idle_balance() is not robust against parallel run

True, though the parallelism is already happening. However your point is well
taken and we'll try to improve the existing code to make it more robust as
well (if needed). Will dig deeper into it.

thanks,

- Joel & Vineeth

