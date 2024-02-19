Return-Path: <linux-kernel+bounces-70899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DEF859DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C1D1F2327B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EA23763;
	Mon, 19 Feb 2024 07:53:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22D23748;
	Mon, 19 Feb 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329213; cv=none; b=Ix5mshB8p2oUp5fk4LwomS/e9dP4LDYOH+cWJTs2B7VRfXZQGf2Lxl5h/EcfG0LBZHB7et1Av/aq8bM9Sx3DFfbM+wiV5pAelIGR2yfhr1bgJ6VMnwGB+jTjGRjKFUMMykt5nMJ4PxczIi3SYUWZjpITuLUokoLimKAaN1YSzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329213; c=relaxed/simple;
	bh=56k4hMKstsjBxMm2cw7pKYsa3et4070o8h6yOOWm6Pc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PBBUxhTvaFamd2RYu0xqYDwxxsRwUp8+pqyvZYX2D7grUpfiH1It4e089/7882nFGZBLUKmM1hpj0aHLD5+uEeLZfmgXOg82OFLG1LjldqpyktigCQGTU8dalQikNRp0P1RXT81fI9Oon3izw/OERJNUW5y5ol7YVQ+ONiAL7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TdZXV5WMkz4f3pHc;
	Mon, 19 Feb 2024 15:53:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C90BA1A0232;
	Mon, 19 Feb 2024 15:53:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7tCNNlftHqEQ--.22470S3;
	Mon, 19 Feb 2024 15:53:19 +0800 (CST)
Subject: Re: [PATCH v5 09/14] dm-raid: really frozen sync_thread during
 suspend
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-10-yukuai1@huaweicloud.com>
 <CALTww2_ppGe29wMOsLS45kR4YS6TyCTBswmeKyVE+-H6XmoN+g@mail.gmail.com>
 <3c062731-3b74-2b3e-94c8-ffdf940df014@huaweicloud.com>
 <CALTww29wMJffDUddW526aLbcArqkZVZnrjfuFjOEMUgBMD=AZA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <afc67a7d-60b9-ae78-77b3-19bfb2df5f86@huaweicloud.com>
Date: Mon, 19 Feb 2024 15:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww29wMJffDUddW526aLbcArqkZVZnrjfuFjOEMUgBMD=AZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ7tCNNlftHqEQ--.22470S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyDWr1fKr1rZr4ftF1rXrb_yoW3tr4fpr
	W8tF4Yyr4UJrW7Aa9Fv3WvqFWYyw1YqrWUXr93Ga45J3ZIy3Z3GFy0yr4UuFWvyFyxJ3Wj
	yw4qyay3CFWDKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/02/19 15:27, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 2:34 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 12:53, Xiao Ni 写道:
>>> Hi Kuai
>>>
>>> On Thu, Feb 1, 2024 at 5:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> 1) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen,
>>>>      it only prevent new sync_thread to start, and it can't stop the
>>>>      running sync thread;
>>>
>>> Agree with this
>>>
>>>> 2) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, use
>>>>      it as condition for md_stop_writes() in raid_postsuspend() doesn't
>>>>      look correct.
>>>
>>> I don't agree with it. __md_stop_writes stops sync thread, so it needs
>>> to check this flag. And It looks like the name __md_stop_writes is not
>>> right. Does it really stop write io? mddev_suspend should be the
>>> function that stop write request. From my understanding,
>>> raid_postsuspend does two jobs. One is stopping sync thread. Two is
>>> suspending array.
>>
>> MD_RECOVERY_FROZEN is not just used in __md_stop_writes(), so I think
>> it's not correct to to check this. For example, if MD_RECOVERY_FROZEN is
>> set by raid_message(), then __md_stop_writes() will be skipped.
> 
> Hi Kuai
> 
> raid_message sets MD_RECOVERY_FROZEN and it stops the sync thread
> synchronously. So it doesn't need __md_stop_writes. So from md and
> dmraid, it has a rule. If you set MD_RECOVERY_FROZEN, you're in the
> process of stopping sync thread.

There are so much problems here, I'm not sure if you really walk through
all patches here.

1) stop the sync_thread synchronously is problematic, and raid_message()
doesn't even hold 'reconfig_mutex' for md_reap_sync_thread();
2) skip __md_stop_writes() because sycn_thread is stopped is wrong,
__md_stop_writes() does more work.
> 
>>
>>>
>>>> 3) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
>>>>      and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
>>>>      new sync_thread can start unexpected.
>>>
>>> md_action_store doesn't check this either. If the array is suspended
>>> and MD_RECOVERY_FROZEN is cleared, before patch01, sync thread can't
>>> happen. So it looks like patch01 breaks the logic.
>>
>> The difference is that md/raid doen't need to frozen sync_thread while
>> suspending the array for now. And I don't understand at all why sync
>> thread can't happed before patch01.
> 
> There is a condition you mentioned above -- the array is suspended.
> Before patch01, if one array is suspended, the sync thread can't
3) before patch 1, sync_thread can still running even if array is
suspended;
And even without patch 1, raid_message() can still start new
sync_thread:

// assume sync_thread is not register
raid_postsuspend	raid_message
  md_stop_writes
			 set_bit(MD_RECOVERY_NEEDED, &mddev->recovery)
			 if (!mddev->suspended)
			  md_wakeup_thread
			  // new sync_thread is registered
  mddev_suspend

