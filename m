Return-Path: <linux-kernel+bounces-109905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E20885798
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A3284736
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F356B9F;
	Thu, 21 Mar 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avQUFy9M"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8D5644E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017852; cv=none; b=rXZOzCMwWx0JojKEXZeBt1Bcg8sp16eO/flIMYusbIE8hM+ViVM7CaaaNyV8ivaG95n2G/+xj6Gxxl00r6x/2pR1Fm1DJ1n85vhi9LaO1S1DHdfS6fPTXnbBfyLSFLiEas6ykzoR2X8NO9bzQcZTgYcBzzUxTpk31N7MNziENNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017852; c=relaxed/simple;
	bh=kavwRgpm/yz7p1x5tAXY1fmJ5OmqJFr7kUsJUNg2KC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS77qT6VWWbbJrw02gsh7f6t2NdEdg9VvH8rZ5ltLLBGke0/+sr6v9SaLmUIQ+qOv1y0uGvolfYefHDNBhGAK//VA9PXoG3hf+fDzyl/SjvMy5n9GvMk0g52tky1HXvQhY5DoPtpFPWNGjE52lsps9DnAr18nDYwWfq50SZkWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avQUFy9M; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e09ad21b34so347061241.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711017850; x=1711622650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGNKVqLixwBJC1Vd2ymCbdiOgs9xUopOw3+FI5+W+fY=;
        b=avQUFy9M+CyQbeC33B8dkUXKN5tEza3+1I/Ws0zuG61nmHMqW6ItRwsirGVWT534tg
         Molxkfo+O5NTLgyyH0eY4CeQINDaGXVYXczeYLTX4DerczUgN3FwROticsX72yB52lGN
         ZtuwA3ESaKabXf1fgnJk4c3aLf1x86d+C0F7tBAFQNLq0rAA0UGneIbHLBsVF1SoOkod
         5ulX8BXIONEYjaRoqPZOo5QBta96zskzPto9MSnncgU5PBaaf5M2jyh1c1oah5GP7znJ
         GarQrGyXEs/Dw0n4KCzvWug5y5FqDSmg2dGW+UZ/e6jpM44BvA8KPWgAjYSgO+LhezHg
         PBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711017850; x=1711622650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGNKVqLixwBJC1Vd2ymCbdiOgs9xUopOw3+FI5+W+fY=;
        b=FgVoEazwg6zobSNLi4UuM+RCV+B6X2aSwrn428He+TyUdZemyTlv7UuVja39vca8V8
         7AqduJ4tHoMMHBPNUbU/9M0y/2c5Pn4D7pyyqFJ0ujed1nSaDrTpdH0OfNRLt7PeF3v1
         +ssZm1cyhQT7fsZ8433esPr9KPBSig1U8lG9nl6W85RzCtd6N2eto/4t8QA6kT/GH4sw
         ezQOcwEmfnOsEUnZZBYstTSRVsaeys0B8UHzQ4fzYvz62RVOUYj9hwfbBNbJn4fJEq+l
         A++KP703E3een4n91PBBAvX1FzYUp31N3Urh2WWW42I4o73zDTljr/JBLKU4lZ3ISi0U
         mpFw==
X-Forwarded-Encrypted: i=1; AJvYcCVR+RPG3sp9bO0lyCglq5dVTtBgDaKvNrUwosenI2+iPsIlKGbF+TLGJuNSYC8eY5dAlr7g/6ycQCyyVODTJQHfaHdhfZjUeGkvz2ib
X-Gm-Message-State: AOJu0Yxoef6dVnMWrcfXeOibzchGCEVwxfWOOylBK/zMhUj59O18qJy7
	8Y6SkCVJGFkIB4epvAfo/hlxspqCRwRtqe9OaLLtSXRXzlGqW+ANEGdJfixlr0YNl0iXG0IuOis
	kF9zmVQGxnZhjJZxxsrSDSOYbqJg=
