Return-Path: <linux-kernel+bounces-51161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC10848737
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B161C1C2155E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03E5F556;
	Sat,  3 Feb 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/KixfTk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC65F541;
	Sat,  3 Feb 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975260; cv=none; b=icHGwknTIXeHkgFNg7mlZMmwbxYSiCYk59G3mzrhgEzZwj4zeI3KKow3dKBW3TVu8xRknXvWcGSxq++VGrDsW7LdhEyuGWi/6tNpBaP8lUleD6knQ0pPKBPpiU0k5BLSsc2VSn2ia3zoZ6HpgbuLjgn3OVXguOhFcZItbU1M8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975260; c=relaxed/simple;
	bh=FdSFBTe2mH/CETNqoGpiNaQFDRF7hVi4nwjoi22gR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hEa0UnlUU2eyeJiiyzyvtw/2Vgx5OTYpJBquyBMCDEoqq7H8eu1oWPVmoT36J9DfKVx47PAz1Nz8qSG3GO5E0OGFdQkxUfAeboUEMhqma1deMVNkgUCIn72yoWyXPAg3lfQu1hB1btWmkTeCYP2HK/5KSVQSbc35ooagJ7Ifyo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/KixfTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E91EC433C7;
	Sat,  3 Feb 2024 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706975260;
	bh=FdSFBTe2mH/CETNqoGpiNaQFDRF7hVi4nwjoi22gR8M=;
	h=From:To:Cc:Subject:Date:From;
	b=J/KixfTkiQLcg85zXo7hEw2HNaO7s0tvsbnDwtcYTL3AIshaR4s7PAagp5SN7FQfi
	 BKLE6j6eps8RIHN1wwNAawngFuAel40dCMrToaBfvd1QOVlEcwBilsXlP3GylEg7ew
	 O2m/KItnC2z+JcbEWog1DCI/oO+31jSdWVh8nSA0DQShTLzMMf+0ZmZxcGNuO7kRyE
	 KXHrOuBwdACMssYvmsLIZBr1QB4YVFSX06XgyWRuJ4vSNdOdJcodXTEPxc4jG4BFeo
	 VPQPU6wbAGnyNfdnsQW7M2B+fXm1rPQ5H726BfCGtOoJlkn0f0nC3/nvhQ2hPwBE1e
	 7ei4LIls3qynw==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Subject: [BUG REPORT] workqueue: Hung task reported when executing
 generic/001 on XFS on next-20240202
Date: Sat, 03 Feb 2024 21:09:14 +0530
Message-ID: <87o7cxeehy.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Executing generic/001 test on XFS on a machine running next-20240201 kernel
causes the following hung task to occur,

    INFO: task umount:6305 blocked for more than 122 seconds.
          Not tainted 6.8.0-rc2-next-20240202 #17
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    task:umount          state:D stack:13008 pid:6305  tgid:6305  ppid:6301   flags:0x00004000
    Call Trace:
     <TASK>
     __schedule+0x2f6/0xa20
     schedule+0x36/0xb0
     schedule_timeout+0x20b/0x280
     ? srso_return_thunk+0x5/0x5f
     ? irq_work_queue+0x40/0x60
     ? srso_return_thunk+0x5/0x5f
     ? __wake_up_klogd.part.0+0x5a/0x80
     wait_for_completion+0x8a/0x140
     __flush_workqueue+0x11a/0x3b0
     xfs_inodegc_flush+0x24/0xf0
     xfs_unmountfs+0x14/0x180
     xfs_fs_put_super+0x3d/0x90
     generic_shutdown_super+0x7c/0x160
     kill_block_super+0x1b/0x40
     xfs_kill_sb+0x12/0x30
     deactivate_locked_super+0x35/0x90
     deactivate_super+0x42/0x50
     cleanup_mnt+0x109/0x170
     __cleanup_mnt+0x12/0x20
     task_work_run+0x60/0x90
     syscall_exit_to_user_mode+0x146/0x150
     do_syscall_64+0x5d/0x110
     entry_SYSCALL_64_after_hwframe+0x6c/0x74
    RIP: 0033:0x7f13c103b38b
    RSP: 002b:00007fff161aeff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
    RAX: 0000000000000000 RBX: 00007f13c116d204 RCX: 00007f13c103b38b
    RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000055964eda0030
    RBP: 000055964ed99310 R08: 0000000000000000 R09: 00007fff161adda0
    R10: 00007f13c1159379 R11: 0000000000000246 R12: 000055964eda0030
    R13: 0000000000000000 R14: 000055964ed99408 R15: 000055964ed99520

