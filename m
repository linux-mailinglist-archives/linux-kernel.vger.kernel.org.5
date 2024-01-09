Return-Path: <linux-kernel+bounces-21236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A5828C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F641F27569
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1193C6BF;
	Tue,  9 Jan 2024 18:18:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A63C488
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-360a49993dfso2606105ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824314; x=1705429114;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhlfHL9tkjJ2VvfckMr55Pf/TCNiKhogiFkQmZhfAd4=;
        b=j7wl47y88oSvDfjjoj7V5RpqPe1yDjCZRFmlwE3K4ZqXy9A7nNAFoTNZeCIxk8c1yN
         tgZiLMTmxiqMYwhJbJDvkGPrsjeS935BOjUbmXMYILltXVlqgH7dUddkgoR5DhfI90zh
         MCdPF/KQ4fRt/7aJ6OX6EvO9ZrKSH79MdR1t2MOLESeoyN09Qg8pxQTCn6pUokX5ohbZ
         h08JDmgTOEmUH002hs+sVZVD2KIOfOfVs28NEmeb1AFjeEA+X8jkKafCXKmd6VCiZ+RX
         sV5Q0MTY0ca/6UYDt9UmT9OSUhrVTULVJbglE9ByGX+N0oSbIk+BbXKHZD1z7Chrfhyo
         GOFg==
X-Gm-Message-State: AOJu0YzD7Q3npHLm7wsZvX3lQfZ0gLdrud8dVA2pI7/2CsaV2zeJEQb6
	wghnUfxem5HL4NfOfKtmR5QWcE8XzuiHcZESF+UysYPE3u8Q
X-Google-Smtp-Source: AGHT+IHxEpDK+WGXr9CXpBQQowt0cnzTGBAqXWBKhmVAiDjvkGaaYNVwWnVpFeTUevOgpjsAQy4xcGGShKd8pa5ATF2i9D0WTL7I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:35f:f01e:bb18 with SMTP id
 m2-20020a056e021c2200b0035ff01ebb18mr496005ilh.6.1704824314008; Tue, 09 Jan
 2024 10:18:34 -0800 (PST)
Date: Tue, 09 Jan 2024 10:18:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a41b82060e875721@google.com>
Subject: [syzbot] [kernel?] WARNING in signal_wake_up_state
From: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>
To: ebiederm@xmission.com, linux-kernel@vger.kernel.org, luto@kernel.org, 
	michael.christie@oracle.com, mst@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D134dee09e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D56c2c781bb4ee18
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc6d438f2d77f96cae=
7c2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10223829e8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1121aeb5e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e10270bc146/disk-=
610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6066a38235d/vmlinux-=
610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7df7096082d/bzI=
mage-610a9b8f.xz

The issue was bisected to:

commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
Author: Mike Christie <michael.christie@oracle.com>
Date:   Thu Jun 1 18:32:32 2023 +0000

    fork, vhost: Use CLONE_THREAD to fix freezer/ps regression

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15ff657ee800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17ff657ee800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D13ff657ee80000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com
Fixes: f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regre=
ssion")

process 'syz-executor189' launched '/dev/fd/4' with NULL argv: empty string=
 added
process 'memfd:=EF=BF=BD=EF=BF=BDn=EF=BF=BDdR=04i5=02=EF=BF=BD=EF=BF=BD=E1=
=88=9D[@8=EF=BF=BD=EF=BF=BD=1F 9I=7F=15=1D=EF=BF=BD=3D=EF=BF=BD=EF=BF=BD\'L=
=EF=BF=BD=D2=8E=EF=BF=BD)JtTDq=EF=BF=BD=CF=81=EF=BF=BD=EF=BF=BD1=EF=BF=BD =
=EF=BF=BD=10>=EF=BF=BD\=EF=BF=BD=17L=EF=BF=BD=CF=91=EF=BF=BDM=EF=BF=BD=02^T=
*' started with executable stack
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5069 at kernel/signal.c:771 signal_wake_up_state+0xfa/=
0x120 kernel/signal.c:771
Modules linked in:
CPU: 1 PID: 5069 Comm: 4 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 11/17/2023
RIP: 0010:signal_wake_up_state+0xfa/0x120 kernel/signal.c:771
Code: 00 be ff ff ff ff 48 8d 78 18 e8 31 6c 2e 09 31 ff 41 89 c4 89 c6 e8 =
55 e8 35 00 45 85 e4 0f 85 62 ff ff ff e8 d7 ec 35 00 90 <0f> 0b 90 e9 54 f=
f ff ff 48 c7 c7 38 71 19 8f e8 12 96 8c 00 e9 2d
RSP: 0018:ffffc900039979f0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff888020380000 RCX: ffffffff8151856b
RDX: ffff888023c40000 RSI: ffffffff81518579 RDI: 0000000000000005
RBP: 0000000000000108 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888020380000 R15: ffff888023c40000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000b7000000 CR3: 00000000288f3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 signal_wake_up include/linux/sched/signal.h:448 [inline]
 zap_process fs/coredump.c:373 [inline]
 zap_threads fs/coredump.c:392 [inline]
 coredump_wait fs/coredump.c:410 [inline]
 do_coredump+0x784/0x3f70 fs/coredump.c:571
 get_signal+0x242f/0x2790 kernel/signal.c:2890
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xa/0x40 kernel/entry/common.c:309
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0023:0xb7000000
Code: Unable to access opcode bytes at 0xb6ffffd6.
RSP: 002b:00000000ff8cdad0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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

