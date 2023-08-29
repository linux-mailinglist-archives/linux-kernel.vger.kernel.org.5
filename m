Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734678C1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjH2JkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjH2Jj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:39:57 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF824E1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:39:53 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68bee35afe0so4475440b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301993; x=1693906793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkrIRuB/KPiotjwKowWNb1HI/98DR9xAPXUPa4EZXHE=;
        b=EFbeUpf0Rn7thckDahqSGaK16ddKSQbqXE0kxNuTYA8t1IZW0Hsc+o3Vdq+6g4sLBo
         meJDFtN+k/9ZMws1qkwC2PWgPgEKb6OBnkxjxEJUF/jFlHyVwhvAExQoogAyQsTb6gNK
         Ep0G/b9ulm+zryUNDm032rJWgtbIIvZG4x3+m92rclk+KkQe/0ohJCqF0sZKAvb6GycD
         tJlmHS1QlqKum4zkGABABIFp6aQBa2c+LqCS/ntJMU+lkyF08ijpgNEvOVm7oGs5+SWz
         l0mcVHrqJPhIiZ+/FFHyoWwoBavV8MVbHm3A49Rub5ae1w1IgQfd72+uz4yebox6oVxA
         mIjA==
X-Gm-Message-State: AOJu0YzyESahFKcBddJK6jBLGpUEf6AK1NuzV6rLkR6KpkUADCqzNJ3k
        C5AYZKqPHaCTuO8PcU0OpTRnnXxzpH8j/xAoxWLnRJUovA8R
X-Google-Smtp-Source: AGHT+IEdy+SdGk+xeL79w68etB+bpMNJdFi/Zg+lDXeT5igRdxr5vPtbLZDZoPGe/9Fh97TleRSOarPSGNJSggDQ6tT9LAX0TQa0
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1491:b0:68b:dfef:de87 with SMTP id
 v17-20020a056a00149100b0068bdfefde87mr5135810pfu.4.1693301993531; Tue, 29 Aug
 2023 02:39:53 -0700 (PDT)
Date:   Tue, 29 Aug 2023 02:39:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d26ff606040c9719@google.com>
Subject: [syzbot] [net?] [v9fs?] KCSAN: data-race in p9_fd_create /
 p9_fd_create (2)
From:   syzbot <syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, edumazet@google.com,
        ericvh@kernel.org, kuba@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    53663f4103ff Merge tag 'nfs-for-6.5-2' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103fc55fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f12c32a009b80107
dashboard link: https://syzkaller.appspot.com/bug?extid=e441aeeb422763cc5511
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f32101f0e8a2/disk-53663f41.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e577e9d7daf/vmlinux-53663f41.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af8ae7d4d06e/bzImage-53663f41.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in p9_fd_create / p9_fd_create

read-write to 0xffff888130fb3d48 of 4 bytes by task 15599 on cpu 0:
 p9_fd_open net/9p/trans_fd.c:842 [inline]
 p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 p9_client_create+0x595/0xa70 net/9p/client.c:1010
 v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 vfs_get_tree+0x51/0x190 fs/super.c:1519
 do_new_mount+0x203/0x660 fs/namespace.c:3335
 path_mount+0x496/0xb30 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff888130fb3d48 of 4 bytes by task 15563 on cpu 1:
 p9_fd_open net/9p/trans_fd.c:842 [inline]
 p9_fd_create+0x210/0x250 net/9p/trans_fd.c:1092
 p9_client_create+0x595/0xa70 net/9p/client.c:1010
 v9fs_session_init+0xf9/0xd90 fs/9p/v9fs.c:410
 v9fs_mount+0x69/0x630 fs/9p/vfs_super.c:123
 legacy_get_tree+0x74/0xd0 fs/fs_context.c:611
 vfs_get_tree+0x51/0x190 fs/super.c:1519
 do_new_mount+0x203/0x660 fs/namespace.c:3335
 path_mount+0x496/0xb30 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3861
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00008002 -> 0x00008802

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15563 Comm: syz-executor.3 Not tainted 6.5.0-rc7-syzkaller-00013-g53663f4103ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
