Return-Path: <linux-kernel+bounces-98404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB478779A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E581F214E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A368138C;
	Mon, 11 Mar 2024 01:50:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2197EC;
	Mon, 11 Mar 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121831; cv=none; b=E+mrsgz2eBNVCYbAlqz5CWddIJxzGoYKOjQNhYuUn/1GFciKKaxbUbKifYbEiTbPQ2psZrseCAj/cMJY/yrjYaC6q7xOduZ42mF68Iym9U38pmOz9kL0Ubdo7FA79svRliE+M04ozNta5s9ZJLDBnNRsbAPN/uM7AGsayN+FwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121831; c=relaxed/simple;
	bh=hfjsoxtrw6ahsQJbKwotw/NRwujaP0BZl944UqvaXao=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PogqYgHFs/BHIxFtJH3TGvcpKNo+peqh3qYvfWX/+aYFU34o4lmFfopEaVmYtHkt35vITx05Qa+W1zXOpTyGX4YYQHqthRyxeeDSShC5kxKjs22v1e+DEbRfhFlZDIZ2banpkFyY687ul1MLmvyqMnYAuzpqW/QrHbsHi29yj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TtKTt3Hc3z4f3lgC;
	Mon, 11 Mar 2024 09:50:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1BED71A017A;
	Mon, 11 Mar 2024 09:50:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFUY+5leIJQGg--.38947S3;
	Mon, 11 Mar 2024 09:50:13 +0800 (CST)
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: junxiao.bi@oracle.com, Song Liu <song@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, stable@vger.kernel.org,
 Dan Moulding <dan@danm.net>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
 <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
 <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
 <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
Date: Mon, 11 Mar 2024 09:50:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFUY+5leIJQGg--.38947S3
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFWkJF4fJrWUtr4fAr4rGrg_yoW8XryDJo
	WFgw1fXa1rWw4UKFnrJw1DAry3Ga4DAFsxJr15Wr17Jrn5JrW5A34rCrWrJ3y7tF18GFn7
	AryUJr1YyFyUJw4kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/09 7:49, junxiao.bi@oracle.com 写道:
> Here is the root cause for this issue:
> 
> Commit 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in 
> raid5d") introduced a regression, it got reverted through commit 
> bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
> raid5d"). To fix the original issue commit 5e2cf333b7bd was fixing, 
> commit d6e035aad6c0 ("md: bypass block throttle for superblock update") 
> was created, it avoids md superblock write getting throttled by block 
> layer which is good, but md superblock write could be stuck in block 
> layer due to block flush as well, and that is what was happening in this 
> regression report.
> 
> Process "md0_reclaim" got stuck while waiting IO for md superblock write 
> done, that IO was marked with REQ_PREFLUSH | REQ_FUA flags, these 3 
> steps ( PREFLUSH, DATA and POSTFLUSH ) will be executed before done, the 
> hung of this process is because the last step "POSTFLUSH" never done. 
> And that was because of  process "md0_raid5" submitted another IO with 
> REQ_FUA flag marked just before that step started. To handle that IO, 
> blk_insert_flush() will be invoked and hit "REQ_FSEQ_DATA | 
> REQ_FSEQ_POSTFLUSH" case where "fq->flush_data_in_flight" will be 
> increased. When the IO for md superblock write was to issue "POSTFLUSH" 
> step through blk_kick_flush(), it found that "fq->flush_data_in_flight" 
> was not zero, so it will skip that step, that is expected, because flush 
> will be triggered when "fq->flush_data_in_flight" dropped to zero.
> 
> Unfortunately here that inflight data IO from "md0_raid5" will never 
> done, because it was added into the blk_plug list of that process, but 
> "md0_raid5" run into infinite loop due to "MD_SB_CHANGE_PENDING" which 
> made it never had a chance to finish the blk plug until 
> "MD_SB_CHANGE_PENDING" was cleared. Process "md0_reclaim" was supposed 
> to clear that flag but it was stuck by "md0_raid5", so this is a deadlock.
> 
> Looks like the approach in the RFC patch trying to resolve the 
> regression of commit 5e2cf333b7bd can help this issue. Once "md0_raid5" 
> starts looping due to "MD_SB_CHANGE_PENDING", it should release all its 
> staging IO requests to avoid blocking others. Also a cond_reschedule() 
> will avoid it run into lockup.

