Return-Path: <linux-kernel+bounces-22940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B536182A5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5060D28AC78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B06A48;
	Thu, 11 Jan 2024 01:56:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444737E4;
	Thu, 11 Jan 2024 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T9SSh6RXHz4f3jMH;
	Thu, 11 Jan 2024 09:56:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D87F81A027B;
	Thu, 11 Jan 2024 09:56:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDDSp9lDeTkAQ--.49355S3;
	Thu, 11 Jan 2024 09:56:21 +0800 (CST)
Subject: Re: [PATCH v2] md/raid5: fix atomicity violation in raid5_cache_count
To: Gui-Dong Han <2045gemini@gmail.com>, song@kernel.org
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231222045224.4439-1-2045gemini@gmail.com>
 <f311998f-303f-44a6-9525-0611152d521a@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c244cd3c-2a9a-f088-9de8-36beae7adde3@huaweicloud.com>
Date: Thu, 11 Jan 2024 09:56:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f311998f-303f-44a6-9525-0611152d521a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDDSp9lDeTkAQ--.49355S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGryxGr1xur4kJFy7uFyUWrg_yoWrCFWrpF
	s5Aa4UXrWkWwnYyryqvr4kZFWrG398tasrJr4DXay8Za90vFWIqr42gF1Ygry8Ar48GFyx
	tF1Yv3srZr1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/11 9:51, Gui-Dong Han 写道:
> Dear All:
> 
> I hope this email finds you well. I hope you haven't missed my previous 
> email, as I understand that everyone has a busy schedule. I just wanted 
> to follow up on my previous message sent.
> I understand that you may be occupied with other tasks or priorities. 
> However, I would greatly appreciate it if you could spare a few moments 
> to check the patch in my previous email. Your prompt response would be 
> highly valuable to me.
> Thank you for your attention to this matter, and I look forward to 
> hearing from you soon.

I already replied:

https://lore.kernel.org/all/97363298-7aa1-cd42-d2cf-c7e2bbeb179f@huaweicloud.com/

You might need to figure out why if you don't receive the email.

Thanks,
Kuai

> 
> Thanks,
> Han
> 
> On 22/12/2023 下午12:52, Gui-Dong Han wrote:
>> In raid5_cache_count():
>>     if (conf->max_nr_stripes < conf->min_nr_stripes)
>>         return 0;
>>     return conf->max_nr_stripes - conf->min_nr_stripes;
>> The current check is ineffective, as the values could change immediately
>> after being checked.
>>
>> In raid5_set_cache_size():
>>     ...
>>     conf->min_nr_stripes = size;
>>     ...
>>     while (size > conf->max_nr_stripes)
>>         conf->min_nr_stripes = conf->max_nr_stripes;
>>     ...
>>
>> Due to intermediate value updates in raid5_set_cache_size(), concurrent
>> execution of raid5_cache_count() and raid5_set_cache_size() may lead to
>> inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
>> The current checks are ineffective as values could change immediately
>> after being checked, raising the risk of conf->min_nr_stripes exceeding
>> conf->max_nr_stripes and potentially causing an integer overflow.
>>
>> This possible bug is found by an experimental static analysis tool
>> developed by our team. This tool analyzes the locking APIs to extract
>> function pairs that can be concurrently executed, and then analyzes the
>> instructions in the paired functions to identify possible concurrency 
>> bugs
>> including data races and atomicity violations. The above possible bug is
>> reported when our tool analyzes the source code of Linux 6.2.
>>
>> To resolve this issue, it is suggested to introduce local variables
>> 'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
>> values remain stable throughout the check. Adding locks in
>> raid5_cache_count() fails to resolve atomicity violations, as
>> raid5_set_cache_size() may hold intermediate values of
>> conf->min_nr_stripes while unlocked. With this patch applied, our tool no
>> longer reports the bug, with the kernel configuration allyesconfig for
>> x86_64. Due to the lack of associated hardware, we cannot test the patch
>> in runtime testing, and just verify it according to the code logic.
>>
>> Fixes: edbe83ab4c27e ("md/raid5: allow the stripe_cache to grow and ...")
>> Reported-by: BassCheck <bass@buaa.edu.cn>
>> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
>>
>> ---
>> v2:
>> * In this patch v2, we've updated to use READ_ONCE() instead of direct
>> reads for accessing max_nr_stripes and min_nr_stripes, since read and
>> write can concurrent.
>>    Thank Yu Kuai for helpful advice.
>> ---
>>   drivers/md/raid5.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 8497880135ee..9037e46de0e2 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -7391,10 +7391,12 @@ static unsigned long raid5_cache_count(struct 
>> shrinker *shrink,
>>   {
>>       struct r5conf *conf = shrink->private_data;
>> -    if (conf->max_nr_stripes < conf->min_nr_stripes)
>> +    int max_stripes = READ_ONCE(conf->max_nr_stripes);
>> +    int min_stripes = READ_ONCE(conf->min_nr_stripes);
>> +    if (max_stripes < min_stripes)
>>           /* unlikely, but not impossible */
>>           return 0;
>> -    return conf->max_nr_stripes - conf->min_nr_stripes;
>> +    return max_stripes - min_stripes;
>>   }
>>   static struct r5conf *setup_conf(struct mddev *mddev)
> .
> 


