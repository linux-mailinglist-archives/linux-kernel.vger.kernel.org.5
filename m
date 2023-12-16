Return-Path: <linux-kernel+bounces-1959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F581565A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD61286BF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120F1C32;
	Sat, 16 Dec 2023 02:24:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5010A02;
	Sat, 16 Dec 2023 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SsVJz2r3Lz4f3jLt;
	Sat, 16 Dec 2023 10:24:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 04D501A08D2;
	Sat, 16 Dec 2023 10:24:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgC3BQxUCn1lhvkTDw--.2147S3;
	Sat, 16 Dec 2023 10:24:21 +0800 (CST)
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-2-linan666@huaweicloud.com>
 <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com>
Date: Sat, 16 Dec 2023 10:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3BQxUCn1lhvkTDw--.2147S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw45uryUKF18Kr4rKr15Jwb_yoWrZFy3pF
	W8AFySkrWUJr4j9w47Z3yDCa4rK34ftrZ3Gry2k34IqF1agrnIgFW8WF4YqFnrur1xCry2
	qa4jgFZ09a4vqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/12/16 7:12, Song Liu 写道:
> On Thu, Dec 14, 2023 at 5:41 PM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> UBSAN reports this problem:
>>
>>    UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
>>    signed integer overflow:
>>    -2147483291 - 2072033152 cannot be represented in type 'int'
>>    Call trace:
>>     dump_backtrace+0x0/0x310
>>     show_stack+0x28/0x38
>>     dump_stack+0xec/0x15c
>>     ubsan_epilogue+0x18/0x84
>>     handle_overflow+0x14c/0x19c
>>     __ubsan_handle_sub_overflow+0x34/0x44
>>     is_mddev_idle+0x338/0x3d8
>>     md_do_sync+0x1bb8/0x1cf8
>>     md_thread+0x220/0x288
>>     kthread+0x1d8/0x1e0
>>     ret_from_fork+0x10/0x18
>>
>> 'curr_events' will overflow when stat accum or 'sync_io' is greater than
>> INT_MAX.
>>
>> Fix it by changing sync_io, last_events and curr_events to 64bit.
>>
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/md/md.h        | 4 ++--
>>   include/linux/blkdev.h | 2 +-
>>   drivers/md/md.c        | 7 ++++---
>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index ade83af123a2..1a4f976951c1 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -50,7 +50,7 @@ struct md_rdev {
>>
>>          sector_t sectors;               /* Device size (in 512bytes sectors) */
>>          struct mddev *mddev;            /* RAID array if running */
>> -       int last_events;                /* IO event timestamp */
>> +       long long last_events;          /* IO event timestamp */
>>
>>          /*
>>           * If meta_bdev is non-NULL, it means that a separate device is
>> @@ -584,7 +584,7 @@ extern void mddev_unlock(struct mddev *mddev);
>>
>>   static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>>   {
>> -       atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
>> +       atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>>   }
>>
>>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 3f8a21cd9233..d28b98adf457 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -170,7 +170,7 @@ struct gendisk {
>>          struct list_head slave_bdevs;
>>   #endif
>>          struct timer_rand_state *random;
>> -       atomic_t sync_io;               /* RAID */
>> +       atomic64_t sync_io;             /* RAID */
>>          struct disk_events *ev;
> 
> As we are on this, I wonder whether we really need this.
> AFAICT, is_mddev_idle() is the only consumer of sync_io.
> We can probably do the same check in is_mddev_idle()
> without sync_io.

After reviewing some code, what I'm understand is following:

I think 'sync_io' is used to distinguish 'sync io' from raid(this can
from different raid, for example, different partition is used for
different array) and other io(any io, even it's not from raid). And
if there are any other IO, sync speed is limited to min, otherwise it's
limited to max.

If we want to keep this behaviour, I can't think of any other way for
now...

> 
> Thanks,
> Song
> 
> 
>>
>>   #ifdef CONFIG_BLK_DEV_ZONED
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index c94373d64f2c..1d71b2a9af03 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>>   {
>>          struct md_rdev *rdev;
>>          int idle;
>> -       int curr_events;
>> +       long long curr_events;
>>
>>          idle = 1;
>>          rcu_read_lock();
>>          rdev_for_each_rcu(rdev, mddev) {
>>                  struct gendisk *disk = rdev->bdev->bd_disk;
>> -               curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
>> -                             atomic_read(&disk->sync_io);
>> +               curr_events =
>> +                       (long long)part_stat_read_accum(disk->part0, sectors) -
>> +                             atomic64_read(&disk->sync_io);

By the way, I don't think this overflow is problematic, assume that
sectors accumulate by 'A' and sync_io accumulate by 'B':

(setros + A) - (sync_io + B) -(sectors - sync_io) = (A - B)

Nomatter overflow or truncation happened of not in the abouve addition
and subtraction, the result is correct.

And even if io accounting is disabled, which means sectors and A is
always 0, the result will always be -B that is <= 0, hence
is_mddev_idle() will always return true, and sync_speed will be limited
to max in this case.

Thanks,
Kuai

>>                  /* sync IO will cause sync_io to increase before the disk_stats
>>                   * as sync_io is counted when a request starts, and
>>                   * disk_stats is counted when it completes.
>> --
>> 2.39.2
>>
>>
> .
> 


