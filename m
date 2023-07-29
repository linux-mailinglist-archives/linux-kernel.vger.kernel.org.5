Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BE767D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjG2JDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG2JDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:03:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E013C33;
        Sat, 29 Jul 2023 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=g6UojXCOkyCdhNj31kgSFEVj8BuEt/lnkxAfMMWCe9s=; b=pFuOcdSBnIPxpL8/P8SR0fNDxG
        nl507WgPU+OmBiRrT7g+mhjrFyCPcijN0CMf4CpDKsWBW3yc7tVijPvu3AWJzb2547fJEMFUuEGpV
        fmnCxjUqLrXOcR3aKzYgzs3GaRbJKk3xXN16tRs5u4BTeih4xd5jLPdaE1qNUzTEB/29AUCeVF6SM
        wGD2nVRjhS6iIOo+DXwpYGYavUVKLxHlUAeNYSIL0WD4pdlx8xOur8szeHQBBYboXtRQdmiozBTeZ
        DudGOTV7odYI3sFW6yawsLFTjgbEl4YC+O+vVcdQkbx4KtRDnAedZwFmaxA0PU+jodN5cT3gpk0rg
        m7xYiZsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPfqh-009wW8-Om; Sat, 29 Jul 2023 09:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C04A63002CE;
        Sat, 29 Jul 2023 11:02:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A87DF2027C618; Sat, 29 Jul 2023 11:02:55 +0200 (CEST)
Date:   Sat, 29 Jul 2023 11:02:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] cpuidle: teo: Update idle duration estimate when
 choosing shallower state
Message-ID: <20230729090255.GD3945851@hirez.programming.kicks-ass.net>
References: <4506480.LvFx2qVVIh@kreacher>
 <CAJZ5v0hnRm7Nnup3HPWedEchzLD_9w8OPkhQ0vjpR3uAL3HUoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hnRm7Nnup3HPWedEchzLD_9w8OPkhQ0vjpR3uAL3HUoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:12:56PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 27, 2023 at 10:05 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The TEO governor takes CPU utilization into account by refining idle state
> > selection when the utilization is above a certain threshold.  The idle state
> > selection is then refined by choosing an idle state shallower than the
> > previously selected one.
> >
> > However, when this is done, the idle duration estimate needs to be updated
> > so as to prevent the scheduler tick from being stopped while the candidate
> > idle state is shallow, which may lead to excessive energy usage if the CPU
> > is not interrupted quickly enough going forward.  Moreover, in case the
> > scheduler tick has been stopped already and the new idle duration estimate
> > is too small, the replacement candidate state cannot be used.
> >
> > Modify the relevant code to take the above observations into account.
> >
> > Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > @Peter: This doesn't attempt to fix the tick stopping problem, it just makes
> > the current behavior consistent.
> >
> > @Anna-Maria: This is likely to basically prevent the tick from being stopped
> > at all if the CPU utilization is above a certain threshold.  I'm wondering if
> > your results will be affected by it and in what way.
> >
> > ---
> >  drivers/cpuidle/governors/teo.c |   33 ++++++++++++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > @@ -397,13 +397,22 @@ static int teo_select(struct cpuidle_dri
> >          * the shallowest non-polling state and exit.
> >          */
> >         if (drv->state_count < 3 && cpu_data->utilized) {
> > -               for (i = 0; i < drv->state_count; ++i) {
> > -                       if (!dev->states_usage[i].disable &&
> > -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> > -                               idx = i;
> > +               /*
> > +                * If state 0 is enabled and it is not a polling one, select it
> > +                * right away and update the idle duration estimate accordingly,
> > +                * unless the scheduler tick has been stopped.
> > +                */
> > +               if (!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> > +                       s64 span_ns = teo_middle_of_bin(0, drv);
> > +
> > +                       if (teo_time_ok(span_ns)) {
> > +                               duration_ns = span_ns;
> >                                 goto end;
> >                         }
> >                 }
> > +               /* Assume that state 1 is not a polling one and select it. */
> 
> Well, I should also check if it is not disabled.  Will send a v2 tomorrow.
> 
> > +               idx = 1;
> > +               goto end;
> >         }
> >
> >         /*
> > @@ -539,10 +548,20 @@ static int teo_select(struct cpuidle_dri
> >
> >         /*
> >          * If the CPU is being utilized over the threshold, choose a shallower
> > -        * non-polling state to improve latency
> > +        * non-polling state to improve latency, unless the scheduler tick has
> > +        * been stopped already and the shallower state's target residency is
> > +        * not sufficiently large.
> >          */
> > -       if (cpu_data->utilized)
> > -               idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> > +       if (cpu_data->utilized) {
> > +               s64 span_ns;
> > +
> > +               i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> > +               span_ns = teo_middle_of_bin(i, drv);
> > +               if (teo_time_ok(span_ns)) {
> > +                       idx = i;
> > +                       duration_ns = span_ns;
> > +               }
> > +       }

So I'm not a huge fan of that utilized thing to begin with.. that feels
like a hack. I think my patch 3 would achieve much the same, because if
busy, you'll have short idles, which will drive the hit+intercept to
favour low states, and voila.

I didn't take it out -- yet -- because I haven't had much time to
evaluate it.

Simply lowering one state at a random busy threshold is duct-tape if
ever I saw some.
