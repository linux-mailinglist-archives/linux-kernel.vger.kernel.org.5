Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C97D0663
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346833AbjJTCJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbjJTCJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:09:28 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD5F11F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:09:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuVIn4o_1697767761;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuVIn4o_1697767761)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 10:09:22 +0800
Message-ID: <05d596f3-c59c-76c3-495e-09f8573cf438@linux.alibaba.com>
Date:   Fri, 20 Oct 2023 10:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: migrate: record the mlocked page status to remove
 unnecessary lru drain
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        hughd@google.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <64899ad0bb78cde88b52abed1a5a5abbc9919998.1697632761.git.baolin.wang@linux.alibaba.com>
 <1F80D8DA-8BB5-4C7E-BC2F-030BF52931F7@nvidia.com>
 <87il73uos1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2ad721be-b81e-d279-0055-f995a8cfe180@linux.alibaba.com>
 <27f40fc2-806a-52a9-3697-4ed9cd7081d4@intel.com>
 <e8099116-6f78-cb4a-5036-1d7e38b63e52@linux.alibaba.com>
 <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <fd389af5-d949-43dc-9a35-d53112fe4a60@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 8:07 PM, Yin, Fengwei wrote:
> 
> 
> On 10/19/2023 4:51 PM, Baolin Wang wrote:
>>
>>
>> On 10/19/2023 4:22 PM, Yin Fengwei wrote:
>>> Hi Baolin,
>>>
>>> On 10/19/23 15:25, Baolin Wang wrote:
>>>>
>>>>
>>>> On 10/19/2023 2:09 PM, Huang, Ying wrote:
>>>>> Zi Yan <ziy@nvidia.com> writes:
>>>>>
>>>>>> On 18 Oct 2023, at 9:04, Baolin Wang wrote:
>>>>>>
>>>>>>> When doing compaction, I found the lru_add_drain() is an obvious hotspot
>>>>>>> when migrating pages. The distribution of this hotspot is as follows:
>>>>>>>       - 18.75% compact_zone
>>>>>>>          - 17.39% migrate_pages
>>>>>>>             - 13.79% migrate_pages_batch
>>>>>>>                - 11.66% migrate_folio_move
>>>>>>>                   - 7.02% lru_add_drain
>>>>>>>                      + 7.02% lru_add_drain_cpu
>>>>>>>                   + 3.00% move_to_new_folio
>>>>>>>                     1.23% rmap_walk
>>>>>>>                + 1.92% migrate_folio_unmap
>>>>>>>             + 3.20% migrate_pages_sync
>>>>>>>          + 0.90% isolate_migratepages
>>>>>>>
>>>>>>> The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
>>>>>>> __unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
>>>>>>> immediately, to help to build up the correct newpage->mlock_count in
>>>>>>> remove_migration_ptes() for mlocked pages. However, if there are no mlocked
>>>>>>> pages are migrating, then we can avoid this lru drain operation, especailly
>>>>>>> for the heavy concurrent scenarios.
>>>>>>
>>>>>> lru_add_drain() is also used to drain pages out of folio_batch. Pages in folio_batch
>>>>>> have an additional pin to prevent migration. See folio_get(folio); in folio_add_lru().
>>>>>
>>>>> lru_add_drain() is called after the page reference count checking in
>>>>> move_to_new_folio().  So, I don't this is an issue.
>>>>
>>>> Agree. The purpose of adding lru_add_drain() is to address the 'mlock_count' issue for mlocked pages. Please see commit c3096e6782b7 and related comments. Moreover I haven't seen an increase in the number of page migration failures due to page reference count checking after this patch.
>>>
>>> I agree with your. My understanding also is that the lru_add_drain() is only needed
>>> for mlocked folio to correct mlock_count. Like to hear the confirmation from Huge.
>>>
>>>
>>> But I have question: why do we need use page_was_mlocked instead of check
>>> folio_test_mlocked(src)? Does page migration clear the mlock flag? Thanks.
>>
>> Yes, please see the call trace: try_to_migrate_one() ---> page_remove_rmap() ---> munlock_vma_folio().
> 
> Yes. This will clear mlock bit.
> 
> What about set dst folio mlocked if source is before try_to_migrate_one()? And
> then check whether dst folio is mlocked after? And need clear mlocked if migration
> fails. I suppose the change is minor. Just a thought. Thanks.

IMO, this will break the mlock related statistics in mlock_folio() when 
the remove_migration_pte() rebuilds the mlock status and mlock count.

Another concern I can see is that, during the page migration, a 
concurrent munlock() can be called to clean the VM_LOCKED flags for the 
VMAs, so the remove_migration_pte() should not rebuild the mlock status 
and mlock count. But the dst folio's mlcoked status is still remained, 
which is wrong.

So your suggested apporach seems not easy, and I think my patch is 
simple with re-using existing __migrate_folio_record() and 
__migrate_folio_extract() :)
