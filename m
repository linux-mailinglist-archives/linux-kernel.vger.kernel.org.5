Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054387DA555
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjJ1GiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1GiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 02:38:05 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337D11B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TpjAkzYedyZU8caQY65fA7BKsB1dxSgkhWgaBHUI8JU=;
  b=eSIqmUdiE9luoQvnw/3CL/qaK/0Kn1awq21BUZGf27qojhMKI32laT4a
   sHq2qas1dSln2fVGzNTv/nI9KZudqDGoNmSOkxlzh7cgTniGAkgdaeFfF
   XQsZB40asKgx8XCsgnB9VEZeZMBu8QYuQZD6ScPt1jSoa5dFi3iPGka6A
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,258,1694728800"; 
   d="scan'208";a="70000203"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 08:38:00 +0200
Date:   Sat, 28 Oct 2023 08:37:59 +0200 (CEST)
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
        Julia Lawall <julia.lawall@inria.fr>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
In-Reply-To: <ZTyfoIBpm3lxd8Dy@chenyu5-mobl2.ccr.corp.intel.com>
Message-ID: <alpine.DEB.2.22.394.2310280836100.3338@hadrien>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr> <ZTyfoIBpm3lxd8Dy@chenyu5-mobl2.ccr.corp.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Oct 2023, Chen Yu wrote:

> On 2023-10-27 at 19:17:43 +0200, Keisuke Nishimura wrote:
> > should_we_balance is called for the decision to do load-balancing.
> > When sched ticks invoke this function, only one CPU should return
> > true. However, in the current code, two CPUs can return true. The
> > following situation, where b means busy and i means idle, is an
> > example because CPU 0 and CPU 2 return true.
> >
> >         [0, 1] [2, 3]
> >          b  b   i  b
> >
> > This fix checks if there exists an idle CPU with busy sibling(s)
> > after looking for a CPU on an idle core. If some idle CPUs with busy
> > siblings are found, just the first one should do load-balancing.
> >
> > Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> > Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> > ---
> >  kernel/sched/fair.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2048138ce54b..eff0316d6c7d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
> >  		return cpu == env->dst_cpu;
> >  	}
> >
> > -	if (idle_smt == env->dst_cpu)
> > -		return true;
> > +	/* Is there an idle CPU with busy siblings? */
> > +	if (idle_smt != -1)
> > +		return idle_smt == env->dst_cpu;
> >
> >  	/* Are we the first CPU of this group ? */
> >  	return group_balance_cpu(sg) == env->dst_cpu;
>
> Looks reasonable to me, if there is other idle SMT(from half-busy core)
> in the system, we should leverage that SMT to do the periodic lb.
> Per my understanding,

That's not the goal of this patch.  The goal of this patch is to avoid
doing return group_balance_cpu(sg) == env->dst_cpu; when a half-busy core
has been identified that is different from env->dst_cpu.

julia

>
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
>
> thanks,
> Chenyu
>
