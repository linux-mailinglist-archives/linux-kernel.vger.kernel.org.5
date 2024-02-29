Return-Path: <linux-kernel+bounces-86032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF986BEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380F3288636
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC536AFF;
	Thu, 29 Feb 2024 02:12:04 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606E3612A;
	Thu, 29 Feb 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172724; cv=none; b=MGgbFs3yQ938iiHE5nOH8dW5h0PlxPGEucJJunwUzhRFAOWNy3239fewOp1HGmuMGYVPRXAcfCSo/LS1gUPVdbHfi+L7JV5AeaiPXjNNpIdi8qs91yGHGiG/GSLZ2tUli+V0ShZ877clJCuoAiy43ZV4+cuJlyJ3GxKxJDtIOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172724; c=relaxed/simple;
	bh=c/XAnTtBwVpnsyh2GdtFIBSBtM8gvqpbZyl3mE9I2Lg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V3INmWxrVACUYzrbqTLqETA26xBDbYu80ISzmu2yQFKaPbClrrQDrYvdZSFIa32EaRQ0HA4A/AAmjegvLd2Lh5IbwYMuH+6+PkAUUO0iY6O1K/sOCc0+epTdyCkKhloyYxrqi3doblvuHHpmFEy5Z/gPIIxANXI6N0FYqONq2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TlZV02DpMz4f3khK;
	Thu, 29 Feb 2024 10:11:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8BA5C1A0232;
	Thu, 29 Feb 2024 10:11:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7r599ljdDlFQ--.51385S3;
	Thu, 29 Feb 2024 10:11:57 +0800 (CST)
Subject: Re: [PATCH md-6.9 v3 02/11] md/raid1: factor out helpers to add rdev
 to conf
To: Yu Kuai <yukuai1@huaweicloud.com>, xni@redhat.com,
 paul.e.luse@linux.intel.com, song@kernel.org, shli@fb.com, neilb@suse.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
 <20240228114333.527222-3-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ca4adb05-2e99-2f83-3032-e7a2e03e94f3@huaweicloud.com>
Date: Thu, 29 Feb 2024 10:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240228114333.527222-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g7r599ljdDlFQ--.51385S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWUtw4DtrWDtr4UKr4xtFb_yoWxCF1kpa
	y3XasxGr47Xrn0gr1DJrWDCFyFvws7Can7JFyfW3yIvanIgrZ5X3y8GFy5XFyUArZ8Zw45
	Ja4rJrWDGF109FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/02/28 19:43, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are no functional changes, just make code cleaner and prepare to
> record disk non-rotational information while adding and removing rdev to
> conf
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid1.c | 74 ++++++++++++++++++++++++++++------------------
>   1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a145fe48b9ce..1940ff398c23 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1757,6 +1757,40 @@ static int raid1_spare_active(struct mddev *mddev)
>   	return count;
>   }
>   
> +static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk)
> +{
> +	struct raid1_info *info = conf->mirrors + disk;
> +
> +	if (info->rdev)
> +		return false;
> +
> +	rdev->raid_disk = disk;
> +	info->head_position = 0;
> +	info->seq_start = MaxSector;
> +	WRITE_ONCE(info->rdev, rdev);
> +
> +	return true;
> +}

I misread the code, for replacement, rdev->raid_disk is the same as the
original rdev, while this patch set it to "raid_disk + conf->raid_disks"
and following should be merged with this patch:

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1940ff398c23..ff1e1aeaf336 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1757,10 +1757,14 @@ static int raid1_spare_active(struct mddev *mddev)
         return count;
  }

-static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, 
int disk)
+static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, 
int disk,
+                          bool replacement)
  {
         struct raid1_info *info = conf->mirrors + disk;

+       if (replacement)
+               info += conf->raid_disks;
+
         if (info->rdev)
                 return false;

@@ -1826,7 +1830,7 @@ static int raid1_add_disk(struct mddev *mddev, 
struct md_rdev *rdev)
                                 disk_stack_limits(mddev->gendisk, 
rdev->bdev,
                                                   rdev->data_offset << 9);

-                       raid1_add_conf(conf, rdev, mirror);
+                       raid1_add_conf(conf, rdev, mirror, false);
                         err = 0;
                         /* As all devices are equivalent, we don't need 
a full recovery
                          * if this was recently any drive of the array
@@ -1844,7 +1848,7 @@ static int raid1_add_disk(struct mddev *mddev, 
struct md_rdev *rdev)
                 /* Add this device as a replacement */
                 clear_bit(In_sync, &rdev->flags);
                 set_bit(Replacement, &rdev->flags);
-               raid1_add_conf(conf, rdev, repl_slot);
+               raid1_add_conf(conf, rdev, repl_slot, true);
                 err = 0;
                 conf->fullsync = 1;
         }
@@ -3017,18 +3021,16 @@ static struct r1conf *setup_conf(struct mddev 
*mddev)

         err = -EINVAL;
         spin_lock_init(&conf->device_lock);
