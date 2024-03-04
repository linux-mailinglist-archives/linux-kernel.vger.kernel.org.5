Return-Path: <linux-kernel+bounces-90535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984B8700D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2F282478
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8A93BB3D;
	Mon,  4 Mar 2024 11:53:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BC3B18C;
	Mon,  4 Mar 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553183; cv=none; b=i4mfiPiMzjMAAj4BRV78cfPC7w2NBVGaoD9GMALAnrzA9SFXeUSU/cg3/7jXKf4h0xYyWVZzySW0vWjrP3kq3tUXGyCPcsNbYp07TU/va7RlDMuad8fErmRZb4KOplOdw7Vu66kFS5PrIJzGxRILhFRTdFB70UrLmRzhRPuHTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553183; c=relaxed/simple;
	bh=pZT/hr6mBggspJXxi4E4wJk2Pr47pzN497vLsA1740c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S08SM5ZHWyjbkjnWXq56Z1sVNrhie6eevz5znG6ARwcJf64DFEBlGiIjQSf5RFWVvcChblrDgsn79XEJE0CHkcXOjjNJG7zSDYpA/RETLHtc+p3QizxNjaE573qC0f6scISMV1oF6FI4g+3glFvCLyJkGlLFOOTFU6sqY3YpLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TpHBT0Xpyz4f3lVj;
	Mon,  4 Mar 2024 19:52:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 82F5D1A0232;
	Mon,  4 Mar 2024 19:52:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REVtuVlZGyqFw--.53448S3;
	Mon, 04 Mar 2024 19:52:55 +0800 (CST)
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org,
 heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
 <0091f7d1-2273-16ff-8285-5fa3f7e2e0f7@huaweicloud.com>
 <35feaa54-db9e-f0d6-d5a5-a10a45bb90a5@huaweicloud.com>
 <CALTww2-BmudurHbsbbqBMq+KgZs+hokqOJnovS5KDGEidHqZzA@mail.gmail.com>
 <CALTww2_tP9kZEeReystMVLT+UqE7gpHvLO6yrSJ_bjsfTOuaxQ@mail.gmail.com>
 <CALTww2_8B1XMaFEBtPeWae0Gse7ngqZuuRZMn32BdfW2-M8uYA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c87f249a-2bfd-edd2-887d-87413bd044d7@huaweicloud.com>
Date: Mon, 4 Mar 2024 19:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2_8B1XMaFEBtPeWae0Gse7ngqZuuRZMn32BdfW2-M8uYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REVtuVlZGyqFw--.53448S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5uryfXw1kZFWkWrykXwb_yoW7Xr4Dpr
	W7Ja13tr4UAr13ArnIqw1UXFyYyw4xJryUXwnrJw1UZryDtr17Jr4Utr1UCFyDXr15Cw1U
	Jr4UJa43Gr1UtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/04 19:06, Xiao Ni 写道:
> On Mon, Mar 4, 2024 at 4:27 PM Xiao Ni <xni@redhat.com> wrote:
>>
>> On Mon, Mar 4, 2024 at 9:25 AM Xiao Ni <xni@redhat.com> wrote:
>>>
>>> On Mon, Mar 4, 2024 at 9:24 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> 在 2024/03/04 9:07, Yu Kuai 写道:
>>>>> Hi,
>>>>>
>>>>> 在 2024/03/03 21:16, Xiao Ni 写道:
>>>>>> Hi all
>>>>>>
>>>>>> There is a error report from lvm regression tests. The case is
>>>>>> lvconvert-raid-reshape-stripes-load-reload.sh. I saw this error when I
>>>>>> tried to fix dmraid regression problems too. In my patch set,  after
>>>>>> reverting ad39c08186f8a0f221337985036ba86731d6aafe (md: Don't register
>>>>>> sync_thread for reshape directly), this problem doesn't appear.
>>>>>
>>>
>>> Hi Kuai
>>>>> How often did you see this tes failed? I'm running the tests for over
>>>>> two days now, for 30+ rounds, and this test never fail in my VM.
>>>
>>> I ran 5 times and it failed 2 times just now.
>>>
>>>>
>>>> Take a quick look, there is still a path from raid10 that
>>>> MD_RECOVERY_FROZEN can be cleared, and in theroy this problem can be
>>>> triggered. Can you test the following patch on the top of this set?
>>>> I'll keep running the test myself.
>>>
>>> Sure, I'll give the result later.
>>
>> Hi all
>>
>> It's not stable to reproduce this. After applying this raid10 patch it
>> failed once 28 times. Without the raid10 patch, it failed once 30
>> times, but it failed frequently this morning.
> 
> Hi all
> 
> After running 152 times with kernel 6.6, the problem can appear too.
> So it can return the state of 6.6. This patch set can make this
> problem appear quickly.

