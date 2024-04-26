Return-Path: <linux-kernel+bounces-159927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CC8B3663
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50B6283C51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B358144D3A;
	Fri, 26 Apr 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OmSgCIhL"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDE1448DA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129856; cv=none; b=U0FgcFUnaVId1SwxW4+dgJMngb4R0ymIAGWeMP6eoiCP4/sQMecYfEsGovFUimLnTtAM09jt2kbhacsPjF+upNgM8nGJi+kV413qBbzpA5d+UssMa/+LR9ikcnmcSyv72ovMkhKOMNxe5tnI27X33l8j/y0ebCevle94Qn8DmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129856; c=relaxed/simple;
	bh=WbhZdoIBj3p0E4VrFE5juiAe7yLSKrqnIW0Ka4pUhGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QSzpIPEmjQN0qxSXAr5qUOA7pzk1sAbNL4I5a2ZeRFu2t63YnU+Vxj8yxbHEx5+Gr0720mfB1XC8ctczYu5HDR2CI+xkIFfprauVrvgXDB2dJ9sG0Xbj7DEPYOWVm9L+IAdKPuWq4yWErifxONNBdZgMXN5nprit9xajOfU8NTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OmSgCIhL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240426111047euoutp023649192360ad2ce4f2d73caf70920c9b~J0AO2Y5Nf0031200312euoutp02h
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240426111047euoutp023649192360ad2ce4f2d73caf70920c9b~J0AO2Y5Nf0031200312euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714129847;
	bh=XSqbdPMuwyK0sHWAYJbKaT5v53vJxjQrzK/zUbpnB+c=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OmSgCIhLO89IbRgp1yAyg3Eye/AZNeeXbQOt9i1WMwa7VsLHK71ar9mfq3tjzNpyI
	 6nfwGito8pkkmGrmPBH+sB6TpC9SO7StG0irb4Su4eeQuChWEBdmwlSHxB2vSzYK3L
	 DYPEB157lBKsv212iG68QYO3ytSZLI/9dQqrmDBA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240426111047eucas1p1147c2bb08053f732ddc16a03e35603f3~J0AOg-D662877728777eucas1p1k;
	Fri, 26 Apr 2024 11:10:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.BD.09624.7BB8B266; Fri, 26
	Apr 2024 12:10:47 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf~J0AOJm_zA0692006920eucas1p1K;
	Fri, 26 Apr 2024 11:10:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240426111046eusmtrp241c92da180f176d63016e2852acbad60~J0AOI_0Za3229532295eusmtrp2N;
	Fri, 26 Apr 2024 11:10:46 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-0c-662b8bb71109
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.6D.08810.6BB8B266; Fri, 26
	Apr 2024 12:10:46 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240426111046eusmtip10756d1ac90a6dcce60edbf902fd2c3f5~J0ANiMTxe2561625616eusmtip1h;
	Fri, 26 Apr 2024 11:10:46 +0000 (GMT)
