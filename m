Return-Path: <linux-kernel+bounces-32938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB5836232
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B5B1C24DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5D3CF5B;
	Mon, 22 Jan 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmvAzXrz"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FA83CF40
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923341; cv=none; b=J3YGC2wCyhWSdbvqu2mXVGmdQXrGQ/SDU9ovPdh3Y2CBnCEIdDmRX8DjzlyIknj21yG2ckq/pgSUiBVUG2E+f5sHlIYqCM5oDi9YLo1JIwgDMSVdBEc+HtLJbFs/i3kgZKs9uamq4deSKMxisRDDqfTjJNw/VUt4V0rcjJ6rjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923341; c=relaxed/simple;
	bh=ITktg658KO+jYDW2QrE2wJQ7SBPbLvYw7i5tXs4P9YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWmH+o5OkPaEov2dFmKFaByj2WdtdWTxIjUf3VRk5rXMejbZ2kufi/RvCHas+rkJGsdBcc0rDiHpSqOp5K6dCTyyA4wuRDHNMivU0A+tiqOK55u4Zswp+CBJV/Zdvz6XRcIAsv0gLt2bn3n2Tm56vTT1impE29euxiW7t1l8wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmvAzXrz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd33336b32so38972701fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705923337; x=1706528137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o0uKBllJvi/u5nbk3CVZywiatfH4T2y62YoNZLL7R0=;
        b=lmvAzXrzXSZgo7zArNce/8fPXfYFuI+Yj2Lp3bT2b1ffoAsejWpw3Btxl1Kxc77eUx
         4ZSjXL9x8PKN9K5+zi+iVJpCZmd0VVjTTjKUm6X8PoIYh4CYcBnKKfWMKgxKE7VBEWAf
         Rr78cegh6DOSOerlWHc18UB+BhiDE8ZC42gICCyregAa0k/epzBwOAs0AetQMWxS+gep
         oLMzJao+xQa7fZ9SY/vVgAqh10u9gL67jFUcYmbQm1Lc76MWsYjxFY9B+e7mCiRSrNSm
         1KqfE8ecrW9FpjnIUYy0E6jD81UT3tDuBHlBpV/YnTHSBtxpwsc4OK+i/2lH6KrzgfvI
         XOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923337; x=1706528137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o0uKBllJvi/u5nbk3CVZywiatfH4T2y62YoNZLL7R0=;
        b=c6jhG1JdkxsChq78Ma4vv4Lkh1CKRdaPZBPfb2ZuX0JM/fxkEvSnfp+0w565A54OcJ
         heRgHdP8Q6W33uAPur4t9nJvSMqg1X7kzUz58nEaQ9panw+og6gn4/GgT2k/oz0PbKhJ
         stamWCJVad9DUsmfoUjfoalSb4IzGgWuTogKKI9XdGdob30GHVDGBPycXIv2cKXSfQcc
         a2S31R5WiURk3gKyh88TEeb4IJbeLl71Lu2O9+gPusFf2uCeHl70oE6O2YzxBv7LbhYh
         4qZw8B8uJy4p4HqZdfatq7lvKUWvYKidZWRMhsqJA3GMpPmjBlsnj/D8DCdLRM/2oYP/
         xTCQ==
X-Gm-Message-State: AOJu0Yy83qoG1tEE+TYcCGxv6vwhQFCng5Pll62KjyMR3SvpvaMOFfH+
	hVrDy4H92OVTIxBaWzNEi3lB/Byd4gbiBR8KNRsmcvRcUAotSxJVBvOZFaZT7nD4+UZyt8sVzEm
	7fzTXv1G8WkxYm8aVKiAgd+ov/ANrzGtlUq0aBATs
X-Google-Smtp-Source: AGHT+IHfSozxUUj0jjaI+2kcSPrKaQqsMYG3W0hLYXvp5KnKOjx/5xd2V6yarKKAa7fwI8yZOsun/eyIA2n6TND4jF8=
X-Received: by 2002:a2e:80d6:0:b0:2cd:827d:e37b with SMTP id
 r22-20020a2e80d6000000b002cd827de37bmr1786575ljg.59.1705923337022; Mon, 22
 Jan 2024 03:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-9-ryncsn@gmail.com>
 <875y039utw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DkyZU0udhSUEfCMMT84Vad20UauXz9pzQp4c=cVFtiMw@mail.gmail.com>
 <87sf2z1hxt.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7C9p-Et2jqyztLp2DHyG8AZrHCnNjXfHkbQrCMDVx-p_g@mail.gmail.com>
 <87a5oxx48b.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5oxx48b.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 22 Jan 2024 19:35:19 +0800
