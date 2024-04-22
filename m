Return-Path: <linux-kernel+bounces-153877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE5D8AD466
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187751F21F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50405154C16;
	Mon, 22 Apr 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj+RWBe6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF6154457
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811917; cv=none; b=ZPhRP6Xcj5vSP91dlWsGFY6LkqWDQiSdSUUPWNvNg5TzbG5EDH3arBBvjVB7O6E8olxvrm62fyzFv7wuoRqY1OJoMdyTpIes8C0oIkRC/oNOReiu/Wcq/j7b4TwXG1SMNVcAMYsCtplRUJXEfGU6IIIDwOE4GdWk4t7f7a/TaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811917; c=relaxed/simple;
	bh=Npe9xd5S0rPgm2NV6+Rs1YLRrrTIYtT6qlcJ2f5OsPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMyAi6riJOeo2B0Q+aPbE4CB3ELgDvOGJEmPCtuMV1TgetLJTIh8p14rP7u/1p1CflRYk1FafHc6N1Tt0IRrT46ygWSabg9k6ZDZwnPJ1jfXlN+WVdk+ZsZtQhxhIOGmEQ4BBTZkTxXV25XMSQluXw//N3U5a+XTHJ2KMHi7uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zj+RWBe6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713811914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VK+D3Uvm1YZ6+pyXxrix2iQ3rB+y0gR1F4i+g5DM+5E=;
	b=Zj+RWBe6qxyr1btcgTlS+kW+NxfWDiiMUiKzdiepGNtG408o/wpLC8kfgSII0YQ6KCzhqE
	d6wphI7anw5lgqOzWd6gbADqLTgDB0bEUXCXad14o+GuM2xB7gQ/HIYnsV6aTJDko5hBtS
	7+YNCDzMu0olBMX30FF4Sxz1/L1qfjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-E6EwsxOdN-mR3zUgKfWyKA-1; Mon, 22 Apr 2024 14:51:51 -0400
X-MC-Unique: E6EwsxOdN-mR3zUgKfWyKA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8BEC887C44;
	Mon, 22 Apr 2024 18:51:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by smtp.corp.redhat.com (Postfix) with SMTP id 41BE340C465;
	Mon, 22 Apr 2024 18:51:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Apr 2024 20:50:26 +0200 (CEST)
Date: Mon, 22 Apr 2024 20:50:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Phil Auld <pauld@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH] sched/isolation: fix boot crash when the boot CPU is
 nohz_full
Message-ID: <20240422184934.GC32422@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
 <20240418145002.GC29188@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418145002.GC29188@lorien.usersys.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Phil, Frederic,

Thanks for your review! Who do you think can take these patches?
At least the 1st one.

To remind, there are more problems with boot CPU in nohz mask, but
can we at least fix the kernel crash?

Oleg.

On 04/18, Phil Auld wrote:
>
> On Thu, Apr 11, 2024 at 04:39:05PM +0200 Oleg Nesterov wrote:
> > Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> > include the boot CPU, this is no longer true after the commit 08ae95f4fd3b
> > ("nohz_full: Allow the boot CPU to be nohz_full").
> >
> > However after another commit aae17ebb53cd ("workqueue: Avoid using isolated
> > cpus' timers on queue_delayed_work") the kernel will crash at boot time in
> > this case; housekeeping_any_cpu() returns an invalid cpu nr until smp_init()
> > paths bring the 1st housekeeping CPU up.
> >
> > Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
> > return smp_processor_id() in this case. Yes, this is just the simple and
> > backportable workaround which fixes the symptom, but smp_processor_id() at
> > boot time should be safe at least for type == HK_TYPE_TIMER, this more or
> > less matches the tick_do_timer_boot_cpu logic.
> >
> > We should not worry about cpu_down(); tick_nohz_cpu_down() will not allow
> > to offline tick_do_timer_cpu (the 1st online housekeeping CPU).
> >
> > Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
> > Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
> > Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> Checking the returned value instead of assuming seems safer in any case.
>
> Reviewed-by: Phil Auld <pauld@redhat.com>
>
> > ---
> >  Documentation/timers/no_hz.rst |  7 ++-----
> >  kernel/sched/isolation.c       | 11 ++++++++++-
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
> > index f8786be15183..7fe8ef9718d8 100644
> > --- a/Documentation/timers/no_hz.rst
> > +++ b/Documentation/timers/no_hz.rst
> > @@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
> >  online to handle timekeeping tasks in order to ensure that system
> >  calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
> >  (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
> > -user processes to observe slight drifts in clock rate.)  Therefore, the
> > -boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > -"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > -error message, and the boot CPU will be removed from the mask.  Note that
> > -this means that your system must have at least two CPUs in order for
> > +user processes to observe slight drifts in clock rate.) Note that this
> > +means that your system must have at least two CPUs in order for
> >  CONFIG_NO_HZ_FULL=y to do anything for you.
> >
> >  Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 373d42c707bc..2a262d3ecb3d 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -46,7 +46,16 @@ int housekeeping_any_cpu(enum hk_type type)
> >  			if (cpu < nr_cpu_ids)
> >  				return cpu;
> >
> > -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			if (likely(cpu < nr_cpu_ids))
> > +				return cpu;
> > +			/*
> > +			 * Unless we have another problem this can only happen
> > +			 * at boot time before start_secondary() brings the 1st
> > +			 * housekeeping CPU up.
> > +			 */
> > +			WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
> > +				     type != HK_TYPE_TIMER);
> >  		}
> >  	}
> >  	return smp_processor_id();
> > --
> > 2.25.1.362.g51ebf55
> >
> >
> >
>
> --
>


