Return-Path: <linux-kernel+bounces-144804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695278A4AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C57282C79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308633BBEF;
	Mon, 15 Apr 2024 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWgtbSdf"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A03B297
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171248; cv=none; b=rJI+9Uz7MtS/fRtryCXgsSwR1Gc8t7Coo6L9PgYR+r0StIDMzgdJMQn2ZO2tzQfuRsXGMIBdZ1/rsmkB1D82DximtraYBTLUELhZ7sx2W5iPVfmRHPgROBzQ0lVHIrU6FYnpAvcqXOG5lZmMbyaF+I52ONCS3p2O7ghAxrqKC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171248; c=relaxed/simple;
	bh=6C7aFXJSJ+z8mxeahL+2cgD9rVs4Pu4AeXEsea6VF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGGWlOCpnlrahwTRFA4iiqSc9172THdft06yVHE2XeoTHXVdJ06UHiiAFcwynoyWDhey+aMkYi+S1cjJwGwX6s2Q1EQAAytxaNOZGp0aN73ce+VPw6XpHCRiOU5pknDRRkrYmw7ad34MJKDhtb7Aj+99XuyJoXOV5QCh6rl+GMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWgtbSdf; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-479cbfc62e9so986531137.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713171245; x=1713776045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqaOA4e4etYyGaYx92IKEUY9XvmlanxSJfs5hIy4nr0=;
        b=MWgtbSdffbXC0PZFbFDSuZG/qDQwB0at+VYo+dVTR05QG37ZYyywYbFrwxaOG5u6MA
         YAgMQXi/PUXEeJgepmwU7kGfyM6NXMXFh1a8A+Jse/Qi31/WCz3/nWiNYz8ipCx2vNg5
         lSTa3saXrPY4/91NTHBx3ekByuE5EXQLp89W8RY3n42oKwvx6tWduYONqQk1ClbuGbGm
         jTrFSXk90B4vGhf+LpMX3Cr+ZzHbL/X/mcUTljKJMPdbDixT5I5G0AFjErvCaDvyB2HV
         zHm+ksAS+n1vuUjZ8vPBCP8a7D5xDqUye17L8VfhRykx7taP/0ouPtGC+1UjV61SgLXA
         lm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171245; x=1713776045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqaOA4e4etYyGaYx92IKEUY9XvmlanxSJfs5hIy4nr0=;
        b=c0uFVP0mA4VTkiYiwASh8agF7FTcER+1ShcWdBi9bhwrxgo9EspRcTnRSdgRfwPABV
         zXhAB8RoEnSjE5AQrXbulRi00SUtv3LP5KNAKp7je5t+45wbqSsPKFmA+Wm7CUKhAhIE
         XmUeN2dnWsK5J+PvkMkAHgV4VHns+LehyXLUHeq/Kwb+J4TGrRYYhlsnweBX0NoTgrd3
         l4iszau+cxorpOpJahw5bN+5RgzDeDuVxur9GE1iSDxybW4PW+Y564p8DWH46GJ5c/S7
         XJ8zfsjOT4VzB68G6+0LA1tYOotuTXgbQFaE8Xyj9NgmmsOqqehNnC2COqWR0CGbd1I4
         lYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPL+I6U5ShcrGk8X4SpJ2HIPNWAgoJ6cMVkMcZj30iWBwew4ZlFSXLgBETfnjfCaZ3f1ezdxM0EMn0pVkF6KiC/xaGu3fjyBkHU6vj
X-Gm-Message-State: AOJu0YzzVFK4KZZL4opYn8qeqj/K2o2LFhwafbDmUUep+UMTIYvrHOlV
	JCwgy/hszY1XwbFDo/qOyv6b3wd7ydg9lvxP/OoXxHI2af6q65E1IL+lZ7GACX+TJfwLnapnERt
	2faFCVlP1gljobQYgWSDmKMSTQMI=
X-Google-Smtp-Source: AGHT+IEW7GuLmdP9spD1ctuyEzlNeLdDIwTFD1t6zGstoAmWFaz6uN3vd9eD3c+t/i5fxH46HUdEQlYa0YgaGnY5tOk=
X-Received: by 2002:a05:6102:e09:b0:47a:3a7c:70bb with SMTP id
 o9-20020a0561020e0900b0047a3a7c70bbmr12706001vst.29.1713171245320; Mon, 15
 Apr 2024 01:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-5-21cnbao@gmail.com>
 <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 15 Apr 2024 20:53:53 +1200
Message-ID: <CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
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
> > ---
> >  mm/memory.c | 64 +++++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 52 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c4a52e8d740a..9818dc1893c8 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3947,6 +3947,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       pte_t pte;
> >       vm_fault_t ret =3D 0;
> >       void *shadow =3D NULL;
> > +     int nr_pages =3D 1;
> > +     unsigned long start_address =3D vmf->address;
> > +     pte_t *start_pte =3D vmf->pte;
>
> IMHO, it's better to rename the above 2 local variables to "address" and
> "ptep".  Just my personal opinion.  Feel free to ignore the comments.

fine.

>
> > +     bool any_swap_shared =3D false;
> >
> >       if (!pte_unmap_same(vmf))
> >               goto out;
> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        */
> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->addre=
ss,
> >                       &vmf->ptl);
>
> We should move pte check here.  That is,
>
>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
>                 goto out_nomap;
>
> This will simplify the situation for large folio.

