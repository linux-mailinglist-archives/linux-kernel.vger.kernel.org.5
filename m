Return-Path: <linux-kernel+bounces-70307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F58595DF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5479E1C21463
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E476125D5;
	Sun, 18 Feb 2024 08:59:26 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A4FC1D;
	Sun, 18 Feb 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246765; cv=none; b=EaBlYstAX6P5pFv7z/gDarPzYTptzD8ECCLQsdXwnFtc1AbiRWUFr8AmAqcpGRM6RYK/2R0/nC/IL3p3ahapNVnI+NwLX1pH3hNn9gNKpGbCPoiK7NkyE945XzmwUfIWNNEKIBabxGZrsppXrVY3MLmXv/wUrCSnTDH55j1nsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246765; c=relaxed/simple;
	bh=ZZ+H8LVg2IFQHCdjKmyzTCPevikSQnQ+JapriyhXgfo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nizIThB1fseORtuwAkjK26nBwC0u45aqyP5RJBrUyYEUh1lmilCEs2oeyIhwwxlhyEC6z/zu2+VIM7H/QOY9y49+h+d85qmBfXJZNPpnuc9sMXOC1cU3UI2jNmJVj3wcEivp6u6uvdNWKWnJuqigNDuoU3psed4wZnrtmEM5De0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Td0376ddLz4f3kKm;
	Sun, 18 Feb 2024 16:59:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 04FFE1A0CF6;
	Sun, 18 Feb 2024 16:59:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHjxtFldH+GEQ--.13072S3;
	Sun, 18 Feb 2024 16:59:17 +0800 (CST)
Subject: Re: [PATCH v5 03/14] md: make sure md_do_sync() will set
 MD_RECOVERY_DONE
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-4-yukuai1@huaweicloud.com>
 <CALTww283nysUDy=jmW4w45GbS6O2nS0XLYX=KEiO2BUp5+cLaA@mail.gmail.com>
 <15f0f260-3a2f-6d9b-e60e-c534a9a4d7d0@huaweicloud.com>
 <CALTww2-jfLXfOSHfBTUk9iMUZfHprmQ56bp2XFPbQaj401nSKg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eb7c3bce-54ee-afbc-cea5-1e19c09d14f8@huaweicloud.com>
Date: Sun, 18 Feb 2024 16:59:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-jfLXfOSHfBTUk9iMUZfHprmQ56bp2XFPbQaj401nSKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHjxtFldH+GEQ--.13072S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFykCFy7Gry8tFW8tryUtrb_yoWxXryrpF
	W8JF90vr48Zry7ZrZFq3WqqFyFyw1jqryUuFy3W34rAa4DK3WfWFW8CFyUCFWvyF97Jw4j
	vF45JFZ3uFyYk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 16:41, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 2:51 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 13:56, Xiao Ni 写道:
>>> On Thu, Feb 1, 2024 at 5:30 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
>>>> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
>>>> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
>>>> stop_sync_thread().
>>>>
>>>> If MD_RECOVERY_WAIT is set or the array is read-only, md_do_sync() will
>>>> return without setting MD_RECOVERY_DONE, and after commit f52f5c71f3d4
>>>> ("md: fix stopping sync thread"), dm-raid switch from
>>>> md_reap_sync_thread() to stop_sync_thread() to unregister sync_thread
>>>> from md_stop() and md_stop_writes(), causing the test
>>>> shell/lvconvert-raid-reshape.sh hang.
>>>>
>>>> We shouldn't switch back to md_reap_sync_thread() because it's
>>>> problematic in the first place. Fix the problem by making sure
>>>> md_do_sync() will set MD_RECOVERY_DONE.
>>>>
>>>> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
>>>> Closes: https://lore.kernel.org/all/ece2b06f-d647-6613-a534-ff4c9bec1142@redhat.com/
>>>> Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
>>>> Fixes: 5fd6c1dce06e ("[PATCH] md: allow checkpoint of recovery with version-1 superblock")
>>>> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    drivers/md/md.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>>> index 6906d023f1d6..c65dfd156090 100644
>>>> --- a/drivers/md/md.c
>>>> +++ b/drivers/md/md.c
>>>> @@ -8788,12 +8788,16 @@ void md_do_sync(struct md_thread *thread)
>>>>           int ret;
>>>>
>>>>           /* just incase thread restarts... */
>>>> -       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
>>>> -           test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
>>>> +       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
>>>>                   return;
>>>> -       if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>>>> +
>>>> +       if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
>>>> +               goto skip;
>>>> +
>>>> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
>>>> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only array */
>>>>                   set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>>>> -               return;
>>>> +               goto skip;
>>>>           }
>>>
>>> Hi all
>>>
>>> I have a question here. The codes above means if MD_RECOVERY_WAIT is
>>> set, it sets MD_RECOVERY_INTR. If so, the sync thread can't happen.
>>> But from the codes in md_start function:
>>>
>>>                   set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
>>>                   md_wakeup_thread(mddev->thread);
>>>                   ret = mddev->pers->start(mddev);
>>>                   clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
>>>                   md_wakeup_thread(mddev->sync_thread);
>>>
>>> MD_RECOVERY_WAIT means "it'll run sync thread later not interrupt it".
>>> I guess this patch can introduce a new bug for raid5 journal?
>>
>> I'm not sure what kind of problem you're talking about. After patch 4,
>> md_start_sync() should be the only place to register sync_thread, hence
>> md_start() should not see registered sync_thread. Perhaps
>> MD_RECOVERY_WAIT and md_wakeup_thread(mddev->sync_thread) can be removed
>> after patch 4?
> 
> Hi Kuai
> 
> Before this patch, the process is:
> 1. set MD_RECOVERY_WAIT
> 2. start sync thread, sync thread can't run until MD_RECOVERY_WAIT is cleared

