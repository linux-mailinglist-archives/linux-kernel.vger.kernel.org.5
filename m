Return-Path: <linux-kernel+bounces-73263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC885C02F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3261C21AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14F762C7;
	Tue, 20 Feb 2024 15:40:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2F7602A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443624; cv=none; b=WIVdNp/p/NBPWlUrV+PabHiqzSonL2T36Plr6ss5FDaANEzOeOIY3POFXmgXZDiBmIzhVKqAHqxyLNBXmiZfEK47GxSAgZCaKjwRAr3sie1p3Q9x3CR+enIz2jqL3/Ys4oXfG754vxizQF696VKvrqE7UViHDX9CfALW5J7+WVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443624; c=relaxed/simple;
	bh=eIaUUoTlzNSh02D816IT9y5IG6uB7sXxoWdt9S+FP6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SU1YBQP7VHlqanqAEvwtN3y4JsNOlOz3YYb3z5aWjDPG1/unvEHJ6KMDpZBsT21l5kRwUgY9svi+H2xqLLuxgRlcoWZrygUIadHL9JeVoWCRvGOSA0E/dwGIjvX26evjXkjZwJHOpDqCEMPShNsROfqpjKvAzz9i2wCXtipOQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365116383bdso27969005ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443622; x=1709048422;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTW4PYWC8kQTl/NN24XZAXhKIjH9X9YDaZM2gEKVVIU=;
        b=PQun2XIpshRBexEr7HFC3bazkDwOxS4Fr3VzgMkVTV7kGWlUJ/zyRA9qlbwlTrgA2C
         wRwcAxkAKXo8aKxDFYu232sTG8CLD65k4sA9AmS2/vmqLiD70LWwDTxi84WkA716Fvxy
         tEdUDCoU8kAUVwluklOVxV+yrW74l46aDAfMrmi1JaevG/L5I0K3VK11eLur6ZihP7VH
         HXGqRPt+k8p2ISBYcalqDWGJBsqN0YnR+iPeHjUR4qRNu3gLs5WtB7FJB8aR25LWG6kH
         hcFvYFtQOJYBaDDaY3HsrNxHTUKD7CQv29FVfbMdnos/xLMz4j1KKpZyYWRkVW8gW23X
         Yvfw==
X-Forwarded-Encrypted: i=1; AJvYcCXvQrNdlDsj9gOcIxTvESWXS0TATF8gV9sARgW/h5Zn0zQrRYc3jIt124X5/xsWbuBIzqsIe3GSBAXE1MfrERW1Ve3jSmRB2ruNDvUO
X-Gm-Message-State: AOJu0Yz5WRRMwh8Slf8jlzOKGNjK6IRSKvRBhjeTPvMU7nCJtA8neSKo
	TUtpjuw6toedSaXU9OJeb4+SmGLXvIzIt0jRsOTD1ql66b5M5mqz5908Bb12pECmJ0mf0B2Io+7
	iDmEzZdLhFgqLzYCOtT0Jx1QAq42eRUBupaOEK6Cnm7YwXP7FGm9KkPA=
X-Google-Smtp-Source: AGHT+IEzHWwnsiSlhQ+WNHERhABP/SrOD1n2hErYUj+JcKCx0/Y5rpq2T76BDbqJxENqW55QuhnKUP8E6qtUyrk9+SMMwl3je6M2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:365:2225:cb05 with SMTP id
 j8-20020a056e02218800b003652225cb05mr491645ila.6.1708443622222; Tue, 20 Feb
 2024 07:40:22 -0800 (PST)
Date: Tue, 20 Feb 2024 07:40:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038b6700611d207b3@google.com>
Subject: [syzbot] [mm?] [hardening?] BUG: bad usercopy in raw_getsockopt
From: syzbot <syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gustavoars@kernel.org, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    74293ea1c4db net: sysfs: Do not create sysfs for non BQL d..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13dcc4b4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
dashboard link: https://syzkaller.appspot.com/bug?extid=0c35af046fa98c893c84
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f38cf8180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136d41c2180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9bca2f6e074e/disk-74293ea1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/611a08387d8f/vmlinux-74293ea1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78c388071345/bzImage-74293ea1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com

usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 4)!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5070 Comm: syz-executor201 Not tainted 6.8.0-rc4-syzkaller-01053-g74293ea1c4db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __check_object_size+0x601/0xa00
 check_object_size include/linux/thread_info.h:215 [inline]
 check_copy_size include/linux/thread_info.h:251 [inline]
 copy_to_user include/linux/uaccess.h:190 [inline]
 raw_getsockopt+0x37a/0x490 net/can/raw.c:852
 do_sock_getsockopt+0x373/0x850 net/socket.c:2373
 __sys_getsockopt+0x270/0x330 net/socket.c:2402
 __do_sys_getsockopt net/socket.c:2412 [inline]
 __se_sys_getsockopt net/socket.c:2409 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2409
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f21bfe782a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdfc8f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007ffcdfc8f208 RCX: 00007f21bfe782a9
RDX: 0000000000000008 RSI: 0000000000000065 RDI: 0000000000000003
RBP: 00007f21bfeeb610 R08: 0000000020001480 R09: 00007ffcdfc8f208
R10: 0000000020001440 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcdfc8f1f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
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

