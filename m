Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062DE76AB41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjHAInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHAIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:42:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C210E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:42:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFTBg2Hr3z4f3lfg
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:42:35 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgB3SK96xchkfh85PQ--.56993S2;
        Tue, 01 Aug 2023 16:42:36 +0800 (CST)
Subject: Re: [PATCH 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-2-shikemeng@huaweicloud.com>
 <6e76323f-a1cc-7d20-676e-4eccdbcf6b91@linux.alibaba.com>
 <9b207dbf-1652-4851-7c6e-16220d5f2f3b@huaweicloud.com>
 <a4a4c935-d7c8-ffba-cf51-6eaeb88ed19c@huaweicloud.com>
 <cb028072-6cf7-05b5-cc47-fddd8f5b1174@linux.alibaba.com>
 <6921ae7e-0c30-0934-168c-9480ca30108f@huaweicloud.com>
 <d5d3dc39-c825-f040-1c1e-ae6c53921331@linux.alibaba.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <7b42d243-c62f-856e-2b8c-ba43528528f0@huaweicloud.com>
Date:   Tue, 1 Aug 2023 16:42:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d5d3dc39-c825-f040-1c1e-ae6c53921331@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3SK96xchkfh85PQ--.56993S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWDZw1UuF1kWw1fuF4UArb_yoW7Aryxpr
        y8JFy7tryDJ348XF1Utw1UuryUtws5Ga1UXr47JF1UAF1qqFn2gryqqr1q9r1jgr48AFyU
        Zr1jyFW7Zr17A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
        1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/1/2023 4:01 PM, Baolin Wang wrote:
> 
> 
> On 8/1/2023 2:08 PM, Kemeng Shi wrote:
>>
>>
>> on 8/1/2023 11:53 AM, Baolin Wang wrote:
>>>
>>>
>>> On 8/1/2023 10:36 AM, Kemeng Shi wrote:
>>>>
>>>>
>>>> on 8/1/2023 10:18 AM, Kemeng Shi wrote:
>>>>>
>>>>>
>>>>> on 7/31/2023 8:01 PM, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 7/29/2023 1:10 AM, Kemeng Shi wrote:
>>>>>>> skip_offline_sections_reverse will return the last pfn in found online
>>>>>>> section. Then we set block_start_pfn to start of page block which
>>>>>>> contains the last pfn in section. Then we continue, move one page
>>>>>>> block forward and ignore the last page block in the online section.
>>>>>>> Make block_start_pfn point to first page block after online section to fix
>>>>>>> this:
>>>>>>> 1. make skip_offline_sections_reverse return end pfn of online section,
>>>>>>> i.e. pfn of page block after online section.
>>>>>>> 2. assign block_start_pfn with next_pfn.
>>>>>>>
>>>>>>> Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")
>>>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>>>> ---
>>>>>>>     mm/compaction.c | 5 ++---
>>>>>>>     1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>>>> index 9b7a0a69e19f..ce7841363b12 100644
>>>>>>> --- a/mm/compaction.c
>>>>>>> +++ b/mm/compaction.c
>>>>>>> @@ -259,7 +259,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>>>>>>>           while (start_nr-- > 0) {
>>>>>>>             if (online_section_nr(start_nr))
>>>>>>> -            return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
>>>>>>> +            return section_nr_to_pfn(start_nr + 1);
>>>>>>
>>>>>> This is incorrect, you returned the start pfn of this section.
>>>>>>
>>>>>>>         }
>>>>>>>           return 0;
>>>>>>> @@ -1670,8 +1670,7 @@ static void isolate_freepages(struct compact_control *cc)
>>>>>>>                   next_pfn = skip_offline_sections_reverse(block_start_pfn);
>>>>>>>                 if (next_pfn)
>>>>>>> -                block_start_pfn = max(pageblock_start_pfn(next_pfn),
>>>>>>> -                              low_pfn);
>>>>>>> +                block_start_pfn = max(next_pfn, low_pfn);
>>>>>>
>>>>>> 'block_start_pfn' should be pageblock aligned. If the 'next_pfn' is not pageblock-aligned (though this is not the common case), we should skip it.
>>>>>>
>>>>>> But if the 'next_pfn' is pageblock-aligned, yes, the commit f63224525309 still ignores the last pageblock, which is not right. So I think it should be:
>>>>>> block_start_pfn = pageblock_aligned(next_pfn) ? : pageblock_start_pfn(next_pfn);
>>>>>> block_start_pfn = max(block_start_pfn, low_pfn);
>>>>>>
>>>>> Hi Baolin, thanks for reply! As skip_offline_sections_reverse is based
>>>>> on skip_offline_sections. I make the assumption that section is pageblock
>>>>> aligned based on that we use section start from skip_offline_sections as
>>>>> block_start_fpn without align check.
>>>>> If section size is not pageblock aligned in real world, the pageblock aligned
>>>>> check should be added to skip_offline_sections and skip_offline_sections_reverse.
>>>>> If no one is against this, I will fix this in next version. THanks!
>>>>>
>>>> More information of aligment of section. For powerpc arch, we have SECTION_SIZE_BITS
>>>> with 24 while PAGE_SHIFT could be configured to 18.
>>>> Pageblock order is (18 + MAX_ORDER) which coule be 28 and is > SECTION_SZIE_BITS 24,
>>>
>>> The maximum pageblock order is MAX_ORDER. But after thinking more, I think return the start pfn or end pfn of a section is okay, and it should be aligned to a pageblock order IIUC.
>>>
>> Right, I mixed up the unit.
>>> So I think your change is good:
>>> + block_start_pfn = max(next_pfn, low_pfn);
>>>
>>> But in skip_offline_sections_reverse(), we should still return the last pfn of the online section.
>>>
>> Sure, then we should assign block_start_pfn with following change. Is this good to you?
>> -                block_start_pfn = max(pageblock_start_pfn(next_pfn),
>> +         block_start_pfn = max(pageblock_end_pfn(next_pfn),
>>                                low_pfn);
> 
> The last pfn of a section is already section aligned, so I think no need to call pageblock_end_pfn(), just like your original change is okay to me.
> block_start_pfn = max(next_pfn, low_pfn);
> 
> 
Um, if we keep "block_start_pfn = max(next_pfn, low_pfn);", should we also keep
returning end of section "section_nr_to_pfn(start_nr + 1);" instead of original last
pfn of the section "section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;" which seems
not aligned.
Assume SECTION_SIZE_BITS = 27, PAGE_SHIFT = 12, pageblock order = 10
Last pfn of the section 0 is 0x7fff, end pfn of section 0 is 0x8000. The last pfn
is not aligned.
Please tell me if I misunderstand anything. Thanks!

-- 
Best wishes
Kemeng Shi

