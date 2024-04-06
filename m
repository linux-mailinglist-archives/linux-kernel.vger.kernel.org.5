Return-Path: <linux-kernel+bounces-133948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E051889AB4C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25C81C20D27
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A52381A4;
	Sat,  6 Apr 2024 14:19:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FB37700
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413144; cv=none; b=YfhGxMW0KlUeh7ZDlkKJpW0GcniStNGze7fgmCfabG/TC6Nx29MCvt+greUZxgXkyv4u3JVKlp3IWcqhLOwDKHBSOibWxfWyimeMOZ+ZrOcJV2KR+N6YTDIE7mSqU3rvhbP4wACKui5z38OID3QCCAd4Itopb0qgo3/smZDlYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413144; c=relaxed/simple;
	bh=OBN/ldIh7GKaoPaVcVjR6TRW1JFN9uZr/aPYrUm/Al4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CXkfeK9qGbwKhaGisXV+d4fQP+RwCOtffH/fxDLD4KDBEvLmhiH8d/VJ2sSugeX6oP6Y2SIlBQSkHU0lS1Nu+qXGtK81KWkD5DHOnFPJGYxcN1E/8WaxExiD1UO5nO+BoYpRZRsQB03ZRmXyCsgT05R2uVDIQEolzku36H/fvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5d9390350so14871539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413142; x=1713017942;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHuhuJ2kzlZ4CHSqEuV7kbXzOrS/X/7SF48m0IRgUqE=;
        b=Uk4+vSTFnHq37aqkk8tAoCjv5uBFSeMte8YIIYoW36aDCGvLeQ1Li8j9sM+ttgbitK
         M0FpJLKPl+pTN47ffWT2wEkw1z3A7en5vpYPEqnGUAcJ6F4y+do+3wapg1okYzeNhPQF
         3jV+ytBEDRb3CtK6ehsPRDQt4YQT4bbrN+2yQ1ZqZmnQjwjqN05+1CGAGjTVeIHfCrY/
         mCObm5eigmW+WQ4yYtYSKDTC9Gb2xfNdiO1Lctpm0rusAvk1NRBYEzm6Q31D6FxZkbo4
         6uYVWk5dRWQF2iLQCxFVvzjqlmPoPZuWps/dnvhgLp6GsvLBmWV2Y65ez4dOAw9uZStI
         9DBg==
X-Gm-Message-State: AOJu0YyLn4WaSPS7fSwaAFd8L29dB3eMsLztQDYEH5mSmsEoZjLBk+3B
	luFPdvlJ9UJHTwuBiALBoeN0Xufg1AZ31XNOZ+HhUz5Q+cOfBayKiW6VxAoJLa2GBMPgW2akp1c
	JBNiquLsif8oiKOuuVg0pqXAvhRWHGet8bbtaP4zNMPYma7HdKU0B+4KWDQ==
X-Google-Smtp-Source: AGHT+IE0AKctM9aaS/qlQ/EpoRg9gJd+ylBnMaQCnW/kskPDCwhKRsP0EBJOVIzFj2wTIOJEkxx0KpkOAAsPnr98rj9q2qsrD2rV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a4:b0:47f:ea62:4812 with SMTP id
 fh36-20020a05663862a400b0047fea624812mr232070jab.4.1712413141949; Sat, 06 Apr
 2024 07:19:01 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:19:01 -0700
