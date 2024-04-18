Return-Path: <linux-kernel+bounces-150065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61208A99E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF16282DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA51DFC5;
	Thu, 18 Apr 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lku26rQF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C66FC3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443607; cv=none; b=SaMlcQV/JkxYYSxJTp252f5rBh+rK1iOTRG/28gJ7iLNgDAGRjR+DLS/GcY/u6BBL3dE4wnlswWrsjrO5zinjab6fOQh2SUm/gwMzVb47Z11KkCNh49LI38q3UWXyicFZtO76Xp11JrEklNJHMxPzkECtN9qKZ9OGNYHeh2X4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443607; c=relaxed/simple;
	bh=kvPP3JRV8zr3oBKqpLztT6nZrpxaaOtJILGIA6j1DBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJF9evjR/QYcpsbQfXGy7X9lb612Uo6S9Fxt/hWJLszAuX82B06KF833n56SFSvXJ07MW1+QgS5sNS94siroQCDYXNELzP2hlEoxCUpkOMh2ORipS/xy4HsnXoPIRBarTfKXTMfRzWkqQaSV4Zm63Cmij+LPnbFlof14ZjYRA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lku26rQF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a526a200879so96935766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713443604; x=1714048404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWbvBBD4IynrcD2Sf4xGpEx0l18q3sV1s1D5M4aDHzM=;
        b=lku26rQFOnRpYD3WBIr1AbMb+qrHR/gsWWfuO5bWN/5vALaHxtOS1tSzCWZLr4G+BN
         wzHn/6QFI68A+k6TslWYIt42kXdld9+zf8WZ6SNQS/X04S78w7DPZ7Gpjnr086moVl+0
         Yp5rnQQIfFX+YOMolDSYka/OLN8eC2CsAwEjLlmzJgGA7iMgc4b6ZWzqiYuhlH2kZ4t9
         7f0lVqzpoxzMOvba1XvekhB5rHXWk2cBO7j1kg1vqiW7anvQUUVKxwUHs/DZe3lykSd3
         YHltkKj3KnUa5ICNDIpGz/LQq8aBvA6U6hZbAdqBr89B7dg9Cpx5aB1ke314r4S4RBAC
         HGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713443604; x=1714048404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWbvBBD4IynrcD2Sf4xGpEx0l18q3sV1s1D5M4aDHzM=;
        b=Nnex3j2I9cy9QR00ThHOtZq0bbCsFfX0L//putZ90+2Bu1bRpBbt+cUIvYQuL+W6ov
         n1a2XgcAVsG2DEp8Zx7ivNsT79MKt48t717DIHaMGz3sMe+BiQzbjGN7/lF+k0LWS9Kn
         uBMM96l+hEkqqOEMpavI5m2NII98RpLQt3rb5vFQoaI2hV/SFQ0fSwaF2X+eZA5MUNcY
         aNfUwsZGLQEWS12dBRtsPM/o5S8FydsxHRl8/Cb/VoRCXTOwz5nlfszSs6zp83aNB+pZ
         H+vl4dqqFmX57swrEGivOLTxDAxUnB2APzsPsPVzWb19eK1pdT6a5NsHFR0LcGp7wgaI
         r0cA==
X-Forwarded-Encrypted: i=1; AJvYcCVOnsYsv/KOSRuMcQwp8fMoF1+vjv/jy+ePMD0YM+L4l+NqkmgB9YF9ljqaL36FSAVg70jH96XADzhh8AcG3KlqYr8OH2mT2ltOS04A
X-Gm-Message-State: AOJu0Yxn2AoswMpZ4t2MihgBluEPpew1aXZZEPFMGrNzmcUXheLo+v6B
	VxGHVkcWTcg85yy+YAfHmMI/3mNmzRAbJi5EdaHoyL0BlOK/zBnVMdXgMda+/rRbY+F4ug9KDCY
	Udc9JdGcE0gzyNr/V57kdkn2P9U8=
X-Google-Smtp-Source: AGHT+IHf/bkF7wytw2Nvf8Bz09dadKEPpP4FClinFkCqOj4123jXRV509DXqBDy3IkWH+qLwXOcD+lNOWsd4uUhYIfY=
X-Received: by 2002:a17:907:7b82:b0:a52:6e3b:fcf1 with SMTP id
 ne2-20020a1709077b8200b00a526e3bfcf1mr2158169ejc.17.1713443604087; Thu, 18
 Apr 2024 05:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418105750.98866-1-ioworker0@gmail.com> <20240418105750.98866-5-ioworker0@gmail.com>
 <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com>
