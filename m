Return-Path: <linux-kernel+bounces-130439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DCD897826
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210A71C21120
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58C4153810;
	Wed,  3 Apr 2024 18:24:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B7153574
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168672; cv=none; b=X7etWtTlyMjnRGh+ArzejGC3pqtOUA4MwN06GnMlLwQg3FUyM9Jpn41vD7/GAAhc6jRuaAUOty2GkmYIiEvZjscuJsZ68EGAOI4b6x+ZHw6CMZpMbB/AU6wYK9JbrzObE8Hi5XZYlBzZMSYjNe3k1oN97HDd7WxjjJmQUh7E/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168672; c=relaxed/simple;
	bh=Q20nkqKhiTy3DTHCj8ZTq/mZ7yoZqYit5926BPi3j24=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aIp4VhyA08YRIK11fW9R+OzB1jJKYN1Gw8Y5aC2Eff9QddmMVYxc5ocum/xgDlWC1Kia7fsBBSLXA3c3nTjU7E6urZPDs/9tFqOmRNqjADE68BkcbqGZ12F4mK+90gNJFAcZei6YK0bo/VXcC5Td+hlaTWIHWS6ITq6FREcGSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbef888187so14793439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168670; x=1712773470;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DUZa0QcWt3ObnRYyOm4aWSBsjDLPIvUG/KIzmmML3A=;
        b=tsm/ehPP2rS9fE+B4ZYJk3RjbhZfWrOCUQxk8bZGge1fiCBTRcN/GjoSLOJBtQKviy
         6ToAvUMOS/Eb+zjPH2c1/hBAc8qfTUFOLsU2FNB+sMaLD5sQSSdA/6ZPzXuvSCMhPhWq
         d1tHoq+oGLEid6FAJdbF/h4lZpdUTMzdGQKaRL5QgeTOntv17Vh2ibUTh7Zu2cb3citg
         9LnLGmZ4vcpFqbzWKloJIQqxZgKKkQlqMXphPfqPBsYR9AE227zKlA7qG828kNaOi64E
         XQKYLTNt7LHe+eWMDW8y7CzLSCPTvMJ+1LHU06etdHEjsBnREKVXnTtqh4ZrgkuAD5JC
         2zbw==
X-Forwarded-Encrypted: i=1; AJvYcCXqUrajUKQqBQdnW74y3V6zz+kfe8Nwxu6lVrFNkxoCv8jycLKyaNH+cHeNFB8bMHczU86SQ+td/Ny1Q2gWPGQVA2Mj4YYKfWuNCvrj
X-Gm-Message-State: AOJu0YyNxt9aGCkeJ1ppHobph+dBOXFOPxKLEp2Xq1GRgZgmLlIPFE6Y
	qF0oVrWlvGFXKHe9YcWw2mrQmgcTXLcqMCdYHhJsDZoHFKu/KetkwwqFYioJ9RvF2Chqz0Di3pS
	GPifynJW2sCDii+nk7XGlj0qeWx6NazJson1QVifPArZzz4P4OeN0aq8=
X-Google-Smtp-Source: AGHT+IEmuDgAZ3lqnsR+TPpAhzKPMjDmdMpZl8YpgnGSQEydv98sXPPv2Yg/XR55l7lXxPsVCtpLw8bKTBC7fIcOCLt/H0bLaGQg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:369:fc41:698 with SMTP id
 g3-20020a92cda3000000b00369fc410698mr21038ild.4.1712168669813; Wed, 03 Apr
 2024 11:24:29 -0700 (PDT)
Date: Wed, 03 Apr 2024 11:24:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c2f9906153555b1@google.com>
Subject: [syzbot] [kernel?] WARNING in emulate_vsyscall (2)
From: syzbot <syzbot+1a55be5c9d955093937c@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f59af9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=1a55be5c9d955093937c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a64776180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142939b1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a55be5c9d955093937c@syzkaller.appspotmail.com

syz-executor110[5075] vsyscall fault (exploit attempt?) ip:ffffffffff600000 cs:33 sp:7f991ee20c78 ax:ffffffffffffffda si:7f991ee20db0 di:19
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5075 at arch/x86/entry/vsyscall/vsyscall_64.c:278 emulate_vsyscall+0xf5a/0x1270 arch/x86/entry/vsyscall/vsyscall_64.c:277
Modules linked in:
CPU: 0 PID: 5075 Comm: syz-executor110 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:emulate_vsyscall+0xf5a/0x1270 arch/x86/entry/vsyscall/vsyscall_64.c:277
Code: 0f 0b 90 e9 f6 f1 ff ff e8 23 74 94 00 90 0f 0b 90 e9 e8 f2 ff ff e8 15 74 94 00 90 0f 0b 90 e9 58 f3 ff ff e8 07 74 94 00 90 <0f> 0b 90 e9 58 fe ff ff 48 c7 c1 00 31 fa 8d 80 e1 07 80 c1 03 38
RSP: 0000:ffffc90004447e60 EFLAGS: 00010293
RAX: ffffffff81008149 RBX: 0000000000000100 RCX: ffff8880228d1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff810080a1 R09: 1ffff92000888f5c
R10: dffffc0000000000 R11: fffff52000888f5d R12: 1ffff92000888ffe
R13: ffff8880228d3710 R14: ffffc90004447ff0 R15: 1ffff1100451a6e2
FS:  00007f991ee216c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000019 CR3: 000000007906a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_user_addr_fault arch/x86/mm/fault.c:1346 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x160/0x890 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:_end+0x6abda000/0x0
Code: Unable to access opcode bytes at 0xffffffffff5fffd6.
RSP: 002b:00007f991ee20c78 EFLAGS: 00010246
RAX: ffffffffffffffda RBX: 00007f991eef0308 RCX: 00007f991ee66739
RDX: 00007f991ee20c80 RSI: 00007f991ee20db0 RDI: 0000000000000019
RBP: 00007f991eef0300 R08: 00007f991ee216c0 R09: 00007f991ee216c0
R10: 0000800000000007 R11: 0000000000000246 R12: 00007f991eef030c
R13: 0400000000000000 R14: 66aa589070d556b8 R15: 00007ffedb75c428
 </TASK>


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

