Return-Path: <linux-kernel+bounces-25585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA782D305
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A91D1F21052
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259B17CB;
	Mon, 15 Jan 2024 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYw4zg2n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8315B3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705283688; x=1736819688;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=1bf2SLo/GP3dv+Ga8QLo6O3BQdW9hoHYWPcbbwFWbfg=;
  b=WYw4zg2nzx/2S0Gw1088CX4LL1fljdhxMVLnA93wF4Zobf2rOc/1OKlM
   eu+AWOzr7gdj8QNpcDrpF9ldFH5aMVfnFYv7zGgXtAqs8zSsISX245Uy+
   31+OvlhzWBDJ/VXtgOHi78izhpYkFLXNjEdK97vUX08ciYJ/FLkX0wyxI
   2xil6eD4UCHYACC/ESmOY2JYe58V82A8MLwvpBUop9iKDc/hR6pcOHuge
   IShjKYbJkHMeSueI3P38MjKm82zk4rkgW+/2djy1fTHRIMRvOW6fxnC6i
   pJhPOf54YrD+gD9wWEIlA2k7p03pxGzgTSIMXZ7xjYfURJHDEuKzEvJkI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6270127"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6270127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="926976585"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="926976585"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:54:44 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without
 vmfault
In-Reply-To: <CAMgjq7DkyZU0udhSUEfCMMT84Vad20UauXz9pzQp4c=cVFtiMw@mail.gmail.com>
	(Kairui Song's message of "Wed, 10 Jan 2024 11:32:21 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-9-ryncsn@gmail.com>
	<875y039utw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7DkyZU0udhSUEfCMMT84Vad20UauXz9pzQp4c=cVFtiMw@mail.gmail.com>
Date: Mon, 15 Jan 2024 09:52:46 +0800
Message-ID: <87sf2z1hxt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 09:11=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > There are two places where swapin is not caused by direct anon page fa=
ult:
>> > - shmem swapin, invoked indirectly through shmem mapping
>> > - swapoff
>> >
>> > They used to construct a pseudo vmfault struct for swapin function.
>> > Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
>> > ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
>> > path is still using one.
>> >
>> > Introduce a helper for them both, this help save stack usage for swapo=
ff
>> > path, and help apply a unified swapin cache and readahead policy check.
>> >
>> > Due to missing vmfault info, the caller have to pass in mempolicy
>> > explicitly, make it different from swapin_entry and name it
>> > swapin_entry_mpol.
>> >
>> > This commit convert swapoff to use this helper, follow-up commits will
>> > convert shmem to use it too.
>> >
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > ---
>> >  mm/swap.h       |  9 +++++++++
>> >  mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
>> >  mm/swapfile.c   | 15 ++++++---------
>> >  3 files changed, 47 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/mm/swap.h b/mm/swap.h
>> > index 9180411afcfe..8f790a67b948 100644
>> > --- a/mm/swap.h
>> > +++ b/mm/swap.h
>> > @@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_t ent=
ry, gfp_t flag,
>> >               struct mempolicy *mpol, pgoff_t ilx);
>> >  struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
>> >                           struct vm_fault *vmf, enum swap_cache_result=
 *result);
>> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
>> > +                             struct mempolicy *mpol, pgoff_t ilx,
>> > +                             enum swap_cache_result *result);
>> >
>> >  static inline unsigned int folio_swap_flags(struct folio *folio)
>> >  {
>> > @@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp_entr=
y_t swp, gfp_t gfp_mask,
>> >       return NULL;
>> >  }
>> >
>> > +static inline struct page *swapin_entry_mpol(swp_entry_t entry, gfp_t=
 gfp_mask,
>> > +             struct mempolicy *mpol, pgoff_t ilx, enum swap_cache_res=
ult *result)
>> > +{
>> > +     return NULL;
>> > +}
>> > +
>> >  static inline int swap_writepage(struct page *p, struct writeback_con=
trol *wbc)
>> >  {
>> >       return 0;
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index 21badd4f0fc7..3edf4b63158d 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp_entr=
y_t targ_entry, gfp_t gfp_mask,
>> >   * in.
>> >   */
>> >  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>> > -                               struct vm_fault *vmf, void *shadow)
>> > +                                struct mempolicy *mpol, pgoff_t ilx,
>> > +                                void *shadow)
>> >  {
>> > -     struct vm_area_struct *vma =3D vmf->vma;
>> >       struct folio *folio;
>> >
>> > -     /* skip swapcache */
>> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>> > -                             vma, vmf->address, false);
>> > +     folio =3D (struct folio *)alloc_pages_mpol(gfp_mask, 0,
>> > +                     mpol, ilx, numa_node_id());
>> >       if (folio) {
>> >               if (mem_cgroup_swapin_charge_folio(folio, NULL,
>> >                                                  GFP_KERNEL, entry)) {
>> > @@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entry, gf=
p_t gfp_mask,
>> >               goto done;
>> >       }
>> >
>> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>> >       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
>> > -             folio =3D swapin_direct(entry, gfp_mask, vmf, shadow);
>> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, shad=
ow);
>> >               cache_result =3D SWAP_CACHE_BYPASS;
>> >       } else {
>> > -             mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>> >               if (swap_use_vma_readahead())
>> >                       folio =3D swap_vma_readahead(entry, gfp_mask, mp=
ol, ilx, vmf);
>> >               else
>> >                       folio =3D swap_cluster_readahead(entry, gfp_mask=
, mpol, ilx);
>> > -             mpol_cond_put(mpol);
>> >               cache_result =3D SWAP_CACHE_MISS;
>> >       }
>> > +     mpol_cond_put(mpol);
>> >  done:
>> >       if (result)
>> >               *result =3D cache_result;
>> > @@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry, gfp=
_t gfp_mask,
>> >       return folio;
>> >  }
>> >
>> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
>> > +                             struct mempolicy *mpol, pgoff_t ilx,
>> > +                             enum swap_cache_result *result)
>> > +{
>> > +     enum swap_cache_result cache_result;
>> > +     void *shadow =3D NULL;
>> > +     struct folio *folio;
>> > +
>> > +     folio =3D swap_cache_get_folio(entry, NULL, 0, &shadow);
>> > +     if (folio) {
>> > +             cache_result =3D SWAP_CACHE_HIT;
>> > +     } else if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
>> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, shad=
ow);
>> > +             cache_result =3D SWAP_CACHE_BYPASS;
>> > +     } else {
>> > +             folio =3D swap_cluster_readahead(entry, gfp_mask, mpol, =
ilx);
>> > +             cache_result =3D SWAP_CACHE_MISS;
>> > +     }
>> > +
>> > +     if (result)
>> > +             *result =3D cache_result;
>> > +
>> > +     return folio;
>> > +}
>> > +
>> >  #ifdef CONFIG_SYSFS
>> >  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
>> >                                    struct kobj_attribute *attr, char *=
buf)
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 5aa44de11edc..2f77bf143af8 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area_stru=
ct *vma, pmd_t *pmd,
>> >       do {
>> >               struct folio *folio;
>> >               unsigned long offset;
>> > +             struct mempolicy *mpol;
>> >               unsigned char swp_count;
>> >               swp_entry_t entry;
>> > +             pgoff_t ilx;
>> >               int ret;
>> >               pte_t ptent;
>> >
>> > -             struct vm_fault vmf =3D {
>> > -                     .vma =3D vma,
>> > -                     .address =3D addr,
>> > -                     .real_address =3D addr,
>> > -                     .pmd =3D pmd,
>> > -             };
>> > -
>> >               if (!pte++) {
>> >                       pte =3D pte_offset_map(pmd, addr);
>> >                       if (!pte)
>> > @@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_struc=
t *vma, pmd_t *pmd,
>> >               pte_unmap(pte);
>> >               pte =3D NULL;
>> >
>> > -             folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
>> > -                                  &vmf, NULL);
>> > +             mpol =3D get_vma_policy(vma, addr, 0, &ilx);
>> > +             folio =3D swapin_entry_mpol(entry, GFP_HIGHUSER_MOVABLE,
>> > +                                       mpol, ilx, NULL);
>> > +             mpol_cond_put(mpol);
>> >               if (!folio) {
>> >                       /*
>> >                        * The entry could have been freed, and will not
>>
>> IIUC, after the change, we will always use cluster readahead for
>> swapoff.  This may be OK.  But, at least we need some test results which
>> show that this will not cause any issue for this behavior change.  And
>> the behavior change should be described explicitly in patch description.
>
> Hi Ying
>
> Actually there is a swap_use_no_readahead check in swapin_entry_mpol,
> so when readahaed is not needed (SYNC_IO), it's just skipped.
>
> And I think VMA readahead is not helpful swapoff, swapoff is already
> walking the VMA, mostly uninterrupted in kernel space. With VMA
> readahead or not, it will issue IO page by page.
> The benchmark result I posted before is actually VMA readhead vs
> no-readahead for ZRAM, sorry I didn't make it clear. It's obvious
> no-readahead is faster.
>
> For actual block device, cluster readahead might be a good choice for
> swapoff, since all pages will be read for swapoff, there has to be
> enough memory for all swapcached page to stay in memory or swapoff
> will fail anyway, and cluster read is faster for block devices.

It's possible.  But please run the tests on some actual block devices
and show your results.  Random memory accessing pattern should be
tested, and the swap space usage should be > 50% to show some not so
friendly situation.

>>
>> And I don't think it's a good abstraction to make swapin_entry_mpol()
>> always use cluster swapin, while swapin_entry() will try to use vma
>> swapin.  I think we can add "struct mempolicy *mpol" and "pgoff_t ilx"
>> to swapin_entry() as parameters, and use them if vmf =3D=3D NULL.  If we
>> want to enforce cluster swapin in swapoff path, it will be better to add
>> some comments to describe why.
>
> Good suggestion, I thought extending swapin_entry may make its
> arguments list get too long, but seems mpol and ilx are the only thing
> needed here. I'll update it.

Thanks!

--
Best Regards,
Huang, Ying

