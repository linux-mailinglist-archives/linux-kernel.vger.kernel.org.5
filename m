Return-Path: <linux-kernel+bounces-83051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B09868DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26CD1F2297B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F11384AD;
	Tue, 27 Feb 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV7OxiBU"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCEF9D6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030308; cv=none; b=QsggykMOP63zHZIwTk0Vq9feidaA/5UkTeQKK2zUDKJqnKo9YQE0J16/PuLdCx7LyRNgw4vDEiZo21U1R/oryG0o5/zSAXbxTTvvdT9DIcD8JCwb2mC+c3SO02PS4lpHX3IoQCHd1lA4x+h7gxZM70WyqRklTvtzNJfypumsukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030308; c=relaxed/simple;
	bh=fhylqX7+UJdTiSy+kGwf/HLQRw7EN0sOXy83W4gnkeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPxdB06eYE9Amg5k9MrmEj9CXlTcvzpUiTuV/j2/orQ/eO8vCik6PEElAa81DeaL467V15agL+qcEhZU0zS+Gja6zhKDbOLKJpL7S2eSvdAl1VNwIYHfiXdCd3WYqVmG4wPsgxeVL9ISgd99FmXEKnK3yqDMuxhgnRt+i257Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV7OxiBU; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7da6e831958so781086241.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030306; x=1709635106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRJFJQ7CU8piiOPmotEohj9ja81bvWEJw6fpyXXopY4=;
        b=jV7OxiBUikNI64Y3IvgufQWaHxnbG7NXbxzx0cd45YeWp3759r9sEbzJ451BHynDbg
         QiI70oI4sPi1ukL9jkI12J0xp/CeelzzBKSvmSzzrTpvjlyrnW5tmqZNZ8sJt8dRQYFA
         C/Z1Xx0a641icWZ0wxmPIzDmYy1noMwRFjZfEjzGsKkPnV/RVhTwAiGHFvMphtzFbSD2
         BXs1sWNMzDwBETx0BeqcHN1MQaoUVdGV0JNDXWW/UtRjgWrSoq9EaU01df7R9tbsERSv
         LIPxvnNq3KFBsXJI42p14PPbTWlWjOKUi4o10iRl7Qod2XJWdPxkUNPE9I8Xza2ZDj8H
         kDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030306; x=1709635106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRJFJQ7CU8piiOPmotEohj9ja81bvWEJw6fpyXXopY4=;
        b=eL/lhMyJ8w2Y7/sxH2rHivutyy3hDkBEjNuyJJUPzbOv88E/o0mBDIAzR87hxG7Hhi
         yaeL8loeHkFK0x55aqL3/jtBNEzrzaZTQvMR0qo0AUWUaLbpj20OWbQngkKit7fX9PYU
         FichgkyXbsZMW5NuNoHCgjcDakapEENequ4dx0GMeJvxeXLoJGLdXhu626YqDOkzfgO3
         bzLzFMTNsLa6fjlh9AYxXZvvNFshV6HLAgWVVIU0w5YEt4iWCr5XzRwXaGS3YYh1KX4Y
         HQ3ITPKliH7R61fz7/UPOrb70F8UQdS0UXFMzX/kpl+6eorRAcmAdTAuZe1Lrk3mR2SP
         YU+A==
X-Forwarded-Encrypted: i=1; AJvYcCVrQtDvT/RZpWDggVlUG/sH7qCsp+OHA9rskgRns0NB915czfFpFeFh/MYCwrZ2JD6J7pXPdS4Wlfj3vHjM5yTe75MNCWjQGdnwZHSS
X-Gm-Message-State: AOJu0YyIfbik1Bp+Ly3ZPwlaFD9IQN/8A/svs/OhwrqD08UGJzRprQDm
	UQDlD8q+0fUAfzLHa5si6fBizCS/ADoO5gLEch+x2cBqmZZdAcwGAs46R/3IG/ltUT7TH+AJt/E
	dSbC12JdTve1PAjHcPBFNusJfCJ4=
X-Google-Smtp-Source: AGHT+IFsnALM5KDHCaii48AVfZAngG6L4SfzV1K3q+6lbgg/mlqLt+793+7uvJc2xN2gs1WYMa/Ip9QA46ZL6oXVoZg=
X-Received: by 2002:a1f:ccc1:0:b0:4cd:b718:4b08 with SMTP id
 c184-20020a1fccc1000000b004cdb7184b08mr5805324vkg.11.1709030305874; Tue, 27
 Feb 2024 02:38:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com> <CAK1f24mOc+Y_UCA2nSC7VbNQMy0DahULz-6JsEPMqTyoAA+MoA@mail.gmail.com>
