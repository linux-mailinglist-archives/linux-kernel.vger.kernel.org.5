Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4F7837CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjHVCR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHVCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:17:57 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57159FD;
        Mon, 21 Aug 2023 19:17:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVCg26yFTz4f3pHZ;
        Tue, 22 Aug 2023 10:17:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqXPGuRkmGYlBQ--.52936S3;
        Tue, 22 Aug 2023 10:17:52 +0800 (CST)
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com>
Date:   Tue, 22 Aug 2023 10:17:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqXPGuRkmGYlBQ--.52936S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuF43uF17Ar4xtw45Awb_yoW5Jw1Dpa
        yrGFWakrWUAry3W3ZFqF18GFyYqF48trs7C34aka4fXas0vrn5Gw18KF98Wa4DAFWY9r4f
        Zr1UJw4kCw1rKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/22 7:22, Song Liu 写道:
> On Sun, Aug 20, 2023 at 2:13 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are no functional changes, just to make the code simpler and
>> prepare to delay remove_and_add_spares() to md_start_sync().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 28 ++++++++++++++++------------
>>   1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 11d27c934fdd..cdc361c521d4 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev)
>>                 !test_bit(Faulty, &rdev->flags);
>>   }
>>
>> +static bool rdev_addable(struct md_rdev *rdev)
>> +{
>> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
>> +           test_bit(Faulty, &rdev->flags))
>> +               return false;
>> +
>> +       if (!test_bit(Journal, &rdev->flags) && !md_is_rdwr(rdev->mddev) &&
> 
> Instead of straightforward refactoring, I hope we can make these rdev_*
> helpers more meaningful, and hopefullly reusable. For example, let's define
> the meaning of "addable", and write the function to match that meaning. In
> this case, I think we shouldn't check md_is_rdwr() inside rdev_addable().
> 
> Does this make sense?

Yes, this make sense, rdev can be added to read-only array.

There are total three callers of pers->hot_add_sisk, I'll try to find if
they have common conditions.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> 
>> +           !(rdev->saved_raid_disk >= 0 &&
>> +             !test_bit(Bitmap_sync, &rdev->flags)))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>   static int remove_and_add_spares(struct mddev *mddev,
>>                                   struct md_rdev *this)
>>   {
>> @@ -9227,20 +9241,10 @@ static int remove_and_add_spares(struct mddev *mddev,
>>                          continue;
>>                  if (rdev_is_spare(rdev))
>>                          spares++;
>> -               if (test_bit(Candidate, &rdev->flags))
>> +               if (!rdev_addable(rdev))
>>                          continue;
>> -               if (rdev->raid_disk >= 0)
>> -                       continue;
>> -               if (test_bit(Faulty, &rdev->flags))
>> -                       continue;
>> -               if (!test_bit(Journal, &rdev->flags)) {
>> -                       if (!md_is_rdwr(mddev) &&
>> -                           !(rdev->saved_raid_disk >= 0 &&
>> -                             !test_bit(Bitmap_sync, &rdev->flags)))
>> -                               continue;
>> -
>> +               if (!test_bit(Journal, &rdev->flags))
>>                          rdev->recovery_offset = 0;
>> -               }
>>                  if (mddev->pers->hot_add_disk(mddev, rdev) == 0) {
>>                          /* failure here is OK */
>>                          sysfs_link_rdev(mddev, rdev);
>> --
>> 2.39.2
>>
> .
> 

