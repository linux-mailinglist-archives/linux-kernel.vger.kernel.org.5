Return-Path: <linux-kernel+bounces-85465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6086B66E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF6CB23834
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4D315E5AE;
	Wed, 28 Feb 2024 17:51:23 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318122F1E;
	Wed, 28 Feb 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142683; cv=none; b=qSs/lLLZfL26EztiLJ45RUEgvIE8WtD2ZTpJBIuGMl0+f/wvPb7XQfWLfIE5cElOQ+QHa/J4QXPvILOed+ncxkworvbf9rZoWqCB4kDFghRN1CzGQ02eXp0CwP04pUUDcLAbWYEnS9Xsi4B0+2AmlsYcO9NN6EGW5jgsJ4+DiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142683; c=relaxed/simple;
	bh=YE/j5Jd5RYyGUXRifgV24q+iH63wNhZlxzUbWcESwek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VYCGvjYYuiuH0wddyu/DmKaABJXV2EhBWMr3lfteBYGStseY4ATTmAYoYFNolDTtUIMLMVHi5NDR2SpCI0lzdQLBo5EZW5z6wi4uB26+HXskF1n/ggesBBithswNKDao4Q6Ivt3fEySfbNHYuTruiJ4Nh6KA55Nfdyb+wjLWUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 51BA32000CE;
	Wed, 28 Feb 2024 17:43:48 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id DCE9CA0086; Wed, 28 Feb 2024 18:41:38 +0100 (CET)
Date: Wed, 28 Feb 2024 18:41:38 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com
Cc: sakari.ailus@linux.intel.com, hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking ops
 when !TASK_RUNNING
Message-ID: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

thanks for your work getting the Intel IPU6 camera system - such as found
within my Dell Inc. XPS 9315 - to work with an upstream kernel. Much
appreciated!

On Linux 6.8.0-rc6+ (as of this morning, HEAD is at cf1182944c7c), though,
I get the following warning during boot with everything built into the
kernel:

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000003688dc79>] prepare_to_wait_event+0x54/0x1a0
WARNING: CPU: 5 PID: 122 at kernel/sched/core.c:10099 __might_sleep+0x59/0x60
Modules linked in:
CPU: 5 PID: 122 Comm: kworker/u24:3 Tainted: G                T  6.8.0-rc6+ #2
Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
Workqueue: events_unbound deferred_probe_work_func
RIP: 0010:__might_sleep+0x59/0x60
Code: ee 48 89 df 5b 31 d2 5d e9 24 fd ff ff 48 8b 90 80 15 00 00 48 c7 c7 a8 3f e3 a7 c6 05 03 9f 47 03 01 48 89 d1 e8 27 6b fb ff <0f> 0b eb d1 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffafd10122fa48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffa7d97bd7 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000eaa R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffa27506339628 R14: ffffa27505df3028 R15: 000000000122fb00
FS:  0000000000000000(0000) GS:ffffa27c6f680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44ac3df460 CR3: 0000000114480000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __might_sleep+0x59/0x60
 ? __warn+0x80/0x170
 ? __might_sleep+0x59/0x60
 ? report_bug+0x182/0x1b0
 ? handle_bug+0x40/0x80
 ? exc_invalid_op+0x17/0x80
 ? asm_exc_invalid_op+0x1a/0x20
 ? __might_sleep+0x59/0x60
 ? __might_sleep+0x59/0x60
 gpiod_get_value_cansleep+0x19/0x60
 vsc_tp_xfer+0x177/0x570
 ? __pfx_autoremove_wake_function+0x10/0x10
 mei_vsc_write+0xe5/0x1d0
 mei_hbm_cl_connect_req+0x7d/0xd0
 mei_cl_connect+0x399/0x460
 mei_cldev_enable+0x97/0x1a0
 mei_ace_probe+0x103/0x390
 ? kernfs_add_one+0x146/0x180
 ? really_probe+0x166/0x300
 really_probe+0x166/0x300
 ? __pfx___device_attach_driver+0x10/0x10
 __driver_probe_device+0x6e/0x120
 driver_probe_device+0x1a/0x90
 __device_attach_driver+0x8e/0xd0
 bus_for_each_drv+0x90/0xf0
 __device_attach+0xac/0x1a0
 ? process_one_work+0x19c/0x500
 bus_probe_device+0x93/0xb0
 ? process_one_work+0x19c/0x500
 deferred_probe_work_func+0x96/0xd0
 process_one_work+0x205/0x500
 worker_thread+0x1dc/0x3e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xea/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
