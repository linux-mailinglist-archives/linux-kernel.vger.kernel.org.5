Return-Path: <linux-kernel+bounces-21249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451D828C82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092C51F28D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA63D0DD;
	Tue,  9 Jan 2024 18:22:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7073D0A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7beeb9acd59so39733439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824543; x=1705429343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TNa4G43q4cO/ACdKNuWCSRQEIf696MY0iwPAGfopVg=;
        b=k9yLuIH5y9ScBjSRz6QRCPj6uaMnL7GcLmqU/DCq9Q02cUX5Mq53oWL06nR2dg2s1q
         aVPx5lbTHttLFQcFQZ5Hvi0qeXdtdWvHhRkNhtl+NgfpqBKR6+Wp/xLpsBcsYcRKgAcK
         05kQHDXpWk5oqXgClXEKoHfdgsj5kEajAWzuO2Ye07B/gOKQuOAz+VaXBtfrkCjYCz/z
         69vxDSOcs6TNZ7nZ4QcPvmuBEdByS5sYmFXw/8430CiORJzMkgCcsyYFzRQik4Qm6y3N
         B/F4YAoAGOFOsE7gNeNFckQyMbN8e9uKqEg1bGRkTU6IX3fF0MOPOrcUxsfcENt4X2Qh
         UZaA==
X-Gm-Message-State: AOJu0YyOQ64Za3IrGqJmVBDyliuPa70L0wlrB6Z+9ZrOy8piX9Y0+8aU
	xMcqfBT0/Sj6L8G1LXuGLVQBA0XPrK0i7lNgTZg0Fu6+fJ38
X-Google-Smtp-Source: AGHT+IGcahAoJvWzpIDo8zselVAoErzwnmmPyfYagYp8tWmDT1/06Ar5CgeRsu+dCZ9Ij37sRUaWExl5csQOSMZG2PlNgjF4GY5u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:35f:d99a:7b1 with SMTP id
 j5-20020a056e02218500b0035fd99a07b1mr752486ila.0.1704824543083; Tue, 09 Jan
 2024 10:22:23 -0800 (PST)
Date: Tue, 09 Jan 2024 10:22:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b841a060e876595@google.com>
Subject: [syzbot] [kernel?] WARNING in input_unregister_device (2)
From: syzbot <syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7d3b9f28654 usb: yurex: Fix inconsistent locking bug in y..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1766e845e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dd225f9d04a5286
dashboard link: https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5bf2bb53c85f/disk-e7d3b9f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f6e5a287ee7/vmlinux-e7d3b9f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8259e694a7e3/bzImage-e7d3b9f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com

------------[ cut here ]------------
add_uevent_var: buffer size too small
WARNING: CPU: 0 PID: 2442 at lib/kobject_uevent.c:671 add_uevent_var+0x32d/0x390 lib/kobject_uevent.c:671
Modules linked in:
CPU: 0 PID: 2442 Comm: kworker/0:6 Not tainted 6.7.0-rc5-syzkaller-ge7d3b9f28654 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:add_uevent_var+0x32d/0x390 lib/kobject_uevent.c:671
Code: fb 48 c7 c7 c0 7c 4e 87 e8 50 63 d9 fa 0f 0b bb f4 ff ff ff e9 57 ff ff ff e8 0f 24 10 fb 48 c7 c7 60 7d 4e 87 e8 33 63 d9 fa <0f> 0b eb e1 4c 89 ee 48 c7 c7 a0 f5 22 89 e8 b0 d0 12 fc e9 b4 fe
RSP: 0018:ffffc90001daf2b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888108b08000 RCX: ffffc9000c6ad000
RDX: 0000000000040000 RSI: ffffffff811733c6 RDI: 0000000000000001
RBP: ffffc90001daf3a8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 00000000006559c8 R12: 1ffff920003b5e5a
R13: 00000000000007f5 R14: ffff888108b08218 R15: 00000000000007f5
FS:  0000000000000000(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1ddf92c98 CR3: 0000000104e44000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kobject_uevent_env+0x995/0x1800 lib/kobject_uevent.c:588
 device_del+0x642/0xa50 drivers/base/core.c:3832
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2440
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2388
 hid_disconnect+0x143/0x1b0 drivers/hid/hid-core.c:2280
 hid_hw_stop+0x16/0x70 drivers/hid/hid-core.c:2329
 ms_remove+0x16/0xa0 drivers/hid/hid-microsoft.c:409
 hid_device_remove+0xce/0x250 drivers/hid/hid-core.c:2689
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 hid_remove_device drivers/hid/hid-core.c:2867 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2887
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1dd/0x8d0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x39a/0xa50 drivers/base/core.c:3814
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1416
 usb_disconnect+0x2e1/0x910 drivers/usb/core/hub.c:2257
 hub_port_connect drivers/usb/core/hub.c:5305 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5605 [inline]
 port_event drivers/usb/core/hub.c:5765 [inline]
 hub_event+0x1be0/0x4f40 drivers/usb/core/hub.c:5847
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
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

