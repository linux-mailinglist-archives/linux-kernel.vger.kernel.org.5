Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983BC769F57
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjGaRVX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 13:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjGaRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:21:01 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A133173D;
        Mon, 31 Jul 2023 10:20:57 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56c9237e0ffso332045eaf.0;
        Mon, 31 Jul 2023 10:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824057; x=1691428857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp/WHB9NlxenQuZy7KyUcZW03h0kCKbBguoGc6IUG1I=;
        b=kzDQsYFZKugKLa7hPSNnPfy3qPmf5fkylHLiM9X3DfZNV03+uzmMHo4j7Y4WIXMPEB
         D4vosC42sPqDl9T6lJDNMkYqXmBdQ0mugr+jOEowCopowNrXNgdUcmxwZ8LEB6914q3N
         T/e9+3U6c5eDuDATayHpm6I3kfUE/pw5yvLXk40uKc/FUVYLAursbYPG8GIiaVhghO/R
         lVvfA5AXF19TDAjnOA8XTGrxztL5er93Db+KqWcAIYj93vxd/wi145AkTbUB0Sim1o4Q
         +UxyMjYDfIscl+aVRYIOLBqLWlUsdL92VVaBwx9UfS2dQfq3eLT3TW5TSYKXGigf0nlY
         KwmQ==
X-Gm-Message-State: ABy/qLZFmUI02Q40mTGsAgsjz6/IYwbnaY13LrBDpPYiI9Yi2d474Hs1
        7wXVNjLotbqZ20CUBMd08sooRNRuOz2kiEQ51Jc=
X-Google-Smtp-Source: APBJJlGHg/RSPWHC0ZfSL1Bxu03CX8ZZZMh4G1nFHlCtr+YpOYxHlaRj+/cM3M7cZeI/9oh3o2TzRJ8Gf/+Emm0us9Y=
X-Received: by 2002:a4a:d027:0:b0:563:3b56:5dc1 with SMTP id
 w7-20020a4ad027000000b005633b565dc1mr5054481oor.0.1690824056783; Mon, 31 Jul
 2023 10:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.902892871@infradead.org>
 <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com>
 <20230728220109.GA3934165@hirez.programming.kicks-ass.net>
 <CAJZ5v0ir_VsvBi4KKhpcjQnVsTK-EXZJjNsk=Jp84HLvaspChw@mail.gmail.com> <20230731120200.GF29590@hirez.programming.kicks-ass.net>
In-Reply-To: <20230731120200.GF29590@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 19:20:45 +0200
Message-ID: <CAJZ5v0hQh2Pg_uXxj8KBRw3oLS1WdsU+rUafBAAq7dRdbRwYSA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
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

On Mon, Jul 31, 2023 at 2:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 31, 2023 at 12:17:27PM +0200, Rafael J. Wysocki wrote:
>
> > Something really simple like:
> >
> > 1. Check sched_cpu_util() (which is done by teo anyway).
> > 2. If that is around 90% of the maximum CPU capacity, select the first
> > non-polling idle state and be done (don't stop the tick as my other
> > replay earlier today).
>
> So I really don't like using cpu_util() here, yes, 90% is a high number,
> but it doesn't say *anything* about the idle duration. Remember, this is
> a 32ms window, so 90% of that is 28.8ms.

It doesn't have to say anything about the idle duration as long as it
says something about the governor's "accuracy".

If it is observed experimentally that the governor is generally likely
to mispredict a deeper state if CPu utilization is about a certain
threshold, then it makes sense to use this information to counter
that.  That's how it is used today.

And yes, you are right about the most immediate idle duration, but
overall the rule that if the CPU utilization is high, then selecting
deep idle states is not a good idea in general does seem to hold.

> (not entirely accurate, since it's an exponential average, but that
> doesn't change the overal argument, only some of the particulars)
>
> That is, 90% util, at best, says there is no idle longer than 3.2 ms.
> But that is still vastly longer than pretty much all residencies. Heck,
> that is still 3 ticks worth of HZ=1000 ticks. So 90% util should not
> preclude disabling the tick (at HZ=1000).
>
> Now, typically this won't be the case, and at 90% you'll have lots of
> small idles adding up to 3.2ms total idle. But the point is, you can't
> tell the difference. And as such util is a horrible measure to use for
> cpuidle.

No it is not IMO, because idle is all about the combined outcome of
multiple cycles.

> > > If we track the tick+ bucket -- as
> > > we must in order to say anything useful about it, then we can decide the
> > > tick state before (as I do here) calling sleep_length().
> > >
> > > The timer-pull rework from Anna-Maria unfortunately makes the
> > > tick_nohz_get_sleep_length() thing excessively expensive and it really
> > > doesn't make sense to call it when we retain the tick.
> > >
> > > It's all a bit of a chicken-egg situation, cpuidle wants to know when
> > > the next timer is, but telling when that is, wants to know if the tick
> > > stays. We need to break that somehow -- I propose by not calling it when
> > > we know we'll keep the tick.
> >
> > By selecting a state whose target residency will not be met, we lose
> > on both energy and performance, so doing this really should be
> > avoided, unless the state is really shallow in which case there may be
> > no time for making this consideration.
>
> I'm not sure how that relates to what I propose above. By adding the
> tick+ bucket we have more historical information as related to the tick
> boundary, how does that make us select states we won't match residency
> for?

As stated in my last reply, the only case in which it makes a
difference is when the deepest idle state's target residency is below
the tick and I'm not really sure if that difference is demonstrably
significant.

So I would do the following to start with:

1. Rearrange the teo code so that it considers all of the bins every
time without calling tick_nohz_get_sleep_length().

2. The sched_cpu_util() check will still be applied to the resulting
candidate state as it is now.

3. If it finds that the candidate state is shallow enough (for
instance, it is a polling state or the first non-polling one), it will
return this state without calling tick_nohz_get_sleep_length() and
stopping the tick.

4. Otherwise it will call tick_nohz_get_sleep_length() to see what
about timers and refine the selection (towards the shallower states)
if need be.

5. If the candidate state is not the deepest one and its target
residency is below the tick, it will be returned and the tick will not
be stopped.

6. Otherwise, the candidate state will be returned and the tick will be stopped.

If this still doesn't get us where we want to be, the extra bin can be
added (as long as it makes a measurable difference).
