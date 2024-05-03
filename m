Return-Path: <linux-kernel+bounces-168400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BA8BB82F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82260284A95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A084D1F;
	Fri,  3 May 2024 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR88HeuC"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC383CD6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778629; cv=none; b=qP4U9Y2ZexDOlA8wUD+00NMbJv4IIaRUmD7mp2upprFJzATORzX8aAVEEieSm5me8cFX1TG+DUsQQRtyZ61rM5dZKx0DR4KpRYOtQOLmYQ2vXyN6llK2gXdtNq+AgcTqTlr4r91aSnATmj98hNh3Jmtgwysmaxh1b4Jp0sqwnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778629; c=relaxed/simple;
	bh=EirfbLTraUcTJ5TyAgJNtOe2441vCn2d0l8nMzP3930=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5ZEksTJITlWHAXMXexjE21ZaCBXi33yg7DUBo6vACLgliuuV/i5/JjgiqJGeDO42kzPRt552nFLn3K2lu4wOKGBUYW8DrIQou6ZGU4SBekMSCaQIxOOk/MYmV+39/R0iM43uhwm36sX0z5WqXbJz1YcmMFlIUDW4qJMzFaB7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR88HeuC; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f4276765d9so1120834241.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714778626; x=1715383426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6H3VTScbmcVWBWXc10KvGJjTYbdsx8It8h7yZ/13J0=;
        b=VR88HeuCeTx2qli93iLgSpIbXhVcWc0+84NIuGCrM+IPVFmo598D9tk1thjKTtpWIE
         EeSxYOZlXp3eH7u1gE/rk2P9+WyC+N8sbawktpz3TfKQh6fE6A/O1JU2Qd+TxCXXx0Ju
         fgFOtE1T8uSSpEvwtC0klZs7oR38Jq9HBlzttnTNc4yqmaAvQQ1zsMD7vBENc3nBgag3
         6Y/931KiI+qudks9+GhR0ch7nqrFbLqzQ44XjOBUmqgers/ORB9/X7AqH30Bb2VppWo+
         M+JkBZLiCRhiHOWU7N8rpUzxHfqnRYG+muIQfFWYE0DmSQLhAGOLNE7oClg7+sXHfwbr
         vE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778626; x=1715383426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6H3VTScbmcVWBWXc10KvGJjTYbdsx8It8h7yZ/13J0=;
        b=pIr8jw3wOr314Wy/r63CH61Mzj6HV2IuzUITadrcb6Fu716Bag3c+iLdQGRcwdpjos
         IU3MGMdVAsadu/cPjxqDBr9DZRwubh1cyeejKLYitDGaKNqjxrhB7xBPWteS7mhgTUgj
         PRj486fbywN5Q7GFlnyy2ltnZi57qDs9rJAlYbh+eUGDzmfSXA2QPkMV4CNLMOjK7E6H
         0ojzU0wdQL1O+EjOn9kqzkOKP5X5HUaS2q3LduhRHUKPmGrK8GlL2XLjd+XiBNmwfFNL
         tRDfCNF9yohwtjXYKzfvszdgza4USXJ0jB3yMaOks5M1oPnDrnEun+8PjQ9WjLhYQYtr
         TOQg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBPYf6LePte6IKZeJ913y4WA2Sr1MZrW2SDw9erQl3vv0pDswYHFQWFXFCj8cqi8pjKsK4vqpo0L2RQ3wz2n9iw4FXT7weTB0ILNG
X-Gm-Message-State: AOJu0YwiRbc58W0EEnm/PNFFSSr7+A0PpB1Lp3DhRNqjWdg0EIoj996w
	VHPrTBIX7TdwF1tpW8ja+fo+HAO4Hpes1jStbTYM/TabW+eMwB18aS2BFkW8nGdec/M/393o2ar
	0idRXPp+F2TXieIuGawjZKJpm8J4=
X-Google-Smtp-Source: AGHT+IG+AXjs1RQlhTgaI/RXMSpA48vwAUgsjbX2UUARv0h3jAYddD1sr3GQUldKCmr4+7Wo8TjXACVTAx4PS0N1epw=
X-Received: by 2002:a05:6122:1da1:b0:4d8:7d49:18fe with SMTP id
 gg33-20020a0561221da100b004d87d4918femr10218903vkb.4.1714778626450; Fri, 03
 May 2024 16:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
