Return-Path: <linux-kernel+bounces-144074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE548A4187
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D231C20DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4F22F11;
	Sun, 14 Apr 2024 09:30:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329E1AACB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087005; cv=none; b=A3Twz8eSLMGkxAyC1baM38lSqXACwXV5igdGqcyBHkSicY992Jm8SZ+hn1Sk+pifcdswRs9R+1+TTGZ/0+TONOqlJNcTdGgUKXaSRKWf+UDksogEQTXmrtnQgJ3SFSst4LH/FdgRv+06iaQQYAzp0pVn/JJqv3ixP5U7WtF+gN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087005; c=relaxed/simple;
	bh=CWwxohlFhva1HLwDEEc6bgdJv7zRNim4xDA7KYssHJ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lQ4NQz8GrtqZxeocx6jKGNzmH5hJyNJVj/bfa4E177AzWmkRoqQ2t3y9AHan0/NvUk0A+4cCxpsjKhBjU1Ua2ivFNysiOAumoSyBFYGILw8Oy7Cc1pMlIONk/Ij2BvpP2Ut9g9DdE+GICGGpcBrMX9pUAEIkqdgDluXRlvLWs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so186592539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713087003; x=1713691803;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKZ8TSEO5J6VVaJbebo8YG3pSUUfD07VkRu3TaOJ7sI=;
        b=dbwMzilai4GShbG2+TAQwIm4zgaau9J88tzB711STWj3OknuKJSypoRK1am8ItBNxm
         pa/o26ftIaDqvdTWiuGhLb3WLYtNkadv9VCDbt15YV1AA2USDtkQU+Tg3hJJ1JhwTP0m
         JexaE5BF9i+GlKrABVfTHe1bglvs5WbuCkopJeRApL8zd+4XkYqJ45uWi69ls/c9soRX
         J6PCLXKeaLFdXpxLYsyyK7gSbn4JQIkE04XPBT7ZT3kbie/X7UNntwOKasVTpgaLfg49
         6tJ5z9xjpnmZh4qndMshryT6u23bMQR3GL6BOwlgKOiX5Hp3rXkj7+FKuAHz8WoDkZPs
         4B9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL39yit4yutBdx+d5EQfmr3mzCOAQvsy0iNeoSNuWDJPRVoiXmef4vJmYChJLfTcgfK8o6reTBixap+CvNMFa1BABcAEL/4S14Pph1
X-Gm-Message-State: AOJu0YwDlFgDCFyomU6JowPyo54N0JYlFv8fCpfUyIuyldxzPm3E7yYP
	2cTiUXxLeHOXRzgjkW4J65r6OUnS/dG0FcMxK6YAjLvmUWb9nnb8DyGFmXsjtIbuihAa5Zr8Ry4
	89/SSxcIPC3lTGQq1OTiuziNvTt+juldjUV9O3Eay7cUTuP1u/TPKlnA=
X-Google-Smtp-Source: AGHT+IFu9TZO3vI63skPBgymPSZikJU1x2o9HTdEBI+oXMSfLakmuKuQVCvFMTLRQ3tC5GhkCj9K8KK5vh7F6cRzP8Vn9Lnu5KvA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8525:b0:482:e78a:899c with SMTP id
 is37-20020a056638852500b00482e78a899cmr231424jab.3.1713087003014; Sun, 14 Apr
 2024 02:30:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 02:30:03 -0700
In-Reply-To: <20240414090253.2294-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048cb1306160b264a@google.com>
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (3)
From: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

