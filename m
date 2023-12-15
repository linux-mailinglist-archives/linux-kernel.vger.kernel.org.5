Return-Path: <linux-kernel+bounces-477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D88141BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0536A2852C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560D8471;
	Fri, 15 Dec 2023 06:17:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B819746B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SrzWk3jPJzZdTJ;
	Fri, 15 Dec 2023 14:16:50 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EFBC180068;
	Fri, 15 Dec 2023 14:16:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 14:16:54 +0800
Message-ID: <f7950e7c-12b8-44b4-bfa9-fb2cb16944c0@huawei.com>
Date: Fri, 15 Dec 2023 14:16:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: HVO: introduce helper function to update and
 flush pgtable
Content-Language: en-US
To: Nanyong Sun <sunnanyong@huawei.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <anshuman.khandual@arm.com>
CC: <willy@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-2-sunnanyong@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231214073912.1938330-2-sunnanyong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2023/12/14 15:39, Nanyong Sun wrote:
> Add pmd/pte update and tlb flush helper function to update page
> table. This refactoring patch is designed to facilitate each
> architecture to implement its own special logic in preparation
> for the arm64 architecture to follow the necessary break-before-make
> sequence when updating page tables.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   mm/hugetlb_vmemmap.c | 55 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 87818ee7f01d..49e8b351def3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -45,6 +45,37 @@ struct vmemmap_remap_walk {
>   	unsigned long		flags;
>   };
>   
> +#ifndef vmemmap_update_pmd
> +static inline void vmemmap_update_pmd(unsigned long start,
> +				      pmd_t *pmd, pte_t *pgtable)

pgtable ->  ptep

> +{
> +	pmd_populate_kernel(&init_mm, pmd, pgtable);
> +}
> +#endif
> +
> +#ifndef vmemmap_update_pte
> +static inline void vmemmap_update_pte(unsigned long addr,
> +				      pte_t *pte, pte_t entry)

pte   -> ptep
entry -> pte

> +{
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +#endif


