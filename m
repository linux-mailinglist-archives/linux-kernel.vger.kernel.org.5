Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E97774125
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjHHRP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjHHROm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:14:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB3326A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23225150C;
        Tue,  8 Aug 2023 05:30:20 -0700 (PDT)
Received: from [10.1.26.48] (010265703453.arm.com [10.1.26.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18FE3F59C;
        Tue,  8 Aug 2023 05:29:36 -0700 (PDT)
Message-ID: <0d32adf1-43fd-2762-d5ab-707d5969dcb0@arm.com>
Date:   Tue, 8 Aug 2023 13:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-GB
To:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230807154446.208572-1-longman@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230807154446.208572-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-07 16:44, Waiman Long wrote:
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
> for protecting the dmc620_pmu_irqs structure only, we don't actually need
> to hold the lock when adding a new instance to the CPU hotplug subsystem.
> 
> Fix this possible deadlock scenario by adding a new
> dmc620_pmu_get_irq_lock for protecting the call to __dmc620_pmu_get_irq()
> and taking dmc620_pmu_irqs_lock inside __dmc620_pmu_get_irq()
> only when dmc620_pmu_irqs is being searched or modified. As a
> result, cpuhp_state_add_instance_nocalls() won't be called with
> dmc620_pmu_irqs_lock held and cpu_hotplug_lock won't be acquired after
> dmc620_pmu_irqs_lock.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   drivers/perf/arm_dmc620_pmu.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> index 9d0f01c4455a..895971915f2d 100644
> --- a/drivers/perf/arm_dmc620_pmu.c
> +++ b/drivers/perf/arm_dmc620_pmu.c
> @@ -68,6 +68,7 @@
>   
>   static LIST_HEAD(dmc620_pmu_irqs);
>   static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
> +static DEFINE_MUTEX(dmc620_pmu_get_irq_lock);
>   
>   struct dmc620_pmu_irq {
>   	struct hlist_node node;
> @@ -421,11 +422,18 @@ static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
>   static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>   {
>   	struct dmc620_pmu_irq *irq;
> +	bool found = false;
>   	int ret;
>   
> +	mutex_lock(&dmc620_pmu_irqs_lock);

Do we strictly need this? I'd hope that the outer release/acquire of 
dmc620_get_pmu_irqs_lock already means we can't observe an invalid value 
of irq->irq_num, and the refcount op should be atomic in itself, no? 
Fair enough if there's some other subtlety I'm missing - I do trust that 
you're more experienced in locking and barrier semantics than I am! - 
and if it comes to it I'd agree that simple extra locking is preferable 
to getting into explicit memory barriers here.

One other nit either way, could we clarify the names to be something 
like irqs_list_lock and irqs_users_lock? The split locking scheme 
doesn't exactly lend itself to being super-obvious, especially if we do 
end up nesting both locks, so I think naming them after what they 
semantically protect seems the most readable option. Otherwise, this 
does pretty much look like what I originally had in mind.

Cheers,
Robin.

>   	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
> -		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
> -			return irq;
> +		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount)) {
> +			found = true;
> +			break;
> +		}
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	if (found)
> +		return irq;
>   
>   	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
>   	if (!irq)
> @@ -452,7 +460,9 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>   		goto out_free_irq;
>   
>   	irq->irq_num = irq_num;
> +	mutex_lock(&dmc620_pmu_irqs_lock);
>   	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
> +	mutex_unlock(&dmc620_pmu_irqs_lock);
>   
>   	return irq;
>   
> @@ -467,9 +477,9 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
>   {
>   	struct dmc620_pmu_irq *irq;
>   
> -	mutex_lock(&dmc620_pmu_irqs_lock);
> +	mutex_lock(&dmc620_pmu_get_irq_lock);
>   	irq = __dmc620_pmu_get_irq(irq_num);
> -	mutex_unlock(&dmc620_pmu_irqs_lock);
> +	mutex_unlock(&dmc620_pmu_get_irq_lock);
>   
>   	if (IS_ERR(irq))
>   		return PTR_ERR(irq);
