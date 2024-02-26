Return-Path: <linux-kernel+bounces-80673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC2866B14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782CE1F21F11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436841C6A3;
	Mon, 26 Feb 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnmmN76V"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93A1C6A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932727; cv=none; b=SLSod8lKgjqX49IsXqSHQ/QhJwFmzYPIzVSUORPu+mc5kv/BB6Yvtb6JCoVO6zQfkDS3sdBB+S7L1q2QAWi00SwcuiKA4f10mSlIzCIBOmUvPhsmZDU03YsP/GKq/iE2BnZEnqztmGgr0a1LZ5bQjKhV8vy0V5NtU+d29vzGHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932727; c=relaxed/simple;
	bh=6z/Y75es29aJAA7xf4HJe9tHDILPi+cFRBqJaKSBQcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0TJuoJzcdoM2oKqhUx5KJ7It8+4POQa1ev8k5aDcuTZwRf6pGcADLvqlqbq4gbyoq581A2hLDnlRiMw0VQzU5tc/572ORlwGoZwRLo5XK44Ra1p4AnRlZ39SC3M1AKUK1EAsrxD9jb4WQNl/wDIlPiNQi1zvyNSy211gsHb6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnmmN76V; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47064e95199so308006137.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708932724; x=1709537524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UPIkE0QQTBljj0L7xZDdkALc4/UETjvnfFaRo5CwzM=;
        b=hnmmN76VlO4I3XrkLj7GOz8PmZntn3uhi4pw8NyQLqTtxotwx1M2GcIsfj2U3pMRDD
         dJAvrtXxiXzztck3yKAoWgkRQYLofNKTmSwhqq3vIy10LEb40dBLW75G6LN3I9FjoWrY
         lJ/g/Bh9rW0i0XK3EcCeL34mI/cmw1VZ+bIVEVrOXkDOMmzs6bAx+KxT2AXaBdsVK02s
         TybIf+ziF6/ktzkzgsm/Y4vf/x09/ounWRNiaHwW9XejAYpKH1C5NMLVn3XuMT28wbXW
         Wpswd/UT3q0WDRUff5DVUW9QMFPaJmhqv3Ex7jMlX0eDFvQRrC4PA7djOLdOe2wn04mP
         eIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932724; x=1709537524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UPIkE0QQTBljj0L7xZDdkALc4/UETjvnfFaRo5CwzM=;
        b=bdzl1KxvMw1MEHkScDLNklEmHcbSidM2qskX+bUo6XBtTBiIBb5rSvFy3uRyNnB5XA
         iPzvLuR+VBBqhNiP+hyFrr/wdlDssL33Xs3PeURr+y1NNEdJVaKq+GhAzjFf8I7Vp/u6
         h/JTKYGD73P+rJcApNNEr38nOWo2YrhDDK8ZnmNFJPyP5LyMrJv8lJEWeUjshdipC2zt
         o0lYuUZ3aueJ5+3f3Ql0A/DhJmlR9/qGJd8fQIIVv7G7kPSb7E9OYD5vItW9mLMfUOIJ
         ZLoJw2/0Lsxet8TtjokP7EfYSOdejbrAAMC8tngdzMOOgnA9B0CWsyF5beeH77i9RBSS
         Fniw==
X-Forwarded-Encrypted: i=1; AJvYcCWFEK0X7cpnF3WisI8FpjXRbrpAQ+eGqDBwDNsn35X6ZVLTF3sbYBOOXDL7KNaxpU/iXEZICWi1rwOpOJ++alNSdR9AHW/7/dK8NVsm
X-Gm-Message-State: AOJu0YyXl0fq773JQh+V8MhMvcQOmjMlQlO1BXUgEMgeNsgGUk0c9/LM
	D1hBo6BuUyWH5KcK95GH6sohzx547+QZQTLWpaLfPiRa3D3Y5b4QMG70v1gUyX+MjslndnPpscu
	rfzLC71nnQK8F1d8gEv4VylFvOU0=
X-Google-Smtp-Source: AGHT+IEIJS8GlMNMGiXIp5s/DhuyNL+jl4Bfn3hWIJCoIz/fCSUEW0uozunSiL551pqQhFJNsaoK5OqG3/XFxD47RxA=
X-Received: by 2002:a05:6102:30a1:b0:470:5b6f:5ee9 with SMTP id
 y1-20020a05610230a100b004705b6f5ee9mr3850161vsd.17.1708932724347; Sun, 25 Feb
 2024 23:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-5-21cnbao@gmail.com> <CAF8kJuNVFq_jWFM3h0fLaUu+kVwa7zWvD3A_AJ1PxR+0Yyw_Dw@mail.gmail.com>
