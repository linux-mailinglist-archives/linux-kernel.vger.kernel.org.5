Return-Path: <linux-kernel+bounces-79927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C608628C8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DBA1C20DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559394C96;
	Sun, 25 Feb 2024 02:19:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3711C11
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708827545; cv=none; b=SMrqy/A6tOPwqIPs5ac6auU8KPkq8Ewq8c/wnLMp3+1HfONedJzdfO/325CoJcjTAfVHsSa58jhBn+mEA1/HYC6pdU61qDjM3GomSLA9gRPMaw8PLMzzX8OrKtkcR0uR9Xic1rA9itZDRWAa6N7yP89azqxLp+6ymgHXKnYGqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708827545; c=relaxed/simple;
	bh=r72d0kIDOaMSfBor8bNFgWX/sV1s+cpJi7dnukRUt1s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pVr/8ztz4PrXgYFeX2o0qo8yG0vPmStY4Q773ICjo6Gb+P6aFeffQ8P6K6o6ZFgd0TfNIPgDsDM83eUNryF3lOfdhYsMXzHhh4fE6B9aSIYPxCWkPIHHmXslKhyOBovquPqaEJiMk2NAsBHZsfQknY4Eb1Ty1kiufMTgGuiro3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36520abf45eso19805245ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 18:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708827542; x=1709432342;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1rILQV7JfFInxHWu63LlsQA5l7wMEghsoDr+QL4LBw=;
        b=enW90mXlR1ckdJWZCFKM6akZOUt5FUJqH0ZSXpMCx8jrUoKcQexA/vc4f4LStd0SLj
         BJ1ha1wrCBYTr8HHlnXJ9LyJVijv+cYqP467YIHeFcQ/4QLwJX85GPJ43i/dMt0zhzRW
         VO8a8/jfvjK7oF9w24VptTn3pLAT2mfRS0WmgKQCAn+NZdn4adIge5CpNIQKlYpXqQbV
         STgdv/RffBNm+4BZvvbrRqWRw3yEWBwjnga7A1z6pRiYjVGQnhoX72r/bMLtp0NB2jf/
         5F1ewr/08RcG4IVgf3Fth12oaQ1aNhDggdDIT06EHJcUc0w9l7KExIFWAXjtuT9Fq7Gu
         Vlwg==
X-Gm-Message-State: AOJu0Yx76z1H1pMEFN4O8VSYIOEdm5S2BzmeqIcbaVD/Zaf4YEP7ZDCl
	NClYp7lj4iniNSX4pMq/piiSG655Qu/P28xQSxrI5ScarDIn8yl1AimDCXySwYcA+MVdFhd7y96
	Qbg58G5CjfLtbMSOxGjnnyvepEw50BkL7JroFKjcaLnt1MXL5oJLIstz66w==
X-Google-Smtp-Source: AGHT+IH5mJdENmw2tmjwFF6MGySwN0K/dkk+wdSIXztOjiiKAO65dkddgLvmSfU8xv+EkTJOjfWTHSQ/muFE/nlze3UyDFwii7bj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2146:b0:363:7bac:528e with SMTP id
 d6-20020a056e02214600b003637bac528emr254158ilv.1.1708827542632; Sat, 24 Feb
 2024 18:19:02 -0800 (PST)
