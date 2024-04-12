Return-Path: <linux-kernel+bounces-141806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE0D8A23B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC1B24066
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6551094E;
	Fri, 12 Apr 2024 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbaBVulv"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E638D299
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887791; cv=none; b=HRyTT4To9SmB5K+jMTOnH1hLKIU3Wylf5FpFltGdH+cefQIWx/qSb+uYOoNBcTQ5MrRi17DTDVWq+cW7RfmZQUKvSULZxW5rOsEUSr8jGgw/M/s4wwJymTVBk0Fzyk2qYqPTz0YcVrCP39lN6pIZ5p2kRa/CVyDzWpTCb9zbG2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887791; c=relaxed/simple;
	bh=jfUntjJnH+OMHbD2BxQnSCfIyTkNUXTJUh3haHMU/3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBU7QWLnNM+wWy6oF/dshYEsoKNWCf8loGU8ry0Zdhz8FagalhHP3SnaFvFIw+oWhBs4bT9/NYgtUFjgmJADgSTYIUz5rHaO/dVi85ABQaXfPnoo3uuEEDnl2IoLgA7KmMWZ1hvNXq56rOFiNsPfi+YvXo4qgX0n86UFXxy5FT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbaBVulv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso492990a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712887787; x=1713492587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x41aUECQyH1uJoELeJiHibMz7iZeQsBZdUA9Cc2JC0Q=;
        b=EbaBVulv+XTyQKAALbHZW6Opk2cgpaqSHbXCT0afU+xAvAVnT/3z9tRpctsXvwcPoo
         dToLojclruIUiTRb1g6+ao+ZdktrE11qcjx8wk0IfrRq8v/DMqThYuyvWcF/35+pRH7j
         tRIpQuURLNfi7OPh3RhgagTnhVl2je+KmzQNMpH3HuSb7sIVeiRy82gmKa07QlMYgCpy
         TDhGk2RoWxSjxgVDX9cbL/ipEOrdXfHd9pKqT0EeG8qeMC39lKR8bs9vDFn+jgLnzcpj
         ZRwlexdrNjYB+ZP3vBo2UcfVx9mSdqn5dLq8C27pngFHIeq+XQXR5+PB99GGQCnzfkJN
         gfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887787; x=1713492587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x41aUECQyH1uJoELeJiHibMz7iZeQsBZdUA9Cc2JC0Q=;
        b=oE7u28PiXpN7QeO495USzgWsJdrypOiH19FTFZa4QBv710r9qZkNSC9FPPTwTDuxfz
         udIX3mdQ/9nXvYfUhIGmsqCYbEYesyJQJg5vzNJZHQqhKFhD0csMMtpdc3u16GgVhXiW
         R4bquxSjXu3KxZ7DXzBlhL/R3bhc6enR6ajpH62psHL3Wf79P+xDj20l1e7nDhCW7QKk
         ddtwpmY5s6d+HYAqr8glDYDfOKivqSXhQA/ES00iTGFsKccKs0EUlCayIWkuuXVBexor
         5OtdvNPVcURtAZXeBXHtw4V7BT4iLgmSCePqVFymttVvfnOwXOLiy34t3jlztZgHaJ88
         sc4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZmPKF8VU0bWcobFBMf8O8PfnBeGPnPr3jPR06ZbnasvNp5RZthBkMGMIMI/I8y9bVT08d0E92bo5hc9bkzju28vf/XEkwlAtNILfX
X-Gm-Message-State: AOJu0YxJuS62vJ2Rh+5DvVKgmVyxnoyk46l4G/97AyeVBWcH+X0daAEj
	Xa+YzFwysVfOapZkqyPJ7yq5RohC4N10nu79OaECJNNg5MGZ24ZzdsLykgjgKZiRySrieC+NkMI
	MzLJjE0UjVwSkKDRCKxEOcxTqdicqXkO/
X-Google-Smtp-Source: AGHT+IGLOacDFDocnZwYMyuilqXHN9H+0VBuzfNXqCGXgGq5ADANxEeokXkpwDcR21MNsW/eQtXwE9p6m2AQrcl5OTM=
X-Received: by 2002:a50:d642:0:b0:56d:fdb3:bcc5 with SMTP id
 c2-20020a50d642000000b0056dfdb3bcc5mr824684edj.12.1712887787112; Thu, 11 Apr
 2024 19:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240408042437.10951-3-ioworker0@gmail.com>
 <3cd1036d-3814-4a10-b6d2-099937ceabc8@arm.com>
