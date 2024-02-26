Return-Path: <linux-kernel+bounces-81540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70835867744
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C24B21523
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A911292C5;
	Mon, 26 Feb 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdm5Uyar"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFD7E570
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955661; cv=none; b=CX2XAyqxhj27wiiAdbV49dur5u+NAzieY02hO9BRh5q5LR6Bmq1MB/2yBdUeSpr2yDnq8+BBp+qby+QsP341KorV4HZx0+qbQ2BX9bXFm2byCnVwE0vFUgWRHlZbxDvOVXraGzcsGu/woE1pqFv7cHhx+eR/UTDT8lkAse8YFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955661; c=relaxed/simple;
	bh=hTG8RN8eyoycsNq7/8/vAgSrE37KibGOD8NeQubaFe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrgbHbdwhwkRB8GWPVrjaeQXi4bVccYOckkEvJQBtfss64V/DgCnvhsdM0dMAJyED8o0NFteDmf3F/vewL1uCty4G7JuP9XFqP/sTmSAJw6Yt5/z/vSClxmG2g36unUadI9jwEgpuYgTlAW213hvmZNdxrqTIK7sVulDO3Q/mv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdm5Uyar; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6087d1355fcso16252447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955659; x=1709560459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZQA1pp9aylKKoMJWvQ6ksA0yhrk2u+zqXkCG99YSAI=;
        b=Kdm5UyarpZ/ktlVelhEuDIUE4QvgTeoiPeLSfyUXsOaI5bCK6aFXcW0chUqtycyQoa
         JS57lT5UlLygDmioTXtQ3vCiae6dXlAyJ6YP8dPIqBwFaFA9qZZD8L69aDc+Qe3k3vf+
         ZfBd8yZVqxnRGNNxZtDpFUTfNOrqB5tYNzLpsa5fN2Bz6vv+vjCamWloIR4hWborhCXC
         zRIabVqT0OH0J/1VNAlAWSi6fuq2zO9eVJAMFwgV2wFwdUvQxh7TIAbUdstiaR+avyJW
         tqjC1ya/v97vwqcOaO85wbF5diuTJrtyI6fokOQiCvaIt3lloiy1VHGZgUPtZz6PxckN
         25Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955659; x=1709560459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZQA1pp9aylKKoMJWvQ6ksA0yhrk2u+zqXkCG99YSAI=;
        b=GgJ1oCXzkenB5uBbrnkaYSGhNl2/5dp5YquuPpeKmiwEk1Gft1mA+xtquWlaEd/viM
         vf8/Y1WO5J07HvOClN0PYP9Kqyf9rcMojyOgm5Y0tldqB8aVJQfi6HWbw1I/1Nv52OPL
         Ljjr7Keianh5VmOIaUZ4fWgCLJz7pph3GQ49ElI22fM8DI3o40lzz3vXDOxbUEa9OUZK
         2A7mRCQ8Nd+fS6pl6ajMI/DR/ujns9SW60nEI9fRN3+RkQe8by+AC1W66hc5z+b2PL0G
         524t9o8+JR9hEzxQKuHvMi1yMK3k0576yfzyEHImdHB4SuZv0QKNPJf7rWWkPIV28b0x
         n2sg==
X-Forwarded-Encrypted: i=1; AJvYcCVwzrc9dI30rS9UtHs7wCBL16dM8olQz/SxuTAv54HnOR6dHPxvxcizUG1n19CvaL11fd1xwXJvnBv6YSWBGqHJIxOPb1wBKv0TBWiT
X-Gm-Message-State: AOJu0YwO4x8aBWzrbevBdmkD2UYFtDN5ueeIRuXFZ5xfZ4rYoZCnJ8+Q
	7i9DHAooXFyiAso9DSh97tFB9oB9gIoeULeCnk+sVyEzA51LHqjPDgIUI0glYzyNlh1fVlDqyco
	6BpzCmh3nuyt7Kw9gYxp0fkW4uXU=
X-Google-Smtp-Source: AGHT+IHfEDXPwirrGbDZyDEnfcb05w6mmL1hznqa/LO6H6EP1zwa8BUQPuVg2T6csrugRa2VWoxcK8z2i1xU05ujtCU=
X-Received: by 2002:a05:690c:5:b0:608:e3ac:e6ed with SMTP id
 bc5-20020a05690c000500b00608e3ace6edmr4593851ywb.10.1708955658999; Mon, 26
 Feb 2024 05:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225123215.86503-1-ioworker0@gmail.com> <c9d4fc77-0121-4415-a3f8-9fd7159992e2@arm.com>
In-Reply-To: <c9d4fc77-0121-4415-a3f8-9fd7159992e2@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 26 Feb 2024 21:54:07 +0800
Message-ID: <CAK1f24kwiH_tw-y+gL=Sgjkms3AxriAhoWvA0tTJh-Mc2Ek4zQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, shy828301@gmail.com, 
	david@redhat.com, mhocko@suse.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan,

Thanks for taking time to review!

On Mon, Feb 26, 2024 at 9:00=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Lance,
>
> Thanks for working on this!
>
>
> On 25/02/2024 12:32, Lance Yang wrote:
> > This patch improves madvise_free_pte_range() to correctly
> > handle large folio that is smaller than PMD-size
>
> When you say "correctly handle" are you implying there is a bug with the =
current
> implementation or are you just saying you can optimize this to improve
> performance? I'm not convinced there is a bug, but I agree there is certa=
inly
> room for performance improvement.

