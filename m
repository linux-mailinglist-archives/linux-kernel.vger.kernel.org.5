Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C844E7FAFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjK1CHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjK1CHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:07:06 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79AC3;
        Mon, 27 Nov 2023 18:07:12 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SfQnR392mz4f3kFZ;
        Tue, 28 Nov 2023 10:07:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 523E21A085D;
        Tue, 28 Nov 2023 10:07:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgDHyhBMS2VlsMmJCA--.64884S3;
        Tue, 28 Nov 2023 10:07:09 +0800 (CST)
Subject: Re: [PATCH v2 1/6] md: fix missing flush of sync_work
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com>
 <20231124075953.1932764-2-yukuai1@huaweicloud.com>
 <CAPhsuW5mjvpMmEN5g_-ADQgJKZ1=QyNxxSw-7kq-W2jww09Aag@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e3b8298c-1154-c5ce-d025-b9346a6cd2ab@huaweicloud.com>
Date:   Tue, 28 Nov 2023 10:07:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5mjvpMmEN5g_-ADQgJKZ1=QyNxxSw-7kq-W2jww09Aag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHyhBMS2VlsMmJCA--.64884S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1kAFykWF1fur4UuFWDtwb_yoW8ZFy3p3
        ySq3W5ArW8AayUtw47KFyq9FyFgw10qrZrKrW3uw1rJFn8Jr15G3WruF1YvFy8Ar93Cwnx
        Za18ta9xu3W0vr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
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

在 2023/11/28 8:02, Song Liu 写道:
> On Fri, Nov 24, 2023 at 12:00 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit ac619781967b ("md: use separate work_struct for md_start_sync()")
>> use a new sync_work to replace del_work, however, stop_sync_thread() and
>> __md_stop_writes() was trying to wait for sync_thread to be done, hence
>> they should switch to use sync_work as well.
>>
>> Noted that md_start_sync() from sync_work will grab 'reconfig_mutex',
>> hence other contex can't held the same lock to flush work, and this will
>> be fixed in later patches.
>>
>> Fixes: ac619781967b ("md: use separate work_struct for md_start_sync()")
> 
> This fix should go via md-fixes branch. Please send it separately.

This patch alone is not good, there are follow up problems to be fixed
completely after patch 5. Can this patchset applied to md-fixes?

Or I can split patch 1,4 and 5 for md-fixes, and keep others to md-next.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 09686d8db983..1701e2fb219f 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4865,7 +4865,7 @@ static void stop_sync_thread(struct mddev *mddev)
>>                  return;
>>          }
>>
>> -       if (work_pending(&mddev->del_work))
>> +       if (work_pending(&mddev->sync_work))
>>                  flush_workqueue(md_misc_wq);
>>
>>          set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> @@ -6273,7 +6273,7 @@ static void md_clean(struct mddev *mddev)
>>   static void __md_stop_writes(struct mddev *mddev)
>>   {
>>          set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>> -       if (work_pending(&mddev->del_work))
>> +       if (work_pending(&mddev->sync_work))
>>                  flush_workqueue(md_misc_wq);
>>          if (mddev->sync_thread) {
>>                  set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>> --
>> 2.39.2
>>
> .
> 

