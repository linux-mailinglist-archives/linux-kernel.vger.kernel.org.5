Return-Path: <linux-kernel+bounces-50895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1496847FFB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1773C289CA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F016FC09;
	Sat,  3 Feb 2024 03:55:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8BF9E9
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 03:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932526; cv=none; b=glVk5bVGB8BveceR3LqX1gOpQczT/vGVosKftTfqjpy1SRi3IsFb12Q9hqSXcjII+kYPrFrGVgK2chVymrB0y3FgvIK4VZ63zzes/ymBBTjYaGvp5dT+EJI6Q6wszhov6FVYx3sKEc/B6PHMs2AIwlVXCF2JQB251eOa23rD3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932526; c=relaxed/simple;
	bh=pz3bTR4QPTBQGtNkck0ABnWfFg+OZqiAEH9+v+f9t5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ut4h0uA8mred/VgNpa+gThWXa9raXKVdBcRxOLAUO5bRn7NoLd4RXZXd7gsO05g6YPHpWZT5SJQU3xoh386h+SUh0flSSsR3r+uFJkisFKY7yMyLJKCY5ZBVIkp2Gau8DMY62igxGx9OCxvu5GhBxiwT8++M5fJ5y+V71cWLaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363bedeec4fso46055ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 19:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706932523; x=1707537323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvu4f2hTAGciBSeASfhgzvcyQRqm5qo/b1UAEIIZ4/k=;
        b=sS7oT3go3j026FZ3GFa48d9IOtglYoPXGipq0FBkNrjwktf1NVVnoYQM0gWGFOPq4G
         g/OMhgwkWBNY8ovEzQjFHhBOXDwP/8jA6XfhmI43KEgiKIdQYr9lnWzkcb7RRpB/ESko
         8d2UJ0HAS2EqkGhbifvez1uoPyuDW7rNUEzZtWISipEfC75nXjkfv0NXGiFD7foZXVaz
         4yRsrr3jZrjOlJ8AFrDMr/FdNxVOB1zC1aHSg2+gCgHki+ncTqfLkUeMuJqdHPi1C+ai
         XeBiCVRmfnadBJ+Z+/vKvzri00RoDm87FQdj04WFGIs/gh7l05aSzrbsBeQbxjq/zaip
         q8kw==
X-Gm-Message-State: AOJu0Yzc7fYvpwYVQ6wGk9T0DgAXM9L4YvWtvV2EWDr/VE7CBYwDSrEL
	4Z+gVry2yyB8FtWXJXLkLAPSDSvg3lAwjrHmUOVht6kSi5KagUTsgiaiOz1GVl9J0N8Ctyo4dlT
	hjNepdkU7oEQw/mJSMIOb60e2H6BjO4Ik3daf0OJNF8UD7CsPHUAjcKk=
X-Google-Smtp-Source: AGHT+IG0un7nsq8gsVaj02ca0MPJ8WyRCWpMuo/2TlQzUsAA+qmdaxJgq2jEY9Cfm2msySqWkjmKvT95yz/mlRab/O7GOflLUawi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0d:b0:35f:f01e:bb18 with SMTP id
 i13-20020a056e021d0d00b0035ff01ebb18mr842612ila.6.1706932523680; Fri, 02 Feb
 2024 19:55:23 -0800 (PST)
Date: Fri, 02 Feb 2024 19:55:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bacd1706107232cd@google.com>
Subject: [syzbot] [net?] upstream boot error: KMSAN: use-after-free in stack_depot_save_flags
From: syzbot <syzbot+7364c186cc00641845c5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56897d51886f Merge tag 'trace-v6.8-rc2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ef8190180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11709bae75cc702
dashboard link: https://syzkaller.appspot.com/bug?extid=7364c186cc00641845c5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f7d6226b85a/disk-56897d51.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/129ced2080da/vmlinux-56897d51.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0c58e85720b/bzImage-56897d51.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7364c186cc00641845c5@syzkaller.appspotmail.com

io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=118)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
virtio_scsi virtio0: 1/0/0 default/read/poll queues
scsi host0: Virtio SCSI HBA
st: Version 20160209, fixed bufsize 32768, s/g segs 256
Rounding down aligned max_sectors from 4294967295 to 4294967288
db_root: cannot open: /etc/target
=====================================================
BUG: KMSAN: use-after-free in __list_del_entry_valid_or_report+0x19e/0x490 lib/list_debug.c:52
 __list_del_entry_valid_or_report+0x19e/0x490 lib/list_debug.c:52
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 depot_pop_free lib/stackdepot.c:426 [inline]
 depot_alloc_stack lib/stackdepot.c:445 [inline]
 stack_depot_save_flags+0x3e9/0x7b0 lib/stackdepot.c:684
 stack_depot_save+0x12/0x20 lib/stackdepot.c:722
 ref_tracker_alloc+0x215/0x700 lib/ref_tracker.c:210
 __netdev_tracker_alloc include/linux/netdevice.h:4147 [inline]
 netdev_hold include/linux/netdevice.h:4176 [inline]
 netdev_queue_add_kobject net/core/net-sysfs.c:1703 [inline]
 netdev_queue_update_kobjects+0x24b/0x860 net/core/net-sysfs.c:1758
 register_queue_kobjects net/core/net-sysfs.c:1819 [inline]
 netdev_register_kobject+0x41e/0x520 net/core/net-sysfs.c:2059
 register_netdevice+0x19ec/0x2230 net/core/dev.c:10261
 bond_create+0x138/0x2a0 drivers/net/bonding/bond_main.c:6390
 bonding_init+0x1a7/0x2d0 drivers/net/bonding/bond_main.c:6474
 do_one_initcall+0x216/0x960 init/main.c:1236
 do_initcall_level+0x140/0x350 init/main.c:1298
 do_initcalls+0xf0/0x1d0 init/main.c:1314
 do_basic_setup+0x22/0x30 init/main.c:1333
 kernel_init_freeable+0x300/0x4b0 init/main.c:1551
 kernel_init+0x2f/0x7e0 init/main.c:1441
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page_prepare+0xc1/0xad0 mm/page_alloc.c:2346
 free_unref_page+0x58/0x6d0 mm/page_alloc.c:2486
 free_the_page mm/page_alloc.c:563 [inline]
 __free_pages+0xb1/0x1f0 mm/page_alloc.c:4653
 thread_stack_free_rcu+0x97/0xb0 kernel/fork.c:344
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0xa3c/0x1e00 kernel/rcu/tree.c:2465
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2482
 __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-00397-g56897d51886f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

