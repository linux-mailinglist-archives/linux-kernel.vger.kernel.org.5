Return-Path: <linux-kernel+bounces-84424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8986A6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DB01C25820
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4761CF81;
	Wed, 28 Feb 2024 02:40:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3921CD13;
	Wed, 28 Feb 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088022; cv=none; b=ikIzabY20d/rzbW7Zo5/EVfAi7esq/UHL7SDoBSiuae3CPOdjM/s6iC3Tjkrk+IfGuZSEv49sMWI5SOVGvGo3ME7FbtJAfHk51OwpsqwryC1oL8WKv760EpWb1e8wqb60SgFFHem9Ujjng5lfv9aaBV5ZVg6BTXLKOBMYMUYf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088022; c=relaxed/simple;
	bh=ChgmAxNg0Mc5z8jxH4amhyKWwa5iQWTl/YPayuk74aY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gTX6OTb0uPrTLeBEm89o5pMNZFeMDySRUhJHclc1pYoLIcJcKgHllLZGE+NN22L4Ye0ciwUpSMYvlFJzymKlX/VPhptdKFEgUMkueXFyehZvj8EMtzZJTETYoFxO0GsHRLhW6FZv6URVN8n9ZCfh384tbaqWa/+hx+Off3x6MhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tkz911pTLz4f3kKd;
	Wed, 28 Feb 2024 10:40:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 958221A0EAF;
	Wed, 28 Feb 2024 10:40:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4Gnd5lk2N_FQ--.39041S3;
	Wed, 28 Feb 2024 10:40:08 +0800 (CST)
Subject: Re: [PATCH md-6.9 v2 02/10] md/raid1: record nonrot rdevs while
 adding/removing rdevs to conf
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, shli@fb.com,
 neilb@suse.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240227120327.1432511-1-yukuai1@huaweicloud.com>
 <20240227120327.1432511-3-yukuai1@huaweicloud.com>
 <CALTww29DXbnhPF241WUbaibFS_aF3jZR8HiuBuj94+hCFUCgOA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <342c4433-229a-9bcd-79ce-874cb2aff051@huaweicloud.com>
Date: Wed, 28 Feb 2024 10:40:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww29DXbnhPF241WUbaibFS_aF3jZR8HiuBuj94+hCFUCgOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g4Gnd5lk2N_FQ--.39041S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15JFWkZw17Ary3Gry5XFb_yoW7Xw13pa
	yUta93Z3yDXrW5Gw1qqa1UCr1Svw15Kay8Grs7C34S9asIqFZ5XFW8Kry2gr1DCrs8Aw12
	vr1UtanxC3WxKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/02/28 9:56, Xiao Ni 写道:
> On Tue, Feb 27, 2024 at 8:09 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
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
>> really shouldn't do this in real life. Record the number of non-rotational
>> disks in conf, to avoid checking each rdev in IO fast path and simplify
>> read_balance() a little bit.
>>
>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.h    |  1 +
>>   drivers/md/raid1.c | 17 ++++++++++-------
>>   drivers/md/raid1.h |  1 +
>>   3 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index a49ab04ab707..b2076a165c10 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -207,6 +207,7 @@ enum flag_bits {
>>                                   * check if there is collision between raid1
>>                                   * serial bios.
>>                                   */
>> +       Nonrot,                 /* non-rotational device (SSD) */
>>   };
>>
>>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>> index a145fe48b9ce..0fed01b06de9 100644
>> --- a/drivers/md/raid1.c
>> +++ b/drivers/md/raid1.c
>> @@ -599,7 +599,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>          int sectors;
>>          int best_good_sectors;
>>          int best_disk, best_dist_disk, best_pending_disk;
>> -       int has_nonrot_disk;
>>          int disk;
>>          sector_t best_dist;
>>          unsigned int min_pending;
>> @@ -620,7 +619,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>          best_pending_disk = -1;
>>          min_pending = UINT_MAX;
>>          best_good_sectors = 0;
>> -       has_nonrot_disk = 0;
>>          choose_next_idle = 0;
>>          clear_bit(R1BIO_FailFast, &r1_bio->state);
>>
>> @@ -637,7 +635,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>                  sector_t first_bad;
>>                  int bad_sectors;
>>                  unsigned int pending;
>> -               bool nonrot;
>>
>>                  rdev = conf->mirrors[disk].rdev;
>>                  if (r1_bio->bios[disk] == IO_BLOCKED
>> @@ -703,8 +700,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>                          /* At least two disks to choose from so failfast is OK */
>>                          set_bit(R1BIO_FailFast, &r1_bio->state);
>>
>> -               nonrot = bdev_nonrot(rdev->bdev);
>> -               has_nonrot_disk |= nonrot;
>>                  pending = atomic_read(&rdev->nr_pending);
>>                  dist = abs(this_sector - conf->mirrors[disk].head_position);
>>                  if (choose_first) {
>> @@ -731,7 +726,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>                           * small, but not a big deal since when the second disk
>>                           * starts IO, the first disk is likely still busy.
>>                           */
>> -                       if (nonrot && opt_iosize > 0 &&
>> +                       if (test_bit(Nonrot, &rdev->flags) && opt_iosize > 0 &&
>>                              mirror->seq_start != MaxSector &&
>>                              mirror->next_seq_sect > opt_iosize &&
>>                              mirror->next_seq_sect - opt_iosize >=
>> @@ -763,7 +758,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>           * mixed ratation/non-rotational disks depending on workload.
>>           */
>>          if (best_disk == -1) {
>> -               if (has_nonrot_disk || min_pending == 0)
>> +               if (READ_ONCE(conf->nonrot_disks) || min_pending == 0)
>>                          best_disk = best_pending_disk;
>>                  else
>>                          best_disk = best_dist_disk;
>> @@ -1819,6 +1814,11 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>>                  WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
>>          }
>>
>> +       if (!err && bdev_nonrot(rdev->bdev)) {
>> +               set_bit(Nonrot, &rdev->flags);
>> +               WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks + 1);
>> +       }
>> +
> 
> Hi Kuai
> 
> I noticed raid1_run->setup_conf is used to add rdev to conf when
> creating raid1. raid1_add_disk is only used for --add/--re-add after
> creating array. So we need to add the same logic in setup_conf?

Yes, it's right. I'll add a helper raid1_add_conf(raid1_info, rdev) and
raid1_remove_conf(raid1_info, rdev) to do this, make sure all the places
to modify conf is covered.

Thanks,
Kuai

> 
> Regards
> Xiao
>>          print_conf(conf);
>>          return err;
>>   }
>> @@ -1883,6 +1883,9 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>>          }
>>   abort:
>>
>> +       if (test_and_clear_bit(Nonrot, &rdev->flags))
>> +               WRITE_ONCE(conf->nonrot_disks, conf->nonrot_disks - 1);
>> +
>>          print_conf(conf);
>>          return err;
>>   }
>> diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
>> index 14d4211a123a..5300cbaa58a4 100644
>> --- a/drivers/md/raid1.h
>> +++ b/drivers/md/raid1.h
>> @@ -71,6 +71,7 @@ struct r1conf {
>>                                                   * allow for replacements.
>>                                                   */
>>          int                     raid_disks;
>> +       int                     nonrot_disks;
>>
>>          spinlock_t              device_lock;
>>
>> --
>> 2.39.2
>>
> 
> .
> 


