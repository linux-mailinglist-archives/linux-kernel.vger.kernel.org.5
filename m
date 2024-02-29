Return-Path: <linux-kernel+bounces-86034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3286BECA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB8D1F261E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9D36B01;
	Thu, 29 Feb 2024 02:14:21 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E622612;
	Thu, 29 Feb 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172861; cv=none; b=qR5/ku/YQe+2f/jScHmTE0rF6IjeT/NabzkhaDZ8DuCRDRkbSQYFGu9q8CHQOl64L4xVPenCgFPJL4VSy3fOzvBd3RjU4TQrRB5dtirjR6YXoDCImdtfikyckuCuS18nNiTXMXGnBIxpbQ7vhkznf+z/+YIBvWAHONGD79mthYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172861; c=relaxed/simple;
	bh=YTYbyy3+UTYewtVzLjaJat1vjlG10V1fAJH99Lsa9Pk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VKMruX7/l8FwwhU6zB5V8+djss6NndPgK0nBPrxPJq3c5qRKtAW8wX1spE7IEBUYa6zNmdLyDFlc5gmBqIXh1g4f+9C0YE0kbmlMGqkDhBoCccVuEA5aFL1DJRht10mTL4yL6ZrP35qHwiylLRgDzY3qLCrxPd8UcR83xu1BYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlZXc4X4Fz4f3mJM;
	Thu, 29 Feb 2024 10:14:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F317D1A0B5D;
	Thu, 29 Feb 2024 10:14:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g526N9ld_rlFQ--.55635S3;
	Thu, 29 Feb 2024 10:14:15 +0800 (CST)
Subject: Re: [PATCH v5 05/14] md: don't suspend the array for interrupted
 reshape
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-6-yukuai1@huaweicloud.com>
 <60d75867-8fb7-4c67-96f7-3e5ba65bdbd9@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0f768b3d-d0a2-92ff-e854-74acc9d0ad7a@huaweicloud.com>
Date: Thu, 29 Feb 2024 10:14:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <60d75867-8fb7-4c67-96f7-3e5ba65bdbd9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g526N9ld_rlFQ--.55635S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4DXr4kAw4rKr4rCryUZFb_yoW5AF45pa
	97ta45CrWDA3s3tw4jqry8KFyYkrZ5t398A3s7Ja4UAr13Jr1FgrW3WrWq9F1j9rWxtw4D
	tr1Yq3s3uF1q9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/29 10:10, Xiao Ni 写道:
> 
> 在 2024/2/1 下午5:25, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> md_start_sync() will suspend the array if there are spares that can be
>> added or removed from conf, however, if reshape is still in progress,
> 
> 
> Hi Kuai
> 
> Why md_start_sync can run when reshape is still in progress? 
> md_check_recovery should return without queue sync_work, right?
> 
>> this won't happen at all or data will be corrupted(remove_and_add_spares
>> won't be called from md_choose_sync_action for reshape), hence there is
>> no need to suspend the array if reshape is not done yet.
>>
>> Meanwhile, there is a potential deadlock for raid456:
>>
>> 1) reshape is interrupted;
>>
>> 2) set one of the disk WantReplacement, and add a new disk to the array,
>>     however, recovery won't start until the reshape is finished;
>>
>> 3) then issue an IO across reshpae position, this IO will wait for
>>     reshape to make progress;
>>
>> 4) continue to reshape, then md_start_sync() found there is a spare disk
>>     that can be added to conf, mddev_suspend() is called;
> 
> 
> I c. The answer for my above question is reshape is interrupted and then 
> it continues the reshape, right?
> 

Yes, reshape is interrupted and sync_thread is unregister, then
sync_thread can be registered again to continue reshape.

Thanks,
Kuai

> 
> Best Regards
> 
> Xiao
> 
>>
>> Step 4 and step 3 is waiting for each other, deadlock triggered. Noted
>> this problem is found by code review, and it's not reporduced yet.
>>
>> Fix this porblem by don't suspend the array for interrupted reshape,
>> this is safe because conf won't be changed until reshape is done.
>>
>> Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array 
>> need reconfiguration")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 6c5d0a372927..85fde05c37dd 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9374,12 +9374,17 @@ static void md_start_sync(struct work_struct *ws)
>>       bool suspend = false;
>>       char *name;
>> -    if (md_spares_need_change(mddev))
>> +    /*
>> +     * If reshape is still in progress, spares won't be added or removed
>> +     * from conf until reshape is done.
>> +     */
>> +    if (mddev->reshape_position == MaxSector &&
>> +        md_spares_need_change(mddev)) {
>>           suspend = true;
>> +        mddev_suspend(mddev, false);
>> +    }
>> -    suspend ? mddev_suspend_and_lock_nointr(mddev) :
>> -          mddev_lock_nointr(mddev);
>> -
>> +    mddev_lock_nointr(mddev);
>>       if (!md_is_rdwr(mddev)) {
>>           /*
>>            * On a read-only array we can:
> 
> .
> 


