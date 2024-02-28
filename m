Return-Path: <linux-kernel+bounces-84338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC2886A514
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1028AEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92F23CB;
	Wed, 28 Feb 2024 01:35:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F586185E;
	Wed, 28 Feb 2024 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084154; cv=none; b=rRSI33tcYUwCE0h0CE98461xzWDH3aQaiajcML43upKzOoDljsew6OUR5ERbHYoyeujPPpIlz6MjkSWc8rD9Fz/13WBqOCBs3gQyJHg3GaBEyMZgi5s085ZUi91W6XgI6rLrI5vk2TmDmjkZjonE6nG3NmJJclwlxVinhyQXvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084154; c=relaxed/simple;
	bh=SWfm49+auF+YfKuVkYr3J/81I0EzJwTGBm9iEkjPZrg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UKWNEpVr8Oh7Z+YA7KC3V/vVF0PZXMwwms9riv6H22k7qIFY1nuRoqmbL3Sa3oZtvPz2A+kyDUR8txvq/U8VDmP+Ggbo+vyBOvaD97fWX4zeznEWyAKFDUkhhQM+IqonySpNVdX+usgPLfohKsfaP6eUX7BYhwdn4V3yO68HPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tkxkg43Dqz4f3m6Z;
	Wed, 28 Feb 2024 09:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DCB0F1A0D2B;
	Wed, 28 Feb 2024 09:35:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7vjd5lt+p6FQ--.6306S3;
	Wed, 28 Feb 2024 09:35:45 +0800 (CST)
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
 <0083c330-1d3f-43b0-1d11-caf09d7c27c8@huaweicloud.com>
 <Zd6KLf1pOkMmfR5g@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ab28c183-171f-47b5-5e98-f38bec2a6174@huaweicloud.com>
Date: Wed, 28 Feb 2024 09:35:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zd6KLf1pOkMmfR5g@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ7vjd5lt+p6FQ--.6306S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr18JFWDXr1fGr1UArWrKrg_yoWDGryxpa
	9rtFWfArWjqrWa9w17tayDu3WYqrn7try2vrWxJ34fZwnIyrn5GF4UWrW5Wr98CFWUur12
	y3WUtF9rur1rtFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/02/28 9:19, Benjamin Marzinski 写道:
> On Thu, Feb 22, 2024 at 05:00:56PM +0800, Yu Kuai wrote:
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
>> I love this idea, however, there could be other reasonable case to
>> return BLK_STS_IOERR, and we probably shouldn't requeue in this case.
>>
>> Are we agree with the idea to let dm-raid reissue the IO after the
>> suspend? If so, we can let raid_map return DM_MAPIO_REQUEUE directly in
>> this special case.
>>
>> Benjamin, can you test the following patch on the top of this set? I
>> verified in my VM for 20+ times that the test pass for me.
> 
> This looks sensible to me, and I have not hit an error in over a hundred
> runs.

That's greate news! Thanks for testing this.

Kuai

