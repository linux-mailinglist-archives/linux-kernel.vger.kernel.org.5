Return-Path: <linux-kernel+bounces-119287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE188C6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FD9307D67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCC13C80C;
	Tue, 26 Mar 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RAcQN9+Y"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726313C67C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466240; cv=none; b=FB5Qr+QDx2pYXBGiiwskSpriUFYbsRcEyNOc6P/NRRpLZKV414FBnck1mkCv+Imd/aynoy9ONORVevNQ4DVUIgTNzU8OpWql6gSl4AsRbiHaG14HOyXNGaPqaNYTbmTyAMz7uJcsTdLx6wBueu/BmELA/ZaX5lcb0lASP7BliSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466240; c=relaxed/simple;
	bh=LcrFDC4HybOuKHTUi2WYoCJx+v1pfVTAhYpKJU0nqqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAGWR8x/MNkphOW/hKJvQ9fohn+sZul8jy9q5vlVDidWoJKvpJHq4129nY+M2ktvZ0nY76Zw8cgAJqFe4eQh36Np0LK3C0L1iQYr9WNB6FD6c3r9CanSlK9nvmxZXeasnXM91OAKXuT/0QWsaxKTXGzxrxuXPZd8dCfQcPYcWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RAcQN9+Y; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711466235; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LJQmTQE2BThbacVB/qSQ5Zu1gkc4s6kLgcT1epLF09k=;
	b=RAcQN9+YwgY9Vm8ZJWsp7LM9ixpQNQf5q0VmBJtMdfWRSDKPRH/SNihRKbldWAMEKwqViARm5neySplgczr0CD/KBgKfb+psZoC3qWMbrMy45DVimoGI23wljRTVjxSNFEiiOSWFj3QjUwDiGr8bcrSB8Og97LYjBk6NRPBaoTc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3Lj8Lz_1711466233;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3Lj8Lz_1711466233)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 23:17:14 +0800
Message-ID: <af3eeb12-a850-4f24-a0e6-ac58a0cb4fef@linux.alibaba.com>
Date: Tue, 26 Mar 2024 23:17:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/migrate: split source folio if it is on deferred
 split list
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Yin, Fengwei" <fengwei.yin@intel.com>,
 SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
References: <20240326150031.569387-1-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240326150031.569387-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/26 23:00, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> If the source folio is on deferred split list, it is likely some subpages
> are not used. Split it before migration to avoid migrating unused subpages.
> 
> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> did not check if a THP is on deferred split list before migration, thus,
> the destination THP is never put on deferred split list even if the source
> THP might be. The opportunity of reclaiming free pages in a partially
> mapped THP during deferred list scanning is lost, but no other harmful
> consequence is present[1].
> 
>  From v5:
> 1. Fixed an error in migrate_misplaced_folio() reported by Baolin Wang[3].
> 
>  From v4:
> 1. Simplify _deferred_list check without locking and do not count as
>     migration failures. (per Matthew Wilcox)
> 
>  From v3:
> 1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
>     compilation error (per SeongJae Park).
> 
>  From v2:
> 1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].
> 
>  From v1:
> 1. Used dst to get correct deferred split list after migration
>     (per Ryan Roberts).
> 
> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/
> [3]: https://lore.kernel.org/linux-mm/df9a644c-a007-46ac-98e3-61d4014fcfff@linux.alibaba.com/
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

LGTM. Feel free to add:
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/migrate.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 1dbe5bd927de..a31aa75d223d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1652,6 +1652,29 @@ static int migrate_pages_batch(struct list_head *from,
>   
>   			cond_resched();
>   
> +			/*
> +			 * The rare folio on the deferred split list should
> +			 * be split now. It should not count as a failure.
> +			 * Only check it without removing it from the list.
> +			 * Since the folio can be on deferred_split_scan()
> +			 * local list and removing it can cause the local list
> +			 * corruption. Folio split process below can handle it
> +			 * with the help of folio_ref_freeze().
> +			 *
> +			 * nr_pages > 2 is needed to avoid checking order-1
> +			 * page cache folios. They exist, in contrast to
> +			 * non-existent order-1 anonymous folios, and do not
> +			 * use _deferred_list.
> +			 */
> +			if (nr_pages > 2 &&
> +			   !list_empty(&folio->_deferred_list)) {
> +				if (try_split_folio(folio, split_folios) == 0) {
> +					stats->nr_thp_split += is_thp;
> +					stats->nr_split++;
> +					continue;
> +				}
> +			}
> +
>   			/*
>   			 * Large folio migration might be unsupported or
>   			 * the allocation might be failed so we should retry

