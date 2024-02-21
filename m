Return-Path: <linux-kernel+bounces-74198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01EA85D101
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7DCB252E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E43A8E6;
	Wed, 21 Feb 2024 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eXw1VdsQ"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917C3A8C0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499607; cv=none; b=RKn6KqqboMJ+Lr70zbL4KhyqvmDotJIFzCKiiTgzrkVgSmDEITaKe//HCeFuRq84z9GdQtoT5ASzyPJgnAzCzfqQOJ7jilaAPzec/++7EDqs1voi0pQmbVOedyqJ0njmuQ79zTzd/UtYOsgHsufJLrFSLJK3iIrVEoaGUfr9c3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499607; c=relaxed/simple;
	bh=0lV17OrH2r4DeZCGGe45hfGIqw5fbDgibCHZC4+T78o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkCswdM3y1Wcov5L/UZgKWTbiXR/aIPhTZ5ipVAmxnt8K0ikw00TYIVJfyN3RFYazEbK/uFVdOJ1A/yotdCpD6n2bZk9EdNsekCEv+ocZoaGacGWtmyKVfTm6B2vOmpsIpZgOmePrx0D75syaTjiY9/KtR6GfR0mVqBBGuHSUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eXw1VdsQ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aef16f2d-b20f-4999-b959-b4bf4209b4dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708499603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lnluPublLsql88cuouFDfLI5nirAwLVTd6p6qVgmKo=;
	b=eXw1VdsQ7wDEGhuFEQMB6qkRmoUxDPruW8kH7jieHchleZv1EQbU4R0VHtVrQcbRZeNP9e
	5ePj6zdU7Wru9czD6TVASS31JOEveRe2xycQ/LOnX4ql+8qfwWJjXaHn4+/Qo5eRyegERr
	qQDZ23yDAWrU8klPHqMBBy9GjokB+Jg=
Date: Wed, 21 Feb 2024 15:13:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
 Xiongwei Song <xiongwei.song@windriver.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/21 00:58, Vlastimil Babka wrote:
