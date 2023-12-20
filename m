Return-Path: <linux-kernel+bounces-6675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A796819BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D70B1C257E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BF2110E;
	Wed, 20 Dec 2023 10:01:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51020DD5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35facd4238bso49667695ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066485; x=1703671285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsQ6ErNzgNNrVVuDT54IjGEFY8eRo6Uqt7+OdHX/zF0=;
        b=bmlg3LvoMmAKCRagBK5akF/zb4CK6tX+DSFTuYogX/7Y3kyKaGmP2urOn/EYkR5FA3
         kupR6EzATlcjDnUgGLGy2UFQFdhFBJ7/It/tNHprQByIgi7+KG99KSFTULyiBY+7kHQd
         3iItUnR8Xf6U0K6WAYxOEttU9yvgLzE6XTpN/MJvVpkeGpj8wafJQ0nim7yrRTto4sZv
         +FJKYyqz1HMLUmSlSMyGahNs7Xhh/4T32AOY8Grfc2IgrbyXwsQ02hpwcjRX0B3ADAH+
         rhB0Y16pXyvVUPHqVhdO/KA3i4lJXZVE/NwwwVg0ctVWk+5MS9vJtBH6f9Z+Pw0bfsMP
         1X7Q==
X-Gm-Message-State: AOJu0YyPTBr4Y5e//6vEWLkIyiv2iT3UFfvtEq62eofAJsPJYJXRlXQf
	vyPgbfSKPh3VF7Acbk7l/hYHEMCPV41EF4fhKZEx0xzl5P61
X-Google-Smtp-Source: AGHT+IG5g/6KURzc6dFEf5ixBSIkefT2Gbyw+fETSPEut4fNx188Ul+HE7C8F3B6y0dOdUcHltKzpMy0WwrKcApz9TFBoTUVfUxG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:1e06:0:b0:35f:4dfd:c224 with SMTP id
 e6-20020a921e06000000b0035f4dfdc224mr1156581ile.0.1703066485653; Wed, 20 Dec
 2023 02:01:25 -0800 (PST)
Date: Wed, 20 Dec 2023 02:01:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8099a060cee1003@google.com>
Subject: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    441c725ed592 selftests/bpf: Close cgrp fd before calling c..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1444d11ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b0f45da11b1/disk-441c725e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a5034980240/vmlinux-441c725e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2daadb549a4c/bzImage-441c725e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5193 at kernel/events/core.c:1950 perf_event_validate_size kernel/events/core.c:1950 [inline]
WARNING: CPU: 1 PID: 5193 at kernel/events/core.c:1950 __do_sys_perf_event_open+0x2748/0x2c70 kernel/events/core.c:12655
Modules linked in:
CPU: 1 PID: 5193 Comm: syz-executor.5 Not tainted 6.7.0-rc5-syzkaller-01532-g441c725ed592 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:perf_event_validate_size kernel/events/core.c:1950 [inline]
RIP: 0010:__do_sys_perf_event_open+0x2748/0x2c70 kernel/events/core.c:12655
Code: ff 48 8d b8 a8 00 00 00 e8 85 0a cf 08 bf 01 00 00 00 89 c3 89 c6 e8 77 74 d5 ff 83 eb 01 0f 84 2d ed ff ff e8 f9 78 d5 ff 90 <0f> 0b 90 e9 1f ed ff ff e8 eb 78 d5 ff be 03 00 00 00 48 89 ef e8
RSP: 0018:ffffc90005187d90 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000ffffffff RCX: ffffc90003d11000
RDX: 0000000000040000 RSI: ffffffff81b224a7 RDI: 0000000000000005
RBP: ffff888077570000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff915e51d0 R12: ffff8880291ffb00
R13: 1ffff92000a30fbd R14: ffff88807a94d940 R15: ffff888077570000
FS:  00007fa10795c6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002a097000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa106c7cbe9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa10795c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fa106d9bf80 RCX: 00007fa106c7cbe9
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fa106cc847a R08: 0000000000000001 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa106d9bf80 R15: 00007fff36da3b98
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