In-Reply-To: <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 4 May 2024 07:23:35 +0800
Message-ID: <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:50=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 03/05/2024 01:50, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > When a large folio is found in the swapcache, the current implementatio=
n
> > requires calling do_swap_page() nr_pages times, resulting in nr_pages
> > page faults. This patch opts to map the entire large folio at once to
> > minimize page faults. Additionally, redundant checks and early exits
> > for ARM64 MTE restoring are removed.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> With the suggested changes below:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> > ---
> >  mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 48 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 22e7c33cc747..940fdbe69fa1 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >       void *shadow =3D NULL;
> > +     int nr_pages =3D 1;
> > +     unsigned long page_idx =3D 0;
> > +     unsigned long address =3D vmf->address;
> > +     pte_t *ptep;
>
> nit: Personally I'd prefer all these to get initialised just before the "=
if
> (folio_test_large()..." block below. That way it is clear they are fresh =
(incase
> any logic between here and there makes an adjustment) and its clear that =
they
> are only to be used after that block (the compiler will warn if using an
> uninitialized value).

right. I agree this will make the code more readable.

>
> >
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> > @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               goto out_nomap;
> >       }
> >
> > +     ptep =3D vmf->pte;
> > +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> > +             int nr =3D folio_nr_pages(folio);
> > +             unsigned long idx =3D folio_page_idx(folio, page);
> > +             unsigned long folio_start =3D vmf->address - idx * PAGE_S=
IZE;
> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
> > +             pte_t *folio_ptep;
> > +             pte_t folio_pte;
> > +
> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, v=
ma->vm_start)))
> > +                     goto check_folio;
> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->=
vm_end)))
> > +                     goto check_folio;
> > +
> > +             folio_ptep =3D vmf->pte - idx;
> > +             folio_pte =3D ptep_get(folio_ptep);
> > +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pt=
e, -idx)) ||
> > +                 swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr)
> > +                     goto check_folio;
> > +
> > +             page_idx =3D idx;
> > +             address =3D folio_start;
> > +             ptep =3D folio_ptep;
> > +             nr_pages =3D nr;
> > +             entry =3D folio->swap;
> > +             page =3D &folio->page;
> > +     }
> > +
> > +check_folio:
>
> Is this still the correct label name, given the checks are now above the =
new
> block? Perhaps "one_page" or something like that?

not quite sure about this, as the code after one_page can be multiple_pages=
.
On the other hand, it seems we are really checking folio after "check_folio=
"
:-)


BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));

/*
* Check under PT lock (to protect against concurrent fork() sharing
* the swap entry concurrently) for certainly exclusive pages.
*/
if (!folio_test_ksm(folio)) {


>
> > +
> >       /*
> >        * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swa=
p pte
> >        * must never point at an anonymous page in the swapcache that is
> > @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * We're already holding a reference on the page but haven't mapp=
ed it
> >        * yet.
> >        */
> > -     swap_free_nr(entry, 1);
> > +     swap_free_nr(entry, nr_pages);
> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >               folio_free_swap(folio);
> >
> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +     folio_ref_add(folio, nr_pages - 1);
> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> >       pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >       /*
> > @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * exclusivity.
> >        */
> >       if (!folio_test_ksm(folio) &&
> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
>
> I think in practice there is no change here? If nr_pages > 1 then the fol=
io is
> in the swapcache, so there is an extra ref on it? I agree with the change=
 for
> robustness sake. Just checking my understanding.

This is the code showing we are reusing/(mkwrite) a folio either
1. we meet a small folio and we are the only one hitting the small folio
2. we meet a large folio and we are the only one hitting the large folio

any corner cases besides the above two seems difficult. for example,

while we hit a large folio in swapcache but if we can't entirely map it
(nr_pages=3D=3D1) due to partial unmap, we will have folio_ref_count(folio)
=3D=3D nr_pages =3D=3D 1, in this case, lacking  folio_nr_pages(folio) =3D=
=3D nr_pages
might lead to mkwrite() on a single pte within a partially unmapped large
folio. not quite sure this is wrong, but seems buggy and arduous.

>
> >               if (vmf->flags & FAULT_FLAG_WRITE) {
> >                       pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >                       vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >               }
> >               rmap_flags |=3D RMAP_EXCLUSIVE;
> >       }
> > -     flush_icache_page(vma, page);
> > +     flush_icache_pages(vma, page, nr_pages);
> >       if (pte_swp_soft_dirty(vmf->orig_pte))
> >               pte =3D pte_mksoft_dirty(pte);
> >       if (pte_swp_uffd_wp(vmf->orig_pte))
> >               pte =3D pte_mkuffd_wp(pte);
> > -     vmf->orig_pte =3D pte;
> > +     vmf->orig_pte =3D pte_advance_pfn(pte, page_idx);
> >
> >       /* ksm created a completely new copy */
> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> > -             folio_add_new_anon_rmap(folio, vma, vmf->address);
> > +             folio_add_new_anon_rmap(folio, vma, address);
> >               folio_add_lru_vma(folio, vma);
> >       } else {
> > -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> > +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addr=
ess,
> >                                       rmap_flags);
> >       }
> >
> >       VM_BUG_ON(!folio_test_anon(folio) ||
> >                       (pte_write(pte) && !PageAnonExclusive(page)));
> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -     arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
> > -                     pte, vmf->orig_pte, 1);
> > +     set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
> > +     arch_do_swap_page_nr(vma->vm_mm, vma, address,
> > +                     pte, pte, nr_pages);
> >
> >       folio_unlock(folio);
> >       if (folio !=3D swapcache && swapcache) {
> > @@ -4291,7 +4327,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       }
> >
> >       /* No need to invalidate - it was non-present before */
> > -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> > +     update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
> >  unlock:
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
>

Thanks
Barry

