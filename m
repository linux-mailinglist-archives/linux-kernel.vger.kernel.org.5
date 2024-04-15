Return-Path: <linux-kernel+bounces-144849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01328A4BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C231C223CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE340878;
	Mon, 15 Apr 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr/Yrh1Q"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE93FBAE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174091; cv=none; b=jlWCi8Bz9B7AxDq+9QpmGFeDHjaLD+ScpLw9P7X226O0THsx4gtVvFx5AXg1pBDLOMGoST8PN6FfnnMom3boTOyb+L3mv9GoCvN4JDRfMH5f2NPjPz0Xm2T6sfg0kQhVggBjJ/3PhvkHKjr7gSsfLCWAT1CLy7giIzHmaTSH3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174091; c=relaxed/simple;
	bh=ZdeiT0bJdSYCdBd/dJmHKpSxxX0NK7In3L4V0oqL6Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHISnNUOgAxOG7jUMzjzVNtnVLpWBhculNfYzpph3cvUosWdUMI9T0x+J64zTWG4Kbslwk4xxyD3epp4SiJwsKZzk0Ce48XI7q67zM/B8D8VCeBm1rTB4reUcZO0wzTWa/vHjiexyd4g1N9VZ1QZ+ILLCxp1TFfUS0AxeIiawTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr/Yrh1Q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so2738672a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713174088; x=1713778888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmvgoDnU5iPDaNfHEWNk9nMHC+RqFBpn8cszCtXpYEU=;
        b=Cr/Yrh1Q5xKmQ2P+QXZHAUhFuJtajvSZMlRaT1EQiEAzk+Q+O0YI50PnuPqj2PvUc2
         NT1nQMFKdLm816/daOY+r8pfKss0Ccmr4ayctb2fx6fGndwQl9jaXMWBm/+Ht0GNyc4+
         WGkAWGKEYhND6AYpLF/DB8yIfpjjFevxoBig6ZCMvtNxECRN8DNBeLryzJA3M+MB7TGK
         +SKDxfRBhjzeBNuB+GpVcY3KpbnTh3SIEq7FAScm3x2kW/fiol1petAR+6cyDe1FK9At
         FZ8R0WWNfB7XzrjzWObQPwoiwo16bZhdEGLAIfRR4X5J4H3OlpHTKFv/OIomVPH74sMk
         RrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713174088; x=1713778888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmvgoDnU5iPDaNfHEWNk9nMHC+RqFBpn8cszCtXpYEU=;
        b=JUnGahVvgqw9OdTVNFiQz+c9hRip/j9KtzyJ5fsYo/mGP55cCZhYVfylvPqU8DoK54
         wGId44VRh/fEtiKXrKONAiwF6AYoRqaWEvZ+qpI9cw6EGhLQi54ImwTRniSebl2Yw2sQ
         PtleQKUBgryb1iGz2bEkCB4L2qxl9piFxGwQnFxdx5crRYLTF3OATbY3UasmTk0F5aaK
         wg+SnCbIk44prc2ipMKqhA489tUJjQudtX3I/2grzRL01h1LqANdI3WEQnxQsMZemPKx
         Owc2UW5iGXd3cz5G/Y0KvPPgqL8nWmtJRfMnMwrrPIxwMuKUCUWEOJW/lGk6UVhI5Tg3
         HJbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3TFI7PXZHMBAD0M55AxH7T+JS1cbA02BmMqAxx6jztOE+pdtDbt6Iz+RFTV4bx/p5X81L5D4N1qDy5NMZLpZIMBnkfJ8AeLtXJOd
X-Gm-Message-State: AOJu0Yw6psBAkaSjwuovIh2ziSKksF4aeg4zkRiqOpZ6lebLsP0VnQHC
	axmjuoaeSjsQfsCrBJYpmpvPTrBdc83I+DBaPx+SO3/9AHyXKS5wHNfoUxckX8syadaVtaJGrQB
	rCa85FYUB+ycZdVniiQwLP7lISBk=
X-Google-Smtp-Source: AGHT+IEbqfHAiws4+f53DJkjb2XkVtw3Iy6rmNtsHEqP4Je0cKaSTwBd5go4csOUYSYpO15EOo32AgPHDP1wrC9oGe8=
X-Received: by 2002:a50:8e5d:0:b0:56d:f00c:2b13 with SMTP id
 29-20020a508e5d000000b0056df00c2b13mr5423638edx.32.1713174087534; Mon, 15 Apr
 2024 02:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413002219.71246-1-ioworker0@gmail.com> <20240413002219.71246-3-ioworker0@gmail.com>
 <209b9341-8bd0-47fe-b8fd-9a0f02beeab0@arm.com>
In-Reply-To: <209b9341-8bd0-47fe-b8fd-9a0f02beeab0@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 15 Apr 2024 17:41:16 +0800
Message-ID: <CAK1f24=oanyccKUYz1E7H2euyhnExjqRShQ8KKqDXAV6qkohhg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm/arm64: override clear_young_dirty_ptes() batch helper
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, 21cnbao@gmail.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:59=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 13/04/2024 01:22, Lance Yang wrote:
> > The per-pte get_and_clear/modify/set approach would result in
> > unfolding/refolding for contpte mappings on arm64. So we need
> > to override clear_young_dirty_ptes() for arm64 to avoid it.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Barry Song <21cnbao@gmail.com>
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>
> No, afraid I haven't signed off yet!

