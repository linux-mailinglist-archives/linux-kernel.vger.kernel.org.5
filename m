Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0455769D46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjGaQzz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGaQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:55:48 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70119AC;
        Mon, 31 Jul 2023 09:55:47 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56cae50792fso136036eaf.1;
        Mon, 31 Jul 2023 09:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822546; x=1691427346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf/vHavd8WCAV3ynHx7GUS+EaCXK1BuHx/QKXm3Tmus=;
        b=Wf+AIl6335kuP+FG0+vzJ5pWLYFarOJ7LYj3BhVNm/9GOSHQRiXPyiDuYDJt1ZQv8f
         IyaOprJK+M1Fr6OFTHmHp7tnVzKBIS9KGLhjD6diKpL3JTKZJhtWZz+gurLTNKrM0/eJ
         yK4Vf+AjvGsKynYUqyZrapREf649GIh3d0MxISOc1XYDmWkKMgojVH6GLAPkBfWOX882
         orwFaTJNqG7zdWiEiO+cfcjzSqiYecXUWjfWG/2TrKXBKGiqGprHLXxHmaZBQSNv+J4L
         Ph0GMJbRFtM4AGPggz7xmxc/msX1rVzzsskMet4D8FTOMszt/vG4aiFokAYUOfCVAAS9
         exig==
X-Gm-Message-State: ABy/qLZkwyN5Ce2iYQVGjdArNzEA2PB2jQlI31ZjIlAHSj1m1jjsExpN
        hKbdbV9O3KVfqaQdrA3k14LHM6b32v3gzNwBHko=
X-Google-Smtp-Source: APBJJlFPbJDXgXDJrWJIpqhgxzLM9ROIAn5ViN7gcFEt/UOjRZtA33fSg4eKKpL0l1X8qbXWjTL/nu8HF76dLoHlFY0=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr6421174oob.1.1690822546674; Mon, 31 Jul
 2023 09:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net> <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
 <20230731113850.GE29590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230731113850.GE29590@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 18:55:35 +0200
Message-ID: <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, anna-maria@linutronix.de,
        tglx@linutronix.de, frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 1:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 31, 2023 at 12:35:20PM +0200, Rafael J. Wysocki wrote:
>
> > > So I agree with 1.
> > >
> > > I do not agree with 2. Disabling the tick is costly, doubly so with the
> > > timer-pull thing, but even today. Simply disabling it because we picked
> > > the deepest idle state, irrespective of the expected duration is wrong
> > > as it will incur this significant cost.
> > >
> > > With 3 there is the question of how we get the expected sleep duration;
> > > this is especially important with timer-pull, where we have this
> > > chicken-and-egg thing.
> > >
> > > Notably: tick_nohz_get_sleep_length() wants to know if the tick gets
> > > disabled
> >
> > Well, it shouldn't.  Or at least it didn't before.
>
> Correct, this is new in the timer-pull thing.
>
> > It is expected to produce two values, one with the tick stopped (this
> > is the return value of the function) and the other with the tick
> > ticking (this is the one written under the address passed as the arg).
> > This cannot depend on whether or not the tick will be stopped.  Both
> > are good to know.
> >
> > Now, I understand that getting these two values may be costly, so
> > there is an incentive to avoid calling it, but then the governor needs
> > to figure this out from its crystal ball and so care needs to be taken
> > to limit the possible damage in case the crystal ball is not right.
>
> If we can get the governor to decide the tick state up-front we can
> avoid a lot of the expensive parts.

I claim that in the vast majority of cases this is the same as
deciding the state.

The case when it is not is when the target residency of the deepest
idle state is below the tick period length and the governor is about
to select that state.  According to the data I've seen so far this is
a tiny fraction of all the cases.

> > > and cpuilde wants to use tick_nohz_get_sleep_length() to
> > > determine if to disable the tick. This cycle needs to be broken for
> > > timer-pull.
> > >
> > > Hence my proposal to introduce the extra tick state, that allows fixing
> > > both 2 and 3.
> >
> > I'm not sure about 3 TBH.
> >
> > Say there are 2 idle states, one shallow (say its target residency is
> > 10 us) and one deep (say its target residency is T = 2 * TICK_NSEC).
>
> This is the easy case and that actually 'works' today.

But this is my case 3 which you said you didn't agree with.  I don't
see why it needs to be fixed.

> The interesting case is where your deepest state has a target residency that
> is below the tick (because for HZ=100, we have a 10ms tick and pretty
> much all idle states are below that).

What about HZ=1000, though?

> In that case you cannot tell the difference between I'm good to use this
> state and I'm good to disable the tick and still use this state.

No, you don't, but is it really worth the fuss?

The state is high-latency anyway and tick_nohz_get_sleep_length()
needs to be called anyway in that case in order to determine if a
shallower state wouldn't be better.  At this point the statistics have
already told the governor otherwise and a misprediction would be a
double loss.

So yes, you can gain performance by avoiding to call
tick_nohz_get_sleep_length(), but then you can also lose it by
selecting a state that is too deep (and that can be determined exactly
with respect to timers).
