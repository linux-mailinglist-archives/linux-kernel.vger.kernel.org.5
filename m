Return-Path: <linux-kernel+bounces-39492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA22083D20B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D752B2417F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C602399;
	Fri, 26 Jan 2024 01:26:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90068539E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232367; cv=none; b=VgGtkuC56LS1oOHKt4rdi39le83EYA98sUwfrospxiX8su/oSgv5s5xjPrFSGltfV4jwGDMVWSNRSZLmoEliZUU63UKnEzAy2a6wW+REFqmKo5Z64KEvDc1GBzxpFwIyQwwm+XQQxfJtfq6Kotlazt0+OhKAzQuwnW6J8g52U4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232367; c=relaxed/simple;
	bh=oxmf0CHc84QQFbkGka6Pnj+NdxEZriFWhhzjbtZXDQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qWME0tw4VA8k7CEYi01KnXVqAgoSjw8b7679xw23l6bmY0kO7IcmvKVVdtl/wA7IJn1dZK5C+xFuDeY84VTJSqC8H7u1/CGk+NyjXkEcEJEUPuy0TLJtt3qMTzjHX5DgmvAP9rRe2qC3R79K3Bu+46Tq1KWKDwM5jaO4/iFnY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3627690706fso1347225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232364; x=1706837164;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCF7vns4Gg/jXcIqRprDE48iIOhOIvTfw2kNh8kM/do=;
        b=i8A6E6LsRXXCdifTSOmJMnWD+4w5j+Jxh5Ckk4FFUtlAesg31oAHjeeruHIWlHMnVU
         DeNs4ULwtU2rVipIjsOAqiFoaW5rYK2rdW6qTIvrVKWleJpmoI9LFc7akOLrBvK0yyAz
         lZtBmEQ1OMe81iZhsJNoiLjswj8pXysCl9M0t9SFJ9ZoCbxJaJdmlK3F7/BlfT2Ce9Nv
         kZPMAznZVhSeJB1rYZ9ePRIi79HE6ZlkEPLSEb+JG9H3Ezcokt5gLgf96yk8/v6imnjA
         6HikxQpBcTQ4t0vYTCIrbJeRRVSbTnTXd6UgzBY/oATwRbggIvNPo1NawTZdEvyVM/gQ
         krMA==
X-Gm-Message-State: AOJu0YwSqebK2lwiTwtv91pT3ywDIqtjv3Ub3od3b2Zt43WYoQ/d5DJy
	Iu4DhjCRMrJ9AtaVxfPn7BQ+kwOkGnjBRv+bL9scPbLrZjSm83sMjHmX5N9NKehfir21kdTo1uN
	cuz6o0bi1mYf5rGdhopYJbheg8zCxR564qsNphEMa/+m6uiogd2yltvQ=
X-Google-Smtp-Source: AGHT+IFpEJHVUniTaWWjJQ+Lu4xmgszEWX5LGuTCld+EpsFVrNCde5AWyctjw/LuxOBljRJc3zhcWUZdCoJCudWdMTjOmvl/RiRI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:360:17a7:d897 with SMTP id
 i2-20020a056e021d0200b0036017a7d897mr68606ila.4.1706232364570; Thu, 25 Jan
 2024 17:26:04 -0800 (PST)
Date: Thu, 25 Jan 2024 17:26:04 -0800
In-Reply-To: <tencent_295DB5DDAC196ACFF38DA625A98DFB926107@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fea272060fcf2d10@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

