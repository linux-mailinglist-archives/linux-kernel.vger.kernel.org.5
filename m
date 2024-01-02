Return-Path: <linux-kernel+bounces-14267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785A821A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AD51C21BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2ADDB6;
	Tue,  2 Jan 2024 10:50:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCFD515;
	Tue,  2 Jan 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T48kX0bQgz4f3jJ9;
	Tue,  2 Jan 2024 18:49:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 528FA1A0484;
	Tue,  2 Jan 2024 18:49:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnahBV6pNlBUVCFQ--.58730S3;
	Tue, 02 Jan 2024 18:49:59 +0800 (CST)
Subject: Re: [PATCH -next RFC] block: support to account io_ticks precisely
To: Yu Kuai <yukuai1@huaweicloud.com>, bvanassche@acm.org, hch@lst.de,
 ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e1475e94-2026-c154-8e4d-498aca4f7ed8@huaweicloud.com>
Date: Tue, 2 Jan 2024 18:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnahBV6pNlBUVCFQ--.58730S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJr47KF1xtw4kuF1ftFyUAwb_yoW8JrWDZo
	Z5JFs3Z3Z3t3yxWFW7Cwn7J3Zru3yDKa18AFWUur45X3Zrtw4UuFy7Ca4rW348GFyFkFn5
	JF9rGFyxtFs5t3s8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
	WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

friendly ping...

There used be lots of attempt to implement similiar feature, please let
me know if this feature is still interested from mainline. The
additional overhead can be ignored at least for HHD, and we had received
multiple complaint that disk util becomes worse after upgrading kernel.
We do provide additional tools like blktrace and bpftrace script to get
precise util, but for performance and userspace complexity, most of our
custormers prefer to keep using iostat of read /proc/diskstats.

Thanks,
Kuai