In-Reply-To: <20240405140629.22663-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008ee1a06156e4148@google.com>
Subject: Re: [syzbot] [usb?] [wireless?] WARNING in ar5523_cmd/usb_submit_urb
From: syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200) is a 16550A
[    9.237640][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[    9.252560][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[    9.276612][    T1] Non-volatile memory driver v1.3
[    9.293898][    T1] Linux agpgart interface v0.103
[    9.298192][    T1] ACPI: bus type drm_connector registered
[    9.309824][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[    9.320431][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[    9.418419][    T1] Console: switching to colour frame buffer device 128=
x48
[    9.434811][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[    9.436949][    T1] usbcore: registered new interface driver udl
[    9.497480][  T804] kworker/u8:5 (804) used greatest stack depth: 27136 =
bytes left
[    9.536903][    T1] brd: module loaded
[    9.649711][    T1] loop: module loaded
[    9.805358][    T1] zram: Added device: zram0
[    9.818794][    T1] null_blk: disk nullb0 created
[    9.819703][    T1] null_blk: module loaded
[    9.820523][    T1] Guest personality initialized and is inactive
[    9.822130][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D119)
[    9.823324][    T1] Initialized host personality
[    9.824207][    T1] usbcore: registered new interface driver rtsx_usb
[    9.826193][    T1] usbcore: registered new interface driver viperboard
[    9.827800][    T1] usbcore: registered new interface driver dln2
[    9.829804][    T1] usbcore: registered new interface driver pn533_usb
[    9.838027][    T1] nfcsim 0.2 initialized
[    9.838893][    T1] usbcore: registered new interface driver port100
[    9.840051][    T1] usbcore: registered new interface driver nfcmrvl
[    9.848387][    T1] Loading iSCSI transport class v2.0-870.
[    9.869483][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[    9.879674][    T1] ------------[ cut here ]------------
[    9.880549][    T1] refcount_t: decrement hit 0; leaking memory.
[    9.881818][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1d7/0x1f0
[    9.883132][    T1] Modules linked in:
[    9.883676][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00387-g6c6e47d69d82-dirty #0
[    9.887735][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.889174][    T1] RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0
[    9.890033][    T1] Code: 05 9b 98 fb 0a 01 e8 98 d0 0d fd 0f 0b e9 d7 f=
e ff ff e8 0c 81 4b fd 48 c7 c7 00 eb 2a 8b c6 05 7a 98 fb 0a 01 e8 79 d0 0=
d fd <0f> 0b e9 b8 fe ff ff 48 89 ef e8 ea 71 a4 fd e9 5c fe ff ff 0f 1f
[    9.892646][    T1] RSP: 0000:ffffc900000673b8 EFLAGS: 00010282
[    9.893490][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814faf0a
[    9.894555][    T1] RDX: ffff888017e78000 RSI: ffffffff814faf17 RDI: 000=
0000000000001
[    9.895754][    T1] RBP: ffff88801f81ef3c R08: 0000000000000001 R09: 000=
0000000000000
[    9.896829][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88801f81ef3c
[    9.897987][    T1] R13: 0000000000000000 R14: 0000000005e400ba R15: fff=
f888015a391c8
[    9.899235][    T1] FS:  0000000000000000(0000) GS:ffff8880b9400000(0000=
) knlGS:0000000000000000
[    9.900816][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.901761][    T1] CR2: ffff88823ffff000 CR3: 000000000d17a000 CR4: 000=
00000003506f0
[    9.902892][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    9.903984][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    9.905099][    T1] Call Trace:
[    9.905564][    T1]  <TASK>
[    9.905996][    T1]  ? show_regs+0x8c/0xa0
[    9.906613][    T1]  ? __warn+0xe5/0x3b0
[    9.907200][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.907962][    T1]  ? report_bug+0x3c0/0x580
[    9.908636][    T1]  ? handle_bug+0x3c/0x70
[    9.909296][    T1]  ? exc_invalid_op+0x17/0x40
[    9.910092][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    9.910797][    T1]  ? __warn_printk+0x17a/0x310
[    9.911479][    T1]  ? __warn_printk+0x187/0x310
[    9.912178][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.913194][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.914001][    T1]  __reset_page_owner+0x2ea/0x370
[    9.914767][    T1]  __free_pages_ok+0x5aa/0xbb0
[    9.915537][    T1]  ? __split_page_owner+0xdd/0x120
[    9.916319][    T1]  make_alloc_exact+0x165/0x260
[    9.917056][    T1]  vring_alloc_queue+0xc1/0x110
[    9.917761][    T1]  vring_alloc_queue_split.part.0+0x19a/0x4d0
[    9.918677][    T1]  ? __pfx_vring_alloc_queue_split.part.0+0x10/0x10
[    9.919618][    T1]  vring_create_virtqueue_split+0x135/0x300
[    9.920515][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.921189][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.921966][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.923065][    T1]  ? driver_register+0x15c/0x4b0
[    9.923794][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.924611][    T1]  ? do_one_initcall+0x113/0x6c0
[    9.925397][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.926167][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.927003][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.927812][    T1]  setup_vq+0x123/0x2f0
[    9.928521][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.929221][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.930011][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.930821][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.931621][    T1]  vp_setup_vq+0xb1/0x380
[    9.932241][    T1]  ? ioread16+0x50/0xc0
[    9.932824][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.933759][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.934541][    T1]  vp_find_vqs+0x58/0x560
[    9.935217][    T1]  virtscsi_init+0x459/0x9f0
[    9.935931][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.936649][    T1]  ? __init_waitqueue_head+0xca/0x150
[    9.937520][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.938447][    T1]  ? ioread8+0x4f/0xc0
[    9.939076][    T1]  ? vp_get+0xf6/0x140
[    9.939719][    T1]  virtscsi_probe+0x39b/0xda0
[    9.940444][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.941192][    T1]  virtio_dev_probe+0x5fd/0x9b0
[    9.941914][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.942658][    T1]  really_probe+0x23e/0xa90
[    9.943379][    T1]  __driver_probe_device+0x1de/0x440
[    9.944151][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.945028][    T1]  driver_probe_device+0x4c/0x1b0
[    9.945917][    T1]  __driver_attach+0x283/0x580
[    9.946607][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.947355][    T1]  bus_for_each_dev+0x12a/0x1c0
[    9.948044][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.948842][    T1]  bus_add_driver+0x2ed/0x640
[    9.949565][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.950373][    T1]  driver_register+0x15c/0x4b0
[    9.951097][    T1]  virtio_scsi_init+0x75/0x100
[    9.951761][    T1]  do_one_initcall+0x113/0x6c0
[    9.952473][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.953442][    T1]  ? parameq+0xf0/0x180
[    9.954130][    T1]  ? trace_kmalloc+0x2d/0xd0
[    9.954767][    T1]  ? __kmalloc+0x20f/0x430
[    9.955561][    T1]  kernel_init_freeable+0x5c7/0x900
[    9.956325][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.957064][    T1]  kernel_init+0x1c/0x2b0
[    9.957848][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.958677][    T1]  ret_from_fork+0x45/0x80
[    9.959408][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.960135][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.960816][    T1]  </TASK>
[    9.961290][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    9.962348][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00387-g6c6e47d69d82-dirty #0
[    9.963984][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    9.965538][    T1] Call Trace:
[    9.965538][    T1]  <TASK>
[    9.965538][    T1]  dump_stack_lvl+0x3d/0x1f0
[    9.965538][    T1]  panic+0x6d2/0x780
[    9.965538][    T1]  ? __pfx_panic+0x10/0x10
[    9.965538][    T1]  ? show_trace_log_lvl+0x35c/0x510
[    9.965538][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    9.965538][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.965538][    T1]  check_panic_on_warn+0xab/0xb0
[    9.965538][    T1]  __warn+0xf1/0x3b0
[    9.965538][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.965538][    T1]  report_bug+0x3c0/0x580
[    9.965538][    T1]  handle_bug+0x3c/0x70
[    9.965538][    T1]  exc_invalid_op+0x17/0x40
[    9.965538][    T1]  asm_exc_invalid_op+0x1a/0x20
[    9.965538][    T1] RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0
[    9.965538][    T1] Code: 05 9b 98 fb 0a 01 e8 98 d0 0d fd 0f 0b e9 d7 f=
e ff ff e8 0c 81 4b fd 48 c7 c7 00 eb 2a 8b c6 05 7a 98 fb 0a 01 e8 79 d0 0=
d fd <0f> 0b e9 b8 fe ff ff 48 89 ef e8 ea 71 a4 fd e9 5c fe ff ff 0f 1f
[    9.965538][    T1] RSP: 0000:ffffc900000673b8 EFLAGS: 00010282
[    9.965538][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff814faf0a
[    9.965538][    T1] RDX: ffff888017e78000 RSI: ffffffff814faf17 RDI: 000=
0000000000001
[    9.965538][    T1] RBP: ffff88801f81ef3c R08: 0000000000000001 R09: 000=
0000000000000
[    9.965538][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88801f81ef3c
[    9.965538][    T1] R13: 0000000000000000 R14: 0000000005e400ba R15: fff=
f888015a391c8
[    9.965538][    T1]  ? __warn_printk+0x17a/0x310
[    9.965538][    T1]  ? __warn_printk+0x187/0x310
[    9.965538][    T1]  ? refcount_warn_saturate+0x1d7/0x1f0
[    9.965538][    T1]  __reset_page_owner+0x2ea/0x370
[    9.965538][    T1]  __free_pages_ok+0x5aa/0xbb0
[    9.965538][    T1]  ? __split_page_owner+0xdd/0x120
[    9.965538][    T1]  make_alloc_exact+0x165/0x260
[    9.965538][    T1]  vring_alloc_queue+0xc1/0x110
[    9.965538][    T1]  vring_alloc_queue_split.part.0+0x19a/0x4d0
[    9.965538][    T1]  ? __pfx_vring_alloc_queue_split.part.0+0x10/0x10
[    9.965538][    T1]  vring_create_virtqueue_split+0x135/0x300
[    9.965538][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  ? __pfx_vring_create_virtqueue_split+0x10/0x10
[    9.965538][    T1]  ? driver_register+0x15c/0x4b0
[    9.965538][    T1]  ? virtio_scsi_init+0x75/0x100
[    9.965538][    T1]  ? do_one_initcall+0x113/0x6c0
[    9.965538][    T1]  vring_create_virtqueue+0xd7/0x140
[    9.965538][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  setup_vq+0x123/0x2f0
[    9.965538][    T1]  ? __pfx_vp_notify+0x10/0x10
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  vp_setup_vq+0xb1/0x380
[    9.965538][    T1]  ? ioread16+0x50/0xc0
[    9.965538][    T1]  ? __pfx_virtscsi_ctrl_done+0x10/0x10
[    9.965538][    T1]  vp_find_vqs_msix+0x661/0xe30
[    9.965538][    T1]  vp_find_vqs+0x58/0x560
[    9.965538][    T1]  virtscsi_init+0x459/0x9f0
[    9.965538][    T1]  ? __pfx_virtscsi_init+0x10/0x10
[    9.965538][    T1]  ? __init_waitqueue_head+0xca/0x150
[    9.965538][    T1]  ? __pfx_default_calc_sets+0x10/0x10
[    9.965538][    T1]  ? ioread8+0x4f/0xc0
[    9.965538][    T1]  ? vp_get+0xf6/0x140
[    9.965538][    T1]  virtscsi_probe+0x39b/0xda0
[    9.965538][    T1]  ? __pfx_virtscsi_probe+0x10/0x10
[    9.965538][    T1]  virtio_dev_probe+0x5fd/0x9b0
[    9.965538][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[    9.965538][    T1]  really_probe+0x23e/0xa90
[    9.965538][    T1]  __driver_probe_device+0x1de/0x440
[    9.965538][    T1]  ? _raw_spin_unlock_irqrestore+0x52/0x80
[    9.965538][    T1]  driver_probe_device+0x4c/0x1b0
[    9.965538][    T1]  __driver_attach+0x283/0x580
[    9.965538][    T1]  ? __pfx___driver_attach+0x10/0x10
[    9.965538][    T1]  bus_for_each_dev+0x12a/0x1c0
[    9.965538][    T1]  ? __pfx_bus_for_each_dev+0x10/0x10
[    9.965538][    T1]  bus_add_driver+0x2ed/0x640
[    9.965538][    T1]  ? __pfx_virtio_scsi_init+0x10/0x10
[    9.965538][    T1]  driver_register+0x15c/0x4b0
[    9.965538][    T1]  virtio_scsi_init+0x75/0x100
[    9.965538][    T1]  do_one_initcall+0x113/0x6c0
[    9.965538][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    9.965538][    T1]  ? parameq+0xf0/0x180
[    9.965538][    T1]  ? trace_kmalloc+0x2d/0xd0
[    9.965538][    T1]  ? __kmalloc+0x20f/0x430
[    9.965538][    T1]  kernel_init_freeable+0x5c7/0x900
[    9.965538][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.965538][    T1]  kernel_init+0x1c/0x2b0
[    9.965538][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.965538][    T1]  ret_from_fork+0x45/0x80
[    9.965538][    T1]  ? __pfx_kernel_init+0x10/0x10
[    9.965538][    T1]  ret_from_fork_asm+0x1a/0x30
[    9.965538][    T1]  </TASK>
[    9.965538][    T1] Kernel Offset: disabled
[    9.965538][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1747655191=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 1c576c232
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1c576c232f825266983096180b3603005edc458e -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221121-163647'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1c576c232f825266983096180b3603005edc458e -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221121-163647'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D1c576c232f825266983096180b3603005edc458e -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20221121-163647'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 =
\
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"1c576c232f825266983096180b3603005e=
dc458e\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12be7ead180000


Tested on:

commit:         6c6e47d6 Merge tag 'firewire-fixes-6.9-rc2' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84f10f559b1064f=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1bc2c2afd44f820a6=
69f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D117699a11800=
00


