Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E804678DF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbjH3TSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbjH3JqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:46:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82B1A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:46:00 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RbK9c1SJJzVkMY;
        Wed, 30 Aug 2023 17:43:32 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 17:45:58 +0800
Message-ID: <646b619b-470a-40eb-bee9-85c7bd4c8a54@huawei.com>
Date:   Wed, 30 Aug 2023 17:45:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] mm: migrate: use a folio in
 migrate_misplaced_page()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>
CC:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        <hughd@google.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-5-wangkefeng.wang@huawei.com>
 <855536BE-766C-49B2-B358-6C0548760929@nvidia.com>
 <875y4y65b8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZO1TgSCevv5JJEz0@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZO1TgSCevv5JJEz0@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/8/29 10:10, Matthew Wilcox wrote:
> On Tue, Aug 29, 2023 at 08:49:31AM +0800, Huang, Ying wrote:
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> On 21 Aug 2023, at 7:56, Kefeng Wang wrote:
>>>
>>>> Use a folio in migrate_misplaced_page() to save compound_head() calls.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>   mm/migrate.c | 23 ++++++++++++-----------
>>>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> LGTM. And a comment below. Reveiwed-by: Zi Yan <ziy@nvidia.com>
>>>
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 281eafdf8e63..fc728f9a383f 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2521,17 +2521,18 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>>>   			   int node)
>>>>   {
>>>>   	pg_data_t *pgdat = NODE_DATA(node);
>>>> +	struct folio *folio = page_folio(page);
>>>>   	int isolated;
>>>>   	int nr_remaining;
>>>>   	unsigned int nr_succeeded;
>>>>   	LIST_HEAD(migratepages);
>>>> -	int nr_pages = thp_nr_pages(page);
>>>> +	int nr_pages = folio_nr_pages(folio);
>>>>
>>>>   	/*
>>>>   	 * Don't migrate file pages that are mapped in multiple processes
>>>>   	 * with execute permissions as they are probably shared libraries.
>>>>   	 */
>>>> -	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
>>>> +	if (page_mapcount(page) != 1 && folio_is_file_lru(folio) &&
>>>
>>> page_mapcount() is not converted, since folio_mapcount() is not equivalent
>>> to page_mapcount(). It can be converted and this function can be converted
>>> to migrate_misplaced_folio() once we have something like folio_num_sharers().
>>
>> It seems that we can use folio_estimated_sharers() here.
> 
> So, funny thing, page_mapcount() was always wrong here.  We have two
> callers, do_huge_pmd_numa_page() and do_numa_page().  do_numa_page()
> has a check for PageCompound() (and /* TODO: handle PTE-mapped THP */).
> do_huge_pmd_numa_page() returns pfn_to_page(), after it got the pfn
> fromm pmd_pfn(pmd).

for PMD-mapped page，do_huge_pmd_numa_page() return head page

    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
    page = vm_normal_page_pmd(vma, haddr, pmd);

do_numa_page() only handle base page with PageCompound() check， so we
could use folio_estimated_sharers()， I am not clear why page_mapcount
is wrong here, could you explain more, thank.

> 
> That makes folio_estimated_sharers() an improvement, possibly even
> a bugfix.  Also, we should look at removing the PageCompound() check
> in do_numa_page().

Yes, for pte-mapped thp and the large folio numa migrate support, we
need remove the check, we could do it in another patchset.

> 
> 
