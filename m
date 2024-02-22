Return-Path: <linux-kernel+bounces-76673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5341385FAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCF01F26196
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9D146904;
	Thu, 22 Feb 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRRCf0ti"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9812EBC0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610763; cv=none; b=QY90Cn9lVyZvZylKEkmzJvxtTlfOQECPm6qhJuxSUJtk+gIpbrTswKjbaB2OP20tWXPEzATmZ4Tswhuzwy5SWE3+jF/TVw8dvd1x4ctkfT+Hi21NVkNdsVR4RRaO4HppIfounZ9xdxMNpjLkLKknca5puExFUOVgf3KfIWK5FcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610763; c=relaxed/simple;
	bh=Z5Q9Z9fcndWFlDgSaG4NTU3zn+kctiKjk3KOQotSWrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbsK/2vCHx+PPMSzvx1sgaCMc7DvN66Dtb03twlzCl7ZT5l0ySg7R7xozovjSgareDfbzZIi9Yz9fM7Kp7nqrn1X4vIJCMaYieCelRq4AOEMmTEQRJUb7vlQoZabfONp/vcrxGRQIB1qJIY84xQ87V0RO1YTalOsvHecrmyHM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRRCf0ti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708610760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c36RQA7GL8/3y2hSmRR+CftEL15VjIXX+ISSIuhobyg=;
	b=bRRCf0tiuzM1P3Yuwb8xveeiNI4GSMIN6iA3UHpU60KuIrsRNeXTcx7rNIP7KId2zUrfkq
	97KPSE8w6NxcEYzuGSLKUsL6X/weQqoh79UNSVsSQflsl+FUTrpWmA5DZ+OuE1fkKUAvfm
	ozlOISRWd8IHRC2nOj2+D+DmtRRilZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-onqHEaw1ONmSH_lqE-a1pQ-1; Thu, 22 Feb 2024 09:05:56 -0500
X-MC-Unique: onqHEaw1ONmSH_lqE-a1pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAE6785CDFC;
	Thu, 22 Feb 2024 14:05:55 +0000 (UTC)
Received: from [10.22.33.9] (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D42058BCC;
	Thu, 22 Feb 2024 14:05:54 +0000 (UTC)
Message-ID: <8b031299-4ec4-4c36-a4cf-97845349c8ad@redhat.com>
Date: Thu, 22 Feb 2024 09:05:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] locking/mutex: Clean up mutex.h
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, George Stark <gnstark@salutedevices.com>
References: <20240213031656.1375951-1-longman@redhat.com>
 <20240213031656.1375951-3-longman@redhat.com>
 <ZdbOnD5NzUDdNnDS@boqun-archlinux>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZdbOnD5NzUDdNnDS@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 2/21/24 23:33, Boqun Feng wrote:
> On Mon, Feb 12, 2024 at 10:16:54PM -0500, Waiman Long wrote:
>> CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
>> can't be both set at the same time.  Move down the mutex_destroy()
>> function declaration to the bottom of mutex.h to eliminate duplicated
>> mutex_destroy() declaration.
>>
>> Also remove the duplicated mutex_trylock() function declaration in the
>> CONFIG_PREEMPT_RT section.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> Although, can you move the first "#ifdef CONFIG_DEBUG_MUTEXES" out of
> the "#ifndef CONFIG_PREEMPT_RT" and combine it with the second one, i.e.
>
> 	#ifdef CONFIG_DEBUG_MUTEXES
> 	# define __DEBUG_MUTEX_INITIALIZER(lockname) ...
> 	extern void mutex_destroy(struct mutex *lock);
> 	#else
> 	# define __DEBUG_MUTEX_INITIALIZER(lockname) ..
> 	static inline void mutex_destroy(struct mutex *lock) {}
> 	#endif
>
> 	#ifndef CONFIG_PREEMPT_RT
> 	...
>
> Thoughts?

Sure. I can move it up and combine the two pieces.

Thanks for the review.

Cheers,
Longman

>
> Regards,
> Boqun
>
>> ---
>>   include/linux/mutex.h | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>> index 7e208d46ba5b..bad383713db2 100644
>> --- a/include/linux/mutex.h
>> +++ b/include/linux/mutex.h
>> @@ -35,18 +35,10 @@
>>   #ifndef CONFIG_PREEMPT_RT
>>   
>>   #ifdef CONFIG_DEBUG_MUTEXES
>> -
>> -#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
>> +# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
>>   	, .magic = &lockname
>> -
>> -extern void mutex_destroy(struct mutex *lock);
>> -
>>   #else
>> -
>>   # define __DEBUG_MUTEX_INITIALIZER(lockname)
>> -
>> -static inline void mutex_destroy(struct mutex *lock) {}
>> -
>>   #endif
>>   
>>   /**
>> @@ -101,9 +93,6 @@ extern bool mutex_is_locked(struct mutex *lock);
>>   
>>   extern void __mutex_rt_init(struct mutex *lock, const char *name,
>>   			    struct lock_class_key *key);
>> -extern int mutex_trylock(struct mutex *lock);
>> -
>> -static inline void mutex_destroy(struct mutex *lock) { }
>>   
>>   #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
>>   
>> @@ -170,6 +159,16 @@ extern void mutex_unlock(struct mutex *lock);
>>   
>>   extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
>>   
>> +#ifdef CONFIG_DEBUG_MUTEXES
>> +
>> +extern void mutex_destroy(struct mutex *lock);
>> +
>> +#else
>> +
>> +static inline void mutex_destroy(struct mutex *lock) {}
>> +
>> +#endif
>> +
>>   DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>>   DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>>   DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
>> -- 
>> 2.39.3
>>


