Return-Path: <linux-kernel+bounces-91577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05ED8713DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD85B2324A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8C29CE9;
	Tue,  5 Mar 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tyhdhdzp"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD918046
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606839; cv=none; b=W8rLnpMdboqI6sfEEbC6cehyuz4ONSkTeVzaS6XOENjJ8DMscuvi0otNaS2pKBh6vvcKcylNKrO/smmG5KTUtRglcMAL8BtKtww2yjPIVlW78ajZE4CJ66/hFGbKH7RvVqexa+TVLs2Ib7YaWrdEBMT8cDW2eEwA9bCxMPSXkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606839; c=relaxed/simple;
	bh=wqJ4dqZUaZJ/ogeOo9VnWSXivkfFvvBjb7SwWrRLJeo=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=CWP4C4+aiggzfOuaHmxkhAswKjWvuxoRZoxqOlbfLHnuZyxQy9QtIRCDOqG26zSARNGjEEyj39BO/jXlF4alfW5eqejXqWBuRkQ9BdNThtcVa/f7WATgfQ4/Fvru1vmy5GnkNsG7EpTe7cJV/6Uh8BnwZ+Y/cSgve3+j1oeiQw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tyhdhdzp; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C7DB3F0F8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709606828;
	bh=6rZkmHG0B34YMM8VJIo9BhGiRwNE/OKV6IxiiI7cs5o=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=tyhdhdzp7/oIjNRUAfaCW0aotUktRkm7DZ70a4XpgHmSj4Jn1+f+NncP21TjnGdC5
	 tUF3Tmumsgy7YPMvND3hLo0FuQ2DbKHM2d+T0PXf+k3rizOoLO5UXGmVVhUB0YgtCP
	 Ltd8ByJ3zXScV9sxH1RHy/dufZhhAomYhqXDHrjQ+8XIdEfFXn3o1kZxAK3pBvpPWl
	 wp7rylZ2tCr9zRHDgSbTrbEHkOKj55kkB0/ufXARpSxWhLOW6g82OI640JzHBLLyKT
	 CvfWs/IyDPdDlwDjIXvpP8DRvYZHRWA3/YB/8LiX2g8VyAbAQ1Cw89u8KHneTqv+h3
	 OW8Joqgbi8EkA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29ae60ce114so3533445a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709606826; x=1710211626;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rZkmHG0B34YMM8VJIo9BhGiRwNE/OKV6IxiiI7cs5o=;
        b=V4l9xr02GxJI1q20rlKyDCkZ9Tq+deemALuu/7e+3/j65duWcX9FPSiv6DeJfBfrKJ
         5u7YNLv2rgGT4dcpirrFcOvWqsvXeMgefc/NgtqWMMxjHx0CwDpzqd/8f5b1z5wpx7+s
         uGqEJPl0GUh3EG3GuTXRpEm7djSs4e+nEO5PTUlfnidu3Lo+gJSkeaMhzan3pRVzkuJJ
         ZxqNu7K+gexIaX8/g9SOnIApFoita7Bq5W3ge9J2KAq500p+83hbaupP+Lrw6ejt5f9x
         BZNQsFgsC7DDrCEq7pgcE0mK4jW/z+SPEu9I8yyd7w5VJd+yQ7q1ZQxKOESWVSqZN/LC
         SnMg==
X-Gm-Message-State: AOJu0YwMjQlrEzne987uJtu4FLtl8H9VqlNrEw/kjvNG5xar+WERbiql
	vXb4MKZAeIVxqrlP1BroJm4uNOALsyS7xKPYnpn1YEWkbesFZYn+dRc1tm4Jx9jwT7NiLYa39r2
	PThdMJwyNQH3oUBM9mif7t8zrwpXfnTlhYAcjmNbya5Nc5t/cAMQArjY5xo2Lh9WgJSMs5X+mb7
	hs8g==
X-Received: by 2002:a17:90a:bb96:b0:298:b9f7:83f7 with SMTP id v22-20020a17090abb9600b00298b9f783f7mr7785743pjr.24.1709606826462;
        Mon, 04 Mar 2024 18:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHQqpus715iZe6IPZLf6N62Vn4ayaO54xcEyoRrWayNbji0XA9Z+qj7trqq7dG0hWMkd+VoQ==
