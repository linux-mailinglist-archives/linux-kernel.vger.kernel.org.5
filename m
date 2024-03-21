Return-Path: <linux-kernel+bounces-109539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D55881AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 042A8B211B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFB1877;
	Thu, 21 Mar 2024 01:35:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DAEC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984906; cv=none; b=eVzSVSKdrgdxtLKX5rBRrKjixKu2quYTv/NsaKFl1IkWSR4LAzENU9XLs2RU6prCgYV2kKtw1JEPhs2itB7rqCepYetgeW1/VZ1TbbP+z5Cjhipo4f2sxJwruBj+MpVpwbmCKgOJXcNVendh6CI2tOKRQoR+FRPJWiWO3szjmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984906; c=relaxed/simple;
	bh=H1uECHvzO7wxQelp0OnE15scijrq8jChvdcuxqsk/Dg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jdZQJQm8XXSER6+P7J7peCjhkQt8C6SaLii4IyO/3UozyG+PZlc7i07zxQdJjy25kgCwYVdzA+LDF0pnmxLwOdD5NOpRN4WzurM8JwhdoTW03t7obIbEBE9zdNVwRwNUFP2QWtnyksCsGchvBJuy3qZQpHym4SfaTYd+iFngydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-366b168b8e6so5009245ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984903; x=1711589703;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8uFf+HOOEu9ApKEmfZBgWMESFw5x9JRY+VVuEWkOTM=;
        b=CPBfOAIBE+FxuLQtQhzP0BTUjqVGnfbolUnEGF0Wl0oxG6rqUf0Bfsy5+/n8dpzXoP
         CYN6FAM7W4ibwNMoMKcd2QB+ub3LppomI9B2729dGHk4tDysOWZpGyMM7veomBoR4LVA
         QLlLKWtiQgT4A4ukvU5BjKZBv1M9RyhHYZXtAIbCOaxaKvAJstAqDcRCLqveusqmFEmy
         RfQeO5d/AopLj0FpmdR9NUMNat2XDYMsesKv9VJY1iZQKoDH7jeOu1BMoMaFWww96SGe
         fg4JIvrOaR74uoi5DUr00WRv1tjzOHklnbBMrJyC+0rVco2OrwjuPhtPaKgD6a6Inlb8
         47TA==
X-Forwarded-Encrypted: i=1; AJvYcCXGisgnMAWS3pV3aQUjosPvS/ed/OItAt5+ay96J5F0pc4Eep+lAOQt6GPCjLqUxC9cV6N57SOfCYll8gQsrQoZx8whCgysC4/HNsB9
X-Gm-Message-State: AOJu0YxhNqTapR2d+6g3FEuojmcPCq4jF7Pi+TcTdI7+McWqh0MAs45E
	M9riTPNKBRYl+CgX/4Cspbn47yeAvqKLcAuAh8M3OuoeTFDAy/G8aAqTOZ9tRbICgdKHPi/mmzL
	nGFBgZ2ROOPIi87CHB/DUfdqeYW+jLqSPzkCkEg/tblkW9NufU1yhiCs=
X-Google-Smtp-Source: AGHT+IFrnr0j67zgeJBDYLlyVZRg93LA85F6TRi5VanQZPQA4ypiM++TDpkTDbmx5scQoXzns9x/jllHGR9yMAO/iEFKPHVx6NQv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:3601:0:b0:368:4f35:92d8 with SMTP id
 d1-20020a923601000000b003684f3592d8mr416129ila.0.1710984903461; Wed, 20 Mar
 2024 18:35:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:35:03 -0700
In-Reply-To: <tencent_C6AB9264DD87DDB41946CFFA8DAA25B10D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000631d64061421b763@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

  3.305058][    T1] ACPI: 2 ACPI AML tables successfully acquired and loade=
