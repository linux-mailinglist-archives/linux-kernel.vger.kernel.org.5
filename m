Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298767FD45F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjK2Kgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Kgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:36:31 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198A2123
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:35:54 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4644db3b384so89273137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701254154; x=1701858954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMrQed01JJcN4xQKdeWzhemwVY/MGHkgvTWPoO+Z2wQ=;
        b=SGzb55rfa7L990KgU9b9myGKp/rrR1Pw5F6BK670UJKjfKVoWRqBfBcWbbXQhs8cxa
         BN0leHOABFmqBVSnPsQ8q/pk6A8INh4JR532HdP/BaWzJ/2/fMhZH5OeVzfc/QvS/reO
         i8vRmYqc3EHo4LRaa8QEal9/vhShvv6RhEp2+XFN9ikZhyUjXW9xzK1LjsxvH7MXZnjq
         eiqnmZT6Buy2NmaHOMli4NYuYSQE3bQvbnF7Zr2RGlKf7O16CbxrwV3moY7F6/P50sGm
         S6/2ASfmI0S0EomNF3YIJNSHsPqCEiSP68uyHwOSFcTvqUmjlw2aaREmJIvSjgXt8U7M
         dkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701254154; x=1701858954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMrQed01JJcN4xQKdeWzhemwVY/MGHkgvTWPoO+Z2wQ=;
        b=tYP80fGt9JX3n+4SV/IS421JRPMpzHGNlY+GANDL4IR6VKHQRbhV6xmNXr/AUPHo1z
         BUKrg5feOrNthFtuOCPimCy2QE2a//Fcy135ZksRJ39yhCPcDv9TTk+hu7NOgNeAeSe9
         SZJR6J1nAlqOVp4BzjVXzvsAHysZPsze2shs3muVIbDtAkYCVUJ702PZ+rWwRlI+Evqf
         bbBp6FBq+HFdYWuTgsLZHS36npq4d00e+d9bTT2IIhBz6dbP5zWMv24ZUf0oaZ2BNkRb
         wuxU9iPw/Fu8HTMiHP/0Mv/ExjMczEw2MYIcERzYwWjUrk5XK2xYd4veYJ/PbjXZPxK6
         E+Mw==
X-Gm-Message-State: AOJu0YwqkSWjNTLJtcnFi0xiW2gLmnW0WlgKtUbLKY1SFu77zM05SH80
        ge+sXKeOgP9CWwJ6Fk9leOJmjL39+tLx8MCxb699cw==
X-Google-Smtp-Source: AGHT+IGyTyUsubURK0Y62/ZJkkb/jcIQV3Lx2dIcd0Dmv73jmLOhEJzKxaomff0g95XI30xBdf2AsBLFYMTIOhT3gt4=
X-Received: by 2002:a67:fb15:0:b0:464:408a:5d87 with SMTP id
 d21-20020a67fb15000000b00464408a5d87mr3293331vsr.33.1701254153678; Wed, 29
 Nov 2023 02:35:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz> <20231129-slub-percpu-caches-v3-5-6bcf536772bc@suse.cz>
In-Reply-To: <20231129-slub-percpu-caches-v3-5-6bcf536772bc@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Nov 2023 11:35:15 +0100
Message-ID: <CANpmjNNOUozLuop+QddSdNd462J6CysPVcTbS9jP+aswKS9XHg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/9] mm/slub: add opt-in percpu array cache of objects
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 10:53, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> kmem_cache_setup_percpu_array() will allocate a per-cpu array for
> caching alloc/free objects of given size for the cache. The cache
> has to be created with SLAB_NO_MERGE flag.
>
> When empty, half of the array is filled by an internal bulk alloc
> operation. When full, half of the array is flushed by an internal bulk
> free operation.
>
> The array does not distinguish NUMA locality of the cached objects. If
> an allocation is requested with kmem_cache_alloc_node() with numa node
> not equal to NUMA_NO_NODE, the array is bypassed.
>
> The bulk operations exposed to slab users also try to utilize the array
> when possible, but leave the array empty or full and use the bulk
> alloc/free only to finish the operation itself. If kmemcg is enabled and
> active, bulk freeing skips the array completely as it would be less
> efficient to use it.
>
> The locking scheme is copied from the page allocator's pcplists, based
> on embedded spin locks. Interrupts are not disabled, only preemption
> (cpu migration on RT). Trylock is attempted to avoid deadlock due to an
> interrupt; trylock failure means the array is bypassed.
>
> Sysfs stat counters alloc_cpu_cache and free_cpu_cache count objects
> allocated or freed using the percpu array; counters cpu_cache_refill and
> cpu_cache_flush count objects refilled or flushed form the array.
>
> kmem_cache_prefill_percpu_array() can be called to ensure the array on
> the current cpu to at least the given number of objects. However this is
> only opportunistic as there's no cpu pinning between the prefill and
> usage, and trylocks may fail when the usage is in an irq handler.
> Therefore allocations cannot rely on the array for success even after
> the prefill. But misses should be rare enough that e.g. GFP_ATOMIC
> allocations should be acceptable after the refill.
>
> When slub_debug is enabled for a cache with percpu array, the objects in
> the array are considered as allocated from the slub_debug perspective,
> and the alloc/free debugging hooks occur when moving the objects between
> the array and slab pages. This means that e.g. an use-after-free that
> occurs for an object cached in the array is undetected. Collected
> alloc/free stacktraces might also be less useful. This limitation could
> be changed in the future.
>
> On the other hand, KASAN, kmemcg and other hooks are executed on actual
> allocations and frees by kmem_cache users even if those use the array,
> so their debugging or accounting accuracy should be unaffected.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h     |   4 +
>  include/linux/slub_def.h |  12 ++
>  mm/Kconfig               |   1 +
>  mm/slub.c                | 457 ++++++++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 468 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d6d6ffeeb9a2..fe0c0981be59 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -197,6 +197,8 @@ struct kmem_cache *kmem_cache_create_usercopy(const char *name,
>  void kmem_cache_destroy(struct kmem_cache *s);
>  int kmem_cache_shrink(struct kmem_cache *s);
>
> +int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count);
> +
>  /*
>   * Please use this macro to create slab caches. Simply specify the
>   * name of the structure and maybe some flags that are listed above.
> @@ -512,6 +514,8 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
>  void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
>  int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
>
> +int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count, gfp_t gfp);
> +
>  static __always_inline void kfree_bulk(size_t size, void **p)
>  {
>         kmem_cache_free_bulk(NULL, size, p);
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index deb90cf4bffb..2083aa849766 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -13,8 +13,10 @@
>  #include <linux/local_lock.h>
>
>  enum stat_item {
> +       ALLOC_PCA,              /* Allocation from percpu array cache */
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
>         ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab */
> +       FREE_PCA,               /* Free to percpu array cache */
>         FREE_FASTPATH,          /* Free to cpu slab */
>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>         FREE_FROZEN,            /* Freeing to frozen slab */
> @@ -39,6 +41,8 @@ enum stat_item {
>         CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
>         CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial */
>         CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
> +       PCA_REFILL,             /* Refilling empty percpu array cache */
> +       PCA_FLUSH,              /* Flushing full percpu array cache */
>         NR_SLUB_STAT_ITEMS
>  };
>
> @@ -66,6 +70,13 @@ struct kmem_cache_cpu {
>  };
>  #endif /* CONFIG_SLUB_TINY */
>
> +struct slub_percpu_array {
> +       spinlock_t lock;
> +       unsigned int count;
> +       unsigned int used;
> +       void * objects[];

checkpatch complains: "foo * bar" should be "foo *bar"
