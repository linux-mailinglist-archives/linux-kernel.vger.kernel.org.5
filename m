Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609D57F3B07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjKVBJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKVBJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:09:47 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D51730
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:09:17 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b58d96a3bbso3638229b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700615356; x=1701220156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFUu9VYQOno00V0Z+W24X8uKsrmKACfQgy6rmcyLykA=;
        b=G9tJa08BvDJXkLwv8Wa9BzVM3JKLdsywCpTxdvLUp+o3wVkglx3QKtPuK8WvQ9p7aB
         rF87ZrVfgjRlHPGBx8mt34o8HINsljQU91EJijg5HuTFsrIxhK8TiuA8UckkRY3/+I5M
         1g1wKi7w44kT39ZL9AvWdPdlGEvEKBDdykWUK0VIALF6+OmU9isoG+sgYbHGxYkvGQpU
         9BziTT5Gp6SKb9yYH5aGn4xa+5W9MbWg38LFFZNRBIgJZy6JEbCtU+pMK43tstAmxzx4
         2nQE5a93QkCYbDe9PdiKSv2TSYNZF4pqcEfuwtO8Gselwus2wXSyrfFALXWyVLL2U/Rl
         vzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615356; x=1701220156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFUu9VYQOno00V0Z+W24X8uKsrmKACfQgy6rmcyLykA=;
        b=ICkd6Y/qSXOfXbezIpOKqoVO6xTbxFZ2XqQA6McPtTAbTMsDk4+C7+SkdXaqWrAJhI
         PDYSPI80nzjHInXlT26C7JfXt6D+Z2fYts31Q0xi0kxoudoYJu10sqBTh4wxiWoWgmEE
         PUhHmuEN/o87lcl27EHyZYucEQ1S+5HrRwaifKad/X8fqL7x8rcWhvICkFzOF5ERW/6J
         OmkMAyYLjptS2lHxXYOLU0FdbRuWqaSiRBSCSQeilHKG18P4nh9qicpWfpV2y3zhTzdD
         rBy1zawsdL0Bc92KgxvCqKn6jR2PH/W3J+jhFo8xcCnJh1PxLjLC+DBkFC6ZygTd6DUf
         gq5A==
X-Gm-Message-State: AOJu0YzRjqRtlkrukCvskIu18VJGBsRC8Cky9em14UcnVs4bdK03V+cJ
        Z8qOWdqv/sAqJgX9Y7yLVIvHEbfDgrCJRC4hb48=
X-Google-Smtp-Source: AGHT+IFT1DG0nvQuvae20Tsdfe3wdPTyTnvsaMyMUJM6vv3DN1rl3YiKjY3GnJFtGsW+7xN91fGzdgelUT2eRT2OcdY=
X-Received: by 2002:a05:6358:927:b0:16b:fd1c:fdba with SMTP id
 r39-20020a056358092700b0016bfd1cfdbamr879293rwi.27.1700615356263; Tue, 21 Nov
 2023 17:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-3-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-3-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Wed, 22 Nov 2023 10:09:04 +0900
