Return-Path: <linux-kernel+bounces-70623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F998859A33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9548A1C2094F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ACE7318E;
	Sun, 18 Feb 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdnUNYgo"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414621DFC5
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708299670; cv=none; b=PMWMvNuJMRjYo1h7EIC/WW2Yj/MAniFJzwqxvo4Nz3Dp9zTto8N7KdJ/vkaMChxFrUrPgPk8MCm7O9BTGYjldSGXOAy/4OZGWdYovUNxh4p9dIVvA9cs68Yx1UbVAsTcQoroB8FWAc4fek8xCvoemrBlSBYXx7O4nrF3ba2r6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708299670; c=relaxed/simple;
	bh=K4WrYpW7gYzIxMn6R8SK6xQQeZmxMB2sNfFGZzpzkWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLY4/a6F/kQ2chpqmFzLxRqbtb5S8GwKIaUJN79rjaWL6TIBd1x9JEeACDmwn6LJ1SZspFFbsznwweBhfBKW6sBAMe96N0gNUqknZ2rDo6bfj3PYLFNj9WM9nkk0NlsCOteE18AHsZJfFqYyvmtm/z7A8l9z6Hpub0AjLl03AKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdnUNYgo; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so2060885241.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708299667; x=1708904467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF9gyIGQdYy5XXWdDlGprgUjh4r3E7Iki1BZ0jJ8E8U=;
        b=RdnUNYgotWo0mH5mCClMuACWh5PQdtPK9L4lved+G57CMNqB4PF3Uov1nZFJx5rOG1
         qytd3KcYh+u3hK5COlxkM4sEbmTnBnfKr89dS2Xaf9wmCyK7cgcb6vY1eVOBDBPZWsqV
         f5SYyW1BEfPDDE1Qo+YgTjdiQ7Xjq1HaaJPPdX0HoiN1jppKGxMIlTq//In0wz72daVx
         3ibzNUlgqeGfHeUGuJZPnE9maY3pjd7KKdyeXwgN4txrrzbIRn9Vs1hBs656TiqJ2vS0
         cmPs6JjBt1tJvr9+fK+1UTRXoTclGyKIJeZrso0z5A3he7xOmsfFRPlzqVBbsRNHaJ7l
         KYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708299667; x=1708904467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF9gyIGQdYy5XXWdDlGprgUjh4r3E7Iki1BZ0jJ8E8U=;
        b=vVfJynq5UcKgGfJm98qdUSUCLbb71MRTZFBtdPbhbeTUVSL26U41Caw+z/eAq8VP94
         4+F5KN7UQ5vSG3gv/pAsceLsSkfEZaLoOLeBCquLzGEOvhmMkr978aA6T9mlnrReQJmJ
         lnW305OMXcQ3YBijYmxFV3FlmWkkNeupxmfij2zih369EbteeoLJxo77jeB6gKA91Yak
         7UOqMDrOtgw0DhuhIy4wqmYg+LTfBJJ7KlMKplL+7ELrlwSjSY7KwI0tKqr74e9qzQyn
         6lgCPrzTjbFhEVlZxnU65MBqRNqhTlv4ac+qjEJ7EQ9+dErOIi6Z4pSNbauyRlEnLcqD
         jbXA==
X-Forwarded-Encrypted: i=1; AJvYcCUmSxMnP/H3OzvH4cprUIl2n0+tGxLfigsLQXpWpst7u1HbvC3H8iaAjvAOKOKM6g3EZG+IKGHYASfQhYZNsSUXn1+oVf2y+2smmK7K
X-Gm-Message-State: AOJu0Yx11QKPh45VmyFNx23rfHwmJVm1CKQZjADspBemHZplQrg5sdbb
	GbgseWW0CnIQhNSrsKAcB108/tCsdILfkiyWAjbdB1awASa5rGSYZboR5ErfYDm/QBQrpGonEPY
	clkzPu27nmShsIDXE3CmUY9ufePs=
X-Google-Smtp-Source: AGHT+IHh/By/ea7rm1g4aj2v4vFwV1B03LOTLifdlouiqyt90dm8iXQQ5uBiRevUzQniMEnOh+V54ZUg0rm1r4/ZZBY=
X-Received: by 2002:a1f:c346:0:b0:4c0:25db:3618 with SMTP id
 t67-20020a1fc346000000b004c025db3618mr8776255vkf.0.1708299666935; Sun, 18 Feb
 2024 15:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240205095155.7151-1-v-songbaohua@oppo.com>
 <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com>
In-Reply-To: <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Feb 2024 12:40:55 +1300
Message-ID: <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, surenb@google.com, 
	hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 1:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 05/02/2024 09:51, Barry Song wrote:
> > +Chris, Suren and Chuanhua
> >
> > Hi Ryan,
> >
> >> +    /*
> >> +     * __scan_swap_map_try_ssd_cluster() may drop si->lock during dis=
card,
> >> +     * so indicate that we are scanning to synchronise with swapoff.
> >> +     */
> >> +    si->flags +=3D SWP_SCANNING;
> >> +    ret =3D __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, =
order);
> >> +    si->flags -=3D SWP_SCANNING;
> >
> > nobody is using this scan_base afterwards. it seems a bit weird to
> > pass a pointer.
> >
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct l=
ist_head *folio_list,
> >>                                      if (!can_split_folio(folio, NULL)=
)
> >>                                              goto activate_locked;
> >>                                      /*
> >> -                                     * Split folios without a PMD map=
 right
> >> -                                     * away. Chances are some or all =
of the
> >> -                                     * tail pages can be freed withou=
t IO.
> >> +                                     * Split PMD-mappable folios with=
out a
> >> +                                     * PMD map right away. Chances ar=
e some
> >> +                                     * or all of the tail pages can b=
e freed
> >> +                                     * without IO.
> >>                                       */
> >> -                                    if (!folio_entire_mapcount(folio)=
 &&
> >> +                                    if (folio_test_pmd_mappable(folio=
) &&
> >> +                                        !folio_entire_mapcount(folio)=
 &&
> >>                                          split_folio_to_list(folio,
> >>                                                              folio_lis=
t))
> >>                                              goto activate_locked;
> >> --
> >
> > Chuanhua and I ran this patchset for a couple of days and found a race
> > between reclamation and split_folio. this might cause applications get
> > wrong data 0 while swapping-in.
> >
> > in case one thread(T1) is reclaiming a large folio by some means, still
> > another thread is calling madvise MADV_PGOUT(T2). and at the same time,
> > we have two threads T3 and T4 to swap-in in parallel. T1 doesn't split
> > and T2 does split as below,
> >
> > static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >                                 unsigned long addr, unsigned long end,
> >                                 struct mm_walk *walk)
> > {
> >
> >                 /*
> >                  * Creating a THP page is expensive so split it only if=
 we
> >                  * are sure it's worth. Split it if we are only owner.
> >                  */
> >                 if (folio_test_large(folio)) {
> >                         int err;
> >
> >                         if (folio_estimated_sharers(folio) !=3D 1)
> >                                 break;
> >                         if (pageout_anon_only_filter && !folio_test_ano=
n(folio))
> >                                 break;
> >                         if (!folio_trylock(folio))
> >                                 break;
> >                         folio_get(folio);
> >                         arch_leave_lazy_mmu_mode();
> >                         pte_unmap_unlock(start_pte, ptl);
> >                         start_pte =3D NULL;
> >                         err =3D split_folio(folio);
> >                         folio_unlock(folio);
> >                         folio_put(folio);
> >                         if (err)
> >                                 break;
> >                         start_pte =3D pte =3D
> >                                 pte_offset_map_lock(mm, pmd, addr, &ptl=
);
> >                         if (!start_pte)
> >                                 break;
> >                         arch_enter_lazy_mmu_mode();
> >                         pte--;
> >                         addr -=3D PAGE_SIZE;
> >                         continue;
> >                 }
> >
> >         return 0;
> > }
> >
> >
> >
> > if T3 and T4 swap-in same page, and they both do swap_read_folio(). the
> > first one of T3 and T4 who gets PTL will set pte, and the 2nd one will
> > check pte_same() and find pte has been changed by another thread, thus
> > goto out_nomap in do_swap_page.
> > vm_fault_t do_swap_page(struct vm_fault *vmf)
> > {
> >         if (!folio) {
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> >                         /* skip swapcache */
> >                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> >                                                 vma, vmf->address, fals=
e);
> >                         page =3D &folio->page;
> >                         if (folio) {
> >                                 __folio_set_locked(folio);
> >                                 __folio_set_swapbacked(folio);
> >
> >                                 /* To provide entry to swap_read_folio(=
) */
> >                                 folio->swap =3D entry;
> >                                 swap_read_folio(folio, true, NULL);
> >                                 folio->private =3D NULL;
> >                         }
> >                 } else {
> >                 }
> >
> >
> >         /*
> >          * Back out if somebody else already faulted in this pte.
> >          */
> >         vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> >                         &vmf->ptl);
> >         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->or=
ig_pte)))
> >                 goto out_nomap;
> >
> >         swap_free(entry);
> >         pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >         set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> >         return ret;
> > }
> >
> >
> > while T1 and T2 is working in parallel, T2 will split folio. this can
> > run into race with T1's reclamation without splitting. T2 will split
> > a large folio into a couple of normal pages and reclaim them.
> >
> > If T3 finishes swap_read_folio and gets PTL earlier than T4, it calls
> > set_pte and swap_free. this will cause zRAM to free the slot. then
> > t4 will get zero data in swap_read_folio() as the below zRAM code
> > will fill zero for freed slots,
> >
> > static int zram_read_from_zspool(struct zram *zram, struct page *page,
> >                                  u32 index)
> > {
> >         ...
> >
> >         handle =3D zram_get_handle(zram, index);
> >         if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
> >                 unsigned long value;
> >                 void *mem;
> >
> >                 value =3D handle ? zram_get_element(zram, index) : 0;
> >                 mem =3D kmap_local_page(page);
> >                 zram_fill_page(mem, PAGE_SIZE, value);
> >                 kunmap_local(mem);
> >                 return 0;
> >         }
> > }
> >
> > usually, after t3 frees swap and does set_pte, t4's pte_same becomes
> > false, it won't set pte again. So filling zero data into freed slot
> > by zRAM driver is not a problem at all. but the race is that T1 and
> > T2 might do set swap to ptes twice as t1 doesn't split but t2 splits
> > (splitted normal folios are also added into reclaim_list), thus, the
> > corrupted zero data will get a chance to be set into PTE by t4 as t4
> > reads the new PTE which is set secondly and has the same swap entry
> > as its orig_pte after T3 has swapped-in and free the swap entry.
> >
> > we have worked around this problem by preventing T4 from splitting
> > large folios and letting it goto skip the large folios entirely in
> > MADV PAGEOUT once we detect a concurrent reclamation for this large
> > folio.
> >
> > so my understanding is changing vmscan isn't sufficient to support
> > large folio swap-out without splitting. we have to adjust madvise
> > as well. we will have a fix for this problem in
> > [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
> > https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.c=
om/
> >
> > But i feel this patch should be a part of your swap-out patchset rather
> > than the swap-in series of Chuanhua and me :-)
>
> Hi Barry, Chuanhua,
>
> Thanks for the very detailed bug report! I'm going to have to take some t=
ime to
> get my head around the details. But yes, I agree the fix needs to be part=
 of the
