Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AD756018
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGQKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjGQKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:08:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE84136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:08:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so26027165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689588516; x=1692180516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqBfpIPYXg9/0aovDlWqLigZJLcQOQ5ybNw4hlBZbB0=;
        b=3b6EnwrTEuz+Sltgnnr6rbDdcvKOjrLG6e9kSLgkVTIy44/IEUsrA82UVGqvC9I9En
         4ESjgLAP2WxdDuWnnamco7/wEbqjIJA8qsK0klDhG9WQD7zm8ecwsc5Euhqe5u81JAKG
         I+/MF8NpcveBatbYzXKbZszSf17pBVfoTotZw8O2OjDiHmHVNp/pPtSKDSJ/zVfZGA4/
         lA+iEddulrlZX2yoem0JMnTgCzIzTJcYFyDIrTHzd4i3hNum7B8USDAi8DTmzEt6H8w7
         Pt5QsmsgvrtqJ+rIXw66FyMF2g8LqA8uYA/CxNJGzNc5B3y1wVALypuBnC4muWmdjixz
         aYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689588516; x=1692180516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqBfpIPYXg9/0aovDlWqLigZJLcQOQ5ybNw4hlBZbB0=;
        b=g66mSs4TruqL4OUFKpgYGyGaF40QnWZzUhavP2PAnrYyKwPmhU0OzuJu6IVUr7V7af
         +FWfSPyeloJ4loCJ/HYvM2gD4IqBkjvUXjAWMwpR48l5TOTh2uF4XBoMsmKVmFsMRKDK
         WjXqxnfuZxuJcgN3JSYS0Sd8yEiXUwPjftP94i/FDOlGqkA/LmTOzfCdSf6ugS7AnEHB
         WeK1Loah6VxA70qwvZB5WuwEqmJB3R1y4HJsR2Wm4syAmuIIn+q6eY2fKw6Hry2o0qsQ
         1P8rjU40B4MZmCK3Ou+EmnfRf3pRgoPEGrsknMnPVX2xkMjsa34iS0W9wV3c1B6f7mbj
         Sskg==
X-Gm-Message-State: ABy/qLbsdBqhbyUms15fjgF3+Q0GM+tEilvtag5tfV/c3P4PVG2aCy0T
        uFVDbR69eSGLkJ5N97NUE26TN4PxT9nxNnOgatWTuw==
X-Google-Smtp-Source: APBJJlGxj41y8JadUipaJMbbk/Taqrd8swi98DNSdlq+gU53/Isa8OIo8Aa18k5CCd/C8qSAMK9ruWFXbDeFdDC2xdQ=
X-Received: by 2002:a05:600c:1d18:b0:3fa:94ea:583c with SMTP id
 l24-20020a05600c1d1800b003fa94ea583cmr8101722wms.8.1689588516493; Mon, 17 Jul
 2023 03:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230712081616.45177-1-zhangpeng.00@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 Jul 2023 12:07:59 +0200
Message-ID: <CANpmjNOhNQuBZAgOKLv4+4UoFK1b_8PP0EzWzkuyyGE0bg+weg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: allocate kfence_metadata at runtime
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
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

On Wed, 12 Jul 2023 at 10:16, 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> kfence_metadata is currently a static array. For the purpose of
> allocating scalable __kfence_pool, we first change it to runtime
> allocation of metadata. Since the size of an object of kfence_metadata
> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
> without enabling kfence.
>
> Below is the numbers obtained in qemu (with default 256 objects).
> before: Memory: 8134692K/8388080K available (3668K bss)
> after: Memory: 8136740K/8388080K available (1620K bss)
> More than expected, it saves 2MB memory. It can be seen that the size
> of the .bss section has changed, possibly because it affects the linker.
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
> Changes since v1:
>  - Fix a stupid problem of not being able to initialize kfence. The problem is
>    that I slightly modified the patch before sending it out, but it has not been
>    tested. I'm extremely sorry.
>  - Drop kfence_alloc_metadata() and kfence_free_metadata() because they are no
>    longer reused.
>  - Allocate metadata from memblock during early initialization. Fixed the issue
>    of allocating metadata size that cannot exceed the limit of the buddy system
>    during early initialization.
>  - Fix potential UAF in kfence_shutdown_cache().
>
> v1: https://lore.kernel.org/lkml/20230710032714.26200-1-zhangpeng.00@bytedance.com/
>
>  include/linux/kfence.h |   5 +-
>  mm/kfence/core.c       | 124 ++++++++++++++++++++++++++++-------------
>  mm/kfence/kfence.h     |   5 +-
>  mm/mm_init.c           |   2 +-
>  4 files changed, 94 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 726857a4b680..68e71562bfa7 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -59,9 +59,10 @@ static __always_inline bool is_kfence_address(const void *addr)
>  }
>
>  /**
> - * kfence_alloc_pool() - allocate the KFENCE pool via memblock
> + * kfence_alloc_pool_and_metadata() - allocate the KFENCE pool and KFENCE
> + * metadata via memblock
>   */
> -void __init kfence_alloc_pool(void);
> +void __init kfence_alloc_pool_and_metadata(void);