> happen. Even raid_messages clears MD_RECOVERY_FROZEN, the sync thread
> can't start. After resume the array, the sync thread can start again.

4) I think I don't need to explain again why suspended should not be
used to prevent starting new sync_thread;

Thanks,
Kuai

> 
> Regards
> Xiao
>>
>> Thanks,
>> Kuai
>>
>>>
>>> Regards
>>> Xiao
>>>
>>>
>>>>
>>>> Fix above problems by using the new helper to suspend the array during
>>>> suspend, also disallow raid_message() to change sync_thread status
>>>> during suspend.
>>>>
>>>> Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), the
>>>> test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread(),
>>>> and with previous fixes, the test won't hang there anymore, however, the
>>>> test will still fail and complain that ext4 is corrupted. And with this
>>>> patch, the test won't hang due to stop_sync_thread() or fail due to ext4
>>>> is corrupted anymore. However, there is still a deadlock related to
>>>> dm-raid456 that will be fixed in following patches.
>>>>
>>>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>>>> Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
>>>> Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_stop_writes()")
>>>> Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
>>>> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/md/dm-raid.c | 38 +++++++++++++++++++++++++++++---------
>>>>    1 file changed, 29 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
>>>> index eb009d6bb03a..5ce3c6020b1b 100644
>>>> --- a/drivers/md/dm-raid.c
>>>> +++ b/drivers/md/dm-raid.c
>>>> @@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>>>           rs->md.ro = 1;
>>>>           rs->md.in_sync = 1;
>>>>
>>>> -       /* Keep array frozen until resume. */
>>>> -       set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
>>>> -
>>>>           /* Has to be held on running the array */
>>>>           mddev_suspend_and_lock_nointr(&rs->md);
>>>> +
>>>> +       /* Keep array frozen until resume. */
>>>> +       md_frozen_sync_thread(&rs->md);
>>>> +
>>>>           r = md_run(&rs->md);
>>>>           rs->md.in_sync = 0; /* Assume already marked dirty */
>>>>           if (r) {
>>>> @@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
>>>>           if (!mddev->pers || !mddev->pers->sync_request)
>>>>                   return -EINVAL;
>>>>
>>>> +       if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
>>>> +               return -EBUSY;
>>>> +
>>>>           if (!strcasecmp(argv[0], "frozen"))
>>>>                   set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>>           else
>>>> @@ -3791,15 +3795,31 @@ static void raid_io_hints(struct dm_target *ti, struct queue_limits *limits)
>>>>           blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_stripes(rs));
>>>>    }
>>>>
>>>> +static void raid_presuspend(struct dm_target *ti)
>>>> +{
>>>> +       struct raid_set *rs = ti->private;
>>>> +
>>>> +       mddev_lock_nointr(&rs->md);
>>>> +       md_frozen_sync_thread(&rs->md);
>>>> +       mddev_unlock(&rs->md);
>>>> +}
>>>> +
>>>> +static void raid_presuspend_undo(struct dm_target *ti)
>>>> +{
>>>> +       struct raid_set *rs = ti->private;
>>>> +
>>>> +       mddev_lock_nointr(&rs->md);
>>>> +       md_unfrozen_sync_thread(&rs->md);
>>>> +       mddev_unlock(&rs->md);
>>>> +}
>>>> +
>>>>    static void raid_postsuspend(struct dm_target *ti)
>>>>    {
>>>>           struct raid_set *rs = ti->private;
>>>>
>>>>           if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
>>>>                   /* Writes have to be stopped before suspending to avoid deadlocks. */
>>>> -               if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
>>>> -                       md_stop_writes(&rs->md);
>>>> -
>>>> +               md_stop_writes(&rs->md);
>>>>                   mddev_suspend(&rs->md, false);
>>>>           }
>>>>    }
>>>> @@ -4012,8 +4032,6 @@ static int raid_preresume(struct dm_target *ti)
>>>>           }
>>>>
>>>>           /* Check for any resize/reshape on @rs and adjust/initiate */
>>>> -       /* Be prepared for mddev_resume() in raid_resume() */
>>>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>>           if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
>>>>                   set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
>>>>                   mddev->resync_min = mddev->recovery_cp;
>>>> @@ -4056,9 +4074,9 @@ static void raid_resume(struct dm_target *ti)
>>>>                           rs_set_capacity(rs);
>>>>
>>>>                   mddev_lock_nointr(mddev);
>>>> -               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>>                   mddev->ro = 0;
>>>>                   mddev->in_sync = 0;
>>>> +               md_unfrozen_sync_thread(mddev);
>>>>                   mddev_unlock_and_resume(mddev);
>>>>           }
>>>>    }
>>>> @@ -4074,6 +4092,8 @@ static struct target_type raid_target = {
>>>>           .message = raid_message,
>>>>           .iterate_devices = raid_iterate_devices,
>>>>           .io_hints = raid_io_hints,
>>>> +       .presuspend = raid_presuspend,
>>>> +       .presuspend_undo = raid_presuspend_undo,
>>>>           .postsuspend = raid_postsuspend,
>>>>           .preresume = raid_preresume,
>>>>           .resume = raid_resume,
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


