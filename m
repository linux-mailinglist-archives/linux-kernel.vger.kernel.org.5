Return-Path: <linux-kernel+bounces-79482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA48622E1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2051F231BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EEF17592;
	Sat, 24 Feb 2024 06:22:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F2213FFF
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708755727; cv=none; b=RCMNFzTsWrzspmcQHamlNlwcl+WG8bRPGqR3PIOL7uJlMWDukonouRW+JMZQXJEMGEbAU8Up41IcdrjpK1YU91vc+8iYQhKS8E0ERr4H7GgjinUM+UVUfi4GjfPiCV/m+ndFHn9WDd4YsDYqByRZQSykJVPhCAOY0HxgnUt/O3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708755727; c=relaxed/simple;
	bh=gnU6k0z5KBb5Fa3d/AM6UwJ8ov8kGkz173MwJYFmp8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N8BUx1EPRWmAoIdP3ohxT0hztWazZ0vHA2HnON4qkXV15jPrUEmofjltBoP/ZDMZI9xWiWdsiEHoayb6DEOeG0WqgHi5vv7EMy+G83Ue0+F5eg56EwGR/MD/acBeujGHPolXEd34MmfA4COrLn6bTeorP9eLqiwq3BEJOHB7Liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c495649efdso109516139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708755724; x=1709360524;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2IjhjhymkhbyeNxyCF6SQLLGGyKJbrj+koxZ38QZP0=;
        b=EGEKWydUXiSmGEenXmlJRFQohGmOKbwlMsCsSR9xOpCnKPtJm0O8YB43Wp732JXhfN
         H94YkjUn3PzOSFsH714xTcwUXTUD8Z2EBKZOAjeU62ZxOb2f3bNzq26iRaOFkfUGN2ME
         /TpUyygi/MoKoJl5XSCL+gT8w1qIRZEgSbFJ6KgwYVK9MrCDukplzo/g2eohZWcGKxjx
         H/RNuHBdJxPqun5KcZMSIea92pxggYJu1sVSMk9mUpGMmqBZJWDgBYbzJtewRtC7elFV
         /jTx0WOBCNWNwVX9SEEVwI+MrKPz6Rz7vqMUhBYutJCWXaXQg9fdWQU9Tbnch1oSlxZg
         qY4A==
X-Gm-Message-State: AOJu0YwGBEjGNG0cciGM4M284LP2soAalEKhYO9k8jT9ipSN4U+IzhNm
	gIMJXRME5shnN4MBFOmkaDWM/T1x6YWhHB5bPHyRWnBH8d5j86N85PdCQiXlQ2yawkudgH/l4Hm
	ScqBqHZgTF33TF/6cacSTR7t5uICoH9rK3R8/UNEddOZawlY1oMc7X0ueRw==
X-Google-Smtp-Source: AGHT+IESRJqOzOme4xMEzTMtznsUqR5X8sEQFXbKmF/VXdARGxSVclBWcpRIpBZWjT4lUtho6MlMOZFFO/l9I81c332o4Ceb+stT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3712:b0:474:3b39:55ed with SMTP id
 k18-20020a056638371200b004743b3955edmr53149jav.6.1708755724212; Fri, 23 Feb
 2024 22:22:04 -0800 (PST)
Date: Fri, 23 Feb 2024 22:22:04 -0800
In-Reply-To: <be634ab4-58aa-40e4-8ab0-0e2685537525@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3208b06121ab106@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

d
[   21.218838][    T1] befs: version: 0.9.3
[   21.224039][    T1] ocfs2: Registered cluster interface o2cb
[   21.231409][    T1] ocfs2: Registered cluster interface user
[   21.238747][    T1] OCFS2 User DLM kernel interface loaded
[   21.258685][    T1] gfs2: GFS2 installed
[   21.299341][    T1] ceph: loaded (mds proto 32)
[   25.455884][    T1] NET: Registered PF_ALG protocol family
[   25.462173][    T1] xor: automatically using best checksumming function =
  avx      =20