Actually, you've done most of this change, and I just do the legwork :)
But I'll remove this s-o-b.

>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/contpte.c          | 28 ++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 9fd8613b2db2..f951774dd2d6 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -1223,6 +1223,28 @@ static inline void __wrprotect_ptes(struct mm_st=
ruct *mm, unsigned long address,
> >               __ptep_set_wrprotect(mm, address, ptep);
> >  }
> >
> > +static inline void __clear_young_dirty_ptes(struct mm_struct *mm,
> > +                                         unsigned long addr, pte_t *pt=
ep,
> > +                                         unsigned int nr, cydp_t flags=
)
> > +{
> > +     pte_t pte;
> > +
> > +     for (;;) {
> > +             pte =3D __ptep_get(ptep);
> > +
> > +             if (flags | CYDP_CLEAR_YOUNG)
>
> bug: should be bitwise AND (&).

Good spot! Thanks!

>
> > +                     pte =3D pte_mkold(pte);
> > +             if (flags | CYDP_CLEAR_DIRTY)
> > +                     pte =3D pte_mkclean(pte);
> > +
> > +             __set_pte(ptep, pte);
>
> The __ptep_get() and __set_pte() are not atomic. This is only safe when y=
ou are
> clearing BOTH access and dirty (as I explained in the previous version). =
If you
> are only clearing one of the flags, you will need a similar cmpxchg loop =
as for
> __ptep_test_and_clear_young(). Otherwise you can race with the HW and los=
e
> information.

Thanks again for your patience and explanation!
I still got it wrong :(

>
> > +             if (--nr =3D=3D 0)
> > +                     break;
> > +             ptep++;
> > +             addr +=3D PAGE_SIZE;
> > +     }
> > +}
> > +
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
> >  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> > @@ -1379,6 +1401,9 @@ extern void contpte_wrprotect_ptes(struct mm_stru=
ct *mm, unsigned long addr,
> >  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                               unsigned long addr, pte_t *ptep,
> >                               pte_t entry, int dirty);
> > +extern void contpte_clear_young_dirty_ptes(struct mm_struct *mm,
> > +                             unsigned long addr, pte_t *ptep,
> > +                             unsigned int nr, cydp_t flags);
> >
> >  static __always_inline void contpte_try_fold(struct mm_struct *mm,
> >                               unsigned long addr, pte_t *ptep, pte_t pt=
e)
> > @@ -1603,6 +1628,17 @@ static inline int ptep_set_access_flags(struct v=
m_area_struct *vma,
> >       return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirt=
y);
> >  }
> >
> > +#define clear_young_dirty_ptes clear_young_dirty_ptes
> > +static inline void clear_young_dirty_ptes(struct mm_struct *mm,
> > +                                       unsigned long addr, pte_t *ptep=
,
> > +                                       unsigned int nr, cydp_t flags)
> > +{
> > +     if (likely(nr =3D=3D 1 && !pte_cont(__ptep_get(ptep))))
> > +             __clear_young_dirty_ptes(mm, addr, ptep, nr, flags);
> > +     else
> > +             contpte_clear_young_dirty_ptes(mm, addr, ptep, nr, flags)=
;
> > +}
> > +
> >  #else /* CONFIG_ARM64_CONTPTE */
> >
> >  #define ptep_get                             __ptep_get
> > @@ -1622,6 +1658,7 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >  #define wrprotect_ptes                               __wrprotect_ptes
> >  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
> >  #define ptep_set_access_flags                        __ptep_set_access=
_flags
> > +#define clear_young_dirty_ptes                       __clear_young_dir=
ty_ptes
> >
> >  #endif /* CONFIG_ARM64_CONTPTE */
> >
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 1b64b4c3f8bf..bf3b089d9641 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -361,6 +361,34 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, =
unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
> >
> > +void contpte_clear_young_dirty_ptes(struct mm_struct *mm, unsigned lon=
g addr,
> > +                                 pte_t *ptep, unsigned int nr, cydp_t =
flags)
> > +{
> > +     /*
> > +      * We can safely clear access/dirty without needing to unfold fro=
m
> > +      * the architectures perspective, even when contpte is set. If th=
e
> > +      * range starts or ends midway through a contpte block, we can ju=
st
> > +      * expand to include the full contpte block. While this is not
> > +      * exactly what the core-mm asked for, it tracks access/dirty per
> > +      * folio, not per page. And since we only create a contpte block
> > +      * when it is covered by a single folio, we can get away with
> > +      * clearing access/dirty for the whole block.
> > +      */
> > +     unsigned int start =3D addr;
> > +     unsigned int end =3D start + nr;
>
> There are addresses; they should be unsigned long. May have been my error
> originally when I sent you the example snippet.

Got it. I'll sort it.

Thanks again for your time!

Thanks,
Lance

>
> Thanks,
> Ryan
>
> > +
> > +     if (pte_cont(__ptep_get(ptep + nr - 1)))
> > +             end =3D ALIGN(end, CONT_PTE_SIZE);
> > +
> > +     if (pte_cont(__ptep_get(ptep))) {
> > +             start =3D ALIGN_DOWN(start, CONT_PTE_SIZE);
> > +             ptep =3D contpte_align_down(ptep);
> > +     }
> > +
> > +     __clear_young_dirty_ptes(mm, start, ptep, end - start, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> > +
> >  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
> >                                       unsigned long addr, pte_t *ptep,
> >                                       pte_t entry, int dirty)
>

