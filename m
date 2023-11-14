Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA687EAD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjKNJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:34:51 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142318C;
        Tue, 14 Nov 2023 01:34:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SV1NL1k7Wz4f3jsr;
        Tue, 14 Nov 2023 17:34:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 94C921A0184;
        Tue, 14 Nov 2023 17:34:43 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHShAxP1Nlis+RAw--.53993S3;
        Tue, 14 Nov 2023 17:34:43 +0800 (CST)
Subject: Re: [PATCH -next 6/8] md: factor out a helper to stop sync_thread
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, neilb@suse.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com>
 <20231110172834.3939490-7-yukuai1@huaweicloud.com>
 <CALTww2_z-a_njriXVsXttS9C052qTCnVjgYNuTs4qnU8x=xc4g@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <15790904-7fea-ae44-4e0f-7abb7fad287a@huaweicloud.com>
Date:   Tue, 14 Nov 2023 17:34:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2_z-a_njriXVsXttS9C052qTCnVjgYNuTs4qnU8x=xc4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHShAxP1Nlis+RAw--.53993S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw45Gw47ur45try7Ww1kGrg_yoW8Gw17Ao
        Z5Gr12qr18Jw1rZFyrtwnrtF93Xa4DJ3s5t3W5ZrZxur1q93W0vw43Way3JF13K3ZxGFn7
        GF97Wr1fZFy3Jw4xn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYF7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/14 15:37, Xiao Ni 写道:
> Hi all
> 
> It's good to put the common codes into one function. Before this, I
> want to check a problem. Does idle_sync_thread need to stop sync
> thread? The sync thread can be run again immediately after stopping
> the sync thread when echo idle > sync_action. It looks like there is
> no meaning to stop the sync thread for idle_sync_thread. If we don't
> need to stop sync thread in idle_sync_thread, there is no need to
> introduce mddev->sync_seq and only needs to clear MD_RECOVERY_FROZEN
> in idle_sync_thread. Then it can make this patch simpler. Something
> like this

