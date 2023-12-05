Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95D8055C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442104AbjLENXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376864AbjLENXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:23:43 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365FDB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:23:49 -0800 (PST)
Message-ID: <93adcdc0-6f32-45fa-b311-34a27ff94290@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701782627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Y3aGufX1vl5A2ALGYiBVD+TybG4OsFZRCv9diM79A8=;
        b=mDZ6ph0oD6GN4VIyjlxG+xz5R+xV+/uKAA5//QVwR59UjvRThXVEbE3/QvAFOfUgypbOZA
        vkjBJxn1O6J1qOCwVw8BB4AVmDNXEdLfNgJWq1aN+0yguJxd7UP182RiYrh1Lgp0Bi918z
        G9pDHo0IQHxFoPXFTcxbQm2XEqmMN/Q=
Date:   Tue, 5 Dec 2023 21:23:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] mm/slub: handle bulk and single object freeing
 separately
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-3-88b65f7cd9d5@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231204-slub-cleanup-hooks-v1-3-88b65f7cd9d5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/5 03:34, Vlastimil Babka wrote:
> Currently we have a single function slab_free() handling both single
> object freeing and bulk freeing with necessary hooks, the latter case
> requiring slab_free_freelist_hook(). It should be however better to
> distinguish the two use cases for the following reasons:
> 
> - code simpler to follow for the single object case
> 
> - better code generation - although inlining should eliminate the
>   slab_free_freelist_hook() for single object freeing in case no
>   debugging options are enabled, it seems it's not perfect. When e.g.
>   KASAN is enabled, we're imposing additional unnecessary overhead for
>   single object freeing.
> 
> - preparation to add percpu array caches in near future
> 
> Therefore, simplify slab_free() for the single object case by dropping
> unnecessary parameters and calling only slab_free_hook() instead of
> slab_free_freelist_hook(). Rename the bulk variant to slab_free_bulk()
> and adjust callers accordingly.
> 
> While at it, flip (and document) slab_free_hook() return value so that
> it returns true when the freeing can proceed, which matches the logic of
> slab_free_freelist_hook() and is not confusingly the opposite.
> 
> Additionally we can simplify a bit by changing the tail parameter of
> do_slab_free() when freeing a single object - instead of NULL we can set
> it equal to head.
> 
> bloat-o-meter shows small code reduction with a .config that has KASAN
> etc disabled:
> 
> add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-118 (-118)
> Function                                     old     new   delta
> kmem_cache_alloc_bulk                       1203    1196      -7
> kmem_cache_free                              861     835     -26
> __kmem_cache_free                            741     704     -37
> kmem_cache_free_bulk                         911     863     -48
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me.

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks!

