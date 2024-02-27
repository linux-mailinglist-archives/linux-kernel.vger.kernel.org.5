Return-Path: <linux-kernel+bounces-82990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16A868CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A85280C89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55586137C34;
	Tue, 27 Feb 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJB7CVTO"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80B1369B9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027478; cv=none; b=PuyFslruMKgW+hcijZ/bnrycuhbujz12D96g3Nv8ZusJ/ITtZ5rXWV3KLIcHnpZuK3YN5lfBxEGqkTUMsbWePpLGa6AXHMOV2Vjb4szxJbQcK6fhHIeIgkuMNsqFSvpdu8leR65uoH80Re2XLpV48mrf3FQPbvl3iy5x2V/hcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027478; c=relaxed/simple;
	bh=ThSU5xHCDVx5Eje/Pmo00tRaVsY0FDEDS390scOQpiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ldh/fb4OngzDRoD06opINeouDsbkYIxOrAtE7Rs4F7UmwXZKB3bKdpWrZB/K2E21s4y75lBWfR8WmTLVjW7vhvRaM+Y18e66tXcDPgERxmBpxwEBBUR4G4pa4AM8dCi9Dg1rcuG7e4Pzic3pL4atcDoP+ROU24zWmNh1mlY4GfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJB7CVTO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso3158358276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709027476; x=1709632276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLfwVegLj3NllSkhisIJaN4ho41gslKZMK9c3d+Tq3A=;
        b=BJB7CVTOSOZyGsyskJtEaMvlLXasyDiknqB1eB5nTdbnGrBP5zcoMvC+hWFa7LVVzc
         thPhpOHm16ehrRrfUJnmtSItaYh8FpkayxdkP/BnbJx0XnlfHgLJo2x8JpPgYDwBDXoJ
         Ib/ubaoA5tO5cv8YXVyVz2j1jwsvFcHavaIIoqwY7m/aFTaL/5/yz0U7JOQmoAF44oMd
         ArUFBiu23U5bvh7PC5/hgs+PlrPR/QsF7rEz9OOpNvnciOS/kN/e3fr6bcZCIShWhq6R
         MamwZtJLn1Y9+wgv7qAywwKTWBi1dLc8zPAQbQ0uRW8yNsHAJgi62Z861llcjpJSX3VH
         uo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027476; x=1709632276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLfwVegLj3NllSkhisIJaN4ho41gslKZMK9c3d+Tq3A=;
        b=D9/FCs+OcnfOKzb/de58a3dBRK+t84EcVebCkWaoTJSa/i2ElXgaC+u5z7m+U5l0MW
         j7lokoFMzXDak6qhop5dT5mio3BUEXUysBTUpOAOYOwWVdvc0/b+XYdjbCD5Fp1GtaoA
         WAZBwcPOlisGQx0IVBOpUMdfIM/pyWQ3XovZJYrMJCEEZStVCHraVKT2puR39SFBbMXF
         JtOO+vK5k7BLQ/ONFwSvJ/lGPNE5e+m5zZz2hJc/Os5xi5zT4Sa5bf1hT1UgaAOq6WYN
         tbF3iMneed86wkbirxRPHmHuXNsIN9JbQ86NNG/Rc07VdcR0fSTmvQDk4UlVcvEKODIt
         SEiw==
X-Forwarded-Encrypted: i=1; AJvYcCVS7ZOAuoDjY+hsXWX55pKHelNjZkRRMZtEqBDH26/WB3FvjYYi3fopylkHMcqqdLuaG6wVHWWiPvE8aDYV6WFz5oOvKZaYM91D2Won
X-Gm-Message-State: AOJu0Yzbun//wdyIHHzcOId8Ny79KZms+ATL1ITdmbmC6IiFT3mhxvZ8
	eJrV3rn14TvSPiotdNOpu4AAuvb98MaY7JdyvcUyd4adlmDfeTWJM26Il/lkQtVfYOAzkhrizjZ
	elUiW6Oiai3iFWw17tXGAfo2PkIY=
X-Google-Smtp-Source: AGHT+IEinYi93IuP4wYqcK9lifs9plKOa9iN+CuwNoBD+nMvGgbpqn7mazEDEhomyUZjmrJS0iPzWPmXlqu0U/yXuI8=
X-Received: by 2002:a25:74d3:0:b0:dcd:5bfa:8184 with SMTP id
 p202-20020a2574d3000000b00dcd5bfa8184mr1600906ybc.39.1709027475695; Tue, 27
 Feb 2024 01:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
