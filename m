Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47217DA7A7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjJ1PDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:03:30 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D869D
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JCgC8iEfqeVG5SmoD+Z1qjOZtlgkC88g0qaak8aF7AM=;
  b=HwvWRDA7Sgno0G1lAYJ4S8dFlOw/uCUwDTPVjlc61GeP9Fl7fV96iEfB
   u9SBd+tk6u+pE0SatqvwzY4NmVwZL84fjhx5soQ8lnE2clzkgBbFCh3Df
   HXpW/QvsvygxkReqhxcvSArAn14eWPH+SFjSgJWvec3LDNKb7Bj6FMSMF
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,259,1694728800"; 
   d="scan'208";a="133701260"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 17:03:23 +0200
Date:   Sat, 28 Oct 2023 17:03:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Chen Yu <yu.c.chen@intel.com>
cc:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
In-Reply-To: <ZT0gQskmc//KxYyD@chenyu5-mobl2.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.22.394.2310281703050.3092@hadrien>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr> <ZTyfoIBpm3lxd8Dy@chenyu5-mobl2.ccr.corp.intel.com> <alpine.DEB.2.22.394.2310280836100.3338@hadrien> <ZT0gQskmc//KxYyD@chenyu5-mobl2.ccr.corp.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Oct 2023, Chen Yu wrote:

> On 2023-10-28 at 08:37:59 +0200, Julia Lawall wrote:
> >
> >
> > On Sat, 28 Oct 2023, Chen Yu wrote:
> >
> > > On 2023-10-27 at 19:17:43 +0200, Keisuke Nishimura wrote:
> > > > should_we_balance is called for the decision to do load-balancing.
> > > > When sched ticks invoke this function, only one CPU should return
> > > > true. However, in the current code, two CPUs can return true. The
> > > > following situation, where b means busy and i means idle, is an
> > > > example because CPU 0 and CPU 2 return true.
> > > >
> > > >         [0, 1] [2, 3]
> > > >          b  b   i  b
> > > >
> > > > This fix checks if there exists an idle CPU with busy sibling(s)
> > > > after looking for a CPU on an idle core. If some idle CPUs with busy
> > > > siblings are found, just the first one should do load-balancing.
> > > >
> > > > Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> > > > Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> > > > ---
> > > >  kernel/sched/fair.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 2048138ce54b..eff0316d6c7d 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
> > > >  		return cpu == env->dst_cpu;
> > > >  	}
> > > >
> > > > -	if (idle_smt == env->dst_cpu)
> > > > -		return true;
> > > > +	/* Is there an idle CPU with busy siblings? */
> > > > +	if (idle_smt != -1)
> > > > +		return idle_smt == env->dst_cpu;
> > > >
> > > >  	/* Are we the first CPU of this group ? */
> > > >  	return group_balance_cpu(sg) == env->dst_cpu;
> > >
> > > Looks reasonable to me, if there is other idle SMT(from half-busy core)
> > > in the system, we should leverage that SMT to do the periodic lb.
> > > Per my understanding,
> >
> > That's not the goal of this patch.  The goal of this patch is to avoid
> > doing return group_balance_cpu(sg) == env->dst_cpu;
>
> Yes, I mean, without this patch, we could incorrectly choose the current
> non idle CPU rather than that idle SMT, but actually we should let that
> idle SMT to do the idle lb.

OK, agreed.  Thanks for the feedback!

julia

>
> thanks,
> Chenyu
>
> > when a half-busy core
> > has been identified that is different from env->dst_cpu.
> >
> > julia
> >
> > >
> > > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> > >
> > > thanks,
> > > Chenyu
> > >
>
