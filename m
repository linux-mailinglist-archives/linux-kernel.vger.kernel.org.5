Return-Path: <linux-kernel+bounces-87809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004BA86D94E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DE31F236A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950838F9B;
	Fri,  1 Mar 2024 02:00:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3DFC03;
	Fri,  1 Mar 2024 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258400; cv=none; b=eG4pByBRPcPG+euP0SnPEagOVGXVNvxubMiwZmWv3+rk56DG+TEbnO7ap5dVIT5/v/tHX1NnMzwrtw0/b3kzMD5XqxnoBAN9aDIPCNUEyqGsX0YqCY5r6dvJNyoQKunA8Z+r89CTuBnDxXVGC43uiSiAkpvd6x+aEip1jrFuzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258400; c=relaxed/simple;
	bh=qAHgni4UkLPw0apvildN88ZpJCb3iXFGkD1LHTOz3QE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uKdUjslYYaKOpT3FirqowDrj3t+ViP3dwD9f5qjX2ASGO67UlPnofhhSKMjiZSd2c7+hKDj5PJSC6CT+5NibpcP2fZwor2hi7jCN4nOUZPdUHcQWStFyw5Nk+Uw0rtwUflRtzKj+6ezcTHJ6UKIh5jUx1wYdD7lPT+RsvUDQfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmB9Y3B4pz4f3lWD;
	Fri,  1 Mar 2024 09:59:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CE5FC1A01A8;
	Fri,  1 Mar 2024 09:59:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCWNuFlofJLFg--.62870S3;
	Fri, 01 Mar 2024 09:59:52 +0800 (CST)
Subject: Re: [PATCH md-6.9 v4 03/11] md/raid1: record nonrot rdevs while
 adding/removing rdevs to conf
To: Paul Menzel <pmenzel@molgen.mpg.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, song@kernel.org,
 neilb@suse.com, shli@fb.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240229095714.926789-1-yukuai1@huaweicloud.com>
 <20240229095714.926789-4-yukuai1@huaweicloud.com>
 <7b030433-518e-4fe7-976c-3ffb5f7f1a85@molgen.mpg.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a5d762b9-f8c9-d690-6616-028f507ba7f6@huaweicloud.com>
Date: Fri, 1 Mar 2024 09:59:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7b030433-518e-4fe7-976c-3ffb5f7f1a85@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCWNuFlofJLFg--.62870S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFWfuFW7Kr15JF4rtr1rCrg_yoWxtrWrpr
	4ktFWrJryUCrn5Jr1Utr1UAryrtw1UJa1DJr1xJa4jqr1UJryjqF4UWryjgr1UJr48Jr1U
	Jr1UJrsrZr1xJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

在 2024/03/01 0:37, Paul Menzel 写道:
> Dear Yu,
> 
> 
> Thank you for your patch.
> 
> 
> Am 29.02.24 um 10:57 schrieb Yu Kuai:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> For raid1, each read will iterate all the rdevs from conf and check if
>> any rdev is non-rotational, then choose rdev with minimal IO inflight
>> if so, or rdev with closest distance otherwise.
>>
>> Disk nonrot info can be changed through sysfs entry:
>>
>> /sys/block/[disk_name]/queue/rotational
>>
>> However, consider that this should only be used for testing, and user
>> really shouldn't do this in real life. Record the number of 
>> non-rotational
>> disks in conf, to avoid checking each rdev in IO fast path and simplify
> 
> The comma is not needed.
> 
>> read_balance() a little bit.
> 
> Just to make sure, I understood correctly. Changing 
> `/sys/block/[disk_name]/queue/rotational` will now not be considered 
> anymore, right?

