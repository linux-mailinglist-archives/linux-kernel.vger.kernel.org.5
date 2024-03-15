Return-Path: <linux-kernel+bounces-103961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D387C70E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14F8283311
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF45381;
	Fri, 15 Mar 2024 01:18:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDED517;
	Fri, 15 Mar 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465489; cv=none; b=qc6HwM878QajoCSTBlAZjc6Qv9+MfYoOLvSwiNjHWCaYFOCvLQxMncjpMH26e72Cyd486XVeFzZryo+jLQivSb/1NTyGm0W95NnlDiLBwadTHpWbX17xDoaJz4Fu1UHbCPBN6pR0TAQY3J1/AwayTsHC9jDlEJlXeefB6QwGJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465489; c=relaxed/simple;
	bh=d+rxEvkYZwbRHUDS3ovS2A/fo34HTT7331zC7Dqzl2k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SyRaX+R6GTKwrhFFvzfpA9+ExFyWnKEL68PICMO5Ds/AJnBG0gYWhY8E002UOdo4ORbPN0VQA0QE8q5lSQaS7nPaWMf8194mq3nZKPfWkk4T0oPvurThJge3wFLtrNddUCdrQfpd6w/0s8T0bAYgIL3QEz3bKC6UBhbGh40EOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TwmZm2Pgwz4f3kFj;
	Fri, 15 Mar 2024 09:17:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E5C51A017A;
	Fri, 15 Mar 2024 09:17:58 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7EofNluLLsGw--.32050S3;
	Fri, 15 Mar 2024 09:17:57 +0800 (CST)
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>, yukuai1@huaweicloud.com
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, song@kernel.org, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
 <20240314161211.14002-1-dan@danm.net>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <db4f5f1b-5eba-2cdb-fad0-7aa725cea508@huaweicloud.com>
Date: Fri, 15 Mar 2024 09:17:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240314161211.14002-1-dan@danm.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7EofNluLLsGw--.32050S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF43Gry8KF17KFyrZF4rGrg_yoW5WFyrpr
	Wqva1Y9F4UWr98XasrA3yjg34Fvw1IgFW2yFyrC3Z7ZasYgrW3t3yrJryUGrs8Jan3KF4S
	vFyYy3sxWr48KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/15 0:12, Dan Moulding Ð´µÀ:
>> How about the following patch?
>>
>> Thanks,
>> Kuai
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 3ad5f3c7f91e..0b2e6060f2c9 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -6720,7 +6720,6 @@ static void raid5d(struct md_thread *thread)
>>
>>           md_check_recovery(mddev);
>>
>> -       blk_start_plug(&plug);
>>           handled = 0;
>>           spin_lock_irq(&conf->device_lock);
>>           while (1) {
>> @@ -6728,6 +6727,14 @@ static void raid5d(struct md_thread *thread)
>>                   int batch_size, released;
>>                   unsigned int offset;
>>
>> +               /*
>> +                * md_check_recovery() can't clear sb_flags, usually
>> because of
>> +                * 'reconfig_mutex' can't be grabbed, wait for
>> mddev_unlock() to
>> +                * wake up raid5d().
>> +                */
>> +               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>> +                       goto skip;
>> +
>>                   released = release_stripe_list(conf,
>> conf->temp_inactive_list);
>>                   if (released)
>>                           clear_bit(R5_DID_ALLOC, &conf->cache_state);
>> @@ -6766,8 +6773,8 @@ static void raid5d(struct md_thread *thread)
>>                           spin_lock_irq(&conf->device_lock);
>>                   }
>>           }
>> +skip:
>>           pr_debug("%d stripes handled\n", handled);
>> -
>>           spin_unlock_irq(&conf->device_lock);
>>           if (test_and_clear_bit(R5_ALLOC_MORE, &conf->cache_state) &&
>>               mutex_trylock(&conf->cache_size_mutex)) {
>> @@ -6779,6 +6786,7 @@ static void raid5d(struct md_thread *thread)
>>                   mutex_unlock(&conf->cache_size_mutex);
>>           }
>>
>> +       blk_start_plug(&plug);
>>           flush_deferred_bios(conf);
>>
>>           r5l_flush_stripe_to_raid(conf->log);
> 
> I can confirm that this patch also works. I'm unable to reproduce the
> hang after applying this instead of the first patch provided by
> Junxiao. So looks like both ways are succesful in avoiding the hang.
> 

Thanks a lot for the testing! Can you also give following patch a try?
It removes the change to blk_plug, because Dan and Song are worried
about performance degradation, so we need to verify the performance
before consider that patch.

Anyway, I think following patch can fix this problem as well.

Thanks,
Kuai

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3ad5f3c7f91e..ae8665be9940 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6728,6 +6728,9 @@ static void raid5d(struct md_thread *thread)
                 int batch_size, released;
                 unsigned int offset;

+               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+                       goto skip;
+
                 released = release_stripe_list(conf, 
conf->temp_inactive_list);
                 if (released)
                         clear_bit(R5_DID_ALLOC, &conf->cache_state);
@@ -6766,6 +6769,7 @@ static void raid5d(struct md_thread *thread)
                         spin_lock_irq(&conf->device_lock);
                 }
         }
+skip:
         pr_debug("%d stripes handled\n", handled);

         spin_unlock_irq(&conf->device_lock);


> -- Dan
> .
> 


