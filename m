Return-Path: <linux-kernel+bounces-118402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D788BA55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75732C207D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB12DDA4;
	Tue, 26 Mar 2024 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yQBoTNL5"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F112B17A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433985; cv=none; b=rsm9WClohzZBSgig+pEFPj2bo8nL2WNARpEyBoykkX1T5lT9NHAbZc4CZOlmdJnLq0tCNqG+4GhHNlBcyutDtvvvxyalp8LY0+4qjIAny12bNBAvT7zsr/QFAD++ziAdszuqtxBW4n5Wt5mHTVXzVZR1EFpgN0W8oKeHe42FjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433985; c=relaxed/simple;
	bh=qRUlAzvOdIXPnIHhIUsia4aWno9aP5ZggsD5RpZsqU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBWkUIXxO61+MBaSAFHfdpsLSMEQfalse8wX4A4FPTWz9ilpTGhdQT6gLU0gcjHSgLIDzap78SxhSvFvM8BbEYDEKSbRWOoQuCSCbsWTgoWb7Hn7chRPIH1rNDHp5ePd/XnRic7RnAn/GAIxGekNurFIyCtarG6x0QUrAT+XTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yQBoTNL5; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711433975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VvNMGVN1rFiN9r1DX16BIWk3fnbEG8dCI8TISDnEaXg=;
	b=yQBoTNL555cujF1nQPCsUXrCBzk2IdOju0hyhB/UkOHugxq+QI+kIf94ASlgfcg2YW75/YqXArAb4a/hajp9qZpVyanQXDys0FrSYtO5sJ9jrzpN7tmFwuNi+hPQtB/AOrYZEO9dHEZXP08HElsO1ckK3NV23qaf4QoSgE/mjgs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3K-ROS_1711433973;
Received: from 30.97.56.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3K-ROS_1711433973)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 14:19:34 +0800
Message-ID: <1ecde325-097b-49e9-9f1f-d93edbc8e1f1@linux.alibaba.com>
Date: Tue, 26 Mar 2024 14:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/migrate: split source folio if it is on deferred
 split list
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Yin, Fengwei" <fengwei.yin@intel.com>,
 SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org
References: <20240322193304.522496-1-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240322193304.522496-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/23 03:33, Zi Yan wrote:
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
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/migrate.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ab9856f5931b..6bd9319624a3 100644
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
> +				if (try_split_folio(folio, from) == 0) {

IMO, we should move the split folios into the 'split_folios' list 
instead of the 'from' list, otherwise there might be unhandled folios 
remaining in the from list.

> +					stats->nr_thp_split += is_thp;
> +					stats->nr_split++;
> +					continue;
> +				}
> +			}
> +
>   			/*
>   			 * Large folio migration might be unsupported or
>   			 * the allocation might be failed so we should retry
> 
> base-commit: 08a487ab26d541a3bd0adaee144f684b724d233b

