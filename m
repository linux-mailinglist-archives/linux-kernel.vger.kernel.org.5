Return-Path: <linux-kernel+bounces-166430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9958B9A96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E852C284A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455D77F13;
	Thu,  2 May 2024 12:15:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABF8D26A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652156; cv=none; b=CruAyq0Q43ZlJcJY9RlBnTTT+s35/xM4nF80ynBPQspK31pfqmUF4HRoGBYl5yIHcrmgF8QKgPHLiM/QETCkQHALj1h1WQ/JG/krRzL64dkK669Mi/S/Qc1tUsmHHj5o/AqrF90KM15Q+4g34l+Rdd+x7BKmrmPdLMOYutZDe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652156; c=relaxed/simple;
	bh=cCqtpdvGnTVJ9cgtHreh97DKvcxJ895O323AwA3hz60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LFqCLB38BBOWTcp2h6BJ5/fHhQVszvOv/1pOto4xpykZEVnbh87FXeeadFAuF8p5YrIVw5rpI2R2WCTYk52fxG8jss3S3ZyoME+bgSQrw1YJqQyRWCJ1xon1vB17vBX1k1UDxjI4Osdje9IPgkNQw2W5rUGyPO/i5VEVA+2Y0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61748C113CC;
	Thu,  2 May 2024 12:15:55 +0000 (UTC)
Date: Thu, 2 May 2024 08:16:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alex Constantino
 <dreaming.about.electric.sheep@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Timo Lindfors <timo.lindfors@iki.fi>, Dave Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-ID: <20240502081641.457aa25f@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I went to run my tests on my VMs and the tests hung on boot up.
Unfortunately, the most I ever got out was:

[   93.607888] Testing event system initcall: OK
[   93.667730] Running tests on all trace events:
[   93.669757] Testing all events: OK
[   95.631064] ------------[ cut here ]------------
Timed out after 60 seconds

I ran a bisect and it came up with:

 # first bad commit: [07ed11afb68d94eadd4ffc082b97c2331307c5ea] Revert "drm/qxl: simplify qxl_fence_wait"

I checked out 07ed11afb68d94eadd4ffc082b97c2331307c5ea~1 and it booted
fine. Added back that commit, it failed to boot. I did this twice, and got
the same results.

