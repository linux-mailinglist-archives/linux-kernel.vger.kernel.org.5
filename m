Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12274786842
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjHXHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjHXHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:25:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ECE6C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:25:26 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RWZMF3dX5z1L9LH;
        Thu, 24 Aug 2023 15:23:53 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 15:25:23 +0800
Message-ID: <3256f9c1-dccd-5995-5b14-afaae281be90@huawei.com>
Date:   Thu, 24 Aug 2023 15:25:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>, <vdonnefort@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>, <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
References: <87h6oqdq0i.ffs@tglx>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <87h6oqdq0i.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/23 18:14, Thomas Gleixner wrote:
> Subject: cpu/hotplug: Prevent self deadlock on CPU hot-unplug
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 23 Aug 2023 10:47:02 +0200
> 
> Xiongfeng reported and debugged a self deadlock of the task which initiates
> and controls a CPU hot-unplug operation vs. the CFS bandwidth timer.
> 
>     CPU1      			                 	 CPU2
> 
> T1 sets cfs_quota
>    starts hrtimer cfs_bandwidth 'period_timer'
> T1 is migrated to CPU2				
> 						T1 initiates offlining of CPU1
> Hotplug operation starts
>   ...
> 'period_timer' expires and is re-enqueued on CPU1
>   ...
> take_cpu_down()
>   CPU1 shuts down and does not handle timers
>   anymore. They have to be migrated in the
>   post dead hotplug steps by the control task.
> 
> 						T1 runs the post dead offline operation
> 					      	T1 is scheduled out
> 						T1 waits for 'period_timer' to expire
> 
> T1 waits there forever if it is scheduled out before it can execute the hrtimer
> offline callback hrtimers_dead_cpu().
> 
> Cure this by delegating the hotplug control operation to a worker thread on
> an online CPU. This takes the initiating user space task, which might be
> affected by the bandwidth timer, completely out of the picture.
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com
> ---
>  kernel/cpu.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1467,8 +1467,22 @@ static int __ref _cpu_down(unsigned int
>  	return ret;
>  }
>  
> +struct cpu_down_work {
> +	unsigned int		cpu;
> +	enum cpuhp_state	target;
> +};
> +
> +static long __cpu_down_maps_locked(void *arg)
> +{
> +	struct cpu_down_work *work = arg;
> +
> +	return _cpu_down(work->cpu, 0, work->target);
> +}
> +
>  static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  {
> +	struct cpu_down_work work = { .cpu = cpu, .target = target, };
> +
>  	/*
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
> @@ -1477,7 +1491,15 @@ static int cpu_down_maps_locked(unsigned
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;
> -	return _cpu_down(cpu, 0, target);
> +
> +	/*
> +	 * Ensure that the control task does not run on the to be offlined
> +	 * CPU to prevent a deadlock against cfs_b->period_timer.
> +	 */
> +	cpu = cpumask_any_but(cpu_online_mask, cpu);
> +	if (cpu >= nr_cpu_ids)
> +		return -EBUSY;
> +	return work_on_cpu(cpu, __cpu_down_maps_locked, &work);
>  }
>  
>  static int cpu_down(unsigned int cpu, enum cpuhp_state target)

Thanks for the patch. Tested in v6.5-rc5 with test script provided by
Xiongfeng, this patch works.

Tested-by: Yu Liao <liaoyu15@huawei.com>

Best regards,
Yu



