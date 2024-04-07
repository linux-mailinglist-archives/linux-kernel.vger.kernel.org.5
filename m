Return-Path: <linux-kernel+bounces-134511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6B89B260
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F1AB20CF3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C16381DE;
	Sun,  7 Apr 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNEuwH7k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F011720
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498068; cv=none; b=BJKmPUc41i2JS+0IteRvF4vZQ/6lh2V2QE6cq6pbFgSvNyDgNKT+XajLHQy1hYNAmIiswB9JaLNv+Q6uGxAwLVJweLjSdMoLD0pmRqVe/l/lfDuAWWozhIRHyCuNyqkcYWaPpdfKWxd1WzifX5mCVp8XEx5Fjw8MYb9dL8PcMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498068; c=relaxed/simple;
	bh=jxBqjjbPajszaEdq2fwpE6x+8A0oeppI3j2mrb+v9n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHnIyXCBSTh1ysOeNLSNimBiuswPHIN2oGAWkPC8ERCJXy2COlaON9RvYpRXx+IZm4MNJNo/5TVyfLPI9cFDs8BPhvFBSFnezOgsDOICFqiFjtyZ93f7mGo3uUA0lT/wP1FTVNhohPyXZkRf+d48Q5AG7qFTCMHq+WvVXv84r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNEuwH7k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712498065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88iwLBU2e6djTkjvz8Wf+ZEeZw4XISzU7qQzK/TLfNA=;
	b=UNEuwH7kSvj89Z+q0/HDLUbYf07g5yLb8+SJXmNcHtpaZr3mlEMZxyBErV60uUaRTyuKuk
	30hI6OL7EZswthPcy4yElqEvIvwfbCE0LoOWOtn+YgmaT9gGqf4QZfUmhNTuizTL0MAm3f
	7ktMEwjLf3ZAUH2ZQMIVRAKHpjITEpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-upORUUgENOS-LCzNvktl5Q-1; Sun, 07 Apr 2024 09:54:23 -0400
X-MC-Unique: upORUUgENOS-LCzNvktl5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C692A104457C;
	Sun,  7 Apr 2024 13:54:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.79])
	by smtp.corp.redhat.com (Postfix) with SMTP id B63031C21915;
	Sun,  7 Apr 2024 13:54:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Apr 2024 15:52:57 +0200 (CEST)
Date: Sun, 7 Apr 2024 15:52:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Nick Piggin <npiggin@gmail.com>, Tejun Heo <tj@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
Message-ID: <20240407135248.GB10796@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407130914.GA10796@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/07, Oleg Nesterov wrote:
>
> On 04/05, Frederic Weisbecker wrote:
> >
> > +Cc Nick
> >
> > Le Fri, Apr 05, 2024 at 04:04:49PM +0200, Oleg Nesterov a écrit :
> > > On 04/03, Oleg Nesterov wrote:
> > > >
> > > > > > OTOH, Documentation/timers/no_hz.rst says
> > > > > >
> > > > > > 	Therefore, the
> > > > > > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > > > > > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > > > > > 	error message, and the boot CPU will be removed from the mask.
> > > > > >
> > > > > > and this doesn't match the reality.
> > > > >
> > > > > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > > > > really solve the problem, right?
> > > >
> > > > I do not know. But I thought about this too.
> > > >
> > > > In the context of this discussion we do not care if the boot CPU goes down.
> > > > But we need at least one housekeeping CPU after cpu_down(). The comment in
> > > > cpu_down_maps_locked() says
> > > >
> > > > 	Also keep at least one housekeeping cpu onlined
> > > >
> > > > but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> > > > to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> > > > empty or not.
> > >
> > > This nearly killed me, but I managed to convince myself we shouldn't worry
> > > about cpu_down().
> > >
> > > HK_FLAG_TIMER implies HK_FLAG_TICK.
> > >
> > > HK_FLAG_TICK implies tick_nohz_full_setup() which sets
> > > tick_nohz_full_mask = non_housekeeping_mask.
> > >
> > > When tick_setup_device() is called on a housekeeping CPU it does
> > >
> > > 	else if (tick_do_timer_boot_cpu != -1 &&
> > > 					!tick_nohz_full_cpu(cpu)) {
> > > 		tick_take_do_timer_from_boot();
> > > 		tick_do_timer_boot_cpu = -1;
> > >
> > >
> > > 	and this sets tick_do_timer_cpu = first-housekeeping-cpu.
> > >
> > > cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.
> > >
> > > So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
> > > still think that the change below is the right approach.
> > >
> > > But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.
> > >
> > > What do you think?
> >
> > Good analysis on this nasty housekeeping VS tick code. I promised so many
> > times to cleanup this mess but things keep piling up.
> >
> > It is indeed possible for the boot CPU to be a nohz_full CPU and as
> > you can see, it's only half-working. This is so ever since:
> >
> >     08ae95f4fd3b (nohz_full: Allow the boot CPU to be nohz_full)
>
> Thanks... So this is intentional. I was confused by
>
> 	Therefore, the
> 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> 	error message, and the boot CPU will be removed from the mask.
>
> from Documentation/timers/no_hz.rst
>
> > I would love
> > to revert that now but I don't know if anyone uses this and have it working
> > by chance somewhere... Should we continue to support a broken feature? Can we
> > break user ABI if it's already half-broken?
>
> Well, the changelog says
>
>     nohz_full has been trialed at a large supercomputer site and found to
>     significantly reduce jitter. In order to deploy it in production, they
>     need CPU0 to be nohz_full
>
> so I guess this feature has users.
>
> But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolated cpus'
> timers on queue_delayed_work") the kernel will crash at boot time if the boot
> CPU is nohz_full.
>
> So we need a workaround at least. I am starting to think I will send a trivial
> patch which changes __queue_delayed_work() to validate the cpu returned by
> housekeeping_any_cpu(HK_TYPE_TIMER).
>
> But perhaps something like below makes more sense as a (stupid) workaround?

Or simply


diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..e912555c6fc8 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			if (cpu < nr_cpu_ids)
+				return cpu;
+
+			WARN_ON_ONCE(system_state == SYSTEM_RUNNING);
 		}
 	}
 	return smp_processor_id();


