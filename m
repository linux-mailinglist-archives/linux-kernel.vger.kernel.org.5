Return-Path: <linux-kernel+bounces-106353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85887ECEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC51C21021
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818A53383;
	Mon, 18 Mar 2024 16:02:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05735337C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777749; cv=none; b=bH5RVd6O/BcIaVJZfDUo6RWkcmYb9huS8LWIYwl2tB0d2ZybMOHSpGPxHcvcGNrFgMUczV+Ebv8MaDVJ2Tz+IXsmKhIMMe2ZSa/y2zMhIARVuj6dv8VqjJNrgnEQwrw7KkWGnZWwP7g9RBPP3FN9oT/9/awvl+hPgbYmOhmR3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777749; c=relaxed/simple;
	bh=3DaoXaMaj6dZVZBaVgtLWrlDY9Wj5keXNGy4i6D8vRY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bj87M9zogJWEWxpoeLit1chLfwtqBBRD62YUe+yZKmc5KyhV/RsE+CfTEsq+ZeZxMrK46Z32SsZWDldWk6B8NI7jAfb1prsYYlUlZTFu3qcyOjCXKfXQXn7iaWaMh+KKyT6bxaCcVcJbMP/BPTmk/7sewTOM8bnQuO8pFdvDmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so409533839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777747; x=1711382547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvqm1uy5ijqhpEACA8hGAMduEjKIAZKeKYiLPAKPLgY=;
        b=ldKcCgLUrz18kfxkRkhxiBEsU5jaBykAJSXhPPaFbCie6NZwwNXLAuZxGCMR7NLDEP
         rBEKaqVX8LFvDzy+wsdBKJzn+VPP5RNYzzzW3oTM8jvT9lWRpRwueEzOwA0I4Wy3GSt4
         7jnvyp3MUxSlCugalpb4lpRmNH+gR+iHYBfhuuCV9fvTHD4HkNMrIK29eFLw6sHCSmr3
         Y6+ZN+V/j1wvF7sbMwlEAy+LWQtpqEEO4acV5txDqPXv6qSsVYmj92ttn2QTj2wOLfT3
         DOrMAkcEMbi+BHzjySWb1ot4wWNWxak0bfierkzosxwfSlDUh9LB1klyUGFvfTTp4Ayu
         6XAg==
X-Forwarded-Encrypted: i=1; AJvYcCWZx9fmBRUGTgJ50m2EakhkNTyEnbWj3u9pxASWGfSNz4S4UYpvXx8It9yr+jIZGJS2MJSFPY5DtAGOyemP3cSg3MBVUpDmlqxj5tfH
X-Gm-Message-State: AOJu0YzzFYd+w0hSse/d9yw7ZhakSoD3wJYCC7s79BjjfYD47PQrkiFj
	S/AM2shALxEPmcsNcMzyogvXrGxgLBabH3IurIy2yhCaSzWkEetY302RpPuz8/ODOdjlzGf/HJC
	QNMiTG1XA/hw1iAnbLnPv2rrP/YpAP5vCFwX6YvlcfbAeEQB66/kK7lM=
X-Google-Smtp-Source: AGHT+IEb6PzzIgjfMBqhqDVVqpTCJo7r0950mjf8Jrx52jskySKEAfuHLAS5MrTfLtZPPYiEKMnNAQjMT/OflZyPeheB2g5Gjszx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a4:b0:367:d6da:8dbd with SMTP id
 e4-20020a056e0204a400b00367d6da8dbdmr85930ils.4.1710777746365; Mon, 18 Mar
 2024 09:02:26 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcb0e50613f17bfc@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_delete_elem
From: syzbot <syzbot+2f4f478b78801c186d39@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1167944e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c046bf13ef8a8472
dashboard link: https://syzkaller.appspot.com/bug?extid=2f4f478b78801c186d39
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cb701180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178e0db9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82840b143668/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/448db0f2aaae/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84c11f014272/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f4f478b78801c186d39@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5063 at kernel/softirq.c:362 __local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Modules linked in:
CPU: 0 PID: 5063 Comm: syz-executor103 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:__local_bh_enable_ip+0x1be/0x200 kernel/softirq.c:362
Code: 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 <0f> 0b 90 e9 fa fe ff ff 48 c7 c1 8c 33 86 8f 80 e1 07 80 c1 03 38
RSP: 0018:ffffc9000443f8e0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff92000887f20 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff895b387a
RBP: ffffc9000443f9a0 R08: ffff888020a859eb R09: 1ffff11004150b3d
R10: dffffc0000000000 R11: ffffed1004150b3e R12: dffffc0000000000
R13: ffff88802e29ba00 R14: ffffc9000443f920 R15: 0000000000000201
FS:  00005555629fd380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8ef4f2501d CR3: 000000007ef10000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xca/0x140 net/core/sock_map.c:446
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
 trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
 kmem_cache_free+0x23c/0x2b0 mm/slub.c:4343
 __sigqueue_free kernel/signal.c:451 [inline]
 collect_signal kernel/signal.c:594 [inline]
 __dequeue_signal+0x4ac/0x5c0 kernel/signal.c:616
 dequeue_signal+0x169/0x5a0 kernel/signal.c:639
 get_signal+0x5f7/0x1850 kernel/signal.c:2787
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f8ef4f03443
Code: 00 00 00 00 00 66 90 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d 3e 0c 05 00 00 74 14 b8 e6 00 00 00 0f 05 <f7> d8 c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10
RSP: 002b:00007ffdd3126958 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00000000000013c9 RCX: 00007f8ef4f03443
RDX: 00007ffdd3126970 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000000000010 R09: 00007f8ef4e9b0b0
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000012e67
R13: 00007ffdd31269ac R14: 00007ffdd31269c0 R15: 00007ffdd31269b0
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

