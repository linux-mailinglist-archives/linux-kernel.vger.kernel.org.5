Return-Path: <linux-kernel+bounces-87770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEE686D8CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB961F21180
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6035A2E415;
	Fri,  1 Mar 2024 01:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hrvI8Dbu"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F521FAB;
	Fri,  1 Mar 2024 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256762; cv=none; b=qe9wT1ca9sQMZeWm7rqw8Y+baAdIvLSc1vTnaN8ww5RrpxF4MCXxrZ/WSx+lwfDZicvTx8S6+IF+2Xx7Rq36OITPJEc/kCIyvatOFKCyO30HTqeIlM/3S80ilAL5k402h1Dpt47O6Iymo8xdKAPIosQ54KDVh0S6G83cvSHBQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256762; c=relaxed/simple;
	bh=GyRBvP61UMuuuBeLEcQrFy65aVcca1wzEIpd1Z2HEFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iCDXnAhxdBG4XqorT+Ryo7oeQ0pnvLC1LMohczq+daAWF+OMGl8p8NThD5RV6C5b/VqeY6v8iUEFA/5QnpQQaotppHH52hfolaIbV7l9FYXk2vxhNOkL8Ns70abhsYwh8mwUrYMzKI0S0yortvFHOcbI2zcn0bou+fVSqpr/VDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hrvI8Dbu; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=qf2m+LPOD0vmhyuQBBDWfZHEVymQ5ijq0f+jKDwcQDU=;
	b=hrvI8DbuyCix2nbhCBYQpKKHsowsFFNOi2edmuZdk8jwaPvyt+wkU/1gtWNYkE
	imqiOM2k/1XlZngN2nKCnbd5PhsGotutp/0xLS9fLVo/bwEGmWWlH/cukBms8Ybt
	eobjnqRrugLUeIxioz5PsmnQQ6UlU7i1cR6pNinBIB+uE=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S4;
	Fri, 01 Mar 2024 09:32:24 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 0/9] Fix the UAF issue caused by the loop driver
Date: Fri,  1 Mar 2024 09:30:19 +0800
Message-Id: <20240301013028.2293831-1-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1kKrW8WF18Gw47Zr1rCrg_yoW3GFyxpF
	1SgrWfCw48GrykG3yUCr48tr13Ja1DA3WUtFZ3Cw13ZF1UWw1aqa4UJrW0gFy3Cry5AFy2
	yF1rGr4rKr1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U65l8UUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbi5gmUfmVLY1IyHwAAs3

From: Genjian Zhang <zhanggenjian@kylinos.cn>

Hello!

We found that 2035c770bfdb ("loop: Check for overflow while configuring loop") lost a unlock loop_ctl_mutex in loop_get_status(...).
which caused syzbot to report a UAF issue. However, the upstream patch does not have this issue.
So, we revert this patch and directly apply the unmodified upstream patch.

Risk use-after-free as reported by syzbot：

