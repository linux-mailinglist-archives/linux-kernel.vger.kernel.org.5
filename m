Return-Path: <linux-kernel+bounces-45685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D168843416
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322281C24432
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1BEAD3;
	Wed, 31 Jan 2024 02:41:18 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC79DF54;
	Wed, 31 Jan 2024 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668878; cv=none; b=Zm3ZZIeghSKv4eZvSXW4oE2ebP9uf61zHm2BPTAeRgMTagbBxfTV6K40F3d/1Ux+Ir4Bz9dPhZ93+HsdDgQvfmGITVw8bKNUmU1aSFIblXhjJ/lNd65b5GB0OE3dIbkqprUBYpuIbc6BwOv5W5ffoLwkVdKERxknzZpxNMCxtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668878; c=relaxed/simple;
	bh=f76r9FSif6orCVUFPbJBPziKnrykRQoTS3oHemcaB10=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aVhR27RqrDyaqTzy/h6SYdzqV3EWU8b4AliLlK7gU/5Rvqcht6R0hINMawu5Xxk0ScWIAKuoqYyTa1V2fgvSK05ODjg1WaZxJD6LHIiAnwz1TMff/xDVmWpZCwo72nLU9F598ctOyT05JAKSCF8Y9lWPpuDGOQMPAyCzBI10iQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPmW859MZz4f3kJv;
	Wed, 31 Jan 2024 10:41:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 43B101A027B;
	Wed, 31 Jan 2024 10:41:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFEs7llUeYGCg--.3062S3;
	Wed, 31 Jan 2024 10:41:09 +0800 (CST)
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Blazej Kucman <blazej.kucman@linux.intel.com>, Dan Moulding <dan@danm.net>
Cc: carlos@fisica.ufpr.br, gregkh@linuxfoundation.org, junxiao.bi@oracle.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, song@kernel.org, stable@vger.kernel.org,
 yukuai1@huaweicloud.com, "yukuai (C)" <yukuai3@huawei.com>
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
 <20240126154610.24755-1-dan@danm.net>
 <20240130172524.0000417b@linux.intel.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <95f2e08e-2daf-e298-e696-42ebfa7b9bbf@huaweicloud.com>
Date: Wed, 31 Jan 2024 10:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240130172524.0000417b@linux.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFEs7llUeYGCg--.3062S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr45Gr1DGr4UJw1fCw1ftFb_yoW7Zw17pF
	4Fqa4akw4rWFyUJ3WUA34qgFy5Ka1YvF97JrZ7K3s7AF1qkwnrX3WrtFWUXFy7Gr15Zw17
	ZFyDua1Utr1ktaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Blazej!

ÔÚ 2024/01/31 0:26, Blazej Kucman Ð´µÀ:
> Hi,
> 
> On Fri, 26 Jan 2024 08:46:10 -0700
> Dan Moulding <dan@danm.net> wrote:
>>
>> That's a good suggestion, so I switched it to use XFS. It can still
>> reproduce the hang. Sounds like this is probably a different problem
>> than the known ext4 one.
>>
> 
> Our daily tests directed at mdadm/md also detected a problem with
> identical symptoms as described in the thread.
> 
> Issue detected with IMSM metadata but it also reproduces with native
> metadata.
> NVMe disks under VMD controller were used.
> 
> Scenario:
> 1. Create raid10:
> mdadm --create /dev/md/r10d4s128-15_A --level=10 --chunk=128
> --raid-devices=4 /dev/nvme6n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme0n1
> --size=7864320 --run
> 2. Create FS
> mkfs.ext4 /dev/md/r10d4s128-15_A
> 3. Set faulty one raid member:
> mdadm --set-faulty /dev/md/r10d4s128-15_A /dev/nvme3n1
> 4. Stop raid devies:
> mdadm -Ss
> 
> Expected result:
> The raid stops without kernel hangs and errors.
> 
> Actual result:
> command "mdadm -Ss" hangs,
> hung_task occurs in OS.

Can you test the following patch?

Thanks!
Kuai

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e3a56a958b47..a8db84c200fe 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -578,8 +578,12 @@ static void submit_flushes(struct work_struct *ws)
                         rcu_read_lock();
                 }
         rcu_read_unlock();
-       if (atomic_dec_and_test(&mddev->flush_pending))
+       if (atomic_dec_and_test(&mddev->flush_pending)) {
+               /* The pair is percpu_ref_get() from md_flush_request() */
+               percpu_ref_put(&mddev->active_io);
+
                 queue_work(md_wq, &mddev->flush_work);
+       }
  }

  static void md_submit_flush_data(struct work_struct *ws)

