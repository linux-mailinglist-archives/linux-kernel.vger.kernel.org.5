Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC17781C26
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHTCoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHTCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:43:52 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5A847E8;
        Sat, 19 Aug 2023 18:45:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RSz2y0qfDz4f3mJX;
        Sun, 20 Aug 2023 09:45:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHoqVMcOFkeueBBA--.29859S3;
        Sun, 20 Aug 2023 09:45:49 +0800 (CST)
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to
 md_start_sync()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-4-yukuai1@huaweicloud.com>
 <bb11d6ca-978a-8e1d-e721-d9d84c9dc5e3@huaweicloud.com>
 <CAPhsuW65Hxq=+D6M6zV8n+k4FarTHui=pSs2YPNKs9MYBD4MHA@mail.gmail.com>
 <bd0a6f0f-2766-deb9-bbfd-5310d3f18e12@huaweicloud.com>
 <CAPhsuW5a6+x6k3x6jvz7L5oVbHCd-EdmfXc4E4v5i0kCs6WPkw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0b154fb7-f577-616b-3d39-25c199897e61@huaweicloud.com>
Date:   Sun, 20 Aug 2023 09:45:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5a6+x6k3x6jvz7L5oVbHCd-EdmfXc4E4v5i0kCs6WPkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHoqVMcOFkeueBBA--.29859S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWfJryrurWDWw47AFW5KFg_yoW5CrWrpa
        yxJFn8JrWDJFy3Ar42q3Z0qFyqgr1jqrWDXF43W34fJrnIvF1fGF1UWr1UGFWkJ3WkCa18
        Zw48JFZxAry5KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/18 5:53, Song Liu 写道:
> On Tue, Aug 15, 2023 at 6:07 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/08/15 23:54, Song Liu 写道:
>>> On Tue, Aug 15, 2023 at 2:00 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>> [...]
>>>>> +
>>>>> +not_running:
>>>>> +     clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>>>>> +     clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
>>>>> +     clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
>>>>> +     clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>>>>> +     clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>>>>> +     mddev_unlock(mddev);
>>>>> +
>>>>> +     wake_up(&resync_wait);
>>>>> +     if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
>>>>> +         mddev->sysfs_action)
>>>>> +             sysfs_notify_dirent_safe(mddev->sysfs_action);
>>>>>     }
>>>>>
>>>>>     /*
>>>>> @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
>>>>>                 return;
>>>>>
>>>>>         if (mddev_trylock(mddev)) {
>>>>> -             int spares = 0;
>>>>>                 bool try_set_sync = mddev->safemode != 0;
>>>>>
>>>>>                 if (!mddev->external && mddev->safemode == 1)
>>>>> @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
>>>>>                 clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>>>>>
>>>>>                 if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
>>>>> -                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>>>> -                     goto not_running;
>>>>> -             if (!md_choose_sync_direction(mddev, &spares))
>>>>> -                     goto not_running;
>>>>> -             if (mddev->pers->sync_request) {
>>>>> -                     if (spares) {
>>>>> -                             /* We are adding a device or devices to an array
>>>>> -                              * which has the bitmap stored on all devices.
>>>>> -                              * So make sure all bitmap pages get written
>>>>> -                              */
>>>>> -                             md_bitmap_write_all(mddev->bitmap);
>>>>> -                     }
>>>>> +                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>>>
>>>> Sorry that I made a mistake here while rebasing v2, here should be
>>>>
>>>> !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)
>>>>
>>>> With this fixed, there are no new regression for mdadm tests using loop
>>>> devicein my VM.
>>>
>>>                   if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
>>>                       !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>>                           queue_work(md_misc_wq, &mddev->sync_work);
>>>                   } else {
>>>
>>> This doesn't look right. Should we do
>>>
>>>                   if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) &&
>>>                       !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>>                           queue_work(md_misc_wq, &mddev->sync_work);
>>>                   } else {
>>>
>>> instead?
>>>
>>
>> Yes you're right, this is exactly what I did in v1, sorry that I keep
>> making mistake while rebasing.
> 
> Please fix this, address comments from other reviews, and resend the
> patches. Also, there are some typos in the commit logs, please also fix them.
> 

Of course, and sorry for the dealy, I was ill and rested at home for a
few days.

Thanks,
Kuai

> Unfortunately, we won't ship this (and the two other big sets) in 6.6.
> 
> Thanks,
> Song
> .
> 

