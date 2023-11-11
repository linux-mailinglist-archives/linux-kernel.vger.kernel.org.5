Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566B7E886D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjKKCr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjKKCrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:47:24 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF53C15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:47:20 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SS0Pv1J6NzrTZT;
        Sat, 11 Nov 2023 10:44:03 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Sat, 11 Nov 2023 10:47:17 +0800
Subject: Re: [PATCH v8] mm: vmscan: try to reclaim swapcache pages if no swap
 space
To:     "Huang, Ying" <ying.huang@intel.com>
References: <20231106074452.2581835-1-liushixin2@huawei.com>
 <87pm0nv05u.fsf@yhuang6-desk2.ccr.corp.intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <017e9d29-4b42-abad-384d-94117a7919eb@huawei.com>
Date:   Sat, 11 Nov 2023 10:47:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87pm0nv05u.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/6 14:57, Huang, Ying wrote:
> Liu Shixin <liushixin2@huawei.com> writes:
>
>> When spaces of swap devices are exhausted, only file pages can be
>> reclaimed.  But there are still some swapcache pages in anon lru list.
>> This can lead to a premature out-of-memory.
>>
>> The problem is found with such step:
>>
>>  Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
>>  memory limit, then runs an program to allocates about 15MB memory.
>>
>> The problem occurs occasionally, which may need about 100 times [1].
>>
>> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
>> If the number is not zero, return true and set swapcache_only to 1.
>> When scan anon lru list in swapcache_only mode, non-swapcache pages will
>> be skipped to isolate in order to accelerate reclaim efficiency.
>>
>> However, in swapcache_only mode, the scan count still increased when scan
>> non-swapcache pages because there are large number of non-swapcache pages
>> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
>> is skipped and do not count, the scan of pages in isolate_lru_folios() can
>> eventually lead to hung task, just as Sachin reported [2].
>>
>> By the way, since there are enough times of memory reclaim before OOM, it
>> is not need to isolate too much swapcache pages in one times.
>>
>> [1]. https://lore.kernel.org/lkml/CAJD7tkZAfgncV+KbKr36=eDzMnT=9dZOT0dpMWcurHLr6Do+GA@mail.gmail.com/
>> [2]. https://lore.kernel.org/linux-mm/CAJD7tkafz_2XAuqE8tGLPEcpLngewhUo=5US14PAtSM9tLBUQg@mail.gmail.com/
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> Tested-by: Yosry Ahmed <yosryahmed@google.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>> ---
>> v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages().
>> v6->v7: Reset swapcache_only to zero after there are swap spaces.
>> v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.
>>
>>  include/linux/swap.h |  6 ++++++
>>  mm/memcontrol.c      |  8 ++++++++
>>  mm/vmscan.c          | 27 +++++++++++++++++++++++++++
>>  3 files changed, 41 insertions(+)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index f6dd6575b905..3ba146ae7cf5 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -659,6 +659,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
>>  }
>>  
>>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
>>  extern bool mem_cgroup_swap_full(struct folio *folio);
>>  #else
>>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
>> @@ -681,6 +682,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>  	return get_nr_swap_pages();
>>  }
>>  
>> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +	return total_swapcache_pages();
>> +}
>> +
>>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>  	return vm_swap_full();
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 5b009b233ab8..29e34c06ca83 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7584,6 +7584,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>>  	return nr_swap_pages;
>>  }
>>  
>> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> +{
>> +	if (mem_cgroup_disabled())
>> +		return total_swapcache_pages();
>> +
>> +	return memcg_page_state(memcg, NR_SWAPCACHE);
>> +}
>> +
>>  bool mem_cgroup_swap_full(struct folio *folio)
>>  {
>>  	struct mem_cgroup *memcg;
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 6f13394b112e..5d5a169ec98c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -137,6 +137,9 @@ struct scan_control {
>>  	/* Always discard instead of demoting to lower tier memory */
>>  	unsigned int no_demotion:1;
>>  
>> +	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
>> +	unsigned int swapcache_only:1;
>> +
>>  	/* Allocation order */
>>  	s8 order;
>>  
>> @@ -606,6 +609,9 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>  					  int nid,
>>  					  struct scan_control *sc)
>>  {
>> +	if (sc)
>> +		sc->swapcache_only = 0;
>> +
>>  	if (memcg == NULL) {
>>  		/*
>>  		 * For non-memcg reclaim, is there
>> @@ -613,10 +619,22 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>  		 */
>>  		if (get_nr_swap_pages() > 0)
>>  			return true;
>> +		/* Is there any swapcache pages to reclaim? */
>> +		if (total_swapcache_pages() > 0) {
>> +			if (sc)
>> +				sc->swapcache_only = 1;
>> +			return true;
>> +		}
>>  	} else {
>>  		/* Is the memcg below its swap limit? */
>>  		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>>  			return true;
>> +		/* Is there any swapcache pages in memcg to reclaim? */
>> +		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
>> +			if (sc)
>> +				sc->swapcache_only = 1;
>> +			return true;
>> +		}
>>  	}
> I understand that this is only possible in theory.  But if can_demote()
> == true, get_nr_swap_pages() == 0, total_swapcache_pages() > 0, we will
> demote only anonymous pages in swapcache.  I think that this isn't
> reasonable.  So, swapcache pages should be checked after can_demote()
> checking.
>
> --
> Best Regards,
> Huang, Ying
Thanks for your advise, that sounds more reasonable. I will modify it soon.
>
>>  	/*
>> @@ -2342,6 +2360,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>  		 */
>>  		scan += nr_pages;
>>  
>> +		/*
>> +		 * Count non-swapcache too because the swapcache pages may
>> +		 * be rare and it takes too much times here if not count
>> +		 * the non-swapcache pages.
>> +		 */
>> +		if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
>> +		    !folio_test_swapcache(folio)))
>> +			goto move;
>> +
>>  		if (!folio_test_lru(folio))
>>  			goto move;
>>  		if (!sc->may_unmap && folio_mapped(folio))
> .
>

