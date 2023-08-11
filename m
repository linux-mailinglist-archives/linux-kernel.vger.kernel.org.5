Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8477971A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHKS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHKS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2830DD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691778400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gWRnpqNuc3HKdM1o4LH3xteZb8Q83KGH9Nvlo0+U0Q=;
        b=fJq3/cK90/bt7VKSFn7TP+DzY6FrgIoDT30OJsV8Se9hNsRK7onPw1ltnzCd3w+OVu1Qcw
        jSvXANbPIAO/bP44S0qWsCK14+/qOeQ8SeoMrzzNCKTwej9xt2riUllCEsb5NfLad4BWv1
        NLIaT2m5j5J1LTNvIwCjUF9TYfHPSbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-3pMXS0aUO42EaMneI-6obw-1; Fri, 11 Aug 2023 14:26:37 -0400
X-MC-Unique: 3pMXS0aUO42EaMneI-6obw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD09185A792;
        Fri, 11 Aug 2023 18:26:36 +0000 (UTC)
Received: from [10.22.17.82] (unknown [10.22.17.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A871D1121314;
        Fri, 11 Aug 2023 18:26:36 +0000 (UTC)
Message-ID: <a49858bf-fbe6-bec6-664a-7aad1ee53ffb@redhat.com>
Date:   Fri, 11 Aug 2023 14:26:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230810154114.405742-1-longman@redhat.com>
 <a956e24b-7f78-7aa0-ec1a-1e6b169c5835@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <a956e24b-7f78-7aa0-ec1a-1e6b169c5835@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 13:21, Robin Murphy wrote:
> On 10/08/2023 4:41 pm, Waiman Long wrote:
>> The following circular locking dependency was reported when running
>> cpus online/offline test on an arm64 system.
>>
>> [   84.195923] Chain exists of:
>>                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> 
>> cpuhp_state-down
>>
>> [   84.207305]  Possible unsafe locking scenario:
>>
>> [   84.213212]        CPU0                    CPU1
>> [   84.217729]        ----                    ----
>> [   84.222247]   lock(cpuhp_state-down);
>> [   84.225899] lock(cpu_hotplug_lock);
>> [   84.232068] lock(cpuhp_state-down);
>> [   84.238237]   lock(dmc620_pmu_irqs_lock);
>> [   84.242236]
>>                  *** DEADLOCK ***
>>
>> The problematic locking order seems to be
>>
>>     lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
>>
>> This locking order happens when dmc620_pmu_get_irq() calls
>> cpuhp_state_add_instance_nocalls(). Since dmc620_pmu_irqs_lock is used
>> for protecting the dmc620_pmu_irqs structure, we don't actually need
>> to hold the lock when adding a new instance to the CPU hotplug 
>> subsystem.
>>
>> Fix this possible deadlock scenario by adding a new dmc620_pmu_get_lock
>> for protecting the call to __dmc620_pmu_get_irq(). While at it, rename
>> dmc620_pmu_irqs_lock to dmc620_pmu_list_lock as it is now just 
>> protecting
>> the iteration and modification of pmus_node and irqs_node lists.
>>
>> As a result, cpuhp_state_add_instance_nocalls() won't be called with
>> reanemd dmc620_pmu_list_lock held and cpu_hotplug_lock won't be acquired
>> after dmc620_pmu_list_lock.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/perf/arm_dmc620_pmu.c | 34 ++++++++++++++++++++++------------
>>   1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/perf/arm_dmc620_pmu.c 
>> b/drivers/perf/arm_dmc620_pmu.c
>> index 9d0f01c4455a..a5bfc8f2e6ab 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -66,8 +66,14 @@
>>   #define DMC620_PMU_COUNTERn_OFFSET(n) \
>>       (DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
>>   +/*
>> + * The allowable lock ordering is:
>> + * - dmc620_pmu_get_lock (protects call to __dmc620_pmu_get_irq())
>> + * - dmc620_pmu_list_lock (protects pmus_node & irqs_node lists)
>
> Sorry, this isn't right: touching the irqs_node list *is* the aspect 
> of __dmc620_pmu_get_irq() which warrants globally locking. It's then 
> the pmus_node lists which want locking separately from that - those 
> could strictly be locked per dmc620_pmu_irq instance, but that would 
> be a big waste of space, so we can still combine them under a single 
> global lock. I just went too far in thinking I could get away with 
> (ab)using the same lock for both purposes since they didn't overlap :)

OK, you want separate locks for pmus_node list and irqs_node list. That 
will be fine too. I can make the change.

Thanks,
Longman

>
>> + */
>> +static DEFINE_MUTEX(dmc620_pmu_get_lock);
>> +static DEFINE_MUTEX(dmc620_pmu_list_lock);
>>   static LIST_HEAD(dmc620_pmu_irqs);
>> -static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
>>     struct dmc620_pmu_irq {
>>       struct hlist_node node;
>> @@ -423,9 +429,11 @@ static struct dmc620_pmu_irq 
>> *__dmc620_pmu_get_irq(int irq_num)
>>       struct dmc620_pmu_irq *irq;
>>       int ret;
>>   +    mutex_lock(&dmc620_pmu_list_lock);
>>       list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
>>           if (irq->irq_num == irq_num && 
>> refcount_inc_not_zero(&irq->refcount))
>> -            return irq;
>> +            goto unlock_out;
>> +    mutex_unlock(&dmc620_pmu_list_lock);
>>         irq = kzalloc(sizeof(*irq), GFP_KERNEL);
>>       if (!irq)
>> @@ -452,8 +460,10 @@ static struct dmc620_pmu_irq 
>> *__dmc620_pmu_get_irq(int irq_num)
>>           goto out_free_irq;
>>         irq->irq_num = irq_num;
>> +    mutex_lock(&dmc620_pmu_list_lock);
>>       list_add(&irq->irqs_node, &dmc620_pmu_irqs);
>> -
>> +unlock_out:
>> +    mutex_unlock(&dmc620_pmu_list_lock);
>>       return irq;
>>     out_free_irq:
>> @@ -467,17 +477,17 @@ static int dmc620_pmu_get_irq(struct dmc620_pmu 
>> *dmc620_pmu, int irq_num)
>>   {
>>       struct dmc620_pmu_irq *irq;
>>   -    mutex_lock(&dmc620_pmu_irqs_lock);
>> +    mutex_lock(&dmc620_pmu_get_lock);
>>       irq = __dmc620_pmu_get_irq(irq_num);
>> -    mutex_unlock(&dmc620_pmu_irqs_lock);
>> +    mutex_unlock(&dmc620_pmu_get_lock);
>>         if (IS_ERR(irq))
>>           return PTR_ERR(irq);
>>         dmc620_pmu->irq = irq;
>> -    mutex_lock(&dmc620_pmu_irqs_lock);
>> +    mutex_lock(&dmc620_pmu_list_lock);
>>       list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
>> -    mutex_unlock(&dmc620_pmu_irqs_lock);
>> +    mutex_unlock(&dmc620_pmu_list_lock);
>>         return 0;
>>   }
>> @@ -486,16 +496,16 @@ static void dmc620_pmu_put_irq(struct 
>> dmc620_pmu *dmc620_pmu)
>>   {
>>       struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
>>   -    mutex_lock(&dmc620_pmu_irqs_lock);
>> +    mutex_lock(&dmc620_pmu_list_lock);
>>       list_del_rcu(&dmc620_pmu->pmus_node);
>
> Ah, it might be the laziness in this function that's misled you. 
> Logically it ought to just be a case of dropping pmu_list_lock here 
> after removing from the pmus_node list, then taking pmu_get_lock 
> before the following list_del from the main global list (I think that 
> shouldn't *need* to cover the refcount operation as well, but equally 
> there's probably no harm if it does).
>
> Thanks,
> Robin.
>
>>       if (!refcount_dec_and_test(&irq->refcount)) {
>> -        mutex_unlock(&dmc620_pmu_irqs_lock);
>> +        mutex_unlock(&dmc620_pmu_list_lock);
>>           return;
>>       }
>>         list_del(&irq->irqs_node);
>> -    mutex_unlock(&dmc620_pmu_irqs_lock);
>> +    mutex_unlock(&dmc620_pmu_list_lock);
>>         free_irq(irq->irq_num, irq);
>>       cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
>> @@ -638,10 +648,10 @@ static int dmc620_pmu_cpu_teardown(unsigned int 
>> cpu,
>>           return 0;
>>         /* We're only reading, but this isn't the place to be 
>> involving RCU */
>> -    mutex_lock(&dmc620_pmu_irqs_lock);
>> +    mutex_lock(&dmc620_pmu_list_lock);
>>       list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
>>           perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
>> -    mutex_unlock(&dmc620_pmu_irqs_lock);
>> +    mutex_unlock(&dmc620_pmu_list_lock);
>>         WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
>>       irq->cpu = target;
>