Message-ID: <CAMgjq7C8z-zEw9X-s-C4cy5NhfC4DuiK2-4Ca5SeOZ0NGZMm0w@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without vmfault
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:40=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Mon, Jan 15, 2024 at 9:54=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C 09:11=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> Kairui Song <ryncsn@gmail.com> writes:
> >> >>
> >> >> > From: Kairui Song <kasong@tencent.com>
> >> >> >
> >> >> > There are two places where swapin is not caused by direct anon pa=
ge fault:
> >> >> > - shmem swapin, invoked indirectly through shmem mapping
> >> >> > - swapoff
> >> >> >
> >> >> > They used to construct a pseudo vmfault struct for swapin functio=
n.
> >> >> > Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc=
05d
> >> >> > ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Sw=
apoff
> >> >> > path is still using one.
> >> >> >
> >> >> > Introduce a helper for them both, this help save stack usage for =
swapoff
> >> >> > path, and help apply a unified swapin cache and readahead policy =
check.
> >> >> >
> >> >> > Due to missing vmfault info, the caller have to pass in mempolicy
> >> >> > explicitly, make it different from swapin_entry and name it
> >> >> > swapin_entry_mpol.
> >> >> >
> >> >> > This commit convert swapoff to use this helper, follow-up commits=
 will
> >> >> > convert shmem to use it too.
> >> >> >
> >> >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >> >> > ---
> >> >> >  mm/swap.h       |  9 +++++++++
> >> >> >  mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
> >> >> >  mm/swapfile.c   | 15 ++++++---------
> >> >> >  3 files changed, 47 insertions(+), 17 deletions(-)
> >> >> >
> >> >> > diff --git a/mm/swap.h b/mm/swap.h
> >> >> > index 9180411afcfe..8f790a67b948 100644
> >> >> > --- a/mm/swap.h
> >> >> > +++ b/mm/swap.h
> >> >> > @@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_=
t entry, gfp_t flag,
> >> >> >               struct mempolicy *mpol, pgoff_t ilx);
> >> >> >  struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
> >> >> >                           struct vm_fault *vmf, enum swap_cache_r=
esult *result);
> >> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mas=
k,
> >> >> > +                             struct mempolicy *mpol, pgoff_t ilx=
,
> >> >> > +                             enum swap_cache_result *result);
> >> >> >
> >> >> >  static inline unsigned int folio_swap_flags(struct folio *folio)
> >> >> >  {
> >> >> > @@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp=
_entry_t swp, gfp_t gfp_mask,
> >> >> >       return NULL;
> >> >> >  }
> >> >> >
> >> >> > +static inline struct page *swapin_entry_mpol(swp_entry_t entry, =
gfp_t gfp_mask,
> >> >> > +             struct mempolicy *mpol, pgoff_t ilx, enum swap_cach=
e_result *result)
> >> >> > +{
> >> >> > +     return NULL;
> >> >> > +}
> >> >> > +
> >> >> >  static inline int swap_writepage(struct page *p, struct writebac=
k_control *wbc)
> >> >> >  {
> >> >> >       return 0;
> >> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> >> > index 21badd4f0fc7..3edf4b63158d 100644
> >> >> > --- a/mm/swap_state.c
> >> >> > +++ b/mm/swap_state.c
> >> >> > @@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp=
_entry_t targ_entry, gfp_t gfp_mask,
> >> >> >   * in.
> >> >> >   */
> >> >> >  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_=
mask,
> >> >> > -                               struct vm_fault *vmf, void *shado=
w)
> >> >> > +                                struct mempolicy *mpol, pgoff_t =
ilx,
> >> >> > +                                void *shadow)
> >> >> >  {
> >> >> > -     struct vm_area_struct *vma =3D vmf->vma;
> >> >> >       struct folio *folio;
> >> >> >
> >> >> > -     /* skip swapcache */
> >> >> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >> >> > -                             vma, vmf->address, false);
> >> >> > +     folio =3D (struct folio *)alloc_pages_mpol(gfp_mask, 0,
> >> >> > +                     mpol, ilx, numa_node_id());
> >> >> >       if (folio) {
> >> >> >               if (mem_cgroup_swapin_charge_folio(folio, NULL,
> >> >> >                                                  GFP_KERNEL, entr=
y)) {
> >> >> > @@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entr=
y, gfp_t gfp_mask,
> >> >> >               goto done;
> >> >> >       }
> >> >> >
> >> >> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> >> >> >       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> >> >> > -             folio =3D swapin_direct(entry, gfp_mask, vmf, shado=
w);
> >> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx,=
 shadow);
