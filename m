Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F7E800965
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378481AbjLALJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378464AbjLALJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:09:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15758193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:09:33 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ShVZD5LMQzMngB;
        Fri,  1 Dec 2023 19:04:36 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 19:09:29 +0800
Message-ID: <9e5c199a-9b4d-4d1b-97d4-dd2b776ac85f@huawei.com>
Date:   Fri, 1 Dec 2023 19:09:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: pagewalk: assert write mmap lock only for walking
 the user page tables
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, <mike.kravetz@oracle.com>,
        <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-2-songmuchun@bytedance.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20231127084645.27017-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/11/27 16:46, Muchun Song wrote:
> The 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
> introduces an assertion to walk_page_range_novma() to make all the users
> of page table walker is safe. However, the race only exists for walking the
> user page tables. And it is ridiculous to hold a particular user mmap write
> lock against the changes of the kernel page tables. So only assert at least
> mmap read lock when walking the kernel page tables. And some users matching
> this case could downgrade to a mmap read lock to relief the contention of
> mmap lock of init_mm, it will be nicer in hugetlb (only holding mmap read
> lock) in the next patch.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/pagewalk.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index b7d7e4fcfad7a..f46c80b18ce4f 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -539,6 +539,11 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
>    * not backed by VMAs. Because 'unusual' entries may be walked this function
>    * will also not lock the PTEs for the pte_entry() callback. This is useful for
>    * walking the kernel pages tables or page tables for firmware.
> + *
> + * Note: Be careful to walk the kernel pages tables, the caller may be need to
> + * take other effective approache (mmap lock may be insufficient) to prevent
> + * the intermediate kernel page tables belonging to the specified address range
> + * from being freed (e.g. memory hot-remove).
>    */
>   int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>   			  unsigned long end, const struct mm_walk_ops *ops,
> @@ -556,7 +561,29 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
>   	if (start >= end || !walk.mm)
>   		return -EINVAL;
>   
> -	mmap_assert_write_locked(walk.mm);
> +	/*
> +	 * 1) For walking the user virtual address space:
> +	 *
> +	 * The mmap lock protects the page walker from changes to the page
> +	 * tables during the walk.  However a read lock is insufficient to
> +	 * protect those areas which don't have a VMA as munmap() detaches
> +	 * the VMAs before downgrading to a read lock and actually tearing
> +	 * down PTEs/page tables. In which case, the mmap write lock should
> +	 * be hold.
> +	 *
> +	 * 2) For walking the kernel virtual address space:
> +	 *
> +	 * The kernel intermediate page tables usually do not be freed, so
> +	 * the mmap map read lock is sufficient. But there are some exceptions.
> +	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
> +	 * to prevent the intermediate kernel pages tables belonging to the
> +	 * specified address range from being freed. The caller should take
> +	 * other actions to prevent this race.
> +	 */
> +	if (mm == &init_mm)
> +		mmap_assert_locked(walk.mm);
> +	else
> +		mmap_assert_write_locked(walk.mm);

Maybe just use process_mm_walk_lock() and set correct page_walk_lock in 
struct mm_walk_ops?

>   
>   	return walk_pgd_range(start, end, &walk);
>   }
