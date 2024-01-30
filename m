Return-Path: <linux-kernel+bounces-44947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4084294F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5FE290843
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7412839E;
	Tue, 30 Jan 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEcHNim4"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9171272DA;
	Tue, 30 Jan 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632030; cv=none; b=PZV7t3vOsVPoKqOCI9slIQLB2zAJMG9PWCLXf/7TLVK23I0QCRzFSLF2Ip8myr77vGwivIlba1ByuQ3bla05aZB89gkde169k59R7xkSIznv97ue/UTxhXepaM8ECCHcJW00t85DlnN5OkSDKMuwX5dG6e8CBRfX4VLDRavqQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632030; c=relaxed/simple;
	bh=Xhy5dTzM5pYWGYn7r4MmIzfnYcet4+S4Czcim/bFPpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkrzcIsglT7rf1+C57AwdFeOnMGEV0WA8ZG1D6n5YE5YEFPnpjUbgvCD6TdrZPjWcvzjos5ud1TGSY2c8J2lVmcS7pO/z0dpRUTdgn55BpUlKS+IK1Jfhoqz7q1t0gmEdEYVNLY7yG0tzuHEgOBhtuQCZpgu44G5t74X9+62KIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEcHNim4; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706632028; x=1738168028;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xhy5dTzM5pYWGYn7r4MmIzfnYcet4+S4Czcim/bFPpo=;
  b=dEcHNim4Yt/duVj5TbRoVB0dlbmjMUP5tYLZ6NeokniKgdnx7FdDMXVP
   KScBx18HZk2xAhUAEXQkG8eLv820SdrvmYjQuLTFiyt6SeUU0ciWyHCpW
   SFJTcfJEACkSW84Lz3o4RgacZwssqnF0oCfcBQM92oYMe0KEFb3CIFHi9
   sAR1XRLGkAP9tJvFGozuSMkQ60dw6o3IPu5IxfI9pDRKNMJApM1tNFjM0
   2S7AvBaQ0mWursMY5l6NqC4eDScxZ/9n6oE/pUby3Z0WDyVk+f6FPlvNx
   j7QSjshwHcExs/g5yyGMbGM41nG6C/m8jUdUOvabiiDAFNyo7t/gpyFuh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402953268"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="402953268"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119316760"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119316760"
Received: from bkucman-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.48.222])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:27:04 -0800
Date: Tue, 30 Jan 2024 17:26:59 +0100
From: Blazej Kucman <blazej.kucman@linux.intel.com>
To: Dan Moulding <dan@danm.net>
Cc: carlos@fisica.ufpr.br, gregkh@linuxfoundation.org,
 junxiao.bi@oracle.com, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, regressions@lists.linux.dev, song@kernel.org,
 stable@vger.kernel.org, yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Message-ID: <20240130172524.0000417b@linux.intel.com>
In-Reply-To: <20240126154610.24755-1-dan@danm.net>
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
 <20240126154610.24755-1-dan@danm.net>
Organization: intel
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 26 Jan 2024 08:46:10 -0700
Dan Moulding <dan@danm.net> wrote: 
> 
> That's a good suggestion, so I switched it to use XFS. It can still
> reproduce the hang. Sounds like this is probably a different problem
> than the known ext4 one.
> 

Our daily tests directed at mdadm/md also detected a problem with
identical symptoms as described in the thread.

Issue detected with IMSM metadata but it also reproduces with native
metadata.
NVMe disks under VMD controller were used.

Scenario:
1. Create raid10:
mdadm --create /dev/md/r10d4s128-15_A --level=10 --chunk=128
--raid-devices=4 /dev/nvme6n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme0n1
--size=7864320 --run
2. Create FS
mkfs.ext4 /dev/md/r10d4s128-15_A
3. Set faulty one raid member:
mdadm --set-faulty /dev/md/r10d4s128-15_A /dev/nvme3n1
4. Stop raid devies:
mdadm -Ss

Expected result:
The raid stops without kernel hangs and errors.

Actual result:
command "mdadm -Ss" hangs,
hung_task occurs in OS.

