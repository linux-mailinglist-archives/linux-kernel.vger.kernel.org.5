Return-Path: <linux-kernel+bounces-93947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A7873759
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322251C24A11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47409130AEB;
	Wed,  6 Mar 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9NrWTTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30512D743;
	Wed,  6 Mar 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730395; cv=none; b=rcqXo1tYLxrQAUIRFJOBZXoRswvp2QRrluT61yas9a/50NGvENxs2BoI7KuRjV6pm8kYtKZ8nIt1fNTviw8hiHtKYgvafAsTHfkxoxX2wwjT8EuSWOkH0M0GRLkHSwc5i9P4Vr2jLQ/a1lkIzp7lgi56NwWWix9SD54OAG1TLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730395; c=relaxed/simple;
	bh=tVPYOqEf/BMupl31Fq6WbwWC0XQISuwiP322VIiaoYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q0R0RFK7T5YabmfuA05M5dbJNjUWa9jwq3iKunGBPue+IfzCmycQ+Uttw8Z4zJ6U4Fh8FHtHPgmHcZiW54JjM0PLOZTpEE2iXVM5c+Hyi8iMbbaiMmBgVeDLMqQl+rDqX1l6gMTn/2tL3bq5VHs7225P1cl3XalHa6iBdK2AP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9NrWTTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B660C433C7;
	Wed,  6 Mar 2024 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730395;
	bh=tVPYOqEf/BMupl31Fq6WbwWC0XQISuwiP322VIiaoYg=;
	h=Date:From:To:Cc:Subject:From;
	b=p9NrWTTtJhWnN7aijaYw/i7mctmNAnupV50TR//sAugSCZDggENjpRMWIwhYy9FxO
	 LNvs31LyTJ6+AY4UFaBdpseJDLsqEOqB0+aYyCZ0JzP78iBq8cMwoh1nY1RcU132pW
	 3j5EFhvsRq+2L4aVZ78ETXbhHS9EUQi0ni7Xbu4FWpL/Dv4G68Ch9gROiVsN9iMDaz
	 gAMzPjoyet7We5UEzS2W1eQu1vWfgRDx9Jsxmashc94YYRPhnFhP7QHEEZ94HlHxng
	 Y7bzVbbTwPV9jzEcNNAQM+9dcdn9v96Y8xStiyTStZGFAafu7//mpD+PIYVOR9SERe
	 eu0lckQ5lCI6Q==
Date: Wed, 6 Mar 2024 10:06:30 -0300
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
Message-ID: <ZdZOYnIkjqkyfo5P@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

> In Thu, 4 Jan 2024 19:35:57 -0300, Arnaldo Carvalho de Melo wrote:
> > +++ b/kernel/events/core.c
> > @@ -6801,7 +6801,7 @@ static void perf_pending_task(struct callback_head *head)
> >         * If we 'fail' here, that's OK, it means recursion is already disabled
> >         * and we won't recurse 'further'.
> >         */
> >-       preempt_disable_notrace();
> >+       migrate_disable();
> >        rctx = perf_swevent_get_recursion_context();
 
> Pardon my ignorance, is it safe to call preempt_count() with preemption
> enabled on PREEMPT_RT, or at least in the context being discussed here?
 
> Because:
 
> 	 perf_swevent_get_recursion_context()
> 	     get_recursion_context()
>                  interrupt_context_level()
>                      preempt_count()	
 
> And:
 
> int perf_swevent_get_recursion_context(void)
> {
>         struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
> 
>         return get_recursion_context(swhash->recursion);
> }

Seems to be enough because perf_pending_task is a irq_work callback and
that is guaranteed not to reentry?

Artem's tests with a RHEL kernel seems to indicate that, ditto for my,
will test with upstream linux-6.8.y-rt.

But there is a lot more happening in perf_sigtrap and I'm not sure if
the irq_work callback gets preempted we would not race with something
else.

Marco, Mike, ideas?

- Arnaldo
 
> >         if (event->pending_work) {
> > @@ -6812,7 +6812,7 @@ static void perf_pending_task(struct callback_head *head)
>  
> >        if (rctx >= 0)
> >                 perf_swevent_put_recursion_context(rctx);
> > -       preempt_enable_notrace();
> > +       migrate_enable();
>  
> >         put_event(event);
> >  }
> > [acme@nine linux]$ uname -a
> > Linux nine 6.7.0-rc5-rt5.sigtrap-fix-dirty #2 SMP PREEMPT_RT Thu Jan  4 18:11:44 -03 2024 x86_64 x86_64 x86_64 GNU/Linux
> > [acme@nine linux]$ sudo su -
> > [sudo] password for acme: 
> > [root@nine ~]# 
> > [root@nine ~]# perf test sigtrap
> >  68: Sigtrap                                                         : Ok
> > [root@nine ~]# 
> > [root@nine ~]# perf probe -L perf_pending_task
> > <perf_pending_task@/home/acme/git/linux/kernel/events/core.c:0>
> >       0  static void perf_pending_task(struct callback_head *head)
> >          {
> >       2         struct perf_event *event = container_of(head, struct perf_event, pending_task);
> >       3         int rctx;
>        
> >                 /*
> >                  * If we 'fail' here, that's OK, it means recursion is already disabled
> >                  * and we won't recurse 'further'.
> >                  */
> >                 migrate_disable();
> >      10         rctx = perf_swevent_get_recursion_context();
> >         
> >      12         if (event->pending_work) {
> >      13                 event->pending_work = 0;
> >      14                 perf_sigtrap(event);
> >      15                 local_dec(&event->ctx->nr_pending);
> >                 }
> >         
> >      18         if (rctx >= 0)
> >      19                 perf_swevent_put_recursion_context(rctx);
> >      20         migrate_enable();
>      
> >      22         put_event(event);
> >          }
>          
> >          #ifdef CONFIG_GUEST_PERF_EVENTS
> 
> > [root@nine ~]# perf probe perf_pending_task
> > Added new event:
> >   probe:perf_pending_task (on perf_pending_task)
> 
> > You can now use it in all perf tools, such as:
> 
> > 	perf record -e probe:perf_pending_task -aR sleep 1
> 
> > [root@nine ~]# perf trace --max-events=1 -e probe:perf_pending_task/max-stack=6/ perf test sigtrap 
> >  68: Sigtrap                                                         : Ok
> >      0.000 :9608/9608 probe:perf_pending_task(__probe_ip: -2064408784)
> >                                        perf_pending_task ([kernel.kallsyms])
> >                                        task_work_run ([kernel.kallsyms])
> >                                        exit_to_user_mode_loop ([kernel.kallsyms])
> >                                        exit_to_user_mode_prepare ([kernel.kallsyms])
> >                                        irqentry_exit_to_user_mode ([kernel.kallsyms])
> >                                        asm_sysvec_irq_work ([kernel.kallsyms])
> > [root@nine ~]#
> 
> > [root@nine ~]# head -5 /etc/os-release
> > NAME="Red Hat Enterprise Linux"
> > VERSION="9.2 (Plow)"
> > ID="rhel"
> > ID_LIKE="fedora"
> > VERSION_ID="9.2"
> > [root@nine ~]#
> 
> > I did the test without the above patch and the original problem is
> > reproduced.
>  
> > > This is also used in perf_pending_irq() and on PREEMPT_RT this is
> > > invoked from softirq context which is preemptible.
> 
> Humm, and then when going thru perf_pending_irq() we don't hit that
> scheduling on atomic.
> 
> - Arnaldo

