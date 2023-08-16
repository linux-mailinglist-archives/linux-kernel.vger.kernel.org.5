Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF377D755
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjHPBH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjHPBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:07:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD686211E;
        Tue, 15 Aug 2023 18:07:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RQVNY67Ssz4f3pHm;
        Wed, 16 Aug 2023 09:07:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6lNIdxkR5k_Aw--.16538S3;
        Wed, 16 Aug 2023 09:07:26 +0800 (CST)
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
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bd0a6f0f-2766-deb9-bbfd-5310d3f18e12@huaweicloud.com>
Date:   Wed, 16 Aug 2023 09:07:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW65Hxq=+D6M6zV8n+k4FarTHui=pSs2YPNKs9MYBD4MHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6lNIdxkR5k_Aw--.16538S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4UKrWkZFWrZr18tFWrKrg_yoW5JF1Upa
        yfJFn8GrW7XFy3XrW2q3Z0qayj9r1jqrZrJF43Wa4fJrnaqF1fKF1rWF17CFWDJa929a1r
        Zw48Ja9xZFyFgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/15 23:54, Song Liu 写道:
> On Tue, Aug 15, 2023 at 2:00 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> [...]
>>> +
>>> +not_running:
>>> +     clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
>>> +     clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
>>> +     clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
>>> +     clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
>>> +     clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>>> +     mddev_unlock(mddev);
>>> +
>>> +     wake_up(&resync_wait);
>>> +     if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
>>> +         mddev->sysfs_action)
>>> +             sysfs_notify_dirent_safe(mddev->sysfs_action);
>>>    }
>>>
>>>    /*
>>> @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
>>>                return;
>>>
>>>        if (mddev_trylock(mddev)) {
>>> -             int spares = 0;
>>>                bool try_set_sync = mddev->safemode != 0;
>>>
>>>                if (!mddev->external && mddev->safemode == 1)
>>> @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
>>>                clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>>>
>>>                if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
>>> -                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>>> -                     goto not_running;
>>> -             if (!md_choose_sync_direction(mddev, &spares))
>>> -                     goto not_running;
>>> -             if (mddev->pers->sync_request) {
>>> -                     if (spares) {
>>> -                             /* We are adding a device or devices to an array
>>> -                              * which has the bitmap stored on all devices.
>>> -                              * So make sure all bitmap pages get written
>>> -                              */
>>> -                             md_bitmap_write_all(mddev->bitmap);
>>> -                     }
>>> +                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>>
>> Sorry that I made a mistake here while rebasing v2, here should be
>>
>> !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)
>>
>> With this fixed, there are no new regression for mdadm tests using loop
>> devicein my VM.
> 
>                  if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
>                      !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>                          queue_work(md_misc_wq, &mddev->sync_work);
>                  } else {
> 
> This doesn't look right. Should we do
> 
>                  if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery) &&
>                      !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>                          queue_work(md_misc_wq, &mddev->sync_work);
>                  } else {
> 
> instead?
> 

Yes you're right, this is exactly what I did in v1, sorry that I keep
making mistake while rebasing.

Thanks,
Kuai

> Thanks,
> Song
> .
> 

