Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06A802168
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjLCGxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjLCGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:53:37 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E89107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:53:32 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4647ee28abeso159905137.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 22:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701586412; x=1702191212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5X4nM4F8oU4+mEy0o6zjiFJGF70n9/7GLXA805ymyQ=;
        b=gFXJyX5VKdHXca8CeYu8kBfRHI7ga94JKDQHSPI9HOYN8zchKHbd67WLKxMezbp8n4
         XeQ/teSkD2/DGZQiZ2/iOSANF3UU4BPDoPaPiAwdL3hrFugoVPUQX4UTlKKCk2Ed/bBq
         1NUX3/GSnAfp+/G29axvopJmyJv+Gwa6sIlAYnn0yaB15QYLIaD6jFVSEhmT10n3SUbm
         4tc8FGyzzUf4jVMhvMJKqxHVIVLiBhUIHdD6xnTWIYKqf37zHD43XPB951LnYnFOEYK3
         dEONiqQtY62GoNHJYEy3zU6Zj2JBFoMCq/1EppClFaO8CQSzuAYASmgdeZ9jhswBa6Js
         Za9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701586412; x=1702191212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5X4nM4F8oU4+mEy0o6zjiFJGF70n9/7GLXA805ymyQ=;
        b=d8Y/jSUBZyNfcc5qYO8On+30sJhUKskIGBXh87Xc+a1h0EuOQdBcjl9BWp68GlMcfZ
         SGKbv/r/m9JQu2swVtRYoWtcCpvp0YwBREX2LPEHDJwOjNtdfQUw8k5X7/Vizysyj1Br
         1nol/EmAXKRPdcjyxv/9ohV3R6cToPXic+bnYGCFwjVamB0u0J8us1HhotJa85qz63aq
         3KLYwyIG90czcJPCYCSt2czsf7pJsSvY/cIKEOUfenzpNYTtoKu2Pg5Bc98HZEKb9OBm
         VSyB8K+VJ/l3WEWhxc6OwOlWjrM26rAsPylzq2xlLsK6/wUXo30Q2nd9z2TsKr9kboU0
         +/cw==
X-Gm-Message-State: AOJu0Yy98Lg5sS6R0jZXySYtyfudGsKmBON/tW/bQcRN6qEKHhb2H6Uy
        B3ADhoun62L/i8KtZ8hYpwKV4r6JtZInOnSUaw0=
X-Google-Smtp-Source: AGHT+IFbN2sLxI2zbfVSLs0YHG1qR0k3sdKfgNXqxwgJShIZavcYKV+U9gdOAktmxdW6yBPyo4TWlCTJhrfLGZJ6B04=
X-Received: by 2002:a05:6102:411:b0:464:4746:c48b with SMTP id
 d17-20020a056102041100b004644746c48bmr649728vsq.27.1701586411817; Sat, 02 Dec
 2023 22:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-7-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-7-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 15:53:19 +0900
Message-ID: <CAB=+i9TK-_WcmQLVV5BTvngfTfTZra0Xi-XZ2m8JGbamwWDuoA@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] slub: Delay freezing of partial slabs
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:25=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> Now we will freeze slabs when moving them out of node partial list to
> cpu partial list, this method needs two cmpxchg_double operations:
>
> 1. freeze slab (acquire_slab()) under the node list_lock
> 2. get_freelist() when pick used in ___slab_alloc()
>
> Actually we don't need to freeze when moving slabs out of node partial
> list, we can delay freezing to when use slab freelist in ___slab_alloc(),
> so we can save one cmpxchg_double().
>
> And there are other good points:
>  - The moving of slabs between node partial list and cpu partial list
>    becomes simpler, since we don't need to freeze or unfreeze at all.
>
>  - The node list_lock contention would be less, since we don't need to
>    freeze any slab under the node list_lock.
>
> We can achieve this because there is no concurrent path would manipulate
> the partial slab list except the __slab_free() path, which is now
> serialized by slab_test_node_partial() under the list_lock.
>
> Since the slab returned by get_partial() interfaces is not frozen anymore
> and no freelist is returned in the partial_context, so we need to use the
> introduced freeze_slab() to freeze it and get its freelist.
>
> Similarly, the slabs on the CPU partial list are not frozen anymore,
> we need to freeze_slab() on it before use.
>
> We can now delete acquire_slab() as it became unused.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 113 +++++++++++-------------------------------------------
>  1 file changed, 23 insertions(+), 90 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index edf567971679..bcb5b2c4e213 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2234,51 +2234,6 @@ static void *alloc_single_from_new_slab(struct kme=
m_cache *s,
>         return object;
>  }
>
> -/*
> - * Remove slab from the partial list, freeze it and
> - * return the pointer to the freelist.
> - *
> - * Returns a list of objects or NULL if it fails.
> - */
> -static inline void *acquire_slab(struct kmem_cache *s,
> -               struct kmem_cache_node *n, struct slab *slab,
> -               int mode)

