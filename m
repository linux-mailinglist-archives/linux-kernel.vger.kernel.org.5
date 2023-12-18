Return-Path: <linux-kernel+bounces-3396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D70816BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A2128407D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2D118648;
	Mon, 18 Dec 2023 11:01:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m92231.xmail.ntesmail.com (mail-m92231.xmail.ntesmail.com [103.126.92.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01D179B4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [10.9.0.122] (unknown [211.103.144.18])
	by mail-m3159.qiye.163.com (Hmail) with ESMTPA id B9B196402AA;
	Mon, 18 Dec 2023 16:31:57 +0800 (CST)
Message-ID: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
Date: Mon, 18 Dec 2023 16:31:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
 <ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSRlJVhgYSk8eH0NPGUIZTlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c7c0da4b2009fkurmb9b196402aa
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MT46Eyo*FjEzGQwBQi48AhlM
	F00aCS9VSlVKTEtJQ0NDSEpCS0tLVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFMTE1KNwY+


在 2023/12/14 18:29, Baoquan He 写道:
> On 11/30/23 at 09:20pm, fuqiang wang wrote:
>> On 2023/11/30 15:44, Baoquan He wrote:
>>> On 11/27/23 at 10:56am, fuqiang wang wrote:
>>>> When the split happened, judge whether mem->nr_ranges is equal to
>>>> mem->max_nr_ranges. If it is true, return -ENOMEM.
>>>>
>>>> The advantage of doing this is that it can avoid array bounds caused by
>>>> some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
>>>> extra range for crashkres_low."), reserve both high and low memories for
>>>> the crashkernel may cause out of bounds.
>>>>
>>>> On the other hand, move this code before the split to ensure that the
>>>> array will not be changed when return error.
>>> If out of array boundary is caused, means the laoding failed, whether
>>> the out of boundary happened or not. I don't see how this code change
>>> makes sense. Do I miss anything?
>>>
>>> Thanks
>>> Baoquan
>>>
>> Hi baoquan,
>>
>> In some configurations, out of bounds may not cause crash_exclude_mem_range()
>> returns error, then the load will succeed.
>>
>> E.g.
>> There is a cmem before execute crash_exclude_mem_range():
>>
>>    cmem = {
>>      max_nr_ranges = 3
>>      nr_ranges = 2
>>      ranges = {
>>         {start = 1,      end = 1000}
>>         {start = 1001,    end = 2000}
>>      }
>>    }
>>
>> After executing twice crash_exclude_mem_range() with the start/end params
>> 100/200, 300/400 respectively, the cmem will be:
>>
>>    cmem = {
>>      max_nr_ranges = 3
>>      nr_ranges = 4                    <== nr_ranges > max_nr_ranges
>>      ranges = {
>>        {start = 1,       end = 99  }
>>        {start = 201,     end = 299 }
>>        {start = 401,     end = 1000}
>>        {start = 1001,    end = 2000}  <== OUT OF BOUNDS
>>      }
>>    }
> Let me borrow your example and copy them here, but I will switch the
> order of start/end params 100/200, 300/400 executing at below:
>
> There is a cmem before execute crash_exclude_mem_range():
>
>    cmem = {
>      max_nr_ranges = 3
>      nr_ranges = 2
>      ranges = {
>         {start = 1,      end = 1000}
>         {start = 1001,    end = 2000}
>      }
>    }
>
> After executing twice crash_exclude_mem_range() with the start/end params
> 300/400, the cmem will be:
>
>    cmem = {
>      max_nr_ranges = 3
>      nr_ranges = 3                    <== nr_ranges == max_nr_ranges
>      ranges = {
>        {start = 1,       end = 299  }  i=0
>        {start = 401,     end = 1000}   i=1
>        {start = 1001,    end = 2000}   i=2
>      }
>    }
> When it's executing the 100/200 excluding, we have:
>
>    cmem = {
>      max_nr_ranges = 3
>      nr_ranges = 4                    <== nr_ranges > max_nr_ranges
>      ranges = {
>        {start = 1,       end = 99  }   i=0
>        {start = 401,     end = 1000}
>        {start = 1001,    end = 2000}
>      }
>    }
>
> Then splitting happened, i == 0, then for loop is broken and jump out.
> Then we have the condition checking here:
>
> 	/* Split happened */
>          if (i == mem->max_nr_ranges - 1)
>                  return -ENOMEM;
>
> Obviously the conditonal checking is incorrect (given the i == 0 in
> above case), it should be
>
> 	/* Split happened */
> 	if (mem->nr_ranges == mem->max_nr_ranges)
>                  return -ENOMEM;
>
> So, now there are two things which need be combed up in
> crash_exclude_mem_range():
>
> 1) the above conditional check is incorrect, need be fixed;
> 2) whether we need have the cmem->ranges[] partly changed, or keep it
> unchanged when OOB happened;
Hi baoquan,

I'm sorry, I would like to confirm if I misunderstood the meaning of your
comment or not.  What you mean is that you have agreed to merge the patch, but
before that, it needs to be explained in detail in the commit message. Is this
understanding correct?

> And also the incorrect handling in crash_setup_memmap_entries():
> 1) the insufficient array slot in crash_setup_memmap_entries();
> 2) the uninitialized cmem->max_nr_ranges;
>
If this patch can be merged, the issue of the uninitialized cmem->max_nr_ranges
must be resolved before the patch is merged because this patch requires a
initialized max_nr_ranges value. I am willing to take on the task of addressing
those issues.

Thanks
fuqiang
>> When an out of bounds occurs during the second execution, the function will not
>> return error.
>>
>> Additionally, when the function returns error, means the load failed. It seems
>> meaningless to keep the original data unchanged. But in my opinion, this will
>> make this function more rigorous and more versatile. (However, I am not sure if
>> it is self-defeating and I hope to receive more suggestions).
>>
>> Thanks
>> fuqiang
>>
>>
>>>> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
>>>> ---
>>>>    kernel/crash_core.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index efe87d501c8c..ffdc246cf425 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>>>    		}
>>>>    		if (p_start > start && p_end < end) {
>>>> +			/* Split happened */
>>>> +			if (mem->nr_ranges == mem->max_nr_ranges)
>>>> +				return -ENOMEM;
>>>>    			/* Split original range */
>>>>    			mem->ranges[i].end = p_start - 1;
>>>>    			temp_range.start = p_end + 1;
>>>> @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>>>    	if (!temp_range.end)
>>>>    		return 0;
>>>> -	/* Split happened */
>>>> -	if (i == mem->max_nr_ranges - 1)
>>>> -		return -ENOMEM;
>>>>    	/* Location where new range should go */
>>>>    	j = i + 1;
>>>> -- 
>>>> 2.42.0
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>>

