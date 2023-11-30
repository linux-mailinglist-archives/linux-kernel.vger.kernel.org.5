Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5967FF028
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345569AbjK3Nai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbjK3Nad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:30:33 -0500
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 05:30:38 PST
Received: from mail-m6011.netease.com (mail-m6011.netease.com [210.79.60.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A910D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:30:37 -0800 (PST)
Received: from [10.9.0.118] (unknown [211.103.144.18])
        by mail-m2838.qiye.163.com (Hmail) with ESMTPA id 57A6D3C00EC;
        Thu, 30 Nov 2023 21:20:57 +0800 (CST)
Message-ID: <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
Date:   Thu, 30 Nov 2023 21:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
From:   fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUsYVkoYQh9CS0IfSkNKSlUZERMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTUNMTE9VSktLVUpCS0tZBg
        ++
X-HM-Tid: 0a8c2063c1748420kuqw57a6d3c00ec
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Izo5LDE4CRkMEy0aMTAv
        SUowC0hVSlVKTEtKSE5LT05DSElPVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
        EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFPTk1ONwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/11/30 15:44, Baoquan He wrote:
> On 11/27/23 at 10:56am, fuqiang wang wrote:
>> When the split happened, judge whether mem->nr_ranges is equal to
>> mem->max_nr_ranges. If it is true, return -ENOMEM.
>>
>> The advantage of doing this is that it can avoid array bounds caused by
>> some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
>> extra range for crashkres_low."), reserve both high and low memories for
>> the crashkernel may cause out of bounds.
>>
>> On the other hand, move this code before the split to ensure that the
>> array will not be changed when return error.
> If out of array boundary is caused, means the laoding failed, whether
> the out of boundary happened or not. I don't see how this code change
> makes sense. Do I miss anything?
>
> Thanks
> Baoquan
>
Hi baoquan,

In some configurations, out of bounds may not cause crash_exclude_mem_range()
returns error, then the load will succeed.

E.g.
There is a cmem before execute crash_exclude_mem_range():

   cmem = {
     max_nr_ranges = 3
     nr_ranges = 2
     ranges = {
        {start = 1,      end = 1000}
        {start = 1001,    end = 2000}
     }
   }

After executing twice crash_exclude_mem_range() with the start/end params
100/200, 300/400 respectively, the cmem will be:

   cmem = {
     max_nr_ranges = 3
     nr_ranges = 4                    <== nr_ranges > max_nr_ranges
     ranges = {
       {start = 1,       end = 99  }
       {start = 201,     end = 299 }
       {start = 401,     end = 1000}
       {start = 1001,    end = 2000}  <== OUT OF BOUNDS
     }
   }

When an out of bounds occurs during the second execution, the function will not
return error.

Additionally, when the function returns error, means the load failed. It seems
meaningless to keep the original data unchanged. But in my opinion, this will
make this function more rigorous and more versatile. (However, I am not sure if
it is self-defeating and I hope to receive more suggestions).

Thanks
fuqiang


>> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
>> ---
>>   kernel/crash_core.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index efe87d501c8c..ffdc246cf425 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>   		}
>>   
>>   		if (p_start > start && p_end < end) {
>> +			/* Split happened */
>> +			if (mem->nr_ranges == mem->max_nr_ranges)
>> +				return -ENOMEM;
>>   			/* Split original range */
>>   			mem->ranges[i].end = p_start - 1;
>>   			temp_range.start = p_end + 1;
>> @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>   	if (!temp_range.end)
>>   		return 0;
>>   
>> -	/* Split happened */
>> -	if (i == mem->max_nr_ranges - 1)
>> -		return -ENOMEM;
>>   
>>   	/* Location where new range should go */
>>   	j = i + 1;
>> -- 
>> 2.42.0
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
