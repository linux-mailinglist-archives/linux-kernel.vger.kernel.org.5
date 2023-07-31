Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED898768977
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGaBID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:08:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C61191;
        Sun, 30 Jul 2023 18:08:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RDg8Y1dyZz4f3jLg;
        Mon, 31 Jul 2023 09:07:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFtCcdktnTRPA--.18098S3;
        Mon, 31 Jul 2023 09:07:58 +0800 (CST)
Subject: Re: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com>
 <d8fde5d9-3ac5-0945-dc8e-315092a67528@huaweicloud.com>
 <CAPhsuW6UnqTowo0CZVZXcb_Z=OjV5xFwYqD1O6FO3CLqiKx2DQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <52ddb065-e778-53d0-9679-7a6879e8a8e9@huaweicloud.com>
Date:   Mon, 31 Jul 2023 09:07:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6UnqTowo0CZVZXcb_Z=OjV5xFwYqD1O6FO3CLqiKx2DQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFtCcdktnTRPA--.18098S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr13KF1Uur4rCr4ktF1DKFg_yoW8Wry5pa
        17GasxWr18AryUGF1Dtr4UuFyFya17KFZ7XFyfWw12qr9IvrWxW3y5KF45urnIvr4UA34j
        yF1jgrZxCF1FgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/29 18:49, Song Liu 写道:
> On Mon, Jul 24, 2023 at 10:12 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> 在 2023/07/22 15:53, Zhang Shurong 写道:
>>> If rddev->raid_disk is greater than mddev->raid_disks, there will be
>>> an out-of-bounds in raid1_remove_disk(). We have already found
>>> similar reports as follows:
>>>
>>> 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
>>> 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")
>>>
>>> Fix this bug by checking whether the "number" variable is
>>> valid.
>>
>> LGTM
>>
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>>> ---
>>> Changes in v2:
>>>    - Using conf->raid_disks instead of mddev->raid_disks.
>>>
>>>    drivers/md/raid1.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>> index dd25832eb045..80aeee63dfb7 100644
>>> --- a/drivers/md/raid1.c
>>> +++ b/drivers/md/raid1.c
>>> @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>>        struct r1conf *conf = mddev->private;
>>>        int err = 0;
>>>        int number = rdev->raid_disk;
>>> +
>>> +     if (unlikely(number >= conf->raid_disks))
>>> +             goto abort;
> 
> We need err = -EINVAL here.

I think return 0 is right here, so that caller can remove this rdev
from array successfully, this only need to return error for the case
-EBUSY.

Thanks,
Kuai

> 
>>> +
>>>        struct raid1_info *p = conf->mirrors + number;
>>>
>>>        if (rdev != p->rdev)
>>>
>>
> .
> 

