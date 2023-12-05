Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0194F8048AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjLEEig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEEie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:38:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E39BE;
        Mon,  4 Dec 2023 20:38:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so1370827b3a.0;
        Mon, 04 Dec 2023 20:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701751120; x=1702355920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8za1LL9JYBxMQqZEFu+Ip+HiV0+LDHs+kobZXAkLSM=;
        b=EEu0ZcSUm039tbXUSuuiNNOLZZlt2IVkUAAPQeAbDsYw0aq4tO11HM20fS6z/5Jy0f
         YzBTlVAyND/Z3v05yS0/XWbNgvcdM5zv3g25Ib6YGzIKr3qyH1bIQLgC9XDyFrbcCXf0
         xgH5gVKAkn7kxL8u7FLNv6eyK7rhviezUpT1wQr//URCf6Kz/e4VZEau9vpyM5zBwShL
         eI8YKSBoPmTHfwaYkrIMd4axbP51sOhT3CA/ZjhEZW3H9d58rBTxk0rgozqIXnc7OXXm
         h+XONHcnuwoFP2mqvNiMljs5pn36PytqHOqpfH5fZSwVeK12IhETR6LazzdG0JH3wGra
         cgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701751120; x=1702355920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8za1LL9JYBxMQqZEFu+Ip+HiV0+LDHs+kobZXAkLSM=;
        b=OMZrrGdLeGsiYoJ5CFcbIlb/VUFjYr4U+fG7FhGGAvLJclFMpKw8UGnZPwZ/N9fbSg
         3q0OWDAMfhJfD3oRDrZEZoJM9YC49ms+YPKl6V2UAHOzefmCXzYy5ntfyXTb7kIOqXyX
         CfXkILbr7tg1gTTzFzCkUjMgeehB0gAG/PgjPluSUS9YGQayipGKeEwG6/JTzAqeNbr2
         DJklBu1wTCltDi2TF9x/NeVpqj5vM2PoSYSyKXivxdf8YIHK9JSKNEcZIhMGUU3+qAwc
         CPKcwR80S0KUd8Bj5H+4pk5sbWBoXI0x1YePBvIQefSPhr6XfosxAXPOtxA3OQ3sOvTX
         e3Lw==
X-Gm-Message-State: AOJu0Ywd6aXpPdtalg/e+Ih4bvJkKSrvWxZdNuU8R3EKz/9tkeMrWgd5
        biYkIcOJFzdXAmfdjRg/CGPldo1EDbI=
X-Google-Smtp-Source: AGHT+IHSG+1Tgf/q/ZSVPAa40DZqAi1IiJXzl6rcBNCixCdC/TwLHWLbumoyWO7hnbLLdrrVcadqwg==
X-Received: by 2002:a05:6a20:1586:b0:18f:97c:5b84 with SMTP id h6-20020a056a20158600b0018f097c5b84mr2423300pzj.82.1701751119663;
        Mon, 04 Dec 2023 20:38:39 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id c13-20020a170903234d00b001cfcf3dd317sm9212738plh.61.2023.12.04.20.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 20:38:38 -0800 (PST)
Date:   Tue, 5 Dec 2023 13:38:21 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 16/21] mm/slab: move kfree() from slab_common.c to
 slub.c
