Return-Path: <linux-kernel+bounces-51483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44D848BC3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453CD1F22BF6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6F881E;
	Sun,  4 Feb 2024 07:10:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597D79CC
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707030630; cv=none; b=X0eOFbF5GdlxCVYVyKH0ZWC/JEASPSqorL8oTzmQAeNTvVfYwV3fFXoOxeDgl6ML4s6T3lduQim3fp8RgViHwwXOsahivKwrNUTrp5neCdwJRMI6KFK6guvMBIyQoKI98Bs46uPCtxtncv/oSfS0rMkKrEzKMKgBCexJkW5+ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707030630; c=relaxed/simple;
	bh=xy4szYCXhyMoPbHzB5O40WqdYeI9UetWlTL4FBoGCTU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uNgUQiHCNGBk/lepGiIJllQm83yc7ersLaD8AcGRNJHXf3C+Zl//LhjowDAX9PpZT78XUSa6hIR5reEzGeiA3kfxDNHZm2e3EqM4C+bu4+EdyXPkiAmF0i3xk1FAq81KzYy4JsTj+2IBwHOoe9fda5Y8283m9jbQb/PukiUGuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b161279aso18532435ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 23:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707030628; x=1707635428;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11IBxnQs0exseBiOW8Uwjq3EX2qMQBaFaF2LrbVfP2o=;
        b=e+S/J5Lngo2UQ8kDn3f0NXmi1nl9zIjK3MHanW0frFT+qeaM3TBVsRJoi0bdmCmuon
         r8Ztn3+M3YLFPZuVoKRIUeJ0y3ouISoSIXV53V1R53BrWNGvOl+n2jgv/YTcfht7ds0q
         wqWaPabB9hhdPcKkqFTJ+fegSW/FLaqp3MuR9PQ4GtKB18mZPNixASUAiN6xUhP0AbCD
         azltXRkNRNctahWPtUFykanebehVRqid/fgdYpVKdAM6lSPCcer0dGyczmglAbN18cbL
         WdHewx3xzBgTIi2wbp7cCpiY4ODbiUp53X0b+NKUpwGASbeyu/4DxolEiJOR17WHvRaZ
         TDRA==
X-Gm-Message-State: AOJu0Yzc7sQUemV+GMTsYxQP2dEczLaw1m3nbwYqgDuUoYfxPpgay2E3
	AITLf28MHfRrDKrepGfuL4yQp9DXI7ABdGaFNbuqGE/iOWJzcSiN6/+cQZiTyeomKyLkl9CiuEY
	4t6vrTsBszZWD4qNIvzimNvOpBwtpawUWn3HHzdBq+OCmQup/IIZXmCc=
X-Google-Smtp-Source: AGHT+IG3HIaVX5o5kBmNhhVfhPFpzyxGoZyd6YgbHgPsgUwzFep/7K6Adif8fmvHWyRHn4zvgXrxb17Q0wmCXocSqCHZ2DVMAYXH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:35f:eb20:3599 with SMTP id
 s10-20020a056e02216a00b0035feb203599mr386475ilv.2.1707030628194; Sat, 03 Feb
 2024 23:10:28 -0800 (PST)
Date: Sat, 03 Feb 2024 23:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036e27e0610890a65@google.com>
Subject: [syzbot] [net?] upstream boot error: KMSAN: uninit-value in stack_depot_save_flags
From: syzbot <syzbot+d3af3bd3dc5f4d43ba10@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b555d191561a Merge tag 'perf-tools-fixes-for-v6.8-1-2024-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11560a38180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11709bae75cc702
dashboard link: https://syzkaller.appspot.com/bug?extid=d3af3bd3dc5f4d43ba10
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab88ac39d951/disk-b555d191.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53de6d54d856/vmlinux-b555d191.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0154e4e3e071/bzImage-b555d191.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3af3bd3dc5f4d43ba10@syzkaller.appspotmail.com

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
BUG: KMSAN: uninit-value in __list_del_entry_valid_or_report+0x19e/0x490 lib/list_debug.c:52
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
 linkwatch_add_event net/core/link_watch.c:127 [inline]
 linkwatch_fire_event+0x32b/0x6d0 net/core/link_watch.c:292
 netif_carrier_off+0xec/0x110 net/sched/sch_generic.c:601
 bond_create+0x19d/0x2a0 drivers/net/bonding/bond_main.c:6396
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
 __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
 stack_depot_save_flags+0x73e/0x7b0 lib/stackdepot.c:672
 stack_depot_save+0x12/0x20 lib/stackdepot.c:722
 ref_tracker_alloc+0x215/0x700 lib/ref_tracker.c:210
 __netdev_tracker_alloc include/linux/netdevice.h:4147 [inline]
 netdev_hold+0xe2/0x120 include/linux/netdevice.h:4176
 register_netdevice+0x1c34/0x2230 net/core/dev.c:10281
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

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-00419-gb555d191561a #0
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