X-Received: by 2002:a17:90a:bb96:b0:298:b9f7:83f7 with SMTP id v22-20020a17090abb9600b00298b9f783f7mr7785720pjr.24.1709606825610;
        Mon, 04 Mar 2024 18:47:05 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090a051000b0029932d64c2bsm9500979pjh.17.2024.03.04.18.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 18:47:04 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 541E95FFF6; Mon,  4 Mar 2024 18:47:04 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 4C03C9FAAA;
	Mon,  4 Mar 2024 18:47:04 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Sam Sun <samsun1006219@gmail.com>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
    andy@greyhouse.net, davem@davemloft.net,
    Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
    pabeni@redhat.com
Subject: Re: [PATCH net] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
In-reply-to: <CAEkJfYP5T4Xv7vn7GZnQ7ig6_QZB8B_g-DS9dk7xhxRntYNY7g@mail.gmail.com>
References: <CAEkJfYP5T4Xv7vn7GZnQ7ig6_QZB8B_g-DS9dk7xhxRntYNY7g@mail.gmail.com>
Comments: In-reply-to Sam Sun <samsun1006219@gmail.com>
   message dated "Mon, 04 Mar 2024 17:53:03 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24640.1709606824.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Mar 2024 18:47:04 -0800
Message-ID: <24641.1709606824@famine>

Sam Sun <samsun1006219@gmail.com> wrote:

>Dear kernel developers and maintainers,
>
>We found a bug through our modified Syzkaller. In function
>bond_option_arp_ip_targets_set(), if newval->string is an empty
>string, newval->string+1 will point to the byte after the string,
>causing an out-of-bound read.  KASAN report is listed below.

	Conceptually, the change here seems fine.  However, I don't
think including the full KASAN report adds much to the description
above.

	Also, in the patch itself the line being added looks to have
been mangled (noted below).

