Return-Path: <linux-kernel+bounces-24293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FE482BA81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF3028737E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267F5B5B7;
	Fri, 12 Jan 2024 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkl8goRk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B05B5AA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705035135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQJ9hOz9qN8Mqz2MuXKMKk0sGzrFbCj0fCm3cv5Fn6A=;
	b=fkl8goRkPhDKzhX7IAkmTslwPXHXhEZJn89cyoiO4I/2saJfpDUsFWjqGHur4arLS9bkE/
	obmlpvKAIYdWOqb+Y6snBWE2u7SGpCPb+9ZcPxm4odK/4RppBeKQgJiCfxkLCRhl2w4FIx
	rUkcixYtQRO07fZGSvcWkvJAYwSILL0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-Pzar8MfmPUiRq9c0eNUBEw-1; Thu,
 11 Jan 2024 23:52:12 -0500
X-MC-Unique: Pzar8MfmPUiRq9c0eNUBEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C855282FA19;
	Fri, 12 Jan 2024 04:52:11 +0000 (UTC)
Received: from [10.22.16.77] (unknown [10.22.16.77])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10CB92166B33;
	Fri, 12 Jan 2024 04:52:11 +0000 (UTC)
Message-ID: <b2e3f866-3644-4730-b2d3-6b84b1433a9d@redhat.com>
Date: Thu, 11 Jan 2024 23:52:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Chandan Babu R <chandan.babu@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
References: <20240111212424.3572189-1-willy@infradead.org>
 <20240111212424.3572189-2-willy@infradead.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240111212424.3572189-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 1/11/24 16:24, Matthew Wilcox (Oracle) wrote:
> Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
> but are always active, even when lockdep is disabled.  Of course, they
> don't test that _this_ thread is the owner, but it's sufficient to catch
> many bugs and doesn't incur the same performance penalty as lockdep.

I don't mind the new *assert_held*nolockdep APIs. The only nit that I 
have is that their behavior is slightly different from the corresponding 
lockdep counterparts as they don't imply the current process is holding 
the lock. So we may need to have some comment to document the difference 
and set the right expectation. Of course it can be done with a follow-up 
patch.

Acked-by: Waiman Long <longman@redhat.com>

>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/rwbase_rt.h |  9 ++++++--
>   include/linux/rwsem.h     | 46 ++++++++++++++++++++++++++++++++++-----
>   2 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..29c4e4f243e4 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -26,12 +26,17 @@ struct rwbase_rt {
>   	} while (0)
>   
>   
> -static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
> +static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
>   {
>   	return atomic_read(&rwb->readers) != READER_BIAS;
>   }
>   
> -static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
> +static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
> +{
> +	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
> +}
> +
> +static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
>   {
>   	return atomic_read(&rwb->readers) > 0;
>   }
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 9c29689ff505..4f1c18992f76 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -66,14 +66,24 @@ struct rw_semaphore {
>   #endif
>   };
>   
> -/* In all implementations count != 0 means locked */
> +#define RWSEM_UNLOCKED_VALUE		0UL
> +#define RWSEM_WRITER_LOCKED		(1UL << 0)
> +#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +
>   static inline int rwsem_is_locked(struct rw_semaphore *sem)
>   {
> -	return atomic_long_read(&sem->count) != 0;
> +	return atomic_long_read(&sem->count) != RWSEM_UNLOCKED_VALUE;
>   }
>   
> -#define RWSEM_UNLOCKED_VALUE		0L
> -#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
> +}
> +
> +static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
> +}
>   
>   /* Common initializer macros and functions */
>   
> @@ -152,11 +162,21 @@ do {								\
>   	__init_rwsem((sem), #sem, &__key);			\
>   } while (0)
>   
> -static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
> +static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
>   {
>   	return rw_base_is_locked(&sem->rwbase);
>   }
>   
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!rwsem_is_locked(sem));
> +}
> +
> +static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	rw_base_assert_held_write(sem);
> +}
> +
>   static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>   {
>   	return rw_base_is_contended(&sem->rwbase);
> @@ -169,6 +189,22 @@ static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>    * the RT specific variant.
>    */
>   
> +static inline void rwsem_assert_held(const struct rw_semaphore *sem)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP))
> +		lockdep_assert_held(sem);
> +	else
> +		rwsem_assert_held_nolockdep(sem);
> +}
> +
> +static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP))
> +		lockdep_assert_held_write(sem);
> +	else
> +		rwsem_assert_held_write_nolockdep(sem);
> +}
> +
>   /*
>    * lock for reading
>    */


