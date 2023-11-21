Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4623B7F2819
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjKUIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:54:52 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E99795;
        Tue, 21 Nov 2023 00:54:48 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45da062101bso1850428137.2;
        Tue, 21 Nov 2023 00:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700556887; x=1701161687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QLs44ZYfikKflEsGu3/LjCRwKrWuU/zW4Qq8PcgIOs=;
        b=HlAaGf5kdy4u/L+VB3ahmFZO8K+GSrs6K4Nf4wHQpHEmSbBjJmI7vqG4bdp/s0ROBo
         8e+8FkxwQ9QaIu3fOuHbT+Q5POhiJj6I3OfCuRdQ7nmvoIz8EhEzk+BN3cA08GsJixR0
         W+z15MtiDpZZCHLkIwOHSxH4lqKK3XIQYkkMQl9GsRSWwRBD4I4Ixr9o9vVvL/sh6Mx1
         4DC1y6guAWx3lqyQ4OxNqEKK7J8Nm/M/V3Gw0MOUy5hkT6bk87XZeR7XtLhH1gmm5zbc
         YYxpY9MDkDRUiKceZ1U3Cm1+/hWE+dbVY/N1awWBrdAyx/YTA85KIwQ2iQIm6aNy7SDY
         WzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700556887; x=1701161687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QLs44ZYfikKflEsGu3/LjCRwKrWuU/zW4Qq8PcgIOs=;
        b=BJpWBubgtkR6aeNFBsBgYvkrNm53uqFOheBiyxsi7Dg+0t0xRmgXWQ5rFeXyyQ9fl/
         2bQYRF2ZwbMBc3bDBBbGL6sarFOdzU98D6Lqf2D3ry2VhigVwlMkErcHmzgqtfOnMcV0
         NOoGuxRoIAARNK8afgwPfRVQmIyh4GeIGwOATCDEPLiFbxHmGtYlnLIGowXCYkQigU1k
         fFotl0lflpbBr/R7NqiyJSm+HKB4efIQxaSgfDMnrp1QWirlI3Fqzrd25cF7pdPeGh4P
         RA1yTOvKlNiUnMP7oafpedOeE0ToIpVNjV71mkupGmekPeYkbmQc3QhSCA8QRMv46ZJW
         mLhw==
X-Gm-Message-State: AOJu0YxVdxp353AcBst23RFlXfGUSfncQP/hzW2hhsTaerGL31Ap+Tzb
        2Nqe7+H61k248OtM2jTuv2bgT8B4go82idYcloY=
X-Google-Smtp-Source: AGHT+IHvKvtNElxV6l2/0QrTgPeTdb5xUNcFO1zWzTkpB2f18bCYzj/+mcWlU1gk0ASyfwwpUGB/OmWVzmxJqJ/XATs=
X-Received: by 2002:a05:6102:2086:b0:462:9f1d:258b with SMTP id
 h6-20020a056102208600b004629f1d258bmr5812196vsr.28.1700556887486; Tue, 21 Nov
 2023 00:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20231120091214.150502-1-sxwjean@me.com> <20231120091214.150502-5-sxwjean@me.com>
In-Reply-To: <20231120091214.150502-5-sxwjean@me.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 21 Nov 2023 17:54:36 +0900
Message-ID: <CAB=+i9RFxqFg2jz3ULbmmswqp0K7SK8O9Uv1=wpUZMQUtSGB1Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/slab: move slab merge from slab_common.c to slub.c
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 20, 2023 at 6:13=E2=80=AFPM <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <xiongwei.song@windriver.com>
>
> Since slab allocator has been removed. There is no users about slab
> merge except slub. This commit is almost to revert
> commit 423c929cbbec ("mm/slab_common: commonize slab merge logic").
>
> Also change all prefix of slab merge related functions, variables and
> definitions from "slab/SLAB" to"slub/SLUB".