> ---
>  mm/slub.c | 59 +++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0742564c4538..ed2fa92e914c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2037,9 +2037,12 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>  /*
>   * Hooks for other subsystems that check memory allocations. In a typical
>   * production configuration these hooks all should produce no code at all.
> + *
> + * Returns true if freeing of the object can proceed, false if its reuse
> + * was delayed by KASAN quarantine.
>   */
> -static __always_inline bool slab_free_hook(struct kmem_cache *s,
> -						void *x, bool init)
> +static __always_inline
> +bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>  {
>  	kmemleak_free_recursive(x, s->flags);
>  	kmsan_slab_free(s, x);
> @@ -2072,7 +2075,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s,
>  		       s->size - s->inuse - rsize);
>  	}
>  	/* KASAN might put x into memory quarantine, delaying its reuse. */
> -	return kasan_slab_free(s, x, init);
> +	return !kasan_slab_free(s, x, init);
>  }
>  
>  static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> @@ -2082,7 +2085,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  
>  	void *object;
>  	void *next = *head;
> -	void *old_tail = *tail ? *tail : *head;
> +	void *old_tail = *tail;
>  
>  	if (is_kfence_address(next)) {
>  		slab_free_hook(s, next, false);
> @@ -2098,8 +2101,8 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  		next = get_freepointer(s, object);
>  
>  		/* If object's reuse doesn't have to be delayed */
> -		if (likely(!slab_free_hook(s, object,
> -					   slab_want_init_on_free(s)))) {
> +		if (likely(slab_free_hook(s, object,
> +					  slab_want_init_on_free(s)))) {
>  			/* Move object to the new freelist */
>  			set_freepointer(s, object, *head);
>  			*head = object;
> @@ -2114,9 +2117,6 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  		}
>  	} while (object != old_tail);
>  
> -	if (*head == *tail)
> -		*tail = NULL;
> -
>  	return *head != NULL;
>  }
>  
> @@ -4227,7 +4227,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  				struct slab *slab, void *head, void *tail,
>  				int cnt, unsigned long addr)
>  {
> -	void *tail_obj = tail ? : head;
>  	struct kmem_cache_cpu *c;
>  	unsigned long tid;
>  	void **freelist;
> @@ -4246,14 +4245,14 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  	barrier();
>  
>  	if (unlikely(slab != c->slab)) {
> -		__slab_free(s, slab, head, tail_obj, cnt, addr);
> +		__slab_free(s, slab, head, tail, cnt, addr);
>  		return;
>  	}
>  
>  	if (USE_LOCKLESS_FAST_PATH()) {
>  		freelist = READ_ONCE(c->freelist);
>  
> -		set_freepointer(s, tail_obj, freelist);
> +		set_freepointer(s, tail, freelist);
>  
>  		if (unlikely(!__update_cpu_freelist_fast(s, freelist, head, tid))) {
>  			note_cmpxchg_failure("slab_free", s, tid);
> @@ -4270,7 +4269,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  		tid = c->tid;
>  		freelist = c->freelist;
>  
> -		set_freepointer(s, tail_obj, freelist);
> +		set_freepointer(s, tail, freelist);
>  		c->freelist = head;
>  		c->tid = next_tid(tid);
>  
> @@ -4283,15 +4282,27 @@ static void do_slab_free(struct kmem_cache *s,
>  				struct slab *slab, void *head, void *tail,
>  				int cnt, unsigned long addr)
>  {
> -	void *tail_obj = tail ? : head;
> -
> -	__slab_free(s, slab, head, tail_obj, cnt, addr);
> +	__slab_free(s, slab, head, tail, cnt, addr);
>  }
>  #endif /* CONFIG_SLUB_TINY */
>  
> -static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> -				      void *head, void *tail, void **p, int cnt,
> -				      unsigned long addr)
> +static __fastpath_inline
> +void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> +	       unsigned long addr)
> +{
> +	bool init;
> +
> +	memcg_slab_free_hook(s, slab, &object, 1);
> +
> +	init = !is_kfence_address(object) && slab_want_init_on_free(s);
> +
> +	if (likely(slab_free_hook(s, object, init)))
> +		do_slab_free(s, slab, object, object, 1, addr);
> +}
> +
> +static __fastpath_inline
> +void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
> +		    void *tail, void **p, int cnt, unsigned long addr)
>  {
>  	memcg_slab_free_hook(s, slab, p, cnt);
>  	/*
> @@ -4305,7 +4316,7 @@ static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
>  #ifdef CONFIG_KASAN_GENERIC
>  void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
>  {
> -	do_slab_free(cache, virt_to_slab(x), x, NULL, 1, addr);
> +	do_slab_free(cache, virt_to_slab(x), x, x, 1, addr);
>  }
>  #endif
>  
> @@ -4349,7 +4360,7 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  	if (!s)
>  		return;
>  	trace_kmem_cache_free(_RET_IP_, x, s);
> -	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, _RET_IP_);
> +	slab_free(s, virt_to_slab(x), x, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
>  
> @@ -4395,7 +4406,7 @@ void kfree(const void *object)
>  
>  	slab = folio_slab(folio);
>  	s = slab->slab_cache;
> -	slab_free(s, slab, x, NULL, &x, 1, _RET_IP_);
> +	slab_free(s, slab, x, _RET_IP_);
>  }
>  EXPORT_SYMBOL(kfree);
>  
> @@ -4512,8 +4523,8 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  		if (!df.slab)
>  			continue;
>  
> -		slab_free(df.s, df.slab, df.freelist, df.tail, &p[size], df.cnt,
> -			  _RET_IP_);
> +		slab_free_bulk(df.s, df.slab, df.freelist, df.tail, &p[size],
> +			       df.cnt, _RET_IP_);
>  	} while (likely(size));
>  }
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
> 
