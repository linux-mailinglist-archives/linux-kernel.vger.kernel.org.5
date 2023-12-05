Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA448804C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjLEITa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:19:29 -0500
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB7BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:19:35 -0800 (PST)
Message-ID: <30f88452-740b-441f-bb4f-a2d946e35cf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701764373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1msEm8akAYRx9kjUOA91nsxPgIb6zvoJEQIqcVegQCI=;
        b=AtV3fzAeFmZ4JdXWxE03Prk3MZ1wZv43S0/xlV9BSbUTbS4gpzfPNZcJ8hnkvLbnvyQ/uu
        jdzhUwZUufJ0BcrKBBvLcMlMyveGsVUDjDk/FESYXgTpwridpsKWff7xPk+5s1zThdAMky
        6MUHbCZDjgykCWbP9LXWTvdIX0CSgLM=
Date:   Tue, 5 Dec 2023 16:19:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] mm/slub: introduce __kmem_cache_free_bulk() without
 free hooks
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
 <20231204-slub-cleanup-hooks-v1-2-88b65f7cd9d5@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231204-slub-cleanup-hooks-v1-2-88b65f7cd9d5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/5 03:34, Vlastimil Babka wrote:
> Currently, when __kmem_cache_alloc_bulk() fails, it frees back the
> objects that were allocated before the failure, using
> kmem_cache_free_bulk(). Because kmem_cache_free_bulk() calls the free
> hooks (KASAN etc.) and those expect objects that were processed by the
> post alloc hooks, slab_post_alloc_hook() is called before
> kmem_cache_free_bulk().
> 
> This is wasteful, although not a big concern in practice for the rare
> error path. But in order to efficiently handle percpu array batch refill
> and free in the near future, we will also need a variant of
> kmem_cache_free_bulk() that avoids the free hooks. So introduce it now
> and use it for the failure path.
> 
> As a consequence, __kmem_cache_alloc_bulk() no longer needs the objcg
> parameter, remove it.

The objects may have been charged before, but it seems __kmem_cache_alloc_bulk()
forget to uncharge them? I can't find "uncharge" in do_slab_free(), or maybe
the bulk interface won't be used on chargeable slab?

Thanks.

> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d7b0ca6012e0..0742564c4538 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4478,6 +4478,27 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
>  	return same;
>  }
>  
> +/*
> + * Internal bulk free of objects that were not initialised by the post alloc
> + * hooks and thus should not be processed by the free hooks
> + */
> +static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> +{
> +	if (!size)
> +		return;
> +
> +	do {
> +		struct detached_freelist df;
> +
> +		size = build_detached_freelist(s, size, p, &df);
> +		if (!df.slab)
> +			continue;
> +
> +		do_slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt,
> +			     _RET_IP_);
> +	} while (likely(size));
> +}
> +
>  /* Note that interrupts must be enabled when calling this function. */
>  void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
>  {
> @@ -4499,7 +4520,7 @@ EXPORT_SYMBOL(kmem_cache_free_bulk);
>  
>  #ifndef CONFIG_SLUB_TINY
>  static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -			size_t size, void **p, struct obj_cgroup *objcg)
> +					  size_t size, void **p)
>  {
>  	struct kmem_cache_cpu *c;
>  	unsigned long irqflags;
> @@ -4563,14 +4584,13 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>  
>  error:
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
> -	kmem_cache_free_bulk(s, i, p);
> +	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  
>  }
>  #else /* CONFIG_SLUB_TINY */
>  static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
> -			size_t size, void **p, struct obj_cgroup *objcg)
> +				   size_t size, void **p)
>  {
>  	int i;
>  
> @@ -4593,8 +4613,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>  	return i;
>  
>  error:
> -	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
> -	kmem_cache_free_bulk(s, i, p);
> +	__kmem_cache_free_bulk(s, i, p);
>  	return 0;
>  }
>  #endif /* CONFIG_SLUB_TINY */
> @@ -4614,7 +4633,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>  	if (unlikely(!s))
>  		return 0;
>  
> -	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
> +	i = __kmem_cache_alloc_bulk(s, flags, size, p);
>  
>  	/*
>  	 * memcg and kmem_cache debug support and memory initialization.
> 
