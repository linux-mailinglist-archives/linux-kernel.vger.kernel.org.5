Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA085802238
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjLCJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:24:04 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81F0E7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 01:24:10 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77dd07e7d39so254078385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701595450; x=1702200250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeasbcueEnclsqZGxNV2x6e/aU9eq7VKQoSs9IICTbY=;
        b=KqZWcbCfAx1ZYIeVcIY+KHYtklLdlogomvTYg8mwvEQybBMRQAyjNFmlTqqZcRKeYP
         ug2tFdGoU2XY4n32oNUWQrnqN0YF9vRCNGDGyqQH0+2X5D2PnO7rxmdLHSMmLHPfxU4W
         roRCiKkVzZv845BgE4tlZIbv6iAqazkwKjFU2nNGmjSRAAQsgjb4dwQdXBHsHMV7WTEL
         UdfP1LbjA3PxWcpDzxxwKUXorwG0HDXvup0Qsi1GE/naq1GweWPr+6pKYSCZZGs4gNio
         LmJZMCBQCEyNnd4O5IQLLaKrSl+EzC0pfme/JPyKEpWO69BBuymEJ7+4vCFBoJd7wnlN
         D1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701595450; x=1702200250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeasbcueEnclsqZGxNV2x6e/aU9eq7VKQoSs9IICTbY=;
        b=rYT8HlIsfygleVc6BB5kCzA78YXnoac6Xy6Hk9w+CdIreEqvQ14yFra9NXI5EKMpF+
         D9XFRJVNuK9Gu9ownXc8VZhTcHSSgXWOe+9rH4eBoD4+e9OpgLv/jSvSCIhXSjRTjdN+
         3pB3aFLmMGnqVq8Diql38L+cbggxRjXzcxnrSycLCUqPfdOGQDNiiTxfqzsQ9DrLosCa
         DtRTZusfbjUouwvFLAFxdZ+jXvxqsF3KmLmmfSscVEw0m4NbGtRFMaktp/L5O6bXkYPl
         3TInmNfRT1QOIOAgweK4qc0E6CM6efPegSk0lWZS7BDQOyo8vPTGWijbxSm4ZPPETmfe
         lYog==
X-Gm-Message-State: AOJu0Ywa8L2dAOb31WWnPvFAn3Y/BO6cN/okusRgd9tIjQyzBcIyY01+
        7CH70k1F/KsPtFHWClZ3Fp3CAR7tupWF/zGAIXI=
X-Google-Smtp-Source: AGHT+IFrCzdYjDSzA4O8rw/e7mDj2NdJweM2ALzmtN9ksUGzWMFVdYjsbZHt9CilRqqqln513+zIzt/bpmcW1YBRnPc=
X-Received: by 2002:a05:620a:208b:b0:778:9148:3c2c with SMTP id
 e11-20020a05620a208b00b0077891483c2cmr2690372qka.18.1701595449862; Sun, 03
 Dec 2023 01:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20231102032330.1036151-1-chengming.zhou@linux.dev> <20231102032330.1036151-8-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-8-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 3 Dec 2023 18:23:57 +0900
Message-ID: <CAB=+i9RR-n4q5NU6LFqmhM8ys4kM0SPqwj0zYtr4twu=yYmPPA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] slub: Optimize deactivate_slab()
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

On Thu, Nov 2, 2023 at 12:25=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> Since the introduce of unfrozen slabs on cpu partial list, we don't
> need to synchronize the slab frozen state under the node list_lock.
>
> The caller of deactivate_slab() and the caller of __slab_free() won't
> manipulate the slab list concurrently.
>
> So we can get node list_lock in the last stage if we really need to
> manipulate the slab list in this path.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/slub.c | 79 ++++++++++++++++++-------------------------------------
>  1 file changed, 26 insertions(+), 53 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index bcb5b2c4e213..d137468fe4b9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2468,10 +2468,8 @@ static void init_kmem_cache_cpus(struct kmem_cache=
 *s)
