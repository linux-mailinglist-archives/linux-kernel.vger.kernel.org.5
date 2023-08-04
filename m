Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802B770658
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjHDQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A3422B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691167909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFe9NXRVWZZcjHmuHznmjHqL0ggt547E/jdYJJf8j2A=;
        b=IYuuCRjAqvjQgSpSmfZclpOFw1yyTnWCMHYgI/yG+ynBaQdqN0W5J1nTfSeq4+aznsyfx3
        psoW44s7QOMzqy6fe3h7ZRNxOCbXxVagSasxcN+le8cJE0c6waXOjgMFbx7yYyHj4PGQ33
        4QwaPg3LOb7GIgFsQFGxbzZ85NslhlY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-UIvp98hPNJyvQR9q9dIcrQ-1; Fri, 04 Aug 2023 12:51:48 -0400
X-MC-Unique: UIvp98hPNJyvQR9q9dIcrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C8783C100CB;
        Fri,  4 Aug 2023 16:51:47 +0000 (UTC)
Received: from [10.22.33.115] (unknown [10.22.33.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4694E112132D;
        Fri,  4 Aug 2023 16:51:47 +0000 (UTC)
Message-ID: <458ac4d2-bb8a-0359-f198-dd53f4c84bd3@redhat.com>
Date:   Fri, 4 Aug 2023 12:51:47 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230804162812.GC30679@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 12:28, Will Deacon wrote:
>>>>    struct dmc620_pmu {
>>>> @@ -423,9 +424,14 @@ static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
>>>>    	struct dmc620_pmu_irq *irq;
>>>>    	int ret;
>>>> -	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
>>>> -		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
>>>> +	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node) {
>>>> +		if (irq->irq_num != irq_num)
>>>> +			continue;
>>>> +		if (!irq->valid)
>>>> +			return ERR_PTR(-EAGAIN);	/* Try again later */
>>> It looks like this can bubble up to the probe() routine. Does the driver
>>> core handle -EAGAIN coming back from a probe routine?
>> Right, I should add code to handle this error condition. I think it can be
>> handled in dmc620_pmu_get_irq(). The important thing is to release the
>> mutex, wait a few ms and try again. What do you think?
> I don't really follow, but waiting a few ms and trying again sounds like
> a really nasty hack for something which doesn't appear to be constrained
> by broken hardware. In other words, we got ourselves into this mess, so
> we should be able to resolve it properly.

 From my point of view, the proper way to solve the problem is to 
reverse the locking order. Since you don't to add a EXPORT statement to 
the core kernel code, we will have to find a way around it by not 
holding the dmc620_pmu_irqs_lock when cpuhp_state_add_instance_nocalls() 
is called. Another alternative that I can think of is to add one more 
mutex that we will hold just for the entirety of  __dmc620_pmu_get_irq() 
and take dmc620_pmu_irqs_lock only when the linked list is being 
modified. That will eliminate the need to introduce arbitrary wait as 
other caller of __dmc620_pmu_get_irq() will wait in the new mutex. Will 
this work for you?

Cheers,
Longman

