Return-Path: <linux-kernel+bounces-15199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1B822845
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21CC1F23A25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E418038;
	Wed,  3 Jan 2024 06:12:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187418021;
	Wed,  3 Jan 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T4fW53f6Fz4f3kFx;
	Wed,  3 Jan 2024 14:11:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C10BB1A01B3;
	Wed,  3 Jan 2024 14:11:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHyhCj+pRlKOyOFQ--.54578S3;
	Wed, 03 Jan 2024 14:11:48 +0800 (CST)
Subject: Re: [PATCH -next RFC] block: support to account io_ticks precisely
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, hch@lst.de, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
 <ZZTcYyveSE6Sl0Dl@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d98316fa-3022-c7ca-d985-da10265592b3@huaweicloud.com>
Date: Wed, 3 Jan 2024 14:11:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZTcYyveSE6Sl0Dl@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHyhCj+pRlKOyOFQ--.54578S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxCryDXr1xtr13Zw18Zrb_yoWrKFy3pF
	W8G3Z3KFWvqr1xuF12va1UtFyfXw4rAw45JrsxCFyYyF1DJr1fZr1IqryFkFn2vr92yayx
	uF109Fy7C3yj9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Ming!

ÔÚ 2024/01/03 12:02, Ming Lei Ð´µÀ:
> On Tue, Dec 05, 2023 at 05:37:43PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, io_ticks is accounted based on sampling, specifically
>> update_io_ticks() will always account io_ticks by 1 jiffies from
>> bdev_start_io_acct()/blk_account_io_start(), and the result can be
>> inaccurate, for example(HZ is 250):
>>
>> Test script:
>> fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms
>>
>> Test result: util is about 90%, while the disk is really idle.
>>
>> In order to account io_ticks precisely, update_io_ticks() must know if
>> there are IO inflight already, and this requires overhead slightly,
>> hence precise io accounting is disabled by default, and user can enable
>> it through sysfs entry.
> 
> Yeah, the trouble is from commit 5b18b5a73760 ("block: delete part_round_stats and
> switch to less precise counting"), and real reason is that IO inflight
> info is too expensive to maintain in fast path, and RH have got several customer
> complaint in this area too.
> 
>>
>> Noted that for rq-based devcie, part_stat_local_inc/dec() and
>> part_in_flight() is used to track inflight instead of iterating tags,
>> which is not supposed to be used in fast path because 'tags->lock' is
>> grabbed in blk_mq_find_and_get_req().
> 
> You can iterate over static requests via BT_TAG_ITER_STATIC_RQS, then
> tags->lock can be bypassed, but new helper is needed.
> 
> But given it is only run once for each tick, I guess percpu counting
> might be fine too even in case of big machine.
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   Documentation/ABI/stable/sysfs-block |  8 ++++--
>>   block/blk-core.c                     | 17 ++++++++----
>>   block/blk-mq.c                       | 18 ++++++++++---
>>   block/blk-sysfs.c                    | 40 ++++++++++++++++++++++++++--
>>   block/blk.h                          |  4 ++-
>>   block/genhd.c                        |  6 ++---
>>   include/linux/blk-mq.h               |  1 +
>>   include/linux/blkdev.h               |  3 +++
>>   8 files changed, 80 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 1fe9a553c37b..e5fedecf7bdf 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -358,8 +358,12 @@ What:		/sys/block/<disk>/queue/iostats
>>   Date:		January 2009
>>   Contact:	linux-block@vger.kernel.org
>>   Description:
>> -		[RW] This file is used to control (on/off) the iostats
>> -		accounting of the disk.
>> +		[RW] This file is used to control the iostats accounting of the
>> +		disk. If this value is 0, iostats accounting is disabled; If
>> +		this value is 1, iostats accounting is enabled, but io_ticks is
>> +		accounted by sampling and the result is not accurate; If this
>> +		value is 2, iostats accounting is enabled and io_ticks is
>> +		accounted precisely, but there will be slightly overhead.
> 
> IMO, this approach looks fine.
> 
>>   
>>   
>>   What:		/sys/block/<disk>/queue/logical_block_size
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fdf25b8d6e78..405883d606cd 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -935,14 +935,20 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>>   }
>>   EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>>   
>> -void update_io_ticks(struct block_device *part, unsigned long now, bool end)
>> +void update_io_ticks(struct block_device *part, unsigned long now, bool end,
>> +		     bool precise)
>>   {
>>   	unsigned long stamp;
>>   again:
>>   	stamp = READ_ONCE(part->bd_stamp);
>> -	if (unlikely(time_after(now, stamp))) {
>> -		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
>> +	if (unlikely(time_after(now, stamp)) &&
>> +	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
>> +		if (precise) {
>> +			if (end || part_in_flight(part))
>> +				__part_stat_add(part, io_ticks, now - stamp);
> 
> Strictly speaking, `end` isn't need any more, but it can be thought
> as one optimization, given part_in_flight() is supposed to be non-zero
> in case of account_done.
> 
>> +		} else {
>>   			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
>> +		}
>>   	}
>>   	if (part->bd_partno) {
>>   		part = bdev_whole(part);
>> @@ -954,7 +960,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>>   				 unsigned long start_time)
>>   {
>>   	part_stat_lock();
>> -	update_io_ticks(bdev, start_time, false);
>> +	update_io_ticks(bdev, start_time, false,
>> +			blk_queue_precise_io_stat(bdev->bd_queue));
> 
> blk_queue_precise_io_stat() can be moved into update_io_ticks()
> directly, and it should be fine given it is just done once in each
> tick.

Thanks for reviewing this patch! I'll update your suggestion in v2.

Kuai

> 
> Thanks,
> Ming
> 
> .
> 


