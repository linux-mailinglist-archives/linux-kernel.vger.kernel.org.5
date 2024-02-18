Return-Path: <linux-kernel+bounces-70134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B78593D4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8C41C20D01
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365EF1C2D;
	Sun, 18 Feb 2024 01:24:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A31103;
	Sun, 18 Feb 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219478; cv=none; b=ttWYxQDS14rUtaYC6RdhsJEVBjVyPTaPe++ljKxp8MQh2EloCIDQkAdBR+IbgKmIiWPgpZCsIznEt+CfwbJgqhaSJ64G8PZlgqP32LaykcatvhZt833Dg3t6J6uURcVW3cFGLAslV1rc85EFzZiuf7hQD850fQfxYiMtlFW6Hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219478; c=relaxed/simple;
	bh=IgYTPmLR6pAHeHDL5m+TGI/faPkMAaOtjDb5k5ziVsY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y5b8qe8UIphyrPkdtYmMNHRRrvX/wo4Gy/NBM4M84JCoc2gKPRSv8fIIJN3dkzUj3+zVEGle6mHHPdcOX68gGxg5cL2l5GfYUlAMajKc7yHH50YEnDkv54W7qTShrwDmR3KAsC+vzCRNxBrOXCwgJYwQhuYIVUmaytmiggcASmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcnyP41WWz4f3jqx;
	Sun, 18 Feb 2024 09:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9CD441A0175;
	Sun, 18 Feb 2024 09:24:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFPXNFlSVRlEQ--.16356S3;
	Sun, 18 Feb 2024 09:24:32 +0800 (CST)
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Benjamin Marzinski <bmarzins@redhat.com>, Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com,
 heinzm@redhat.com, xni@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com>
 <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b969c17d-3330-49c9-fb32-60156325949e@huaweicloud.com>
Date: Sun, 18 Feb 2024 09:24:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zc72uQln4bXothru@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFPXNFlSVRlEQ--.16356S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1xtF18GrW8try7JrWDArb_yoWrtryDpF
	ZxGFySyrWUArZ3JrnIvF1jgFnxt3Wftry5Jr97Jw4rZrn8Zr1DGr18GFyrWFZ8CFyUur17
	tF4UtF98GF4UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/16 13:46, Benjamin Marzinski 写道:
> On Thu, Feb 15, 2024 at 02:24:34PM -0800, Song Liu wrote:
>> On Thu, Feb 1, 2024 at 1:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>> [...]
>>>
>>> [1] https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/
>>>
>>> Yu Kuai (14):
>>>    md: don't ignore suspended array in md_check_recovery()
>>>    md: don't ignore read-only array in md_check_recovery()
>>>    md: make sure md_do_sync() will set MD_RECOVERY_DONE
>>>    md: don't register sync_thread for reshape directly
>>>    md: don't suspend the array for interrupted reshape
>>>    md: fix missing release of 'active_io' for flush
>>
>> Applied 1/14-5/14 to md-6.8 branch (6/14 was applied earlier).
>>
>> Thanks,
>> Song
> 
> I'm still seeing new failures that I can't reproduce in the 6.6 kernel,
> specifically:
> 
> lvconvert-raid-reshape-stripes-load-reload.sh
> lvconvert-repair-raid.sh
> 
> with lvconvert-raid-reshape-stripes-load-reload.sh Patch 12/14
> ("md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> reshape") is changing a hang to a corruption. The issues is that we
> can't simply fail IO that crosses the reshape position. I assume that
> the correct thing to do is have dm-raid reissue it after the suspend,
> when the reshape can make progress again. Perhaps something like this,
> only less naive (although this patch does make the test pass for me).
> Heinz, any thoughts on this? Otherwise, I'll look into this a little
> more and post a RFC patch.

Does the corruption looks like below?

[12504.959682] BUG bio-296 (Not tainted): Object already free
[12504.960239] 
-----------------------------------------------------------------------------
[12504.960239]
[12504.961209] Allocated in mempool_alloc+0xe8/0x270 age=30 cpu=1 pid=203288
[12504.961905]  kmem_cache_alloc+0x36a/0x3b0
[12504.962324]  mempool_alloc+0xe8/0x270
[12504.962712]  bio_alloc_bioset+0x3b5/0x920
[12504.963129]  bio_alloc_clone+0x3e/0x160
[12504.963533]  alloc_io+0x3d/0x1f0
[12504.963876]  dm_submit_bio+0x12f/0xa30
[12504.964267]  __submit_bio+0x9c/0xe0
[12504.964639]  submit_bio_noacct_nocheck+0x25a/0x570
[12504.965136]  submit_bio_wait+0xc2/0x160
[12504.965535]  blkdev_issue_zeroout+0x19b/0x2e0
[12504.965991]  ext4_init_inode_table+0x246/0x560
[12504.966462]  ext4_lazyinit_thread+0x750/0xbe0
[12504.966922]  kthread+0x1b4/0x1f0

I assum that this is a dm problem and I'm still trying to debug it.
Can you explain more why IO that crosses the reshape position can't
fail directly?

Thanks,
Kuai

> 
> =========================================================
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index ed8c28952b14..ff481d494b04 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3345,6 +3345,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
>   	return DM_MAPIO_SUBMITTED;
>   }
>   
> +static int raid_end_io(struct dm_target *ti, struct bio *bio,
> +		       blk_status_t *error)
> +{
> +	if (*error != BLK_STS_IOERR || !dm_noflush_suspending(ti))
> +		return DM_ENDIO_DONE;
> +	return DM_ENDIO_REQUEUE;
> +}

> +
>   /* Return sync state string for @state */
>   enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, st_recover, st_idle };
>   static const char *sync_str(enum sync_state state)
> @@ -4100,6 +4108,7 @@ static struct target_type raid_target = {
>   	.ctr = raid_ctr,
>   	.dtr = raid_dtr,
>   	.map = raid_map,
> +	.end_io = raid_end_io,
>   	.status = raid_status,
>   	.message = raid_message,
>   	.iterate_devices = raid_iterate_devices,
> =========================================================
>>
>>
>>>    md: export helpers to stop sync_thread
>>>    md: export helper md_is_rdwr()
>>>    dm-raid: really frozen sync_thread during suspend
>>>    md/dm-raid: don't call md_reap_sync_thread() directly
>>>    dm-raid: add a new helper prepare_suspend() in md_personality
>>>    md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>>>      reshape
>>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
>>>    dm-raid: remove mddev_suspend/resume()
>>>
>>>   drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
>>>   drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
>>>   drivers/md/md.h      |  16 ++++++
>>>   drivers/md/raid10.c  |  16 +-----
>>>   drivers/md/raid5.c   |  61 +++++++++++----------
>>>   5 files changed, 192 insertions(+), 105 deletions(-)
>>>
>>> --
>>> 2.39.2
>>>
>>>
> 
> .
> 


