Return-Path: <linux-kernel+bounces-81524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4707867710
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216201C297DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28231292C0;
	Mon, 26 Feb 2024 13:46:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0F128839
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955187; cv=none; b=uxLYA8v6neRmpU+bjqEYBuPakbIeT3GZgootpynSvhoECWcWZKYrQp74mDBy6zIuCapEA1J8BNZsq+/3qAnkdK2shXUQGc98vXJBbwkRWBFMbIGou/BX15WQ0ZQ7/6nBAUxAABOKlFoRE+sWbNYURwOmAXnkei7TLp2Uiw94M1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955187; c=relaxed/simple;
	bh=x0tKBMBvabDged48OlDNnAqjAxWwHlmzi+vREigK+sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyKcc0XraiVke5+hdTwhFkMyCJftpmvOXiXCYDkMAmGRW/aayzIa/q0WPjcpF4zrhplsQD/3qcuWG4JcyLNMNQOggRGrgwgZ+E3cyD9kryfaR2z27gJNbgm/Gn1jISnLdGyZ9KienfpNwDP+FOeM2cqEseMg80XEX1Z9u8L1kPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F2EDA7;
	Mon, 26 Feb 2024 05:47:03 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833013F762;
	Mon, 26 Feb 2024 05:46:22 -0800 (PST)
Message-ID: <71fa4302-2df6-4e55-a5a8-7609476c41d4@arm.com>
Date: Mon, 26 Feb 2024 13:46:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] madvise:madvise_cold_or_pageout_pte_range(): allow split
 while folio_estimated_sharers = 0
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>,
 Vishal Moola <vishal.moola@gmail.com>, Yang Shi <shy828301@gmail.com>
References: <20240221085036.105621-1-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240221085036.105621-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 08:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> The purpose is stopping splitting large folios whose mapcount are 2 or
> above. Folios whose estimated_shares = 0 should be still perfect and
> even better candidates than estimated_shares = 1.
> 
> Consider a pte-mapped large folio with 16 subpages, if we unmap 1-15,
> the current code will split folios and reclaim them while madvise goes
> on this folio; but if we unmap subpage 0, we will keep this folio and
> break. This is weird.
> 
> For pmd-mapped large folios, we can still use "= 1" as the condition
> as anyway we have the entire map for it. So this patch doesn't change
> the condition for pmd-mapped large folios.
> This also explains why we had been using "= 1" for both pmd-mapped and
> pte-mapped large folios before commit 07e8c82b5eff ("madvise: convert
> madvise_cold_or_pageout_pte_range() to use folios"), because in the
> past, we used the mapcount of the specific subpage, since the subpage
> had pte present, its mapcount wouldn't be 0.
> 
> The problem can be quite easily reproduced by writing a small program,
> unmapping the first subpage of a pte-mapped large folio vs. unmapping
> anyone other than the first subpage.
> 
> Fixes: 2f406263e3e9 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
> Cc: Yin Fengwei <fengwei.yin@intel.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..abde3edb04f0 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (folio_test_large(folio)) {
>  			int err;
>  
> -			if (folio_estimated_sharers(folio) != 1)
> +			if (folio_estimated_sharers(folio) > 1)
>  				break;
>  			if (pageout_anon_only_filter && !folio_test_anon(folio))
>  				break;

I wonder if we should change all the instances:

folio_estimated_sharers() != 1   ->   folio_estimated_sharers() > 1
folio_estimated_sharers() == 1   ->   folio_estimated_sharers() <= 1

It shouldn't cause a problem for the pmd case, and there are definitely other
cases where it will help. e.g. madvise_free_pte_range().

Regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>



