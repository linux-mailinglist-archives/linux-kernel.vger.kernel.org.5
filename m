Return-Path: <linux-kernel+bounces-163011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD98B6371
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B53C1F220A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D481422B1;
	Mon, 29 Apr 2024 20:22:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7801411F0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422149; cv=none; b=O7yCHD24FOB0dDZ/aakHT9UMj9TiA3SVIlNZF/60Bm8mAahbWOEaXUCsMMhHIDgR6/eBq5hUwHpQvI9eNPsaE6VGd9I62s2UP3WuVlen/LqrfflpSyO+HP2lFx8Cegv1GBAVyU3J/o9l3NX14t7lmKqUSJi2fq+RWEdYx8lIoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422149; c=relaxed/simple;
	bh=JSgKyDL4A9NtlDZZMSaEAcnVSJ9FA6sACZl1tA+d+os=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nejD3/ECiMuuGmf6nligYtOATQ2HgMydxMa4+iMqiHqIyxyozeF8B9zMKjAwb3AryBNHeWZzbGtt9Jlexy+dMoAOc/BvEPqr8ZZz2KKsvTe5UUwzh/aI/OnrIcNzsommVhSIA84s0GzFACVnUV/ug5zGPjXKmVgPBXzm53DSjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c1b3aa28cso39978485ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422147; x=1715026947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dvg04ghK/E1dsyKMAW67gkIQkszA/ndC/eYE29YpcLo=;
        b=A7k8AEeuKYsEVrvqgjFMKabq0qGInK3iCYMTfAlFznYDdwP0B6ZE8v6pnEPsIeqA/+
         TiIWoVe26wwZUQXTjfFEakCNlwW0rXSqulZqsb/B/z8giCKvY2RSWo3xBxKW6JEVkfUB
         zODSL/uyeXmJgBll6rGL/PpMfZuib8vFw0Bo1pS9aY3KX7asz0u1g2RZVaaPyFdkTG3n
         eQi5oDqRNi8orxjpbj8uu1Q5U8NgMIgV+x1OHjIfbCH2bErU6Qiocl1j7se8WZLR1nC/
         UT7rqu3LvyE+WDbN4XzH0mPzPpnIEREalXLJ5cx0n1uJS82XnvX6IWubnBWtPSAYA53P
         yIIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEDP9YG/oqxgZqrT8GL4uPePDGww6Ktx5pz1ezMNpBh9LH6qxqBDrtVQfJgWru/Y17TqS5PHGFe6WK3lqRS9uw5vqmNVe9ZMH5G27c
X-Gm-Message-State: AOJu0Yy26/k8SaXofphIdfe0iyM/rIVItNT5fgjS8LL4keMTu1yQD9tZ
	19qmshRHDLUFrX/cRzTfOu4wmGax8s6WHHZvQWOQDU+HZGmZ141wMvoP61JAviF4qz/igXSI+DI
	S/R0QTSd+2Eec9KDcDW0LbKdPHb9YL84kr0E88wI8edniU58HS9aPHdU=
X-Google-Smtp-Source: AGHT+IGqB+cNgGMzrr5l13LChooEjad7Ac1/tQWk6VQYZJ+9jQL5vRcFN5JJDcgZ++ESFV2kPfLJSJhD6sBsU0z7N0YH/kfSEq+6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd87:0:b0:36c:2981:a85a with SMTP id
 r7-20020a92cd87000000b0036c2981a85amr394549ilb.0.1714422147401; Mon, 29 Apr
 2024 13:22:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:22:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000176a130617420310@google.com>
Subject: [syzbot] [bpf?] WARNING in bpf_map_lookup_percpu_elem
From: syzbot <syzbot+dce5aae19ae4d6399986@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, mingo@redhat.com, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev, zhoufeng.zf@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16023d30980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529956b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e35aa0980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0ce27d8874a/disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b4f35a65c416/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1c3abd538d5/bzImage-e33c4963.xz

The issue was bisected to:

commit 07343110b293456d30393e89b86c4dee1ac051c8
Author: Feng Zhou <zhoufeng.zf@bytedance.com>
Date:   Wed May 11 09:38:53 2022 +0000

    bpf: add bpf_map_lookup_percpu_elem for percpu map

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c20c08980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c20c08980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c20c08980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dce5aae19ae4d6399986@syzkaller.appspotmail.com
Fixes: 07343110b293 ("bpf: add bpf_map_lookup_percpu_elem for percpu map")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5075 at kernel/bpf/helpers.c:132 ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:132 [inline]
WARNING: CPU: 1 PID: 5075 at kernel/bpf/helpers.c:132 bpf_map_lookup_percpu_elem+0xa8/0xc0 kernel/bpf/helpers.c:130
Modules linked in:
CPU: 1 PID: 5075 Comm: syz-executor426 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:132 [inline]
RIP: 0010:bpf_map_lookup_percpu_elem+0xa8/0xc0 kernel/bpf/helpers.c:130
Code: 41 5c 41 5d ff e0 cc 66 90 e8 24 8f e5 ff e8 6f 12 cb ff 31 ff 41 89 c4 89 c6 e8 f3 89 e5 ff 45 85 e4 75 8c e8 09 8f e5 ff 90 <0f> 0b 90 eb 81 48 89 df e8 db b7 40 00 eb 93 e8 d4 b7 40 00 eb ae
RSP: 0018:ffffc90003187a80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801b299000 RCX: ffffffff81a8333d
RDX: ffff888026ff5a00 RSI: ffffffff81a83347 RDI: 0000000000000005
RBP: 0000000000500100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90003187b38 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555561e24380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606a936e0c8 CR3: 000000007ab28000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:681 [inline]
 bpf_prog_test_run_syscall+0x3ae/0x770 net/bpf/test_run.c:1509
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7bd6870669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4a73bd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffc4a73bf18 RCX: 00007f7bd6870669
RDX: 000000000000000c RSI: 00000000200004c0 RDI: 000000000000000a
RBP: 00007f7bd68e3610 R08: 00007ffc4a73bf18 R09: 00007ffc4a73bf18
R10: 00007ffc4a73bf18 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc4a73bf08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

