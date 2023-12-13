Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A898112A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379195AbjLMNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLMNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:20:27 -0500
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 05:20:31 PST
Received: from mail-m17207.xmail.ntesmail.com (mail-m17207.xmail.ntesmail.com [45.195.17.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ECCEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:20:31 -0800 (PST)
Received: from [10.9.0.122] (unknown [211.103.144.18])
        by smtp.qiye.163.com (Hmail) with ESMTPA id 32B6F560105;
        Wed, 13 Dec 2023 21:10:03 +0800 (CST)
Message-ID: <92a1bdff-e988-48ff-8e78-2998834a3e02@easystack.cn>
Date:   Wed, 13 Dec 2023 21:10:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
 <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
 <e588c619-9b97-4627-bce1-b595c757e5c4@easystack.cn>
 <ZXk2oBf/T1Ul6o0c@MiWiFi-R3L-srv>
From:   fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZXk2oBf/T1Ul6o0c@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx1CVhlISEIfGhhPT0MYT1UZERMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
        ++
X-HM-Tid: 0a8c634c72cf0278kunm32b6f560105
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46SBw6ODE*PwkBMT0#TBFN
        EUtPCQ5VSlVKTEtJT0xIS0tPTEJNVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
        EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFNSUtLNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/12/13 12:44, Baoquan He 写道:

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
>>
>> When an out of bounds occurs during the second execution, the function will not
>> return error.
>>
>> Additionally, when the function returns error, means the load failed. It seems
>> meaningless to keep the original data unchanged. But in my opinion, this will
>> make this function more rigorous and more versatile. (However, I am not sure if
>> it is self-defeating and I hope to receive more suggestions).
> Sorry for late reply.
>
> I checked the code again, there seems to be cases out of bounds occur
> very possiblly. We may need to enlarge the cmem array to avoid the risk.
>
> In below draft code, we need add another slot to exclude the low 1M area
> when preparing elfcorehdr. And to exclude the elf header region from
> crash kernel region, we need create the cmem with 2 slots.
>
> With these change, we can absolutely avoid out of bounds occurence.
> What do you think?
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 1715e5f06a59..21facabcf699 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -147,10 +147,10 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>   		return NULL;
>   
>   	/*
> -	 * Exclusion of crash region and/or crashk_low_res may cause
> -	 * another range split. So add extra two slots here.
> +	 * Exclusion of low 1M, crash region and/or crashk_low_res may
> +	 * cause another range split. So add extra two slots here.
>   	 */
> -	nr_ranges += 2;
> +	nr_ranges += 3;
>   	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>   	if (!cmem)
>   		return NULL;
Hi baoquan,

Exclusion of low 1M may not cause new region. Because when calling
crash_exclude_mem_range(), the start parameter is 0 and the condition for
splitting a new region is that the start, end parameters are both in a certain
existing region in cmem and cannot be equal to existing region's start or end.
Obviously, start (0) cannot meet this condition.
> @@ -282,7 +282,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>   	struct crash_memmap_data cmd;
>   	struct crash_mem *cmem;
>   
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>   	if (!cmem)
>   		return -ENOMEM;
>   
>
Yes, you are right. Exclude the elf header region from crash kernel region may
cause split a new region. And there seems to be another issue with this code
path: Before calling crash_exclude_mem_range(), cmem->max_nr_ranges was not
initialized.

In my opinion, these change can absolutely avoid out of bounds occurence. But
when we forget to modify max_nr_ranges due to a mistakes in the future, is it
better to report it by returning an error through crash_exclude_mem_range().
What do you think about it?

Thanks
fuqiang