Could you please elaborate a little bit?
I am not sure if I understand what the last two patches of this series
are useful for.

- Why rename variable/function/macro names?
- Why move merge related functions from slab_common.c to slub.c?
  (I mean merging slab_common.c and slub.c into single file might make sens=
e
   but why move only some parts of one into the other?)

> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slab.h        |   3 --
>  mm/slab_common.c |  98 ----------------------------------------------
>  mm/slub.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 99 insertions(+), 102 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 8d20f8c6269d..cd52e705ce28 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -429,9 +429,6 @@ extern void create_boot_cache(struct kmem_cache *, co=
nst char *name,
>
>  unsigned int calculate_alignment(slab_flags_t flags,
>                 unsigned int align, unsigned int size);
> -int slab_unmergeable(struct kmem_cache *s);
> -struct kmem_cache *find_mergeable(unsigned size, unsigned align,
> -               slab_flags_t flags, const char *name, void (*ctor)(void *=
));
>  struct kmem_cache *
>  __kmem_cache_alias(const char *name, unsigned int size, unsigned int ali=
gn,
>                    slab_flags_t flags, void (*ctor)(void *));
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 62eb77fdedf2..6960ae5c35ee 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -45,36 +45,6 @@ static void slab_caches_to_rcu_destroy_workfn(struct w=
ork_struct *work);
>  static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>                     slab_caches_to_rcu_destroy_workfn);
>
> -/*
> - * Set of flags that will prevent slab merging
> - */
> -#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
> -               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
> -
> -#define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> -                        SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> -
> -/*
> - * Merge control. If this is set then no merging of slab caches will occ=
ur.
> - */
> -static bool slub_nomerge =3D !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);
> -
> -static int __init setup_slab_nomerge(char *str)
> -{
> -       slub_nomerge =3D true;
> -       return 1;
> -}
> -
> -static int __init setup_slab_merge(char *str)
> -{
> -       slub_nomerge =3D false;
> -       return 1;
> -}
> -
> -__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
> -__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
> -
>  /*
>   * Determine the size of a slab object
>   */
> @@ -130,74 +100,6 @@ unsigned int calculate_alignment(slab_flags_t flags,
>         return ALIGN(align, sizeof(void *));
>  }
>
> -/*
> - * Find a mergeable slab cache
> - */
> -int slab_unmergeable(struct kmem_cache *s)
> -{
> -       if (slub_nomerge || (s->flags & SLAB_NEVER_MERGE))
> -               return 1;
> -
> -       if (s->ctor)
> -               return 1;
> -
> -#ifdef CONFIG_HARDENED_USERCOPY
> -       if (s->usersize)
> -               return 1;
> -#endif
> -
> -       /*
> -        * We may have set a slab to be unmergeable during bootstrap.
> -        */
> -       if (s->refcount < 0)
> -               return 1;
> -
> -       return 0;
> -}
> -
> -struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
> -               slab_flags_t flags, const char *name, void (*ctor)(void *=
))
> -{
> -       struct kmem_cache *s;
> -
> -       if (slub_nomerge)
> -               return NULL;
> -
> -       if (ctor)
> -               return NULL;
> -
> -       size =3D ALIGN(size, sizeof(void *));
> -       align =3D calculate_alignment(flags, align, size);
> -       size =3D ALIGN(size, align);
> -       flags =3D kmem_cache_flags(size, flags, name);
> -
> -       if (flags & SLAB_NEVER_MERGE)
> -               return NULL;
> -
> -       list_for_each_entry_reverse(s, &slab_caches, list) {
> -               if (slab_unmergeable(s))
> -                       continue;
> -
> -               if (size > s->size)
> -                       continue;
> -
> -               if ((flags & SLAB_MERGE_SAME) !=3D (s->flags & SLAB_MERGE=
_SAME))
> -                       continue;
> -               /*
> -                * Check if alignment is compatible.
> -                * Courtesy of Adrian Drzewiecki
> -                */
> -               if ((s->size & ~(align - 1)) !=3D s->size)
> -                       continue;
> -
> -               if (s->size - size >=3D sizeof(void *))
> -                       continue;
> -
> -               return s;
> -       }
> -       return NULL;
> -}
> -
>  static struct kmem_cache *create_cache(const char *name,
>                 unsigned int object_size, unsigned int align,
>                 slab_flags_t flags, unsigned int useroffset,
> diff --git a/mm/slub.c b/mm/slub.c
> index ae1e6e635253..435d9ed140e4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -709,6 +709,104 @@ static inline bool slab_update_freelist(struct kmem=
_cache *s, struct slab *slab,
>         return false;
>  }
>
> +/*
> + * Set of flags that will prevent slab merging
> + */
> +#define SLUB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER =
| \
> +               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> +               SLAB_FAILSLAB | SLAB_NO_MERGE | kasan_never_merge())
> +
> +#define SLUB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> +                        SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> +
> +/*
> + * Merge control. If this is set then no merging of slab caches will occ=
ur.
> + */
> +static bool slub_nomerge =3D !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);
> +
> +static int __init setup_slub_nomerge(char *str)
> +{
> +       slub_nomerge =3D true;
> +       return 1;
> +}
> +
> +static int __init setup_slub_merge(char *str)
> +{
> +       slub_nomerge =3D false;
> +       return 1;
> +}
> +
> +__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
> +__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
> +
> +/*
> + * Find a mergeable slab cache
> + */
> +static inline int slub_unmergeable(struct kmem_cache *s)
> +{
> +       if (slub_nomerge || (s->flags & SLUB_NEVER_MERGE))
> +               return 1;
> +
> +       if (s->ctor)
> +               return 1;
> +
> +#ifdef CONFIG_HARDENED_USERCOPY
> +       if (s->usersize)
> +               return 1;
> +#endif
> +
> +       /*
> +        * We may have set a slab to be unmergeable during bootstrap.
> +        */
> +       if (s->refcount < 0)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static struct kmem_cache *find_mergeable(unsigned int size, unsigned int=
 align,
> +               slab_flags_t flags, const char *name, void (*ctor)(void *=
))
> +{
> +       struct kmem_cache *s;
> +
> +       if (slub_nomerge)
> +               return NULL;
> +
> +       if (ctor)
> +               return NULL;
> +
> +       size =3D ALIGN(size, sizeof(void *));
> +       align =3D calculate_alignment(flags, align, size);
> +       size =3D ALIGN(size, align);
> +       flags =3D kmem_cache_flags(size, flags, name);
> +
> +       if (flags & SLUB_NEVER_MERGE)
> +               return NULL;
> +
> +       list_for_each_entry_reverse(s, &slab_caches, list) {
> +               if (slub_unmergeable(s))
> +                       continue;
> +
> +               if (size > s->size)
> +                       continue;
> +
> +               if ((flags & SLUB_MERGE_SAME) !=3D (s->flags & SLUB_MERGE=
_SAME))
> +                       continue;
> +               /*
> +                * Check if alignment is compatible.
> +                * Courtesy of Adrian Drzewiecki
> +                */
> +               if ((s->size & ~(align - 1)) !=3D s->size)
> +                       continue;
> +
> +               if (s->size - size >=3D sizeof(void *))
> +                       continue;
> +
> +               return s;
> +       }
> +       return NULL;
> +}
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>  static DEFINE_SPINLOCK(object_map_lock);
> @@ -6679,7 +6777,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
>         int err;
>         const char *name;
>         struct kset *kset =3D cache_kset(s);
> -       int unmergeable =3D slab_unmergeable(s);
> +       int unmergeable =3D slub_unmergeable(s);
>
>         if (!unmergeable && disable_higher_order_debug &&
>                         (slub_debug & DEBUG_METADATA_FLAGS))
> --
> 2.34.1
>
