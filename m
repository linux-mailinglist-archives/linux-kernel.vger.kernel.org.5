Return-Path: <linux-kernel+bounces-12253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACA81F1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB641F230CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADE47F78;
	Wed, 27 Dec 2023 20:51:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557ED481A4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3601c1b80d3so9881015ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703710278; x=1704315078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RH1fku3ryMWl5b9TQPsta4gwjT0JdL0o1tj9ksa+sc=;
        b=XGtGJjUCASxFTnOKvcApdwDO5LnFWNWiL2LIBkxjGKcy/GWvlsY+w0KeT8To0JkJIT
         Istunx5Zl1yEeueZb0NU/uP4ClgD2gK07CMApmolAn9TPZpWPVxcGstJdlUXl5n0kE6V
         EiVeetkAcdrUdcehlkP52EiEEFa1wc5eiPhBNRy+eSl/bO5gHFiKDtKUyPMas+0iuARy
         Bx0zEeQotPOU8V8NPz5Yvz9cZ2alMm6LQ8ouYJFwuVwQB39TP0mVfkKkvpp/jwx4kSFR
         2S5Z11EPaG7ch7Ktpu4gU6t6CWSxCQyLFkkg2cvk0ioOp4hco5rKW09nijnhhl7ECD7J
         CrIw==
X-Gm-Message-State: AOJu0YwYMMKfvo85c23ICnGs6YP5O0gRn33nmeCcH5EOPkfQJdjkDhlZ
	OqdYtoZr+OLlZS0BYxZcxdCE5KVYfo9wMJ2gqvW79JZ2XvJI
X-Google-Smtp-Source: AGHT+IGEybVICjOUX9vJrIn3vsaTDFrBGnGLBuGyYO3KpsmGmcX5pyhDob4xgjJ+ckmag9X3Q7pKJU3Y6cDN0rvpfuWwemWyUZn5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c548:0:b0:35f:f01e:bb18 with SMTP id
 a8-20020a92c548000000b0035ff01ebb18mr1252426ilj.6.1703710278611; Wed, 27 Dec
 2023 12:51:18 -0800 (PST)
Date: Wed, 27 Dec 2023 12:51:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4faa2060d83f582@google.com>
Subject: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
From: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
To: airlied@gmail.com, akinobu.mita@gmail.com, akpm@linux-foundation.org, 
	christian.koenig@amd.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	jgg@nvidia.com, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, 
	tzimmermann@suse.de, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5254c0cbc92d Merge tag 'block-6.7-2023-12-22' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10cc6995e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e35809e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d5fd6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebe09a5995ee/disk-5254c0cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02178d7f5f98/vmlinux-5254c0cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12307f47d87c/bzImage-5254c0cb.xz

The issue was bisected to:

commit ea4452de2ae987342fadbdd2c044034e6480daad
Author: Qi Zheng <zhengqi.arch@bytedance.com>
Date:   Fri Nov 18 10:00:11 2022 +0000

    mm: fix unexpected changes to {failslab|fail_page_alloc}.attr

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13027f76e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10827f76e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17027f76e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com
Fixes: ea4452de2ae9 ("mm: fix unexpected changes to {failslab|fail_page_alloc}.attr")

R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe98069194
R13: 00007efe97fd2210 R14: 0000000000000002 R15: 6972642f7665642f
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5107 at drivers/gpu/drm/drm_prime.c:227 drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227
Modules linked in:
CPU: 0 PID: 5107 Comm: syz-executor227 Not tainted 6.7.0-rc6-syzkaller-00248-g5254c0cbc92d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 21 48 8b 83 90 00 00 00 48 85 c0 75 06 5b e9 13 f1 93 fc e8 0e f1 93 fc 90 <0f> 0b 90 5b e9 04 f1 93 fc e8 3f 9b ea fc eb d8 66 66 2e 0f 1f 84
RSP: 0018:ffffc90003bdf9e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888019f28378 RCX: ffffc90003bdf9b0
RDX: ffff888018ff9dc0 RSI: ffffffff84f380c2 RDI: ffff888019f28408
RBP: ffff888019f28000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f193a57 R11: 0000000000000000 R12: ffff88814829a000
R13: ffff888019f282a8 R14: ffff88814829a068 R15: ffff88814829a0a0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efe98050410 CR3: 000000006d1ff000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_file_free.part.0+0x738/0xb90 drivers/gpu/drm/drm_file.c:290
 drm_file_free drivers/gpu/drm/drm_file.c:247 [inline]
 drm_close_helper.isra.0+0x180/0x1f0 drivers/gpu/drm/drm_file.c:307
 drm_release+0x22a/0x4f0 drivers/gpu/drm/drm_file.c:494
 __fput+0x270/0xb70 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:869
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
 get_signal+0x23b5/0x2790 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7efe98014769
Code: Unable to access opcode bytes at 0x7efe9801473f.
RSP: 002b:00007efe97fd2208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007efe9809c408 RCX: 00007efe98014769
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007efe9809c408
RBP: 00007efe9809c400 R08: 0000000000003131 R09: 0000000000003131
R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe98069194
R13: 00007efe97fd2210 R14: 0000000000000002 R15: 6972642f7665642f
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