Nit: alloc_single_from_partial()'s comment still refers to acquire_slab().

> -{
> -       void *freelist;
> -       unsigned long counters;
> -       struct slab new;
> -
> -       lockdep_assert_held(&n->list_lock);
> -
> -       /*
> -        * Zap the freelist and set the frozen bit.
> -        * The old freelist is the list of objects for the
> -        * per cpu allocation list.
> -        */
> -       freelist =3D slab->freelist;
> -       counters =3D slab->counters;
> -       new.counters =3D counters;
> -       if (mode) {
> -               new.inuse =3D slab->objects;
> -               new.freelist =3D NULL;
> -       } else {
> -               new.freelist =3D freelist;
> -       }
> -
> -       VM_BUG_ON(new.frozen);
> -       new.frozen =3D 1;
> -
> -       if (!__slab_update_freelist(s, slab,
> -                       freelist, counters,
> -                       new.freelist, new.counters,
> -                       "acquire_slab"))
> -               return NULL;
> -
> -       remove_partial(n, slab);
> -       WARN_ON(!freelist);
> -       return freelist;
> -}
> -
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int=
 drain);
>  #else
> @@ -2295,7 +2250,6 @@ static struct slab *get_partial_node(struct kmem_ca=
che *s,
>                                      struct partial_context *pc)
>  {
>         struct slab *slab, *slab2, *partial =3D NULL;
> -       void *object =3D NULL;
>         unsigned long flags;
>         unsigned int partial_slabs =3D 0;
>
> @@ -2314,7 +2268,7 @@ static struct slab *get_partial_node(struct kmem_ca=
che *s,
>                         continue;
>
>                 if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) =
{
> -                       object =3D alloc_single_from_partial(s, n, slab,
> +                       void *object =3D alloc_single_from_partial(s, n, =
slab,
>                                                         pc->orig_size);
>                         if (object) {
>                                 partial =3D slab;
> @@ -2324,13 +2278,10 @@ static struct slab *get_partial_node(struct kmem_=
cache *s,
>                         continue;
>                 }
>
> -               object =3D acquire_slab(s, n, slab, object =3D=3D NULL);
> -               if (!object)
> -                       break;
> +               remove_partial(n, slab);
>
>                 if (!partial) {
>                         partial =3D slab;
> -                       pc->object =3D object;
>                         stat(s, ALLOC_FROM_PARTIAL);
>                 } else {
>                         put_cpu_partial(s, slab, 0);
> @@ -2629,9 +2580,6 @@ static void __unfreeze_partials(struct kmem_cache *=
s, struct slab *partial_slab)
>         unsigned long flags =3D 0;
>
>         while (partial_slab) {
> -               struct slab new;
> -               struct slab old;
> -
>                 slab =3D partial_slab;
>                 partial_slab =3D slab->next;
>
> @@ -2644,23 +2592,7 @@ static void __unfreeze_partials(struct kmem_cache =
*s, struct slab *partial_slab)
>                         spin_lock_irqsave(&n->list_lock, flags);
>                 }
>
> -               do {
> -
> -                       old.freelist =3D slab->freelist;
> -                       old.counters =3D slab->counters;
> -                       VM_BUG_ON(!old.frozen);
> -
> -                       new.counters =3D old.counters;
> -                       new.freelist =3D old.freelist;
> -
> -                       new.frozen =3D 0;
> -
> -               } while (!__slab_update_freelist(s, slab,
> -                               old.freelist, old.counters,
> -                               new.freelist, new.counters,
> -                               "unfreezing slab"));
> -
> -               if (unlikely(!new.inuse && n->nr_partial >=3D s->min_part=
ial)) {
> +               if (unlikely(!slab->inuse && n->nr_partial >=3D s->min_pa=
rtial)) {
>                         slab->next =3D slab_to_discard;
>                         slab_to_discard =3D slab;
>                 } else {
> @@ -3167,7 +3099,6 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>                         node =3D NUMA_NO_NODE;
>                 goto new_slab;
>         }
> -redo:
>
>         if (unlikely(!node_match(slab, node))) {
>                 /*
> @@ -3243,7 +3174,8 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>
>  new_slab:
>
> -       if (slub_percpu_partial(c)) {
> +#ifdef CONFIG_SLUB_CPU_PARTIAL
> +       while (slub_percpu_partial(c)) {
>                 local_lock_irqsave(&s->cpu_slab->lock, flags);
>                 if (unlikely(c->slab)) {
>                         local_unlock_irqrestore(&s->cpu_slab->lock, flags=
);
> @@ -3255,12 +3187,22 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>                         goto new_objects;
>                 }
>
> -               slab =3D c->slab =3D slub_percpu_partial(c);
> +               slab =3D slub_percpu_partial(c);
>                 slub_set_percpu_partial(c, slab);
>                 local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>                 stat(s, CPU_PARTIAL_ALLOC);
> -               goto redo;
> +
> +               if (unlikely(!node_match(slab, node) ||
> +                            !pfmemalloc_match(slab, gfpflags))) {
> +                       slab->next =3D NULL;
> +                       __unfreeze_partials(s, slab);
> +                       continue;
> +               }
> +
> +               freelist =3D freeze_slab(s, slab);
> +               goto retry_load_slab;
>         }
> +#endif
>
>  new_objects:
>
> @@ -3268,8 +3210,8 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>         pc.orig_size =3D orig_size;
>         slab =3D get_partial(s, node, &pc);
>         if (slab) {
> -               freelist =3D pc.object;
>                 if (kmem_cache_debug(s)) {
> +                       freelist =3D pc.object;
>                         /*
>                          * For debug caches here we had to go through
>                          * alloc_single_from_partial() so just store the
> @@ -3281,6 +3223,7 @@ static void *___slab_alloc(struct kmem_cache *s, gf=
p_t gfpflags, int node,
>                         return freelist;
>                 }
>
> +               freelist =3D freeze_slab(s, slab);
>                 goto retry_load_slab;
>         }
>
> @@ -3682,18 +3625,8 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>                 was_frozen =3D new.frozen;
>                 new.inuse -=3D cnt;
>                 if ((!new.inuse || !prior) && !was_frozen) {
> -
> -                       if (kmem_cache_has_cpu_partial(s) && !prior) {
> -
> -                               /*
> -                                * Slab was on no list before and will be
> -                                * partially empty
> -                                * We can defer the list move and instead
> -                                * freeze it.
> -                                */
> -                               new.frozen =3D 1;
> -
> -                       } else { /* Needs to be taken off a list */
> +                       /* Needs to be taken off a list */
> +                       if (!kmem_cache_has_cpu_partial(s) || prior) {
>
>                                 n =3D get_node(s, slab_nid(slab));
>                                 /*
> @@ -3723,9 +3656,9 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>                          * activity can be necessary.
>                          */
>                         stat(s, FREE_FROZEN);
> -               } else if (new.frozen) {
> +               } else if (kmem_cache_has_cpu_partial(s) && !prior) {
>                         /*
> -                        * If we just froze the slab then put it onto the
> +                        * If we started with a full slab then put it ont=
o the
>                          * per cpu partial list.
>                          */
>                         put_cpu_partial(s, slab, 1);
> --

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> 2.20.1
>
