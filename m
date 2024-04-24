Return-Path: <linux-kernel+bounces-156360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95E8B01C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C21C227E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680D157467;
	Wed, 24 Apr 2024 06:28:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B85156C61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940097; cv=none; b=YVYp+oJgGe3O1H+AN4J6fNrIjJaKxnBNsi/aFTrNeG2a1KpZzuKVRxW6HQZ4ZYIJuurUDBThKFXYkUbS0/ljDYDJVyTvWVPSybzavwU6UnMewjKxKYPYuGM7G8bcigecfHBgZw8JGekZsMIaHRpN3LdMW90VFL9cvws4vmMMKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940097; c=relaxed/simple;
	bh=824j8fGf5A1bphwArUG2NJ6SLq0h4wH5cc5+3SnwvbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AP+XOWkqpl1WFvQ1MEh0yHoi9bZKl35m9MSUjlaxIrZgppD4k6ghuhEU0SidmGjbww6enUBMaG5cXpZQCzjgAF9GjHPRaPdKsT+UYI4AJ7ZXx9IL/y/5Q15+RoJXwtZqtxo7DFUaIvV6hzQVflBhXDOBZEb9tlN1266D3mZkqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VPTY36XwMz1HBhS;
	Wed, 24 Apr 2024 14:27:03 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D9811A016F;
	Wed, 24 Apr 2024 14:28:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 14:28:04 +0800
Message-ID: <c51d8d04-e108-4a0c-9f0b-7c47b619a76c@huawei.com>
Date: Wed, 24 Apr 2024 14:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] mm: shmem: add an 'order' parameter for
 shmem_alloc_hugefolio()
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <21cnbao@gmail.com>,
	<ryan.roberts@arm.com>, <ying.huang@intel.com>, <shy828301@gmail.com>,
	<ziy@nvidia.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <2014bf7370d78bc1f5600731af5bf8f569e5868b.1713755580.git.baolin.wang@linux.alibaba.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <2014bf7370d78bc1f5600731af5bf8f569e5868b.1713755580.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/4/22 15:02, Baolin Wang wrote:
> Add a new parameter to specify the huge page order for shmem_alloc_hugefolio(),
> as a preparation to supoort mTHP.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fa2a0ed97507..893c88efc45f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1604,14 +1604,14 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>   }
>   
>   static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
> -		struct shmem_inode_info *info, pgoff_t index)
> +		struct shmem_inode_info *info, pgoff_t index, int order)
>   {
>   	struct mempolicy *mpol;
>   	pgoff_t ilx;
>   	struct page *page;
>   
> -	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
> -	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
> +	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
> +	page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
>   	mpol_cond_put(mpol);
>   
>   	return page_rmappable_folio(page);
> @@ -1639,13 +1639,14 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   	struct folio *folio;
>   	long pages;
> -	int error;
> +	int error, order;
>   
>   	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>   		huge = false;
>   
>   	if (huge) {
>   		pages = HPAGE_PMD_NR;
> +		order = HPAGE_PMD_ORDER;
>   		index = round_down(index, HPAGE_PMD_NR);
>   
>   		/*
> @@ -1660,7 +1661,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>   				index + HPAGE_PMD_NR - 1, XA_PRESENT))
>   			return ERR_PTR(-E2BIG);
>   
> -		folio = shmem_alloc_hugefolio(gfp, info, index);
> +		folio = shmem_alloc_hugefolio(gfp, info, index, order);

Avoid order variable, we can directly use HPAGE_PMD_NR here.

>   		if (!folio)
>   			count_vm_event(THP_FILE_FALLBACK);
>   	} else {

