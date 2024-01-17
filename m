Return-Path: <linux-kernel+bounces-28735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD46830268
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FD1F21718
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041C1426D;
	Wed, 17 Jan 2024 09:35:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154F14A97;
	Wed, 17 Jan 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484116; cv=none; b=QmkU1bVJZnxQPRFWggcDRZ00SsXEJR8DzI/+t+6AOidVielj60mTrnLEt5tSpjS/ybok5sbIfpbg/NMo3orMpsVMxpMzOQeR1znmuIZeiWL7UbiXplnsA41C/GGbJWefpnpftYoIADJWtihO9DCVfsRoM93KkMV7tFclFiH7YlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484116; c=relaxed/simple;
	bh=MhLCYMADdYGVjaEBH/w4U5E+UR/EiGHvoQw/szfsRak=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=WUQwS+HoHMZb9pZ7ZvEi+0OLVB+NWVX8zAlLUmsscMrxLqchoBb5iFpaQPm6Kru8+4PZHNpl/xcsGvNNFll4xZKtgELzUrSVcX5M5GJur2wNF5Raus/dP2AqzJhtefl1H6tLL+FktAfpgt6fOD7gZdQyBTncw4AJi7UoSNAsggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFLM93x10z4f3k60;
	Wed, 17 Jan 2024 17:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A9F791A0E05;
	Wed, 17 Jan 2024 17:35:03 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBFFn6dlc8dmBA--.17489S3;
	Wed, 17 Jan 2024 17:35:03 +0800 (CST)
Subject: Re: [PATCH v4 2/2] md: don't account sync_io if iostats of the disk
 is disabled
To: linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240117031946.2324519-1-linan666@huaweicloud.com>
 <20240117031946.2324519-3-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6f9618f1-3656-ccb5-25de-13e98d8f46b9@huaweicloud.com>
Date: Wed, 17 Jan 2024 17:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240117031946.2324519-3-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBFFn6dlc8dmBA--.17489S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1xCFyDuw4fGrWUJFyDAwb_yoW8WFy8pa
	ykAa4fC34UZr45Ww1DX34UCas5Ww17KFW8ArW7A34fXFyaqr9xGF4SgFWqqF1kWFWrWFWa
	v3WjyFs09a10yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

ÔÚ 2024/01/17 11:19, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> If iostats is disabled, disk_stats will not be updated and
> part_stat_read_accum() only returns a constant value. In this case,
> continuing to count sync_io and to check is_mddev_idle() is no longer
> meaningful.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

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
> index a6829ea5b560..919d6affc0ac 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>   	rcu_read_lock();
>   	rdev_for_each_rcu(rdev, mddev) {
>   		struct gendisk *disk = rdev->bdev->bd_disk;
> +
> +		if (!init && !blk_queue_io_stat(disk->queue))
> +			continue;
> +
>   		curr_events =
>   			(long long)part_stat_read_accum(disk->part0, sectors) -
>   			atomic64_read(&disk->sync_io);
> 


