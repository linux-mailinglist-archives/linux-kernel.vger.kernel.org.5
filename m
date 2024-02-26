Return-Path: <linux-kernel+bounces-82091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A0867F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90406B316D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D512DD87;
	Mon, 26 Feb 2024 17:41:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96167605A1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969272; cv=none; b=NisDfoQbDvoBQHB23TwZoYyZ0N6W9ELDtqMqoVEVzz4dc/3ROsRbuH5lphm0DYhHJ+X820MKtdBjHa1lg0A9YtY9JngbUqEY1C0RvUtitTjum7pqZhY56W6j81+/5dfy2B4FmChBv1SLOp+Q0hmffGh01gsjQ9a8aAPHnLGkexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969272; c=relaxed/simple;
	bh=dOUW0bwkpdXqCxCp6JFzajwGpBaS9u7CxDWxetlC2TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Az/Ep8fdTknvYNc/WGXfrCkfcTPULS+uryKiOhPxxg8+XOFzWwZlENEYlGJC4zet+NnYEImG/8jgT3X17p93uarwnLUyZNHXZqNatjK2a7JCYlBv1Em4VIwVGmFOKezsRbKQeBTj50O6Sm/wVGwXt2r4LJBDWJNueHcx0noF5UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FEF9DA7;
	Mon, 26 Feb 2024 09:41:48 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95DC3F73F;
	Mon, 26 Feb 2024 09:41:07 -0800 (PST)
Message-ID: <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
Date: Mon, 26 Feb 2024 17:41:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 10:20, David Hildenbrand wrote:
> On 22.02.24 11:19, David Hildenbrand wrote:
>> On 25.10.23 16:45, Ryan Roberts wrote:
>>> As preparation for supporting small-sized THP in the swap-out path,
>>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>>> which, when present, always implies PMD-sized THP, which is the same as
>>> the cluster size.
>>>
>>> The only use of the flag was to determine whether a swap entry refers to
>>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>>> Instead of relying on the flag, we now pass in nr_pages, which
>>> originates from the folio's number of pages. This allows the logic to
>>> work for folios of any order.
>>>
>>> The one snag is that one of the swap_page_trans_huge_swapped() call
>>> sites does not have the folio. But it was only being called there to
>>> avoid bothering to call __try_to_reclaim_swap() in some cases.
>>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>>> call site and believe the new logic should be equivalent.
>>
>> That is the  __try_to_reclaim_swap() -> folio_free_swap() ->
>> folio_swapped() -> swap_page_trans_huge_swapped() call chain I assume.
>>
>> The "difference" is that you will now (1) get another temporary
>> reference on the folio and (2) (try)lock the folio every time you
>> discard a single PTE of a (possibly) large THP.
>>
> 
> Thinking about it, your change will not only affect THP, but any call to
> free_swap_and_cache().
> 
> Likely that's not what we want. :/
> 

Is folio_trylock() really that expensive given the code path is already locking
multiple spinlocks, and I don't think we would expect the folio lock to be very
contended?

I guess filemap_get_folio() could be a bit more expensive, but again, is this
really a deal-breaker?


I'm just trying to refamiliarize myself with this series, but I think I ended up
allocating a cluster per cpu per order. So one potential solution would be to
turn the flag into a size and store it in the cluster info. (In fact I think I
was doing that in an early version of this series - will have to look at why I
got rid of that). Then we could avoid needing to figure out nr_pages from the folio.

