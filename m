Return-Path: <linux-kernel+bounces-38551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F483C166
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8D1F27153
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21E236123;
	Thu, 25 Jan 2024 11:56:37 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC3405F2;
	Thu, 25 Jan 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183797; cv=none; b=IV1RJYuzfEZ137jkxlYEIv/mSlGGYtwHSFmdjD4paLdZp7XyY2DoIB04tDmT3z185j3zXiqVglkvmbUpL1sJpNjouGZNc3gxWZwJbqIusldew5avTFtbRYUk9MGN93ooYGotxSqWRop0eThO58P9oDBWzyPcmpNCM7KgiuZcknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183797; c=relaxed/simple;
	bh=qinoT8HQhCZeND0T4jPSkjNi98kimDVGbHS0szRkkuY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ffjoqy8aohO1Ak7B9t19Rs3VUwmCyh74QH42qX8XLRCC1CrUqPcx2AH9c2Rd5oqzUBQXhlBg1JryMERysKjSDWvBZo2Or0kYrQcDlzGZMqeE7IHLbGBsFljavI4XFzzxb6w6UC/+8hSBQC+Xj2crtlW+5S2wjm17k0vO0+YfFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLK6g2Z7wz4f3kFl;
	Thu, 25 Jan 2024 19:56:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 50E011A0232;
	Thu, 25 Jan 2024 19:56:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFtTLJlt1a+Bw--.15398S3;
	Thu, 25 Jan 2024 19:56:31 +0800 (CST)
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Xiao Ni <xni@redhat.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, song@kernel.org, neilb@suse.de, heinzm@redhat.com,
 shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww2_V6Cr4j7hMPnMMt-g2w_xfCHQvwBpwbyOk=5rGcap6YA@mail.gmail.com>
 <d7b8043e-c921-8769-f39f-5105f2e866b6@huawei.com>
 <CALTww2_jezrwJu0Vea+0mePBrV_9RwUMZ=J+_WV0KS-ShW1WPg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <56f3ef80-76d1-2d83-5f5d-84736d548b0f@huaweicloud.com>
Date: Thu, 25 Jan 2024 19:56:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_jezrwJu0Vea+0mePBrV_9RwUMZ=J+_WV0KS-ShW1WPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFtTLJlt1a+Bw--.15398S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry8tw4DGF1rCw48tryxKrg_yoWrKw18pr
	W8tFn8Ar4UtrZxXr12q3Wq9asIqw10gFyqqrW3Ga4fJF9xtFnrtF15ZF1UCFykCa4xGr1j
	q3WjgFZxuFyrXr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUosqXDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 19:52, Xiao Ni 写道:
> On Thu, Jan 25, 2024 at 7:42 PM Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> Hi,
>>
>> 在 2024/01/25 19:35, Xiao Ni 写道:
>>> Hi all
>>>
>>> This is the result of lvm2 tests:
>>> make check
>>> ### 426 tests: 319 passed, 74 skipped, 0 timed out, 5 warned, 28
>>> failed   in 56:04.914
>>
>> Are you testing with this patchset? 28 failed is much more than my
>> test result in following:
> 
> Yes, 6.7.0-rc8 with this patch set.
>>
>>> make[1]: *** [Makefile:138: check] Error 1
>>> make[1]: Leaving directory '/root/lvm2/test'
>>> make: *** [Makefile:89: check] Error 2
>>>
>>> Do you know where to check which cases fail?
>>
>> I saved logs and grep keyword "failed:", and the result will look like
>> this:
> 
> I'll use this way to collect the failed cases.

I somehow send out this draft. Please check the other reply.

Kuai
> 
> Regards
> Xiao
>>
>>
>> You can find each test log in the dir test/result/
>>>
>>> Best Regards
>>> Xiao
>>>
>>> On Wed, Jan 24, 2024 at 5:19 PM Yu Kuai <yukuai3@huawei.com> wrote:
>>>>
>>>> The new heleprs will be used in dm-raid in later patches to fix
>>>> regressions and prevent calling md_reap_sync_thread() directly.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
>>>>    drivers/md/md.h |  3 +++
>>>>    2 files changed, 40 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>> index 6c5d0a372927..90cf31b53804 100644
>>>> --- a/drivers/md/md.c
>>>> +++ b/drivers/md/md.c
>>>> @@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mddev, bool locked, bool check_seq)
>>>>                   mddev_lock_nointr(mddev);
>>>>    }
>>>>
>>>> -static void idle_sync_thread(struct mddev *mddev)
>>>> +void md_idle_sync_thread(struct mddev *mddev)
>>>>    {
>>>> +       lockdep_assert_held(mddev->reconfig_mutex);
>>>> +
>>>>           mutex_lock(&mddev->sync_mutex);
>>>>           clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>> +       stop_sync_thread(mddev, true, true);
>>>> +       mutex_unlock(&mddev->sync_mutex);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
>>>> +
>>>> +void md_frozen_sync_thread(struct mddev *mddev)
>>>> +{
>>>> +       lockdep_assert_held(mddev->reconfig_mutex);
>>>> +
>>>> +       mutex_lock(&mddev->sync_mutex);
>>>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>> +       stop_sync_thread(mddev, true, false);
>>>> +       mutex_unlock(&mddev->sync_mutex);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
>>>>
>>>> +void md_unfrozen_sync_thread(struct mddev *mddev)
>>>> +{
>>>> +       lockdep_assert_held(mddev->reconfig_mutex);
>>>> +
>>>> +       mutex_lock(&mddev->sync_mutex);
>>>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>>>> +       md_wakeup_thread(mddev->thread);
>>>> +       sysfs_notify_dirent_safe(mddev->sysfs_action);
>>>> +       mutex_unlock(&mddev->sync_mutex);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
>>>> +
>>>> +static void idle_sync_thread(struct mddev *mddev)
>>>> +{
>>>>           if (mddev_lock(mddev)) {
>>>>                   mutex_unlock(&mddev->sync_mutex);
>>>>                   return;
>>>>           }
>>>>
>>>> +       mutex_lock(&mddev->sync_mutex);
>>>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>>           stop_sync_thread(mddev, false, true);
>>>>           mutex_unlock(&mddev->sync_mutex);
>>>>    }
>>>>
>>>>    static void frozen_sync_thread(struct mddev *mddev)
>>>>    {
>>>> -       mutex_lock(&mddev->sync_mutex);
>>>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>> -
>>>>           if (mddev_lock(mddev)) {
>>>>                   mutex_unlock(&mddev->sync_mutex);
>>>>                   return;
>>>>           }
>>>>
>>>> +       mutex_lock(&mddev->sync_mutex);
>>>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>>           stop_sync_thread(mddev, false, false);
>>>>           mutex_unlock(&mddev->sync_mutex);
>>>>    }
>>>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>>>> index 8d881cc59799..437ab70ce79b 100644
>>>> --- a/drivers/md/md.h
>>>> +++ b/drivers/md/md.h
>>>> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>>>>    extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>>>>    extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>>>>    extern void mddev_resume(struct mddev *mddev);
>>>> +extern void md_idle_sync_thread(struct mddev *mddev);
>>>> +extern void md_frozen_sync_thread(struct mddev *mddev);
>>>> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>>>>
>>>>    extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>>>>    extern void md_update_sb(struct mddev *mddev, int force);
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 


