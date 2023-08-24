Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE27865C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbjHXDPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbjHXDPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:15:18 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E53C10EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 20:15:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VqSJ0m._1692846897;
Received: from 30.97.48.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqSJ0m._1692846897)
          by smtp.aliyun-inc.com;
          Thu, 24 Aug 2023 11:14:58 +0800
Message-ID: <fb262b1d-485c-8c93-d47b-96c95c9ec976@linux.alibaba.com>
Date:   Thu, 24 Aug 2023 11:14:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/4] mm: migrate: move the numamigrate_isolate_page()
 into do_numa_page()
To:     Bharata B Rao <bharata@amd.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
 <9ff2a9e3e644103a08b9b84b76b39bbd4c60020b.1692665449.git.baolin.wang@linux.alibaba.com>
 <95d72acc-c4fa-cd71-a27f-113f0c2a8649@amd.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <95d72acc-c4fa-cd71-a27f-113f0c2a8649@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 5:02 PM, Bharata B Rao wrote:
> On 22-Aug-23 6:23 AM, Baolin Wang wrote:
>> Move the numamigrate_isolate_page() into do_numa_page() to simplify the
>> migrate_misplaced_page(), which now only focuses on page migration, and
>> it also serves as a preparation for supporting batch migration for
>> migrate_misplaced_page().
>>
>> While we are at it, change the numamigrate_isolate_page() to boolean
>> type to make the return value more clear.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/migrate.h |  6 ++++++
>>   mm/huge_memory.c        |  7 +++++++
>>   mm/memory.c             |  7 +++++++
>>   mm/migrate.c            | 22 +++++++---------------
>>   4 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 711dd9412561..ddcd62ec2c12 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -144,12 +144,18 @@ const struct movable_operations *page_movable_ops(struct page *page)
>>   #ifdef CONFIG_NUMA_BALANCING
>>   int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>   			   int node);
>> +bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page);
>>   #else
>>   static inline int migrate_misplaced_page(struct page *page,
>>   					 struct vm_area_struct *vma, int node)
>>   {
>>   	return -EAGAIN; /* can't migrate now */
>>   }
>> +
>> +static inline bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>> +{
>> +	return false;
>> +}
>>   #endif /* CONFIG_NUMA_BALANCING */
>>   
>>   #ifdef CONFIG_MIGRATION
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 4a9b34a89854..07149ead11e4 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1496,6 +1496,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>>   	bool migrated = false, writable = false;
>>   	int flags = 0;
>> +	pg_data_t *pgdat;
>>   
>>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>   	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>> @@ -1545,6 +1546,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   		goto migrate_fail;
>>   	}
>>   
>> +	pgdat = NODE_DATA(target_nid);
>> +	if (!numamigrate_isolate_page(pgdat, page)) {
>> +		put_page(page);
>> +		goto migrate_fail;
>> +	}
>> +
>>   	migrated = migrate_misplaced_page(page, vma, target_nid);
>>   	if (migrated) {
>>   		flags |= TNF_MIGRATED;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index fc6f6b7a70e1..4e451b041488 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4769,6 +4769,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	int target_nid;
>>   	pte_t pte, old_pte;
>>   	int flags = 0;
>> +	pg_data_t *pgdat;
>>   
>>   	/*
>>   	 * The "pte" at this point cannot be used safely without
>> @@ -4844,6 +4845,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   		goto migrate_fail;
>>   	}
>>   
>> +	pgdat = NODE_DATA(target_nid);
>> +	if (!numamigrate_isolate_page(pgdat, page)) {
>> +		put_page(page);
>> +		goto migrate_fail;
>> +	}
>> +
>>   	/* Migrate to the requested node */
>>   	if (migrate_misplaced_page(page, vma, target_nid)) {
>>   		page_nid = target_nid;
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 9cc98fb1d6ec..0b2b69a2a7ab 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2478,7 +2478,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>>   	return __folio_alloc_node(gfp, order, nid);
>>   }
>>   
>> -static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>> +bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>   {
>>   	int nr_pages = thp_nr_pages(page);
>>   	int order = compound_order(page);
>> @@ -2496,11 +2496,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>   				break;
>>   		}
> 
> There is an other s/return 0/return false/ changed required here for this chunk:
> 
> if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>                          return 0;

Good catch.

> 
>>   		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
>> -		return 0;
>> +		return false;
>>   	}
> 
> Looks like this whole section under "Avoiding migrating to a node that is nearly full"
> check could be moved to numa_page_can_migrate() as that can be considered as one more
> check (or action to) see if the page can be migrated or not. After that numamigrate_isolate_page()
> will truly be about isolating the page.

Good idea. Will do. Thanks.
