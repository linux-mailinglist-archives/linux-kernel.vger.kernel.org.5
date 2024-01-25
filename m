Return-Path: <linux-kernel+bounces-37868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B136683B6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DF428781A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906EE566A;
	Thu, 25 Jan 2024 01:40:58 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3610E6;
	Thu, 25 Jan 2024 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146857; cv=none; b=CKqt5Mz6Hd98CLymhQPMU5nQTqKq46+yZ6rCL5X1x5nRxSZ5tSaEFe5rWDCzCWl35MXfssp+/7qoaPZQlkRewKu/sBkV0i8m3oSyq4oGSIaAyFsU61b0B5Ysns4etwosPqRtOCqFCw1cmpz9vh6soDFruHVRYA/hqc1u5eDY7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146857; c=relaxed/simple;
	bh=GDEKcx6onVsx23QceFWmpb1VE7xCNpdesMtOmf9hCbM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I8NheD1dguGh7CLgFaLvIWEXjp5kNB4s3A9+xe0VaDAFsWoat9GCgxInlC38ad9HnfZkMAnUnPIX6lU4ME2BrUZy+bQpjXG5aNi6PAboDu3bo1Xn20CX5c6t6bgsqzpiAiauNxUvli6WtxnMsndr5sLOpsQ+nd0joN3Gs7XdQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TL3SF4JT9z4f3kFM;
	Thu, 25 Jan 2024 09:40:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 88FD01A017A;
	Thu, 25 Jan 2024 09:40:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ4fvLFlKESQBw--.18874S3;
	Thu, 25 Jan 2024 09:40:49 +0800 (CST)
Subject: Re: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
To: Xiao Ni <xni@redhat.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <CALTww28G_CmSxzJZVDqHmPgdmT1e2X8+QcToiUOGV1msAisTcQ@mail.gmail.com>
 <CALTww2-1oSCahsqouQv2WT1SDCYDGRepJyh9e_Ph=YjPEboqXQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b8517f1c-5246-14c5-b443-f3c47eb0bfa2@huaweicloud.com>
Date: Thu, 25 Jan 2024 09:40:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-1oSCahsqouQv2WT1SDCYDGRepJyh9e_Ph=YjPEboqXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ4fvLFlKESQBw--.18874S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyxJw1fJFWkWFWUKF13CFg_yoWfGryfpa
	42k3Waqr4UAr1xZrZxt3W0qFyYy3s5JrWYqr98G34rA3s0kF1IyrW8GF4UuFZ8AF9xJw42
	qr45ta4fuas0yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 8:50, Xiao Ni 写道:
> On Wed, Jan 24, 2024 at 8:19 PM Xiao Ni <xni@redhat.com> wrote:
>>
>> On Wed, Jan 24, 2024 at 5:18 PM Yu Kuai <yukuai3@huawei.com> wrote:
>>>
>>> First regression related to stop sync thread:
>>>
>>> The lifetime of sync_thread is designed as following:
>>>
>>> 1) Decide want to start sync_thread, set MD_RECOVERY_NEEDED, and wake up
>>> daemon thread;
>>> 2) Daemon thread detect that MD_RECOVERY_NEEDED is set, then set
>>> MD_RECOVERY_RUNNING and register sync_thread;
>>> 3) Execute md_do_sync() for the actual work, if it's done or
>>> interrupted, it will set MD_RECOVERY_DONE and wake up daemone thread;
>>> 4) Daemon thread detect that MD_RECOVERY_DONE is set, then clear
>>> MD_RECOVERY_RUNNING and unregister sync_thread;
>>>
>>> In v6.7, we fix md/raid to follow this design by commit f52f5c71f3d4
>>> ("md: fix stopping sync thread"), however, dm-raid is not considered at
>>> that time, and following test will hang:
>>
>> Hi Kuai
>>
>> Thanks very much for the patch set. I reported the dm raid deadlock
>> when stopping dm raid and we had the patch set "[PATCH v5 md-fixes
>> 0/3] md: fix stopping sync thread" which has patch f52f5c71f3d4. So we
>> indeed considered dm-raid that time. Because we want to resolve the
>> deadlock problem. I re-look patch f52f5c71f3d4. It has two major
>> changes. One is to use a common function stop_sync_thread for stopping
>> sync thread. This can fix the deadlock problem. The second change
>> changes the way to reap sync thread. mdraid and dmraid reap sync
>> thread in __md_stop_writes. So the patch looks overweight.
>>
>> Before f52f5c71f3d4  do_md_stop release reconfig_mutex before waiting
>> sync_thread to finish. So there should not be the deadlock problem
>> which has been fixed in 130443d60b1b ("md: refactor
>> idle/frozen_sync_thread() to fix deadlock"). So we only need to change
>> __md_stop_writes to stop sync thread like do_md_stop and reap sync
>> thread directly.
>>
>> Maybe this can avoid deadlock? I'll try this way and give the test result.
> 
> Please ignore my last comment. There is something wrong. Only dmraid
> calls reap_sync_thread directly in __md_stop_writes before.
> 
> 130443d60b1b ("md: refactor idle/frozen_sync_thread() to fix
> deadlock") fixes a deadlock problem. sync io is running and user io
> comes. sync io needs to wait user io. user io needs to update
> suerblock and it needs mddev->reconfig_mutex. But user action happens
> with this lock to stop sync thread. So this is the deadlock. For
> dmraid, it doesn't update superblock like md. I'm not sure if dmraid
> has such deadlock problem. If not, dmraid can call md_reap_sync_thread
> directly, right?

Yes, the deadlock problem is because holding the lock to call
md_reap_sync_thread() directly will block daemon thread to handle IO.

However, for dm-raid superblock, I'm confused here, the code looks like
md superblock is still there, for example:

rs_update_sbs
  set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
  md_update_sb(mddev, 1);

And the code in raid1/10/5 to update md superblock doesn't have any
special handling for dm-raid. Or am I missing something here?

Thanks,
Kuai

> 
>>>
>>> shell/integrity-caching.sh
>>> shell/lvconvert-raid-reshape.sh
>>>
>>> This patch set fix the broken test by patch 1-4;
>>>   - patch 1 fix that step 4) is broken by suspended array;
>>>   - patch 2 fix that step 4) is broken by read-only array;
>>>   - patch 3 fix that step 3) is broken that md_do_sync() doesn't set
>>>   MD_RECOVERY_DONE; Noted that this patch will introdece new problem that
>>>   data will be corrupted, which will be fixed in later patches.
>>>   - patch 4 fix that setp 1) is broken that sync_thread is register and
>>>   MD_RECOVERY_RUNNING is set directly;
>>>
>>> With patch 1-4, the above test won't hang anymore, however, the test
>>> will still fail and complain that ext4 is corrupted;
>>
>> For patch3, as I mentioned today, the root cause is
>> dm-raid->rs_start_reshape sets MD_RECOVERY_WAIT. So md_do_sync returns
>> when MD_RECOVERY_WAIT is set. It's the reason why dm-raid can't stop
>> sync thread when start a new reshape. . The way in patch3 looks like a
>> workaround. We need to figure out if dm raid really needs to set
>> MD_RECOVERY_WAIT. Because now we stop sync thread in an asynchronous
>> way. So the deadlock problem which was fixed in 644e2537f (dm raid:
>> fix stripe adding reshape deadlock) may disappear. Maybe we can revert
>> the patch.

In fact, the flag MD_RECOVERY_WAIT looks like a workaround to prevent
new sync thread to start to me. I actually frozen the sync_thread during
suspend, and prevent user to unfrozen it from raid_message() in patch 6.
I think this way is better and probably MD_RECOVERY_WAIT can be removed.

