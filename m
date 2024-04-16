Return-Path: <linux-kernel+bounces-146174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5619B8A61A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79CA1F23BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C551374F5;
	Tue, 16 Apr 2024 03:23:09 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE6219E1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237788; cv=none; b=EV4Mb5U037zq+7+AjFtrI9+nMq612X7on1JV1wSJUW3p7ddwRqf60j4F0YNiZltuvrSOLT2p0il2Ojn0ljVHQlMoOr8UQicuiZoi+NLx441tjz+SUT8xPjtPOpoCAaID7jObOV0siCXnpcezIlXsrlw6O9GyD0paAoDVvaDgPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237788; c=relaxed/simple;
	bh=J7UUoh0gKM33WA+DNqobRnfpSG5tuReJRrFUzeCmW3w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UIsG4mUWSMGnvSjyz+6Q30a4n6YTLVwQdbIWOEMCnjANjYBm3Of1vXUNyqWmTjDnptTIclFf2rTN8ak3p3NLK4hFJDV5w0Pc3J91rYw2YHZhB8OXqPzzZZTNEQ2nPJJIP3ARkApBcqz60xVyyQaZp7aninqMpg8dAm+vJp2xoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VJTn118vnz1RCqc;
	Tue, 16 Apr 2024 11:20:05 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BA721403D1;
	Tue, 16 Apr 2024 11:23:02 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 11:23:01 +0800
Subject: Re: [PATCH v2] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Andrew Morton <akpm@linux-foundation.org>
CC: Sidhartha Kumar <sidhartha.kumar@oracle.com>, <naoya.horiguchi@nec.com>,
	<osalvador@suse.de>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240412025754.1897615-1-linmiaohe@huawei.com>
 <48647e5b-d15b-457b-9879-fb1b6bbaee27@oracle.com>
 <8d186776-f3b1-5d9a-2f94-fa249dee7d5f@huawei.com>
 <20240412162111.10f67ad0f001734464b53ad8@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e18fd131-2a31-48a6-d889-0a03ad1ffd38@huawei.com>
Date: Tue, 16 Apr 2024 11:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240412162111.10f67ad0f001734464b53ad8@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/13 7:21, Andrew Morton wrote:
> On Fri, 12 Apr 2024 16:11:52 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>>> I recently sent a patch[1] to convert dissolve_free_huge_page() to folios which changes the function name and the name referenced in the comment so this will conflict with my patch. It's in mm-unstable now, would you be able to rebase to that in a new version?
>>>
> 
> This patch is a hotfixes, cc:stable one so the mm-unstable material will be
> based on top of this change.
> 
> I've queued this change up as a -fix against v1.  And I've retained
> this changelog addition:
> 
> : This issue won't occur until commit a6b40850c442 ("mm: hugetlb: replace
> : hugetlb_free_vmemmap_enabled with a static_key").  As it introduced
> : rlock(cpu_hotplug_lock) in dissolve_free_huge_page() code path while
> : lock(pcp_batch_high_lock) is already in the __page_handle_poison().
> 
> And I've queued another -fix to reflow that block comment to 80 columns.
> 
> --- a/mm/memory-failure.c~mm-memory-failure-fix-deadlock-when-hugetlb_optimize_vmemmap-is-enabled-v2-fix
> +++ a/mm/memory-failure.c
> @@ -155,14 +155,16 @@ static int __page_handle_poison(struct p
>  	int ret;
>  
>  	/*
> -	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
> -	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
> -	 * when hugetlb vmemmap optimization is enabled. This will break current lock
> -	 * dependency chain and leads to deadlock.
> -	 * Disabling pcp before dissolving the page was a deterministic approach because
> -	 * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
> -	 * expels those pages to the buddy system, but nothing guarantees that those pages
> -	 * do not get back to a PCP queue if we need to refill those.
> +	 * zone_pcp_disable() can't be used here. It will
> +	 * hold pcp_batch_high_lock and dissolve_free_huge_page() might hold
> +	 * cpu_hotplug_lock via static_key_slow_dec() when hugetlb vmemmap
> +	 * optimization is enabled. This will break current lock dependency
> +	 * chain and leads to deadlock.
> +	 * Disabling pcp before dissolving the page was a deterministic
> +	 * approach because we made sure that those pages cannot end up in any
> +	 * PCP list. Draining PCP lists expels those pages to the buddy system,
> +	 * but nothing guarantees that those pages do not get back to a PCP
> +	 * queue if we need to refill those.
>  	 */
>  	ret = dissolve_free_huge_page(page);
>  	if (!ret) {
> _
> 

Many thanks for doing this. :)
.

> .
> 


