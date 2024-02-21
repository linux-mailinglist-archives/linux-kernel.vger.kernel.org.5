Return-Path: <linux-kernel+bounces-74200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F078E85D109
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D0228473D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED243A8C0;
	Wed, 21 Feb 2024 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fm28TUMb"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3039879
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499725; cv=none; b=Tw+q8JIRFQT6LZjQt3bz6jL4AwKwzOBJ5CqP45/kk0NqHstykpWd+IDMm5+M6kDGTOzk/R97yY9LOaA1A+SBIyKKVwsluX+svBs8BMa3XRU0dIiV+uxciljx+ajy8GssoLartEqigKsJ8mUQyy21JWY6MkeoCw84tyJ1r+IY8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499725; c=relaxed/simple;
	bh=j1qSMXyLyIlayjqhNgawo/LH2TOhz+JtLKZQOgLzBO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Canc5NJA0HezssypZDtlYcJBGrLuyr+u21Bd0i0t/AvznFH2wAEwreV20F1whzhHNhvzP3iHq9XpiL4QQZNFXXvYY6QDi10XrxD9+RuTR9uCiMJ59XXtZiNyt2RUGLKmHN1y9LlTlskESXBX08I4voo8XzeAobHQMjEO956B0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fm28TUMb; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50522603-85a9-4e4b-ab44-db40ee7bf476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708499721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6jQuMnrBC0WcnisUd1nhZPzN/7+9FC41RDCX5WDq+o=;
	b=fm28TUMb8zXckOAu3/NuPD5LD9RNiEjIiIrse4G029PoUxs4HGZd4wSISHMflFjf9gWHOI
	gvd5xNDghD/rgwRQx5YGs4X33VZZ2xgayFfvzFCCkc3ez8gYMv/o7msxVwW8NWgrJmyJrt
	TICDT+NJGOIBOSEzkVrRhbFHeer2XJ8=
Date: Wed, 21 Feb 2024 15:14:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] mm, slab, kasan: replace kasan_never_merge() with
 SLAB_NO_MERGE
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
 <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240220-slab-cleanup-flags-v1-3-e657e373944a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/21 00:58, Vlastimil Babka wrote:
> The SLAB_KASAN flag prevents merging of caches in some configurations,
> which is handled in a rather complicated way via kasan_never_merge().
> Since we now have a generic SLAB_NO_MERGE flag, we can instead use it
> for KASAN caches in addition to SLAB_KASAN in those configurations,
> and simplify the SLAB_NEVER_MERGE handling.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>  include/linux/kasan.h |  6 ------
>  mm/kasan/generic.c    | 16 ++++------------
>  mm/slab_common.c      |  2 +-
>  3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dbb06d789e74..70d6a8f6e25d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -429,7 +429,6 @@ struct kasan_cache {
>  };
>  
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
> -slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  			slab_flags_t *flags);
>  
> @@ -446,11 +445,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache,
>  {
>  	return 0;
>  }
> -/* And thus nothing prevents cache merging. */
> -static inline slab_flags_t kasan_never_merge(void)
> -{
> -	return 0;
> -}
>  /* And no cache-related metadata initialization is required. */
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>  				      unsigned int *size,
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index df6627f62402..d8b78d273b9f 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -334,14 +334,6 @@ DEFINE_ASAN_SET_SHADOW(f3);
>  DEFINE_ASAN_SET_SHADOW(f5);
>  DEFINE_ASAN_SET_SHADOW(f8);
>  
> -/* Only allow cache merging when no per-object metadata is present. */
> -slab_flags_t kasan_never_merge(void)
> -{
> -	if (!kasan_requires_meta())
> -		return 0;
> -	return SLAB_KASAN;
> -}
> -
>  /*
>   * Adaptive redzone policy taken from the userspace AddressSanitizer runtime.
>   * For larger allocations larger redzones are used.
> @@ -372,13 +364,13 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  	/*
>  	 * SLAB_KASAN is used to mark caches that are sanitized by KASAN
>  	 * and that thus have per-object metadata.
> -	 * Currently this flag is used in two places:
> +	 * Currently this flag is used in one place:
>  	 * 1. In slab_ksize() to account for per-object metadata when
>  	 *    calculating the size of the accessible memory within the object.
> -	 * 2. In slab_common.c via kasan_never_merge() to prevent merging of
> -	 *    caches with per-object metadata.
> +	 * Additionally, we use SLAB_NO_MERGE to prevent merging of caches
> +	 * with per-object metadata.
>  	 */
> -	*flags |= SLAB_KASAN;
> +	*flags |= SLAB_KASAN | SLAB_NO_MERGE;
>  
>  	ok_size = *size;
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 238293b1dbe1..7cfa2f1ce655 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -50,7 +50,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -		SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
> +		SLAB_FAILSLAB | SLAB_NO_MERGE)
>  
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> 