I verified in my VM that after testing 100+ times, this problem can both
triggered with v6.6 and v6.8-rc5 + this set.

I think we can merge this patchset, and figure out why the test can fail
later.

Thanks,
Kuai


> 
> Best Regards
> Xiao
> 
> 
>>
>> Regards
>> Xiao
>>>
>>> Regards
>>> Xiao
>>>>
>>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>>> index a5f8419e2df1..7ca29469123a 100644
>>>> --- a/drivers/md/raid10.c
>>>> +++ b/drivers/md/raid10.c
>>>> @@ -4575,7 +4575,8 @@ static int raid10_start_reshape(struct mddev *mddev)
>>>>           return 0;
>>>>
>>>>    abort:
>>>> -       mddev->recovery = 0;
>>>> +       if (mddev->gendisk)
>>>> +               mddev->recovery = 0;
>>>>           spin_lock_irq(&conf->device_lock);
>>>>           conf->geo = conf->prev;
>>>>           mddev->raid_disks = conf->geo.raid_disks;
>>>>
>>>> Thanks,
>>>> Kuai
>>>>>
>>>>> Thanks,
>>>>> Kuai
>>>>>
>>>>>>
>>>>>> I put the log in the attachment.
>>>>>>
>>>>>> On Fri, Mar 1, 2024 at 6:03 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>>>>>
>>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>>
>>>>>>> link to part1:
>>>>>>> https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/
>>>>>>>
>>>>>>>
>>>>>>> part1 contains fixes for deadlocks for stopping sync_thread
>>>>>>>
>>>>>>> This set contains fixes:
>>>>>>>    - reshape can start unexpected, cause data corruption, patch 1,5,6;
>>>>>>>    - deadlocks that reshape concurrent with IO, patch 8;
>>>>>>>    - a lockdep warning, patch 9;
>>>>>>>
>>>>>>> I'm runing lvm2 tests with following scripts with a few rounds now,
>>>>>>>
>>>>>>> for t in `ls test/shell`; do
>>>>>>>           if cat test/shell/$t | grep raid &> /dev/null; then
>>>>>>>                   make check T=shell/$t
>>>>>>>           fi
>>>>>>> done
>>>>>>>
>>>>>>> There are no deadlock and no fs corrupt now, however, there are still
>>>>>>> four
>>>>>>> failed tests:
>>>>>>>
>>>>>>> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
>>>>>>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>>>>>>> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
>>>>>>> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>>>>>>>
>>>>>>> And failed reasons are the same:
>>>>>>>
>>>>>>> ## ERROR: The test started dmeventd (147856) unexpectedly
>>>>>>>
>>>>>>> I have no clue yet, and it seems other folks doesn't have this issue.
>>>>>>>
>>>>>>> Yu Kuai (9):
>>>>>>>     md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
>>>>>>>     md: export helpers to stop sync_thread
>>>>>>>     md: export helper md_is_rdwr()
>>>>>>>     md: add a new helper reshape_interrupted()
>>>>>>>     dm-raid: really frozen sync_thread during suspend
>>>>>>>     md/dm-raid: don't call md_reap_sync_thread() directly
>>>>>>>     dm-raid: add a new helper prepare_suspend() in md_personality
>>>>>>>     dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
>>>>>>>       concurrent with reshape
>>>>>>>     dm-raid: fix lockdep waring in "pers->hot_add_disk"
>>>>>>>
>>>>>>>    drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++----------
>>>>>>>    drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
>>>>>>>    drivers/md/md.h      | 38 +++++++++++++++++-
>>>>>>>    drivers/md/raid5.c   | 32 ++++++++++++++-
>>>>>>>    4 files changed, 196 insertions(+), 40 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> 2.39.2
>>>>>>>
>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
> 
> .
> 


