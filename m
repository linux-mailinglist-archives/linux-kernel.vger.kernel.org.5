Return-Path: <linux-kernel+bounces-1208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4CF814BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5E31C22682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01C3716A;
	Fri, 15 Dec 2023 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZP/OuKyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AB37141
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PsuBt3Vxcjvct1x6GswH9qrfO3gP89Oemg6DFIds43o=; b=ZP/OuKyjnrqJ1cfREu6NHWOPBP
	byVZ318SPUj0MAHcz96U15upnAMKHUaELm3jrg1nO6Jw7HyVWIFS7hSLjr93uFnxfxtCKuso81Bh2
	9jDseVlPNpAWFmVlOiXsyl9fVIhbTOc07FXswNGv3sLLSkop3AgpyauaunGpBk7g2bXXHTfYEsidc
	tr3a3VO7GDxMddeihm8Hs3BpClkbV9H17WzsfFHxWJ/WwkVPn1RxPOUPLa0CiDIz2G6bGyz0EnD5s
	tReWuuLLXsuSlcVz/OjJUTBlbs1LrzgAK9HsgqIYvl6qVrwt1Ou/A8Dp5sRB+mFaIPYgQSdZGPKUT
	GMl+ifsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEA1v-009xag-37;
	Fri, 15 Dec 2023 15:23:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9EA993005B2; Fri, 15 Dec 2023 16:23:11 +0100 (CET)
Date: Fri, 15 Dec 2023 16:23:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Josh Don <joshdon@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: take into account scheduling domain in
 select_idle_core()
Message-ID: <20231215152311.GL36716@noisy.programming.kicks-ass.net>
References: <20231214175551.629945-1-keisuke.nishimura@inria.fr>
 <20231214175551.629945-2-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214175551.629945-2-keisuke.nishimura@inria.fr>

On Thu, Dec 14, 2023 at 06:55:51PM +0100, Keisuke Nishimura wrote:
> When picking out a CPU on a task wakeup, select_idle_smt() has to take
> into account the scheduling domain where the function looks for the CPU.
> This is because cpusets and isolcpus can remove CPUs from the domain
> to isolate them from other SMT siblings.

Same question as before, when cpusets, the cpu should also be unset from
p->cpus_ptr. So I'm thinking you're one of those isolcpus users I wish
that would go away ;-)

> This change replaces the set of CPUs allowed to run the task from
> p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
> which is stored in the cpus argument provided by select_idle_cpu.
> 
> Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 71306b48cf68..3b7d32632674 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7262,7 +7262,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  		if (!available_idle_cpu(cpu)) {
>  			idle = false;
>  			if (*idle_cpu == -1) {
> -				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
>  					*idle_cpu = cpu;
>  					break;
>  				}
> @@ -7270,7 +7270,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  			}
>  			break;
>  		}
> -		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
>  			*idle_cpu = cpu;
>  	}

Aside of that, the actual patch seems to be fine, just the rationale
needs work.

