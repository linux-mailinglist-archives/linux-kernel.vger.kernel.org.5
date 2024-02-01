Return-Path: <linux-kernel+bounces-47458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E20844E38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AA51C2721C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E55139F;
	Thu,  1 Feb 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i963c31J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C01FC8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748888; cv=none; b=tW2hrX2bOuYTxCuOa17J2gX46fKim/n80HQ2jnJh+2Nl9M1kZCXKQnkcXo7fQlhoMiEc6Y0N6MnswFGmMkBE5HvKYs4E0XV9pmpUayZfrGrPo6MeSEoPtUsyqiO1znqD4Wm25ptluX/Kmwa0fJQB7Y2JcrfQ8bezwJ/rPHkksTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748888; c=relaxed/simple;
	bh=qujnpASse8+r8ZzJznge6AEXFi6ewoeRbuwBmjdvRgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tBRm9sCNgNNLlI8x5h0bOhQfV5/ZFshSJTAntQiGuvhsP9YaNNl/EvqcCY6lDVehaonIik6cqnsXk5bt7GqaYKZvD4+OuzaQBch3B295dBzjw+t2bBDRUWH8J5sDFi/B6vOeHF5jdEXGZerKbDcWpP5HR0Y/0nuVOgFpQOH02do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i963c31J; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706748887; x=1738284887;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qujnpASse8+r8ZzJznge6AEXFi6ewoeRbuwBmjdvRgs=;
  b=i963c31JKDOsy8Jyo/yBYjeyygNMupxtpRmVONsNUDzUo4vL5M63mYq2
   xogcgTSJbXTjRUsP4I4mk3hBfyeqPaKttF4w5UJKQ/BfDFypLl6EMHQqH
   KMdTpPD9AuSuHbaAqOuP/IWHyEtpHSYbddnuUyniQjlKXG9liRjOTDvKE
   LmVifYDfaHiqGmgQeC7qWA3pqnA8A+ryIl8KfSrhye8qJgkWOOgaWxvjN
   DzJQT6mpXkcyYLbWTS5f2RGgPMf97Wm7BBpG0gcVl9yobcDgrb1h3IJYT
   vdHjS68bteSC5ONt+9mX91/83qNNM2b8KS2Fgea6S5vt+Z2ZdwbcunUVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17157873"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="17157873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="932031458"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="932031458"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:54:42 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>,  Minchan Kim <minchan@kernel.org>,
  linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Hugh
 Dickins <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  Matthew Wilcox <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,
  Yosry Ahmed <yosryahmed@google.com>,  David Hildenbrand
 <david@redhat.com>,  linux-kernel@vger.kernel.org,  Yu Zhao
 <yuzhao@google.com>
Subject: Re: Whether is the race for SWP_SYNCHRONOUS_IO possible? (was Re:
 [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem)
In-Reply-To: <CAF8kJuN6G578RWQ5R6eW=FQWg3mphywgnusQYCRMJA4TzhR4jg@mail.gmail.com>
	(Chris Li's message of "Wed, 31 Jan 2024 15:45:18 -0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-7-ryncsn@gmail.com>
	<87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7DhjeeCehzj5hiO=v+X0Jg5mEpKim3k8abJA20TN63SHA@mail.gmail.com>
	<CAF8kJuN6G578RWQ5R6eW=FQWg3mphywgnusQYCRMJA4TzhR4jg@mail.gmail.com>
Date: Thu, 01 Feb 2024 08:52:46 +0800
Message-ID: <87plxhf1k1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> On Tue, Jan 30, 2024 at 7:58=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
>>
>> Hi Ying,
>>
>> On Wed, Jan 31, 2024 at 10:53=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
>> >
>> > Hi, Minchan,
>> >
>> > When I review the patchset from Kairui, I checked the code to skip swap
>> > cache in do_swap_page() for swap device with SWP_SYNCHRONOUS_IO.  Is t=
he
>> > following race possible?  Where a page is swapped out to a swap device
>> > with SWP_SYNCHRONOUS_IO and the swap count is 1.  Then 2 threads of the
>> > process runs on CPU0 and CPU1 as below.  CPU0 is running do_swap_page(=
).
>>
>> Chris raised a similar issue about the shmem path, and I was worrying
>> about the same issue in previous discussions about do_swap_page:
>> https://lore.kernel.org/linux-mm/CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7=
m4WRb_UKPghg@mail.gmail.com/
>
> Ha thanks for remembering that.
>
>>
>> """
>> In do_swap_page path, multiple process could swapin the page at the
>> same time (a mapped once page can still be shared by sub threads),
>> they could get different folios. The later pte lock and pte_same check
>> is not enough, because while one process is not holding the pte lock,
>> another process could read-in, swap_free the entry, then swap-out the
>> page again, using same entry, an ABA problem. The race is not likely
>> to happen in reality but in theory possible.
>> """
>>
>> >
>> > CPU0                            CPU1
>> > ----                            ----
>> > swap_cache_get_folio()
>> > check sync io and swap count
>> > alloc folio
>> > swap_readpage()
>> > folio_lock_or_retry()
>> >                                 swap in the swap entry
>> >                                 write page
>> >                                 swap out to same swap entry
>> > pte_offset_map_lock()
>> > check pte_same()
>> > swap_free()   <-- new content lost!
>> > set_pte_at()  <-- stale page!
>> > folio_unlock()
>> > pte_unmap_unlock()
>>
>> Thank you very much for highlighting this!
>>
>> My concern previously is the same as yours (swapping out using the
>> same entry is like an ABA issue, where pte_same failed to detect the
>> page table change), later when working on V3, I mistakenly thought
>> that's impossible as entry should be pinned until swap_free on CPU0,
>> and I'm wrong. CPU1 can also just call swap_free, then swap count is
>> dropped to 0 and it can just swap out using the same entry. Now I
>> think my patch 6/7 is also affected by this potential race. Seems
>> nothing can stop it from doing this.
>>
>> Actually I was trying to make a reproducer locally, due to swap slot
>> cache, swap allocation algorithm, and the short race window, this is
>> very unlikely to happen though.
>
> You can put some sleep in some of the CPU0 where expect the other race
> to happen to manual help triggering it. Yes, it sounds hard to trigger
> in real life due to reclaim swap out.
>
>>
>> How about we just increase the swap count temporarily in the direct
>> swap in path (after alloc folio), then drop the count after pte_same
>> (or shmem_add_to_page_cache in shmem path)? That seems enough to
>> prevent the entry reuse issue.
>
> Sounds like a good solution.

Yes.  It seems that this can solve the race.

--
Best Regards,
Huang, Ying

