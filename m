Return-Path: <linux-kernel+bounces-163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB3813CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B809E1F227BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28532C6BF;
	Thu, 14 Dec 2023 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2Bg6dUh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AF6E2C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702590531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N76kfg0ywmkR8TtMnOIAIbHKVc1yAqCoMGV3nn4LGko=;
	b=A2Bg6dUhyGeKx+QikkTQoVvqfEVMFhgB4hZ/RXgrwV934Parsx+2Iy8zj92dCjcsUIDGIc
	sHun8i8JIgVImbTO6OoTZtyA917HFrbRwkdmlAtBMkJu8hzIJhiVGA1OJfUjt8aLakQqI1
	Ih14shd4kaBEzb/39+DPGB2/1K5Fq6s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-BCArnhgcOo6X7wGnFiFIWQ-1; Thu,
 14 Dec 2023 16:48:45 -0500
X-MC-Unique: BCArnhgcOo6X7wGnFiFIWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 980A329AA3AF;
	Thu, 14 Dec 2023 21:48:44 +0000 (UTC)
Received: from [10.22.17.13] (unknown [10.22.17.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 193C41C060B1;
	Thu, 14 Dec 2023 21:48:43 +0000 (UTC)
Message-ID: <300d2131-87ef-48c1-b162-dcef0d8d5722@redhat.com>
Date: Thu, 14 Dec 2023 16:48:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] locking: introduce devm_mutex_init
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 George Stark <gnstark@salutedevices.com>,
 "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
 "vadimp@nvidia.com" <vadimp@nvidia.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>
Cc: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231214173614.2820929-3-gnstark@salutedevices.com>
 <5c10f66c-3fd8-4861-994b-13e71c24f10a@redhat.com>
 <b158ca2b-7300-4ad0-82b8-e1442d267734@csgroup.eu>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <b158ca2b-7300-4ad0-82b8-e1442d267734@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 12/14/23 14:53, Christophe Leroy wrote:
>
> Le 14/12/2023 à 19:48, Waiman Long a écrit :
>> On 12/14/23 12:36, George Stark wrote:
>>> Using of devm API leads to a certain order of releasing resources.
>>> So all dependent resources which are not devm-wrapped should be deleted
>>> with respect to devm-release order. Mutex is one of such objects that
>>> often is bound to other resources and has no own devm wrapping.
>>> Since mutex_destroy() actually does nothing in non-debug builds
>>> frequently calling mutex_destroy() is just ignored which is safe for now
>>> but wrong formally and can lead to a problem if mutex_destroy() will be
>>> extended so introduce devm_mutex_init()
>>>
>>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>>> ---
>>>    include/linux/mutex.h        | 23 +++++++++++++++++++++++
>>>    kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
>>>    2 files changed, 45 insertions(+)
>>>
>>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>>> index a33aa9eb9fc3..ebd03ff1ef66 100644
>>> --- a/include/linux/mutex.h
>>> +++ b/include/linux/mutex.h
>>> @@ -21,6 +21,8 @@
>>>    #include <linux/debug_locks.h>
>>>    #include <linux/cleanup.h>
>>> +struct device;
>>> +
>>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>    # define __DEP_MAP_MUTEX_INITIALIZER(lockname)            \
>>>            , .dep_map = {                    \
>>> @@ -127,6 +129,20 @@ extern void __mutex_init(struct mutex *lock,
>>> const char *name,
>>>     */
>>>    extern bool mutex_is_locked(struct mutex *lock);
>>> +#ifdef CONFIG_DEBUG_MUTEXES
>>> +
>>> +int devm_mutex_init(struct device *dev, struct mutex *lock);
>> Please add "extern" to the function declaration to be consistent with
>> other functional declarations in mutex.h.
> 'extern' is pointless and deprecated on function prototypes. Already
> having some is not a good reason to add new ones, errors from the past
> should be avoided nowadays. With time they should all disappear so don't
> add new ones.
Yes, "extern" is optional. It is just a suggestion and I am going to 
argue about that.
>
>>> +
>>> +#else
>>> +
>>> +static inline int devm_mutex_init(struct device *dev, struct mutex
>>> *lock)
>>> +{
>>> +    mutex_init(lock);
>>> +    return 0;
>>> +}
>> I would prefer you to add a devm_mutex_init macro after the function
>> declaration and put this inline function at the end of header if the
>> devm_mutex_init macro isn't defined. In this way, you don't need to
>> repeat this inline function twice as it has no dependency on PREEMPT_RT.
> It is already done that way for other functions in that file. Should be
> kept consistant. I agree with you it is not ideal, maybe we should
> rework that file completely but I don't like the idea of a
> devm_mutex_init macro for that.

devm_mutex_init() is not an API for the core mutex code. That is why I 
want to minimize change to the existing code layout. Putting it at the 
end will reduce confusion when developers look up mutex.h header file to 
find out what mutex functions are available.

Cheers,
Longman


