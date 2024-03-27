Return-Path: <linux-kernel+bounces-120402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423488D6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75501C2484E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3E24B29;
	Wed, 27 Mar 2024 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbIGDVP1"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A41CA87
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522573; cv=none; b=ZgJJkZp528U/dTDo0/kFKMtY/00etixOZfnCpPH+Vj9ckAWzaEdwkinT3ze/BxQTHJ2nhpyQRP9sudQPywQCe7HTKy7gmYouXv1UsZxSgg5T+vHTrQJUUBnBBwXXf4X994GJL4pS+CIvRI4lNsxljqLubdIS3wTwokAZzqRmgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522573; c=relaxed/simple;
	bh=vlNVD0EZKbOsiom2txKYsk2wrMtZ9NRpu4Q7k4xqdJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUtPDVKEbXmegrJL5vGmq29Uk4/uTdM97G/dDY9PdxbQfwb4A45PL2Sq9v7A5N+0rvI9UIvMJmfPFSroWsMzBR70UyRxNEPZVMLMtuOIUPt2mBdvZr8EpQDpbjrrXiDIKlG71/aITdII3kQWTJooOh15lOxED280tA975WvVc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbIGDVP1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d48f03a8bbso4685061fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711522569; x=1712127369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEhC8Rd/dGZdcGTLIVJ88DhHsuV/GHJuUT32hTDzmo8=;
        b=FbIGDVP1/V0anpXvhCB4TfzRU3dcITQf2C8kcJ7IvxkMwrYBnO7Jlzm+eWp1TSHXnk
         XGRvSsF7WtuUl8vfWVkTtMkooeGBLKqhiHtcprAH9PthOu6jrnsBCvBwcrRXc1xBZIPY
         q+3ydE9i9NjkeQkZksvJB5cdIIRoPkm+FmqlrqkUMetqNsJaPB1NKeOwF+Y7y6f3OzzH
         mgej1OjG5rMbzxMZrEKRhnSc5z35GSrSf2lKZvqoqHmiv+6WLGyBqZizY0AuLfcmX7Ly
         F5OYA+XyWdaK42KsEMPTGAl6is+8p1LfuUj8wcPbHqS9Bo0XmnTk8ATd1vNA4qqxVqZF
         ZArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522569; x=1712127369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEhC8Rd/dGZdcGTLIVJ88DhHsuV/GHJuUT32hTDzmo8=;
        b=jml4w53ugqA8O+JOyqN8j5usiKfWQjcMoFMLXc54Yl+VqOZ9d3hK0PKsO97euYEdk3
         UuzTkoeljLWDwyf0P5wRJZRVIwwtGH4o1PxVILIXt17OSpx4X8Aq0bBfs0nZlHP1QH6/
         kyQ19lQNlhhReEGXXJPiLhFHfcGamUm6KtTftJxzK7TIBfzlyJYvzVZe1X/yfqyZyz4n
         Chm1yG9cGSlensHWPu63vv4YcOLFp3zZuNP/w5UR30CTS/ZMiC0JFb4NSTnhxg59ZGo4
         +Yb0keyfQw6OyMon57QXhC042OTrYCYRGtnrDqehRbzebV/ghMqCxTB/Cs0DmW4ZyZYS
         NsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUFrCvW5H93z+ZteRwe2l876aycVbg0Sqw68BzN9PmOk9WlXbaaFToh451oWycapS5p2uyAGaqeVpul18HXBSeGS4zQoemS7Zv8Jvt/
X-Gm-Message-State: AOJu0YyKx74Ibv5TZbC3gtFrNaxJjPnzsGasLmepgpEjL2eTB5H2KkFo
	du+oG+4XbF8rjjR/GnxDOBhmVo7fKNz7d3RptKZurCOHB+FhiYe9toCfzjq0JzX1ulNhcoqg+p9
	hGtjhCfChJ3uEAB3sc5gpbof17v4=
X-Google-Smtp-Source: AGHT+IHAgurMjSG3ISiwdkjytkJzKdB3Xph10OvdzWTCMeYbNKDEtlPgl9slggTJYhUNYXNyMuU8/3IBiZ713ktIl+0=
X-Received: by 2002:a05:651c:1991:b0:2d4:9334:3c11 with SMTP id
 bx17-20020a05651c199100b002d493343c11mr1335574ljb.16.1711522569219; Tue, 26
 Mar 2024 23:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <20240326185032.72159-5-ryncsn@gmail.com>
 <87v858mbjh.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v858mbjh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 14:55:53 +0800
