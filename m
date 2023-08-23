Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71A784F10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjHWDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjHWDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:04:55 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E152D93;
        Tue, 22 Aug 2023 20:04:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVrfn0M8Fz4f3lgS;
        Wed, 23 Aug 2023 11:04:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6lQd+Vk5mJ2BQ--.19817S3;
        Wed, 23 Aug 2023 11:04:50 +0800 (CST)
Subject: Re: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from
 remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc:     xni@redhat.com, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-7-yukuai1@huaweicloud.com>
 <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
 <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2766d001-f618-d224-f8a9-ec38ed1dc2a7@huaweicloud.com>
Date:   Wed, 23 Aug 2023 11:04:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6lQd+Vk5mJ2BQ--.19817S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4xuFy8Xr15uw4xCFy3Jwb_yoWrZr1kpr
        18JFWUGryUAr18Jr1Utr1UJFyUtr1UJw1UJr1xJF1UJw1DJr1jgr1UXryqgr1UJr48Jr1U
        Jr1UJr17Zr1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/22 10:17, Yu Kuai 写道:
> Hi,
> 
> 在 2023/08/22 7:22, Song Liu 写道:
>> On Sun, Aug 20, 2023 at 2:13 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> There are no functional changes, just to make the code simpler and
>>> prepare to delay remove_and_add_spares() to md_start_sync().
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/md.c | 28 ++++++++++++++++------------
>>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 11d27c934fdd..cdc361c521d4 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev)
>>>                 !test_bit(Faulty, &rdev->flags);
>>>   }
>>>
>>> +static bool rdev_addable(struct md_rdev *rdev)
>>> +{
>>> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
>>> +           test_bit(Faulty, &rdev->flags))
>>> +               return false;
>>> +
>>> +       if (!test_bit(Journal, &rdev->flags) && 
>>> !md_is_rdwr(rdev->mddev) &&
>>
>> Instead of straightforward refactoring, I hope we can make these rdev_*
>> helpers more meaningful, and hopefullly reusable. For example, let's 
>> define
>> the meaning of "addable", and write the function to match that 
>> meaning. In
>> this case, I think we shouldn't check md_is_rdwr() inside rdev_addable().
>>
>> Does this make sense?
> 
> Yes, this make sense, rdev can be added to read-only array.
> 
> There are total three callers of pers->hot_add_sisk, I'll try to find if
> they have common conditions.

Unfortunately, the conditions is quite different, and It's difficult to
factor out a common helper for them to use.

In this case, !md_is_rdwr() is one of the four conditions, which means
if the array is read-only, there is a special case that rdev can't be
added to the configuration. Perhaps it's okay to keep this?

Thanks,
Kuai
> 
> Thanks,
> Kuai
> 
>>
>> Thanks,
>> Song
>>
>>
>>> +           !(rdev->saved_raid_disk >= 0 &&
>>> +             !test_bit(Bitmap_sync, &rdev->flags)))
>>> +               return false;
>>> +
>>> +       return true;
>>> +}
>>> +
>>>   static int remove_and_add_spares(struct mddev *mddev,
>>>                                   struct md_rdev *this)
>>>   {
>>> @@ -9227,20 +9241,10 @@ static int remove_and_add_spares(struct mddev 
>>> *mddev,
>>>                          continue;
>>>                  if (rdev_is_spare(rdev))
>>>                          spares++;
>>> -               if (test_bit(Candidate, &rdev->flags))
>>> +               if (!rdev_addable(rdev))
>>>                          continue;
>>> -               if (rdev->raid_disk >= 0)
>>> -                       continue;
>>> -               if (test_bit(Faulty, &rdev->flags))
>>> -                       continue;
>>> -               if (!test_bit(Journal, &rdev->flags)) {
>>> -                       if (!md_is_rdwr(mddev) &&
>>> -                           !(rdev->saved_raid_disk >= 0 &&
>>> -                             !test_bit(Bitmap_sync, &rdev->flags)))
>>> -                               continue;
>>> -
>>> +               if (!test_bit(Journal, &rdev->flags))
>>>                          rdev->recovery_offset = 0;
>>> -               }
>>>                  if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
>>>                          /* failure here is OK */
>>>                          sysfs_link_rdev(mddev, rdev);
>>> -- 
>>> 2.39.2
>>>
>> .
>>
> 
> .
> 

