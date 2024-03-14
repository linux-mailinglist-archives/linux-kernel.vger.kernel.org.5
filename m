Return-Path: <linux-kernel+bounces-103393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869587BED7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6AD1C22CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57395D8F8;
	Thu, 14 Mar 2024 14:25:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCA58ACF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426336; cv=none; b=FMi8l2GaPgP0grsUDDVV+xuvtFpPZM78iIgVPTymxBoZMqxUOYajzhxACBf3/qpd0wdtB8A//5OJ1kq5L99pYNkmybcThKDVmbcocM7OZbqYBGitcgQREUQY72dtW7GnSlqGIXAJhPHV+PWOhmZn0cE99gmMt80zFB60qZe5yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426336; c=relaxed/simple;
	bh=59IRwYZvCIRh+RtQJoWY2krHeK/9wif811uQ2Y7soPs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EqOzn8+n0QWdYec2Fcsrtvl/Ey5gIHCOVpEtak5JaJ6sbHQZx4oa1CWI3aT32rTsAOwnDw1F6qUMgS+cwVwT0xvlEKGv+qZ1CYwiWgLkrK8KAGOGDHuyfYW/5deAqCefgRuS9RZpFn2Xa7aAJQOvCK7LFR1RC1BFUrxxIMsIWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8b4d00be6so68192039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426334; x=1711031134;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18uoimT1bopfIcNqOqvsGh+pCmb6LlcLxHjVzIhvia8=;
        b=s0ESaGXCssj4aCIpvk4qQ51wn4ChNd4HRq5MwtpC4WCT3r8vf4e3kqi0Ut5SVuetS4
         Ne7oNZHjyfeOVNJ6U8HTLx9oy10XljUKf5MPiwKNuCWfgLns3CFqR4NL4VGWCiLRKNFp
         YPn8Yao366Ebj3qbW7EV+g5aPaVDZUWUMNGIk/N+B/brOC9zYhnckCCuvwj/rIOkJPKg
         PaKrZewlUdMvE5CBf0MMvs3lgcfkrvlTWyhPMnv/JaVZze1fhHpNVvuI4pIa+ujNW3IT
         nV/GySjbhvfh9298x/mqzH9gVZqN1HdQKE8oX5/oAdYw6T5utGMitv6MGnqrbveYxDAh
         6nrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+igSTawlqt9EtVjd2iwle6WkH0BMQsy51KZ6GD/1Uy1CNDdz+nXnCjreVQD+1fBI3EfbbjJ9NKXgKqyafQsY+uXlz7u+r73VwUuu/
X-Gm-Message-State: AOJu0Yxx7R6LZnp8sjx2XcWtZPA9T3MIBiCeiqWyHbjAan67W3cJwTOH
	rWeJuJ4+13RZMnU10TVvThhhpcqiZuRN6XZP6PFq+O6vpWPMVB3Q10vr7gZ3RkCbls4aN3AITBi
	InCAqionvnCjKqES7lkmNwUhREYcItgfeglksIPoBBJWAORA+4Npo6TY=
X-Google-Smtp-Source: AGHT+IEyD058LrvaoW91Em2xsLn3kN7oQVgSdB6kgLaibdaFnU05ghC1YrJnMrPMr7l+2lAoLy/tJRfiA6KQ9IsntxFwbQBCQ2jP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6287:b0:476:fa88:fdea with SMTP id
 fh7-20020a056638628700b00476fa88fdeamr106481jab.5.1710426334129; Thu, 14 Mar
 2024 07:25:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 07:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f823606139faa5d@google.com>
Subject: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9187210eee7d Merge tag 'net-next-6.9' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1736a3da180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=222448ff79dba2ea
dashboard link: https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b3fdc1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201969180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98c1ea7ddb95/disk-9187210e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/343c5524f68f/vmlinux-9187210e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c0c68b0ee90/bzImage-9187210e.xz

The issue was bisected to:

commit 011832b97b311bb9e3c27945bc0d1089a14209c9
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Wed Mar 6 03:19:26 2024 +0000

    bpf: Introduce may_goto instruction

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115e578e180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=135e578e180000
console output: https://syzkaller.appspot.com/x/log.txt?x=155e578e180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/bpf/core.c:2349:29
index 16 is out of range for type '<unknown> *[16]'
CPU: 1 PID: 5060 Comm: syz-executor255 Not tainted 6.8.0-syzkaller-05202-g9187210eee7d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:415
 bpf_prog_select_func kernel/bpf/core.c:2349 [inline]
 bpf_prog_select_runtime+0x5aa/0x640 kernel/bpf/core.c:2380
 bpf_prog_load+0xf0f/0x2660 kernel/bpf/syscall.c:2899
 __sys_bpf+0x9b4/0x4b40 kernel/bpf/syscall.c:5631
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fa2a0fe73e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd829a698 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffdd829a878 RCX: 00007fa2a0fe73e9
RDX: 0000000000000048 RSI: 00000000200017c0 RDI: 0000000000000005
RBP: 00007fa2a105a610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdd829a868 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