91][    T1] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    3.614673][    T1] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    3.646357][    T1] ACPI: Interpreter enabled
[    3.648193][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    3.649163][    T1] ACPI: Using IOAPIC for interrupt routing
[    3.650860][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    3.651369][    T1] PCI: Ignoring E820 reservations for host bridge wind=
ows
[    3.662167][    T1] ACPI: Enabled 16 GPEs in block 00 to 0F
[    4.033152][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    4.034764][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    4.036247][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    4.039584][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    4.075099][    T1] PCI host bridge to bus 0000:00
[    4.076061][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    4.077387][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    4.078606][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    4.080065][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfefff window]
[    4.081402][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    4.083887][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    4.094418][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100=
 conventional PCI endpoint
[    4.135316][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    4.166509][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    4.176175][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    4.187818][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    4.196090][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    4.223988][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    4.234695][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    4.243163][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    4.272806][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    4.285866][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    4.317757][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    4.329713][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.341390][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    4.348543][    T1] pci 0000:00:06.0: BAR 1 [mem 0xfe802000-0xfe80207f]
[    4.376630][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.387973][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    4.396013][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe803000-0xfe80303f]
[    4.481476][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    4.495349][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    4.508536][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    4.522312][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    4.529440][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    4.565749][    T1] iommu: Default domain type: Translated
[    4.566927][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    4.574481][    T1] SCSI subsystem initialized
[    4.579451][    T1] ACPI: bus type USB registered
[    4.581306][    T1] usbcore: registered new interface driver usbfs
[    4.589444][    T1] usbcore: registered new interface driver hub
[    4.591072][    T1] usbcore: registered new device driver usb
[    4.594960][    T1] mc: Linux media interface: v0.10
[    4.596691][    T1] videodev: Linux video capture interface: v2.00
[    4.601447][    T1] pps_core: LinuxPPS API ver. 1 registered
[    4.602363][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    4.605231][    T1] PTP clock support registered
[    4.609007][    T1] EDAC MC: Ver: 3.0.0
[    4.616776][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    4.627872][    T1] Bluetooth: Core ver 2.22
[    4.629284][    T1] NET: Registered PF_BLUETOOTH protocol family
[    4.630417][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    4.631589][    T1] Bluetooth: HCI socket layer initialized
[    4.632742][    T1] Bluetooth: L2CAP socket layer initialized
[    4.634185][    T1] Bluetooth: SCO socket layer initialized
[    4.635853][    T1] NET: Registered PF_ATMPVC protocol family
[    4.636961][    T1] NET: Registered PF_ATMSVC protocol family
[    4.638662][    T1] NetLabel: Initializing
[    4.639413][    T1] NetLabel:  domain hash size =3D 128
[    4.641372][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    4.644039][    T1] NetLabel:  unlabeled traffic allowed by default
[    4.649764][    T1] nfc: nfc_init: NFC Core ver 0.1
[    4.652037][    T1] NET: Registered PF_NFC protocol family
[    4.653537][    T1] PCI: Using ACPI for IRQ routing
[    4.656664][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    4.658465][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    4.659754][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    4.661395][    T1] vgaarb: loaded
[    4.682286][    T1] clocksource: Switched to clocksource kvm-clock
[    4.691143][    T1] VFS: Disk quotas dquot_6.6.0
[    4.691361][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    4.696332][    T1] TOMOYO: 2.6.0
[    4.697632][    T1] Mandatory Access Control activated.
[    4.706768][    T1] AppArmor: AppArmor Filesystem Enabled
[    4.709648][    T1] pnp: PnP ACPI init
[    4.758720][    T1] pnp: PnP ACPI: found 7 devices
[    4.839879][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    4.844298][    T1] NET: Registered PF_INET protocol family
[    4.847213][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    4.862177][    T1] ------------[ cut here ]------------
[    4.863545][    T1] refcount_t: decrement hit 0; leaking memory.
[    4.866291][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[    4.868831][    T1] Modules linked in:
[    4.869929][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00077-g3d122e6d27e4-dirty #0
[    4.872557][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    4.874517][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.876676][    T1] Code: 86 e8 87 1c ca fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 e8 f4 03 ff c6 05 d3 4f 3d 07 01 90 48 c7 c7 00 2e e7 86 e8 64 1c ca f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 52 d1 55 ff e9 44 fe ff ff
[    4.881228][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.882527][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8118c1a9
[    4.884580][    T1] RDX: ffff8881012a8000 RSI: ffffffff8118c1b6 RDI: 000=
0000000000001
[    4.885990][    T1] RBP: ffff888106ee853c R08: 0000000000000001 R09: 000=
0000000000000
[    4.887750][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888106ee853c
[    4.890006][    T1] R13: 0000000000000000 R14: 0000000000a40059 R15: fff=
f888106679f28
[    4.891526][    T1] FS:  0000000000000000(0000) GS:ffff8881f6400000(0000=
) knlGS:0000000000000000
[    4.893530][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.895233][    T1] CR2: ffff88823ffff000 CR3: 000000000829e000 CR4: 000=
00000003506f0
[    4.897559][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.899665][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.901169][    T1] Call Trace:
[    4.901995][    T1]  <TASK>
[    4.902478][    T1]  ? show_regs+0x8c/0xa0
[    4.904000][    T1]  ? __warn+0xe5/0x3c0
[    4.905027][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.906240][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.908147][    T1]  ? report_bug+0x3c0/0x580
[    4.909407][    T1]  ? handle_bug+0x3d/0x70
[    4.910307][    T1]  ? exc_invalid_op+0x17/0x50
[    4.911531][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    4.913111][    T1]  ? __warn_printk+0x199/0x350
[    4.914285][    T1]  ? __warn_printk+0x1a6/0x350
[    4.915687][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.917380][    T1]  __reset_page_owner+0x2ea/0x370
[    4.918474][    T1]  __free_pages_ok+0x5d0/0xbd0
[    4.919831][    T1]  ? __split_page_owner+0xdd/0x120
[    4.921296][    T1]  make_alloc_exact+0x165/0x260
[    4.922990][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.924052][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.925350][    T1]  tcp_init+0xba/0x9f0
[    4.926596][    T1]  inet_init+0x419/0x6f0
[    4.928032][    T1]  ? __pfx_inet_init+0x10/0x10
[    4.929343][    T1]  do_one_initcall+0x128/0x700
[    4.930535][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.932057][    T1]  ? trace_kmalloc+0x2d/0xe0
[    4.932985][    T1]  ? __kmalloc+0x213/0x400
[    4.933838][    T1]  kernel_init_freeable+0x69d/0xca0
[    4.934840][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.935868][    T1]  kernel_init+0x1c/0x2b0
[    4.937223][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.938288][    T1]  ret_from_fork+0x45/0x80
[    4.939009][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.940454][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.941548][    T1]  </TASK>
[    4.942500][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    4.944326][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00077-g3d122e6d27e4-dirty #0
[    4.946854][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 03/27/2024
[    4.949083][    T1] Call Trace:
[    4.950163][    T1]  <TASK>
[    4.950970][    T1]  dump_stack_lvl+0x3d/0x1f0
[    4.951524][    T1]  panic+0x6f5/0x7a0
[    4.951524][    T1]  ? __pfx_panic+0x10/0x10
[    4.951524][    T1]  ? show_trace_log_lvl+0x363/0x500
[    4.951524][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    4.951524][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.951524][    T1]  check_panic_on_warn+0xab/0xb0
[    4.951524][    T1]  __warn+0xf1/0x3c0
[    4.951524][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.951524][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.951524][    T1]  report_bug+0x3c0/0x580
[    4.951524][    T1]  handle_bug+0x3d/0x70
[    4.951524][    T1]  exc_invalid_op+0x17/0x50
[    4.951524][    T1]  asm_exc_invalid_op+0x1a/0x20
[    4.951524][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.951524][    T1] Code: 86 e8 87 1c ca fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 e8 f4 03 ff c6 05 d3 4f 3d 07 01 90 48 c7 c7 00 2e e7 86 e8 64 1c ca f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 52 d1 55 ff e9 44 fe ff ff
[    4.951524][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.951524][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff8118c1a9
[    4.951524][    T1] RDX: ffff8881012a8000 RSI: ffffffff8118c1b6 RDI: 000=
0000000000001
[    4.951524][    T1] RBP: ffff888106ee853c R08: 0000000000000001 R09: 000=
0000000000000
[    4.951524][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f888106ee853c
[    4.951524][    T1] R13: 0000000000000000 R14: 0000000000a40059 R15: fff=
f888106679f28
[    4.951524][    T1]  ? __warn_printk+0x199/0x350
[    4.951524][    T1]  ? __warn_printk+0x1a6/0x350
[    4.951524][    T1]  __reset_page_owner+0x2ea/0x370
[    4.951524][    T1]  __free_pages_ok+0x5d0/0xbd0
[    4.951524][    T1]  ? __split_page_owner+0xdd/0x120
[    4.951524][    T1]  make_alloc_exact+0x165/0x260
[    4.951524][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.951524][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.951524][    T1]  tcp_init+0xba/0x9f0
[    4.951524][    T1]  inet_init+0x419/0x6f0
[    4.951524][    T1]  ? __pfx_inet_init+0x10/0x10
[    5.001542][    T1]  do_one_initcall+0x128/0x700
[    5.001542][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    5.001542][    T1]  ? trace_kmalloc+0x2d/0xe0
[    5.001542][    T1]  ? __kmalloc+0x213/0x400
[    5.001542][    T1]  kernel_init_freeable+0x69d/0xca0
[    5.001542][    T1]  ? __pfx_kernel_init+0x10/0x10
[    5.001542][    T1]  kernel_init+0x1c/0x2b0
[    5.001542][    T1]  ? __pfx_kernel_init+0x10/0x10
[    5.001542][    T1]  ret_from_fork+0x45/0x80
[    5.001542][    T1]  ? __pfx_kernel_init+0x10/0x10
[    5.001542][    T1]  ret_from_fork_asm+0x1a/0x30
[    5.001542][    T1]  </TASK>
[    5.001542][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1222580029=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 171ec3714
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
/syzkaller/prog.GitRevision=3D171ec3714ee4886a3f5ecbfe71f63c8f81c7fd7c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-121653'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D171ec3714ee4886a3f5ecbfe71f63c8f81c7fd7c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-121653'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D171ec3714ee4886a3f5ecbfe71f63c8f81c7fd7c -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240409-121653'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"171ec3714ee4886a3f5ecbfe71f63c8f81=
c7fd7c\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10eba243180000


Tested on:

commit:         3d122e6d usb: typec: mux: gpio-sbu: Allow GPIO operati..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbd9338c1f703fa5=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd0f14b2d5a3d1587f=
be7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1182aaf51800=
00


