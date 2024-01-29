Return-Path: <linux-kernel+bounces-42406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFC48400E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902E91C22943
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBF55C05;
	Mon, 29 Jan 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2ENxUiO"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B455783
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519226; cv=none; b=FyawpP89LsAbSi7xLcT6YlMgwzFB0drsBmqkryD3TXT048gEVZT7pjtq81fXmJR6F6aq0d5L4i5BNk9UkYwFEz4tyMXkucBGBAfRt2GSFbTAKkHqf1R6UHVmvRKIgJ6VE9LO7dfArJVtvoDKtYi2lUwokV6Z/ia/1MlJMQTip6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519226; c=relaxed/simple;
	bh=tN7xWY/aoRePb/06SXJNtwJUb0WC049eAoR7aYoGkmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N0t7Er6wJcReQVkRnPDzTYtxx5gvdNCBRgvE9kRZXcPvt0LzH3OlaIZz9VgCAWsKyWMoZJ9Z6JL2X+UhTuFZEVx0wKIkDfBjJ473Xp+huOZPbxArg5Kq0RCxuYACY0aVQRHmLXRnDJZHdE8nlMVvGGPZNoeius44iM3Tb2HOZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2ENxUiO; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706519224; x=1738055224;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tN7xWY/aoRePb/06SXJNtwJUb0WC049eAoR7aYoGkmo=;
  b=P2ENxUiOhGB2wfFCD6Hxt4Jaq30CL0WC1V314If2l5mUyxCw9nDd0LXV
   M87Ng2GysRunNat/hGtZvyy7XDBWCMHzT131wJm+z2CjfnZBUJk6nNCVv
   BdPHmvwXxq6tKE8u20IjHkeiyK14DczBJfZU81IEcKSriNdcsfKYLLEiZ
   3n5zgQdlXm3XDuvbRqBVJXB3GG34a+F4iFdhfDNAgegG4XND763yDUw53
   563cvjW7QT2FaC2LA/2BSeLiAysYhDDACozwBGLRJfyWjPtPXSXvEcsv0
   A8+yGeV0kTP571JqqjC0lM/iHlF7nwgj7FP92A0ihLDva71DdK5WmsWES
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434060466"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="434060466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787771793"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="787771793"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:06:58 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com,  akpm@linux-foundation.org,  david@redhat.com,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  mhocko@suse.com,
  shy828301@gmail.com,  wangkefeng.wang@huawei.com,  willy@infradead.org,
  xiang@kernel.org,  yuzhao@google.com,  surenb@google.com,
  steven.price@arm.com
Subject: Re: [PATCH RFC 0/6] mm: support large folios swap-in
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com> (Barry Song's message
	of "Fri, 19 Jan 2024 00:10:30 +1300")
References: <20231025144546.577640-1-ryan.roberts@arm.com>
	<20240118111036.72641-1-21cnbao@gmail.com>
Date: Mon, 29 Jan 2024 17:05:01 +0800
Message-ID: <8734ugjyrm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> On an embedded system like Android, more than half of anon memory is actually
> in swap devices such as zRAM. For example, while an app is switched to back-
> ground, its most memory might be swapped-out.
>
> Now we have mTHP features, unfortunately, if we don't support large folios
> swap-in, once those large folios are swapped-out, we immediately lose the 
> performance gain we can get through large folios and hardware optimization
> such as CONT-PTE.
>
> In theory, we don't need to rely on Ryan's swap out patchset[1]. That is to say,
> before swap-out, if some memory were normal pages, but when swapping in, we
> can also swap-in them as large folios. But this might require I/O happen at
> some random places in swap devices. So we limit the large folios swap-in to
> those areas which were large folios before swapping-out, aka, swaps are also
> contiguous in hardware. On the other hand, in OPPO's product, we've deployed
> anon large folios on millions of phones[2]. we enhanced zsmalloc and zRAM to
> compress and decompress large folios as a whole, which help improve compression
> ratio and decrease CPU consumption significantly. In zsmalloc and zRAM we can
> save large objects whose original size are 64KiB for example. So it is also a
> better choice for us to only swap-in large folios for those compressed large
> objects as a large folio can be decompressed all together.

Another possibility is to combine large folios swap-in with VMA based
swap-in readahead.  If we will swap-in readahead several pages based on
VMA, we can swap-in a large folio instead.

I think that it is similar as allocating large file folios for file
readahead (TBH, I haven't check file large folios allocation code).

--
Best Regards,
Huang, Ying

> Note I am moving my previous "arm64: mm: swap: support THP_SWAP on hardware
> with MTE" to this series as it might help review.
>
> [1] [PATCH v3 0/4] Swap-out small-sized THP without splitting
> https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.roberts@arm.com/
> [2] OnePlusOSS / android_kernel_oneplus_sm8550 
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/tree/oneplus/sm8550_u_14.0.0_oneplus11
>
> Barry Song (2):
>   arm64: mm: swap: support THP_SWAP on hardware with MTE
>   mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
>
> Chuanhua Han (4):
>   mm: swap: introduce swap_nr_free() for batched swap_free()
>   mm: swap: make should_try_to_free_swap() support large-folio
>   mm: support large folios swapin as a whole
>   mm: madvise: don't split mTHP for MADV_PAGEOUT
>
>  arch/arm64/include/asm/pgtable.h |  21 ++----
>  arch/arm64/mm/mteswap.c          |  42 ++++++++++++
>  include/asm-generic/tlb.h        |  10 +++
>  include/linux/huge_mm.h          |  12 ----
>  include/linux/pgtable.h          |  62 ++++++++++++++++-
>  include/linux/swap.h             |   6 ++
>  mm/madvise.c                     |  48 ++++++++++++++
>  mm/memory.c                      | 110 ++++++++++++++++++++++++++-----
>  mm/page_io.c                     |   2 +-
>  mm/rmap.c                        |   5 +-
>  mm/swap_slots.c                  |   2 +-
>  mm/swapfile.c                    |  29 ++++++++
>  12 files changed, 301 insertions(+), 48 deletions(-)