X-Google-Smtp-Source: AGHT+IFVpTUtS3RKZd4uee1A7DQWV+55ipcZhVGdwto8Kr/uMq+dECfpnlszzEy/+uiOfZV2g1RrBJYBbBylLfJF/AE=
X-Received: by 2002:a67:f70b:0:b0:473:2d3c:b96a with SMTP id
 m11-20020a67f70b000000b004732d3cb96amr1351666vso.19.1711017849243; Thu, 21
 Mar 2024 03:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-2-21cnbao@gmail.com>
 <01c61b90-df90-4819-978b-414bb717ef64@arm.com> <CAGsJ_4z5xDtBj-nyvPXfgv+ZVmzPQzvptyBrf=kB49Q3=Dmq-Q@mail.gmail.com>
 <e77c18df-2796-4fd1-b589-57f0569587e8@arm.com>
In-Reply-To: <e77c18df-2796-4fd1-b589-57f0569587e8@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 18:43:58 +0800
Message-ID: <CAGsJ_4whCr+AtxajSYQ=ovDKkCEvVBvZfykgbU_qTWaZFhnoVA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] arm64: mm: swap: support THP_SWAP on hardware
 with MTE
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Barry Song <v-songbaohua@oppo.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Peter Collingbourne <pcc@google.com>, Peter Xu <peterx@redhat.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 6:31=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 21/03/2024 08:42, Barry Song wrote:
> > Hi Ryan,
> > Sorry for the late reply.
>
> No problem!
>
> >
> > On Tue, Mar 12, 2024 at 5:56=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 04/03/2024 08:13, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
> >>> THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
> >>> MTE as the MTE code works with the assumption tags save/restore is
> >>> always handling a folio with only one page.
> >>>
> >>> The limitation should be removed as more and more ARM64 SoCs have
> >>> this feature. Co-existence of MTE and THP_SWAP becomes more and
> >>> more important.
> >>>
> >>> This patch makes MTE tags saving support large folios, then we don't
> >>> need to split large folios into base pages for swapping out on ARM64
> >>> SoCs with MTE any more.
> >>>
> >>> arch_prepare_to_swap() should take folio rather than page as paramete=
r
> >>> because we support THP swap-out as a whole. It saves tags for all
> >>> pages in a large folio.
> >>>
> >>> As now we are restoring tags based-on folio, in arch_swap_restore(),
> >>> we may increase some extra loops and early-exitings while refaulting
> >>> a large folio which is still in swapcache in do_swap_page(). In case
> >>> a large folio has nr pages, do_swap_page() will only set the PTE of
> >>> the particular page which is causing the page fault.
> >>> Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
> >>> will loop nr times for those subpages in the folio. So right now the
> >>> algorithmic complexity becomes O(nr^2).
> >>>
> >>> Once we support mapping large folios in do_swap_page(), extra loops
> >>> and early-exitings will decrease while not being completely removed
> >>> as a large folio might get partially tagged in corner cases such as,
> >>> 1. a large folio in swapcache can be partially unmapped, thus, MTE
> >>> tags for the unmapped pages will be invalidated;
> >>> 2. users might use mprotect() to set MTEs on a part of a large folio.
> >>>
> >>> arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
> >>> who needed it.
>
> I think we should decouple this patch from your swap-in series. I suspect=
 this
> one could be ready and go in sooner than the swap-in series based on the =
current
> discussions :)

I concur, particularly given that nowadays, most modern and popular ARM64
SoCs are equipped with MTE. The absence of this patch also hinders the
effective functioning of mTHP swap-out.