I agree with your point, and will update the changelog in v2.

Thanks again for your time!

Best,
Lance

>
> Thanks,
> Ryan
>
> > (for example, 16KiB to 1024KiB[1]). It=E2=80=99s probably part of
> > the preparation to support anonymous multi-size THP.
> >
> > Additionally, when the consecutive PTEs are mapped to
> > consecutive pages of the same large folio (mTHP), if the
> > folio is locked before madvise(MADV_FREE) or cannot be
> > split, then all subsequent PTEs within the same PMD will
> > be skipped. However, they should have been MADV_FREEed.
> >
> > Moreover, this patch also optimizes lazyfreeing with
> > PTE-mapped mTHP (Inspired by David Hildenbrand[2]). We
> > aim to avoid unnecessary folio splitting if the large
> > folio is entirely within the given range.
> >
> > On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
> > PTE-mapped folios of the same size results in the following
> > runtimes for madvise(MADV_FREE) in seconds (shorter is better):
> >
> > Folio Size  |    Old     |    New     |  Change
> > ----------------------------------------------
> >       4KiB  |  0.590251  |  0.590264  |     0%
> >      16KiB  |  2.990447  |  0.182167  |   -94%
> >      32KiB  |  2.547831  |  0.101622  |   -96%
> >      64KiB  |  2.457796  |  0.049726  |   -98%
> >     128KiB  |  2.281034  |  0.030109  |   -99%
> >     256KiB  |  2.230387  |  0.015838  |   -99%
> >     512KiB  |  2.189106  |  0.009149  |   -99%
> >    1024KiB  |  2.183949  |  0.006620  |   -99%
> >    2048KiB  |  0.002799  |  0.002795  |     0%
> >
> > [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm=
com
> > [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redh=
at.com/
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/madvise.c | 69 +++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 58 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index cfa5e7288261..bcbf56595a2e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                */
> >               if (folio_test_large(folio)) {
> >                       int err;
> > +                     unsigned long next_addr, align;
> >
> > -                     if (folio_estimated_sharers(folio) !=3D 1)
> > -                             break;
> > -                     if (!folio_trylock(folio))
> > -                             break;
> > +                     if (folio_estimated_sharers(folio) !=3D 1 ||
> > +                         !folio_trylock(folio))
> > +                             goto skip_large_folio;
> > +
> > +                     align =3D folio_nr_pages(folio) * PAGE_SIZE;
> > +                     next_addr =3D ALIGN_DOWN(addr + align, align);
> > +
> > +                     /*
> > +                      * If we mark only the subpages as lazyfree,
> > +                      * split the large folio.
> > +                      */
> > +                     if (next_addr > end || next_addr - addr !=3D alig=
n)
> > +                             goto split_large_folio;
> > +
> > +                     /*
> > +                      * Avoid unnecessary folio splitting if the large
> > +                      * folio is entirely within the given range.
> > +                      */
> > +                     folio_test_clear_dirty(folio);
> > +                     folio_unlock(folio);
> > +                     for (; addr !=3D next_addr; pte++, addr +=3D PAGE=
_SIZE) {
> > +                             ptent =3D ptep_get(pte);
> > +                             if (pte_young(ptent) || pte_dirty(ptent))=
 {
> > +                                     ptent =3D ptep_get_and_clear_full=
(
> > +                                             mm, addr, pte, tlb->fullm=
m);
> > +                                     ptent =3D pte_mkold(ptent);
> > +                                     ptent =3D pte_mkclean(ptent);
> > +                                     set_pte_at(mm, addr, pte, ptent);
> > +                                     tlb_remove_tlb_entry(tlb, pte, ad=
dr);
> > +                             }
> > +                     }
> > +                     folio_mark_lazyfree(folio);
> > +                     goto next_folio;
> > +
> > +split_large_folio:
> >                       folio_get(folio);
> >                       arch_leave_lazy_mmu_mode();
> >                       pte_unmap_unlock(start_pte, ptl);
> > @@ -688,13 +720,28 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                       err =3D split_folio(folio);
> >                       folio_unlock(folio);
> >                       folio_put(folio);
> > -                     if (err)
> > -                             break;
> > -                     start_pte =3D pte =3D
> > -                             pte_offset_map_lock(mm, pmd, addr, &ptl);
> > -                     if (!start_pte)
> > -                             break;
> > -                     arch_enter_lazy_mmu_mode();
> > +
> > +                     /*
> > +                      * If the large folio is locked before madvise(MA=
DV_FREE)
> > +                      * or cannot be split, we just skip it.
> > +                      */
> > +                     if (err) {
> > +skip_large_folio:
> > +                             if (next_addr >=3D end)
> > +                                     break;
> > +                             pte +=3D (next_addr - addr) / PAGE_SIZE;
> > +                             addr =3D next_addr;
> > +                     }
> > +
> > +                     if (!start_pte) {
> > +                             start_pte =3D pte =3D pte_offset_map_lock=
(
> > +                                     mm, pmd, addr, &ptl);
> > +                             if (!start_pte)
> > +                                     break;
> > +                             arch_enter_lazy_mmu_mode();
> > +                     }
> > +
> > +next_folio:
> >                       pte--;
> >                       addr -=3D PAGE_SIZE;
> >                       continue;
>

