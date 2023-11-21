Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC07F2DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjKUNBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjKUNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:01:31 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08FD4B;
        Tue, 21 Nov 2023 05:01:25 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SZPdX1wR7z4f3khV;
        Tue, 21 Nov 2023 21:01:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id D9CD31A035F;
        Tue, 21 Nov 2023 21:01:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hAgqlxlAZonBg--.50806S3;
        Tue, 21 Nov 2023 21:01:21 +0800 (CST)
Subject: Re: [PATCH -next 6/8] md: factor out a helper to stop sync_thread
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
 <20231110172834.3939490-7-yukuai1@huaweicloud.com>
 <CALTww2-ivzhRRMYBoVSZ32uRUPL8Lii=z3SHGbMijsximdn=7A@mail.gmail.com>
 <CALTww2-YiGbw9HAA-hvEbCmWuOHpdHkx1KCBciRW9d6r=j44nQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <df362513-42a5-ea85-6bc4-784bba263f1b@huaweicloud.com>
Date:   Tue, 21 Nov 2023 21:01:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-YiGbw9HAA-hvEbCmWuOHpdHkx1KCBciRW9d6r=j44nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hAgqlxlAZonBg--.50806S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw17Ar43Gw13Xw1xtry7Jrb_yoWfWF1xp3
        y8JFn8tr4UXry3urZFq3WqqayFvw1jgr9FyFy3Wa4fJrnayrsxKFy5uF1UCFykAay8Ar48
        Za1rKFW3ZF93KFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/21 14:34, Xiao Ni 写道:
> On Tue, Nov 21, 2023 at 2:02 PM Xiao Ni <xni@redhat.com> wrote:
>>
>> On Fri, Nov 10, 2023 at 5:34 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> stop_sync_thread(), md_set_readonly() and do_md_stop() are trying to
>>> stop sync_thread() the same way, hence factor out a helper to make code
>>> cleaner, and also prepare to use the new helper to fix problems later.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
>>> ---
>>>   drivers/md/md.c | 129 ++++++++++++++++++++++++++----------------------
>>>   1 file changed, 69 insertions(+), 60 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index c0f2bdafe46a..7252fae0c989 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -4848,29 +4848,46 @@ action_show(struct mddev *mddev, char *page)
>>>          return sprintf(page, "%s\n", type);
>>>   }
>>>
>>> -static int stop_sync_thread(struct mddev *mddev)
>>> +static bool sync_thread_stopped(struct mddev *mddev, int *seq_ptr)
>>>   {
>>> -       int ret = 0;
>>> +       if (seq_ptr && *seq_ptr != atomic_read(&mddev->sync_seq))
>>> +               return true;
>>>
>>> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>> -               return 0;
>>> +       return (!mddev->sync_thread &&
>>> +               !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>>> +}
>>>
>>> -       ret = mddev_lock(mddev);
>>> -       if (ret)
>>> -               return ret;
>>> +/*
>>> + * stop_sync_thread() - stop running sync_thread.
>>> + * @mddev: the array that sync_thread belongs to.
>>> + * @freeze: set true to prevent new sync_thread to start.
>>> + * @interruptible: if set true, then user can interrupt while waiting for
>>> + * sync_thread to be done.
>>> + *
>>> + * Noted that this function must be called with 'reconfig_mutex' grabbed, and
>>> + * fter this function return, 'reconfig_mtuex' will be released.
>>> + */
>>> +static int stop_sync_thread(struct mddev *mddev, bool freeze,
>>> +                           bool interruptible)
>>> +       __releases(&mddev->reconfig_mutex)
>>> +{
>>> +       int *seq_ptr = NULL;
>>> +       int sync_seq;
>>> +       int ret = 0;
>>> +
>>> +       if (freeze) {
>>> +               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +       } else {
>>> +               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +               sync_seq = atomic_read(&mddev->sync_seq);
>>> +               seq_ptr = &sync_seq;
>>> +       }
>>>
>>> -       /*
>>> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
>>> -        * held.
>>> -        */
>>>          if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>>                  mddev_unlock(mddev);
>>>                  return 0;
>>>          }
>> Hi Kuai
>>
>> It does the unlock inside this function. For me, it's not good,
>> because the caller does the lock. So the caller should do the unlock
>> too.
>>>
>>> -       if (work_pending(&mddev->sync_work))
>>> -               flush_workqueue(md_misc_wq);
>>> -
>>>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>>          /*
>>>           * Thread might be blocked waiting for metadata update which will now
>>> @@ -4879,53 +4896,58 @@ static int stop_sync_thread(struct mddev *mddev)
>>>          md_wakeup_thread_directly(mddev->sync_thread);
>>>
>>>          mddev_unlock(mddev);
>>
>> Same with above point.
>>
>>> -       return 0;
>>> +       if (work_pending(&mddev->sync_work))
>>> +               flush_work(&mddev->sync_work);
>>> +
>>> +       if (interruptible)
>>> +               ret = wait_event_interruptible(resync_wait,
>>> +                                       sync_thread_stopped(mddev, seq_ptr));
>>> +       else
>>> +               wait_event(resync_wait, sync_thread_stopped(mddev, seq_ptr));
>>> +
>>
>> It looks like the three roles (md_set_readonly, do_md_stop and
>> stop_sync_thread) need to wait for different events. We can move these
>> codes out this helper function and make this helper function to be
>> more common.
> 
> Or get lock again before returning this function and leave the wait here?
> 

I tried but I made code complex. 😞

I guess I'll need to drop this version and restart...

Thanks,
Kuai

> Regards
> Xiao
> 
> 
>>
>> Best Regards
>> Xiao
>>
>>
>>> +       return ret;
>>>   }
>>>
>>>   static int idle_sync_thread(struct mddev *mddev)
>>>   {
>>>          int ret;
>>> -       int sync_seq = atomic_read(&mddev->sync_seq);
>>>          bool flag;
>>>
>>>          ret = mutex_lock_interruptible(&mddev->sync_mutex);
>>>          if (ret)
>>>                  return ret;
>>>
>>> -       flag = test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> -       ret = stop_sync_thread(mddev);
>>> +       flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +       ret = mddev_lock(mddev);
>>>          if (ret)
>>> -               goto out;
>>> +               goto unlock;
>>>
>>> -       ret = wait_event_interruptible(resync_wait,
>>> -                       sync_seq != atomic_read(&mddev->sync_seq) ||
>>> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>>> -out:
>>> +       ret = stop_sync_thread(mddev, false, true);
>>>          if (ret && flag)
>>>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +unlock:
>>>          mutex_unlock(&mddev->sync_mutex);
>>>          return ret;
>>>   }
>>>
>>>   static int frozen_sync_thread(struct mddev *mddev)
>>>   {
>>> -       int ret = mutex_lock_interruptible(&mddev->sync_mutex);
>>> +       int ret;
>>>          bool flag;
>>>
>>> +       ret = mutex_lock_interruptible(&mddev->sync_mutex);
>>>          if (ret)
>>>                  return ret;
>>>
>>> -       flag = test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> -       ret = stop_sync_thread(mddev);
>>> +       flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +       ret = mddev_lock(mddev);
>>>          if (ret)
>>> -               goto out;
>>> +               goto unlock;
>>>
>>> -       ret = wait_event_interruptible(resync_wait,
>>> -                       mddev->sync_thread == NULL &&
>>> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>>> -out:
>>> +       ret = stop_sync_thread(mddev, true, true);
>>>          if (ret && !flag)
>>>                  clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> +unlock:
>>>          mutex_unlock(&mddev->sync_mutex);
>>>          return ret;
>>>   }
>>> @@ -6397,22 +6419,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>>          if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>>>                  return -EBUSY;
>>>
>>> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>>                  did_freeze = 1;
>>> -               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>> -       }
>>> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>>
>>> -       /*
>>> -        * Thread might be blocked waiting for metadata update which will now
>>> -        * never happen
>>> -        */
>>> -       md_wakeup_thread_directly(mddev->sync_thread);
>>> -
>>> -       mddev_unlock(mddev);
>>> -       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
>>> -                                         &mddev->recovery));
>>> +       stop_sync_thread(mddev, true, false);
>>>          wait_event(mddev->sb_wait,
>>>                     !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
>>>          mddev_lock_nointr(mddev);
>>> @@ -6421,6 +6431,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>>          if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>>>              mddev->sync_thread ||
>>>              test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>> +               /*
>>> +                * This could happen if user change array state through
>>> +                * ioctl/sysfs while reconfig_mutex is released.
>>> +                */
>>>                  pr_warn("md: %s still in use.\n",mdname(mddev));
>>>                  err = -EBUSY;
>>>                  goto out;
>>> @@ -6457,30 +6471,25 @@ static int do_md_stop(struct mddev *mddev, int mode,
>>>          struct md_rdev *rdev;
>>>          int did_freeze = 0;
>>>
>>> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>>                  did_freeze = 1;
>>> +
>>> +       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>> +               stop_sync_thread(mddev, true, false);
>>> +               mddev_lock_nointr(mddev);
>>> +       } else {
>>>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>          }
>>> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>>> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>> -
>>> -       /*
>>> -        * Thread might be blocked waiting for metadata update which will now
>>> -        * never happen
>>> -        */
>>> -       md_wakeup_thread_directly(mddev->sync_thread);
>>> -
>>> -       mddev_unlock(mddev);
>>> -       wait_event(resync_wait, (mddev->sync_thread == NULL &&
>>> -                                !test_bit(MD_RECOVERY_RUNNING,
>>> -                                          &mddev->recovery)));
>>> -       mddev_lock_nointr(mddev);
>>>
>>>          mutex_lock(&mddev->open_mutex);
>>>          if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>>>              mddev->sysfs_active ||
>>>              mddev->sync_thread ||
>>>              test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>> +               /*
>>> +                * This could happen if user change array state through
>>> +                * ioctl/sysfs while reconfig_mutex is released.
>>> +                */
>>>                  pr_warn("md: %s still in use.\n",mdname(mddev));
>>>                  mutex_unlock(&mddev->open_mutex);
>>>                  if (did_freeze) {
>>> --
>>> 2.39.2
>>>
> 
> 
> .
> 

