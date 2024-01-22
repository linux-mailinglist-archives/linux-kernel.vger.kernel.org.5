Return-Path: <linux-kernel+bounces-32391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC2835B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09C3B23F03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3C9DF6E;
	Mon, 22 Jan 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAoMyyHK"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C3D52D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905615; cv=none; b=eSVDbf7daaXmh15IVYWXZ7id45/K+G7wSa4nD+9CwXsPKN9tbYh+D1BYS1XpONL06li3vPpcXu19jYJmVPl9Oyldg7jdxv6RI75CsgD3PhRLiLKmVj2O7//FvyBly3cP08yowpVmAurf2JspRHYhsTRTvQuZ/8n3/yzcT6bt8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905615; c=relaxed/simple;
	bh=lTAVrR0JBk9IY5C4cV90k560ebkdbeR6FHYwMShlhcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfI1tYFk2h3BUGWZxTw+M+qMLRMbSB8CF3eEg/E/4STMsFFN4DnEpMgVmRl10Uk9oJd3NF/fOgFknfObNu87nhhEjnBLXl6vvSsEVEIo4Cu0r0IawUG54N43Uw1pMy2gzvcOf1Ag3emZEhUyM7hgXWWk8QYN2IP237fCrN36BUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAoMyyHK; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705905613; x=1737441613;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lTAVrR0JBk9IY5C4cV90k560ebkdbeR6FHYwMShlhcc=;
  b=PAoMyyHKBs4T8t3HnLHattj/kdNe05GMtFoUhT0J+uJEgf1Eqnt7/APk
   JSC+ADUKz1YR0AMVtqJ62EAMuILcZ8Ipx9tGrjXDQn169s0bfcNmnTakX
   lqR90VLFGCJGYKRXP5CktgE41OXtCYgJqAQaiS7KwKFs68hpvWuXuUS65
   V3PWCUnW2GHKqXfPBD5o1g6qDCnMMEzxMQz/Lv+D+zI84UWLyI3C6Ge3v
   RfaWU0OtVb20gxJykoJW0k63qUcS2wrTiOa/spi6vDtZGcfZv1neM9S6S
   ZrWtdxYkl+70EmNOBq7wnzRVLRWXKkjtI16yvck1Yxs/FQMYu7EIiKplG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="391550548"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="391550548"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 22:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1108122"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 22:40:10 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without
 vmfault
In-Reply-To: <CAMgjq7C9p-Et2jqyztLp2DHyG8AZrHCnNjXfHkbQrCMDVx-p_g@mail.gmail.com>
	(Kairui Song's message of "Mon, 22 Jan 2024 02:40:36 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-9-ryncsn@gmail.com>
	<875y039utw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7DkyZU0udhSUEfCMMT84Vad20UauXz9pzQp4c=cVFtiMw@mail.gmail.com>
	<87sf2z1hxt.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7C9p-Et2jqyztLp2DHyG8AZrHCnNjXfHkbQrCMDVx-p_g@mail.gmail.com>
Date: Mon, 22 Jan 2024 14:38:12 +0800
Message-ID: <87a5oxx48b.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Jan 15, 2024 at 9:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C 09:11=E5=86=99=E9=81=93=EF=BC=9A
>> >>
>> >> Kairui Song <ryncsn@gmail.com> writes:
>> >>
>> >> > From: Kairui Song <kasong@tencent.com>
>> >> >
>> >> > There are two places where swapin is not caused by direct anon page=
 fault:
>> >> > - shmem swapin, invoked indirectly through shmem mapping
>> >> > - swapoff
>> >> >
>> >> > They used to construct a pseudo vmfault struct for swapin function.
>> >> > Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
>> >> > ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swap=
off
>> >> > path is still using one.
>> >> >
>> >> > Introduce a helper for them both, this help save stack usage for sw=
apoff
>> >> > path, and help apply a unified swapin cache and readahead policy ch=
eck.
>> >> >
>> >> > Due to missing vmfault info, the caller have to pass in mempolicy
>> >> > explicitly, make it different from swapin_entry and name it
>> >> > swapin_entry_mpol.
>> >> >
>> >> > This commit convert swapoff to use this helper, follow-up commits w=
ill
>> >> > convert shmem to use it too.
>> >> >
>> >> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> >> > ---
>> >> >  mm/swap.h       |  9 +++++++++
>> >> >  mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
>> >> >  mm/swapfile.c   | 15 ++++++---------
>> >> >  3 files changed, 47 insertions(+), 17 deletions(-)
>> >> >
>> >> > diff --git a/mm/swap.h b/mm/swap.h
>> >> > index 9180411afcfe..8f790a67b948 100644
>> >> > --- a/mm/swap.h
>> >> > +++ b/mm/swap.h
>> >> > @@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_t =
entry, gfp_t flag,
>> >> >               struct mempolicy *mpol, pgoff_t ilx);
>> >> >  struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
>> >> >                           struct vm_fault *vmf, enum swap_cache_res=
ult *result);
>> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
>> >> > +                             struct mempolicy *mpol, pgoff_t ilx,
>> >> > +                             enum swap_cache_result *result);
>> >> >
>> >> >  static inline unsigned int folio_swap_flags(struct folio *folio)
>> >> >  {
>> >> > @@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp_e=
ntry_t swp, gfp_t gfp_mask,
>> >> >       return NULL;
>> >> >  }
>> >> >
>> >> > +static inline struct page *swapin_entry_mpol(swp_entry_t entry, gf=
p_t gfp_mask,
>> >> > +             struct mempolicy *mpol, pgoff_t ilx, enum swap_cache_=
result *result)
>> >> > +{
>> >> > +     return NULL;
>> >> > +}
>> >> > +
>> >> >  static inline int swap_writepage(struct page *p, struct writeback_=
control *wbc)
>> >> >  {
>> >> >       return 0;
>> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> >> > index 21badd4f0fc7..3edf4b63158d 100644
>> >> > --- a/mm/swap_state.c
>> >> > +++ b/mm/swap_state.c
>> >> > @@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp_e=
ntry_t targ_entry, gfp_t gfp_mask,
>> >> >   * in.
>> >> >   */
>> >> >  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_ma=
sk,
>> >> > -                               struct vm_fault *vmf, void *shadow)
>> >> > +                                struct mempolicy *mpol, pgoff_t il=
x,
>> >> > +                                void *shadow)
>> >> >  {
>> >> > -     struct vm_area_struct *vma =3D vmf->vma;
>> >> >       struct folio *folio;
>> >> >
>> >> > -     /* skip swapcache */
>> >> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>> >> > -                             vma, vmf->address, false);
>> >> > +     folio =3D (struct folio *)alloc_pages_mpol(gfp_mask, 0,
>> >> > +                     mpol, ilx, numa_node_id());
>> >> >       if (folio) {
>> >> >               if (mem_cgroup_swapin_charge_folio(folio, NULL,
>> >> >                                                  GFP_KERNEL, entry)=
) {
>> >> > @@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entry,=
 gfp_t gfp_mask,
>> >> >               goto done;
>> >> >       }
>> >> >
>> >> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>> >> >       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
>> >> > -             folio =3D swapin_direct(entry, gfp_mask, vmf, shadow);
>> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, s=
hadow);
>> >> >               cache_result =3D SWAP_CACHE_BYPASS;
>> >> >       } else {
>> >> > -             mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &i=
lx);
>> >> >               if (swap_use_vma_readahead())
>> >> >                       folio =3D swap_vma_readahead(entry, gfp_mask,=
 mpol, ilx, vmf);
