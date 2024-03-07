Return-Path: <linux-kernel+bounces-94957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E955A87473B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F78285B03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F831BC20;
	Thu,  7 Mar 2024 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CrtVN9bL"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957717BB3;
	Thu,  7 Mar 2024 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785181; cv=none; b=OZifVjKPBBjDhQMTYoq0o2QztqbdJyyd/tI4fPBpocD28er0U+lsFrgz8i7uBqeSS7LovS36ww8XH1GaguyKbh14LN60wxx4NUP0VHnk1WQkifAc+x1BTeRKVmbeEAaDhe6YAk2yQpAesYFumFQ45r1Vd83dfQWO3y/OLPV+XBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785181; c=relaxed/simple;
	bh=6bu/4c6TwZlZLaYOo7fDDH1ti+5fYtSXJoV+eRDtkJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gS6ZrLExDkhVg+f63RgfE4/Sd5xnUc4nPgC4wVlIw51vhSA7k7ZX9GSHtyIVBs1ZnVxWgqkRPDTo1mmeJbmE3rXRDCzuWg0B2TAHNBKdU+YL+HxMfkBnZUgclmVMeviSKeuDQ3PA03SdeL29/Ee8obTTO6fXxMNlvIeJl5HNol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CrtVN9bL; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=w3TqMLeorEO8x2mBtG5UaVwrPWdAcmdw5mh56xxtAqU=;
	b=CrtVN9bLRWQ+LwY3gl4BEG5CkM1u6/N62lXheYlN9geHWtWJLlL9bFdIiJJfT7
	E1+kEAE+a3ZsTK2HrPARzJk/jQ/DocswwAIiYZJ4IsZsCSm8NBZF/Nx6R+mg/Ku3
	xCSV8MB9rvPCdUCMSgO6S6oPd9eo1J5YrfRi6U4DUuL1o=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S4;
	Thu, 07 Mar 2024 12:19:02 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH linux-5.4.y 0/8] Fix the UAF issue caused by the loop driver
Date: Thu,  7 Mar 2024 12:14:03 +0800
Message-Id: <20240307041411.3792061-1-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF48Xr4fWw1UKF17Gw1kAFb_yoWxuFykpF
	nxKrWfGr48GryDXr43ta1UWr18Jayku3Wxtrs2yF1UZa1DZr4Yqr1UC3srWFyUWFy8Ary7
	WF4YqrW5t3WDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jK6wtUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbi5h2afmVLY5SfTAAAsV

From: Genjian Zhang <zhanggenjian@kylinos.cn>

Hello!

We found that 13b2856037a6 ("loop: Check for overflow while configuring loop") lost a unlock loop_ctl_mutex in loop_get_status(...).
which caused syzbot to report a UAF issue. However, the upstream patch does not have this issue.
So, we revert this patch and directly apply the unmodified upstream patch.

This series of patches was also sent to 4.19.y.
https://lore.kernel.org/all/20240301013028.2293831-1-zhanggenjian@126.com/

Risk use-after-free as reported by syzbot：

