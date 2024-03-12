Return-Path: <linux-kernel+bounces-100262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD28879437
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA03281E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E501543AAB;
	Tue, 12 Mar 2024 12:34:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C9811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246878; cv=none; b=FASWBru8JyGP7XN5WqLLUAue4oT42lGebqs13HvJn89qCe4AEtkPWJgmcQqAIxfRUZviy9jAOOcP3ELLJ9RPF2xPN5wphy/25GzANaQ9ggn45e7/xGTAMl6Bpo7PJmhl91HSfhv7W7dM7BI7+ETix/S6SWdq0cwmvJxpVWVVs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246878; c=relaxed/simple;
	bh=00ALwGCpmxxMsJj+o8wyLH2RHkjByrRU74ql53w1Eug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGNQ15SzjGQHGPKlO4GJDhmVoUoIkwunTUMlFk5dXW2ZfjdFU5iirOEq0XOjxSqRyei+Gc4aIVo7cVImmtdmqZpFCvKlONRItahnT/hJ0XUMLVhihx74KdCwthZo9cyIR+YBY8/Ba6B9pwkvI0mAN9dJLkB2Y8F5ANZJcf9I1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB4D1007;
	Tue, 12 Mar 2024 05:35:12 -0700 (PDT)
Received: from [10.1.27.122] (XHFQ2J9959.cambridge.arm.com [10.1.27.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 696043F73F;
	Tue, 12 Mar 2024 05:34:29 -0700 (PDT)
Message-ID: <e73c12ff-5234-44d5-a2b3-99cdc61a9c37@arm.com>
Date: Tue, 12 Mar 2024 12:34:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] mm: swap: make should_try_to_free_swap()
 support large-folio
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Chuanhua Han
 <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-4-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240304081348.197341-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 08:13, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> should_try_to_free_swap() works with an assumption that swap-in is always done
> at normal page granularity, aka, folio_nr_pages = 1. To support large folio
> swap-in, this patch removes the assumption.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index abd4f33d62c9..e0d34d705e07 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3837,7 +3837,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
>  	 * reference only in case it's likely that we'll be the exlusive user.
>  	 */
>  	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
> -		folio_ref_count(folio) == 2;
> +		folio_ref_count(folio) == (1 + folio_nr_pages(folio));

I don't think this is correct; one reference has just been added to the folio in
do_swap_page(), either by getting from swapcache (swap_cache_get_folio()) or by
allocating. If it came from the swapcache, it could be a large folio, because we
swapped out a large folio and never removed it from swapcache. But in that case,
others may have partially mapped it, so the refcount could legitimately equal
the number of pages while still not being exclusively mapped.

I'm guessing this logic is trying to estimate when we are likely exclusive so
that we remove from swapcache (release ref) and can then reuse rather than CoW
the folio? The main CoW path currently CoWs page-by-page even for large folios,
and with Barry's recent patch, even the last page gets copied. So not sure what
this change is really trying to achieve?


>  }
>  
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)


