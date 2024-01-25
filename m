Return-Path: <linux-kernel+bounces-38117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974983BB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121D828BDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AE15AF9;
	Thu, 25 Jan 2024 07:57:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCC1798E;
	Thu, 25 Jan 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169478; cv=none; b=bzNodbKQoC8/kn/XGuUD5nq/+yJ3C9c7nD9Wuz+TdXIaUSUEdt4ORLEhVpLNaTMrJemwxktgOI53FWgf+4hDyr7rxd1D3jR8HmOBXy62JWYh8pBRHztecEwmYaZT/XM2Q1LLfGxzuVbwX2YTrR7YgXIsrtt+XsSYVoeBx9uoG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169478; c=relaxed/simple;
	bh=BS7mby3uI4AgQEdXF3cuczOSH/qGPB30Opbg7BnGykA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=akDK4hGXZ7QErMZLel6WTkvT1Z2NjweaIoqG9k7ueBi6UcQ8i0pgiUwsLbiqMWsmq8W0zLtWAgSjqTCC+baCngHG2qItQzX6LFK4HDO26Dtf3eCkov19ZiNu1q/lmTuP9T/llb3r1p6uT1QQUVn5JwGgomflq+KvPAPpQm/KY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLCqF4TWCz4f3mHT;
	Thu, 25 Jan 2024 15:57:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E848E1A017A;
	Thu, 25 Jan 2024 15:57:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF9FLJltc6sBw--.4241S3;
	Thu, 25 Jan 2024 15:57:51 +0800 (CST)
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Xiao Ni <xni@redhat.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww2_hG2_YL1v-d0=uv2=bVzJ2wwpSJyQdBBGMCBx79bot-Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <85eeb8e4-d526-aa20-c50d-7e755ca6c776@huaweicloud.com>
Date: Thu, 25 Jan 2024 15:57:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_hG2_YL1v-d0=uv2=bVzJ2wwpSJyQdBBGMCBx79bot-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF9FLJltc6sBw--.4241S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1rKr4kWr47AF43GrWrGrg_yoWrXF4fp3
	yktFs5Ar4YyrZxXry2qa4DuayFqwn2gFyqyrWfCa4fJas2krZrKF1Y93WUCFykCa48Gr1D
	ta1jqFsxuFy8WrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 15:51, Xiao Ni 写道:
> On Wed, Jan 24, 2024 at 5:19 PM Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> The new heleprs will be used in dm-raid in later patches to fix
>> regressions and prevent calling md_reap_sync_thread() directly.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
>>   drivers/md/md.h |  3 +++
>>   2 files changed, 40 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 6c5d0a372927..90cf31b53804 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>>                  mddev_lock_nointr(mddev);
>>   }
>>
>> -static void idle_sync_thread(struct mddev *mddev)
>> +void md_idle_sync_thread(struct mddev *mddev)
>>   {
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
> 
> Hi Kuai
> 
> There is a building error. It should give a pointer to
> lockdep_assert_held. And same with the other two places in this patch.

Yes, I forgot that I disabled all the debug config in order to let tests
finish quickly.

Thanks for the notince, will fix this in v3.

Thanks,
Kuai

> 
> Regards
> Xiao
> 
>>          mutex_lock(&mddev->sync_mutex);
>>          clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       stop_sync_thread(mddev, true, true);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
>> +
>> +void md_frozen_sync_thread(struct mddev *mddev)
>> +{
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
>> +       mutex_lock(&mddev->sync_mutex);
>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       stop_sync_thread(mddev, true, false);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
>>
>> +void md_unfrozen_sync_thread(struct mddev *mddev)
>> +{
>> +       lockdep_assert_held(mddev->reconfig_mutex);
>> +
>> +       mutex_lock(&mddev->sync_mutex);
>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>> +       md_wakeup_thread(mddev->thread);
>> +       sysfs_notify_dirent_safe(mddev->sysfs_action);
>> +       mutex_unlock(&mddev->sync_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
>> +
>> +static void idle_sync_thread(struct mddev *mddev)
>> +{
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       mutex_lock(&mddev->sync_mutex);
>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, true);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
>>
>>   static void frozen_sync_thread(struct mddev *mddev)
>>   {
>> -       mutex_lock(&mddev->sync_mutex);
>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       mutex_lock(&mddev->sync_mutex);
>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, false);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 8d881cc59799..437ab70ce79b 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>>   extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>>   extern void mddev_resume(struct mddev *mddev);
>> +extern void md_idle_sync_thread(struct mddev *mddev);
>> +extern void md_frozen_sync_thread(struct mddev *mddev);
>> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>>
>>   extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>>   extern void md_update_sb(struct mddev *mddev, int force);
>> --
>> 2.39.2
>>
> 
> .
> 


