Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2751C769F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGaR1o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGaR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:27:42 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7BB0;
        Mon, 31 Jul 2023 10:27:40 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56c9237e0ffso333263eaf.0;
        Mon, 31 Jul 2023 10:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824459; x=1691429259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ/qLMevfRFI8qX6ON9WVhN5LKon64lJl9KMq0vWLJk=;
        b=HSJlfJmhSyS2EWFXr8GF2EJXOolhk+/BKybfN+af0EXAQ1zX1in0U8eHNPud6nJt3J
         XYkLEJct0/GUE2ccQmVZ2/T2bwMoueDq0j2r4QvmoPmaF8zWlf3wfHxQwfWmcZV1ClaC
         yUv+W33y80izd1WtJN9rh1QKTE1xRiYUlNg1pb1pVcQPd1PWGLKhv8BSHaigwHWZok8V
         4+n++1gn5q2gEQsmGlPr7PxhVeBUh2q0GjVuWgjBRKH5mZW7UUkujh5jFJNyGf4gNYVy
         ZszKoiepvEMyqxBJuHtD50NqgIcNKQs0jIKhYsybV+BbJcD9yUZIX06j9da/ti7XL31c
         FrsA==
X-Gm-Message-State: ABy/qLb7H0MLTcFePYXmvypICo12KQwbX2RLsbqW0iJWqKrbffDfZ0Aw
        6r958LJNotvbuMZL0dupysxif8KylmPAPLgJE1Q=
X-Google-Smtp-Source: APBJJlFRsSTA4XnbGx+1O9cyIKLhO/Az+Mc2TMWjuk2pmsQVRmWMR/HaziRKMVTlXIBXLN4EwlwicbDhPzGbUuU103g=
X-Received: by 2002:a4a:d027:0:b0:563:3b56:5dc1 with SMTP id
 w7-20020a4ad027000000b005633b565dc1mr5067994oor.0.1690824459060; Mon, 31 Jul
 2023 10:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net> <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
 <20230731113850.GE29590@hirez.programming.kicks-ass.net> <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 19:27:27 +0200
Message-ID: <CAJZ5v0jz1aZdNHPH5x=VoDjfdMnD_+iE2CuYN5=nk=CMxSkXpA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 6:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jul 31, 2023 at 1:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 31, 2023 at 12:35:20PM +0200, Rafael J. Wysocki wrote:
> >
> > > > So I agree with 1.
> > > >
> > > > I do not agree with 2. Disabling the tick is costly, doubly so with the
> > > > timer-pull thing, but even today. Simply disabling it because we picked
> > > > the deepest idle state, irrespective of the expected duration is wrong
> > > > as it will incur this significant cost.
> > > >
> > > > With 3 there is the question of how we get the expected sleep duration;
> > > > this is especially important with timer-pull, where we have this
> > > > chicken-and-egg thing.
> > > >
> > > > Notably: tick_nohz_get_sleep_length() wants to know if the tick gets
> > > > disabled
> > >
> > > Well, it shouldn't.  Or at least it didn't before.
> >
> > Correct, this is new in the timer-pull thing.
> >
> > > It is expected to produce two values, one with the tick stopped (this
> > > is the return value of the function) and the other with the tick
> > > ticking (this is the one written under the address passed as the arg).
> > > This cannot depend on whether or not the tick will be stopped.  Both
> > > are good to know.
> > >
> > > Now, I understand that getting these two values may be costly, so
> > > there is an incentive to avoid calling it, but then the governor needs
> > > to figure this out from its crystal ball and so care needs to be taken
> > > to limit the possible damage in case the crystal ball is not right.
> >
> > If we can get the governor to decide the tick state up-front we can
> > avoid a lot of the expensive parts.
>
> I claim that in the vast majority of cases this is the same as
> deciding the state.
>
> The case when it is not is when the target residency of the deepest
> idle state is below the tick period length and the governor is about
> to select that state.  According to the data I've seen so far this is
> a tiny fraction of all the cases.
>
> > > > and cpuilde wants to use tick_nohz_get_sleep_length() to
> > > > determine if to disable the tick. This cycle needs to be broken for
> > > > timer-pull.
> > > >
> > > > Hence my proposal to introduce the extra tick state, that allows fixing
> > > > both 2 and 3.
> > >
> > > I'm not sure about 3 TBH.
> > >
> > > Say there are 2 idle states, one shallow (say its target residency is
> > > 10 us) and one deep (say its target residency is T = 2 * TICK_NSEC).
> >
> > This is the easy case and that actually 'works' today.
>
> But this is my case 3 which you said you didn't agree with.  I don't
> see why it needs to be fixed.
>
> > The interesting case is where your deepest state has a target residency that
> > is below the tick (because for HZ=100, we have a 10ms tick and pretty
> > much all idle states are below that).
>
> What about HZ=1000, though?
>
> > In that case you cannot tell the difference between I'm good to use this
> > state and I'm good to disable the tick and still use this state.
>
> No, you don't, but is it really worth the fuss?
>
> The state is high-latency anyway and tick_nohz_get_sleep_length()
> needs to be called anyway in that case in order to determine if a
> shallower state wouldn't be better.  At this point the statistics have
> already told the governor otherwise and a misprediction would be a
> double loss.
>
> So yes, you can gain performance by avoiding to call
> tick_nohz_get_sleep_length(), but then you can also lose it by
> selecting a state that is too deep (and that can be determined exactly
> with respect to timers).

BTW, note that teo records timers as "hits", because it has an idea
about when the next timer should occur and that's because it calls
tick_nohz_get_sleep_length().

If it doesn't call that function, it will not be able to tell the
difference between a non-tick timer and any other wakeup, so the
non-tick timer wakeups will then be recorded as "intercepts" which
will skew it towards shallow states over time.  That's one of the
reasons why I would prefer to only avoid calling
tick_nohz_get_sleep_length() when the candidate idle state is really
shallow.
