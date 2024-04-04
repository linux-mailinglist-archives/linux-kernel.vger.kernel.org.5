Return-Path: <linux-kernel+bounces-131522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B3898900
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F273281490
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB476023;
	Thu,  4 Apr 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtVYms7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B585644
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238225; cv=none; b=R30SVZ6UZUIJZ8YRh719kMWP/DvvNR7WNB5brVBg2O1XhXUItPvhM2kChIC6ZVjlK2gFuJJ/iFO2pC1vNSHU3dNn3OkAURxGuvjyop/HtIdGsYtYi47VzxNoBFabz7/E4ZS62DbrpDfbGyqWQ0nKLc71mH/ZWf19KSAuDi8fnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238225; c=relaxed/simple;
	bh=o9MhFdlGnw32ziXC3IWaYQCUzaU9mJTeg/Ipm0c064U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu6E0BZEr3ZKjo36vJFwtG+hsO3MlXRPoFL/RK7p5GDmZWRN415b4nnZaKDRabI8PLTUFZQtrJm+Ha1Xl9t8cgHK7Lwu7drAmmvbOYT3e0OKEteA6oqHn/GxBy2oGdvJmOsNXtfVJ6SBmN6EETNBaCVKbcfE7ByDUBJMJLLBKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtVYms7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29925C43394
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238225;
	bh=o9MhFdlGnw32ziXC3IWaYQCUzaU9mJTeg/Ipm0c064U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CtVYms7bi0GUMlzh7g8mj6AxPNKgrpVJAR/mdYntbvUHD1o9iscjF/KBUd8SkeCC/
	 EaHxT4su0hC9xaaNUy2EzPbyfCTxjYLwU4K5oAuSOkcFC4iaBKN+vbHz/DUf9W93dz
	 0ru/mTraP0VbRMYnQMNCKeHcAKXg8CiCcWbwkMkDH/fb3Oluq3T6ZDt529BSM/gWdy
	 eRH+GggnHsZ4AioLJ/7k7MchPBVBBt/Kn9a1sWsUrXyg1xU490GsLgj03GSWYIRIMd
	 /FrG5EET5LUiErRN9HXmHQRhp/D9OJ2PJFzUl9nCrePexKTOGIcLWCNwiaX+FmYPFX
	 w+BwdMoI4w5mA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d718efedb2so16693171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:43:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxvcLCpuouGTZtsYfwJ6QcX3J8FC1PrUXYRSh0CxPrfVPVODz9eyXl10gFpATc+l+r3pfYpIyycXcct14P5rQ/GLEz1cMhAfFTFMr2
X-Gm-Message-State: AOJu0YxczmGUiB5xE7PBxTBw5AkxGP4dc0NulM+qJ0/9MdUPT+6ZLRj5
	CTv4xa8gLwgjsYZNTX+HQ92SH6ltlkHg4/EWU4iZgsY60YVjSOqCPVAKKFrulqQetwVXHhja+6t
	Jz4dOMjsWJ/tR7aHt0+/1nI2JLw==
X-Google-Smtp-Source: AGHT+IECbm50o89l/5du0PboRTqVze4XM7Gg5DfNdiM8lsiR9jlOlNvwkQ6rhzvERNmqUAUF1jBJ11DEiIYDIxU9RrY=
X-Received: by 2002:a05:651c:210e:b0:2d6:8868:f1a6 with SMTP id
 a14-20020a05651c210e00b002d68868f1a6mr3184834ljq.43.1712238223818; Thu, 04
 Apr 2024 06:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-2-ryan.roberts@arm.com> <CANeU7QnYOx-=xoeoLWotdQWOs2KMvw0E7LuRq27LO4RDA_ManQ@mail.gmail.com>
 <2acd461f-1d75-434c-a2f2-a3a8e1daad8f@arm.com>