irq event stamp: 1179
hardirqs last  enabled at (1185): [<ffffffffa50b61d8>] console_unlock+0x118/0x170
hardirqs last disabled at (1190): [<ffffffffa50b61bd>] console_unlock+0xfd/0x170
softirqs last  enabled at (558): [<ffffffffa5012f8e>] irq_exit_rcu+0x7e/0xa0
softirqs last disabled at (551): [<ffffffffa5012f8e>] irq_exit_rcu+0x7e/0xa0
---[ end trace 0000000000000000 ]---
mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)
mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)


Using modules for mei[_*], ivsc_ace and ivsc_csi, I get a slightly different
trace pointing to mei_vsc_probe():


------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<00000000cd4cced5>] prepare_to_wait_event+0x54/0x1a0
WARNING: CPU: 3 PID: 335 at kernel/sched/core.c:10099 __might_sleep+0x59/0x60
Modules linked in: mei_vsc mei_hdcp mei_pxp mei_me mei mei_vsc_hw
CPU: 3 PID: 335 Comm: kworker/u24:5 Tainted: G                T  6.8.0-rc6+ #1
Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__might_sleep+0x59/0x60
Code: ee 48 89 df 5b 31 d2 5d e9 24 fd ff ff 48 8b 90 b8 15 00 00 48 c7 c7 38 b7 62 a9 c6 05 43 9b 47 03 01 48 89 d1 e8 67 6b fb ff <0f> 0b eb d1 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffff9c2a86fa7b40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffa9590070 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000eaa R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8fe0c6413028 R14: ffff8fe0ce4f2028 R15: 0000000086fa7c00
FS:  0000000000000000(0000) GS:ffff8fe82f580000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005559a7dbc010 CR3: 000000031385c000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __might_sleep+0x59/0x60
 ? __warn+0x80/0x170
 ? __might_sleep+0x59/0x60
 ? report_bug+0x182/0x1b0
 ? handle_bug+0x40/0x80
 ? exc_invalid_op+0x17/0x80
 ? asm_exc_invalid_op+0x1a/0x20
 ? __might_sleep+0x59/0x60
 gpiod_get_value_cansleep+0x19/0x60
 vsc_tp_xfer+0x177/0x570 [mei_vsc_hw]
 ? mei_me_cl_rm_all+0x25/0x90 [mei]
 ? __pfx_autoremove_wake_function+0x10/0x10
 mei_vsc_write+0xe5/0x1d0 [mei_vsc]
 mei_hbm_start_req+0x83/0xf0 [mei]
 mei_reset+0x2af/0x4b0 [mei]
 ? mei_start+0x1c/0x110 [mei]
 ? rcu_read_lock_sched_held+0x42/0x80
 mei_start+0x72/0x110 [mei]
 mei_vsc_probe+0x9a/0x140 [mei_vsc]
 platform_probe+0x3c/0x90
 really_probe+0x166/0x300
 ? process_one_work+0x19c/0x500
 __driver_probe_device+0x6e/0x120
 driver_probe_device+0x1a/0x90
 __driver_attach_async_helper+0x50/0xa0
 async_run_entry_fn+0x24/0xc0
 ? process_one_work+0x19c/0x500
 process_one_work+0x205/0x500
 worker_thread+0x1dc/0x3e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xea/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
irq event stamp: 1113943
hardirqs last  enabled at (1113949): [<ffffffffa68b6308>] console_unlock+0x118/0x170
hardirqs last disabled at (1113954): [<ffffffffa68b62ed>] console_unlock+0xfd/0x170
softirqs last  enabled at (1113130): [<ffffffffa68130be>] irq_exit_rcu+0x7e/0xa0
softirqs last disabled at (1113125): [<ffffffffa68130be>] irq_exit_rcu+0x7e/0xa0
---[ end trace 0000000000000000 ]---



Any ideas?

Best,
	Dominik

