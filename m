Return-Path: <linux-kernel+bounces-83023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE07868D64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A424C28E1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDFA13849C;
	Tue, 27 Feb 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuAe0qpw"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F002138492
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029332; cv=none; b=Bk5uQwvofRS/QPW3hWmg+qGyDt+/sgefQueW4JBsr/VfsDkexGvVe9aoA7Bu7G/IVtS4Pcgm/Z+3Um09OnuTA3SyXrevD42R6xcnSwJY0lqv+rBqApC+PVaR2YegDoiZ6SG7Q6M0H2YemszEyHyGO2lPRdsoUhmVm5FrrC/ytm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029332; c=relaxed/simple;
	bh=cmWxvGCVhYTkbWiKq2bJiR26WUpAeY/TtzgpuaJj1/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP4MBJDV7oF2b+KdOqOOHqBPnCdTKwAGJQbehZ6xKPiG4Qrb3JAtgAPAWsTo0F2WuW5DSgGQ6tmA3hOPzRcZbXMFAjHCXoqKJwc7Cu4gLLT8uDehRWmr9ViXmI27kXJw0pZymwmkVUgzLogaKDBze76vyjja6S+HGs9V3/RJb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuAe0qpw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so4159670276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709029329; x=1709634129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVqspSV8bn52+VvDaD9TtJ1YOvvJ6e4K2RuUE7mf/l4=;
        b=WuAe0qpw7mLtky04XUCn4uwT/rEpOVdhVOUwzkWhBzM8bHAhVGrlqOS5nHzZvv72qU
         UURqS8iyiVpukAAv7wgFFkITZ+qIH3BdN87Ipox5clI5C6kb9TZJnHqCYWywIyjNAjVi
         /SaG80YhJgDRkrc7ALl3j2UGCHAB1Nr0Mc8VUsE2vKJ0B9fWSuoHYeMJwK9ryQJSu4IH
         91gnuSYMZHSeGRc4hWYK7r/eo/XbpucLxonTnlJpLbto7WfOPxFi5kNNC4rZ/jTBc1LU
         EYeiNUJc+vJhw7Lf4UwQK1snTbBaMiV932Y7DO8fBdMRplbSfpsIJxTs6HpzTWPByOXm
         YYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709029329; x=1709634129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVqspSV8bn52+VvDaD9TtJ1YOvvJ6e4K2RuUE7mf/l4=;
        b=MgSCEbrq2WwbH1MD42cHVllFNrBrHioczqUjfrTpOq5klALKqrr2pEGGbVWzLF8XyJ
         Fg3ytt1fT/44TGgJsQ3CyV3o2Z2rDIch34kBd4p025d+UUoL+hWXEm50xnUmYwIgMYNX
         W2YJQukiJSYsiDpTmWc1DRUyjvHB5o0bZLGte+t8snBTNzEG02FokDit5tCUjxXbWXNr
         hRP1c9Urc1uoC2YfeRF8xPFeSy8y37y3uOHKq/27J5VVCUPBwnI19ZEWa4+vvSf+Ev8U
         ctj5ARqxaB0nuEoQXzuJxvLq2KSQaxS/5cS/bsU0KS0oEU3uZQKR9ReDm9H9hn1HY29z
         ULXA==
X-Forwarded-Encrypted: i=1; AJvYcCVq1Q7+iB3p0W5No81jWkDdoJqVOEZm3sV4br93JS4I3V7vyhNK9YKlD8qb+JlAynRYdILsXg3wNFuc07e2AXa5HoP7RR3iNeCaes/Y
X-Gm-Message-State: AOJu0Yw/16jXBpXft9CFHy+69rWgh+0V1M+0SVfwMZY8rozJv6XkAS1L
	7AbEPz1YW6e3PYvzKZsI7yyWAjdZhYF64qu0WXmcN/vUA9PP5wtsvWR9flMSIoG4Rqpq8C/6T7p
	RUF/1CQOsUA9A53aOgXr4GIf9bSU=
X-Google-Smtp-Source: AGHT+IETJjY/UIWO4RH1eSLrcFb2JcXGvEThD2ZUfMF0v7Hk5cFqhNEY+0DG7mhX4z3+ttuEjHe+5usQfemEPH+/WTY=
X-Received: by 2002:a25:dcc8:0:b0:dcc:f0a:e495 with SMTP id
 y191-20020a25dcc8000000b00dcc0f0ae495mr1512825ybe.3.1709029329482; Tue, 27
 Feb 2024 02:22:09 -0800 (PST)
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
Date: Tue, 27 Feb 2024 18:21:58 +0800
Message-ID: <CAK1f24mOc+Y_UCA2nSC7VbNQMy0DahULz-6JsEPMqTyoAA+MoA@mail.gmail.com>
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

Nit:

- * @pte: Page table entry for the first page.
+ * @pte: Page table entry for the first page that must be the first subpag=
e of
+ *               the folio excluding arm64 for now.

IIUC, pte_batch_hint is always 1 excluding arm64 for now.
I'm not sure if this modification will be helpful?

Thanks,
Lance

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
>
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

