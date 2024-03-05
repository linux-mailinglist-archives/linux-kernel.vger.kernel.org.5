Return-Path: <linux-kernel+bounces-91958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D37D871906
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0238F284803
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C94F211;
	Tue,  5 Mar 2024 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpoQKETn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25241EF1A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629613; cv=none; b=aEjWdrUBq1N9rmH8ZQ8o4DWXDLUYMbI2nQ5kUOHO9ZcF68ZIpzGCosgzDY9gV9qpn+4jmjZY4BnYtdugMubM7OkKvG/glsQSEvsJcACzSxeVk4B+vIYlc7Ju703LRZtFCEMki12XshvOsmtIZo8NOwrKC9m2KsmAVeqs70zZHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629613; c=relaxed/simple;
	bh=SVDc3/QVD4qQIeEwISkNQ6ehRKSAArCRXoPluhdHuS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLDQ2owYMe3GM9rcGQef8J/lYhd0ndSZ1c1dkA9VJmPzHSjmOfqbIfkpzhCsVgclvGBo9VF85U4QSfqQnheGDuiNdt5CLbZJDafxtANh5Suf62ONyzni3HpI2OMjxPAXnXxovpN524NqytNK3EBsiIElWGlXUGKiZ5Ll8ienuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpoQKETn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709629612; x=1741165612;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=SVDc3/QVD4qQIeEwISkNQ6ehRKSAArCRXoPluhdHuS8=;
  b=UpoQKETnD8sqLravJK8wfLvGG6b6/LEjV7BA7BAW7McwilIAAEbsfENl
   PHMacgIkmkD41qAQO5Jl02YML9BN6icmvHfb5lpXqVge//bn0cGXo+S1Q
   dRaLj3BlafGfpVY5bvn5GCMuIaWtZ0xCXE3eTskbCAyN7eyvsn6owoUIQ
   4HhJJrGBh+iuq+10D5EYx4lPqVxRmQ1Y5QwykeVvJ0ns91aVC3jShVjGE
   o3bGkQ82/7McZR+9J4xFzMKB/B9Nqm2Fu/iavJAaJgybTP6zlpjrF8Ifx
   2+tyFeTmqjazNKzJqjIU48OkgPHBbdQC6IyoO6R8beB+/LeLF1hZZxTBG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4030334"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4030334"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 01:06:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="32471355"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 01:06:47 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,  david@redhat.com,
  ryan.roberts@arm.com,  chrisl@kernel.org,  yuzhao@google.com,
  hanchuanhua@oppo.com,  linux-kernel@vger.kernel.org,
  willy@infradead.org,  xiang@kernel.org,  mhocko@suse.com,
  shy828301@gmail.com,  wangkefeng.wang@huawei.com,  Barry Song
 <v-songbaohua@oppo.com>,  Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
In-Reply-To: <CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com>
	(Barry Song's message of "Tue, 5 Mar 2024 21:56:02 +1300")
References: <20240304103757.235352-1-21cnbao@gmail.com>
	<878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com>
Date: Tue, 05 Mar 2024 17:04:53 +0800
Message-ID: <87msrd82x6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Tue, Mar 5, 2024 at 8:30=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > page_vma_mapped_walk() within try_to_unmap_one() races with other
>> > PTEs modification such as break-before-make, while iterating PTEs
>>
>> Sorry, I don't know what is "break-before-make", can you elaborate?
>> IIUC, ptep_modify_prot_start()/ptep_modify_prot_commit() can clear PTE
>> temporarily, which may cause race with page_vma_mapped_walk().  Is that
>> the issue that you try to fix?
>
> we are writing pte to zero(break) before writing a new value(make).

OK.  Is break and make is commonly used terminology in kernel?  If not,
it's better to explain a little (e.g., ptep_get_and_clear() / modify /
set_pte_at()).

> while
> this behavior is within PTL in another thread,  page_vma_mapped_walk()
> of try_to_unmap_one thread won't take PTL till it meets a present PTE.

IIUC, !pte_none() should be enough?

> for example, if another threads are modifying nr_pages PTEs under PTL,
> but we don't hold PTL, we might skip one or two PTEs at the beginning of
> a large folio.
> For a large folio, after try_to_unmap_one(), we may result in PTE0 and PT=
E1
> untouched but PTE2~nr_pages-1 are set to swap entries.
>
> by holding PTL from PTE0 for large folios, we won't get these intermediate
> values. At the moment we get PTL, other threads have done.

Got it!  Thanks!

--
Best Regards,
Huang, Ying

>>
>> --
>> Best Regards,
>> Huang, Ying
>>
>> > of a large folio, it will only begin to acquire PTL after it gets
>> > a valid(present) PTE. break-before-make intermediately sets PTEs
>> > to pte_none. Thus, a large folio's PTEs might be partially skipped
>> > in try_to_unmap_one().
>> > For example, for an anon folio, after try_to_unmap_one(), we may
>> > have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
>> > So folio will be still mapped, the folio fails to be reclaimed.
>> > What=E2=80=99s even more worrying is, its PTEs are no longer in a unif=
ied
>> > state. This might lead to accident folio_split() afterwards. And
>> > since a part of PTEs are now swap entries, accessing them will
>> > incur page fault - do_swap_page.
>> > It creates both anxiety and more expense. While we can't avoid
>> > userspace's unmap to break up unified PTEs such as CONT-PTE for
>> > a large folio, we can indeed keep away from kernel's breaking up
>> > them due to its code design.
>> > This patch is holding PTL from PTE0, thus, the folio will either
>> > be entirely reclaimed or entirely kept. On the other hand, this
>> > approach doesn't increase PTL contention. Even w/o the patch,
>> > page_vma_mapped_walk() will always get PTL after it sometimes
>> > skips one or two PTEs because intermediate break-before-makes
>> > are short, according to test. Of course, even w/o this patch,
>> > the vast majority of try_to_unmap_one still can get PTL from
>> > PTE0. This patch makes the number 100%.
>> > The other option is that we can give up in try_to_unmap_one
>> > once we find PTE0 is not the first entry we get PTL, we call
>> > page_vma_mapped_walk_done() to end the iteration at this case.
>> > This will keep the unified PTEs while the folio isn't reclaimed.
>> > The result is quite similar with small folios with one PTE -
>> > either entirely reclaimed or entirely kept.
>> > Reclaiming large folios by holding PTL from PTE0 seems a better
>> > option comparing to giving up after detecting PTL begins from
>> > non-PTE0.
>> >
>> > Cc: Hugh Dickins <hughd@google.com>
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > ---
>> >  mm/vmscan.c | 11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index 0b888a2afa58..e4722fbbcd0c 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
>> >
>> >                       if (folio_test_pmd_mappable(folio))
>> >                               flags |=3D TTU_SPLIT_HUGE_PMD;
>> > +                     /*
>> > +                      * if page table lock is not held from the first=
 PTE of
>> > +                      * a large folio, some PTEs might be skipped bec=
ause of
>> > +                      * races with break-before-make, for example, PT=
Es can
>> > +                      * be pte_none intermediately, thus one or more =
PTEs
>> > +                      * might be skipped in try_to_unmap_one, we migh=
t result
>> > +                      * in a large folio is partially mapped and part=
ially
>> > +                      * unmapped after try_to_unmap
>> > +                      */
>> > +                     if (folio_test_large(folio))
>> > +                             flags |=3D TTU_SYNC;
>> >
>> >                       try_to_unmap(folio, flags);
>> >                       if (folio_mapped(folio)) {
>
> Thanks
> Barry

