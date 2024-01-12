Return-Path: <linux-kernel+bounces-24542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9082BE22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5D21F21F32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143F5D907;
	Fri, 12 Jan 2024 10:10:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD55D755
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36072f247bdso63357885ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054228; x=1705659028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wq/Neynlo7rd9EMdFfz+w2uSTNXBQrlV6BSSyVMmA8Q=;
        b=LlzPi9nmBKGhfqq4PCqJqGek6ulm4QCokUvvPbj9RyMgkOxo55GtC7+hfFVpTtpEn7
         fx4ak3GQZUh/0maHpNLNOyUTsGw4l0tiS6ttXLFkQ50mV1tlOCj2sEn4cUeDf2p38MxY
         cRY87hSXhiMpaTEghoGjWz7zwwQipOVdBc6taZaD3TG6dhm4Yp5xk69TM5ZLxzK34++f
         6bblQ/syhmiZ/uilBPCNwoyxJdEvygdW/n5TPJ1mp5t0N0a52iYHBrWI7GsaKL5iHA0x
         QcKOcHEq+TeIaI8TI3RYW2+a5KwE2u7KM5Ub8TaC80+y1mCjgRSkK+Y9R902Q1uSAQv2
         65BQ==
X-Gm-Message-State: AOJu0YzYywRi2nhb8L76qY0w89IIfTRwvjwfj8dKgBjpXwodRJeNnisZ
	TIZspXN2efgaUAdqVMh5boUWOv33CgtnbPNORYj/cNaEqAm2
X-Google-Smtp-Source: AGHT+IGl20DykQgHikEGY9DrhP3cYgtQLM3BTHK1OM3/ZjSp1AaJonRlHFb8otrnOonC0bofGF4ls+S9ysIJU+N+zqF654IKs5Ax
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:35f:b1e7:cac with SMTP id
 15-20020a056e0216cf00b0035fb1e70cacmr38175ilx.4.1705054228268; Fri, 12 Jan
 2024 02:10:28 -0800 (PST)
Date: Fri, 12 Jan 2024 02:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000994e09060ebcdffb@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in ipv6_mc_down / mld_ifc_work (2)
From: syzbot <syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8735c7c84d1b Merge tag '6.7rc7-smb3-srv-fix' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17948c9ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4da1e2da456c3a7d
dashboard link: https://syzkaller.appspot.com/bug?extid=a9400cabb1d784e49abf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f263d974af01/disk-8735c7c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9faf34fc0b3e/vmlinux-8735c7c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b52a58ecd0e/bzImage-8735c7c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work

write to 0xffff88813a80c832 of 1 bytes by task 3771 on cpu 0:
 mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
 ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
 addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
 addrconf_notify+0x310/0x980
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
 __dev_notify_flags+0x205/0x3d0
 dev_change_flags+0xab/0xd0 net/core/dev.c:8685
 do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
 rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
 rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
 rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
 netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
 rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x1e9/0x270 net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
 mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 worker_thread+0x525/0x730 kernel/workqueue.c:2781
 kthread+0x1d7/0x210 kernel/kthread.c:388
 ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

value changed: 0x02 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 22 Comm: kworker/1:0 Not tainted 6.7.0-rc7-syzkaller-00029-g8735c7c84d1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: mld mld_ifc_work
==================================================================


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

