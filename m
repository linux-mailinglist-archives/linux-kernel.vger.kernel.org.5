Return-Path: <linux-kernel+bounces-111319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07641886A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6251EB233B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A053D3B1;
	Fri, 22 Mar 2024 10:44:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD56383B9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104261; cv=none; b=pmu4uqUI1mOFZl6RXp5Q0edv9WaqMRHSKgIZLUeNPm0FTq6wLdtays2pmd/exGsCk6RPj2V97vR2roFVB47pQtv+ckJGXyNhAtIYVQvDsp4B7o77OhNI4tLHGGiA2h+oy7X/MxWmiit3nAgkQeqSJdajrAWLGV5cTXrhlkjzhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104261; c=relaxed/simple;
	bh=9KunjxSgRCqwix3sO03OFopWsrgdE6LHZ5VuJbMX3M4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tm09j8xQfggZTU3syeR9x4W2pJcrf5eKQ7lJrlcWYyOUug4pooW8cFiADonkQOIpTu4RW+F+zrCP9ATiv3CCY8dud1K3WfBYGg1SMyZzSu/pdWYWvrQlhjlN/4Dj/VjZY2rToHI4YgxDRN+Xk0aTKfaG0aopE00iDkphx/rr0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36660582003so22333965ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104259; x=1711709059;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkDZeghMwkXwm4rdzmArDwpkhROwVsJRzSxMOJhcObI=;
        b=hOfX7zV2N1dUDdpuxGHD4Om3Q7i0XLPPN26Ryxf96prVpjzvpNsCFAfb9VfDtGROVQ
         UFa6L/9xANL/tCt+di2/KYloNnk834hKHpnxIgPWQub0Mlh/1EJt6mSdOpFkM1u6Sz8G
         osb6wM1nQDPL2hXNj/a2IAU8e2KOsKZpSG8svb41O5o2VJkfVeQ45wt+DpFc95vaVNqS
         DVIrWQnTkPaLT5IK9Eh+YEhho6USXfh26aUsYjPJW1uBGgaTKXq8YmUAuZkfEn2nPH0X
         XAPfW8GoT3JouKr/J6LI0stPyKb7PSZh2I/F55sFn9r2PG9ttYCN2BqodPE3cKrxCDxp
         L4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIvOFgcDhiit1x1W8XnrgF6yPd5NmYSYYzX2D3PLaUFNuiCX8Okc76550t7m13AAxHko3knOjdiXBMD5bLh1sy/LYFw52sLfdAOPZH
X-Gm-Message-State: AOJu0YxjW9z7VzVE/LOj/EkmHbjaS7bXHmgtWfoou76Rl+nQa48uY8ha
	EwQ9iLEJQrtVspw3/2f9Mmgk0p6dMBo/PhKBE1po9a4dK4Ay/vpGxOBB+wQQrWUxFzBhQrxSPj4
	/9lMSGacUEr37WhkuM4pZIHykqIsQqWnofg1Ltx68Xh5is8PRXvohEFY=
X-Google-Smtp-Source: AGHT+IG+Y1gMkuz614HqXYzh/CuzeSCZP7/kYEkwXAbU3Foh8fjew5oCOlVYKb0EmOR5mG1wuIaWGCQ5ZLseyVoAdV70kMV6Ij8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3288:b0:366:b4c8:2150 with SMTP id
 bk8-20020a056e02328800b00366b4c82150mr81873ilb.6.1711104259340; Fri, 22 Mar
 2024 03:44:19 -0700 (PDT)
Date: Fri, 22 Mar 2024 03:44:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d4beb06143d8165@google.com>
Subject: [syzbot] [virtualization?] net-next boot error: WARNING: refcount bug
 in __free_pages_ok
From: syzbot <syzbot+e58465c446f16bd6191a@syzkaller.appspotmail.com>
To: davem@davemloft.net, jasowang@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    537c2e91d354 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c8343a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5e4ca7f025e9172
dashboard link: https://syzkaller.appspot.com/bug?extid=e58465c446f16bd6191a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31c81b152208/disk-537c2e91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d91fa59c13e4/vmlinux-537c2e91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31dbb656b1c7/bzImage-537c2e91.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e58465c446f16bd6191a@syzkaller.appspotmail.com

Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
io scheduler mq-deadline registered
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
------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzkaller-12821-g537c2e91d354 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Code: b2 00 00 00 e8 d7 d2 e9 fc 5b 5d c3 cc cc cc cc e8 cb d2 e9 fc c6 05 6c 6e e8 0a 01 90 48 c7 c7 60 34 1f 8c e8 67 6f ac fc 90 <0f> 0b 90 90 eb d9 e8 ab d2 e9 fc c6 05 49 6e e8 0a 01 90 48 c7 c7
RSP: 0000:ffffc90000066e18 EFLAGS: 00010246
RAX: c71d06ef88c7c400 RBX: ffff8880214ecb6c RCX: ffff8880166d8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff815800c2 R09: fffffbfff1c396e0
R10: dffffc0000000000 R11: fffffbfff1c396e0 R12: ffffea000501fdc0
R13: ffffea000501fdc8 R14: 1ffffd4000a03fb9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 __free_pages_ok+0xc60/0xd90 mm/page_alloc.c:1270
 make_alloc_exact+0xa3/0xf0 mm/page_alloc.c:4829
 vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
 vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
 vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c:1158
 vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
 setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
 vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
 vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
 vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
 virtio_find_vqs include/linux/virtio_config.h:233 [inline]
 virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
 virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
 virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
 really_probe+0x2b8/0xad0 drivers/base/dd.c:656
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
 driver_probe_device+0x50/0x430 drivers/base/dd.c:828
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1214
 bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
 bus_add_driver+0x347/0x620 drivers/base/bus.c:673
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
 do_one_initcall+0x248/0x880 init/main.c:1238
 do_initcall_level+0x157/0x210 init/main.c:1300
 do_initcalls+0x3f/0x80 init/main.c:1316
 kernel_init_freeable+0x435/0x5d0 init/main.c:1548
 kernel_init+0x1d/0x2b0 init/main.c:1437
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

