Return-Path: <linux-kernel+bounces-132934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6A899C26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F31F23A26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491D16C6A5;
	Fri,  5 Apr 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsgeDZcE"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FA16C68E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318115; cv=none; b=KrIXIN910o8c9oFN0g+b9orJod+RnhjctuYPL1wOQRW/Bfceh8Ylb5haeUJeiI49uECGt/p5UwxKg8VaBeNNUSqhzWfyxQp4RCiu/EIN7euB0M9h7aY8e4xLh5zoieJ7vCoIzALzIDa/QAsEZ3HK1EzuEvrgtl6+RqJxmSAPhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318115; c=relaxed/simple;
	bh=I5lRYQkwtPKMXKgKGWQAeiV92QEPwOla0pluxKz8Wjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9/RrM4cczgECWxMgCAEDbTQO92soIp+g8f7nY3tKnu/xq8T+6I106mDxB0ac0Kisn/ic7ByQfmcuabUReOgvltL8EBx229EAjhTPRnHksRqca/2UFLi2BBqsF9rzb8EWLj9PaPGWVuGGOx1AUvyOUTwMXiKXqVcDnC01B7jD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsgeDZcE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2169289a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712318112; x=1712922912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA1tTLEF6tQjQUASzxOQDBDY7cW0W5LfoybYp/6l9r0=;
        b=DsgeDZcE/L3VkJQLdAz3R7eGwqn/3aUFXJjJvUhj6bzBlHsuu3XSToAIMBGwxhncxs
         Ho0mCs6K5t/lWvGJlIQYWjsbyWXJpjhIfxcRWGnWbR+Jr7hBXtvt64SPceQABQbwnz5R
         2eP9gGeoYU83VPrk4ifTRx6+E1PWkfE2rdwnnaQZwDp6kPkDnQZ6luO1beb1+OGxsmAc
         RJPEWFPmJttcUbp2gyP2wJgwf9iSYyCgnjifKnflIVVg53NV6+qAdeF3WE4pcnFsy99B
         XM4CqK6WmKYtbDVvgJhk+EM992hJ1fJd22pzvNuLdg3kdqv4aJA7SSKwsTkSMQzS6Ym6
         P/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318112; x=1712922912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA1tTLEF6tQjQUASzxOQDBDY7cW0W5LfoybYp/6l9r0=;
        b=fAaVyNN0hU2WSExWvOZiqoLIzr9+vhSmNYETqLJViTatdjhJqqsigF1coOXPnvG5zH
         a3Qs/Zyjvn1bX1ecznx/gKI161bviIMM0QZxdMxGvxHeGbolngLSR+boWaWU3/K+3WzZ
         Zcw/CdAbse1Nskvt2V4syyTQ5qrXFgqlySDG6F+ND4pweYhSvsAuiQRwOiodHqImCnON
         1OEx6oOsVlrgGsQAxZrUQpjhyfdQNbvjxvcfWqImSlwHAKnwpdZHUjncFMLCx3vEOvml
         /S4pPDz2lyu37weibFAPWZhb8IwHVyajsef3GztVWXAQRMfVFHWyR8cxRZr5UEWvw0R6
         b7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpSDFBbIn1DptQhf16Ob5+4PIuc4gMLmbRWu7wqaPKfOQcCLKc60AKRV3hO1D2HDIsI6qvUA0ZC3XmP83YSYfUEghk4e4cVjBs+ZRD
X-Gm-Message-State: AOJu0Yxz3RsH8rPeHX1HZV9CNKjmJdbOkmsoL0wZRlJJDcoqCsxWHOxW
	sSOW3Q7zotJJjm96xX2JiqD5LEN1hZ09xPAaFEZkmBNZ9yqaCYSzZOw2BCQ+Zt2SYqMvTcZgFwG
	JxjWdHz/UNSRogvP+mug+y9A+2J8=
X-Google-Smtp-Source: AGHT+IF0/Z8sAs1AunjxxmeS1dwOmoclZmhO6PSJoiptsld3avrd2FV5hIVLWoVH+Fz5/ydSIQHHhwoPKFj9xS4/USo=
X-Received: by 2002:a50:bb4b:0:b0:56d:f246:bfa4 with SMTP id
 y69-20020a50bb4b000000b0056df246bfa4mr1180007ede.23.1712318111914; Fri, 05
 Apr 2024 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402124029.47846-1-ioworker0@gmail.com> <20240402124029.47846-2-ioworker0@gmail.com>
 <0793c3d9-589b-4550-a556-9a4fa5a6cec2@arm.com>