rose_ndevs=3D16 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workque=
ue.watchdog_thresh=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D1=
40 dummy_hcd.num=3D8 kmsan.panic=3D1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev=
/sda1 console=3DttyS0
[    0.436786][    T0] Unknown kernel command line parameters "page_owner=
=3Don spec_store_bypass_disable=3Dprctl watchdog_thresh=3D55 BOOT_IMAGE=3D/=
boot/bzImage", will be passed to user space.
[    0.439567][    T0] random: crng init done
[    0.440342][    T0] Fallback order for Node 0: 0 1=20
[    0.440387][    T0] Fallback order for Node 1: 1 0=20
[    0.440402][    T0] Built 2 zonelists, mobility grouping on.  Total page=
s: 2055933
[    0.443831][    T0] Policy zone: Normal
[    0.444788][    T0] mem auto-init: stack:off, heap alloc:off, heap free:=
off
[    0.709507][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash
[    0.710697][    T0] stackdepot hash table entries: 524288 (order: 11, 83=
88608 bytes, linear)
[    0.714527][    T0] software IO TLB: area num 2.
[    0.805862][    T0] Memory: 2335784K/8388204K available (227328K kernel =
code, 9515K rwdata, 14976K rodata, 4256K init, 2096K bss, 1372684K reserved=
, 0K cma-reserved)
[    0.810734][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D2
[    0.811929][    T0] Starting KernelMemorySanitizer
[    0.812611][    T0] ATTENTION: KMSAN is a debugging tool! Do not use it =
on production machines!
SeaBIOS (version 1.8.2-google)
Total RAM Size =3D 0x0000000200000000 =3D 8192 MiB
CPUs found: 2     Max CPUs supported: 2
SeaBIOS (version 1.8.2-google)
Machine UUID ee6e2ee3-62a1-1e1b-9da6-871c6e7e270f
found virtio-scsi at 0:3
virtio-scsi vendor=3D'Google' product=3D'PersistentDisk' rev=3D'1' type=3D0=
 removable=3D0
virtio-scsi blksize=3D512 sectors=3D4194304 =3D 2048 MiB
drive 0x000f2870: PCHS=3D0/0/0 translation=3Dlba LCHS=3D520/128/63 s=3D4194=
304
Sending Seabios boot VM event.
Booting from Hard Disk 0...
[    0.000000][    T0] Linux version 6.8.0-rc1-syzkaller-gecb1b8288dc7-dirt=
y (syzkaller@syzkaller) (Debian clang version 15.0.6, GNU ld (GNU Binutils =
for Debian) 2.40) #0 SMP PREEMPT_DYNAMIC now
[    0.000000][    T0] Command line: BOOT_IMAGE=3D/boot/bzImage root=3D/dev=
/sda1 console=3DttyS0
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbf=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009fff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000ffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000bfffcff=
f] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000bfffd000-0x00000000bffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffbc000-0x00000000fffffff=
f] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000023ffffff=
f] usable
[    0.000000][    T0] printk: legacy bootconsole [earlyser0] enabled
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ERROR: earlyprintk=3D earlyser already used
[    0.000000][    T0] ****************************************************=
******
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] ** This system shows unhashed kernel memory addresse=
s   **
[    0.000000][    T0] ** via the console, logs, and other interfaces. This=
    **
[    0.000000][    T0] ** might reduce the security of your system.        =
    **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] ** If you see this message and you are not debugging=
    **
[    0.000000][    T0] ** the kernel, report this immediately to your syste=
m   **
[    0.000000][    T0] ** administrator!                                   =
    **
[    0.000000][    T0] **                                                  =
    **
