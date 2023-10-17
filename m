Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70EF7CB968
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjJQDse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJQDsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:48:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20D83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 20:48:30 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8fwJ0lvyzvPyY;
        Tue, 17 Oct 2023 11:43:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 11:48:27 +0800
Message-ID: <84cdc2c3-e5e3-469b-b265-8df3e72a8c2f@huawei.com>
Date:   Tue, 17 Oct 2023 11:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/khugepaged: Convert alloc_charge_hpage() to use
 folios
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <shy828301@gmail.com>
References: <20231016200510.7387-1-vishal.moola@gmail.com>
 <20231016200510.7387-5-vishal.moola@gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231016200510.7387-5-vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/17 4:05, Vishal Moola (Oracle) wrote:
> Also convert hpage_collapse_alloc_page() to
> hpage_collapse_alloc_folio().
> 
> This removes 1 call to compound_head() and helps convert khugepaged to
> use folios throughout.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>   mm/khugepaged.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index fa21a53ce0c0..70bba8ddea13 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -886,16 +886,16 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>   }
>   #endif
>   
> -static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node,
> +static bool hpage_collapse_alloc_folio(struct folio **folio, gfp_t gfp, int node,
>   				      nodemask_t *nmask)
>   {
> -	*hpage = __alloc_pages(gfp, HPAGE_PMD_ORDER, node, nmask);
> -	if (unlikely(!*hpage)) {
> +	*folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, nmask);
> +
> +	if (unlikely(!*folio)) {
>   		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>   		return false;
>   	}
>   
> -	folio_prep_large_rmappable((struct folio *)*hpage);
>   	count_vm_event(THP_COLLAPSE_ALLOC);
>   	return true;
>   }
> @@ -1062,15 +1062,16 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>   	int node = hpage_collapse_find_target_node(cc);
>   	struct folio *folio;
>   
> -	if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
> +	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask))
>   		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>   
> -	folio = page_folio(*hpage);
>   	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
>   		folio_put(folio);
>   		*hpage = NULL;
>   		return SCAN_CGROUP_CHARGE_FAIL;
>   	}
> +
> +	*hpage = folio_page(folio, 0);
>   	count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);

count_memcg_folio_events（）and kill count_memcg_page_event?
>   
>   	return SCAN_SUCCEED;
