Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA347F88AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjKYGsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:48:08 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC8F18E;
        Fri, 24 Nov 2023 22:48:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Scj934PWTz4f3kKD;
        Sat, 25 Nov 2023 14:48:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 61FC31A0B43;
        Sat, 25 Nov 2023 14:48:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgBHShComGFlJRSDBw--.22491S3;
        Sat, 25 Nov 2023 14:48:10 +0800 (CST)
Subject: Re: [PATCH -next] md: synchronize flush io with array reconfiguration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, maan@systemlinux.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231108180210.3657203-1-yukuai1@huaweicloud.com>
 <CAPhsuW7kkSMNpo9cm3L23o7T676iLa=7gq8V9YkCx0MA6ad+QQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <baef0c45-9136-ed83-fab5-e2ea7108f1a3@huaweicloud.com>
Date:   Sat, 25 Nov 2023 14:48:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7kkSMNpo9cm3L23o7T676iLa=7gq8V9YkCx0MA6ad+QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHShComGFlJRSDBw--.22491S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fuF4furW5ArWUCw4kZwb_yoW5ZF18p3
        y0qay5trWUXFW7Cw43Jrs8GryfWw40vFW8tFW3A347ZwnrXrn5G3yrtF95Xr98Aryfu3yr
        ur1qqwsruayjvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/25 1:36, Song Liu 写道:
> On Wed, Nov 8, 2023 at 2:07 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently rcu is used to protect iterating rdev from submit_flushes():
>>
>> submit_flushes                  remove_and_add_spares
>>                                   synchronize_rcu
>>                                   pers->hot_remove_disk()
>>   rcu_read_lock()
>>   rdev_for_each_rcu
>>    if (rdev->raid_disk >= 0)
>>                                   rdev->radi_disk = -1;
>>     atomic_inc(&rdev->nr_pending)
>>     rcu_read_unlock()
>>     bi = bio_alloc_bioset()
>>     bi->bi_end_io = md_end_flush
>>     bi->private = rdev
>>     submit_bio
>>     // issue io for removed rdev
>>
>> Fix this problem by grabbing 'acive_io' before iterating rdev, make sure
>> that remove_and_add_spares() won't concurrent with submit_flushes().
>>
>> Fixes: a2826aa92e2e ("md: support barrier requests on all personalities.")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> LGTM.
> 
>> ---
>>   drivers/md/md.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 4ee4593c874a..eb3e455bcbae 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -529,6 +529,9 @@ static void md_end_flush(struct bio *bio)
>>          rdev_dec_pending(rdev, mddev);
>>
>>          if (atomic_dec_and_test(&mddev->flush_pending)) {
>> +               /* The pair is percpu_ref_tryget() from md_flush_request() */
>> +               percpu_ref_put(&mddev->active_io);
>> +
>>                  /* The pre-request flush has finished */
>>                  queue_work(md_wq, &mddev->flush_work);
>>          }
>> @@ -548,12 +551,8 @@ static void submit_flushes(struct work_struct *ws)
>>          rdev_for_each_rcu(rdev, mddev)
>>                  if (rdev->raid_disk >= 0 &&
>>                      !test_bit(Faulty, &rdev->flags)) {
>> -                       /* Take two references, one is dropped
>> -                        * when request finishes, one after
>> -                        * we reclaim rcu_read_lock
>> -                        */
>>                          struct bio *bi;
>> -                       atomic_inc(&rdev->nr_pending);
>> +
>>                          atomic_inc(&rdev->nr_pending);
>>                          rcu_read_unlock();
>>                          bi = bio_alloc_bioset(rdev->bdev, 0,
>> @@ -564,7 +563,6 @@ static void submit_flushes(struct work_struct *ws)
>>                          atomic_inc(&mddev->flush_pending);
>>                          submit_bio(bi);
>>                          rcu_read_lock();
>> -                       rdev_dec_pending(rdev, mddev);
>>                  }
>>          rcu_read_unlock();
>>          if (atomic_dec_and_test(&mddev->flush_pending))
>> @@ -617,6 +615,17 @@ bool md_flush_request(struct mddev *mddev, struct bio *bio)
>>          /* new request after previous flush is completed */
>>          if (ktime_after(req_start, mddev->prev_flush_start)) {
>>                  WARN_ON(mddev->flush_bio);
>> +               /*
>> +                * Grab a reference to make sure mddev_suspend() will wait for
>> +                * this flush to be done.
>> +                *
>> +                * md_flush_reqeust() is called under md_handle_request() and
>> +                * 'active_io' is already grabbed, hence percpu_ref_tryget()
>> +                * won't fail, percpu_ref_tryget_live() can't be used because
>> +                * percpu_ref_kill() can be called by mddev_suspend()
>> +                * concurrently.
>> +                */
>> +               percpu_ref_tryget(&mddev->active_io);
> 
> Probably add an warn_on here to catch any issues in the future.

Will do this in v2.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>>                  mddev->flush_bio = bio;
>>                  bio = NULL;
>>          }
>> --
>> 2.39.2
>>
> .
> 

