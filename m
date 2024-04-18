Return-Path: <linux-kernel+bounces-150337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE98A9D92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8889B21CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CF168AE9;
	Thu, 18 Apr 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BauijufJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AF165FCD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451816; cv=none; b=bUZDohopiBC/es4/wMclMWP1autC0jjj8YBbk6roKgdyniIPzixZ2Zk8fAjtbd38DB3id8UP+tAQ8RrxVyZSufoDFwjmiBjZumezErtaZy55lBsSegKBhtbbMtvBWpl8gwodN/hqhPXuEaTUx9kzq3X9c//eNqm6TEyjgpumpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451816; c=relaxed/simple;
	bh=OmM4Ol2cehc696v2G5IaKMs3D22emCXT7jfMzKndz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOy0kZ3EAWOGsu7wOxqNo7Hjosl1QyA/ad0HhFqzW1HrLuO/yhIWOBw2ePTowrq+fg/hlM6hDM75psibH35HCz6lhloAHWwNfkTz4oszcV7z7joOQpdP1wYxKawLeECjxPAEu80WoNpi7Uw3biP9eQTjCBe7JYZs6iec2DqRddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BauijufJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713451813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iA26oegDx20/Oc13YNzcYkvxMaaemAyNcLhc+rMuX3A=;
	b=BauijufJhpNV0FEVOL1QASyPrFyzC3fd1+toDN7UFNqnRAsx75mSidPeW78/UXk4cfp1Lq
	iQTMGvaaLa3heMVDUoRmcQAGFfUmGD4fJXgH4u240k8qakQ/W8lt4UFL3mopivfLfjaaJ0
	XLmbDSxO+vBZ8So1lpmEQbac8uq30TQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-FBi5yr9LP8mOk6bxUDwbfw-1; Thu,
 18 Apr 2024 10:50:10 -0400
X-MC-Unique: FBi5yr9LP8mOk6bxUDwbfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 454A6286A9C2;
	Thu, 18 Apr 2024 14:50:09 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.76])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF95B40C1233;
	Thu, 18 Apr 2024 14:50:05 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:50:02 -0400
From: Phil Auld <pauld@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH] sched/isolation: fix boot crash when the boot CPU is
 nohz_full
Message-ID: <20240418145002.GC29188@lorien.usersys.redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411143905.GA19288@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Thu, Apr 11, 2024 at 04:39:05PM +0200 Oleg Nesterov wrote:
> Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> include the boot CPU, this is no longer true after the commit 08ae95f4fd3b
> ("nohz_full: Allow the boot CPU to be nohz_full").
> 
> However after another commit aae17ebb53cd ("workqueue: Avoid using isolated
> cpus' timers on queue_delayed_work") the kernel will crash at boot time in
> this case; housekeeping_any_cpu() returns an invalid cpu nr until smp_init()
> paths bring the 1st housekeeping CPU up.
> 
> Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
> return smp_processor_id() in this case. Yes, this is just the simple and
> backportable workaround which fixes the symptom, but smp_processor_id() at
> boot time should be safe at least for type == HK_TYPE_TIMER, this more or
> less matches the tick_do_timer_boot_cpu logic.
> 
> We should not worry about cpu_down(); tick_nohz_cpu_down() will not allow
> to offline tick_do_timer_cpu (the 1st online housekeeping CPU).
> 
> Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
> Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
> Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Checking the returned value instead of assuming seems safer in any case.

Reviewed-by: Phil Auld <pauld@redhat.com>

> ---
>  Documentation/timers/no_hz.rst |  7 ++-----
>  kernel/sched/isolation.c       | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
> index f8786be15183..7fe8ef9718d8 100644
> --- a/Documentation/timers/no_hz.rst
> +++ b/Documentation/timers/no_hz.rst
> @@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
>  online to handle timekeeping tasks in order to ensure that system
>  calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
>  (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
> -user processes to observe slight drifts in clock rate.)  Therefore, the
> -boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> -"nohz_full=" mask that includes the boot CPU will result in a boot-time
> -error message, and the boot CPU will be removed from the mask.  Note that
> -this means that your system must have at least two CPUs in order for
> +user processes to observe slight drifts in clock rate.) Note that this
> +means that your system must have at least two CPUs in order for
>  CONFIG_NO_HZ_FULL=y to do anything for you.
>  
>  Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..2a262d3ecb3d 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,16 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (likely(cpu < nr_cpu_ids))
> +				return cpu;
> +			/*
> +			 * Unless we have another problem this can only happen
> +			 * at boot time before start_secondary() brings the 1st
> +			 * housekeeping CPU up.
> +			 */
> +			WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
> +				     type != HK_TYPE_TIMER);
>  		}
>  	}
>  	return smp_processor_id();
> -- 
> 2.25.1.362.g51ebf55
> 
> 
> 

-- 


