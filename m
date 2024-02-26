Return-Path: <linux-kernel+bounces-81017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E814B866F16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AB31C222CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49180C0E;
	Mon, 26 Feb 2024 09:12:53 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B0249F8;
	Mon, 26 Feb 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938773; cv=none; b=FQnMRE37HEu4GYfSOlS5Bzv7C42j7FMfxOyU33Zc8TGl5HOKcgD2pStXSK4peXtUt4iHt1y9KeQfHjZgp1TdPkORhw8ncFaUNQHzP68PjtrTjnh5AelL3ldW54e6jII8UirPPnGW85gnV6mdCRNnFyflku1xGH4BgSrVQPyZiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938773; c=relaxed/simple;
	bh=HAjG04Jq/mOFSP/5B/LLl+sfRnqvqCPPIC2LlSaRA8U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SILqyt9xKgtNiA4x2wLVNrR12JuqxygxXI7PTT6Hm34+yRaySnTAF/H7fcwggKJaMJ4oq9eQhIo+/WbzekQ+phnLjmSOwxRo/4HCUyn/2ahehZLHVU5aIPxlKs6txXy+ksCwsL5+HtxSKRT0UOFw0PR5DJDNy4ZsLmCb84CLWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tjvyv3k2cz4f3nK3;
	Mon, 26 Feb 2024 17:12:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C65DA1A016E;
	Mon, 26 Feb 2024 17:12:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBEMVtxlw6XMFA--.40107S3;
	Mon, 26 Feb 2024 17:12:46 +0800 (CST)
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in
 read_balance()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com,
 shli@fb.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-4-yukuai1@huaweicloud.com>
 <CALTww2_g5Sdxh5f=krWiZ1y2y7ud3XaSX5Hhx-mz3AU45c6rGg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <34fbafbe-a510-5193-b86c-91fac69de95f@huaweicloud.com>
Date: Mon, 26 Feb 2024 17:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_g5Sdxh5f=krWiZ1y2y7ud3XaSX5Hhx-mz3AU45c6rGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBEMVtxlw6XMFA--.40107S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUur13Gw1xtrW8ur1UAwb_yoWrZryDpa
	yjvanayrWUXrWak3s0qw4UXrySq345JF48CFWkJa4SqryaqFZ0qryxK3yagFyUCFs3Jw1x
	Xr1UGrW7u3WkKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/02/26 16:55, Xiao Ni 写道:
> Hi Kuai
> 
> Thanks for the effort!
> 
> On Thu, Feb 22, 2024 at 4:04 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") add
>> the case choose next idle in read_balance():
>>
>> read_balance:
>>   for_each_rdev
>>    if(next_seq_sect == this_sector || disk == 0)
> 
> typo error: s/disk/dist/g
> 
>>    -> sequential reads
>>     best_disk = disk;
>>     if (...)
>>      choose_next_idle = 1
>>      continue;
>>
>>   for_each_rdev
>>   -> iterate next rdev
>>    if (pending == 0)
>>     best_disk = disk;
>>     -> choose the next idle disk
>>     break;
>>
>>    if (choose_next_idle)
>>     -> keep using this rdev if there are no other idle disk
>>     continue
>>
>> However, commit 2e52d449bcec ("md/raid1: add failfast handling for reads.")
>> remove the code:
>>
>> -               /* If device is idle, use it */
>> -               if (pending == 0) {
>> -                       best_disk = disk;
>> -                       break;
>> -               }
>>
>> Hence choose next idle will never work now, fix this problem by
>> following:
>>
>> 1) don't set best_disk in this case, read_balance() will choose the best
>>     disk after iterating all the disks;
>> 2) add 'pending' so that other idle disk will be chosen;
>> 3) set 'dist' to 0 so that if there is no other idle disk, and all disks
>>     are rotational, this disk will still be chosen;
>>
>> Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/raid1.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index c60ea58ae8c5..d0bc67e6d068 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>          unsigned int min_pending;
>>          struct md_rdev *rdev;
>>          int choose_first;
>> -       int choose_next_idle;
>>
>>          /*
>>           * Check if we can balance. We can balance on the whole
>> @@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>          best_pending_disk = -1;
>>          min_pending = UINT_MAX;
>>          best_good_sectors = 0;
>> -       choose_next_idle = 0;
>>          clear_bit(R1BIO_FailFast, &r1_bio->state);
>>
>>          if ((conf->mddev->recovery_cp < this_sector + sectors) ||
>> @@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>                          int opt_iosize = bdev_io_opt(rdev->bdev) >> 9;
>>                          struct raid1_info *mirror = &conf->mirrors[disk];
>>
>> -                       best_disk = disk;
>>                          /*
>>                           * If buffered sequential IO size exceeds optimal
>>                           * iosize, check if there is idle disk. If yes, choose
>> @@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>                              mirror->next_seq_sect > opt_iosize &&
>>                              mirror->next_seq_sect - opt_iosize >=
>>                              mirror->seq_start) {
>> -                               choose_next_idle = 1;
>> -                               continue;
>> +                               /*
>> +                                * Add 'pending' to avoid choosing this disk if
>> +                                * there is other idle disk.
>> +                                * Set 'dist' to 0, so that if there is no other
>> +                                * idle disk and all disks are rotational, this
>> +                                * disk will still be chosen.
>> +                                */
>> +                               pending++;
>> +                               dist = 0;
> 
> There is a problem. If all disks are not idle and there is a disk with
> dist=0 before the seq disk, it can't read from the seq disk. It will
> read from the first disk with dist=0. Maybe we can only add the codes
> which are removed from 2e52d449bcec?

If there is a disk with disk=0, then best_dist_disk will be updated to
the disk, and best_dist will be updated to 0 already:

// in each iteration
if (dist < best_dist) {
	best_dist = dist;
	btest_disk_disk = disk;
}

In this case, best_dist will be set to the first disk with dist=0, and
at last, the disk will be chosen:

if (best_disk == -1) {
         if (has_nonrot_disk || min_pending == 0)
                 best_disk = best_pending_disk;
         else
                 best_disk = best_dist_disk;
		-> the first disk with dist=0;
}

So, the problem that you concerned should not exist.

Thanks,
Kuai
> 
> Best Regards
> Xiao
> 
>> +                       } else {
>> +                               best_disk = disk;
>> +                               break;
>>                          }
>> -                       break;
>>                  }
>>
>> -               if (choose_next_idle)
>> -                       continue;
>> -
>>                  if (min_pending > pending) {
>>                          min_pending = pending;
>>                          best_pending_disk = disk;
>> --
>> 2.39.2
>>
>>
> 
> .
> 