But the last time I ran it, it did trigger this:

 ------------[ cut here ]------------
 
 ======================================================
 WARNING: possible circular locking dependency detected
 6.9.0-rc1-test-00021-g07ed11afb68d #5 Not tainted
 ------------------------------------------------------
 kworker/u24:3/119 is trying to acquire lock:
 ffffffff95aa4600 (console_owner){....}-{0:0}, at: console_flush_all+0x1f5/0x530
 
 but task is already holding lock:
 ffff93c4bbd37218 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0xc1/0x440
 
 which lock already depends on the new lock.
 
 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (&pool->lock){-.-.}-{2:2}:
        _raw_spin_lock+0x33/0x40
        __queue_work+0xd6/0x610
        queue_work_on+0x8a/0x90
        soft_cursor+0x1a0/0x230
        bit_cursor+0x386/0x5f0
        hide_cursor+0x27/0xb0
        vt_console_print+0x474/0x490
        console_flush_all+0x22e/0x530
        console_unlock+0x56/0x160
        vprintk_emit+0x160/0x390
        dev_printk_emit+0xa5/0xd0
        _dev_info+0x79/0xa0
        __drm_fb_helper_initial_config_and_unlock+0x3a9/0x5f0
        drm_fbdev_generic_client_hotplug+0x69/0xc0
        drm_client_register+0x7b/0xc0
        qxl_pci_probe+0x107/0x1a0
        local_pci_probe+0x45/0xa0
        pci_device_probe+0xc7/0x240
        really_probe+0xd6/0x390
        __driver_probe_device+0x78/0x150
        driver_probe_device+0x1f/0x90
        __driver_attach+0xd6/0x1d0
        bus_for_each_dev+0x8f/0xe0
        bus_add_driver+0x119/0x220
        driver_register+0x59/0x100
        do_one_initcall+0x76/0x3c0
        kernel_init_freeable+0x3a5/0x5b0
        kernel_init+0x1a/0x1c0
        ret_from_fork+0x34/0x50
        ret_from_fork_asm+0x1a/0x30
 
 -> #0 (console_owner){....}-{0:0}:
        __lock_acquire+0x13e7/0x2180
        lock_acquire+0xd9/0x300
        console_flush_all+0x212/0x530
        console_unlock+0x56/0x160
        vprintk_emit+0x160/0x390
        _printk+0x64/0x80
        __warn_printk+0x8e/0x180
        check_flush_dependency+0xfd/0x120
        __flush_work+0xfa/0x440
        qxl_queue_garbage_collect+0x83/0x90
        qxl_fence_wait+0xa4/0x1a0
        dma_fence_wait_timeout+0x98/0x1e0
        dma_resv_wait_timeout+0x7f/0xe0
        ttm_bo_delayed_delete+0x2b/0x90
        process_one_work+0x228/0x740
        worker_thread+0x1dc/0x3c0
        kthread+0xf2/0x120
        ret_from_fork+0x34/0x50
        ret_from_fork_asm+0x1a/0x30
 
 other info that might help us debug this:
 
  Possible unsafe locking scenario:
 
        CPU0                    CPU1
        ----                    ----
   lock(&pool->lock);
                                lock(console_owner);
                                lock(&pool->lock);
   lock(console_owner);
 
  *** DEADLOCK ***
 
 6 locks held by kworker/u24:3/119:
  #0: ffff93c440245948 ((wq_completion)ttm){+.+.}-{0:0}, at: process_one_work+0x43a/0x740
  #1: ffffa01380d83e60 ((work_completion)(&bo->delayed_delete)){+.+.}-{0:0}, at: process_one_work+0x1e2/0x740
  #2: ffffffff95b17880 (rcu_read_lock){....}-{1:2}, at: __flush_work+0x86/0x440
  #3: ffff93c4bbd37218 (&pool->lock){-.-.}-{2:2}, at: __flush_work+0xc1/0x440
  #4: ffffffff95b149c0 (console_lock){+.+.}-{0:0}, at: _printk+0x64/0x80
  #5: ffffffff95b14a10 (console_srcu){....}-{0:0}, at: console_flush_all+0x7b/0x530
 
 stack backtrace:
 CPU: 2 PID: 119 Comm: kworker/u24:3 Not tainted 6.9.0-rc1-test-00021-g07ed11afb68d #5
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Workqueue: ttm ttm_bo_delayed_delete
 Call Trace:
  <TASK>
  dump_stack_lvl+0x77/0xb0
  check_noncircular+0x148/0x160
  __lock_acquire+0x13e7/0x2180
  lock_acquire+0xd9/0x300
  ? console_flush_all+0x1f5/0x530
  ? lock_release+0x147/0x2c0
  ? console_flush_all+0x1f5/0x530
  console_flush_all+0x212/0x530
  ? console_flush_all+0x1f5/0x530
  console_unlock+0x56/0x160
  vprintk_emit+0x160/0x390
  _printk+0x64/0x80
  ? __pfx_ttm_bo_delayed_delete+0x10/0x10
  ? __pfx_qxl_gc_work+0x10/0x10
  __warn_printk+0x8e/0x180
  ? __pfx_ttm_bo_delayed_delete+0x10/0x10
  ? __pfx_qxl_gc_work+0x10/0x10
  ? __pfx_qxl_gc_work+0x10/0x10
  check_flush_dependency+0xfd/0x120
  __flush_work+0xfa/0x440
  qxl_queue_garbage_collect+0x83/0x90
  qxl_fence_wait+0xa4/0x1a0
  dma_fence_wait_timeout+0x98/0x1e0
  dma_resv_wait_timeout+0x7f/0xe0
  ttm_bo_delayed_delete+0x2b/0x90
  process_one_work+0x228/0x740
  worker_thread+0x1dc/0x3c0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xf2/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 workqueue: WQ_MEM_RECLAIM ttm:ttm_bo_delayed_delete is flushing !WQ_MEM_RECLAIM events:qxl_gc_work
 WARNING: CPU: 2 PID: 119 at kernel/workqueue.c:3728 check_flush_dependency+0xfd/0x120
 Modules linked in:
 CPU: 2 PID: 119 Comm: kworker/u24:3 Not tainted 6.9.0-rc1-test-00021-g07ed11afb68d #5
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Workqueue: ttm ttm_bo_delayed_delete
 RIP: 0010:check_flush_dependency+0xfd/0x120
 Code: 8b 45 18 48 8d b2 70 01 00 00 49 89 e8 48 8d 8b 70 01 00 00 48 c7 c7 60 46 7b 95 c6 05 48 67 d2 01 01 48 89 c2 e8 63 40 fd ff <0f> 0b e9 1e ff ff ff 80 3d 33 67 d2 01 00 75 93 e9 4a ff ff ff 66
 RSP: 0000:ffffa01380d83c28 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: ffff93c44004ee00 RCX: 0000000000000000
 RDX: 0000000080000003 RSI: 00000000ffffefff RDI: 0000000000000001
 RBP: ffffffff9497b100 R08: 0000000000000000 R09: 0000000000000003
 R10: ffffa01380d83ab8 R11: ffffffff95b14828 R12: ffff93c443980000
 R13: ffff93c440fbe300 R14: 0000000000000001 R15: ffff93c44004ee00
 FS:  0000000000000000(0000) GS:ffff93c4bbd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000007c864001 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  ? __warn+0x8c/0x180
  ? check_flush_dependency+0xfd/0x120
  ? report_bug+0x191/0x1c0
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x3c/0x80
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __pfx_qxl_gc_work+0x10/0x10
  ? check_flush_dependency+0xfd/0x120
  ? check_flush_dependency+0xfd/0x120
  __flush_work+0xfa/0x440
  qxl_queue_garbage_collect+0x83/0x90
  qxl_fence_wait+0xa4/0x1a0
  dma_fence_wait_timeout+0x98/0x1e0
  dma_resv_wait_timeout+0x7f/0xe0
  ttm_bo_delayed_delete+0x2b/0x90
  process_one_work+0x228/0x740
  worker_thread+0x1dc/0x3c0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xf2/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 irq event stamp: 58
 hardirqs last  enabled at (57): [<ffffffff93fede30>] queue_work_on+0x60/0x90
 hardirqs last disabled at (58): [<ffffffff94ea7f66>] _raw_spin_lock_irq+0x56/0x60
 softirqs last  enabled at (0): [<ffffffff93fbae27>] copy_process+0xc07/0x2c60
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace 0000000000000000 ]---

So there's an issue with dma_fence and a workqueue.

-- Steve


