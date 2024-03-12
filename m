Return-Path: <linux-kernel+bounces-100101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 918738791CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BF5B2159B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19857867A;
	Tue, 12 Mar 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlRPMobx"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084AAD53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238859; cv=none; b=ptVpujROKG2r+EB0qwrx7xljocDC+CSs27HsQ1uIMVV1uIsxLXmnvt9K3Mo21O5jb/yIW99/Gkwb6aNzjYqhO2ZDY87suALPs6E7XqnVSlT1ioGNOuFfdW3hK5Kj6p3L+6IGPnXo9mFQKjFRJpDW56cW3AJOG1LykvEmohz6ZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238859; c=relaxed/simple;
	bh=VDYpPpL9HwIOrO+3A3FM/2vrWpQfxayEQsCedR6Poo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8DpdJISCmYiPR41nZeKIccEd13mg6njuHwVovjIJn41LMlHYiWGhYzHeiXIgUWg3he3ik3bBXuAQKMUuft5wcbt7c2hOdbPMrO+75/gOU1ITUbrAKlbDloDDDjgC71pNaAgfGLellU3rTRX5mHONIG2cpZ5PY1WIBDIqOv3yM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlRPMobx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a0a54869bso28794847b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710238857; x=1710843657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGF/hIVTrAtQpunvsvrl+1vMh2fhzIOPNq7zDJSYdNY=;
        b=MlRPMobxE/GfNoW6q7r56xhR0Ks1kWBGrhFA3AhmLWUjN7vVA56wsUiwpdMlOTK39v
         ajeUWXiq6lNp0ox5pDBabTuq0v6fJIg3+xIZ80+BGLa8/iqd5s0Mp5r20QpUzYVOnHLd
         nMX/x1gORoYxW6FlAaAtk1Mb52u588KaDl4LahkKg7N1RVVcsdE0BSgB306ftSR/jVOu
         rLiEK0H0q0ub2a/gX5QsInOzGX3QQ3mw64rh9d5RkfVaoYZO/A5YRt6m1O/P3z0cbFfz
         hC7UNK5PYtQyS2rBzYllm8QjzeeZjKcang9wTXXTytAFWyY6hJPZRyjh6aBXn+0EPuQU
         g8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710238857; x=1710843657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGF/hIVTrAtQpunvsvrl+1vMh2fhzIOPNq7zDJSYdNY=;
        b=W1ovE+MwU/UMcbzxQPzsHE2Px9MiiRz5GcUALfCCy2HUEsgZG6Oo7aHQSTO0X1GYN0
         AGAchhmQsYeUxPW9FpPDJV5cXtkrwo9pLUB1qeY9ACpl+Wj55Ku1TRnd3x5JT0OplUNJ
         A43Rr2Ytu882CT8vZKqG5y/LFqNxatP+qdIBGfKF/Cu8hIiBpnVCVOSa5bH1CG+Tcng6
         edHexlAYtxxD/s5ecqAQoiZhF4zlMutmJjQ07OSPkco88hZdBVOEi8StfQxWMdqpnN/O
         mRShjrCfh2J/ZaqWZiuc0t5pPWxe8LafOiU2779K8KO7tnCUHL4ozns56RF28oiqGr54
         rJzg==
X-Forwarded-Encrypted: i=1; AJvYcCUqPgbqMyZhMQVT6rZKJhqq6id937KBnLWpO3Hcllv/H5GKwnHKp1EmT/L3/SNqFRcAwScAg4qByPNRwTZyrWQMd4akZj6cxkZHTZx4
X-Gm-Message-State: AOJu0YyqJ2NjSl2zuzb3aDDHmXiVR4MHM4wkO8q4lMUkNvqPYD1bqJOD
	7Srz+ngEKAIg+7A2Cw266+aBj/T8wxvgDWRKB3cDzoyaTt11z6GCrN7YoYtAZYr2gCxSXyyNFgH
	FcHyX/1xBQBRii7CWoxVE1RaKcDM=
X-Google-Smtp-Source: AGHT+IG6bMCGUYxeWt3V+sQi6R2N/d0jlLfhEG4tDYAcn9V+9ugAQtRlz0Q58rROEQRoU7hfv+1MZsVKTNYSPn/6vrU=
X-Received: by 2002:a05:690c:d1b:b0:60a:181f:16d8 with SMTP id
 cn27-20020a05690c0d1b00b0060a181f16d8mr5661633ywb.5.1710238857078; Tue, 12
 Mar 2024 03:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com> <4090ae12-8fb9-4e58-a093-86c13cca1d47@arm.com>