>
> >>>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> >>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >>> Cc: Peter Collingbourne <pcc@google.com>
> >>> Cc: Steven Price <steven.price@arm.com>
> >>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> >>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >>> Cc: Hugh Dickins <hughd@google.com>
> >>> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> >>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> Reviewed-by: Steven Price <steven.price@arm.com>
> >>> Acked-by: Chris Li <chrisl@kernel.org>
> >>> ---
> >>>  arch/arm64/include/asm/pgtable.h | 19 ++------------
> >>>  arch/arm64/mm/mteswap.c          | 43 ++++++++++++++++++++++++++++++=
++
> >>>  include/linux/huge_mm.h          | 12 ---------
> >>>  include/linux/pgtable.h          |  2 +-
> >>>  mm/page_io.c                     |  2 +-
> >>>  mm/swap_slots.c                  |  2 +-
> >>>  6 files changed, 48 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/as=
m/pgtable.h
> >>> index 401087e8a43d..7a54750770b8 100644
> >>> --- a/arch/arm64/include/asm/pgtable.h
> >>> +++ b/arch/arm64/include/asm/pgtable.h
> >>> @@ -45,12 +45,6 @@
> >>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
> >>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >>>
> >>> -static inline bool arch_thp_swp_supported(void)
> >>> -{
> >>> -     return !system_supports_mte();
> >>> -}
> >>> -#define arch_thp_swp_supported arch_thp_swp_supported
> >>> -
> >>>  /*
> >>>   * Outside of a few very special situations (e.g. hibernation), we a=
lways
> >>>   * use broadcast TLB invalidation instructions, therefore a spurious=
 page
> >>> @@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct vm_a=
rea_struct *vma,
> >>>  #ifdef CONFIG_ARM64_MTE
> >>>
> >>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
> >>> -static inline int arch_prepare_to_swap(struct page *page)
> >>> -{
> >>> -     if (system_supports_mte())
> >>> -             return mte_save_tags(page);
> >>> -     return 0;
> >>> -}
> >>> +extern int arch_prepare_to_swap(struct folio *folio);
> >>>
> >>>  #define __HAVE_ARCH_SWAP_INVALIDATE
> >>>  static inline void arch_swap_invalidate_page(int type, pgoff_t offse=
t)
> >>> @@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_area(i=
nt type)
> >>>  }
> >>>
> >>>  #define __HAVE_ARCH_SWAP_RESTORE
> >>> -static inline void arch_swap_restore(swp_entry_t entry, struct folio=
 *folio)
> >>> -{
> >>> -     if (system_supports_mte())
> >>> -             mte_restore_tags(entry, &folio->page);
> >>> -}
> >>> +extern void arch_swap_restore(swp_entry_t entry, struct folio *folio=
);
> >>>
> >>>  #endif /* CONFIG_ARM64_MTE */
> >>>
> >>> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> >>> index a31833e3ddc5..295836fef620 100644
> >>> --- a/arch/arm64/mm/mteswap.c
> >>> +++ b/arch/arm64/mm/mteswap.c
> >>> @@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
> >>>       mte_free_tag_storage(tags);
> >>>  }
> >>>
> >>> +static inline void __mte_invalidate_tags(struct page *page)
> >>> +{
> >>> +     swp_entry_t entry =3D page_swap_entry(page);
> >>> +
> >>> +     mte_invalidate_tags(swp_type(entry), swp_offset(entry));
> >>> +}
> >>> +
> >>>  void mte_invalidate_tags_area(int type)
> >>>  {
> >>>       swp_entry_t entry =3D swp_entry(type, 0);
> >>> @@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
> >>>       }
> >>>       xa_unlock(&mte_pages);
> >>>  }
> >>> +
> >>> +int arch_prepare_to_swap(struct folio *folio)
> >>> +{
> >>> +     long i, nr;
> >>> +     int err;
> >>> +
> >>> +     if (!system_supports_mte())
> >>> +             return 0;
> >>> +
> >>> +     nr =3D folio_nr_pages(folio);
> >>> +
> >>> +     for (i =3D 0; i < nr; i++) {
> >>> +             err =3D mte_save_tags(folio_page(folio, i));
> >>> +             if (err)
> >>> +                     goto out;
> >>> +     }
> >>> +     return 0;
> >>> +
> >>> +out:
> >>> +     while (i--)
> >>> +             __mte_invalidate_tags(folio_page(folio, i));
> >>> +     return err;
> >>> +}
> >>> +
> >>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
> >>
> >> I'm still not a fan of the fact that entry could be anywhere within fo=
lio.
> >>
> >>> +{
> >>> +     if (system_supports_mte()) {
> >>
> >> nit: if you do:
> >>
> >> if (!system_supports_mte())
> >>         return;
> >
> > Acked
> >
> >>
> >> It will be consistent with arch_prepare_to_swap() and reduce the inden=
tation of
> >> the main body.
> >>
> >>> +             long i, nr =3D folio_nr_pages(folio);
> >>> +
> >>> +             entry.val -=3D swp_offset(entry) & (nr - 1);
> >>
> >> This assumes that folios are always stored in swap with natural alignm=
ent. Is
> >> that definitely a safe assumption? My swap-out series is currently ens=
uring that
> >> folios are swapped-out naturally aligned, but that is an implementatio=
n detail.
> >>
> >
> > I concur that this is an implementation detail. However, we should be
> > bold enough
> > to state that swap slots will be contiguous, considering we are
> > currently utilizing
> > folio->swap instead of subpage->swap ?
>
> Yes, I agree about contiguity. My objection is about assuming natural ali=
gnment
> though. It can still be contiguous while not naturally aligned in swap.

right.

>
> >
> >> Your cover note for swap-in says that you could technically swap in a =
large
> >> folio without it having been swapped-out large. If you chose to do tha=
t in
> >> future, this would break, right? I don't think it's good to couple the=
 swap
> >
> > Right. technically I agree. Given that we still have many tasks involvi=
ng even
> > swapping in contiguous swap slots, it's unlikely that swapping in large=
 folios
> > for non-contiguous entries will occur in the foreseeable future :-)
> >
> >> storage layout to the folio order that you want to swap into. Perhaps =
that's an
> >> argument for passing each *page* to this function with its exact, corr=
esponding
> >> swap entry?
> >
> > I recall Matthew Wilcox strongly objected to using "page" as the
> > parameter, so I've
> > discarded that approach. Alternatively, it appears I can consistently p=
ass
> > folio->swap to this function and ensure the function always retrieves
> > the first entry?
>
> Yes, if we must pass a folio here, I'd prefer that entry always correspon=
ds to
> the first entry for the folio. That will remove the need for this functio=
n to do
> the alignment above too. So win-win.

right.

>
> >
> >>
> >>> +             for (i =3D 0; i < nr; i++) {
> >>> +                     mte_restore_tags(entry, folio_page(folio, i));
> >>> +                     entry.val++;
> >>> +             }
> >>> +     }
> >>> +}
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index de0c89105076..e04b93c43965 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -535,16 +535,4 @@ static inline int split_folio_to_order(struct fo=
lio *folio, int new_order)
> >>>  #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l,=
 0)
