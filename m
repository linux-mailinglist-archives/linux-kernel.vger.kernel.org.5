Return-Path: <linux-kernel+bounces-159932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0B8B366E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6A283C35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D332144D34;
	Fri, 26 Apr 2024 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sGxJELTS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51F13A3EE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130182; cv=none; b=hHReHCQOfch2+Ma+FQksKzOFPeT4+Fzzn2NUlAJMehI07kxBE8pbkUYuYQzHPWs2ffCGu4E4uWUAcSp0DHdnWXcMDzzz7Kh6PtuAv9BbCPvDsqw6bm35z/GEJNIpg8GLlhwMpSEupLcV/DJmEX/XO5dviuZRIvDKv2HtnH5L3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130182; c=relaxed/simple;
	bh=rE9wLg38vM1yDvFUcKM7QJodi/DAwDGZtS2uKW3mPwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdfL/AxXxb+xeA1m7gB0Fo/BHO3ajHWMiL2vnsdEif9RoZouY2hoB6JS+DlkI4pJC1pY5d1rHtf3jWMV+42aakhkzifYVHl2qBOK8kvD72p7/DsgM/mWpnsbWHIPa7WDQ/pLW/rZsvLe2qLzWHCJi9rL3vfEGwL5yRj06aUWkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sGxJELTS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mBA6rZh9cdabUwthmH3eGc9q1nFfHeMVQ11XQocbX6U=; b=sGxJELTSPMWo4v1r3JjqL1I5t4
	2jZfBpTGNFpikglfp2PMQD6SoFeMpRQzLFo3HWdRSPTz+3kATadu/alCaJmu7VN5y4HQ4Csj6ZZVT
	iKUo6BZrbHix05Ca4VdABFpVs/UsgGUUOXqMwDVTcsE6GQckZEG9x7BLz9aMCTn5vrpOlmsu+sqvL
	dJzP6VFsGh72zmnXdBzaFAR6m1fdgLhauP1U6YwX7V5c3VsKT1z94p4NNFIisGqnQ+GBWgJE3pbd1
	ITKHy50aT6K90b6HHmdvpPREbNctj8hdtRE8z2V7Wb/XAtSumyVaomudPzwiFnBIyKqgcVMPPGicb
	sydYdVNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JYl-0000000557k-3ccs;
	Fri, 26 Apr 2024 11:16:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 838DC30046F; Fri, 26 Apr 2024 13:16:07 +0200 (CEST)
Date: Fri, 26 Apr 2024 13:16:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	tglx@linutronix.de, Chen Yu <yu.c.chen@intel.com>,
	Oliver Sang <oliver.sang@intel.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240426111607.GL12673@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
 <20240425112855.GF21980@noisy.programming.kicks-ass.net>
 <20240426105607.GK12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426105607.GK12673@noisy.programming.kicks-ass.net>

On Fri, Apr 26, 2024 at 12:56:07PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 01:28:55PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 18, 2024 at 06:24:59PM +0200, Mike Galbraith wrote:
> > > The root cause seems to be doing the delay dequeue business on
> > > exiting tasks. 
> > 
> > > ---
> > >  kernel/sched/fair.c |    5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5374,6 +5374,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > >  		update_curr(cfs_rq);
> > > 
> > >  		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> > > +		    !(entity_is_task(se) && (task_of(se)->flags & PF_EXITING)) &&
> > >  		    !entity_eligible(cfs_rq, se)) {
> > >  			if (cfs_rq->next == se)
> > >  				cfs_rq->next = NULL;
> > 
> > So I think this can be easier done in dequeue_task_fair(), where we
> > still know this is a task.
> > 
> > Perhaps something like (I'll test later):
> > 
> > 	if (p->flags & PF_EXITING)
> > 		flags &= ~DEQUEUE_SLEEP;
> > 
> > But now I need to go think about the case of removing a cgroup...
> > *urgh*.
> 
> I ended up with the below instead; lemme go run this unixbench spawn on it.

Seems to survive that.

I pushed out the patches with updates to queue/sched/eevdf

