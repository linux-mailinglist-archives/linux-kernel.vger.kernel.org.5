Return-Path: <linux-kernel+bounces-82995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56B868CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7631C219C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C41369BF;
	Tue, 27 Feb 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub79+uO7"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8D131734
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027835; cv=none; b=fa5z4t0RcDM93NV+k0s378tq0tO3TsUcjgRKEMSToMLKHtYdEDWGtO8I2qllAUCbL5mR53MjACC7nRJD0ANsj/6TB2MRjRjd7M+Rhvtufdnzygn29hREdxAtmDvV/cCFWRx3fw03fBGm/6rHl428VI/rfy8pcIJ8eSnECCi0/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027835; c=relaxed/simple;
	bh=6fbOC/dFrsDm4Fj9k6voWNi2Kh2IZWZZDyRHML7iYDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxIWvpPamKFXEpvHaobue4DYVeUrU136+CtM4Il2HC2lyXeiYzyixMH8ZpHXAfP9ZI4Y55Al/sxv3HBKKL09AsKL46udfklIs2AHBwk8ikRaYP+Xk00vLWeuM9sSvmUqi6PhkSGXJ8xBX4yFXCu9b6jpm/N1gUUCE73L0mK3NZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub79+uO7; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3048353276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709027832; x=1709632632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44p1PS4kysmLkru7RBWfodjScSBkJAwmu615zPS+v1g=;
        b=Ub79+uO7bkkLsKYlUb+OIUEwH+pdiB9Sfd1IPqo86Mbdg5z+b6Gfuv5vmcfu3nuYAK
         +urx5Hf6PG/H2q/RnrA+8YdODlHDQqQ2c1v9ODTa87QKS6Klu1uKnfLGC7aYYaL16x2u
         m4Tf3mMeCF/9ESxQI2H5glyrJn+/MiBg/3NcNDmgFIv/K15rhI08K+ngz5iIxIzNO/xf
         n6iQc+sMmxYSj5bhWzXydbyP5c3mcB9DQPJA+nk0iDDhsdZLaw8jCUkbFg8tysoYKPiH
         v4FmWuNZKo51Ib+v0Ywk7CPxSXieHp139QeQhcTAsCLF/qKQTTiUT7Ge7HvExx7aR/8F
         HvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027832; x=1709632632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44p1PS4kysmLkru7RBWfodjScSBkJAwmu615zPS+v1g=;
        b=l4HZ69RLN6zRNZfYFPXcg+zeMoaG2YBbrXGvnmM0CKOeFHkQKBFOQt4objXlEHDkmD
         JHrxWNKtMpAjTWE6cUqBMIOh9o6AGqcHuR9szwZ+cAPgKVzEdEE/T3rmStMjfBS3o3Vn
         47KJ5STwyjO2HDl8HXgR/4F6bS1WAhu7KSkoZqFhYdFF1fOhhQI10GMc3zwQ4TUPT2WP
         SvYe7SLsnCprWE8k5vi6Iuzhc+ldiLlne71ArJGTarXZuSsWyT+DhpFdt+tLG1P8Uma6
         VAr/MruDTirMWzgMTCp1RafQlujprWLlz1RMj1hjotfHCzMYTU3GxY88CAN4fB8BCTOD
         bRaA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+VtELXJEZT+MPCjZm/+0Mt4nTYYTzJMIn8+wkQgR0j1zLDp5V59p+W3l3YgoNaVOR2cqBKI6dBomAGZWDsIt7xKdLSbtY9d5qsdU
X-Gm-Message-State: AOJu0YyLAroRvvW5l0D4SipqBiQfeBJ047w/sJU5tI+WYq8iDZYw9nld
	lBi9sDdDIiu2gMXTRJyXVU1on03FtQBGVFVcrcnk9Z/i/scoSCLyMD6SArRgpV/ZHR1iiBmjn06
	K83hFDB9k6oNYL2Ji2tfi4fLIkz4=
X-Google-Smtp-Source: AGHT+IH4y/NaYpL4iNYeAh2QxQjeoiL0zWSichhc1nCqXy5u2x8DfngNJvUHzA9e+4EsW4nDRUIPGcKxGHPhfn+gO9I=
X-Received: by 2002:a25:9e07:0:b0:dc6:9399:849e with SMTP id
 m7-20020a259e07000000b00dc69399849emr1375255ybq.11.1709027832414; Tue, 27 Feb
 2024 01:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com> <CAK1f24nwfyaF3Ly_-mMtf2fMvMgZ5sDVC1t0XsfF41ii6vvL5Q@mail.gmail.com>
 <fc8cdf6f-b400-4228-b8dc-3fb47df0b402@redhat.com>