Message-ID: <CAMgjq7B0rDp_u37XG0JWyFci6s9NmGd3gdasOwU0RRZBYTqquw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] mm/swap: remove cache bypass swapin
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:32=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > We used to have the cache bypass swapin path for better performance,
> > but by removing it, more optimization can be applied and have
> > an even better overall performance and less hackish.
> >
> > And these optimizations are not easily doable or not doable at all
> > without this.
> >
> > This patch simply removes it, and the performance will drop heavily
> > for simple swapin, things won't get this worse for real workloads
> > but still observable. Following commits will fix this and archive a
> > better performance.
> >
> > Swapout/in 30G zero pages from ZRAM (This mostly measures overhead
> > of swap path itself, because zero pages are not compressed but simply
> > recorded in ZRAM, and performance drops more as SWAP device is getting
> > full):
> >
> > Test result of sequential swapin/out:
> >
> >                Before (us)        After (us)
> > Swapout:       33619409           33624641
> > Swapin:        32393771           41614858 (-28.4%)
> > Swapout (THP): 7817909            7795530
> > Swapin (THP) : 32452387           41708471 (-28.4%)
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 18 ++++-------------
> >  mm/swap.h       | 10 +++++-----
> >  mm/swap_state.c | 53 ++++++++++---------------------------------------
> >  mm/swapfile.c   | 13 ------------
> >  4 files changed, 19 insertions(+), 75 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index dfdb620a9123..357d239ee2f6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3932,7 +3932,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       struct page *page;
> >       struct swap_info_struct *si =3D NULL;
> >       rmap_t rmap_flags =3D RMAP_NONE;
> > -     bool need_clear_cache =3D false;
> >       bool exclusive =3D false;
> >       swp_entry_t entry;
> >       pte_t pte;
> > @@ -4000,14 +3999,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > -                     /* skip swapcache and readahead */
> >                       folio =3D swapin_direct(entry, GFP_HIGHUSER_MOVAB=
LE, vmf);
> > -                     if (PTR_ERR(folio) =3D=3D -EBUSY)
> > -                             goto out;
> > -                     need_clear_cache =3D true;
> >               } else {
> >                       folio =3D swapin_readahead(entry, GFP_HIGHUSER_MO=
VABLE, vmf);
> > -                     swapcache =3D folio;
> >               }
> >
> >               if (!folio) {
> > @@ -4023,6 +4017,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                       goto unlock;
> >               }
> >
> > +             swapcache =3D folio;
> >               page =3D folio_file_page(folio, swp_offset(entry));
> >
> >               /* Had to read the page from swap area: Major fault */
> > @@ -4187,7 +4182,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       vmf->orig_pte =3D pte;
> >
> >       /* ksm created a completely new copy */
> > -     if (unlikely(folio !=3D swapcache && swapcache)) {
> > +     if (unlikely(folio !=3D swapcache)) {
> >               folio_add_new_anon_rmap(folio, vma, vmf->address);
> >               folio_add_lru_vma(folio, vma);
> >       } else {
> > @@ -4201,7 +4196,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> >
> >       folio_unlock(folio);
> > -     if (folio !=3D swapcache && swapcache) {
> > +     if (folio !=3D swapcache) {
> >               /*
> >                * Hold the lock to avoid the swap entry to be reused
> >                * until we take the PT lock for the pte_same() check
> > @@ -4227,9 +4222,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
> >  out:
> > -     /* Clear the swap cache pin for direct swapin after PTL unlock */
> > -     if (need_clear_cache)
> > -             swapcache_clear(si, entry);
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
> > @@ -4240,12 +4232,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       folio_unlock(folio);
> >  out_release:
> >       folio_put(folio);
> > -     if (folio !=3D swapcache && swapcache) {
> > +     if (folio !=3D swapcache) {
> >               folio_unlock(swapcache);
> >               folio_put(swapcache);
> >       }
> > -     if (need_clear_cache)
> > -             swapcache_clear(si, entry);
> >       if (si)
> >               put_swap_device(si);
> >       return ret;
> > diff --git a/mm/swap.h b/mm/swap.h
> > index aee134907a70..ac9573b03432 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct folio *folio,
> >  void delete_from_swap_cache(struct folio *folio);
> >  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                                 unsigned long end);
> > -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> >  struct folio *swap_cache_get_folio(swp_entry_t entry,
> >               struct vm_area_struct *vma, unsigned long addr);
> >  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> > @@ -100,14 +99,15 @@ static inline struct folio *swapin_readahead(swp_e=
ntry_t swp, gfp_t gfp_mask,
> >  {
> >       return NULL;
> >  }
> > -
> > -static inline int swap_writepage(struct page *p, struct writeback_cont=
rol *wbc)
> > +static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t fla=
g,
> > +                     struct vm_fault *vmf);
> >  {
> > -     return 0;
> > +     return NULL;
> >  }
> >
> > -static inline void swapcache_clear(struct swap_info_struct *si, swp_en=
try_t entry)
> > +static inline int swap_writepage(struct page *p, struct writeback_cont=
rol *wbc)
> >  {
> > +     return 0;
> >  }
> >
> >  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 2a9c6bdff5ea..49ef6250f676 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -880,61 +880,28 @@ static struct folio *swap_vma_readahead(swp_entry=
_t targ_entry, gfp_t gfp_mask,
> >  }
> >
> >  /**
> > - * swapin_direct - swap in folios skipping swap cache and readahead
> > + * swapin_direct - swap in folios skipping readahead
> >   * @entry: swap entry of this memory
> >   * @gfp_mask: memory allocation flags
> >   * @vmf: fault information
> >   *
> > - * Returns the struct folio for entry and addr after the swap entry is=
 read
> > - * in.
> > + * Returns the folio for entry after it is read in.
> >   */
> >  struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
> >                           struct vm_fault *vmf)
> >  {
> > -     struct vm_area_struct *vma =3D vmf->vma;
> > +     struct mempolicy *mpol;
> >       struct folio *folio;
> > -     void *shadow =3D NULL;
> > -
> > -     /*
> > -      * Prevent parallel swapin from proceeding with
> > -      * the cache flag. Otherwise, another thread may
> > -      * finish swapin first, free the entry, and swapout
> > -      * reusing the same entry. It's undetectable as
> > -      * pte_same() returns true due to entry reuse.
> > -      */
> > -     if (swapcache_prepare(entry)) {
> > -             /* Relax a bit to prevent rapid repeated page faults */
> > -             schedule_timeout_uninterruptible(1);
> > -             return ERR_PTR(-EBUSY);
> > -     }
> > -
> > -     /* skip swapcache */
> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> > -                             vma, vmf->address, false);
> > -     if (folio) {
> > -             __folio_set_locked(folio);
> > -             __folio_set_swapbacked(folio);
> > -
> > -             if (mem_cgroup_swapin_charge_folio(folio,
> > -                                     vma->vm_mm, GFP_KERNEL,
> > -                                     entry)) {
> > -                     folio_unlock(folio);
> > -                     folio_put(folio);
> > -                     return NULL;
> > -             }
> > -             mem_cgroup_swapin_uncharge_swap(entry);
> > -
> > -             shadow =3D get_shadow_from_swap_cache(entry);
> > -             if (shadow)
> > -                     workingset_refault(folio, shadow);
> > +     bool page_allocated;
> > +     pgoff_t ilx;
> >
> > -             folio_add_lru(folio);
> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> > +     folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
> > +                                     &page_allocated, false);
> > +     mpol_cond_put(mpol);
> >
> > -             /* To provide entry to swap_read_folio() */
> > -             folio->swap =3D entry;
> > +     if (page_allocated)
> >               swap_read_folio(folio, true, NULL);
> > -             folio->private =3D NULL;
> > -     }
> >
> >       return folio;
> >  }
>
> This looks similar as read_swap_cache_async().  Can we merge them?

Yes, that's doable. But I may have to split it out again for later
optimizations though.

>
> And, we should avoid to readahead in swapin_readahead() or
> swap_vma_readahead() for SWP_SYNCHRONOUS_IO anyway.  So, it appears that
> we can change and use swapin_readahead() directly?

Good point, SWP_SYNCHRONOUS_IO check can be extended more after this
series, but readahead optimization could be another series (like the
previous one which tried to unify readahead for shmem/anon), so I
thought it's better to keep it untouched for now.