Git bisect revealed the following as the bad commit,

dd6c3c5441263723305a9c52c5ccc899a4653000 is the first bad commit
commit dd6c3c5441263723305a9c52c5ccc899a4653000
Author: Tejun Heo <tj@kernel.org>
Date:   Mon Jan 29 08:11:24 2024 -1000

    workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
    
    The planned shared nr_active handling for unbound workqueues will make
    pwq_dec_nr_active() sometimes drop the pool lock temporarily to acquire
    other pool locks, which is necessary as retirement of an nr_active count
    from one pool may need kick off an inactive work item in another pool.
    
    This patch moves pwq_dec_nr_in_flight() call in try_to_grab_pending() to the
    end of work item handling so that work item state changes stay atomic.
    process_one_work() which is the other user of pwq_dec_nr_in_flight() already
    calls it at the end of work item handling. Comments are added to both call
    sites and pwq_dec_nr_in_flight().
    
    This shouldn't cause any behavior changes.
    
    Signed-off-by: Tejun Heo <tj@kernel.org>
    Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

 kernel/workqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Here is the full git bisect log,
# bad: [076d56d74f17e625b3d63cf4743b3d7d02180379] Add linux-next specific files for 20240202
# good: [881f78f472556ed05588172d5b5676b48dc48240] xfs: remove conditional building of rt geometry validator functions
git bisect start 'HEAD' '881f78f47255' 'fs/'
# good: [50673a33b8dc743777e79d7206acdc8d64452498] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good 50673a33b8dc743777e79d7206acdc8d64452498
# good: [717a7216eaa84233dc70498db3e92989153fa444] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
git bisect good 717a7216eaa84233dc70498db3e92989153fa444
# bad: [e6ead6ea890b2c2df0faf62ca2da15392cdc4165] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect bad e6ead6ea890b2c2df0faf62ca2da15392cdc4165
# good: [be364bf6099dc52d26ce25e2996fa2a04502a890] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good be364bf6099dc52d26ce25e2996fa2a04502a890
# good: [b043e7f00dfd9def840c03a8eb1cb56b0def4db9] Merge branch 'next' of https://github.com/kvm-x86/linux.git
git bisect good b043e7f00dfd9def840c03a8eb1cb56b0def4db9
# bad: [6806f880feafd5a565f00714f2f6254e7c80e961] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect bad 6806f880feafd5a565f00714f2f6254e7c80e961
# bad: [6e50cdc4feb87e269649adb2c7498ce98fcf458c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect bad 6e50cdc4feb87e269649adb2c7498ce98fcf458c
# good: [c5404d4e6df6faba1007544b5f4e62c7c14416dd] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
git bisect good c5404d4e6df6faba1007544b5f4e62c7c14416dd
# bad: [15930da42f8981dc42c19038042947b475b19f47] workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
git bisect bad 15930da42f8981dc42c19038042947b475b19f47
# bad: [91ccc6e7233bb10a9c176aa4cc70d6f432a441a5] workqueue: Introduce struct wq_node_nr_active
git bisect bad 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5
# bad: [dd6c3c5441263723305a9c52c5ccc899a4653000] workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
git bisect bad dd6c3c5441263723305a9c52c5ccc899a4653000
# good: [9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab] workqueue: RCU protect wq->dfl_pwq and implement accessors for it
git bisect good 9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab
# first bad commit: [dd6c3c5441263723305a9c52c5ccc899a4653000] workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling

-- 
Chandan

