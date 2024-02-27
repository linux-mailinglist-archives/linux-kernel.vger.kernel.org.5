Return-Path: <linux-kernel+bounces-83231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38386908B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD831C22E35
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489313B289;
	Tue, 27 Feb 2024 12:28:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994A13A865
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036906; cv=none; b=t/4gd+EMRCNOo7EmgdJ4qqkZyXVH8g0PQ6VFimJAS7hVoS5Q3g4iIfmElwxbXYqBhhnAN7AbOQZ7GmsynQt88AlK15Qd3Hv9bDa6niN1AV1obPgbZ/KiHWQsQob0ClcAg+m7AcOnjO9tfz9oHgEhIDrHIQEwWLnpxR4KV90syPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036906; c=relaxed/simple;
	bh=pNGYRWeSsIs/vvvMllDfm8nU1L0apuuC4docxZUztyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmMbi6pR41kqW3LdaHtW5lH6dwFo+huUI99BYwfbZHJUDQDHl/vqTzf5C71f18vBT7M98gWe2J+MTHH/79GaHqBttdhvBVAx/24TqsFJOAwwoT3Vcx1X+G6DlhO0VqYFNjvyp1SfKqsXHNBogfVHiDy97U/ig+ofiDs1r8f38ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE29EDA7;
	Tue, 27 Feb 2024 04:29:02 -0800 (PST)
Received: from [10.1.30.188] (XHFQ2J9959.cambridge.arm.com [10.1.30.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C993F73F;
	Tue, 27 Feb 2024 04:28:22 -0800 (PST)
Message-ID: <6caed7a8-6a76-4957-9c24-f59b8259b526@arm.com>
Date: Tue, 27 Feb 2024 12:28:20 +0000
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

I can't claim to fully understand the problem yet (thanks for all the details -
I'll keep reading it and looking at the code until I do), but I guess this
problem should exist today for PMD-mappable folios? We already skip splitting
those folios if they are pmd-mapped. Or does the problem only apply to
pte-mapped folios?


