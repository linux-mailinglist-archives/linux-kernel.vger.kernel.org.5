Return-Path: <linux-kernel+bounces-29632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234C831101
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFE7287797
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C623D8;
	Thu, 18 Jan 2024 01:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoeKeUrC"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245C186C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542425; cv=none; b=mSmhDr46bVdQlUpPdEjytgjRfT4z+9C1fzecns89+mq9VP4LsrJbGPwEIMAvZQLpszEoBQfNY9sL57VdQN6srQ30vAbMwVIdyaamg3txRzod5BY+D/U0ppouCB51FyT6v1Pv6QJ0n1RRnBFPtOlhZZcK1rKMo64vwVIaCPlJGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542425; c=relaxed/simple;
	bh=JjkB7Mg67F9gPQ/JI+1fR/XQ2Qkk9Nn1mcA0Reo3bIc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ubH3dxrtXao6avbItOvA0b2w+bjp+vRVxPQsTIdO4l6qmVkK91t5NVjQV8o9qPDtIQbej2/4dMDOsahzir/AZ4Dv9OC8YRATGv4rGoKU2+Swmz13+yj10YHQ+ov1hYaCSDx077nbAJV09L7oZTuLtmHGUnCiEExd0lr4954fguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoeKeUrC; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc253ca54cdso384662276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542422; x=1706147222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SbokGqNIGizcFU8VWDSVMedxouK7tzaX6SbnlnQ1SI=;
        b=RoeKeUrCAFR6nFsTRDAp2nDrd3q2vFLC8OSAmi7lcjYneFMU4zrwkgh26Q6dGBQ8vd
         /sYO+ID6pBUyNXyVQdq8kgAAcIQo3CjM+TIuBuKMB68kD1aJSDOtETMtmcMfL71liPGb
         V7cEw3EIuDsl6JlT5Nf30PZ2h9xqb5UGWrHyRs5XERWa0xLu6yBfBhwqHV1ZnJMunxIk
         EbNd0GMixYYVH8gPgDyBp+E+Z2y5jhE4sLi859/wR2lcr0HBrUc5lPhmgHHmUT5zCPmg
         hDr7bQ4odU4ttwfSqcYbBTaqeY7D6y7TpecZXsSGM5IVhxZr2/yjEZWUV/gX3zYlQFHa
         XL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542422; x=1706147222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SbokGqNIGizcFU8VWDSVMedxouK7tzaX6SbnlnQ1SI=;
        b=HimVOfeVfi3S7thT7XheSVJAeVSlPMRJYbOiYjcBdg/58XauOMKoG4Fnu47/Yarc1B
         XHcGF4Rfv1wd+0IGuFEsIc5xpU6WgMevLNdr2afr14Ry2o0TEKtQbANVrhK0zzqrEKb1
         Bfib7Or2zKrexfcyvzMHCNJnaY9Qw06Epwyc7lNvUdrAd3IdyOuB+QyOoxUDmUOnaZdP
         gXR0xf5DksA++gVovyfv2DiC8Yo2UwW8GfBPPC67E2CBIabOYnGdXI0O2chL7/5b3Jh6
         UZvjvrYfFoZrNe/sLw58kqxGF0f8jzULR2FE87b8TUbaCLOzFLAGUm8cGnbueaXFPCCB
         DcAg==
X-Gm-Message-State: AOJu0Yz7OWEcu8zMk+GCFGaV//i8GI8in2+QSeMXxrxeP9eCsxN9pqer
	pNGc6lme3bDGK1O8SNsR6l1quer6qZKoDve86w0m7Rd5UDloDu+1Pxn96DX9ytbx/FT71VGWGFZ
	bcCxHiXqNyapZtF52D4yWRdWa9SM=
X-Google-Smtp-Source: AGHT+IFwDMyE3srS0/WoJRHeR2/VbaUuhAR/MNShNGmzF9e7AH5yusDoq380X8zWMm6QkmkjLToJEBXMejO/80QDjBI=
X-Received: by 2002:a25:a290:0:b0:dc2:4402:6ec4 with SMTP id
 c16-20020a25a290000000b00dc244026ec4mr65057ybi.40.1705542421930; Wed, 17 Jan
 2024 17:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117050217.43610-1-ioworker0@gmail.com> <CAAa6QmR0rcdk_rJOzc88ZA4jm9K5LwxT4dSHiBX+nPyd6E3Ddw@mail.gmail.com>
