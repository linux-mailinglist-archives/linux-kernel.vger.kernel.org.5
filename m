Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177587824EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjHUHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjHUHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:53:00 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D81B1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:52:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VqE2ap9_1692604372;
Received: from 30.97.48.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqE2ap9_1692604372)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 15:52:53 +0800
Message-ID: <d2d2f545-ca85-846c-fdda-94ec96c7c7e8@linux.alibaba.com>
Date:   Mon, 21 Aug 2023 15:52:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] mm: migrate: move migration validation into
 numa_migrate_prep()
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        shy828301@gmail.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
 <a37b13dd91bd3eadcd56a08cb3c839616f8457e7.1692440586.git.baolin.wang@linux.alibaba.com>
 <87h6otdtm6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87h6otdtm6.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2023 10:20 AM, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> Now there are 3 places will validate if a page can mirate or not, and
>> some validations are performed later, which will waste some CPU to call
>> numa_migrate_prep().
>>
>> Thus we can move all the migration validation into numa_migrate_prep(),
>> which is more maintainable as well as saving some CPU resources. Another
>> benefit is that it can serve as a preparation for supporting batch migration
>> in do_numa_page() in future.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c  | 19 +++++++++++++++++++
>>   mm/migrate.c | 19 -------------------
>>   2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d003076b218d..bee9b1e86ef0 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4747,6 +4747,25 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>>   		*flags |= TNF_FAULT_LOCAL;
>>   	}
>>   
>> +	/*
>> +	 * Don't migrate file pages that are mapped in multiple processes
>> +	 * with execute permissions as they are probably shared libraries.
>> +	 */
>> +	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
>> +	    (vma->vm_flags & VM_EXEC))
>> +		return NUMA_NO_NODE;
>> +
>> +	/*
>> +	 * Also do not migrate dirty pages as not all filesystems can move
>> +	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
>> +	 */
>> +	if (page_is_file_lru(page) && PageDirty(page))
>> +		return NUMA_NO_NODE;
>> +
>> +	/* Do not migrate THP mapped by multiple processes */
>> +	if (PageTransHuge(page) && total_mapcount(page) > 1)
>> +		return NUMA_NO_NODE;
>> +
>>   	return mpol_misplaced(page, vma, addr);
> 
> In mpol_misplaced()->should_numa_migrate_memory(), accessing CPU and PID
> will be recorded.  So the code change above will introduce some behavior
> change.

Indeed.

> 
> How about move these checks into a separate function which is called
> between numa_migrate_prep() and migrate_misplaced_page() after unlocking
> PTL?

Sounds reasonable to me. Thanks for your input.

> 
> --
> Best Regards,
> Huang, Ying
> 
>>   }
>>   
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e21d5a7e7447..9cc98fb1d6ec 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2485,10 +2485,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>   
>>   	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>>   
>> -	/* Do not migrate THP mapped by multiple processes */
>> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
>> -		return 0;
>> -
>>   	/* Avoid migrating to a node that is nearly full */
>>   	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
>>   		int z;
>> @@ -2533,21 +2529,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>   	LIST_HEAD(migratepages);
>>   	int nr_pages = thp_nr_pages(page);
>>   
>> -	/*
>> -	 * Don't migrate file pages that are mapped in multiple processes
>> -	 * with execute permissions as they are probably shared libraries.
>> -	 */
>> -	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
>> -	    (vma->vm_flags & VM_EXEC))
>> -		goto out;
>> -
>> -	/*
>> -	 * Also do not migrate dirty pages as not all filesystems can move
>> -	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
>> -	 */
>> -	if (page_is_file_lru(page) && PageDirty(page))
>> -		goto out;
>> -
>>   	isolated = numamigrate_isolate_page(pgdat, page);
>>   	if (!isolated)
>>   		goto out;