Message-ID: <420eec10-d499-4d50-b4c3-44af15b82698@samsung.com>
Date: Fri, 26 Apr 2024 13:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: HCI: fix slab-use-after-free in
 cmd_sync_work
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240425041128.3093970-1-iam@sung-woo.kim>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rbu7XTDC6sZrdouTKTxaK9exaT
	xa6px5gt5lzrY7a4vGsOm8XTz1NYLb59+sXowO6xc9Zddo/1u5eze1xvs/aY9N3V4/MmuQDW
	KC6blNSczLLUIn27BK6MOVv3MhXc86loPyjVwDjVsYuRk0NCwERi790XrF2MXBxCAisYJU42
	vmOEcL4wSsx/fBEq8xko834NK0zL5h13oRLLGSUOzjrEBuF8ZJR4e6YTrIpXwE6ivXEFE4jN
	IqAqcXvWPai4oMTJmU9YQGxRAXmJ+7dmsIPYwgL+Eoe6FoPFRQSUJA79vwk2lFngOtDQ9TuZ
	QRLMAuISt57MBxvKJmAo0fW2iw3E5hSwkGhqf8gEUSMv0bx1NjNIs4TAAw6JHe1HWCDudpGY
	P+caG4QtLPHq+BZ2CFtG4v9OkKEgDe2MEgt+34dyJjBKNDy/xQhRZS1x59wvoG4OoBWaEut3
	6UOEHSU+XvjCCBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiGF
	yywkb85C8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKag0/+Of9rBOPfV
	R71DjEwcjIcYJTiYlUR4b37USBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5Ykpqd
	mlqQWgSTZeLglGpg6jp/w9HK8m9xicyriEky5/zT/VnPl+s+q7fKeWo8O2qlOKPsT4+gxU28
	3ldmJIiLLZSM5LoWYpH2afbUHz//f/vytGpyRHO+x+x5yyt2rSh7O0fm7Prcdo28/JRnqdGm
	vzcoTFZtFd21Sjmrtb3q0/F1kYuj5wsqNcqIW/0VnFwze2vtsnVSL19ncRcz26XkRV5d+iYz
	K2/66ZbAaXrxk603bFDWKr5y4+SsS8UFJrof2uo2J9iJGSnGL3kzc9tmhQVVy96XslisVO7w
	nfDyozSHSPGVaAUJKTHOHedEF8a/trP9d4pfpkNXv/TNt+YF0i+axS/cOj5fUEeytqI8JEUl
	PUPZVWylYmDs1/VKLMUZiYZazEXFiQBNXq5SsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7rburXTDF72aFm0XJnJYtHePYvJ
	YtfUY8wWc671MVtc3jWHzeLp5ymsFt8+/WJ0YPfYOesuu8f63cvZPa63WXtM+u7q8XmTXABr
	lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GnK17
	mQru+VS0H5RqYJzq2MXIySEhYCKxecdd1i5GLg4hgaWMEndnX2OGSMhInJzWwAphC0v8udbF
	BlH0nlHi1ZUNbCAJXgE7ifbGFUwgNouAqsTtWfdYIeKCEidnPmEBsUUF5CXu35rB3sXIwSEs
	4Ctx7E05SFhEQEni0P+bYDOZBW4ySty6/Y0FpEZIwFxi+RMLkBpmAXGJW0/mg41nEzCU6Hrb
	BbaWU8BCoqn9IRNEjZlE19YuRghbXqJ562zmCYxCs5BcMQvJqFlIWmYhaVnAyLKKUSS1tDg3
	PbfYUK84Mbe4NC9dLzk/dxMjMNq2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuG9+VEjTYg3JbGy
	KrUoP76oNCe1+BCjKTAoJjJLiSbnA+M9ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7
	NbUgtQimj4mDU6qBKfxye8omm6Jb3D9vNDwUX1i1XjJSWGfjhUdqGQF1NfppU+/Jbnmy7cD2
	7pXSfzu//Erm3/NRr9tf47H3Rr0mudbd31VNrz3itZ2uvWxmmo3pwi1Sxttn9hldrovfbWt3
	0fgMe9bXuqlPpVK0Nks2/qtTtNjcYzy78An/pX3pee5BimHuk55/4J79eevHw89XnpyzquVi
	lIdLpuQrYUH3Ow7+x7o2HDyUai1f8tDqkt8qnnMH1zG53WHyLONLfbtN7OYU0fbDS460ZVts
	0w9fPPGu8hmJ+bk/Jr3fxZDkJ6T/8PfqCEOpknUekfNkDyWrf995Vv3q/YkBpodWyvtb3WKb
	fGWvRvbr4xdWfZmVE6XEUpyRaKjFXFScCAC+AIXcPwMAAA==
X-CMS-MailID: 20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf
References: <20240425041128.3093970-1-iam@sung-woo.kim>
	<CGME20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf@eucas1p1.samsung.com>

Dear All,

