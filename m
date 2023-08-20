Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA1781C24
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHTCn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHTCnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:43:46 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA59399D1;
        Sat, 19 Aug 2023 18:44:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RSz1C1mV5z4f3jZd;
        Sun, 20 Aug 2023 09:44:15 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH1qjub+Fka8+BBA--.16221S3;
        Sun, 20 Aug 2023 09:44:15 +0800 (CST)
Subject: Re: [PATCH -next v2 2/7] md: factor out a helper to choose sync
 direction from md_check_recovery()
To:     Song Liu <song@kernel.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-3-yukuai1@huaweicloud.com>
 <20230817095814.00005530@linux.intel.com>
 <CAPhsuW5Nn4gPv6EKaxHqtJfRFXMLg3bEBTNknLBR3tNuxFyVMQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <716511c3-9252-dba6-0902-a8231bf444fa@huaweicloud.com>
Date:   Sun, 20 Aug 2023 09:44:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5Nn4gPv6EKaxHqtJfRFXMLg3bEBTNknLBR3tNuxFyVMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH1qjub+Fka8+BBA--.16221S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWDCrW5ZFWDKF43WrW7Jwb_yoW8WF1DpF
        47Ga13Cr4UJ3y7Jw1Sqw1kCa4Fkw4xtrWUtry7J3W8XFn8ZryvgFyfKF4vgr95Cry3Gr15
        ur4UtFyfCF10yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/18 5:49, Song Liu 写道:
> On Thu, Aug 17, 2023 at 12:58 AM Mariusz Tkaczyk
> <mariusz.tkaczyk@linux.intel.com> wrote:
>>
>> On Tue, 15 Aug 2023 11:09:52 +0800
>> Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> There are no functional changes, on the one hand make the code cleaner,
>>> on the other hand prevent following checkpatch error in the next patch to
>>> delay choosing sync direction to md_start_sync().
>>>
>>> ERROR: do not use assignment in if condition
>>> +       } else if ((spares = remove_and_add_spares(mddev, NULL))) {
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   drivers/md/md.c | 68 +++++++++++++++++++++++++++++++------------------
>>>   1 file changed, 43 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 90815be1e80f..4846ff6d25b0 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -9246,6 +9246,48 @@ static int remove_and_add_spares(struct mddev *mddev,
>>>        return spares;
>>>   }
>>>
>>> +static bool md_choose_sync_direction(struct mddev *mddev, int *spares)
>>
>> The naming is little confusing because as a direction I would expect forward or
>> backward - from end to start or or from start to end. In this case you are
>> determining the type of the background operation needed. Assuming that reshape
>> is a kind of "sync" operation I would say "md_choose_sync_action".
> 
> Yeah, md_choose_sync_direction is indeed confusing.
> 

Thanks for the suggestion, I'll update this in the new version.

Kuai,

> Thanks,
> Song
> .
> 

