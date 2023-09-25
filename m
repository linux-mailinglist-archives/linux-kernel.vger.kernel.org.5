Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C37ACD89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjIYBSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIYBSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:18:23 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8271DF;
        Sun, 24 Sep 2023 18:18:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rv4kX2m4Bz4f3kKH;
        Mon, 25 Sep 2023 09:18:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgB3BdXT3xBlhCZJBQ--.61915S3;
        Mon, 25 Sep 2023 09:18:13 +0800 (CST)
Subject: Re: [PATCH -next v2 01/28] md: use READ_ONCE/WRITE_ONCE for
 'suspend_lo' and 'suspend_hi'
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
 <20230828020021.2489641-2-yukuai1@huaweicloud.com>
 <CALTww28MiiWTOyLYHErAZWTzn8iGif5=adY7yohxmn1OxrpK=w@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4d8fc562-5e9a-3932-90d4-c7566696d965@huaweicloud.com>
Date:   Mon, 25 Sep 2023 09:18:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww28MiiWTOyLYHErAZWTzn8iGif5=adY7yohxmn1OxrpK=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3BdXT3xBlhCZJBQ--.61915S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuFyUZF1fuF4rXF17GFg_yoW5Cry8p3
        yIgFW5Cr4UtasxA34jq3WkCFyrXw4aqrWqyrZrW3W7C3WxGrn3GF15Wry3Wr9YvF97CFs3
        Ga1UA3WUA348GFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
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

在 2023/09/14 10:53, Xiao Ni 写道:
> On Mon, Aug 28, 2023 at 10:04 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Because reading 'suspend_lo' and 'suspend_hi' from md_handle_request()
>> is not protected, use READ_ONCE/WRITE_ONCE to prevent reading abnormal
>> value.
> 
> Hi Kuai
> 
> If we don't use READ_ONCE/WRITE_ONCE, What's the risk here? Could you
> explain in detail or give an example?

Sorry for the late reply.

That depends on the architecture, a load/store may not be atomice,
for example:

// assume a is 10
t1 write 01
// write half first
a = 11
		t2 read
		//read
		a = 11 -> read abnormal value.
// write other half
a = 01

READ_ONCE/WRITE_ONCE can guarantee that either old value or new value is
read.

Thanks,
Kuai

> 
> Regards
> Xiao
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 46badd13a687..9d8dff9d923c 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -359,11 +359,11 @@ static bool is_suspended(struct mddev *mddev, struct bio *bio)
>>                  return true;
>>          if (bio_data_dir(bio) != WRITE)
>>                  return false;
>> -       if (mddev->suspend_lo >= mddev->suspend_hi)
>> +       if (READ_ONCE(mddev->suspend_lo) >= READ_ONCE(mddev->suspend_hi))
>>                  return false;
>> -       if (bio->bi_iter.bi_sector >= mddev->suspend_hi)
>> +       if (bio->bi_iter.bi_sector >= READ_ONCE(mddev->suspend_hi))
>>                  return false;
>> -       if (bio_end_sector(bio) < mddev->suspend_lo)
>> +       if (bio_end_sector(bio) < READ_ONCE(mddev->suspend_lo))
>>                  return false;
>>          return true;
>>   }
>> @@ -5171,7 +5171,8 @@ __ATTR(sync_max, S_IRUGO|S_IWUSR, max_sync_show, max_sync_store);
>>   static ssize_t
>>   suspend_lo_show(struct mddev *mddev, char *page)
>>   {
>> -       return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend_lo);
>> +       return sprintf(page, "%llu\n",
>> +                      (unsigned long long)READ_ONCE(mddev->suspend_lo));
>>   }
>>
>>   static ssize_t
>> @@ -5191,7 +5192,7 @@ suspend_lo_store(struct mddev *mddev, const char *buf, size_t len)
>>                  return err;
>>
>>          mddev_suspend(mddev);
>> -       mddev->suspend_lo = new;
>> +       WRITE_ONCE(mddev->suspend_lo, new);
>>          mddev_resume(mddev);
>>
>>          mddev_unlock(mddev);
>> @@ -5203,7 +5204,8 @@ __ATTR(suspend_lo, S_IRUGO|S_IWUSR, suspend_lo_show, suspend_lo_store);
>>   static ssize_t
>>   suspend_hi_show(struct mddev *mddev, char *page)
>>   {
>> -       return sprintf(page, "%llu\n", (unsigned long long)mddev->suspend_hi);
>> +       return sprintf(page, "%llu\n",
>> +                      (unsigned long long)READ_ONCE(mddev->suspend_hi));
>>   }
>>
>>   static ssize_t
>> @@ -5223,7 +5225,7 @@ suspend_hi_store(struct mddev *mddev, const char *buf, size_t len)
>>                  return err;
>>
>>          mddev_suspend(mddev);
>> -       mddev->suspend_hi = new;
>> +       WRITE_ONCE(mddev->suspend_hi, new);
>>          mddev_resume(mddev);
>>
>>          mddev_unlock(mddev);
>> --
>> 2.39.2
>>
> 
> .
> 

