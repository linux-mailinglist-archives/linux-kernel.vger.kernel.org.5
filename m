Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0297C776935
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjHITts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjHITtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:49:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB03510DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=sFRRM464Bt6MEnb3WIeAuQysrD/M+qVRQwMUi036qMI=; b=THzT725cTZnBJWe0mx4wYStpmZ
        J0qBz142+KC+QdO5jeLkEyt7Kd2v4Jbn/D18Wk7cv+oMMEGet5+BVxcawjNRhESMl5p3+yt2KUPuK
        UtRS+Bn1SXMUMxWfPisaC0egopFfhrY7/ol+oUJ3epuZgckIMHcrIbU3PSHt34MQOSA7SjqPcG2Vy
        9zInh+nuBX5OYIiUMy+YGVmEYXogXCy0ztdWPyc4Hd9T6jMvBtA1QrOFYfGo74+Pn3BQz7o+rFY3k
        cu+eFmOyfRkcYtNcWz077Bt8IoxbtIO0f1ZTvZm5YL0Ob4V0VmKEPjND3v7PRF+Y4CEieeCnjlTuY
        Pa8A40Hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTpAN-005s4m-1p;
        Wed, 09 Aug 2023 19:48:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7E4630026C;
        Wed,  9 Aug 2023 21:48:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B49A220B32279; Wed,  9 Aug 2023 21:48:22 +0200 (CEST)
Date:   Wed, 9 Aug 2023 21:48:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] sched: Simplify get_nohz_timer_target()
Message-ID: <20230809194822.GV212435@hirez.programming.kicks-ass.net>
References: <20230801204121.929256934@infradead.org>
 <20230801211811.828443100@infradead.org>
 <CAEXW_YSJ-G_zUKLzLgvCkxAY-dg_Zxo6n=bEXyeEmo9hEMcZpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSJ-G_zUKLzLgvCkxAY-dg_Zxo6n=bEXyeEmo9hEMcZpg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 05:39:24PM -0400, Joel Fernandes wrote:
> On Sun, Aug 6, 2023 at 9:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Use guards to reduce gotos and simplify control flow.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/core.c |   15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1097,25 +1097,22 @@ int get_nohz_timer_target(void)
> >
> >         hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
> >
> > -       rcu_read_lock();
> > +       guard(rcu)();
> > +
> >         for_each_domain(cpu, sd) {
> >                 for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
> >                         if (cpu == i)
> >                                 continue;
> >
> > -                       if (!idle_cpu(i)) {
> > -                               cpu = i;
> > -                               goto unlock;
> > -                       }
> > +                       if (!idle_cpu(i))
> > +                               return i;
> >                 }
> >         }
> >
> >         if (default_cpu == -1)
> >                 default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> > -       cpu = default_cpu;
> > -unlock:
> > -       rcu_read_unlock();
> > -       return cpu;
> > +
> > +       return default_cpu;
> >  }
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I haven't looked into the actual implementation of the guard stuff,
> but rcu_read_lock_guarded() is less of an eyesore to me than
> guard(rcu)(); TBH.

I readily admit it isn't the prettiest construct, my brain is warped by
many years of C++ and I can read it as: guard<rcu>(), but I'm not sure
that's actually better :-)

The advantage of all this is that you also get:

	scoped_guard (rcu) {
	}

for 'free'.

