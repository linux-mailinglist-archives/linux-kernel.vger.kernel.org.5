Return-Path: <linux-kernel+bounces-109824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA6885628
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B18EB21946
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49744C629;
	Thu, 21 Mar 2024 09:01:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03352209F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011690; cv=none; b=EEKlG/ehw7+UZuTMyJv0z8eXYUPMezUu3zaecB4CPU1dlqKVOqG6ryI1K7u0h9c/ZzghHybaqwzD+jQCqCtkJ08Qo1gq1JoQWXCiL7+wOhO0xcxliIyKUKotIPMgtsoCr/ZRW5dyYEJ5qOlKMeKC3iK2YVX51MWcpkKVGcCvV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011690; c=relaxed/simple;
	bh=WCVRaPCR4U/UaWO/C2Ofrsna8iAnF+mkFtDhk2Nziyk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YWkLpM1Y45XCxQHrDa/74snI3BeJRfGU5s+ugDe7BhWnWUYm5iOytWap+fFSI0ODLZDobulgz+pyWI8mIDZcAc8YgtN+PjEtY4Vm8xbqFi4ZRH0lmjZS8XUYV2fzFX1ry31TJaYbkXlPqGlENygtvwnhqywCwbreF5vG6GcyDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cb806fc9f7so75782939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011688; x=1711616488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEdQFGDdkHClnAdzEq+D+vcocFQ9IkwJONhs+T9p4xc=;
        b=dNcWwcA/YYz+Zz7pe0+NNIf4St8BF1vUGzZab9lbEPTTAMwreG1AElmLI4oMjnd39S
         UOYrhd5LRsExRedOvyhBfKd7HkQyRrIdlWtye1+bdBJ02zWXAShRAEi1+9CoON1Wr3FY
         2kJsCGGNu6fMK8w8iORE+2YC5F7bqymaUjJxV3TWIzSnD5jYeDIhWZagvBaOxgWKXXY1
         6t4n1sWLPoluwIaspiVKuz+sedO8Xzj1t1D8lUFRc4PVFR/f5eFS97CCfgjUbdgpkzLt
         aZ451EyZdYYS6PPn2SJMzOk4G2g+ZUKyS2pAeVgKXoxM379fZJ+d5nSyjYiG1MomU5hh
         AqVw==
X-Forwarded-Encrypted: i=1; AJvYcCVnRg0anprS6nWoSYgmYR53dCKwGa/CHOkEI5bJwG+4K5GSfulfhGcKZJYt0dKXrFupHOu2kSaqtrdF5CxiF0J4bWudbah9UyuvQH/+
X-Gm-Message-State: AOJu0Ywsfyqq7DiR8RqrnOhEwXLd2IQx1mNETwe4LL8Z39Z1nJUJh5nT
	E6KBuAIrWmCBcHrmRwruSi/LOEpGDVUfM0hxdKaW/7pX7RFR93E3zLpepTtPdYCyHNS0bqbDrK9
	WdoSmK2zU74Vd0RXNckzD3sI3/OHhco7pQMANLjavyvXe/xDyHRL7mtI=
X-Google-Smtp-Source: AGHT+IHhZyQJuxD69mTUwS3hPVGJVOJpDg9KcngqWJzDT0PU3vEZSOdENrP0TP8oAtzRvl3Cy2B73Mgys+WP+th8j0GJMp1HXcOL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:474:fce1:3f8c with SMTP id
 i3-20020a05663813c300b00474fce13f8cmr436293jaj.6.1711011687855; Thu, 21 Mar
 2024 02:01:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:01:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc8ad7061427f3cd@google.com>
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run2
From: syzbot <syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    520fad2e3206 selftests/bpf: scale benchmark counting by us..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b967b9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=2cb5a6c573e98db598cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257dd85180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b55c6e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4eef3506c5ce/disk-520fad2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24d60ebe76cc/vmlinux-520fad2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f883e706550/bzImage-520fad2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run2+0xfa/0x530 kernel/trace/bpf_trace.c:2431
Read of size 8 at addr ffff88802aaea218 by task syz-executor147/10463

CPU: 0 PID: 10463 Comm: syz-executor147 Not tainted 6.8.0-syzkaller-05233-g520fad2e3206 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
 bpf_trace_run2+0xfa/0x530 kernel/trace/bpf_trace.c:2431
 __traceiter_kfree+0x2b/0x50 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x291/0x380 mm/slub.c:4396
 tomoyo_realpath_from_path+0xc2/0x5e0 security/tomoyo/realpath.c:250
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x69/0x570 security/security.c:2933
 do_dentry_open+0x327/0x15a0 fs/open.c:943
 do_open fs/namei.c:3643 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3800
 do_filp_open+0x235/0x490 fs/namei.c:3827
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2308d06f51
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 3a 91 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007fffb8a33850 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007f2308d06f51
RDX: 0000000000080001 RSI: 00007f2308d51022 RDI: 00000000ffffff9c
RBP: 00007f2308d51022 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffb8a338f0
R13: 00007fffb8a33dcc R14: 00007fffb8a33de0 R15: 00007fffb8a33dd0
 </TASK>

Allocated by task 10462:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3816
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3863
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5673
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 10462:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
 __fput+0x429/0x8a0 fs/file_table.c:423
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff88802aaea200
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff88802aaea200, ffff88802aaea280)

The buggy address belongs to the physical page:
page:ffffea0000aaba80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2aaea
ksm flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c418c0 ffffea000070d080 0000000000000003
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6819, tgid 6819 (syz-executor147), ts 85383852364, free_ts 85383700647
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node_track_caller+0x2d4/0x4e0 mm/slub.c:4001
 __do_krealloc mm/slab_common.c:1187 [inline]
 krealloc+0x7d/0x120 mm/slab_common.c:1220
 copy_array kernel/bpf/verifier.c:1220 [inline]
 copy_stack_state kernel/bpf/verifier.c:1274 [inline]
 copy_func_state kernel/bpf/verifier.c:1407 [inline]
 copy_verifier_state+0x95a/0xf30 kernel/bpf/verifier.c:1451
 is_state_visited kernel/bpf/verifier.c:17435 [inline]
 do_check+0x4327/0x10500 kernel/bpf/verifier.c:17597
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20497
 do_check_main kernel/bpf/verifier.c:20588 [inline]
 bpf_check+0x136ab/0x190c0 kernel/bpf/verifier.c:21258
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
page last free pid 6819 tgid 6819 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 vfree+0x186/0x2e0 mm/vmalloc.c:2914
 bpf_prog_calc_tag+0x663/0x900 kernel/bpf/core.c:357
 resolve_pseudo_ldimm64+0xe2/0x1650 kernel/bpf/verifier.c:18191
 bpf_check+0x6175/0x190c0 kernel/bpf/verifier.c:21244
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff88802aaea100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802aaea180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802aaea200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802aaea280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802aaea300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