In-Reply-To: <fc8cdf6f-b400-4228-b8dc-3fb47df0b402@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 17:57:00 +0800
Message-ID: <CAK1f24=K9bHpxNUUbOyVO=UbV-smvryr77yk3m1evY7khOQtJg@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 27.02.24 10:51, Lance Yang wrote:
> > On Tue, Feb 27, 2024 at 5:14=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 27.02.24 10:07, Ryan Roberts wrote:
> >>> On 27/02/2024 02:40, Barry Song wrote:
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> madvise and some others might need folio_pte_batch to check if a ran=
ge
> >>>> of PTEs are completely mapped to a large folio with contiguous physc=
ial
> >>>> addresses. Let's export it for others to use.
> >>>>
> >>>> Cc: Lance Yang <ioworker0@gmail.com>
> >>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>> Cc: David Hildenbrand <david@redhat.com>
> >>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>> ---
> >>>>    -v1:
> >>>>    at least two jobs madv_free and madv_pageout depend on it. To avo=
id
> >>>>    conflicts and dependencies, after discussing with Lance, we prefe=
r
> >>>>    this one can land earlier.
> >>>
> >>> I think this will also ultimately be useful for mprotect too, though =
I haven't
> >>> looked at it properly yet.
> >>>
> >>
> >> Yes, I think we briefly discussed that.
> >>
> >>>>
> >>>>    mm/internal.h | 13 +++++++++++++
> >>>>    mm/memory.c   | 11 +----------
> >>>>    2 files changed, 14 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>> index 13b59d384845..8e2bc304f671 100644
> >>>> --- a/mm/internal.h
> >>>> +++ b/mm/internal.h
> >>>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct foli=
o *folio)
> >>>>       return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> >>>>    }
> >>>>
> >>>> +/* Flags for folio_pte_batch(). */
> >>>> +typedef int __bitwise fpb_t;
> >>>> +
> >>>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >>>> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >>>> +
> >>>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dir=
ty bit. */
> >>>> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> >>>> +
> >>>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> >>>> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >>>> +            bool *any_writable);
> >>>> +
> >>>>    void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *fol=
io,
> >>>>                                               int nr_throttled);
> >>>>    static inline void acct_reclaim_writeback(struct folio *folio)
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 1c45b6a42a1b..319b3be05e75 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes=
(struct vm_area_struct *dst_vma,
> >>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> >>>>    }
> >>>>
> >>>> -/* Flags for folio_pte_batch(). */
> >>>> -typedef int __bitwise fpb_t;
> >>>> -
> >>>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >>>> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >>>> -
> >>>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dir=
ty bit. */
> >>>> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1))
> >>>> -
> >>>>    static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t fl=
ags)
> >>>>    {
> >>>>       if (flags & FPB_IGNORE_DIRTY)
> >>>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pt=
e_t pte, fpb_t flags)
> >>>>     * If "any_writable" is set, it will indicate if any other PTE be=
sides the
> >>>>     * first (given) PTE is writable.
> >>>>     */
> >>>
> >>> David was talking in Lance's patch thread, about improving the docs f=
or this
> >>> function now that its exported. Might be worth syncing on that.
> >>
> >> Here is my take:
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>    mm/memory.c | 22 ++++++++++++++++++----
> >>    1 file changed, 18 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index d0b855a1837a8..098356b8805ae 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pt=
e_t pte, fpb_t flags)
> >>          return pte_wrprotect(pte_mkold(pte));
> >>    }
> >>
> >> -/*
> >> +/**
> >> + * folio_pte_batch - detect a PTE batch for a large folio
> >> + * @folio: The large folio to detect a PTE batch for.
> >> + * @addr: The user virtual address the first page is mapped at.
> >> + * @start_ptep: Page table pointer for the first entry.
> >> + * @pte: Page table entry for the first page.
> >> + * @max_nr: The maximum number of table entries to consider.
> >> + * @flags: Flags to modify the PTE batch semantics.
> >> + * @any_writable: Optional pointer to indicate whether any entry exce=
pt the
> >> + *               first one is writable.
> >> + *
> >>     * Detect a PTE batch: consecutive (present) PTEs that map consecut=
ive
> >> - * pages of the same folio.
> >> + * pages of the same large folio.
> >>     *
> >>     * All PTEs inside a PTE batch have the same PTE bits set, excludin=
g the PFN,
> >>     * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY=
) and
> >>     * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
> >>     *
> >> - * If "any_writable" is set, it will indicate if any other PTE beside=
s the
> >> - * first (given) PTE is writable.
> >> + * start_ptep must map any page of the folio. max_nr must be at least=
 one and
> >> + * must be limited by the caller so scanning cannot exceed a single p=
age table.
> >> + *
> >> + * Return: the number of table entries in the batch.
> >>     */
> >>    static inline int folio_pte_batch(struct folio *folio, unsigned lon=
g addr,
> >>                  pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags=
,
> >> @@ -996,6 +1008,8 @@ static inline int folio_pte_batch(struct folio *f=
olio, unsigned long addr,
> >>                  *any_writable =3D false;
> >>
> >>          VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> >> +       VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio=
);
> >> +       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=3D fo=
lio, folio);
> >
> > Nit:
> > IIUC, the pte that maps to the first page.
> >   -       VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) !=3D
> > folio, folio);
> >   +       VM_WARN_ON_FOLIO(pte_pfn(pte) !=3D folio_pfn(folio), folio);
>
> That would only work if the PTE would map the very first subpage of the
> folio, not any subpage?

You're right. I got it.

>
> --
> Cheers,
>
> David / dhildenb
>

