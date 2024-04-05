Return-Path: <linux-kernel+bounces-133435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403989A3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E121C21B34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52483172777;
	Fri,  5 Apr 2024 17:40:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72A172769
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338832; cv=none; b=CwTBQkj+mzlO9csM+BlxZHuAa6wVXunkzgYvA53FZkuQupDQsp1CqSpEMFn0Bc2c87Y84iNuCwbIBhmZO5rr4qVX2MIWNKYQgpltTVgil3ZvlN6b0EcwJCVR7gr4B5kJP5fz4Uess2Vkzupgij8Hcl1zDqd2qI5y8P9L9l/zEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338832; c=relaxed/simple;
	bh=YSGCjNsngubo/Jl1dYAgPO8aCFH9ns4tj/o/yF+A/N4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZqzoLxHdHsxke3rbAsiy8IAdyBDBb9nrkF9alb/OX+eyCG0opQ5MAp9kYpSSrpkMNKS0pVPuWfkwF9gopumtWPvSKTFbPRv5mUWl4uGoggF7junceiklMByg0fVqab2IDLuFyF4H6tDnPWengiV7f1qDE7xJhnfAbIpug+sYgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a0d31b727so9161555ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 10:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712338830; x=1712943630;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ah/hZ2yJ0TwcfFp3XWyXAJ/KFmBkEoLcHbO6pknimo8=;
        b=seih8JQZDjIWvs2aciFBOQWUoRG2gOMZRiL8l7PE3ExLX6XkojSAfO8s3l3U/nfSda
         ecBlt1O25nLOsyTpE4QBx1K0v89sUQ1EIQGS33i0HqLH0SmIjchotosU5966cIU0wnXM
         LXbOqtERYq8YRHFZECcKBJnZiLsEe8GUlHYPwl5bnhPeAf+yUZjMgZ4CAdxIYHm7QPD/
         vtGWgjmTzRt8HVcdiYSIUzQvaVU9Y8003NOGE/zZlM5N+J1KvABc3lVkb3hL4PPlEh9c
         eon5o2r9kl8egSQ2+qtDq2b+oceM0NDRltA2DuGN/JxOGDF5ydKJ0vHQPg9P2zEb+CK6
         /ajQ==
X-Forwarded-Encrypted: i=1; AJvYcCURYfdwXUs9d5GiiRWtpjuQ1oxh44V8HBhiCNfsmiub2tedJg5xse9UCdt18p5pXwW+elsg0gu85kEy8NwPxiXNl2SxRFzdrcep7mIW
X-Gm-Message-State: AOJu0YzZY4fyLezWT5zEorflUkghDsZQSXrVtEOKVLH4WFjlpjYdZEiD
	1VgsI7TaBZTpoxgSQ2Gyq8JZne68RVZhkW06LDpdE3UqOhHi0QdIKkg6LnxW/nJanbYtIjmMfVy
	5HI6FXf5V06fU+DpyknhdXF0CnXoTuHb5yqZUe5QqK6etl6+/ppfuBCY=
X-Google-Smtp-Source: AGHT+IEa8ErI5FgU8ll+UtLrtt9fRtswGqcbjZC30844W8V4aUKoP5b0lwmlVyIv3bBsaEffu2BV5Iwtgb/xfl7/x8BopX03/sjL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:369:ac5f:9a10 with SMTP id
 k15-20020a056e02156f00b00369ac5f9a10mr142998ilu.1.1712338830394; Fri, 05 Apr
 2024 10:40:30 -0700 (PDT)
Date: Fri, 05 Apr 2024 10:40:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8974d06155cf3a2@google.com>
Subject: [syzbot] [mm?] [hardening?] BUG: bad usercopy in do_handle_open
From: syzbot <syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gustavoars@kernel.org, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13a5c3b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4372e026c95b0e36d0ee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ed9d29180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161ab3c6180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4372e026c95b0e36d0ee@syzkaller.appspotmail.com

usercopy: Kernel memory overwrite attempt detected to SLUB object 'kmalloc-16' (offset 8, size 9)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5081 Comm: syz-executor249 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 e0 27 d8 8b 48 0f 44 de 48 c7 c7 80 26 d8 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 b1 6f 75 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dbfd78 EFLAGS: 00010286
RAX: 0000000000000062 RBX: ffffffff8bd827e0 RCX: 2b2ecef8eabe4800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff81760b9c R09: 1ffff920007b7f4c
R10: dffffc0000000000 R11: fffff520007b7f4d R12: ffffea00008fe840
R13: 0000000000000009 R14: 0000000000000008 R15: 0000000000000009
FS:  000055556aa78380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000076e74000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __check_heap_object+0xb1/0x100 mm/slub.c:5461
 check_heap_object mm/usercopy.c:196 [inline]
 __check_object_size+0x1e3/0x900 mm/usercopy.c:251
 check_object_size include/linux/thread_info.h:215 [inline]
 check_copy_size include/linux/thread_info.h:251 [inline]
 copy_from_user include/linux/uaccess.h:182 [inline]
 handle_to_path fs/fhandle.c:203 [inline]
 do_handle_open+0x1f6/0x660 fs/fhandle.c:226
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f27665352a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe7e4589d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007ffe7e458bb8 RCX: 00007f27665352a9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 00000000ffffffff
RBP: 00007f27665a8610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe7e458ba8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 e0 27 d8 8b 48 0f 44 de 48 c7 c7 80 26 d8 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 b1 6f 75 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003dbfd78 EFLAGS: 00010286
RAX: 0000000000000062 RBX: ffffffff8bd827e0 RCX: 2b2ecef8eabe4800
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff81760b9c R09: 1ffff920007b7f4c
R10: dffffc0000000000 R11: fffff520007b7f4d R12: ffffea00008fe840
R13: 0000000000000009 R14: 0000000000000008 R15: 0000000000000009
FS:  000055556aa78380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000076e74000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

