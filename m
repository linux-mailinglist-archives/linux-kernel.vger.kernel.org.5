Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE67ACD99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjIYBfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:35:01 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8ECA;
        Sun, 24 Sep 2023 18:34:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rv55d6bZtz4f3jrc;
        Mon, 25 Sep 2023 09:34:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd244xBlPSFKBQ--.7589S3;
        Mon, 25 Sep 2023 09:34:50 +0800 (CST)
Subject: Re: [PATCH -next v2 02/28] md: use 'mddev->suspended' for
 is_md_suspended()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
 <20230828020021.2489641-3-yukuai1@huaweicloud.com>
 <CALTww29iHX_GHogGFEfzdaDjohBr8ycfiz2=E_ru4JYvmrTYdA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1407f90d-d608-6059-7381-adb230585e3d@huaweicloud.com>
Date:   Mon, 25 Sep 2023 09:34:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww29iHX_GHogGFEfzdaDjohBr8ycfiz2=E_ru4JYvmrTYdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd244xBlPSFKBQ--.7589S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1rKrW5AF15ZrWUurW5trb_yoW5KF17p3
        yIqFWYyrWUJF9Ik3yDtw1kua45uwn8KrW0yr9xW3W7C3W3Wr1rGF4furs8Xr1vk3Z3Gw1D
        Ja1Ut34fAF109FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/20 16:46, Xiao Ni 写道:
> On Mon, Aug 28, 2023 at 10:04 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> 'pers->prepare_suspend' is introduced to prevent a deadlock for raid456,
>> this change prepares to clean this up in later patches while refactoring
>> mddev_suspend(). Specifically allow reshape to make progress while
>> waiting for 'active_io' to be 0.
> 
> Hi Kuai
> 
>>From my side, I can't understand the comments. The change has
> relationship with pers->prepare_suspend? And why this change can
> affect reshape? If this change indeed can affect these two things, can
> you explain more?

First of all, 'prepare_suspend' is used to fix a deadlock in raid456:

1) suspend is waiting for normal io to be done.

mddev_suspend
  mddev->suspended++ -> new sync_thread can't start
  percpu_ref_kill(active_io)
  wait_event(percpu_ref_is_zero(active_io))

2) normal io is waiting for reshape to make progress.
3) reshape is waiting for suspended array to be resumed.

md_check_recovery
  if (is_md_suspended(mddev))
   return

Then prepare_suspend will failed the io that is waiting for reshape to
make progress:

mddev_suspend
  mddev->suspended++
  percpu_ref_kill(active_io)
   -> new io will be stuck in md_handle_request
  pers->prepare_suspend() -> raid5_prepare_suspend
   -> wake_up(wait_for_overlap)
		// woke up
		raid5_make_request
		 make_stripe_request
		  !reshape_inprogress(mddev) && reshape_disabled(mddev)
		   // return io error for the io that is waiting for
		   // reshape to make progress

  wait_event(percpu_ref_is_zero(active_io))

With this patch and the new api to suspend array:

mddev_suspend
  percpu_ref_kill(active_io)
  wait_event(percpu_ref_is_zero(active_io))
  -> while waiting for normal io to be done, new sync_thread can still
     start, and reshape can still make progress.
  mddev->suspended++

> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 2 +-
>>   drivers/md/md.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 9d8dff9d923c..7fa311a14317 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -355,7 +355,7 @@ static DEFINE_SPINLOCK(all_mddevs_lock);
>>    */
>>   static bool is_suspended(struct mddev *mddev, struct bio *bio)
>>   {
>> -       if (is_md_suspended(mddev))
>> +       if (is_md_suspended(mddev) || percpu_ref_is_dying(&mddev->active_io))
> 
> If we use mddev->suspended to judge if the raid is suspended, it
> should be enough? Because mddev->suspended must be true when active_io
> is dying.

In the new api, active_io is killed before increasing suspended, and the
difference is that the timing that array is suspended will be delayed
from the start of mddev_suspend() to when all dispatched io is done.

I think this is OK because this doesn't change behaviour when
mddev_suspend() returns.

Thanks,
Kuai
`
> 
> Best Regards
> Xiao
>>                  return true;
>>          if (bio_data_dir(bio) != WRITE)
>>                  return false;
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index b628c292506e..fb3b123f16dd 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -584,7 +584,7 @@ static inline bool md_is_rdwr(struct mddev *mddev)
>>
>>   static inline bool is_md_suspended(struct mddev *mddev)
>>   {
>> -       return percpu_ref_is_dying(&mddev->active_io);
>> +       return READ_ONCE(mddev->suspended);
>>   }
>>
>>   static inline int __must_check mddev_lock(struct mddev *mddev)
>> --
>> 2.39.2
>>
> 
> .
> 

