Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8D7E4EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjKHCB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKHCBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:01:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472710F2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:01:51 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SQ7Xv5Rfyz1P80c;
        Wed,  8 Nov 2023 09:58:39 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 8 Nov 2023 10:01:19 +0800
Message-ID: <cc4ac7de-97f5-4131-804d-622fb158dba9@huawei.com>
Date:   Wed, 8 Nov 2023 10:01:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Content-Language: en-US
To:     Gregory Price <gregory.price@memverge.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <david@redhat.com>, <vbabka@suse.cz>, <naoya.horiguchi@linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org> <ZUA/IzTMokFsXS5Y@memverge.com>
 <ZUDFSEvpxxoGWmdG@casper.infradead.org> <ZUCD1dsbrFjdZgVv@memverge.com>
 <bc332eb1-fe00-416d-b915-b2957d7b25b9@huawei.com>
 <ZUpZCsR1rmIau8wv@memverge.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZUpZCsR1rmIau8wv@memverge.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 23:34, Gregory Price wrote:
> On Tue, Nov 07, 2023 at 09:03:53AM +0800, Kefeng Wang wrote:
>>
>>
>> On 2023/10/31 12:34, Gregory Price wrote:
>>> On Tue, Oct 31, 2023 at 09:13:44AM +0000, Matthew Wilcox wrote:
>>>> On Mon, Oct 30, 2023 at 07:41:23PM -0400, Gregory Price wrote:
>>>>> On Mon, Oct 30, 2023 at 11:22:18PM +0000, Matthew Wilcox wrote:
>>>>>> On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
>>>>>>> kpageflags reads page-flags directly from the page, even when the
>>>>>>> respective flag is only updated on the headpage of a folio.
>>>>>>>
>>>>>>> Update bitchecks to use PAGEFLAG() interfaces to check folio for the
>>>>>>> referenced, dirty, lru, active, and unevictable bits.
>>>>>>
>>>>>> But uptodate, writeback and reclaim (amongst others) are also defined
>>>>>> only on the head page.
>>>>>>
>>>>>
>>>>> Ah yes i was only looking at the things defined w/ PAGEFLAG defines in
>>>>> page-flags.h. I'll give it full once over can collect them all, my bad.
>>>>>
>>>>> (also i forgot to update my commit message)
>>>>>
>>>>> Quick question here since i have your attention: any recommendation on
>>>>> what to do for ONLY_HEAD flags?  If the provided page is not the head,
>>>>> should the flag report 0... or whatever the head says?
>>>>
>>>> Thinking about it some more, really almost all flags are per-folio, not
>>>> per-page.  The only exceptions are HWPoison and AnonExclusive.  So
>>>> probably the right way to do this is to make k = folio->flags, and
>>>> then just change a few places rather than changing all the places that
>>>> test 'k'.
>>>
>>> Funny enough that's what i originally did but was confident it was
>>> correct so walked it back.  I'll take another crack at it.
>>
>> Hi Gregory, any update?
>> I changed stable_page_flags[1] when try to remove page idle wrapper,
>> Matthew pointed it will conflict with this, I could redo my patch
>> based on your new version:)
>>
>> [1]https://lore.kernel.org/linux-mm/20231103072906.2000381-5-wangkefeng.wang@huawei.com/
>>
>> Thanks.
> 
> looks like we were noticing the same thing.  I haven't done any further
> work, got caught up in another project.

Yes, I see your "Node Weights and Weighted Interleave", this is an 
interesting topic, we need some easy and efficient way to use tiered
memory.

> 
> Matthew last pointed out:
> 
> "probably the right way to do this is to make k = folio->flags, and then
> just change a few places rather than changing all the places that test
> 'k'."
> 
> https://lore.kernel.org/linux-mm/ZUDFSEvpxxoGWmdG@casper.infradead.org/
> 
> I took a quick look, and the only thing I'm not confident about is that
> some flags are stored in the head page, and some are stored on the
> second page.
> 
> /* Which page is the flag stored in */
> #define FOLIO_PF_ANY            0
> #define FOLIO_PF_HEAD           0
> #define FOLIO_PF_ONLY_HEAD      0
> #define FOLIO_PF_NO_TAIL        0
> #define FOLIO_PF_NO_COMPOUND    0
> #define FOLIO_PF_SECOND         1
> 
> There's only a handful, so yeah the best way is probably to go ahead and
> swap k = page->flags for k = *folio_flags(folio, 0) and then handle the
> couple of outliars.

If you don't mind, I maybe try to convert it in my changes.

Thanks.
> 
> ~Gregory
