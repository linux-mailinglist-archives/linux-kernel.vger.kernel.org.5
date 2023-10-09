Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6C7BEB4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378561AbjJIUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378555AbjJIUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:09:48 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C9AA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:09:46 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6c4d128e090so6852439a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882185; x=1697486985;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vdk/s0cRW1gT3irTEZ17OEvDFCD/HvOZqWIKEfeeFxk=;
        b=jx1IbDRIZ1yPUXD+p0ELw72YC/LAQLJwvEfZKvI7EGmq2E12KZ9f0XoW/6sSYAtHSa
         SkJ9LfOH50ID2SomPmC/yMohRARcOUS/qP6R3SdLGbTn4KAGTW8tVQEKDgnz0fth95y9
         muMoxvqtdzkb3vcMXOmngIEVv5TuIPqAGHZlMkZSxkyMTqmwCrrv8iruWNy3Ey1MXqGu
         3iQ9uoHHf5CfjwvaS9QKNsDeShAL4rIvmE+5xAEAmgWZ4R8GHt/hCblp+WAFTS7d/RaS
         AWuZzRh0bcJHxIIsZVKDt4P0zrh6VN/LuKY4ZYdsOPYgscZn8zQY9O+tcJjwfRVV6ZOQ
         UWjA==
X-Gm-Message-State: AOJu0YxSwvXeLUmdFKHSdzFYKRBGdm9Aw0YZEQjoymg4YHFKW02s5huE
        VsCJme9wJRldOZlJaT9iaUDMbyojET8yfEQn6Fj0cs31PSfC
X-Google-Smtp-Source: AGHT+IFIG1BHSYIUplQLFd/iGd96P8h7DQ4/qzR45dskjrKAVrNZRIDWumuU7+lVTrCTVkhYxwHSAvLT0zINvQLstXsa6ATzOVKF
MIME-Version: 1.0
X-Received: by 2002:a05:6870:769b:b0:1e1:1e68:ba3d with SMTP id
 dx27-20020a056870769b00b001e11e68ba3dmr6212784oab.7.1696882185433; Mon, 09
 Oct 2023 13:09:45 -0700 (PDT)
Date:   Mon, 09 Oct 2023 13:09:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3788c06074e2b84@google.com>
Subject: [syzbot] [net?] [wireless?] possible deadlock in rfkill_send_events
From:   syzbot <syzbot+509238e523e032442b80@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f291209eca5e Merge tag 'net-6.6-rc5' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1139f1be680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b89b61abf7449972
dashboard link: https://syzkaller.appspot.com/bug?extid=509238e523e032442b80
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1103ec86680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118b6bda680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b2add3a29c7/disk-f291209e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a15a9498899/vmlinux-f291209e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f39062509f32/bzImage-f291209e.xz

The issue was bisected to:

commit 2c3dfba4cf84ac4f306cc6653b37b6dd6859ae9d
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Sep 14 13:45:17 2023 +0000

    rfkill: sync before userspace visibility/changes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13967b3a680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10567b3a680000
console output: https://syzkaller.appspot.com/x/log.txt?x=17967b3a680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+509238e523e032442b80@syzkaller.appspotmail.com
Fixes: 2c3dfba4cf84 ("rfkill: sync before userspace visibility/changes")

============================================
WARNING: possible recursive locking detected
6.6.0-rc4-syzkaller-00158-gf291209eca5e #0 Not tainted
--------------------------------------------
syz-executor675/5132 is trying to acquire lock:
ffff8880297ee088 (&data->mtx){+.+.}-{3:3}, at: rfkill_send_events+0x226/0x3f0 net/rfkill/core.c:286

but task is already holding lock:
ffff88801bfc0088 (&data->mtx){+.+.}-{3:3}, at: rfkill_fop_open+0x146/0x750 net/rfkill/core.c:1183

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&data->mtx);
  lock(&data->mtx);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor675/5132:
 #0: ffffffff8d6f39e8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
 #1: ffffffff8ea7fa68 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_open+0x13c/0x750 net/rfkill/core.c:1182
 #2: ffff88801bfc0088 (&data->mtx){+.+.}-{3:3}, at: rfkill_fop_open+0x146/0x750 net/rfkill/core.c:1183

stack backtrace:
CPU: 1 PID: 5132 Comm: syz-executor675 Not tainted 6.6.0-rc4-syzkaller-00158-gf291209eca5e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2971/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x181/0x1340 kernel/locking/mutex.c:747
 rfkill_send_events+0x226/0x3f0 net/rfkill/core.c:286
 rfkill_event net/rfkill/core.c:301 [inline]
 rfkill_event net/rfkill/core.c:293 [inline]
 rfkill_set_block+0x3d0/0x550 net/rfkill/core.c:369
 rfkill_sync net/rfkill/core.c:379 [inline]
 rfkill_sync+0x10a/0x1c0 net/rfkill/core.c:372
 rfkill_fop_open+0x1d6/0x750 net/rfkill/core.c:1193
 misc_open+0x3da/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x277/0x700 fs/char_dev.c:414
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8b31dbc989
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1e 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b31f5ccc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8b31e3c4c8 RCX: 00007f8b31dbc989
RDX: 0000000000000801 RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f8b31f5c7f0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f8b31f5cd00 R14: 00007f8b31f5cd40 R15: 0000000000000000
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