The analysis sounds good, however, it seems to me that the behaviour
raid5d() pings the cpu to wait for 'MD_SB_CHANGE_PENDING' to be cleared
is not reasonable, because md_check_recovery() must hold
'reconfig_mutex' to clear the flag.

Look at raid1/raid10, there are two different behaviour that seems can
avoid this problem as well:

1) blk_start_plug() is delayed until all failed IO is handled. This look
reasonable because in order to get better performance, IO should be
handled by submitted thread as much as possible, and meanwhile, the
deadlock can be triggered here.
2) if 'MD_SB_CHANGE_PENDING' is not cleared by md_check_recovery(), skip
the handling of failed IO, and when mddev_unlock() is called, daemon
thread will be woken up again to handle failed IO.

How about the following patch?

Thanks,
Kuai

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3ad5f3c7f91e..0b2e6060f2c9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6720,7 +6720,6 @@ static void raid5d(struct md_thread *thread)

         md_check_recovery(mddev);

-       blk_start_plug(&plug);
         handled = 0;
         spin_lock_irq(&conf->device_lock);
         while (1) {
@@ -6728,6 +6727,14 @@ static void raid5d(struct md_thread *thread)
                 int batch_size, released;
                 unsigned int offset;

+               /*
+                * md_check_recovery() can't clear sb_flags, usually 
because of
+                * 'reconfig_mutex' can't be grabbed, wait for 
mddev_unlock() to
+                * wake up raid5d().
+                */
+               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+                       goto skip;
+
                 released = release_stripe_list(conf, 
conf->temp_inactive_list);
                 if (released)
                         clear_bit(R5_DID_ALLOC, &conf->cache_state);
@@ -6766,8 +6773,8 @@ static void raid5d(struct md_thread *thread)
                         spin_lock_irq(&conf->device_lock);
                 }
         }
+skip:
         pr_debug("%d stripes handled\n", handled);
-
         spin_unlock_irq(&conf->device_lock);
         if (test_and_clear_bit(R5_ALLOC_MORE, &conf->cache_state) &&
             mutex_trylock(&conf->cache_size_mutex)) {
@@ -6779,6 +6786,7 @@ static void raid5d(struct md_thread *thread)
                 mutex_unlock(&conf->cache_size_mutex);
         }

+       blk_start_plug(&plug);
         flush_deferred_bios(conf);

         r5l_flush_stripe_to_raid(conf->log);