+       conf->raid_disks = mddev->raid_disks;
         rdev_for_each(rdev, mddev) {
                 int disk_idx = rdev->raid_disk;
-               if (disk_idx >= mddev->raid_disks
+               if (disk_idx >= conf->raid_disks
                     || disk_idx < 0)
                         continue;
-               if (test_bit(Replacement, &rdev->flags))
-                       disk_idx += mddev->raid_disks;
-
-               if (!raid1_add_conf(conf, rdev, disk_idx))
+               if (!raid1_add_conf(conf, rdev, disk_idx,
+                                   test_bit(Replacement, &rdev->flags)))
                         goto abort;
         }
-       conf->raid_disks = mddev->raid_disks;
         conf->mddev = mddev;
         INIT_LIST_HEAD(&conf->retry_list);
         INIT_LIST_HEAD(&conf->bio_end_io_list);


I'll finish mdadm tests suite before v4.

Thanks,
Kuai
> +
> +static bool raid1_remove_conf(struct r1conf *conf, int disk)
> +{
> +	struct raid1_info *info = conf->mirrors + disk;
> +	struct md_rdev *rdev = info->rdev;
> +
> +	if (!rdev || test_bit(In_sync, &rdev->flags) ||
> +	    atomic_read(&rdev->nr_pending))
> +		return false;
> +
> +	/* Only remove non-faulty devices if recovery is not possible. */
> +	if (!test_bit(Faulty, &rdev->flags) &&
> +	    rdev->mddev->recovery_disabled != conf->recovery_disabled &&
> +	    rdev->mddev->degraded < conf->raid_disks)
> +		return false;
> +
> +	WRITE_ONCE(info->rdev, NULL);
> +	return true;
> +}
> +
>   static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   {
>   	struct r1conf *conf = mddev->private;
> @@ -1792,15 +1826,13 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   				disk_stack_limits(mddev->gendisk, rdev->bdev,
>   						  rdev->data_offset << 9);
>   
> -			p->head_position = 0;
> -			rdev->raid_disk = mirror;
> +			raid1_add_conf(conf, rdev, mirror);
>   			err = 0;
>   			/* As all devices are equivalent, we don't need a full recovery
>   			 * if this was recently any drive of the array
>   			 */
>   			if (rdev->saved_raid_disk < 0)
>   				conf->fullsync = 1;
> -			WRITE_ONCE(p->rdev, rdev);
>   			break;
>   		}
>   		if (test_bit(WantReplacement, &p->rdev->flags) &&
> @@ -1810,13 +1842,11 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   
>   	if (err && repl_slot >= 0) {
>   		/* Add this device as a replacement */
> -		p = conf->mirrors + repl_slot;
>   		clear_bit(In_sync, &rdev->flags);
>   		set_bit(Replacement, &rdev->flags);
> -		rdev->raid_disk = repl_slot;
> +		raid1_add_conf(conf, rdev, repl_slot);
>   		err = 0;
>   		conf->fullsync = 1;
> -		WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
>   	}
>   
>   	print_conf(conf);
> @@ -1833,27 +1863,20 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	if (unlikely(number >= conf->raid_disks))
>   		goto abort;
>   
> -	if (rdev != p->rdev)
> -		p = conf->mirrors + conf->raid_disks + number;
> +	if (rdev != p->rdev) {
> +		number += conf->raid_disks;
> +		p = conf->mirrors + number;
> +	}
>   
>   	print_conf(conf);
>   	if (rdev == p->rdev) {
> -		if (test_bit(In_sync, &rdev->flags) ||
> -		    atomic_read(&rdev->nr_pending)) {
> -			err = -EBUSY;
> -			goto abort;
> -		}
> -		/* Only remove non-faulty devices if recovery
> -		 * is not possible.
> -		 */
> -		if (!test_bit(Faulty, &rdev->flags) &&
> -		    mddev->recovery_disabled != conf->recovery_disabled &&
> -		    mddev->degraded < conf->raid_disks) {
> +		if (!raid1_remove_conf(conf, number)) {
>   			err = -EBUSY;
>   			goto abort;
>   		}
> -		WRITE_ONCE(p->rdev, NULL);
> -		if (conf->mirrors[conf->raid_disks + number].rdev) {
> +
> +		if (number < conf->raid_disks &&
> +		    conf->mirrors[conf->raid_disks + number].rdev) {
>   			/* We just removed a device that is being replaced.
>   			 * Move down the replacement.  We drain all IO before
>   			 * doing this to avoid confusion.
> @@ -3000,15 +3023,10 @@ static struct r1conf *setup_conf(struct mddev *mddev)
>   		    || disk_idx < 0)
>   			continue;
>   		if (test_bit(Replacement, &rdev->flags))
> -			disk = conf->mirrors + mddev->raid_disks + disk_idx;
> -		else
> -			disk = conf->mirrors + disk_idx;
> +			disk_idx += mddev->raid_disks;
>   
> -		if (disk->rdev)
> +		if (!raid1_add_conf(conf, rdev, disk_idx))
>   			goto abort;
> -		disk->rdev = rdev;
> -		disk->head_position = 0;
> -		disk->seq_start = MaxSector;
>   	}
>   	conf->raid_disks = mddev->raid_disks;
>   	conf->mddev = mddev;
> 


