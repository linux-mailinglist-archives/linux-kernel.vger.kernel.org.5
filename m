Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E47748CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjHHTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjHHTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB8AD62A3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691521806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeVkxpfosTFSRrQDbRSKpxY5xH9FceNhlXTELBhZXOw=;
        b=R906pwMDdDRjLQXPKka2wT0+qVGfpTj2KYIN3PR+kwplW9+w1I2KHvKAokY/X5y3uiL7PX
        s8iRYzc1dreTWllSbZos/oayOMqd1o9i/pxfU10CCyv7TvZsc5Sc+ROXCFegGfY2TGNHoY
        nrSEuYjeAv6rJIZJ/KzW4H1hN8b9/gM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-tXHDdqDvNuKxE3PntJYYqg-1; Tue, 08 Aug 2023 15:10:02 -0400
X-MC-Unique: tXHDdqDvNuKxE3PntJYYqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2434885C715;
        Tue,  8 Aug 2023 19:10:02 +0000 (UTC)
Received: from [10.22.17.153] (unknown [10.22.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B2D40C6F53;
        Tue,  8 Aug 2023 19:10:01 +0000 (UTC)
Message-ID: <e2be710d-336e-7136-ef23-08f5eab35aed@redhat.com>
Date:   Tue, 8 Aug 2023 15:10:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230807154446.208572-1-longman@redhat.com>
 <0d32adf1-43fd-2762-d5ab-707d5969dcb0@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <0d32adf1-43fd-2762-d5ab-707d5969dcb0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/8/23 08:29, Robin Murphy wrote:
> On 2023-08-07 16:44, Waiman Long wrote:
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
>> for protecting the dmc620_pmu_irqs structure only, we don't actually 
>> need
>> to hold the lock when adding a new instance to the CPU hotplug 
>> subsystem.
>>
>> Fix this possible deadlock scenario by adding a new
>> dmc620_pmu_get_irq_lock for protecting the call to 
>> __dmc620_pmu_get_irq()
>> and taking dmc620_pmu_irqs_lock inside __dmc620_pmu_get_irq()
>> only when dmc620_pmu_irqs is being searched or modified. As a
>> result, cpuhp_state_add_instance_nocalls() won't be called with
>> dmc620_pmu_irqs_lock held and cpu_hotplug_lock won't be acquired after
>> dmc620_pmu_irqs_lock.
>>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/perf/arm_dmc620_pmu.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/perf/arm_dmc620_pmu.c 
>> b/drivers/perf/arm_dmc620_pmu.c
>> index 9d0f01c4455a..895971915f2d 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -68,6 +68,7 @@
>>     static LIST_HEAD(dmc620_pmu_irqs);
>>   static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
>> +static DEFINE_MUTEX(dmc620_pmu_get_irq_lock);
>>     struct dmc620_pmu_irq {
>>       struct hlist_node node;
>> @@ -421,11 +422,18 @@ static irqreturn_t dmc620_pmu_handle_irq(int 
>> irq_num, void *data)
>>   static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>>   {
>>       struct dmc620_pmu_irq *irq;
>> +    bool found = false;
>>       int ret;
>>   +    mutex_lock(&dmc620_pmu_irqs_lock);
>
> Do we strictly need this? I'd hope that the outer release/acquire of 
> dmc620_get_pmu_irqs_lock already means we can't observe an invalid 
> value of irq->irq_num, and the refcount op should be atomic in itself, 
> no? Fair enough if there's some other subtlety I'm missing - I do 
> trust that you're more experienced in locking and barrier semantics 
> than I am! - and if it comes to it I'd agree that simple extra locking 
> is preferable to getting into explicit memory barriers here. locking

I guess we can use rcu_read_lock/rcu_read_unlock and 
list_for_each_entry_rcu() to avoid taking dmc620_pmu_irqs_lock here. 
However, we also need to change the list_del(&irq->irqs_node) & 
list_add(&irq->irqs_node,...) to use their rcu equivalents to make it 
more fail-safe. The problem with RCU is that you have to think carefully 
before you can use it. Locking, on the other hand, don't need such 
serious thought. So it is easier for lazy people :-) So I still prefer 
the simple locking scheme.


>
> One other nit either way, could we clarify the names to be something 
> like irqs_list_lock and irqs_users_lock? The split locking scheme 
> doesn't exactly lend itself to being super-obvious, especially if we 
> do end up nesting both locks, so I think naming them after what they 
> semantically protect seems the most readable option. Otherwise, this 
> does pretty much look like what I originally had in mind.

I think it is a good to rename dmc620_pmu_irqs_lock to 
dmc620_pmu_irqs_list_lock. For the other lock, its purpose is to make 
sure that only one user can get to __dmc620_pmu_get_irq(), may be 
dmc620_irqs_get_lock. I can add some comment to clarify the nesting 
relationship.

Cheers,
Longman