In-Reply-To: <0793c3d9-589b-4550-a556-9a4fa5a6cec2@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 5 Apr 2024 19:55:00 +0800
Message-ID: <CAK1f24kLXWsTPW=sL0TxCSDHYR4-kLpaBjAqZpH2SEx5i+opRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/madvise: introduce mkold_clean_ptes() batch helper
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, 21cnbao@gmail.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan,

Thanks for taking time to review!

On Thu, Apr 4, 2024 at 12:38=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 02/04/2024 13:40, Lance Yang wrote:
> > Change the code that clears young and dirty bits from the PTEs to use
> > ptep_get_and_clear_full() and set_pte_at(), via the new mkold_clean_pte=
s()
> > batch helper function.
> >
> > Unfortunately, the per-pte get_and_clear/modify/set approach would resu=
lt
> > in unfolding/refolding for contpte mappings on arm64. So we need to
> > override mkold_clean_ptes() for arm64 to avoid it.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Barry Song <21cnbao@gmail.com>
> > Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/contpte.c          | 10 +++++++++
> >  include/linux/pgtable.h          | 30 ++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+)
>
> When I suggested splitting out this patch, this wasn't quite what I meant=
.
> Instead I intended for the first patch to make the MADV_FREE change and a=
s part
> of that introduce mkold_clean_ptes() with a generic implementation. Then =
a
> second patch would do the arm64-specific specialization of mkold_clean_pt=
es()
> for an arm64-specific performance boost. In general it is often useful to
> separate core changes from arch changes where practical since they have
> different target audiences.

Thanks for clearing that up! I=E2=80=98ll make sure to implement it as disc=
ussed.

>
>
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 9fd8613b2db2..b032c107090c 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1086,6 +1086,27 @@ static inline bool pud_user_accessible_page(pud_=
t pud)
> >  }
> >  #endif
> >
> > +static inline void __mkold_clean_pte(struct vm_area_struct *vma,
> > +                                 unsigned long addr, pte_t *ptep)
> > +{
> > +     pte_t old_pte, pte;
> > +
> > +     pte =3D __ptep_get(ptep);
> > +     do {
> > +             old_pte =3D pte;
> > +             pte =3D pte_mkclean(pte_mkold(pte));
> > +             pte_val(pte) =3D cmpxchg_relaxed(&pte_val(*ptep),
> > +                                            pte_val(old_pte), pte_val(=
pte));
> > +     } while (pte_val(pte) !=3D pte_val(old_pte));
> > +}
>
> I'm not sure how value it is to split this out, given we are only exposin=
g a
> batched version to the core. Perhaps just include the body in mkold_clean=
_ptes()?

I agree that including the body in mkold_clean_ptes() would be better.

>
> > +
> > +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> > +                                 unsigned long addr, pte_t *ptep, unsi=
gned int nr, int full)
> > +{
> > +     for (; nr-- > 0; ptep++, addr +=3D PAGE_SIZE)
> > +             __mkold_clean_pte(vma, addr, ptep);
> > +}
> > +
> >  /*
> >   * Atomic pte/pmd modifications.
> >   */
> > @@ -1379,6 +1400,8 @@ extern void contpte_wrprotect_ptes(struct mm_stru=
ct *mm, unsigned long addr,
> >  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                               unsigned long addr, pte_t *ptep,
> >                               pte_t entry, int dirty);
> > +extern void contpte_ptep_mkold_clean(struct vm_area_struct *vma,
> > +                             unsigned long addr, pte_t *ptep);
>
> Let's have this follow the same naming pattern; contpte_mkold_clean_ptes(=
)

Got it. Let=E2=80=99s keep the naming consistent with contpte_mkold_clean_p=
tes().

