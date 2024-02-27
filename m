Return-Path: <linux-kernel+bounces-82956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74A868C37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3EE28A394
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C15136663;
	Tue, 27 Feb 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAiOFM+n"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA054BD4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026069; cv=none; b=Fj0s6y1TAo0/3bZVm+D+Vc/MRg80gtP+DuagGaLSvUnzxMVKJ6TD3T0g6zNJm3radqpoNsVrxRP4t4tURaWu+lXHWe3LFEaIGAa0nZwDsJ9YDcNxuwxgRZQXaoJ/p1oikjDMVStU/ccHeICRmteLz3+ZdGTNqyhE6DVw8yQYPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026069; c=relaxed/simple;
	bh=OoQBsxVZ2SK4JLgU4OedYpYq7Z0S1CY+f9hOXYk8PUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0OfPt16dW7lAIHiCuD5fqeqnkQly1v0balCeXPhe89pN+Yv3wp4Priz40IH+3wqkxhckdKv1rabZ8GBnFVFWT2dRDbg7vOauNy+KtbCz7Yfz2uXtJCGt4/xInchQM2Rssa6mECXQuh9L5gxzU9+P4shqEZ/Fze2UVQJKMLcay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAiOFM+n; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso2363296241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709026067; x=1709630867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JnPwwMCUBnYLzcxQfOuWfmpjNJn/her9A9WUWKljo4=;
        b=aAiOFM+nJPb5YR/KGt4mqAP8ArsFuhHtgYHQBXDiM9jS/oF3ex7/N/6ZhHa1BjrxY6
         z8Q41GOltPpJwjDB3SVXxHrXc7zYS3U0CY6wUAeh61np3c8qeRROpA64Jg9kDL4nMbqz
         X/Y4+L8382egASVpCmY9wz4+vDEby1DwvNWSesBUvtNLsWlGP1tlZgA/l/IuWQxqYlh/
         RcASXwsdRJZXYolc98Z17CtXoEUn5Bwgqr0hLQkmIMzTYgCI2iznZdNRenuWz3UhTKiH
         169yTHiPGuQRYNdS6jT5jdILC6dl2DcjfzDBIpVJlnTUMmuBsg7Oq+keMvc69Vr6evXd
         Brqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709026067; x=1709630867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JnPwwMCUBnYLzcxQfOuWfmpjNJn/her9A9WUWKljo4=;
        b=udfKNWTvonJXZJsQFNTv67SIsv7hdi5TNt9W90+01ITxnV+BcF35+UB0h2jd2X3GxE
         smAcOWnCdLfCnld8t/qXPGtwH1JnQBwVWGN6tLQE5tep0wZQ0aL1wxr5WcrCSTzhRssH
         n9yBbmHvO7cZYN/7Ok/wP6FahJuHLv+KUGFZy7lB+2dlxRY84WI8EeNmC/VBpg6Z/3kj
         Pc6Q5TMM9u2IU5s4w0I3Uor8Zkz5lG4InqkYyxnfL4FxPQ3rDdgaPHQyjm0hXyYwp5CA
         PJRi5J7qbp+xjyYkQj3aF7Ek23382OzOdcUvW5+uwUCElXxNt3lqC/HoXhKGcGx+Insx
         P81A==
X-Forwarded-Encrypted: i=1; AJvYcCXufrruisCiVJCBAinP4In8aFjd5XUIX8Z7Trqx8sDT86g5SLXHHYfkH+oVwGwdJU+JJn+2V10rgO6X92S9ESPla4sGh81p6mCpmrZJ
X-Gm-Message-State: AOJu0Yy2cmG5XnQWbh/2KNTqn0qPAw7OYJ+B0HtkTg0D2+ZZAJ41Akx2
	ZQ9nq0pnSoULnjNzFHvIhaO99U5TyGgVUmjSDoV27qR7W81RslHBQN/vI/XlCEbsTc0TL2fBZIc
	UbpEK087W8q/kM1A2mhLgWuLT6uk=
X-Google-Smtp-Source: AGHT+IEYjjFXebZ9zBwdv+BbHOLU6dj330KP0FVJ/sz3eLmDyaisZp2vNDTwtybCbgh5YmPssbQIDaimF31wF5RL9Io=
X-Received: by 2002:a05:6102:21c8:b0:472:61c9:818a with SMTP id
 r8-20020a05610221c800b0047261c9818amr66386vsg.13.1709026066888; Tue, 27 Feb
 2024 01:27:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
In-Reply-To: <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 22:27:35 +1300
Message-ID: <CAGsJ_4z3dbqnN5nkKgm2_zyLHK0gqMugzPYMkPpRMK4ypBVJNw@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:14=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
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

my aarch64-linux-gnu-gcc didn't inline it

$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.

$ nm -S -s vmlinux.a | grep  folio_pte_batch
0000000000003818 0000000000000204 T folio_pte_batch

>
> >
> > Either way, perhaps we are better off making it inline in the header? T=
hat would
> > avoid needing to rerun David's micro-benchmarks for fork() and munmap()=
.

actually tried this before trying extern, the problem is that we have to ad=
d
others into internal.h, for example __pte_batch_clear_ignored, which
seems not API. are we comfortable to move that one to internal.h too?

>
> That way, the compiler can most certainly better optimize it also outside=
 of mm/memory.c
>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

