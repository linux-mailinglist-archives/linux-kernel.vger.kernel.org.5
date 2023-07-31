Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2F76932E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGaKff convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGaKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:35:34 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50281116;
        Mon, 31 Jul 2023 03:35:32 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56475c1b930so615376eaf.0;
        Mon, 31 Jul 2023 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690799731; x=1691404531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkace5vPaNLPGRNvCritdfOa890Cb4sF1iDw++EQSEM=;
        b=BqzfI04zsyDQeJQnbncLubLEFW3qV3vKHovhrM71o9JOE07girookPAN4aKC4gTf0l
         2T57C5XIFJY/C8T1qc9wRjHXg+DUQ3yJXf7hTnXl6hVXHAxeWxgh8TsZI2i+mte+VGVi
         Sl4gcbVEEn7lZz6LI8hhlbNR51wsuEHLxLx7wxmjrtb0MD0N+UitFtohuu6rkG7w2uTH
         r6xP/REtnFjvPFMUViY6iaf9w8D/X16vtby6fdt+sNqAROc/DFb1/7rytDiKbUAQqXDv
         /5HDEa+81SlSh/yD3NMFZvgXar6t55LexbBWhJlcElhpgr5r0WoFejFlD4VTqvRcBVoY
         Gc5Q==
X-Gm-Message-State: ABy/qLYvIb8SSq960/Eo+6qC9vW3i/1Zwb8x+3jQTWGW0hKPlQh0/qwa
        Ki9cX2yzfCG6/SESql/R37ubDZbPqwIgdQQ+I6k=
X-Google-Smtp-Source: APBJJlHU5PorP1/uCCcJkKD/TQTKl9JfBlPDW5d2rkerPY9IKjiOHKlLWiOxHx+2afRu9HDyDuNXdj55HoweWxl+HsE=
X-Received: by 2002:a05:6820:2201:b0:560:b01a:653d with SMTP id
 cj1-20020a056820220100b00560b01a653dmr5692139oob.0.1690799731459; Mon, 31 Jul
 2023 03:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com> <20230731090935.GB29590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230731090935.GB29590@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 12:35:20 +0200
Message-ID: <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 31, 2023 at 10:01:53AM +0200, Rafael J. Wysocki wrote:
> > On Sat, Jul 29, 2023 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 05:36:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > In order to facilitate governors that track history in idle-state
> > > > > buckets (TEO) making a useful decision about NOHZ, make sure we have a
> > > > > bucket that counts tick-and-longer.
> > > > >
> > > > > In order to be inclusive of the tick itself -- after all, if we do not
> > > > > disable NOHZ we'll sleep for a full tick, the actual boundary should
> > > > > be just short of a full tick.
> > > > >
> > > > > IOW, when registering the idle-states, add one that is always
> > > > > disabled, just to have a bucket.
> > > >
> > > > This extra bucket can be created in the governor itself, can't it?
> > >
> > > I couldn't find a nice spot for the governor to add idle-states.
> >
> > Well, I've thought this through and recalled a couple of things and my
> > conclusion is that the decision whether or not to stop the tick really
> > depends on the idle state choice.
> >
> > There are three cases:
> >
> > 1. The selected idle state is shallow (that is, its target residency
> > is below the tick period length), but it is not the deepest one.
> > 2. The selected idle state is shallow, but it is the deepest one (or
> > at least the deepest enabled one).
> > 3. The selected idle state is deep (that is, its target residency is
> > above the tick length period).
> >
> > In case 1, the tick should not be stopped so as to prevent the CPU
> > from spending too much time in a suboptimal idle state.
> >
> > In case 3, the tick needs to be stopped, because otherwise the target
> > residency of the selected state would not be met.
> >
> > Case 2 is somewhat a mixed bag, but generally speaking stopping the
> > tick doesn't hurt if the selected idle state is the deepest one,
> > because in that case the governor kind of expects a significant exit
> > latency anyway.  If it is not the deepest one (which is disabled),
> > it's better to let the tick tick.
>
> So I agree with 1.
>
> I do not agree with 2. Disabling the tick is costly, doubly so with the
> timer-pull thing, but even today. Simply disabling it because we picked
> the deepest idle state, irrespective of the expected duration is wrong
> as it will incur this significant cost.
>
> With 3 there is the question of how we get the expected sleep duration;
> this is especially important with timer-pull, where we have this
> chicken-and-egg thing.
>
> Notably: tick_nohz_get_sleep_length() wants to know if the tick gets
> disabled

Well, it shouldn't.  Or at least it didn't before.

It is expected to produce two values, one with the tick stopped (this
is the return value of the function) and the other with the tick
ticking (this is the one written under the address passed as the arg).
This cannot depend on whether or not the tick will be stopped.  Both
are good to know.

Now, I understand that getting these two values may be costly, so
there is an incentive to avoid calling it, but then the governor needs
to figure this out from its crystal ball and so care needs to be taken
to limit the possible damage in case the crystal ball is not right.

> and cpuilde wants to use tick_nohz_get_sleep_length() to
> determine if to disable the tick. This cycle needs to be broken for
> timer-pull.
>
> Hence my proposal to introduce the extra tick state, that allows fixing
> both 2 and 3.

I'm not sure about 3 TBH.

Say there are 2 idle states, one shallow (say its target residency is
10 us) and one deep (say its target residency is T = 2 * TICK_NSEC).

Currently, there are 3 bins in this case, 0 (0 - 10 us), 1 (10 us - T)
and 2 (T - infinity) and the governor will need to check bins 1 and 2
unless it somehow knows that it will use state 0.

Note that all of the events falling into bin 1 will cause the governor
to select state 0 more often, so I don't see how adding one more bin
between 1 and 2 changes this.
