Return-Path: <linux-kernel+bounces-166129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99298B969C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A86282682
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBE4654D;
	Thu,  2 May 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OhHr4/ia"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29101B299
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639441; cv=none; b=gF+VnKHQYbVsunR0ni1/2nSQD9/Eqj1bTPThVRqbDqXkPT8GwfZKTeqd7pu/46dMBQw5rjL88cWBwDYGHcTLlokLXi+WRheBSDxmtRlS33YO+PH6cFiYQKecbJBsSB9ZmyxKV8q89Dhz4tc4ecWWx3A9zwKLPg4AoJ8OuYmRbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639441; c=relaxed/simple;
	bh=pX8ilqARQV2Z90/pSS2jwuMRTtcQmuRJ3mVD8TOf5Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0FYBAb7ynh+8DvK4WeB/o/ayYOWv7TBtL6RW25c3DERy2m82uUxUJnytiozU++0JpxbDmDmUvUXzIoMKewaZNSLZlXiEM+tWh7ihEpFj31kYYaHDFsZkov2QNinFvH8+1/wMngumM3VZxf2Gxb+df7fiPN++Q2HGPFqPuZ+nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OhHr4/ia; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1GXxPgFfTdtpqT+LPQBFDbKrIYQ+i+pi0bFYs+txOK0=; b=OhHr4/iazFgToN2Kpoe2BWf5MU
	wy/wi6+9AQydxBVB9LIK4vSKpBjxGzaAdLrnAmyx3mx4m+I4/1nDBJN0KjCcuUmEOcy97OuxE5YXU
	lzfbinsqQ4sfqz//4n6VuFKrg0dfxapMMBXt3SJcMDbbKM/fXYr88ezD6K1MF2MKej7SYRuv61XWq
	6SMIW2hPbKrTcN9Z+4NFgOquJB8wiUGTOGAT8AF80HJwKErVUtwhwNFTEyE4IvQChGrb2R9Nj/qkV
	0EDyOo45LxCKnBH1nZTnBMLXQPi5jVyp8xmGLh6XymAaCBMTIlqUhMnldmM4oATBKhh4rvZ+BzWOD
	VREOb/oQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2S2f-00000001HTK-3qWe;
	Thu, 02 May 2024 08:43:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9084330057A; Thu,  2 May 2024 10:43:49 +0200 (CEST)
Date: Thu, 2 May 2024 10:43:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Ankit Jain <ankit-aj.jain@broadcom.com>, linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, pauld@redhat.com, ajay.kaher@broadcom.com,
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
Message-ID: <20240502084349.GW30852@noisy.programming.kicks-ass.net>
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

On Tue, Apr 30, 2024 at 11:23:07AM -0700, Yury Norov wrote:
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

So 14e292f8d453 is very specifically only using sched_domain_span(), and
if you're using partitioned CPUs they should not show up there.

As to 46a87b3851f0, if you're explicitly creating tasks with an affinity
masks that spans your partition then you're getting what you ask for.

In fact, I already explained this to you earlier, so why are you
suggesting horrible hacks again? This behaviour toggle you suggest is
absolutely unacceptable.

I even explained what the problem was and where to look for solutions.

https://lkml.kernel.org/r/20231011135238.GG6337@noisy.programming.kicks-ass.net


