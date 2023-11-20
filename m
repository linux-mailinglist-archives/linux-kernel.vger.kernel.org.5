Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB057F0AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKTD2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjKTD2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:28:06 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2D1A6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:28:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vwg4JdO_1700450877;
Received: from 30.97.48.46(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vwg4JdO_1700450877)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 11:27:58 +0800
Message-ID: <a3a54a24-76bc-419f-9251-d6ae1355b3b6@linux.alibaba.com>
Date:   Mon, 20 Nov 2023 11:28:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <05dbc7b8-2e4a-4762-a6a6-278985d89928@redhat.com>
 <ad7c3a3d-58d8-4edd-859e-4ed5a35145dd@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ad7c3a3d-58d8-4edd-859e-4ed5a35145dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 6:47 PM, David Hildenbrand wrote:
> On 15.11.23 11:46, David Hildenbrand wrote:
>> On 13.11.23 11:45, Baolin Wang wrote:
>>> Currently, the file pages already support large folio, and supporting 
>>> for
>>> anonymous pages is also under discussion[1]. Moreover, the numa 
>>> balancing
>>> code are converted to use a folio by previous thread[2], and the 
>>> migrate_pages
>>> function also already supports the large folio migration.
>>>
>>> So now I did not see any reason to continue restricting NUMA 
>>> balancing for
>>> large folio.
>>>
>>> [1] https://lkml.org/lkml/2023/9/29/342
>>> [2] 
>>> https://lore.kernel.org/all/20230921074417.24004-4-wangkefeng.wang@huawei.com/T/#md9d10fe34587229a72801f0d731f7457ab3f4a6e
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>
>> I'll note that another piece is missing, and I'd be curious how you
>> tested your patch set or what I am missing. (no anonymous pages?)

I tested it with file large folio (order = 4) created by XFS filesystem.

>> change_pte_range() contains:
>>
>> if (prot_numa) {
>>     ...
>>     /* Also skip shared copy-on-write pages */
>>     if (is_cow_mapping(vma->vm_flags) &&
>>         folio_ref_count(folio) != 1)
>>         continue;
>>
>> So we'll never end up mapping an anon PTE-mapped THP prot-none (well, 
>> unless a
>> single PTE remains) and consequently never trigger NUMA hinting faults.
>>
>> Now, that change has some history [1], but the original problem has been
>> sorted out in the meantime. But we should consider Linus' original 
>> feedback.
>>
>> For pte-mapped THP, we might want to do something like the following
>> (completely untested):

Thanks for pointing out. I have not tried pte-mapped THP yet, and will 
look at it in detail.

>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 81991102f785..c4e6b9032e40 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -129,7 +129,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>>                                   /* Also skip shared copy-on-write 
>> pages */
>>                                   if (is_cow_mapping(vma->vm_flags) &&
>> -                                   folio_ref_count(folio) != 1)
>> +                                   (folio_maybe_dma_pinned(folio) ||
>> +                                    folio_estimated_sharers(folio) != 
>> 1))
> 
> Actually, > 1 might be better if the first subpage is not mapped; it's a 
> mess.
> 
