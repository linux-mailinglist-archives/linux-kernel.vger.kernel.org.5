Return-Path: <linux-kernel+bounces-94925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4628746D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2087C288BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A81125B9;
	Thu,  7 Mar 2024 03:35:08 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E01CA78;
	Thu,  7 Mar 2024 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782507; cv=none; b=o8mdpgJLZIU50XTfL85jdnnOu3eEupOG1CC7bqcxkoYLEQQPToN/YKBx9kU1a/DEgHp/U1n5/HaRvguikdpl2psr/vmbezUwkCQRt/VVbspyrorC9EnUPDBWujjg6XoI42bUg5sb9hI0n3q/YvzrD42Q14UjwC9eePi9X1Szb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782507; c=relaxed/simple;
	bh=SmFs9CXqMnMDgOlmrhFcrJLGlHiq9rT416WY1uJ3UJ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oJVDlRwdjcoMZYDQ2nIuOqdfTK3M3np95uFikMpra5Lhf3Y41iZY/VHJIL33CPC1BnKcZfSp2k68Q0EFDER6s8SchqPSzJRl+mcKEKWGwMfGy80+7KnYWW1XdXhV5KdPU+9QyvSTmalCSbP+7Hv5OkSDwm3QpTFbdpWyWLHr3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tqw0b3SPsz4f3kFP;
	Thu,  7 Mar 2024 11:34:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EA3551A0232;
	Thu,  7 Mar 2024 11:35:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7hNellZOu6GA--.41300S3;
	Thu, 07 Mar 2024 11:34:59 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cd0f300f-49a0-235a-099c-e76af5ed7c05@huaweicloud.com>
Date: Thu, 7 Mar 2024 11:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7hNellZOu6GA--.41300S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWkAFyUAr4ruFWxZw1xGrg_yoWfJw1rpr
	Z3tFs8CrW8tr1kJr1UJw4xXFy8Zr12y3WUJr95JFyUG3y5GFyjqrWxWrWjgF1DZr40ya17
	Xr1UJryDuryUKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/02 4:26, junxiao.bi@oracle.com 写道:
> Hi Dan & Song,
> 
> I have not root cause this yet, but would like share some findings from 
> the vmcore Dan shared. From what i can see, this doesn't look like a md 
> issue, but something wrong with block layer or below.

I would like to take a look at vmcore as well. How dose Dan sharing the
vmcore? I don't find it in the thread.

Thanks,
Kuai

