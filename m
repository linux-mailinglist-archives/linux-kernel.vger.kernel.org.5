Return-Path: <linux-kernel+bounces-102695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6387B615
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B226F1F23868
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F33D75;
	Thu, 14 Mar 2024 01:14:04 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA981113
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378844; cv=none; b=W0Z+xHeVXFqpWVuv3YAJx3Aw78yOEjbes82XzrUb+ZHyXjfRu7WA1fhmE2ryHVnTMNUuPo85po9pYxq2mcXhi3UBP1VDV000ii8oYWdBdWQK/78dADYZaa82nMnnmYIp6DgMUezWm4uiUCXKNEOCt67iU1jK3bKsSuXonib80bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378844; c=relaxed/simple;
	bh=LshyCLnQc4nYjRb6U1WvL5e69Y3jTXpgZS30dZ45Cik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rHqbAAD+uBg1a6SMVzGgFprtWYMb0fznWK2DuDFlPGuFzYpvdgm2lJG78FV0tyL6dEyo2DuZONteggqVjQ04MsZ68mg/4KuHHGWOpYadDFefxJXBhk+Wk5X8tliT2+hGAR0sgnBSwxTjMxHe4CwjnJveXRpsDS+IYqzgOcE3CxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tw8Wm63xGz1vwbL;
	Thu, 14 Mar 2024 09:13:08 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 58AC61A0172;
	Thu, 14 Mar 2024 09:13:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 09:13:51 +0800
Message-ID: <e59c7b3a-3763-4ee0-96d9-6018e1ab0904@huawei.com>
Date: Thu, 14 Mar 2024 09:13:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/show_mem: simplify ifdef on si_meminfo_node()
To: Luis Chamberlain <mcgrof@kernel.org>, <akpm@linux-foundation.org>,
	<jhubbard@nvidia.com>, <vbabka@suse.cz>, <mgorman@suse.de>,
	<linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <dave@stgolabs.net>,
	<p.raghav@samsung.com>, <da.gomez@samsung.com>
References: <20240314005436.2962962-1-mcgrof@kernel.org>
 <20240314005436.2962962-2-mcgrof@kernel.org>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240314005436.2962962-2-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/14 8:54, Luis Chamberlain wrote:
> There is an ifdef where the same exact values are used at
> the end, so remove the else and keep the same values for both
> conditions.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   mm/show_mem.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 8dcfafbd283c..529d2f9b6410 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -108,12 +108,9 @@ void si_meminfo_node(struct sysinfo *val, int nid)
>   			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
>   		}
>   	}
> +#endif
>   	val->totalhigh = managed_highpages;
>   	val->freehigh = free_highpages;
> -#else
> -	val->totalhigh = managed_highpages;
> -	val->freehigh = free_highpages;
> -#endif
>   	val->mem_unit = PAGE_SIZE;
>   }
>   #endif

More cleanup?
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 8dcfafbd283c..44dd6d6e9488 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -94,26 +94,21 @@ void si_meminfo_node(struct sysinfo *val, int nid)
         unsigned long free_highpages = 0;
         pg_data_t *pgdat = NODE_DATA(nid);

-       for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-               managed_pages += 
zone_managed_pages(&pgdat->node_zones[zone_type]);
-       val->totalram = managed_pages;
-       val->sharedram = node_page_state(pgdat, NR_SHMEM);
-       val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
-#ifdef CONFIG_HIGHMEM
         for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
                 struct zone *zone = &pgdat->node_zones[zone_type];

+               managed_pages += zone_managed_pages(zone);
                 if (is_highmem(zone)) {
                         managed_highpages += zone_managed_pages(zone);
                         free_highpages += zone_page_state(zone, 
NR_FREE_PAGES);
                 }
         }
+
+       val->totalram = managed_pages;
+       val->sharedram = node_page_state(pgdat, NR_SHMEM);
+       val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
         val->totalhigh = managed_highpages;
         val->freehigh = free_highpages;
-#else
-       val->totalhigh = managed_highpages;
-       val->freehigh = free_highpages;
-#endif
         val->mem_unit = PAGE_SIZE;
  }

