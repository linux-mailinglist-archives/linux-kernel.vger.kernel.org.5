Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857C7837C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHVCI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHVCIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:08:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD130D1;
        Mon, 21 Aug 2023 19:08:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVCSf1Fdkz4f3jJK;
        Tue, 22 Aug 2023 10:08:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6mwGORk7OQkBQ--.11369S3;
        Tue, 22 Aug 2023 10:08:50 +0800 (CST)
Subject: Re: [PATCH -next 3/7] md: don't rely on 'mddev->pers' to be set in
 mddev_suspend()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
 <20230803132751.2741652-4-yukuai1@huaweicloud.com>
 <CAPhsuW6Q6Mf=GqRcGbMrrU_4gPvyOdJz2ZkEKZVOT=mfeQtpjg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2771400f-d4bb-d650-b075-0c2b56006545@huaweicloud.com>
Date:   Tue, 22 Aug 2023 10:08:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6Q6Mf=GqRcGbMrrU_4gPvyOdJz2ZkEKZVOT=mfeQtpjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6mwGORk7OQkBQ--.11369S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3GF18tFy5ArWxXF13Jwb_yoW8AFWUp3
        yIqFZ0yry8WFyay3yjq34kWFy5XwsYqrWvkry3XF45Z343WF1fGF1SgrZ8Xryvkw4FyF1v
        v3W5X3yxuF1j9FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
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

在 2023/08/22 8:13, Song Liu 写道:
> On Thu, Aug 3, 2023 at 6:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that active io is initialized when mddev is allocated, it's safe to
>> call mddev_suspend() before 'mddev->pers' is set.
>>
>> This also prevent null-ptr-def in some cases that caller doesn't
>> guarantee 'mddev->pers' to be set.
> 
> This description is a little confusing (to me at least). Please revise it.

Sorry about this, how about this:

'active_io' used to be initialized while the array is running, and
'mddev->pers' is set while the array is running as well. Hence caller
must hold 'reconfig_mutex' and guarantee 'mddev->pers' is set before
calling mddev_suspend().

Now that 'active_io' is initialized when mddev is allocated, such
restriction doesn't exist anymore. In the meantime, follow up patches
will refactor mddev_suspend(), hence add checking for 'mddev->pers' to
prevent null-ptr-deref.

Thanks,
Kuai

> 
> Other than that, the set looks good to me.
> 
> Thanks,
> Song
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 897e94a9e47d..f14f2f0a9484 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -448,7 +448,7 @@ void mddev_suspend(struct mddev *mddev)
>>          set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
>>          percpu_ref_kill(&mddev->active_io);
>>
>> -       if (mddev->pers->prepare_suspend)
>> +       if (mddev->pers && mddev->pers->prepare_suspend)
>>                  mddev->pers->prepare_suspend(mddev);
>>
>>          wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
>> --
>> 2.39.2
>>
> .
> 

