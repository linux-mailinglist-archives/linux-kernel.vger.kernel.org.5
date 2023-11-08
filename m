Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595BE7E5239
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjKHIzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjKHIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:55:35 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818DD4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:55:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5056059e0so94977981fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699433731; x=1700038531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Neyzo+yXODi+LxgmmxsXAP91xo9G/2gVdE30ohYlc=;
        b=c1DpzliuL3P/OS+Fpp/oWoetqikYOfFLGUQfFd+SCIWrMFBTOC1Etcu12v4D970/2i
         /bZHGojCEvL0/3C4tGinmQM2F21NXIX79Nle8FwDM4QOmWBbon7N1DIy9ecuY1+ttFcy
         qhAjdM9arlpDggJD3p6PEi4ikFtmonxoljiDiFzFTmRynX1h7a0vKR8ZEAKzRbIQHAHI
         79EXocN6QwPddPMkMUVNYRkx3sO7k9RP2uj93w53/Mbsll8vqTmz11mMEKkzUyuR6rTs
         ZbFcTDc0ESyE2wOXOJZZRgJCe+w2X5eBD9vbiBs/7J6NPH9sKFDj63T19RGlQ7g5AU57
         ZyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699433731; x=1700038531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Neyzo+yXODi+LxgmmxsXAP91xo9G/2gVdE30ohYlc=;
        b=UsgsTt4kMeID3UvXpwZIBX0Yfscj+975P1zE6TmZUuSTROfwPcAfG+ZbNRQAChH8i4
         n3nnyjCjYiU6PCHIajkCwijNDkW5ZB8CTAvcLit8ykJKnwgaFS7rdEpsXHtkBMzM1jbA
         Uwbqr/0wVR79GWoCoq+0btIkXVvAfpQfEGqYxun5qucyPYSXrGVqTuC/YCbOYR3j7VtU
         GMmCWKGryYSv2yQJAP2urkDcqdwxPjIYPd4cZ2ozoyEVbMartOQPp3Y/govO8oia8AU3
         8Mbr6nt+iQJwCyVNOBh0DCrafVT5Omz30hVKTEzeC0a5oi6Eyao6Hh+JvJqwXmIaUfjV
         3bGw==
X-Gm-Message-State: AOJu0YyvsTaDlzDzXio2/eh8OK378FM2UHXm1vB7b0ySuMOjEvMHYylq
        IxXFGzkjS397xQAhD1NOJUrqEcD8JShQBTBof2nbTZ/EOUI=
X-Google-Smtp-Source: AGHT+IEhGkbnw+DdnnIHh1LEcmqDkwpQfE1G3mZkSvugcfSpqjW2g7mGAOqEJpcf6kQYikqM7O/X0VqLJeCi7ScgS/o=
X-Received: by 2002:a05:651c:11c6:b0:2be:54b4:ff90 with SMTP id
 z6-20020a05651c11c600b002be54b4ff90mr890530ljo.53.1699433730681; Wed, 08 Nov
 2023 00:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com> <20231107172820.GA3745089@cmpxchg.org>
