Return-Path: <linux-kernel+bounces-5073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0008B818643
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6A1C21680
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346915E98;
	Tue, 19 Dec 2023 11:24:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m12814.netease.com (mail-m12814.netease.com [103.209.128.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F998168A7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [10.9.0.234] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 32DC6260110;
	Tue, 19 Dec 2023 16:55:16 +0800 (CST)
Message-ID: <3765549d-892e-4102-9b56-9add1d0a8089@easystack.cn>
Date: Tue, 19 Dec 2023 16:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Content-Language: en-US
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com
References: <c797bdde-b5a5-4b2b-9106-c1386a0e7516@easystack.cn>
 <20231219052955.40414-1-ytcoode@gmail.com>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <20231219052955.40414-1-ytcoode@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUJLVk5JSEsaSx5LSEJOH1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c81495d980276kunm32dc6260110
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Hhw5LjEwCQIIGU4uTEou
	Vj0KFBxVSlVKTEtJQkxNSkpCT09DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFOS0hDNwY+


在 2023/12/19 13:29, Yuntao Wang 写道:
> On Tue, 19 Dec 2023 11:50:32 +0800, fuqiang wang <fuqiang.wang@easystack.cn> wrote:
>> 在 2023/12/19 10:47, Yuntao Wang 写道:
>>
>>> Hi fuqiang,
>>>
>>> Yesterday, I posted two patches that happen to address the bugs you an Baoquan
>>> are currently discussing here, I wasn't aware that you both were also working
>>> on fixing these issues.
>>>
>>> Baoquan suggested I talk to you about it.
>>>
>>> If you're interested, you can take a look at my patches and review them to see
>>> if there are any issues. If everything is fine, and if you're willing, you can
>>> also add a 'Reviewed-by' tag there.
>>>
>>> The following link is for the two patches I posted yesterday:
>>>
>>> https://lore.kernel.org/lkml/20231218081915.24120-3-ytcoode@gmail.com/t/#u
>>>
>>> Sincerely,
>>> Yuntao
>> Hi Yuntao,
>>
>> I'm glad you've also noticed this issue. But I'm sorry, I want to solve this
>> problem myself because this is my first time posting a patch in the community,
>> and I cherish this opportunity very much.
> I can truly understand your feelings because I still remember how thrilled I
> was when my first patch got merged. So keep it up!

Hi Yuntao,

Thanks for your understanding and encourage. :)

>> I have carefully reviewed your patch. There is some changes where my views differ
>> from yours:
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index c92d88680dbf..3be46f4b441e 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -282,10 +282,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>        struct crash_memmap_data cmd;
>>        struct crash_mem *cmem;
>>
>> -    cmem = vzalloc(struct_size(cmem, ranges, 1));
>> -    if (!cmem)
>> -        return -ENOMEM;
>> -
>>        memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>        cmd.params = params;
>>
>> @@ -321,6 +317,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>        }
>>
>>        /* Exclude some ranges from crashk_res and add rest to memmap */
>> +    cmem = vzalloc(struct_size(cmem, ranges, 1));
>> +    if (!cmem)
>> +        return -ENOMEM;
>> +    cmem->max_nr_ranges = 1;
>> +
>>        ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
>>        if (ret)
>>            goto out;
>>
>> 1. I don't feel very good that you have moved vzalloc() to in front of
>> memmap_exclude_ranges. Because if memory allocation fails, there is no need to
>> do anything else afterwards.
> I moved it here because only memmap_exclude_ranges() and the code below it use cmem.
>
> I think it is a good practice to put related code together, which also improves
> code readability.

Thank you very much for your patient comment. This change does indeed improve
readability. But as a combination of these two, how do you feel about moving
crash_setup_memmap_entries() behind vzalloc().
>> 2. The cmem->max_nr_ranges should be set to 2. Because in
>> memmap_exclude_ranges, a cmem->ranges[] will be filled in and if a split occurs
>> later, another one will be added.
> With the current code, image->elf_load_addr should be equal to crashk_res.start,
> so split will not occur in crash_exclude_mem_range(). Therefore, setting
> cmem->max_nr_ranges to 1 is safe.

The image->elf_load_addr is determined by arch_kexec_locate_mem_hole(), this
function can ensure that the value is within the range of [crashk_res.start,
crashk_res.end), but it seems that it cannot guarantee that its value will
always be equal to crashk_res.start. Perhaps I have some omissions, please
point them out.

Thanks
fuqiang
>> Thanks
>> fuqiang

