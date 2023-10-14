Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA87C9267
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJNDME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNDMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:12:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B8B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 20:11:58 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S6pGM0xPpz1kv4d;
        Sat, 14 Oct 2023 11:07:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 14 Oct 2023 11:11:55 +0800
Message-ID: <9f56879d-2157-45ba-9f62-2c67b924da8d@huawei.com>
Date:   Sat, 14 Oct 2023 11:11:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 09/19] mm: mprotect: use a folio in
 change_pte_range()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231013085603.1227349-1-wangkefeng.wang@huawei.com>
 <20231013085603.1227349-10-wangkefeng.wang@huawei.com>
 <ZSlekx1pYOh7ltaF@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZSlekx1pYOh7ltaF@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/10/13 23:13, Matthew Wilcox wrote:
> On Fri, Oct 13, 2023 at 04:55:53PM +0800, Kefeng Wang wrote:
>> Use a folio in change_pte_range() to save three compound_head() calls.
> 
> Yes, but here we have a change of behaviour, which should be argued
> is desirable.  Before if a partial THP was mapped, or a fs large
> folio, we would do this to individual pages.  Now we're doing it to the
> entire folio.  Is that desirable?  I don't have the background to argue
> either way.

The Huang's replay in v1[1] already mentioned this, we only use 
last_cpupid from head page, and large folio won't be handled from
do_numa_page(), and if large folio numa balancing is supported,
we could migrate the entire large folio mapped only one process,
or maybe split the large folio mapped multi-processes, and when
split it, we will copy the last_cpupid from head to the tail page.
Anyway, I think this change or the wp_page_reuse() won't break
current numa balancing.

Thanks.


[1]https://lore.kernel.org/linux-mm/874jixhfeu.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
>> @@ -157,7 +159,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   					continue;
>>   				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
>>   				    !toptier)
>> -					xchg_page_access_time(page,
>> +					folio_xchg_access_time(folio,
>>   						jiffies_to_msecs(jiffies));
>>   			}
> 
