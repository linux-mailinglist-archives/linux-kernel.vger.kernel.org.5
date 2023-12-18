Return-Path: <linux-kernel+bounces-2911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A9816422
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D7A1C22070
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2A2100;
	Mon, 18 Dec 2023 01:39:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE6D1FBF;
	Mon, 18 Dec 2023 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4StjD23JZWz4f3kFT;
	Mon, 18 Dec 2023 09:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 24AD91A0787;
	Mon, 18 Dec 2023 09:39:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCX5QvDon9lx6vIDw--.40516S3;
	Mon, 18 Dec 2023 09:39:16 +0800 (CST)
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-2-linan666@huaweicloud.com>
 <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
 <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com>
 <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <baf95bd0-0378-9b3a-9ab9-473baa35ebbc@huaweicloud.com>
Date: Mon, 18 Dec 2023 09:39:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCX5QvDon9lx6vIDw--.40516S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4DGrWxtFyDXw48JF1rtFb_yoW5CF18pF
	WUAF48Kr4DJr45uw1jq3y7A34rK3yUKrZ3GryYkry2qr1agFnIgF40gr4Y9Fn3Zw1xCrW0
	qa4j9FZxu34kAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/12/17 8:28, Song Liu 写道:
> On Fri, Dec 15, 2023 at 6:24 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
> [...]
>>>>    static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>>> index 3f8a21cd9233..d28b98adf457 100644
>>>> --- a/include/linux/blkdev.h
>>>> +++ b/include/linux/blkdev.h
>>>> @@ -170,7 +170,7 @@ struct gendisk {
>>>>           struct list_head slave_bdevs;
>>>>    #endif
>>>>           struct timer_rand_state *random;
>>>> -       atomic_t sync_io;               /* RAID */
>>>> +       atomic64_t sync_io;             /* RAID */
>>>>           struct disk_events *ev;
>>>
>>> As we are on this, I wonder whether we really need this.
>>> AFAICT, is_mddev_idle() is the only consumer of sync_io.
>>> We can probably do the same check in is_mddev_idle()
>>> without sync_io.
>>
>> After reviewing some code, what I'm understand is following:
>>
>> I think 'sync_io' is used to distinguish 'sync io' from raid(this can
>> from different raid, for example, different partition is used for
>> different array) and other io(any io, even it's not from raid). And
>> if there are any other IO, sync speed is limited to min, otherwise it's
>> limited to max.
>>
>> If we want to keep this behaviour, I can't think of any other way for
>> now...
> 
> Thanks for looking into this. To keep current behavior, we will need it
> in gendisk.
> 
> [...]
> 
>>>> @@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>>>>    {
>>>>           struct md_rdev *rdev;
>>>>           int idle;
>>>> -       int curr_events;
>>>> +       long long curr_events;
>>>>
>>>>           idle = 1;
>>>>           rcu_read_lock();
>>>>           rdev_for_each_rcu(rdev, mddev) {
>>>>                   struct gendisk *disk = rdev->bdev->bd_disk;
>>>> -               curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
>>>> -                             atomic_read(&disk->sync_io);
>>>> +               curr_events =
>>>> +                       (long long)part_stat_read_accum(disk->part0, sectors) -
>>>> +                             atomic64_read(&disk->sync_io);
>>
>> By the way, I don't think this overflow is problematic, assume that
>> sectors accumulate by 'A' and sync_io accumulate by 'B':
>>
>> (setros + A) - (sync_io + B) -(sectors - sync_io) = (A - B)
>>
>> Nomatter overflow or truncation happened of not in the abouve addition
>> and subtraction, the result is correct.
>>
>> And even if io accounting is disabled, which means sectors and A is
>> always 0, the result will always be -B that is <= 0, hence
>> is_mddev_idle() will always return true, and sync_speed will be limited
>> to max in this case.
> 
> We only use  this for idle or not check, the behavior is OK (I think).
> However, this logic is error prone.
> 
> On 64-bit systems, there is a 4-byte hole behind sync_io. I think we can
> just use it for atomic64_t so that we don't have to worry about overflow.

I'm not sure about this, because other than this ubsan warning, this
overflow doesn't have any impact on functionality to me.

If we care about this 'hole', there are lots of holes in gendisk, and
can be avoiled, for example, moving 'sync_io' near  to 'node_id'.

Thanks,
Kuai

> 
> Thanks,
> Song
> .
> 


