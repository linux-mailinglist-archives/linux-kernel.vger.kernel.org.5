Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7876C1EB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHBBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjHBBLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:11:03 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A8C12B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:11:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vosmk5t_1690938657;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vosmk5t_1690938657)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:10:58 +0800
Message-ID: <0bb2bddf-a9e6-a285-da5a-27ac4e114c73@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 09:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-2-shikemeng@huaweicloud.com>
 <6e76323f-a1cc-7d20-676e-4eccdbcf6b91@linux.alibaba.com>
 <9b207dbf-1652-4851-7c6e-16220d5f2f3b@huaweicloud.com>
 <a4a4c935-d7c8-ffba-cf51-6eaeb88ed19c@huaweicloud.com>
 <cb028072-6cf7-05b5-cc47-fddd8f5b1174@linux.alibaba.com>
 <6921ae7e-0c30-0934-168c-9480ca30108f@huaweicloud.com>
 <d5d3dc39-c825-f040-1c1e-ae6c53921331@linux.alibaba.com>
 <7b42d243-c62f-856e-2b8c-ba43528528f0@huaweicloud.com>
 <b04a7905-f19a-6437-0936-f60e6c9c5715@linux.alibaba.com>
 <8b5a1ab4-56d6-cc6a-5213-6586e33a8fdd@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8b5a1ab4-56d6-cc6a-5213-6586e33a8fdd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 8:33 PM, Kemeng Shi wrote:
> 
> 
> on 8/1/2023 5:32 PM, Baolin Wang wrote:
>>
>>
>> On 8/1/2023 4:42 PM, Kemeng Shi wrote:
>>>
>>>
>>> on 8/1/2023 4:01 PM, Baolin Wang wrote:
>>>>
>>>>
>>>> On 8/1/2023 2:08 PM, Kemeng Shi wrote:
>>>>>
>>>>>
>>>>> on 8/1/2023 11:53 AM, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 8/1/2023 10:36 AM, Kemeng Shi wrote:
>>>>>>>
>>>>>>>
>>>>>>> on 8/1/2023 10:18 AM, Kemeng Shi wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> on 7/31/2023 8:01 PM, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 7/29/2023 1:10 AM, Kemeng Shi wrote:
>>>>>>>>>> skip_offline_sections_reverse will return the last pfn in found online
>>>>>>>>>> section. Then we set block_start_pfn to start of page block which
>>>>>>>>>> contains the last pfn in section. Then we continue, move one page
>>>>>>>>>> block forward and ignore the last page block in the online section.
>>>>>>>>>> Make block_start_pfn point to first page block after online section to fix
>>>>>>>>>> this:
>>>>>>>>>> 1. make skip_offline_sections_reverse return end pfn of online section,
>>>>>>>>>> i.e. pfn of page block after online section.
>>>>>>>>>> 2. assign block_start_pfn with next_pfn.
>>>>>>>>>>
>>>>>>>>>> Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")
>>>>>>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>>>>>>> ---
>>>>>>>>>>       mm/compaction.c | 5 ++---
>>>>>>>>>>       1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>>>>>>> index 9b7a0a69e19f..ce7841363b12 100644
>>>>>>>>>> --- a/mm/compaction.c
>>>>>>>>>> +++ b/mm/compaction.c
>>>>>>>>>> @@ -259,7 +259,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>>>>>>>>>>             while (start_nr-- > 0) {
>>>>>>>>>>               if (online_section_nr(start_nr))
>>>>>>>>>> -            return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
>>>>>>>>>> +            return section_nr_to_pfn(start_nr + 1);
>>>>>>>>>
>>>>>>>>> This is incorrect, you returned the start pfn of this section.
>>>>>>>>>
>>>>>>>>>>           }
>>>>>>>>>>             return 0;
>>>>>>>>>> @@ -1670,8 +1670,7 @@ static void isolate_freepages(struct compact_control *cc)
>>>>>>>>>>                     next_pfn = skip_offline_sections_reverse(block_start_pfn);
>>>>>>>>>>                   if (next_pfn)
>>>>>>>>>> -                block_start_pfn = max(pageblock_start_pfn(next_pfn),
>>>>>>>>>> -                              low_pfn);
>>>>>>>>>> +                block_start_pfn = max(next_pfn, low_pfn);
>>>>>>>>>
>>>>>>>>> 'block_start_pfn' should be pageblock aligned. If the 'next_pfn' is not pageblock-aligned (though this is not the common case), we should skip it.
>>>>>>>>>
>>>>>>>>> But if the 'next_pfn' is pageblock-aligned, yes, the commit f63224525309 still ignores the last pageblock, which is not right. So I think it should be:
>>>>>>>>> block_start_pfn = pageblock_aligned(next_pfn) ? : pageblock_start_pfn(next_pfn);
>>>>>>>>> block_start_pfn = max(block_start_pfn, low_pfn);
>>>>>>>>>
>>>>>>>> Hi Baolin, thanks for reply! As skip_offline_sections_reverse is based
>>>>>>>> on skip_offline_sections. I make the assumption that section is pageblock
>>>>>>>> aligned based on that we use section start from skip_offline_sections as
>>>>>>>> block_start_fpn without align check.
>>>>>>>> If section size is not pageblock aligned in real world, the pageblock aligned
>>>>>>>> check should be added to skip_offline_sections and skip_offline_sections_reverse.
>>>>>>>> If no one is against this, I will fix this in next version. THanks!
>>>>>>>>
>>>>>>> More information of aligment of section. For powerpc arch, we have SECTION_SIZE_BITS
>>>>>>> with 24 while PAGE_SHIFT could be configured to 18.
>>>>>>> Pageblock order is (18 + MAX_ORDER) which coule be 28 and is > SECTION_SZIE_BITS 24,
>>>>>>
>>>>>> The maximum pageblock order is MAX_ORDER. But after thinking more, I think return the start pfn or end pfn of a section is okay, and it should be aligned to a pageblock order IIUC.
>>>>>>
>>>>> Right, I mixed up the unit.
>>>>>> So I think your change is good:
>>>>>> + block_start_pfn = max(next_pfn, low_pfn);
>>>>>>
>>>>>> But in skip_offline_sections_reverse(), we should still return the last pfn of the online section.
>>>>>>
>>>>> Sure, then we should assign block_start_pfn with following change. Is this good to you?
>>>>> -                block_start_pfn = max(pageblock_start_pfn(next_pfn),
>>>>> +         block_start_pfn = max(pageblock_end_pfn(next_pfn),
>>>>>                                  low_pfn);
>>>>
>>>> The last pfn of a section is already section aligned, so I think no need to call pageblock_end_pfn(), just like your original change is okay to me.
>>>> block_start_pfn = max(next_pfn, low_pfn);
>>>>
>>>>
>>> Um, if we keep "block_start_pfn = max(next_pfn, low_pfn);", should we also keep
>>> returning end of section "section_nr_to_pfn(start_nr + 1);" instead of original last
>>> pfn of the section "section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;" which seems
>>> not aligned.
>>> Assume SECTION_SIZE_BITS = 27, PAGE_SHIFT = 12, pageblock order = 10
>>> Last pfn of the section 0 is 0x7fff, end pfn of section 0 is 0x8000. The last pfn
>>> is not aligned.
>>> Please tell me if I misunderstand anything. Thanks!
>>
>> Ah, you are right, sorry for my bad arithmetic. Maybe we should return the end pfn (section_nr_to_pfn(start_nr) + PAGES_PER_SECTION) of the section in skip_offline_sections_reverse() with adding some comments to explain the return value like David suggested. Then we can remove the pageblock_end_pfn() in isolate_freepages().
>>
>>
> Sure, I will add comments in next version. As (section_nr_to_pfn(start_nr) + PAGES_PER_SECTION)
> is = section_nr_to_pfn(start_nr + 1), I will keep the change to skip_offline_sections_reverse

IMO, next section is confusing. We need return the end pfn of the 
current online section, and we usually get it by 
"section_nr_to_pfn(start_nr) + PAGES_PER_SECTION".