> swap-out series.
>

Hi Ryan,
I am running into some races especially while enabling large folio swap-out=
 and
swap-in both. some of them, i am still struggling with the detailed
timing how they
are happening.
but the below change can help remove those bugs which cause corrupted data.

index da2aab219c40..ef9cfbc84760 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1953,6 +1953,16 @@ static unsigned int shrink_folio_list(struct
list_head *folio_list,

                        if (folio_test_pmd_mappable(folio))
                                flags |=3D TTU_SPLIT_HUGE_PMD;
+                       /*
+                        * make try_to_unmap_one hold ptl from the very fir=
st
+                        * beginning if we are reclaiming a folio with mult=
i-
+                        * ptes. otherwise, we may only reclaim a part of t=
he
+                        * folio from the middle.
+                        * for example, a parallel thread might temporarily
+                        * set pte to none for various purposes.
+                        */
+                       else if (folio_test_large(folio))
+                               flags |=3D TTU_SYNC;

                        try_to_unmap(folio, flags);
                        if (folio_mapped(folio)) {


While we are swapping-out a large folio, it has many ptes, we change those =
ptes
to swap entries in try_to_unmap_one(). "while (page_vma_mapped_walk(&pvmw))=
"
will iterate all ptes within the large folio. but it will only begin
to acquire ptl when
it meets a valid pte as below /* xxxxxxx */

static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
{
        pte_t ptent;

        if (pvmw->flags & PVMW_SYNC) {
                /* Use the stricter lookup */
                pvmw->pte =3D pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->p=
md,
                                                pvmw->address, &pvmw->ptl);
                *ptlp =3D pvmw->ptl;
                return !!pvmw->pte;
        }

       ...
        pvmw->pte =3D pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
                                          pvmw->address, ptlp);
        if (!pvmw->pte)
                return false;

        ptent =3D ptep_get(pvmw->pte);

        if (pvmw->flags & PVMW_MIGRATION) {
                if (!is_swap_pte(ptent))
                        return false;
        } else if (is_swap_pte(ptent)) {
                swp_entry_t entry;
                ...
                entry =3D pte_to_swp_entry(ptent);
                if (!is_device_private_entry(entry) &&
                    !is_device_exclusive_entry(entry))
                        return false;
        } else if (!pte_present(ptent)) {
                return false;
        }
        pvmw->ptl =3D *ptlp;
        spin_lock(pvmw->ptl);   /* xxxxxxx */
        return true;
}


for various reasons,  for example, break-before-make for clearing access fl=
ags
etc. pte can be set to none. since page_vma_mapped_walk() doesn't hold ptl
from the beginning,  it might only begin to set swap entries from the middl=
e of
a large folio.

For example, in case a large folio has 16 ptes, and 0,1,2 are somehow zero
in the intermediate stage of a break-before-make, ptl will be held
from the 3rd pte,
and swap entries will be set from 3rd pte as well. it seems not good as we =
are
trying to swap out a large folio, but we are swapping out a part of them.

I am still struggling with all the timing of races, but using PVMW_SYNC to
explicitly ask for ptl from the first pte seems a good thing for large foli=
o
regardless of those races. it can avoid try_to_unmap_one reading intermedia=
te
pte and further make the wrong decision since reclaiming pte-mapped large
folios is atomic with just one pte.

> Sorry I haven't progressed this series as I had hoped. I've been concentr=
ating
> on getting the contpte series upstream. I'm hoping I will find some time =
to move
> this series along by the tail end of Feb (hoping to get it in shape for v=
6.10).
> Hopefully that doesn't cause you any big problems?

no worries. Anyway, we are already using your code to run various tests.

>
> Thanks,
> Ryan

Thanks
Barry