In-Reply-To: <CAAa6QmR0rcdk_rJOzc88ZA4jm9K5LwxT4dSHiBX+nPyd6E3Ddw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Jan 2024 09:46:50 +0800
Message-ID: <CAK1f24kG72ogeh04SkngQ_=BW4nomZAejmRK3qrzLKvUKF1Tsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: akpm@linux-foundation.org, songmuchun@bytedance.com, 
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
	Michael Knyszek <mknyszek@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach,

Thanks for taking the time to review!

Zach O'Keefe <zokeefe@google.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8818=E6=97=
=A5=E5=91=A8=E5=9B=9B 01:11=E5=86=99=E9=81=93=EF=BC=9A
>
> [+linux-mm & others]
>
> On Tue, Jan 16, 2024 at 9:02=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
> >
> > Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
> > make a least-effort attempt at a synchronous collapse of memory at
> > their own expense.
> >
> > The only difference from MADV_COLLAPSE is that the new hugepage allocat=
ion
> > avoids direct reclaim and/or compaction, quickly failing on allocation =
errors.
> >
> > The benefits of this approach are:
> >
> > * CPU is charged to the process that wants to spend the cycles for the =
THP
> > * Avoid unpredictable timing of khugepaged collapse
> > * Prevent unpredictable stalls caused by direct reclaim and/or compacti=
on
> >
> > Semantics
> >
> > This call is independent of the system-wide THP sysfs settings, but wil=
l
> > fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> > multiple VMAs, the semantics of the collapse over each VMA is independe=
nt
> > from the others.  This implies a hugepage cannot cross a VMA boundary. =
 If
> > collapse of a given hugepage-aligned/sized region fails, the operation =
may
> > continue to attempt collapsing the remainder of memory specified.
> >
> > The memory ranges provided must be page-aligned, but are not required t=
o
> > be hugepage-aligned.  If the memory ranges are not hugepage-aligned, th=
e
> > start/end of the range will be clamped to the first/last hugepage-align=
ed
> > address covered by said range.  The memory ranges must span at least on=
e
> > hugepage-sized region.
> >
> > All non-resident pages covered by the range will first be
> > swapped/faulted-in, before being internally copied onto a freshly
> > allocated hugepage.  Unmapped pages will have their data directly
> > initialized to 0 in the new hugepage.  However, for every eligible
> > hugepage aligned/sized region to-be collapsed, at least one page must
> > currently be backed by memory (a PMD covering the address range must
> > already exist).
> >
> > Allocation for the new hugepage will not enter direct reclaim and/or
> > compaction, quickly failing if allocation fails. When the system has
> > multiple NUMA nodes, the hugepage will be allocated from the node provi=
ding
> > the most native pages. This operation operates on the current state of =
the
> > specified process and makes no persistent changes or guarantees on how =
pages
> > will be mapped, constructed, or faulted in the future.
> >
> > Return Value
> >
> > If all hugepage-sized/aligned regions covered by the provided range wer=
e
> > either successfully collapsed, or were already PMD-mapped THPs, this
> > operation will be deemed successful.  On success, madvise(2) returns 0.
> > Else, -1 is returned and errno is set to indicate the error for the
> > most-recently attempted hugepage collapse.  Note that many failures mig=
ht
> > have occurred, since the operation may continue to collapse in the even=
t a
> > single hugepage-sized/aligned region fails.
> >
> >         ENOMEM  Memory allocation failed or VMA not found
> >         EBUSY   Memcg charging failed
> >         EAGAIN  Required resource temporarily unavailable.  Try again
> >                 might succeed.
> >         EINVAL  Other error: No PMD found, subpage doesn't have Present
> >                 bit set, "Special" page no backed by struct page, VMA
> >                 incorrectly sized, address not page-aligned, ...
> >
> > Use Cases
> >
> > An immediate user of this new functionality is the Go runtime heap allo=
cator
> > that manages memory in hugepage-sized chunks. In the past, whether it w=
as a
> > newly allocated chunk through mmap() or a reused chunk released by
> > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory =
with
> > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3=
]
> > respectively. However, both approaches resulted in performance issues; =
for
> > both scenarios, there could be entries into direct reclaim and/or compa=
ction,
> > leading to unpredictable stalls[4]. Now, the allocator can confidently =
use
> > madvise(MADV_TRY_COLLAPSE) to attempt the allocation of huge pages.
> >
> > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404f=
aca29a82689c77
> > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181=
268b60a3a
> > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4=
b3a9bd2af
> > [4] https://github.com/golang/go/issues/63334
>
> Thanks for the patch, Lance, and thanks for providing the links above,
> referring to issues Go has seen.
>
> I've reached out to the Go team to try and understand their use case,
> and how we could help. It's not immediately clear whether a
> lighter-weight MADV_COLLAPSE is the answer, but it could turn out to
> be.
>
> That said, with respect to the implementation, should a need for a
> lighter-weight MADV_COLLAPSE be warranted, I'd personally like to see
> process_madvise(2) be the "v2" of madvise(2), where we can start

