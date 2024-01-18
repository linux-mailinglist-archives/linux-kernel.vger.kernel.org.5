Return-Path: <linux-kernel+bounces-30192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B6831B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12956289332
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2E28DB6;
	Thu, 18 Jan 2024 14:22:43 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC7128DAF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587762; cv=none; b=bc94smK81UN+KkmsUPOP/DbxrIl4VEFxVsPQgl5AYoMfbI49xzqShGE5DV0ChsfPlFZdz1AMK5gGXOqx2MVA5IRtsQAu2f+6GLotCVho17kcj98fgMVLzIUPjhlfUjtZENVYeREfOfjOTwg+T36cBGyCeKapTcXl6m+jrA3eDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587762; c=relaxed/simple;
	bh=RaAR4iKXhImCOq8X/xcEqLZUrDrSsgzaUKbhMu1eOg0=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy; b=o+1QrMn0uTQOay4x1dFKfkE415yHNMFlQK4OF9GXE6dXhDaxIAPXO5MOBXXFqoHGfKzoRBRHXbAyjcioELzIiQA1AWQ7ODEA56QSKmncPxATSrMMpGmjXuxub8gJeAsbeNDsYl0r+5uVZg7boOclsv1kpsrg8Tp5ArgCtRJOfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TG4gc74J3z1xmF8;
	Thu, 18 Jan 2024 22:21:48 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 220821A016B;
	Thu, 18 Jan 2024 22:22:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 22:22:34 +0800
Message-ID: <f11526d6-463a-4e1a-979e-a93de1a24617@huawei.com>
Date: Thu, 18 Jan 2024 22:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] hugetlb: parallelize 1G hugetlb initialization
Content-Language: en-US
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<ligang.bdlg@bytedance.com>
References: <20240118123911.88833-1-gang.li@linux.dev>
 <20240118123911.88833-8-gang.li@linux.dev>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240118123911.88833-8-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/18 20:39, Gang Li wrote:
> Optimizing the initialization speed of 1G huge pages through
> parallelization.
> 
> 1G hugetlbs are allocated from bootmem, a process that is already
> very fast and does not currently require optimization. Therefore,
> we focus on parallelizing only the initialization phase in
> `gather_bootmem_prealloc`.
> 
> Here are some test results:
>          test          no patch(ms)   patched(ms)   saved
>   ------------------- -------------- ------------- --------
>    256c2t(4 node) 1G           4745          2024   57.34%
>    128c1t(2 node) 1G           3358          1712   49.02%
>        12t        1G          77000         18300   76.23%
> 
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> ---
>   include/linux/hugetlb.h |  2 +-
>   mm/hugetlb.c            | 42 +++++++++++++++++++++++++++++++++--------
>   2 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c1ee640d87b1..77b30a8c6076 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -178,7 +178,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
>   
>   extern int sysctl_hugetlb_shm_group;
> -extern struct list_head huge_boot_pages;
> +extern struct list_head huge_boot_pages[MAX_NUMNODES];

Hi, please update arch/powerpc/mm/hugetlbpage.c too, since it
was used in ppc.

>   
>   /* arch callbacks */
>   
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9b348ba418f5..2f4b77630ada 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -69,7 +69,7 @@ static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
>   #endif
>   static unsigned long hugetlb_cma_size __initdata;
>   
> -__initdata LIST_HEAD(huge_boot_pages);
> +__initdata struct list_head huge_boot_pages[MAX_NUMNODES];
>   
>   /* for command line parsing */
>   static struct hstate * __initdata parsed_hstate;
> @@ -3301,7 +3301,7 @@ int alloc_bootmem_huge_page(struct hstate *h, int nid)
>   int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>   {
>   	struct huge_bootmem_page *m = NULL; /* initialize for clang */
> -	int nr_nodes, node;
> +	int nr_nodes, node = nid;
>   
>   	/* do node specific alloc */
>   	if (nid != NUMA_NO_NODE) {
> @@ -3339,7 +3339,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>   		huge_page_size(h) - PAGE_SIZE);
>   	/* Put them into a private list first because mem_map is not up yet */
>   	INIT_LIST_HEAD(&m->list);
> -	list_add(&m->list, &huge_boot_pages);
> +	list_add(&m->list, &huge_boot_pages[node]);
>   	m->hstate = h;
>   	return 1;
>   }
> @@ -3390,8 +3390,6 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
>   	/* Send list for bulk vmemmap optimization processing */
>   	hugetlb_vmemmap_optimize_folios(h, folio_list);
>   
> -	/* Add all new pool pages to free lists in one lock cycle */
> -	spin_lock_irqsave(&hugetlb_lock, flags);
>   	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>   		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>   			/*
> @@ -3404,23 +3402,27 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
>   					HUGETLB_VMEMMAP_RESERVE_PAGES,
>   					pages_per_huge_page(h));
>   		}
> +		/* Subdivide locks to achieve better parallel performance */
> +		spin_lock_irqsave(&hugetlb_lock, flags);
>   		__prep_account_new_huge_page(h, folio_nid(folio));
>   		enqueue_hugetlb_folio(h, folio);
> +		spin_unlock_irqrestore(&hugetlb_lock, flags);
>   	}
> -	spin_unlock_irqrestore(&hugetlb_lock, flags);
>   }
>   
>   /*
>    * Put bootmem huge pages into the standard lists after mem_map is up.
>    * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
>    */
> -static void __init gather_bootmem_prealloc(void)
> +static void __init __gather_bootmem_prealloc(unsigned long start, unsigned long end, void *arg)
> +
>   {
> +	int nid = start;
>   	LIST_HEAD(folio_list);
>   	struct huge_bootmem_page *m;
>   	struct hstate *h = NULL, *prev_h = NULL;
>   
> -	list_for_each_entry(m, &huge_boot_pages, list) {
> +	list_for_each_entry(m, &huge_boot_pages[nid], list) {
>   		struct page *page = virt_to_page(m);
>   		struct folio *folio = (void *)page;
>   
> @@ -3453,6 +3455,22 @@ static void __init gather_bootmem_prealloc(void)
>   	prep_and_add_bootmem_folios(h, &folio_list);
>   }
>   
> +static void __init gather_bootmem_prealloc(void)
> +{
> +	struct padata_mt_job job = {
> +		.thread_fn	= __gather_bootmem_prealloc,
> +		.fn_arg		= NULL,
> +		.start		= 0,
> +		.size		= num_node_state(N_MEMORY),
> +		.align		= 1,
> +		.min_chunk	= 1,
> +		.max_threads	= num_node_state(N_MEMORY),
> +		.numa_aware	= true,
> +	};
> +
> +	padata_do_multithreaded(&job);
> +}
> +
>   static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>   {
>   	unsigned long i;
> @@ -3602,6 +3620,14 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   		return;
>   	}
>   
> +	/* hugetlb_hstate_alloc_pages will be called many times, init huge_boot_pages once*/
> +	if (huge_boot_pages[0].next == NULL) {
> +		int i = 0;
> +
> +		for (i = 0; i < MAX_NUMNODES; i++)
> +			INIT_LIST_HEAD(&huge_boot_pages[i]);
> +	}
> +
>   	/* do node specific alloc */
>   	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
>   		return;