> >> >> >               cache_result =3D SWAP_CACHE_BYPASS;
> >> >> >       } else {
> >> >> > -             mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, =
&ilx);
> >> >> >               if (swap_use_vma_readahead())
> >> >> >                       folio =3D swap_vma_readahead(entry, gfp_mas=
k, mpol, ilx, vmf);
> >> >> >               else
> >> >> >                       folio =3D swap_cluster_readahead(entry, gfp=
_mask, mpol, ilx);
> >> >> > -             mpol_cond_put(mpol);
> >> >> >               cache_result =3D SWAP_CACHE_MISS;
> >> >> >       }
> >> >> > +     mpol_cond_put(mpol);
> >> >> >  done:
> >> >> >       if (result)
> >> >> >               *result =3D cache_result;
> >> >> > @@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry=
, gfp_t gfp_mask,
> >> >> >       return folio;
> >> >> >  }
> >> >> >
> >> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mas=
k,
> >> >> > +                             struct mempolicy *mpol, pgoff_t ilx=
,
> >> >> > +                             enum swap_cache_result *result)
> >> >> > +{
> >> >> > +     enum swap_cache_result cache_result;
> >> >> > +     void *shadow =3D NULL;
> >> >> > +     struct folio *folio;
> >> >> > +
> >> >> > +     folio =3D swap_cache_get_folio(entry, NULL, 0, &shadow);
> >> >> > +     if (folio) {
> >> >> > +             cache_result =3D SWAP_CACHE_HIT;
> >> >> > +     } else if (swap_use_no_readahead(swp_swap_info(entry), entr=
y)) {
> >> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx,=
 shadow);
> >> >> > +             cache_result =3D SWAP_CACHE_BYPASS;
> >> >> > +     } else {
> >> >> > +             folio =3D swap_cluster_readahead(entry, gfp_mask, m=
pol, ilx);
> >> >> > +             cache_result =3D SWAP_CACHE_MISS;
> >> >> > +     }
> >> >> > +
> >> >> > +     if (result)
> >> >> > +             *result =3D cache_result;
> >> >> > +
> >> >> > +     return folio;
> >> >> > +}
> >> >> > +
> >> >> >  #ifdef CONFIG_SYSFS
> >> >> >  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
> >> >> >                                    struct kobj_attribute *attr, c=
har *buf)
> >> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> >> > index 5aa44de11edc..2f77bf143af8 100644
> >> >> > --- a/mm/swapfile.c
> >> >> > +++ b/mm/swapfile.c
> >> >> > @@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area=
_struct *vma, pmd_t *pmd,
> >> >> >       do {
> >> >> >               struct folio *folio;
> >> >> >               unsigned long offset;
> >> >> > +             struct mempolicy *mpol;
> >> >> >               unsigned char swp_count;
> >> >> >               swp_entry_t entry;
> >> >> > +             pgoff_t ilx;
> >> >> >               int ret;
> >> >> >               pte_t ptent;
> >> >> >
> >> >> > -             struct vm_fault vmf =3D {
> >> >> > -                     .vma =3D vma,
> >> >> > -                     .address =3D addr,
> >> >> > -                     .real_address =3D addr,
> >> >> > -                     .pmd =3D pmd,
> >> >> > -             };
> >> >> > -
> >> >> >               if (!pte++) {
> >> >> >                       pte =3D pte_offset_map(pmd, addr);
> >> >> >                       if (!pte)
> >> >> > @@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_=
struct *vma, pmd_t *pmd,
> >> >> >               pte_unmap(pte);
> >> >> >               pte =3D NULL;
> >> >> >
> >> >> > -             folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> >> >> > -                                  &vmf, NULL);
> >> >> > +             mpol =3D get_vma_policy(vma, addr, 0, &ilx);
> >> >> > +             folio =3D swapin_entry_mpol(entry, GFP_HIGHUSER_MOV=
ABLE,
> >> >> > +                                       mpol, ilx, NULL);
> >> >> > +             mpol_cond_put(mpol);
> >> >> >               if (!folio) {
> >> >> >                       /*
> >> >> >                        * The entry could have been freed, and wil=
l not
> >> >>
> >> >> IIUC, after the change, we will always use cluster readahead for
> >> >> swapoff.  This may be OK.  But, at least we need some test results =
which
> >> >> show that this will not cause any issue for this behavior change.  =
And
> >> >> the behavior change should be described explicitly in patch descrip=
tion.
> >> >
> >> > Hi Ying
> >> >
> >> > Actually there is a swap_use_no_readahead check in swapin_entry_mpol=
,
> >> > so when readahaed is not needed (SYNC_IO), it's just skipped.
> >> >
> >> > And I think VMA readahead is not helpful swapoff, swapoff is already
> >> > walking the VMA, mostly uninterrupted in kernel space. With VMA
> >> > readahead or not, it will issue IO page by page.
> >> > The benchmark result I posted before is actually VMA readhead vs
> >> > no-readahead for ZRAM, sorry I didn't make it clear. It's obvious
> >> > no-readahead is faster.
> >> >
> >> > For actual block device, cluster readahead might be a good choice fo=
r
> >> > swapoff, since all pages will be read for swapoff, there has to be
> >> > enough memory for all swapcached page to stay in memory or swapoff
> >> > will fail anyway, and cluster read is faster for block devices.
> >>
> >> It's possible.  But please run the tests on some actual block devices
> >> and show your results.  Random memory accessing pattern should be
> >> tested, and the swap space usage should be > 50% to show some not so
> >> friendly situation.
> >>
> >
> > Hi Ying,
> >
> > I setup a test environment and did following test, and found that
> > cluster readahaed for swapoff is actually much worse in default setup:
> >
> > 1. Setup MySQL server using 2G memcg, with 28G buffer pool, and 24G NVM=
E swap
> > 2. Stress test with sysbench for 15min.
> > 3. Remove the 2G memcg limit and swapoff.
> >
> > Before this patch, swapoff will take about 9m.
> > After this patch, swapoff will take about 30m.
>
> Thanks for data!
>
> > After some analysis I found the reason is that cluster readahead is
> > almost disabled (window =3D=3D 1 or 2) during swapoff, because it will
> > detect a very low hit rate on fragmented swap. But VMA readhead is
> > much more aggressive here since swapoff is walking the VMA, with a
> > very high hit rate.
> >
> > But If I force cluster readahead to use a large window for swapoff,
> > the swapoff performance boost by a lot:
> > By adding following change in swap_cluster_readahead:
> >
> > if (unlikely(!(si->flags & SWP_WRITEOK)))
> >     mask =3D max_t(unsigned long, 1 << READ_ONCE(page_cluster), PMD_SIZ=
E
> > / PAGE_SIZE) - 1;
> >
> > The swapoff will take only 40s to finish, more than 10x faster than
> > the VMA readahead path (9m), because VMA readhead is still doing 4K
> > random IO just with a longer queue due to async readahead. But cluster
> > readhead will be doing 2M IO now.
> > I think PMD size window is good here since it still keep a balance
> > between good IO performance and the swapoff progress can still be
> > interrupted, and the system is responsible. And in most cases we
> > expect swapoff to success, if it fail, the RA windows should still
> > keep the side effect of extra swapcache being generated acceptable.
>
> swapoff performance isn't very important because swapoff is a very rare
> operation.  It's OK to optimize it if the change is simple and doesn't
> compromise other stuff.  But, as you said below, using large readahead
> window makes mempolicy issue more serious.  Why isn't the original
> swapoff performance good enough for you?

Thanks for the reply.

I think I'll just keep the original VMA readahead policy here then.
Just I noticed that VMA readhead will also violate ranged memory
policy too... That's some different issue, looks trivial though.

>
> > But this showed a bad effect of ignoring mem policy. Actually this is
> > not a new issue, cluster readhead is already violating VMA's mem
> > policy since it does readhead only based on entry value not VMA, the
> > entry being swapped in is not aware of which VMA it belongs.
> >
> > And I was thinking, maybe we can just drop the mpol all the way, and
> > use the nid from page shadow to alloc pages, that may save a lot of
> > effort, and make cluster readhead more usable in general, also might
> > simplify a lot of code. How do you think? If this is acceptable, I
> > think I can send out a new series first and then rework this one
> > later.
>
> The "shadow" node can be reclaimed, please take a look at
> scan_shadow_nodes().  Although this hasn't been implemented, it may be
> implemented someday.

Right, I noticed upstream commit 5649d113ffce ("swap_state: update
shadow_nodes for anonymous page") started reclaiming anon pages
shadows now, thanks for the info.

