Return-Path: <linux-kernel+bounces-17718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A702825197
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B040B21F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70412C859;
	Fri,  5 Jan 2024 10:13:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D82C69D;
	Fri,  5 Jan 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T5zmt5sT4z4f3jpr;
	Fri,  5 Jan 2024 18:13:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9DEFE1A0AD2;
	Fri,  5 Jan 2024 18:13:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDXJg0_1pdliqpcFg--.48265S3;
	Fri, 05 Jan 2024 18:13:20 +0800 (CST)
Subject: Re: [PATCH for-6.8/block RFC v2] block: support to account io_ticks
 precisely
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240103071515.2477311-1-yukuai1@huaweicloud.com>
 <ZZduPrwMrwOLQiU7@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0a7aa14b-2ceb-2551-3600-cac7f9370360@huaweicloud.com>
Date: Fri, 5 Jan 2024 18:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZZduPrwMrwOLQiU7@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXJg0_1pdliqpcFg--.48265S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDJry7GF4kur1UuF1Dtrb_yoW8uFWkpF
	Wjk3WDKw1kXr18CF4DA3WxGas2grZ5Cw45Zr4fGry7Zr1jqrWfAr4xtrWF9F92vFs7Aw1I
	93W8uF4DAw1UZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Ming!

ÔÚ 2024/01/05 10:49, Ming Lei Ð´µÀ:
> On Wed, Jan 03, 2024 at 03:15:15PM +0800, Yu Kuai wrote:
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
>>
>> Noted that for rq-based devcie, part_stat_local_inc/dec() and
>> part_in_flight() is used to track inflight instead of iterating tags,
>> which is not supposed to be used in fast path because 'tags->lock' is
>> grabbed in blk_mq_find_and_get_req().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> Changes in v2:
>>   - remove the new parameter for update_io_ticks();
>>   - simplify update_io_ticks();
>>   - use swith in queue_iostats_store();
>>   - add missing part_stat_local_dec() in blk_account_io_merge_request()
> 
> Looks fine,
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review, however, I made a mistake while "simplify
update_io_ticks()" that first IO will still account by 1 jiffies even if
precise iostat is enabled:

+       if (unlikely(time_after(now, stamp)) &&
+           likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
+               if (end || (blk_queue_precise_io_stat(part->bd_queue) &&
+                           part_in_flight(part)))
+                       __part_stat_add(part, io_ticks, now - stamp);
+               else
-> here, should be else if (!blk_queue_precise_io_stat(part->bd_queue))
+                       __part_stat_add(part, io_ticks, 1);

Alough this is RFC, my apologize for sending this version without fully
test the functionally. I'll send a formal version soon.

Thanks,
Kuai

> 
> 
> thanks,
> Ming
> 
> .
> 


