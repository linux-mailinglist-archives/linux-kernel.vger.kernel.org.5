Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B188764129
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGZV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGZV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:26:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB62691
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tjqM9TBxrwznfxbhKmOlhEod+wK7pog9vaAmTTD7/AU=; b=fIPk/s+kZMiSMb7yfX5ysDR7g4
        ssmyP7micLQzSDjfHImAu6xM1YisERD/GtCdaCLoxCvboJUA0ElleTQftPWY839ehxQfwzMwNEj+b
        otIKaTEDVNA35h0nINeGvQZa+CL/4cY0W0ntNOimxFBdeZVAGuroeVgV4WwfU6TEiXM70wZohi8EA
        iZgVFaIR4ncJGIEYUGR23VNb9vepTan5+jd7kUe7lrXerl5+zWdeJpU4+ZY91/XOxX8Zpy3s+Eby/
        kyJAZ2dVZzHYejBqTl7/rgoQOEB1WWEUAcHTXHi0GnFUvVMGRfMlS0VD0VR0ffnpYsyjW2kMKQ5pD
        InRe2nnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOm1M-006rTr-FX; Wed, 26 Jul 2023 21:26:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 617FE300155;
        Wed, 26 Jul 2023 23:26:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F57A22B8D5E1; Wed, 26 Jul 2023 23:26:11 +0200 (CEST)
Date:   Wed, 26 Jul 2023 23:26:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        g@hirez.programming.kicks-ass.net
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
Message-ID: <20230726212611.GA3869583@hirez.programming.kicks-ass.net>
References: <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
 <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
 <20230726161432.GW4253@hirez.programming.kicks-ass.net>
 <20230726164958.GV38236@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726164958.GV38236@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:49:58PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 26, 2023 at 06:14:32PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 26, 2023 at 05:53:46PM +0200, Rafael J. Wysocki wrote:
> > 
> > > > > That means we don't track nearly enough data to reliably tell anything
> > > > > about disabling the tick or not. We should have at least one bucket
> > > > > beyond TICK_NSEC for this.
> > > >
> > > > Quite likely.
> > > 
> > > So the reasoning here was that those additional bins would not be
> > > necessary for idle state selection, but the problem of whether or not
> > > to stop the tick is kind of separate from the idle state selection
> > > problem if the target residency values for all of the idle states are
> > > relatively short.  And so it should be addressed separately which
> > > currently it is not.  Admittedly, this is a mistake.
> > 
> > Right, the C state buckets are enough to pick a state, but not to handle
> > the tick thing.
> > 
> > The below hack boots on my ivb-ep with extra (disabled) states. Now let
> > me go hack up teo to make use of that.
> > 
> > name		residency
> > 
> > POLL		0
> > C1              1
> > C1E             80
> > C3              156
> > C6              300
> > TICK            1000
> > POST-TICK       2000
> > 
> 
> builds and boots, futher untested -- I need to see to dinner.
> 
> The idea is that teo_update() should account to the highest state if
> measured_ns is 'large'.
> 
> Then, then the tick is on, see if the majority (50%) of the
> hit+intercepts are below the TICK threshold, if so, don't stop the tick
> and assume duration_ns = TICK_NSEC -- iow. don't call
> tick_nohz_get_sleep_length().
> 
> I'll check if the below code actually does as intended once the loonies
> are in bed.

D'oh, it suffers the 'obvious' problem. Since the tick is not disabled,
we'll never log sleeps longer than the tick and hence never decide to
disable the tick.

Clever of me... This needs a wee bit of refining it does :-)