[    0.000000][    T0] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTIC=
E   **
[    0.000000][    T0] ****************************************************=
******
[    0.000000][    T0] Malformed early option 'vsyscall'
[    0.000000][    T0] nopcid: PCID feature disabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.4 present.
[    0.000000][    T0] DMI: Google Google Compute Engine/Google Compute Eng=
ine, BIOS Google 11/17/2023
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000003][    T0] kvm-clock: using sched offset of 5361175763 cycles
[    0.000979][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max=
_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.004869][    T0] tsc: Detected 2200.152 MHz processor
[    0.013186][    T0] last_pfn =3D 0x240000 max_arch_pfn =3D 0x400000000
[    0.014422][    T0] MTRR map: 4 entries (3 fixed + 1 variable; max 19), =
built from 8 variable MTRRs
[    0.016036][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP=
  UC- WT =20
[    0.017511][    T0] last_pfn =3D 0xbfffd max_arch_pfn =3D 0x400000000
[    0.025734][    T0] found SMP MP-table at [mem 0x000f2b30-0x000f2b3f]
[    0.027084][    T0] Using GB pages for direct mapping
[    0.031479][    T0] ACPI: Early table checksum verification disabled
[    0.032936][    T0] ACPI: RSDP 0x00000000000F28B0 000014 (v00 Google)
[    0.034280][    T0] ACPI: RSDT 0x00000000BFFFFFA0 000038 (v01 Google GOO=
GRSDT 00000001 GOOG 00000001)
[    0.036044][    T0] ACPI: FACP 0x00000000BFFFF330 0000F4 (v02 Google GOO=
GFACP 00000001 GOOG 00000001)
[    0.037902][    T0] ACPI: DSDT 0x00000000BFFFD8C0 001A64 (v01 Google GOO=
GDSDT 00000001 GOOG 00000001)
[    0.040136][    T0] ACPI: FACS 0x00000000BFFFD880 000040
[    0.041374][    T0] ACPI: FACS 0x00000000BFFFD880 000040
[    0.042421][    T0] ACPI: SRAT 0x00000000BFFFFE60 0000C8 (v03 Google GOO=
GSRAT 00000001 GOOG 00000001)
[    0.044426][    T0] ACPI: APIC 0x00000000BFFFFDB0 000076 (v05 Google GOO=
GAPIC 00000001 GOOG 00000001)
[    0.046543][    T0] ACPI: SSDT 0x00000000BFFFF430 000980 (v01 Google GOO=
GSSDT 00000001 GOOG 00000001)
[    0.048530][    T0] ACPI: WAET 0x00000000BFFFFE30 000028 (v01 Google GOO=
GWAET 00000001 GOOG 00000001)
[    0.050596][    T0] ACPI: Reserving FACP table memory at [mem 0xbffff330=
-0xbffff423]
[    0.051916][    T0] ACPI: Reserving DSDT table memory at [mem 0xbfffd8c0=
-0xbffff323]
[    0.053117][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.054371][    T0] ACPI: Reserving FACS table memory at [mem 0xbfffd880=
-0xbfffd8bf]
[    0.055840][    T0] ACPI: Reserving SRAT table memory at [mem 0xbffffe60=
-0xbfffff27]
[    0.058109][    T0] ACPI: Reserving APIC table memory at [mem 0xbffffdb0=
-0xbffffe25]
[    0.059864][    T0] ACPI: Reserving SSDT table memory at [mem 0xbffff430=
-0xbffffdaf]
[    0.061666][    T0] ACPI: Reserving WAET table memory at [mem 0xbffffe30=
-0xbffffe57]
[    0.063198][    T0] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.064065][    T0] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.064984][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.066942][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.068354][    T0] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x23ffffff=
f]
[    0.069621][    T0] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00=
100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.071997][    T0] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x10=
0000000-0x23fffffff] -> [mem 0x00000000-0x23fffffff]
[    0.075579][    T0] Faking node 0 at [mem 0x0000000000000000-0x000000013=
fffffff] (5120MB)
[    0.077333][    T0] Faking node 1 at [mem 0x0000000140000000-0x000000023=
fffffff] (4096MB)
[    0.079984][    T0] NODE_DATA(0) allocated [mem 0x13fffa000-0x13fffffff]
[    0.082677][    T0] NODE_DATA(1) allocated [mem 0x23fff7000-0x23fffcfff]
[    0.104743][    T0] Zone ranges:
[    0.105603][    T0]   DMA      [mem 0x0000000000001000-0x0000000000fffff=
f]
[    0.107187][    T0]   DMA32    [mem 0x0000000001000000-0x00000000fffffff=
f]
[    0.109218][    T0]   Normal   [mem 0x0000000100000000-0x000000023ffffff=
f]
[    0.110726][    T0]   Device   empty
[    0.111630][    T0] Movable zone start for each node
[    0.113093][    T0] Early memory node ranges
[    0.113926][    T0]   node   0: [mem 0x0000000000001000-0x000000000009ef=
ff]
[    0.115166][    T0]   node   0: [mem 0x0000000000100000-0x00000000bfffcf=
ff]
[    0.116887][    T0]   node   0: [mem 0x0000000100000000-0x000000013fffff=
ff]
[    0.117924][    T0]   node   1: [mem 0x0000000140000000-0x000000023fffff=
ff]
[    0.119129][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x00000=
0013fffffff]
[    0.120252][    T0] Initmem setup node 1 [mem 0x0000000140000000-0x00000=
0023fffffff]
[    0.122345][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.123755][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.244127][    T0] On node 0, zone Normal: 3 pages in unavailable range=
s
[    0.365187][    T0] ACPI: PM-Timer IO Port: 0xb008
[    0.366213][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.367294][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000=
, GSI 0-23
[    0.369026][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high=
 level)
[    0.370283][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high=
 level)
[    0.371435][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 hi=
gh level)
[    0.372688][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 hi=
gh level)
[    0.373776][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation
[    0.374745][    T0] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.375648][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
000000-0x00000fff]
[    0.378087][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
09f000-0x0009ffff]
[    0.379781][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0a0000-0x000effff]
[    0.381429][    T0] PM: hibernation: Registered nosave memory: [mem 0x00=
0f0000-0x000fffff]
[    0.383062][    T0] PM: hibernation: Registered nosave memory: [mem 0xbf=
ffd000-0xbfffffff]
[    0.384796][    T0] PM: hibernation: Registered nosave memory: [mem 0xc0=
000000-0xfffbbfff]
[    0.386969][    T0] PM: hibernation: Registered nosave memory: [mem 0xff=
fbc000-0xffffffff]
[    0.389189][    T0] [mem 0xc0000000-0xfffbbfff] available for PCI device=
s
[    0.390657][    T0] Booting paravirtualized kernel on KVM
[    0.392046][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.395073][    T0] setup_percpu: NR_CPUS:8 nr_cpumask_bits:2 nr_cpu_ids=
:2 nr_node_ids:2
[    0.398586][    T0] percpu: Embedded 176 pages/cpu s683016 r8192 d29688 =
u1048576
[    0.400406][    T0] Kernel command line: earlyprintk=3Dserial net.ifname=
s=3D0 sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-con=
ntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.p=
orts=3D20000 nf-conntrack-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000=
 binder.debug_mask=3D0 rcupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cp=
utime=3D1 no_hash_pointers page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysct=
l.vm.nr_overcommit_hugepages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_=
to_panic=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff root=3D/dev/sd=
a console=3DttyS0 vsyscall=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 sp=
ec_store_bypass_disable=3Dprctl nopcid vivid.n_devs=3D16 vivid.multiplanar=
=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D16 rose.rose_ndevs=3D1=
6 smp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thr=
esh=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.nu=
m=3D8 kmsan.panic=3D1 BOOT_IMAGE=3D/boot/bzImage root=3D/dev/sda1 console=
=3DttyS0
[    0.424272][    T0] Unknown kernel command line parameters "page_owner=
=3Don spec_store_bypass_disable=3Dprctl watchdog_thresh=3D55 BOOT_IMAGE=3D/=
boot/bzImage", will be passed to user space.
[    0.428208][    T0] random: crng init done
[    0.429106][    T0] Fallback order for Node 0: 0 1=20
[    0.429151][    T0] Fallback order for Node 1: 1 0=20
[    0.429165][    T0] Built 2 zonelists, mobility grouping on.  Total page=
s: 2055933
[    0.432106][    T0] Policy zone: Normal
[    0.432815][    T0] mem auto-init: stack:off, heap alloc:off, heap free:=
off
[    0.697820][    T0] stackdepot: allocating hash table via alloc_large_sy=
stem_hash
[    0.699706][    T0] stackdepot hash table entries: 524288 (order: 11, 83=
88608 bytes, linear)
[    0.703815][    T0] software IO TLB: area num 2.
[    0.793637][    T0] Memory: 2335784K/8388204K available (227328K kernel =
code, 9515K rwdata, 14976K rodata, 4256K init, 2096K bss, 1372684K reserved=
, 0K cma-reserved)
[    0.798348][    T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D2
[    0.799788][    T0] Starting KernelMemorySanitizer
[    0.800749][    T0] ATTENTION: KMSAN is a debugging tool! Do not use it =
on production machines!


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
 -ffile-prefix-map=3D/tmp/go-build948879897=3D/tmp/go-build -gno-record-gcc=
-switches'

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
https://syzkaller.appspot.com/x/error.txt?x=3D1565fca7e80000


Tested on:

commit:         ecb1b828 Merge tag 'net-6.8-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2a91fdc4fbf06a6=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7521c1e3841ed075=
a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1098fe5fe800=
00