>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
>Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
>
>CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc1/0x5e0 mm/kasan/report.c:475
> kasan_report+0xbe/0xf0 mm/kasan/report.c:588
> strlen+0x7d/0xa0 lib/string.c:418
> __fortify_strlen include/linux/fortify-string.h:210 [inline]
> in4_pton+0xa3/0x3f0 net/core/utils.c:130
> bond_option_arp_ip_targets_set+0xc2/0x910
>drivers/net/bonding/bond_options.c:1201
> __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
> __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
> bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
> bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:1=
56
> dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x96a/0xd80 fs/read_write.c:584
> ksys_write+0x122/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>RIP: 0033:0x7f797835cfcd
>Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
>89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007ffff464ffb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>RAX: ffffffffffffffda RBX: 00007ffff46501b8 RCX: 00007f797835cfcd
>RDX: 00000000000000f5 RSI: 0000000020000140 RDI: 0000000000000003
>RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff46501b8
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
>R13: 00007ffff46501a8 R14: 00007f79783da530 R15: 0000000000000001
> </TASK>
>
>Allocated by task 8107:
> kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> ____kasan_kmalloc mm/kasan/common.c:333 [inline]
> __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
> kasan_kmalloc include/linux/kasan.h:198 [inline]
> __do_kmalloc_node mm/slab_common.c:1007 [inline]
> __kmalloc_node_track_caller+0x5e/0xd0 mm/slab_common.c:1027
> kstrndup+0x72/0x110 mm/util.c:108
> bonding_sysfs_store_option+0x66/0x120 drivers/net/bonding/bond_sysfs.c:1=
53
> dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x96a/0xd80 fs/read_write.c:584
> ksys_write+0x122/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
>The buggy address belongs to the object at ffff8881119c4780
> which belongs to the cache kmalloc-32 of size 32
>The buggy address is located 0 bytes to the right of
> allocated 1-byte region [ffff8881119c4780, ffff8881119c4781)
>
>The buggy address belongs to the physical page:
>page:ffffea0004467100 refcount:1 mapcount:0 mapping:0000000000000000
>index:0xffff8881119c4fc1 pfn:0x1119c4
>flags: 0x57ff00000000800(slab|node=3D1|zone=3D2|lastcpupid=3D0x7ff)
>page_type: 0x3f()
>raw: 057ff00000000800 ffff888013040100 ffffea000405a650 ffffea0004156b90
>raw: ffff8881119c4fc1 ffff8881119c4000 000000010000003f 0000000000000000
>page dumped because: kasan: bad access detected
>page_owner tracks the page as allocated
>page last allocated via order 0, migratetype Unmovable, gfp_mask
>0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE),
>pid 25, tgid 25 (kworker/u6:0), ts 73787966798, free_ts 73774684635
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook+0x2d9/0x350 mm/page_alloc.c:1537
> prep_new_page mm/page_alloc.c:1544 [inline]
> get_page_from_freelist+0xd38/0x2fa0 mm/page_alloc.c:3312
> __alloc_pages+0x21d/0x21f0 mm/page_alloc.c:4568
> __alloc_pages_node include/linux/gfp.h:238 [inline]
> kmem_getpages mm/slab.c:1356 [inline]
> cache_grow_begin+0x9b/0x3c0 mm/slab.c:2550
> cache_alloc_refill+0x289/0x3a0 mm/slab.c:2923
> ____cache_alloc mm/slab.c:2999 [inline]
> ____cache_alloc mm/slab.c:2982 [inline]
> __do_cache_alloc mm/slab.c:3185 [inline]
> slab_alloc_node mm/slab.c:3230 [inline]
> __kmem_cache_alloc_node+0x374/0x420 mm/slab.c:3521
> __do_kmalloc_node mm/slab_common.c:1006 [inline]
> __kmalloc_node+0x50/0xd0 mm/slab_common.c:1014
> kmalloc_array_node include/linux/slab.h:698 [inline]
> kcalloc_node include/linux/slab.h:703 [inline]
> memcg_alloc_slab_cgroups+0x10e/0x210 mm/memcontrol.c:2968
> account_slab mm/slab.h:637 [inline]
> kmem_getpages mm/slab.c:1364 [inline]
> cache_grow_begin+0x349/0x3c0 mm/slab.c:2550
> cache_alloc_refill+0x289/0x3a0 mm/slab.c:2923
> ____cache_alloc mm/slab.c:2999 [inline]
> ____cache_alloc mm/slab.c:2982 [inline]
> __do_cache_alloc mm/slab.c:3182 [inline]
> slab_alloc_node mm/slab.c:3230 [inline]
> kmem_cache_alloc_node+0x3e1/0x4a0 mm/slab.c:3509
> alloc_task_struct_node kernel/fork.c:173 [inline]
> dup_task_struct kernel/fork.c:1110 [inline]
> copy_process+0x3f6/0x73e0 kernel/fork.c:2332
> kernel_clone+0xeb/0x8c0 kernel/fork.c:2907
> user_mode_thread+0xb4/0xf0 kernel/fork.c:2985
> call_usermodehelper_exec_work kernel/umh.c:172 [inline]
> call_usermodehelper_exec_work+0xd0/0x180 kernel/umh.c:158
> process_one_work+0x878/0x15c0 kernel/workqueue.c:2627
>page last free stack trace:
> reset_page_owner include/linux/page_owner.h:24 [inline]
> free_pages_prepare mm/page_alloc.c:1137 [inline]
> free_unref_page_prepare+0x4c5/0xa60 mm/page_alloc.c:2347
> free_unref_page+0x33/0x3d0 mm/page_alloc.c:2487
> rcu_do_batch kernel/rcu/tree.c:2158 [inline]
> rcu_core+0x817/0x1670 kernel/rcu/tree.c:2431
> __do_softirq+0x1d4/0x85e kernel/softirq.c:553
>
>Memory state around the buggy address:
> ffff8881119c4680: fa fb fb fb fc fc fc fc 00 01 fc fc fc fc fc fc
> ffff8881119c4700: 00 05 fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
>>ffff8881119c4780: 01 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
>                   ^
> ffff8881119c4800: 00 01 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8881119c4880: 00 fc fc fc fc fc fc fc 00 01 fc fc fc fc fc fc
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>We developed a patch to fix this problem. Check the string length
>first before calling in4_pton().
>
>Reported-by: Yue Sun <samsun1006219@gmail.com>
>Signed-off-by: Yue Sun <samsun1006219@gmail.com>
>
>diff --git a/drivers/net/bonding/bond_options.c
>b/drivers/net/bonding/bond_options.c
>index f3f27f0bd2a6..a6d01055f455 100644
>--- a/drivers/net/bonding/bond_options.c
>+++ b/drivers/net/bonding/bond_options.c
>@@ -1198,7 +1198,7 @@ static int bond_option_arp_ip_targets_set(struct
>bonding *bond,
>     __be32 target;
>
>     if (newval->string) {
>-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
>+        if (!strlen(newval->string) || !in4_pton(newval->string+1,
>-1, (u8 *)&target, -1, NULL)) {

	The text beginning with "-1," is a separate line, and something
messed up the tabs.  Also, this should be rewritten as

		if (!strlen(newval->string) ||
		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {

	to avoid a long line.

	-J

>             netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
>                    &target);
>             return ret;
>


---
	-Jay Vosburgh, jay.vosburgh@canonical.com

