Return-Path: <linux-kernel+bounces-158443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D88B2033
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6BB1F2289C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0412AACA;
	Thu, 25 Apr 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXQU9aim"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324F12AAC4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044552; cv=none; b=J1xm6UsoJnRgcFBHIHRTmOMdMv662EHcr4R+3ocHSCE1+KmQdREm39ezNoip2YLfh9MDuLmngzO1SnRZNgPz0V6FE5ZgmTZgqxMvY8HAnKYeEZ9uUXAGOBdXevAbI+g5n4JdZCiEQTKFrmdX7vtVMMv9FTcIweAJEfsntRkqzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044552; c=relaxed/simple;
	bh=EotpqrOTCgxv/fcwPtWq0HslLgdSIeDoKLBq2nO36gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlhzTEC6k+/U4nChjrmInThHSwrYIfXv2ZOqi7oC0kgQJkFHh/xD4r3cDCpyr3g1MbkoQv3MaDP2L5L7Zx1pEoX61mxgRI9JnF3NiiJ9+CsbCqv1X1e5qQSYEXQm0Hsu7UUxbXBIi+TVDGbtiMyMHwQFqymLFIHpLbP3iOcY6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CXQU9aim; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LucgZsZ2fF1q3sR6F54UyCTR1dPpRoPMHDd0YAuRUvo=; b=CXQU9aimWDuO+U40QmpbKD9IcQ
	+Ld66VDCp4qb61vF9gpeawozVsbjOqRLtb/ptV4UE9qVwT8SMdx9e/aBLcgmhsqQAvJXkqZe/bZrW
	dnS8C1YsWn35J9URgOUA8pH9QjoRG2FpL2AZOtJmWTe1e2XpWZBHToPL8S8CFYHOlbuSvNXC+p/ES
	tvUT8Be6m+24MXCpAanuRtZ7yji3NBn7/3ObLHGkSyn3/Dz5SViFEKNySIvDaDzw6bFuCudctHMiV
	S4QS4VbZrW6blMUIBhB7YfCbmcOgYTap/ZtNbBY+AsBe1DSW+6JmeC8Ww9V44UFCZEEXQum2soge1
	K+UlOSjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzxHb-0000000EqUK-2lh6;
	Thu, 25 Apr 2024 11:28:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 51B6D300439; Thu, 25 Apr 2024 13:28:55 +0200 (CEST)
Date: Thu, 25 Apr 2024 13:28:55 +0200
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
Message-ID: <20240425112855.GF21980@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>

On Thu, Apr 18, 2024 at 06:24:59PM +0200, Mike Galbraith wrote:
> The root cause seems to be doing the delay dequeue business on
> exiting tasks. 

> ---
>  kernel/sched/fair.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5374,6 +5374,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  		update_curr(cfs_rq);
> 
>  		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !(entity_is_task(se) && (task_of(se)->flags & PF_EXITING)) &&
>  		    !entity_eligible(cfs_rq, se)) {
>  			if (cfs_rq->next == se)
>  				cfs_rq->next = NULL;

So I think this can be easier done in dequeue_task_fair(), where we
still know this is a task.

Perhaps something like (I'll test later):

	if (p->flags & PF_EXITING)
		flags &= ~DEQUEUE_SLEEP;

But now I need to go think about the case of removing a cgroup...
*urgh*.

