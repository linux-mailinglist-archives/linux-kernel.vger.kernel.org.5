Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75C9782C30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjHUOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjHUOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:41:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE40E8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:41:24 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTw7v1BZ2zLp2r;
        Mon, 21 Aug 2023 22:38:19 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 22:41:21 +0800
Message-ID: <cd3036d5-861e-4be9-b577-eee8d0a61841@huawei.com>
Date:   Mon, 21 Aug 2023 22:41:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] mm: migrate: remove PageTransHuge check in
 numamigrate_isolate_page()
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-2-wangkefeng.wang@huawei.com>
 <ZONay3H/RB381x8a@casper.infradead.org>
 <ebf94247-e77e-4265-880a-1d74a74c76f6@huawei.com>
In-Reply-To: <ebf94247-e77e-4265-880a-1d74a74c76f6@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/21 20:52, Kefeng Wang wrote:
> 
> 
> On 2023/8/21 20:38, Matthew Wilcox wrote:
>> On Mon, Aug 21, 2023 at 07:56:17PM +0800, Kefeng Wang wrote:
>>> Since we begin to convert the numa migration code to use folio, which
>>> could let us to handle arbitrary sizes of folio, so drop assert that
>>> we only support PageTransHuge page(PMD size) when order > 0.
>>
>> Have you looked at the implementation of PageTransHuge()?  Your
>> description doesn't match what the code does.
> 
> oops, not only PMD size...

Please ignore about reply, sorry，I misread， PageTransHuge return true
for head page, and BUG_ON for tail page, and compound_order(page) will
return 0 for tail page, so when begin to convert page to folio, we could
drop this line since it is not useful check for folio.

> 
>>
>>> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   mm/migrate.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index b7fa020003f3..646d8ee7f102 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2483,8 +2483,6 @@ static int numamigrate_isolate_page(pg_data_t 
>>> *pgdat, struct page *page)
>>>       int nr_pages = thp_nr_pages(page);
>>>       int order = compound_order(page);
>>> -    VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>>> -
>>>       /* Do not migrate THP mapped by multiple processes */
>>>       if (PageTransHuge(page) && total_mapcount(page) > 1)
>>>           return 0;
>>> -- 
>>> 2.41.0
>>>
>>>
>>
