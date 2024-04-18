Return-Path: <linux-kernel+bounces-150345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB28A9DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740D31F212E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E524168B14;
	Thu, 18 Apr 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgrzw3Vt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98B15E5C2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452093; cv=none; b=Nd1Sk30A19u4kGhaKVq+81MuqFiDztDZmWO2prihMkluLqSJIxtxGfdF4P4DG95BhOwqeZ5mzQTPFyUAyvrj+lvbK8JcVjpjCfTi4cViVaUDoIU4tGWAoomq6BF3Q3pyKlIIC3X9tdtcODanJvd7e/8oUr6RPArS7yhN13YnxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452093; c=relaxed/simple;
	bh=RkoB4lpM7SQp7wLAY3W9tcar+vO2aUBWcAA9IdsjUNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqn5k/wNyuvGUUBvPDwykvcd/2oP2+CIcF7u+fXTI0kwF/HeZLN5eFBcAgXO5pM0f42T3hH0TTKyJC5AZ/jQdG+6dyewwklGLtCuVHaT8SUfWrGX9XqShlfgz52P3aTmzH7KcIbI7q7q7sad1HGboCEV5UdpWk59RKwGorZtfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kgrzw3Vt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713452090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjAgIJ9bEDy7d1QsholKuarzIc+pJd8Rrqs4LlRJVNw=;
	b=Kgrzw3VtMGZlcyEjqxOhF2mf3teXkKOxqPX9LRuMT4wytKamIgutPDhx8VqNnoisnqg6uo
	4YnFkFb5Gt9CtturgFPh/d9azXioee1ufhQhzy8Z65jh1P4E9wKSpDvK7P35unl/eyfBu+
	a7DSTTYGY4b8WHSFUf/KriCiWLKIYKY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-x9pjP0qyP5OyfMMLLoSzQA-1; Thu,
 18 Apr 2024 10:54:47 -0400
X-MC-Unique: x9pjP0qyP5OyfMMLLoSzQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3244829AA2CE;
	Thu, 18 Apr 2024 14:54:47 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.195.76])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C25EC3543A;
	Thu, 18 Apr 2024 14:54:43 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:54:40 -0400
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
Subject: Re: [PATCH] sched/isolation: fix boot crash when maxcpus <
 first-housekeeping-cpu
Message-ID: <20240418145440.GD29188@lorien.usersys.redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
 <20240413141746.GA10008@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413141746.GA10008@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Sat, Apr 13, 2024 at 04:17:46PM +0200 Oleg Nesterov wrote:
> housekeeping_setup() checks cpumask_intersects(present, online) to ensure
> that the kernel will have at least one housekeeping CPU after smp_init(),
> but this doesn't work if the maxcpus= kernel parameter limits the number
> of processors available after bootup.
> 
> For example, the kernel with "maxcpus=2 nohz_full=0-2" parameters crashes
> at boot time on my virtual machine with 4 CPUs.
> 
> Change housekeeping_setup() to use cpumask_first_and() and check that the
> returned cpu number is valid and less than setup_max_cpus.
> 
> Another corner case is "nohz_full=0" on a machine with a single CPU or
> with the maxcpus=1 kernel argument. In this case non_housekeeping_mask
> is empty and IIUC tick_nohz_full_setup() makes no sense. And indeed, the
> kernel hits the WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().
> 
> And how should the kernel interpret the "nohz_full=" parameter? I think
> it should be silently ignored, but currently cpulist_parse() happily
> returns the empty cpumask and this leads to the same problem.
> 
> Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
> and do nothing in this case.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Looks good to me. One less footgun. 

Reviewed-by: Phil Auld <pauld@redhat.com>

> ---
>  kernel/sched/isolation.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 2a262d3ecb3d..5891e715f00d 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -118,6 +118,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
>  static int __init housekeeping_setup(char *str, unsigned long flags)
>  {
>  	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
> +	unsigned int first_cpu;
>  	int err = 0;
>  
>  	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
> @@ -138,7 +139,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  	cpumask_andnot(housekeeping_staging,
>  		       cpu_possible_mask, non_housekeeping_mask);
>  
> -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> +	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
> +	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
>  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
>  		if (!housekeeping.flags) {
> @@ -147,6 +149,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>  		}
>  	}
>  
> +	if (cpumask_empty(non_housekeeping_mask))
> +		goto free_housekeeping_staging;
> +
>  	if (!housekeeping.flags) {
>  		/* First setup call ("nohz_full=" or "isolcpus=") */
>  		enum hk_type type;
> -- 
> 2.25.1.362.g51ebf55
> 
> 
> 

-- 


