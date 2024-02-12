Return-Path: <linux-kernel+bounces-61327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD69D85110E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6369F282D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F0208A2;
	Mon, 12 Feb 2024 10:37:17 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240F39843
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734237; cv=none; b=dpk/EcYWWyg6Kxd/73mYDBHSm8quROHlxtCQHj1CW+Dlngee3dJgSKI0EqJOAv83H1DgCgCkOIVyX3HEIMtX31L6Fb5WG61791/DpIGBXl7y6jAZmOzL/JGR/clwghzjV0sFyjXXP0UpRGjACBomoe2gFiwzd4GDyKq0pVuiHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734237; c=relaxed/simple;
	bh=SgHeV8Nf/cgzT4GIeKjL6yhteJJUdUSlnzvMHkYxeT0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sVZbZhwTcjcR/s0+GTSf7h/I6wCsYRnVyk2BOzc9eWOzkXvRX94acsSaUw+euf+c6TxMHH4sgho3hWJvIK9O+p17upxh73xKMI6INIpWU2H5vY4aN8syXxAfQSSSS0UTe1dwgEPVhGiDtOdWurKetGUDM2GMf9DdezcHXrwPcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363ec32bca3so23666835ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734235; x=1708339035;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIBwNVPo8yY6K+mo7Hy1fv0t+Zyvtu0xD/6C5qU5YRo=;
        b=E3PRo9MJYaYdkWcb8MkvsxZKN2p7xUPqOXlxxhf+W1n8UbdhHWtPLc8uUlaQI3CszI
         F7Eaie6b+od8A9jWoTAaLA3H/1NyuSoVEqmYuinHsQjbpp8roi6JvlK7tT69FLKizAL2
         xZU/PxAoLMlSyM51+TebMg7Cy3aEC/X1DAvXu62tyh2fNf95omkjTZIqr59Eu69TCl8C
         D7v04BHum0y4JKvb/YQFGatx79k/8onFsAvaKpmJE0vSGGbhSZDPR7ieLtgiFfMUbDoS
         IChp6CXBzjgVVFvfiC+MYpXSREt99GHpOddzumLZH6kCq/4B/ZMbcZ9PIXogpRS1couS
         YkGw==
X-Gm-Message-State: AOJu0YxIw8sNXa2wvkZ9TqrDvqQX8NGOACVoZBgp8fLxjaTKoeaTVAYV
	YF6SKA9izCQo+ZIlJfCQmup+3i9lHZ0UI+ZY7jBZW+onb7lPZnh9ya8jzOaK6gvuXSbFnqtY2Jc
	DSwQqQwBw3DTkpaW2f2yad+vBuFR1lfb1UA84ymIGJxVFIcQ20663Am4=
X-Google-Smtp-Source: AGHT+IE+9GOmm5vmGx5EguCXnwG6okIwR+rq0ZHGtpDvnO8j4TjkMbG5WEnVSbzjoqosKuej6oq1WcYA1RHpP+eW74emGNCQCpJ1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:363:dd02:1512 with SMTP id
 m2-20020a056e021c2200b00363dd021512mr432341ilh.3.1707734235095; Mon, 12 Feb
 2024 02:37:15 -0800 (PST)
Date: Mon, 12 Feb 2024 02:37:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000742ab106112cdcbe@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_cmd
From: syzbot <syzbot+c39f6e731d27b028df97@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e6f39a90de92 Merge tag 'efi-fixes-for-v6.8-1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157751e0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31f74f10f14dec54
dashboard link: https://syzkaller.appspot.com/bug?extid=c39f6e731d27b028df97
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/663081ccfa7b/disk-e6f39a90.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47bbf72bfafe/vmlinux-e6f39a90.xz
kernel image: https://storage.googleapis.com/syzbot-assets/982bd4f4331d/bzImage-e6f39a90.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c39f6e731d27b028df97@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11256 at kernel/workqueue.c:1728 __queue_work+0xdc6/0x11d0 kernel/workqueue.c:1727
Modules linked in:
CPU: 0 PID: 11256 Comm: syz-executor.2 Not tainted 6.8.0-rc3-syzkaller-00215-ge6f39a90de92 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:__queue_work+0xdc6/0x11d0 kernel/workqueue.c:1727
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 d3 31 8d 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 84 7c 33 00 85 db 75 56 e8 9b 81 33 00 90 <0f> 0b 90 e9 ac f8 ff ff e8 8d 81 33 00 90 0f 0b 90 e9 5b f8 ff ff
RSP: 0018:ffffc9000bec7a20 EFLAGS: 00010087
RAX: 000000000000282e RBX: 0000000000000000 RCX: ffffc90009c6e000
RDX: 0000000000040000 RSI: ffffffff8158e825 RDI: 0000000000000005
RBP: 0000000000000200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880418bcda8
R13: 0000000000000000 R14: ffff88807f8b9c00 R15: ffff88807f8b9c00
FS:  00007f1069ea96c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000000776c8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 queue_work_on+0xf4/0x120 kernel/workqueue.c:1837
 queue_work include/linux/workqueue.h:548 [inline]
 hci_send_cmd+0xcb/0x1b0 net/bluetooth/hci_core.c:3072
 hci_acl_create_connection+0x426/0x5d0 net/bluetooth/hci_conn.c:237
 hci_connect_acl+0x3e3/0x700 net/bluetooth/hci_conn.c:1706
 l2cap_chan_connect+0x724/0x2180 net/bluetooth/l2cap_core.c:8054
 l2cap_sock_connect+0x33f/0x720 net/bluetooth/l2cap_sock.c:256
 __sys_connect_file+0x162/0x1a0 net/socket.c:2048
 __sys_connect+0x149/0x170 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2072
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd8/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f106907dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1069ea90c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f10691abf80 RCX: 00007f106907dda9
RDX: 000000000000000e RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f10690ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f10691abf80 R15: 00007ffcf75228b8
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

