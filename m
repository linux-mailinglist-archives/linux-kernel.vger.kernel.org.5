Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A8762711
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjGYWy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGYWyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:54:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924FF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LQbCFZHRhXpQFpBcLrTq8sSHp6lzZ8N0vEiSZRwCtWg=; b=d6Abi48RFQ6TTsu5Wat08CADbb
        xRVUILLQrFfSvlVZ6nRYU2utJzSVbKnNSLlqmMlM/PlHDTGxBlnPjTpMLb/0EntlmilAn8Wsjgz+E
        ieBjon1q9Iqhrgm4F0NN3QLzanxK/uClVUMUXDZw8rAxPUMIJjYpLHwlG552V/20e6GkjZuKbAE3F
        zfy4dAvz34giYp/VCCxLR6Ur19O6y8Bjo7E1A662oZCp2txFY3VFxWmrBfoQgn8q+d04aHTPcdmeH
        jgDRbhK0SaoayRAezxLc+6566hEGNgHmCLQQpPS9cE0wxDgx8Ic0VnN7n2O9/Iu89RktXGfGtud41
        jqP7DAUQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOQWT-005vcd-4B; Tue, 25 Jul 2023 22:28:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D82F30049D;
        Wed, 26 Jul 2023 00:28:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 785A9280F0301; Wed, 26 Jul 2023 00:28:51 +0200 (CEST)
Date:   Wed, 26 Jul 2023 00:28:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:27:56PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen

> >                         100% load               50% load                25% load
> >                         (top: ~2% idle)         (top: ~49% idle)        (top: ~74% idle;
> >                                                                         33 CPUs are completely idle)
> >                         ---------------         ----------------        ----------------------------
> > Idle Total              1658703 100%            3150522 100%            2377035 100%
> > x >= 4ms                2504    0.15%           2       0.00%           53      0.00%
> > 4ms> x >= 2ms           390     0.02%           0       0.00%           4563    0.19%
> > 2ms > x >= 1ms          62      0.00%           1       0.00%           54      0.00%
> > 1ms > x >= 500us        67      0.00%           6       0.00%           2       0.00%
> > 500us > x >= 250us      93      0.01%           39      0.00%           11      0.00%
> > 250us > x >=100us       280     0.02%           1145    0.04%           633     0.03%
> > 100us > x >= 50us       942     0.06%           30722   0.98%           13347   0.56%
> > 50us > x >= 25us        26728   1.61%           310932  9.87%           106083  4.46%
> > 25us > x >= 10us        825920  49.79%          2320683 73.66%          1722505 72.46%
> > 10us > x > 5us          795197  47.94%          442991  14.06%          506008  21.29%
> > 5us > x                 6520    0.39%           43994   1.40%           23645   0.99%
> >
> >
> > 99% of the tick stops only have an idle period shorter than 50us (50us is
> > 1,25% of a tick length).
> 
> Well, this just means that the governor predicts overly long idle
> durations quite often under this workload.
> 
> The governor's decision on whether or not to stop the tick is based on
> its idle duration prediction.  If it overshoots, that's how it goes.

This is abysmal; IIRC TEO tracks a density function in C state buckets
and if it finds it's more likely to be shorter than 'predicted' by the
timer it should pick something shallower.

Given we have this density function, picking something that's <1% likely
is insane. In fact, it seems to suggest the whole pick-alternative thing
is utterly broken.

> > This is also the reason for my opinion, that the return of
> > tick_nohz_next_event() is completely irrelevant in a (fully) loaded case:
> 
> It is an upper bound and in a fully loaded case it may be way off.

But given we have our density function, we should be able to do much
better.


Oooh,... I think I see the problem. Our bins are strictly the available
C-state, but if you run this on a Zen3 that has ACPI-idle, then you end
up with something that only has 3 C states, like:

$ for i in state*/residency ; do echo -n "${i}: "; cat $i; done
state0/residency: 0
state1/residency: 2
state2/residency: 36

Which means we only have buckets: (0,0] (0,2000], (2000,36000] or somesuch. All
of them very much smaller than TICK_NSEC.

That means we don't track nearly enough data to reliably tell anything
about disabling the tick or not. We should have at least one bucket
beyond TICK_NSEC for this.

Hmm.. it is getting very late, but how about I get the cpuidle framework
to pad the drv states with a few 'disabled' C states so that we have at
least enough data to cross the TICK_NSEC boundary and say something
usable about things.

Because as things stand, it's very likely we determine @stop_tick purely
based on what tick_nohz_get_sleep_length() tells us, not on what we've
learnt from recent history.


(FWIW intel_idle seems to not have an entry for Tigerlake !?! -- my poor
laptop, it feels neglected)
