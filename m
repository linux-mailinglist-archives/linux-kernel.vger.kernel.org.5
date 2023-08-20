Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C6781C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjHTCrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHTCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:46:53 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4E349320;
        Sat, 19 Aug 2023 19:20:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RSzpK405Qz4f3mJ0;
        Sun, 20 Aug 2023 10:19:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qhJeOFkadqDBA--.18182S3;
        Sun, 20 Aug 2023 10:19:54 +0800 (CST)
Subject: Re: [PATCH -next v2 7/7] md: delay remove_and_add_spares() for read
 only array to md_start_sync()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-8-yukuai1@huaweicloud.com>
 <CALTww28yBsGucpaPO9BiQO-gU3+F25MaNVgGhnOA3Mi+9enFjQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fc27ff4e-a572-c70c-ab2f-be47d2cb8044@huaweicloud.com>
Date:   Sun, 20 Aug 2023 10:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww28yBsGucpaPO9BiQO-gU3+F25MaNVgGhnOA3Mi+9enFjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qhJeOFkadqDBA--.18182S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuF4kuF4UJr1UXry5urg_yoWrXrWDpr
        WxAFn0krWUX34xXr12gF1DWa4rtr10qrZFkry3ua4xZwnIyrn7G34rWayUWry5Aa4S9a10
        va18tFZxuF1rCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/16 15:18, Xiao Ni 写道:
> On Tue, Aug 15, 2023 at 11:13 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Before this patch, for read-only array:
>>
>> md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, then it will
>> call remove_and_add_spares() directly to try to remove and add rdevs
>> from array.
>>
>> After this patch:
>>
>> 1) md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, and the
>>     worker 'sync_work' is not pending, and there are rdevs can be added
>>     or removed, then it will queue new work md_start_sync();
>> 2) md_start_sync() will call remove_and_add_spares() and exist;
> 
> Hi Kuai
> 
> If md_check_recovery returns and md_starts_sync doesn't start, during
> the window the raid changes to read-write, the sync thread can be run
> but MD_RECOVERY_RUNNING isn't set. Is there such a problem?

That's a good question, looks like this is possible. Read-only array
doesn't test or set MD_RECOVERY_RUNNING at all in md_check_recovery().
I'll use MD_RECOVERY_RUNNING to prevent such concurrent scenario in
the new version.

Thanks,
Kuai

> 
> Regards
> Xiao
> 
>>
>> This change make sure that array reconfiguration is independent from
>> daemon, and it'll be much easier to synchronize it with io, consier
>> that io may rely on daemon thread to be done.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 37 +++++++++++++++++++++++++++----------
>>   1 file changed, 27 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index d26d2c35f9af..74d529479fcf 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9191,6 +9191,16 @@ static bool rdev_addable(struct md_rdev *rdev)
>>          return true;
>>   }
>>
>> +static bool md_spares_need_change(struct mddev *mddev)
>> +{
>> +       struct md_rdev *rdev;
>> +
>> +       rdev_for_each(rdev, mddev)
>> +               if (rdev_removeable(rdev) || rdev_addable(rdev))
>> +                       return true;
>> +       return false;
>> +}
>> +
>>   static int remove_and_add_spares(struct mddev *mddev,
>>                                   struct md_rdev *this)
>>   {
>> @@ -9309,6 +9319,12 @@ static void md_start_sync(struct work_struct *ws)
>>
>>          mddev_lock_nointr(mddev);
>>
>> +       if (!md_is_rdwr(mddev)) {
>> +               remove_and_add_spares(mddev, NULL);
>> +               mddev_unlock(mddev);
>> +               return;
>> +       }
>> +
>>          if (!md_choose_sync_direction(mddev, &spares))
>>                  goto not_running;
>>
>> @@ -9403,7 +9419,8 @@ void md_check_recovery(struct mddev *mddev)
>>          }
>>
>>          if (!md_is_rdwr(mddev) &&
>> -           !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
>> +           (!test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
>> +            work_pending(&mddev->sync_work)))
>>                  return;
>>          if ( ! (
>>                  (mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
>> @@ -9431,15 +9448,8 @@ void md_check_recovery(struct mddev *mddev)
>>                                   */
>>                                  rdev_for_each(rdev, mddev)
>>                                          clear_bit(Blocked, &rdev->flags);
>> -                       /* On a read-only array we can:
>> -                        * - remove failed devices
>> -                        * - add already-in_sync devices if the array itself
>> -                        *   is in-sync.
>> -                        * As we only add devices that are already in-sync,
>> -                        * we can activate the spares immediately.
>> -                        */
>> -                       remove_and_add_spares(mddev, NULL);
>> -                       /* There is no thread, but we need to call
>> +                       /*
>> +                        * There is no thread, but we need to call
>>                           * ->spare_active and clear saved_raid_disk
>>                           */
>>                          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> @@ -9447,6 +9457,13 @@ void md_check_recovery(struct mddev *mddev)
>>                          clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>>                          clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>>                          clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
>> +
>> +                       /*
>> +                        * Let md_start_sync() to remove and add rdevs to the
>> +                        * array.
>> +                        */
>> +                       if (md_spares_need_change(mddev))
>> +                               queue_work(md_misc_wq, &mddev->sync_work);
>>                          goto unlock;
>>                  }
>>
>> --
>> 2.39.2
>>
> 
> .
> 