[   84.669496] ==================================================================
[   84.670021] BUG: KASAN: use-after-free in __mutex_lock.isra.9+0xc13/0xcb0
[   84.670433] Read of size 4 at addr ffff88808dba43b8 by task syz-executor.22/14230
[   84.670885] 
[   84.670987] CPU: 1 PID: 14230 Comm: syz-executor.22 Not tainted 5.4.270 #4
[   84.671397] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1kylin1 04/01/2014
[   84.671927] Call Trace:
[   84.672085]  dump_stack+0x94/0xc7
[   84.672293]  ? __mutex_lock.isra.9+0xc13/0xcb0
[   84.672569]  print_address_description.constprop.6+0x16/0x220
[   84.672915]  ? __mutex_lock.isra.9+0xc13/0xcb0
[   84.673187]  ? __mutex_lock.isra.9+0xc13/0xcb0
[   84.673462]  __kasan_report.cold.9+0x1a/0x32
[   84.673723]  ? __mutex_lock.isra.9+0xc13/0xcb0
[   84.673993]  kasan_report+0x10/0x20
[   84.674208]  __mutex_lock.isra.9+0xc13/0xcb0
[   84.674468]  ? __mutex_lock.isra.9+0x617/0xcb0
[   84.674739]  ? ww_mutex_lock_interruptible+0x100/0x100
[   84.675055]  ? ww_mutex_lock_interruptible+0x100/0x100
[   84.675369]  ? kobject_get_unless_zero+0x144/0x190
[   84.675668]  ? kobject_del+0x60/0x60
[   84.675893]  ? __module_get+0x120/0x120
[   84.676128]  ? __mutex_lock_slowpath+0x10/0x10
[   84.676399]  mutex_lock_killable+0xde/0xf0
[   84.676652]  ? __mutex_lock_killable_slowpath+0x10/0x10
[   84.676967]  ? __mutex_lock_slowpath+0x10/0x10
[   84.677243]  ? disk_block_events+0x1d/0x120
[   84.677509]  lo_open+0x16/0xc0
[   84.677701]  ? lo_compat_ioctl+0x160/0x160
[   84.677954]  __blkdev_get+0xb0f/0x1160
[   84.678185]  ? bd_may_claim+0xd0/0xd0
[   84.678410]  ? bdev_disk_changed+0x190/0x190
[   84.678674]  ? _raw_spin_lock+0x7c/0xd0
[   84.678915]  ? _raw_write_lock_bh+0xd0/0xd0
[   84.679172]  blkdev_get+0x9b/0x290
[   84.679381]  ? ihold+0x1a/0x40
[   84.679574]  blkdev_open+0x1bd/0x240
[   84.679794]  do_dentry_open+0x439/0x1000
[   84.680035]  ? blkdev_get_by_dev+0x60/0x60
[   84.680286]  ? __x64_sys_fchdir+0x1a0/0x1a0
[   84.680557]  ? inode_permission+0x86/0x320
[   84.680814]  path_openat+0x998/0x4120
[   84.681044]  ? stack_trace_consume_entry+0x160/0x160
[   84.681348]  ? do_futex+0x136/0x1880
[   84.681568]  ? path_mountpoint+0xb50/0xb50
[   84.681823]  ? save_stack+0x4d/0x80
[   84.682038]  ? save_stack+0x19/0x80
[   84.682253]  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
[   84.682553]  ? kmem_cache_alloc+0xc7/0x210
[   84.682804]  ? getname_flags+0xc4/0x560
[   84.683045]  ? do_sys_open+0x1ce/0x450
[   84.683272]  ? do_syscall_64+0x9a/0x330
[   84.683509]  ? entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[   84.683826]  ? _raw_spin_lock+0x7c/0xd0
[   84.684063]  ? _raw_write_lock_bh+0xd0/0xd0
[   84.684319]  ? futex_exit_release+0x60/0x60
[   84.684574]  ? kasan_unpoison_shadow+0x30/0x40
[   84.684844]  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
[   84.685149]  ? get_partial_node.isra.83.part.84+0x1e5/0x340
[   84.685485]  ? __fget_light+0x1d1/0x550
[   84.685721]  do_filp_open+0x197/0x270
[   84.685946]  ? may_open_dev+0xd0/0xd0
[   84.686172]  ? kasan_unpoison_shadow+0x30/0x40
[   84.686443]  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
[   84.686743]  ? __alloc_fd+0x1a3/0x580
[   84.686973]  do_sys_open+0x2c7/0x450
[   84.687195]  ? filp_open+0x60/0x60
[   84.687406]  ? __x64_sys_timer_settime32+0x280/0x280
[   84.687707]  do_syscall_64+0x9a/0x330
[   84.687931]  ? syscall_return_slowpath+0x17a/0x230
[   84.688221]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[   84.688524] 
[   84.688622] Allocated by task 14056:
[   84.688842]  save_stack+0x19/0x80
[   84.689044]  __kasan_kmalloc.constprop.6+0xc1/0xd0
[   84.689333]  kmem_cache_alloc_node+0xe2/0x230
[   84.689600]  copy_process+0x165c/0x72d0
[   84.689833]  _do_fork+0xf9/0x9a0
[   84.690032]  __x64_sys_clone+0x17a/0x200
[   84.690271]  do_syscall_64+0x9a/0x330
[   84.690496]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[   84.690800] 
[   84.690903] Freed by task 0:
[   84.691081]  save_stack+0x19/0x80
[   84.691287]  __kasan_slab_free+0x125/0x170
[   84.691535]  kmem_cache_free+0x7a/0x2a0
[   84.691774]  __put_task_struct+0x1ec/0x4a0
[   84.692023]  delayed_put_task_struct+0x178/0x1d0
[   84.692303]  rcu_core+0x538/0x16c0
[   84.692512]  __do_softirq+0x175/0x63d
[   84.692741] 
[   84.692840] The buggy address belongs to the object at ffff88808dba4380
[   84.692840]  which belongs to the cache task_struct of size 3328
[   84.693584] The buggy address is located 56 bytes inside of
[   84.693584]  3328-byte region [ffff88808dba4380, ffff88808dba5080)
[   84.694272] The buggy address belongs to the page:
[   84.694563] page:ffffea000236e800 refcount:1 mapcount:0 mapping:ffff8881838acdc0 index:0x0 compound_mapcount: 0
[   84.695166] flags: 0x100000000010200(slab|head)
[   84.695457] raw: 0100000000010200 dead000000000100 dead000000000122 ffff8881838acdc0
[   84.695919] raw: 0000000000000000 0000000000090009 00000001ffffffff 0000000000000000
[   84.696375] page dumped because: kasan: bad access detected
[   84.696705] 
[   84.696801] Memory state around the buggy address:
[   84.697089]  ffff88808dba4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.697519]  ffff88808dba4300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   84.697945] >ffff88808dba4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.698371]                                         ^
[   84.698674]  ffff88808dba4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.699111]  ffff88808dba4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   84.699537] ==================================================================
[   84.699965] Disabling lock debugging due to kernel taint

Best regards
Genjian

Genjian Zhang (1):
  Revert "loop: Check for overflow while configuring loop"

Martijn Coenen (5):
  loop: Call loop_config_discard() only after new config is applied
  loop: Remove sector_t truncation checks
  loop: Factor out setting loop device size
  loop: Refactor loop_set_status() size calculation
  loop: Factor out configuring loop from status

Siddh Raman Pant (1):
  loop: Check for overflow while configuring loop

Zhong Jinghua (1):
  loop: loop_set_status_from_info() check before assignment

 drivers/block/loop.c | 185 ++++++++++++++++++++++++-------------------
 1 file changed, 104 insertions(+), 81 deletions(-)

-- 
2.25.1


