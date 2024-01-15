Return-Path: <linux-kernel+bounces-25941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048AA82D89B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE751F2265A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4AD2C6A4;
	Mon, 15 Jan 2024 11:54:53 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36028E3E;
	Mon, 15 Jan 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TD9Y54qVhz4f3kpH;
	Mon, 15 Jan 2024 19:54:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5984C1A0948;
	Mon, 15 Jan 2024 19:54:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBH7HKVlbDqkAw--.1828S3;
	Mon, 15 Jan 2024 19:54:37 +0800 (CST)
Subject: Re: [PATCH for-6.8/block] block: support to account io_ticks
 precisely
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240109071332.2216253-1-yukuai1@huaweicloud.com>
 <ZaUZH8v2i7YBklyc@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bdbbaff8-bdb6-0416-b4f4-bbebb64fb1fc@huaweicloud.com>
Date: Mon, 15 Jan 2024 19:54:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZaUZH8v2i7YBklyc@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBH7HKVlbDqkAw--.1828S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxCryDXr1xtFWrZrWxtFb_yoWrZrW8pr
	y8G3ZxKFnaqFy7uFsFva17tF1xX395Cr45JrsxGryayr1DWr1fZrs2qrWF9FZ2vrZ2ya18
	Zr18uFyUCw4j9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/01/15 19:38, Ming Lei Ð´µÀ:
> On Tue, Jan 09, 2024 at 03:13:32PM +0800, Yu Kuai wrote:
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
> 
> Just be curious, what is result with this patch? 0%?

No, it's not 0%, this actually depends on how many IO really start from
one jiffies and complete at the next jiffies. Given that the probability
is related to IO latency, so the result should be relatively
accurate(Around 10% in my environment). I think we can live with that
unless we improve time precision from jiffies to ns.
> 
>>
>> In order to account io_ticks precisely, update_io_ticks() must know if
>> there are IO inflight already, and this requires overhead slightly,
>> hence precise io accounting is disabled by default, and user can enable
>> it through sysfs entry.
>>
>> Noted that for rq-based devcie, part_stat_local_inc/dec() and
>> part_in_flight() is used to track inflight instead of iterating tags,
>> which is not supposed to be used in fast path because 'tags->lock' is
>> grabbed in blk_mq_find_and_get_req().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> Changes from RFC v1:
>>   - remove the new parameter for update_io_ticks();
>>   - simplify update_io_ticks();
>>   - use swith in queue_iostats_store();
>>   - add missing part_stat_local_dec() in blk_account_io_merge_request();
>> Changes from RFC v2:
>>   - fix that precise is ignored for the first io in update_io_ticks();
>>
>>   Documentation/ABI/stable/sysfs-block |  8 ++++--
>>   block/blk-core.c                     | 10 +++++--
>>   block/blk-merge.c                    |  3 ++
>>   block/blk-mq-debugfs.c               |  2 ++
>>   block/blk-mq.c                       | 11 +++++++-
>>   block/blk-sysfs.c                    | 42 ++++++++++++++++++++++++++--
>>   block/blk.h                          |  1 +
>>   block/genhd.c                        |  2 +-
>>   include/linux/blk-mq.h               |  1 +
>>   include/linux/blkdev.h               |  3 ++
>>   10 files changed, 74 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 1fe9a553c37b..79027bf2661a 100644
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
>> +		accounted precisely, but there will be slightly more overhead.
>>   
>>   
>>   What:		/sys/block/<disk>/queue/logical_block_size
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 9520ccab3050..c70dc311e3b7 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -954,11 +954,15 @@ EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>>   void update_io_ticks(struct block_device *part, unsigned long now, bool end)
>>   {
>>   	unsigned long stamp;
>> +	bool precise = blk_queue_precise_io_stat(part->bd_queue);
>>   again:
>>   	stamp = READ_ONCE(part->bd_stamp);
>> -	if (unlikely(time_after(now, stamp))) {
>> -		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
>> -			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
>> +	if (unlikely(time_after(now, stamp)) &&
>> +	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
>> +		if (end || (precise && part_in_flight(part)))
>> +			__part_stat_add(part, io_ticks, now - stamp);
>> +		else if (!precise)
>> +			__part_stat_add(part, io_ticks, 1);
> 
> It should be better or readable to move 'bool precise' into the above branch,
> given we only need to read the flag once in each tick.
> 
> Otherwise, this patch looks fine.

Thanks for your advice, will change that in next version.

Kuai
> 
> Thanks,
> Ming
> 
> .
> 