Yes, and I think this will case performance to be worse in real life.
> 
> For the summary, maybe you could also say “cache”. Maybe:
> 
> Cache attribute rotational while adding/removing rdevs to conf
> 
>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.h    |  1 +
>>   drivers/md/raid1.c | 17 ++++++++++-------
>>   drivers/md/raid1.h |  1 +
>>   3 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index a49ab04ab707..b2076a165c10 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -207,6 +207,7 @@ enum flag_bits {
>>                    * check if there is collision between raid1
>>                    * serial bios.
>>                    */
>> +    Nonrot,            /* non-rotational device (SSD) */
>>   };
>>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int 
>> sectors,
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index 6ec9998f6257..de6ea87d4d24 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>       int sectors;
>>       int best_good_sectors;
>>       int best_disk, best_dist_disk, best_pending_disk;
>> -    int has_nonrot_disk;
>>       int disk;
>>       sector_t best_dist;
>>       unsigned int min_pending;
>> @@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>       best_pending_disk = -1;
>>       min_pending = UINT_MAX;
>>       best_good_sectors = 0;
>> -    has_nonrot_disk = 0;
>>       choose_next_idle = 0;
>>       clear_bit(R1BIO_FailFast, &r1_bio->state);
>> @@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>           sector_t first_bad;
>>           int bad_sectors;
>>           unsigned int pending;
>> -        bool nonrot;
>>           rdev = conf->mirrors[disk].rdev;
>>           if (r1_bio->bios[disk] == IO_BLOCKED
>> @@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>               /* At least two disks to choose from so failfast is OK */
>>               set_bit(R1BIO_FailFast, &r1_bio->state);
>> -        nonrot = bdev_nonrot(rdev->bdev);
>> -        has_nonrot_disk |= nonrot;
>>           pending = atomic_read(&rdev->nr_pending);
>>           dist = abs(this_sector - conf->mirrors[disk].head_position);
>>           if (choose_first) {
>> @@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>                * small, but not a big deal since when the second disk
>>                * starts IO, the first disk is likely still busy.
>>                */
>> -            if (nonrot && opt_iosize > 0 &&
>> +            if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
>>                   mirror->seq_start != MaxSector &&
>>                   mirror->next_seq_sect > opt_iosize &&
>>                   mirror->next_seq_sect - opt_iosize >=
>> @@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, 
>> struct r1bio *r1_bio, int *max_sect
>>        * mixed ratation/non-rotational disks depending on workload.
>>        */
>>       if (best_disk == -1) {
>> -        if (has_nonrot_disk || min_pending == 0)
>> +        if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
>>               best_disk = best_pending_disk;
>>           else
>>               best_disk = best_dist_disk;
>> @@ -1768,6 +1763,11 @@ static bool raid1_add_conf(struct r1conf *conf, 
>> struct md_rdev *rdev, int disk,
>>       if (info->rdev)
>>           return false;
>> +    if (bdev_nonrot(rdev->bdev)) {
>> +        set_bit(Nonrot, &rdev->flags);
>> +        WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
>> +    }
>> +
>>       rdev->raid_disk = disk;
>>       info->head_position = 0;
>>       info->seq_start = MaxSector;
>> @@ -1791,6 +1791,9 @@ static bool raid1_remove_conf(struct r1conf 
>> *conf, int disk)
>>           rdev->mddev->degraded < conf->raid_disks)
>>           return false;
>> +    if (test_and_clear_bit(Nonrot, &rdev->flags))
>> +        WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
>> +
>>       WRITE_ONCE(info->rdev, NULL);
>>       return true;
>>   }
>> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
>> index 14d4211a123a..5300cbaa58a4 100644
>> --- a/drivers/md/raid1.h
>> +++ b/drivers/md/raid1.h
>> @@ -71,6 +71,7 @@ struct r1conf {
>>                            * allow for replacements.
>>                            */
>>       int            raid_disks;
>> +    int            nonrot_disks;
>>       spinlock_t        device_lock;
> 
> As you meant “fastpath” in the commit message, if I remember correctly, 
> this does not improve the performance in benchmarks, right?

Yest, this just safe some memory load command, this is to little to
affect performance benchmarks. Main ideal here is make read_balance()
cleaner.

Thanks,
Kuai

> 
> 
> Kind regards,
> 
> Paul
> .
> 