In-Reply-To: <4090ae12-8fb9-4e58-a093-86c13cca1d47@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 12 Mar 2024 18:20:45 +0800
Message-ID: <CAK1f24mawWz3BObGi6itqFq9Y0kFy40QzAir3EDxDtF+o=YY-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, david@redhat.com, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 07/03/2024 09:07, Ryan Roberts wrote:
> > On 07/03/2024 08:10, Barry Song wrote:
> >> On Thu, Mar 7, 2024 at 9:00=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> >>>
> >>> Hey Barry,
> >>>
> >>> Thanks for taking time to review!
> >>>
> >>> On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gmail.c=
om> wrote:
> >>>>>
> >>> [...]
> >>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long add=
r,
> >>>>> +                                                struct folio *foli=
o, pte_t *start_pte)
> >>>>> +{
> >>>>> +       int nr_pages =3D folio_nr_pages(folio);
> >>>>> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> >>>>> +
> >>>>> +       for (int i =3D 0; i < nr_pages; i++)
> >>>>> +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> >>>>> +                       return false;
> >>>>
> >>>> we have moved to folio_estimated_sharers though it is not precise, s=
o
> >>>> we don't do
> >>>> this check with lots of loops and depending on the subpage's mapcoun=
t.
> >>>
> >>> If we don't check the subpage=E2=80=99s mapcount, and there is a cow =
folio associated
> >>> with this folio and the cow folio has smaller size than this folio,
> >>> should we still
> >>> mark this folio as lazyfree?
> >>
> >> I agree, this is true. However, we've somehow accepted the fact that
> >> folio_likely_mapped_shared
> >> can result in false negatives or false positives to balance the
> >> overhead.  So I really don't know :-)
> >>
> >> Maybe David and Vishal can give some comments here.
> >>
> >>>
> >>>> BTW, do we need to rebase our work against David's changes[1]?
> >>>> [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@r=
edhat.com/
> >>>
> >>> Yes, we should rebase our work against David=E2=80=99s changes.
> >>>
> >>>>
> >>>>> +
> >>>>> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, start_p=
te,
> >>>>> +                                        ptep_get(start_pte), nr_pa=
ges, flags, NULL);
> >>>>> +}
> >>>>> +
> >>>>>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >>>>>                                 unsigned long end, struct mm_walk *=
walk)
> >>>>>
> >>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd,=
 unsigned long addr,
> >>>>>                  */
> >>>>>                 if (folio_test_large(folio)) {
> >>>>>                         int err;
> >>>>> +                       unsigned long next_addr, align;
> >>>>>
> >>>>> -                       if (folio_estimated_sharers(folio) !=3D 1)
> >>>>> -                               break;
> >>>>> -                       if (!folio_trylock(folio))
> >>>>> -                               break;
> >>>>> +                       if (folio_estimated_sharers(folio) !=3D 1 |=
|
> >>>>> +                           !folio_trylock(folio))
> >>>>> +                               goto skip_large_folio;
> >>>>
> >>>>
> >>>> I don't think we can skip all the PTEs for nr_pages, as some of them=
 might be
> >>>> pointing to other folios.
> >>>>
> >>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-=
16),
> >>>> and write the memory of PTE15 and PTE16, you get page faults, thus P=
TE15
> >>>> and PTE16 will point to two different small folios. We can only skip=
 when we
