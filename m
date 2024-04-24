Return-Path: <linux-kernel+bounces-157702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73C38B14CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751142812B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675E15696C;
	Wed, 24 Apr 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcilreIO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2F156898
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991293; cv=none; b=hxi/XgkvQHCAxEaEOYsbz9VF+nFhb4ipBLmd/c+xirokpKt4WaV+Y8OJ0eLydAmBA7ONRnL5AfcdgvCTJibDB4TTOvSf5a6lfTW/sZbc+Yumd9MU17EW0ArBUhscBNKRLY4h0WLHKjgK+Fvexijzb+tNKyVgG+ElTKLEZD2/8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991293; c=relaxed/simple;
	bh=buNsFbtYYVmx18JUFv8HM4y2vKkaxmf9C7mDNlja280=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3Zd4t1rbMO3Ee+qWRlv0gym8NNyNEMK+z/rAoJ2I8kNb0tVQ1CsIloukJGcromSpr9IHiU8QexQIr3hjk61H3bnrUZJxGGMs8Hl2NKf/EZHlBJ2/mlK2iHdf3spCDNNykpKJ1xuMATrDyb7aDbohtn6Y0aG5oB11e4bjYxEnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcilreIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713991291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oDWaGWnJakdCF6hfPJajrIOzDqbpV/2hCAui/gKGuBQ=;
	b=fcilreIO6FdixA1kIywC294xU5HEfjWCxWY/6H0koCSFoVi4aR9NcdG3l4iJ1tOcpZ++H6
	vVX2vwJVu0mg2bZ/hnhxdwtmA/fXot+uCf6MCmZD3Lb2W0gMZUsxebAOfns+W3ZC3qDJv8
	YUAr+TnShtrrMuG8LgJ+7njb+8bZFjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Mv2ADBDyNyGMwxSxk2PyJQ-1; Wed, 24 Apr 2024 16:41:27 -0400
X-MC-Unique: Mv2ADBDyNyGMwxSxk2PyJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D8C580021A;
	Wed, 24 Apr 2024 20:41:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A10E5202450D;
	Wed, 24 Apr 2024 20:41:26 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:41:24 -0400
From: Phil Auld <pauld@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: {revent boot crash when the
 boot CPU is nohz_full
Message-ID: <20240424204124.GA36310@lorien.usersys.redhat.com>
References: <20240411143905.GA19288@redhat.com>
 <171398910227.10875.3649946025664504959.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171398910227.10875.3649946025664504959.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Wed, Apr 24, 2024 at 08:05:02PM -0000 tip-bot2 for Oleg Nesterov wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     8e3101b38dfc20848a23525b1e6e80bd1641d44c
> Gitweb:        https://git.kernel.org/tip/8e3101b38dfc20848a23525b1e6e80bd1641d44c
> Author:        Oleg Nesterov <oleg@redhat.com>
> AuthorDate:    Thu, 11 Apr 2024 16:39:05 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 24 Apr 2024 21:53:34 +02:00
> 
> sched/isolation: {revent boot crash when the boot CPU is nohz_full
>

Thanks Thomas, Typo in the reworded description :)


> Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> include the boot CPU, which is no longer true after commit 08ae95f4fd3b
> ("nohz_full: Allow the boot CPU to be nohz_full").
> 
> However after commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
> timers on queue_delayed_work") the kernel will crash at boot time in this
> case; housekeeping_any_cpu() returns an invalid CPU number until smp_init()
> brings the first housekeeping CPU up.
> 
> Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
> return smp_processor_id() in this case.
> 
> This is just the simple and backportable workaround which fixes the
> symptom, but smp_processor_id() at boot time should be safe at least for
> type == HK_TYPE_TIMER, this more or less matches the tick_do_timer_boot_cpu
> logic.
> 
> There is no worry about cpu_down(); tick_nohz_cpu_down() will not allow to
> offline tick_do_timer_cpu (the 1st online housekeeping CPU).
> 
> Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
> Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
> Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
> ---
>  Documentation/timers/no_hz.rst |  7 ++-----
>  kernel/sched/isolation.c       | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
> index f8786be..7fe8ef9 100644
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
> index 373d42c..2a262d3 100644
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
> 

-- 