You've renamed this, but not the stub later in the file. So this
currently breaks with !CONFIG_KFENCE.

Also, there's a reference in comments to kfence_alloc_pool(), please
update as well.

>  /**
>   * kfence_init() - perform KFENCE initialization at boot time
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index dad3c0eb70a0..ed0424950cf1 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -116,7 +116,16 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
>   * backing pages (in __kfence_pool).
>   */
>  static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
> -struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
> +struct kfence_metadata *kfence_metadata;

Add __read_mostly, like for __kfence_pool.

> +/*
> + * When kfence_metadata is not NULL, it may be that kfence is being initialized
> + * at this time, and it may be used by kfence_shutdown_cache() during
> + * initialization. If the initialization fails, kfence_metadata will be released,
> + * causing UAF. So it is necessary to add kfence_metadata_init for initialization,
> + * and kfence_metadata will be visible only when initialization is successful.
> + */
> +static struct kfence_metadata *kfence_metadata_init;

Also add __read_mostly.

>  /* Freelist with available objects. */
>  static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
> @@ -591,7 +600,7 @@ static unsigned long kfence_init_pool(void)
>
>                 __folio_set_slab(slab_folio(slab));
>  #ifdef CONFIG_MEMCG
> -               slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> +               slab->memcg_data = (unsigned long)&kfence_metadata_init[i / 2 - 1].objcg |
>                                    MEMCG_DATA_OBJCGS;
>  #endif
>         }
> @@ -610,7 +619,7 @@ static unsigned long kfence_init_pool(void)
>         }
>
>         for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> -               struct kfence_metadata *meta = &kfence_metadata[i];
> +               struct kfence_metadata *meta = &kfence_metadata_init[i];
>
>                 /* Initialize metadata. */
>                 INIT_LIST_HEAD(&meta->list);
> @@ -626,6 +635,12 @@ static unsigned long kfence_init_pool(void)
>                 addr += 2 * PAGE_SIZE;
>         }
>
> +       /*
> +        * Make kfence_metadata visible only when initialization is successful.
> +        * Otherwise, if the initialization fails and kfence_metadata is
> +        * freed, it may cause UAF in kfence_shutdown_cache().
> +        */
> +       kfence_metadata = kfence_metadata_init;

May cause _concurrent_ UAF, right? I assume so, at least with late init.

So in that case, this should be smp_store_release().

>         return 0;
>
>  reset_slab:
> @@ -672,26 +687,10 @@ static bool __init kfence_init_pool_early(void)
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
> @@ -841,19 +840,30 @@ static void toggle_allocation_gate(struct work_struct *work)
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
> @@ -895,33 +905,68 @@ void __init kfence_init(void)
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
> @@ -941,6 +986,9 @@ void kfence_shutdown_cache(struct kmem_cache *s)
>         struct kfence_metadata *meta;
>         int i;
>
> +       if (!kfence_metadata)
> +               return;

And this should be smp_load_acquire(&kfence_metadata), so that all the
metadata initialization is actually seen by concurrent
kfence_shutdown_cache / kfence_init_pool.

And add a comment something like:

  /* Pairs with release in kfence_init_pool(). */

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
> index a1963c3322af..86b26d013f4b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2778,7 +2778,7 @@ void __init mm_core_init(void)
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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230712081616.45177-1-zhangpeng.00%40bytedance.com.
