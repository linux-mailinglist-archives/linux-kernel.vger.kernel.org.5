Return-Path: <linux-kernel+bounces-19153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D48268DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433211C21A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C08C02;
	Mon,  8 Jan 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxEAxt3W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DAE578
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704699979; x=1736235979;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=PZxQ8Ps+P7mZ0Hr0oqTsFUwxlBWxzQlbFso4pftin1o=;
  b=bxEAxt3WL4w9REKuZKvJ/I7senPjn4R+kJKA3LMOfuIttjyEMyDXiODC
   pY6GB5vjrzRCKTprHkf3mdkk21JJU5DwLg/CnC5Ed4q79SlEKO7S4HcTV
   R9NEIMD1HqKNlSfTKPolJ2ESLWIZ1z2ZF0HdClI7tzQieDmzyztXGQcfY
   pB5OnEs8LwyXa8g+A3hntrc1DIZekwZnCw7M4fZDU85S/tHqZ3ukbMxgU
   8YawFuDXatDvO28aTJ3l6aF75AsBo8HtDRDo7yfYRh37uM8trF4GpDLmy
   Bojqf4tLdJ+tnXA1tTXWxciNwT+auYLjkAvCtFouOo7bOvKy3SXF6FGbj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="5170477"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="5170477"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="900294546"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="900294546"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:46:14 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] mm/swap: always account swapped in page into
 current memcg
In-Reply-To: <CAMgjq7B7iShnLaiT-0MBGEMdVS65bupx_NshjM0ssLmhJm0CFQ@mail.gmail.com>
	(Kairui Song's message of "Fri, 5 Jan 2024 15:33:08 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-5-ryncsn@gmail.com>
	<878r54b6ae.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7B7iShnLaiT-0MBGEMdVS65bupx_NshjM0ssLmhJm0CFQ@mail.gmail.com>
Date: Mon, 08 Jan 2024 15:44:17 +0800
Message-ID: <87edes9smm.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=94 15:16=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Currently, mem_cgroup_swapin_charge_folio is always called with
>> > mm argument as NULL, except in swapin_direct.
>> >
>> > swapin_direct is used when swapin should skip readahead and
>> > swapcache (SWP_SYNCHRONOUS_IO). Other caller paths of
>> > mem_cgroup_swapin_charge_folio are for swapin that should
>> > not skip readahead and cache.
>> >
>> > This could cause swapin charging to behave differently depending
>> > on swap device. This currently didn't happen because the only call
>> > path of swapin_direct is the direct anon page fault path, where mm
>> > equals to current->mm, but will no longer be true if swapin_direct
>> > is shared and have other callers (eg, swapoff).
>> >
>> > So make swapin_direct also passes NULL for mm, no feature change.
>> >
>> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > ---
>> >  mm/swap_state.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/swap_state.c b/mm/swap_state.c
>> > index 6130de8d5226..d39c5369da21 100644
>> > --- a/mm/swap_state.c
>> > +++ b/mm/swap_state.c
>> > @@ -881,7 +881,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp=
_t gfp_mask,
>> >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>> >                               vma, vmf->address, false);
>> >       if (folio) {
>> > -             if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
>> > +             if (mem_cgroup_swapin_charge_folio(folio, NULL,
>> >                                                  GFP_KERNEL, entry)) {
>> >                       folio_put(folio);
>> >                       return NULL;
>>
>> I think that why not provide "mm" when it's available?  For
>> swapin_direct() called by do_swap_page(), mm can be provided.  While,
>> for swapin_direct() called by shmem swapin, mm will be NULL.  We can
>> even provide "mm" for __read_swap_cache_async() for VMA based swapin and
>> for the fault address for cluster swapin.
>
> Hi, Ying.
>
> Thanks for the comment.
>
> Without modifying too much code, providing mm here will change swapin
> charge behaviour on swapoff, we discussed it previously:
> https://lkml.org/lkml/2023/11/19/320

It's better to use "lore" for kernel email link, for example,

https://lore.kernel.org/lkml/20231119194740.94101-24-ryncsn@gmail.com/

This is more readable than the above link.

> If we want to avoid the behavior change, we have to extend all direct
> and indirect callers of mem_cgroup_swapin_charge_folio to accept a
> standalone mm argument (including swapin_direct, swap_vma_readahead,
> swap_cluster_readahead, __read_swap_cache_async, swapin_entry_mpol,
> read_swap_cache_async, and some other path may need more audit), and
> sort things our case by case. I'm not sure if that's a good idea...
>
> Simply dropping it here seems the easiest way to avoid such change.

OK.  Didn't realize that they are related directly.  It appears that we
always pass NULL as mm to mem_cgroup_swapin_charge_folio().  If so,
please just remove the parameter.

--
Best Regards,
Huang, Ying