>> >> >               else
>> >> >                       folio =3D swap_cluster_readahead(entry, gfp_m=
ask, mpol, ilx);
>> >> > -             mpol_cond_put(mpol);
>> >> >               cache_result =3D SWAP_CACHE_MISS;
>> >> >       }
>> >> > +     mpol_cond_put(mpol);
>> >> >  done:
>> >> >       if (result)
>> >> >               *result =3D cache_result;
>> >> > @@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry, =
gfp_t gfp_mask,
>> >> >       return folio;
>> >> >  }
>> >> >
>> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
>> >> > +                             struct mempolicy *mpol, pgoff_t ilx,
>> >> > +                             enum swap_cache_result *result)
>> >> > +{
>> >> > +     enum swap_cache_result cache_result;
>> >> > +     void *shadow =3D NULL;
>> >> > +     struct folio *folio;
>> >> > +
>> >> > +     folio =3D swap_cache_get_folio(entry, NULL, 0, &shadow);
>> >> > +     if (folio) {
>> >> > +             cache_result =3D SWAP_CACHE_HIT;
>> >> > +     } else if (swap_use_no_readahead(swp_swap_info(entry), entry)=
) {
>> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, s=
hadow);
>> >> > +             cache_result =3D SWAP_CACHE_BYPASS;
>> >> > +     } else {
>> >> > +             folio =3D swap_cluster_readahead(entry, gfp_mask, mpo=
l, ilx);
>> >> > +             cache_result =3D SWAP_CACHE_MISS;
>> >> > +     }
>> >> > +
>> >> > +     if (result)
>> >> > +             *result =3D cache_result;
>> >> > +
>> >> > +     return folio;
>> >> > +}
>> >> > +
>> >> >  #ifdef CONFIG_SYSFS
>> >> >  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
>> >> >                                    struct kobj_attribute *attr, cha=
r *buf)
>> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> > index 5aa44de11edc..2f77bf143af8 100644
>> >> > --- a/mm/swapfile.c
>> >> > +++ b/mm/swapfile.c
>> >> > @@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area_s=
truct *vma, pmd_t *pmd,
>> >> >       do {
>> >> >               struct folio *folio;
>> >> >               unsigned long offset;
>> >> > +             struct mempolicy *mpol;
>> >> >               unsigned char swp_count;
>> >> >               swp_entry_t entry;
>> >> > +             pgoff_t ilx;
>> >> >               int ret;
>> >> >               pte_t ptent;
>> >> >
>> >> > -             struct vm_fault vmf =3D {
>> >> > -                     .vma =3D vma,
>> >> > -                     .address =3D addr,
>> >> > -                     .real_address =3D addr,
>> >> > -                     .pmd =3D pmd,
>> >> > -             };
>> >> > -
>> >> >               if (!pte++) {
>> >> >                       pte =3D pte_offset_map(pmd, addr);
>> >> >                       if (!pte)
>> >> > @@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_st=
ruct *vma, pmd_t *pmd,
>> >> >               pte_unmap(pte);
>> >> >               pte =3D NULL;
>> >> >
>> >> > -             folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
>> >> > -                                  &vmf, NULL);
>> >> > +             mpol =3D get_vma_policy(vma, addr, 0, &ilx);
>> >> > +             folio =3D swapin_entry_mpol(entry, GFP_HIGHUSER_MOVAB=
LE,
>> >> > +                                       mpol, ilx, NULL);
>> >> > +             mpol_cond_put(mpol);
>> >> >               if (!folio) {
>> >> >                       /*
>> >> >                        * The entry could have been freed, and will =
not
>> >>
>> >> IIUC, after the change, we will always use cluster readahead for
>> >> swapoff.  This may be OK.  But, at least we need some test results wh=
ich
>> >> show that this will not cause any issue for this behavior change.  And
>> >> the behavior change should be described explicitly in patch descripti=
on.
>> >
>> > Hi Ying
>> >
>> > Actually there is a swap_use_no_readahead check in swapin_entry_mpol,
>> > so when readahaed is not needed (SYNC_IO), it's just skipped.
>> >
>> > And I think VMA readahead is not helpful swapoff, swapoff is already
>> > walking the VMA, mostly uninterrupted in kernel space. With VMA
>> > readahead or not, it will issue IO page by page.
>> > The benchmark result I posted before is actually VMA readhead vs
>> > no-readahead for ZRAM, sorry I didn't make it clear. It's obvious
>> > no-readahead is faster.
>> >
>> > For actual block device, cluster readahead might be a good choice for
>> > swapoff, since all pages will be read for swapoff, there has to be
>> > enough memory for all swapcached page to stay in memory or swapoff
>> > will fail anyway, and cluster read is faster for block devices.
>>
>> It's possible.  But please run the tests on some actual block devices
>> and show your results.  Random memory accessing pattern should be
>> tested, and the swap space usage should be > 50% to show some not so
>> friendly situation.
>>
>
> Hi Ying,
>
> I setup a test environment and did following test, and found that
> cluster readahaed for swapoff is actually much worse in default setup:
>
> 1. Setup MySQL server using 2G memcg, with 28G buffer pool, and 24G NVME =
swap
> 2. Stress test with sysbench for 15min.
> 3. Remove the 2G memcg limit and swapoff.
>
> Before this patch, swapoff will take about 9m.
> After this patch, swapoff will take about 30m.

Thanks for data!

> After some analysis I found the reason is that cluster readahead is
> almost disabled (window =3D=3D 1 or 2) during swapoff, because it will
> detect a very low hit rate on fragmented swap. But VMA readhead is
> much more aggressive here since swapoff is walking the VMA, with a
> very high hit rate.
>
> But If I force cluster readahead to use a large window for swapoff,
> the swapoff performance boost by a lot:
> By adding following change in swap_cluster_readahead:
>
> if (unlikely(!(si->flags & SWP_WRITEOK)))
>     mask =3D max_t(unsigned long, 1 << READ_ONCE(page_cluster), PMD_SIZE
> / PAGE_SIZE) - 1;
>
> The swapoff will take only 40s to finish, more than 10x faster than
> the VMA readahead path (9m), because VMA readhead is still doing 4K
> random IO just with a longer queue due to async readahead. But cluster
> readhead will be doing 2M IO now.
> I think PMD size window is good here since it still keep a balance
> between good IO performance and the swapoff progress can still be
> interrupted, and the system is responsible. And in most cases we
> expect swapoff to success, if it fail, the RA windows should still
> keep the side effect of extra swapcache being generated acceptable.

swapoff performance isn't very important because swapoff is a very rare
operation.  It's OK to optimize it if the change is simple and doesn't
compromise other stuff.  But, as you said below, using large readahead
window makes mempolicy issue more serious.  Why isn't the original
swapoff performance good enough for you?

> But this showed a bad effect of ignoring mem policy. Actually this is
> not a new issue, cluster readhead is already violating VMA's mem
> policy since it does readhead only based on entry value not VMA, the
> entry being swapped in is not aware of which VMA it belongs.
>
> And I was thinking, maybe we can just drop the mpol all the way, and
> use the nid from page shadow to alloc pages, that may save a lot of
> effort, and make cluster readhead more usable in general, also might
> simplify a lot of code. How do you think? If this is acceptable, I
> think I can send out a new series first and then rework this one
> later.

The "shadow" node can be reclaimed, please take a look at
scan_shadow_nodes().  Although this hasn't been implemented, it may be
implemented someday.

And, shadow nid may not record the correct memory policy for the memory
allocation.

--
Best Regards,
Huang, Ying

