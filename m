Return-Path: <linux-kernel+bounces-83326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D98692AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E028F3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7F13DBBF;
	Tue, 27 Feb 2024 13:37:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D93713AA2F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041063; cv=none; b=LcylXLuOFIoxQxL3vwldPlWnx8zmmlvlwlASy3cVliag95uVvKdVIYUjA9EqywTTwbwWqDegss9CGmPGmjlWKW6hLoy9Mt9mcB2Ps1CLlJLR8F1HYfSib7iB5SZjx3Vyyjtb9I1OMm7RdNPqunxzSe1QZWQt8m0g6CHTYTTSKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041063; c=relaxed/simple;
	bh=VbywaFmN5QFS1W+PB43Dluw9OIE+JY09v7rj137vPrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GevXJw2ElhCfoIj0Pe18JLpbpGjLkBwDwc3GCiJ/trMkHCjWBKTd3ucdOaqyrIdI3WflKH6j6fx1JvpMHsVptaDTsX3cY8KJMO7jay62Xrcg2h7OyNhs2vSCdPWuNc2O0DvHWN2/K71kRsIAWZLuEwP/fupuJubzVS4MNPZMT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23959DA7;
	Tue, 27 Feb 2024 05:38:19 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BC343F73F;
	Tue, 27 Feb 2024 05:37:38 -0800 (PST)
Message-ID: <6a55e785-73dd-4951-bad8-2670810a13b6@arm.com>
Date: Tue, 27 Feb 2024 13:37:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com,
 chrisl@kernel.org, surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240205095155.7151-1-v-songbaohua@oppo.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240205095155.7151-1-v-songbaohua@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 09:51, Barry Song wrote:
> +Chris, Suren and Chuanhua
> 
> Hi Ryan,
> 
>> +	/*
>> +	 * __scan_swap_map_try_ssd_cluster() may drop si->lock during discard,
>> +	 * so indicate that we are scanning to synchronise with swapoff.
>> +	 */
>> +	si->flags += SWP_SCANNING;
>> +	ret = __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order);
>> +	si->flags -= SWP_SCANNING;
> 
> nobody is using this scan_base afterwards. it seems a bit weird to
> pass a pointer.
> 
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>  					if (!can_split_folio(folio, NULL))
>>  						goto activate_locked;
>>  					/*
>> -					 * Split folios without a PMD map right
>> -					 * away. Chances are some or all of the
>> -					 * tail pages can be freed without IO.
>> +					 * Split PMD-mappable folios without a
>> +					 * PMD map right away. Chances are some
>> +					 * or all of the tail pages can be freed
>> +					 * without IO.
>>  					 */
>> -					if (!folio_entire_mapcount(folio) &&
>> +					if (folio_test_pmd_mappable(folio) &&
>> +					    !folio_entire_mapcount(folio) &&
>>  					    split_folio_to_list(folio,
>>  								folio_list))
>>  						goto activate_locked;
>> --
> 
> Chuanhua and I ran this patchset for a couple of days and found a race
> between reclamation and split_folio. this might cause applications get
> wrong data 0 while swapping-in.
> 
> in case one thread(T1) is reclaiming a large folio by some means, still
> another thread is calling madvise MADV_PGOUT(T2). and at the same time,
> we have two threads T3 and T4 to swap-in in parallel. T1 doesn't split
> and T2 does split as below,

Hi Barry,

Do you have a test case you can share that provokes this problem? And is this a
separate problem to the race you solved with TTU_SYNC or is this solving the
same problem?

Thanks,
Ryan


