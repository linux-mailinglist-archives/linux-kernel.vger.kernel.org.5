Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2617810FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378825AbjHRQvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378809AbjHRQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566F3C3C;
        Fri, 18 Aug 2023 09:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558A863C5A;
        Fri, 18 Aug 2023 16:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B6C433C8;
        Fri, 18 Aug 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692377470;
        bh=UXwgjTF9vZUq6C1vY+lnIpxz0SvrUM4K5imtrm/t1w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmBh1QLZJdjufL8s/LLAEKkVuvT5yli5X0FMzI/ELHMIEI+pY61xo27iE+HmWafH+
         qQyQi5ekwshgwLW3+ER8V9ovdZLld8mGGxCBNrNJMWLuXzjQi7Gqc1NVL6qO/LvZRx
         0bc8Vim/dWAAVOG5ZYZu7AMcxb2osCJGZHjmw3r6i2JAw7DKxPTzZqJBmfyVKWBDUz
         8QqctG6SXsEupMR8KnWrNrUkBLKEGc32xCZif1CAPwdzfzkwO3lVPxJHhw/mMtDvkW
         Prqnoj01KDNnDMcMs1S9wGXK6ZOyYqzcCpGCf+Afn3RKOHDa8E8Ugn3j+5yOvn/5y/
         ag4w2GVN+9PeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 19:51:06 +0300
Message-Id: <CUVTQR55UKS5.2WB8G160PA1N3@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        <todd.e.brandt@linux.intel.com>, <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <len.brown@intel.com>,
        <charles.d.prestopine@intel.com>, <rafael.j.wysocki@intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
X-Mailer: aerc 0.14.0
References: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
 <CUV5EXGO425W.1RGBLDQJ8GK9W@suppilovahvero>
 <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
In-Reply-To: <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 1:33 AM EEST, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 1:25 AM EEST, Todd Brandt wrote:
> > On Fri, 2023-08-18 at 00:47 +0300, Jarkko Sakkinen wrote:
> > > On Fri Aug 18, 2023 at 12:09 AM EEST, Todd Brandt wrote:
> > > > While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing
> > > > a
> > > > crash and reboot situation when S3 suspend is initiated. To
> > > > reproduce
> > > > it, this call is all that's required "sudo sleepgraph -m mem
> > > > -rtcwake
> > > > 15".
> > >=20
> > > 1. Are there logs available?
> > > 2. Is this the test case: https://pypi.org/project/sleepgraph/ (never
> > > used it before).
> >
> > There are no dmesg logs because the S3 crash wipes them out. Sleepgraph
> > isn't actually necessary to activate it, just an S3 suspend "echo mem >
> > /sys/power/state".
> >
> > So far it appears to only have affected test systems, not production
> > hardware, and none of them have TPM chips, so I'm beginning to wonder
> > if this patch just inadvertently activated a bug somewhere else in the
> > kernel that happens to affect test hardware.
> >
> > I'll continue to debug it, this isn't an emergency as so far I haven't
> > seen it in production hardware.
>
> OK, I'll still see if I could reproduce it just in case.

I created a BR environment for QA:

https://github.com/jarkkojs/buildroot-tpmdd/tree/linux-6.5.y

Building: make qemu_x64_64_config && make

Transcript:

$ output/images/start-qemu.sh --use-system-swtpm --serial-only --rtc
Enable SWTPM
Enable RTC
SeaBIOS (version rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org)