d
[    3.345167][    T1] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    3.380560][    T1] ACPI: Interpreter enabled
[    3.381986][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    3.383436][    T1] ACPI: Using IOAPIC for interrupt routing
[    3.386458][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    3.390677][    T1] PCI: Ignoring E820 reservations for host bridge wind=
ows
[    3.404120][    T1] ACPI: Enabled 16 GPEs in block 00 to 0F
[    3.816060][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    3.818685][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    3.820678][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    3.825853][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    3.866305][    T1] PCI host bridge to bus 0000:00
[    3.867808][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    3.870746][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    3.873420][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    3.875780][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfefff window]
[    3.877928][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.882258][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    3.893319][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100=
 conventional PCI endpoint
[    3.934727][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    3.962720][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    3.974606][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    3.987448][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    3.996068][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    4.026294][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    4.037205][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    4.047843][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    4.079535][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    4.095238][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    4.131357][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    4.144658][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.159996][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    4.167804][    T1] pci 0000:00:06.0: BAR 1 [mem 0xfe802000-0xfe80207f]
[    4.199732][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.212382][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    4.220686][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe803000-0xfe80303f]
[    4.317862][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    4.332924][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    4.347440][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    4.361995][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    4.369427][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    4.408938][    T1] iommu: Default domain type: Translated
[    4.410243][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    4.417307][    T1] SCSI subsystem initialized
[    4.424332][    T1] ACPI: bus type USB registered
[    4.426871][    T1] usbcore: registered new interface driver usbfs
[    4.429598][    T1] usbcore: registered new interface driver hub
[    4.431177][    T1] usbcore: registered new device driver usb
[    4.437120][    T1] mc: Linux media interface: v0.10
[    4.438490][    T1] videodev: Linux video capture interface: v2.00
[    4.442426][    T1] pps_core: LinuxPPS API ver. 1 registered
[    4.444018][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    4.447319][    T1] PTP clock support registered
[    4.451694][    T1] EDAC MC: Ver: 3.0.0
[    4.461095][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    4.473440][    T1] Bluetooth: Core ver 2.22
[    4.474741][    T1] NET: Registered PF_BLUETOOTH protocol family
[    4.476138][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    4.478227][    T1] Bluetooth: HCI socket layer initialized
[    4.479583][    T1] Bluetooth: L2CAP socket layer initialized
[    4.480955][    T1] Bluetooth: SCO socket layer initialized
[    4.482638][    T1] NET: Registered PF_ATMPVC protocol family
[    4.484003][    T1] NET: Registered PF_ATMSVC protocol family
[    4.485973][    T1] NetLabel: Initializing
[    4.486946][    T1] NetLabel:  domain hash size =3D 128
[    4.487956][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    4.491596][    T1] NetLabel:  unlabeled traffic allowed by default
[    4.497799][    T1] nfc: nfc_init: NFC Core ver 0.1
[    4.499829][    T1] NET: Registered PF_NFC protocol family
[    4.500687][    T1] PCI: Using ACPI for IRQ routing
[    4.503830][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    4.505644][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    4.507273][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    4.510167][    T1] vgaarb: loaded
[    4.527031][    T1] clocksource: Switched to clocksource kvm-clock
[    4.530275][    T1] VFS: Disk quotas dquot_6.6.0
[    4.530642][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    4.535808][    T1] TOMOYO: 2.6.0
[    4.536472][    T1] Mandatory Access Control activated.
[    4.546108][    T1] AppArmor: AppArmor Filesystem Enabled
[    4.549360][    T1] pnp: PnP ACPI init
[    4.604367][    T1] pnp: PnP ACPI: found 7 devices
[    4.694258][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    4.698986][    T1] NET: Registered PF_INET protocol family
[    4.701555][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    4.734977][    T1] ------------[ cut here ]------------
[    4.736183][    T1] refcount_t: decrement hit 0; leaking memory.
[    4.738151][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[    4.741044][    T1] Modules linked in:
[    4.742030][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11767-g23956900041d-dirty #0
[    4.744715][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    4.746880][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.748509][    T1] Code: 86 e8 07 31 ca fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 c8 05 04 ff c6 05 de 77 3d 07 01 90 48 c7 c7 80 27 e7 86 e8 e4 30 ca f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 f2 dd 55 ff e9 44 fe ff ff
[    4.753988][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.755467][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8118b199
[    4.756870][    T1] RDX: ffff8881012b0000 RSI: ffffffff8118b1a6 RDI: 000=
0000000000001
[    4.759096][    T1] RBP: ffff8881076c8aac R08: 0000000000000001 R09: 000=
0000000000000
[    4.761254][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f8881076c8aac
[    4.762823][    T1] R13: 0000000000000000 R14: 000000000152005a R15: fff=
f888106899f28
[    4.764957][    T1] FS:  0000000000000000(0000) GS:ffff8881f6400000(0000=
) knlGS:0000000000000000
[    4.768035][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.769740][    T1] CR2: ffff88823ffff000 CR3: 000000000829e000 CR4: 000=
00000003506f0
[    4.771844][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.774449][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.776329][    T1] Call Trace:
[    4.777314][    T1]  <TASK>
[    4.778263][    T1]  ? show_regs+0x8c/0xa0
[    4.779980][    T1]  ? __warn+0xe5/0x3c0
[    4.781778][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.783348][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.784682][    T1]  ? report_bug+0x3c0/0x580
[    4.786057][    T1]  ? handle_bug+0x3d/0x70
[    4.786960][    T1]  ? exc_invalid_op+0x17/0x50
[    4.788001][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    4.789478][    T1]  ? __warn_printk+0x199/0x350
[    4.790751][    T1]  ? __warn_printk+0x1a6/0x350
[    4.792085][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.793191][    T1]  __reset_page_owner+0x2ea/0x370
[    4.794640][    T1]  __free_pages_ok+0x5d0/0xbd0
[    4.795484][    T1]  ? __split_page_owner+0xdd/0x120
[    4.796259][    T1]  make_alloc_exact+0x165/0x260
[    4.797178][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.798659][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.799662][    T1]  tcp_init+0xba/0x9f0
[    4.800581][    T1]  inet_init+0x419/0x6f0
[    4.801638][    T1]  ? __pfx_inet_init+0x10/0x10
[    4.802833][    T1]  do_one_initcall+0x128/0x700
[    4.803971][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.806124][    T1]  ? trace_kmalloc+0x2d/0xe0
[    4.807395][    T1]  ? __kmalloc+0x213/0x400
[    4.808797][    T1]  kernel_init_freeable+0x69d/0xca0
[    4.810003][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.810805][    T1]  kernel_init+0x1c/0x2b0
[    4.811720][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.812936][    T1]  ret_from_fork+0x45/0x80
[    4.813638][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.814804][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.816207][    T1]  </TASK>
[    4.816802][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    4.817978][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-syzk=
aller-11767-g23956900041d-dirty #0
[    4.819974][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/29/2024
[    4.819974][    T1] Call Trace:
[    4.819974][    T1]  <TASK>
[    4.819974][    T1]  dump_stack_lvl+0x3d/0x1f0
[    4.819974][    T1]  panic+0x6f5/0x7a0
[    4.819974][    T1]  ? __pfx_panic+0x10/0x10
[    4.819974][    T1]  ? show_trace_log_lvl+0x363/0x500
[    4.819974][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    4.819974][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.819974][    T1]  check_panic_on_warn+0xab/0xb0
[    4.819974][    T1]  __warn+0xf1/0x3c0
[    4.819974][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.819974][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.819974][    T1]  report_bug+0x3c0/0x580
[    4.819974][    T1]  handle_bug+0x3d/0x70
[    4.819974][    T1]  exc_invalid_op+0x17/0x50
[    4.819974][    T1]  asm_exc_invalid_op+0x1a/0x20
[    4.819974][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.819974][    T1] Code: 86 e8 07 31 ca fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 c8 05 04 ff c6 05 de 77 3d 07 01 90 48 c7 c7 80 27 e7 86 e8 e4 30 ca f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 f2 dd 55 ff e9 44 fe ff ff
[    4.819974][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.819974][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8118b199
[    4.819974][    T1] RDX: ffff8881012b0000 RSI: ffffffff8118b1a6 RDI: 000=
0000000000001
[    4.819974][    T1] RBP: ffff8881076c8aac R08: 0000000000000001 R09: 000=
0000000000000
[    4.819974][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f8881076c8aac
[    4.819974][    T1] R13: 0000000000000000 R14: 000000000152005a R15: fff=
f888106899f28
[    4.819974][    T1]  ? __warn_printk+0x199/0x350
[    4.819974][    T1]  ? __warn_printk+0x1a6/0x350
[    4.819974][    T1]  __reset_page_owner+0x2ea/0x370
[    4.819974][    T1]  __free_pages_ok+0x5d0/0xbd0
[    4.819974][    T1]  ? __split_page_owner+0xdd/0x120
[    4.819974][    T1]  make_alloc_exact+0x165/0x260
[    4.819974][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.819974][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.819974][    T1]  tcp_init+0xba/0x9f0
[    4.819974][    T1]  inet_init+0x419/0x6f0
[    4.819974][    T1]  ? __pfx_inet_init+0x10/0x10
[    4.819974][    T1]  do_one_initcall+0x128/0x700
[    4.819974][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.819974][    T1]  ? trace_kmalloc+0x2d/0xe0
[    4.819974][    T1]  ? __kmalloc+0x213/0x400
[    4.819974][    T1]  kernel_init_freeable+0x69d/0xca0
[    4.819974][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.819974][    T1]  kernel_init+0x1c/0x2b0
[    4.869878][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.869878][    T1]  ret_from_fork+0x45/0x80
[    4.869878][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.869878][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.869878][    T1]  </TASK>
[    4.869878][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1907310309=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at a485f2390
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da485f2390d41decb9fca41e15902295e293464d2 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240319-162551'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da485f2390d41decb9fca41e15902295e293464d2 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240319-162551'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da485f2390d41decb9fca41e15902295e293464d2 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240319-162551'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"a485f2390d41decb9fca41e15902295e29=
3464d2\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10e977be180000


Tested on:

commit:         23956900 Merge tag 'v6.9-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7168075f97c1225=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D93cbd5fbb85814306=
ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D15a8783a1800=
00


