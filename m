Return-Path: <linux-kernel+bounces-141766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D18A2329
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81545284FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F08F58;
	Fri, 12 Apr 2024 01:23:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FB4C6C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885009; cv=none; b=gqpHXCDo/ls4fb8YK2OxbC18OSl1xMCtbst9Xgh77zGMIfmMI5r+rWThxBTdLSOXzoUdCwEoMOHdoP4tEKRDqUMevPtwCXa2pYPYq8zLnn5/mzu8BRKv7KqxO4gxbGZr0knKiaNWadYsPp+5Wo2QcAoI00LHA2MmXSYFhSyE70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885009; c=relaxed/simple;
	bh=P7/CqcnBj4904s/Gr/xtuT/dVWcNMNUpnBm4ltOUT9M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kEaQLjGDxqPNmZuH5e1VnX3jVEwpjJdoxF9C0QPR4bUbdonn/+4CrFiEyVRmokxXM8+r4h3M7z0ZSmQfWdPbWKGuWoxBC7xmGJGZp9Q3l6NmmeGQsjVtUs4WMCrPla50oFZD+K4x/ieYJYuf0/RVbJ1GuAvJDgbhHVNmFP/wEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so44731639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712885007; x=1713489807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX3zTd2y4+HRztgVwHxJ2tusI55QhxbeeOJ+ZIgPsu0=;
        b=f6NdLd0LMkXoX7TXKkW0bimdH7cE1xebM8ikSiRySycfDi67VfvJw/kuKvF+XcVT+W
         hvw3NK+JA5gMgIxTip7Y5dNgcbRGp9jaRzSWovLkfxBveKRLsSrCgeRYLl7UpYdZFIoW
         zIrERVPzLpc8jkY3Chz4mIk3pxiFW8YPmPpQzuDiQBi86j9TMXerrePG/ZBFCcrwt+uo
         2vnAu0ocB9+VCL5ygLKBJ0qsuoYUdZrtQojyM0ZcoZrJYJCcvzsb33RtmRDyAodsf70u
         AEgidAVstDdH6DkhLRWRtYGxxQRbkuOfrMlZUb5cZPINdb2g7OsVPDhUz1Ku32cVHv5X
         QUww==
X-Forwarded-Encrypted: i=1; AJvYcCU0+D3ACfovP4R0geo24bl2Egw//EIHVxORMMhRXf7aOaUMgnioQwqVIBr/Tn6CGyBlmJkHaKdM33i3vf9SYtE8MFyadXDCTeBBzupx
X-Gm-Message-State: AOJu0YxExtFRBHq2/w4bUFxUIDf8KO8hLAHSQpIJYObBogyaMvj88PXD
	ra5HhsN/oVuuVSUlT0wpryX8xXVCmEkgxtaS8BFzaZFmrHok2XogjlEcCc/TW2oB+CyvJ+cV5w3
	VICY+pAN+4XQbCLTooirlcijV7uKFBhMO0JulS3kTAisM3eRqT8pEWYE=
X-Google-Smtp-Source: AGHT+IHbdNGwAuB6VxQnudK1t9oofe0sMN6prWJtYYDUPhVjNy8eAjwVTXA/nXWh3rj++jr7+gDTmU7HqHlhA/Bp6TPJT3DG9NX/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1542:b0:36b:85e:7cdc with SMTP id
 j2-20020a056e02154200b0036b085e7cdcmr22701ilu.1.1712885007163; Thu, 11 Apr
 2024 18:23:27 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:23:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064b2580615dc1eaa@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_unref
From: syzbot <syzbot+4b9597d9c853a4230301@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13bfa699180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=4b9597d9c853a4230301
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a26f4b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17971ba1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b9597d9c853a4230301@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5065 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Modules linked in:
CPU: 1 PID: 5065 Comm: syz-executor149 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Code: 00 e8 81 6c 0b 00 e8 4c 69 42 00 fb 65 8b 05 cc 34 b2 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 4e e9 b0 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 73 67 42 00 eb 99 48 89 ef e8 f9 df 19 00 eb a2
RSP: 0018:ffffc900033df350 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1f3d467
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff88cb2222
RBP: ffffffff88cb2222 R08: 0000000000000000 R09: ffffed100fc7b64f
R10: ffff88807e3db27b R11: ffffffff81e6fb83 R12: ffff88807e3db268
R13: ffff88807e3db268 R14: ffff88807e3db268 R15: 0000000000000000
FS:  00005555732bd380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000295b2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_map_del_link net/core/sock_map.c:161 [inline]
 sock_map_unref+0x3b2/0x6e0 net/core/sock_map.c:180
 __sock_map_delete net/core/sock_map.c:420 [inline]
 sock_map_delete_elem+0xf0/0x150 net/core/sock_map.c:446
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
 __bpf_trace_tlb_flush+0xd2/0x110 include/trace/events/tlb.h:38
 trace_tlb_flush+0xeb/0x150 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x68b/0xbc0 arch/x86/mm/tlb.c:645
 unuse_temporary_mm arch/x86/kernel/alternative.c:1832 [inline]
 __text_poke+0x543/0xcb0 arch/x86/kernel/alternative.c:1942
 text_poke_bp_batch+0x1cd/0x760 arch/x86/kernel/alternative.c:2293
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 tracepoint_add_func+0xa4c/0xe50 kernel/tracepoint.c:361
 tracepoint_probe_register_prio_may_exist+0xbd/0x110 kernel/tracepoint.c:482
 tracepoint_probe_register_may_exist include/linux/tracepoint.h:52 [inline]
 __bpf_probe_register kernel/trace/bpf_trace.c:2446 [inline]
 bpf_probe_register+0x164/0x1d0 kernel/trace/bpf_trace.c:2452
 bpf_raw_tp_link_attach+0x2e5/0x610 kernel/bpf/syscall.c:3836
 bpf_raw_tracepoint_open kernel/bpf/syscall.c:3863 [inline]
 __sys_bpf+0x3a0/0x4b40 kernel/bpf/syscall.c:5673
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7ff61e228fb9
Code: Unable to access opcode bytes at 0x7ff61e228f8f.
RSP: 002b:00007fffcfb4b8a8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff61e228fb9
RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000011
RBP: 0000000000000000 R08: 0000000000000140 R09: 0000000000000140
R10: 0000000000000140 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fffcfb4b8d7 R15: 000000000000000c
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

