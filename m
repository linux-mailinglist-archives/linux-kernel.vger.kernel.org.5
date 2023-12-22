Return-Path: <linux-kernel+bounces-9697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7BC81C9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A7D2876DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6D1803D;
	Fri, 22 Dec 2023 12:21:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m17204.xmail.ntesmail.com (mail-m17204.xmail.ntesmail.com [45.195.17.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07D18026
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from [10.9.0.94] (unknown [211.103.144.18])
	by smtp.qiye.163.com (Hmail) with ESMTPA id AC02A4C0275;
	Fri, 22 Dec 2023 19:41:36 +0800 (CST)
Message-ID: <ba124f2b-3292-4c5d-b5f6-b078ce289838@easystack.cn>
Date: Fri, 22 Dec 2023 19:41:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/kexec: Fix potential out of bounds in
 crash_setup_memmap_entries()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231220055733.100325-1-fuqiang.wang@easystack.cn>
 <20231220055733.100325-2-fuqiang.wang@easystack.cn>
 <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
From: fuqiang wang <fuqiang.wang@easystack.cn>
In-Reply-To: <ZYQ6O/57sHAPxTHm@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh1IVk1CGR9PGRoYTU1NHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
	++
X-HM-Tid: 0a8c9154b5f7022ekunmac02a4c0275
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6HBw4LzczNShCEkgpHkIt
	OhhPCgJVSlVKTEtISU9OSUJMTU9DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
	EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFPQkhPNwY+

在 2023/12/21 21:14, Baoquan He 写道:

> On 12/20/23 at 01:57pm, fuqiang wang wrote:
>> In memmap_exclude_ranges(), there will exclude elfheader from
>> crashk_res. In the current x86 architecture code, the elfheader is
>> always allocated at crashk_res.start. It seems that there won't be a
>> split a new range. But it depends on the allocation position of
>> elfheader in crashk_res. To avoid potential out of bounds in future, Set
>> the array size to 2.
> If so, I would suggest to add extra slot for low 1M too in
> fill_up_crash_elf_data() lest the low 1M could be changed in the future,
> e.g [start, 1M].


Hi Baoquan

This seems to be better for future maintenance. Thank you for your suggestion.

>> But similar issue will not exist in fill_up_crash_elf_data(). Because
>> the range to be excluded is [0, 1M], start (0) is special and will not
>> appear in the middle of existing cmem->ranges[]. I added a comment to
>> explain it.
>>
>> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
>> ---
>>   arch/x86/kernel/crash.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index c92d88680dbf..1c15d0884c90 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -149,6 +149,13 @@ static struct crash_mem *fill_up_crash_elf_data(void)
>>   	/*
>>   	 * Exclusion of crash region and/or crashk_low_res may cause
>>   	 * another range split. So add extra two slots here.
>> +	 *
>> +	 * Exclusion of low 1M may not cause another range split, because the
>> +	 * range of exclude is [0, 1M] and the condition for splitting a new
>> +	 * region is that the start, end parameters are both in a certain
>> +	 * existing region in cmem and cannot be equal to existing region's
>> +	 * start or end. Obviously, the start of [0, 1M] cannot meet this
>> +	 * condition.
>>   	 */
>>   	nr_ranges += 2;
>>   	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
>> @@ -282,9 +289,15 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>   	struct crash_memmap_data cmd;
>>   	struct crash_mem *cmem;
>>   
>> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
>> +	cmem = vzalloc(struct_size(cmem, ranges, 2));
>>   	if (!cmem)
>>   		return -ENOMEM;
>> +	cmem->max_nr_ranges = 2;
>> +
>> +	/* Exclude some ranges from crashk_res and add rest to memmap */
>> +	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
>> +	if (ret)
>> +		goto out;
>>   
>>   	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>   	cmd.params = params;
>> @@ -320,11 +333,6 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>   		add_e820_entry(params, &ei);
>>   	}
>>   
>> -	/* Exclude some ranges from crashk_res and add rest to memmap */
>> -	ret = memmap_exclude_ranges(image, cmem, crashk_res.start, crashk_res.end);
>> -	if (ret)
>> -		goto out;
> And you didn't mention moving above code block up in log. I would
> suggest keeping it as is because it looks more reasonable to be adjacent
> to the following cmem->ranges[] handling.

Yes, baoquan, keeping it as it is may be more coherent.I will post a new patch later.

Thanks
fuqiang

>> -
>>   	for (i = 0; i < cmem->nr_ranges; i++) {
>>   		ei.size = cmem->ranges[i].end - cmem->ranges[i].start + 1;
>>   
>> -- 
>> 2.42.0
>>

