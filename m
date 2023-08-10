Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACE777F06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHJRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHJRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:21:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E4342702
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:21:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CCADD75;
        Thu, 10 Aug 2023 10:22:37 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A1223F6C4;
        Thu, 10 Aug 2023 10:21:54 -0700 (PDT)
Message-ID: <a956e24b-7f78-7aa0-ec1a-1e6b169c5835@arm.com>
Date:   Thu, 10 Aug 2023 18:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-GB
To:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230810154114.405742-1-longman@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230810154114.405742-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 4:41 pm, Waiman Long wrote:
> The following circular locking dependency was reported when running
> cpus online/offline test on an arm64 system.
> 
> [   84.195923] Chain exists of:
>                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
> 
> [   84.207305]  Possible unsafe locking scenario:
> 
> [   84.213212]        CPU0                    CPU1
> [   84.217729]        ----                    ----
> [   84.222247]   lock(cpuhp_state-down);
> [   84.225899]                                lock(cpu_hotplug_lock);
> [   84.232068]                                lock(cpuhp_state-down);
> [   84.238237]   lock(dmc620_pmu_irqs_lock);
> [   84.242236]
>                  *** DEADLOCK ***
> 
> The problematic locking order seems to be
> 
> 	lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
> 
> This locking order happens when dmc620_pmu_get_irq() calls
> cpuhp_state_add_instance_nocalls(). Since dmc620_pmu_irqs_lock is used
> for protecting the dmc620_pmu_irqs structure, we don't actually need
> to hold the lock when adding a new instance to the CPU hotplug subsystem.
> 
> Fix this possible deadlock scenario by adding a new dmc620_pmu_get_lock
> for protecting the call to __dmc620_pmu_get_irq(). While at it, rename
> dmc620_pmu_irqs_lock to dmc620_pmu_list_lock as it is now just protecting
> the iteration and modification of pmus_node and irqs_node lists.
> 
> As a result, cpuhp_state_add_instance_nocalls() won't be called with
> reanemd dmc620_pmu_list_lock held and cpu_hotplug_lock won't be acquired
> after dmc620_pmu_list_lock.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   drivers/perf/arm_dmc620_pmu.c | 34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 9d0f01c4455a..a5bfc8f2e6ab 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -66,8 +66,14 @@
>   #define DMC620_PMU_COUNTERn_OFFSET(n) \
>   	(DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
>   
> +/*
> + * The allowable lock ordering is:
> + * - dmc620_pmu_get_lock (protects call to __dmc620_pmu_get_irq())
> + * - dmc620_pmu_list_lock (protects pmus_node & irqs_node lists)

Sorry, this isn't right: touching the irqs_node list *is* the aspect of 
__dmc620_pmu_get_irq() which warrants globally locking. It's then the 
pmus_node lists which want locking separately from that - those could 
strictly be locked per dmc620_pmu_irq instance, but that would be a big 
waste of space, so we can still combine them under a single global lock. 
I just went too far in thinking I could get away with (ab)using the same 
lock for both purposes since they didn't overlap :)

> + */
> +static DEFINE_MUTEX(dmc620_pmu_get_lock);
> +static DEFINE_MUTEX(dmc620_pmu_list_lock);
>   static LIST_HEAD(dmc620_pmu_irqs);
> -static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
>   
>   struct dmc620_pmu_irq {
>   	struct hlist_node node;
> @@ -423,9 +429,11 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>   	struct dmc620_pmu_irq *irq;
>   	int ret;
>   
> +	mutex_lock(&dmc620_pmu_list_lock);
>   	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
>   		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
> -			return irq;
> +			goto unlock_out;
> +	mutex_unlock(&dmc620_pmu_list_lock);
>   
>   	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
>   	if (!irq)
> @@ -452,8 +460,10 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>   		goto out_free_irq;
>   
>   	irq->irq_num = irq_num;
> +	mutex_lock(&dmc620_pmu_list_lock);
>   	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
> -
> +unlock_out:
> +	mutex_unlock(&dmc620_pmu_list_lock);
>   	return irq;
>   
>   out_free_irq:
> @@ -467,17 +477,17 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
>   {
>   	struct dmc620_pmu_irq *irq;
>   
> -	mutex_lock(&dmc620_pmu_irqs_lock);
> +	mutex_lock(&dmc620_pmu_get_lock);
>   	irq = __dmc620_pmu_get_irq(irq_num);
> -	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	mutex_unlock(&dmc620_pmu_get_lock);
>   
>   	if (IS_ERR(irq))
>   		return PTR_ERR(irq);
>   
>   	dmc620_pmu->irq = irq;
> -	mutex_lock(&dmc620_pmu_irqs_lock);
> +	mutex_lock(&dmc620_pmu_list_lock);
>   	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
> -	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	mutex_unlock(&dmc620_pmu_list_lock);
>   
>   	return 0;
>   }
> @@ -486,16 +496,16 @@ static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
>   {
>   	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
>   
> -	mutex_lock(&dmc620_pmu_irqs_lock);
> +	mutex_lock(&dmc620_pmu_list_lock);
>   	list_del_rcu(&dmc620_pmu->pmus_node);

Ah, it might be the laziness in this function that's misled you. 
Logically it ought to just be a case of dropping pmu_list_lock here 
after removing from the pmus_node list, then taking pmu_get_lock before 
the following list_del from the main global list (I think that shouldn't 
*need* to cover the refcount operation as well, but equally there's 
probably no harm if it does).

Thanks,
Robin.

>   	if (!refcount_dec_and_test(&irq->refcount)) {
> -		mutex_unlock(&dmc620_pmu_irqs_lock);
> +		mutex_unlock(&dmc620_pmu_list_lock);
>   		return;
>   	}
>   
>   	list_del(&irq->irqs_node);
> -	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	mutex_unlock(&dmc620_pmu_list_lock);
>   
>   	free_irq(irq->irq_num, irq);
>   	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
> @@ -638,10 +648,10 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
>   		return 0;
>   
>   	/* We're only reading, but this isn't the place to be involving RCU */
> -	mutex_lock(&dmc620_pmu_irqs_lock);
> +	mutex_lock(&dmc620_pmu_list_lock);
>   	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
>   		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
> -	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	mutex_unlock(&dmc620_pmu_list_lock);
>   
>   	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
>   	irq->cpu = target;
