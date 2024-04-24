Return-Path: <linux-kernel+bounces-157182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12008B0DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECF8B2A64F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D515FA76;
	Wed, 24 Apr 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mqMzFLk6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511C15EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972070; cv=none; b=NjrAvzAzi/doR2nkRWkJ02KiUxhL8IMCH0C0chHvkviFiRpqsmNc/Q726/KZk99TPPbrRjOuV8OkBYpkIu1sf/Vyyfl9sHsdAYbmr3fIw6eayoY2YXZHe1iqLoyOGTGxWVBOZmPnmfkBxUMnpp45TUzNWk1v/dzLIWeNHGl2Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972070; c=relaxed/simple;
	bh=q1exOMXTIOd9tdMTIymwsETDLgVuZhekuD/4BzdFroE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5EFV/wMfdRx6Dq0Jrt5ur+JWDgfeCzmwQRJg8xe/QovbZxEhgHM6rr75/YQHb51yOaqe/kXTACHbN+8JqbVSkwXubtX4aZ9xov9j1tKpCh0YnCyKa7AQk6fVT8EKQbHD4/nmfBbDva5H437rbSa88IGbu/iH4Zu2en59+FbyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mqMzFLk6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1BnmcBKajNjGf36OXNjueaNFKhQAlEqsZTRopkafH8Q=; b=mqMzFLk68bVQeWWZ2Z1gXeq8/U
	0A52ko5Kh63k6l4n6DrP9lI2V8jY4fk4viTtgGnyDRI1q40OsiNsmFJfqsTypbJUKMEG8o/Pp4fBv
	o5y/7PqJvNoESukcq/mYtmVJ5eSoQuDVplsod69b5nBZ1pEDwVTts6AJH0kdOgFiq3b2RFmcZJMLk
	2HQWjCJOL/rVgW0XqYkz04r9rbS2KJYFSHkOYA49B6GTnDwqibow5dYUJ+KtXwVaFX3wHZP+Y6Nvk
	lsQFtIKn649q2EITEWItFjCAODkXPpeEs+aGhheatzET3tibvn6C7Fz46G1OXjg7QBjHIxtGH5mf9
	DTXCrfJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzeQO-0000000EQr3-3BVc;
	Wed, 24 Apr 2024 15:20:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60D3E30040C; Wed, 24 Apr 2024 17:20:44 +0200 (CEST)
Date: Wed, 24 Apr 2024 17:20:44 +0200
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
Message-ID: <20240424152044.GS30852@noisy.programming.kicks-ass.net>
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
> Greetings,
> 
> I tossed a couple rocks at it today, and seem to have hit the little
> bugger.  The root cause seems to be doing the delay dequeue business on
> exiting tasks.  Hunk #1 of hacklet below seems to quell the explosions.
> 

Neat, Thanks! I was just about ready to go look at this again.

> 
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
> @@ -5495,14 +5496,14 @@ pick_next_entity(struct rq *rq, struct c
>  	}
> 
>  	struct sched_entity *se = pick_eevdf(cfs_rq);
> -	if (se->sched_delayed) {
> +	while (se && se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  		SCHED_WARN_ON(se->sched_delayed);
>  		SCHED_WARN_ON(se->on_rq);
>  		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
>  			se->vlag = 0;
> 
> -		return NULL;
> +		se = pick_eevdf(cfs_rq);
>  	}
>  	return se;
>  }
> 

