Return-Path: <linux-kernel+bounces-41211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DED83ED76
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E48C1C21247
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EC2576B;
	Sat, 27 Jan 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWBCrcwd"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570811DFF8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706365656; cv=none; b=rJEVn5wf9s+wwFSg+ue8/Z2xwxeR5uHvZQqz2FjqzGuTji7Gp81kMCNUgbP471otCdmM1elpXLBogVkI+uOHX9Nlt732JsATjkbgcnPiCJNa8YaNlU4zgr3oN/SxJVmP2mKlvEh61C45Ee05dV8tOEFJAw4U/PFAS9+ul9TzkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706365656; c=relaxed/simple;
	bh=9iWfi5LYKjqwlOB7PwPV1HXG/v5UTmqsASRDqv0qjB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBwKCmCxcV9svA/dMqOnGGxr0KAsfLbF1OmBUoy32H7ThAYP3cC1NHKDorq5b1CrVuR2/7/MBH5jDTEGO7dsQ9oXWWuuKqMMw5VUp0ljuNaBEi947U6FgO+UPhj5Gn9ECY5kbO7nofrojCuQe2tQOyaKO/C6L2UZMkBxQDz5YAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWBCrcwd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429dd92b842so13681321cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706365653; x=1706970453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKCUzbh4CdSHg1rlaJlHT2QklO0r3IxMhk5Yk+OiuN4=;
        b=fWBCrcwdFifXex7ntxl1TK0hoBfH30QM6ZCHQyK1/tK700LQgVZ2r17mhQn3dRoWg0
         TLJoMb0sSE1Vno4U9ROPA1OVTqvxwayfBCK50eTPIuWQ9LiUQlfugfB5WnCLDoNtU+zv
         FzHoNC7PcbJbGUvcyzhEdiWAGlhoQpI8U7Sl+gu//dR4+1L8AitqhEJzk1yAWG3Y/HvL
         5asstkeVZhUUsjbaEssROUq02S6yKcnN3F7W6WN/8BLpH4NFMuFy+VhEBJIUWRM0XK7G
         MA6Q7wipRRTo0X3G8fI39ncBZuS8BOsL733iwO3ED8pTbyxsxd0Zt2KiL9ZjBGY5iliX
         Lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706365653; x=1706970453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKCUzbh4CdSHg1rlaJlHT2QklO0r3IxMhk5Yk+OiuN4=;
        b=BxspQCbSGewTEvVHdBqIZhzPLe+OlS4r7O51+bsZpCrN/fpgbAIn3fMfdwQt9xB8WG
         ZEfdXH7aoFor705wMDb9XuY8puIDUrrjmndqvrwnKWP1H/c/MoW4j2ODjNzD7DttEfTu
         ZUhNTSlcnQYHNXaNECyE+FvYtiNmxO3SrCtQ47CuouGaDZNScNVKux83b1yUEJrWInLX
         jqGUAR+R2Gljdr9N4QIM+Gz2EcnJg1Koc/sCAYosAERizEZLauqkspJrPYhRo7hD5jvB
         X3v1D4dzBOco0q/QT9rHgb6E2HfC85+KwLPXDu3uTtE4R+46Vkud1ncR0bWIwdNKoewP
         0eAA==
X-Gm-Message-State: AOJu0YwRjG3NURqJL2dvwQy5woaxvG+jZZX6LoC1wI1UhH5UmgErYLEw
	+Ua6SzB9/v0kRjLsyffVk9n+cjEmviuATLFGMUfRiQKaUIOApLvX69z/fXTKz21Pl07HhNf4nyz
	mJqIRKwq2IknXTrd+Y6wSa0mR99Y=
X-Google-Smtp-Source: AGHT+IGju8gckovWFFrxF1EKjK8vrcbN3lwLPk374enU3Pw8lBzZttlOmsVDA31YYDFBsh88lq0qXAIGURn2AZsCcA8=
X-Received: by 2002:a05:620a:148c:b0:783:d917:7dd9 with SMTP id
 w12-20020a05620a148c00b00783d9177dd9mr1597947qkj.24.1706365653055; Sat, 27
 Jan 2024 06:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <0450f151-143a-4ce8-8131-31180bbc13b8@arm.com> <CAGsJ_4xHaAzOMphFt-0GwtS4f+Vj4cbR+WdX68TSQVo+-WR6rA@mail.gmail.com>
 <caf72da8-1f32-4eb4-9935-b49c1efed4c5@arm.com>
In-Reply-To: <caf72da8-1f32-4eb4-9935-b49c1efed4c5@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 27 Jan 2024 22:27:21 +0800
Message-ID: <CAGsJ_4z-smNivr0m7df=K6WpTvjakzB9FMf-36OWMr5+T0nzLQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] mm: support large folios swap-in
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 9:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 18/01/2024 23:54, Barry Song wrote:
> > On Thu, Jan 18, 2024 at 11:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> On 18/01/2024 11:10, Barry Song wrote:
> >>> On an embedded system like Android, more than half of anon memory is =
actually
> >>> in swap devices such as zRAM. For example, while an app is switched t=
o back-
> >>> ground, its most memory might be swapped-out.
> >>>
> >>> Now we have mTHP features, unfortunately, if we don't support large f=
olios
> >>> swap-in, once those large folios are swapped-out, we immediately lose=
 the
