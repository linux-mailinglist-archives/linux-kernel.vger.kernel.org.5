Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B1C801B32
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 08:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjLBHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 02:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLBHum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 02:50:42 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56E1A6;
        Fri,  1 Dec 2023 23:50:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Sj2D20HDqz4f3jXM;
        Sat,  2 Dec 2023 15:50:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 1C8501A09E4;
        Sat,  2 Dec 2023 15:50:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2xHS4WplopETCg--.58925S3;
        Sat, 02 Dec 2023 15:50:43 +0800 (CST)
Subject: Re: [PATCH v3 3/3] md: fix stopping sync thread
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231129043127.2245901-1-yukuai1@huaweicloud.com>
 <20231129043127.2245901-4-yukuai1@huaweicloud.com>
 <CAPhsuW6ato6HNAosJZa1o2WHpoF1Y+qcSPLd3Y_rwW1ZiHAydQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <03003a7d-d712-3a23-8a0f-54862852e6f2@huaweicloud.com>
Date:   Sat, 2 Dec 2023 15:50:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6ato6HNAosJZa1o2WHpoF1Y+qcSPLd3Y_rwW1ZiHAydQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2xHS4WplopETCg--.58925S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxGFyruryrZr4xCw4DJwb_yoWrKrW7pr
        WftF98Jr48AFW3Zry2g3Wqva4rZw1jvrWDtrW3Wa4fJwnYkr47KFyY9Fy8AFykZa4ftr48
        ZayrtFWfuFykKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/12/02 6:08, Song Liu 写道:
> On Tue, Nov 28, 2023 at 8:32 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently sync thread is stopped from multiple contex:
>>   - idle_sync_thread
>>   - frozen_sync_thread
>>   - __md_stop_writes
>>   - md_set_readonly
>>   - do_md_stop
>>
>> And there are some problems:
>> 1) sync_work is flushed while reconfig_mutex is grabbed, this can
>>     deadlock because the work function will grab reconfig_mutex as well.
>> 2) md_reap_sync_thread() can't be called directly while md_do_sync() is
>>     not finished yet, for example, commit 130443d60b1b ("md: refactor
>>     idle/frozen_sync_thread() to fix deadlock").
>> 3) If MD_RECOVERY_RUNNING is not set, there is no need to stop
>>     sync_thread at all because sync_thread must not be registered.
>>
>> Factor out a helper prepare_to_stop_sync_thread(), so that above contex
>> will behave the same. Fix 1) by flushing sync_work after reconfig_mutex
>> is released, before waiting for sync_thread to be done; Fix 2) bt
>> letting daemon thread to unregister sync_thread; Fix 3) by always
>> checking MD_RECOVERY_RUNNING first.
>>
>> Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
>> Acked-by: Xiao Ni <xni@redhat.com>
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 96 +++++++++++++++++++++++--------------------------
>>   1 file changed, 45 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 2d8e45a1af23..05902e36db66 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4840,26 +4840,9 @@ action_show(struct mddev *mddev, char *page)
>>          return sprintf(page, "%s\n", type);
>>   }
>>
>> -static void stop_sync_thread(struct mddev *mddev)
>> +static void prepare_to_stop_sync_thread(struct mddev *mddev)
>> +       __releases(&mddev->reconfig_mutex)
>>   {
>> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>> -               return;
>> -
>> -       if (mddev_lock(mddev))
>> -               return;
>> -
>> -       /*
>> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
>> -        * held.
>> -        */
>> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> -               mddev_unlock(mddev);
>> -               return;
>> -       }
>> -
>> -       if (work_pending(&mddev->sync_work))
>> -               flush_workqueue(md_misc_wq);
>> -
>>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>          /*
>>           * Thread might be blocked waiting for metadata update which will now
>> @@ -4868,6 +4851,8 @@ static void stop_sync_thread(struct mddev *mddev)
>>          md_wakeup_thread_directly(mddev->sync_thread);
>>
>>          mddev_unlock(mddev);
>> +       if (work_pending(&mddev->sync_work))
>> +               flush_work(&mddev->sync_work);
>>   }
>>
>>   static void idle_sync_thread(struct mddev *mddev)
>> @@ -4876,10 +4861,20 @@ static void idle_sync_thread(struct mddev *mddev)
>>
>>          mutex_lock(&mddev->sync_mutex);
>>          clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -       stop_sync_thread(mddev);
>>
>> -       wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
>> +       if (mddev_lock(mddev)) {
>> +               mutex_unlock(&mddev->sync_mutex);
>> +               return;
>> +       }
>> +
>> +       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> +               prepare_to_stop_sync_thread(mddev);
>> +               wait_event(resync_wait,
>> +                       sync_seq != atomic_read(&mddev->sync_seq) ||
>>                          !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>> +       } else {
>> +               mddev_unlock(mddev);
>> +       }
> 
> We have a few patterns like this:
> 
>          if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>                  prepare_to_stop_sync_thread(mddev);
>                  wait_event(resync_wait,
>                          sync_seq != atomic_read(&mddev->sync_seq) ||
>                          !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>          } else {
>                  mddev_unlock(mddev);
>          }
> 
> This is pretty confusing. Maybe try something like (untested)
> 
> static void stop_sync_thread(struct mddev *mddev,
>                               bool do_unlock, bool check_sync_seq)
Yes, if we can accept use parameter to distinguish different use case.

Thanks,
Kuai

> {
>          if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>                  if (do_unlock)
>                          mddev_unlock(mddev);
>                  return;
>          }
>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>          /*
>           * Thread might be blocked waiting for metadata update which will now
>           * never happen
>           */
>          md_wakeup_thread_directly(mddev->sync_thread);
> 
>          mddev_unlock(mddev);
>          if (work_pending(&mddev->sync_work))
>                  flush_work(&mddev->sync_work);
>          wait_event(resync_wait,
>                     !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
>                     (check_sync_seq && sync_seq !=
> atomic_read(&mddev->sync_seq)));
>          if (!do_unlock)
>                  mddev_lock_nointr(mddev);
> }
> 
> Thanks,
> Song
> 
> .
> 