In-Reply-To: <20231107172820.GA3745089@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 8 Nov 2023 16:55:19 +0800
Message-ID: <CAGWkznGbGciTocrqMowepCc=aStYFHPt8RPGYjWxQ4TRG1ZqXQ@mail.gmail.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA enabled
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, steve.kang@unisoc.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 1:28=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Oct 16, 2023 at 03:12:45PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > According to current CMA utilization policy, an alloc_pages(GFP_USER)
> > could 'steal' UNMOVABLE & RECLAIMABLE page blocks via the help of
> > CMA(pass zone_watermark_ok by counting CMA in but use U&R in rmqueue),
> > which could lead to following alloc_pages(GFP_KERNEL) fail.
> > Solving this by introducing second watermark checking for GFP_MOVABLE,
> > which could have the allocation use CMA when proper.
> >
> > -- Free_pages(30MB)
> > |
> > |
> > -- WMARK_LOW(25MB)
> > |
> > -- Free_CMA(12MB)
> > |
> > |
> > --
>
> We're running into the same issue in production and had an incident
> over the weekend because of it. The hosts have a raised
> vm.min_free_kbytes for network rx reliability, which makes the
> mismatch between free pages and what's actually allocatable by regular
> kernel requests quite pronounced. It wasn't OOMing this time, but we
> saw very high rates of thrashing while CMA had plenty of headroom.
>
> I had raised the broader issue around poor CMA utilization before:
> https://lore.kernel.org/lkml/20230726145304.1319046-1-hannes@cmpxchg.org/
>
> For context, we're using hugetlb_cma at several gigabytes to allow
> sharing hosts between jobs that use hugetlb and jobs that don't.
>
> > @@ -2078,6 +2078,43 @@ __rmqueue_fallback(struct zone *zone, int order,=
 int start_migratetype,
> >
> >  }
> >
> > +#ifdef CONFIG_CMA
> > +/*
> > + * GFP_MOVABLE allocation could drain UNMOVABLE & RECLAIMABLE page blo=
cks via
> > + * the help of CMA which makes GFP_KERNEL failed. Checking if zone_wat=
ermark_ok
> > + * again without ALLOC_CMA to see if to use CMA first.
> > + */
> > +static bool use_cma_first(struct zone *zone, unsigned int order, unsig=
ned int alloc_flags)
> > +{
> > +     unsigned long watermark;
> > +     bool cma_first =3D false;
> > +
> > +     watermark =3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> > +     /* check if GFP_MOVABLE pass previous zone_watermark_ok via the h=
elp of CMA */
> > +     if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~=
ALLOC_CMA))) {
> > +             /*
> > +              * Balance movable allocations between regular and CMA ar=
eas by
> > +              * allocating from CMA when over half of the zone's free =
memory
> > +              * is in the CMA area.
> > +              */
ok, thanks for point out.
Could we simple it like this, which will mis-judge kmalloc within
ioctl as GFP_USER. I think it is ok as it is rare
             if (current_is_kswapd() || !current->mm)
                 gfp_flags =3D GFP_KERNEL;
             else
                 gfp_flags =3D GFP_USER;
            free_pages =3D zone_page_state(zone, NR_FREE_PAGES);
            free_pages -=3D zone->lowmem_reserve[gfp_zone(gfp_flags)];
            free_pages -=3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MAS=
K);
            cma_first =3D free_pages > zone_page_state(zone, NR_FREE_PAGES)=
 / 2);

