Return-Path: <linux-kernel+bounces-90358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ABE86FE11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16908281835
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F21224DE;
	Mon,  4 Mar 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8gYRhje"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056320B33;
	Mon,  4 Mar 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545999; cv=none; b=Veh+nAxKX29WhabGhwnN2bI7jorrmsvD5zMqg8ZFyTaOV/Ppni0qGP/v5qbCTEA4A2cjLlwxVPl05NNQzkvhxbH1/zmfJkpLoi9LuVqUIYEDVEESZabYjtkcxSl3C5a8fjViY9MOHm4ekBVjHvy6XJ1E1ik+FGxSqiRFGuew8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545999; c=relaxed/simple;
	bh=SwJYBVWCQc/s1GHsKd1+fyA8kLw1X4cfpZ2y4tcEMwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tbbUh+tgxuPtGI98cFqIZoO8Ea01don3dz3bK5VJf+CiKHbAqkyCmBC4rIiYPmZb05ZSSxpI7UHIFlrMtJnBvtmQTfp1MSs6C73edtH157s5atc+RrdN5OPbHFtGclnso2MaK3oBe8h9Z6CGbCvOegUaLMcG5PqlZj+juMPzlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8gYRhje; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so5151693a12.0;
        Mon, 04 Mar 2024 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545995; x=1710150795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT70S1p+PH9hL091yd8+31qBGcRCEfw7ATgxMs9BG/I=;
        b=L8gYRhjehDkUIppEFDQuTLuaCmKg144SUmBFGd6oGyUHdNsZqda1HExI74a0StVg7D
         JwVmNtImPYnR/toaj7ijkw8rYAzBGJoIeqtGe167mT3WamdJCj9/bZAtVFD7qnsgnw2s
         c5bMgPITFUYxUaJiGVoh5iatpKjY/8zv5tzlvZNQd4V+kf9U1vzq17/AI+S11O7Xz/cE
         NpAUfJINez0PHpkG8cTJ9QOGRu+1dWogRaEBuXWNbDG4v8pM8keUx97WpMr92PPPaFZ8
         6FY/Ve5g3Ig/DgmjuRtYS1hPLfJ2G94h9KH9Iga5L2GtRFgDq0+VqlIhxyKnyrkNf9TW
         d04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545995; x=1710150795;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT70S1p+PH9hL091yd8+31qBGcRCEfw7ATgxMs9BG/I=;
        b=wKWpjhWGUUiVBsNFsbV5OYBxy6rkUVrQv/0agx791uQlvu8xMO52WCK1AwKJrpiSKq
         fpGjPp2buVXL7eiD9jh20QfrvNC+4P5k68Vc3MKXGaGycRFuY+mL3X3z9Qscx5jPKjnO
         /0hSj7OhdMDWUzXH52CGNOubCO4q/tvoEW/21jS2h2f670lCiI9P4SZWX3qoahaHGcO4
         8saT//C97Q2ZALCS5KCdzX6kRbmnBkYxNWoaijC55700A4NA5xkB50WK3FiYd9HY4GHg
         +ZXmVdbuMQVEK+ECintn4zQqrO0blsMZOYgd2/Ele4UNJhvilGz22TtpVAGO9II3PUY6
         H76g==
X-Gm-Message-State: AOJu0YwjnNva919Mka2SNkj7s3fA+rbJbe8adyg9QEUplmMvOXma+rgM
	UWFZuEeILQDPdBj8Hs8NwL4rRSPAUfnDFMCjfyc7o6eyc9rcFjwDzgB3DgY7AEOo8ieqYWuqne8
	pG7y6BLpsnR768XJoL7Gpep7bqagApDHu0JwTdBGCe20=
X-Google-Smtp-Source: AGHT+IHD3r2nRqBLuByj4KH/VSRGl6yyQ483mWi6KKegjcjJKJVO94ku8hbcUcBPwQslZHXDAYmHxAumL5G4+oGEg5Q=
X-Received: by 2002:a17:907:20b9:b0:a43:e550:4067 with SMTP id
 pw25-20020a17090720b900b00a43e5504067mr4995407ejb.12.1709545995101; Mon, 04
 Mar 2024 01:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Mon, 4 Mar 2024 17:53:03 +0800
