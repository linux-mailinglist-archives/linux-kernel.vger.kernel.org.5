Return-Path: <linux-kernel+bounces-100693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCD879BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811CF1F23EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A99A141988;
	Tue, 12 Mar 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCghAoUn"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E11419AA;
	Tue, 12 Mar 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269802; cv=none; b=gZGLyTocduKt3hk4r8CqqE+ifXNskR35K8Nt24V+mtaQvOQJKXtONQBFkNPeiAQZ7PPh2XSi99bDggz3k70fU5b4y/dVoITEhhr0pad9bGth1fZGx5DKZNz4v1MahHzO6Jw7mhuPTOu2LrxZufcfnw9ZS+ex70Y1aVRbbcZ2UCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269802; c=relaxed/simple;
	bh=Tt/Nw+qQfWxJPZJFDqwem/+LdkXpCq6BGyMeXD2QnqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+gjUSwaQuZO2w0Wk2Kk3cNB0LQmaFUA15m3ddRI5gUWo3fTN58KtQZXyXTgDckEluFUxbsFq0qVXc5Iz9lH3m/5gsArcZqcLVD5Y4pgorjjVENI3FUetrHxZ+Rf7dxIXbg7a4ympLJfKGW6Gzk0lVNHZXpDOLjox2n9cCjllK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCghAoUn; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 11:56:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710269798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/vbUFRT4v6z0E2DcirJO1q59nBkBCTNwTPtMtNe8Yiw=;
	b=iCghAoUnCwH8kI0/NrUiK4kWEC5H+CYF9MrTs2MphCasYW5zPOZqV/0AwbJkBhJdTMrJbp
	uYZKm2lEO4GyrVq8YfopiXFWp3Rz/FVyiJ0068cXPWVWHj8fuH5hlkz9rQiELZHRNVvcic
	XyDJE5V0OuxJapfzQzXJTkB/ae49lTI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] mm, slab: move slab_memcg hooks to
 mm/memcontrol.c
Message-ID: <ZfClX_CJBYRW-cCc@P9FQF9L96D>
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-2-359328a46596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-slab-memcg-v1-2-359328a46596@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 06:07:09PM +0100, Vlastimil Babka wrote:
> The hooks make multiple calls to functions in mm/memcontrol.c, including
> to th current_obj_cgroup() marked __always_inline. It might be faster to
> make a single call to the hook in mm/memcontrol.c instead. The hooks
> also don't use almost anything from mm/slub.c. obj_full_size() can move
> with the hooks and cache_vmstat_idx() to the internal mm/slab.h
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h       |  10 ++++++
>  mm/slub.c       | 100 --------------------------------------------------------
>  3 files changed, 100 insertions(+), 100 deletions(-)

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Btw, even before your change:
$ cat mm/memcontrol.c | wc -l
8318
so I wonder if soon we might want to split it into some smaller parts.

