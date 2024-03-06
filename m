Return-Path: <linux-kernel+bounces-94266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC8873C35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD4D1C23C34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035A13793D;
	Wed,  6 Mar 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhZld4lG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA6137927;
	Wed,  6 Mar 2024 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742430; cv=none; b=UiqHFEWsjS9+U/DSAEBp2MZlhWFKpksXn8VWzEFXPpwaPiOUslY+sebuwYdlL666q6UYebRn3wF3rOuVJmNubAi2Ui8QXfJoa4AVgfS3j5jNl/I87DhukLHp0/CNMPHCsChHEv+Sf5EyPMaijl071W1VY/bomLikeC9cwHzhs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742430; c=relaxed/simple;
	bh=mST0baNuDZQDxdlBh3gFG3t11nxhv4188xlTctM8KAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4l08d/VMcu+rO5DdqUhcDeAKa54zxY6W0GJfRR0pemUxw/JBcWc0Wf3Z8ii57jj4dkwDktSVO0ZRjc+VgWKOaEprMwgc7Cx0rqU6msdZa+iIJFfzocGPWDHV4Hn+e1hWdxF6Ikwt30YVTfEcphzkSPrm/QYTjgSwVS22NcgQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhZld4lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0319C43394;
	Wed,  6 Mar 2024 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742430;
	bh=mST0baNuDZQDxdlBh3gFG3t11nxhv4188xlTctM8KAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhZld4lG7GINhc9K+uHkPNx96orLDEa10TFZ8fEVhsgtrQGnohY+sjOGAJeqHRUk0
	 EunhC94QsqjPcgQJIBoTGD+jl+/oBLty/HOXPxhSDDx0ILhdXmjg3OV4oqSyBifmEg
	 fx8vh9KvS7IBDFmGCka2nhjMkPRLCctoO2ukJYxMlSqD0OGibw+RXKhWQxdT/CmCPX
	 dKHXpLknEXw4ezT7k+4mUhxBxC+BbY9q94jfHImJVTIAC76bg+YAPhzQeVuK8VH4el
	 VjK/aIAMMvuaG0KfflRxexmg7SG8eKGpm0uULUJyAotL8fN0VJ7N/BS9hTPX0DE24s
	 NoWoYQntpKEkw==
Date: Wed, 6 Mar 2024 13:27:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>, linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <ZeiZWjRUmXszp0CN@x1>
References: <ZdZOYnIkjqkyfo5P@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdZOYnIkjqkyfo5P@x1>

On Wed, Mar 06, 2024 at 10:06:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > In Thu, 4 Jan 2024 19:35:57 -0300, Arnaldo Carvalho de Melo wrote:
> > > +++ b/kernel/events/core.c
> > > @@ -6801,7 +6801,7 @@ static void perf_pending_task(struct callback_head *head)
> > >         * If we 'fail' here, that's OK, it means recursion is already disabled
> > >         * and we won't recurse 'further'.
> > >         */
> > >-       preempt_disable_notrace();
> > >+       migrate_disable();
> > >        rctx = perf_swevent_get_recursion_context();
>  
> > Pardon my ignorance, is it safe to call preempt_count() with preemption
> > enabled on PREEMPT_RT, or at least in the context being discussed here?
>  
> > Because:
>  
> > 	 perf_swevent_get_recursion_context()
> > 	     get_recursion_context()
> >                  interrupt_context_level()
> >                      preempt_count()	
>  
> > And:
>  
> > int perf_swevent_get_recursion_context(void)
> > {
> >         struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
> > 
> >         return get_recursion_context(swhash->recursion);
> > }
> 
> Seems to be enough because perf_pending_task is a irq_work callback and

s/irq_work/task_work/ but that also doesn't reentry, I think

> that is guaranteed not to reentry?
> 
> Artem's tests with a RHEL kernel seems to indicate that, ditto for my,
> will test with upstream linux-6.8.y-rt.
> 
> But there is a lot more happening in perf_sigtrap and I'm not sure if
> the irq_work callback gets preempted we would not race with something
> else.
> 
> Marco, Mike, ideas?

Looking at:

commit ca6c21327c6af02b7eec31ce4b9a740a18c6c13f
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Oct 6 15:00:39 2022 +0200

    perf: Fix missing SIGTRAPs
    
    Marco reported:
    
    Due to the implementation of how SIGTRAP are delivered if
    perf_event_attr::sigtrap is set, we've noticed 3 issues:
    
      1. Missing SIGTRAP due to a race with event_sched_out() (more
         details below).
    
      2. Hardware PMU events being disabled due to returning 1 from
         perf_event_overflow(). The only way to re-enable the event is
         for user space to first "properly" disable the event and then
         re-enable it.
    
      3. The inability to automatically disable an event after a
         specified number of overflows via PERF_EVENT_IOC_REFRESH.
    
    The worst of the 3 issues is problem (1), which occurs when a
    pending_disable is "consumed" by a racing event_sched_out(), observed
    as follows:

-------------------------------------------------------------

That its what introduces perf_pending_task(), I'm now unsure we can just
disable migration, as event_sched_out() seems to require being called
under a raw_spin_lock and that disables preemption...

- Arnaldo