Do you take a look at patch 4 and patch 9? sync thread will not start
before step 4 now.
> 3. do something
> 4. clear MD_RECOVERY_WAIT
> 5. sync thread (md_do_sync) can run
> 
> After this patch, step2 returns directly because MD_RECOVERY_INTR is
> set. By this patch, MD_RECOVERY_WAIT has the same meaning as
> MD_RECOVERY_INTR.  So this patch breaks one logic.

And nothing is broke here.
> 
> MD_RECOVERY_WAIT is introduced by patch
> d5d885fd514fcebc9da5503c88aa0112df7514ef (md: introduce new
> personality funciton start()). Then dm raid uses it to delay sync
> thread too.
> 
> Back to the deadlock which this patch tries to fix.
> The original report is reshape is stuck and can be reproduced easily
> by these commands:
> modprobe brd rd_size=34816 rd_nr=5
> vgcreate test_vg /dev/ram*
> lvcreate --type raid5 -L 16M -n test_lv test_vg
> lvconvert -y --stripes 4 /dev/test_vg/test_lv
> vgremove test_vg -ff
> 

And can you still reporduce this problem after this patchset?

> The root cause is that dm raid stopped the sync thread directly
> before. It works even MD_RECOVERY_WAIT is set. Now we stop sync thread
> asynchronously. Because MD_RECOVERY_WAIT is set, when stopping dm
> raid, it can't set MD_RECOVERY_DONE in md_do_sync. It's the reason
> it's stuck at stop_sync_thread. So to fix this deadlock, dm raid
> should clear MD_RECOVERY_WAIT before stopping the sync thread.

Or are you saying that it's better to fix this problem this way? You
dind't explain that what's the problem to set MD_RECOVERY_DONE in
md_so_sync().
> 
> dm raid stop process:
> 1. dm_table_postsuspend_targets -> raid_postsuspend -> md_stop_writes.
> 2. dm_table_destroy -> raid_dtr
> 
> So we need to clear MD_RECOVERY_WAIT before calling md_stop_writes.
> 
>>
>>>
>>> And to resolve this deadlock, we can use this patch:
>>>
>>> --- a/drivers/md/dm-raid.c
>>> +++ b/drivers/md/dm-raid.c
>>> @@ -3796,8 +3796,10 @@ static void raid_postsuspend(struct dm_target *ti)
>>>           struct raid_set *rs = ti->private;
>>>
>>>           if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
>>> +               if (test_bit(MD_RECOVERY_WAIT, &rs->md.recovery))
>>> +                       clear_bit(MD_RECOVERY_WAIT, &rs->md.recovery);
>>
>> You must make sure md_do_sync() is called after this if sync_thread is
>> already registered, and I don't understand yet how this is guranteed. :(
> 
> md_stop_writes -> __md_stop_writes -> stop_sync_thread guarantee this.
> 
> Best Regards
> Xiao
>>
>> Thanks,
>> Kuai
>>
>>>
>>> Regards
>>> Xiao
>>>>
>>>>           if (mddev_is_clustered(mddev)) {
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 


