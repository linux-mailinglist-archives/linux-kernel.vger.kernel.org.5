Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AC6786487
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbjHXBQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbjHXBQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:16:27 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7710E4;
        Wed, 23 Aug 2023 18:16:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RWQC61gqjz4f3lJf;
        Thu, 24 Aug 2023 09:16:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qhjr+ZkV8nABQ--.54463S3;
        Thu, 24 Aug 2023 09:16:21 +0800 (CST)
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
 <a004ed5b-cf4a-2392-c7e5-fcd1161a29a4@huaweicloud.com>
 <CAPhsuW5DytoZDTi1NEv_EDaKoaHNE9Vd3UU_O_-2XzVqq0YNwg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c64c7b46-3447-79b5-a87f-7be835651269@huaweicloud.com>
Date:   Thu, 24 Aug 2023 09:16:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5DytoZDTi1NEv_EDaKoaHNE9Vd3UU_O_-2XzVqq0YNwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qhjr+ZkV8nABQ--.54463S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4DJw15Gr17Jw1ftrW3GFg_yoW5Xr1UpF
        W8tFW3KF4UZryUWr10qr15A3WSvr18KF4xCa4Ska4xZas0vr13try8CFy5G3Z8AF45ur1Y
        vF1UJa1fur1SgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
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

在 2023/08/23 19:25, Song Liu 写道:
> On Wed, Aug 23, 2023 at 1:37 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
> [...]
>>> diff --git i/drivers/md/md.c w/drivers/md/md.c
>>> index 78be7811a89f..8cb855d03e0a 100644
>>> --- i/drivers/md/md.c
>>> +++ w/drivers/md/md.c
>>> @@ -9117,6 +9117,20 @@ void md_do_sync(struct md_thread *thread)
>>>    }
>>>    EXPORT_SYMBOL_GPL(md_do_sync);
>>>
>>> +static bool rdev_addable(struct md_rdev *rdev)
>>> +{
>>> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
>>> +           test_bit(Faulty, &rdev->flags))
>>> +               return false;
>>> +       return true;
>>> +}
>>> +
>>> +static bool rdev_is_readd(struct md_rdev *rdev)
>>> +{
>>> +       return rdev->saved_raid_disk >= 0 ||
>>> +               !test_bit(Bitmap_sync, &rdev->flags);
>> This should use '&&' instead of '||' ?
>>
>>> +}
>>> +
>>>    static int remove_and_add_spares(struct mddev *mddev,
>>>                                    struct md_rdev *this)
>>>    {
>>> @@ -9176,25 +9190,24 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>           rdev_for_each(rdev, mddev) {
>>>                   if (this && this != rdev)
>>>                           continue;
>>> -               if (test_bit(Candidate, &rdev->flags))
>>> -                       continue;
>>>                   if (rdev->raid_disk >= 0 &&
>>>                       !test_bit(In_sync, &rdev->flags) &&
>>>                       !test_bit(Journal, &rdev->flags) &&
>>>                       !test_bit(Faulty, &rdev->flags))
>>>                           spares++;
>>> -               if (rdev->raid_disk >= 0)
>>> +
>>> +               if (!rdev_addable(rdev))
>>>                           continue;
>>> -               if (test_bit(Faulty, &rdev->flags))
>>> +
>>> +               if (test_bit(Journal, &rdev->flags))
>>> +                       goto hot_add_disk;
>>> +
>>
>> I understand what you mean now, but I must use the exact same judgement
>> in the new helper md_spares_need_change() in patch 7, there will be
>> redundant code this way.
>>
>> How about this, rework rdev_addable():
> 
> Yeah, this was another option that I was thinking about. Let's go with
> this version.
> 
Ok, and I'll do this for rdev_removeable() in patch 4 as well.

Thanks,
Kuai

> Thanks,
> Song
> 
>>
>>     static bool rdev_addable(struct md_rdev *rdev)
>>     {
>> +         /* rdev is already used, don't add it again. */
>>             if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >= 0 ||
>>                 test_bit(Faulty, &rdev->flags))
>>                     return false;
>>
>> ~         /* Allow to add journal disk. */
>> ~         if (test_bit(Journal, &rdev->flags))
>> ~_                return true;
>>
>> ~         /* Allow to add if array is read-write. */
>> +         if (md_is_rdwr(rdev->mddev))
>> +                 return true;
>> +
>> +         /*
>> +          * For read-only array, only allow to readd a rdev. And if
>> bitmap is
>> +          * used, don't allow to readd a rdev that is too old.
>> +          */
>> +         if (rdev->saved_raid_disk >=0 && !test_bit(Bitmap_sync,
>> &rdev->flags))
>> +                 return true;
>> +
>> +         return false;
>>     }
> .
> 

