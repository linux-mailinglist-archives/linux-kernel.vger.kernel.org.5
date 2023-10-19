Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14097CEDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJSB7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSB7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:59:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5233EA;
        Wed, 18 Oct 2023 18:59:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9rWF5Fcgz4f3k5Y;
        Thu, 19 Oct 2023 09:59:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3Dt6JjTBlWBVdDQ--.36072S3;
        Thu, 19 Oct 2023 09:59:39 +0800 (CST)
Subject: Re: [PATCH -next 0/6] md: remvoe rcu protection to access rdev from
 conf
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
 <CAPhsuW6vE7O1uPXnC3yrUT4maghKdx+E0odqF7UxP5esgBC=2A@mail.gmail.com>
 <d330b1f1-fd72-554c-f25c-dd9c347d8dd1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ce5d1e69-6a9a-0492-a5b0-57ec860b77c3@huaweicloud.com>
Date:   Thu, 19 Oct 2023 09:59:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d330b1f1-fd72-554c-f25c-dd9c347d8dd1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3Dt6JjTBlWBVdDQ--.36072S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy7JF4fAFyrZw1kAFykAFb_yoW5Kw17pF
        Z3ta43WrWUXr1rWFyDX3yDCryrJw18X3yDAry3W3WxZ3yjvr92gr15XFyv9F98C393AFWj
        qw1UJrZxZFyUAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/19 9:04, Yu Kuai 写道:
> Hi,
> 
> 在 2023/10/19 1:58, Song Liu 写道:
>> On Sun, Oct 15, 2023 at 6:28 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Yu Kuai (6):
>>>    md: remove useless debug code to print configuration
>>>    md: remove flag RemoveSynchronized
>>>    md/raid1: remove rcu protection to access rdev from conf
>>>    md/raid10: remove rcu protection to access rdev from conf
>>>    md/raid5: remove rcu protection to access rdev from conf
>>>    md/md-multipath: remove rcu protection to access rdev from conf
>>
>> While a cover letter is highly recommended for a patchset. An empty
>> cover letter like this doesn't really add value. If the description of 
>> each
>> patch is clear enough, it is OK to not have a cover-letter.
> 
> Yes, I was hoping commit message in each patch is clear enough,I'll try
> to explain everything more detailed.

I'll add following cover letter in the next version:

The lifetime of rdev:

1. md_import_device() generate a rdev based on underlying disk;

    mddev_lock()
    rdev = kzalloc();
    rdev->bdev = blkdev_get_by_dev();
    mddev_unlock()

2. bind_rdev_to_array() add this rdev to mddev->disks;

    mddev_lock()
    kobject_add(&rdev->kobj, &mddev->kobj, ...);
    list_add_rcu(&rdev->same_set, &mddev->disks);
    mddev_unlock()

3. remove_and_add_spares() add this rdev to conf;

    mddev_lock()
    rdev_addable();
    pers->hot_add_disk();
    rcu_assign_pointer(conf->rdev, rdev);
    mddev_unlock()

4. Use this array with rdev;

5. remove_and_add_spares() remove rdev from conf;

    // triggered by sysfs/ioctl
    mddev_lock()
    rdev_removeable();
    pers->hot_remove_disk();
     rcu_assign_pointer(conf->rdev, NULL);
     synchronize_rcu();
    mddev_unlock()

    // triggered by deamon
    mddev_lock()
    rdev_removeable();
    synchronize_rcu(); -> this can't protect accessing rdev from conf
    pers->hot_remove_disk();
     rcu_assign_pointer(conf->rdev, NULL);
    mddev_unlock()

6. md_kick_rdev_from_array() remove rdev from mddev->disks;

    mddev_lock()
    list_del_rcu(&rdev->same_set);
    synchronize_rcu();
    list_add(&rdev->same_set, &mddev->deleting)
    mddev_unlock()
     export_rdev

There are two seperate rcu protection for rdev, and this pathset remove
the protection of conf(step 3 and 5), because it's safe to access rdev
from conf in following cases:

  - If 'reconfig_mutex' is held, because rdev can't be added or rmoved to
  conf;
  - If there is normal IO inflight, because mddev_suspend() will prevent
  rdev to be added or removed to conf;
  - If sync thread is running, because remove_and_add_spares() can only
  be called from daemon thread when sync thread is done, and
  'MD_RECOVERY_RUNNING' is also checked for ioctl/sysfs;
  - if rcu_read_lock() or any spinlock is held, because synchronize_rcu()
  from step 6 prevent rdev to be freed until rcu_read_unlock() or
  spinlock is released;

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
>>>
>>>   drivers/md/md-multipath.c |  29 ++---
>>>   drivers/md/md.c           |  37 +-----
>>>   drivers/md/raid1.c        |  94 ++++-----------
>>>   drivers/md/raid10.c       | 248 +++++++++-----------------------------
>>>   drivers/md/raid5-cache.c  |  11 +-
>>>   drivers/md/raid5-ppl.c    |  16 +--
>>>   drivers/md/raid5.c        | 225 ++++++++++------------------------
>>>   drivers/md/raid5.h        |   4 +-
>>>   8 files changed, 163 insertions(+), 501 deletions(-)
>>>
>>> -- 
>>> 2.39.2
>>>
>> .
>>
> 
> .
> 

