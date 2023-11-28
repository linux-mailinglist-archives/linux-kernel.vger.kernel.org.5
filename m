Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08817FAFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjK1B7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjK1B7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:59:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBE1AA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:59:57 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SfQX920j6zShKJ;
        Tue, 28 Nov 2023 09:55:37 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 28 Nov 2023 09:59:54 +0800
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap
 space
To:     Chris Li <chrisl@kernel.org>
References: <20231121090624.1814733-1-liushixin2@huawei.com>
 <CAF8kJuPPk0nPMyp+pjOdN0sJ4StL63MF+haXJYBTRki2uLywyQ@mail.gmail.com>
CC:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <f30c160c-eb74-0c7c-9341-59774dfe5fc1@huawei.com>
Date:   Tue, 28 Nov 2023 09:59:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAF8kJuPPk0nPMyp+pjOdN0sJ4StL63MF+haXJYBTRki2uLywyQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/24 1:19, Chris Li wrote:
> Hi Shixin,
>
> On Tue, Nov 21, 2023 at 12:08 AM Liu Shixin <liushixin2@huawei.com> wrote:
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
> Just out of my curiosity, in your usage case, how much additional
> memory in terms of pages or MB can be freed by this patch, using
> current code as base line?
My testcase is in a memory cgroup with memory limit of 10MB, the memory can
be freed is only about 5MB.
> Does the swap cache page reclaimed in swapcache_only mode, all swap
> count drop to zero, and the only reason to stay in swap cache is to
> void page IO write if we need to swap that page out again?
Yes.
>
>> Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
>> If the number is not zero, return true and set swapcache_only to 1.
>> When scan anon lru list in swapcache_only mode, non-swapcache pages will
>> be skipped to isolate in order to accelerate reclaim efficiency.
> Here you said non-swapcache will be skipped if swapcache_only == 1
>
>> However, in swapcache_only mode, the scan count still increased when scan
>> non-swapcache pages because there are large number of non-swapcache pages
>> and rare swapcache pages in swapcache_only mode, and if the non-swapcache
> Here you suggest non-swapcache pages will also be scanned even when
> swapcache_only == 1. It seems to contradict what you said above. I
> feel that I am missing something here.
The swapcache pages and non-swapcache pages are both in anon lru. So when scan
anon pages, then non-swapcache pages will also be scanned. In isolate_lru_folios(),
if we select to put non-swapcache pages in folios_skipped list, the scan of anon list
will running until finding enough swapcache pages, this will waste too much time.
To avoid such problem, after we scan enough anon pages, even if we don't isolate
enough swapcache pages, we have to stop.
>
>> is skipped and do not count, the scan of pages in isolate_lru_folios() can
> Can you clarify which "scan of pages", are those pages swapcache pages
> or non-swapcache pages?
I mean scan of anon pages, include both swapcache pages and non-swpacache pages.
>
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
>> v9->v10: Use per-node swapcache suggested by Yu Zhao.
>> v8->v9: Move the swapcache check after can_demote() and refector
>>         can_reclaim_anon_pages() a bit.
>> v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages().
>> v6->v7: Reset swapcache_only to zero after there are swap spaces.
>> v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.
>>
>>  mm/vmscan.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 506f8220c5fe..1fcc94717370 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -136,6 +136,9 @@ struct scan_control {
>>         /* Always discard instead of demoting to lower tier memory */
>>         unsigned int no_demotion:1;
>>
>> +       /* Swap space is exhausted, only reclaim swapcache for anon LRU */
>> +       unsigned int swapcache_only:1;
>> +
>>         /* Allocation order */
>>         s8 order;
>>
>> @@ -308,10 +311,36 @@ static bool can_demote(int nid, struct scan_control *sc)
>>         return true;
>>  }
>>
>> +#ifdef CONFIG_SWAP
>> +static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
>> +{
>> +       struct pglist_data *pgdat = NODE_DATA(nid);
>> +       unsigned long nr_swapcache;
>> +
>> +       if (!memcg) {
>> +               nr_swapcache = node_page_state(pgdat, NR_SWAPCACHE);
>> +       } else {
>> +               struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +
>> +               nr_swapcache = lruvec_page_state_local(lruvec, NR_SWAPCACHE);
>> +       }
>> +
>> +       return nr_swapcache > 0;
>> +}
>> +#else
>> +static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
>> +{
>> +       return false;
>> +}
>> +#endif
>> +
>>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>                                           int nid,
>>                                           struct scan_control *sc)
>>  {
>> +       if (sc)
>> +               sc->swapcache_only = 0;
>> +
> Minor nitpick. The sc->swapcache_only is first set to 0 then later set
> to 1. Better use a local variable then write to sc->swapcache_only in
> one go. If the scan_control has more than one thread accessing it, the
> threads can see the flicker of 0->1 change.  I don't think that is the
> case in our current code, sc is created on stack. There are other
> minor benefits as The "if (sc) test" only needs to be done once, one
> store instruction.
>
> Chris
Thanks for your advice. If finally decide to use this patch, I will revise it.
>>         if (memcg == NULL) {
>>                 /*
>>                  * For non-memcg reclaim, is there
>> @@ -330,7 +359,17 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
>>          *
>>          * Can it be reclaimed from this node via demotion?
>>          */
>> -       return can_demote(nid, sc);
>> +       if (can_demote(nid, sc))
>> +               return true;
>> +
>> +       /* Is there any swapcache pages to reclaim in this node? */
>> +       if (can_reclaim_swapcache(memcg, nid)) {
>> +               if (sc)
>> +                       sc->swapcache_only = 1;
>> +               return true;
>> +       }
>> +
>> +       return false;
>>  }
>>
>>  /*
>> @@ -1642,6 +1681,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>>                  */
>>                 scan += nr_pages;
>>
>> +               /*
>> +                * Count non-swapcache too because the swapcache pages may
>> +                * be rare and it takes too much times here if not count
>> +                * the non-swapcache pages.
>> +                */
>> +               if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
>> +                   !folio_test_swapcache(folio)))
>> +                       goto move;
>> +
>>                 if (!folio_test_lru(folio))
>>                         goto move;
>>                 if (!sc->may_unmap && folio_mapped(folio))
>> --
>> 2.25.1
>>
>>
> .
>

