Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527667A750F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjITH6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjITH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:58:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0E97
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:58:01 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rr9lF3P0QztSJh;
        Wed, 20 Sep 2023 15:53:45 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 15:57:59 +0800
Message-ID: <db90339a-1ff8-44c1-93e3-9a6832c1fa0d@huawei.com>
Date:   Wed, 20 Sep 2023 15:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sched/numa, mm: make numa migrate functions to take a
 folio
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
 <20230918103213.4166210-2-wangkefeng.wang@huawei.com>
 <87ttrpwnmo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <87ttrpwnmo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/20 11:05, Huang, Ying wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> 
>> The cpuid(or access time) is stored in the head page for THP, so it is
> 
> s/cpuid/cpupid/

Will fix.

> 
>> safely to make should_numa_migrate_memory() and numa_hint_fault_latency()
>> to take a folio. This is in preparation for large folio numa balancing.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/sched/numa_balancing.h |  4 ++--
>>   kernel/sched/fair.c                  | 12 ++++++------
>>   mm/mempolicy.c                       |  3 ++-
>>   3 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
>> index 3988762efe15..a38528c28665 100644
>> --- a/include/linux/sched/numa_balancing.h
>> +++ b/include/linux/sched/numa_balancing.h
>> @@ -20,7 +20,7 @@ extern void task_numa_fault(int last_node, int node, int pages, int flags);
>>   extern pid_t task_numa_group_id(struct task_struct *p);
>>   extern void set_numabalancing_state(bool enabled);
>>   extern void task_numa_free(struct task_struct *p, bool final);
>> -extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
>> +extern bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>>   					int src_nid, int dst_cpu);
>>   #else
>>   static inline void task_numa_fault(int last_node, int node, int pages,
>> @@ -38,7 +38,7 @@ static inline void task_numa_free(struct task_struct *p, bool final)
>>   {
>>   }
>>   static inline bool should_numa_migrate_memory(struct task_struct *p,
>> -				struct page *page, int src_nid, int dst_cpu)
>> +				struct folio *folio, int src_nid, int dst_cpu)
>>   {
>>   	return true;
>>   }
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cb225921bbca..683cc1e417d7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1722,12 +1722,12 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
>>    * The smaller the hint page fault latency, the higher the possibility
>>    * for the page to be hot.
>>    */
>> -static int numa_hint_fault_latency(struct page *page)
>> +static int numa_hint_fault_latency(struct folio *folio)
>>   {
>>   	int last_time, time;
>>   
>>   	time = jiffies_to_msecs(jiffies);
>> -	last_time = xchg_page_access_time(page, time);
>> +	last_time = xchg_page_access_time(&folio->page, time);
> 
> How about define xchg_folio_access_time() and folio_cpupid_xchg_last()?
> 
Yes, like 
page_cpupid_last()/xchg_page_access_time()/page_cpupid_xchg_last(),
we could do it later to change the caller to use a folio, and rename them.


> --
> Best Regards,
> Huang, Ying
> 
