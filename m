Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776E7EEBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 06:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjKQFBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 00:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjKQFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 00:01:31 -0500
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B9D4E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 21:01:25 -0800 (PST)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1cc323b2aa3so20269955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 21:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700197285; x=1700802085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQvfh3fUS45FJqBkwgsW0HmX/kTX5XXmTJsuDoFopEc=;
        b=J+5Akfg40X1Au2eawmNWfxiVHKZVXZdRDAGGu8Zqir2yCKw9b12/6SRjyGAQKjF/Wq
         S8hUp77H1+WLdvT66KvLmACL8PBChhgFTJmhzWYgA295TrbYJJy1zpmEOtFma07Vhr1K
         o/pLUqfRFEP1P1vorUA2CbKKdIjnQW4hRMGSjQ2I4OtAjNwOtcafPw0ZL7tBnmL2D3zr
         9p2cTqDa4lgmLGCgMWi28gQV8+tdL8WqEGAImVCVNYD1TKpXNpSkvIlE6ML65hIAv1nx
         X/+MskUSeEvXHq2gg05U1hjmD7zj+NqpuIKAy4uOMU0HjYwTAIqBJR6mYrZQQK1irapm
         3ABg==
X-Gm-Message-State: AOJu0Yxo33lFxJHefrzsmM7d3jmVqYGXnvQL7YYv+HYhT6XziUzOv2Qq
        463yrGGPlrTDcrPIS00gzXSQFfG/VXBUPBxfQu14xpJ99kYU
X-Google-Smtp-Source: AGHT+IEYNUY4GpTXRFjqfuw1ibibOrKXqtqhuysZhdRk1fDlr5pTKXWwqravtaLqAlhLIiY7/ss3borFG3D4K3S+/5Tcu2KguCeD
MIME-Version: 1.0
X-Received: by 2002:a17:903:25ce:b0:1cc:cc77:73bb with SMTP id
 jc14-20020a17090325ce00b001cccc7773bbmr2745106plb.13.1700197284931; Thu, 16
 Nov 2023 21:01:24 -0800 (PST)
Date:   Thu, 16 Nov 2023 21:01:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000376d93060a5207ed@google.com>
Subject: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_invalidate_range_start (3)
From:   syzbot <syzbot+c74f40907a9c0479af10@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b57b17e88bf5 Merge tag 'parisc-for-6.7-rc1-2' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14460084e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d950a2e2e34359e2
dashboard link: https://syzkaller.appspot.com/bug?extid=c74f40907a9c0479af10
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15785fc4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1469c9a8e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f611e08f3538/disk-b57b17e8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/035697c78f4a/vmlinux-b57b17e8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fd2581edc0c/bzImage-b57b17e8.xz

Bisection is inconclusive: the first bad commit could be any of:

d61ea1cb0095 userfaultfd: UFFD_FEATURE_WP_ASYNC
52526ca7fdb9 fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1338e5a8e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c74f40907a9c0479af10@syzkaller.appspotmail.com

kvm_intel: L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5071 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 __kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 [inline]
WARNING: CPU: 1 PID: 5071 at arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 kvm_mmu_notifier_invalidate_range_start+0x91b/0xa90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:811
Modules linked in:
CPU: 1 PID: 5071 Comm: syz-executor531 Not tainted 6.6.0-syzkaller-16201-gb57b17e88bf5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__kvm_handle_hva_range arch/x86/kvm/../../../virt/kvm/kvm_main.c:592 [inline]
RIP: 0010:kvm_mmu_notifier_invalidate_range_start+0x91b/0xa90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:811
Code: 1b 8c 7e 00 45 84 e4 0f 85 9f f8 ff ff e8 dd 90 7e 00 0f 0b e9 93 f8 ff ff e8 d1 90 7e 00 0f 0b e9 d9 fd ff ff e8 c5 90 7e 00 <0f> 0b e9 e6 fc ff ff e8 b9 90 7e 00 0f 0b e9 a9 fc ff ff e8 ad 90
RSP: 0018:ffffc90003877ac8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000020ffc000 RCX: ffffffff810a0d7b
RDX: ffff88807e9d1dc0 RSI: ffffffff810a141b RDI: 0000000000000006
RBP: ffffc90003877d60 R08: 0000000000000006 R09: 0000000020ffc000
R10: 0000000020ffc000 R11: ffffffff916014f0 R12: ffffc900015aea30
R13: 0000000000000001 R14: 0000000020ffc000 R15: ffffc900015b7810
FS:  00005555562b2380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7cef33ae0 CR3: 000000007bde5000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mn_hlist_invalidate_range_start mm/mmu_notifier.c:493 [inline]
 __mmu_notifier_invalidate_range_start+0x3b5/0x8e0 mm/mmu_notifier.c:548
 mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:457 [inline]
 do_pagemap_scan+0xbd3/0xcc0 fs/proc/task_mmu.c:2422
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f826e81d5e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc43d7c2d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc43d7c2e0 RCX: 00007f826e81d5e9
RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000005
RBP: 00007f826e890610 R08: 0000000000000000 R09: 68742f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc43d7c518 R14: 0000000000000001 R15: 0000000000000001
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