> >>>  #define split_folio(f) split_folio_to_order(f, 0)
> >>>
> >>> -/*
> >>> - * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP d=
ue to
> >>> - * limitations in the implementation like arm64 MTE can override thi=
s to
> >>> - * false
> >>> - */
> >>> -#ifndef arch_thp_swp_supported
> >>> -static inline bool arch_thp_swp_supported(void)
> >>> -{
> >>> -     return true;
> >>> -}
> >>> -#endif
> >>> -
> >>>  #endif /* _LINUX_HUGE_MM_H */
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index e1b22903f709..bfcfe3386934 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -1106,7 +1106,7 @@ static inline int arch_unmap_one(struct mm_stru=
ct *mm,
> >>>   * prototypes must be defined in the arch-specific asm/pgtable.h fil=
e.
> >>>   */
> >>>  #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
> >>> -static inline int arch_prepare_to_swap(struct page *page)
> >>> +static inline int arch_prepare_to_swap(struct folio *folio)
> >>>  {
> >>>       return 0;
> >>>  }
> >>> diff --git a/mm/page_io.c b/mm/page_io.c
> >>> index ae2b49055e43..a9a7c236aecc 100644
> >>> --- a/mm/page_io.c
> >>> +++ b/mm/page_io.c
> >>> @@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writ=
eback_control *wbc)
> >>>        * Arch code may have to preserve more data than just the page
> >>>        * contents, e.g. memory tags.
> >>>        */
> >>> -     ret =3D arch_prepare_to_swap(&folio->page);
> >>> +     ret =3D arch_prepare_to_swap(folio);
> >>>       if (ret) {
> >>>               folio_mark_dirty(folio);
> >>>               folio_unlock(folio);
> >>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> >>> index 90973ce7881d..53abeaf1371d 100644
> >>> --- a/mm/swap_slots.c
> >>> +++ b/mm/swap_slots.c
> >>> @@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
> >>>       entry.val =3D 0;
> >>>
> >>>       if (folio_test_large(folio)) {
> >>> -             if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_support=
ed())
> >>> +             if (IS_ENABLED(CONFIG_THP_SWAP))
> >>>                       get_swap_pages(1, &entry, folio_nr_pages(folio)=
);
> >>>               goto out;
> >>>       }
> >>
> >

Thanks
Barry

