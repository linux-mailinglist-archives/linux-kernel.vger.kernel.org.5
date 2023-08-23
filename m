Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F556784EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjHWCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHWCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:48:02 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1915C1A5;
        Tue, 22 Aug 2023 19:48:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVrHJ62zHz4f3l8w;
        Wed, 23 Aug 2023 10:47:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6lcc+VkinR1BQ--.19078S3;
        Wed, 23 Aug 2023 10:47:57 +0800 (CST)
Subject: Re: [PATCH -next v3 5/7] md: factor out a helper rdev_is_spare() from
 remove_and_add_spares()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-6-yukuai1@huaweicloud.com>
 <CALTww28fa_LUVfzswTmpascZEYr-PdyjgoU88A+H9Q7CP04VXA@mail.gmail.com>
 <CALTww2-gdFHh4j+_bwuT2fX_OHMFfra3p34PM4rNZv0OCqPKcw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2d4c2350-f74d-4f4f-2bea-58dab8af2418@huaweicloud.com>
Date:   Wed, 23 Aug 2023 10:47:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-gdFHh4j+_bwuT2fX_OHMFfra3p34PM4rNZv0OCqPKcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6lcc+VkinR1BQ--.19078S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47tF1fCF4kGrWrAw1rCrg_yoW8Zw17pa
        y8WFWYkFWUZFyj93W2qr15CFy5ta18tr48ua47Ca4xZas0vr9xJr18GF98Ww1DAFWrur4r
        ZF1UG3yfu3WFqFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/23 10:28, Xiao Ni 写道:
> On Wed, Aug 23, 2023 at 10:20 AM Xiao Ni <xni@redhat.com> wrote:
>>
>> On Sun, Aug 20, 2023 at 5:13 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> There are no functional changes, just to make the code simpler and
>>> prepare to delay remove_and_add_spares() to md_start_sync().
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/md.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index ceace5ffadd6..11d27c934fdd 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -9169,6 +9169,14 @@ static bool rdev_removeable(struct md_rdev *rdev)
>>>          return true;
>>>   }
>>>
>>> +static bool rdev_is_spare(struct md_rdev *rdev)
>>> +{
>>> +       return !test_bit(Candidate, &rdev->flags) && rdev->raid_disk >= 0 &&
>>> +              !test_bit(In_sync, &rdev->flags) &&
>>> +              !test_bit(Journal, &rdev->flags) &&
>>> +              !test_bit(Faulty, &rdev->flags);
>>> +}
>>> +
>>>   static int remove_and_add_spares(struct mddev *mddev,
>>>                                   struct md_rdev *this)
>>>   {
>>> @@ -9217,13 +9225,10 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>          rdev_for_each(rdev, mddev) {
>>>                  if (this && this != rdev)
>>>                          continue;
>>> +               if (rdev_is_spare(rdev))
>>> +                       spares++;
>>>                  if (test_bit(Candidate, &rdev->flags))
>>>                          continue;
>>
>> Hi Kuai
>>
>> Why not put rdev_is_spare after testing Candidate?
>>
>> Best Regards
>> Xiao
> 
> I know the answer now, Because the next patch wants to put codes into
> the function rdev_addable

Yes, and thanks for the review!

Kuai
>>
>>> -               if (rdev->raid_disk >= 0 &&
>>> -                   !test_bit(In_sync, &rdev->flags) &&
>>> -                   !test_bit(Journal, &rdev->flags) &&
>>> -                   !test_bit(Faulty, &rdev->flags))
>>> -                       spares++;
>>>                  if (rdev->raid_disk >= 0)
>>>                          continue;
>>>                  if (test_bit(Faulty, &rdev->flags))
>>> --
>>> 2.39.2
>>>
> 
> Reviewed-by: Xiao Ni <xni@redhat.com>
> 
> .
> 