On 25.04.2024 06:11, Sungwoo Kim wrote:
> Hello, could you review the UAF bug and its fix?
> The stack trace is at the bottom.
>
> mgmt sync cmd could be used after freed in this scenario:
>
> set_local_name()       ... cmd is allocated, set_name_complete() is
>                             queued in cmd_sync_work.
> hci_error_reset()      ... hci device reset.
>    hci_dev_close_sync() ... close hdev, at this point, cmd is freed.
> set_name_complete()    ... callback from cmd_sync_work. cmd->param causes UAF.
>
> To fix this, this patch makes hci_dev_close_sync() call hci_cmd_sync_clear() to clear the cmd_sync_work.
>
> Thanks,
> Sungwoo Kim.

This patch landed in today's linux-next as commit 37dd04e4d594 
("Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work"). I believe 
it correctly fixes the mentioned problem, but on the other hand it 
introduces the following kernel's lock dependency checker warning:

============================================
WARNING: possible recursive locking detected
6.9.0-rc4-01047-g37dd04e4d594 #14949 Not tainted
--------------------------------------------
kworker/u9:0/56 is trying to acquire lock:
c3aba78c ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: 
__flush_work+0x1e0/0x538

but task is already holding lock:
f0eb5f18 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: 
process_scheduled_works+0x328/0x7a8

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock((work_completion)(&hdev->cmd_sync_work));
   lock((work_completion)(&hdev->cmd_sync_work));

  *** DEADLOCK ***

  May be due to missing lock nesting notation

4 locks held by kworker/u9:0/56:
  #0: c3a4e8b4 ((wq_completion)hci0){+.+.}-{0:0}, at: 
process_scheduled_works+0x2fc/0x7a8
  #1: f0eb5f18 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, 
at: process_scheduled_works+0x328/0x7a8
  #2: c3abab6c (&hdev->req_lock){+.+.}-{3:3}, at: 
hci_cmd_sync_work+0xa0/0x154 [bluetooth]
  #3: c137bdfc (rcu_read_lock){....}-{1:2}, at: __flush_work+0x40/0x538

stack backtrace:
CPU: 0 PID: 56 Comm: kworker/u9:0 Not tainted 
6.9.0-rc4-01047-g37dd04e4d594 #14949
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call trace:.
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __lock_acquire+0x152c/0x1744
  __lock_acquire from lock_acquire+0x21c/0x394
  lock_acquire from __flush_work+0x20c/0x538
  __flush_work from __cancel_work_sync+0x12c/0x20c
  __cancel_work_sync from hci_cmd_sync_clear+0x1c/0x6c [bluetooth]
  hci_cmd_sync_clear [bluetooth] from hci_dev_close_sync+0x31c/0x5f4 
[bluetooth]
  hci_dev_close_sync [bluetooth] from hci_set_powered_sync+0x27c/0x288 
[bluetooth]
  hci_set_powered_sync [bluetooth] from hci_cmd_sync_work+0xb0/0x154 
[bluetooth]
  hci_cmd_sync_work [bluetooth] from process_scheduled_works+0x390/0x7a8
  process_scheduled_works from worker_thread+0x150/0x3bc
  worker_thread from kthread+0x108/0x140
  kthread from ret_from_fork+0x14/0x28
Exception stack(0xf0eb5fb0 to 0xf0eb5ff8)
..


Please check if the locking is really correct and if so, add the needed 
lockdep annotation to the bluetooth code to silence the above warning.