[   25.470258][    T1] async_tx: api initialized (async)
[   25.475789][    T1] Key type asymmetric registered
[   25.480985][    T1] Asymmetric key parser 'x509' registered
[   25.486893][    T1] Asymmetric key parser 'pkcs8' registered
[   25.492975][    T1] Key type pkcs7_test registered
[   25.498812][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 240)
[   25.509132][    T1] io scheduler mq-deadline registered
[   25.514858][    T1] io scheduler kyber registered
[   25.520533][    T1] io scheduler bfq registered
[   25.537345][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   25.557878][    T1] ACPI: button: Power Button [PWRF]
[   25.565475][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   25.575850][    T1] ACPI: button: Sleep Button [SLPF]
[   25.599393][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   25.688382][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   25.698171][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   25.773719][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   25.780039][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   25.858501][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   25.864338][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   25.925717][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   26.972684][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   26.980030][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   26.993242][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   27.024320][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   27.054743][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   27.083834][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   27.133086][    T1] Non-volatile memory driver v1.3
[   27.161382][    T1] Linux agpgart interface v0.103
[   27.177896][    T1] ACPI: bus type drm_connector registered
[   27.195073][    T1] [drm] Initialized vgem 1.0.0 20120112 for vgem on mi=
nor 0
[   27.215880][    T1] [drm] Initialized vkms 1.0.0 20180514 for vkms on mi=
nor 1
[   27.690881][    T1] Console: switching to colour frame buffer device 128=
x48
[   27.845338][    T1] platform vkms: [drm] fb0: vkmsdrmfb frame buffer dev=
ice
[   27.853291][    T1] usbcore: registered new interface driver udl
[   28.015016][    T1] brd: module loaded
[   28.195324][    T1] loop: module loaded
[   28.444871][    T1] zram: Added device: zram0
[   28.471729][    T1] null_blk: disk nullb0 created
[   28.476949][    T1] null_blk: module loaded
[   28.481708][    T1] Guest personality initialized and is inactive
[   28.489569][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D118)
[   28.497772][    T1] Initialized host personality
[   28.503268][    T1] usbcore: registered new interface driver rtsx_usb
[   28.512421][    T1] usbcore: registered new interface driver viperboard
[   28.520209][    T1] usbcore: registered new interface driver dln2
[   28.527820][    T1] usbcore: registered new interface driver pn533_usb
[   28.540882][    T1] nfcsim 0.2 initialized
[   28.545800][    T1] usbcore: registered new interface driver port100
[   28.553465][    T1] usbcore: registered new interface driver nfcmrvl
[   28.570561][    T1] Loading iSCSI transport class v2.0-870.
[   28.605596][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   28.652924][    T1] scsi host0: Virtio SCSI HBA
[   29.190956][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[   29.207865][   T26] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[   29.257823][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[   29.270496][    T1] db_root: cannot open: /etc/target
[   29.286144][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.286396][    T1] BUG: KMSAN: use-after-free in __list_del_entry_valid=
_or_report+0x19e/0x490
[   29.286565][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   29.286657][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   29.286657][    T1]  stack_depot_save+0x12/0x20
[   29.286842][    T1]  ref_tracker_alloc+0x215/0x700
[   29.286842][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   29.286842][    T1]  netdev_register_kobject+0x30e/0x520
[   29.286842][    T1]  register_netdevice+0x198f/0x2170
[   29.286842][    T1]  bond_create+0x138/0x2a0
[   29.286842][    T1]  bonding_init+0x1a7/0x2d0
[   29.286842][    T1]  do_one_initcall+0x216/0x960
[   29.286842][    T1]  do_initcall_level+0x140/0x350
[   29.286842][    T1]  do_initcalls+0xf0/0x1d0
[   29.286842][    T1]  do_basic_setup+0x22/0x30
[   29.287955][    T1]  kernel_init_freeable+0x300/0x4b0
[   29.287955][    T1]  kernel_init+0x2f/0x7e0
[   29.287955][    T1]  ret_from_fork+0x66/0x80
[   29.287955][    T1]  ret_from_fork_asm+0x11/0x20
[   29.287955][    T1]=20
[   29.287955][    T1] Uninit was created at:
[   29.287955][    T1]  __free_pages_ok+0x133/0xeb0
[   29.287955][    T1]  alloc_pages_exact+0x2f5/0x350
[   29.287955][    T1]  vring_alloc_queue_split+0x2d9/0x990
[   29.287955][    T1]  vring_create_virtqueue_split+0x89/0x380
[   29.287955][    T1]  vring_create_virtqueue+0x101/0x1a0
[   29.287955][    T1]  setup_vq+0x175/0x510
[   29.287955][    T1]  vp_setup_vq+0x103/0x630
[   29.287955][    T1]  vp_find_vqs_msix+0x1162/0x16c0
[   29.287955][    T1]  vp_find_vqs+0x78/0x770
[   29.287955][    T1]  virtscsi_init+0xff7/0x17a0
[   29.289671][    T1]  virtscsi_probe+0x43b/0xfe0
[   29.289671][    T1]  virtio_dev_probe+0x16df/0x1900
[   29.289671][    T1]  really_probe+0x506/0xf40
[   29.289671][    T1]  __driver_probe_device+0x2a7/0x5d0
[   29.289671][    T1]  driver_probe_device+0x72/0x7b0
[   29.289671][    T1]  __driver_attach+0x710/0xa30
[   29.289671][    T1]  bus_for_each_dev+0x34c/0x530
[   29.289671][    T1]  driver_attach+0x51/0x60
[   29.289671][    T1]  bus_add_driver+0x747/0xca0
[   29.289671][    T1]  driver_register+0x3fb/0x650
[   29.289671][    T1]  register_virtio_driver+0xd1/0xf0
[   29.289671][    T1]  virtio_scsi_init+0x123/0x2f0
[   29.289671][    T1]  do_one_initcall+0x216/0x960
[   29.289671][    T1]  do_initcall_level+0x140/0x350
[   29.289671][    T1]  do_initcalls+0xf0/0x1d0
[   29.289671][    T1]  do_basic_setup+0x22/0x30
[   29.289671][    T1]  kernel_init_freeable+0x300/0x4b0
[   29.289671][    T1]  kernel_init+0x2f/0x7e0
[   29.289671][    T1]  ret_from_fork+0x66/0x80
[   29.289671][    T1]  ret_from_fork_asm+0x11/0x20
[   29.289671][    T1]=20
[   29.289671][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-00278-g603c04e27c3e-dirty #0
[   29.289671][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   29.289671][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.289671][    T1] Disabling lock debugging due to kernel taint
[   29.289671][    T1] Kernel panic - not syncing: kmsan.panic set ...
[   29.289671][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-rc5-syzkaller-00278-g603c04e27c3e-dirty #0
[   29.289671][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[   29.289671][    T1] Call Trace:
[   29.289671][    T1]  <TASK>
[   29.289671][    T1]  dump_stack_lvl+0x1bf/0x240
[   29.289671][    T1]  dump_stack+0x1e/0x20
[   29.289671][    T1]  panic+0x4de/0xc90
[   29.289671][    T1]  kmsan_report+0x2d0/0x2d0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? __msan_warning+0x96/0x110
[   29.289671][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
[   29.289671][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
[   29.289671][    T1]  ? stack_depot_save+0x12/0x20
[   29.289671][    T1]  ? ref_tracker_alloc+0x215/0x700
[   29.289671][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   29.289671][    T1]  ? netdev_register_kobject+0x30e/0x520
[   29.289671][    T1]  ? register_netdevice+0x198f/0x2170
[   29.289671][    T1]  ? bond_create+0x138/0x2a0
[   29.289671][    T1]  ? bonding_init+0x1a7/0x2d0
[   29.289671][    T1]  ? do_one_initcall+0x216/0x960
[   29.289671][    T1]  ? do_initcall_level+0x140/0x350
[   29.289671][    T1]  ? do_initcalls+0xf0/0x1d0
[   29.289671][    T1]  ? do_basic_setup+0x22/0x30
[   29.289671][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   29.289671][    T1]  ? kernel_init+0x2f/0x7e0
[   29.289671][    T1]  ? ret_from_fork+0x66/0x80
[   29.289671][    T1]  ? ret_from_fork_asm+0x11/0x20
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
[   29.289671][    T1]  ? filter_irq_stacks+0x60/0x1a0
[   29.289671][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  __msan_warning+0x96/0x110
[   29.289671][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[   29.289671][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[   29.289671][    T1]  stack_depot_save+0x12/0x20
[   29.289671][    T1]  ref_tracker_alloc+0x215/0x700
[   29.289671][    T1]  ? dev_uevent_filter+0x53/0x110
[   29.289671][    T1]  ? net_rx_queue_update_kobjects+0x1eb/0xa80
[   29.289671][    T1]  ? netdev_register_kobject+0x30e/0x520
[   29.289671][    T1]  ? register_netdevice+0x198f/0x2170
[   29.289671][    T1]  ? bond_create+0x138/0x2a0
[   29.289671][    T1]  ? bonding_init+0x1a7/0x2d0
[   29.289671][    T1]  ? do_one_initcall+0x216/0x960
[   29.289671][    T1]  ? do_initcall_level+0x140/0x350
[   29.289671][    T1]  ? do_initcalls+0xf0/0x1d0
[   29.289671][    T1]  ? do_basic_setup+0x22/0x30
[   29.289671][    T1]  ? kernel_init_freeable+0x300/0x4b0
[   29.289671][    T1]  ? kernel_init+0x2f/0x7e0
[   29.289671][    T1]  ? ret_from_fork+0x66/0x80
[   29.289671][    T1]  ? ret_from_fork_asm+0x11/0x20
[   29.289671][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   29.289671][    T1]  net_rx_queue_update_kobjects+0x1eb/0xa80
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  netdev_register_kobject+0x30e/0x520
[   29.289671][    T1]  register_netdevice+0x198f/0x2170
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  bond_create+0x138/0x2a0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  bonding_init+0x1a7/0x2d0
[   29.289671][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.289671][    T1]  do_one_initcall+0x216/0x960
[   29.289671][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.289671][    T1]  ? kmsan_get_metadata+0x80/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? filter_irq_stacks+0x164/0x1a0
[   29.289671][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[   29.289671][    T1]  ? skip_spaces+0x8f/0xc0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? parse_args+0x1511/0x15e0
[   29.289671][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[   29.289671][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[   29.289671][    T1]  ? spi_dln2_driver_init+0x40/0x40
[   29.289671][    T1]  do_initcall_level+0x140/0x350
[   29.289671][    T1]  do_initcalls+0xf0/0x1d0
[   29.289671][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
[   29.289671][    T1]  do_basic_setup+0x22/0x30
[   29.289671][    T1]  kernel_init_freeable+0x300/0x4b0
[   29.289671][    T1]  ? rest_init+0x260/0x260
[   29.289671][    T1]  kernel_init+0x2f/0x7e0
[   29.289671][    T1]  ? rest_init+0x260/0x260
[   29.289671][    T1]  ret_from_fork+0x66/0x80
[   29.289671][    T1]  ? rest_init+0x260/0x260
[   29.289671][    T1]  ret_from_fork_asm+0x11/0x20
[   29.289671][    T1]  </TASK>
[   29.289671][    T1] Kernel Offset: disabled


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
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
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
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4072519577=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 9bd8dcda8
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
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D9bd8dcda8c7c494d59bd3132a668f4784ea835c6 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240119-142441'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"9bd8dcda8c7c494d59bd3132a668f4784e=
a835c6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1409f29a180000


Tested on:

commit:         603c04e2 Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd33318d4e4a0d22=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3841ed075=
a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D164e2a9a1800=
00