Date: Sat, 24 Feb 2024 18:19:02 -0800
In-Reply-To: <f555e0b7-00f6-48e2-abe5-b29bedf8c4c3@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a93fca06122b6a90@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 processors activated (8800.82 BogoMIPS)
[    1.438059][    T1] devtmpfs: initialized
[    1.438059][    T1] x86/mm: Memory block size: 128MB
[    1.537424][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 19112604462750000 ns
[    1.541248][    T1] futex hash table entries: 512 (order: 3, 32768 bytes=
, vmalloc)
[    1.543999][    T1] PM: RTC time: 02:09:52, date: 2024-02-25
[    1.551035][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.570747][    T1] audit: initializing netlink subsys (disabled)
[    1.573762][   T27] audit: type=3D2000 audit(1708826992.525:1): state=3D=
initialized audit_enabled=3D0 res=3D1
[    1.589225][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    1.589289][    T1] thermal_sys: Registered thermal governor 'user_space=
'
[    1.591526][    T1] cpuidle: using governor menu
[    1.594184][    T1] NET: Registered PF_QIPCRTR protocol family
[    1.609953][    T1] dca service started, version 1.12.1
[    1.610033][    T1] PCI: Using configuration type 1 for base access
[    1.637050][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocate=
d 0 pages
[    1.640047][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB p=
age
[    1.642925][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocate=
d 0 pages
[    1.643291][    T1] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB p=
age
[    1.693336][    T1] raid6: skipped pq benchmark and selected avx2x4
[    1.693336][    T1] raid6: using avx2x2 recovery algorithm
[    1.697685][    T1] ACPI: Added _OSI(Module Device)
[    1.700031][    T1] ACPI: Added _OSI(Processor Device)
[    1.703277][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.705648][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    2.205354][    T1] ACPI: 2 ACPI AML tables successfully acquired and lo=
aded
[    2.299980][    T1] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    2.362337][    T1] ACPI: Interpreter enabled
[    2.364750][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    2.365761][    T1] ACPI: Using IOAPIC for interrupt routing
[    2.368508][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    2.371280][    T1] PCI: Ignoring E820 reservations for host bridge wind=
ows
[    2.390515][    T1] ACPI: Enabled 16 GPEs in block 00 to 0F
[    3.115531][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    3.117418][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    3.119220][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    3.123713][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    3.193294][    T1] PCI host bridge to bus 0000:00
[    3.193294][    T1] pci_bus 0000:00: Unknown NUMA node; performance will=
 be reduced
[    3.194712][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    3.196205][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    3.197730][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    3.199394][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfefff window]
[    3.200955][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.204545][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    3.216364][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100=
 conventional PCI endpoint
[    3.259076][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    3.289965][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    3.303975][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    3.316498][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    3.324669][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    3.358364][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    3.374736][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    3.383283][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    3.419323][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    3.437913][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    3.476881][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    3.495064][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.509218][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    3.518528][    T1] pci 0000:00:06.0: BAR 1 [mem 0xfe802000-0xfe80207f]
[    3.557251][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    3.569662][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    3.578093][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe803000-0xfe80303f]
[    3.723845][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    3.748176][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.771042][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.793854][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.805804][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    3.874360][    T1] iommu: Default domain type: Translated
[    3.874835][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    3.890314][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.890556][    T1] BUG: KMSAN: uninit-value in __list_del_entry_valid_o=
r_report+0x19e/0x490
[    3.890717][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[    3.890868][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[    3.890973][    T1]  stack_depot_save+0x12/0x20
[    3.891068][    T1]  ref_tracker_alloc+0x215/0x700
[    3.891170][    T1]  sk_alloc+0x7b4/0x850
[    3.891271][    T1]  __netlink_kernel_create+0x1ec/0xe50
[    3.891398][    T1]  scsi_netlink_init+0x6f/0x140
[    3.891505][    T1]  init_scsi+0x1dc/0x300
[    3.891593][    T1]  do_one_initcall+0x216/0x960
[    3.891705][    T1]  do_initcall_level+0x140/0x350
[    3.891814][    T1]  do_initcalls+0xf0/0x1d0
[    3.891913][    T1]  do_basic_setup+0x22/0x30
[    3.892013][    T1]  kernel_init_freeable+0x300/0x4b0
[    3.892122][    T1]  kernel_init+0x2f/0x7e0
[    3.892241][    T1]  ret_from_fork+0x66/0x80
[    3.892364][    T1]  ret_from_fork_asm+0x11/0x20
[    3.892477][    T1]=20
[    3.892491][    T1] Uninit was created at:
[    3.892629][    T1]  __alloc_pages+0x9a4/0xe00
[    3.892712][    T1]  alloc_pages_mpol+0x62b/0x9d0
[    3.892806][    T1]  alloc_pages+0x1be/0x1e0
[    3.892895][    T1]  stack_depot_save_flags+0x73a/0x7b0
[    3.892999][    T1]  stack_depot_save+0x12/0x20
[    3.893094][    T1]  ref_tracker_alloc+0x215/0x700
[    3.893196][    T1]  sk_alloc+0x7b4/0x850
[    3.893197][    T1]  __netlink_kernel_create+0x1ec/0xe50
[    3.893197][    T1]  cn_init+0x6f/0x280
[    3.893197][    T1]  do_one_initcall+0x216/0x960
[    3.893197][    T1]  do_initcall_level+0x140/0x350
[    3.893197][    T1]  do_initcalls+0xf0/0x1d0
[    3.893197][    T1]  do_basic_setup+0x22/0x30
[    3.893197][    T1]  kernel_init_freeable+0x300/0x4b0
[    3.893197][    T1]  kernel_init+0x2f/0x7e0
[    3.893197][    T1]  ret_from_fork+0x66/0x80
[    3.893197][    T1]  ret_from_fork_asm+0x11/0x20
[    3.893197][    T1]=20
[    3.893197][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-=
syzkaller-00329-gab0a97cffa0b-dirty #0
[    3.893197][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[    3.893197][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    3.893197][    T1] Disabling lock debugging due to kernel taint
[    3.893197][    T1] Kernel panic - not syncing: kmsan.panic set ...
[    3.893197][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B       =
       6.8.0-rc5-syzkaller-00329-gab0a97cffa0b-dirty #0
[    3.893197][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 01/25/2024
[    3.893197][    T1] Call Trace:
[    3.893197][    T1]  <TASK>
[    3.893197][    T1]  dump_stack_lvl+0x1bf/0x240
[    3.893197][    T1]  dump_stack+0x1e/0x20
[    3.893197][    T1]  panic+0x4de/0xc90
[    3.893197][    T1]  kmsan_report+0x2d0/0x2d0
[    3.893197][    T1]  ? kmsan_metadata_is_contiguous+0x66/0x1e0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? __msan_warning+0x96/0x110
[    3.893197][    T1]  ? __list_del_entry_valid_or_report+0x19e/0x490
[    3.893197][    T1]  ? stack_depot_save_flags+0x3e7/0x7b0
[    3.893197][    T1]  ? stack_depot_save+0x12/0x20
[    3.893197][    T1]  ? ref_tracker_alloc+0x215/0x700
[    3.893197][    T1]  ? sk_alloc+0x7b4/0x850
[    3.893197][    T1]  ? __netlink_kernel_create+0x1ec/0xe50
[    3.893197][    T1]  ? scsi_netlink_init+0x6f/0x140
[    3.893197][    T1]  ? init_scsi+0x1dc/0x300
[    3.893197][    T1]  ? do_one_initcall+0x216/0x960
[    3.893197][    T1]  ? do_initcall_level+0x140/0x350
[    3.893197][    T1]  ? do_initcalls+0xf0/0x1d0
[    3.893197][    T1]  ? do_basic_setup+0x22/0x30
[    3.893197][    T1]  ? kernel_init_freeable+0x300/0x4b0
[    3.893197][    T1]  ? kernel_init+0x2f/0x7e0
[    3.893197][    T1]  ? ret_from_fork+0x66/0x80
[    3.893197][    T1]  ? ret_from_fork_asm+0x11/0x20
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? _raw_spin_lock_irqsave+0x35/0xc0
[    3.893197][    T1]  ? filter_irq_stacks+0x60/0x1a0
[    3.893197][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  __msan_warning+0x96/0x110
[    3.893197][    T1]  __list_del_entry_valid_or_report+0x19e/0x490
[    3.893197][    T1]  stack_depot_save_flags+0x3e7/0x7b0
[    3.893197][    T1]  stack_depot_save+0x12/0x20
[    3.893197][    T1]  ref_tracker_alloc+0x215/0x700
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? sk_alloc+0x7b4/0x850
[    3.893197][    T1]  ? __netlink_kernel_create+0x1ec/0xe50
[    3.893197][    T1]  ? scsi_netlink_init+0x6f/0x140
[    3.893197][    T1]  ? init_scsi+0x1dc/0x300
[    3.893197][    T1]  ? do_one_initcall+0x216/0x960
[    3.893197][    T1]  ? do_initcall_level+0x140/0x350
[    3.893197][    T1]  ? do_initcalls+0xf0/0x1d0
[    3.893197][    T1]  ? do_basic_setup+0x22/0x30
[    3.893197][    T1]  ? kernel_init_freeable+0x300/0x4b0
[    3.893197][    T1]  ? kernel_init+0x2f/0x7e0
[    3.893197][    T1]  ? ret_from_fork+0x66/0x80
[    3.893197][    T1]  ? ret_from_fork_asm+0x11/0x20
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  sk_alloc+0x7b4/0x850
[    3.893197][    T1]  __netlink_kernel_create+0x1ec/0xe50
[    3.893197][    T1]  ? kmsan_internal_memmove_metadata+0x91/0x220
[    3.893197][    T1]  scsi_netlink_init+0x6f/0x140
[    3.893197][    T1]  ? scsi_netlink_init+0x140/0x140
[    3.893197][    T1]  init_scsi+0x1dc/0x300
[    3.893197][    T1]  ? udmabuf_dev_init+0x2a0/0x2a0
[    3.893197][    T1]  do_one_initcall+0x216/0x960
[    3.893197][    T1]  ? udmabuf_dev_init+0x2a0/0x2a0
[    3.893197][    T1]  ? kmsan_get_metadata+0x80/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? filter_irq_stacks+0x164/0x1a0
[    3.893197][    T1]  ? stack_depot_save_flags+0x2c/0x7b0
[    3.893197][    T1]  ? skip_spaces+0x8f/0xc0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? parse_args+0x1511/0x15e0
[    3.893197][    T1]  ? kmsan_get_metadata+0x146/0x1c0
[    3.893197][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xa0
[    3.893197][    T1]  ? udmabuf_dev_init+0x2a0/0x2a0
[    3.893197][    T1]  do_initcall_level+0x140/0x350
[    3.893197][    T1]  do_initcalls+0xf0/0x1d0
[    3.893197][    T1]  ? arch_cpuhp_init_parallel_bringup+0xe0/0xe0
[    3.893197][    T1]  do_basic_setup+0x22/0x30
[    3.893197][    T1]  kernel_init_freeable+0x300/0x4b0
[    3.893197][    T1]  ? rest_init+0x260/0x260
[    3.893197][    T1]  kernel_init+0x2f/0x7e0
[    3.893197][    T1]  ? rest_init+0x260/0x260
[    3.893197][    T1]  ret_from_fork+0x66/0x80
[    3.893197][    T1]  ? rest_init+0x260/0x260
[    3.893197][    T1]  ret_from_fork_asm+0x11/0x20
[    3.893197][    T1]  </TASK>


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
 -ffile-prefix-map=3D/tmp/go-build3486373933=3D/tmp/go-build -gno-record-gc=
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
https://syzkaller.appspot.com/x/error.txt?x=3D147e9a30180000


Tested on:

commit:         ab0a97cf Merge tag 'powerpc-6.8-4' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd33318d4e4a0d22=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3841ed075=
a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D126caac41800=
00


