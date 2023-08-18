Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B4C780B66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbjHRLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376729AbjHRLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:47:51 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6681D2723
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:47:50 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44779e3e394so285268137.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692359269; x=1692964069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAfIM5gpLJTpuPiiqsDtzWBiv40WoFry3jyTY/pzGKQ=;
        b=WgFyAtGBMxvr226dkfTHl5GKxVdN0h0kzbcnKkrDeKL5Ytm3ODeLGpBw3r8/9neIvl
         4PgYqJcR3HIXVKyz/eDspWnSbTYXggMWmwAyYUxyZCLSrlcvE5jarpyyPh5an6FfsVbE
         rq2cpMAUGAhSXnFr1YtBtfa/uPtC+qYHNbhNnh3XH6JzDjDcBq9lltcDR16c/+8FjZKW
         kPkCPN4+2CWSUj4cBzqCw+OXpU1lqkDs+7yP0qnOEeprus4uBBXMrMPhRrAj+VK8IMAg
         47KKkowdN1QOLpwwVHJ0UuDM+5S5//PjWoBGGfWbP2D3U0gqE4PVNJGU3qiSzzLsx0BG
         o7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692359269; x=1692964069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAfIM5gpLJTpuPiiqsDtzWBiv40WoFry3jyTY/pzGKQ=;
        b=D2XORv96+tGPJ2WaCSOQf10Goym2Dtph5zW1D39ocTacC8rCjxPnWOy4J67CKK4/ng
         x/BFLGkLZeT3yLF1q5zJNCOIPHeo1+2f9v55mLLHN0NRWuqhiuFymz2hK9jZwH1NQJKf
         3NMdoGd+UN73YYjCYG1HQCHRXeHW/j+CuinEAPiIJ5g731ZkXzapJBhUTPC5ZOROmdOn
         4t+TZjJtUWHhEY3FuvYPnPvC0BKpddosNjtpQN2LYRBQnX5kxcY5cCrMOTlXqwrKS15F
         CbOlVK+ZNd0Z4plI6prdbqwOMa/+kQ1GQpH29FesKVz5xtSJjaYulvLCzgbZUyDibUdi
         8BOg==
X-Gm-Message-State: AOJu0YzDBz92as9/zkH4HSIFsoYPNWEmgesVLY7/vsNbd8XC4Vrt3fB4
        tbR/3+ZZoK5i6yRLdcCJDGBy3Hv2Nje4rV7smlk=
X-Google-Smtp-Source: AGHT+IGJrBuWc0TgeyRTJnSrv8cqlREWyOoz6U6qJj7S3f7Ew1q7aRXhto3Nmue2STFJvfLAkqstSuKdh0XXv93p+lc=
X-Received: by 2002:a67:f5d6:0:b0:447:6965:7285 with SMTP id
 t22-20020a67f5d6000000b0044769657285mr3080841vso.9.1692359269361; Fri, 18 Aug
 2023 04:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230808095342.12637-7-vbabka@suse.cz> <20230808095342.12637-8-vbabka@suse.cz>
In-Reply-To: <20230808095342.12637-8-vbabka@suse.cz>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 18 Aug 2023 20:47:37 +0900
Message-ID: <CAB=+i9QaA+ewMeGM9ngkn06ag2HFoJqCRhmfG4qP-_G3Gv5DTQ@mail.gmail.com>
Subject: Re: [RFC v1 1/5] mm, slub: fix bulk alloc and free stats
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> The SLUB sysfs stats enabled CONFIG_SLUB_STATS have two deficiencies
> identified wrt bulk alloc/free operations:
>
> - Bulk allocations from cpu freelist are not counted. Add the
>   ALLOC_FASTPATH counter there.
>
> - Bulk fastpath freeing will count a list of multiple objects with a
>   single FREE_FASTPATH inc. Add a stat_add() variant to count them all.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index e3b5d5c0eb3a..a9437d48840c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -341,6 +341,14 @@ static inline void stat(const struct kmem_cache *s, =
enum stat_item si)
>  #endif
>  }
>
> +static inline void stat_add(const struct kmem_cache *s, enum stat_item s=
i, int v)
> +{
> +#ifdef CONFIG_SLUB_STATS
> +       raw_cpu_add(s->cpu_slab->stat[si], v);
> +#endif
> +}
> +
> +
>  /*
>   * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
>   * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
> @@ -3776,7 +3784,7 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
>
>                 local_unlock(&s->cpu_slab->lock);
>         }
> -       stat(s, FREE_FASTPATH);
> +       stat_add(s, FREE_FASTPATH, cnt);

Should bulk free slowpath also be counted in the same way?

>  }
>  #else /* CONFIG_SLUB_TINY */
>  static void do_slab_free(struct kmem_cache *s,
> @@ -3978,6 +3986,7 @@ static inline int __kmem_cache_alloc_bulk(struct km=
em_cache *s, gfp_t flags,
>                 c->freelist =3D get_freepointer(s, object);
>                 p[i] =3D object;
>                 maybe_wipe_obj_freeptr(s, p[i]);
> +               stat(s, ALLOC_FASTPATH);
>         }
>         c->tid =3D next_tid(c->tid);
>         local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
> --
> 2.41.0
>
