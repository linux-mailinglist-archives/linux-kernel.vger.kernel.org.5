Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EE7FCCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376749AbjK2Cfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Cfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:35:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C51727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701225338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwJB9IE9U0fNkYKAsbTbaHexqgcD2HVrtbLOqf3Tqr4=;
        b=Wpbf/rbj39f31U+lHQ/zWtzk8A4geEmZTILOt6xKmqb5AHTOLh9m0MDBXN4FhyODgSP9dY
        EcbrvwiEX+zD2JeW2WTWFFYjoX/os3fyi6CVUOOH4xD2Cndv6baqdNO1dON/DZw6NkDkdw
        GpeWJKRnx7PIRlvhLg0JhXfovQ4xraM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-2xEdQ1gqNMKemJKqaLEgTQ-1; Tue,
 28 Nov 2023 21:35:35 -0500
X-MC-Unique: 2xEdQ1gqNMKemJKqaLEgTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FEEF3C02763;
        Wed, 29 Nov 2023 02:35:34 +0000 (UTC)
Received: from [10.22.17.248] (unknown [10.22.17.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AD2F502A;
        Wed, 29 Nov 2023 02:35:34 +0000 (UTC)
Message-ID: <66e526c8-9d06-460b-b5df-92697634106b@redhat.com>
Date:   Tue, 28 Nov 2023 21:35:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/kmemleak: Add cond_resched() to kmemleak_free_percpu()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231127194153.289626-1-longman@redhat.com>
 <ZWYPmCLi9XyUdCNT@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYPmCLi9XyUdCNT@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/23 11:04, Catalin Marinas wrote:
> On Mon, Nov 27, 2023 at 02:41:53PM -0500, Waiman Long wrote:
>>   /**
>>    * kmemleak_free_percpu - unregister a previously registered __percpu object
>>    * @ptr:	__percpu pointer to beginning of the object
>>    *
>>    * This function is called from the kernel percpu allocator when an object
>> - * (memory block) is freed (free_percpu).
>> + * (memory block) is freed (free_percpu). Since this function is inherently
>> + * slow especially on systems with a large number of CPUs, defer the actual
>> + * removal of kmemleak objects associated with the percpu pointer to a
>> + * workqueue if it is not in a task context.
>>    */
>>   void __ref kmemleak_free_percpu(const void __percpu *ptr)
>>   {
>> -	unsigned int cpu;
>> -
>>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>>   
>> -	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
>> -		for_each_possible_cpu(cpu)
>> -			delete_object_full((unsigned long)per_cpu_ptr(ptr,
>> -								      cpu));
>> +	if (!kmemleak_free_enabled || !ptr || IS_ERR(ptr))
>> +		return;
>> +
>> +	if (!in_task()) {
>> +		struct kmemleak_percpu_addr *addr;
>> +
>> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>> +		if (addr) {
>> +			INIT_WORK(&addr->work, kmemleak_free_percpu_workfn);
>> +			addr->ptr = ptr;
>> +			queue_work(system_long_wq, &addr->work);
>> +			return;
>> +		}
> We can't defer this freeing. It can mess up the kmemleak metadata if the
> per-cpu pointer is re-allocated before kmemleak removed it from its
> object tree.
You are right. In fact, it is possible for kmemleak_free_percpu() be 
called from softIRQ context. And if the system has hundreds of CPUs, it 
will take a long time to process all the free request.
>
> The problem is looking up the object tree for each per-cpu offset. We
> can make the percpu pointer handling O(1) since freeing is only done by
> the main __percpu pointer, so that's the only one needing a look-up. So
> far the per-cpu pointers are not tracked for leaking, only scanned.
>
> We could just add the per_cpu_ptr(ptr, 0) to the kmemleak
> object_tree_root but when scanning we don't have an inverse function to
> get the __percpu pointer back and calculate the pointers for the other
> CPUs (well, we could with some hacks but they are probably fragile).
We could keep a separate tree to track the percpu area. We will know the 
max percpu offset in each percpu area. The base of the percpu area is 
just per_cpu_ptr(0, cpu).
>
> What I came up with is a separate object_percpu_tree_root similar to the
> object_phys_tree_root. The only reason for these additional trees is to
> look up the kmemleak metadata when needed (usually freeing). They don't
> contain objects that are tracked for actual leaking, only scanned. A
> briefly tested patch below. I need to go through it again, update some
> comments and write a commit log:

That sounds like a good idea like what I have said above. I will do a 
more careful review of the change tomorrow as it is getting late for me 
today.

Cheers,
Longman


