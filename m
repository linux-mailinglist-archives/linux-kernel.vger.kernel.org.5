Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1582E769131
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGaJMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGaJMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:12:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F11A4;
        Mon, 31 Jul 2023 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ktCqLU8eJ3sg8SjbvGPYu8iAVDMU/S8xLXSVitYz1HU=; b=XfWq/yjQPP69Zvzg1Q6q3Yvrhp
        8mrqm8wqq5JECZ52jmKT+bqHuUp41FQO6j5uMq+P26bRJ3FffU/LROpaXj4McO2bw3/EhZsZUFIIQ
        m9PU8jbmX4EadCh+g1XZbOrHQg9JIxckpQmxjPck8r1CphkHyKpVkUkqyFOCG6W6Y3GBBNY4TzFhX
        m8RRpITen2Mf9wPS4h6i4sfdMkw1DjRi2zckJfhDd7cqvf4+vVHvHXVFDVgs00gr82zNpsz4mcFOd
        zula8B3qRwnTufon9rj8OkVC+AlttuMF0z8YtIXPrhqiAquduqwvMzr9z7tZGei4653fbgAuVkgxP
        qiHs5xkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQOuG-00CVVY-3C;
        Mon, 31 Jul 2023 09:11:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D5503002D9;
        Mon, 31 Jul 2023 11:09:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFD9720165067; Mon, 31 Jul 2023 11:09:35 +0200 (CEST)
Date:   Mon, 31 Jul 2023 11:09:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
Message-ID: <20230731090935.GB29590@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:01:53AM +0200, Rafael J. Wysocki wrote:
> On Sat, Jul 29, 2023 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jul 28, 2023 at 05:36:55PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > In order to facilitate governors that track history in idle-state
> > > > buckets (TEO) making a useful decision about NOHZ, make sure we have a
> > > > bucket that counts tick-and-longer.
> > > >
> > > > In order to be inclusive of the tick itself -- after all, if we do not
> > > > disable NOHZ we'll sleep for a full tick, the actual boundary should
> > > > be just short of a full tick.
> > > >
> > > > IOW, when registering the idle-states, add one that is always
> > > > disabled, just to have a bucket.
> > >
> > > This extra bucket can be created in the governor itself, can't it?
> >
> > I couldn't find a nice spot for the governor to add idle-states.
> 
> Well, I've thought this through and recalled a couple of things and my
> conclusion is that the decision whether or not to stop the tick really
> depends on the idle state choice.
> 
> There are three cases:
> 
> 1. The selected idle state is shallow (that is, its target residency
> is below the tick period length), but it is not the deepest one.
> 2. The selected idle state is shallow, but it is the deepest one (or
> at least the deepest enabled one).
> 3. The selected idle state is deep (that is, its target residency is
> above the tick length period).
> 
> In case 1, the tick should not be stopped so as to prevent the CPU
> from spending too much time in a suboptimal idle state.
> 
> In case 3, the tick needs to be stopped, because otherwise the target
> residency of the selected state would not be met.
> 
> Case 2 is somewhat a mixed bag, but generally speaking stopping the
> tick doesn't hurt if the selected idle state is the deepest one,
> because in that case the governor kind of expects a significant exit
> latency anyway.  If it is not the deepest one (which is disabled),
> it's better to let the tick tick.

So I agree with 1.

I do not agree with 2. Disabling the tick is costly, doubly so with the
timer-pull thing, but even today. Simply disabling it because we picked
the deepest idle state, irrespective of the expected duration is wrong
as it will incur this significant cost.

With 3 there is the question of how we get the expected sleep duration;
this is especially important with timer-pull, where we have this
chicken-and-egg thing.

Notably: tick_nohz_get_sleep_length() wants to know if the tick gets
disabled and cpuilde wants to use tick_nohz_get_sleep_length() to
determine if to disable the tick. This cycle needs to be broken for
timer-pull.

Hence my proposal to introduce the extra tick state, that allows fixing
both 2 and 3.