Message-ID: <ZW6pPdvjOfaMmWxu@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-16-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-16-9c9c70177183@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:34:27PM +0100, Vlastimil Babka wrote:
> This should result in better code. Currently kfree() makes a function
> call between compilation units to __kmem_cache_free() which does its own
> virt_to_slab(), throwing away the struct slab pointer we already had in
> kfree(). Now it can be reused. Additionally kfree() can now inline the
> whole SLUB freeing fastpath.
> 
> Also move over free_large_kmalloc() as the only callsites are now in
> slub.c, and make it static.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h        |  4 ----
>  mm/slab_common.c | 45 ---------------------------------------------
>  mm/slub.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 5ae6a978e9c2..35a55c4a407d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -395,8 +395,6 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags, unsigned long caller);
>  void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags,
>  			      int node, size_t orig_size,
>  			      unsigned long caller);
> -void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller);
> -
>  gfp_t kmalloc_fix_flags(gfp_t flags);
>  
>  /* Functions provided by the slab allocators */
> @@ -559,8 +557,6 @@ static inline int memcg_alloc_slab_cgroups(struct slab *slab,
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>  
> -void free_large_kmalloc(struct folio *folio, void *object);
> -
>  size_t __ksize(const void *objp);
>  
>  static inline size_t slab_ksize(const struct kmem_cache *s)
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bbc2e3f061f1..f4f275613d2a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -963,22 +963,6 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  	slab_state = UP;
>  }
>  
> -void free_large_kmalloc(struct folio *folio, void *object)
> -{
> -	unsigned int order = folio_order(folio);
> -
> -	if (WARN_ON_ONCE(order == 0))
> -		pr_warn_once("object pointer: 0x%p\n", object);
> -
> -	kmemleak_free(object);
> -	kasan_kfree_large(object);
> -	kmsan_kfree_large(object);
> -
> -	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> -			      -(PAGE_SIZE << order));
> -	__free_pages(folio_page(folio, 0), order);
> -}
> -
>  static void *__kmalloc_large_node(size_t size, gfp_t flags, int node);
>  static __always_inline
>  void *__do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
> @@ -1023,35 +1007,6 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
>  }
>  EXPORT_SYMBOL(__kmalloc_node_track_caller);
>  
> -/**
> - * kfree - free previously allocated memory
> - * @object: pointer returned by kmalloc() or kmem_cache_alloc()
> - *
> - * If @object is NULL, no operation is performed.
> - */
> -void kfree(const void *object)
> -{
> -	struct folio *folio;
> -	struct slab *slab;
> -	struct kmem_cache *s;
> -
> -	trace_kfree(_RET_IP_, object);
> -
> -	if (unlikely(ZERO_OR_NULL_PTR(object)))
> -		return;
> -
> -	folio = virt_to_folio(object);
> -	if (unlikely(!folio_test_slab(folio))) {
> -		free_large_kmalloc(folio, (void *)object);
> -		return;
> -	}
> -
> -	slab = folio_slab(folio);
> -	s = slab->slab_cache;
> -	__kmem_cache_free(s, (void *)object, _RET_IP_);
> -}
> -EXPORT_SYMBOL(kfree);
> -
>  /**
>   * __ksize -- Report full size of underlying allocation
>   * @object: pointer to the object
> diff --git a/mm/slub.c b/mm/slub.c
> index cc801f8258fe..2baa9e94d9df 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4197,11 +4197,6 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
>  	return cachep;
>  }
>  
> -void __kmem_cache_free(struct kmem_cache *s, void *x, unsigned long caller)
> -{
> -	slab_free(s, virt_to_slab(x), x, NULL, &x, 1, caller);
> -}
> -
>  /**
>   * kmem_cache_free - Deallocate an object
>   * @s: The cache the allocation was from.
> @@ -4220,6 +4215,52 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
>  }
>  EXPORT_SYMBOL(kmem_cache_free);
>  
> +static void free_large_kmalloc(struct folio *folio, void *object)
> +{
> +	unsigned int order = folio_order(folio);
> +
> +	if (WARN_ON_ONCE(order == 0))
> +		pr_warn_once("object pointer: 0x%p\n", object);
> +
> +	kmemleak_free(object);
> +	kasan_kfree_large(object);
> +	kmsan_kfree_large(object);
> +
> +	mod_lruvec_page_state(folio_page(folio, 0), NR_SLAB_UNRECLAIMABLE_B,
> +			      -(PAGE_SIZE << order));
> +	__free_pages(folio_page(folio, 0), order);
> +}
> +
> +/**
> + * kfree - free previously allocated memory
> + * @object: pointer returned by kmalloc() or kmem_cache_alloc()
> + *
> + * If @object is NULL, no operation is performed.
> + */
> +void kfree(const void *object)
> +{
> +	struct folio *folio;
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +	void *x = (void *)object;
> +
> +	trace_kfree(_RET_IP_, object);
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(object)))
> +		return;
> +
> +	folio = virt_to_folio(object);
> +	if (unlikely(!folio_test_slab(folio))) {
> +		free_large_kmalloc(folio, (void *)object);
> +		return;
> +	}
> +
> +	slab = folio_slab(folio);
> +	s = slab->slab_cache;
> +	slab_free(s, slab, x, NULL, &x, 1, _RET_IP_);
> +}
> +EXPORT_SYMBOL(kfree);
> +
>  struct detached_freelist {
>  	struct slab *slab;
>  	void *tail;

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

nit: mm/kfence/report.c checks if a function name starts with
"__kmem_cache_free" which is removed by this patch.

> 
> -- 
> 2.42.1
> 
> 
