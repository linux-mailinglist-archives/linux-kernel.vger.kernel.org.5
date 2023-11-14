Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D97EB09E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjKNNNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjKNNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:13:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64374CB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:12:56 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SV6Cg3RMlzWhNR;
        Tue, 14 Nov 2023 21:12:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 21:12:52 +0800
Message-ID: <6f953202-b29c-4274-943f-f1a93b1b6ea5@huawei.com>
Date:   Tue, 14 Nov 2023 21:12:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        <akpm@linux-foundation.org>
CC:     <ying.huang@intel.com>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <70973a55-63a0-4a85-abe5-d8681fdb3886@huawei.com>
 <e75ce7a4-1294-435c-86eb-d6cf55281a39@linux.alibaba.com>
 <00372b9e-6020-64b7-1381-e88d9744ed05@nvidia.com>
 <1b4de866-df27-46fa-81fa-6818a48d8cc1@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <1b4de866-df27-46fa-81fa-6818a48d8cc1@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/11/14 19:35, David Hildenbrand wrote:
> On 13.11.23 23:15, John Hubbard wrote:
>> On 11/13/23 5:01 AM, Baolin Wang wrote:
>>>
>>>
>>> On 11/13/2023 8:10 PM, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2023/11/13 18:53, David Hildenbrand wrote:
>>>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>>>> Currently, the file pages already support large folio, and
>>>>>> supporting for
>>>>>> anonymous pages is also under discussion[1]. Moreover, the numa
>>>>>> balancing
>>>>>> code are converted to use a folio by previous thread[2], and the
>>>>>> migrate_pages
>>>>>> function also already supports the large folio migration.
>>>>>>
>>>>>> So now I did not see any reason to continue restricting NUMA
>>>>>> balancing for
>>>>>> large folio.
>>>>>
>>>>> I recall John wanted to look into that. CCing him.
>>>>>
>>>>> I'll note that the "head page mapcount" heuristic to detect sharers 
>>>>> will
>>>>> now strike on the PTE path and make us believe that a large folios is
>>>>> exclusive, although it isn't.
>>>>>
>>>>> As spelled out in the commit you are referencing:
>>>>>
>>>>> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
>>>>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> Date:   Thu Sep 21 15:44:14 2023 +0800
>>>>>
>>>>>       mm: memory: use a folio in do_numa_page()
>>>>>       Numa balancing only try to migrate non-compound page in
>>>>> do_numa_page(),
>>>>>       use a folio in it to save several compound_head calls, note 
>>>>> we use
>>>>>       folio_estimated_sharers(), it is enough to check the folio
>>>>> sharers since
>>>>>       only normal page is handled, if large folio numa balancing is
>>>>> supported, a
>>>>>       precise folio sharers check would be used, no functional change
>>>>> intended.
>>>>>
>>>>>
>>>>> I'll send WIP patches for one approach that can improve the situation
>>>>> soonish.
>>
>> To be honest, I'm still catching up on the approximate vs. exact
>> sharers case. It wasn't clear to me why a precise sharers count
>> is needed in order to do this. Perhaps the cost of making a wrong
>> decision is considered just too high?
> 
> Good question, I didn't really look into the impact for the NUMA hinting 
> case where we might end up not setting TNF_SHARED although it is shared. 
> For other folio_estimate_sharers() users it's more obvious.

The task_numa_group() will check the TNF_SHARED, if processes share same
page/folio, they will be packed into a single numa group, and the numa
group fault statistic will be used in should_numa_migrate_memory() to
decide whether to migrate or not, if not setting TNF_SHARED, maybe be
lead to more page/folio migration.

> 
> As a side note, it could have happened already in corner cases (e.g., 
> concurrent page migration of a small folio).
> 
> If precision as documented in that commit is really required remains to 
> be seen -- just wanted to spell it out.
> 
