Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6A7AED41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjIZMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIZMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:54:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B7116;
        Tue, 26 Sep 2023 05:54:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rw06x2LHmz4f3lfR;
        Tue, 26 Sep 2023 20:54:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd1p1BJlyCfFBQ--.58358S3;
        Tue, 26 Sep 2023 20:54:03 +0800 (CST)
Subject: Re: [PATCH v2 1/2] md: factor out a new helper to put mddev
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230926025827.671407-1-yukuai1@huaweicloud.com>
 <20230926025827.671407-2-yukuai1@huaweicloud.com>
 <20230926144536.0000017d@linux.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3d304e39-60c1-8f3c-f8b3-de8850d70b82@huaweicloud.com>
Date:   Tue, 26 Sep 2023 20:54:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230926144536.0000017d@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd1p1BJlyCfFBQ--.58358S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kWFW5WF18CFWxJw4Dtwb_yoW8uw1xpF
        WFga98Cr1UXry5X39ruanxu3WYgw1v9rWDKryfK3s8ZFyDurn3W3WFgw45Ww1kCa1fXan0
        v3WUGa4Uur18CrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
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

ÔÚ 2023/09/26 20:45, Mariusz Tkaczyk Ð´µÀ:
> On Tue, 26 Sep 2023 10:58:26 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
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
>> @@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev
>> *mddev)
>>   static void mddev_delayed_delete(struct work_struct *ws);
>>   
>> -void mddev_put(struct mddev *mddev)
>> +static void __mddev_put(struct mddev *mddev, bool locked)
>>   {
>> -	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
>> +	if (locked) {
>> +		spin_lock(&all_mddevs_lock);
>> +		if (!atomic_dec_and_test(&mddev->active))
>> +			return;
> 
> It is "locked" and we are taking lock? It seems weird to me. Perhaps "do_lock"
> would be better? Do you meant "lockdep_assert_held(&all_mddevs_lock);"

Yes, do_lock is a better name, true means this function will return with
lock held.
> 
> Something is wrong here, we have two paths and in both cases we are
> taking lock.

No, in the first path, lock is held unconditionaly, that's what we
expected in md_seq_show(); in the next path, lock will only be held if
active is decreased to 0.

Thanks,
Kuai

> 
>> +	} else if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
>>   		return;
>> +
>>   	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
>>   	    mddev->ctime == 0 && !mddev->hold_active) {
>>   		/* Array is not configured at all, and not held active,
>> @@ -633,7 +638,14 @@ void mddev_put(struct mddev *mddev)
>>   		 */
>>   		queue_work(md_misc_wq, &mddev->del_work);
>>   	}
>> -	spin_unlock(&all_mddevs_lock);
>> +
>> +	if (!locked)
>> +		spin_unlock(&all_mddevs_lock);
> As above, I'm not sure if it is correct.
> 
> Thanks,
> Mariusz
> 
> .
> 

