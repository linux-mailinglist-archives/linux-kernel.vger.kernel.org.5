Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22D7EAE58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjKNKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:53:52 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A1D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:53:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VwPHoyG_1699959222;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VwPHoyG_1699959222)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 18:53:43 +0800
Message-ID: <5a510d8f-2b63-4032-947a-99d1a1aab161@linux.alibaba.com>
Date:   Tue, 14 Nov 2023 18:53:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     ying.huang@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <517f2a75-638d-4f17-a5c1-719e15507c6a@linux.alibaba.com>
 <bce69d21-14cc-4e0b-93a2-425f40ca91ad@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <bce69d21-14cc-4e0b-93a2-425f40ca91ad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2023 10:49 PM, David Hildenbrand wrote:
> On 13.11.23 13:59, Baolin Wang wrote:
>>
>>
>> On 11/13/2023 6:53 PM, David Hildenbrand wrote:
>>> On 13.11.23 11:45, Baolin Wang wrote:
>>>> Currently, the file pages already support large folio, and 
>>>> supporting for
>>>> anonymous pages is also under discussion[1]. Moreover, the numa 
>>>> balancing
>>>> code are converted to use a folio by previous thread[2], and the
>>>> migrate_pages
>>>> function also already supports the large folio migration.
>>>>
>>>> So now I did not see any reason to continue restricting NUMA balancing
>>>> for
>>>> large folio.
>>>
>>> I recall John wanted to look into that. CCing him.
>>>
>>> I'll note that the "head page mapcount" heuristic to detect sharers will
>>> now strike on the PTE path and make us believe that a large folios is
>>> exclusive, although it isn't.
>>>
>>> As spelled out in the commit you are referencing:
>>>
>>> commit 6695cf68b15c215d33b8add64c33e01e3cbe236c
>>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Date:   Thu Sep 21 15:44:14 2023 +0800
>>>
>>>       mm: memory: use a folio in do_numa_page()
>>>       Numa balancing only try to migrate non-compound page in
>>> do_numa_page(),
>>>       use a folio in it to save several compound_head calls, note we use
>>>       folio_estimated_sharers(), it is enough to check the folio sharers
>>> since
>>>       only normal page is handled, if large folio numa balancing is
>>> supported, a
>>>       precise folio sharers check would be used, no functional change
>>> intended.
>>
>> Thanks for pointing out the part I missed.
>>
>> I saw the migrate_pages() syscall is also using
>> folio_estimated_sharers() to check if the folio is shared, and I wonder
>> it will bring about any significant issues?
> 
> It's now used all over the place, in some places for making manual 
> decisions (e.g., MADV_PAGEOUT works although it shouldn't) and more and 
> more automatic places (e.g., the system ends up migrating a folio 
> although it shouldn't). The nasty thing about it is that it doesn't give 
> you "certainly exclusive" vs. "maybe shared" but "maybe exclusive" vs. 
> "certainly shared".
> 
> IIUC, the side effect could be that we migrate folios because we assume 
> they are exclusive even though they are actually shared. Right now, it's 
> sufficient to not have the first page of the folio mapped anymore for 
> that to happen.

Yes.

> Anyhow, it's worth mentioning that in the commit message as long as we 
> have no better solution for that. For many cases it might be just 
> tolerable.

Agree. The 'maybe shared' folio may affect the numa group statistics, 
which is used to accumulate the numa faults in one group to choose a 
prefered node for the tasks. For this case, it may be tolerable too, but 
I have no performance numbers now. Let me think about it.

>>> I'll send WIP patches for one approach that can improve the situation
>>> soonish.
>>
>> Great. Look forward to seeing this:)
> 
> I'm still trying to evaluate the performance hit of the additional 
> tracking ... turns out there is no such thing as free food ;)

Make sense.
