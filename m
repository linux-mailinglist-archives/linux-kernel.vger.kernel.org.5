Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4407ACD61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjIYBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:02:33 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AF9C4;
        Sun, 24 Sep 2023 18:02:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rv4ND4ymDz4f3jpm;
        Mon, 25 Sep 2023 09:02:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd0b3BBlQDJIBQ--.63409S3;
        Mon, 25 Sep 2023 09:02:21 +0800 (CST)
Subject: Re: [PATCH] md/raid1: only update stack limits with the device in use
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230906093720.1070929-1-linan122@huawei.com>
 <e67775c0-2d41-5541-a644-e5239ada3333@huaweicloud.com>
 <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com>
 <5e08c3aa-7bd5-f5dd-3d38-b93fb772ea56@huaweicloud.com>
 <CAPhsuW4pP5yJGJyfA67754Y-5GOABrUmNRb9FK75=Jfa=zBGMQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <876da383-1450-af0d-2943-da09ba8c4c02@huaweicloud.com>
Date:   Mon, 25 Sep 2023 09:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4pP5yJGJyfA67754Y-5GOABrUmNRb9FK75=Jfa=zBGMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd0b3BBlQDJIBQ--.63409S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4DAFW5WryUJrW8Gr47XFb_yoW5CF17pF
        17Ja45C3srWry293WIyryrW3Wrt347WFW0gr13KryjkryDtry2kr4xKry5WryYqrs7tr1j
        vr1DKFy7AFnYkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/23 5:53, Song Liu 写道:
> On Sat, Sep 9, 2023 at 7:24 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/09/09 4:42, Song Liu 写道:
>>> On Wed, Sep 6, 2023 at 11:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2023/09/06 17:37, Li Nan 写道:
>>>>> Spare device affects array stack limits is unreasonable. For example,
>>>>> create a raid1 with two 512 byte devices, the logical_block_size of array
>>>>> will be 512. But after add a 4k devcie as spare, logical_block_size of
>>>>> array will change as follows.
>>>>>
>>>>>      mdadm -C /dev/md0 -n 2 -l 10 /dev/sd[ab]   //sd[ab] is 512
>>>>>      //logical_block_size of md0: 512
>>>>>
>>>>>      mdadm --add /dev/md0 /dev/sdc                      //sdc is 4k
>>>>>      //logical_block_size of md0: 512
>>>>>
>>>>>      mdadm -S /dev/md0
>>>>>      mdadm -A /dev/md0 /dev/sd[ab]
>>>>>      //logical_block_size of md0: 4k
>>>>>
>>>>> This will confuse users, as nothing has been changed, why did the
>>>>> logical_block_size of array change?
>>>>>
>>>>> Now, only update logical_block_size of array with the device in use.
>>>>>
>>>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>>>> ---
>>>>>     drivers/md/raid1.c | 19 ++++++++-----------
>>>>>     1 file changed, 8 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>>> index 95504612b7e2..d75c5dd89e86 100644
>>>>> --- a/drivers/md/raid1.c
>>>>> +++ b/drivers/md/raid1.c
>>>>> @@ -3140,19 +3140,16 @@ static int raid1_run(struct mddev *mddev)
>>>>
>>>> I'm not sure about this behaviour, 'logical_block_size' can be
>>>> increased while adding new underlying disk, the key point is not when
>>>> to increase 'logical_block_size'. If there is a mounted fs, or
>>>> partition in the array, I think the array will be corrupted.
>>>
>>> How common is such fs/partition corruption? I think some fs and partition
>>> table can work properly with 512=>4096 change?
>>
>> For fs, that should depend on fs bs that is usually set in mkfs, if bs
>> is less than 4096, then such fs can't be mounted.
>>
>> For partition, that is much worse, start sector and end sector will stay
>> the same, while sector size is changed. And 4096 -> 512 change is the
>> same.
> 
> Thanks for this information.
> 
>>>>
>>>> Perhaps once that array is started, logical_block_size should not be
>>>> changed anymore, this will require 'logical_block_size' to be metadate
>>>> inside raid superblock. And the array should deny any new disk with
>>>> bigger logical_block_size.
> 
> I really hope we can avoid adding this to the raid superblock. But I am not
> sure what would be a better solution (that is also backward compatible).
> Do we have real world reports of such issues?

Yes, our customer is using raid1 with one 4k disk and other 512 disk as
root device, and they reported that if 4k disk is kicked out from the
array, then system can't reboot.

And for backward compatible, I think it can be solved by continue to use
biggest block size from uderlying disks if metadata is 0.

Thanks,
Kuai


> 
> Thanks,
> Song
> .
> 

