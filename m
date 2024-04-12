Return-Path: <linux-kernel+bounces-141934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027F8A2548
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0EB1C2309E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725111A28C;
	Fri, 12 Apr 2024 04:44:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC48C13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897059; cv=none; b=DLDEdRGXe9bDpfa8PruJ2N/qzI7edl0TkmJoevKDrjbuAM+jEQqL6pFX7xQxyjvM41aRs3ucewHNsp07oGAYipNFR+LLw94+ZBHLrD1gc1fE1nushre9KQwB6XY/xiKomF7WPRYVnyEiw9CW1P9sh+BoElLBqi0Gguj9vzxfm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897059; c=relaxed/simple;
	bh=FhvTXwUAai1hqoc4Lk63Cx/KnDPdGaH5T8GcEZysPVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XKI8P895Mdc+9ecTNe7WNP3hJ131xq5GUMzWYYT2/1slXxoNxTlSTH8ItkGxBGKa3YGn+4DJbqu3uMIcdObZcZ6ZqcJQrNXMt5KLpFIT/C2db8d4iBk4nZJZRpPGn4XMJjgS7aFjqBj9GPFSTOI0GRAcUfjOFL5kEMVxAQgsCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36849578ac4so5329875ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712897057; x=1713501857;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAhQIXfW8xBEuSdDsNQsYph3pDu0nc5My/lHfZx4wT8=;
        b=nLZuYPJSrcfv1BdtXtxXUub7n4ChQMPKmjwWdGK530U715z1776FKcZT+MVNNYUVZT
         QYvYdAKobPjyxVrnaJhtRaFKbCOIOoEo74sAMsFm0SR7gwdF/iIFe83SOyE3eVvrikbN
         9YAsZMigKpR+x2RJzLbi2j5cQaISY0VsCsqpr3cn76hcEyINmuOLif1sRC9re5T7WwGJ
         a76TfXbU7TlpxsJPpe9ZAIywA0hK+SbVZJuLHzzLRJfyuSeaMTJVLK45hGJWMjGKPv8U
         EU3dymtktBrx6A8Uut7MkC9Cfg+pHybyQNyIPBAkUp6HIdwb2rkZrjklodzB504fQEGy
         bQcA==
X-Forwarded-Encrypted: i=1; AJvYcCW0MP7Jd/nqYIH7pXb/J3CXcbZQ8Rtqk2ymcP4DLn0zHgtjfkj0/U/Mk54QDw8UyFhHeyPVT5bai9RgYIodJ7dCXCF38zHVwA6jFUsj
X-Gm-Message-State: AOJu0Ywo5xEdU8FZm/dXb9Nqt3oiw5pdmy8Ogbq+RdrBaTNUpZQ9Zn9t
	lWIFjssh0j1GFFNoCTa0GRm3MGEE7rwTpg5MC6aN0EmcGgpmd8ihUpOFOOvMkEX2svF3/8Z7Cds
	LJSnXJwQr/Bb34kpMtMcONl+RDMMg++KlvsRjYrlwh4ojY3IDYP+WYlM=
X-Google-Smtp-Source: AGHT+IF6alcoFvLfVNjbSasjdrR1MuCme+6gYfCXpS05IZbrn+Nf5nfybhkMdPBUJm1+oTrceUbFfj/aT+OlmrAVzWWcyZzYMiHD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36b:214:bc2f with SMTP id
 j13-20020a92ca0d000000b0036b0214bc2fmr88964ils.3.1712897057088; Thu, 11 Apr
 2024 21:44:17 -0700 (PDT)
Date: Thu, 11 Apr 2024 21:44:17 -0700
In-Reply-To: <0000000000001e41e20615824081@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ffb1d0615deec6b@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __hci_req_sync
From: syzbot <syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    00dcf5d862e8 Merge tag 'acpi-6.9-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f84c93180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179a3b4d180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-00dcf5d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a72277e36da/vmlinux-00dcf5d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c529702b5e0/bzImage-00dcf5d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1227 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1224 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1251
Read of size 4 at addr ffff88801d9c3b24 by task syz-executor.2/5302

CPU: 3 PID: 5302 Comm: syz-executor.2 Not tainted 6.9.0-rc3-syzkaller-00189-g00dcf5d862e8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1227 [inline]
 __kfree_skb_reason net/core/skbuff.c:1224 [inline]
 kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1251
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x653/0x9c0 net/bluetooth/hci_core.c:790
 hci_sock_ioctl+0x4f3/0x8e0 net/bluetooth/hci_sock.c:1153
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f98e227dbcb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007fff8983d770 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f98e227dbcb
RDX: 00007fff8983d7e8 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 0000555556cf6430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000003 R14: 0000000000000001 R15: 00000000fffffff1
 </TASK>

Allocated by task 5308:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2063
 hci_send_cmd_sync net/bluetooth/hci_core.c:4220 [inline]
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4240
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5308:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 hci_req_sync_complete+0x16c/0x270 net/bluetooth/hci_request.c:109
 hci_event_packet+0x963/0x1170 net/bluetooth/hci_event.c:7604
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88801d9c3a40
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff88801d9c3a40, ffff88801d9c3b30)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d9c2
head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015b8e000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015b8e000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000001 ffffea0000767081 dead000000000122 00000000ffffffff
head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5314, tgid 5314 (kworker/u33:8), ts 1081717469726, free_ts 1081659697828
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2063
 hci_send_cmd_sync net/bluetooth/hci_core.c:4220 [inline]
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4240
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 5294 tgid 5294 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmalloc_trace+0x147/0x330 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0xcb6/0x2180 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x193/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xef9/0x2020 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12e/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x65/0xb0 security/security.c:1191
 search_binary_handler fs/exec.c:1766 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve fs/exec.c:1872 [inline]
 bprm_execve+0x642/0x19b0 fs/exec.c:1848
 do_execveat_common.isra.0+0x5cb/0x750 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2124
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff88801d9c3a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88801d9c3a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801d9c3b00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff88801d9c3b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d9c3c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

