Return-Path: <linux-kernel+bounces-61302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD3D8510BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FD2B23A46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71A1B273;
	Mon, 12 Feb 2024 10:25:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A918049
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733526; cv=none; b=al+uCsYfUVwv2PdascRQ36mnUMLsIf+J9UG3GLjk0KqxDh4c8NMB7vgqhxkdgwz1t7A/Vj7tnPyzQMseSOaBzKyF8Y15Y3L6R62tHC6PRYSGcfNy4yqp/1rMMdyxMPo42s995Dai9kgLgK9+POKz2et2TMtW49qw/9S+rgIjAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733526; c=relaxed/simple;
	bh=bzH296aBfMEGIJoJI/husLWzf8HC0CRP++nMcVYex2E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ip+6+eYKcfPW/IfpWN+r8mlM2Dgbmy/QD8tNBqwktIo4I/N7BBGrcNt+qlJC+4YcWYbYWFxepSEqRRi5l54AhS1FYjW9jtkgq7x5l4jvyalClp4zSQcr9Rf5d4aq4K+8CRhl0Cf2r3Oq+i/yLtvfZwcaNFQCoTVtckwuzaBhqtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc32b2225aso222675439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733524; x=1708338324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KShDIFCkebOMmx38PXQl8Qp3bwUYjiColL4uZBM8zHM=;
        b=iyWFu9NOQz3K1yI+wUn8LI38nl3DBw/qsZrW5YRAG/68+L0nJwbqARj+Fyo6sy6qwD
         I6/aAQZAX+3lzfz3SRyq3J4iv8mkem5pL2buUBaAb7Mvlra0Of+8NLgOSEp0UEAifNYX
         GuTnDQuaunU76RBwNx8aJAXzxOQH2+wmG/TdRixXQovgXI3bn+fFk20y/TCtCO8g5Box
         +sFeluXyPjTvaOV9CDUV5fjkvS2b6XT4cK5H2Zoj0poE5ErFpjx3j3Ojg3iMbPLF/9H+
         uxibvgb+A39QWIOFPJt75ACgDbxYx/kPJ/KwCjG/chEro+E/kUkd1dS0Rjnw9+CH8Sa4
         ubfA==
X-Gm-Message-State: AOJu0YxcGYOQU2WTpbsees88na4iXED5KoKrGEfeVBwwYxA6PJ0zwQYt
	7tVJQkks/7jKd9kEmUVUSClv0BcRCFo2e/jMrb0OJZYVblTlVeV/9eCYJe2Nw0XpcnNwGLScPxN
	owYwhQTQh9PmEMkI68wBcdGK8oyge8XerFVVfBHEf0AOBO0LeLKp0SkmKEg==
X-Google-Smtp-Source: AGHT+IEilDEoMvdBsJOpTZQOsEGRDsEiz6K0K24aKD6pvDiLrJswm4A/TspX4KMAlJaNrrUPhj0ZcgcRejqmbPzDyfey6QTPfXJW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:990a:0:b0:7c0:21f0:301c with SMTP id
 t10-20020a5e990a000000b007c021f0301cmr64894ioj.1.1707733524175; Mon, 12 Feb
 2024 02:25:24 -0800 (PST)
Date: Mon, 12 Feb 2024 02:25:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014671906112cb2ef@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in hrtimer_active
From: syzbot <syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a7bbe7519b6 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10476de0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=264238120cdb2bda
dashboard link: https://syzkaller.appspot.com/bug?extid=039399a9b96297ddedca
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a7bbe75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee3f97d1ed38/vmlinux-4a7bbe75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb6f9f8f9f37/Image-4a7bbe75.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com

infiniband syz0: set active
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
Mem abort info:
  ESR = 0x0000000097810006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  Access size = 4 byte(s)
  SSE = 0, SRT = 1
  SF = 0, AR = 0
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000006f316000
[0000000000000010] pgd=080000006f27f003, p4d=080000006f27f003, pud=080000006f31a003, pmd=0000000000000000
Internal error: Oops: 0000000097810006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3665 Comm: syz-executor.0 Not tainted 6.8.0-rc3-syzkaller-00279-g4a7bbe7519b6 #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]
pc : hrtimer_active+0x4/0x60 kernel/time/hrtimer.c:1614
lr : hrtimer_try_to_cancel+0x1c/0xf8 kernel/time/hrtimer.c:1331
sp : ffff800082c63300
x29: ffff800082c63300 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000340 x25: 0000000000000000 x24: f3ff00001ab7e9e0
x23: 0000000000000000 x22: 000061100fc019e9 x21: 0000000000000009
x20: 0000000000000000 x19: fbff00001abf9920 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008144d28c
x14: ffff80008144d20c x13: ffff80008144d28c x12: ffff80008144d20c
x11: ffff800080011558 x10: ffff800081907d14 x9 : ffff8000819078a4
x8 : ffff800082c63408 x7 : 0000000000000000 x6 : ffff800080026d20
x5 : f2ff000033f2c800 x4 : 000061100fc019e9 x3 : 0000000000000340
x2 : 0000000000000000 x1 : 000000000000000d x0 : fbff00001abf9920
Call trace:
 hrtimer_active+0x4/0x60 kernel/time/hrtimer.c:1613
 hrtimer_cancel+0x1c/0x38 kernel/time/hrtimer.c:1446
 napi_disable+0x5c/0x11c net/core/dev.c:6502
 veth_napi_del_range+0x64/0x1d8 drivers/net/veth.c:1109
 veth_napi_del drivers/net/veth.c:1129 [inline]
 veth_set_features+0x68/0x98 drivers/net/veth.c:1580
 __netdev_update_features+0x200/0x6ec net/core/dev.c:9872
 netdev_update_features+0x28/0x6c net/core/dev.c:9946
 veth_xdp_set drivers/net/veth.c:1681 [inline]
 veth_xdp+0x108/0x224 drivers/net/veth.c:1694
 dev_xdp_install+0x64/0xf8 net/core/dev.c:9243
 dev_xdp_attach+0x250/0x52c net/core/dev.c:9395
 dev_change_xdp_fd+0x16c/0x218 net/core/dev.c:9643
 do_setlink+0xdd0/0xf14 net/core/rtnetlink.c:3132
 rtnl_group_changelink net/core/rtnetlink.c:3452 [inline]
 __rtnl_newlink+0x460/0x898 net/core/rtnetlink.c:3711
 rtnl_newlink+0x50/0x7c net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x12c/0x380 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x5c/0x128 net/netlink/af_netlink.c:2543
 rtnetlink_rcv+0x18/0x24 net/core/rtnetlink.c:6633
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x2f4/0x360 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x1a4/0x3e8 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x54/0x60 net/socket.c:745
 ____sys_sendmsg+0x274/0x2ac net/socket.c:2584
 ___sys_sendmsg+0xac/0x100 net/socket.c:2638
 __sys_sendmsg+0x84/0xe0 net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: 54fffe8b 91000400 17ffffe6 f9401802 (b9401041) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	54fffe8b 	b.lt	0xffffffffffffffd0  // b.tstop
   4:	91000400 	add	x0, x0, #0x1
   8:	17ffffe6 	b	0xffffffffffffffa0
   c:	f9401802 	ldr	x2, [x0, #48]
* 10:	b9401041 	ldr	w1, [x2, #16] <-- trapping instruction


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