> 
> -Ben
> 
>> Thanks,
>> Kuai
>>
>> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
>> index ed8c28952b14..bd37ec94663e 100644
>> --- a/drivers/md/dm-raid.c
>> +++ b/drivers/md/dm-raid.c
>> @@ -3340,7 +3340,8 @@ static int raid_map(struct dm_target *ti, struct bio
>> *bio)
>>          if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
>>                  return DM_MAPIO_REQUEUE;
>>
>> -       md_handle_request(mddev, bio);
>> +       if (unlikely(!md_handle_request(mddev, bio)))
>> +               return DM_MAPIO_REQUEUE;
>>
>>          return DM_MAPIO_SUBMITTED;
>>   }
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index a8db84c200fe..59411d20cbfd 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -366,7 +366,7 @@ static bool is_suspended(struct mddev *mddev, struct bio
>> *bio)
>>          return true;
>>   }
>>
>> -void md_handle_request(struct mddev *mddev, struct bio *bio)
>> +bool md_handle_request(struct mddev *mddev, struct bio *bio)
>>   {
>>   check_suspended:
>>          if (is_suspended(mddev, bio)) {
>> @@ -374,7 +374,7 @@ void md_handle_request(struct mddev *mddev, struct bio
>> *bio)
>>                  /* Bail out if REQ_NOWAIT is set for the bio */
>>                  if (bio->bi_opf & REQ_NOWAIT) {
>>                          bio_wouldblock_error(bio);
>> -                       return;
>> +                       return true;
>>                  }
>>                  for (;;) {
>>                          prepare_to_wait(&mddev->sb_wait, &__wait,
>> @@ -390,10 +390,14 @@ void md_handle_request(struct mddev *mddev, struct bio
>> *bio)
>>
>>          if (!mddev->pers->make_request(mddev, bio)) {
>>                  percpu_ref_put(&mddev->active_io);
>> +               if (!mddev->gendisk && mddev->pers->prepare_suspend &&
>> +                   mddev->reshape_position != MaxSector)
>> +                       return false;
>>                  goto check_suspended;
>>          }
>>
>>          percpu_ref_put(&mddev->active_io);
>> +       return true;
>>   }
>>   EXPORT_SYMBOL(md_handle_request);
>>
>> @@ -8765,6 +8769,23 @@ void md_account_bio(struct mddev *mddev, struct bio
>> **bio)
>>   }
>>   EXPORT_SYMBOL_GPL(md_account_bio);
>>
>> +void md_free_cloned_bio(struct bio *bio)
>> +{
>> +       struct md_io_clone *md_io_clone = bio->bi_private;
>> +       struct bio *orig_bio = md_io_clone->orig_bio;
>> +       struct mddev *mddev = md_io_clone->mddev;
>> +
>> +       if (bio->bi_status && !orig_bio->bi_status)
>> +               orig_bio->bi_status = bio->bi_status;
>> +
>> +       if (md_io_clone->start_time)
>> +               bio_end_io_acct(orig_bio, md_io_clone->start_time);
>> +
>> +       bio_put(bio);
>> +       percpu_ref_put(&mddev->active_io);
>> +}
>> +EXPORT_SYMBOL_GPL(md_free_cloned_bio);
>> +
>>   /* md_allow_write(mddev)
>>    * Calling this ensures that the array is marked 'active' so that writes
>>    * may proceed without blocking.  It is important to call this before
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 8e81f9e2fb20..08db2954006e 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -763,6 +763,7 @@ extern void md_finish_reshape(struct mddev *mddev);
>>   void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
>>                          struct bio *bio, sector_t start, sector_t size);
>>   void md_account_bio(struct mddev *mddev, struct bio **bio);
>> +void md_free_cloned_bio(struct bio *bio);
>>
>>   extern bool __must_check md_flush_request(struct mddev *mddev, struct bio
>> *bio);
>>   extern void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
>> @@ -791,7 +792,7 @@ extern void md_stop_writes(struct mddev *mddev);
>>   extern int md_rdev_init(struct md_rdev *rdev);
>>   extern void md_rdev_clear(struct md_rdev *rdev);
>>
>> -extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>> +extern bool md_handle_request(struct mddev *mddev, struct bio *bio);
>>   extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>>   extern void mddev_resume(struct mddev *mddev);
>>   extern void md_idle_sync_thread(struct mddev *mddev);
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 812d7ec64da5..9a6a1d9eed3d 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -760,6 +760,7 @@ enum stripe_result {
>>          STRIPE_RETRY,
>>          STRIPE_SCHEDULE_AND_RETRY,
>>          STRIPE_FAIL,
>> +       STRIPE_WAIT_RESHAPE,
>>   };
>>
>>   struct stripe_request_ctx {
>> @@ -6036,9 +6037,9 @@ static enum stripe_result make_stripe_request(struct
>> mddev *mddev,
>>   out:
>>          if (ret == STRIPE_SCHEDULE_AND_RETRY && !mddev->gendisk &&
>>              reshape_disabled(mddev)) {
>> -               bi->bi_status = BLK_STS_IOERR;
>> -               ret = STRIPE_FAIL;
>> -               pr_err("dm-raid456: io failed across reshape position while
>> reshape can't make progress");
>> +               bi->bi_status = BLK_STS_RESOURCE;
>> +               ret = STRIPE_WAIT_RESHAPE;
>> +               pr_err_ratelimited("dm-raid456: io across reshape position
>> while reshape can't make progress");
>>          }
>>          return ret;
>>   }
>> @@ -6161,7 +6162,7 @@ static bool raid5_make_request(struct mddev *mddev,
>> struct bio * bi)
>>          while (1) {
>>                  res = make_stripe_request(mddev, conf, &ctx, logical_sector,
>>                                            bi);
>> -               if (res == STRIPE_FAIL)
>> +               if (res == STRIPE_FAIL ||res == STRIPE_WAIT_RESHAPE)
>>                          break;
>>
>>                  if (res == STRIPE_RETRY)
>> @@ -6199,8 +6200,13 @@ static bool raid5_make_request(struct mddev *mddev,
>> struct bio * bi)
>>
>>          if (rw == WRITE)
>>                  md_write_end(mddev);
>> -       bio_endio(bi);
>> -       return true;
>> +       if (res == STRIPE_WAIT_RESHAPE) {
>> +               md_free_cloned_bio(bi);
>> +               return false;
>> +       } else {
>> +               bio_endio(bi);
>> +               return true;
>> +       }
>>   }
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


