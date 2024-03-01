Return-Path: <linux-kernel+bounces-87771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF786D8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A154B22E16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868F2E842;
	Fri,  1 Mar 2024 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="F0L2SzkO"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3D2B9C1;
	Fri,  1 Mar 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256779; cv=none; b=JlH9RtgaeI/A7LJ8xc0XkHWJ+OPRXU1AhoNC6/FWASKTqKTX4cAe39Ofkp0Vbg7FsHgXzilTOWj2hw5YLJ4ZCQgsGkYaH1c1id6VBQa/pbaIGzAPkY/hqc5Zz3MZaZHm7JIMwEv9t/heCtbKcmV0Xews/dg734hq1m5jcKM7tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256779; c=relaxed/simple;
	bh=tuGC5wyFcsYrlqp5HtH5FDj3u0VQ99pcTwEH86G7J5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulW+wTAiRcKCSAvOUV7u47CETETWtT/wpL+aqB/HlrA3Oq8UZ4Gge5h2frPgbD5BKPKjEojHZy0lAmFiF71Y+D3/Z05xgDK1577ZrEyREDfXyLDm97f0OsxCfW1TOCYQ7xSYv1oiqPWggg2EJ/3Cc97Ukfg57lcWYLMymnWLdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=F0L2SzkO; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=yUP3Fg8UEbX0/ycHA5FJkvcoXBqMXasQLvzZECI1t5M=;
	b=F0L2SzkOb3RAVKgrBWl58jW4HIf8CoFr2ofNFMAogRGxSJut4OmQXfbjWxFBWt
	A9Z6aRA1RUVah3RZFeWPoxEpjolGM/hsfI7ftNwa1XgEGQwH0GyEVXdhbgTgQhNo
	eSTu4uMVAqOfSu0O/7ArOfYMkmT//QNCJCe11Dtl2Eq7c=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S5;
	Fri, 01 Mar 2024 09:32:37 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH 4.19.y 1/9] Revert "loop: Check for overflow while configuring loop"
Date: Fri,  1 Mar 2024 09:30:20 +0800
Message-Id: <20240301013028.2293831-2-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1UGw45uw4rGr47tF43KFg_yoW3XrW5pF
	1S9FWxCw48KrykWw4UCr48tr17Aa1DC3WjyFZakw13ZF17Ww1aqa4UJrW0gr9xCryUAFy2
	yFn5Jr4rtr1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_l1PUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBWUfmWWf0mb9AAAsd

From: Genjian Zhang <zhanggenjian@kylinos.cn>

This reverts commit 2035c770bfdbcc82bd52e05871a7c82db9529e0f.

This patch lost a unlock loop_ctl_mutex in loop_get_status(...),
which caused syzbot to report a UAF issue.The upstream patch does not
have this issue. Therefore, we revert this patch and directly apply
the upstream patch later on.

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

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2e6c3f658894..52481f1f8d01 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1351,11 +1351,6 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_number = lo->lo_number;
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
-
-	/* loff_t vars have been assigned __u64 */
-	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
-		return -EOVERFLOW;
-
 	info->lo_flags = lo->lo_flags;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
-- 
2.25.1


