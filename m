Return-Path: <linux-kernel+bounces-30644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7483226A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D768B21129
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83C1EB52;
	Thu, 18 Jan 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMncayNY"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4331EB36
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622064; cv=none; b=JXi8YeJyjmPSHmeL4flyZxn5jTc89BwcP46f+5ZOJlIbiIYLUqI+7xD/HOt1uM1Q/Ys6FglHrhhtoioHcsuo8LvjTJ1VI9NQ5UjwhNDqHpl8ReGnkQfynHy9LeDexiYuFQd8Mr8HzsfCiZOVA5r1CpnkTn4UupMqxlGimMETdDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622064; c=relaxed/simple;
	bh=YYJBifPbOOP5GXiqH8vcJl2O2HcdW8D6yCh3T4/TxXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRwUv/KIPCCCITBr3AATtT25/Lsfk6c9OOXlglVuvgj8DYL2ryx9gtdK/kVp9y5PdR3cNoDQAqLMxRnY//2xdRHeMI0EZgZBX7/OZCtXA//MujfkgFF0iUIkkyopd6pln6FKgFkxMlVCjJjvQWrIjZ7mchfHQ+P47lP5Cm0n/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMncayNY; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so69012241.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705622062; x=1706226862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csibKJZwe9QBeUcqCRzxQaxm9q++tACWnhZsAcs9+Ao=;
        b=lMncayNYwbuNT23JQgLTYCxsw9Yry2aR1lxQMawkMuiXmjD2NT4EeQFLiP4fBUn7tr
         ZRR1PAHp8hbWKR3J2pKuRMvCdXDH/b7aKk4glXjgk7GM8HYf1/2I+eT32MudUFfjJEFM
         QSpbttmP161jm6z+qmoFi5iEa4p8XVtfdCisNu/PKmL3UYBT3sshZ/hfRu0Uo9letThp
         JEmYv7tjXaCKQTphoRrCAHzAgh6lwwdckqFCVgWzkb029EthYxzK4K1slnY4KfBUYTRt
         lY23InxPz5ycCIlud6MgDTqESPJhePzdLYf1n6lMBJuOwJUetTPnNGJ4yIRtp/grs3f8
         1N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622062; x=1706226862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csibKJZwe9QBeUcqCRzxQaxm9q++tACWnhZsAcs9+Ao=;
        b=YHccbznel3yCJviQPhfPvUo2FJOj5BAULtCjgQp0L5itnlGMiDlUmGJtB6vT4e2Af0
         XfIH3LRf5cSuOh9MX6ZIrRUD6a4OP7DWHW3+K+lrd6pB8OUc0R2j5XVrICGE7TDNorsx
         tQG6A9XeJYoXnp4m8LJ3kHbBA7Tk43+gosamX2o9Y/L6KiCPwavHH2qrkdSAC42BLke3
         75p51DIVe3mXNnSfMLToreCUmh9V/gDCzfWyedYd6ftft6bDmjZFlrpri6WU8p2x8+zY
         74aWYqxtk23GUoT4LGrS4YM1+MWIZrb0iH0FUgUaCt1JaFSj67GG9cQPOuBKXSfsXa6f
         l6EA==
X-Gm-Message-State: AOJu0Yyy2lrsj+cSjlfIMjNUl5DNjm80JDeglpzwp9bDT/d9uCEYCoK6
	JIQonOAAGUw1EdpEVSeL2pyNaDNlxEGX6Ef2MfduIKuFjNzOkp8sVGFSXcZV9MzCsH8DoJS5txn
	3SiNoXLy+UjvOjMk4O98QjKV45xA=
X-Google-Smtp-Source: AGHT+IFPaf1FzqdUkzDXuFj5qbm17OW6S8RY5EJ2XlMRXIVI95KesvbU1YDDcnNDF7A/017mou+FQZkyI0v0rzpzecE=
X-Received: by 2002:a67:fd19:0:b0:468:e16:1cf9 with SMTP id
 f25-20020a67fd19000000b004680e161cf9mr1334711vsr.60.1705622061317; Thu, 18
 Jan 2024 15:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <0450f151-143a-4ce8-8131-31180bbc13b8@arm.com>
