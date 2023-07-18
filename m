Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3239757BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGRMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGRMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:40:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7D099
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:40:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so56998955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689684018; x=1692276018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikv3c5UKmNpyTHlS5fwGJGbwI2S8WZSWuI+ewsXdmvo=;
        b=iPdReQBNazY9OQXhuoZsLAPbpAGbQ9Ro4LpfVnH39BW3Z6RqsLJ8o2UDwsfJJyLyYK
         GGgGArNqz+jWFv1W7CHn/OEAF7aYEncVWkhE22fOJYGYDZ/K7ZRugbLzSviQwRV0/aI+
         vI+wTD8rAFdnSqxwFw7Dd1epq9W4QNLRfmU33s592m44UrZnDGJTWoWO41gs+6lWx/2x
         Yxlz1q6tXcv61bQ6q0eUXT27tJlgrTh+YHR+9NFA/a0eGnO6lnhTqfiacrrSMTAA394L
         G1DdevYTPDxEZJ/SegVYoN6S9yMBh1rlu3mVKHoukMLKhROEyonHGG4KA7Tr7HgbOOBm
         OlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684018; x=1692276018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikv3c5UKmNpyTHlS5fwGJGbwI2S8WZSWuI+ewsXdmvo=;
        b=kcj1YBkdjCChjyqi3Y3AcUiGkpvyURazguFGhNRvTUvGXvlYLwoIVjC+vyCyg1d/9+
         9rjLaxvB7LovWQOTRttL0n/HFtRK4Nm6tNZ98DQ6ig0iYuXLIY7ZxsVtWQbxG3fsJZ2+
         nf4Zj0L+o2QZ2rgkxlMTVk8uFg4k26tXyeHxMuLzXQGLANYNaTupr46UWm03CG48iS5v
         QVaxoRI/HcmNXvBm9sjIKWqbarnEUu7Ou7EL10sxui8vqZ9IclvSJ+RSeZOL5iP84WQ0
         8GfEMJt3noLNs5HlFA3fa0yr7D3arArowvidkFL37RTY5jppJ+U1XWTpi4MotbsmirDy
         mY4w==
X-Gm-Message-State: ABy/qLYqhvljvjK14j1DCxIzAlmPxDYrKsLoChQz5XHAapK1kIRP3eI8
        JUj0JUP9qGXROgcnAwKbmGf8HMxtf3aFF4K7SrhE21So9+zyZMMjCKCYKFMd
X-Google-Smtp-Source: APBJJlHrZz/Cq7fkx1TjUUPkf1UaAo/58hjI1pBUORe6tJ3gjOw4Cm/O0FT/XmEHA68W/xgHC3q9CESzqjvaQP0XEAE=
X-Received: by 2002:a05:600c:204b:b0:3fa:9561:3016 with SMTP id
 p11-20020a05600c204b00b003fa95613016mr1714538wmg.30.1689684018077; Tue, 18
 Jul 2023 05:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230718073019.52513-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230718073019.52513-1-zhangpeng.00@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Jul 2023 14:39:41 +0200
Message-ID: <CANpmjNNUr17dKfBYumm54aqB9J-FaeWOW-az9cpkwMS6sd6+3A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: kfence: allocate kfence_metadata at runtime
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>
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

On Tue, 18 Jul 2023 at 09:30, Peng Zhang <zhangpeng.00@bytedance.com> wrote:
>
> kfence_metadata is currently a static array. For the purpose of allocating
> scalable __kfence_pool, we first change it to runtime allocation of
> metadata. Since the size of an object of kfence_metadata is 1160 bytes, we
> can save at least 72 pages (with default 256 objects) without enabling
> kfence.
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

