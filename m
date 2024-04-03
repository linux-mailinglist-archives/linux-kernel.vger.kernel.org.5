Return-Path: <linux-kernel+bounces-130488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B4D8978D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87111F283B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38906154C09;
	Wed,  3 Apr 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA50A14V"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BE154458
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171547; cv=none; b=ItlO74OpuDbdh8kQADyH1CS8pqQD6lkSAwzZaBOmXs2oRIZR7TzS/xgXkSXqGU6B1CrSvcy0PD1QGQ7DGR+8dd/GnzV51afFLIR/0WEiiTf+zq2WDoUyKhoOvOFLuV7eAJ3HnpB+A2rFLN5pfRchXfUQfswY/Dk3bI9mrKBZdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171547; c=relaxed/simple;
	bh=xmvw7OCvDHeBcZ43xzBWmf7wXuv2+U+mt4NeNZ/ts8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyaJOEC0VH6l2T/9kNJR0QFvBEVHS3GyRaNWAL8v71a+lODkOCji/eYXRbxwmP4MTrZ1Ti2G73LcRpk825CrpUSV8OYlVwiKyaBb7HwTrb3+ptX9QKgeit7UutgnR90YwCjzDvwuLa6w+s/Xtd5633woiL4HN2nS3rYRAMoJSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA50A14V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so143717b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712171545; x=1712776345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiVPftN3gk7aUwtGKLl4zbFS9L4LSr7apE60PF9cTH4=;
        b=WA50A14VPwb1rqCHS+G65FXAFGD+ze/upLhhA4aJ51ccZtRGGbDehNGKYNBWz0wps5
         H2kmSpUfZtLxBG5KVYS+wAO+Y9EgnpAAk+usqQe0Yy78FASnENMFBwWAAvjOH6ujU1Tq
         OJtriTgo4xgBovvRbMOZ2pn6jlNk8shSfc1RRyQ3a6SWnr/o/wi7FsPEYEo5JQf0V8um
         K9ZM30XYsIcc3DZP3r4nC7chrNmRRlL4+qMcE8gL+RJP9Ic4kEG2llbInRosNzQqgXl4
         2DtMRvcHO1X59aqptM3UFHA1RVXF6dSMY9bzToxsLrLrub9QTHpmikqM9g+L12otUXlV
         JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712171545; x=1712776345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiVPftN3gk7aUwtGKLl4zbFS9L4LSr7apE60PF9cTH4=;
        b=p0gd6Jyh2DgGPbuWU62MgXPxM+j7HSru9TUzPrWWjDMBJ4l0CrhRtcXJDAZ4QpTILs
         2TLF4E2LFAxKKvU/iZG0t4oz4kMwwHu04DwAsCTuJ3/W+7HyeoA06zYZVR4Ua3/1AdE/
         pzLU1xsGQEoHsLVlkLHi/ReJz1dSvB2f1yCWpOsSNaDLHFV4E/zZ0u71meQ2bkKTIjbz
         dn9P90xXlpUOam/LILhUAYVn1gybfTx7dm++afwv9b95iWZ/pRAmf7L4CgONh9tWNd0+
         2k2cWU7RwDToLV98it9LNShZrdNQHUgoWGYP7d7mYBZSJourPJ4P014WL6aV9kzOC6TA
         Hqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXBpPyHmP7rG8Jdu+cWB5DOB8p9ED0bFKltenG7hxmH+vOjWJ+mYLdGC1Ahky2IiTOgb+XMhodBtl6Eb/yugD7Z2LcG59s2GL8Sldwx
X-Gm-Message-State: AOJu0YzuQwOvEKQ5N4DkTmDzQUNRcBMH2R6+/TV4bgrDzQq0ckgSKrTj
	n0sH7xjuqZWMtglXlqVr4LDnPkyOpXMJTLpajWxJ06wJvHe4TlLD
X-Google-Smtp-Source: AGHT+IGXHglYH35vCIC6pVSh/kFRdis1PYkiJFxZiZLDa3r8/wrV+FJNTbo4XIvb/q3xHCHMOZ1Flg==
X-Received: by 2002:a05:6a00:2e1e:b0:6ec:d3a6:801 with SMTP id fc30-20020a056a002e1e00b006ecd3a60801mr759707pfb.11.1712171544870;
        Wed, 03 Apr 2024 12:12:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b006e5360f1cffsm12163139pfb.180.2024.04.03.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:12:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 09:12:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <Zg2qFinSkAOmRHcM@slm.duckdns.org>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402105847.GA24832@redhat.com>