>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>                             void *freelist)
>  {
> -       enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>         struct kmem_cache_node *n =3D get_node(s, slab_nid(slab));
>         int free_delta =3D 0;
> -       enum slab_modes mode =3D M_NONE;
>         void *nextfree, *freelist_iter, *freelist_tail;
>         int tail =3D DEACTIVATE_TO_HEAD;
>         unsigned long flags =3D 0;
> @@ -2509,65 +2507,40 @@ static void deactivate_slab(struct kmem_cache *s,=
 struct slab *slab,
>         /*
>          * Stage two: Unfreeze the slab while splicing the per-cpu
>          * freelist to the head of slab's freelist.
> -        *
> -        * Ensure that the slab is unfrozen while the list presence
> -        * reflects the actual number of objects during unfreeze.
> -        *
> -        * We first perform cmpxchg holding lock and insert to list
> -        * when it succeed. If there is mismatch then the slab is not
> -        * unfrozen and number of objects in the slab may have changed.
> -        * Then release lock and retry cmpxchg again.
>          */
> -redo:
> -
> -       old.freelist =3D READ_ONCE(slab->freelist);
> -       old.counters =3D READ_ONCE(slab->counters);
> -       VM_BUG_ON(!old.frozen);
> -
> -       /* Determine target state of the slab */
> -       new.counters =3D old.counters;
> -       if (freelist_tail) {
> -               new.inuse -=3D free_delta;
> -               set_freepointer(s, freelist_tail, old.freelist);
> -               new.freelist =3D freelist;
> -       } else
> -               new.freelist =3D old.freelist;
> -
> -       new.frozen =3D 0;
> +       do {
> +               old.freelist =3D READ_ONCE(slab->freelist);
> +               old.counters =3D READ_ONCE(slab->counters);
> +               VM_BUG_ON(!old.frozen);
> +
> +               /* Determine target state of the slab */
> +               new.counters =3D old.counters;
> +               new.frozen =3D 0;
> +               if (freelist_tail) {
> +                       new.inuse -=3D free_delta;
> +                       set_freepointer(s, freelist_tail, old.freelist);
> +                       new.freelist =3D freelist;
> +               } else {
> +                       new.freelist =3D old.freelist;
> +               }
> +       } while (!slab_update_freelist(s, slab,
> +               old.freelist, old.counters,
> +               new.freelist, new.counters,
> +               "unfreezing slab"));
>
> +       /*
> +        * Stage three: Manipulate the slab list based on the updated sta=
te.
> +        */

deactivate_slab() might unconsciously put empty slabs into partial list, li=
ke:

deactivate_slab()                    __slab_free()
cmpxchg(), slab's not empty
                                               cmpxchg(), slab's empty
and unfrozen
                                               spin_lock(&n->list_lock)
                                               (slab's empty but not
on partial list,

spin_unlock(&n->list_lock) and return)
spin_lock(&n->list_lock)
put slab into partial list
spin_unlock(&n->list_lock)

IMHO it should be fine in the real world, but just wanted to
mention as it doesn't seem to be intentional.

Otherwise it looks good to me!

>         if (!new.inuse && n->nr_partial >=3D s->min_partial) {
> -               mode =3D M_FREE;
> +               stat(s, DEACTIVATE_EMPTY);
> +               discard_slab(s, slab);
> +               stat(s, FREE_SLAB);
>         } else if (new.freelist) {
> -               mode =3D M_PARTIAL;
> -               /*
> -                * Taking the spinlock removes the possibility that
> -                * acquire_slab() will see a slab that is frozen
> -                */
>                 spin_lock_irqsave(&n->list_lock, flags);
> -       } else {
> -               mode =3D M_FULL_NOLIST;
> -       }
> -
> -
> -       if (!slab_update_freelist(s, slab,
> -                               old.freelist, old.counters,
> -                               new.freelist, new.counters,
> -                               "unfreezing slab")) {
> -               if (mode =3D=3D M_PARTIAL)
> -                       spin_unlock_irqrestore(&n->list_lock, flags);
> -               goto redo;
> -       }
> -
> -
> -       if (mode =3D=3D M_PARTIAL) {
>                 add_partial(n, slab, tail);
>                 spin_unlock_irqrestore(&n->list_lock, flags);
>                 stat(s, tail);
> -       } else if (mode =3D=3D M_FREE) {
> -               stat(s, DEACTIVATE_EMPTY);
> -               discard_slab(s, slab);
> -               stat(s, FREE_SLAB);
> -       } else if (mode =3D=3D M_FULL_NOLIST) {
> +       } else {
>                 stat(s, DEACTIVATE_FULL);
>         }
>  }
> --
> 2.20.1
>
