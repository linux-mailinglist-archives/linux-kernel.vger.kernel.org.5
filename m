Return-Path: <linux-kernel+bounces-14446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB9821D29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19741C22210
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E010979;
	Tue,  2 Jan 2024 13:55:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60216FC0A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b89d5c71dcso1320922739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704203719; x=1704808519;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHgT/7dzE/CRHUEYKAyqVtxx1vbF4LkNYh6Yolsca50=;
        b=YzlXX1yvhu11G/HS7XYzm9/Gt2idrf6l1gddt20LVOl9JCvZ3mlMFAyMaDnouHySQ2
         iME6dIZ6X15aXucuPPQOPQkMH5r0nxu5lE4/Bv03e56gha9dvIkXl4pv2W7dEfsaal8y
         jpI+8LZ/ZDfb0oLPNBjkdC+Tg9lfg3r2KTkC/gHPYDvidpS+4h8/ST/5cNgUtpq1ddLF
         8722omECa3CA4Gjokkz6wmCA3mCY69VSbFobil4xGvfh22Q4oLSg/fcrNqnDz+nP5tef
         Eo85vxfGRHXzQvvTNElETdkFoPCoPls1fQRjFEUcltZwvB2iRVptahyqseikThxXSCq7
         nOuw==
X-Gm-Message-State: AOJu0YwXFA5XeeQhaDKkDLRywhCKqbQZRP4qB2y3s61cbQq4hXAsq1dH
	j0MjrBUOKeDFk82UqUPU6ZhCtUnVaqXs26fw9fWN+m1loKdr
X-Google-Smtp-Source: AGHT+IGvVaADsw+rLv6nwp6HYruKTYPQAtnI+Adc3Md/R0JsR3M8yj+pCedF6Ui72GlixQm1OK4smaQFlKULoNlgfFQfz5smHMvy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b05:b0:46c:dcd2:64a0 with SMTP id
 fm5-20020a0566382b0500b0046cdcd264a0mr553035jab.3.1704203718249; Tue, 02 Jan
 2024 05:55:18 -0800 (PST)
Date: Tue, 02 Jan 2024 05:55:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000405425060df6d9f3@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in shrinker_alloc
From: syzbot <syzbot+1e0ed05798af62917464@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2da77f431ac Merge tag 'parisc-for-6.7-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16aec608e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=1e0ed05798af62917464
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1712ebc8e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c6f2e6a124d/disk-d2da77f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c53690e51338/vmlinux-d2da77f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0799b7d74db/bzImage-d2da77f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e0ed05798af62917464@syzkaller.appspotmail.com

RBP: 00007f43defc4120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f43de39bf80 R15: 00007f43de4bfa48
 </TASK>
=====================================================
BUG: KMSAN: uninit-value in shrinker_unit_free mm/shrinker.c:33 [inline]
BUG: KMSAN: uninit-value in shrinker_unit_alloc mm/shrinker.c:52 [inline]
BUG: KMSAN: uninit-value in expand_one_shrinker_info mm/shrinker.c:136 [inline]
BUG: KMSAN: uninit-value in expand_shrinker_info mm/shrinker.c:165 [inline]
BUG: KMSAN: uninit-value in shrinker_memcg_alloc mm/shrinker.c:227 [inline]
BUG: KMSAN: uninit-value in shrinker_alloc+0xd7c/0x1100 mm/shrinker.c:697
 shrinker_unit_free mm/shrinker.c:33 [inline]
 shrinker_unit_alloc mm/shrinker.c:52 [inline]
 expand_one_shrinker_info mm/shrinker.c:136 [inline]
 expand_shrinker_info mm/shrinker.c:165 [inline]
 shrinker_memcg_alloc mm/shrinker.c:227 [inline]
 shrinker_alloc+0xd7c/0x1100 mm/shrinker.c:697
 alloc_super+0x9a6/0xf00 fs/super.c:386
 sget_fc+0x36b/0xf80 fs/super.c:797
 vfs_get_super fs/super.c:1333 [inline]
 get_tree_nodev+0x48/0x340 fs/super.c:1357
 mqueue_get_tree+0xff/0x1c0 ipc/mqueue.c:435
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 fc_mount+0x33/0x110 fs/namespace.c:1114
 mq_create_mount ipc/mqueue.c:485 [inline]
 mq_init_ns+0x51c/0x760 ipc/mqueue.c:1700
 create_ipc_ns ipc/namespace.c:73 [inline]
 copy_ipcs+0x4b3/0xa40 ipc/namespace.c:112
 create_new_namespaces+0x3ad/0xdb0 kernel/nsproxy.c:90
 unshare_nsproxy_namespaces+0x17a/0x2b0 kernel/nsproxy.c:228
 ksys_unshare+0x8fa/0x1340 kernel/fork.c:3433
 __do_sys_unshare kernel/fork.c:3504 [inline]
 __se_sys_unshare kernel/fork.c:3502 [inline]
 __x64_sys_unshare+0x48/0x70 kernel/fork.c:3502
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x11c/0x3c0 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:617
 expand_one_shrinker_info mm/shrinker.c:129 [inline]
 expand_shrinker_info mm/shrinker.c:165 [inline]
 shrinker_memcg_alloc mm/shrinker.c:227 [inline]
 shrinker_alloc+0x606/0x1100 mm/shrinker.c:697
 alloc_super+0x9a6/0xf00 fs/super.c:386
 sget_fc+0x36b/0xf80 fs/super.c:797
 vfs_get_super fs/super.c:1333 [inline]
 get_tree_nodev+0x48/0x340 fs/super.c:1357
 mqueue_get_tree+0xff/0x1c0 ipc/mqueue.c:435
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 fc_mount+0x33/0x110 fs/namespace.c:1114
 mq_create_mount ipc/mqueue.c:485 [inline]
 mq_init_ns+0x51c/0x760 ipc/mqueue.c:1700
 create_ipc_ns ipc/namespace.c:73 [inline]
 copy_ipcs+0x4b3/0xa40 ipc/namespace.c:112
 create_new_namespaces+0x3ad/0xdb0 kernel/nsproxy.c:90
 unshare_nsproxy_namespaces+0x17a/0x2b0 kernel/nsproxy.c:228
 ksys_unshare+0x8fa/0x1340 kernel/fork.c:3433
 __do_sys_unshare kernel/fork.c:3504 [inline]
 __se_sys_unshare kernel/fork.c:3502 [inline]
 __x64_sys_unshare+0x48/0x70 kernel/fork.c:3502
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5127 Comm: syz-executor.1 Not tainted 6.7.0-rc2-syzkaller-00265-gd2da77f431ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
=====================================================


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

