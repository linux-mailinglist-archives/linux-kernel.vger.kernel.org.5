Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA57BC432
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjJGCcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGCcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:32:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D2C2;
        Fri,  6 Oct 2023 19:32:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2Tpw5Hy8z4f3jJ4;
        Sat,  7 Oct 2023 10:32:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3Dt5HwyBl+tZOCQ--.41587S3;
        Sat, 07 Oct 2023 10:32:41 +0800 (CST)
Subject: Re: [PATCH -next v3 00/25] md: synchronize io with array
 reconfiguration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
 <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com>
 <f59cbb99-33dd-c427-2e43-5a07ab9fbf51@huaweicloud.com>
 <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eb4ea24d-f7b4-899b-9259-2d48dc83e48f@huaweicloud.com>
Date:   Sat, 7 Oct 2023 10:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3Dt5HwyBl+tZOCQ--.41587S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF45KFy5GF17WF45WrWxWFg_yoWxXFWrp3
        y2qan0kr4DJrn7ZFs7J3y8uF1Sy3yfWFW5GryfK34akwn8Aryvvry8Ka15urZ09r9rGF12
        vF4UKa98Aa4YyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/05 11:55, Song Liu 写道:
> On Wed, Oct 4, 2023 at 8:42 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/09/29 3:15, Song Liu 写道:
>>> Hi Kuai,
>>>
>>> Thanks for the patchset!
>>>
>>> A few high level questions/suggestions:
>>
>> Thanks a lot for these!
>>>
>>> 1. This is a big change that needs a lot of explanation. While you managed to
>>> keep each patch relatively small (great job btw), it is not very clear why we
>>> need these changes. Specifically, we are adding a new mutex, it is worth
>>> mentioning why we cannot achieve the same goal without it. Please add
>>> more information in the cover letter. We will put part of the cover letter in
>>> the merge commit.
>>
>> Yeah, I realize that I explain too little. I will add background and
>> design.
>>>
Can you take a look about this new cover letter?

##### Backgroud

Our testers started to test raid10 last year, and we found that there
are lots of problem in the following test scenario:

- add or remove disks to the array
- issue io to the array

At first, we fixed each problem independently respect that io can
concurrent with array reconfiguration.  However, on the one hand new
issues are continuously reported, on the other hand other personalities
might have the same problems. I'm thinking about how to fix these
problems thoroughly.

Refer to how block layer protect io with queue reconfiguration(for
example, change elevator):

```
blk_mq_freeze_queue
-> wait for all io to be done, and prevent new io to be dispatched
// reconfiguration
blk_mq_unfreeze_queue
```

Then it comes to my mind that I can do something similar to synchronize
io with array reconfiguration.

##### rcu introduction

see details in https://www.kernel.org/doc/html/next/RCU/whatisRCU.html

- writer should replace old data with new data first, and free old data
after grace period;
- reader should handle both cases that old data and new data is read,
and the data that is read should not be dereferenced after critical
section;

##### Current synchronization

Add or remove disks to the array can be triggered by ioctl/sysfs/daemon
thread:

1. hold 'reconfig_mutex';

2. check that rdev can be added/removed, one condition is that there is
no IO, for example:

    ```
    raid10_remove_disk
     if (atomic_read(&rdev->nr_pending))
      err = -EBUSY;
    ```

3. do the actual operations to add/remove a rdev, one procedure is
set/clear a pointer to rdev, for example:

    ```
    raid10_remove_disk
     p = conf->mirrors[xx]
     rdevp = &p->rdev/replacement
     *rdevp = NULL
    ```

4. check if there is still no io on this rdev, if not, revert the
pointer to rdev and return failure, for example

    ```
    raid10_remove_disk
     synchronize_rcu()
     if (atomic_read(&rdev->nr_pending))
      err = -EBUSY
      *rdevp = rdev
    ```

IO path is using rcu_read_lock/unlock() to access rdev, for example:

```
raid10_write_request
  rcu_read_lock
  rdev = rcu_dereference(mirror->rdev/replacement)
  rcu_read_unlock

raid10_end_write_request
  rdev = conf->mirrors[dev].rdev/replacement
  -> rdev/rrdev is still used after rcu_read_unlock()
```

##### Current problems

- rcu is used wrongly;
- There are lots of places involved that old value is read, however,
many places doesn't handle this correctly;
- Between step 3 and 4, if new io is dispatched, NULL will be read for
the rdev, and data will be lost.

##### New synchronization

Similar to how blk_mq_freeze_queue() works

Add or remove disks:

1. suspend the array, this should guarantee no new io is dispatched and
wait for dispatched io to be done;
2. add or remove rdevs from array;
3. resume the array;

IO path doesn't need to change for now, and all rcu implementation can
be removed.

There are already apis to suspend/resume the array, unfortunately, they
can't be used here because:

- old apis only wait for io to be dispatched, not to be done;
- old apis is only supported for the personality that implement quiesce
callback;
- old apis must be called after the array start running;
- old apis must hold 'reconfig_mutex', and will wait for io to be done,
this behavior is risky because 'reconfig_mutex' is used for daemon
thread to update super_block and handle io. In order to prevent
potential problems, there is a weird logical that suspend array hold
'reconfig_mutex' for mddev_check_recovery() to update super_block;

Then main work is divided into 3 steps, at first make sure new apis to
suspend the array is general:

- make sure suspend array will wait for io to be done(Done by []);
- make sure suspend array can be called for all personalities(Done by
[]);
- make sure suspend array can be called at any time(Done by []);
- make sure suspend array doesn't rely on 'reconfig_mutex';

The second step is to replace old apis with new apis:

```
From:
lock reconfig_mutex
suspend array
resume array
unlock reconfig_mutex

To:
suspend array
lock reconfig_mutex
unlock reconfig_mutex
resume array
```

Finally, for the remain path that involved reconfiguration, suspend the
array first:

```
From:
// reconfiguration

To:
suspend array
// reconfiguration
resume array
```

>>> 2. In the cover letter, please also highlight that we are removing
>>>    MD_ALLOW_SB_UPDATE and MD_UPDATING_SB. This is a big improvement.
>>>
>>
>> Okay.
>>> 3. Please rearrange the patch set so that the two "READ_ONCE/WRITE_ONCE"
>>> patches are at the beginning.
>>
>> Okay.
>>>
>>> 4. Please consider merging some patches. Current "add-api => use-api =>
>>> remove-old-api" makes it tricky to follow what is being changed. For this set,
>>> I found the diff of the whole set easier to follow than some of the big patches.
>> I refer to some other big patchset to replace an old api, for example:
>>
>> https://lore.kernel.org/all/20230818123232.2269-1-jack@suse.cz/
> 
> Yes, this is a safe way to replace old APIs. Since the scale of this
> patchset is
> smaller, I was thinking it might not be necessary to go that path. But
> I will let
> you make the decision.
> 
>> Currently I prefer to use one patch for each function point. And I do
>> merged some patches in this version, and for remaining patches, do you
>> prefer to use one patch for one file instead of one function point?(For
>> example, merge patch 10-12 for md/raid5-cache, and 13-16 for md/raid5).
> 
> I think 10 should be a separate patch, and we can merge 11 and 12. We can
> merge 13-16, and maybe also 5-7 and 18-20.
> 
> Thanks,
> Song
> .
> 

