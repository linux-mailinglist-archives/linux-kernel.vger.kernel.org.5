Return-Path: <linux-kernel+bounces-165323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353428B8B47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FE21F23895
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46512E1FA;
	Wed,  1 May 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffeUBFr9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530212E1E4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570584; cv=none; b=Ub4HfJRIof39LGGIT/b6gZlYgwvBo++fLVeG0oneEpZt/onbqVcSjGJiOnOlFm28jsjeaVhCWvCQWOxjITK9ZaxfzWuiMv3CVKhd7Tb46rLIdo285P0jT59FEsapPCgijWZxw6B8LLI5d/QNDXyjdLLPgGmHfIMk7tEDqZnQL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570584; c=relaxed/simple;
	bh=+MLGtmFkVoW2V2ltR19thvpq2CQAt0BTvEGEtfnCiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy1U+Gg1aucyz1mrjXrLoVV0y8icflOJ3poiCdSZYVryC4E5uQTZDXB77fYStelCTxbyTWt1xcL1bQjy0ox1FDr3jBAo3LB+RFfAhXCCNT0fscnNs74PwL+Ea04/K1ZXW++PF0hTqoANjZ0itL3WxPdNbEpXbeAYT4qDC31qUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffeUBFr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714570581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iNSqtzWwAlwgIQ6iiOBFN9QT1dUeSTsLKWPCg4OcUJc=;
	b=ffeUBFr9iXCB8wroLITqZz9ci5iQ7AgDf1Wu79Hz/3Ph7rTYs7TdXDV9RM/ePsqodh5X/n
	VQmFMKd05BsXRsFhzfD9bA9zripXSKrNLVOcve0RDlpVtCLX76zRICMCSahF3Fk+w/p5Qh
	fBPm6/FyQdBrbN3l5dTrcHOkuMb8EME=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-TQgDEG4BObaLaS4JSwWH9w-1; Wed,
 01 May 2024 09:36:19 -0400
X-MC-Unique: TQgDEG4BObaLaS4JSwWH9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 662D21C4C3E0;
	Wed,  1 May 2024 13:36:18 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CEBE40C6CC0;
	Wed,  1 May 2024 13:36:11 +0000 (UTC)
Date: Wed, 1 May 2024 09:36:08 -0400
From: Phil Auld <pauld@redhat.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ankit Jain <ankit-aj.jain@broadcom.com>, linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] lib/cpumask: Boot option to disable tasks distribution
 within cpumask
Message-ID: <20240501133608.GB39737@lorien.usersys.redhat.com>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
 <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


Hi Yuri,

On Tue, Apr 30, 2024 at 11:23:07AM -0700 Yury Norov wrote:
> On Tue, Apr 30, 2024 at 02:34:31PM +0530, Ankit Jain wrote:
> > commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> > and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> > introduced the logic to distribute the tasks within cpumask upon initial
> > wakeup.
> 
> So let's add the authors in CC list?
> 
> > For Telco RAN deployments, isolcpus are a necessity to cater to
> > the requirement of low latency applications. These isolcpus are generally
> > tickless so that high priority SCHED_FIFO tasks can execute without any
> > OS jitter. Since load balancing is disabled on isocpus, any task
> > which gets placed on these CPUs can not be migrated on its own.
> > For RT applications to execute on isolcpus, a guaranteed kubernetes pod
> > with all isolcpus becomes the requirement and these RT applications are
> > affine to execute on a specific isolcpu within the kubernetes pod.
> > However, there may be some non-RT tasks which could also schedule in the
> > same kubernetes pod without being affine to any specific CPU(inherits the
> > pod cpuset affinity).
> 
> OK... It looks like adding scheduler maintainers is also a necessity to
> cater here...
> 
> > With multiple spawning and running containers inside
> > the pod, container runtime spawns several non-RT initializing tasks
> > ("runc init") inside the pod and due to above mentioned commits, these
> > non-RT tasks may get placed on any isolcpus and may starve if it happens
> > to wakeup on the same CPU as SCHED_FIFO task because RT throttling is also
> > disabled in telco setup. Thus, RAN deployment fails and eventually leads
> > to system hangs.
> 
> Not that I'm familiar to your setup, but this sounds like a userspace
> configuration problems. Can you try to move your non-RT tasks into a
> cgroup attached to non-RT CPUs, or something like that? 
>

It's not really. In a container environment just logging in to the
container could end up with the exec'd task landing on one of
the polling or latency sensitive cores.

In a telco deployment the applications will run containers with
isolated(pinned) cpus with load balacning disabled.  These
containers typically use one of these cpus for its "housekeeping"
with the remainder used for the latency sensitive workloads.

Also, this is a change in kernel behavior which is breaking
userspace.

We are also hitting this and are interested in a way to get the
old behavior back for some workloads.

> > With the introduction of kernel cmdline param 'sched_pick_firstcpu',
> > there is an option provided for such usecases to disable the distribution
> > of tasks within the cpumask logic and use the previous 'pick first cpu'
> > approach for initial placement of tasks. Because many telco vendors
> > configure the system in such a way that the first cpu within a cpuset
> > of pod doesn't run any SCHED_FIFO or High priority tasks.
> > 
> > Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> > ---
> >  lib/cpumask.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > index e77ee9d46f71..3dea87d5ec1f 100644
> > --- a/lib/cpumask.c
> > +++ b/lib/cpumask.c
> > @@ -154,6 +154,23 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
> >  }
> >  EXPORT_SYMBOL(cpumask_local_spread);
> >  
> > +/*
> > + * Task distribution within the cpumask feature disabled?
> > + */
> > +static bool cpumask_pick_firstcpu __read_mostly;
> > +
> > +/*
> > + * Disable Tasks distribution within the cpumask feature
> > + */
> > +static int __init cpumask_pick_firstcpu_setup(char *str)
> > +{
> > +	cpumask_pick_firstcpu = 1;
> > +	pr_info("cpumask: Tasks distribution within cpumask is disabled.");
> > +	return 1;
> > +}
> > +
> > +__setup("sched_pick_firstcpu", cpumask_pick_firstcpu_setup);
> > +
> >  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
> >  
> >  /**
> > @@ -171,6 +188,13 @@ unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
> >  {
> >  	unsigned int next, prev;
> >  
> > +	/*
> > +	 * Don't distribute, if tasks distribution
> > +	 * within cpumask feature is disabled
> > +	 */
> > +	if (cpumask_pick_firstcpu)
> > +		return cpumask_any_and(src1p, src2p);
> 
> No, this is a wrong way.
> 
> To begin with, this parameter shouldn't control a single random
> function. At least, the other cpumask_*_distribute() should be
> consistent to the policy.
> 
> But in general... I don't think we should do things like that at all.
> Cpumask API is a simple and plain wrapper around bitmaps. If you want
> to modify a behavior of the scheduler, you could do that at scheduler
> level, not in a random helper function.
> 
> Consider 2 cases:
>  - Someone unrelated to scheduler would use the same helper and will
>    be affected by this parameter inadvertently.
>  - Scheduler will switch to using another function to distribute CPUs,
>    and your setups will suddenly get broken again. This time deeply in
>    production.
>

Yeah, I think I agree with this part.  At the scheduler level, where this
is called, makes more sense. 

Note, this is "deeply in production" now...


Cheers,
Phil

> Thanks,
> Yury
> 
> >  	/* NOTE: our first selection will skip 0. */
> >  	prev = __this_cpu_read(distribute_cpu_mask_prev);
> >  
> > -- 
> > 2.23.1
> 

-- 


