Return-Path: <linux-kernel+bounces-165501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45A08B8D54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C36E1F211A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569012FB06;
	Wed,  1 May 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwRkcnqz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71B5024E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577987; cv=none; b=WLThm7iDo6elifD3ao8yHZrMQtglXR26n0Jyr1fkbvdqOCLsQDL6kjgS8ScN0uDLbb1DIXnw6ZPbNvOdKMeYxqeCSCbFL1WnLPAUdYuhUZRt9SHP2n6r5+dRB1y15JGJ7j/K5a0XMIgMQ5DNGSAnKGees0IXtAHXBJ603RsO2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577987; c=relaxed/simple;
	bh=TXnlRUd4wzTg+J3RDLQaov6hXIMql18Rm1XlXmIxRJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxAjQkXedU/5elsRgZyGGuuH7aB5A9xNYDK9yc9DEFOjomiI6+9oGoCmYW873cDXLiWFKgaGA5jPzQpgUDaR0u8KgRtKJMbIgesCOax1izjRb7wDdu6KoM6b83TtN9hSoQY7/iNcdgtSv3C8y1dldBp+6ztjGA1LnG4wnnOHiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwRkcnqz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714577984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HEIRVOOxs9+Z4JyFqDhStdwNE4nDa7vmALaBzUWy5c=;
	b=gwRkcnqzQNoKA/c/sIYzp3400oK8EH+TUh6785N12gTORtrOE/Ki1lcZmxLS5vy5d2O1ep
	Dq72c4kPn69HTtIiBmEq8Kcqc0VkkxVEW7w93XSjBsyfpk7cgPzMrDQ+LcbWkY9/EKiin6
	xbSUaVPLFrXpog1ZKOYQJtSHrEUKCIE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-sC1vH30zMqy-tC0TGZzU7g-1; Wed,
 01 May 2024 11:39:36 -0400
X-MC-Unique: sC1vH30zMqy-tC0TGZzU7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 839D0385A185;
	Wed,  1 May 2024 15:39:19 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C8511C0654E;
	Wed,  1 May 2024 15:39:14 +0000 (UTC)
Date: Wed, 1 May 2024 11:39:11 -0400
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
Message-ID: <20240501153911.GD39737@lorien.usersys.redhat.com>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
 <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
 <20240501133608.GB39737@lorien.usersys.redhat.com>
 <ZjJfftWMbjT9r8iT@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJfftWMbjT9r8iT@yury-ThinkPad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, May 01, 2024 at 08:27:58AM -0700 Yury Norov wrote:
> On Wed, May 01, 2024 at 09:36:08AM -0400, Phil Auld wrote:
> > 
> > Hi Yuri,
> 
> [...]
>  
> > > Not that I'm familiar to your setup, but this sounds like a userspace
> > > configuration problems. Can you try to move your non-RT tasks into a
> > > cgroup attached to non-RT CPUs, or something like that? 
> > >
> > 
> > It's not really. In a container environment just logging in to the
> > container could end up with the exec'd task landing on one of
> > the polling or latency sensitive cores.
> > 
> > In a telco deployment the applications will run containers with
> > isolated(pinned) cpus with load balacning disabled.  These
> > containers typically use one of these cpus for its "housekeeping"
> > with the remainder used for the latency sensitive workloads.
> > 
> > Also, this is a change in kernel behavior which is breaking
> > userspace.
> 
> Alright, that's a different story.
>

It's a specific edge case. I'd prefer to push for a forward solution
than revert. 

> > We are also hitting this and are interested in a way to get the
> > old behavior back for some workloads.
> > 
> > > > With the introduction of kernel cmdline param 'sched_pick_firstcpu',
> > > > there is an option provided for such usecases to disable the distribution
> > > > of tasks within the cpumask logic and use the previous 'pick first cpu'
> > > > approach for initial placement of tasks. Because many telco vendors
> > > > configure the system in such a way that the first cpu within a cpuset
> > > > of pod doesn't run any SCHED_FIFO or High priority tasks.
> > > > 
> > > > Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > > > Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
> > > > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
> > > > ---
> > > >  lib/cpumask.c | 24 ++++++++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > > 
> > > > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > > > index e77ee9d46f71..3dea87d5ec1f 100644
> > > > --- a/lib/cpumask.c
> > > > +++ b/lib/cpumask.c
> > > > @@ -154,6 +154,23 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
> > > >  }
> > > >  EXPORT_SYMBOL(cpumask_local_spread);
> > > >  
> > > > +/*
> > > > + * Task distribution within the cpumask feature disabled?
> > > > + */
> > > > +static bool cpumask_pick_firstcpu __read_mostly;
> > > > +
> > > > +/*
> > > > + * Disable Tasks distribution within the cpumask feature
> > > > + */
> > > > +static int __init cpumask_pick_firstcpu_setup(char *str)
> > > > +{
> > > > +	cpumask_pick_firstcpu = 1;
> > > > +	pr_info("cpumask: Tasks distribution within cpumask is disabled.");
> > > > +	return 1;
> > > > +}
> > > > +
> > > > +__setup("sched_pick_firstcpu", cpumask_pick_firstcpu_setup);
> > > > +
> > > >  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
> > > >  
> > > >  /**
> > > > @@ -171,6 +188,13 @@ unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
> > > >  {
> > > >  	unsigned int next, prev;
> > > >  
> > > > +	/*
> > > > +	 * Don't distribute, if tasks distribution
> > > > +	 * within cpumask feature is disabled
> > > > +	 */
> > > > +	if (cpumask_pick_firstcpu)
> > > > +		return cpumask_any_and(src1p, src2p);
> > > 
> > > No, this is a wrong way.
> > > 
> > > To begin with, this parameter shouldn't control a single random
> > > function. At least, the other cpumask_*_distribute() should be
> > > consistent to the policy.
> > > 
> > > But in general... I don't think we should do things like that at all.
> > > Cpumask API is a simple and plain wrapper around bitmaps. If you want
> > > to modify a behavior of the scheduler, you could do that at scheduler
> > > level, not in a random helper function.
> > > 
> > > Consider 2 cases:
> > >  - Someone unrelated to scheduler would use the same helper and will
> > >    be affected by this parameter inadvertently.
> > >  - Scheduler will switch to using another function to distribute CPUs,
> > >    and your setups will suddenly get broken again. This time deeply in
> > >    production.
> > >
> > 
> > Yeah, I think I agree with this part.  At the scheduler level, where this
> > is called, makes more sense. 
> > 
> > Note, this is "deeply in production" now...
> 
> So, if we all agree that touching cpumasks is a bad idea, let's drop
> this patch and try figuring out a better solution.
> 
> Now that you're saying the scheduler patches break userspace, I think
> it would be legitimate to revert them, unless there's a simple fix for
> that.

As I said above let's try to go forward if we can. I'd argue that relying
on the old first cpu selection is not really an API, or documented so I
don't think a revert is needed.

I think a static key at the one or two places _distribute() is used
in the scheduler (and workqueue?) code would have the same effect as
this and be a better fit. 


Cheers,
Phil

> 
> Let's see what the folks will say. Please keep me in CC.
> 
> Thanks,
> Yury
> 

-- 