In-Reply-To: <CAF8kJuNVFq_jWFM3h0fLaUu+kVwa7zWvD3A_AJ1PxR+0Yyw_Dw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 20:31:53 +1300
Message-ID: <CAGsJ_4wfpjR2T5sETpZq1Yq-py-LmbgVqOUhUZ_N=AjK8285Mw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] mm: support large folios swapin as a whole
To: Chris Li <chrisl@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 9:06=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
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
> > This patch brings up mTHP swap-in support. Right now, we limit mTHP swa=
p-in
> > to those contiguous swaps which were likely swapped out from mTHP as a =
whole.
> >
> > On the other hand, the current implementation only covers the SWAP_SYCH=
RONOUS
> > case. It doesn't support swapin_readahead as large folios yet.
> >
> > Right now, we are re-faulting large folios which are still in swapcache=
 as a
> > whole, this can effectively decrease extra loops and early-exitings whi=
ch we
> > have increased in arch_swap_restore() while supporting MTE restore for =
folios
> > rather than page.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 94 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f61a48929ba7..928b3f542932 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -107,6 +107,8 @@ EXPORT_SYMBOL(mem_map);
> >  static vm_fault_t do_fault(struct vm_fault *vmf);
> >  static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
> >  static bool vmf_pte_changed(struct vm_fault *vmf);
> > +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> > +                                     bool (*pte_range_check)(pte_t *, =
int));
> >
> >  /*
> >   * Return true if the original pte was a uffd-wp pte marker (so the pt=
e was
> > @@ -3784,6 +3786,34 @@ static vm_fault_t handle_pte_marker(struct vm_fa=
ult *vmf)
> >         return VM_FAULT_SIGBUS;
> >  }
> >
> > +static bool pte_range_swap(pte_t *pte, int nr_pages)
> > +{
> > +       int i;
> > +       swp_entry_t entry;
> > +       unsigned type;
> > +       pgoff_t start_offset;
> > +
> > +       entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
> > +       if (non_swap_entry(entry))
> > +               return false;
> > +       start_offset =3D swp_offset(entry);
> > +       if (start_offset % nr_pages)
> > +               return false;
> > +
> > +       type =3D swp_type(entry);
> > +       for (i =3D 1; i < nr_pages; i++) {
> > +               entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
> > +               if (non_swap_entry(entry))
> > +                       return false;
> > +               if (swp_offset(entry) !=3D start_offset + i)
> > +                       return false;
> > +               if (swp_type(entry) !=3D type)
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -3804,6 +3834,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         pte_t pte;
> >         vm_fault_t ret =3D 0;
> >         void *shadow =3D NULL;
> > +       int nr_pages =3D 1;
> > +       unsigned long start_address;
> > +       pte_t *start_pte;
> >
> >         if (!pte_unmap_same(vmf))
> >                 goto out;
> > @@ -3868,13 +3901,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> >                         /* skip swapcache */
> > -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> > -                                               vma, vmf->address, fals=
e);
> > +                       folio =3D alloc_anon_folio(vmf, pte_range_swap)=
;
> >                         page =3D &folio->page;
> >                         if (folio) {
> >                                 __folio_set_locked(folio);
> >                                 __folio_set_swapbacked(folio);
> >
> > +                               if (folio_test_large(folio)) {
> > +                                       unsigned long start_offset;
> > +
> > +                                       nr_pages =3D folio_nr_pages(fol=
io);
> > +                                       start_offset =3D swp_offset(ent=
ry) & ~(nr_pages - 1);
> > +                                       entry =3D swp_entry(swp_type(en=
try), start_offset);
> > +                               }
> > +
> >                                 if (mem_cgroup_swapin_charge_folio(foli=
o,
> >                                                         vma->vm_mm, GFP=
_KERNEL,
> >                                                         entry)) {
> > @@ -3980,6 +4020,39 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          */
> >         vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> >                         &vmf->ptl);
> > +
> > +       start_address =3D vmf->address;
> > +       start_pte =3D vmf->pte;
> > +       if (folio_test_large(folio)) {
> > +               unsigned long nr =3D folio_nr_pages(folio);
> > +               unsigned long addr =3D ALIGN_DOWN(vmf->address, nr * PA=
GE_SIZE);
> > +               pte_t *pte_t =3D vmf->pte - (vmf->address - addr) / PAG=
E_SIZE;
>
> I forgot about one comment here.
> Please change the variable name other than "pte_t", it is a bit
> strange to use the typedef name as variable name here.
>

make sense!

> Chris

Thanks
Barry

