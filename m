Return-Path: <linux-kernel+bounces-70549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70670859910
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61011F2149A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896446F53A;
	Sun, 18 Feb 2024 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwoENa2L"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F36F50D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284333; cv=none; b=r5xvGPxO+ry59mVFLMGWy96Po/9DA+9nbrfLv5BFm97VM1Y7jlG6A430XqUl9ou8WL96bTbZbLwRUBdN72ZRtxuB7+XnmBsXbbXD5Ymn038VOYZE2J0F/NFxEyL46pT1a9fOOjd9a7a26yS8UmVOZBokJ82SJdrD4vwUUnbvmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284333; c=relaxed/simple;
	bh=dLiFSjAHanMQtY1W8/0C3wLfJsmyN9sHiwqHYFJZBPY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t7neFVQ1oHZzW78oK52MzjacC35DupqGjIHahcQF1oZddO5RJfcPgpILuyzXapB6vBNl2HMIaU5niL4xp151k/U8FBArl+ll5fYio3DxTo72nWPlEg4oqNFph7xThYnOz2r3kbcCjeQgof2J79e6/qv4EgJmwfmmt5HshgE0fmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwoENa2L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d89f0ab02bso107615ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708284331; x=1708889131; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9xYxG+4EJNJj5YE6nXWMmKMGcc6ntgXWEQgOTyX2uY=;
        b=mwoENa2LxynncblepbU5Rn4YDszPIASj2bpLpENGKLzJjA836YqDhaWJCxRiwdQ6xz
         b0Fea8eSBSMu3u4/AeYFRfQp+7pHaXWvgnoFTX3C0d5ZYKlr2Rd0/qS4R9yL+fx7ux8F
         9hYEMynsAUUZrq5JBfL2+Yr7jnN5RTr9Nh1D2gcL317EsxjB8dVnkCgFeSzMnv2kmU4O
         dQHYK5dc1ulUIf9iMwDwA++LetOA/h9P3r5uswQ2HS0fmMNPY4Q6sSba/VaBvmP2ATwS
         ZalEHdXZrvmAY1H3PBUr21rA/wJ6dio7hlRz3HU54mbXnT7k4+pN4zhD8zsmV+KU/Yrm
         LH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708284331; x=1708889131;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9xYxG+4EJNJj5YE6nXWMmKMGcc6ntgXWEQgOTyX2uY=;
        b=bShJf1XYWMcBRB46674IBsj7Leai2Qam0igDrr95NC31qxAZZ8zHDcQLC7roxE+YsT
         PBEORXOZO6s5X4m0cSqo3LaZBZBf/N5C+WaRpHYJmWYZyUFqmx09rXo+TN7c5z890DKB
         +6u9OOoMBVF5TtKcV4xQ5+hhPHR0YclwicV6aUlv2cNs6le/xpLqbEfqKmGqIRFlwwa2
         Sn+TdoznRXTJ9UWJrcfZKPwgo72vjw4CSDjjVVxTkq8OQj18eJ3kGElqPrjCgtAVSl7l
         cZiov8yfBISxtj47opL9Vb1ISixmT7TNac65CBEdWSJ89fWOclCD9n6VOdo2RC29re4B
         zqsg==
X-Forwarded-Encrypted: i=1; AJvYcCVM5BEonGRKCeXh/R2NGBfoBE9hEx6xRaBNLpTqV5/bti7947GmrgELXvCTSq0xT3prMsif3nTcE3GOKiuKuTn3LsthJrh9FQ3gUBox
X-Gm-Message-State: AOJu0YxOU21xxxL9MH/i6QO7Cbo8Bpv+GC/sj+xZ9iee3enz7Ay2ITy1
	7flrtKeoVmdEHw5oP8ZeFx97Is3UicGME7H1rPbyMdtB0XVd7aQE2g5CbS6L6g==
X-Google-Smtp-Source: AGHT+IH3jgWpu6FG5EYkD52aO3UsfnmkQqySwQcDKAwDMvNX32n1Z7SJTgSQUNvhJSiTOajSCd1OaA==
X-Received: by 2002:a17:903:25d5:b0:1db:4f08:4b10 with SMTP id jc21-20020a17090325d500b001db4f084b10mr223317plb.21.1708284331153;
        Sun, 18 Feb 2024 11:25:31 -0800 (PST)
Received: from [2620:0:1008:15:cd06:f5b0:224e:954a] ([2620:0:1008:15:cd06:f5b0:224e:954a])
        by smtp.gmail.com with ESMTPSA id cz15-20020a17090ad44f00b0029703476e9bsm3546097pjb.44.2024.02.18.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:25:30 -0800 (PST)
Date: Sun, 18 Feb 2024 11:25:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in
 get_slabinfo()
In-Reply-To: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
Message-ID: <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Feb 2024, Jianfeng Wang wrote:

> When reading "/proc/slabinfo", the kernel needs to report the number of
> free objects for each kmem_cache. The current implementation relies on
> count_partial() that counts the number of free objects by scanning each
> kmem_cache_node's partial slab list and summing free objects from all
> partial slabs in the list. This process must hold per kmem_cache_node
> spinlock and disable IRQ. Consequently, it can block slab allocation
> requests on other CPU cores and cause timeouts for network devices etc.,
> if the partial slab list is long. In production, even NMI watchdog can
> be triggered because some slab caches have a long partial list: e.g.,
> for "buffer_head", the number of partial slabs was observed to be ~1M
> in one kmem_cache_node. This problem was also observed by several
> others [1-2] in the past.
> 
> The fix is to maintain a counter of free objects for each kmem_cache.
> Then, in get_slabinfo(), use the counter rather than count_partial()
> when reporting the number of free objects for a slab cache. per-cpu
> counter is used to minimize atomic or lock operation.
> 
> Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
> with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
> The command is "hackbench 18 thread 20000". Each group gets 10 runs.
> 

