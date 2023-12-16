Return-Path: <linux-kernel+bounces-2170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28298158E5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112191C21650
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5481E4B6;
	Sat, 16 Dec 2023 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AywwhjmM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3D1E499
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id ETSEr1N7v4QGMETSErWtUn; Sat, 16 Dec 2023 13:07:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702728462;
	bh=eQ0asiDyEh5zDzuZXKXuWTZved4B2G07ODTKTMug6jQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AywwhjmMlE5WvSV/6ewLSDJh3tO4w1L8GoVK66PJ9ZE0rrXhN63hmW/OjKFjmN1xb
	 UgfGOHn15jEki0++JZgqa0WliS1fvSlsDS92wnt6xWyC0RyCPTZE7ybIcTLH73hOva
	 32CTgSfE8pJW8VOrOhQfIcqDf5cmi+iXXYUJ63CqmjK10JHE9t6pD2reI9AdwQSSwY
	 JhFi8mQ/dhycY9Ns4ZfvU/AhzNiIO8bHac4ZYoK53XneQTOtx7PikgicAlLcPFM8pZ
	 HbvEP3OkN2RZC+x8w5mi++Lz/UtlM7JqSrQ5FSBen5E1rlQrP1goOWq1AL7o7ULoK2
	 IzMFy1dG/K/oA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Dec 2023 13:07:42 +0100
X-ME-IP: 92.140.202.140
Message-ID: <f52abb48-6a01-4914-a949-025ae6835b74@wanadoo.fr>
Date: Sat, 16 Dec 2023 13:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/mutex: Clean up mutex.h
Content-Language: fr
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, George Stark <gnstark@salutedevices.com>
References: <20231216013656.1382213-1-longman@redhat.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231216013656.1382213-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/12/2023 à 02:36, Waiman Long a écrit :
> CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
> can't be both set at the same time.  Move down the mutex_destroy()
> function declaration to the bottom of mutex.h to eliminate duplicated
> mutex_destroy() declaration.
> 
> Also remove the duplicated mutex_trylock() function declaration in the
> CONFIG_PREEMPT_RT section.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   include/linux/mutex.h | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index a33aa9eb9fc3..f3ae911580bf 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -77,18 +77,10 @@ struct mutex {
>   };
>   
>   #ifdef CONFIG_DEBUG_MUTEXES
> -
> -#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
> +# define __DEBUG_MUTEX_INITIALIZER(lockname)				\

Is this extra space added on purpose?

CJ

>   	, .magic = &lockname
> -
> -extern void mutex_destroy(struct mutex *lock);
> -
>   #else
> -
>   # define __DEBUG_MUTEX_INITIALIZER(lockname)
> -
> -static inline void mutex_destroy(struct mutex *lock) {}
> -
>   #endif
>   
>   /**
> @@ -151,9 +143,6 @@ struct mutex {
>   
>   extern void __mutex_rt_init(struct mutex *lock, const char *name,
>   			    struct lock_class_key *key);
> -extern int mutex_trylock(struct mutex *lock);
> -
> -static inline void mutex_destroy(struct mutex *lock) { }
>   
>   #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
>   
> @@ -220,6 +209,16 @@ extern void mutex_unlock(struct mutex *lock);
>   
>   extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
>   
> +#ifdef CONFIG_DEBUG_MUTEXES
> +
> +extern void mutex_destroy(struct mutex *lock);
> +
> +#else
> +
> +static inline void mutex_destroy(struct mutex *lock) {}
> +
> +#endif
> +
>   DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>   DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
>   