[  174.437352] BUG: KASAN: use-after-free in __mutex_lock.isra.10+0xbc4/0xc30
[  174.437772] Read of size 4 at addr ffff8880bac49ab8 by task syz-executor.0/13897
[  174.438205]
[  174.438306] CPU: 1 PID: 13897 Comm: syz-executor.0 Not tainted 4.19.306 #1
[  174.438712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1kylin1 04/01/2014
[  174.439236] Call Trace:
[  174.439392]  dump_stack+0x94/0xc7
[  174.439596]  ? __mutex_lock.isra.10+0xbc4/0xc30
[  174.439881]  print_address_description+0x60/0x229
[  174.440165]  ? __mutex_lock.isra.10+0xbc4/0xc30
[  174.440436]  kasan_report.cold.6+0x241/0x2fd
[  174.440696]  __mutex_lock.isra.10+0xbc4/0xc30
[  174.440959]  ? entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[  174.441272]  ? mutex_trylock+0xa0/0xa0
[  174.441500]  ? entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[  174.441816]  ? kobject_get_unless_zero+0x129/0x1c0
[  174.442106]  ? kset_unregister+0x30/0x30
[  174.442351]  ? find_symbol_in_section+0x310/0x310
[  174.442634]  ? __mutex_lock_slowpath+0x10/0x10
[  174.442901]  mutex_lock_killable+0xb0/0xf0
[  174.443149]  ? __mutex_lock_killable_slowpath+0x10/0x10
[  174.443465]  ? __mutex_lock_slowpath+0x10/0x10
[  174.443732]  ? _cond_resched+0x10/0x20
[  174.443966]  ? kobject_get+0x54/0xa0
[  174.444190]  lo_open+0x16/0xc0
[  174.444382]  __blkdev_get+0x273/0x10f0
[  174.444612]  ? lo_fallocate.isra.20+0x150/0x150
[  174.444886]  ? bdev_disk_changed+0x190/0x190
[  174.445146]  ? path_init+0x1030/0x1030
[  174.445371]  ? do_syscall_64+0x9a/0x2d0
[  174.445608]  ? deref_stack_reg+0xab/0xe0
[  174.445852]  blkdev_get+0x97/0x880
[  174.446061]  ? walk_component+0x297/0xdc0
[  174.446303]  ? __blkdev_get+0x10f0/0x10f0
[  174.446547]  ? __fsnotify_inode_delete+0x20/0x20
[  174.446822]  blkdev_open+0x1bd/0x240
[  174.447040]  do_dentry_open+0x448/0xf80
[  174.447274]  ? blkdev_get_by_dev+0x60/0x60
[  174.447522]  ? __x64_sys_fchdir+0x1a0/0x1a0
[  174.447775]  ? inode_permission+0x86/0x320
[  174.448022]  path_openat+0xa83/0x3ed0
[  174.448248]  ? path_mountpoint+0xb50/0xb50
[  174.448495]  ? kasan_kmalloc+0xbf/0xe0
[  174.448723]  ? kmem_cache_alloc+0xbc/0x1b0
[  174.448971]  ? getname_flags+0xc4/0x560
[  174.449203]  ? do_sys_open+0x1ce/0x3f0
[  174.449432]  ? do_syscall_64+0x9a/0x2d0
[  174.449706]  ? entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[  174.450022]  ? __d_alloc+0x2a/0xa50
[  174.450232]  ? kasan_unpoison_shadow+0x30/0x40
[  174.450510]  ? should_fail+0x117/0x6c0
[  174.450737]  ? timespec64_trunc+0xc1/0x150
[  174.450986]  ? inode_init_owner+0x2e0/0x2e0
[  174.451237]  ? timespec64_trunc+0xc1/0x150
[  174.451484]  ? inode_init_owner+0x2e0/0x2e0
[  174.451736]  do_filp_open+0x197/0x270
[  174.451959]  ? may_open_dev+0xd0/0xd0
[  174.452182]  ? kasan_unpoison_shadow+0x30/0x40
[  174.452448]  ? kasan_kmalloc+0xbf/0xe0
[  174.452672]  ? __alloc_fd+0x1a3/0x4b0
[  174.452895]  do_sys_open+0x2c7/0x3f0
[  174.453114]  ? filp_open+0x60/0x60
[  174.453320]  do_syscall_64+0x9a/0x2d0
[  174.453541]  ? prepare_exit_to_usermode+0xf3/0x170
[  174.453832]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[  174.454136] RIP: 0033:0x41edee
[  174.454321] Code: 25 00 00 41 00 3d 00 00 41 00 74 48 48 c7 c0 a4 af 0b 01 8b 00 85 c0 75 69 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a6 00 00 00 48 8b 4c 24 28 64 48 33 0c5
[  174.455404] RSP: 002b:00007ffd2501fbd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  174.455854] RAX: ffffffffffffffda RBX: 00007ffd2501fc90 RCX: 000000000041edee
[  174.456273] RDX: 0000000000000002 RSI: 00007ffd2501fcd0 RDI: 00000000ffffff9c
[  174.456698] RBP: 0000000000000003 R08: 0000000000000001 R09: 00007ffd2501f9a7
[  174.457116] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
[  174.457535] R13: 0000000000565e48 R14: 00007ffd2501fcd0 R15: 0000000000400510
[  174.457955]
[  174.458052] Allocated by task 945:
[  174.458261]  kasan_kmalloc+0xbf/0xe0
[  174.458478]  kmem_cache_alloc_node+0xb4/0x1d0
[  174.458743]  copy_process.part.57+0x14b0/0x7010
[  174.459017]  _do_fork+0x197/0x980
[  174.459218]  kernel_thread+0x2f/0x40
[  174.459438]  call_usermodehelper_exec_work+0xa8/0x240
[  174.459742]  process_one_work+0x933/0x13b0
[  174.459986]  worker_thread+0x8c/0x1000
[  174.460212]  kthread+0x343/0x410
[  174.460408]  ret_from_fork+0x35/0x40
[  174.460621]
[  174.460716] Freed by task 22902:
[  174.460913]  __kasan_slab_free+0x125/0x170
[  174.461159]  kmem_cache_free+0x6e/0x1b0
[  174.461391]  __put_task_struct+0x1c4/0x440
[  174.461636]  delayed_put_task_struct+0x135/0x170
[  174.461915]  rcu_process_callbacks+0x578/0x15c0
[  174.462184]  __do_softirq+0x175/0x60e
[  174.462403]
[  174.462501] The buggy address belongs to the object at ffff8880bac49a80
[  174.462501]  which belongs to the cache task_struct of size 3264
[  174.463235] The buggy address is located 56 bytes inside of
[  174.463235]  3264-byte region [ffff8880bac49a80, ffff8880bac4a740)
[  174.463923] The buggy address belongs to the page:
[  174.464210] page:ffffea0002eb1200 count:1 mapcount:0 mapping:ffff888188ca0a00 index:0x0 compound_mapcount: 0
[  174.464784] flags: 0x100000000008100(slab|head)
[  174.465079] raw: 0100000000008100 ffffea0002eaa400 0000000400000004 ffff888188ca0a00
[  174.465533] raw: 0000000000000000 0000000000090009 00000001ffffffff 0000000000000000
[  174.465988] page dumped because: kasan: bad access detected
[  174.466321]
[  174.466322] Memory state around the buggy address:
[  174.466325]  ffff8880bac49980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  174.466327]  ffff8880bac49a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  174.466329] >ffff8880bac49a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  174.466329]                                         ^
[  174.466331]  ffff8880bac49b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  174.466333]  ffff8880bac49b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  174.466333] ==================================================================
[  174.466338] Disabling lock debugging due to kernel taint

Best regards
Genjian

Genjian Zhang (1):
  Revert "loop: Check for overflow while configuring loop"

Holger Hoffstätte (1):
  loop: properly observe rotational flag of underlying device

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

 drivers/block/loop.c | 204 ++++++++++++++++++++++++++-----------------
 1 file changed, 123 insertions(+), 81 deletions(-)

-- 
2.25.1


