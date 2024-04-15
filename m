Return-Path: <linux-kernel+bounces-144460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8008A46A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB0B2219D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF193FBF0;
	Mon, 15 Apr 2024 01:54:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D3639
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146066; cv=none; b=TCFv/1Ntt5EifUAoPwRpzFBS/BddiYLXDUm+DhyJfGT31EQYwIQ9RKNsa+sKfvkHFRo3YJ4KrlC62S018eNqok8sEgwFK1m0z/YBkseXlOWMwuxLpgGu5ynHB09AmH2jJAcbeIiCbYitsf3U5qHoqv59cOhbcDuJ8W35ixkVi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146066; c=relaxed/simple;
	bh=uiwR4bCfdUN49IoGIefYpNDodSs5vQxu8QswN81syDU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bxzn9FLUsuxNOVfeHezZdq8V7XYthAbc/am9hFVNX4Kx+xcT8YNsgGJmqJba7rptv7sSRggACzTOfIFFjIS/62vwTokQonyZTZIanhEhwvcdc9w561bkTnKyWgx/D0XuV92ypM0rThEEI6RFP8I0jk6Tw0/AP0FJQUiTnACiu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d676654767so335864439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713146064; x=1713750864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81j4LIGOaJ+dg2uPNOLKbQWXKsjbyohwLVK9toRJWjA=;
        b=YiKarTX4N1uimbCjGHqVTP1uYWgioKDhqhOGU2J7URHcByt4V5w3PoKxaBsq59I0qK
         Pm9qoZexUoTOP53myD5ws2xHw2Q3kZxKfY1f+qVfmhLI3S6VKGND+kMfuIwH+lf6Bu+Z
         EV3+v3uDURVXkyKX1oIqap+KvqNxZ+M4X0jPrc68N7kEGwDAGn1OWILwbu1zbaki2gxy
         CcMYG0LQi78m8UmHwTf9DWhgi7xaEdpEwUVeX0dpEM3LXCyAlAA+9BgXk0JDd74qJkZL
         rPjoO989BMY58YGwbeDZsPeeCa5NoQwuILXjQcVBhLU5qWmat6Gnf6txu6N/er4Dv6EQ
         SbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2CQgoEJDMQ45YPMK4Z9sKmb8rKrcVwq7eeZLc0x0N7OmoayYN5AFM5Q5FSNjxb0Kv5QR9IgHlypu9IiXRpUvnInBwD+hwgS2Xsbqq
X-Gm-Message-State: AOJu0YyHjBnGnvHknov79lELdx8PAgQFpBo6o7Zg5ppH2vey/F4h4sau
	ygAiU0KdlGBge761U7GXm0YSBhz9Z3CWswqlJxYpvGiw2Ow/5xPqf8llo0LeouieDhgchmPVEPl
	FW5OSBD9NlAoWnENFRvpOSjYIZXobr1sl4KpgrayJDr45MterrcLczjA=
X-Google-Smtp-Source: AGHT+IGZKrJxC7xxrA2mNycgWIsW/SvrKX0rVQgVfLpK77riPlwvSCZObpSy9aeqOcK0/fXfUiBWtYiSQfvUBrN7817GjtNebZSe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8917:b0:482:fa6f:78f1 with SMTP id
 jc23-20020a056638891700b00482fa6f78f1mr269367jab.6.1713146063141; Sun, 14 Apr
 2024 18:54:23 -0700 (PDT)
Date: Sun, 14 Apr 2024 18:54:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008acb1e061618e68e@google.com>
Subject: [syzbot] [input?] WARNING in bcm5974_start_traffic/usb_submit_urb (2)
From: syzbot <syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rydberg@bitmath.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fec50db7033e Linux 6.9-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14439bd3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=560f5db1d0b3f6d0
dashboard link: https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c2c5bd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cbbf5b180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab4d6cae2eca/disk-fec50db7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b67542cc5860/vmlinux-fec50db7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3eeebb470b79/Image-fec50db7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b064b5599f18f7ebb1e1@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 6237 at drivers/usb/core/urb.c:504 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 PID: 6237 Comm: udevd Not tainted 6.9.0-rc3-syzkaller-gfec50db7033e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
lr : usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
sp : ffff80009f8b73b0
x29: ffff80009f8b73f0 x28: ffff0000d4fee000 x27: 0000000000000001
x26: ffff80008c6919e8 x25: ffff0000c8bd1fe0 x24: ffff0000c1d45a50
x23: ffff80008c698500 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000cc0 x19: ffff0000c1d45a00 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae6d1bc x15: 0000000000000001
x14: 1fffe000367b9a02 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000002 x10: 0000000000ff0100 x9 : b1573c5f9bab7600
x8 : b1573c5f9bab7600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009f8b6b18 x4 : ffff80008ef65000 x3 : ffff8000805e9200
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa00/0x1434 drivers/usb/core/urb.c:503
 bcm5974_start_traffic+0xe0/0x154 drivers/input/mouse/bcm5974.c:799
 bcm5974_open+0x98/0x134 drivers/input/mouse/bcm5974.c:839
 input_open_device+0x170/0x29c drivers/input/input.c:654
 evdev_open_device drivers/input/evdev.c:400 [inline]
 evdev_open+0x308/0x4b4 drivers/input/evdev.c:487
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 5626
hardirqs last  enabled at (5625): [<ffff8000803749b0>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (5625): [<ffff8000803749b0>] __console_unlock kernel/printk/printk.c:2731 [inline]
hardirqs last  enabled at (5625): [<ffff8000803749b0>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3050
hardirqs last disabled at (5626): [<ffff80008ae68608>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (2362): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (2360): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