In-Reply-To: <3cd1036d-3814-4a10-b6d2-099937ceabc8@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 12 Apr 2024 10:09:36 +0800
Message-ID: <CAK1f24m=nC=ecuOZesQvytnxJms2d-wONKT4_7GUfvz0PJz+oQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm/arm64: override mkold_clean_ptes() batch helper
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:17=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 08/04/2024 05:24, Lance Yang wrote:
> > The per-pte get_and_clear/modify/set approach would result in
> > unfolding/refolding for contpte mappings on arm64. So we need
> > to override mkold_clean_ptes() for arm64 to avoid it.
>
> IIRC, in the last version, I suggested copying the wrprotect_ptes() patte=
rn to
> correctly iterate over contpte blocks. I meant for you to take it as insp=
iration
> but looks like you have done a carbon copy, including lots of things that=
 are
> unneeded here. That's my fault for not being clear - sorry!

My bad. I must have misunderstood your intention.

>
>
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Barry Song <21cnbao@gmail.com>
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/contpte.c          | 15 +++++++++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 9fd8613b2db2..395754638a9a 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1223,6 +1223,34 @@ static inline void __wrprotect_ptes(struct mm_st=
ruct *mm, unsigned long address,
> >               __ptep_set_wrprotect(mm, address, ptep);
> >  }
> >
> > +static inline void ___ptep_mkold_clean(struct mm_struct *mm, unsigned =
long addr,
> > +                                    pte_t *ptep, pte_t pte)
> > +{
> > +     pte_t old_pte;
> > +
> > +     do {
> > +             old_pte =3D pte;
> > +             pte =3D pte_mkclean(pte_mkold(pte));
> > +             pte_val(pte) =3D cmpxchg_relaxed(&pte_val(*ptep),
> > +                                            pte_val(old_pte), pte_val(=
pte));
> > +     } while (pte_val(pte) !=3D pte_val(old_pte));
> > +}
>
> Given you are clearing old and dirty, you have nothing to race against, s=
o you
> shouldn't need the cmpxchg loop here; just a get/modify/set should do? Of=
 course
> if you are setting one or the other, then you need the loop.

Got it.

>
> > +
> > +static inline void __ptep_mkold_clean(struct mm_struct *mm, unsigned l=
ong addr,
> > +                                   pte_t *ptep)
> > +{
> > +     ___ptep_mkold_clean(mm, addr, ptep, __ptep_get(ptep));
> > +}
>
> I don't see a need for this intermediate function.
>
> > +
> > +static inline void __mkold_clean_ptes(struct mm_struct *mm, unsigned l=
ong addr,
> > +                                   pte_t *ptep, unsigned int nr)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < nr; i++, addr +=3D PAGE_SIZE, ptep++)
>
> It would probably be good to use the for() loop pattern used by the gener=
ic
> impls here too.

Got it.

