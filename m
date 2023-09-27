Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878907AF7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjI0BtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjI0BrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:47:08 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6ACF7;
        Tue, 26 Sep 2023 17:54:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RwJ6l5pMzz4f3k6X;
        Wed, 27 Sep 2023 08:54:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd1ffRNlJNruBQ--.41325S3;
        Wed, 27 Sep 2023 08:54:56 +0800 (CST)
Subject: Re: [PATCH v2 1/2] md: factor out a new helper to put mddev
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
 <20230926025827.671407-2-yukuai1@huaweicloud.com>
 <CAPhsuW4dXrwt7VTifcdbdwH6Uz3b4m4Z54fBfD3LDjXy89PTkQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <94ef3ef4-0580-416b-f672-250a91b39e10@huaweicloud.com>
Date:   Wed, 27 Sep 2023 08:54:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4dXrwt7VTifcdbdwH6Uz3b4m4Z54fBfD3LDjXy89PTkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd1ffRNlJNruBQ--.41325S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxWF48Kw1rXFy5GF17Jrb_yoW8Zr1Dpa
        ySqa90kr4DXFy3W39rZanru3WYqws2grWktryfKwn8ZFy5Wr1DWw1Fgws5Wr1DAw1fJFs0
        v3WUK3y7Cr1UtrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/27 8:15, Song Liu 写道:
> On Mon, Sep 25, 2023 at 8:04 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are no functional changes, the new helper will still hold
>> 'all_mddevs_lock' after putting mddev, and it will be used to simplify
>> md_seq_ops.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 10cb4dfbf4ae..a5ef6f7da8ec 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev *mddev)
>>
>>   static void mddev_delayed_delete(struct work_struct *ws);
>>
>> -void mddev_put(struct mddev *mddev)
>> +static void __mddev_put(struct mddev *mddev, bool locked)
>>   {
>> -       if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
>> +       if (locked) {
>> +               spin_lock(&all_mddevs_lock);
>> +               if (!atomic_dec_and_test(&mddev->active))
>> +                       return;
>> +       } else if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
>>                  return;
>> +
> 
> This condition is indeed very confusing. No matter whether we call the
> flag "locked" or "do_lock", it is not really accurate.
> 
> How about we factor out a helper with the following logic:
> 
>          if (!mddev->raid_disks && list_empty(&mddev->disks) &&
>              mddev->ctime == 0 && !mddev->hold_active) {
>                  /* Array is not configured at all, and not held active,
>                   * so destroy it */
>                  set_bit(MD_DELETED, &mddev->flags);
> 
>                  /*
>                   * Call queue_work inside the spinlock so that
>                   * flush_workqueue() after mddev_find will succeed in waiting
>                   * for the work to be done.
>                   */
>                  queue_work(md_misc_wq, &mddev->del_work);
>          }
> 
> and then use it at the two callers?
> 
> Does this make sense?

Yes, that sounds great. I'll do this in v3.

Thanks,
Kuai

> 
> Thanks,
> Song
> .
> 

