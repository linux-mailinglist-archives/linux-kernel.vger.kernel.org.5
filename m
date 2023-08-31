Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3975F78EF95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbjHaObD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:31:02 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C4D7;
        Thu, 31 Aug 2023 07:30:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VqySyaf_1693492251;
Received: from 30.0.139.142(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VqySyaf_1693492251)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 22:30:52 +0800
Message-ID: <e0088370-1ff9-a8df-65a6-bc4ae393b4dc@linux.alibaba.com>
Date:   Thu, 31 Aug 2023 22:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] mm/khugepaged: increase
 transparent_hugepage_recommend_disable parameter to disable active
 modification of min_free_kbytes
To:     Yang Shi <shy828301@gmail.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230817035155.84230-1-liusong@linux.alibaba.com>
 <CAHbLzkrUQ2i0jtgiDf25t_VD4W8hm3jZvd=N=dTyCqvFXc8Q1g@mail.gmail.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <CAHbLzkrUQ2i0jtgiDf25t_VD4W8hm3jZvd=N=dTyCqvFXc8Q1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/8/30 04:04, Yang Shi 写道:

> On Wed, Aug 16, 2023 at 8:52 PM Liu Song <liusong@linux.alibaba.com> wrote:
>> In the arm64 environment, when PAGESIZE is 4K, the "pageblock_nr_pages"
>> value is 512, and the recommended min_free_kbytes in
>> "set_recommended_min_free_kbytes" usually does not exceed 44MB.
>>
>> However, when PAGESIZE is 64K, the "pageblock_nr_pages" value is 8192,
>> and the recommended min_free_kbytes in "set_recommended_min_free_kbytes"
>> is 8192 * 2 * (2 + 9) * 64K, which directly increases to 11GB.
>>
>> According to this calculation method, due to the modification of min_free_kbytes,
>> the reserved memory in my 128GB memory environment reaches 10GB, and MemAvailable
>> is correspondingly reduced by 10GB.
>>
>> In the case of PAGESIZE 64K, transparent hugepages are 512MB, and we only
>> need them to be used on demand. If transparent hugepages cannot be allocated,
>> falling back to regular 64K pages is completely acceptable.
>>
>> Therefore, we added the transparent_hugepage_recommend_disable parameter
>> to disable active modification of min_free_kbytes, thereby meeting our
>> requirements for transparent hugepages in the 64K scenario, and it will
>> not excessively reduce the available memory.
> Thanks for debugging this. I agree 11GB for min_free_kbytes is too
> much. But a kernel parameter sounds overkilling to me either. IMHO we
> just need to have a better scaling for bigger base page size. For
> example, we just keep one or two pageblock for min_free_kbytes when
> the base page size is bigger than 4K.
>
Thank you very much for your advice, but how do we determine the number 
of pageblocks?
This is a difficult number to determine. When PAGESIZE is 64K, arm64 
supports hugepages
of 2M, 512M, and 16G, which can meet the requirements of scenarios that 
require hugepages.

However, transparent huge pages can only support 512M, and 512M is a 
very large number, so
enabling transparent huge pages should be carefully considered, not to 
mention whether it makes
sense to reserve such a large amount of memory.

Therefore, I think that in the scenario of 64K PAGESIZE, it might also 
be a good choice to directly
cancel set_recommended_min_free_kbytes?

Thanks


>> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  5 +++++
>>   mm/khugepaged.c                               | 20 ++++++++++++++++++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 654d0d921101..612bdf601cce 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6553,6 +6553,11 @@
>>                          See Documentation/admin-guide/mm/transhuge.rst
>>                          for more details.
>>
>> +       transparent_hugepage_recommend_disable
>> +                       [KNL,THP]
>> +                       Can be used to disable transparent hugepage to actively modify
>> +                       /proc/sys/vm/min_free_kbytes during enablement process.
>> +
>>          trusted.source= [KEYS]
>>                          Format: <string>
>>                          This parameter identifies the trust source as a backend
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 78fc1a24a1cc..ac40c618f4f6 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -88,6 +88,9 @@ static unsigned int khugepaged_max_ptes_none __read_mostly;
>>   static unsigned int khugepaged_max_ptes_swap __read_mostly;
>>   static unsigned int khugepaged_max_ptes_shared __read_mostly;
>>
>> +/* default enable recommended */
>> +static unsigned int transparent_hugepage_recommend __read_mostly = 1;
>> +
>>   #define MM_SLOTS_HASH_BITS 10
>>   static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>>
>> @@ -2561,6 +2564,11 @@ static void set_recommended_min_free_kbytes(void)
>>                  goto update_wmarks;
>>          }
>>
>> +       if (!transparent_hugepage_recommend) {
>> +               pr_info("do not allow to recommend modify min_free_kbytes\n");
>> +               return;
>> +       }
>> +
>>          for_each_populated_zone(zone) {
>>                  /*
>>                   * We don't need to worry about fragmentation of
>> @@ -2591,7 +2599,10 @@ static void set_recommended_min_free_kbytes(void)
>>
>>          if (recommended_min > min_free_kbytes) {
>>                  if (user_min_free_kbytes >= 0)
>> -                       pr_info("raising min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>> +                       pr_info("raising user specified min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>> +                               min_free_kbytes, recommended_min);
>> +               else
>> +                       pr_info("raising default min_free_kbytes from %d to %lu to help transparent hugepage allocations\n",
>>                                  min_free_kbytes, recommended_min);
>>
>>                  min_free_kbytes = recommended_min;
>> @@ -2601,6 +2612,13 @@ static void set_recommended_min_free_kbytes(void)
>>          setup_per_zone_wmarks();
>>   }
>>
>> +static int __init setup_transparent_hugepage_recommend_disable(char *str)
>> +{
>> +       transparent_hugepage_recommend = 0;
>> +       return 1;
>> +}
>> +__setup("transparent_hugepage_recommend_disable", setup_transparent_hugepage_recommend_disable);
>> +
>>   int start_stop_khugepaged(void)
>>   {
>>          int err = 0;
>> --
>> 2.19.1.6.gb485710b
>>
>>