[   62.770472] md: resync of RAID array md127
[  140.893329] md: md127: resync done.
[  204.100490] md/raid10:md127: Disk failure on nvme3n1, disabling
device. md/raid10:md127: Operation continuing on 3 devices.
[  244.625393] INFO: task kworker/48:1:755 blocked for more than 30
seconds. [  244.632294]       Tainted: G S
6.8.0-rc1-20240129.intel.13479453+ #1 [  244.640157] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message. [
244.648105] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
  ppid:2      flags:0x00004000 [  244.657552] Workqueue: md_misc
md_start_sync [md_mod] [  244.662688] Call Trace: [  244.665176]  <TASK>
[  244.667316]  __schedule+0x2f0/0x9c0
[  244.670868]  ? sched_clock+0x10/0x20
[  244.674510]  schedule+0x28/0x90
[  244.677703]  mddev_suspend+0x11d/0x1e0 [md_mod]
[  244.682313]  ? __update_idle_core+0x29/0xc0
[  244.686574]  ? swake_up_all+0xe0/0xe0
[  244.690302]  md_start_sync+0x3c/0x280 [md_mod]
[  244.694825]  process_scheduled_works+0x87/0x320
[  244.699427]  worker_thread+0x147/0x2a0
[  244.703237]  ? rescuer_thread+0x2d0/0x2d0
[  244.707313]  kthread+0xe5/0x120
[  244.710504]  ? kthread_complete_and_exit+0x20/0x20
[  244.715370]  ret_from_fork+0x31/0x40
[  244.719007]  ? kthread_complete_and_exit+0x20/0x20
[  244.723879]  ret_from_fork_asm+0x11/0x20
[  244.727872]  </TASK>
[  244.730117] INFO: task mdadm:8457 blocked for more than 30 seconds.
[  244.736486]       Tainted: G S
6.8.0-rc1-20240129.intel.13479453+ #1 [  244.744345] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message. [
244.752293] task:mdadm           state:D stack:13512 pid:8457
tgid:8457  ppid:8276   flags:0x00000000 [  244.761736] Call Trace: [
244.764241]  <TASK> [  244.766389]  __schedule+0x2f0/0x9c0
[  244.773224]  schedule+0x28/0x90
[  244.779690]  stop_sync_thread+0xfa/0x170 [md_mod]
[  244.787737]  ? swake_up_all+0xe0/0xe0
[  244.794705]  do_md_stop+0x51/0x4c0 [md_mod]
[  244.802166]  md_ioctl+0x59d/0x10a0 [md_mod]
[  244.809567]  blkdev_ioctl+0x1bb/0x270
[  244.816417]  __x64_sys_ioctl+0x7a/0xb0
[  244.823720]  do_syscall_64+0x4e/0x110
[  244.830481]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  244.838700] RIP: 0033:0x7f2c540c97cb
[  244.845457] RSP: 002b:00007fff4ad6a8f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010 [  244.856265] RAX: ffffffffffffffda RBX:
0000000000000003 RCX: 00007f2c540c97cb [  244.866659] RDX:
0000000000000000 RSI: 0000000000000932 RDI: 0000000000000003 [
244.877031] RBP: 0000000000000019 R08: 0000000000200000 R09:
00007fff4ad6a4c5 [  244.887382] R10: 0000000000000000 R11:
0000000000000246 R12: 00007fff4ad6a9c0 [  244.897723] R13:
00007fff4ad6a9a0 R14: 000055724d0990e0 R15: 000055724efaa780 [
244.908018]  </TASK> [  275.345375] INFO: task kworker/48:1:755 blocked
for more than 60 seconds. [  275.355363]       Tainted: G S
    6.8.0-rc1-20240129.intel.13479453+ #1 [  275.366306] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message. [
275.377334] task:kworker/48:1    state:D stack:14592 pid:755   tgid:755
  ppid:2      flags:0x00004000 [  275.389863] Workqueue: md_misc
md_start_sync [md_mod] [  275.398102] Call Trace: [  275.403673]  <TASK>


Also reproduces with XFS FS, does not reproduce when there is no FS on
RAID.

Repository used for testing:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
Branch: master

Last working build: kernel branch HEAD: acc657692aed ("keys, dns: Fix
size check of V1 server-list header")

I see one merge commit touching md after the above one:
01d550f0fcc0 ("Merge tag 'for-6.8/block-2024-01-08' of
git://git.kernel.dk/linux")

I hope these additional logs will help find the cause.

Thanks,
Blazej


