Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5D7852E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjHWImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjHWIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:39:08 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E291705;
        Wed, 23 Aug 2023 01:37:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RW02F2FqTz4f3pHZ;
        Wed, 23 Aug 2023 16:37:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqk0xeVke9mIBQ--.11337S3;
        Wed, 23 Aug 2023 16:37:10 +0800 (CST)
Subject: Re: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from
 remove_and_add_spares()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-7-yukuai1@huaweicloud.com>
 <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
 <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com>
 <2766d001-f618-d224-f8a9-ec38ed1dc2a7@huaweicloud.com>
 <CAPhsuW6JQX7ujeO77NVTme8t0DvzVBrsXRHmayVnp4fwWoYhZg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a004ed5b-cf4a-2392-c7e5-fcd1161a29a4@huaweicloud.com>
Date:   Wed, 23 Aug 2023 16:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6JQX7ujeO77NVTme8t0DvzVBrsXRHmayVnp4fwWoYhZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHVqk0xeVke9mIBQ--.11337S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8WrW3Ary7AryrJF15CFg_yoW7Ww4xpF
        W8XFWSkr4UAr17uw1qgr1rX3WFqr18KF4xurySk34xZas0qrn8Gw48CFy5uFyDJr45ur1Y
        vF15J3yxCw1YgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/23 13:26, Song Liu 写道:
> On Tue, Aug 22, 2023 at 8:04 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/08/22 10:17, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2023/08/22 7:22, Song Liu 写道:
>>>> On Sun, Aug 20, 2023 at 2:13 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> There are no functional changes, just to make the code simpler and
>>>>> prepare to delay remove_and_add_spares() to md_start_sync().
>>>>>
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>> ---
>>>>>    drivers/md/md.c | 28 ++++++++++++++++------------
>>>>>    1 file changed, 16 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>>> index 11d27c934fdd..cdc361c521d4 100644
>>>>> --- a/drivers/md/md.c
>>>>> +++ b/drivers/md/md.c
>>>>> @@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev)
>>>>>                  !test_bit(Faulty, &rdev->flags);
>>>>>    }
>>>>>
>>>>> +static bool rdev_addable(struct md_rdev *rdev)
>>>>> +{
>>>>> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
>>>>> +           test_bit(Faulty, &rdev->flags))
>>>>> +               return false;
>>>>> +
>>>>> +       if (!test_bit(Journal, &rdev->flags) &&
>>>>> !md_is_rdwr(rdev->mddev) &&
>>>>
>>>> Instead of straightforward refactoring, I hope we can make these rdev_*
>>>> helpers more meaningful, and hopefullly reusable. For example, let's
>>>> define
>>>> the meaning of "addable", and write the function to match that
>>>> meaning. In
>>>> this case, I think we shouldn't check md_is_rdwr() inside rdev_addable().
>>>>
>>>> Does this make sense?
>>>
>>> Yes, this make sense, rdev can be added to read-only array.
>>>
>>> There are total three callers of pers->hot_add_sisk, I'll try to find if
>>> they have common conditions.
>>
>> Unfortunately, the conditions is quite different, and It's difficult to
>> factor out a common helper for them to use.
>>
>> In this case, !md_is_rdwr() is one of the four conditions, which means
>> if the array is read-only, there is a special case that rdev can't be
>> added to the configuration. Perhaps it's okay to keep this?
> 
> My main concern is that rdev_addable() is not making the code easier to
> understand. We have a few different cases at this point:
> 
> 1. rdev is not suitable for add (Faulty, raid_disk>=0, Candidate);
> 2. rdev is Journal;
> 3. Re-add rdev to RO array;
> 4. Non-re-add rdev to RO array;
> 5. Other cases.
> 
> Current rdev_addable() handles more or less all of this, which is
> confusing. Maybe we can do something along similar to the
> following (not tested). Does this look more clear?
> 
> Thanks,
> Song
> 
> diff --git i/drivers/md/md.c w/drivers/md/md.c
> index 78be7811a89f..8cb855d03e0a 100644
> --- i/drivers/md/md.c
> +++ w/drivers/md/md.c
> @@ -9117,6 +9117,20 @@ void md_do_sync(struct md_thread *thread)
>   }
>   EXPORT_SYMBOL_GPL(md_do_sync);
> 
> +static bool rdev_addable(struct md_rdev *rdev)
> +{
> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
> +           test_bit(Faulty, &rdev->flags))
> +               return false;
> +       return true;
> +}
> +
> +static bool rdev_is_readd(struct md_rdev *rdev)
> +{
> +       return rdev->saved_raid_disk >= 0 ||
> +               !test_bit(Bitmap_sync, &rdev->flags);
This should use '&&' instead of '||' ?

> +}
> +
>   static int remove_and_add_spares(struct mddev *mddev,
>                                   struct md_rdev *this)
>   {
> @@ -9176,25 +9190,24 @@ static int remove_and_add_spares(struct mddev *mddev,
>          rdev_for_each(rdev, mddev) {
>                  if (this && this != rdev)
>                          continue;
> -               if (test_bit(Candidate, &rdev->flags))
> -                       continue;
>                  if (rdev->raid_disk >= 0 &&
>                      !test_bit(In_sync, &rdev->flags) &&
>                      !test_bit(Journal, &rdev->flags) &&
>                      !test_bit(Faulty, &rdev->flags))
>                          spares++;
> -               if (rdev->raid_disk >= 0)
> +
> +               if (!rdev_addable(rdev))
>                          continue;
> -               if (test_bit(Faulty, &rdev->flags))
> +
> +               if (test_bit(Journal, &rdev->flags))
> +                       goto hot_add_disk;
> +

I understand what you mean now, but I must use the exact same judgement
in the new helper md_spares_need_change() in patch 7, there will be 
redundant code this way.

How about this, rework rdev_addable():

   static bool rdev_addable(struct md_rdev *rdev)
   {
+         /* rdev is already used, don't add it again. */
           if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
               test_bit(Faulty, &rdev->flags))
                   return false;

~         /* Allow to add journal disk. */
~         if (test_bit(Journal, &rdev->flags))
~_                return true;

~         /* Allow to add if array is read-write. */
+         if (md_is_rdwr(rdev->mddev))
+                 return true;
+
+         /*
+          * For read-only array, only allow to readd a rdev. And if 
bitmap is
+          * used, don't allow to readd a rdev that is too old.
+          */
+         if (rdev->saved_raid_disk >=0 && !test_bit(Bitmap_sync, 
&rdev->flags))
+                 return true;
+
+         return false;
   }


Thanks,
Kuai

> +               if (!md_is_rdwr(mddev) && !rdev_is_readd(rdev))
>                          continue;
> -               if (!test_bit(Journal, &rdev->flags)) {
> -                       if (!md_is_rdwr(mddev) &&
> -                           !(rdev->saved_raid_disk >= 0 &&
> -                             !test_bit(Bitmap_sync, &rdev->flags)))
> -                               continue;
> 
> -                       rdev->recovery_offset = 0;
> -               }
> +               rdev->recovery_offset = 0;
> +
> +       hot_add_disk:
>                  if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
>                          /* failure here is OK */
>                          sysfs_link_rdev(mddev, rdev);
> .
> 