1) commit 7eec314d7512 ("[PATCH] md: improve 'scan_mode' and rename it
to 'sync_action'"), first introduce echo idle > sync_action, and it make
sure to stop current sync_thread.

2) commit 8e8e2518fcec ("md: Close race when setting 'action' to
'idle'.") added mddev_unlock after stopping sync_thread, that's why
sync_thread will always restart after echo idle > sync_action.

That's actually an regression problem that echo idle > sync_action
doen't work anymore, but looks like nobody cares all there years,
I'm ok to remove echo idle, or try to fix this regression.

Song, please let me know what you think.

Thanks,
Kuai

> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3484a0fc4d2a..34245c4c71b8 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -716,7 +716,6 @@ int mddev_init(struct mddev *mddev)
>          timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
>          atomic_set(&mddev->active, 1);
>          atomic_set(&mddev->openers, 0);
> -       atomic_set(&mddev->sync_seq, 0);
>          spin_lock_init(&mddev->lock);
>          atomic_set(&mddev->flush_pending, 0);
>          init_waitqueue_head(&mddev->sb_wait);
> @@ -4848,38 +4847,33 @@ action_show(struct mddev *mddev, char *page)
>          return sprintf(page, "%s\n", type);
>   }
> 
> -static int stop_sync_thread(struct mddev *mddev)
> +static void stop_sync_thread(struct mddev *mddev)
>   {
>          int ret = 0;
> 
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               return 0;
> 
> -       ret = mddev_lock(mddev);
> -       if (ret)
> -               return ret;
> +       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> +               return;
> 
> -       /*
> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
> -        * held.
> -        */
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> -               mddev_unlock(mddev);
> -               return 0;
> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> +               did_freeze = 1;
> +               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +               md_wakeup_thread(mddev->thread);
>          }
> 
> -       if (work_pending(&mddev->sync_work))
> -               flush_workqueue(md_misc_wq);
> -
>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> +
>          /*
>           * Thread might be blocked waiting for metadata update which will now
>           * never happen
>           */
>          md_wakeup_thread_directly(mddev->sync_thread);
> 
> -       mddev_unlock(mddev);
> -       return 0;
> +        mddev_unlock(mddev);
> +       wait_event(resync_wait, (mddev->sync_thread == NULL &&
> +                                       !test_bit(MD_RECOVERY_RUNNING,
> +                                       &mddev->recovery)));
> +        mddev_lock_nointr(mddev);
>   }
> 
>   static int idle_sync_thread(struct mddev *mddev)
> @@ -4891,8 +4885,14 @@ static int idle_sync_thread(struct mddev *mddev)
>          if (ret)
>                  return ret;
> 
> -       mddev_lock(mddev);
> -       test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       ret = mddev_lock(mddev);
> +       if (ret) {
> +               mutex_unlock(&mddev->sync_mutex);
> +               return ret;
> +       }
> +
> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +
>          mddev_unlock(mddev);
>          mutex_unlock(&mddev->sync_mutex);
>          return ret;
> @@ -4906,17 +4906,15 @@ static int frozen_sync_thread(struct mddev *mddev)
>          if (ret)
>                  return ret;
> 
> -       flag = test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       ret = stop_sync_thread(mddev);
> -       if (ret)
> -               goto out;
> +       ret = mddev_lock(mddev);
> +       if (ret) {
> +               mutex_unlock(&mddev->sync_mutex);
> +               return ret;
> +       }
> 
> -       ret = wait_event_interruptible(resync_wait,
> -                       mddev->sync_thread == NULL &&
> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> -out:
> -       if (ret && !flag)
> -               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       stop_sync_thread(mddev);
> +
> +       mddev_unlock(mddev);
>          mutex_unlock(&mddev->sync_mutex);
>          return ret;
>   }
> @@ -6388,22 +6386,9 @@ static int md_set_readonly(struct mddev *mddev,
> struct block_device *bdev)
>          if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>                  return -EBUSY;
> 
> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> -               did_freeze = 1;
> -               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       }
> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -
> -       /*
> -        * Thread might be blocked waiting for metadata update which will now
> -        * never happen
> -        */
> -       md_wakeup_thread_directly(mddev->sync_thread);
> +       stop_sync_thread(mddev);
> 
>          mddev_unlock(mddev);
> -       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
> -                                         &mddev->recovery));
>          wait_event(mddev->sb_wait,
>                     !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
>          mddev_lock_nointr(mddev);
> @@ -6448,25 +6433,8 @@ static int do_md_stop(struct mddev *mddev, int mode,
>          struct md_rdev *rdev;
>          int did_freeze = 0;
> 
> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> -               did_freeze = 1;
> -               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       }
> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -
> -       /*
> -        * Thread might be blocked waiting for metadata update which will now
> -        * never happen
> -        */
> -       md_wakeup_thread_directly(mddev->sync_thread);
> -
> -       mddev_unlock(mddev);
> -       wait_event(resync_wait, (mddev->sync_thread == NULL &&
> -                                !test_bit(MD_RECOVERY_RUNNING,
> -                                          &mddev->recovery)));
> -       mddev_lock_nointr(mddev);
> -
> +       stop_sync_thread(mddev);
> +
>          mutex_lock(&mddev->open_mutex);
>          if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>              mddev->sysfs_active ||
> @@ -9622,7 +9590,6 @@ void md_reap_sync_thread(struct mddev *mddev)
> 
>          /* resync has finished, collect result */
>          md_unregister_thread(mddev, &mddev->sync_thread);
> -       atomic_inc(&mddev->sync_seq);
> 
>          if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
>              !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
> 
> Best Regards
> Xiao
> 
> On Fri, Nov 10, 2023 at 5:34 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> stop_sync_thread(), md_set_readonly() and do_md_stop() are trying to
>> stop sync_thread() the same way, hence factor out a helper to make code
>> cleaner, and also prepare to use the new helper to fix problems later.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
>> ---
>>   drivers/md/md.c | 129 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 69 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index c0f2bdafe46a..7252fae0c989 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4848,29 +4848,46 @@ action_show(struct mddev *mddev, char *page)
>>          return sprintf(page, "%s\n", type);
>>   }
>>
>> -static int stop_sync_thread(struct mddev *mddev)
>> +static bool sync_thread_stopped(struct mddev *mddev, int *seq_ptr)
>>   {
>> -       int ret = 0;
>> +       if (seq_ptr && *seq_ptr != atomic_read(&mddev->sync_seq))
>> +               return true;
>>
>> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> -               return 0;
>> +       return (!mddev->sync_thread &&
>> +               !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> +}
>>
>> -       ret = mddev_lock(mddev);
>> -       if (ret)
>> -               return ret;
>> +/*
>> + * stop_sync_thread() - stop running sync_thread.
>> + * @mddev: the array that sync_thread belongs to.
>> + * @freeze: set true to prevent new sync_thread to start.
>> + * @interruptible: if set true, then user can interrupt while waiting for
>> + * sync_thread to be done.
>> + *
>> + * Noted that this function must be called with 'reconfig_mutex' grabbed, and
>> + * fter this function return, 'reconfig_mtuex' will be released.
>> + */
>> +static int stop_sync_thread(struct mddev *mddev, bool freeze,
>> +                           bool interruptible)
>> +       __releases(&mddev->reconfig_mutex)
>> +{
>> +       int *seq_ptr = NULL;
>> +       int sync_seq;
>> +       int ret = 0;
>> +
>> +       if (freeze) {
>> +               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       } else {
>> +               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +               sync_seq = atomic_read(&mddev->sync_seq);
>> +               seq_ptr = &sync_seq;
>> +       }
>>
>> -       /*
>> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
>> -        * held.
>> -        */
>>          if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>>                  mddev_unlock(mddev);
>>                  return 0;
>>          }
>>
>> -       if (work_pending(&mddev->sync_work))
>> -               flush_workqueue(md_misc_wq);
>> -
>>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>          /*
>>           * Thread might be blocked waiting for metadata update which will now
>> @@ -4879,53 +4896,58 @@ static int stop_sync_thread(struct mddev *mddev)
>>          md_wakeup_thread_directly(mddev->sync_thread);
>>
>>          mddev_unlock(mddev);
>> -       return 0;
>> +       if (work_pending(&mddev->sync_work))
>> +               flush_work(&mddev->sync_work);
>> +
>> +       if (interruptible)
>> +               ret = wait_event_interruptible(resync_wait,
>> +                                       sync_thread_stopped(mddev, seq_ptr));
>> +       else
>> +               wait_event(resync_wait, sync_thread_stopped(mddev, seq_ptr));
>> +
>> +       return ret;
>>   }
>>
>>   static int idle_sync_thread(struct mddev *mddev)
>>   {
>>          int ret;
>> -       int sync_seq = atomic_read(&mddev->sync_seq);
>>          bool flag;
>>
>>          ret = mutex_lock_interruptible(&mddev->sync_mutex);
>>          if (ret)
>>                  return ret;
>>
>> -       flag = test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -       ret = stop_sync_thread(mddev);
>> +       flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       ret = mddev_lock(mddev);
>>          if (ret)
>> -               goto out;
>> +               goto unlock;
>>
>> -       ret = wait_event_interruptible(resync_wait,
>> -                       sync_seq != atomic_read(&mddev->sync_seq) ||
>> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> -out:
>> +       ret = stop_sync_thread(mddev, false, true);
>>          if (ret && flag)
>>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +unlock:
>>          mutex_unlock(&mddev->sync_mutex);
>>          return ret;
>>   }
>>
>>   static int frozen_sync_thread(struct mddev *mddev)
>>   {
>> -       int ret = mutex_lock_interruptible(&mddev->sync_mutex);
>> +       int ret;
>>          bool flag;
>>
>> +       ret = mutex_lock_interruptible(&mddev->sync_mutex);
>>          if (ret)
>>                  return ret;
>>
>> -       flag = test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -       ret = stop_sync_thread(mddev);
>> +       flag = test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +       ret = mddev_lock(mddev);
>>          if (ret)
>> -               goto out;
>> +               goto unlock;
>>
>> -       ret = wait_event_interruptible(resync_wait,
>> -                       mddev->sync_thread == NULL &&
>> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> -out:
>> +       ret = stop_sync_thread(mddev, true, true);
>>          if (ret && !flag)
>>                  clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> +unlock:
>>          mutex_unlock(&mddev->sync_mutex);
>>          return ret;
>>   }
>> @@ -6397,22 +6419,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>          if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>>                  return -EBUSY;
>>
>> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>                  did_freeze = 1;
>> -               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -       }
>> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>
>> -       /*
>> -        * Thread might be blocked waiting for metadata update which will now
>> -        * never happen
>> -        */
>> -       md_wakeup_thread_directly(mddev->sync_thread);
>> -
>> -       mddev_unlock(mddev);
>> -       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
>> -                                         &mddev->recovery));
>> +       stop_sync_thread(mddev, true, false);
>>          wait_event(mddev->sb_wait,
>>                     !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
>>          mddev_lock_nointr(mddev);
>> @@ -6421,6 +6431,10 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
>>          if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>>              mddev->sync_thread ||
>>              test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> +               /*
>> +                * This could happen if user change array state through
>> +                * ioctl/sysfs while reconfig_mutex is released.
>> +                */
>>                  pr_warn("md: %s still in use.\n",mdname(mddev));
>>                  err = -EBUSY;
>>                  goto out;
>> @@ -6457,30 +6471,25 @@ static int do_md_stop(struct mddev *mddev, int mode,
>>          struct md_rdev *rdev;
>>          int did_freeze = 0;
>>
>> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>                  did_freeze = 1;
>> +
>> +       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> +               stop_sync_thread(mddev, true, false);
>> +               mddev_lock_nointr(mddev);
>> +       } else {
>>                  set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          }
>> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> -
>> -       /*
>> -        * Thread might be blocked waiting for metadata update which will now
>> -        * never happen
>> -        */
>> -       md_wakeup_thread_directly(mddev->sync_thread);
>> -
>> -       mddev_unlock(mddev);
>> -       wait_event(resync_wait, (mddev->sync_thread == NULL &&
>> -                                !test_bit(MD_RECOVERY_RUNNING,
>> -                                          &mddev->recovery)));
>> -       mddev_lock_nointr(mddev);
>>
>>          mutex_lock(&mddev->open_mutex);
>>          if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>>              mddev->sysfs_active ||
>>              mddev->sync_thread ||
>>              test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> +               /*
>> +                * This could happen if user change array state through
>> +                * ioctl/sysfs while reconfig_mutex is released.
>> +                */
>>                  pr_warn("md: %s still in use.\n",mdname(mddev));
>>                  mutex_unlock(&mddev->open_mutex);
>>                  if (did_freeze) {
>> --
>> 2.39.2
>>
> 
> .
> 

