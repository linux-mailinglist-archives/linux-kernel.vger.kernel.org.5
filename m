Return-Path: <linux-kernel+bounces-166408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F98B9A38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F95B2811CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C4664DD;
	Thu,  2 May 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPeBQVcr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AE63C7
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650345; cv=none; b=c7FWedD9X+xjx6bZhYavdkywPLPI4YQQxHIxmyO+g/g5JUnQMUmq1jssxcyJZoUbZeYXJYA93YT4V4z8wk068c5sj+rj8XLi0T0DQ2ps+xB2bz0Q342+eHJkCQgBsiTQY2wCqbFP2sAW2MqaqsYnF2nOovRwmilXg/lzq55SsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650345; c=relaxed/simple;
	bh=s2tUSZPBGC8x+4ifPMESmhlbdPvFWhRJ+en/QLgU7hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgJkQhM1mL7d6ihaA4mvb58XmgscGpbZUNrAqLsxAmfWu05cXVsZzl5laF2Zjg8TeGsq3KGGerybk025flEjcxuovSB2bTiwcOZPM9Ts2KwWlYs0MoFR6gIyb+Alm0j88lTLMlvDLtlwp1tdluulDBdKSJILtZ304mWa3mhqWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPeBQVcr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714650343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=blUl2qJx9ram7fhnnzGyThINz/XZwJLDlyy9nK5U8pQ=;
	b=fPeBQVcrIPU4wy4hHAKdZimByaPt12BUBrt8NnZfiidAhkVIlZxiMihUmdUcOiYLk9ORAe
	bCOfeesrODLoCcYi+016kIgiV+4n6XA8ukf7D3YwUXy6+HsT5++D0LR5j0EM/LKPhZRr5H
	OlggIj2g20WuYHTJqnf1hP5iLRFIXxs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-7B9D8zc4MuKTdsKUOSz43Q-1; Thu,
 02 May 2024 07:45:40 -0400
X-MC-Unique: 7B9D8zc4MuKTdsKUOSz43Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28A67299E753;
	Thu,  2 May 2024 11:45:39 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C21C81C0654E;
	Thu,  2 May 2024 11:45:37 +0000 (UTC)
Date: Thu, 2 May 2024 07:45:35 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ankit Jain <ankit-aj.jain@broadcom.com>, linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] lib/cpumask: Boot option to disable tasks distribution
 within cpumask
Message-ID: <20240502114535.GA86496@lorien.usersys.redhat.com>
References: <20240430090431.1619622-1-ankit-aj.jain@broadcom.com>
 <ZjE3C9UgeZR02Jyy@yury-ThinkPad>
 <20240502084349.GW30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502084349.GW30852@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Peter,

On Thu, May 02, 2024 at 10:43:49AM +0200 Peter Zijlstra wrote:
> On Tue, Apr 30, 2024 at 11:23:07AM -0700, Yury Norov wrote:
> > On Tue, Apr 30, 2024 at 02:34:31PM +0530, Ankit Jain wrote:
> > > commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> > > and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> > > introduced the logic to distribute the tasks within cpumask upon initial
> > > wakeup.
> > 
> > So let's add the authors in CC list?
> > 
> > > For Telco RAN deployments, isolcpus are a necessity to cater to
> > > the requirement of low latency applications. These isolcpus are generally
> > > tickless so that high priority SCHED_FIFO tasks can execute without any
> > > OS jitter. Since load balancing is disabled on isocpus, any task
> > > which gets placed on these CPUs can not be migrated on its own.
> > > For RT applications to execute on isolcpus, a guaranteed kubernetes pod
> > > with all isolcpus becomes the requirement and these RT applications are
> > > affine to execute on a specific isolcpu within the kubernetes pod.
> > > However, there may be some non-RT tasks which could also schedule in the
> > > same kubernetes pod without being affine to any specific CPU(inherits the
> > > pod cpuset affinity).
> > 
> > OK... It looks like adding scheduler maintainers is also a necessity to
> > cater here...
> 
> So 14e292f8d453 is very specifically only using sched_domain_span(), and
> if you're using partitioned CPUs they should not show up there.
> 
> As to 46a87b3851f0, if you're explicitly creating tasks with an affinity
> masks that spans your partition then you're getting what you ask for.

I think you are skipping some details. We've also asked for no load
balancing and this spreading is a form of load balancing. So that's
not getting what was asked for.

And the tasks being created with this affinity are not being explicitly
created thusly. It's implicit. Anything exec'd into the container
(==cgroup with cpuset set) gets the cpu affinity spanning the cpus in
the container. There are layers. It's not someone using "taskset bash"
at a command prompt.

> 
> In fact, I already explained this to you earlier, so why are you
> suggesting horrible hacks again? This behaviour toggle you suggest is
> absolutely unacceptable.
> 
> I even explained what the problem was and where to look for solutions.
> 
> https://lkml.kernel.org/r/20231011135238.GG6337@noisy.programming.kicks-ass.net
>

I was not aware of the history here. Thanks. I'll look into that. At
first blush it's not obvious how that helps but I've been wrong before...


Cheers,
Phil

-- 