>
> >
> >  static __always_inline void contpte_try_fold(struct mm_struct *mm,
> >                               unsigned long addr, pte_t *ptep, pte_t pt=
e)
> > @@ -1603,6 +1626,18 @@ static inline int ptep_set_access_flags(struct v=
m_area_struct *vma,
> >       return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirt=
y);
> >  }
> >
> > +#define mkold_clean_ptes mkold_clean_ptes
> > +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> > +                                 unsigned long addr, pte_t *ptep, unsi=
gned int nr, int full)
> > +{
> > +     pte_t orig_pte =3D __ptep_get(ptep);
> > +
> > +     if (likely(!pte_valid_cont(orig_pte)))
> > +             return __mkold_clean_ptes(vma, addr, ptep, nr, full);
> > +
> > +     return contpte_ptep_mkold_clean(vma, addr, ptep);> +}
>
> This function is totally broken as far as I can tell. You are assuming if=
 the
> first pte is not cont, then the whole range is not cont; you can't assume=
 that.
> Then if you decide it is cont, you ignore nr and only fixup a single cont=
pte block.
>
> Take a look at wrprotect_ptes() or another one of the batched helpers and=
 follow
> that pattern.

Sorry for the mistake. I'll take a closer look at wrprotect_ptes() and
make sure to
follow that pattern.

>
> > +
> >  #else /* CONFIG_ARM64_CONTPTE */
> >
> >  #define ptep_get                             __ptep_get
> > @@ -1622,6 +1657,7 @@ static inline int ptep_set_access_flags(struct vm=
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
> > index 1b64b4c3f8bf..560622cfb2a9 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -322,6 +322,16 @@ int contpte_ptep_test_and_clear_young(struct vm_ar=
ea_struct *vma,
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_ptep_test_and_clear_young);
> >
> > +void contpte_ptep_mkold_clean(struct vm_area_struct *vma, unsigned lon=
g addr,
> > +                           pte_t *ptep)
> > +{
> > +     ptep =3D contpte_align_down(ptep);
> > +     addr =3D ALIGN_DOWN(addr, CONT_PTE_SIZE);
> > +
> > +     __mkold_clean_ptes(vma, addr, ptep, CONT_PTES, 0);
>
> As above, this is broken as is.
>
> > +}
> > +EXPORT_SYMBOL_GPL(contpte_ptep_mkold_clean);
> > +
> >  int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> >                                       unsigned long addr, pte_t *ptep)
> >  {
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index fa8f92f6e2d7..fd30779fe487 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -391,6 +391,36 @@ static inline void mkold_ptes(struct vm_area_struc=
t *vma, unsigned long addr,
> >  }
> >  #endif
> >
> > +#ifndef mkold_clean_ptes
> > +/**
> > + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same=
 folio
> > + *           as old and clean.
> > + * @vma: VMA the pages are mapped into.
> > + * @addr: Address the first page is mapped at.
> > + * @ptep: Page table pointer for the first entry.
> > + * @nr: Number of entries to mark old and clean.
> > + *
> > + * May be overridden by the architecture; otherwise, implemented as a =
simple
> > + * loop over ptep_get_and_clear_full().
>
> How about "otherwise, implemented by get_and_clear/modify/set for each pt=
e in
> the range."?

Nice, this is clearer and more accurate than before.

>
> > + *
> > + * Note that PTE bits in the PTE range besides the PFN can differ. For=
 example,
> > + * some PTEs might be write-protected.
> > + *
> > + * Context: The caller holds the page table lock.  The PTEs map consec=
utive
> > + * pages that belong to the same folio.  The PTEs are all in the same =
PMD.
> > + */
> > +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> > +                                 unsigned long addr, pte_t *ptep, unsi=
gned int nr, int full)
>
> You've included the "full" param in the function but not in the docs. I d=
on't
> think the full param is valuable though; it doesn't make sense to call th=
is
> function when tearing down a process. So drop the parameter and just call
> ptep_get_and_clear().

Got it. I'll drop the "full" parameter.

>
> > +{
> > +     pte_t pte;
> > +
> > +     for (; nr-- > 0; ptep++, addr +=3D PAGE_SIZE) {
>
> nit: This is using a different pattern to all the other batch helpers
> (set_ptes(), wrprotect_ptes() clear_full_ptes()).

Thanks for pointing that out.

Thanks,
Lance

>
> > +             pte =3D ptep_get_and_clear_full(vma->vm_mm, addr, ptep, f=
ull);
> > +             set_pte_at(vma->vm_mm, addr, ptep, pte_mkclean(pte_mkold(=
pte)));
> > +     }
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NO=
NLEAF_PMD_YOUNG)
> >  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma=
,
>