ÔÚ 2023/12/05 17:37, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, io_ticks is accounted based on sampling, specifically
> update_io_ticks() will always account io_ticks by 1 jiffies from
> bdev_start_io_acct()/blk_account_io_start(), and the result can be
> inaccurate, for example(HZ is 250):
> 
> Test script:
> fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms
> 
> Test result: util is about 90%, while the disk is really idle.
> 
> In order to account io_ticks precisely, update_io_ticks() must know if
> there are IO inflight already, and this requires overhead slightly,
> hence precise io accounting is disabled by default, and user can enable
> it through sysfs entry.
> 
> Noted that for rq-based devcie, part_stat_local_inc/dec() and
> part_in_flight() is used to track inflight instead of iterating tags,
> which is not supposed to be used in fast path because 'tags->lock' is
> grabbed in blk_mq_find_and_get_req().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   Documentation/ABI/stable/sysfs-block |  8 ++++--
>   block/blk-core.c                     | 17 ++++++++----
>   block/blk-mq.c                       | 18 ++++++++++---
>   block/blk-sysfs.c                    | 40 ++++++++++++++++++++++++++--
>   block/blk.h                          |  4 ++-
>   block/genhd.c                        |  6 ++---
>   include/linux/blk-mq.h               |  1 +
>   include/linux/blkdev.h               |  3 +++
>   8 files changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..e5fedecf7bdf 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -358,8 +358,12 @@ What:		/sys/block/<disk>/queue/iostats
>   Date:		January 2009
>   Contact:	linux-block@vger.kernel.org
>   Description:
> -		[RW] This file is used to control (on/off) the iostats
> -		accounting of the disk.
> +		[RW] This file is used to control the iostats accounting of the
> +		disk. If this value is 0, iostats accounting is disabled; If
> +		this value is 1, iostats accounting is enabled, but io_ticks is
> +		accounted by sampling and the result is not accurate; If this
> +		value is 2, iostats accounting is enabled and io_ticks is
> +		accounted precisely, but there will be slightly overhead.
>   
>   
>   What:		/sys/block/<disk>/queue/logical_block_size
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..405883d606cd 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -935,14 +935,20 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>   }
>   EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
>   
> -void update_io_ticks(struct block_device *part, unsigned long now, bool end)
> +void update_io_ticks(struct block_device *part, unsigned long now, bool end,
> +		     bool precise)
>   {
>   	unsigned long stamp;
>   again:
>   	stamp = READ_ONCE(part->bd_stamp);
> -	if (unlikely(time_after(now, stamp))) {
> -		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
> +	if (unlikely(time_after(now, stamp)) &&
> +	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
> +		if (precise) {
> +			if (end || part_in_flight(part))
> +				__part_stat_add(part, io_ticks, now - stamp);
> +		} else {
>   			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
> +		}
>   	}
>   	if (part->bd_partno) {
>   		part = bdev_whole(part);
> @@ -954,7 +960,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
>   				 unsigned long start_time)
>   {
>   	part_stat_lock();
> -	update_io_ticks(bdev, start_time, false);
> +	update_io_ticks(bdev, start_time, false,
> +			blk_queue_precise_io_stat(bdev->bd_queue));
>   	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
>   	part_stat_unlock();
>   
> @@ -982,7 +989,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
>   	unsigned long duration = now - start_time;
>   
>   	part_stat_lock();
> -	update_io_ticks(bdev, now, true);
> +	update_io_ticks(bdev, now, true, true);
>   	part_stat_inc(bdev, ios[sgrp]);
>   	part_stat_add(bdev, sectors[sgrp], sectors);
>   	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 900c1be1fee1..84fffbdc9dc1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -360,8 +360,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>   
>   	if (data->flags & BLK_MQ_REQ_PM)
>   		data->rq_flags |= RQF_PM;
> -	if (blk_queue_io_stat(q))
> +	if (blk_queue_io_stat(q)) {
>   		data->rq_flags |= RQF_IO_STAT;
> +		if (blk_queue_precise_io_stat(q))
> +			data->rq_flags |= RQF_PRECISE_IO_STAT;
> +	}
>   	rq->rq_flags = data->rq_flags;
>   
>   	if (data->rq_flags & RQF_SCHED_TAGS) {
> @@ -996,17 +999,21 @@ static inline void blk_account_io_done(struct request *req, u64 now)
>   		const int sgrp = op_stat_group(req_op(req));
>   
>   		part_stat_lock();
> -		update_io_ticks(req->part, jiffies, true);
> +		update_io_ticks(req->part, jiffies, true, true);
>   		part_stat_inc(req->part, ios[sgrp]);
>   		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
> +		if (req->rq_flags & RQF_PRECISE_IO_STAT)
> +			part_stat_local_dec(req->part,
> +					in_flight[op_is_write(req_op(req))]);
>   		part_stat_unlock();
>   	}
>   }
>   
>   static inline void blk_account_io_start(struct request *req)
>   {
> -	trace_block_io_start(req);
> +	bool precise = req->rq_flags & RQF_PRECISE_IO_STAT;
>   
> +	trace_block_io_start(req);
>   	if (blk_do_io_stat(req)) {
>   		/*
>   		 * All non-passthrough requests are created from a bio with one
> @@ -1020,7 +1027,10 @@ static inline void blk_account_io_start(struct request *req)
>   			req->part = req->q->disk->part0;
>   
>   		part_stat_lock();
> -		update_io_ticks(req->part, jiffies, false);
> +		update_io_ticks(req->part, jiffies, false, precise);
> +		if (precise)
> +			part_stat_local_inc(req->part,
> +					in_flight[op_is_write(req_op(req))]);
>   		part_stat_unlock();
>   	}
>   }
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 63e481262336..75ddbbd1edb4 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -303,7 +303,6 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
>   
>   QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
>   QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
> -QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
>   QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
>   #undef QUEUE_SYSFS_BIT_FNS
>   
> @@ -473,6 +472,43 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
>   	return queue_var_show(blk_queue_dax(q), page);
>   }
>   
> +static ssize_t queue_iostats_show(struct request_queue *q, char *page)
> +{
> +	int val = 0;
> +
> +	if (blk_queue_io_stat(q))
> +		val = blk_queue_precise_io_stat(q) ? 2 : 1;
> +
> +	return sprintf(page, "%u\n", val);
> +}
> +
> +static ssize_t
> +queue_iostats_store(struct request_queue *q, const char *page, size_t count)
> +{
> +	unsigned long nr;
> +	int ret, err;
> +
> +	ret = queue_var_store(&nr, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (nr > 2)
> +		return -EINVAL;
> +
> +	if (nr == 0) {
> +		blk_queue_flag_clear(QUEUE_FLAG_IO_STAT, q);
> +		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
> +	} else if (nr == 1) {
> +		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
> +		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
> +	} else {
> +		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
> +		blk_queue_flag_set(QUEUE_FLAG_PRECISE_IO_STAT, q);
> +	}
> +
> +	return count;
> +}
> +
>   #define QUEUE_RO_ENTRY(_prefix, _name)			\
>   static struct queue_sysfs_entry _prefix##_entry = {	\
>   	.attr	= { .name = _name, .mode = 0444 },	\
> @@ -494,6 +530,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
>   QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
>   QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
>   QUEUE_RW_ENTRY(elv_iosched, "scheduler");
> +QUEUE_RW_ENTRY(queue_iostats, "iostats");
>   
>   QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
>   QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
> @@ -539,7 +576,6 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
>   };
>   
>   QUEUE_RW_ENTRY(queue_nonrot, "rotational");
> -QUEUE_RW_ENTRY(queue_iostats, "iostats");
>   QUEUE_RW_ENTRY(queue_random, "add_random");
>   QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
>   
> diff --git a/block/blk.h b/block/blk.h
> index 08a358bc0919..d2321709a9ce 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -343,7 +343,9 @@ static inline bool blk_do_io_stat(struct request *rq)
>   	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
>   }
>   
> -void update_io_ticks(struct block_device *part, unsigned long now, bool end);
> +void update_io_ticks(struct block_device *part, unsigned long now, bool end,
> +		     bool precise);
> +unsigned int part_in_flight(struct block_device *part);
>   
>   static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>   {
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d06f72c587..aec651976c83 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -118,7 +118,7 @@ static void part_stat_read_all(struct block_device *part,
>   	}
>   }
>   
> -static unsigned int part_in_flight(struct block_device *part)
> +unsigned int part_in_flight(struct block_device *part)
>   {
>   	unsigned int inflight = 0;
>   	int cpu;
> @@ -962,7 +962,7 @@ ssize_t part_stat_show(struct device *dev,
>   
>   	if (inflight) {
>   		part_stat_lock();
> -		update_io_ticks(bdev, jiffies, true);
> +		update_io_ticks(bdev, jiffies, true, true);
>   		part_stat_unlock();
>   	}
>   	part_stat_read_all(bdev, &stat);
> @@ -1255,7 +1255,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>   
>   		if (inflight) {
>   			part_stat_lock();
> -			update_io_ticks(hd, jiffies, true);
> +			update_io_ticks(hd, jiffies, true, true);
>   			part_stat_unlock();
>   		}
>   		part_stat_read_all(hd, &stat);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1ab3081c82ed..e6c7adea1b4e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -44,6 +44,7 @@ typedef __u32 __bitwise req_flags_t;
>   #define RQF_QUIET		((__force req_flags_t)(1 << 11))
>   /* account into disk and partition IO statistics */
>   #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
> +#define RQF_PRECISE_IO_STAT	((__force req_flags_t)(1 << 14))
>   /* runtime pm request */
>   #define RQF_PM			((__force req_flags_t)(1 << 15))
>   /* on IO scheduler merge hash */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 51fa7ffdee83..fbc7ac419288 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -534,6 +534,7 @@ struct request_queue {
>   #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
>   #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
>   #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
> +#define QUEUE_FLAG_PRECISE_IO_STAT 8	/* do disk/partitions IO accounting precisely */
>   #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
>   #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
>   #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
> @@ -574,6 +575,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>   #define blk_queue_stable_writes(q) \
>   	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
>   #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
> +#define blk_queue_precise_io_stat(q) \
> +	test_bit(QUEUE_FLAG_PRECISE_IO_STAT, &(q)->queue_flags)
>   #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
>   #define blk_queue_zone_resetall(q)	\
>   	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
> 