> 
> [   62.770472] md: resync of RAID array md127
> [  140.893329] md: md127: resync done.
> [  204.100490] md/raid10:md127: Disk failure on nvme3n1, disabling
> device. md/raid10:md127: Operation continuing on 3 devices.
> [  244.625393] INFO: task kworker/48:1:755 blocked for more than 30
> seconds. [  244.632294]       Tainted: G S
> 6.8.0-rc1-20240129.intel.13479453+ #1 [  244.640157] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 244.648105] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
>    ppid:2      flags:0x00004000 [  244.657552] Workqueue: md_misc
> md_start_sync [md_mod] [  244.662688] Call Trace: [  244.665176]  <TASK>
> [  244.667316]  __schedule+0x2f0/0x9c0
> [  244.670868]  ? sched_clock+0x10/0x20
> [  244.674510]  schedule+0x28/0x90
> [  244.677703]  mddev_suspend+0x11d/0x1e0 [md_mod]
> [  244.682313]  ? __update_idle_core+0x29/0xc0
> [  244.686574]  ? swake_up_all+0xe0/0xe0
> [  244.690302]  md_start_sync+0x3c/0x280 [md_mod]
> [  244.694825]  process_scheduled_works+0x87/0x320
> [  244.699427]  worker_thread+0x147/0x2a0
> [  244.703237]  ? rescuer_thread+0x2d0/0x2d0
> [  244.707313]  kthread+0xe5/0x120
> [  244.710504]  ? kthread_complete_and_exit+0x20/0x20
> [  244.715370]  ret_from_fork+0x31/0x40
> [  244.719007]  ? kthread_complete_and_exit+0x20/0x20
> [  244.723879]  ret_from_fork_asm+0x11/0x20
> [  244.727872]  </TASK>
> [  244.730117] INFO: task mdadm:8457 blocked for more than 30 seconds.
> [  244.736486]       Tainted: G S
> 6.8.0-rc1-20240129.intel.13479453+ #1 [  244.744345] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 244.752293] task:mdadm           state:D stack:13512 pid:8457
> tgid:8457  ppid:8276   flags:0x00000000 [  244.761736] Call Trace: [
> 244.764241]  <TASK> [  244.766389]  __schedule+0x2f0/0x9c0
> [  244.773224]  schedule+0x28/0x90
> [  244.779690]  stop_sync_thread+0xfa/0x170 [md_mod]
> [  244.787737]  ? swake_up_all+0xe0/0xe0
> [  244.794705]  do_md_stop+0x51/0x4c0 [md_mod]
> [  244.802166]  md_ioctl+0x59d/0x10a0 [md_mod]
> [  244.809567]  blkdev_ioctl+0x1bb/0x270
> [  244.816417]  __x64_sys_ioctl+0x7a/0xb0
> [  244.823720]  do_syscall_64+0x4e/0x110
> [  244.830481]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  244.838700] RIP: 0033:0x7f2c540c97cb
> [  244.845457] RSP: 002b:00007fff4ad6a8f8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010 [  244.856265] RAX: ffffffffffffffda RBX:
> 0000000000000003 RCX: 00007f2c540c97cb [  244.866659] RDX:
> 0000000000000000 RSI: 0000000000000932 RDI: 0000000000000003 [
> 244.877031] RBP: 0000000000000019 R08: 0000000000200000 R09:
> 00007fff4ad6a4c5 [  244.887382] R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fff4ad6a9c0 [  244.897723] R13:
> 00007fff4ad6a9a0 R14: 000055724d0990e0 R15: 000055724efaa780 [
> 244.908018]  </TASK> [  275.345375] INFO: task kworker/48:1:755 blocked
> for more than 60 seconds. [  275.355363]       Tainted: G S
>      6.8.0-rc1-20240129.intel.13479453+ #1 [  275.366306] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message. [
> 275.377334] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
>    ppid:2      flags:0x00004000 [  275.389863] Workqueue: md_misc
> md_start_sync [md_mod] [  275.398102] Call Trace: [  275.403673]  <TASK>
> 
> 
> Also reproduces with XFS FS, does not reproduce when there is no FS on
> RAID.
> 
> Repository used for testing:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> Branch: master
> 
> Last working build: kernel branch HEAD: acc657692aed ("keys, dns: Fix
> size check of V1 server-list header")
> 
> I see one merge commit touching md after the above one:
> 01d550f0fcc0 ("Merge tag 'for-6.8/block-2024-01-08' of
> git://git.kernel.dk/linux")
> 
> I hope these additional logs will help find the cause.
> 
> Thanks,
> Blazej
> 
> 
> .
> 


