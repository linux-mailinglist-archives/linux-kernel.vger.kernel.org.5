Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962FB784ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHWCpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHWCpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:45:19 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6A1A5;
        Tue, 22 Aug 2023 19:45:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RVrD820xsz4f3nJn;
        Wed, 23 Aug 2023 10:45:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6m3cuVkik51BQ--.25591S3;
        Wed, 23 Aug 2023 10:45:13 +0800 (CST)
Subject: Re: [PATCH -next v3 4/7] md: factor out a helper rdev_removeable()
 from remove_and_add_spares()
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-5-yukuai1@huaweicloud.com>
 <CALTww2-mH7SW3Dz0DOd+NyBpZAZzB8r50UCBOkMipNtV4VxWTw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <941be671-0d33-ef3a-8e81-d89af66b38a4@huaweicloud.com>
Date:   Wed, 23 Aug 2023 10:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2-mH7SW3Dz0DOd+NyBpZAZzB8r50UCBOkMipNtV4VxWTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6m3cuVkik51BQ--.25591S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xKFW5GF1xKr1DtFW3trb_yoW5Kr1kpF
        WxKFy3Cr4DZr12gw48trn8JFyrXa18t3yxCFyfCa4Iv3sFkr98W34rGFy5ur98AFZ3ua10
        vF1UJws5CryvkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/08/22 18:19, Xiao Ni 写道:
> On Sun, Aug 20, 2023 at 5:13 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are no functional changes, just to make the code simpler and
>> prepare to delay remove_and_add_spares() to md_start_sync().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 33 +++++++++++++++++++--------------
>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 561cac13ff96..ceace5ffadd6 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -9153,6 +9153,22 @@ void md_do_sync(struct md_thread *thread)
>>   }
>>   EXPORT_SYMBOL_GPL(md_do_sync);
>>
>> +static bool rdev_removeable(struct md_rdev *rdev)
>> +{
>> +       if (rdev->raid_disk < 0 || test_bit(Blocked, &rdev->flags) ||
>> +           atomic_read(&rdev->nr_pending))
>> +               return false;
>> +
>> +       if (test_bit(RemoveSynchronized, &rdev->flags))
>> +               return true;
>> +
>> +       if (test_bit(In_sync, &rdev->flags) ||
>> +           test_bit(Journal, &rdev->flags))
>> +               return false;
>> +
>> +       return true;
>> +}
>> +
>>   static int remove_and_add_spares(struct mddev *mddev,
>>                                   struct md_rdev *this)
>>   {
>> @@ -9166,11 +9182,7 @@ static int remove_and_add_spares(struct mddev *mddev,
>>                  return 0;
>>
>>          rdev_for_each(rdev, mddev) {
>> -               if ((this == NULL || rdev == this) &&
>> -                   rdev->raid_disk >= 0 &&
>> -                   !test_bit(Blocked, &rdev->flags) &&
>> -                   test_bit(Faulty, &rdev->flags) &&
>> -                   atomic_read(&rdev->nr_pending)==0) {
>> +               if ((this == NULL || rdev == this) && rdev_removeable(rdev)) {
> 
> There is a small change with the original method. Before this patch,
> it checks the Faulty flag when setting RemoveSynchronized and it
> checks RemoveSynchronized and "!In_sync && !Journal". I'm not sure if
> it's right or not.

Yes, there is a small change. After a second thought, I think it's OK
to leave the code to set RemoveSynchronized where it is for now, because
it'll be removed later. I don't need to bother factor out a common code
to set RemoveSynchronized and call hot_remove_disk().

By the way, once refactor of mddev_suspend() is done, then access to
rdev from fastpath will be replaced from:

rcu_read_lock()
...
rcu_read_unlock()

to:

md_array_enter()
// grab 'active_io', 'active_io' will probably be renamed
...
md_array_exit()

That's why I said RemoveSynchronized will be removed.

Thanks,
Kuai

> 
>>                          /* Faulty non-Blocked devices with nr_pending == 0
>>                           * never get nr_pending incremented,
>>                           * never get Faulty cleared, and never get Blocked set.
>> @@ -9185,19 +9197,12 @@ static int remove_and_add_spares(struct mddev *mddev,
>>                  synchronize_rcu();
>>          rdev_for_each(rdev, mddev) {
>>                  if ((this == NULL || rdev == this) &&
>> -                   rdev->raid_disk >= 0 &&
>> -                   !test_bit(Blocked, &rdev->flags) &&
>> -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
>> -                    (!test_bit(In_sync, &rdev->flags) &&
>> -                     !test_bit(Journal, &rdev->flags))) &&
>> -                   atomic_read(&rdev->nr_pending)==0)) {
>> -                       if (mddev->pers->hot_remove_disk(
>> -                                   mddev, rdev) == 0) {
>> +                   rdev_removeable(rdev) &&
>> +                   mddev->pers->hot_remove_disk(mddev, rdev) == 0) {
>>                                  sysfs_unlink_rdev(mddev, rdev);
>>                                  rdev->saved_raid_disk = rdev->raid_disk;
>>                                  rdev->raid_disk = -1;
>>                                  removed++;
>> -                       }
>>                  }
>>                  if (remove_some && test_bit(RemoveSynchronized, &rdev->flags))
>>                          clear_bit(RemoveSynchronized, &rdev->flags);
>> --
>> 2.39.2
>>
> 
> .
> 

