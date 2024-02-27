Return-Path: <linux-kernel+bounces-82549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A3868639
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F09B1C222A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119881B285;
	Tue, 27 Feb 2024 01:43:59 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04F36E;
	Tue, 27 Feb 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998238; cv=none; b=Q5W8Wm7q7wWL66LXCq17vuopaPqMILp/b2Jv5r3hlzvb/ustrx7YkTr0n1FuG5Sjqhuk6MKI7GxtupBwCJRtDbdvgEl3nFPazpqlD1oVRXkp2jnr6Yq5g+f3n48fn6Hyyxz3PqszAmQogq2N+1VA7a7vG317DFuBAefG5f6xiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998238; c=relaxed/simple;
	bh=wrrH8Jx+s4UPCfudTaYgHcvLZRd4yMh6PB2n4HvRTuw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hbKQQj2DHeKMkfI8C9fnKqhqFiMZKFhMT7KD0ixn58HOjpZ/FoOunzlAdZA6kagNVHD4sCxURQcVikB1hWMUv3nX65pELRXbLNMYcruvqaokZbglIt1cPImUPyNOOQ7pEay0gxg/ZWiQO+L2WAVJk8G0YvUfZ/b8uPhzma7Iv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkKyV0xxlz4f3kFB;
	Tue, 27 Feb 2024 09:43:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 523061A0172;
	Tue, 27 Feb 2024 09:43:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RFVPt1l8qsUFQ--.61819S3;
	Tue, 27 Feb 2024 09:43:51 +0800 (CST)
Subject: Re: [PATCH md-6.9 06/10] md/raid1: factor out read_first_rdev() from
 read_balance()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com,
 shli@fb.com, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-7-yukuai1@huaweicloud.com>
 <CALTww2-ypx2YJOeXTzj7Y0EtXMkfrTOAJzzmDnnUK=1irspWtQ@mail.gmail.com>
 <4f2ae964-5030-907e-bc06-4d9e1fc8f3e8@huaweicloud.com>
 <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <20374432-d8d6-ceae-2f31-d154520288ee@huaweicloud.com>
Date: Tue, 27 Feb 2024 09:43:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RFVPt1l8qsUFQ--.61819S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5trWxuFWDJr4UKw1fCrg_yoWxurWkpr
	4UJFsayFWUXry3uwn0qw4qgrn3t345JF48Wr4xJ3WxWrn7KF9rKFy8Gryj9FyrCr45Jw1U
	Zw1UArW3u3ZYyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/27 9:23, Xiao Ni 写道:
> On Tue, Feb 27, 2024 at 9:06 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/26 22:16, Xiao Ni 写道:
>>> On Thu, Feb 22, 2024 at 4:04 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> read_balance() is hard to understand because there are too many status
>>>> and branches, and it's overlong.
>>>>
>>>> This patch factor out the case to read the first rdev from
>>>> read_balance(), there are no functional changes.
>>>>
>>>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
>>>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++-------------
>>>>    1 file changed, 46 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
>>>> index 8089c569e84f..08c45ca55a7e 100644
>>>> --- a/drivers/md/raid1.c
>>>> +++ b/drivers/md/raid1.c
>>>> @@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(sector_t start_sector,
>>>>           return len;
>>>>    }
>>>>
>>>> +static void update_read_sectors(struct r1conf *conf, int disk,
>>>> +                               sector_t this_sector, int len)
>>>> +{
>>>> +       struct raid1_info *info = &conf->mirrors[disk];
>>>> +
>>>> +       atomic_inc(&info->rdev->nr_pending);
>>>> +       if (info->next_seq_sect != this_sector)
>>>> +               info->seq_start = this_sector;
>>>> +       info->next_seq_sect = this_sector + len;
>>>> +}
>>>> +
>>>> +static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_bio,
>>>> +                            int *max_sectors)
>>>> +{
>>>> +       sector_t this_sector = r1_bio->sector;
>>>> +       int len = r1_bio->sectors;
>>>> +       int disk;
>>>> +
>>>> +       for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
>>>> +               struct md_rdev *rdev;
>>>> +               int read_len;
>>>> +
>>>> +               if (r1_bio->bios[disk] == IO_BLOCKED)
>>>> +                       continue;
>>>> +
>>>> +               rdev = conf->mirrors[disk].rdev;
>>>> +               if (!rdev || test_bit(Faulty, &rdev->flags))
>>>> +                       continue;
>>>> +
>>>> +               /* choose the first disk even if it has some bad blocks. */
>>>> +               read_len = raid1_check_read_range(rdev, this_sector, &len);
>>>> +               if (read_len > 0) {
>>>> +                       update_read_sectors(conf, disk, this_sector, read_len);
>>>> +                       *max_sectors = read_len;
>>>> +                       return disk;
>>>> +               }
>>>
>>> Hi Kuai
>>>
>>> It needs to update max_sectors even if the bad block starts before
>>> this_sector. Because it can't read more than bad_blocks from other
>>> member disks. If it reads more data than bad blocks, it will cause
>>> data corruption. One rule here is read from the primary disk (the
>>> first readable disk) if it has no bad block and read the
>>> badblock-data-length data from other disks.
>>
>> Noted that raid1_check_read_range() will return readable length from
>> this rdev, hence if bad block starts before this_sector, 0 is returned,
>> and 'len' is updated to the length of badblocks(if not exceed read
>> range), and following iteration will find the first disk to read updated
>> 'len' data and update max_sectors.
> 
> Hi Kuai
> 
> The problem is that choose_first_rdev doesn't return 'len' from
> max_sectors when bad blocks start before this_sector. In the following
> iteration, it can't read more than 'len' from other disks to avoid
> data corruption. I haven't read all the patches. To this patch, it
> resets best_good_sectors to sectors when it encounters a good member
> disk without bad blocks.

In this case, 'len' is not supposed to be returned, caller will split
orignal IO based on 'max_sectors', for example:

IO:		2, 4	|  ----
rdev1: BB: 	0, 4	|xxxx
rdev2: no BB

Then choose_first_rdev() will set max_sectors to 2, and return rdev2,
then caller will split and issue new IO:

orignal IO:	4, 2	|    --
splited IO: 	2, 2	|  --

Finally, issue splited IO to rdev2. Later orignal IO will be handled by
read_balance() again, and rdev1 will be returned.

Is this case what you concerned?

Thanks,
Kuai

> 
> Regards
> Xiao
>>
>> Thanks,
>> Kuai
>>
>>>
>>> Best Regards
>>> Xiao
>>>
>>>> +       }
>>>> +
>>>> +       return -1;
>>>> +}
>>>> +
>>>>    /*
>>>>     * This routine returns the disk from which the requested read should
>>>>     * be done. There is a per-array 'next expected sequential IO' sector
>>>> @@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>           sector_t best_dist;
>>>>           unsigned int min_pending;
>>>>           struct md_rdev *rdev;
>>>> -       int choose_first;
>>>>
>>>>     retry:
>>>>           sectors = r1_bio->sectors;
>>>> @@ -613,10 +653,11 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>           best_pending_disk = -1;
>>>>           min_pending = UINT_MAX;
>>>>           best_good_sectors = 0;
>>>> -       choose_first = raid1_should_read_first(conf->mddev, this_sector,
>>>> -                                              sectors);
>>>>           clear_bit(R1BIO_FailFast, &r1_bio->state);
>>>>
>>>> +       if (raid1_should_read_first(conf->mddev, this_sector, sectors))
>>>> +               return choose_first_rdev(conf, r1_bio, max_sectors);
>>>> +
>>>>           for (disk = 0 ; disk < conf->raid_disks * 2 ; disk++) {
>>>>                   sector_t dist;
>>>>                   sector_t first_bad;
>>>> @@ -662,8 +703,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>                                    * bad_sectors from another device..
>>>>                                    */
>>>>                                   bad_sectors -= (this_sector - first_bad);
>>>> -                               if (choose_first && sectors > bad_sectors)
>>>> -                                       sectors = bad_sectors;
>>>>                                   if (best_good_sectors > sectors)
>>>>                                           best_good_sectors = sectors;
>>>>
>>>> @@ -673,8 +712,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>                                           best_good_sectors = good_sectors;
>>>>                                           best_disk = disk;
>>>>                                   }
>>>> -                               if (choose_first)
>>>> -                                       break;
>>>>                           }
>>>>                           continue;
>>>>                   } else {
>>>> @@ -689,10 +726,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>
>>>>                   pending = atomic_read(&rdev->nr_pending);
>>>>                   dist = abs(this_sector - conf->mirrors[disk].head_position);
>>>> -               if (choose_first) {
>>>> -                       best_disk = disk;
>>>> -                       break;
>>>> -               }
>>>>                   /* Don't change to another disk for sequential reads */
>>>>                   if (conf->mirrors[disk].next_seq_sect == this_sector
>>>>                       || dist == 0) {
>>>> @@ -760,13 +793,9 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
>>>>                   rdev = conf->mirrors[best_disk].rdev;
>>>>                   if (!rdev)
>>>>                           goto retry;
>>>> -               atomic_inc(&rdev->nr_pending);
>>>> -               sectors = best_good_sectors;
>>>> -
>>>> -               if (conf->mirrors[best_disk].next_seq_sect != this_sector)
>>>> -                       conf->mirrors[best_disk].seq_start = this_sector;
>>>>
>>>> -               conf->mirrors[best_disk].next_seq_sect = this_sector + sectors;
>>>> +               sectors = best_good_sectors;
>>>> +               update_read_sectors(conf, disk, this_sector, sectors);
>>>>           }
>>>>           *max_sectors = sectors;
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 


