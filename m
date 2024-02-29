Return-Path: <linux-kernel+bounces-87095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2786CF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0411C22003
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B42D602;
	Thu, 29 Feb 2024 16:39:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A4160645;
	Thu, 29 Feb 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224789; cv=none; b=CH1emQcYnN/IqTCxB4VG6I5Oax7Gt1+biT9SuD2vkKc/QctvpL9QQRJlSdW1LkCG0SEeAbAA/T7SJD1Zmsrzq4ePDmQyt2poPkWsEDaHvdIcloaX0Lz58O2zLThVk7wRZC//+Y2mMMdDA5t2U0fUfKwV3yOqjnGpFJ4r1pi5MWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224789; c=relaxed/simple;
	bh=I2nNf4c0LRphhHr1U1aLklikvtNXhwBKV22E+huo1rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZiHic8kHIE7aQg7wbivIt7db+P3ubhbxDunnLScvzL9XlCeYXN/oY2KM9rJyZsVu3S2rwTKkdij9xl+vGXqWT58gvuwvDe+H3Iw8+YOC5UGNBeiyQ1wdKLTi0n0+ZDiNfbVrKbb2xMW/9yzMR2fA/UhQEMaUTJfwUeg+k58KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aeddf.dynamic.kabel-deutschland.de [95.90.237.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2EB1E61E5FE04;
	Thu, 29 Feb 2024 17:37:03 +0100 (CET)
Message-ID: <7b030433-518e-4fe7-976c-3ffb5f7f1a85@molgen.mpg.de>
Date: Thu, 29 Feb 2024 17:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH md-6.9 v4 03/11] md/raid1: record nonrot rdevs while
 adding/removing rdevs to conf
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, song@kernel.org,
 neilb@suse.com, shli@fb.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
 <20240229095714.926789-4-yukuai1@huaweicloud.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240229095714.926789-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Yu,


Thank you for your patch.


Am 29.02.24 um 10:57 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> For raid1, each read will iterate all the rdevs from conf and check if
> any rdev is non-rotational, then choose rdev with minimal IO inflight
> if so, or rdev with closest distance otherwise.
> 
> Disk nonrot info can be changed through sysfs entry:
> 
> /sys/block/[disk_name]/queue/rotational
> 
> However, consider that this should only be used for testing, and user
> really shouldn't do this in real life. Record the number of non-rotational
> disks in conf, to avoid checking each rdev in IO fast path and simplify

The comma is not needed.

> read_balance() a little bit.

Just to make sure, I understood correctly. Changing 
`/sys/block/[disk_name]/queue/rotational` will now not be considered 
anymore, right?

For the summary, maybe you could also say “cache”. Maybe:

Cache attribute rotational while adding/removing rdevs to conf

> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.h    |  1 +
>   drivers/md/raid1.c | 17 ++++++++++-------
>   drivers/md/raid1.h |  1 +
>   3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index a49ab04ab707..b2076a165c10 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -207,6 +207,7 @@ enum flag_bits {
>   				 * check if there is collision between raid1
>   				 * serial bios.
>   				 */
> +	Nonrot,			/* non-rotational device (SSD) */
>   };
>   
>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 6ec9998f6257..de6ea87d4d24 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   	int sectors;
>   	int best_good_sectors;
>   	int best_disk, best_dist_disk, best_pending_disk;
> -	int has_nonrot_disk;
>   	int disk;
>   	sector_t best_dist;
>   	unsigned int min_pending;
> @@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   	best_pending_disk = -1;
>   	min_pending = UINT_MAX;
>   	best_good_sectors = 0;
> -	has_nonrot_disk = 0;
>   	choose_next_idle = 0;
>   	clear_bit(R1BIO_FailFast, &r1_bio->state);
>   
> @@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   		sector_t first_bad;
>   		int bad_sectors;
>   		unsigned int pending;
> -		bool nonrot;
>   
>   		rdev = conf->mirrors[disk].rdev;
>   		if (r1_bio->bios[disk] == IO_BLOCKED
> @@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   			/* At least two disks to choose from so failfast is OK */
>   			set_bit(R1BIO_FailFast, &r1_bio->state);
>   
> -		nonrot = bdev_nonrot(rdev->bdev);
> -		has_nonrot_disk |= nonrot;
>   		pending = atomic_read(&rdev->nr_pending);
>   		dist = abs(this_sector - conf->mirrors[disk].head_position);
>   		if (choose_first) {
> @@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   			 * small, but not a big deal since when the second disk
>   			 * starts IO, the first disk is likely still busy.
>   			 */
> -			if (nonrot && opt_iosize > 0 &&
> +			if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
>   			    mirror->seq_start != MaxSector &&
>   			    mirror->next_seq_sect > opt_iosize &&
>   			    mirror->next_seq_sect - opt_iosize >=
> @@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>   	 * mixed ratation/non-rotational disks depending on workload.
>   	 */
>   	if (best_disk == -1) {
> -		if (has_nonrot_disk || min_pending == 0)
> +		if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
>   			best_disk = best_pending_disk;
>   		else
>   			best_disk = best_dist_disk;
> @@ -1768,6 +1763,11 @@ static bool raid1_add_conf(struct r1conf *conf, struct md_rdev *rdev, int disk,
>   	if (info->rdev)
>   		return false;
>   
> +	if (bdev_nonrot(rdev->bdev)) {
> +		set_bit(Nonrot, &rdev->flags);
> +		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
> +	}
> +
>   	rdev->raid_disk = disk;
>   	info->head_position = 0;
>   	info->seq_start = MaxSector;
> @@ -1791,6 +1791,9 @@ static bool raid1_remove_conf(struct r1conf *conf, int disk)
>   	    rdev->mddev->degraded < conf->raid_disks)
>   		return false;
>   
> +	if (test_and_clear_bit(Nonrot, &rdev->flags))
> +		WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
> +
>   	WRITE_ONCE(info->rdev, NULL);
>   	return true;
>   }
> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
> index 14d4211a123a..5300cbaa58a4 100644
> --- a/drivers/md/raid1.h
> +++ b/drivers/md/raid1.h
> @@ -71,6 +71,7 @@ struct r1conf {
>   						 * allow for replacements.
>   						 */
>   	int			raid_disks;
> +	int			nonrot_disks;
>   
>   	spinlock_t		device_lock;
>   

As you meant “fastpath” in the commit message, if I remember correctly, 
this does not improve the performance in benchmarks, right?


Kind regards,

Paul

