Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194B97EFD3C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjKRCnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRCnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:43:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FCD5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:43:04 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SXHzZ3RqtzsR5v;
        Sat, 18 Nov 2023 10:39:38 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:43:01 +0800
Message-ID: <153d0e8e-c860-4221-bcb0-71b46f17e2d5@huawei.com>
Date:   Sat, 18 Nov 2023 10:43:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mm: memory: use folio_prealloc() in wp_page_copy()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>
References: <20231118023232.1409103-1-wangkefeng.wang@huawei.com>
 <20231118023232.1409103-6-wangkefeng.wang@huawei.com>
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231118023232.1409103-6-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/18 10:32, Kefeng Wang wrote:
> Use folio_prealloc() helper to simplify code a bit.
> 
Forget to add RB of Vishal，adding it

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 868a2fc54549..98d9c7094cab 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3112,6 +3112,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   	int page_copied = 0;
>   	struct mmu_notifier_range range;
>   	vm_fault_t ret;
> +	bool pfn_is_zero;
>   
>   	delayacct_wpcopy_start();
>   
> @@ -3121,16 +3122,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   	if (unlikely(ret))
>   		goto out;
>   
> -	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
> -		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
> -		if (!new_folio)
> -			goto oom;
> -	} else {
> +	pfn_is_zero = is_zero_pfn(pte_pfn(vmf->orig_pte));
> +	new_folio = folio_prealloc(mm, vma, vmf->address, pfn_is_zero);
> +	if (!new_folio)
> +		goto oom;
> +
> +	if (!pfn_is_zero) {
>   		int err;
> -		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> -				vmf->address, false);
> -		if (!new_folio)
> -			goto oom;
>   
>   		err = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
>   		if (err) {
> @@ -3151,10 +3149,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   		kmsan_copy_page_meta(&new_folio->page, vmf->page);
>   	}
>   
> -	if (mem_cgroup_charge(new_folio, mm, GFP_KERNEL))
> -		goto oom_free_new;
> -	folio_throttle_swaprate(new_folio, GFP_KERNEL);
> -
>   	__folio_mark_uptodate(new_folio);
>   
>   	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> @@ -3253,8 +3247,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   
>   	delayacct_wpcopy_end();
>   	return 0;
> -oom_free_new:
> -	folio_put(new_folio);
>   oom:
>   	ret = VM_FAULT_OOM;
>   out:
