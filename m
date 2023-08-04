Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636E37706A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHDREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjHDREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C84EFB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691168619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ew8+859/KxLYM1PCEstkPSyPtAKzzdZ/Lbawn2bmLw=;
        b=hNSjb0uJck+kifk+VV+s9fSbjLay4S6iheJ4PW/jJ8V0TSlIfOoU+iBBvjrKoblRS0RfyB
        JIdBrU0WVAeOaxFaNQAOIsYG/rfm8Yb7zyBcRRT81sdJAiErZliJdE70jzLht2/JYlZPRD
        JP9UoSo9RqPAHcJf6a77iBDLmn6f4NI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-C06GJQ95O-i084vS0IMVbw-1; Fri, 04 Aug 2023 13:03:38 -0400
X-MC-Unique: C06GJQ95O-i084vS0IMVbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C09D185A7AE;
        Fri,  4 Aug 2023 17:03:37 +0000 (UTC)
Received: from [10.22.33.115] (unknown [10.22.33.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBFE040C1258;
        Fri,  4 Aug 2023 17:03:36 +0000 (UTC)
Message-ID: <352465f6-394a-6f91-712d-85ed15588822@redhat.com>
Date:   Fri, 4 Aug 2023 13:03:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] perf/arm-dmc620: Fix
 dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20230722031729.3913953-1-longman@redhat.com>
 <20230728150614.GF21718@willie-the-truck>
 <62d4b353-0237-9ec6-a63e-8a7a6764aba5@redhat.com>
 <20230804162812.GC30679@willie-the-truck>
 <458ac4d2-bb8a-0359-f198-dd53f4c84bd3@redhat.com>
 <20230804165943.GG30679@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230804165943.GG30679@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 12:59, Will Deacon wrote:
> On Fri, Aug 04, 2023 at 12:51:47PM -0400, Waiman Long wrote:
>> On 8/4/23 12:28, Will Deacon wrote:
>>>>>>     struct dmc620_pmu {
>>>>>> @@ -423,9 +424,14 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>>>>>>     	struct dmc620_pmu_irq *irq;
>>>>>>     	int ret;
>>>>>> -	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
>>>>>> -		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
>>>>>> +	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
>>>>>> +		if (irq->irq_num != irq_num)
>>>>>> +			continue;
>>>>>> +		if (!irq->valid)
>>>>>> +			return ERR_PTR(-EAGAIN);	/* Try again later */
>>>>> It looks like this can bubble up to the probe() routine. Does the driver
>>>>> core handle -EAGAIN coming back from a probe routine?
>>>> Right, I should add code to handle this error condition. I think it can be
>>>> handled in dmc620_pmu_get_irq(). The important thing is to release the
>>>> mutex, wait a few ms and try again. What do you think?
>>> I don't really follow, but waiting a few ms and trying again sounds like
>>> a really nasty hack for something which doesn't appear to be constrained
>>> by broken hardware. In other words, we got ourselves into this mess, so
>>> we should be able to resolve it properly.
>>  From my point of view, the proper way to solve the problem is to reverse the
>> locking order. Since you don't to add a EXPORT statement to the core kernel
>> code, we will have to find a way around it by not holding the
>> dmc620_pmu_irqs_lock when cpuhp_state_add_instance_nocalls() is called.
>> Another alternative that I can think of is to add one more mutex that we
>> will hold just for the entirety of  __dmc620_pmu_get_irq() and take
>> dmc620_pmu_irqs_lock only when the linked list is being modified. That will
>> eliminate the need to introduce arbitrary wait as other caller of
>> __dmc620_pmu_get_irq() will wait in the new mutex. Will this work for you?
> Yes. To be honest, I think we've both spent far too much time trying to
> fix this (and I admire your persistence!), so adding a mutex to make it
> "obviously" correct sounds like the right thing to me. We can look at
> optimisations later if anybody cares.

Sorry to be too persistent sometimes:-) Will send out a new version soon.

Cheers,
Longman

