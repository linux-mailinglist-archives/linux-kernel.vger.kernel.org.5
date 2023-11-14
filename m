Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC37EB0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKNNhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjKNNg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:36:59 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26287D42
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:36:55 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7bb42a18bf1so1640699241.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699969014; x=1700573814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylLF0ezxv0p5B3lhnDvW84ZadVID6r9w9mm9HftD9ww=;
        b=CmlyIe45mBOhzr6cxweQsrVAngaYwlOOfCsgrdHFkmqDfUWQpQBYiwmBUIOxa7Ao4O
         iPBoIwgGn4BsqI0KNB5k+vJS2kHifLjRpC9wrRj9lspOCjPVX1aXL0ISxv1y9tbeTV2a
         2SKftASVQnd/b8kA17c8BmCY6ArmXqGRG6xcGqsCaicCnjte3ox9tWWlDw0ZLkwMVtGy
         4PN5NeLbIYYmyqyr95jKOfPLtcZq3FmEGDP23ltUI/b2MoOggV2TAryFISVTRKbUEsDb
         NhLXXmRBgBiKJBSwKGWKpZ+1FUdZ0sQVSqHxmaYrpp48MZqKRDY2vxPITpcCk6FGSP6H
         CSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969014; x=1700573814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylLF0ezxv0p5B3lhnDvW84ZadVID6r9w9mm9HftD9ww=;
        b=egUN1ql0pHj7O7XwfmYDrKKo0ECZ9InIaspAFLvN6PVG88/rgit5a621CzFBWBaf7d
         7Ojb+RO0Q3LxD31seN7ohTQCN6qEZAo3W6rzSJ2MO1b7nGbjMUvWv76p1pOautQGDM5n
         5pjf1bkv64LjAweTQo10i4kEs+7LHeJMe3XxCXCa2juQf4//rmbeqSrBdglA3RaDcpDG
         uxZrh6yyYjx/vMXryxR2es6gkfHX/INuBn88HgH5rNhpYouz/iAO1l0I/OtnRUjMLGYX
         GPKXQelD6/zC5Wga2+4lU/o3iLvDGW17aCgLGMXV3bm3dW/yR74AixSANDrLHYUSMNbp
         QCVQ==
X-Gm-Message-State: AOJu0Yylczq2s+C4TUmv8blCsQiiglSHYZ2jNH1AJ0pE07eoWm6KH80s
        MuzZHdLvesliffLEyYcLhYM25Qlqe5bO/2CiZ9vrVA==
X-Google-Smtp-Source: AGHT+IGFZcHbvcMLcTK6DmSeS+m2B545zTg40k1tpVHvU7teaggEx/CkU6cnqTK9MqTVK+4jOzK20HLcS6JwUxSlz9U=
X-Received: by 2002:a1f:9cd6:0:b0:4ab:cdf0:b2c7 with SMTP id
 f205-20020a1f9cd6000000b004abcdf0b2c7mr5133093vke.5.1699969013928; Tue, 14
 Nov 2023 05:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20231103212724.134597-1-andrey.konovalov@linux.dev>
In-Reply-To: <20231103212724.134597-1-andrey.konovalov@linux.dev>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Nov 2023 14:36:15 +0100
Message-ID: <CANpmjNMJJyiaEWKouY4jho-Qg1+i7eYSxdjn_vEPCbQ0AR9Sew@mail.gmail.com>
Subject: Re: [PATCH RFC] kasan: use stack_depot_put for Generic mode
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2023 at 22:27, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Evict alloc/free stack traces from the stack depot for Generic KASAN
> once they are evicted from the quaratine.
>
> For auxiliary stack traces, evict the oldest stack trace once a new one
> is saved (KASAN only keeps references to the last two).
>
> Also evict all save stack traces on krealloc.
>
> To avoid double-evicting and mis-evicting stack traces (in case KASAN's
> metadata was corrupted), reset KASAN's per-object metadata that stores
> stack depot handles when the object is initialized and when it's evicted
> from the quarantine.
>
> Note that stack_depot_put is no-op of the handle is 0.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Maybe mention the space and performance difference from your
experiments. As-is, it's a bit cryptic what the benefit is. I assume
this patch goes along with the other series.

