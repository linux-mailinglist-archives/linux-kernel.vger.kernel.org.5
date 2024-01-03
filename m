Return-Path: <linux-kernel+bounces-15113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EE82275F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBBE1F22457
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46067171B4;
	Wed,  3 Jan 2024 03:08:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F801168DC;
	Wed,  3 Jan 2024 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4ZRn3dTCz4f3jqG;
	Wed,  3 Jan 2024 11:08:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3EE8D1A017D;
	Wed,  3 Jan 2024 11:08:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xG1z5Rlt+6CFQ--.782S3;
	Wed, 03 Jan 2024 11:08:39 +0800 (CST)
Subject: Re: [PATCH v3 1/2] md: Fix overflow in is_mddev_idle
To: linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231223033703.2949831-1-linan666@huaweicloud.com>
 <20231223033703.2949831-2-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a26a72f-3f47-69a1-1322-d0d360f23445@huaweicloud.com>
Date: Wed, 3 Jan 2024 11:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231223033703.2949831-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2xG1z5Rlt+6CFQ--.782S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4fuFy7ZF4kCF4DXF48Crg_yoW5Cw48pF
	WkJFyakrWUJr4Uua1UZ3yDCa4Fg34ft3ySkrW2k34fXF1fKas3KF48GFyYqF1DurW8uFW2
	qa4UKFs0vay0qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2023/12/23 11:37, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> UBSAN reports this problem:
> 
>    UBSAN: Undefined behaviour in drivers/md/md.c:8175:15
>    signed integer overflow:
>    -2147483291 - 2072033152 cannot be represented in type 'int'
>    Call trace:
>     dump_backtrace+0x0/0x310
>     show_stack+0x28/0x38
>     dump_stack+0xec/0x15c
>     ubsan_epilogue+0x18/0x84
>     handle_overflow+0x14c/0x19c
>     __ubsan_handle_sub_overflow+0x34/0x44
>     is_mddev_idle+0x338/0x3d8
>     md_do_sync+0x1bb8/0x1cf8
>     md_thread+0x220/0x288
>     kthread+0x1d8/0x1e0
>     ret_from_fork+0x10/0x18
> 
> 'curr_events' will overflow when stat accum or 'sync_io' is greater than
> INT_MAX.
> 
> Fix it by changing sync_io, last_events and curr_events to 64bit.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.h        | 4 ++--
>   include/linux/blkdev.h | 2 +-
>   drivers/md/md.c        | 7 ++++---
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index ade83af123a2..1a4f976951c1 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -50,7 +50,7 @@ struct md_rdev {
>   
>   	sector_t sectors;		/* Device size (in 512bytes sectors) */
>   	struct mddev *mddev;		/* RAID array if running */
> -	int last_events;		/* IO event timestamp */
> +	long long last_events;		/* IO event timestamp */
>   
>   	/*
>   	 * If meta_bdev is non-NULL, it means that a separate device is
> @@ -584,7 +584,7 @@ extern void mddev_unlock(struct mddev *mddev);
>   
>   static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>   {
> -	atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
> +	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>   }
>   
>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 3f8a21cd9233..d28b98adf457 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -170,7 +170,7 @@ struct gendisk {
>   	struct list_head slave_bdevs;
>   #endif
>   	struct timer_rand_state *random;
> -	atomic_t sync_io;		/* RAID */
> +	atomic64_t sync_io;		/* RAID */
>   	struct disk_events *ev;
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c94373d64f2c..a6829ea5b560 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8496,14 +8496,15 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>   {
>   	struct md_rdev *rdev;
>   	int idle;
> -	int curr_events;
> +	long long curr_events;
>   
>   	idle = 1;
>   	rcu_read_lock();
>   	rdev_for_each_rcu(rdev, mddev) {
>   		struct gendisk *disk = rdev->bdev->bd_disk;
> -		curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -			      atomic_read(&disk->sync_io);
> +		curr_events =
> +			(long long)part_stat_read_accum(disk->part0, sectors) -
> +			atomic64_read(&disk->sync_io);
>   		/* sync IO will cause sync_io to increase before the disk_stats
>   		 * as sync_io is counted when a request starts, and
>   		 * disk_stats is counted when it completes.
> 


