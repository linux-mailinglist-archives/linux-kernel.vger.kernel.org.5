Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3E750E63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjGLQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjGLQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:23:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D752D65;
        Wed, 12 Jul 2023 09:23:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262fa79e97fso3585205a91.2;
        Wed, 12 Jul 2023 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689179000; x=1691771000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mvKlKHSg/A3EuJ2PFCJvzfOkyyunP0cNJw9XZ1YoG4=;
        b=VHnuNATviqOgKPuyo3fuh1fXRy2OtRR/omFx+1Sa0YyCS83h8RtoeVoirEmi33KxVj
         g1K4O/CD8L6aR7SXF02veyJT2HS+FHZLswYIM+kpjJKG4qXi54M6HzSgrgccjBhdZM16
         7dkoE6XTRFpoldjZiEjKPk2sndtlxAE3IeSKB9XknsPXks/RyD6ePGFqztpdC2CocYgR
         XSByCC97A4XUlkhuinayUvwLt2+JXyvZ3iH8fN7QKSbCBuUKmzt4gro0OCSm83GQHUDj
         kLUajaa9ldIx42KMzNTTWuIe/PA2h/G1AZULj6qVniKflEdR/S8tU49+KDbfde7ePfir
         EnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179000; x=1691771000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mvKlKHSg/A3EuJ2PFCJvzfOkyyunP0cNJw9XZ1YoG4=;
        b=fXFKqAKnSPN5qsjKFhXcAnI8995UBvQ9+vd3FxmZXgbuVryXeMibPmxVW0McPqAC0D
         fT/F0bUBXcaDE/24sWhqEUsOKEFCYWSpz0LNsebVxfswyRsI5dyh3ncTJG415nMfULHt
         zxfYML0bY5ZTW6bSkSIuCCwM+AzHszj8326eMs5krLbUWaETAPFbWPaqmZ4Fe/uu1PII
         ehBBtvgs9TY73DHdLofzdxJMU0lAQBS2nLaupesF+yrTG2zfspk/W3NQ8ODOhT06IRcx
         JihLIo3vBqE1gRbVccg075UnPmvQFyuqbKrjhHZfv83rPfaNS1JzK6zk5N+GeAjlL5XZ
         foRA==
X-Gm-Message-State: ABy/qLYOAaa528rAYddhgUbvse0QNtKqyL6FghNtq/eomrM4Q6RKm2mr
        RvyzJGhb8Myq3CC0gJe/QSNSkqDsPOc8UOMfcvw=
X-Google-Smtp-Source: APBJJlF3rf+aZ7Dic0YZaGil/jwvb4h4itZZ9wPU2RvqES1B/ZcPeLeQYICZfi8bU6WCHwKtU9BfGohX9VYGxKiHV3U=
X-Received: by 2002:a17:90b:400a:b0:263:f5a5:fb98 with SMTP id
 ie10-20020a17090b400a00b00263f5a5fb98mr15776385pjb.28.1689178999981; Wed, 12
 Jul 2023 09:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230711134623.12695-3-vbabka@suse.cz>
In-Reply-To: <20230711134623.12695-3-vbabka@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 12 Jul 2023 18:23:09 +0200
Message-ID: <CA+fCnZci9E8Snjuc-rJqSeX+Gn84_AVO5OjQwyFT=vL+pw22HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: remove redundant kasan_reset_tag() from
 freelist_ptr calculations
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:46=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Commit d36a63a943e3 ("kasan, slub: fix more conflicts with
> CONFIG_SLAB_FREELIST_HARDENED") has introduced kasan_reset_tags() to
> freelist_ptr() encoding/decoding when CONFIG_SLAB_FREELIST_HARDENED is
> enabled to resolve issues when passing tagged or untagged pointers
> inconsistently would lead to incorrect calculations.
>
> Later, commit aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing
> metadata") made sure all pointers have tags reset regardless of
> CONFIG_SLAB_FREELIST_HARDENED, because there was no other way to access
> the freepointer metadata safely with hw tag-based KASAN.
>
> Therefore the kasan_reset_tag() usage in freelist_ptr_encode()/decode()
> is now redundant, as all callers use kasan_reset_tag() unconditionally
> when constructing ptr_addr. Remove the redundant calls and simplify the
> code and remove obsolete comments.
>
> Also in freelist_ptr_encode() introduce an 'encoded' variable to make
> the lines shorter and make it similar to the _decode() one.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> These 2 patches build on top of:
> https://lore.kernel.org/all/20230704135834.3884421-1-matteorizzo@google.c=
om/
>
>  mm/slub.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index f8cc47eff742..07edad305512 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -374,22 +374,14 @@ typedef struct { unsigned long v; } freeptr_t;
>  static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
>                                             void *ptr, unsigned long ptr_=
addr)
>  {
> +       unsigned long encoded;
> +
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> -       /*
> -        * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tag=
ged.
> -        * Normally, this doesn't cause any issues, as both set_freepoint=
er()
> -        * and get_freepointer() are called with a pointer with the same =
tag.
> -        * However, there are some issues with CONFIG_SLUB_DEBUG code. Fo=
r
> -        * example, when __free_slub() iterates over objects in a cache, =
it
> -        * passes untagged pointers to check_object(). check_object() in =
turns
> -        * calls get_freepointer() with an untagged pointer, which causes=
 the
> -        * freepointer to be restored incorrectly.
> -        */
> -       return (freeptr_t){.v =3D (unsigned long)ptr ^ s->random ^
> -                       swab((unsigned long)kasan_reset_tag((void *)ptr_a=
ddr))};
> +       encoded =3D (unsigned long)ptr ^ s->random ^ swab(ptr_addr);
>  #else
> -       return (freeptr_t){.v =3D (unsigned long)ptr};
> +       encoded =3D (unsigned long)ptr;
>  #endif
> +       return (freeptr_t){.v =3D encoded};
>  }
>
>  static inline void *freelist_ptr_decode(const struct kmem_cache *s,
> @@ -398,9 +390,7 @@ static inline void *freelist_ptr_decode(const struct =
kmem_cache *s,
>         void *decoded;
>
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> -       /* See the comment in freelist_ptr_encode */
> -       decoded =3D (void *)(ptr.v ^ s->random ^
> -               swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
> +       decoded =3D (void *)(ptr.v ^ s->random ^ swab(ptr_addr));
>  #else
>         decoded =3D (void *)ptr.v;
>  #endif
> --
> 2.41.0

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
