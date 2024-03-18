Return-Path: <linux-kernel+bounces-106067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D087E890
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0E81C21AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FCC37707;
	Mon, 18 Mar 2024 11:26:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327D376EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761184; cv=none; b=ADJQJqC1nc2290cEK6zYFnZrF6YRm+zylilU5KEolrDD3ltmmBwB/cXYwYe23WlrgpfZwswvrdnfPCk09OE74IoYfXbAEFsVi8pdJ0muHco+q24fiiGOQIadmgPQTSIG+/wsK5mRvq+J+B7mlZ14zf7cIldnFBjbtaKQziCMVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761184; c=relaxed/simple;
	bh=eMyp7RrmOb6nyfJV+jyvLy5KaxIxEQFHcWNd7Fu87ro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VjmRg+ireIkdb2SsQ77u/y7gC2xWVKWw0WM/7oOWIG6s0a1k4lQC6Yb/wmoYbS52LKoaNQ1rphAiJ7NEAir2FenCv9EbLZaK0udiegOwHlEZeTVs9LeweJ+Hjz3SkiO8bzSwuMRsWiYMz0NxwNdaunqZ8SxHIW4852fWdBKe4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1d5d35bso322303839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 04:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710761182; x=1711365982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6x+AJFUwAXaZCD3R3JMJd09IYBzpisXUbEvFR9fpds=;
        b=DhERjpFK018njsDWmNJFUAbITAj2gHyQ9n1138pCRUG9CCBua1ji3/ho9NHpjSvicz
         Ozz3GnA2647mR+Zq7Sq80ZwTcxx1IfGjgDAoanKZG/Ztffm1/aa3mW4DXkAf0djVpVGD
         ncKiV6stmVSp5N8Vd0Ya8Wt13moJhCwEbjsOnY3ltx9n7fd4OfOyckHMYKNh/ab0HJ71
         NaJw1LGHgqHuUaHHpkh0SZ0HeNSNTPtIh0BV/SmY2TIlD6VU5IY6GMksu5mK9NPBXi0h
         2QDxhSe/0Dz+d/fPwsaCdMZXm1f7mPIkiqIDXA8ZQtQS1FGztic9fbxcUJklD05TXZ44
         mPZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKZ3R7oNExX75GovoK2hlKqD1jgbTbLCMI2t5kFrXUO8xXJEAJZEz527n/tcCWsCBjmeg60XiynmR9PINaCQKjjivE4raFN/NcIrXs
X-Gm-Message-State: AOJu0YzjPbKIBmJ9gOT0kr3tcUbbp0CIOhkXc6i6hxfoNHEnW7U6WfEL
	FET2rY+DbBCRFZbzakpXUGcs0U0ZGEAL7TRvmNLzl0cSBRDvDOlEFRfBeJJG0Jc6TcT2JgWX9rs
	ZiQgOyD7dSsxhPqSdO3fZmonjB+1baBdu/OXkQGAAbLh+pIHGp8V8ZZQ=
X-Google-Smtp-Source: AGHT+IEwg6shlcBInBIlHsRDA7QvtVVpVdrjTqqMpKjeDnkpIE/vNMiEOGinS2TYQfztXbsgoD82RUwRFctB1t7v6WSmf6bf1+Ie
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d91:b0:7c8:d517:1008 with SMTP id
 k17-20020a0566022d9100b007c8d5171008mr325672iow.0.1710761182286; Mon, 18 Mar
 2024 04:26:22 -0700 (PDT)
Date: Mon, 18 Mar 2024 04:26:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090e8ff0613eda0e5@google.com>
Subject: [syzbot] [mm?] upstream boot error: WARNING: refcount bug in __reset_page_owner
From: syzbot <syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f6cef5f8c37f Merge tag 'i3c/for-6.9' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119f21f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc79b17d66836c3
dashboard link: https://syzkaller.appspot.com/bug?extid=41bbfdb8d41003d12c0f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/343571f33be3/disk-f6cef5f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15f7478fde42/vmlinux-f6cef5f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e71e321ebc91/bzImage-f6cef5f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com

Asymmetric key parser 'pkcs8' registered
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
WARNING: CPU: 1 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzkaller-11409-gf6cef5f8c37f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Code: 8b e8 77 85 d5 fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 98 e7 12 fd c6 05 ad b6 0e 0b 01 90 48 c7 c7 80 a1 6e 8b e8 54 85 d5 fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 12 7b 6e fd e9 44 fe ff ff
RSP: 0018:ffffc900000673c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81510449
RDX: ffff8880166d8000 RSI: ffffffff81510456 RDI: 0000000000000001
RBP: ffff888020c2d70c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888020c2d70c
R13: 0000000000000000 R14: 0000000002de00b7 R15: ffff888140425588
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000d57a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 dec_stack_record_count mm/page_owner.c:215 [inline]
 __reset_page_owner+0x2ea/0x370 mm/page_owner.c:253
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 __free_pages_ok+0x5a9/0xbf0 mm/page_alloc.c:1270
 make_alloc_exact+0x165/0x260 mm/page_alloc.c:4829
 vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
 vring_alloc_queue+0xc1/0x110 drivers/virtio/virtio_ring.c:311
 vring_alloc_queue_split+0x186/0x510 drivers/virtio/virtio_ring.c:1108
 vring_create_virtqueue_split+0xe8/0x280 drivers/virtio/virtio_ring.c:1158
 vring_create_virtqueue+0xd7/0x140 drivers/virtio/virtio_ring.c:2683
 setup_vq+0x123/0x2f0 drivers/virtio/virtio_pci_legacy.c:131
 vp_setup_vq+0xb4/0x380 drivers/virtio/virtio_pci_common.c:189
 vp_find_vqs_msix+0x661/0xe30 drivers/virtio/virtio_pci_common.c:331
 vp_find_vqs+0x58/0x560 drivers/virtio/virtio_pci_common.c:408
 virtio_find_vqs include/linux/virtio_config.h:233 [inline]
 virtscsi_init+0x45c/0x9f0 drivers/scsi/virtio_scsi.c:887
 virtscsi_probe+0x3b2/0xdd0 drivers/scsi/virtio_scsi.c:945
 virtio_dev_probe+0x602/0x9b0 drivers/virtio/virtio.c:311
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23d/0xcb0 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __driver_attach+0x283/0x580 drivers/base/dd.c:1216
 bus_for_each_dev+0x13f/0x1d0 drivers/base/bus.c:368
 bus_add_driver+0x2ed/0x640 drivers/base/bus.c:673
 driver_register+0x15c/0x4b0 drivers/base/driver.c:246
 virtio_scsi_init+0x75/0x100 drivers/scsi/virtio_scsi.c:1083
 do_one_initcall+0x12b/0x690 init/main.c:1238
 do_initcall_level init/main.c:1300 [inline]
 do_initcalls init/main.c:1316 [inline]
 do_basic_setup init/main.c:1335 [inline]
 kernel_init_freeable+0x69d/0xc40 init/main.c:1548
 kernel_init+0x1c/0x2b0 init/main.c:1437
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
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

