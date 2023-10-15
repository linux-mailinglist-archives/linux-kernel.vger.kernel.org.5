Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE957C97C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 05:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjJODhx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Oct 2023 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjJODhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 23:37:50 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E58D6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 20:37:48 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3ae3d83145cso5417126b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 20:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697341067; x=1697945867;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foF8w8a+Sc3aMYEjJANWw1plNPjcJQbPnL865dnxUWo=;
        b=fPGtBynphPTgE2NbZt5Ub/zF19wrSEiN7RK74/gC2OCRECLeyKJzXxkA9YMglEoL/b
         aN59/oUVO/Ukv2Rsa8vaI3IY7+YNA07hh472IvEhWLA5ISIwbwLa/NtdxcGYdHIoOICu
         sR9We4g6/XFxq9qXAo7wdKnWde7vgLN6Pc3yV9E4KXC/crADsc3y+xS7HXwSEkjniftT
         1imfVhq7PfBp+GbcnAsY1e8S+8O/seygR4Wn/3n92ZqzZBTtVanYkvO0h29vGEAWT5/T
         JHK8DWoWY/9/sUcoXuuCA8BOBCDlJnhVysTh9FOFWGE5J9+EVRVHxhvx7TzLwaNjW2So
         7UGw==
X-Gm-Message-State: AOJu0YzaOmRMV+9AxBwusRzM9lhw8qTpKZsqDyH2BA27HExeuEJHwJ+V
        bpik08qJ8sQQi2D+zJj7hQvY5g605YgKYg1vMcPsNqS5QszV
X-Google-Smtp-Source: AGHT+IGsyZ0CVZPQIKSBXE2Ngyt2bDz2pyzbCDr2Xsmei5tIBjt7D/9dE16CAQNT9YtnIs7GTSb7j6pgJXBjgsVW/asO6sA1JIcf
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2091:b0:3a1:c163:6022 with SMTP id
 s17-20020a056808209100b003a1c1636022mr1741075oiw.4.1697341067805; Sat, 14 Oct
 2023 20:37:47 -0700 (PDT)
Date:   Sat, 14 Oct 2023 20:37:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068c7730607b903b7@google.com>
Subject: [syzbot] [dri?] WARNING in drm_prime_fd_to_handle_ioctl
From:   syzbot <syzbot+0da81ccba2345eeb7f48@syzkaller.appspotmail.com>
To:     airlied@gmail.com, christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c8b86a3799f Merge tag 'xsa441-6.6-tag' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13005e31680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32d0b9b42ceb8b10
dashboard link: https://syzkaller.appspot.com/bug?extid=0da81ccba2345eeb7f48
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c48345680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101b3679680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45e9377886e9/disk-1c8b86a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9511a41a6d1e/vmlinux-1c8b86a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fac07e1c3c1a/bzImage-1c8b86a3.xz

The issue was bisected to:

commit 85e26dd5100a182bf8448050427539c0a66ab793
Author: Christian König <christian.koenig@amd.com>
Date:   Thu Jan 26 09:24:26 2023 +0000

    drm/client: fix circular reference counting issue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cf17f1680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16cf17f1680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12cf17f1680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0da81ccba2345eeb7f48@syzkaller.appspotmail.com
Fixes: 85e26dd5100a ("drm/client: fix circular reference counting issue")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5040 at drivers/gpu/drm/drm_prime.c:326 drm_gem_prime_fd_to_handle drivers/gpu/drm/drm_prime.c:326 [inline]
WARNING: CPU: 0 PID: 5040 at drivers/gpu/drm/drm_prime.c:326 drm_prime_fd_to_handle_ioctl+0x555/0x600 drivers/gpu/drm/drm_prime.c:374
Modules linked in:
CPU: 0 PID: 5040 Comm: syz-executor405 Not tainted 6.6.0-rc5-syzkaller-00055-g1c8b86a3799f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:drm_gem_prime_fd_to_handle drivers/gpu/drm/drm_prime.c:326 [inline]
RIP: 0010:drm_prime_fd_to_handle_ioctl+0x555/0x600 drivers/gpu/drm/drm_prime.c:374
Code: 89 df e8 0e 9b 26 fd f0 48 ff 03 e9 7e fd ff ff e8 b0 dc d0 fc 4c 89 f7 44 89 eb e8 75 73 8b 05 e9 da fe ff ff e8 9b dc d0 fc <0f> 0b e9 5d fd ff ff e8 3f 94 26 fd e9 3a fc ff ff 48 8b 7c 24 08
RSP: 0018:ffffc90003a5fc70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888018f14c00 RCX: 0000000000000000
RDX: ffff88801d691dc0 RSI: ffffffff84b6ea15 RDI: ffff8881476f3928
RBP: ffff88801fac5400 R08: 0000000000000007 R09: fffffffffffff000
R10: ffff8881476f3800 R11: 0000000000000000 R12: ffffc90003a5fe10
R13: ffff8881476f3800 R14: ffff88801c590c10 R15: 0000000000000000
FS:  00005555555d6380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555db75f4058 CR3: 0000000072209000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_ioctl_kernel+0x280/0x4c0 drivers/gpu/drm/drm_ioctl.c:789
 drm_ioctl+0x5cb/0xbf0 drivers/gpu/drm/drm_ioctl.c:892
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0c8214be69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6f4156f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0c8214be69
RDX: 0000000020000000 RSI: 00000000c00c642e RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0c821c3820 R14: 00007fff6f415720 R15: 00007fff6f415710
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