(cc'ing Frederic and quoting whole body)

Hello, Oleg.

On Tue, Apr 02, 2024 at 12:58:47PM +0200, Oleg Nesterov wrote:
> This patch was applied as aae17ebb53cd3da but as Chris reports with this
> commit the kernel can crash at boot time because __queue_delayed_work()
> doesn't check that housekeeping_any_cpu() returns a valid cpu < nr_cpu_ids.
> 
> Just boot the kernel with nohz_full=mask which includes the boot cpu, say
> nohz_full=0-6 on a machine with 8 CPUs. __queue_delayed_work() will use
> add_timer_on(timer, NR_CPUS /* returned by housekeeping_any_cpu */) until
> start_secondary() brings CPU 7 up.
> 
> The problem is simple, but I do not know what should we do, I know nothing
> about CPU isolation.
> 
> We can fix __queue_delayed_work(), this is simple, but other callers of
> housekeeping_any_cpu() seem to assume it must always return a valid CPU
> too. So perhaps we should change housekeeping_any_cpu()

Yeah, patching this up from wq side is easy but housekeeping_any_cpu()
always being able to pick a housekeeping CPU would be better.

> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> 
> ?
> 
> But I'm afraid this can hide other problems. May be
> 
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> +
> +			WARN_ON(system_state > SYSTEM_BOOTING);
> 
> ?
>
> -------------------------------------------------------------------------------
> OTOH, Documentation/timers/no_hz.rst says
> 
> 	Therefore, the
> 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> 	error message, and the boot CPU will be removed from the mask.
> 
> and this doesn't match the reality.

Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
really solve the problem, right?

> So it seems that we should fix housekeeping_setup() ? see the patch below.
> 
> In any case the usage of cpu_present_mask doesn't look right to me.
> 
> Oleg.
> 
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	cpumask_andnot(housekeeping_staging,
>  		       cpu_possible_mask, non_housekeeping_mask);
>  
> -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> +	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
>  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
>  		if (!housekeeping.flags) {
> 
> 
> On 01/29, Leonardo Bras wrote:
> >
> > When __queue_delayed_work() is called, it chooses a cpu for handling the
> > timer interrupt. As of today, it will pick either the cpu passed as
> > parameter or the last cpu used for this.
> >
> > This is not good if a system does use CPU isolation, because it can take
> > away some valuable cpu time to:
> > 1 - deal with the timer interrupt,
> > 2 - schedule-out the desired task,
> > 3 - queue work on a random workqueue, and
> > 4 - schedule the desired task back to the cpu.
> >
> > So to fix this, during __queue_delayed_work(), if cpu isolation is in
> > place, pick a random non-isolated cpu to handle the timer interrupt.
> >
> > As an optimization, if the current cpu is not isolated, use it instead
> > of looking for another candidate.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> > Changes since v1:
> > - Make sure the CPU is isolated for any value of "cpu"
> >
> > Changes since RFC:
> > - Do not use the same cpu from the timer for queueing the work.
> > - If the current cpu is not isolated, use it's timer instead of
> >   looking for another candidate.
> >
> >  kernel/workqueue.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 76e60faed8923..8dd7c01b326a4 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1958,10 +1958,18 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
> >  	dwork->cpu = cpu;
> >  	timer->expires = jiffies + delay;
> >
> > -	if (unlikely(cpu != WORK_CPU_UNBOUND))
> > +	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> > +		/* If the current cpu is a housekeeping cpu, use it. */
> > +		cpu = smp_processor_id();
> > +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> > +			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> >  		add_timer_on(timer, cpu);
> > -	else
> > -		add_timer(timer);
> > +	} else {
> > +		if (likely(cpu == WORK_CPU_UNBOUND))
> > +			add_timer(timer);
> > +		else
> > +			add_timer_on(timer, cpu);
> > +	}
> >  }
> >
> >  /**
> > --
> > 2.43.0
> >
> 

-- 
tejun