I agree with you; it's a good idea!

> leveraging the forward-facing flags argument for these different
> advice flavors. We'd need to safely revert v5.10 commit a68a0262abdaa
> ("mm/madvise: remove racy mm ownership check") so that
> process_madvise(2) can always operate on self. IIRC, this was ~ the
> plan we landed on during MADV_COLLAPSE dev discussions (i.e. pick a
> sane default, and implement options in flags down the line).
>
> That flag could be a MADV_F_COLLAPSE_LIGHT, where we use a lighter

The name MADV_F_COLLAPSE_LIGHT sounds great for the flag, and its
semantics are very clear.

Thanks again for your review and your suggestion!
Lance

> allocation context, as well as, for example, only do a local
> lru_add_drain() vs lru_add_drain_all(). But I'll refrain from thinking
> too hard about it just yet.
>
> Best,
> Zach
>
>
>
>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/mman.h           |  1 +
> >  arch/mips/include/uapi/asm/mman.h            |  1 +
> >  arch/parisc/include/uapi/asm/mman.h          |  1 +
> >  arch/xtensa/include/uapi/asm/mman.h          |  1 +
> >  include/linux/huge_mm.h                      |  5 +++--
> >  include/uapi/asm-generic/mman-common.h       |  1 +
> >  mm/khugepaged.c                              | 19 ++++++++++++++++---
> >  mm/madvise.c                                 |  8 +++++++-
> >  tools/include/uapi/asm-generic/mman-common.h |  1 +
> >  9 files changed, 32 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/ua=
pi/asm/mman.h
> > index 763929e814e9..44aa1f57a982 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -77,6 +77,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi=
/asm/mman.h
> > index c6e1fc77c996..1ae16e5d7dfc 100644
> > --- a/arch/mips/include/uapi/asm/mman.h
> > +++ b/arch/mips/include/uapi/asm/mman.h
> > @@ -104,6 +104,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/=
uapi/asm/mman.h
> > index 68c44f99bc93..f8d016ee1f98 100644
> > --- a/arch/parisc/include/uapi/asm/mman.h
> > +++ b/arch/parisc/include/uapi/asm/mman.h
> > @@ -71,6 +71,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  #define MADV_HWPOISON     100          /* poison a page for testing */
> >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testin=
g */
> > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/=
uapi/asm/mman.h
> > index 1ff0c858544f..c495d1b39c83 100644
> > --- a/arch/xtensa/include/uapi/asm/mman.h
> > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > @@ -112,6 +112,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 5adb86af35fc..e1af75aa18fb 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, un=
signed long *vm_flags,
> >                      int advice);
> >  int madvise_collapse(struct vm_area_struct *vma,
> >                      struct vm_area_struct **prev,
> > -                    unsigned long start, unsigned long end);
> > +                    unsigned long start, unsigned long end, bool is_tr=
y);
> >  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long s=
tart,
> >                            unsigned long end, long adjust_next);
> >  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *v=
ma);
> > @@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_s=
truct *vma,
> >
> >  static inline int madvise_collapse(struct vm_area_struct *vma,
> >                                    struct vm_area_struct **prev,
> > -                                  unsigned long start, unsigned long e=
nd)
> > +                                  unsigned long start, unsigned long e=
nd,
> > +                                  bool is_try)
> >  {
> >         return -EINVAL;
> >  }
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-=
generic/mman-common.h
> > index 6ce1f1ceb432..a9e5273db5f6 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -78,6 +78,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2b219acb528e..c22703155b6e 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -96,6 +96,7 @@ static struct kmem_cache *mm_slot_cache __ro_after_in=
it;
> >
> >  struct collapse_control {
> >         bool is_khugepaged;
> > +       bool is_try;
> >
> >         /* Num pages scanned per node */
> >         u32 node_load[MAX_NUMNODES];
> > @@ -1058,10 +1059,14 @@ static int __collapse_huge_page_swapin(struct m=
m_struct *mm,
> >  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *m=
m,
> >                               struct collapse_control *cc)
> >  {
> > -       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gf=
pmask() :
> > -                    GFP_TRANSHUGE);
> >         int node =3D hpage_collapse_find_target_node(cc);
> >         struct folio *folio;
> > +       gfp_t gfp;
> > +
> > +       if (cc->is_khugepaged)
> > +               gfp =3D alloc_hugepage_khugepaged_gfpmask();
> > +       else
> > +               gfp =3D cc->is_try ? GFP_TRANSHUGE_LIGHT : GFP_TRANSHUG=
E;
> >
> >         if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_n=
mask)) {
> >                 *hpage =3D NULL;
> > @@ -2697,7 +2702,7 @@ static int madvise_collapse_errno(enum scan_resul=
t r)
> >  }
> >
> >  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct=
 **prev,