> >>>> are sure nr_pages =3D=3D folio_pte_batch() is sure.
> >>>
> >>> Agreed. Thanks for pointing that out.
> >>>
> >>>>
> >>>>> +
> >>>>> +                       align =3D folio_nr_pages(folio) * PAGE_SIZE=
;
> >>>>> +                       next_addr =3D ALIGN_DOWN(addr + align, alig=
n);
> >>>>> +
> >>>>> +                       /*
> >>>>> +                        * If we mark only the subpages as lazyfree=
, or
> >>>>> +                        * cannot mark the entire large folio as la=
zyfree,
> >>>>> +                        * then just split it.
> >>>>> +                        */
> >>>>> +                       if (next_addr > end || next_addr - addr !=
=3D align ||
> >>>>> +                           !can_mark_large_folio_lazyfree(addr, fo=
lio, pte))
> >>>>> +                               goto split_large_folio;
> >>>>> +
> >>>>> +                       /*
> >>>>> +                        * Avoid unnecessary folio splitting if the=
 large
> >>>>> +                        * folio is entirely within the given range=
.
> >>>>> +                        */
> >>>>> +                       folio_clear_dirty(folio);
> >>>>> +                       folio_unlock(folio);
> >>>>> +                       for (; addr !=3D next_addr; pte++, addr +=
=3D PAGE_SIZE) {
> >>>>> +                               ptent =3D ptep_get(pte);
> >>>>> +                               if (pte_young(ptent) || pte_dirty(p=
tent)) {
> >>>>> +                                       ptent =3D ptep_get_and_clea=
r_full(
> >>>>> +                                               mm, addr, pte, tlb-=
>fullmm);
> >>>>> +                                       ptent =3D pte_mkold(ptent);
> >>>>> +                                       ptent =3D pte_mkclean(ptent=
);
> >>>>> +                                       set_pte_at(mm, addr, pte, p=
tent);
> >>>>> +                                       tlb_remove_tlb_entry(tlb, p=
te, addr);
> >>>>> +                               }
> >>>>
> >>>> Can we do this in batches? for a CONT-PTE mapped large folio, you ar=
e unfolding
> >>>> and folding again. It seems quite expensive.
> >
> > I'm not convinced we should be doing this in batches. We want the initi=
al
> > folio_pte_batch() to be as loose as possible regarding permissions so t=
hat we
> > reduce our chances of splitting folios to the min. (e.g. ignore SW bits=
 like
> > soft dirty, etc). I think it might be possible that some PTEs are RO an=
d other
> > RW too (e.g. due to cow - although with the current cow impl, probably =
not. But
> > its fragile to assume that). Anyway, if we do an initial batch that ign=
ores all
> > that then do this bit as a batch, you will end up smeering all the ptes=
 with
> > whatever properties were set on the first pte, which probably isn't rig=
ht.
> >
> > I've done a similar conversion for madvise_cold_or_pageout_pte_range() =
as part
> > of my swap-out series v4 (hoping to post imminently, but still working =
out a
> > latent bug that it triggers). I use ptep_test_and_clear_young() in that=
, which
> > arm64 can apply per-pte but avoid doing a contpte unfold/fold. I know y=
ou have
> > to clear dirty here too, but I think this pattern is preferable.
> >
> > FYI, my swap-out series also halfway-batches madvise_free_pte_range() s=
o that I
> > can batch free_swap_and_cache() for the swap entry case. Ideally the wo=
rk you
> > are doing here would be rebased on top of that and plug-in to the appro=
ach
> > implemented there. (subject to others' views of course).
> >
> > I'll cc you when I post it.
>
> I just sent out the swap-out series v4, as I presed the button I realized=
 I
> forgot to cc you - sorry about that! It's at [1]. Patch 2 and 6 are the

No worries about that. Thanks for letting me know!
I will rebase our work on Patch 2 and 6.

Thanks,
Lance

> interesting ones from this PoV.
>
> [1] https://lore.kernel.org/linux-mm/20240311150058.1122862-1-ryan.robert=
s@arm.com/



>
>
> >
> >>>
> >>> Thanks for your suggestion. I'll do this in batches in v3.
> >>>
> >>> Thanks again for your time!
> >>>
> >>> Best,
> >>> Lance
> >>>
> >>>>
> >>>>> +                       }
> >>>>> +                       folio_mark_lazyfree(folio);
> >>>>> +                       goto next_folio;
> >>>>> +
> >>>>> +split_large_folio:
> >>>>>                         folio_get(folio);
> >>>>>                         arch_leave_lazy_mmu_mode();
> >>>>>                         pte_unmap_unlock(start_pte, ptl);
> >>>>> @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd,=
 unsigned long addr,
> >>>>>                         err =3D split_folio(folio);
> >>>>>                         folio_unlock(folio);
> >>>>>                         folio_put(folio);
> >>>>> -                       if (err)
> >>>>> -                               break;
> >>>>> -                       start_pte =3D pte =3D
> >>>>> -                               pte_offset_map_lock(mm, pmd, addr, =
&ptl);
> >>>>> -                       if (!start_pte)
> >>>>> -                               break;
> >>>>> -                       arch_enter_lazy_mmu_mode();
> >>>>> +
> >>>>> +                       /*
> >>>>> +                        * If the large folio is locked or cannot b=
e split,
> >>>>> +                        * we just skip it.
> >>>>> +                        */
> >>>>> +                       if (err) {
> >>>>> +skip_large_folio:
> >>>>> +                               if (next_addr >=3D end)
> >>>>> +                                       break;
> >>>>> +                               pte +=3D (next_addr - addr) / PAGE_=
SIZE;
> >>>>> +                               addr =3D next_addr;
> >>>>> +                       }
> >>>>> +
> >>>>> +                       if (!start_pte) {
> >>>>> +                               start_pte =3D pte =3D pte_offset_ma=
p_lock(
> >>>>> +                                       mm, pmd, addr, &ptl);
> >>>>> +                               if (!start_pte)
> >>>>> +                                       break;
> >>>>> +                               arch_enter_lazy_mmu_mode();
> >>>>> +                       }
> >>>>> +
> >>>>> +next_folio:
> >>>>>                         pte--;
> >>>>>                         addr -=3D PAGE_SIZE;
> >>>>>                         continue;
> >>>>> --
> >>>>> 2.33.1
> >>>>>
> >>
> >> Thanks
> >> Barry
> >
>