> > +             cma_first =3D (zone_page_state(zone, NR_FREE_CMA_PAGES) >
> > +                             zone_page_state(zone, NR_FREE_PAGES) / 2)=
;
> > +     } else {
> > +             /*
> > +              * watermark failed means UNMOVABLE & RECLAIMBLE is not e=
nough
> > +              * now, we should use cma first to keep them stay around =
the
> > +              * corresponding watermark
> > +              */
> > +             cma_first =3D true;
> > +     }
> > +     return cma_first;
>
> I think it's a step in the right direction. However, it doesn't take
> the lowmem reserves into account. With DMA32 that can be an additional
> multiple gigabytes of "free" memory not available to GFP_KERNEL. It
> also has a knee in the balancing curve because it doesn't take
> reserves into account *until* non-CMA is depleted - at which point it
> would already be below the use-CMA threshold by the full reserves and
> watermarks.
>
> A more complete solution would have to plumb the highest_zoneidx
> information through the rmqueue family of functions somehow, and
> always take unavailable free memory into account:
>
> ---
> Subject: [PATCH] mm: page_alloc: use CMA when kernel allocations are begi=
nning
>  to fail
>
> We can get into a situation where kernel allocations are starting to
> fail on watermarks, but movable allocations still don't use CMA
> because they make up more than half of the free memory. This can
> happen in particular with elevated vm.min_free_kbytes settings, where
> the remaining free pages aren't available to non-atomic requests.
>
> Example scenario:
>
>       Free: 3.0G
> Watermarks: 2.0G
>        CMA: 1.4G
> -> non-CMA: 1.6G
>
> CMA isn't used because CMA <=3D free/2. Kernel allocations fail due to
> non-CMA < watermarks. If memory is mostly unreclaimable (e.g. anon
> without swap), the kernel is more likely to OOM prematurely.
>
> Reduce the probability of that happening by taking reserves and
> watermarks into account when deciding whether to start using CMA.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 93 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 59 insertions(+), 34 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 733732e7e0ba..b9273d7f23b8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2079,30 +2079,52 @@ __rmqueue_fallback(struct zone *zone, int order, =
int start_migratetype,
>
>  }
>
> +static bool should_try_cma(struct zone *zone, unsigned int order,
> +                          gfp_t gfp_flags, unsigned int alloc_flags)
> +{
> +       long free_pages;
> +
> +       if (!IS_ENABLED(CONFIG_CMA) || !(alloc_flags & ALLOC_CMA))
> +               return false;
> +
> +       /*
> +        * CMA regions can be used by movable allocations while
> +        * they're not otherwise in use. This is a delicate balance:
> +        * Filling CMA too soon poses a latency risk for actual CMA
> +        * allocations (think camera app startup). Filling CMA too
> +        * late risks premature OOMs from non-movable allocations.
> +        *
> +        * Start using CMA once it dominates the remaining free
> +        * memory. Be sure to take watermarks and reserves into
> +        * account when considering what's truly "free".
> +        *
> +        * free_pages can go negative, but that's okay because
> +        * NR_FREE_CMA_PAGES should not.
> +        */
> +
> +       free_pages =3D zone_page_state(zone, NR_FREE_PAGES);
> +       free_pages -=3D zone->lowmem_reserve[gfp_zone(gfp_flags)];
> +       free_pages -=3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK)=
;
> +
> +       return zone_page_state(zone, NR_FREE_CMA_PAGES) > free_pages / 2;
> +}
> +
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
>   */
>  static __always_inline struct page *
> -__rmqueue(struct zone *zone, unsigned int order, int migratetype,
> -                                               unsigned int alloc_flags)
> +__rmqueue(struct zone *zone, unsigned int order, gfp_t gfp_flags,
> +         int migratetype, unsigned int alloc_flags)
>  {
>         struct page *page;
>
> -       if (IS_ENABLED(CONFIG_CMA)) {
> -               /*
> -                * Balance movable allocations between regular and CMA ar=
eas by
> -                * allocating from CMA when over half of the zone's free =
memory
> -                * is in the CMA area.
> -                */
> -               if (alloc_flags & ALLOC_CMA &&
> -                   zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
> -                       page =3D __rmqueue_cma_fallback(zone, order);
> -                       if (page)
> -                               return page;
> -               }
> +       if (should_try_cma(zone, order, gfp_flags, alloc_flags)) {
> +               page =3D __rmqueue_cma_fallback(zone, order);
> +               if (page)
> +                       return page;
>         }
> +
>  retry:
>         page =3D __rmqueue_smallest(zone, order, migratetype);
>         if (unlikely(!page)) {
> @@ -2121,7 +2143,7 @@ __rmqueue(struct zone *zone, unsigned int order, in=
t migratetype,
>   * a single hold of the lock, for efficiency.  Add them to the supplied =
list.
>   * Returns the number of new pages which were placed at *list.
>   */
> -static int rmqueue_bulk(struct zone *zone, unsigned int order,
> +static int rmqueue_bulk(struct zone *zone, unsigned int order, gfp_t gfp=
_flags,
>                         unsigned long count, struct list_head *list,
>                         int migratetype, unsigned int alloc_flags)
>  {
> @@ -2130,8 +2152,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned=
 int order,
>
>         spin_lock_irqsave(&zone->lock, flags);
>         for (i =3D 0; i < count; ++i) {
> -               struct page *page =3D __rmqueue(zone, order, migratetype,
> -                                                               alloc_fla=
gs);
> +               struct page *page =3D __rmqueue(zone, order, gfp_flags,
> +                                             migratetype, alloc_flags);
>                 if (unlikely(page =3D=3D NULL))
>                         break;
>
> @@ -2714,8 +2736,8 @@ static inline void zone_statistics(struct zone *pre=
ferred_zone, struct zone *z,
>
>  static __always_inline
>  struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zon=
e,
> -                          unsigned int order, unsigned int alloc_flags,
> -                          int migratetype)
> +                          unsigned int order, gfp_t gfp_flags,
> +                          unsigned int alloc_flags, int migratetype)
>  {
>         struct page *page;
>         unsigned long flags;
> @@ -2726,7 +2748,8 @@ struct page *rmqueue_buddy(struct zone *preferred_z=
one, struct zone *zone,
>                 if (alloc_flags & ALLOC_HIGHATOMIC)
>                         page =3D __rmqueue_smallest(zone, order, MIGRATE_=
HIGHATOMIC);
>                 if (!page) {
> -                       page =3D __rmqueue(zone, order, migratetype, allo=
c_flags);
> +                       page =3D __rmqueue(zone, order, migratetype,
> +                                        gfp_flags, alloc_flags);
>
>                         /*
>                          * If the allocation fails, allow OOM handling ac=
cess
> @@ -2806,10 +2829,10 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp=
, struct zone *zone, int order)
>  /* Remove page from the per-cpu list, caller must protect the list */
>  static inline
>  struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
> -                       int migratetype,
> -                       unsigned int alloc_flags,
> -                       struct per_cpu_pages *pcp,
> -                       struct list_head *list)
> +                              gfp_t gfp_flags, int migratetype,
> +                              unsigned int alloc_flags,
> +                              struct per_cpu_pages *pcp,
> +                              struct list_head *list)
>  {
>         struct page *page;
>
> @@ -2818,7 +2841,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, u=
nsigned int order,
>                         int batch =3D nr_pcp_alloc(pcp, zone, order);
>                         int alloced;
>
> -                       alloced =3D rmqueue_bulk(zone, order,
> +                       alloced =3D rmqueue_bulk(zone, order, gfp_flags,
>                                         batch, list,
>                                         migratetype, alloc_flags);
>
> @@ -2837,8 +2860,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, u=
nsigned int order,
>
>  /* Lock and remove page from the per-cpu list */
>  static struct page *rmqueue_pcplist(struct zone *preferred_zone,
> -                       struct zone *zone, unsigned int order,
> -                       int migratetype, unsigned int alloc_flags)
> +                                   struct zone *zone, unsigned int order=
,
> +                                   gfp_t gfp_flags, int migratetype,
> +                                   unsigned int alloc_flags)
>  {
>         struct per_cpu_pages *pcp;
>         struct list_head *list;
> @@ -2860,7 +2884,8 @@ static struct page *rmqueue_pcplist(struct zone *pr=
eferred_zone,
>          */
>         pcp->free_count >>=3D 1;
>         list =3D &pcp->lists[order_to_pindex(migratetype, order)];
> -       page =3D __rmqueue_pcplist(zone, order, migratetype, alloc_flags,=
 pcp, list);
> +       page =3D __rmqueue_pcplist(zone, order, gfp_flags, migratetype,
> +                                alloc_flags, pcp, list);
>         pcp_spin_unlock(pcp);
>         pcp_trylock_finish(UP_flags);
>         if (page) {
> @@ -2898,13 +2923,13 @@ struct page *rmqueue(struct zone *preferred_zone,
>
>         if (likely(pcp_allowed_order(order))) {
>                 page =3D rmqueue_pcplist(preferred_zone, zone, order,
> -                                      migratetype, alloc_flags);
> +                                      gfp_flags, migratetype, alloc_flag=
s);
>                 if (likely(page))
>                         goto out;
>         }
>
> -       page =3D rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
> -                                                       migratetype);
> +       page =3D rmqueue_buddy(preferred_zone, zone, order, gfp_flags,
> +                            alloc_flags, migratetype);
>
>  out:
>         /* Separate test+clear to avoid unnecessary atomics */
> @@ -4480,8 +4505,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int pre=
ferred_nid,
>                         continue;
>                 }
>
> -               page =3D __rmqueue_pcplist(zone, 0, ac.migratetype, alloc=
_flags,
> -                                                               pcp, pcp_=
list);
> +               page =3D __rmqueue_pcplist(zone, 0, gfp, ac.migratetype,
> +                                        alloc_flags, pcp, pcp_list);
>                 if (unlikely(!page)) {
>                         /* Try and allocate at least one page */
>                         if (!nr_account) {
> --
> 2.42.0

>