In-Reply-To: <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 20:33:12 +0800
Message-ID: <CAK1f24m4y0kvmdFtHoJoPZeF9aeRpw4nnr1W5BMRz_OH49dHvg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.04.24 12:57, Lance Yang wrote:
> > This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> > (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> > splitting if the large folio is fully mapped within the target range.
> >
> > If a large folio is locked or shared, or if we fail to split it, we jus=
t
> > leave it in place and advance to the next PTE in the range. But note th=
at
> > the behavior is changed; previously, any failure of this sort would cau=
se
> > the entire operation to give up. As large folios become more common,
> > sticking to the old way could result in wasted opportunities.
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios =
of
> > the same size results in the following runtimes for madvise(MADV_FREE) =
in
> > seconds (shorter is better):
> >
> > Folio Size |   Old    |   New    | Change
> > ------------------------------------------
> >        4KiB | 0.590251 | 0.590259 |    0%
> >       16KiB | 2.990447 | 0.185655 |  -94%
> >       32KiB | 2.547831 | 0.104870 |  -95%
> >       64KiB | 2.457796 | 0.052812 |  -97%
> >      128KiB | 2.281034 | 0.032777 |  -99%
> >      256KiB | 2.230387 | 0.017496 |  -99%
> >      512KiB | 2.189106 | 0.010781 |  -99%
> >     1024KiB | 2.183949 | 0.007753 |  -99%
> >     2048KiB | 0.002799 | 0.002804 |    0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com
> >
> > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   mm/madvise.c | 85 +++++++++++++++++++++++++++------------------------=
-
> >   1 file changed, 44 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 4597a3568e7e..375ab3234603 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
> >                               unsigned long end, struct mm_walk *walk)
> >
> >   {
> > +     const cydp_t cydp_flags =3D CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;
> >       struct mmu_gather *tlb =3D walk->private;
> >       struct mm_struct *mm =3D tlb->mm;
> >       struct vm_area_struct *vma =3D walk->vma;
> > @@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                       continue;
> >
> >               /*
> > -              * If pmd isn't transhuge but the folio is large and
> > -              * is owned by only this process, split it and
> > -              * deactivate all pages.
> > +              * If we encounter a large folio, only split it if it is =
not
> > +              * fully mapped within the range we are operating on. Oth=
erwise
> > +              * leave it as is so that it can be marked as lazyfree. I=
f we
> > +              * fail to split a folio, leave it in place and advance t=
o the
> > +              * next pte in the range.
> >                */
> >               if (folio_test_large(folio)) {
> > -                     int err;
> > +                     bool any_young, any_dirty;
> >
> > -                     if (folio_likely_mapped_shared(folio))
> > -                             break;
> > -                     if (!folio_trylock(folio))
> > -                             break;
> > -                     folio_get(folio);
> > -                     arch_leave_lazy_mmu_mode();
> > -                     pte_unmap_unlock(start_pte, ptl);
> > -                     start_pte =3D NULL;
> > -                     err =3D split_folio(folio);
> > -                     folio_unlock(folio);
> > -                     folio_put(folio);
> > -                     if (err)
> > -                             break;
> > -                     start_pte =3D pte =3D
> > -                             pte_offset_map_lock(mm, pmd, addr, &ptl);
> > -                     if (!start_pte)
> > -                             break;
> > -                     arch_enter_lazy_mmu_mode();
> > -                     pte--;
> > -                     addr -=3D PAGE_SIZE;
> > -                     continue;
> > +                     nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> > +                                                  ptent, &any_young, N=
ULL);
> > +
> > +                     if (nr < folio_nr_pages(folio)) {
> > +                             int err;
> > +
> > +                             if (folio_likely_mapped_shared(folio))
> > +                                     continue;
> > +                             if (!folio_trylock(folio))
> > +                                     continue;
> > +                             folio_get(folio);
> > +                             arch_leave_lazy_mmu_mode();
> > +                             pte_unmap_unlock(start_pte, ptl);
> > +                             start_pte =3D NULL;
> > +                             err =3D split_folio(folio);
> > +                             folio_unlock(folio);
> > +                             folio_put(folio);
> > +                             start_pte =3D pte =3D
> > +                                     pte_offset_map_lock(mm, pmd, addr=
, &ptl);
>
> I'd just put it on a single line.

start_pte =3D pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);

I suddenly realized that putting it on a single line would exceed the
80-char limit.

Or:

start_pte =3D pte =3D pte_offset_map_lock(
        mm, pmd, addr, &ptl);

Thanks,
Lance
>
> > +                             if (!start_pte)
> > +                                     break;
> > +                             arch_enter_lazy_mmu_mode();
> > +                             if (!err)
> > +                                     nr =3D 0;
> > +                             continue;
> > +                     }
> > +
> > +                     if (any_young)
> > +                             ptent =3D pte_mkyoung(ptent);
> > +                     if (any_dirty)
>
> any_dirty is never set, likely missed to pass it to
> madvise_folio_pte_batch().
>
> Apart from that LGTM and this patch is much easier to review now!
>
>
> With above:
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

