Return-Path: <linux-kernel+bounces-72248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC885B124
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2881C22532
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E2433CB;
	Tue, 20 Feb 2024 03:09:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFD524B8;
	Tue, 20 Feb 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398562; cv=none; b=SOgCcOYQEELDBnumLHd4AgLETXSwW/OaF7hqYMeivCS7jsPm7ng2DBzbEPCa9uB7/B0CHfQ1tI57thpWwoD+LXXtLVCx9E3yexJ2qEnqRFF2bHKH5B6IkZYMyOuvPeBpOYLzOS+tIfzUV+oZ3p6bFgqbK+4KTEjtiDJs24k5Q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398562; c=relaxed/simple;
	bh=yBsgM+sIUq10lZUQwkyMIv8az/ZvECypyV+q4wGM93w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eQS8awPZHxGshQCHlEprYdUT91YE9N4Umz2vDTrMr8nUH6JIGkUoQ67Uj+PBXGVgLKY3scQcgrm3QZfuGRc7ZlFI8FuyE6LbSNPjq2BjqGNisHORB69/doUOLUINk0UTawGhX+EM8qRMixKECrmnLp/ut3uvTqpTcq1jwk9QmIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tf4B93Wdnz4f3kFK;
	Tue, 20 Feb 2024 11:09:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6AAC41A0BB2;
	Tue, 20 Feb 2024 11:09:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHSF9Rlk6w+Eg--.52537S3;
	Tue, 20 Feb 2024 11:09:08 +0800 (CST)
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Benjamin Marzinski <bmarzins@redhat.com>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: Song Liu <song@kernel.org>, mpatocka@redhat.com, heinzm@redhat.com,
 xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
 <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <b969c17d-3330-49c9-fb32-60156325949e@huaweicloud.com>
 <ZdN8USOlyKRLVNgj@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dafd3e61-a033-4c4b-bcf6-70ccd0f4ff63@huaweicloud.com>
Date: Tue, 20 Feb 2024 11:09:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdN8USOlyKRLVNgj@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHSF9Rlk6w+Eg--.52537S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr18JFWDXr1fGr1UArWrKrg_yoW3tr1fpF
	ZxGFySyryUJr93G3sFva1jqFy5t3Z5try5Xr97Jw1fArn0vrn3Jr47JFyrWFyUCryUCr1j
	qF1Utr9rWr1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/20 0:05, Benjamin Marzinski 写道:
> On Sun, Feb 18, 2024 at 09:24:31AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/02/16 13:46, Benjamin Marzinski 写道:
>>> On Thu, Feb 15, 2024 at 02:24:34PM -0800, Song Liu wrote:
>>>> On Thu, Feb 1, 2024 at 1:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>
>>>> [...]
>>>>>
>>>>> [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/
>>>>>
>>>>> Yu Kuai (14):
>>>>>     md: don't ignore suspended array in md_check_recovery()
>>>>>     md: don't ignore read-only array in md_check_recovery()
>>>>>     md: make sure md_do_sync() will set MD_RECOVERY_DONE
>>>>>     md: don't register sync_thread for reshape directly
>>>>>     md: don't suspend the array for interrupted reshape
>>>>>     md: fix missing release of 'active_io' for flush
>>>>
>>>> Applied 1/14-5/14 to md-6.8 branch (6/14 was applied earlier).
>>>>
>>>> Thanks,
>>>> Song
>>>
>>> I'm still seeing new failures that I can't reproduce in the 6.6 kernel,
>>> specifically:
>>>
>>> lvconvert-raid-reshape-stripes-load-reload.sh
>>> lvconvert-repair-raid.sh
>>>
>>> with lvconvert-raid-reshape-stripes-load-reload.sh Patch 12/14
>>> ("md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>>> reshape") is changing a hang to a corruption. The issues is that we
>>> can't simply fail IO that crosses the reshape position. I assume that
>>> the correct thing to do is have dm-raid reissue it after the suspend,
>>> when the reshape can make progress again. Perhaps something like this,
>>> only less naive (although this patch does make the test pass for me).
>>> Heinz, any thoughts on this? Otherwise, I'll look into this a little
>>> more and post a RFC patch.
>>
>> Does the corruption looks like below?
> 
> There isn't a kernel stack trace.  The test
> lvconvert-raid-reshape-stripes-load-reload.sh does some IO to a
> filesytem on top of a raid device, and then starts a reshape, and
> repeatedly suspends the device. After all that, it runs fsck to see if
> the filesystem is clean, and on runs where I see "dm-raid456: io failed
> across reshape position while reshape can't make progress" I see
> filesystem errors:
> 
> ------------------------------------------------------------------
> [ 0:25.219] fsck from util-linux 2.39.2
> [ 0:25.224] e2fsck 1.47.0 (5-Feb-2023)
> [ 0:25.232] Warning: skipping journal recovery because doing a read-only
> filesystem check.
> [ 0:25.233] Pass 1: Checking inodes, blocks, and sizes
> [ 0:25.233] Pass 2: Checking directory structure
> [ 0:25.234] Pass 3: Checking directory connectivity
> [ 0:25.234] Pass 4: Checking reference counts
> [ 0:25.234] Pass 5: Checking group summary information
> [ 0:25.234] Feature orphan_present is set but orphan file is clean.
> [ 0:25.235] Clear? no
> [ 0:25.235]
> [ 0:25.235]
> [ 0:25.235] /tmp/LVMTEST35943.Iuo9Ro5tCY/dev/mapper/LVMTEST35943vg-LV1:
> ********** WARNING: Filesystem still has errors **********
> [ 0:25.235]
> [ 0:25.235] /tmp/LVMTEST35943.Iuo9Ro5tCY/dev/mapper/LVMTEST35943vg-LV1:
> 13/2560 files (0.0% non-contiguous), 5973/10240 blocks
> ------------------------------------------------------------------
> 
> O.k. corruption is too strong a word. Lets just call it a filesystem
> that got a write error, and now is in an unclean state according to
> fsck. I'm pretty sure that this is recoverable.

Yes, I thought this can be acceptable because everything should be good
again once reshape continues.

> 
>> [12504.959682] BUG bio-296 (Not tainted): Object already free
>> [12504.960239]
>> -----------------------------------------------------------------------------
>> [12504.960239]
>> [12504.961209] Allocated in mempool_alloc+0xe8/0x270 age=30 cpu=1 pid=203288
>> [12504.961905]  kmem_cache_alloc+0x36a/0x3b0
>> [12504.962324]  mempool_alloc+0xe8/0x270
>> [12504.962712]  bio_alloc_bioset+0x3b5/0x920
>> [12504.963129]  bio_alloc_clone+0x3e/0x160
>> [12504.963533]  alloc_io+0x3d/0x1f0
>> [12504.963876]  dm_submit_bio+0x12f/0xa30
>> [12504.964267]  __submit_bio+0x9c/0xe0
>> [12504.964639]  submit_bio_noacct_nocheck+0x25a/0x570
>> [12504.965136]  submit_bio_wait+0xc2/0x160
>> [12504.965535]  blkdev_issue_zeroout+0x19b/0x2e0
>> [12504.965991]  ext4_init_inode_table+0x246/0x560
>> [12504.966462]  ext4_lazyinit_thread+0x750/0xbe0
>> [12504.966922]  kthread+0x1b4/0x1f0
>>
>> I assum that this is a dm problem and I'm still trying to debug it.
>> Can you explain more why IO that crosses the reshape position can't
>> fail directly?
> 
> Maybe I'm missing something here, but if the filesystem is trying to
> write out data to the device, and we fail that IO, why would that not
> cause problems, whatever we call it?

And the root cause is the logical in raid456:

Reshape will reconstruct data, and data accross reshape position can't
be reachable until reshape make progress.

The point is that before c467e97f079f, data could be corrupted sliently,
because c467e97f079f fix that IO across reshape position is submitted
directly.

I'm not sure yet how to completely fix this, we can let the IO wait for
reshape(in the upper layer, wait in raid456 will deadlock) to make
progress instead of fail it directly, however, continue the reshape
relies on user, and this way IO may wait forever.

Thanks,
Kuai
> 
> [ 0:18.792] 3,6342,47220996156,-;dm-raid456: io failed across reshape
> position while reshape can't make progress
> [ 0:18.792] 3,6343,47220996182,-;Aborting journal on device dm-39-8.
> [ 0:18.792] 3,6344,47221411730,-;dm-raid456: io failed across reshape
> position while reshape can't make progress
> [ 0:18.792] 3,6345,47221411746,-;Buffer I/O error on dev dm-39, logical
> block 740, lost sync page write
> [ 0:18.792] 3,6346,47221416194,-;JBD2: I/O error when updating journal
> superblock for dm-39-8.
> 
> Does this test not fail for you? Or does it simply also fail in the 6.6
> kernel.

Yes, this test failed as well. And it also fail in 6.6.
> 
> -Ben
>   
>> Thanks,
>> Kuai
>>
>>>
>>> =========================================================
>>> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
>>> index ed8c28952b14..ff481d494b04 100644
>>> --- a/drivers/md/dm-raid.c
>>> +++ b/drivers/md/dm-raid.c
>>> @@ -3345,6 +3345,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
>>>    	return DM_MAPIO_SUBMITTED;
>>>    }
>>> +static int raid_end_io(struct dm_target *ti, struct bio *bio,
>>> +		       blk_status_t *error)
>>> +{
>>> +	if (*error != BLK_STS_IOERR || !dm_noflush_suspending(ti))
>>> +		return DM_ENDIO_DONE;
>>> +	return DM_ENDIO_REQUEUE;
>>> +}
>>
>>> +
>>>    /* Return sync state string for @state */
>>>    enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, st_recover, st_idle };
>>>    static const char *sync_str(enum sync_state state)
>>> @@ -4100,6 +4108,7 @@ static struct target_type raid_target = {
>>>    	.ctr = raid_ctr,
>>>    	.dtr = raid_dtr,
>>>    	.map = raid_map,
>>> +	.end_io = raid_end_io,
>>>    	.status = raid_status,
>>>    	.message = raid_message,
>>>    	.iterate_devices = raid_iterate_devices,
>>> =========================================================
>>>>
>>>>
>>>>>     md: export helpers to stop sync_thread
>>>>>     md: export helper md_is_rdwr()
>>>>>     dm-raid: really frozen sync_thread during suspend
>>>>>     md/dm-raid: don't call md_reap_sync_thread() directly
>>>>>     dm-raid: add a new helper prepare_suspend() in md_personality
>>>>>     md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>>>>>       reshape
>>>>>     dm-raid: fix lockdep waring in "pers->hot_add_disk"
>>>>>     dm-raid: remove mddev_suspend/resume()
>>>>>
>>>>>    drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
>>>>>    drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
>>>>>    drivers/md/md.h      |  16 ++++++
>>>>>    drivers/md/raid10.c  |  16 +-----
>>>>>    drivers/md/raid5.c   |  61 +++++++++++----------
>>>>>    5 files changed, 192 insertions(+), 105 deletions(-)
>>>>>
>>>>> --
>>>>> 2.39.2
>>>>>
>>>>>
>>>
>>> .
>>>
> 
> .
> 


