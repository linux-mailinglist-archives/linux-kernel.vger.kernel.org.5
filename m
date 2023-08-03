Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FC76DD75
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHCBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHCBqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4763C3A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 18:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691027102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAsnqIzhgN70MVogLZRUKBp2r2KU3xDPwLa0t6GESpc=;
        b=jT4gYvap2Tes1KJ16NGrQonjuq8BEmfORkux3HbaYkhvItDdq0gD14b9jj4K/lif0IY3D4
        Jtp59X7NVptY1iu52q8eVbUiQ5A5uqZ4YzNRDv/TzuPSVDAvSNcJbiqO0L1WmZkhpAH6em
        /Y627njZkuDgbpTysBfmf05+XvExYvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-DPmLIw6sOKKoVy9VbKbCMw-1; Wed, 02 Aug 2023 21:44:59 -0400
X-MC-Unique: DPmLIw6sOKKoVy9VbKbCMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD12780027F;
        Thu,  3 Aug 2023 01:44:58 +0000 (UTC)
Received: from [10.22.18.41] (unknown [10.22.18.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61010200B41D;
        Thu,  3 Aug 2023 01:44:58 +0000 (UTC)
Message-ID: <3e6a9ca3-3be5-8207-4923-8ecd141c04eb@redhat.com>
Date:   Wed, 2 Aug 2023 21:44:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20230722031729.3913953-1-longman@redhat.com>
 <20230728150614.GF21718@willie-the-truck>
 <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
In-Reply-To: <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/23 21:37, Waiman Long wrote:
>
> On 7/28/23 11:06, Will Deacon wrote:
>> On Fri, Jul 21, 2023 at 11:17:28PM -0400, Waiman Long wrote:
>>> The following circular locking dependency was reported when running
>>> cpus online/offline test on an arm64 system.
>>>
>>> [   84.195923] Chain exists of:
>>>                   dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> 
>>> cpuhp_state-down
>>>
>>> [   84.207305]  Possible unsafe locking scenario:
>>>
>>> [   84.213212]        CPU0                    CPU1
>>> [   84.217729]        ----                    ----
>>> [   84.222247]   lock(cpuhp_state-down);
>>> [   84.225899] lock(cpu_hotplug_lock);
>>> [   84.232068] lock(cpuhp_state-down);
>>> [   84.238237]   lock(dmc620_pmu_irqs_lock);
>>> [   84.242236]
>>>                  *** DEADLOCK ***
>>>
>>> The problematic locking order seems to be
>>>
>>>     lock(dmc620_pmu_irqs_lock) --> lock(cpu_hotplug_lock)
>>>
>>> This locking order happens when dmc620_pmu_get_irq() is called from
>>> dmc620_pmu_device_probe(). Since dmc620_pmu_irqs_lock is used for
>>> protecting the dmc620_pmu_irqs structure only, we don't actually need
>>> to hold the lock when adding a new instance to the CPU hotplug 
>>> subsystem.
>>>
>>> Fix this possible deadlock scenario by releasing the lock before
>>> calling cpuhp_state_add_instance_nocalls() and reacquiring it 
>>> afterward.
>>> To avoid the possibility of 2 racing dmc620_pmu_get_irq() calls 
>>> inserting
>>> duplicated dmc620_pmu_irq structures with the same irq number, a dummy
>>> entry is inserted before releasing the lock which will block a 
>>> competing
>>> thread from inserting another irq structure of the same irq number.
>>>
>>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>   drivers/perf/arm_dmc620_pmu.c | 28 ++++++++++++++++++++++------
>>>   1 file changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm_dmc620_pmu.c 
>>> b/drivers/perf/arm_dmc620_pmu.c
>>> index 9d0f01c4455a..7cafd4dd4522 100644
>>> --- a/drivers/perf/arm_dmc620_pmu.c
>>> +++ b/drivers/perf/arm_dmc620_pmu.c
>>> @@ -76,6 +76,7 @@ struct dmc620_pmu_irq {
>>>       refcount_t refcount;
>>>       unsigned int irq_num;
>>>       unsigned int cpu;
>>> +    unsigned int valid;
>>>   };
>>>     struct dmc620_pmu {
>>> @@ -423,9 +424,14 @@ static struct dmc620_pmu_irq 
>>> *__dmc620_pmu_get_irq(int irq_num)
>>>       struct dmc620_pmu_irq *irq;
>>>       int ret;
>>>   -    list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
>>> -        if (irq->irq_num == irq_num && 
>>> refcount_inc_not_zero(&irq->refcount))
>>> +    list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
>>> +        if (irq->irq_num != irq_num)
>>> +            continue;
>>> +        if (!irq->valid)
>>> +            return ERR_PTR(-EAGAIN);    /* Try again later */
>> It looks like this can bubble up to the probe() routine. Does the driver
>> core handle -EAGAIN coming back from a probe routine?
> Right, I should add code to handle this error condition. I think it 
> can be handled in dmc620_pmu_get_irq(). The important thing is to 
> release the mutex, wait a few ms and try again. What do you think?
>>
>>> +        if (refcount_inc_not_zero(&irq->refcount))
>>>               return irq;
>>> +    }
>>>         irq = kzalloc(sizeof(*irq), GFP_KERNEL);
>>>       if (!irq)
>>> @@ -447,13 +453,23 @@ static struct dmc620_pmu_irq 
>>> *__dmc620_pmu_get_irq(int irq_num)
>>>       if (ret)
>>>           goto out_free_irq;
>>>   -    ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, 
>>> &irq->node);
>>> -    if (ret)
>>> -        goto out_free_irq;
>>> -
>>>       irq->irq_num = irq_num;
>>>       list_add(&irq->irqs_node, &dmc620_pmu_irqs);
>>>   +    /*
>>> +     * Release dmc620_pmu_irqs_lock before calling
>>> +     * cpuhp_state_add_instance_nocalls() and reacquire it afterward.
>>> +     */
>>> +    mutex_unlock(&dmc620_pmu_irqs_lock);
>>> +    ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, 
>>> &irq->node);
>>> +    mutex_lock(&dmc620_pmu_irqs_lock);
>>> +
>>> +    if (ret) {
>>> +        list_del(&irq->irqs_node);
>>> +        goto out_free_irq;
>>> +    }
>>> +
>>> +    irq->valid = true;
>> Do you actually need a new flag here, or could we use a refcount of zero
>> to indicate that the irq descriptor is still being constructed?
>
> A refcount of zero can also mean that an existing irq is about to be 
> removed. Right? So I don't think we can use that for this purpose. 
> Besides, there is a 4-byte hole in the structure anyway for arm64.

Alternatively, I can use a special reference count value, say -1, to 
signal that the irq is not valid yet. What do you think?

Cheers,
Longman

