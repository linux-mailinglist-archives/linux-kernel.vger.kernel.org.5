Return-Path: <linux-kernel+bounces-15129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815B9822781
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4BD284B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100B1095B;
	Wed,  3 Jan 2024 03:16:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69F171CA;
	Wed,  3 Jan 2024 03:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4ZcT2BqHz4f3nTT;
	Wed,  3 Jan 2024 11:16:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EC08D1A017F;
	Wed,  3 Jan 2024 11:16:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgD3Rg1+0ZRl7G6DFQ--.7113S3;
	Wed, 03 Jan 2024 11:16:14 +0800 (CST)
Subject: Re: [PATCH v3 2/2] md: don't account sync_io if iostats of the disk
 is disabled
To: linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231223033703.2949831-1-linan666@huaweicloud.com>
 <20231223033703.2949831-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e2305cc4-dc3e-7693-9b61-33896c1b7a37@huaweicloud.com>
Date: Wed, 3 Jan 2024 11:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231223033703.2949831-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3Rg1+0ZRl7G6DFQ--.7113S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xCFyDtry8tryxJrW7XFb_yoW8Cr1xpa
	ykAF9ak34UXr45WasrZ34UCa4rWw17tFW0yrW7C34fXFy3tr9xGF4Sga90qF1vgFWrWFWa
	qw1jvFs09a10vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/



ÔÚ 2023/12/23 11:37, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> If iostats is disabled, disk_stats will not be updated and
> part_stat_read_accum() only returns a constant value. In this case,
> continuing to count sync_io and to check is_mddev_idle() is no longer
> meaningful.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.h | 3 ++-
>   drivers/md/md.c | 4 ++++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1a4f976951c1..e2d03a7a858c 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -584,7 +584,8 @@ extern void mddev_unlock(struct mddev *mddev);
>   
>   static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>   {
> -	atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
> +	if (blk_queue_io_stat(bdev->bd_disk->queue))
> +		atomic64_add(nr_sectors, &bdev->bd_disk->sync_io);
>   }
>   
>   static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a6829ea5b560..b56614eae8dc 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>   	rcu_read_lock();
>   	rdev_for_each_rcu(rdev, mddev) {
>   		struct gendisk *disk = rdev->bdev->bd_disk;
> +
> +		if (!blk_queue_io_stat(disk->queue))
> +			continue;

Consider that the queue flag can be set/cleared through sysfs, let's
keep set rdev->last_events in the case 'init'. To prevent a false
positive(althrough highly unlikely) if iostat is enabled during
md_do_sync().

Thanks,
Kuai

> +
>   		curr_events =
>   			(long long)part_stat_read_accum(disk->part0, sectors) -
>   			atomic64_read(&disk->sync_io);
> 