Message-ID: <CAEkJfYP5T4Xv7vn7GZnQ7ig6_QZB8B_g-DS9dk7xhxRntYNY7g@mail.gmail.com>
Subject: [PATCH net] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Dear kernel developers and maintainers,

We found a bug through our modified Syzkaller. In function
bond_option_arp_ip_targets_set(), if newval->string is an empty
string, newval->string+1 will point to the byte after the string,
causing an out-of-bound read.  KASAN report is listed below.

==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107

CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 strlen+0x7d/0xa0 lib/string.c:418
 __fortify_strlen include/linux/fortify-string.h:210 [inline]
 in4_pton+0xa3/0x3f0 net/core/utils.c:130
 bond_option_arp_ip_targets_set+0xc2/0x910
drivers/net/bonding/bond_options.c:1201
 __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
 __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
 bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
 bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
 dev_attr_store+0x54/0x80 drivers/base/core.c:2366
 sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x96a/0xd80 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f797835cfcd
Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
 </TASK>

Allocated by task 8107:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node_track_caller+0x5e/0xd0 mm/slab_common.c:1027
 kstrndup+0x72/0x110 mm/util.c:108
 bonding_sysfs_store_option+0x66/0x120 drivers/net/bonding/bond_sysfs.c:153
 dev_attr_store+0x54/0x80 drivers/base/core.c:2366
 sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x96a/0xd80 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff8881119c4780
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 1-byte region [ffff8881119c4780, ffff8881119c4781)

The buggy address belongs to the physical page:
page:ffffea0004467100 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff8881119c4fc1 pfn:0x1119c4
flags: 0x57ff00000000800(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0x3f()
raw: 057ff00000000800 ffff888013040100 ffffea000405a650 ffffea0004156b90
raw: ffff8881119c4fc1 ffff8881119c4000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE),
pid 25, tgid 25 (kworker/u6:0), ts 73787966798, free_ts 73774684635
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d9/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xd38/0x2fa0 mm/page_alloc.c:3312
 __alloc_pages+0x21d/0x21f0 mm/page_alloc.c:4568
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x9b/0x3c0 mm/slab.c:2550
 cache_alloc_refill+0x289/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3185 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 __kmem_cache_alloc_node+0x374/0x420 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x50/0xd0 mm/slab_common.c:1014
 kmalloc_array_node include/linux/slab.h:698 [inline]
 kcalloc_node include/linux/slab.h:703 [inline]
 memcg_alloc_slab_cgroups+0x10e/0x210 mm/memcontrol.c:2968
 account_slab mm/slab.h:637 [inline]
 kmem_getpages mm/slab.c:1364 [inline]
 cache_grow_begin+0x349/0x3c0 mm/slab.c:2550
 cache_alloc_refill+0x289/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 kmem_cache_alloc_node+0x3e1/0x4a0 mm/slab.c:3509
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1110 [inline]
 copy_process+0x3f6/0x73e0 kernel/fork.c:2332
 kernel_clone+0xeb/0x8c0 kernel/fork.c:2907
 user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xd0/0x180 kernel/umh.c:158
 process_one_work+0x878/0x15c0 kernel/workqueue.c:2627
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x4c5/0xa60 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3d0 mm/page_alloc.c:2487
 rcu_do_batch kernel/rcu/tree.c:2158 [inline]
 rcu_core+0x817/0x1670 kernel/rcu/tree.c:2431
 __do_softirq+0x1d4/0x85e kernel/softirq.c:553

Memory state around the buggy address:
 ffff8881119c4680: fa fb fb fb fc fc fc fc 00 01 fc fc fc fc fc fc
 ffff8881119c4700: 00 05 fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff8881119c4780: 01 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
                   ^
 ffff8881119c4800: 00 01 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff8881119c4880: 00 fc fc fc fc fc fc fc 00 01 fc fc fc fc fc fc
==================================================================

We developed a patch to fix this problem. Check the string length
first before calling in4_pton().

Reported-by: Yue Sun <samsun1006219@gmail.com>
Signed-off-by: Yue Sun <samsun1006219@gmail.com>

diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index f3f27f0bd2a6..a6d01055f455 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
+        if (!strlen(newval->string) || !in4_pton(newval->string+1,
-1, (u8 *)&target, -1, NULL)) {
             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
                    &target);
             return ret;