Message-ID: <CAB=+i9RNC5vvVDNdzPB6nTuSE0xL7JVSQLO=O4BonW4S2DGcnw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] slub: Change get_partial() interfaces to return slab
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
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:24=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> We need all get_partial() related interfaces to return a slab, instead
> of returning the freelist (or object).
>
> Use the partial_context.object to return back freelist or object for
> now. This patch shouldn't have any functional changes.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 63 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 0b0fdc8c189f..03384cd965c5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -204,9 +204,9 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
>
>  /* Structure holding parameters for get_partial() call chain */
>  struct partial_context {
> -       struct slab **slab;
>         gfp_t flags;
>         unsigned int orig_size;
> +       void *object;
>  };
>
>  static inline bool kmem_cache_debug(struct kmem_cache *s)
> @@ -2269,10 +2269,11 @@ static inline bool pfmemalloc_match(struct slab *=
slab, gfp_t gfpflags);
>  /*
>   * Try to allocate a partial slab from a specific node.
>   */
> -static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_no=
de *n,
> -                             struct partial_context *pc)
> +static struct slab *get_partial_node(struct kmem_cache *s,
> +                                    struct kmem_cache_node *n,
> +                                    struct partial_context *pc)
>  {
> -       struct slab *slab, *slab2;
> +       struct slab *slab, *slab2, *partial =3D NULL;
>         void *object =3D NULL;
>         unsigned long flags;
>         unsigned int partial_slabs =3D 0;
> @@ -2288,27 +2289,28 @@ static void *get_partial_node(struct kmem_cache *=
s, struct kmem_cache_node *n,
>
>         spin_lock_irqsave(&n->list_lock, flags);
>         list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> -               void *t;
> -
>                 if (!pfmemalloc_match(slab, pc->flags))
>                         continue;
>
>                 if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) =
{
>                         object =3D alloc_single_from_partial(s, n, slab,
>                                                         pc->orig_size);
> -                       if (object)
> +                       if (object) {
> +                               partial =3D slab;
> +                               pc->object =3D object;
>                                 break;
> +                       }
>                         continue;
>                 }
>
> -               t =3D acquire_slab(s, n, slab, object =3D=3D NULL);
> -               if (!t)
> +               object =3D acquire_slab(s, n, slab, object =3D=3D NULL);
> +               if (!object)
>                         break;
>
> -               if (!object) {
> -                       *pc->slab =3D slab;
> +               if (!partial) {
> +                       partial =3D slab;
> +                       pc->object =3D object;
>                         stat(s, ALLOC_FROM_PARTIAL);
> -                       object =3D t;
>                 } else {
>                         put_cpu_partial(s, slab, 0);
>                         stat(s, CPU_PARTIAL_NODE);
> @@ -2324,20 +2326,21 @@ static void *get_partial_node(struct kmem_cache *=
s, struct kmem_cache_node *n,
>
>         }
>         spin_unlock_irqrestore(&n->list_lock, flags);
> -       return object;
> +       return partial;
>  }
>
>  /*
>   * Get a slab from somewhere. Search in increasing NUMA distances.
>   */
> -static void *get_any_partial(struct kmem_cache *s, struct partial_contex=
t *pc)
> +static struct slab *get_any_partial(struct kmem_cache *s,
> +                                   struct partial_context *pc)
>  {
>  #ifdef CONFIG_NUMA
>         struct zonelist *zonelist;
>         struct zoneref *z;
>         struct zone *zone;
>         enum zone_type highest_zoneidx =3D gfp_zone(pc->flags);
> -       void *object;
> +       struct slab *slab;
>         unsigned int cpuset_mems_cookie;
>
>         /*
> @@ -2372,8 +2375,8 @@ static void *get_any_partial(struct kmem_cache *s, =
struct partial_context *pc)
>
>                         if (n && cpuset_zone_allowed(zone, pc->flags) &&
>                                         n->nr_partial > s->min_partial) {
> -                               object =3D get_partial_node(s, n, pc);
> -                               if (object) {
> +                               slab =3D get_partial_node(s, n, pc);
> +                               if (slab) {
>                                         /*
>                                          * Don't check read_mems_allowed_=
retry()
>                                          * here - if mems_allowed was upd=
ated in
> @@ -2381,7 +2384,7 @@ static void *get_any_partial(struct kmem_cache *s, =
struct partial_context *pc)
>                                          * between allocation and the cpu=
set
>                                          * update
>                                          */
> -                                       return object;
> +                                       return slab;
>                                 }
>                         }
>                 }
> @@ -2393,17 +2396,18 @@ static void *get_any_partial(struct kmem_cache *s=
, struct partial_context *pc)
>  /*
>   * Get a partial slab, lock it and return it.
>   */
> -static void *get_partial(struct kmem_cache *s, int node, struct partial_=
context *pc)
> +static struct slab *get_partial(struct kmem_cache *s, int node,
> +                               struct partial_context *pc)
>  {
> -       void *object;
> +       struct slab *slab;
>         int searchnode =3D node;
>
>         if (node =3D=3D NUMA_NO_NODE)
>                 searchnode =3D numa_mem_id();
>
> -       object =3D get_partial_node(s, get_node(s, searchnode), pc);
> -       if (object || node !=3D NUMA_NO_NODE)
> -               return object;
> +       slab =3D get_partial_node(s, get_node(s, searchnode), pc);
> +       if (slab || node !=3D NUMA_NO_NODE)
> +               return slab;
>
>         return get_any_partial(s, pc);
>  }
> @@ -3213,10 +3217,10 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>  new_objects:
>
>         pc.flags =3D gfpflags;
> -       pc.slab =3D &slab;
>         pc.orig_size =3D orig_size;
> -       freelist =3D get_partial(s, node, &pc);
> -       if (freelist) {
> +       slab =3D get_partial(s, node, &pc);
> +       if (slab) {
> +               freelist =3D pc.object;
>                 if (kmem_cache_debug(s)) {
>                         /*
>                          * For debug caches here we had to go through
> @@ -3408,12 +3412,11 @@ static void *__slab_alloc_node(struct kmem_cache =
*s,
>         void *object;
>
>         pc.flags =3D gfpflags;
> -       pc.slab =3D &slab;
>         pc.orig_size =3D orig_size;
> -       object =3D get_partial(s, node, &pc);
> +       slab =3D get_partial(s, node, &pc);
>
> -       if (object)
> -               return object;
> +       if (slab)
> +               return pc.object;
>
>         slab =3D new_slab(s, gfpflags, node);
>         if (unlikely(!slab)) {

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
