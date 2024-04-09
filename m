Return-Path: <linux-kernel+bounces-136666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42589D6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3991F2309D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13C128389;
	Tue,  9 Apr 2024 10:16:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DE823A3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657782; cv=none; b=kjqB1t6FEpmZfl3I/z2MphddQVpeMxE7f+FKReo3DRFwIZrLQHSFpFCPJHYbemF6dSjUDmrvrldO/GtFusSQ1xW1AJ2OrfZSBiGlSDF6QpYuosfZaF7Lw8eeZIfrkolk5CQNEzn7Mwpqt6y6DVEnPa85yXv0BKH4Yn5lS4nIQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657782; c=relaxed/simple;
	bh=dgppY183WcDm1YKlncBGmTrSmb9+fdndHbE65lKkgS0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P+ZJlmBZ8/Y6ToIcPzGC+ncko004rjjnRRDLqj03HtBAAtgIwd+8bHiz2fQLZmE2Utav90KCe98Dn5z9G/rQTfS8LHDQ1MOb0b+SFmsl7xpqWh62M9VuhnM3v1JloL/GtCVk6pckOT9fsnHkrRQ3z4NritYFFwZc0p03qRDBc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36a14031548so32276675ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657780; x=1713262580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8xnbUhc5v96Cmj+lscbf95g8Xp7z+Ho57Sa9YRJnE4=;
        b=O0xiEWBsWycr7odN1o32Qqw4aVpn+QvGgQ8xB4lVfEGkembOhCeU7yq99UhpVcNE3b
         QdT1Y+UgFh1ectxmL5EEkxwrq1xi8aHzfY2t/XSOdTx6XklwHIN0AymhBBZ+g7olOmOF
         jTslYWoKFh2BXa9WSgBJmQf+FJZ1q0FbvDJkgrqJvZULMFgFIbN8tOCbwnZ2vvFDPRAL
         logwqSU7AeqWlQYtGA/eLQYkMC5i/kj/pnHEF8ENzgb64oi0nlJvWN6/nMawn5g7z2qW
         7pmJsWIGEM/UHKKgR5MMaRsUxZIPVelzYJDolzioir2AQ3Oh7Ty9IaFRCvVwBW45EjYc
         Wk2g==
X-Forwarded-Encrypted: i=1; AJvYcCVsmv8LcVehV3dD5O/srhpy8F7fTzw9cSUr6120/qvGp/y9wE6V53q+EuFti6c/WfIJfHSSiTzKb/Mp5BVqubImHuQFZQaSTUhNDdGe
X-Gm-Message-State: AOJu0Yzj9TO/jF3QY94UTLn58b1ggB4Z3YvICQmaTcaDo9jPAEYS+P+6
	Gv1Sw05lrMY7gUIruxqhaGFylLogs8vbRoDGdMGT6lq259dgpHVlBqs3w5oMiA129CGrn+3KSlD
	YaWbx17VWqj6RNWicaC2dBeUCFNHw1djAGHMUXI3Thh98ltdrHIr7UzM=
X-Google-Smtp-Source: AGHT+IFhyvgfGlJgw9nwTp48ZrbpzQ1XLwRmmKUFE6PKC5xy3dyEVsTFOX+gkIrq89I0qg+9MMOenK/hguU3b6/aIb2hVhbvWMa3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4e:b0:369:98a3:6f7b with SMTP id
 d14-20020a056e021c4e00b0036998a36f7bmr893897ilg.4.1712657780286; Tue, 09 Apr
 2024 03:16:20 -0700 (PDT)
Date: Tue, 09 Apr 2024 03:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009db84e0615a73698@google.com>
Subject: [syzbot] [mm?] general protection fault in hpage_collapse_scan_file
From: syzbot <syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152f4805180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=57adb2a4b9d206521bc2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268258d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1256598d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d120b5e779c/disk-8568bb2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a89e3589a585/vmlinux-8568bb2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/045e657c0e0d/bzImage-8568bb2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57adb2a4b9d206521bc2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 5080 Comm: syz-executor931 Not tainted 6.9.0-rc2-next-20240405-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:PageTail include/linux/page-flags.h:284 [inline]
RIP: 0010:const_folio_flags include/linux/page-flags.h:312 [inline]
RIP: 0010:folio_test_locked include/linux/page-flags.h:512 [inline]
RIP: 0010:collapse_file mm/khugepaged.c:1907 [inline]
RIP: 0010:hpage_collapse_scan_file+0x1ea3/0x63e0 mm/khugepaged.c:2292
Code: 48 8d bc 24 30 02 00 00 e8 9a a1 f9 ff 4c 8b bc 24 30 02 00 00 49 8d 5f 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 6f a1 f9 ff 48 8b 1b 48 89 de 48 83
RSP: 0018:ffffc9000340f420 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000006 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000340f7d0 R08: ffffffff81cb9212 R09: 1ffffffff1f5802d
R10: dffffc0000000000 R11: fffffbfff1f5802e R12: ffffc9000340f6b0
R13: 0000000000000000 R14: ffffc9000340f5f0 R15: fffffffffffffffe
FS:  000055558dc18380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 000000006ee40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_collapse+0x561/0xcc0 mm/khugepaged.c:2736
 madvise_vma_behavior mm/madvise.c:1081 [inline]
 madvise_walk_vmas mm/madvise.c:1255 [inline]
 do_madvise+0xc3c/0x44a0 mm/madvise.c:1441
 __do_sys_madvise mm/madvise.c:1456 [inline]
 __se_sys_madvise mm/madvise.c:1454 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1454
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f4cdb4292e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff99038cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fff99038eb8 RCX: 00007f4cdb4292e9
RDX: 0000000000000019 RSI: 0000000000600722 RDI: 0000000020000000
RBP: 00007f4cdb49c610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff99038ea8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:PageTail include/linux/page-flags.h:284 [inline]
RIP: 0010:const_folio_flags include/linux/page-flags.h:312 [inline]
RIP: 0010:folio_test_locked include/linux/page-flags.h:512 [inline]
RIP: 0010:collapse_file mm/khugepaged.c:1907 [inline]
RIP: 0010:hpage_collapse_scan_file+0x1ea3/0x63e0 mm/khugepaged.c:2292
Code: 48 8d bc 24 30 02 00 00 e8 9a a1 f9 ff 4c 8b bc 24 30 02 00 00 49 8d 5f 08 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 6f a1 f9 ff 48 8b 1b 48 89 de 48 83
RSP: 0018:ffffc9000340f420 EFLAGS: 00010247
RAX: 0000000000000000 RBX: 0000000000000006 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000340f7d0 R08: ffffffff81cb9212 R09: 1ffffffff1f5802d
R10: dffffc0000000000 R11: fffffbfff1f5802e R12: ffffc9000340f6b0
R13: 0000000000000000 R14: ffffc9000340f5f0 R15: fffffffffffffffe
FS:  000055558dc18380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 000000006ee40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8d bc 24 30 02 00 	lea    0x230(%rsp),%rdi
   7:	00
   8:	e8 9a a1 f9 ff       	call   0xfff9a1a7
   d:	4c 8b bc 24 30 02 00 	mov    0x230(%rsp),%r15
  14:	00
  15:	49 8d 5f 08          	lea    0x8(%r15),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 6f a1 f9 ff       	call   0xfff9a1a7
  38:	48 8b 1b             	mov    (%rbx),%rbx
  3b:	48 89 de             	mov    %rbx,%rsi
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


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