In-Reply-To: <CAK1f24mOc+Y_UCA2nSC7VbNQMy0DahULz-6JsEPMqTyoAA+MoA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 23:38:14 +1300
Message-ID: <CAGsJ_4xOi0=rQjcv=S6HvHg8r9s_m4+tTimAK+bX-p4C4sDGGA@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: Lance Yang <ioworker0@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> On Tue, Feb 27, 2024 at 5:14=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 27.02.24 10:07, Ryan Roberts wrote:
> > > On 27/02/2024 02:40, Barry Song wrote:
> > >> From: Barry Song <v-songbaohua@oppo.com>
> > >>
> > >> madvise and some others might need folio_pte_batch to check if a ran=
ge
> > >> of PTEs are completely mapped to a large folio with contiguous physc=
ial
> > >> addresses. Let's export it for others to use.
> > >>
> > >> Cc: Lance Yang <ioworker0@gmail.com>
> > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >> Cc: David Hildenbrand <david@redhat.com>
> > >> Cc: Yin Fengwei <fengwei.yin@intel.com>
> > >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > >> ---
> > >>   -v1:
> > >>   at least two jobs madv_free and madv_pageout depend on it. To avoi=
d
> > >>   conflicts and dependencies, after discussing with Lance, we prefer
> > >>   this one can land earlier.
> > >
> > > I think this will also ultimately be useful for mprotect too, though =
I haven't
> > > looked at it properly yet.
> > >
> >
> > Yes, I think we briefly discussed that.
> >
> > >>
> > >>   mm/internal.h | 13 +++++++++++++
> > >>   mm/memory.c   | 11 +----------
> > >>   2 files changed, 14 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/mm/internal.h b/mm/internal.h
> > >> index 13b59d384845..8e2bc304f671 100644
> > >> --- a/mm/internal.h
> > >> +++ b/mm/internal.h
> > >> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct foli=
o *folio)
> > >>      return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> > >>   }
> > >>
> > >> +/* Flags for folio_pte_batch(). */
> > >> +typedef int __bitwise fpb_t;
> > >> +
> > >> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> > >> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> > >> +
> > >> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dir=
ty bit. */
> > >> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> > >> +
> > >> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> > >> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> > >> +            bool *any_writable);
> > >> +
> > >>   void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *foli=
o,
> > >>                                              int nr_throttled);
> > >>   static inline void acct_reclaim_writeback(struct folio *folio)
> > >> diff --git a/mm/memory.c b/mm/memory.c
> > >> index 1c45b6a42a1b..319b3be05e75 100644
> > >> --- a/mm/memory.c
> > >> +++ b/mm/memory.c
> > >> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes=
(struct vm_area_struct *dst_vma,
> > >>      set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> > >>   }
> > >>
> > >> -/* Flags for folio_pte_batch(). */
> > >> -typedef int __bitwise fpb_t;
> > >> -
> > >> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> > >> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> > >> -
> > >> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dir=
ty bit. */
> > >> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> > >> -
> > >>   static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t fla=
gs)
> > >>   {
> > >>      if (flags & FPB_IGNORE_DIRTY)
> > >> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pt=
e_t pte, fpb_t flags)
> > >>    * If "any_writable" is set, it will indicate if any other PTE bes=
ides the
> > >>    * first (given) PTE is writable.
> > >>    */
> > >
> > > David was talking in Lance's patch thread, about improving the docs f=
or this
> > > function now that its exported. Might be worth syncing on that.
> >
> > Here is my take:
> >
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >   mm/memory.c | 22 ++++++++++++++++++----
> >   1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d0b855a1837a8..098356b8805ae 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte=
_t pte, fpb_t flags)
> >         return pte_wrprotect(pte_mkold(pte));
> >   }
> >
> > -/*
> > +/**
> > + * folio_pte_batch - detect a PTE batch for a large folio
> > + * @folio: The large folio to detect a PTE batch for.
> > + * @addr: The user virtual address the first page is mapped at.
> > + * @start_ptep: Page table pointer for the first entry.
> > + * @pte: Page table entry for the first page.
>
> Nit:
>
> - * @pte: Page table entry for the first page.
> + * @pte: Page table entry for the first page that must be the first subp=
age of
> + *               the folio excluding arm64 for now.
>
> IIUC, pte_batch_hint is always 1 excluding arm64 for now.
> I'm not sure if this modification will be helpful?

I don't understand how this will be different for arm64 and others.
It seems pte_batch_hint with one value > 1 only helps move the
PTE pointer faster to finish the call.

Thanks
Barry

