Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644017F22EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjKUBMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjKUBMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:12:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0145BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700529132; x=1732065132;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=VEFsIUgfPV39a0OqrPWAUirhQiyA7JQSSKxLhbj5aiA=;
  b=IX20ZPXBim4Qf26nXbDSrtu0llZ7hn/Zp2mybrGxAhfjg9nnJf+z0JM/
   FBjzWasEBnoPx0qUH2WBI1FxCghrGsI5MDe62L05yo0eb9aW4eo1Tzvcf
   QZYcAht8WcC2p5DY5YkefrDs/VJWBIdaPVsTZgQjhUj59iNLEY/12QnXw
   FuyEAnf2uS2c5PkLFzH4AWba/pYcVx3UfEDyl8ASf2OOrEeup4++uvih6
   4da22W9v3YZ6dcDarqwHqSmXRVOl1hlefgUXErZfcmch+GanXyTRhD/WO
   k1+u7PbL7njyvSXoSDJyjsNuKxYKtzaERAKxfzmYcYGyqwW2Ri133I5+j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10407918"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="10407918"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097886053"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1097886053"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:12:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
In-Reply-To: <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
        (Kairui Song's message of "Mon, 20 Nov 2023 19:17:12 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-9-ryncsn@gmail.com>
        <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
Date:   Tue, 21 Nov 2023 09:10:06 +0800
Message-ID: <87a5r7c3o1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 14:07=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Currently VMA readahead is globally disabled when any rotate disk is
>> > used as swap backend. So multiple swap devices are enabled, if a slower
>> > hard disk is set as a low priority fallback, and a high performance SSD
>> > is used and high priority swap device, vma readahead is disabled globa=
lly.
>> > The SSD swap device performance will drop by a lot.
>> >
>> > Check readahead policy per entry to avoid such problem.
>> >
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > ---
>> >  mm/swap_state.c | 12 +++++++-----
>> >  1 file changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index ff6756f2e8e4..fb78f7f18ed7 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct sw=
ap_info_struct *si, swp_entry_
>> >       return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count=
(entry) =3D=3D 1;
>> >  }
>> >
>> > -static inline bool swap_use_vma_readahead(void)
>> > +static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
>> >  {
>> > -     return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotat=
e_swap);
>> > +     return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enable=
_vma_readahead);
>> >  }
>> >
>> >  /*
>> > @@ -341,7 +341,7 @@ struct folio *swap_cache_get_folio(swp_entry_t ent=
ry,
>> >
>> >       folio =3D filemap_get_folio(swap_address_space(entry), swp_offse=
t(entry));
>> >       if (!IS_ERR(folio)) {
>> > -             bool vma_ra =3D swap_use_vma_readahead();
>> > +             bool vma_ra =3D swap_use_vma_readahead(swp_swap_info(ent=
ry));
>> >               bool readahead;
>> >
>> >               /*
>> > @@ -920,16 +920,18 @@ static struct page *swapin_no_readahead(swp_entr=
y_t entry, gfp_t gfp_mask,
>> >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>> >                             struct vm_fault *vmf, bool *swapcached)
>> >  {
>> > +     struct swap_info_struct *si;
>> >       struct mempolicy *mpol;
>> >       struct page *page;
>> >       pgoff_t ilx;
>> >       bool cached;
>> >
>> > +     si =3D swp_swap_info(entry);
>> >       mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>> > -     if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
>> > +     if (swap_use_no_readahead(si, entry)) {
>> >               page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx,=
 vmf->vma->vm_mm);
>> >               cached =3D false;
>> > -     } else if (swap_use_vma_readahead()) {
>> > +     } else if (swap_use_vma_readahead(si)) {
>>
>> It's possible that some pages are swapped out to SSD while others are
>> swapped out to HDD in a readahead window.
>>
>> I suspect that there are practical requirements to use swap on SSD and
>> HDD at the same time.
>
> Hi Ying,
>
> Thanks for the review!
>
> For the first issue "fragmented readahead window", I was planning to
> do an extra check in readahead path to skip readahead entries that are
> on different swap devices, which is not hard to do,

This is a possible solution.

> but this series is growing too long so I thought it will be better
> done later.

You don't need to keep everything in one series.  Just use multiple
series.  Even if they are all swap-related.  They are dealing with
different problem in fact.

> For the second issue, "is there any practical use for multiple swap",
> I think actually there are. For example we are trying to use multi
> layer swap for offloading memory of different hotness on servers. And
> we also tried to implement a mechanism to migrate long sleep swap
> entries from high performance SSD/RAMDISK swap to cheap HDD swap
> device, with more than two layers of swap, which worked except the
> upstream issue, that readahead policy will no longer work as expected.

Thanks for your information.

>> >               page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, =
vmf);
>> >               cached =3D true;
>> >       } else {

--
Best Regards,
Huang, Ying
