Return-Path: <linux-kernel+bounces-108901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A460881198
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9DD1F237C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768093FB93;
	Wed, 20 Mar 2024 12:22:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6C3D0C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937346; cv=none; b=k4WON9L0YCb2/06MCDJnTmbYMGbHlH09ivpQna3nO6SBLfqDb/qM8FMQsvEqw5hFcplcyNSFqiwxuzQdL32yJtTO5lX5QywiWnfvbDx62arqiUI752n7lVc8It8vuSJnbIa3cnlv/9Qi6xqXZRg+lg5D1eTOtKdDXglM3q2Qvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937346; c=relaxed/simple;
	bh=UW282k+J2e56WLYn+PCzmsbRNcSPwX1syGOLIVuUhX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TK89ZDFGaY9PRC8dviZN0WXM4HWBO0wTAv+cB9PwAF3p8ZQnXPhwokqrBfxeMBhRGHyjXB1qd1MioqX8eP9tFEk5rTQsHc3B8pFAJfjG1t0odh0ZwZV8OcP8XRIrZ3dhG3zlTxGwYdrDoJCdcyBxtpiweg2qx9soUeCrYvEQ/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EC771007;
	Wed, 20 Mar 2024 05:22:57 -0700 (PDT)
Received: from [10.57.72.78] (unknown [10.57.72.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248603F762;
	Wed, 20 Mar 2024 05:22:20 -0700 (PDT)
Message-ID: <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com>
Date: Wed, 20 Mar 2024 12:22:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-5-ryan.roberts@arm.com>
 <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Huang, Ying,


On 12/03/2024 07:51, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Multi-size THP enables performance improvements by allocating large,
>> pte-mapped folios for anonymous memory. However I've observed that on an
>> arm64 system running a parallel workload (e.g. kernel compilation)
>> across many cores, under high memory pressure, the speed regresses. This
>> is due to bottlenecking on the increased number of TLBIs added due to
>> all the extra folio splitting when the large folios are swapped out.
>>
>> Therefore, solve this regression by adding support for swapping out mTHP
>> without needing to split the folio, just like is already done for
>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>> and when the swap backing store is a non-rotating block device. These
>> are the same constraints as for the existing PMD-sized THP swap-out
>> support.
>>
>> Note that no attempt is made to swap-in (m)THP here - this is still done
>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>> prerequisite for swapping-in mTHP.
>>
>> The main change here is to improve the swap entry allocator so that it
>> can allocate any power-of-2 number of contiguous entries between [1, (1
>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>> order and allocating sequentially from it until the cluster is full.
>> This ensures that we don't need to search the map and we get no
>> fragmentation due to alignment padding for different orders in the
>> cluster. If there is no current cluster for a given order, we attempt to
>> allocate a free cluster from the list. If there are no free clusters, we
>> fail the allocation and the caller can fall back to splitting the folio
>> and allocates individual entries (as per existing PMD-sized THP
>> fallback).
>>
>> The per-order current clusters are maintained per-cpu using the existing
>> infrastructure. This is done to avoid interleving pages from different
>> tasks, which would prevent IO being batched. This is already done for
>> the order-0 allocations so we follow the same pattern.
>>
>> As is done for order-0 per-cpu clusters, the scanner now can steal
>> order-0 entries from any per-cpu-per-order reserved cluster. This
>> ensures that when the swap file is getting full, space doesn't get tied
>> up in the per-cpu reserves.
>>
>> This change only modifies swap to be able to accept any order mTHP. It
>> doesn't change the callers to elide doing the actual split. That will be
>> done in separate changes.

[...]

>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  	}
>>  
>>  	if (si->swap_map[offset]) {
>> +		VM_WARN_ON(order > 0);
>>  		unlock_cluster(ci);
>>  		if (!n_ret)
>>  			goto scan;
>>  		else
>>  			goto done;
>>  	}
>> -	WRITE_ONCE(si->swap_map[offset], usage);
>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>> +	memset(si->swap_map + offset, usage, nr_pages);
> 
> Add barrier() here corresponds to original WRITE_ONCE()?
> unlock_cluster(ci) may be NOP for some swap devices.

Looking at this a bit more closely, I'm not sure this is needed. Even if there
is no cluster, the swap_info is still locked, so unlocking that will act as a
barrier. There are a number of other callsites that memset(si->swap_map) without
an explicit barrier and with the swap_info locked.

Looking at the original commit that added the WRITE_ONCE() it was worried about
a race with reading swap_map in _swap_info_get(). But that site is now annotated
with a data_race(), which will suppress the warning. And I don't believe there
are any places that read swap_map locklessly and depend upon observing ordering
between it and other state? So I think the si unlock is sufficient?

I'm not planning to add barrier() here. Let me know if you disagree.

Thanks,
Ryan

> 
>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>  	unlock_cluster(ci);



