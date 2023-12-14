Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AF813A53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573084AbjLNStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733FFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702579743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53kITy3tOA4usH8Xl0YPm2kFgqevQ7XX321m2q4Kelw=;
        b=SsHQm4Eptb4cN8krD2oFD3e1vPJ41rbZmthiiRYBaY/YbYhd5IVT80qX7rrbc9SAC91ueE
        O14cHZmL2O2QS3pIuKPQg5d8ZDp08QIBJ8nxcpv3pb4Ea9nyCevZpqaDCPCZ8O9v1RUeKm
        +moEUPQbqO//7I+D+aMyjdizxoPwzRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Z86V0OOtPxaCfj8_NqiGgQ-1; Thu, 14 Dec 2023 13:48:58 -0500
X-MC-Unique: Z86V0OOtPxaCfj8_NqiGgQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F2A848944;
        Thu, 14 Dec 2023 18:48:55 +0000 (UTC)
Received: from [10.22.17.13] (unknown [10.22.17.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EFB2492BF0;
        Thu, 14 Dec 2023 18:48:52 +0000 (UTC)
Message-ID: <5c10f66c-3fd8-4861-994b-13e71c24f10a@redhat.com>
Date:   Thu, 14 Dec 2023 13:48:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] locking: introduce devm_mutex_init
Content-Language: en-US
To:     George Stark <gnstark@salutedevices.com>,
        andy.shevchenko@gmail.com, pavel@ucw.cz, lee@kernel.org,
        vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hdegoede@redhat.com,
        mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com, nikitos.tr@gmail.com
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231214173614.2820929-3-gnstark@salutedevices.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231214173614.2820929-3-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/23 12:36, George Stark wrote:
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init()
>
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   include/linux/mutex.h        | 23 +++++++++++++++++++++++
>   kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..ebd03ff1ef66 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -21,6 +21,8 @@
>   #include <linux/debug_locks.h>
>   #include <linux/cleanup.h>
>   
> +struct device;
> +
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
>   		, .dep_map = {					\
> @@ -127,6 +129,20 @@ extern void __mutex_init(struct mutex *lock, const char *name,
>    */
>   extern bool mutex_is_locked(struct mutex *lock);
>   
> +#ifdef CONFIG_DEBUG_MUTEXES
> +
> +int devm_mutex_init(struct device *dev, struct mutex *lock);
Please add "extern" to the function declaration to be consistent with 
other functional declarations in mutex.h.
> +
> +#else
> +
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return 0;
> +}

I would prefer you to add a devm_mutex_init macro after the function 
declaration and put this inline function at the end of header if the 
devm_mutex_init macro isn't defined. In this way, you don't need to 
repeat this inline function twice as it has no dependency on PREEMPT_RT.

By doing this, you can also move the function declaration right after 
mutex_destroy() without the need to add another #ifdef 
CONFIG_DEBUG_MUTEXES block.

> +
> +#endif
> +
>   #else /* !CONFIG_PREEMPT_RT */
>   /*
>    * Preempt-RT variant based on rtmutexes.
> @@ -169,6 +185,13 @@ do {							\
>   							\
>   	__mutex_init((mutex), #mutex, &__key);		\
>   } while (0)
> +
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return 0;
> +}
> +
>   #endif /* CONFIG_PREEMPT_RT */
>   
>   /*
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index bc8abb8549d2..c9efab1a8026 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -19,6 +19,7 @@
>   #include <linux/kallsyms.h>
>   #include <linux/interrupt.h>
>   #include <linux/debug_locks.h>
> +#include <linux/device.h>
>   
>   #include "mutex.h"
>   
> @@ -104,3 +105,24 @@ void mutex_destroy(struct mutex *lock)
>   }
>   
>   EXPORT_SYMBOL_GPL(mutex_destroy);
> +
> +static void devm_mutex_release(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:	Device which lifetime mutex is bound to
> + * @lock:	Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when the driver is detached.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> +}
> +EXPORT_SYMBOL_GPL(devm_mutex_init);

The mutex-debug.c change looks fine to me.

Cheers,
Longman