In-Reply-To: <0450f151-143a-4ce8-8131-31180bbc13b8@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 19 Jan 2024 07:54:10 +0800
Message-ID: <CAGsJ_4xHaAzOMphFt-0GwtS4f+Vj4cbR+WdX68TSQVo+-WR6rA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] mm: support large folios swap-in
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 18/01/2024 11:10, Barry Song wrote:
> > On an embedded system like Android, more than half of anon memory is ac=
tually
> > in swap devices such as zRAM. For example, while an app is switched to =
back-
> > ground, its most memory might be swapped-out.
> >
> > Now we have mTHP features, unfortunately, if we don't support large fol=
ios
> > swap-in, once those large folios are swapped-out, we immediately lose t=
he
> > performance gain we can get through large folios and hardware optimizat=
ion
> > such as CONT-PTE.
> >
> > In theory, we don't need to rely on Ryan's swap out patchset[1]. That i=
s to say,
> > before swap-out, if some memory were normal pages, but when swapping in=
, we
> > can also swap-in them as large folios.
>
> I think this could also violate MADV_NOHUGEPAGE; if the application has
> requested that we do not create a THP, then we had better not; it could c=
ause a
> correctness issue in some circumstances. You would need to pay attention =
to this
> vma flag if taking this approach.
>
> > But this might require I/O happen at
> > some random places in swap devices. So we limit the large folios swap-i=
n to
> > those areas which were large folios before swapping-out, aka, swaps are=
 also
> > contiguous in hardware.
>
> In fact, even this may not be sufficient; it's possible that a contiguous=
 set of
> base pages (small folios) were allocated to a virtual mapping and all swa=
pped
> out together - they would likely end up contiguous in the swap file, but =
should
> not be swapped back in as a single folio because of this (same reasoning =
applies
> to cluster of smaller THPs that you mistake for a larger THP, etc).
>
> So you will need to check what THP sizes are enabled and check the VMA
> suitability regardless; Perhaps you are already doing this - I haven't lo=
oked at
> the code yet.

we are actually re-using your alloc_anon_folio() by adding a parameter
to make it
support both do_anon_page and do_swap_page,

-static struct folio *alloc_anon_folio(struct vm_fault *vmf)
+static struct folio *alloc_anon_folio(struct vm_fault *vmf,
+      bool (*pte_range_check)(pte_t *, int))
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
  struct vm_area_struct *vma =3D vmf->vma;
@@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct
vm_fault *vmf)
  order =3D highest_order(orders);
  while (orders) {
  addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
- if (pte_range_none(pte + pte_index(addr), 1 << order))
+ if (pte_range_check(pte + pte_index(addr), 1 << order))
  break;
  order =3D next_order(&orders, order);
  }
@@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *=
vmf)
  if (unlikely(anon_vma_prepare(vma)))
  goto oom;
  /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
- folio =3D alloc_anon_folio(vmf);
+ folio =3D alloc_anon_folio(vmf, pte_range_none);
  if (IS_ERR(folio))
  return 0;
  if (!folio)
--

I assume this has checked everything?

>
> I'll aim to review the code in the next couple of weeks.

nice, thanks!

>
> Thanks,
> Ryan
>
> > On the other hand, in OPPO's product, we've deployed
> > anon large folios on millions of phones[2]. we enhanced zsmalloc and zR=
AM to
> > compress and decompress large folios as a whole, which help improve com=
pression
> > ratio and decrease CPU consumption significantly. In zsmalloc and zRAM =
we can
> > save large objects whose original size are 64KiB for example. So it is =
also a
> > better choice for us to only swap-in large folios for those compressed =
large
> > objects as a large folio can be decompressed all together.
> >
> > Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hard=
ware
> > with MTE" to this series as it might help review.
> >
> > [1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
> > https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@a=
rm.com/
> > [2] OnePlusOSS / android_kernel_oneplus_sm8550
> > https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplu=
s/sm8550_u_14.0.0_oneplus11
> >
> > Barry Song (2):
> >   arm64: mm: swap: support THP_SWAP on hardware with MTE
> >   mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
> >
> > Chuanhua Han (4):
> >   mm: swap: introduce swap_nr_free() for batched swap_free()
> >   mm: swap: make should_try_to_free_swap() support large-folio
> >   mm: support large folios swapin as a whole
> >   mm: madvise: don't split mTHP for MADV_PAGEOUT
> >
> >  arch/arm64/include/asm/pgtable.h |  21 ++----
> >  arch/arm64/mm/mteswap.c          |  42 ++++++++++++
> >  include/asm-generic/tlb.h        |  10 +++
> >  include/linux/huge_mm.h          |  12 ----
> >  include/linux/pgtable.h          |  62 ++++++++++++++++-
> >  include/linux/swap.h             |   6 ++
> >  mm/madvise.c                     |  48 ++++++++++++++
> >  mm/memory.c                      | 110 ++++++++++++++++++++++++++-----
> >  mm/page_io.c                     |   2 +-
> >  mm/rmap.c                        |   5 +-
> >  mm/swap_slots.c                  |   2 +-
> >  mm/swapfile.c                    |  29 ++++++++
> >  12 files changed, 301 insertions(+), 48 deletions(-)
> >
>

Thanks
Barry

