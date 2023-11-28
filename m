Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264E7FAFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjK1CMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjK1CMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:12:24 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA5C9;
        Mon, 27 Nov 2023 18:12:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SfQvY60tYz4f3jrp;
        Tue, 28 Nov 2023 10:12:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id B44AE1A086B;
        Tue, 28 Nov 2023 10:12:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDX2hCKTGVlyCCKCA--.60144S3;
        Tue, 28 Nov 2023 10:12:27 +0800 (CST)
Subject: Re: [PATCH -next v2] md: synchronize flush io with array
 reconfiguration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     maan@systemlinux.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231125065419.3518254-1-yukuai1@huaweicloud.com>
 <CAPhsuW4YsDXdpHMuscQrW4NdXZxhg8-k4J0Xt_47twA8sG_Fmg@mail.gmail.com>
 <CAPhsuW57SuytxCY-fV74qx6B8AYb65nFC_t2VVeTN34Pamp=gQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ac4470c6-f9a4-ba63-63d7-69b56ef92cc7@huaweicloud.com>
Date:   Tue, 28 Nov 2023 10:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW57SuytxCY-fV74qx6B8AYb65nFC_t2VVeTN34Pamp=gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX2hCKTGVlyCCKCA--.60144S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5tryfJFy5KF4furW3KFg_yoWrGFy8pr
        Wvqa90yr4UXFW5Kw1aqFs8WryfWw40vFWIyFW3Zw12vwnIgrn3G3yftF95WFy5AFyfG3y8
        ur1qgwsxuayYvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6w
        ZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/11/28 7:32, Song Liu 写道:
> On Mon, Nov 27, 2023 at 2:16 PM Song Liu <song@kernel.org> wrote:
>>
>> On Fri, Nov 24, 2023 at 10:54 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Currently rcu is used to protect iterating rdev from submit_flushes():
>>>
>>> submit_flushes                  remove_and_add_spares
>>>                                  synchronize_rcu
>>>                                  pers->hot_remove_disk()
>>>   rcu_read_lock()
>>>   rdev_for_each_rcu
>>>    if (rdev->raid_disk >= 0)
>>>                                  rdev->radi_disk = -1;
>>>     atomic_inc(&rdev->nr_pending)
>>>     rcu_read_unlock()
>>>     bi = bio_alloc_bioset()
>>>     bi->bi_end_io = md_end_flush
>>>     bi->private = rdev
>>>     submit_bio
>>>     // issue io for removed rdev
>>>
>>> Fix this problem by grabbing 'acive_io' before iterating rdev, make sure
>>> that remove_and_add_spares() won't concurrent with submit_flushes().
>>>
>>> Fixes: a2826aa92e2e ("md: support barrier requests on all personalities.")
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>> Changes v2:
>>>   - Add WARN_ON in case md_flush_request() is not called from
>>>   md_handle_request() in future.
>>>
>>>   drivers/md/md.c | 22 ++++++++++++++++------
>>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 86efc9c2ae56..2ffedc39edd6 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -538,6 +538,9 @@ static void md_end_flush(struct bio *bio)
>>>          rdev_dec_pending(rdev, mddev);
>>>
>>>          if (atomic_dec_and_test(&mddev->flush_pending)) {
>>> +               /* The pair is percpu_ref_tryget() from md_flush_request() */
>>> +               percpu_ref_put(&mddev->active_io);
>>> +
>>>                  /* The pre-request flush has finished */
>>>                  queue_work(md_wq, &mddev->flush_work);
>>>          }
>>> @@ -557,12 +560,8 @@ static void submit_flushes(struct work_struct *ws)
>>>          rdev_for_each_rcu(rdev, mddev)
>>>                  if (rdev->raid_disk >= 0 &&
>>>                      !test_bit(Faulty, &rdev->flags)) {
>>> -                       /* Take two references, one is dropped
>>> -                        * when request finishes, one after
>>> -                        * we reclaim rcu_read_lock
>>> -                        */
>>>                          struct bio *bi;
>>> -                       atomic_inc(&rdev->nr_pending);
>>> +
>>>                          atomic_inc(&rdev->nr_pending);
>>>                          rcu_read_unlock();
>>>                          bi = bio_alloc_bioset(rdev->bdev, 0,
>>> @@ -573,7 +572,6 @@ static void submit_flushes(struct work_struct *ws)
>>>                          atomic_inc(&mddev->flush_pending);
>>>                          submit_bio(bi);
>>>                          rcu_read_lock();
>>> -                       rdev_dec_pending(rdev, mddev);
>>>                  }
>>>          rcu_read_unlock();
>>>          if (atomic_dec_and_test(&mddev->flush_pending))
>>> @@ -626,6 +624,18 @@ bool md_flush_request(struct mddev *mddev, struct bio *bio)
>>>          /* new request after previous flush is completed */
>>>          if (ktime_after(req_start, mddev->prev_flush_start)) {
>>>                  WARN_ON(mddev->flush_bio);
>>> +               /*
>>> +                * Grab a reference to make sure mddev_suspend() will wait for
>>> +                * this flush to be done.
>>> +                *
>>> +                * md_flush_reqeust() is called under md_handle_request() and
>>> +                * 'active_io' is already grabbed, hence percpu_ref_tryget()
>>> +                * won't fail, percpu_ref_tryget_live() can't be used because
>>> +                * percpu_ref_kill() can be called by mddev_suspend()
>>> +                * concurrently.
>>> +                */
>>> +               if (WARN_ON(percpu_ref_tryget(&mddev->active_io)))
>>
>> This should be "if (!WARN_ON(..))", right?

Sorry for the mistake, this actually should be:

if (WARN_ON(!percpu_ref_tryget(...))
>>
>> Song
>>
>>> +                       percpu_ref_get(&mddev->active_io);
> 
> Actually, we can just use percpu_ref_get(), no?

Yes, we can, but if someone else doesn't call md_flush_request() under
md_handle_request() in the fulture, there will be problem and
percpu_ref_get() can't catch this, do you think it'll make sense to
prevent such case?

Thanks,
Kuai

> 
> Thanks,
> Song
> .
> 