In-Reply-To: <2acd461f-1d75-434c-a2f2-a3a8e1daad8f@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 4 Apr 2024 06:43:31 -0700
X-Gmail-Original-Message-ID: <CANeU7QkZqJXCfj6oMZHM51nwqKYeJ+UG+rE8ZZ2HVUssM-RfhQ@mail.gmail.com>
Message-ID: <CANeU7QkZqJXCfj6oMZHM51nwqKYeJ+UG+rE8ZZ2HVUssM-RfhQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:06=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 03/04/2024 23:12, Chris Li wrote:
> > Hi Ryan,
> >
> > Sorry for the late reply. I want to review this series but don't have
> > the chance to do it sooner.
>
> No problem. This series is now in mm-unstable, so if you want to request =
any
> changes in the other patches, I'd prefer it sooner rather than later, if =
possible.
>
> >
> > On Wed, Apr 3, 2024 at 4:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> As preparation for supporting small-sized THP in the swap-out path,
> >> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUG=
E,
> >> which, when present, always implies PMD-sized THP, which is the same a=
s
> >> the cluster size.
> >>
> >> The only use of the flag was to determine whether a swap entry refers =
to
> >> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
> >> Instead of relying on the flag, we now pass in nr_pages, which
> >> originates from the folio's number of pages. This allows the logic to
> >> work for folios of any order.
> >>
> >> The one snag is that one of the swap_page_trans_huge_swapped() call
> >> sites does not have the folio. But it was only being called there to
> >> shortcut a call __try_to_reclaim_swap() in some cases.
> >> __try_to_reclaim_swap() gets the folio and (via some other functions)
> >> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> >> call site and believe the new logic should be functionally equivalent.
> >>
> >> That said, removing the fast path means that we will take a reference
> >> and trylock a large folio much more often, which we would like to avoi=
d.
> >> The next patch will solve this.
> >>
> >> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster=
()
> >> which used to be called during folio splitting, since
> >> split_swap_cluster()'s only job was to remove the flag.
> >
> > Seems necessary to remove the assumption of large folio be PMD size.
> >
> > Acked-by: Chris Li <chrisl@kernel.org>
>
> Thanks!
>
> >
> >>
> >> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/swap.h | 10 ----------
> >>  mm/huge_memory.c     |  3 ---
> >>  mm/swapfile.c        | 47 ++++++++-----------------------------------=
-
> >>  3 files changed, 8 insertions(+), 52 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index a211a0383425..f6f78198f000 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -259,7 +259,6 @@ struct swap_cluster_info {
> >>  };
> >>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
> >>  #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster =
*/
> >> -#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent =
huge page */
> >>
> >>  /*
> >>   * We assign a cluster to each CPU, so each CPU can allocate swap ent=
ry from
> >> @@ -590,15 +589,6 @@ static inline int add_swap_extent(struct swap_inf=
o_struct *sis,
> >>  }
> >>  #endif /* CONFIG_SWAP */
> >>
> >> -#ifdef CONFIG_THP_SWAP
> >> -extern int split_swap_cluster(swp_entry_t entry);
> >> -#else
> >> -static inline int split_swap_cluster(swp_entry_t entry)
> >> -{
> >> -       return 0;
> >> -}
> >> -#endif
> >> -
> >>  #ifdef CONFIG_MEMCG
> >>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> >>  {
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index ea6d1f09a0b9..3ca9282a0dc9 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -2844,9 +2844,6 @@ static void __split_huge_page(struct page *page,=
 struct list_head *list,
> >>                 shmem_uncharge(folio->mapping->host, nr_dropped);
> >>         remap_page(folio, nr);
> >>
> >> -       if (folio_test_swapcache(folio))
> >> -               split_swap_cluster(folio->swap);
> >> -
> >>         /*
> >>          * set page to its compound_head when split to non order-0 pag=
es, so
> >>          * we can skip unlocking it below, since PG_locked is transfer=
red to
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 5e6d2304a2a4..0d44ee2b4f9c 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -343,18 +343,6 @@ static inline void cluster_set_null(struct swap_c=
luster_info *info)
> >>         info->data =3D 0;
> >>  }
> >>
> >> -static inline bool cluster_is_huge(struct swap_cluster_info *info)
> >> -{
> >> -       if (IS_ENABLED(CONFIG_THP_SWAP))
> >> -               return info->flags & CLUSTER_FLAG_HUGE;
> >> -       return false;
> >> -}
> >> -
> >> -static inline void cluster_clear_huge(struct swap_cluster_info *info)
> >> -{
> >> -       info->flags &=3D ~CLUSTER_FLAG_HUGE;
> >> -}
> >> -
> >>  static inline struct swap_cluster_info *lock_cluster(struct swap_info=
_struct *si,
> >>                                                      unsigned long off=
set)
> >>  {
> >> @@ -1027,7 +1015,7 @@ static int swap_alloc_cluster(struct swap_info_s=
truct *si, swp_entry_t *slot)
> >>         offset =3D idx * SWAPFILE_CLUSTER;
> >>         ci =3D lock_cluster(si, offset);
> >>         alloc_cluster(si, idx);
> >> -       cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE=
);
> >> +       cluster_set_count(ci, SWAPFILE_CLUSTER);
> >>
> >>         memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER=
);
> >>         unlock_cluster(ci);
> >> @@ -1365,7 +1353,6 @@ void put_swap_folio(struct folio *folio, swp_ent=
ry_t entry)
> >>
> >>         ci =3D lock_cluster_or_swap_info(si, offset);
> >>         if (size =3D=3D SWAPFILE_CLUSTER) {
> >> -               VM_BUG_ON(!cluster_is_huge(ci));
> >>                 map =3D si->swap_map + offset;
> >>                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >>                         val =3D map[i];
> >> @@ -1373,7 +1360,6 @@ void put_swap_folio(struct folio *folio, swp_ent=
ry_t entry)
> >>                         if (val =3D=3D SWAP_HAS_CACHE)
> >>                                 free_entries++;
> >>                 }
> >> -               cluster_clear_huge(ci);
> >>                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
> >>                         unlock_cluster_or_swap_info(si, ci);
> >>                         spin_lock(&si->lock);
> >> @@ -1395,23 +1381,6 @@ void put_swap_folio(struct folio *folio, swp_en=
try_t entry)
> >>         unlock_cluster_or_swap_info(si, ci);
> >>  }
> >>
> >> -#ifdef CONFIG_THP_SWAP
> >> -int split_swap_cluster(swp_entry_t entry)
> >> -{
> >> -       struct swap_info_struct *si;
> >> -       struct swap_cluster_info *ci;
> >> -       unsigned long offset =3D swp_offset(entry);
> >> -
> >> -       si =3D _swap_info_get(entry);
> >> -       if (!si)
> >> -               return -EBUSY;
> >> -       ci =3D lock_cluster(si, offset);
> >> -       cluster_clear_huge(ci);
> >> -       unlock_cluster(ci);
> >> -       return 0;
> >> -}
> >> -#endif
> >> -
> >>  static int swp_entry_cmp(const void *ent1, const void *ent2)
> >>  {
> >>         const swp_entry_t *e1 =3D ent1, *e2 =3D ent2;
> >> @@ -1519,22 +1488,23 @@ int swp_swapcount(swp_entry_t entry)
> >>  }
> >>
> >>  static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
> >> -                                        swp_entry_t entry)
> >> +                                        swp_entry_t entry,
> >> +                                        unsigned int nr_pages)
> >>  {
> >>         struct swap_cluster_info *ci;
> >>         unsigned char *map =3D si->swap_map;
> >>         unsigned long roffset =3D swp_offset(entry);
> >> -       unsigned long offset =3D round_down(roffset, SWAPFILE_CLUSTER)=
;
> >> +       unsigned long offset =3D round_down(roffset, nr_pages);
> >
> > It is obvious this code only works for powers two nr_pages. The
> > SWAPFILE_CLSTER is a power of two. If we switch to an API for
> > nr_pages, we might want to warn/ban passing in the non-power of two
> > nr_pages.
>
> Indeed. I could change the prototype to pass order instead of nr_pages, t=
hen
> generate nr_pages (=3D 1 << order) inside the function. But given the fun=
ction is
> static and only called from a single callsite, I don't see it as hugely
> important. I'd prefer to leave as is at this stage, unless you have stron=
g
> objection.

That is fine with me.

>
> >
> >>         int i;
> >>         bool ret =3D false;
> >>
> >>         ci =3D lock_cluster_or_swap_info(si, offset);
> >> -       if (!ci || !cluster_is_huge(ci)) {
> >> +       if (!ci || nr_pages =3D=3D 1) {
> >>                 if (swap_count(map[roffset]))
> >>                         ret =3D true;
> >>                 goto unlock_out;
> >>         }
> >> -       for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >
> > Here we assume the swap entry offset is contiguous. That is beyond
> > your patch's scope. If in the future we want to have non-contiguous
> > swap entries to swap out large pages, we will need to find out and
> > change all the places that have the assumption of contiguous swap
> > entries.
>
> Yes there are tonnes of places that make this assumption :)

Yes, that is why I want to have some wrapper API to mark the existing
place that makes the assumption. Hopefully we can just change those
wrapper functions to implement the non-contiguous version of swap.

Thank you for the patch.

Chris

