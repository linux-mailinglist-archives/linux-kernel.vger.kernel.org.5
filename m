Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8D7E6A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjKIMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjKIMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:20:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E52702
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:20:35 -0800 (PST)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SR1CC6ztkzPnfY;
        Thu,  9 Nov 2023 20:16:23 +0800 (CST)
Received: from [10.174.176.191] (10.174.176.191) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 20:20:33 +0800
Message-ID: <fb427e6c-e89b-47f9-8947-9493b1dbfb0e@huawei.com>
Date:   Thu, 9 Nov 2023 20:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   "liutie (A)" <liutie4@huawei.com>
Subject: Re: [Bug report] A variant deadlock issue of CPU hot-unplug operation
 vs. the CFS bandwidth timer
To:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>, xiafukun <xiafukun@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Phil Auld <pauld@redhat.com>, <vschneid@redhat.com>,
        <vdonnefort@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liuchao173@huawei.com>
References: <6f0f3e42-ddf2-1bbf-ec80-bcbae41c700c@huawei.com>
 <87a5rphara.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87a5rphara.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.191]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 22:57, Thomas Gleixner wrote:
> 
> Bah.
> 
> So we can actually migrate the hrtimers away from the outgoing CPU in
> the dying callbacks. That's safe as nothing can queue an hrtimer remote
> on the outgoing CPU because all other CPUs are spinwaiting with
> interrupts disabled in stomp_machine() until the CPU marked itself
> offline.
> 
> Survived a quick test, but needs some scrunity and probably a sanity
> check in the post dead stage.
> 
> Thanks,
> 
>          tglx
> ---
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -195,6 +195,7 @@ enum cpuhp_state {
>   	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
>   	CPUHP_AP_ARM64_ISNDEP_STARTING,
>   	CPUHP_AP_SMPCFD_DYING,
> +	CPUHP_AP_HRTIMERS_DYING,
>   	CPUHP_AP_X86_TBOOT_DYING,
>   	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
>   	CPUHP_AP_ONLINE,
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -531,9 +531,9 @@ extern void sysrq_timer_list_show(void);
>   
>   int hrtimers_prepare_cpu(unsigned int cpu);
>   #ifdef CONFIG_HOTPLUG_CPU
> -int hrtimers_dead_cpu(unsigned int cpu);
> +int hrtimers_cpu_dying(unsigned int cpu);
>   #else
> -#define hrtimers_dead_cpu	NULL
> +#define hrtimers_cpu_dying	NULL
>   #endif
>   
>   #endif
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2116,7 +2116,7 @@ static struct cpuhp_step cpuhp_hp_states
>   	[CPUHP_HRTIMERS_PREPARE] = {
>   		.name			= "hrtimers:prepare",
>   		.startup.single		= hrtimers_prepare_cpu,
> -		.teardown.single	= hrtimers_dead_cpu,
> +		.teardown.single	= NULL,
>   	},
>   	[CPUHP_SMPCFD_PREPARE] = {
>   		.name			= "smpcfd:prepare",
> @@ -2208,6 +2208,12 @@ static struct cpuhp_step cpuhp_hp_states
>   		.startup.single		= NULL,
>   		.teardown.single	= smpcfd_dying_cpu,
>   	},
> +	[CPUHP_AP_HRTIMERS_DYING] = {
> +		.name			= "hrtimers:dying",
> +		.startup.single		= NULL,
> +		.teardown.single	= hrtimers_cpu_dying,
> +	},
> +
>   	/* Entry state on starting. Interrupts enabled from here on. Transient
>   	 * state for synchronsization */
>   	[CPUHP_AP_ONLINE] = {
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2219,29 +2219,22 @@ static void migrate_hrtimer_list(struct
>   	}
>   }
>   
> -int hrtimers_dead_cpu(unsigned int scpu)
> +int hrtimers_cpu_dying(unsigned int dying_cpu)
>   {
>   	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i;
> +	int i, ncpu = cpumask_first(cpu_active_mask);
>   
> -	BUG_ON(cpu_online(scpu));
> -	tick_cancel_sched_timer(scpu);
> +	tick_cancel_sched_timer(dying_cpu);
> +
> +	old_base = this_cpu_ptr(&hrtimer_bases);
> +	new_base = &per_cpu(hrtimer_bases, ncpu);
>   
> -	/*
> -	 * this BH disable ensures that raise_softirq_irqoff() does
> -	 * not wakeup ksoftirqd (and acquire the pi-lock) while
> -	 * holding the cpu_base lock
> -	 */
> -	local_bh_disable();
> -	local_irq_disable();
> -	old_base = &per_cpu(hrtimer_bases, scpu);
> -	new_base = this_cpu_ptr(&hrtimer_bases);
>   	/*
>   	 * The caller is globally serialized and nobody else
>   	 * takes two locks at once, deadlock is not possible.
>   	 */
> -	raw_spin_lock(&new_base->lock);
> -	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
> +	raw_spin_lock(&old_base->lock);
> +	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
>   
>   	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
>   		migrate_hrtimer_list(&old_base->clock_base[i],
> @@ -2252,15 +2245,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
>   	 * The migration might have changed the first expiring softirq
>   	 * timer on this CPU. Update it.
>   	 */
> -	hrtimer_update_softirq_timer(new_base, false);
> +	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
> +	/* Tell the other CPU to retrigger the next event */
> +	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
>   
> -	raw_spin_unlock(&old_base->lock);
>   	raw_spin_unlock(&new_base->lock);
> +	raw_spin_unlock(&old_base->lock);
>   
> -	/* Check, if we got expired work to do */
> -	__hrtimer_peek_ahead_timers();
> -	local_irq_enable();
> -	local_bh_enable();
>   	return 0;
>   }
>   

Thanks for the patch. Tested in v6.6 and this patch works.

Tested-by: Liu Tie <liutie4@huawei.com>

Best regards,
Tie
