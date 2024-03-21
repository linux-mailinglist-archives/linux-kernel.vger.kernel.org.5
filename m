Return-Path: <linux-kernel+bounces-109653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF90881C00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304FD1C215F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FC02B2F2;
	Thu, 21 Mar 2024 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We/BiDAW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9953CB65F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996096; cv=none; b=XZGfBtBOoENlV9r5UyuxX0RA+oeqRF7wQjRk3bwHuWVfiAKuuLe6IHdQIXzT8XL5CJ/XmeKlJuG8UaMgJcgEg80DKw4jluynS2HQmGlFQ4ld3JHivyr97Oxhn0S2KjxM4jjf+gzEXfyKrd19DwzVyxouCMpjlEa+T5Q2KciuSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996096; c=relaxed/simple;
	bh=QEydSPBqt/QCL6B+mc4yp2WGTbDT5hEdcQk6+KWkD4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VokLbFNp04chWuABdHJY+wa44IVRmwVZjkml+Nj8fm7tRQDdSM2qhGUevX/ROxsm++K/5NwfhXQTtkJtB+Y7gieBk8oobJYoUxWLxDogCcy2k+xDRIGL9sP7+Q0/JxLpAZ+/aTLSyMsnhfkbHpbtWbktxz2IPnHD0gi2YeUQwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We/BiDAW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710996095; x=1742532095;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QEydSPBqt/QCL6B+mc4yp2WGTbDT5hEdcQk6+KWkD4Y=;
  b=We/BiDAWE4WUa3Pn2MzkX9gBtczDaieaNOq2lm9JgN+AgLw4edP5Mwdt
   dkZV2qu9Z0gxCd1dK6OpEvp6KWVce3N1lPqJClMUlhgfSeduCF+5Oky9I
   7s5zJqMb6NZwCuN/Xm3GkE+iEP4WwG+EJNvPnoPjbAH0kjglExCNT8AB6
   PZzR+VyL0QA9/N5ciXmr1H1h8yUcxYXzywQPl15K/TEQSv948S7V5qncJ
   j41H+0T3ilMt/c8cqUmeDKAL+OotvVHwYDTkf6GsHCgXNEO5s/gdNLpDC
   n/dlz3PoIhBWyJRmW+K/TCq2h0GfGnc6LM1s7kMoNsCLtrf/56nTCi9Lw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5902329"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5902329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 21:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="18850240"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 21:41:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
In-Reply-To: <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com> (Ryan Roberts's
	message of "Wed, 20 Mar 2024 12:22:18 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-5-ryan.roberts@arm.com>
	<87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
Date: Thu, 21 Mar 2024 12:39:36 +0800
Message-ID: <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> Hi Huang, Ying,
>
>
> On 12/03/2024 07:51, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Multi-size THP enables performance improvements by allocating large,
>>> pte-mapped folios for anonymous memory. However I've observed that on an
>>> arm64 system running a parallel workload (e.g. kernel compilation)
>>> across many cores, under high memory pressure, the speed regresses. This
>>> is due to bottlenecking on the increased number of TLBIs added due to
>>> all the extra folio splitting when the large folios are swapped out.
>>>
>>> Therefore, solve this regression by adding support for swapping out mTHP
>>> without needing to split the folio, just like is already done for
>>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>>> and when the swap backing store is a non-rotating block device. These
>>> are the same constraints as for the existing PMD-sized THP swap-out
>>> support.
>>>
>>> Note that no attempt is made to swap-in (m)THP here - this is still done
>>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>>> prerequisite for swapping-in mTHP.
>>>
>>> The main change here is to improve the swap entry allocator so that it
>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>> order and allocating sequentially from it until the cluster is full.
>>> This ensures that we don't need to search the map and we get no
>>> fragmentation due to alignment padding for different orders in the
>>> cluster. If there is no current cluster for a given order, we attempt to
>>> allocate a free cluster from the list. If there are no free clusters, we
>>> fail the allocation and the caller can fall back to splitting the folio
>>> and allocates individual entries (as per existing PMD-sized THP
>>> fallback).
>>>
>>> The per-order current clusters are maintained per-cpu using the existing
>>> infrastructure. This is done to avoid interleving pages from different
>>> tasks, which would prevent IO being batched. This is already done for
>>> the order-0 allocations so we follow the same pattern.
>>>
>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>> ensures that when the swap file is getting full, space doesn't get tied
>>> up in the per-cpu reserves.
>>>
>>> This change only modifies swap to be able to accept any order mTHP. It
>>> doesn't change the callers to elide doing the actual split. That will be
>>> done in separate changes.
>
> [...]
>
>>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	}
>>>  
>>>  	if (si->swap_map[offset]) {
>>> +		VM_WARN_ON(order > 0);
>>>  		unlock_cluster(ci);
>>>  		if (!n_ret)
>>>  			goto scan;
>>>  		else
>>>  			goto done;
>>>  	}
>>> -	WRITE_ONCE(si->swap_map[offset], usage);
>>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>>> +	memset(si->swap_map + offset, usage, nr_pages);
>> 
>> Add barrier() here corresponds to original WRITE_ONCE()?
>> unlock_cluster(ci) may be NOP for some swap devices.
>
> Looking at this a bit more closely, I'm not sure this is needed. Even if there
> is no cluster, the swap_info is still locked, so unlocking that will act as a
> barrier. There are a number of other callsites that memset(si->swap_map) without
> an explicit barrier and with the swap_info locked.
>
> Looking at the original commit that added the WRITE_ONCE() it was worried about
> a race with reading swap_map in _swap_info_get(). But that site is now annotated
> with a data_race(), which will suppress the warning. And I don't believe there
> are any places that read swap_map locklessly and depend upon observing ordering
> between it and other state? So I think the si unlock is sufficient?
>
> I'm not planning to add barrier() here. Let me know if you disagree.

swap_map[] may be read locklessly in swap_offset_available_and_locked()
in parallel.  IIUC, WRITE_ONCE() here is to make the writing take effect
as early as possible there.

>
>> 
>>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>>  	unlock_cluster(ci);

--
Best Regards,
Huang, Ying