the plan is moving the whole code block

if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio))

after
        if (unlikely(!folio_test_uptodate(folio))) {
                ret =3D VM_FAULT_SIGBUS;
                goto out_nomap;
        }

though we couldn't be !folio_test_uptodate(folio)) for hitting
swapcache but it seems
logically better for future use.

>
> > +
> > +     /* We hit large folios in swapcache */
>
> The comments seems unnecessary because the code tells that already.
>
> > +     if (start_pte && folio_test_large(folio) && folio_test_swapcache(=
folio)) {
> > +             int nr =3D folio_nr_pages(folio);
> > +             int idx =3D folio_page_idx(folio, page);
> > +             unsigned long folio_start =3D vmf->address - idx * PAGE_S=
IZE;
> > +             unsigned long folio_end =3D folio_start + nr * PAGE_SIZE;
> > +             pte_t *folio_ptep;
> > +             pte_t folio_pte;
> > +
> > +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, v=
ma->vm_start)))
> > +                     goto check_pte;
> > +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->=
vm_end)))
> > +                     goto check_pte;
> > +
> > +             folio_ptep =3D vmf->pte - idx;
> > +             folio_pte =3D ptep_get(folio_ptep);
>
> It's better to construct pte based on fault PTE via generalizing
> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we can find
> inconsistent PTEs quicker.

it seems your point is getting the pte of page0 by pte_next_swp_offset()
unfortunately pte_next_swp_offset can't go back. on the other hand,
we have to check the real pte value of the 0nd entry right now because
swap_pte_batch() only really reads pte from the 1st entry. it assumes
pte argument is the real value for the 0nd pte entry.

static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
{
        pte_t expected_pte =3D pte_next_swp_offset(pte);
        const pte_t *end_ptep =3D start_ptep + max_nr;
        pte_t *ptep =3D start_ptep + 1;

        VM_WARN_ON(max_nr < 1);
        VM_WARN_ON(!is_swap_pte(pte));
        VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));

        while (ptep < end_ptep) {
                pte =3D ptep_get(ptep);

                if (!pte_same(pte, expected_pte))
                        break;

                expected_pte =3D pte_next_swp_offset(expected_pte);
                ptep++;
        }

        return ptep - start_ptep;
}

>
> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_=
entry(folio_pte)) ||
> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_s=
hared) !=3D nr)
> > +                     goto check_pte;
> > +
> > +             start_address =3D folio_start;
> > +             start_pte =3D folio_ptep;
> > +             nr_pages =3D nr;
> > +             entry =3D folio->swap;
> > +             page =3D &folio->page;
> > +     }
> > +
> > +check_pte:
> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
> >               goto out_nomap;
> >
> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                        */
> >                       exclusive =3D false;
> >               }
> > +
> > +             /* Reuse the whole large folio iff all entries are exclus=
ive */
> > +             if (nr_pages > 1 && any_swap_shared)
> > +                     exclusive =3D false;
> >       }
> >
> >       /*
> > @@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * We're already holding a reference on the page but haven't mapp=
ed it
> >        * yet.
> >        */
> > -     swap_free(entry);
> > +     swap_free_nr(entry, nr_pages);
> >       if (should_try_to_free_swap(folio, vma, vmf->flags))
> >               folio_free_swap(folio);
> >
> > -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +     folio_ref_add(folio, nr_pages - 1);
> > +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > +
> >       pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >       /*
> > @@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >        * exclusivity.
> >        */
> >       if (!folio_test_ksm(folio) &&
> > -         (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > +         (exclusive || (folio_ref_count(folio) =3D=3D nr_pages &&
> > +                        folio_nr_pages(folio) =3D=3D nr_pages))) {
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
> >
> >       /* ksm created a completely new copy */
> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> > -             folio_add_new_anon_rmap(folio, vma, vmf->address);
> > +             folio_add_new_anon_rmap(folio, vma, start_address);
> >               folio_add_lru_vma(folio, vma);
> >       } else {
> > -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> > -                                     rmap_flags);
> > +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, star=
t_address,
> > +                                      rmap_flags);
> >       }
> >
> >       VM_BUG_ON(!folio_test_anon(folio) ||
> >                       (pte_write(pte) && !PageAnonExclusive(page)));
> > -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -     arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_p=
te);
> > +     set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> > +     vmf->orig_pte =3D ptep_get(vmf->pte);
> > +     arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
>
> Do we need to call arch_do_swap_page() for each subpage?  IIUC, the
> corresponding arch_unmap_one() will be called for each subpage.

i actually thought about this very carefully, right now, the only one who
needs this is sparc and it doesn't support THP_SWAPOUT at all. and
there is no proof doing restoration one by one won't really break sparc.
so i'd like to defer this to when sparc really needs THP_SWAPOUT.
on the other hand, it seems really bad we have both

arch_swap_restore  - for this, arm64 has moved to using folio
and
arch_do_swap_page

we should somehow unify them later if sparc wants THP_SWPOUT.

>
> >       folio_unlock(folio);
> >       if (folio !=3D swapcache && swapcache) {
> > @@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       }
> >
> >       /* No need to invalidate - it was non-present before */
> > -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> > +     update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pag=
es);
> >  unlock:
> >       if (vmf->pte)
> >               pte_unmap_unlock(vmf->pte, vmf->ptl);
>
> --
> Best Regards,
> Huang, Ying