> > -                    unsigned long start, unsigned long end)
> > +                    unsigned long start, unsigned long end, bool is_tr=
y)
> >  {
> >         struct collapse_control *cc;
> >         struct mm_struct *mm =3D vma->vm_mm;
> > @@ -2718,6 +2723,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
struct vm_area_struct **prev,
> >         if (!cc)
> >                 return -ENOMEM;
> >         cc->is_khugepaged =3D false;
> > +       cc->is_try =3D is_try;
> >
> >         mmgrab(mm);
> >         lru_add_drain_all();
> > @@ -2773,6 +2779,13 @@ int madvise_collapse(struct vm_area_struct *vma,=
 struct vm_area_struct **prev,
> >                         result =3D collapse_pte_mapped_thp(mm, addr, tr=
ue);
> >                         mmap_read_unlock(mm);
> >                         goto handle_result;
> > +               /* MADV_TRY_COLLAPSE: fail quickly */
> > +               case SCAN_ALLOC_HUGE_PAGE_FAIL:
> > +               case SCAN_CGROUP_CHARGE_FAIL:
> > +                       if (cc->is_try) {
> > +                               last_fail =3D result;
> > +                               goto out_maybelock;
> > +                       }
> >                 /* Whitelisted set of results where continuing OK */
> >                 case SCAN_PMD_NULL:
> >                 case SCAN_PTE_NON_PRESENT:
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 912155a94ed5..5a359bcd286c 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> >         case MADV_COLLAPSE:
> > +       case MADV_TRY_COLLAPSE:
> >                 return 0;
> >         default:
> >                 /* be safe, default to 1. list exceptions explicitly */
> > @@ -1082,8 +1083,10 @@ static int madvise_vma_behavior(struct vm_area_s=
truct *vma,
> >                 if (error)
> >                         goto out;
> >                 break;
> > +       case MADV_TRY_COLLAPSE:
> > +               return madvise_collapse(vma, prev, start, end, true);
> >         case MADV_COLLAPSE:
> > -               return madvise_collapse(vma, prev, start, end);
> > +               return madvise_collapse(vma, prev, start, end, false);
> >         }
> >
> >         anon_name =3D anon_vma_name(vma);
> > @@ -1178,6 +1181,7 @@ madvise_behavior_valid(int behavior)
> >         case MADV_HUGEPAGE:
> >         case MADV_NOHUGEPAGE:
> >         case MADV_COLLAPSE:
> > +       case MADV_TRY_COLLAPSE:
> >  #endif
> >         case MADV_DONTDUMP:
> >         case MADV_DODUMP:
> > @@ -1368,6 +1372,8 @@ int madvise_set_anon_name(struct mm_struct *mm, u=
nsigned long start,
> >   *             transparent huge pages so the existing pages will not b=
e
> >   *             coalesced into THP and new pages will not be allocated =
as THP.
> >   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> > + *  MADV_TRY_COLLAPSE - similar to COLLAPSE, but avoids direct reclaim
> > + *             and/or compaction.
> >   *  MADV_DONTDUMP - the application wants to prevent pages in the give=
n range
> >   *             from being included in its core dump.
> >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core du=
mp.
> > diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/inclu=
de/uapi/asm-generic/mman-common.h
> > index 6ce1f1ceb432..a9e5273db5f6 100644
> > --- a/tools/include/uapi/asm-generic/mman-common.h
> > +++ b/tools/include/uapi/asm-generic/mman-common.h
> > @@ -78,6 +78,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_TRY_COLLAPSE      26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > --
> > 2.33.1
> >