> The values of SLAB_ cache creation flagsare defined by hand, which is
> tedious and error-prone. Use an enum to assign the bit number and a
> __SF_BIT() macro to #define the final flags.
> 
> This renumbers the flag values, which is OK as they are only used
> internally.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>  include/linux/slab.h | 81 ++++++++++++++++++++++++++++++++++++++--------------
>  mm/slub.c            |  6 ++--
>  2 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6252f44115c2..f893a132dd5a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -21,29 +21,68 @@
>  #include <linux/cleanup.h>
>  #include <linux/hash.h>
>  
> +enum _slab_flag_bits {
> +	_SLAB_CONSISTENCY_CHECKS,
> +	_SLAB_RED_ZONE,
> +	_SLAB_POISON,
> +	_SLAB_KMALLOC,
> +	_SLAB_HWCACHE_ALIGN,
> +	_SLAB_CACHE_DMA,
> +	_SLAB_CACHE_DMA32,
> +	_SLAB_STORE_USER,
> +	_SLAB_PANIC,
> +	_SLAB_TYPESAFE_BY_RCU,
> +	_SLAB_TRACE,
> +#ifdef CONFIG_DEBUG_OBJECTS
> +	_SLAB_DEBUG_OBJECTS,
> +#endif
> +	_SLAB_NOLEAKTRACE,
> +	_SLAB_NO_MERGE,
> +#ifdef CONFIG_FAILSLAB
> +	_SLAB_FAILSLAB,
> +#endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	_SLAB_ACCOUNT,
> +#endif
> +#ifdef CONFIG_KASAN_GENERIC
> +	_SLAB_KASAN,
> +#endif
> +	_SLAB_NO_USER_FLAGS,
> +#ifdef CONFIG_KFENCE
> +	_SLAB_SKIP_KFENCE,
> +#endif
> +#ifndef CONFIG_SLUB_TINY
> +	_SLAB_RECLAIM_ACCOUNT,
> +#endif
> +	_SLAB_OBJECT_POISON,
> +	_SLAB_CMPXCHG_DOUBLE,
> +	_SLAB_FLAGS_LAST_BIT
> +};
> +
> +#define __SF_BIT(nr)	((slab_flags_t __force)(1U << (nr)))
>  
>  /*
>   * Flags to pass to kmem_cache_create().
>   * The ones marked DEBUG need CONFIG_SLUB_DEBUG enabled, otherwise are no-op
>   */
>  /* DEBUG: Perform (expensive) checks on alloc/free */
> -#define SLAB_CONSISTENCY_CHECKS	((slab_flags_t __force)0x00000100U)
> +#define SLAB_CONSISTENCY_CHECKS	__SF_BIT(_SLAB_CONSISTENCY_CHECKS)
>  /* DEBUG: Red zone objs in a cache */
> -#define SLAB_RED_ZONE		((slab_flags_t __force)0x00000400U)
> +#define SLAB_RED_ZONE		__SF_BIT(_SLAB_RED_ZONE)
>  /* DEBUG: Poison objects */
> -#define SLAB_POISON		((slab_flags_t __force)0x00000800U)
> +#define SLAB_POISON		__SF_BIT(_SLAB_POISON)
>  /* Indicate a kmalloc slab */
> -#define SLAB_KMALLOC		((slab_flags_t __force)0x00001000U)
> +#define SLAB_KMALLOC		__SF_BIT(_SLAB_KMALLOC)
>  /* Align objs on cache lines */
> -#define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
> +#define SLAB_HWCACHE_ALIGN	__SF_BIT(_SLAB_HWCACHE_ALIGN)
>  /* Use GFP_DMA memory */
> -#define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
> +#define SLAB_CACHE_DMA		__SF_BIT(_SLAB_CACHE_DMA)
>  /* Use GFP_DMA32 memory */
> -#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
> +#define SLAB_CACHE_DMA32	__SF_BIT(_SLAB_CACHE_DMA32)
>  /* DEBUG: Store the last owner for bug hunting */
> -#define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
> +#define SLAB_STORE_USER		__SF_BIT(_SLAB_STORE_USER)
>  /* Panic if kmem_cache_create() fails */
> -#define SLAB_PANIC		((slab_flags_t __force)0x00040000U)
> +#define SLAB_PANIC		__SF_BIT(_SLAB_PANIC)
>  /*
>   * SLAB_TYPESAFE_BY_RCU - **WARNING** READ THIS!
>   *
> @@ -95,19 +134,19 @@
>   * Note that SLAB_TYPESAFE_BY_RCU was originally named SLAB_DESTROY_BY_RCU.
>   */
>  /* Defer freeing slabs to RCU */
> -#define SLAB_TYPESAFE_BY_RCU	((slab_flags_t __force)0x00080000U)
> +#define SLAB_TYPESAFE_BY_RCU	__SF_BIT(_SLAB_TYPESAFE_BY_RCU)
>  /* Trace allocations and frees */
> -#define SLAB_TRACE		((slab_flags_t __force)0x00200000U)
> +#define SLAB_TRACE		__SF_BIT(_SLAB_TRACE)
>  
>  /* Flag to prevent checks on free */
>  #ifdef CONFIG_DEBUG_OBJECTS
> -# define SLAB_DEBUG_OBJECTS	((slab_flags_t __force)0x00400000U)
> +# define SLAB_DEBUG_OBJECTS	__SF_BIT(_SLAB_DEBUG_OBJECTS)
>  #else
>  # define SLAB_DEBUG_OBJECTS	0
>  #endif
>  
>  /* Avoid kmemleak tracing */
> -#define SLAB_NOLEAKTRACE	((slab_flags_t __force)0x00800000U)
> +#define SLAB_NOLEAKTRACE	__SF_BIT(_SLAB_NOLEAKTRACE)
>  
>  /*
>   * Prevent merging with compatible kmem caches. This flag should be used
> @@ -119,23 +158,23 @@
>   * - performance critical caches, should be very rare and consulted with slab
>   *   maintainers, and not used together with CONFIG_SLUB_TINY
>   */
> -#define SLAB_NO_MERGE		((slab_flags_t __force)0x01000000U)
> +#define SLAB_NO_MERGE		__SF_BIT(_SLAB_NO_MERGE)
>  
>  /* Fault injection mark */
>  #ifdef CONFIG_FAILSLAB
> -# define SLAB_FAILSLAB		((slab_flags_t __force)0x02000000U)
> +# define SLAB_FAILSLAB		__SF_BIT(_SLAB_FAILSLAB)
>  #else
>  # define SLAB_FAILSLAB		0
>  #endif
>  /* Account to memcg */
>  #ifdef CONFIG_MEMCG_KMEM
> -# define SLAB_ACCOUNT		((slab_flags_t __force)0x04000000U)
> +# define SLAB_ACCOUNT		__SF_BIT(_SLAB_ACCOUNT)
>  #else
>  # define SLAB_ACCOUNT		0
>  #endif
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -#define SLAB_KASAN		((slab_flags_t __force)0x08000000U)
> +#define SLAB_KASAN		__SF_BIT(_SLAB_KASAN)
>  #else
>  #define SLAB_KASAN		0
>  #endif
> @@ -145,10 +184,10 @@
>   * Intended for caches created for self-tests so they have only flags
>   * specified in the code and other flags are ignored.
>   */
> -#define SLAB_NO_USER_FLAGS	((slab_flags_t __force)0x10000000U)
> +#define SLAB_NO_USER_FLAGS	__SF_BIT(_SLAB_NO_USER_FLAGS)
>  
>  #ifdef CONFIG_KFENCE
> -#define SLAB_SKIP_KFENCE	((slab_flags_t __force)0x20000000U)
> +#define SLAB_SKIP_KFENCE	__SF_BIT(_SLAB_SKIP_KFENCE)
>  #else
>  #define SLAB_SKIP_KFENCE	0
>  #endif
> @@ -156,9 +195,9 @@
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #ifndef CONFIG_SLUB_TINY
> -#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> +#define SLAB_RECLAIM_ACCOUNT	__SF_BIT(_SLAB_RECLAIM_ACCOUNT)
>  #else
> -#define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0)
> +#define SLAB_RECLAIM_ACCOUNT	0
>  #endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..a93c5a17cbbb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -306,13 +306,13 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  
>  /* Internal SLUB flags */
>  /* Poison object */
> -#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
> +#define __OBJECT_POISON		__SF_BIT(_SLAB_OBJECT_POISON)
>  /* Use cmpxchg_double */
>  
>  #ifdef system_has_freelist_aba
> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
> +#define __CMPXCHG_DOUBLE	__SF_BIT(_SLAB_CMPXCHG_DOUBLE)
>  #else
> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
> +#define __CMPXCHG_DOUBLE	0
>  #endif
>  
>  /*
> 

