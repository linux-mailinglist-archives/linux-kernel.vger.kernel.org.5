Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E7E7AE970
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjIZJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjIZJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:39:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D32810C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:39:26 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvvlp1sNyzrT6n;
        Tue, 26 Sep 2023 17:37:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 17:39:24 +0800
Message-ID: <75d28233-c8bd-4528-a775-8ccdc7fc3e26@huawei.com>
Date:   Tue, 26 Sep 2023 17:39:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 8/9] mm: page_alloc: use a folio in
 free_pages_prepare()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
 <20230926005254.2861577-9-wangkefeng.wang@huawei.com>
 <b7818a38-d991-6cdd-c908-fe0ebc3677c6@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <b7818a38-d991-6cdd-c908-fe0ebc3677c6@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/9/26 15:49, David Hildenbrand wrote:
> On 26.09.23 02:52, Kefeng Wang wrote:
>> The page should not a tail page in free_pages_prepare(), let's use
>> a folio in free_pages_prepare() to save several compound_head() calls.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/page_alloc.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 06be8821d833..a888b9d57751 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1070,6 +1070,7 @@ static __always_inline bool 
>> free_pages_prepare(struct page *page,
>>               unsigned int order, fpi_t fpi_flags)
>>   {
>>       int bad = 0;
>> +    struct folio *folio = page_folio(page);
> 
> We might have higher-order pages here that are not folios (not compound 
> pages). It looks a bit like this function really shouldn't be working 
> with folios in the generic way, for that reason.
> 
> Wrong level of abstraction in that function.

Thanks for your point this, also the change also looks unnecessary too,
the main purpose to use a folio in this function is prepared for
converting page_cpupid_reset_last() to folio, as the higher-order pages
the next patch is not right, I will reconsider it.

> 
> What am I missing?
> 
