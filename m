Return-Path: <linux-kernel+bounces-137039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D889DB76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAD51F221EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F212F589;
	Tue,  9 Apr 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPHm5Ewx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491927BAF3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671203; cv=none; b=q3X3LCcnQQenuzNU/nBt+3BkAJ+9cMvC8q8twYICWJoz1eYp2ReeJ1EMVEHr1qOo9nB8NKk40YkZoUXXPyugKJwA/B4iblErhuuYQBkU9ZLv5oYyK5wzFIfmZqsyI6DVkwKcRzUJmJFWFwJQq47YS34Odzt51P6JjMtNPkUDSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671203; c=relaxed/simple;
	bh=YE4SM/AVhmsY36Btdoby6ScHukpiWOmm9uQ9kMEx29U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qni4VGqh4UulkkpjR9xCRJw49ENtwPhSiNMTMuTE+ImQBQGAy092DPGoWAtR71c8JtdpS6pmp0ivJ+GOQC92LPMfuc2MyJ790SX51HBBObsGmEHdAxbRTjmU0C6qyrVLBmEwlqkqe8Ae3Yb7gov2CuXZclo/2ginmGG24l0o1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPHm5Ewx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659FCC433C7;
	Tue,  9 Apr 2024 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671202;
	bh=YE4SM/AVhmsY36Btdoby6ScHukpiWOmm9uQ9kMEx29U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPHm5EwxD7YwzQa3dG/UpYUMVfcQDAwIhuehSGcFJGZsa6pMlM1F/ayuE+bnSe5vE
	 9E/zoVPC1AqSuzPgX0DTw2tN2S4I7yWpGpXPx5WS7xq6HoE7smdtqhskUvIbGEa8Dh
	 KmDDUv1+py1z6zbGnNyjHAU/juuHaXbKz0c/tzQy6wibUsodJSl8+nstLtXml+qbkl
	 GuClRqZfkWqo2OU2CX/onjfdhIwKOxat8X798FAZeoJLPW4ZBrV8r2GtVJ+oXqrGIT
	 Vl0uz90tjSabXIkqEe+aymUKRFuBgvnUMy07iAFpOw7Y9CY7P9ZrWcu4tlQ/BdYQ2O
	 HzydHeugU1c/A==
Date: Tue, 9 Apr 2024 15:59:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
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
Message-ID: <ZhVJ3-wOKB0-Dc9b@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <ZhUu0uQxPgcXmQes@localhost.localdomain>
 <20240409130727.GC29396@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409130727.GC29396@redhat.com>

Le Tue, Apr 09, 2024 at 03:07:28PM +0200, Oleg Nesterov a écrit :
> On 04/09, Frederic Weisbecker wrote:
> >
> > Le Sun, Apr 07, 2024 at 03:09:14PM +0200, Oleg Nesterov a écrit :
> > > Well, the changelog says
> > >
> > >     nohz_full has been trialed at a large supercomputer site and found to
> > >     significantly reduce jitter. In order to deploy it in production, they
> > >     need CPU0 to be nohz_full
> > >
> > > so I guess this feature has users.
> > >
> > > But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolated cpus'
> > > timers on queue_delayed_work") the kernel will crash at boot time if the boot
> > > CPU is nohz_full.
> >
> > Right but there are many possible calls to housekeeping on boot before the
> > first housekeeper becomes online.
> 
> Well, it seems that other callers are more or less fine in this respect...
> At least the kernel boots fine with that commit reverted.
> 
> But a) I didn't try to really check, and b) this doesn't matter.
> 
> I agree, and that is why I never blamed this change in queue_delayed_work().
> 
> OK, you seem to agree with the patch below, I'll write the changelog/comment
> and send it "officially".
> 
> Or did I misunderstand you?

Works for me!

Thanks.

> 
> Oleg.
> 
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..e912555c6fc8 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> +
> +			WARN_ON_ONCE(system_state == SYSTEM_RUNNING);
>  		}
>  	}
>  	return smp_processor_id();
> 