> >>> performance gain we can get through large folios and hardware optimiz=
ation
> >>> such as CONT-PTE.
> >>>
> >>> In theory, we don't need to rely on Ryan's swap out patchset[1]. That=
 is to say,
> >>> before swap-out, if some memory were normal pages, but when swapping =
in, we
> >>> can also swap-in them as large folios.
> >>
> >> I think this could also violate MADV_NOHUGEPAGE; if the application ha=
s
> >> requested that we do not create a THP, then we had better not; it coul=
d cause a
> >> correctness issue in some circumstances. You would need to pay attenti=
on to this
> >> vma flag if taking this approach.
> >>
> >>> But this might require I/O happen at
> >>> some random places in swap devices. So we limit the large folios swap=
-in to
> >>> those areas which were large folios before swapping-out, aka, swaps a=
re also
> >>> contiguous in hardware.
> >>
> >> In fact, even this may not be sufficient; it's possible that a contigu=
ous set of
> >> base pages (small folios) were allocated to a virtual mapping and all =
swapped
> >> out together - they would likely end up contiguous in the swap file, b=
ut should
> >> not be swapped back in as a single folio because of this (same reasoni=
ng applies
> >> to cluster of smaller THPs that you mistake for a larger THP, etc).
> >>
> >> So you will need to check what THP sizes are enabled and check the VMA
> >> suitability regardless; Perhaps you are already doing this - I haven't=
 looked at
> >> the code yet.
> >
> > we are actually re-using your alloc_anon_folio() by adding a parameter
> > to make it
> > support both do_anon_page and do_swap_page,
> >
> > -static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> > +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> > +      bool (*pte_range_check)(pte_t *, int))
> >  {
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   struct vm_area_struct *vma =3D vmf->vma;
> > @@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct
> > vm_fault *vmf)
> >   order =3D highest_order(orders);
> >   while (orders) {
> >   addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > - if (pte_range_none(pte + pte_index(addr), 1 << order))
> > + if (pte_range_check(pte + pte_index(addr), 1 << order))
> >   break;
> >   order =3D next_order(&orders, order);
> >   }
> > @@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
> >   if (unlikely(anon_vma_prepare(vma)))
> >   goto oom;
> >   /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault=
 */
> > - folio =3D alloc_anon_folio(vmf);
> > + folio =3D alloc_anon_folio(vmf, pte_range_none);
> >   if (IS_ERR(folio))
> >   return 0;
> >   if (!folio)
> > --
> >
> > I assume this has checked everything?
>
> Ahh yes, very good. In that case you can disregard what I said; its alrea=
dy covered.
>
> I notice that this series appears as a reply to my series. I'm not sure w=
hat the
> normal convention is, but I expect more people would see it if you posted=
 it as
> its own thread?

yes. i was replying your series because we were using your series to
swapout large folios
without splitting. in v2,  i will send it as a new thread.

>
>
> >
> >>
> >> I'll aim to review the code in the next couple of weeks.
> >
> > nice, thanks!
> >
> >>
> >> Thanks,
> >> Ryan
> >>
> >>> On the other hand, in OPPO's product, we've deployed
> >>> anon large folios on millions of phones[2]. we enhanced zsmalloc and =
zRAM to
> >>> compress and decompress large folios as a whole, which help improve c=
ompression
> >>> ratio and decrease CPU consumption significantly. In zsmalloc and zRA=
M we can
> >>> save large objects whose original size are 64KiB for example. So it i=
s also a
> >>> better choice for us to only swap-in large folios for those compresse=
d large
> >>> objects as a large folio can be decompressed all together.
> >>>
> >>> Note I am moving my previous "arm64: mm: swap: support THP_SWAP on ha=
rdware
> >>> with MTE" to this series as it might help review.
> >>>
> >>> [1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
> >>> https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts=
@arm.com/
> >>> [2] OnePlusOSS / android_kernel_oneplus_sm8550
> >>> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/onep=
lus/sm8550_u_14.0.0_oneplus11
> >>>
> >>> Barry Song (2):
> >>>   arm64: mm: swap: support THP_SWAP on hardware with MTE
> >>>   mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
> >>>
> >>> Chuanhua Han (4):
> >>>   mm: swap: introduce swap_nr_free() for batched swap_free()
> >>>   mm: swap: make should_try_to_free_swap() support large-folio
> >>>   mm: support large folios swapin as a whole
> >>>   mm: madvise: don't split mTHP for MADV_PAGEOUT
> >>>
> >>>  arch/arm64/include/asm/pgtable.h |  21 ++----
> >>>  arch/arm64/mm/mteswap.c          |  42 ++++++++++++
> >>>  include/asm-generic/tlb.h        |  10 +++
> >>>  include/linux/huge_mm.h          |  12 ----
> >>>  include/linux/pgtable.h          |  62 ++++++++++++++++-
> >>>  include/linux/swap.h             |   6 ++
> >>>  mm/madvise.c                     |  48 ++++++++++++++
> >>>  mm/memory.c                      | 110 ++++++++++++++++++++++++++---=
--
> >>>  mm/page_io.c                     |   2 +-
> >>>  mm/rmap.c                        |   5 +-
> >>>  mm/swap_slots.c                  |   2 +-
> >>>  mm/swapfile.c                    |  29 ++++++++
> >>>  12 files changed, 301 insertions(+), 48 deletions(-)
> >>>
> >>
> >
 Thanks
 Barry
>

