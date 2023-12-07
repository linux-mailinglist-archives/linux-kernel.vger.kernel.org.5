Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE278807E47
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjLGCQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjLGCQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14BD63
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701915404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBSYHwojXw9kaGuT0KXDyW/rgXDL9EP6Xo6RAZZVUjw=;
        b=HuDrTkg1yBQ9tP2VPQfCDKNUYKnDHbYDOPDPeqryiPdxh+Fw6LGJZlXmwZyLcB30Xx2mKp
        mF80hnTLlL81lKkkrkS5sPsGN/LxGT91jN0HClzQJy3fUT8Nhs1fdC9xzeKRZb608Z41Zs
        4Lx10HbzDabKfXQopFJHO1sutE8avuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-rmphrsgtOkS3HsEJKlrQog-1; Wed, 06 Dec 2023 21:16:38 -0500
X-MC-Unique: rmphrsgtOkS3HsEJKlrQog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA08F101A551;
        Thu,  7 Dec 2023 02:16:37 +0000 (UTC)
Received: from [10.22.34.92] (unknown [10.22.34.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 766B4C15E6C;
        Thu,  7 Dec 2023 02:16:35 +0000 (UTC)
Message-ID: <377e4437-7051-4d88-ae68-1460bcd692e1@redhat.com>
Date:   Wed, 6 Dec 2023 21:16:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US
To:     George Stark <gnstark@salutedevices.com>,
        Hans de Goede <hdegoede@redhat.com>, pavel@ucw.cz,
        lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mazziesaccount@gmail.com, andy.shevchenko@gmail.com,
        jic23@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        will@kernel.org, mingo@redhat.com
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
 <81798fe5-f89e-482f-b0d0-674ccbfc3666@redhat.com>
 <29584eb6-fa10-4ce0-9fa3-0c409a582445@salutedevices.com>
 <580ecff0-b335-4cc0-b928-a99fe73741ca@redhat.com>
 <469f44fb-2371-4b3b-bc1c-d09ec35a5ec8@redhat.com>
 <75368bdb-b54e-4e15-a3c0-89b920e5e729@salutedevices.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <75368bdb-b54e-4e15-a3c0-89b920e5e729@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 19:37, George Stark wrote:
> Hello Waiman
>
> Thanks for the review.
>
> On 12/7/23 00:02, Waiman Long wrote:
>> On 12/6/23 14:55, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12/6/23 19:58, George Stark wrote:
>>>> Hello Hans
>>>>
>>>> Thanks for the review.
>>>>
>>>> On 12/6/23 18:01, Hans de Goede wrote:
>>>>> Hi George,
>>>>>
> ...
>>>>> mutex_destroy() only actually does anything if CONFIG_DEBUG_MUTEXES
>>>>> is set, otherwise it is an empty inline-stub.
>>>>>
>>>>> Adding a devres resource to the device just to call an empty inline
>>>>> stub which is a no-op seems like a waste of resources. IMHO it
>>>>> would be better to change this to:
>>>>>
>>>>> static inline int devm_mutex_init(struct device *dev, struct mutex 
>>>>> *lock)
>>>>> {
>>>>>      mutex_init(lock);
>>>>> #ifdef CONFIG_DEBUG_MUTEXES
>>>>>      return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>>>>> #else
>>>>>      return 0;
>>>>> #endif
>>>>> }
>>>>>
>>>>> To avoid the unnecessary devres allocation when
>>>>> CONFIG_DEBUG_MUTEXES is not set.
>>>> Honestly saying I don't like unnecessary devres allocation either 
>>>> but the proposed approach has its own price:
>>>>
>>>> 1) we'll have more than one place with branching if mutex_destroy 
>>>> is empty or not using  indirect condition. If suddenly 
>>>> mutex_destroy is extended for non-debug code (in upstream branch or 
>>>> e.g. by someone for local debug) than there'll be a problem.
>>>>
>>>> 2) If mutex_destroy is empty or not depends on CONFIG_PREEMPT_RT 
>>>> option too. When CONFIG_PREEMPT_RT is on mutex_destroy is always 
>>>> empty.
>>>>
>>>> As I see it only the mutex interface (mutex.h) has to say 
>>>> definitely if mutex_destroy must be called. Probably we could add 
>>>> some define to include/linux/mutex.h,like IS_MUTEX_DESTROY_REQUIRED 
>>>> and declare it near mutex_destroy definition itself.
>>> That (a  IS_MUTEX_DESTROY_REQUIRED define) is an interesting idea. 
>>> Lets s>
>>>>> Adding a devres resource to the device just to call an empty inline
>>>>> stub which is a no-op seems like a waste of resources. IMHO it
>>>>> would be better to change this to:
>>>>>
>>>>> static inline int devm_mutex_init(struct device *dev, struct mutex 
>>>>> *lock)
>>>>> {
>>>>>      mutex_init(lock);
>>>>> #ifdef CONFIG_DEBUG_MUTEXES
>>>>>      return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>>>>> #else
>>>>>      return 0;
>>>>> #endif
>>>>> }
>>>>> ee for v3 if the mutex maintainers will accept that and if not 
>>> then I guess we will just need to live with the unnecessary devres 
>>> allocation.
>>
>> The purpose of calling mutex_destroy() is to mark a mutex as being 
>> destroyed so that any subsequent call to mutex_lock/unlock will cause 
>> a warning to be printed when CONFIG_DEBUG_MUTEXES is defined. I would 
>> not say that mutex_destroy() is required. Rather it is a nice to have 
>> for catching programming error.
>
> This is quite understandable but probably mutex_destroy() is not the 
> best name for an optional API. Questions are asked over and over again
> if it can be safely ignored taking into account that it could be 
> extended in the future. Every maintainer makes decision on that question
> in his own way and it leads to inconsistency.
>
> devm_mutex_init could take responsibility for calling/dropping 
> mutex_destroy() on its own.

The DEBUG_MUTEXES code is relatively old and there was no major change 
to it for a number of years. I don't see we will make major change to it 
in the near future. Of course, thing may change if there are new 
requirement that may affect the DEBUG_MUTEXES code.

Cheers,
Longman

>
>> Cheers,
>> Longman
>>
>

