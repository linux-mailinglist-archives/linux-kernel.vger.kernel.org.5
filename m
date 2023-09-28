Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E77B130F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjI1Gcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjI1Gbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:31:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8811ACC0;
        Wed, 27 Sep 2023 23:31:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx3Xs5QTgz4f3jYr;
        Thu, 28 Sep 2023 14:31:41 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXNHRVlBY9XBg--.905S3;
        Thu, 28 Sep 2023 14:31:42 +0800 (CST)
Subject: Re: [PATCH] md: use interruptible apis in idle/frozen_sync_thread
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230906084401.1027358-1-linan122@huawei.com>
 <e2befbc6-dfc4-f469-78f0-b648d0ad205d@huaweicloud.com>
 <CAPhsuW4FjWohGYzWGocF+zxMcLRk7N3J8T45=QXzAmdqFFuNTA@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <382b6c81-598b-52be-c09a-2f5b293b8d69@huaweicloud.com>
Date:   Thu, 28 Sep 2023 14:31:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4FjWohGYzWGocF+zxMcLRk7N3J8T45=QXzAmdqFFuNTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXNHRVlBY9XBg--.905S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1UAr45KF4DJw1rAw1kXwb_yoW8trWDpa
        y8JFs8Ar45JrWDWw47t3Wqva4Fvw109FWDtrW3G3WfXrn3Kr9rtF1UuF1UCFyv9rWxCr4j
        ya4rKFW3ZFyrKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
        Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/09 4:29, Song Liu 写道:
> On Wed, Sep 6, 2023 at 11:31 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> 在 2023/09/06 16:44, Li Nan 写道:
>>> Before refactoring idle and frozen from action_store, interruptible apis
>>> is used so that hungtask warning won't be triggered if it takes too long
>>> to finish indle/frozen sync_thread. So change to use interruptible apis.
>>>
>> LGTM
>>
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>
>>> Signed-off-by: Li Nan <linan122@huawei.com>
> 
> I think we will need a fix tag and send this via md-fixes branch (to 6.6)?
> 

I agree, Nan, please resend this patch.

Thanks,
Kuai

> Thanks,
> Song
> 
> 
> 
>>> ---
>>>    drivers/md/md.c | 13 +++++++++----
>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 46badd13a687..52689adfa37f 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -4834,11 +4834,14 @@ static void idle_sync_thread(struct mddev *mddev)
>>>    {
>>>        int sync_seq = atomic_read(&mddev->sync_seq);
>>>
>>> -     mutex_lock(&mddev->sync_mutex);
>>> +     if (mutex_lock_interruptible(&mddev->sync_mutex))
>>> +             return;
>>> +
>>>        clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>        stop_sync_thread(mddev);
>>>
>>> -     wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
>>> +     wait_event_interruptible(resync_wait,
>>> +                     sync_seq != atomic_read(&mddev->sync_seq) ||
>>>                        !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>>>
>>>        mutex_unlock(&mddev->sync_mutex);
>>> @@ -4846,11 +4849,13 @@ static void idle_sync_thread(struct mddev *mddev)
>>>
>>>    static void frozen_sync_thread(struct mddev *mddev)
>>>    {
>>> -     mutex_lock(&mddev->sync_mutex);
>>> +     if (mutex_lock_interruptible(&mddev->sync_mutex))
>>> +             return;
>>> +
>>>        set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>>        stop_sync_thread(mddev);
>>>
>>> -     wait_event(resync_wait, mddev->sync_thread == NULL &&
>>> +     wait_event_interruptible(resync_wait, mddev->sync_thread == NULL &&
>>>                        !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
>>>
>>>        mutex_unlock(&mddev->sync_mutex);
>>>
>>
> .
> 