> 
> After talking with Heinz, he mentioned dmraid needs this bit to avoid
> md sync thread to start during reshape. So patch3 looks good.
> 
> Best Regards
> Xiao
>>
>> Best Regards
>> Xiao
>>
>>>
>>> Second regression related to frozen sync thread:
>>>
>>> Noted that for raid456, if reshape is interrupted, then call
>>> "pers->start_reshape" will corrupt data. This is because dm-raid rely on
>>> md_do_sync() doesn't set MD_RECOVERY_DONE so that new sync_thread won't
>>> be registered, and patch 3 just break this.
>>>
>>>   - Patch 5-6 fix this problem by interrupting reshape and frozen
>>>   sync_thread in dm_suspend(), then unfrozen and continue reshape in
>>> dm_resume(). It's verified that dm-raid tests won't complain that
>>> ext4 is corrupted anymore.
>>>   - Patch 7 fix the problem that raid_message() call
>>>   md_reap_sync_thread() directly, without holding 'reconfig_mutex'.
>>>
>>> Last regression related to dm-raid456 IO concurrent with reshape:
>>>
>>> For raid456, if reshape is still in progress, then IO across reshape
>>> position will wait for reshape to make progress. However, for dm-raid,
>>> in following cases reshape will never make progress hence IO will hang:
>>>
>>> 1) the array is read-only;
>>> 2) MD_RECOVERY_WAIT is set;
>>> 3) MD_RECOVERY_FROZEN is set;
>>>
>>> After commit c467e97f079f ("md/raid6: use valid sector values to determine
>>> if an I/O should wait on the reshape") fix the problem that IO across
>>> reshape position doesn't wait for reshape, the dm-raid test
>>> shell/lvconvert-raid-reshape.sh start to hang at raid5_make_request().
>>>
>>> For md/raid, the problem doesn't exist because:
>>>
>>> 1) If array is read-only, it can switch to read-write by ioctl/sysfs;
>>> 2) md/raid never set MD_RECOVERY_WAIT;
>>> 3) If MD_RECOVERY_FROZEN is set, mddev_suspend() doesn't hold
>>>     'reconfig_mutex' anymore, it can be cleared and reshape can continue by
>>>     sysfs api 'sync_action'.
>>>
>>> However, I'm not sure yet how to avoid the problem in dm-raid yet.
>>>
>>>   - patch 9-11 fix this problem by detecting the above 3 cases in
>>>   dm_suspend(), and fail those IO directly.
>>>
>>> If user really meet the IO error, then it means they're reading the wrong
>>> data before c467e97f079f. And it's safe to read/write the array after
>>> reshape make progress successfully.
>>>
>>> Tests:
>>>
>>> I already run the following two tests many times and verified that they
>>> won't fail anymore:
>>>
>>> shell/integrity-caching.sh
>>> shell/lvconvert-raid-reshape.sh
>>>
>>> For other tests, I'm still running. However, I'm sending this patchset
>>> in case people think the fixes is not appropriate. Running the full
>>> tests will cost lots of time in my VM, and I'll update full test results
>>> soon.
>>>
>>> Yu Kuai (11):
>>>    md: don't ignore suspended array in md_check_recovery()
>>>    md: don't ignore read-only array in md_check_recovery()
>>>    md: make sure md_do_sync() will set MD_RECOVERY_DONE
>>>    md: don't register sync_thread for reshape directly
>>>    md: export helpers to stop sync_thread
>>>    dm-raid: really frozen sync_thread during suspend
>>>    md/dm-raid: don't call md_reap_sync_thread() directly
>>>    dm-raid: remove mddev_suspend/resume()
>>>    dm-raid: add a new helper prepare_suspend() in md_personality
>>>    md: export helper md_is_rdwr()
>>>    md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>>>      reshape
>>>
>>>   drivers/md/dm-raid.c |  76 +++++++++++++++++++++----------
>>>   drivers/md/md.c      | 104 ++++++++++++++++++++++++++++---------------
>>>   drivers/md/md.h      |  16 +++++++
>>>   drivers/md/raid10.c  |  16 +------
>>>   drivers/md/raid5.c   |  61 +++++++++++++------------
>>>   5 files changed, 171 insertions(+), 102 deletions(-)
>>>
>>> --
>>> 2.39.2
>>>
> 
> .
> 