In-Reply-To: <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 17:51:03 +0800
Message-ID: <CAK1f24nwfyaF3Ly_-mMtf2fMvMgZ5sDVC1t0XsfF41ii6vvL5Q@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.02.24 10:07, Ryan Roberts wrote:
> > On 27/02/2024 02:40, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> madvise and some others might need folio_pte_batch to check if a range
> >> of PTEs are completely mapped to a large folio with contiguous physcia=
l
> >> addresses. Let's export it for others to use.
> >>
> >> Cc: Lance Yang <ioworker0@gmail.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Yin Fengwei <fengwei.yin@intel.com>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> ---
> >>   -v1:
> >>   at least two jobs madv_free and madv_pageout depend on it. To avoid
> >>   conflicts and dependencies, after discussing with Lance, we prefer
> >>   this one can land earlier.
> >
> > I think this will also ultimately be useful for mprotect too, though I =
haven't
> > looked at it properly yet.
> >
>
> Yes, I think we briefly discussed that.
>
> >>
> >>   mm/internal.h | 13 +++++++++++++
> >>   mm/memory.c   | 11 +----------
> >>   2 files changed, 14 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/internal.h b/mm/internal.h
> >> index 13b59d384845..8e2bc304f671 100644
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio =
*folio)
> >>      return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> >>   }
> >>
> >> +/* Flags for folio_pte_batch(). */
> >> +typedef int __bitwise fpb_t;
> >> +
> >> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >> +
> >> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty=
 bit. */
> >> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> >> +
> >> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> >> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >> +            bool *any_writable);
> >> +
> >>   void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> >>                                              int nr_throttled);
> >>   static inline void acct_reclaim_writeback(struct folio *folio)
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 1c45b6a42a1b..319b3be05e75 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(s=
truct vm_area_struct *dst_vma,
> >>      set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> >>   }
> >>
> >> -/* Flags for folio_pte_batch(). */
> >> -typedef int __bitwise fpb_t;
> >> -
> >> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >> -
> >> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty=
 bit. */
> >> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> >> -
> >>   static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags=
)
> >>   {
> >>      if (flags & FPB_IGNORE_DIRTY)
> >> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_=
t pte, fpb_t flags)
> >>    * If "any_writable" is set, it will indicate if any other PTE besid=
es the
> >>    * first (given) PTE is writable.
> >>    */
> >
> > David was talking in Lance's patch thread, about improving the docs for=
 this
> > function now that its exported. Might be worth syncing on that.
>
> Here is my take:
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/memory.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d0b855a1837a8..098356b8805ae 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
>         return pte_wrprotect(pte_mkold(pte));
>   }
>
> -/*
> +/**
> + * folio_pte_batch - detect a PTE batch for a large folio
> + * @folio: The large folio to detect a PTE batch for.
> + * @addr: The user virtual address the first page is mapped at.
> + * @start_ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @max_nr: The maximum number of table entries to consider.
> + * @flags: Flags to modify the PTE batch semantics.
> + * @any_writable: Optional pointer to indicate whether any entry except =
the
> + *               first one is writable.
> + *
>    * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> - * pages of the same folio.
> + * pages of the same large folio.
>    *
>    * All PTEs inside a PTE batch have the same PTE bits set, excluding th=
e PFN,
>    * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) an=
d
>    * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
>    *
> - * If "any_writable" is set, it will indicate if any other PTE besides t=
he
> - * first (given) PTE is writable.
> + * start_ptep must map any page of the folio. max_nr must be at least on=
e and
> + * must be limited by the caller so scanning cannot exceed a single page=
 table.
> + *
> + * Return: the number of table entries in the batch.
>    */
>   static inline int folio_pte_batch(struct folio *folio, unsigned long ad=
dr,
>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> @@ -996,6 +1008,8 @@ static inline int folio_pte_batch(struct folio *foli=
o, unsigned long addr,
>                 *any_writable =3D false;
>
>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> +       VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> +       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=3D folio=
, folio);

Nit:
IIUC, the pte that maps to the first page.
 -       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=3D
folio, folio);
 +       VM_WARN_ON_FOLIO(pte_pfn(pte) !=3D folio_pfn(folio), folio);

>         nr =3D pte_batch_hint(start_ptep, pte);
>         expected_pte =3D __pte_batch_clear_ignored(pte_advance_pfn(pte, n=
r), flags);
> --
> 2.43.2
>
>
> >
> >> -static inline int folio_pte_batch(struct folio *folio, unsigned long =
addr,
> >> +int folio_pte_batch(struct folio *folio, unsigned long addr,
> >
> > fork() is very performance sensitive. Is there a risk we are regressing
> > performance by making this out-of-line? Although its in the same compil=
ation
> > unit so the compiler may well inline it anyway?
>
> Easy to verify by looking at the generated asm I guess?
>
> >
> > Either way, perhaps we are better off making it inline in the header? T=
hat would
> > avoid needing to rerun David's micro-benchmarks for fork() and munmap()=
.
>
> That way, the compiler can most certainly better optimize it also outside=
 of mm/memory.c
>
> --
> Cheers,
>
> David / dhildenb
>

