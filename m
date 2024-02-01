Return-Path: <linux-kernel+bounces-48003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97984560C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AF61F2BAA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7173D15D5C8;
	Thu,  1 Feb 2024 11:10:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E324D9EC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785833; cv=none; b=HzSYhQFeq8zc/KVh01P0ZrpD4T8XqR5s8TAF3uIY2X3UxVmbMzp8/W7BzwiJDgGMJvX8RuE3WOthc23YAP3sdSjrAgrLSzRb1+56vKV+LiRUgUZbbzsDrdzmNLn3P6WxPB/Nwc2323QmVTxdrFvhge3meZaAEjahRYmG1z5MkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785833; c=relaxed/simple;
	bh=MR32wlPdFj4reI0h5wtauZEe++OecNMO82JpJCzlCxU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XMRFysPwPEuQ4U48AzN+9awjNhipsHp0Xc2SDJ1V41ocSvzkMwCoomHBEtTrIVSn3IBxTKDu9JcI5+A4ZVXFG/fPLDZYVhke5OLDwgfTIdS8mfLL7tFuKf3nDhb4wHb5F2EroROc0AuoB0YuChTefbyC8aU9MgJuq5J4cGpaxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so79803039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706785830; x=1707390630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjaEiq2pWlyCI1KFg/OKwz03Z3t0rKmfmFaJtUF2VUI=;
        b=w5C75PsDABKelitVNdMFya7fNLb/gXlRS0vzYNAIdEakcDgQWXJvj2G00Y5KgBLRFb
         EUm9BCDTIDXSfl/MNyTXAvLkMEyjngmvFXq8GD9Ah+lB7XJo1cQctnf0kvgb48cwayGp
         m/toAW2rtQamIGbiCOlOHmTARCJWDkO6tyr6IVGWS/kjkc32Yx+pG2J0CHSSsvCNojJr
         9A9DLX4Pf6eXfXrDs7vJw3aNfhG8eUTOsVqbVRj5NZTf2Ahvgg9ofShU4VWCy2mu/4cb
         LGEF3/Lvkws+sp4GOe1YyhQUqJT6l/+zQIBuwKFvv6aNpcZZ+R2NCs51VGXLtWrPLRrj
         qqsQ==
X-Gm-Message-State: AOJu0Yz7ujNRRgo9SLi+/EZow+MZC9BfkbXh4qt6U6doVbj4tbFNxz8J
	AQnuVuHi10uX3VUP0og57TJlJ35+XyDhB2cqEooBdSMjKIKAxc8O+a24w8FR/JUDjSJ3xr4fB62
	f3i1/Un3uYPYGGWr7NGSB570bdsP+3VGvaBLss58OLa18PoDs7WwrXdg=
X-Google-Smtp-Source: AGHT+IEFE/nxFyPm0mI0pD4IWQWwsE1OOK4FKNjdRxCUZYB9l4l1A3QUUrDJi11l8uDdfXJd97B5sD0wr3PjlKh+z0nSluH/7BvO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ab83:0:b0:470:b28b:7610 with SMTP id
 t3-20020a02ab83000000b00470b28b7610mr42881jan.0.1706785828996; Thu, 01 Feb
 2024 03:10:28 -0800 (PST)
Date: Thu, 01 Feb 2024 03:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b8cf30610500bf9@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __delete_from_swap_cache /
 folio_mapping (2)
From: syzbot <syzbot+cf119d1637f0bd53608c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1bbb19b6eb1b Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f1c72fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aab723d3dfffc44
dashboard link: https://syzkaller.appspot.com/bug?extid=cf119d1637f0bd53608c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f79e8ff3cf7/disk-1bbb19b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca27972976b4/vmlinux-1bbb19b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dce27549b82b/bzImage-1bbb19b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf119d1637f0bd53608c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __delete_from_swap_cache / folio_mapping

write to 0xffffea0004e7c468 of 8 bytes by task 24368 on cpu 1:
 __delete_from_swap_cache+0x1f2/0x290 mm/swap_state.c:160
 delete_from_swap_cache+0x72/0xd0 mm/swap_state.c:240
 folio_free_swap+0x19f/0x1c0 mm/swapfile.c:1590
 do_swap_page+0xaf3/0x1530 mm/memory.c:4052
 handle_pte_fault mm/memory.c:5147 [inline]
 __handle_mm_fault mm/memory.c:5285 [inline]
 handle_mm_fault+0x7f6/0x27c0 mm/memory.c:5450
 do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x401/0x6d0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

read to 0xffffea0004e7c468 of 8 bytes by task 24369 on cpu 0:
 folio_mapping+0xca/0x110 mm/util.c:780
 folio_evictable mm/internal.h:162 [inline]
 move_folios_to_lru+0x132/0x690 mm/vmscan.c:1801
 shrink_active_list+0x580/0x820 mm/vmscan.c:2069
 shrink_list mm/vmscan.c:2149 [inline]
 shrink_lruvec+0x993/0x17a0 mm/vmscan.c:5681
 shrink_node_memcgs mm/vmscan.c:5867 [inline]
 shrink_node+0xac3/0x15d0 mm/vmscan.c:5902
 shrink_zones mm/vmscan.c:6141 [inline]
 do_try_to_free_pages+0x43d/0xce0 mm/vmscan.c:6203
 try_to_free_mem_cgroup_pages+0x1e2/0x480 mm/vmscan.c:6518
 try_charge_memcg+0x280/0xd20 mm/memcontrol.c:2777
 obj_cgroup_charge_pages+0xbd/0x1c0 mm/memcontrol.c:3296
 __memcg_kmem_charge_page+0x9c/0x170 mm/memcontrol.c:3322
 __alloc_pages+0x1bb/0x340 mm/page_alloc.c:4584
 alloc_pages_mpol+0xb1/0x1d0 mm/mempolicy.c:2133
 alloc_pages+0xe0/0x100 mm/mempolicy.c:2204
 vm_area_alloc_pages mm/vmalloc.c:3063 [inline]
 __vmalloc_area_node mm/vmalloc.c:3139 [inline]
 __vmalloc_node_range+0x6ee/0xec0 mm/vmalloc.c:3320
 kvmalloc_node+0x121/0x170 mm/util.c:642
 kvmalloc include/linux/slab.h:728 [inline]
 xt_alloc_table_info+0x3d/0x80 net/netfilter/x_tables.c:1192
 do_replace net/ipv6/netfilter/ip6_tables.c:1139 [inline]
 do_ip6t_set_ctl+0x633/0x1800 net/ipv6/netfilter/ip6_tables.c:1636
 nf_setsockopt+0x18d/0x1b0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x11c/0x130 net/ipv6/ipv6_sockglue.c:997
 tcp_setsockopt+0x90/0xa0 net/ipv4/tcp.c:3724
 sock_common_setsockopt+0x61/0x70 net/core/sock.c:3716
 do_sock_setsockopt net/socket.c:2311 [inline]
 __sys_setsockopt+0x1d4/0x240 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x0000000000001805 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 24369 Comm: syz-executor.4 Not tainted 6.8.0-rc2-syzkaller-00047-g1bbb19b6eb1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