> 
> 1. There were multiple process hung by IO over 15mins.
> 
> crash> ps -m | grep UN
> [0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0  CPU: 1 
> COMMAND: "jbd2/dm-3-8"
> [0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0  CPU: 2 
> COMMAND: "dd"
> [0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3 
> COMMAND: "md0_reclaim"
> [0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740  CPU: 1 
> COMMAND: "kworker/1:2"
> [0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80  CPU: 7 
> COMMAND: "kworker/u21:1"
> 
> 2. Let pick md0_reclaim to take a look, it is waiting done super_block 
> update. We can see there were two pending superblock write and other 
> pending io for the underling physical disk, which caused these process 
> hung.
> 
> crash> bt 876
> PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
>   #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
>   #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
>   #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
>   #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
>   #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
>   #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
>   #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
>   #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
>   #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
> 
> crash> mddev.pending_writes,disks 0xffff888108335800
>    pending_writes = {
>      counter = 2  <<<<<<<<<< 2 active super block write
>    },
>    disks = {
>      next = 0xffff88810ce85a00,
>      prev = 0xffff88810ce84c00
>    },
> crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
> 0xffff88810ce85a00
> ffff88810ce85a00
>    kobj.name = 0xffff8881067c1a00 "dev-dm-1",
>    nr_pending = {
>      counter = 0
>    },
> ffff8881083ace00
>    kobj.name = 0xffff888100a93280 "dev-sde",
>    nr_pending = {
>      counter = 10 <<<<
>    },
> ffff8881010ad200
>    kobj.name = 0xffff8881012721c8 "dev-sdc",
>    nr_pending = {
>      counter = 8 <<<<<
>    },
> ffff88810ce84c00
>    kobj.name = 0xffff888100325f08 "dev-sdd",
>    nr_pending = {
>      counter = 2 <<<<<
>    },
> 
> 3. From block layer, i can find the inflight IO for md superblock write 
> which has been pending 955s which matches with the hung time of 
> "md0_reclaim"
> 
> crash> 
> request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
> ffff888103b4c300
>    q = 0xffff888103a00d80,
>    mq_hctx = 0xffff888103c5d200,
>    cmd_flags = 38913,
>    rq_flags = 139408,
>    start_time_ns = 1504179024146,
>    bio = 0x0,
>    biotail = 0xffff888120758e40,
>    state = MQ_RQ_COMPLETE,
>    __data_len = 0,
>    flush = {
>      seq = 3, <<<< REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA
>      saved_end_io = 0x0
>    },
>    end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,
> 
> crash> p tk_core.timekeeper.tkr_mono.base
> $1 = 2459916243002
> crash> eval 2459916243002-1504179024146
> hexadecimal: de86609f28
>      decimal: 955737218856  <<<<<<< IO pending time is 955s
>        octal: 15720630117450
>       binary: 
> 0000000000000000000000001101111010000110011000001001111100101000
> 
> crash> bio.bi_iter,bi_end_io 0xffff888120758e40
>    bi_iter = {
>      bi_sector = 8, <<<< super block offset
>      bi_size = 0,
>      bi_idx = 0,
>      bi_bvec_done = 0
>    },
>    bi_end_io = 0xffffffff817dca50 <super_written>,
> crash> dev -d | grep ffff888103a00d80
>      8 ffff8881003ab000   sdd        ffff888103a00d80       0 0     0
> 
> 4. Check above request, even its state is "MQ_RQ_COMPLETE", but it is 
> still pending. That's because each md superblock write was marked with 
> REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 steps: pre_flush, 
> data, and post_flush. Once each step complete, it will be marked in 
> "request.flush.seq", here the value is 3, which is REQ_FSEQ_PREFLUSH | 
> REQ_FSEQ_DATA, so the last step "post_flush" has not be done.  Another 
> wired thing is that blk_flush_queue.flush_data_in_flight is still 1 even 
> "data" step already done.
> 
> crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
>    fq = 0xffff88810332e240,
> crash> blk_flush_queue 0xffff88810332e240
> struct blk_flush_queue {
>    mq_flush_lock = {
>      {
>        rlock = {
>          raw_lock = {
>            {
>              val = {
>                counter = 0
>              },
>              {
>                locked = 0 '\000',
>                pending = 0 '\000'
>              },
>              {
>                locked_pending = 0,
>                tail = 0
>              }
>            }
>          }
>        }
>      }
>    },
>    flush_pending_idx = 1,
>    flush_running_idx = 1,
>    rq_status = 0 '\000',
>    flush_pending_since = 4296171408,
>    flush_queue = {{
>        next = 0xffff88810332e250,
>        prev = 0xffff88810332e250
>      }, {
>        next = 0xffff888103b4c348, <<<< the request is in this list
>        prev = 0xffff888103b4c348
>      }},
>    flush_data_in_flight = 1,  >>>>>> still 1
>    flush_rq = 0xffff888103c2e000
> }
> 
> crash> list 0xffff888103b4c348
> ffff888103b4c348
> ffff88810332e260
> 
> crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of hw queue
>    tag = -1,
>    state = MQ_RQ_IDLE,
>    ref = {
>      counter = 0
>    },
> 
> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have 
> some issue which leading to the io request from md layer stayed in a 
> partial complete statue. I can't see how this can be related with the 
> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
> raid5d"")
> 
> 
> Dan,
> 
> Are you able to reproduce using some regular scsi disk, would like to 
> rule out whether this is related with virtio-scsi?
> 
> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
> official mainline v6.8-rc5 without any other patches?
> 
> 
> Thanks,
> 
> Junxiao.
> 
> On 2/23/24 6:13 PM, Song Liu wrote:
>> Hi,
>>
>> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>> On 21.02.24 00:06, Dan Moulding wrote:
>>>> Just a friendly reminder that this regression still exists on the
>>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>>> development system to 6.8-rc5 today and immediately hit this issue
>>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>>> Song Liu, what's the status here? I aware that you fixed with quite a
>>> few regressions recently, but it seems like resolving this one is
>>> stalled. Or were you able to reproduce the issue or make some progress
>>> and I just missed it?
>> Sorry for the delay with this issue. I have been occupied with some
>> other stuff this week.
>>
>> I haven't got luck to reproduce this issue. I will spend more time 
>> looking
>> into it next week.
>>
>>> And if not, what's the way forward here wrt to the release of 6.8?
>>> Revert the culprit and try again later? Or is that not an option for one
>>> reason or another?
>> If we don't make progress with it in the next week, we will do the 
>> revert,
>> same as we did with stable kernels.
>>
>>> Or do we assume that this is not a real issue? That it's caused by some
>>> oddity (bit-flip in the metadata or something like that?) only to be
>>> found in Dan's setup?
>> I don't think this is because of oddities. Hopefully we can get more
>> information about this soon.
>>
>> Thanks,
>> Song
>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>> -- 
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.
>>>
>>> #regzbot poke
>>>
> 
> .
> 