iPXE (http://ipxe.org) 00:03.0 CA00 PCI2.10 PnP PMM+06FD0F20+06F30F20 CA00



Booting from ROM..
Linux version 6.5.0-rc6 (jarkko@suppilovahvero) (x86_64-buildroot-linux-gnu=
-gcc.br_real (Buildroot 2023.08-rc1-94-gc4bbd4b659) 12.3.0, GNU ld (GNU Bin=
utils) 2.40) #2 SMP PREEMPT_DYNAMIC Fri Aug 18 19:35:50 EEST 2023
Command line: rootwait root=3D/dev/vda console=3Dtty1 console=3DttyS0
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x0000000007fccfff] usable
BIOS-e820: [mem 0x0000000007fcd000-0x0000000007ffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a07339=
0-prebuilt.qemu.org 04/01/2014
tsc: Fast TSC calibration using PIT
tsc: Detected 2995.194 MHz processor
last_pfn =3D 0x7fcd max_arch_pfn =3D 0x400000000
MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable M=
TRRs
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
found SMP MP-table at [mem 0x000f5b90-0x000f5b9f]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F59B0 000014 (v00 BOCHS )
ACPI: RSDT 0x0000000007FD1DA8 000038 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: FACP 0x0000000007FD1C10 000074 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: DSDT 0x0000000007FD0040 001BD0 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: FACS 0x0000000007FD0000 000040
ACPI: APIC 0x0000000007FD1C84 000078 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: HPET 0x0000000007FD1CFC 000038 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: TPM2 0x0000000007FD1D34 00004C (v04 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: WAET 0x0000000007FD1D80 000028 (v01 BOCHS  BXPC     00000001 BXPC 000=
00001)
ACPI: Reserving FACP table memory at [mem 0x7fd1c10-0x7fd1c83]
ACPI: Reserving DSDT table memory at [mem 0x7fd0040-0x7fd1c0f]
ACPI: Reserving FACS table memory at [mem 0x7fd0000-0x7fd003f]
ACPI: Reserving APIC table memory at [mem 0x7fd1c84-0x7fd1cfb]
ACPI: Reserving HPET table memory at [mem 0x7fd1cfc-0x7fd1d33]
ACPI: Reserving TPM2 table memory at [mem 0x7fd1d34-0x7fd1d7f]
ACPI: Reserving WAET table memory at [mem 0x7fd1d80-0x7fd1da7]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x0000000007fccfff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x0000000007fccfff]
Initmem setup node 0 [mem 0x0000000000001000-0x0000000007fccfff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
On node 0, zone DMA32: 51 pages in unavailable ranges
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[mem 0x08000000-0xfffbffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_=
idle_ns: 7645519600211568 ns
setup_percpu: NR_CPUS:64 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
percpu: Embedded 44 pages/cpu s140520 r8192 d31512 u2097152
Kernel command line: rootwait root=3D/dev/vda console=3Dtty1 console=3DttyS=
0
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 31949
mem auto-init: stack:all(zero), heap alloc:off, heap free:off
Memory: 104524K/130476K available (10240K kernel code, 943K rwdata, 6612K r=
odata, 1776K init, 1272K bss, 25692K reserved, 0K cma-reserved)
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
Dynamic Preempt: none
rcu: Preemptible hierarchical RCU implementation.
rcu:    RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D1.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D1
NR_IRQS: 4352, nr_irqs: 48, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
Console: colour VGA+ 80x25
printk: console [tty1] enabled
printk: console [ttyS0] enabled
ACPI: Core revision 20230331
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19=
112604467 ns
APIC: Switch to symmetric I/O mode setup
..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2b2c89527d5,=
 max_idle_ns: 440795312054 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. =
5990.38 BogoMIPS (lpj=3D11980776)
process: using AMD E400 aware idle routine
Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer saniti=
zation
Spectre V2 : Mitigation: Retpolines
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context swi=
tch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
x86/fpu: x87 FPU will use FXSAVE
Freeing SMP alternatives memory: 28K
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b,=
 stepping: 0x1)
Performance Events: PMU not available due to virtualization, using software=
 events only.
signal: max sigframe size: 1040
rcu: Hierarchical SRCU implementation.
rcu:    Max phase no-delay instances is 1000.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
smpboot: Max logical packages: 1
smpboot: Total of 1 processors activated (5990.38 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=
 7645041785100000 ns
futex hash table entries: 256 (order: 2, 16384 bytes, linear)
NET: Registered PF_NETLINK/PF_ROUTE protocol family
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor ladder
PCI: Using configuration type 1 for base access
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs" a=
nd report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments HPX-Type3]
acpi PNP0A03:00: PCIe port services disabled; not requesting _OSC control
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended co=
nfiguration space under this bridge
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x08000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:02.0: reg 0x18: [mem 0xfebd0000-0xfebd0fff]
pci 0000:00:02.0: reg 0x30: [mem 0xfebc0000-0xfebcffff pref]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000df=
fff]
pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [io  0xc080-0xc09f]
pci 0000:00:03.0: reg 0x14: [mem 0xfebd1000-0xfebd1fff]
pci 0000:00:03.0: reg 0x20: [mem 0xfe000000-0xfe003fff 64bit pref]
pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc07f]
pci 0000:00:04.0: reg 0x14: [mem 0xfebd2000-0xfebd2fff]
pci 0000:00:04.0: reg 0x20: [mem 0xfe004000-0xfe007fff 64bit pref]
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKS configured for IRQ 9
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: lazy mode
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giome=
tti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem,=
locks=3Dnone
vgaarb: loaded
clocksource: Switched to clocksource tsc-early
pnp: PnP ACPI init
pnp: PnP ACPI: found 6 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 208=
5701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 bytes, lin=
ear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
TCP bind hash table entries: 1024 (order: 3, 32768 bytes, linear)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x08000000-0xfebfffff window]
pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
PCI: CLS 0 bytes, default 64
workingset: timestamp_bits=3D62 max_order=3D15 bucket_order=3D0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
io scheduler mq-deadline registered
io scheduler kyber registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
ACPI: \_SB_.LNKD: Enabled at IRQ 10
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
ACPI: bus type drm_connector registered
bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
[drm] Found bochs VGA, ID 0xb0c5.
[drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebd0000.
[drm] Found EDID data blob.
[drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 0
virtio_blk virtio1: 1/0/0 default/read/poll queues
virtio_blk virtio1: [vda] 122880 512-byte logical blocks (62.9 MB/60.0 MiB)
scsi host0: ata_piix
scsi host1: ata_piix
ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
usbcore: registered new interface driver usb-storage
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
rtc_cmos 00:05: RTC can wake from S4
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input=
/input1
rtc_cmos 00:05: registered as rtc0
rtc_cmos 00:05: setting system clock to 2023-08-18T19:35:58 UTC (1692387358=
)
rtc_cmos 00:05: alarms up to one day, y3k, 242 bytes nvram, hpet irqs
fail to initialize ptp_kvm
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
IPI shorthand broadcast: enabled
sched_clock: Marking stable (654763761, 13648236)->(674898287, -6486290)
ALSA device list:
  No soundcards found.
ata2: found unknown device (class 0)
ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: =
5
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/in=
put/input3
EXT4-fs (vda): mounting ext2 file system using the ext4 subsystem
EXT4-fs (vda): mounted filesystem dbde8608-8ccb-44fe-8e89-a32f7984e7a4 ro w=
ithout journal. Quota mode: disabled.
VFS: Mounted root (ext2 filesystem) readonly on device 254:0.
devtmpfs: mounted
Freeing unused kernel image (initmem) memory: 1776K
Write protecting the kernel read-only data: 18432k
Freeing unused kernel image (rodata/data gap) memory: 1580K
Run /sbin/init as init process
EXT4-fs (vda): re-mounted dbde8608-8ccb-44fe-8e89-a32f7984e7a4 r/w. Quota m=
ode: disabled.
Starting syslogd: OK
Starting klogd: OK
Running sysctl: tsc: Refined TSC clocksource calibration: 2995.170 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b2c72918ff, max_i=
dle_ns: 440795304087 ns
clocksource: Switched to clocksource tsc
OK
Saving 256 bits of non-creditable seed for next boot
Starting network: udhcpc: started, v1.36.1
udhcpc: broadcasting discover
udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
deleting routers
adding dns 10.0.2.3
OK
Starting dropbear sshd: OK
mount: mounting nodev on /sys/kernel/tracing failed: No such file or direct=
ory
mount: mounting nodev on /sys/kernel/security failed: No such file or direc=
tory

Welcome to Buildroot
buildroot login: root
# ls /dev/rtc0 ^C

# ^C

# rtcwake -s 15 -m mem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Aug 18 19:36:29 2023
PM: suspend entry (deep)
Filesystems sync: 0.000 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.001 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.003 seconds)
printk: Suspending console(s) (use no_console_suspend to debug)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10 at kernel/workqueue.c:3382 __flush_work.isra.0+0x2d=
9/0x300
Modules linked in:
CPU: 0 PID: 10 Comm: kworker/u2:0 Not tainted 6.5.0-rc6 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-ge=
a1b7a073390-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:__flush_work.isra.0+0x2d9/0x300
Code: 39 c2 0f 84 e3 fe ff ff 48 8b 46 40 48 85 c0 0f 84 d6 fe ff ff 48 8b =
78 50 e8 63 95 01 00 e9 c8 fe ff ff 0f 0b e9 0d ff ff ff <0f> 0b e9 06 ff f=
f ff 0f 0b e9 a1 fe ff ff 0f 0b e9 74 fe ff ff e8
RSP: 0018:ffffb07c0005bc68 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff9b12c125d330 RCX: 0000000000000000
RDX: ffffb07c0005bc70 RSI: 0000000000000001 RDI: ffffb07c0005bcb8
RBP: ffffb07c0005bce8 R08: 0000000000000000 R09: 0000000000000308
R10: ffff9b12c1144890 R11: ffff9b12c7a21370 R12: ffff9b12c125d330
R13: 0000000000000001 R14: 0000000000000001 R15: ffff9b12c105a005
FS:  0000000000000000(0000) GS:ffff9b12c7a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56fdf201d6 CR3: 0000000001b1e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? show_regs+0x64/0x70
 ? __warn+0x74/0xe0
 ? __flush_work.isra.0+0x2d9/0x300
 ? report_bug+0x147/0x1a0
 ? handle_bug+0x40/0x70
 ? exc_invalid_op+0x1c/0x70
 ? asm_exc_invalid_op+0x1f/0x30
 ? __flush_work.isra.0+0x2d9/0x300
 ? set_next_entity+0x7b/0x80
 __cancel_work_timer+0xfc/0x190
 cancel_delayed_work_sync+0x12/0x20
 drm_kms_helper_poll_disable+0x21/0x40
 drm_mode_config_helper_suspend+0x1a/0x60
 bochs_pm_suspend+0x11/0x20
 pci_pm_suspend+0x80/0x230
 ? __pfx_pci_pm_suspend+0x10/0x10
 __device_suspend+0x112/0x3d0
 async_suspend+0x1e/0xa0
 async_run_entry_fn+0x24/0xb0
 process_one_work+0x1e0/0x370
 worker_thread+0x4f/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xf1/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3c/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
---[ end trace 0000000000000000 ]---
ACPI: PM: Preparing to enter system sleep state S3
ACPI: PM: Saving platform NVS memory
Disabling non-boot CPUs ...
ACPI: PM: Low-level resume complete
ACPI: PM: Restoring platform NVS memory
ACPI: PM: Waking up from system sleep state S3
pci 0000:00:01.0: PIIX3: Enabling Passive Release
virtio_blk virtio1: 1/0/0 default/read/poll queues
OOM killer enabled.
Restarting tasks ... done.
PM: suspend exit
# ata2: found unknown device (class 0)

# dmesg|grep -i tpm
[    0.016261] ACPI: TPM2 0x0000000007FD1D34 00004C (v04 BOCHS  BXPC     00=
000001 BXPC 00000001)
[    0.016351] ACPI: Reserving TPM2 table memory at [mem 0x7fd1d34-0x7fd1d7=
f]
# /usr/lib/kselftests/run_kselftest.sh
kselftest: Running tests in tpm2
TAP version 13
1..3
# timeout set to 600
# selftests: tpm2: test_smoke.sh
random: crng init done
# test_read_partial_overwrite (tpm2_tests.SmokeTest.test_read_partial_overw=
rite) ... ok
# test_read_partial_resp (tpm2_tests.SmokeTest.test_read_partial_resp) ... =
ok
# test_seal_with_auth (tpm2_tests.SmokeTest.test_seal_with_auth) ... ok
# test_seal_with_policy (tpm2_tests.SmokeTest.test_seal_with_policy) ... ok
# test_seal_with_too_long_auth (tpm2_tests.SmokeTest.test_seal_with_too_lon=
g_auth) ... ok
# test_send_two_cmds (tpm2_tests.SmokeTest.test_send_two_cmds) ... ok
# test_too_short_cmd (tpm2_tests.SmokeTest.test_too_short_cmd) ... ok
# test_unseal_with_wrong_auth (tpm2_tests.SmokeTest.test_unseal_with_wrong_=
auth) ... ok
# test_unseal_with_wrong_policy (tpm2_tests.SmokeTest.test_unseal_with_wron=
g_policy) ... ok
#
# ----------------------------------------------------------------------
# Ran 9 tests in 0.488s
#
# OK
ok 1 selftests: tpm2: test_smoke.sh
# timeout set to 600
# selftests: tpm2: test_space.sh
# test_flush_context (tpm2_tests.SpaceTest.test_flush_context) ... ok
# test_get_handles (tpm2_tests.SpaceTest.test_get_handles) ... ok
# test_invalid_cc (tpm2_tests.SpaceTest.test_invalid_cc) ... ok
# test_make_two_spaces (tpm2_tests.SpaceTest.test_make_two_spaces) ... ok
#
# ----------------------------------------------------------------------
# Ran 4 tests in 0.334s
#
# OK
ok 2 selftests: tpm2: test_space.sh
# timeout set to 600
# selftests: tpm2: test_async.sh
# test_async (tpm2_tests.AsyncTest.test_async) ... ok
# test_flush_invalid_context (tpm2_tests.AsyncTest.test_flush_invalid_conte=
xt) ... ok
#
# ----------------------------------------------------------------------
# Ran 2 tests in 0.007s
#
# OK
ok 3 selftests: tpm2: test_async.sh

BR, Jarkko