This seems particularly intrusive for the common path to optimize for 
reading of /proc/slabinfo, and that's shown in the benchmark result.

Could you discuss the /proc/slabinfo usage model a bit?  It's not clear if 
this is being continuously read, or whether even a single read in 
isolation is problematic.

That said, optimizing for reading /proc/slabinfo at the cost of runtime 
performance degradation doesn't sound like the right trade-off.

> Results:
> - Mainline:
> 21.0381 +- 0.0325 seconds time elapsed  ( +-  0.15% )
> - Mainline w/ this patch:
> 21.1878 +- 0.0239 seconds time elapsed  ( +-  0.11% )
> 
> [1] https://lore.kernel.org/linux-mm/
> alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
> [2] https://lore.kernel.org/lkml/
> alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
> 
> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> ---
>  mm/slab.h |  4 ++++
>  mm/slub.c | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 54deeb0428c6..a0e7672ba648 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -11,6 +11,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/kfence.h>
>  #include <linux/kasan.h>
> +#include <linux/percpu_counter.h>
>  
>  /*
>   * Internal slab definitions
> @@ -277,6 +278,9 @@ struct kmem_cache {
>  	unsigned int red_left_pad;	/* Left redzone padding size */
>  	const char *name;		/* Name (only for display!) */
>  	struct list_head list;		/* List of slab caches */
> +#ifdef CONFIG_SLUB_DEBUG
> +	struct percpu_counter free_objects;
> +#endif
>  #ifdef CONFIG_SYSFS
>  	struct kobject kobj;		/* For sysfs */
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..44f8ded96574 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -736,6 +736,12 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>  static DEFINE_SPINLOCK(object_map_lock);
>  
> +static inline void
> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta)
> +{
> +	percpu_counter_add_batch(&s->free_objects, delta, INT_MAX);
> +}
> +
>  static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
>  		       struct slab *slab)
>  {
> @@ -1829,6 +1835,9 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  	return flags | slub_debug_local;
>  }
>  #else /* !CONFIG_SLUB_DEBUG */
> +static inline void
> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta) {}
> +
>  static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>  static inline
>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
> @@ -2369,6 +2378,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>  	slab->inuse = 0;
>  	slab->frozen = 0;
>  
> +	__update_kmem_cache_free_objs(s, slab->objects);
>  	account_slab(slab, oo_order(oo), s, flags);
>  
>  	slab->slab_cache = s;
> @@ -2445,6 +2455,7 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
>  		call_rcu(&slab->rcu_head, rcu_free_slab);
>  	else
>  		__free_slab(s, slab);
> +	__update_kmem_cache_free_objs(s, -slab->objects);
>  }
>  
>  static void discard_slab(struct kmem_cache *s, struct slab *slab)
> @@ -3859,6 +3870,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>  	 */
>  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>  
> +	if (object)
> +		__update_kmem_cache_free_objs(s, -1);
>  	return object;
>  }
>  
> @@ -4235,6 +4248,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	unsigned long tid;
>  	void **freelist;
>  
> +	__update_kmem_cache_free_objs(s, cnt);
>  redo:
>  	/*
>  	 * Determine the currently cpus per cpu slab.
> @@ -4286,6 +4300,7 @@ static void do_slab_free(struct kmem_cache *s,
>  				struct slab *slab, void *head, void *tail,
>  				int cnt, unsigned long addr)
>  {
> +	__update_kmem_cache_free_objs(s, cnt);
>  	__slab_free(s, slab, head, tail, cnt, addr);
>  }
>  #endif /* CONFIG_SLUB_TINY */
> @@ -4658,6 +4673,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  		memcg_slab_alloc_error_hook(s, size, objcg);
>  	}
>  
> +	__update_kmem_cache_free_objs(s, -i);
>  	return i;
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
> @@ -4899,6 +4915,9 @@ void __kmem_cache_release(struct kmem_cache *s)
>  	cache_random_seq_destroy(s);
>  #ifndef CONFIG_SLUB_TINY
>  	free_percpu(s->cpu_slab);
> +#endif
> +#ifdef CONFIG_SLUB_DEBUG
> +	percpu_counter_destroy(&s->free_objects);
>  #endif
>  	free_kmem_cache_nodes(s);
>  }
> @@ -5109,6 +5128,14 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->random = get_random_long();
>  #endif
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +	int ret;
> +
> +	ret = percpu_counter_init(&s->free_objects, 0, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +#endif
> +
>  	if (!calculate_sizes(s))
>  		goto error;
>  	if (disable_higher_order_debug) {
> @@ -7100,15 +7127,15 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>  {
>  	unsigned long nr_slabs = 0;
>  	unsigned long nr_objs = 0;
> -	unsigned long nr_free = 0;
> +	unsigned long nr_free;
>  	int node;
>  	struct kmem_cache_node *n;
>  
>  	for_each_kmem_cache_node(s, node, n) {
>  		nr_slabs += node_nr_slabs(n);
>  		nr_objs += node_nr_objs(n);
> -		nr_free += count_partial(n, count_free);
>  	}
> +	nr_free = percpu_counter_sum_positive(&s->free_objects);
>  
>  	sinfo->active_objs = nr_objs - nr_free;
>  	sinfo->num_objs = nr_objs;
> -- 
> 2.42.1
> 
> 