This looks good (minor nit below).

Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> ---
> Changes since v2:
>  - Fix missing renaming of kfence_alloc_pool.
>  - Add __read_mostly for kfence_metadata and kfence_metadata_init.
>  - Use smp_store_release() and smp_load_acquire() to access kfence_metadata.
>  - Some tweaks to comments and git log.
>
> v1: https://lore.kernel.org/lkml/20230710032714.26200-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230712081616.45177-1-zhangpeng.00@bytedance.com/
>
>  include/linux/kfence.h |  11 ++--
>  mm/kfence/core.c       | 124 ++++++++++++++++++++++++++++-------------
>  mm/kfence/kfence.h     |   5 +-
>  mm/mm_init.c           |   2 +-
>  4 files changed, 97 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 726857a4b680..401af4757514 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -59,15 +59,16 @@ static __always_inline bool is_kfence_address(const void *addr)
>  }
>
>  /**
> - * kfence_alloc_pool() - allocate the KFENCE pool via memblock
> + * kfence_alloc_pool_and_metadata() - allocate the KFENCE pool and KFENCE
> + * metadata via memblock
>   */
> -void __init kfence_alloc_pool(void);
> +void __init kfence_alloc_pool_and_metadata(void);
>
>  /**
>   * kfence_init() - perform KFENCE initialization at boot time
>   *
> - * Requires that kfence_alloc_pool() was called before. This sets up the
> - * allocation gate timer, and requires that workqueues are available.
> + * Requires that kfence_alloc_pool_and_metadata() was called before. This sets
> + * up the allocation gate timer, and requires that workqueues are available.
>   */
>  void __init kfence_init(void);
>
> @@ -223,7 +224,7 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *sla
>  #else /* CONFIG_KFENCE */
>
>  static inline bool is_kfence_address(const void *addr) { return false; }
> -static inline void kfence_alloc_pool(void) { }
> +static inline void kfence_alloc_pool_and_metadata(void) { }
>  static inline void kfence_init(void) { }
>  static inline void kfence_shutdown_cache(struct kmem_cache *s) { }
>  static inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags) { return NULL; }
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index dad3c0eb70a0..6b526435886c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -116,7 +116,15 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>   * backing pages (in __kfence_pool).
>   */
>  static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
> -struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> +struct kfence_metadata *kfence_metadata __read_mostly;
> +
> +/*
> + * If kfence_metadata is not NULL, it may be accessed by kfence_shutdown_cache().
> + * So introduce kfence_metadata_init to initialize metadata, and then make
> + * kfence_metadata visible after initialization is successful. This prevents
> + * potential UAF or access to uninitialized metadata.
> + */
> +static struct kfence_metadata *kfence_metadata_init __read_mostly;
>
>  /* Freelist with available objects. */
>  static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
> @@ -591,7 +599,7 @@ static unsigned long kfence_init_pool(void)
>
>                 __folio_set_slab(slab_folio(slab));
>  #ifdef CONFIG_MEMCG
> -               slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> +               slab->memcg_data = (unsigned long)&kfence_metadata_init[i / 2 - 1].objcg |
>                                    MEMCG_DATA_OBJCGS;
>  #endif
>         }
> @@ -610,7 +618,7 @@ static unsigned long kfence_init_pool(void)
>         }
>
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> -               struct kfence_metadata *meta = &kfence_metadata[i];
> +               struct kfence_metadata *meta = &kfence_metadata_init[i];
>
>                 /* Initialize metadata. */
>                 INIT_LIST_HEAD(&meta->list);
> @@ -626,6 +634,12 @@ static unsigned long kfence_init_pool(void)
>                 addr += 2 * PAGE_SIZE;
>         }
>
> +       /*
> +        * Make kfence_metadata visible only when initialization is successful.
> +        * Otherwise, if the initialization fails and kfence_metadata is freed,
> +        * it may cause UAF in kfence_shutdown_cache().
> +        */
> +       smp_store_release(&kfence_metadata, kfence_metadata_init);
>         return 0;
>
>  reset_slab:
> @@ -672,26 +686,10 @@ static bool __init kfence_init_pool_early(void)
>          */
>         memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
>         __kfence_pool = NULL;
> -       return false;
> -}
> -
> -static bool kfence_init_pool_late(void)
> -{
> -       unsigned long addr, free_size;
>
> -       addr = kfence_init_pool();
> -
> -       if (!addr)
> -               return true;
> +       memblock_free_late(__pa(kfence_metadata_init), KFENCE_METADATA_SIZE);
> +       kfence_metadata_init = NULL;
>
> -       /* Same as above. */
> -       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> -#ifdef CONFIG_CONTIG_ALLOC
> -       free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
> -#else
> -       free_pages_exact((void *)addr, free_size);
> -#endif
> -       __kfence_pool = NULL;
>         return false;
>  }
>
> @@ -841,19 +839,30 @@ static void toggle_allocation_gate(struct work_struct *work)
>
>  /* === Public interface ===================================================== */
>
> -void __init kfence_alloc_pool(void)
> +void __init kfence_alloc_pool_and_metadata(void)
>  {
>         if (!kfence_sample_interval)
>                 return;
>
> -       /* if the pool has already been initialized by arch, skip the below. */
> -       if (__kfence_pool)
> -               return;
> -
> -       __kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> -
> +       /*
> +        * If the pool has already been initialized by arch, there is no need to
> +        * re-allocate the memory pool.
> +        */
>         if (!__kfence_pool)
> +               __kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> +
> +       if (!__kfence_pool) {
>                 pr_err("failed to allocate pool\n");
> +               return;
> +       }
> +
> +       /* The memory allocated by memblock has been zeroed out. */
> +       kfence_metadata_init = memblock_alloc(KFENCE_METADATA_SIZE, PAGE_SIZE);
> +       if (!kfence_metadata_init) {
> +               pr_err("failed to allocate metadata\n");
> +               memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
> +               __kfence_pool = NULL;
> +       }
>  }
>
>  static void kfence_init_enable(void)
> @@ -895,33 +904,68 @@ void __init kfence_init(void)
>
>  static int kfence_init_late(void)
>  {
> -       const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
> +       const unsigned long nr_pages_pool = KFENCE_POOL_SIZE / PAGE_SIZE;
> +       const unsigned long nr_pages_meta = KFENCE_METADATA_SIZE / PAGE_SIZE;
> +       unsigned long addr = (unsigned long)__kfence_pool;
> +       unsigned long free_size = KFENCE_POOL_SIZE;
> +       int err = -ENOMEM;
> +
>  #ifdef CONFIG_CONTIG_ALLOC
>         struct page *pages;
> -

Unnecessary blank line removal (it looks worse now).


> -       pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node, NULL);
> +       pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL, first_online_node,
> +                                  NULL);
>         if (!pages)
>                 return -ENOMEM;
> +
>         __kfence_pool = page_to_virt(pages);
> +       pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL, first_online_node,
> +                                  NULL);
> +       if (pages)
> +               kfence_metadata_init = page_to_virt(pages);
>  #else
> -       if (nr_pages > MAX_ORDER_NR_PAGES) {
> +       if (nr_pages_pool > MAX_ORDER_NR_PAGES ||
> +           nr_pages_meta > MAX_ORDER_NR_PAGES) {
>                 pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
>                 return -EINVAL;
>         }
> +
>         __kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
>         if (!__kfence_pool)
>                 return -ENOMEM;
> +
> +       kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE, GFP_KERNEL);
>  #endif
>
> -       if (!kfence_init_pool_late()) {
> -               pr_err("%s failed\n", __func__);
> -               return -EBUSY;
> +       if (!kfence_metadata_init)
> +               goto free_pool;
> +
> +       memzero_explicit(kfence_metadata_init, KFENCE_METADATA_SIZE);
> +       addr = kfence_init_pool();
> +       if (!addr) {
> +               kfence_init_enable();
> +               kfence_debugfs_init();
> +               return 0;
>         }
>
> -       kfence_init_enable();
> -       kfence_debugfs_init();
> +       pr_err("%s failed\n", __func__);
> +       free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
> +       err = -EBUSY;
>
> -       return 0;
> +#ifdef CONFIG_CONTIG_ALLOC
> +       free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata_init)),
> +                         nr_pages_meta);
> +free_pool:
> +       free_contig_range(page_to_pfn(virt_to_page((void *)addr)),
> +                         free_size / PAGE_SIZE);
> +#else
> +       free_pages_exact((void *)kfence_metadata_init, KFENCE_METADATA_SIZE);
> +free_pool:
> +       free_pages_exact((void *)addr, free_size);
> +#endif
> +
> +       kfence_metadata_init = NULL;
> +       __kfence_pool = NULL;
> +       return err;
>  }
>
>  static int kfence_enable_late(void)
> @@ -941,6 +985,10 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>         struct kfence_metadata *meta;
>         int i;
>
> +       /* Pairs with release in kfence_init_pool(). */
> +       if (!smp_load_acquire(&kfence_metadata))
> +               return;
> +
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
>                 bool in_use;
>
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 392fb273e7bd..f46fbb03062b 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -102,7 +102,10 @@ struct kfence_metadata {
>  #endif
>  };
>
> -extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> +#define KFENCE_METADATA_SIZE PAGE_ALIGN(sizeof(struct kfence_metadata) * \
> +                                       CONFIG_KFENCE_NUM_OBJECTS)
> +
> +extern struct kfence_metadata *kfence_metadata;
>
>  static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
>  {
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7f7f9c677854..3d0a63c75829 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2721,7 +2721,7 @@ void __init mm_core_init(void)
>          */
>         page_ext_init_flatmem();
>         mem_debugging_and_hardening_init();
> -       kfence_alloc_pool();
> +       kfence_alloc_pool_and_metadata();
>         report_meminit();
>         kmsan_init_shadow();
>         stack_depot_early_init();
> --
> 2.20.1
>