>
> > +             __ptep_mkold_clean(mm, addr, ptep);
> > +}
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
> >  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> > @@ -1379,6 +1407,8 @@ extern void contpte_wrprotect_ptes(struct mm_stru=
ct *mm, unsigned long addr,
> >  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                               unsigned long addr, pte_t *ptep,
> >                               pte_t entry, int dirty);
> > +extern void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned lo=
ng addr,
> > +                             pte_t *ptep, unsigned int nr);
> >
> >  static __always_inline void contpte_try_fold(struct mm_struct *mm,
> >                               unsigned long addr, pte_t *ptep, pte_t pt=
e)
> > @@ -1603,6 +1633,30 @@ static inline int ptep_set_access_flags(struct v=
m_area_struct *vma,
> >       return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirt=
y);
> >  }
> >
> > +#define mkold_clean_ptes mkold_clean_ptes
> > +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned lon=
g addr,
> > +                                 pte_t *ptep, unsigned int nr)
> > +{
> > +     if (likely(nr =3D=3D 1)) {
> > +             /*
> > +              * Optimization: mkold_clean_ptes() can only be called fo=
r present
> > +              * ptes so we only need to check contig bit as condition =
for unfold,
> > +              * and we can remove the contig bit from the pte we read =
to avoid
> > +              * re-reading. This speeds up madvise(MADV_FREE) which is=
 sensitive
> > +              * for order-0 folios. Equivalent to contpte_try_unfold()=
.
> > +              */
>
> Is this true? Do you have data that shows the cost? If not, I'd prefer to=
 avoid
> the optimization and do it the more standard way:
>
> contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>
> > +             pte_t orig_pte =3D __ptep_get(ptep);
> > +
> > +             if (unlikely(pte_cont(orig_pte))) {
> > +                     __contpte_try_unfold(mm, addr, ptep, orig_pte);
> > +                     orig_pte =3D pte_mknoncont(orig_pte);
> > +             }
> > +             ___ptep_mkold_clean(mm, addr, ptep, orig_pte);
> > +     } else {
> > +             contpte_mkold_clean_ptes(mm, addr, ptep, nr);
> > +     }
>
> ...but I don't think you should ever need to unfold in the first place. E=
ven if
> it's folded and you are trying to clear access/dirty for a single pte, yo=
u can
> just clear the whole block. See existing comment in
> contpte_ptep_test_and_clear_young().

Thanks for pointing that out.

>
> So this ends up as something like:
>
> static inline void clear_young_dirty_ptes(struct mm_struct *mm,
>                         unsigned long addr, pte_t *ptep, unsigned int nr,
>                         bool clear_young, bool clear_dirty)
> {
>         if (likely(nr =3D=3D 1 && !pte_cont(__ptep_get(ptep))))
>                 clear_young_dirty_ptes(mm, addr, ptep, nr,
>                                         clear_young, clear_dirty);
>         else
>                 contpte_clear_young_dirty_ptes(mm, addr, ptep, nr,
>                                         clear_young, clear_dirty);
> }

Nice. I'll make sure to follow this approach.

>
>
> > +}
> > +
> >  #else /* CONFIG_ARM64_CONTPTE */
> >
> >  #define ptep_get                             __ptep_get
> > @@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >  #define wrprotect_ptes                               __wrprotect_ptes
> >  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> >  #define ptep_set_access_flags                        __ptep_set_access=
_flags
> > +#define mkold_clean_ptes                     __mkold_clean_ptes
> >
> >  #endif /* CONFIG_ARM64_CONTPTE */
> >
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 1b64b4c3f8bf..dbff9c5e9eff 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -361,6 +361,21 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, =
unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
> >
> > +void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned long addr=
,
> > +                           pte_t *ptep, unsigned int nr)
> > +{
> > +     /*
> > +      * If clearing the young and dirty bits for an entire contig rang=
e, we can
> > +      * avoid unfolding. Just set old/clean and wait for the later mmu=
_gather
> > +      * flush to invalidate the tlb. If it's a partial range though, w=
e need to
> > +      * unfold.
> > +      */
>
> nit: Please reflow comments like this to 80 cols.
>
> We can avoid unfolding in all cases. See existing comment in
> contpte_ptep_test_and_clear_young(). Suggest something like this (unteste=
d):
>
> void clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
>                             pte_t *ptep, unsigned int nr,
>                             bool clear_young, bool clear_dirty)
> {
>         /*
>          * We can safely clear access/dirty without needing to unfold fro=
m the
>          * architectures perspective, even when contpte is set. If the ra=
nge
>          * starts or ends midway through a contpte block, we can just exp=
and to
>          * include the full contpte block. While this is not exactly what=
 the
>          * core-mm asked for, it tracks access/dirty per folio, not per p=
age.
>          * And since we only create a contpte block when it is covered by=
 a
>          * single folio, we can get away with clearing access/dirty for t=
he
>          * whole block.
>          */
>
>         unsigned int start =3D addr;
>         unsigned int end =3D start + nr;
>
>         if (pte_cont(__ptep_get(ptep + nr - 1)))
>                 end =3D ALIGN(end, CONT_PTE_SIZE);
>
>         if (pte_cont(__ptep_get(ptep))) {
>                 start =3D ALIGN_DOWN(start, CONT_PTE_SIZE);
>                 ptep =3D contpte_align_down(ptep);
>         }
>
>         __clear_young_dirty_ptes(mm, start, ptep, end - start,
>                                  clear_young, clear_dirty);
> }

Nice. Thanks a lot for your help!

Thanks,
Lance

>
> Thanks,
> Ryan
>
> > +
> > +     contpte_try_unfold_partial(mm, addr, ptep, nr);
> > +     __mkold_clean_ptes(mm, addr, ptep, nr);
> > +}
> > +EXPORT_SYMBOL_GPL(contpte_mkold_clean_ptes);
> > +
> >  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                                       unsigned long addr, pte_t *ptep,
> >                                       pte_t entry, int dirty)
>

