Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9497F0D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjKTIBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjKTIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:01:36 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C049B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:01:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VwkI1Fs_1700467289;
Received: from 30.97.48.46(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VwkI1Fs_1700467289)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 16:01:30 +0800
Message-ID: <55ca937e-92ba-4d01-a8f1-3a2a66054451@linux.alibaba.com>
Date:   Mon, 20 Nov 2023 16:01:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
To:     Mel Gorman <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
 <87sf57en8n.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231117100745.fnpijbk4xgmals3k@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/2023 6:07 PM, Mel Gorman wrote:
> On Wed, Nov 15, 2023 at 10:58:32AM +0800, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> On 11/14/2023 9:12 AM, Huang, Ying wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>>>> Currently, the file pages already support large folio, and supporting for
>>>>>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>>>>>> code are converted to use a folio by previous thread[2], and the migrate_pages
>>>>>> function also already supports the large folio migration.
>>>>>> So now I did not see any reason to continue restricting NUMA
>>>>>> balancing for
>>>>>> large folio.
>>>>>
>>>>> I recall John wanted to look into that. CCing him.
>>>>>
>>>>> I'll note that the "head page mapcount" heuristic to detect sharers will
>>>>> now strike on the PTE path and make us believe that a large folios is
>>>>> exclusive, although it isn't.
>>>> Even 4k folio may be shared by multiple processes/threads.  So, numa
>>>> balancing uses a multi-stage node selection algorithm (mostly
>>>> implemented in should_numa_migrate_memory()) to identify shared folios.
>>>> I think that the algorithm needs to be adjusted for PTE mapped large
>>>> folio for shared folios.
>>>
>>> Not sure I get you here. In should_numa_migrate_memory(), it will use
>>> last CPU id, last PID and group numa faults to determine if this page
>>> can be migrated to the target node. So for large folio, a precise
>>> folio sharers check can make the numa faults of a group more accurate,
>>> which is enough for should_numa_migrate_memory() to make a decision?
>>
>> A large folio that is mapped by multiple process may be accessed by one
>> remote NUMA node, so we still want to migrate it.  A large folio that is
>> mapped by one process but accessed by multiple threads on multiple NUMA
>> node may be not migrated.
>>
> 
> This leads into a generic problem with large anything with NUMA
> balancing -- false sharing. As it stands, THP can be false shared by
> threads if thread-local data is split within a THP range. In this case,
> the ideal would be the THP is migrated to the hottest node but such
> support doesn't exist. The same applies for folios. If not handled

So below check in should_numa_migrate_memory() can not avoid the false 
sharing of large folio you mentioned? Please correct me if I missed 
anything.

         /*
          * Destination node is much more heavily used than the source
          * node? Allow migration.
          */
         if (group_faults_cpu(ng, dst_nid) > group_faults_cpu(ng, src_nid) *
                                         ACTIVE_NODE_FRACTION)
                 return true;

         /*
          * Distribute memory according to CPU & memory use on each node,
          * with 3/4 hysteresis to avoid unnecessary memory migrations:
          *
          * faults_cpu(dst)   3   faults_cpu(src)
          * --------------- * - > ---------------
          * faults_mem(dst)   4   faults_mem(src)
          */
         return group_faults_cpu(ng, dst_nid) * group_faults(p, src_nid) 
* 3 >
                group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) 
* 4;


> properly, a large folio of any type can ping-pong between nodes so just
> migrating because we can is not necessarily a good idea. The patch
> should cover a realistic case why this matters, why splitting the folio
> is not better and supporting data.

Sure. For a private mapping, we should always migrate the large folio. 
The tricky part is the shared mapping as you and Ying said, which can 
have different scenarios, and I'm thinking about how to validate it. Do 
you have any suggestion? Thanks.