Thanks!

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e4c8735e7c85..37ee9356a26c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3575,6 +3575,96 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  	refill_obj_stock(objcg, size, true);
>  }
>  
> +static inline size_t obj_full_size(struct kmem_cache *s)
> +{
> +	/*
> +	 * For each accounted object there is an extra space which is used
> +	 * to store obj_cgroup membership. Charge it too.
> +	 */
> +	return s->size + sizeof(struct obj_cgroup *);
> +}
> +
> +bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> +				  gfp_t flags, size_t size, void **p)
> +{
> +	struct obj_cgroup *objcg;
> +	struct slab *slab;
> +	unsigned long off;
> +	size_t i;
> +
> +	/*
> +	 * The obtained objcg pointer is safe to use within the current scope,
> +	 * defined by current task or set_active_memcg() pair.
> +	 * obj_cgroup_get() is used to get a permanent reference.
> +	 */
> +	objcg = current_obj_cgroup();
> +	if (!objcg)
> +		return true;
> +
> +	/*
> +	 * slab_alloc_node() avoids the NULL check, so we might be called with a
> +	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
> +	 * the whole requested size.
> +	 * return success as there's nothing to free back
> +	 */
> +	if (unlikely(*p == NULL))
> +		return true;
> +
> +	flags &= gfp_allowed_mask;
> +
> +	if (lru) {
> +		int ret;
> +		struct mem_cgroup *memcg;
> +
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		ret = memcg_list_lru_alloc(memcg, lru, flags);
> +		css_put(&memcg->css);
> +
> +		if (ret)
> +			return false;
> +	}
> +
> +	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
> +		return false;
> +
> +	for (i = 0; i < size; i++) {
> +		slab = virt_to_slab(p[i]);
> +
> +		if (!slab_objcgs(slab) &&
> +		    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
> +			obj_cgroup_uncharge(objcg, obj_full_size(s));
> +			continue;
> +		}
> +
> +		off = obj_to_index(s, slab, p[i]);
> +		obj_cgroup_get(objcg);
> +		slab_objcgs(slab)[off] = objcg;
> +		mod_objcg_state(objcg, slab_pgdat(slab),
> +				cache_vmstat_idx(s), obj_full_size(s));
> +	}
> +
> +	return true;
> +}
> +
> +void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +			    void **p, int objects, struct obj_cgroup **objcgs)
> +{
> +	for (int i = 0; i < objects; i++) {
> +		struct obj_cgroup *objcg;
> +		unsigned int off;
> +
> +		off = obj_to_index(s, slab, p[i]);
> +		objcg = objcgs[off];
> +		if (!objcg)
> +			continue;
> +
> +		objcgs[off] = NULL;
> +		obj_cgroup_uncharge(objcg, obj_full_size(s));
> +		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
> +				-obj_full_size(s));
> +		obj_cgroup_put(objcg);
> +	}
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  /*
> diff --git a/mm/slab.h b/mm/slab.h
> index 54deeb0428c6..3f170673fa55 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -541,6 +541,12 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>  	return false;
>  }
>  
> +static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> +{
> +	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> +		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  /*
>   * slab_objcgs - get the object cgroups vector associated with a slab
> @@ -564,6 +570,10 @@ int memcg_alloc_slab_cgroups(struct slab *slab, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_slab);
>  void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr);
> +bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> +				  gfp_t flags, size_t size, void **p);
> +void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> +			    void **p, int objects, struct obj_cgroup **objcgs);
>  #else /* CONFIG_MEMCG_KMEM */
>  static inline struct obj_cgroup **slab_objcgs(struct slab *slab)
>  {
> diff --git a/mm/slub.c b/mm/slub.c
> index 7022a1246bab..64da169d672a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1875,12 +1875,6 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>  #endif
>  #endif /* CONFIG_SLUB_DEBUG */
>  
> -static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> -{
> -	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
> -		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static inline void memcg_free_slab_cgroups(struct slab *slab)
>  {
> @@ -1888,79 +1882,6 @@ static inline void memcg_free_slab_cgroups(struct slab *slab)
>  	slab->memcg_data = 0;
>  }
>  
> -static inline size_t obj_full_size(struct kmem_cache *s)
> -{
> -	/*
> -	 * For each accounted object there is an extra space which is used
> -	 * to store obj_cgroup membership. Charge it too.
> -	 */
> -	return s->size + sizeof(struct obj_cgroup *);
> -}
> -
> -static bool __memcg_slab_post_alloc_hook(struct kmem_cache *s,
> -					 struct list_lru *lru,
> -					 gfp_t flags, size_t size,
> -					 void **p)
> -{
> -	struct obj_cgroup *objcg;
> -	struct slab *slab;
> -	unsigned long off;
> -	size_t i;
> -
> -	/*
> -	 * The obtained objcg pointer is safe to use within the current scope,
> -	 * defined by current task or set_active_memcg() pair.
> -	 * obj_cgroup_get() is used to get a permanent reference.
> -	 */
> -	objcg = current_obj_cgroup();
> -	if (!objcg)
> -		return true;
> -
> -	/*
> -	 * slab_alloc_node() avoids the NULL check, so we might be called with a
> -	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
> -	 * the whole requested size.
> -	 * return success as there's nothing to free back
> -	 */
> -	if (unlikely(*p == NULL))
> -		return true;
> -
> -	flags &= gfp_allowed_mask;
> -
> -	if (lru) {
> -		int ret;
> -		struct mem_cgroup *memcg;
> -
> -		memcg = get_mem_cgroup_from_objcg(objcg);
> -		ret = memcg_list_lru_alloc(memcg, lru, flags);
> -		css_put(&memcg->css);
> -
> -		if (ret)
> -			return false;
> -	}
> -
> -	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
> -		return false;
> -
> -	for (i = 0; i < size; i++) {
> -		slab = virt_to_slab(p[i]);
> -
> -		if (!slab_objcgs(slab) &&
> -		    memcg_alloc_slab_cgroups(slab, s, flags, false)) {
> -			obj_cgroup_uncharge(objcg, obj_full_size(s));
> -			continue;
> -		}
> -
> -		off = obj_to_index(s, slab, p[i]);
> -		obj_cgroup_get(objcg);
> -		slab_objcgs(slab)[off] = objcg;
> -		mod_objcg_state(objcg, slab_pgdat(slab),
> -				cache_vmstat_idx(s), obj_full_size(s));
> -	}
> -
> -	return true;
> -}
> -
>  static void memcg_alloc_abort_single(struct kmem_cache *s, void *object);
>  
>  static __fastpath_inline
> @@ -1986,27 +1907,6 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  	return false;
>  }
>  
> -static void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> -				   void **p, int objects,
> -				   struct obj_cgroup **objcgs)
> -{
> -	for (int i = 0; i < objects; i++) {
> -		struct obj_cgroup *objcg;
> -		unsigned int off;
> -
> -		off = obj_to_index(s, slab, p[i]);
> -		objcg = objcgs[off];
> -		if (!objcg)
> -			continue;
> -
> -		objcgs[off] = NULL;
> -		obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
> -				-obj_full_size(s));
> -		obj_cgroup_put(objcg);
> -	}
> -}
> -
>  static __fastpath_inline
>  void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
>  			  int objects)
> 
> -- 
> 2.44.0
> 
> 

