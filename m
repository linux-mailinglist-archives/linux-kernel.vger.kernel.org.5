Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F97EAF98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKNMBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjKNMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:01:31 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCF2126
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:01:28 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-4ac3083ca04so2531456e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699963287; x=1700568087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+cNKD/DZD2lkmgn//C/a4VZOCUEay1a0fxR4tTnP1Y=;
        b=hGCuizFkQJDvUZM8SlED/YrkZ5wzev7JTsJNC93J48EK6Gp4Y3AzhWfaaxAH6jgEfH
         FNcYFV+Uxmy4UGcqI5zf3qVeEvCnSLWmrluJM/cFkp3FXxgutjX7jujp2Oh1Vw3JPfr3
         MneCNJ9tzqysS3x0E3V8yI0eSamvHgMKj/tUpoaUpWgfbnW2OkKpChN0zJhc25ilO7B6
         AuJvYc5wEFWZeEU1XDMYMawMxhbnbKPcv1MnqRD9cS/osoqIrbxc0JgYMy8U07q3Jf0p
         ezzTSI+rSKp5wmuD1Q4Bf7VNwhdJ+AWLhBHrLcA/8c3adlxqlp1GxSUBJJlK27/vgoPM
         Ad7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699963287; x=1700568087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+cNKD/DZD2lkmgn//C/a4VZOCUEay1a0fxR4tTnP1Y=;
        b=FdtrHGdB/ndkFsttTzl7A7Hs7YSB2AXAr7dAkw83UZl27SsorSHlTWWV0XVEo6KN8W
         a39/E83U1451W4kwDORdQ9xiNWcbo/q8Iozbo2S5+ooxJ9YPK0DjGsRSNmGjFTQfDWAK
         6doKFq4QHSe2PFRjWoyM847DFrFE6xO1ukbDz0PWJzQSLzjQUrMgv2SAbf5q+lqLTr8c
         R1YIjdXX0DiyEIhMLumQ+jqxJp8tpKr6pjQ/WcdUz+pEZ7ZzhcBOg6IkE+hC41eZSDJQ
         vgp8A36zZbzvUZp+CKq9QfFyGPtnV6LdRjUCisZohFgqIXT625Q4JT1fPH0Mz7dTbtKu
         RAfA==
X-Gm-Message-State: AOJu0YxBFkaiBXgXedQZhGM7RzxMKdoRf0Ej0wA5jek8pT0KqUSBTR9x
        VGmKIA8wPs5jRzlWfv50ilca/3zyfRBqi1EZmIRMZg==
X-Google-Smtp-Source: AGHT+IGdPTgrNucIG+Lo6vRM+7FUzSZPC0zMXelLtqwy0mDzkjNg/l2YT2+nTW9YrVKzffzwqrRySMvvW/+/It1UJuA=
X-Received: by 2002:a05:6122:1689:b0:4ac:593b:e9f4 with SMTP id
 9-20020a056122168900b004ac593be9f4mr9715321vkl.9.1699963287127; Tue, 14 Nov
 2023 04:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-24-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-24-vbabka@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Nov 2023 13:00:00 +0100
Message-ID: <CANpmjNOy+K_jBkaZ9_+He9tT83PaYLama517YvQ1TH13ayg3vg@mail.gmail.com>
Subject: Re: [PATCH 02/20] KASAN: remove code paths guarded by CONFIG_SLAB
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
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

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c     | 13 ++-----------
>  mm/kasan/kasan.h      |  3 +--
>  mm/kasan/quarantine.c |  7 -------
>  3 files changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 256930da578a..5d95219e69d7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>   * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
>   *    accessed after being freed. We preassign tags for objects in these
>   *    caches as well.
> - * 3. For SLAB allocator we can't preassign tags randomly since the freelist
> - *    is stored as an array of indexes instead of a linked list. Assign tags
> - *    based on objects indexes, so that objects that are next to each other
> - *    get different tags.
>   */
>  static inline u8 assign_tag(struct kmem_cache *cache,
>                                         const void *object, bool init)
> @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>         if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>
> -       /* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
> -#ifdef CONFIG_SLAB
> -       /* For SLAB assign tags based on the object index in the freelist. */
> -       return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
> -#else
>         /*
> -        * For SLUB assign a random tag during slab creation, otherwise reuse
> +        * For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU,
> +        * assign a random tag during slab creation, otherwise reuse
>          * the already assigned tag.
>          */
>         return init ? kasan_random_tag() : get_tag(object);
> -#endif
>  }
>
>  void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8b06bab5c406..eef50233640a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags);
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>  void kasan_save_free_info(struct kmem_cache *cache, void *object);
>
> -#if defined(CONFIG_KASAN_GENERIC) && \
> -       (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> +#ifdef CONFIG_KASAN_GENERIC
>  bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
>  void kasan_quarantine_reduce(void);
>  void kasan_quarantine_remove_cache(struct kmem_cache *cache);
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index ca4529156735..138c57b836f2 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>  {
>         void *object = qlink_to_object(qlink, cache);
>         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> -       unsigned long flags;
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_save(flags);
>
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored in
> @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>
>         ___cache_free(cache, object, _THIS_IP_);
> -
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_restore(flags);
>  }
>
>  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
> --
> 2.42.1
>