> ==================================================================
> BUG: KASAN: slab-use-after-free in set_name_complete+0x4a/0x330 net/bluetooth/mgmt.c:3815
> Read of size 8 at addr ffff888107259098 by task kworker/u3:0/66
>
> CPU: 0 PID: 66 Comm: kworker/u3:0 Not tainted 6.8.0+ #61
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x18f/0x560 mm/kasan/report.c:488
>   kasan_report+0xd7/0x110 mm/kasan/report.c:601
>   __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
>   set_name_complete+0x4a/0x330 net/bluetooth/mgmt.c:3815
>   hci_cmd_sync_work+0x269/0x3e0 net/bluetooth/hci_sync.c:308
>   process_one_work kernel/workqueue.c:2633 [inline]
>   process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
>   worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
>   kthread+0x2a9/0x340 kernel/kthread.c:388
>   ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>   </TASK>
>
> Allocated by task 308:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x30/0x70 mm/kasan/common.c:68
>   kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
>   kmalloc include/linux/slab.h:590 [inline]
>   kzalloc include/linux/slab.h:711 [inline]
>   mgmt_pending_new+0x6f/0x230 net/bluetooth/mgmt_util.c:269
>   mgmt_pending_add+0x3f/0x120 net/bluetooth/mgmt_util.c:296
>   set_local_name+0x15a/0x4c0 net/bluetooth/mgmt.c:3892
>   hci_mgmt_cmd+0xb79/0x1190 net/bluetooth/hci_sock.c:1715
>   hci_sock_sendmsg+0x63a/0xf00 net/bluetooth/hci_sock.c:1835
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x227/0x270 net/socket.c:745
>   sock_write_iter+0x28d/0x3d0 net/socket.c:1160
>   do_iter_readv_writev+0x331/0x4c0
>   vfs_writev+0x2e6/0xa40 fs/read_write.c:971
>   do_writev+0xfd/0x250 fs/read_write.c:1018
>   __do_sys_writev fs/read_write.c:1091 [inline]
>   __se_sys_writev fs/read_write.c:1088 [inline]
>   __x64_sys_writev+0x86/0xa0 fs/read_write.c:1088
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x84/0x120 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Freed by task 66:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x30/0x70 mm/kasan/common.c:68
>   kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
>   poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
>   __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2121 [inline]
>   slab_free mm/slub.c:4299 [inline]
>   kfree+0x106/0x2e0 mm/slub.c:4409
>   mgmt_pending_free net/bluetooth/mgmt_util.c:309 [inline]
>   mgmt_pending_remove+0x19e/0x1d0 net/bluetooth/mgmt_util.c:315
>   cmd_complete_rsp+0x104/0x1a0
>   mgmt_pending_foreach+0xc7/0x120 net/bluetooth/mgmt_util.c:259
>   __mgmt_power_off+0x137/0x370 net/bluetooth/mgmt.c:9496
>   hci_dev_close_sync+0x4ab/0xe80 net/bluetooth/hci_sync.c:4953
>   hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
>   hci_error_reset+0x150/0x410 net/bluetooth/hci_core.c:1060
>   process_one_work kernel/workqueue.c:2633 [inline]
>   process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
>   worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
>   kthread+0x2a9/0x340 kernel/kthread.c:388
>   ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>
> The buggy address belongs to the object at ffff888107259080
>   which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 24 bytes inside of
>   freed 96-byte region [ffff888107259080, ffff8881072590e0)
>
> The buggy address belongs to the physical page:
> page:000000006bdb81a5 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888107259280 pfn:0x107259
> flags: 0x17ffffc0000a00(workingset|slab|node=0|zone=2|lastcpupid=0x1fffff)
> page_type: 0xffffffff()
> raw: 0017ffffc0000a00 ffff888100041780 ffffea0004145510 ffffea0004240190
> raw: ffff888107259280 000000000020000f 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff888107258f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff888107259000: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>> ffff888107259080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                              ^
>   ffff888107259100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>   ffff888107259180: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ==================================================================
>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>   net/bluetooth/hci_core.c | 2 --
>   net/bluetooth/hci_sync.c | 5 ++++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a7028d38c..c347efc4f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2764,8 +2764,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
>   
>   	cancel_work_sync(&hdev->power_on);
>   
> -	hci_cmd_sync_clear(hdev);
> -
>   	hci_unregister_suspend_notifier(hdev);
>   
>   	msft_unregister(hdev);
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c5d879904..aa8e0c33c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5181,9 +5181,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>   		clear_bit(HCI_INIT, &hdev->flags);
>   	}
>   
> -	/* flush cmd  work */
> +	/* flush cmd work */
>   	flush_work(&hdev->cmd_work);
>   
> +	/* flush cmd sync work */
> +	hci_cmd_sync_clear(hdev);
> +
>   	/* Drop queues */
>   	skb_queue_purge(&hdev->rx_q);
>   	skb_queue_purge(&hdev->cmd_q);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


