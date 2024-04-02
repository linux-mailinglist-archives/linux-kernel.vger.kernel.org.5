Return-Path: <linux-kernel+bounces-127811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1367C895144
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E171C237DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E669946;
	Tue,  2 Apr 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehSXeixg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78760269
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055625; cv=none; b=WnHKam52MBFellqYgg2QmbkmGV3brI/NFc47007HHWnXTQcIcRXHmaV2FubkLrOQBT4OGxYjNsNwnj18eG8amTreratScSO66rItv30T2kabJrhQD1w13W5xzRG1aRhKVVoj7AhHDnLH0S1/3mbCkfpcX9/FBzE8O10HgHU87CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055625; c=relaxed/simple;
	bh=9l/uJlhZz71INlCmZi6FyRzwD9Rw0VhpOTNQ49UU2H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9PFd1JvUk+5qMmBRDxqjEAnQe/e2Wqyr7l5YBAOdqkZiT7ASkPOWqPscIGflzEHwAAPsl9JS3RWkeK5VHS5DiClnyr+IU4FZrRtPFXwL+7JC7phgoeirAzsXsbMnuEFunvX6lg9FuQbfDFUs6BuYtRuFRmwVclHxEZUtOcG+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehSXeixg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712055621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUu3nr9E3SwUyf0LhqLc3kAfs3lSg4TLssyKsTdFRrI=;
	b=ehSXeixg+KyVttXD4vPPpo3iFUVt4qDVxPgfLKYWuicPoK13EzFBxnOv6Ithfy/hfzzI7E
	WAyNm105nWqmt/JQl/NNdUjb7RuV16eYjxWiWhFDDjwKJ0e96mLDDWFPJatC8Sm+E60mCC
	v2Ah6Y8udMFeM6tC/3NK8CvAKa4FYRg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-pmYRuB_lMcalWZwNXFOHkg-1; Tue,
 02 Apr 2024 07:00:18 -0400
X-MC-Unique: pmYRuB_lMcalWZwNXFOHkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64D6338143A3;
	Tue,  2 Apr 2024 11:00:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.69])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2A25E1C060A4;
	Tue,  2 Apr 2024 11:00:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  2 Apr 2024 12:58:54 +0200 (CEST)
Date: Tue, 2 Apr 2024 12:58:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <20240402105847.GA24832@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130010046.2730139-2-leobras@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hello,

This patch was applied as aae17ebb53cd3da but as Chris reports with this
commit the kernel can crash at boot time because __queue_delayed_work()
doesn't check that housekeeping_any_cpu() returns a valid cpu < nr_cpu_ids.

Just boot the kernel with nohz_full=mask which includes the boot cpu, say
nohz_full=0-6 on a machine with 8 CPUs. __queue_delayed_work() will use
add_timer_on(timer, NR_CPUS /* returned by housekeeping_any_cpu */) until
start_secondary() brings CPU 7 up.

The problem is simple, but I do not know what should we do, I know nothing
about CPU isolation.

We can fix __queue_delayed_work(), this is simple, but other callers of
housekeeping_any_cpu() seem to assume it must always return a valid CPU
too. So perhaps we should change housekeeping_any_cpu()

-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			if (cpu < nr_cpu_ids)
+				return cpu;

?

But I'm afraid this can hide other problems. May be

-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			if (cpu < nr_cpu_ids)
+				return cpu;
+
+			WARN_ON(system_state > SYSTEM_BOOTING);

?

-------------------------------------------------------------------------------
OTOH, Documentation/timers/no_hz.rst says

	Therefore, the
	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
	"nohz_full=" mask that includes the boot CPU will result in a boot-time
	error message, and the boot CPU will be removed from the mask.

and this doesn't match the reality.

So it seems that we should fix housekeeping_setup() ? see the patch below.

In any case the usage of cpu_present_mask doesn't look right to me.

Oleg.

--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {


On 01/29, Leonardo Bras wrote:
>
> When __queue_delayed_work() is called, it chooses a cpu for handling the
> timer interrupt. As of today, it will pick either the cpu passed as
> parameter or the last cpu used for this.
>
> This is not good if a system does use CPU isolation, because it can take
> away some valuable cpu time to:
> 1 - deal with the timer interrupt,
> 2 - schedule-out the desired task,
> 3 - queue work on a random workqueue, and
> 4 - schedule the desired task back to the cpu.
>
> So to fix this, during __queue_delayed_work(), if cpu isolation is in
> place, pick a random non-isolated cpu to handle the timer interrupt.
>
> As an optimization, if the current cpu is not isolated, use it instead
> of looking for another candidate.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
> Changes since v1:
> - Make sure the CPU is isolated for any value of "cpu"
>
> Changes since RFC:
> - Do not use the same cpu from the timer for queueing the work.
> - If the current cpu is not isolated, use it's timer instead of
>   looking for another candidate.
>
>  kernel/workqueue.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 76e60faed8923..8dd7c01b326a4 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1958,10 +1958,18 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
>  	dwork->cpu = cpu;
>  	timer->expires = jiffies + delay;
>
> -	if (unlikely(cpu != WORK_CPU_UNBOUND))
> +	if (housekeeping_enabled(HK_TYPE_TIMER)) {
> +		/* If the current cpu is a housekeeping cpu, use it. */
> +		cpu = smp_processor_id();
> +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> +			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
>  		add_timer_on(timer, cpu);
> -	else
> -		add_timer(timer);
> +	} else {
> +		if (likely(cpu == WORK_CPU_UNBOUND))
> +			add_timer(timer);
> +		else
> +			add_timer_on(timer, cpu);
> +	}
>  }
>
>  /**
> --
> 2.43.0
>


