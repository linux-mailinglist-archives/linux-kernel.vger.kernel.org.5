Return-Path: <linux-kernel+bounces-44024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BED841C52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CADB1C24DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F54CDEC;
	Tue, 30 Jan 2024 07:04:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F657864;
	Tue, 30 Jan 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598249; cv=none; b=rBN991/j3AxSUEwumZey9f5N6XN1SPbnW+0BRqhsJujjHK+PACILN0xczl3P7pS8NePgUvN4wP+qZc5JQ/qG+ayCkdOR68VjQLhn313hAiTa+GTb2T1AO/hUT4XUvRkTzeEcrXmx6vuGisK+64kkYaP1RVcT1Zn+xEDBhWM+cQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598249; c=relaxed/simple;
	bh=cp+vNae2Kyxr8hSqHTbnUBDSy19wGrtbSz0IwvhrIzg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZLfKRKIk9dDIpzvV1tph7oqFvvT/DktTo3zgDddzA1eclbhE7dDgteDt4Wze96/Hm+1eLm9xDSj5f6Av2fpvP+LNhAu3B9CG8qrmYWQmPr693o/aDN6c+Gk2uUf17XCcuX3zIS5gRzHR2PEg/dvig0xfNurhtLEqSXQNFHBY0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TPGNt4fQ6z4f3khK;
	Tue, 30 Jan 2024 15:03:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C05EB1A01E9;
	Tue, 30 Jan 2024 15:04:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFhn7hlr7+zCQ--.41571S3;
	Tue, 30 Jan 2024 15:04:02 +0800 (CST)
Subject: Re: [PATCH -next 3/3] md: use interruptible apis in
 idle/frozen_sync_thread()
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231228125553.2697765-1-yukuai1@huaweicloud.com>
 <20231228125553.2697765-4-yukuai1@huaweicloud.com>
 <CAPhsuW5ck33wdFznkpXzZmyW3ux3gCf-yhQnevdirjVJkmzmEA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <864b3e44-ba1b-3bfe-c17e-3e6048fbea01@huaweicloud.com>
Date: Tue, 30 Jan 2024 15:04:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5ck33wdFznkpXzZmyW3ux3gCf-yhQnevdirjVJkmzmEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFhn7hlr7+zCQ--.41571S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW5JrWDCFW7Jr4xJF4xWFg_yoWrZr1Upr
	W7WFW5Ar4UAr4akwsFqa1vyFyFyw1fXw4Dtry3Ga4fJw15Kr4DKFy8KFy5uF95CFyrJw17
	Xa15AFs3Ca4vy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/30 14:37, Song Liu 写道:
> Hi,
> 
> Sorry for the late reply.
> 
> The first two patches of the set look good, so I applied them to
> md-tmp-6.9 branch. However, this one needs a respin.

We are fixing dm-raid regressions, so I'll not send a new version until
that work is done. :)
> 
> On Thu, Dec 28, 2023 at 4:58 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Before refactoring idle and frozen from action_store, interruptible apis
>> is used so that hungtask warning won't be triggered if it takes too long
>> to finish idle/frozen sync_thread. So change to use interruptible apis.
> 
> This paragraph is confusing. Please rephrase it.
> 
>>
>> In order not to make stop_sync_thread() more complicated, factor out a
>> helper prepare_to_stop_sync_thread() to replace stop_sync_thread().
>>
>> Also return error to user if idle/frozen_sync_thread() failed, otherwise
>> user will be misleaded.
> 
> s/misleaded/misled/
> 
>>
>> Fixes: 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix deadlock")
>> Fixes: 8e8e2518fcec ("md: Close race when setting 'action' to 'idle'.")
> 
> Please add more information about what is being fixed here, so that
> we can make a clear decision on whether the fix needs to be back
> ported to stable kernels.

8e8e2518fcec added the interruptible apis first, however, it doesn't
return error to user if it's interrupted.

130443d60b1b deleted the interruptible apis.

Perhaps I should split this patch into two minor patches, one for each
fixed tag.

> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 105 ++++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 60f99768a1a9..9ea05de79fe4 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4846,26 +4846,34 @@ action_show(struct mddev *mddev, char *page)
>>          return sprintf(page, "%s\n", type);
>>   }
>>
>> +static bool sync_thread_stopped(struct mddev *mddev, int *sync_seq)
> 
> I think we need a comment for this.
> 
>> +{
>> +       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> +               return true;
>> +
>> +       if (sync_seq && *sync_seq != atomic_read(&mddev->sync_seq))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>   /**
>> - * stop_sync_thread() - wait for sync_thread to stop if it's running.
>> + * prepare_to_stop_sync_thread() - prepare to stop sync_thread if it's running.
>>    * @mddev:     the array.
>> - * @locked:    if set, reconfig_mutex will still be held after this function
>> - *             return; if not set, reconfig_mutex will be released after this
>> - *             function return.
>> - * @check_seq: if set, only wait for curent running sync_thread to stop, noted
>> - *             that new sync_thread can still start.
>> + * @unlock:    whether or not caller want to release reconfig_mutex if
>> + *             sync_thread is not running.
>> + *
>> + * Return true if sync_thread is running, release reconfig_mutex and do
>> + * preparatory work to stop sync_thread, caller should wait for
>> + * sync_thread_stopped() to return true. Return false if sync_thread is not
>> + * running, reconfig_mutex will be released if @unlock is set.
>>    */
> 
> I found prepare_to_stop_sync_thread very hard to reason. Please try to
> rephrase the comment or refactor the code. Maybe it makes sense to put
> the following logic and its variations to a separate function:
> 
>          if (prepare_to_stop_sync_thread(mddev, false)) {
>                  wait_event(resync_wait, sync_thread_stopped(mddev, NULL));
>                  mddev_lock_nointr(mddev);
>          }

I can do this, but there are 5 callers and only two of them can use the
separate caller. Pehaps something like this?

void stop_sync_thread(struct mddev *mddev, bool wait_sb)
{
	if (prepare_to_stop_sync_thread(mddev, wait_sb)) {
		wait_event(resync_wait, ...);
		if (!wait_sb) {
			mddev_lock_nointr(mddev);
			return;
		}
	}

	if (wait_sb) {
		wait_event(sb_wait, ...);
		mddev_lock_nointr(mddev);
	}
}

int stop_sync_thread_interruptible(struct mddev *mddev, bool check_sync_seq)
{
..
}

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>> -static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>> +static bool prepare_to_stop_sync_thread(struct mddev *mddev, bool unlock)
>>   {
>> -       int sync_seq;
> 
> [...]
> .
> 