> 
> https://www.spinics.net/lists/raid/msg75338.html
> 
> Dan, can you try the following patch?
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index de771093b526..474462abfbdc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1183,6 +1183,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool 
> from_schedule)
>          if (unlikely(!rq_list_empty(plug->cached_rq)))
>                  blk_mq_free_plug_rqs(plug);
>   }
> +EXPORT_SYMBOL(__blk_flush_plug);
> 
>   /**
>    * blk_finish_plug - mark the end of a batch of submitted I/O
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..26e09cdf46a3 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6773,6 +6773,11 @@ static void raid5d(struct md_thread *thread)
> spin_unlock_irq(&conf->device_lock);
>                          md_check_recovery(mddev);
>                          spin_lock_irq(&conf->device_lock);
> +               } else {
> + spin_unlock_irq(&conf->device_lock);
> +                       blk_flush_plug(&plug, false);
> +                       cond_resched();
> +                       spin_lock_irq(&conf->device_lock);
>                  }
>          }
>          pr_debug("%d stripes handled\n", handled);
> 
> Thanks,
> 
> Junxiao.
> 
> On 3/1/24 12:26 PM, junxiao.bi@oracle.com wrote:
>> Hi Dan & Song,
>>
>> I have not root cause this yet, but would like share some findings 
>> from the vmcore Dan shared. From what i can see, this doesn't look 
>> like a md issue, but something wrong with block layer or below.
>>
>> 1. There were multiple process hung by IO over 15mins.
>>
>> crash> ps -m | grep UN
>> [0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0  CPU: 1 
>> COMMAND: "jbd2/dm-3-8"
>> [0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0  CPU: 2 
>> COMMAND: "dd"
>> [0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3 
>> COMMAND: "md0_reclaim"
>> [0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740  CPU: 1 
>> COMMAND: "kworker/1:2"
>> [0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80  CPU: 7 
>> COMMAND: "kworker/u21:1"
>>
>> 2. Let pick md0_reclaim to take a look, it is waiting done super_block 
>> update. We can see there were two pending superblock write and other 
>> pending io for the underling physical disk, which caused these process 
>> hung.
>>
>> crash> bt 876
>> PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
>>  #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
>>  #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
>>  #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
>>  #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
>>  #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
>>  #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
>>  #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
>>  #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
>>  #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
>>
>> crash> mddev.pending_writes,disks 0xffff888108335800
>>   pending_writes = {
>>     counter = 2  <<<<<<<<<< 2 active super block write
>>   },
>>   disks = {
>>     next = 0xffff88810ce85a00,
>>     prev = 0xffff88810ce84c00
>>   },
>> crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
>> 0xffff88810ce85a00
>> ffff88810ce85a00
>>   kobj.name = 0xffff8881067c1a00 "dev-dm-1",
>>   nr_pending = {
>>     counter = 0
>>   },
>> ffff8881083ace00
>>   kobj.name = 0xffff888100a93280 "dev-sde",
>>   nr_pending = {
>>     counter = 10 <<<<
>>   },
>> ffff8881010ad200
>>   kobj.name = 0xffff8881012721c8 "dev-sdc",
>>   nr_pending = {
>>     counter = 8 <<<<<
>>   },
>> ffff88810ce84c00
>>   kobj.name = 0xffff888100325f08 "dev-sdd",
>>   nr_pending = {
>>     counter = 2 <<<<<
>>   },
>>
>> 3. From block layer, i can find the inflight IO for md superblock 
>> write which has been pending 955s which matches with the hung time of 
>> "md0_reclaim"
>>
>> crash> 
>> request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
>> ffff888103b4c300
>>   q = 0xffff888103a00d80,
>>   mq_hctx = 0xffff888103c5d200,
>>   cmd_flags = 38913,
>>   rq_flags = 139408,
>>   start_time_ns = 1504179024146,
>>   bio = 0x0,
>>   biotail = 0xffff888120758e40,
>>   state = MQ_RQ_COMPLETE,
>>   __data_len = 0,
>>   flush = {
>>     seq = 3, <<<< REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA
>>     saved_end_io = 0x0
>>   },
>>   end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,
>>
>> crash> p tk_core.timekeeper.tkr_mono.base
>> $1 = 2459916243002
>> crash> eval 2459916243002-1504179024146
>> hexadecimal: de86609f28
>>     decimal: 955737218856  <<<<<<< IO pending time is 955s
>>       octal: 15720630117450
>>      binary: 
>> 0000000000000000000000001101111010000110011000001001111100101000
>>
>> crash> bio.bi_iter,bi_end_io 0xffff888120758e40
>>   bi_iter = {
>>     bi_sector = 8, <<<< super block offset
>>     bi_size = 0,
>>     bi_idx = 0,
>>     bi_bvec_done = 0
>>   },
>>   bi_end_io = 0xffffffff817dca50 <super_written>,
>> crash> dev -d | grep ffff888103a00d80
>>     8 ffff8881003ab000   sdd        ffff888103a00d80       0 0 0
>>
>> 4. Check above request, even its state is "MQ_RQ_COMPLETE", but it is 
>> still pending. That's because each md superblock write was marked with 
>> REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 steps: pre_flush, 
>> data, and post_flush. Once each step complete, it will be marked in 
>> "request.flush.seq", here the value is 3, which is REQ_FSEQ_PREFLUSH 
>> |  REQ_FSEQ_DATA, so the last step "post_flush" has not be done. 
>> Another wired thing is that blk_flush_queue.flush_data_in_flight is 
>> still 1 even "data" step already done.
>>
>> crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
>>   fq = 0xffff88810332e240,
>> crash> blk_flush_queue 0xffff88810332e240
>> struct blk_flush_queue {
>>   mq_flush_lock = {
>>     {
>>       rlock = {
>>         raw_lock = {
>>           {
>>             val = {
>>               counter = 0
>>             },
>>             {
>>               locked = 0 '\000',
>>               pending = 0 '\000'
>>             },
>>             {
>>               locked_pending = 0,
>>               tail = 0
>>             }
>>           }
>>         }
>>       }
>>     }
>>   },
>>   flush_pending_idx = 1,
>>   flush_running_idx = 1,
>>   rq_status = 0 '\000',
>>   flush_pending_since = 4296171408,
>>   flush_queue = {{
>>       next = 0xffff88810332e250,
>>       prev = 0xffff88810332e250
>>     }, {
>>       next = 0xffff888103b4c348, <<<< the request is in this list
>>       prev = 0xffff888103b4c348
>>     }},
>>   flush_data_in_flight = 1,  >>>>>> still 1
>>   flush_rq = 0xffff888103c2e000
>> }
>>
>> crash> list 0xffff888103b4c348
>> ffff888103b4c348
>> ffff88810332e260
>>
>> crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of hw queue
>>   tag = -1,
>>   state = MQ_RQ_IDLE,
>>   ref = {
>>     counter = 0
>>   },
>>
>> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have 
>> some issue which leading to the io request from md layer stayed in a 
>> partial complete statue. I can't see how this can be related with the 
>> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING 
>> in raid5d"")
>>
>>
>> Dan,
>>
>> Are you able to reproduce using some regular scsi disk, would like to 
>> rule out whether this is related with virtio-scsi?
>>
>> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
>> official mainline v6.8-rc5 without any other patches?
>>
>>
>> Thanks,
>>
>> Junxiao.
>>
>> On 2/23/24 6:13 PM, Song Liu wrote:
>>> Hi,
>>>
>>> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>> On 21.02.24 00:06, Dan Moulding wrote:
>>>>> Just a friendly reminder that this regression still exists on the
>>>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>>>> development system to 6.8-rc5 today and immediately hit this issue
>>>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>>>> Song Liu, what's the status here? I aware that you fixed with quite a
>>>> few regressions recently, but it seems like resolving this one is
>>>> stalled. Or were you able to reproduce the issue or make some progress
>>>> and I just missed it?
>>> Sorry for the delay with this issue. I have been occupied with some
>>> other stuff this week.
>>>
>>> I haven't got luck to reproduce this issue. I will spend more time 
>>> looking
>>> into it next week.
>>>
>>>> And if not, what's the way forward here wrt to the release of 6.8?
>>>> Revert the culprit and try again later? Or is that not an option for 
>>>> one
>>>> reason or another?
>>> If we don't make progress with it in the next week, we will do the 
>>> revert,
>>> same as we did with stable kernels.
>>>
>>>> Or do we assume that this is not a real issue? That it's caused by some
>>>> oddity (bit-flip in the metadata or something like that?) only to be
>>>> found in Dan's setup?
>>> I don't think this is because of oddities. Hopefully we can get more
>>> information about this soon.
>>>
>>> Thanks,
>>> Song
>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' 
>>>> hat)
>>>> -- 
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>
>>>> #regzbot poke
>>>>
> 
> .
> 


