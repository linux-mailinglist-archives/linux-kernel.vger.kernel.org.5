Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE4776248
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjHIOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjHIOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:22:27 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C31FDE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:22:26 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-564364d11adso4714719a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691590946; x=1692195746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mukwG1V/FIQiy6R5EBTSVQrZAqBmTIXdSIWdGLQeLQ=;
        b=d+GgdIiIkkw8m9eraGxrt1zUlsGO51tRujc0MOkcm6AlPLIwRNlyl30YblM87E45L+
         QImKekJzfp1HxQEp6F5hu8A4/83UFvEndHiPXMoHdPPq4eaBkQibNezLmH7K5O0aeN/b
         QDK56szl0PQDsKIy0tabLxcXDI3Q39QBXEf5B1voYYranhPKPoxD0Z+Zj0HnP7QQPY1E
         1oiTgoQwGUXQ+g/N5hgOAsXGyTo+oWlPl4o9Sar5K4aRyvMBAulwI20oKVzBYGccTr5p
         AfjQrRREaGE8yVS0/AyOTU+HiZWTGCV0w0GIIyPUV2siFHOAIF/mhNW6I7L05n0Ij2yb
         qwdA==
X-Gm-Message-State: AOJu0YyfFzTZIQ4+wreJhLX57Bgc/vwDahyz8udb6N1KVVVKC6VX5JI4
        6QjPEaeHwKMbDWVUPvfXNwYB7HRMhhjCgQGtpiqUSxcncsUa
X-Google-Smtp-Source: AGHT+IEeKgIEwOADJyXbgtPz2H6/g6Vqz1b4GNRCd4d3ObVXKpR8XPFjPOOLVS6tX70d/+QE2xaq4ukfT2U/W7LAVXqC20SllTbS
MIME-Version: 1.0
X-Received: by 2002:a63:3852:0:b0:563:fa95:3baf with SMTP id
 h18-20020a633852000000b00563fa953bafmr193155pgn.2.1691590945788; Wed, 09 Aug
 2023 07:22:25 -0700 (PDT)
Date:   Wed, 09 Aug 2023 07:22:25 -0700
In-Reply-To: <20230809110318.2110-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ddae806027e35c8@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: corrupted list in btrfs_close_devices

list_del corruption, ffff88801bc63020->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5637 Comm: syz-executor.5 Not tainted 6.5.0-rc5-next-20230807-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__list_del_entry_valid+0xfd/0x1b0 lib/list_debug.c:53
Code: 18 c3 48 c7 c7 80 8f c8 8a e8 5f 71 43 fd 0f 0b 48 c7 c7 e0 8f c8 8a e8 51 71 43 fd 0f 0b 48 c7 c7 40 90 c8 8a e8 43 71 43 fd <0f> 0b 48 89 ca 48 c7 c7 a0 90 c8 8a e8 32 71 43 fd 0f 0b 48 89 c2
RSP: 0018:ffffc9000558f8d0 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88801bc63000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a9732 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801bc63130
R13: ffffc9000558f928 R14: ffff88801bc63020 R15: ffff88801bc63028
FS:  00007fe3739386c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560da64aa048 CR3: 000000006a4e0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 btrfs_close_devices+0x460/0x790 fs/btrfs/volumes.c:1208
 btrfs_mount_root+0x6a0/0xe70 fs/btrfs/super.c:1542
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1588
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe372c7e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe373937ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe373937f80 RCX: 00007fe372c7e1ea
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007fe373937f40
RBP: 00000000200051c0 R08: 00007fe373937f80 R09: 0000000001000008
R10: 0000000001000008 R11: 0000000000000246 R12: 0000000020005200
R13: 00007fe373937f40 R14: 00000000000051ab R15: 0000000020000280
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid+0xfd/0x1b0 lib/list_debug.c:53
Code: 18 c3 48 c7 c7 80 8f c8 8a e8 5f 71 43 fd 0f 0b 48 c7 c7 e0 8f c8 8a e8 51 71 43 fd 0f 0b 48 c7 c7 40 90 c8 8a e8 43 71 43 fd <0f> 0b 48 89 ca 48 c7 c7 a0 90 c8 8a e8 32 71 43 fd 0f 0b 48 89 c2
RSP: 0018:ffffc9000558f8d0 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88801bc63000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816a9732 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88801bc63130
R13: ffffc9000558f928 R14: ffff88801bc63020 R15: ffff88801bc63028
FS:  00007fe3739386c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2d90255290 CR3: 000000006a4e0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1292aea5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1230fea5a80000

