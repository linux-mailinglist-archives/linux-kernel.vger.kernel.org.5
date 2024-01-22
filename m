Return-Path: <linux-kernel+bounces-34282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F6837766
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0912833DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CC239842;
	Mon, 22 Jan 2024 23:04:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8C4A988
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964678; cv=none; b=Gjzxdm5g2E2U63YWz9oNwXUsX5Fv1L8AzG8jnJfo267AMOJrznAOR+H+ul2muMPvTQtnJSZAj4BGd0qtF2WxfwJ3+HemrVXhSEVpaFZjeoB0hdz8uQ8utrHqjVAI5oEdZn9XlgYoB0+Daw8WoM611VLCPGW0dAMess4v649YmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964678; c=relaxed/simple;
	bh=eV/1PBpFY/w9xfh1oc7d6hhOkwniusf4d5foreVSHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cxvc8/TdphiYv+2/xMPJrYBMb6I/qgYi3Hsr9pPahlZJ+pLxsOi2lMnvK04H3mkmvq2fVm3dhbIyHAZDzqVmpfN6fWBX40vOi4dSqgqoycg/wspxTAfh6gsIj3DOzQOmrEPW99qyMQ9nOmFD5bWPOKECrv00eFVfDCMwLGt28yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F1C433F1;
	Mon, 22 Jan 2024 23:04:36 +0000 (UTC)
Date: Mon, 22 Jan 2024 18:06:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [BUG]  BUG: kernel NULL pointer dereference at ttm_device_init+0xb4
Message-ID: <20240122180605.28daf23a@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I just kicked off testing some patches on top of 6.8-rc1 and triggered this
immediately:

[ note this happened on both my 32 bit an 64 bit test machines, this is
  just the 32 bit output ]

 BUG: kernel NULL pointer dereference, address: 00000238
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc1-test-00001-g2b44760609e9-dirty #1056
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 Workqueue: events work_for_cpu_fn
 EIP: ttm_device_init+0xb4/0x274
 Code: 86 10 09 00 00 83 c4 0c 85 c0 0f 84 96 01 00 00 8b 45 ac 8d 9e 94 00 00 00 89 46 08 89 f0 e8 27 05 00 00 8b 55 a8 0f b6 45 98 <8b> 8a 38 02 00 00 50 0f b6 45 9c 50 89 d8 e8 95 ee ff ff 8b 45 a0
 EAX: 00000000 EBX: c135a7e4 ECX: c135a7b0 EDX: 00000000
 ESI: c135a750 EDI: 0007bc1d EBP: c11d7e4c ESP: c11d7de4
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
 CR0: 80050033 CR2: 00000238 CR3: 145c4000 CR4: 000006f0
 Call Trace:
  ? show_regs+0x4f/0x58
  ? __die+0x1d/0x58
  ? page_fault_oops+0x171/0x330
  ? lock_acquire+0xa4/0x280
  ? kernelmode_fixup_or_oops.constprop.0+0x7c/0xcc
  ? __bad_area_nosemaphore.constprop.0+0x124/0x1b4
  ? __mutex_lock+0x17f/0xb00
  ? bad_area_nosemaphore+0xf/0x14
  ? do_user_addr_fault+0x140/0x3e4
  ? exc_page_fault+0x5b/0x1d8
  ? pvclock_clocksource_read_nowd+0x130/0x130
  ? handle_exception+0x133/0x133
  ? pvclock_clocksource_read_nowd+0x130/0x130
  ? ttm_device_init+0xb4/0x274
  ? pvclock_clocksource_read_nowd+0x130/0x130
  ? ttm_device_init+0xb4/0x274
  qxl_ttm_init+0x34/0x130
  qxl_bo_init+0xd/0x10
  qxl_device_init+0x52a/0x92c
  qxl_pci_probe+0x91/0x1ac
  local_pci_probe+0x3d/0x84
  work_for_cpu_fn+0x16/0x20
  process_one_work+0x1bc/0x4a0
  worker_thread+0x310/0x3a8
  kthread+0xea/0x110
  ? rescuer_thread+0x2f0/0x2f0
  ? kthread_complete_and_exit+0x1c/0x1c
  ret_from_fork+0x34/0x4c
  ? kthread_complete_and_exit+0x1c/0x1c
  ret_from_fork_asm+0x12/0x18
  entry_INT80_32+0xf0/0xf0
 Modules linked in:
 CR2: 0000000000000238
 ---[ end trace 0000000000000000 ]---

The crash happened here:

int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *funcs,
		    struct device *dev, struct address_space *mapping,
		    struct drm_vma_offset_manager *vma_manager,
		    bool use_dma_alloc, bool use_dma32)
{
	struct ttm_global *glob = &ttm_glob;
	int ret;

	if (WARN_ON(vma_manager == NULL))
		return -EINVAL;

	ret = ttm_global_init();
	if (ret)
		return ret;

	bdev->wq = alloc_workqueue("ttm",
				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
	if (!bdev->wq) {
		ttm_global_release();
		return -ENOMEM;
	}

	bdev->funcs = funcs;

	ttm_sys_man_init(bdev);

	ttm_pool_init(&bdev->pool, dev, dev_to_node(dev), use_dma_alloc, use_dma32); <<<------- BUG!

Specifically, it appears that dev is NULL and dev_to_node() doesn't like
having a NULL pointer passed to it.

I currently "fixed" this with a:

	if (!dev)
		return -EINVAL;

at the start of this function just so that I can continue running my tests,
but that is obviously incorrect.

-- Steve

