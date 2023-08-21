Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D2782514
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjHUIKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjHUIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:10:15 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA37EB5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:10:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VqD7Njw_1692605407;
Received: from 30.97.48.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqD7Njw_1692605407)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 16:10:08 +0800
Message-ID: <21099f59-c660-41a3-e422-0c14ac5d0fac@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 16:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/4] Extend migrate_misplaced_page() to support batch
 migration
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        shy828301@gmail.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
 <87cyzhdt5r.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87cyzhdt5r.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 10:29 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Hi,
>>
>> Currently, on our ARM servers with NUMA enabled, we found the cross-die latency
>> is a little larger that will significantly impact the workload's performance.
>> So on ARM servers we will rely on the NUMA balancing to avoid the cross-die
>> accessing. And I posted a patchset[1] to support speculative numa fault to
>> improve the NUMA balancing's performance according to the principle of data
>> locality. Moreover, thanks to Huang Ying's patchset[2], which introduced batch
>> migration as a way to reduce the cost of TLB flush, and it will also benefit
>> the migration of multiple pages all at once during NUMA balancing.
>>
>> So we plan to continue to support batch migration in do_numa_page() to improve
>> the NUMA balancing's performance, but before adding complicated batch migration
>> algorithm for NUMA balancing, some cleanup and preparation work need to do firstly,
>> which are done in this patch set. In short, this patchset extends the
>> migrate_misplaced_page() interface to support batch migration, and no functional
>> changes intended.
> 
> Will these cleanup benefit anything except batching migration?  If not,

I hope these cleanup can also benefit the compound page's NUMA 
balancing, which was discussed in the thread[1]. IIUC, for the compound 
page's NUMA balancing, it is possible that partial pages were 
successfully migrated, so it is necessary to return the number of pages 
that were successfully migrated from migrate_misplaced_page(). (But I 
did not look this in detail yet, please correct me if I missed 
something, and I will find some time to look this in detail). That is 
why I think these cleanups are straightforward.

Yes, I will post the batch migration patches after more polish and 
testing, but I think these cleanups are separate and straightforward, so 
I plan to submit the patches separately.

[1] 
https://lore.kernel.org/all/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/

> I suggest you to post the whole series.  In this way, people will be
> more clear about why we need these cleanup.
> 
> --
> Best Regards,
> Huang, Ying
> 
>> [1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
>> [2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u
>>
>> Baolin Wang (4):
>>    mm: migrate: move migration validation into numa_migrate_prep()
>>    mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
>>    mm: migrate: change migrate_misplaced_page() to support multiple pages
>>      migration
>>    mm: migrate: change to return the number of pages migrated
>>      successfully
>>
>>   include/linux/migrate.h | 15 ++++++++---
>>   mm/huge_memory.c        | 19 +++++++++++---
>>   mm/memory.c             | 34 +++++++++++++++++++++++-
>>   mm/migrate.c            | 58 ++++++++---------------------------------
>>   4 files changed, 71 insertions(+), 55 deletions(-)