> ---
>
> This goes on top of the "stackdepot: allow evicting stack traces" series.
> I'll mail the patches all together after the merge window.
> ---
>  mm/kasan/common.c     |  3 ++-
>  mm/kasan/generic.c    | 22 ++++++++++++++++++----
>  mm/kasan/quarantine.c | 26 ++++++++++++++++++++------
>  3 files changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 825a0240ec02..b5d8bd26fced 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -50,7 +50,8 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags)
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
>  {
>         track->pid = current->pid;
> -       track->stack = kasan_save_stack(flags, STACK_DEPOT_FLAG_CAN_ALLOC);
> +       track->stack = kasan_save_stack(flags,
> +                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
>  }
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 5d168c9afb32..50cc519e23f4 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -449,10 +449,14 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> +       struct kasan_free_meta *free_meta;
>
>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         if (alloc_meta)
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       free_meta = kasan_get_free_meta(cache, object);
> +       if (free_meta)
> +               __memset(free_meta, 0, sizeof(*free_meta));
>  }
>
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
> @@ -489,18 +493,20 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>         if (!alloc_meta)
>                 return;
>
> +       stack_depot_put(alloc_meta->aux_stack[1]);
>         alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
>         alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
>  }
>
>  void kasan_record_aux_stack(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
> +       return __kasan_record_aux_stack(addr,
> +                       STACK_DEPOT_FLAG_CAN_ALLOC | STACK_DEPOT_FLAG_GET);
>  }
>
>  void kasan_record_aux_stack_noalloc(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr, 0);
> +       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_GET);
>  }
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> @@ -508,8 +514,16 @@ void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>         struct kasan_alloc_meta *alloc_meta;
>
>         alloc_meta = kasan_get_alloc_meta(cache, object);
> -       if (alloc_meta)
> -               kasan_set_track(&alloc_meta->alloc_track, flags);
> +       if (!alloc_meta)
> +               return;
> +
> +       /* Evict previous stack traces (might exist for krealloc). */
> +       stack_depot_put(alloc_meta->alloc_track.stack);
> +       stack_depot_put(alloc_meta->aux_stack[0]);
> +       stack_depot_put(alloc_meta->aux_stack[1]);
> +       __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +
> +       kasan_set_track(&alloc_meta->alloc_track, flags);
>  }
>
>  void kasan_save_free_info(struct kmem_cache *cache, void *object)
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 152dca73f398..37fb0e3f5876 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -141,11 +141,22 @@ static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
>  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>  {
>         void *object = qlink_to_object(qlink, cache);
> -       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> +       struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
> +       struct kasan_free_meta *free_meta = kasan_get_free_meta(cache, object);
>         unsigned long flags;
>
> -       if (IS_ENABLED(CONFIG_SLAB))
> -               local_irq_save(flags);
> +       if (alloc_meta) {
> +               stack_depot_put(alloc_meta->alloc_track.stack);
> +               stack_depot_put(alloc_meta->aux_stack[0]);
> +               stack_depot_put(alloc_meta->aux_stack[1]);
> +               __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       }
> +
> +       if (free_meta &&
> +           *(u8 *)kasan_mem_to_shadow(object) == KASAN_SLAB_FREETRACK) {
> +               stack_depot_put(free_meta->free_track.stack);
> +               free_meta->free_track.stack = 0;
> +       }
>
>         /*
>          * If init_on_free is enabled and KASAN's free metadata is stored in
> @@ -155,14 +166,17 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>          */
>         if (slab_want_init_on_free(cache) &&
>             cache->kasan_info.free_meta_offset == 0)
> -               memzero_explicit(meta, sizeof(*meta));
> +               memzero_explicit(free_meta, sizeof(*free_meta));
>
>         /*
> -        * As the object now gets freed from the quarantine, assume that its
> -        * free track is no longer valid.
> +        * As the object now gets freed from the quarantine,
> +        * take note that its free track is no longer exists.
>          */
>         *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>
> +       if (IS_ENABLED(CONFIG_SLAB))
> +               local_irq_save(flags);
> +
>         ___cache_free(cache, object, _THIS_IP_);
>
>         if (IS_ENABLED(CONFIG_SLAB))
> --
> 2.25.1
>
