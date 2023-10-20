Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC57D06DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbjJTDaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346873AbjJTDau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:30:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF83D45
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:30:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EABC433C7;
        Fri, 20 Oct 2023 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697772646;
        bh=nAW7yaGAw2+GSFmNQxMjQNNwSPjbQcDUROdu+UxCPI8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R1MtiCwimV46A8P19T5UnQiKOKFlSN7PpPx5a5A+S4IoeFzg9gw0XCxoSwraMjXPd
         7ZDLypyNr8th4qACzWKkYPeEHAdIEhWSF6H0RLV7dh1pvjtleo7sbSiSSr0x/jFGcZ
         FBeHule/wkDZVmGZvb5yTNB1LhYvM/4OhyluBq5j1JITgsWAsJhoBr5rM7rRGHE7tF
         G94Ow708ZgBbAzMnu10B7CzxhsemuuZvULKik4z8b5z4+jmWW++MpDwUdR9bKzQMgJ
         W0sygzLotJ8rPeodAhuTJg2aVVase9ZAMDQWFQDlkNi/DZVI/TuVCGvRASDm5cMbbx
         DOil20ptcqsPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44AF5CE0DE9; Thu, 19 Oct 2023 20:30:46 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:30:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org, frederic@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <83c9317a-b1d2-4741-b955-98e7cd23595c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:26:17PM +0900, Tetsuo Handa wrote:
> On 2023/10/19 21:14, Thomas Gleixner wrote:
> > Maybe because of this:
> >>>> (This environment is Oracle VM VirtualBox on Windows 11 host.)
> 
> I don't think that I'm the only user running Linux on Oracle VM VirtualBox on Windows. ;-)
> 
> > So you could boot with "nosmp clocksource=acpi_pm" on the command line
> > and compare that against a "nosmp" boot.
> 
> This did not make much difference.
> 
> Just for testing, I booted several Fedora/Ubuntu kernels used by installation ISO image.
> 5.11 / 6.0 / 6.6 Fedora kernels all showed this problem. On the other hand, 5.15 Ubuntu
> kernel does not show this problem. Thus, I'd rather suspect kernel config dependent
> problem than platform dependent problem.
> 
> Fedora-Everything-netinst-x86_64-Rawhide-20231018.n.0.iso
> [    0.000000] Linux version 6.6.0-0.rc6.47.fc40.x86_64 (mockbuild@65b4f242683a45f6bd4621fe8c018a9d) (gcc (GCC) 13.2.1 20231011 (Red Hat 13.2.1-4), GNU ld version 2.41-7.fc40) #1 SMP PREEMPT_DYNAMIC Mon Oct 16 13:34:35 UTC 2023
> 
> Fedora-Server-netinst-x86_64-37-1.7.iso
> [    0.000000] Linux version 6.0.7-301.fc37.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 12.2.1 20220819 (Red Hat 12.2.1-2), GNU ld version 2.38-24.fc37) #1 SMP PREEMPT_DYNAMIC Fri Nov 4 18:35:48 UTC 2022
> 
> Fedora-Everything-netinst-x86_64-34-1.2.iso
> [    0.000000] Linux version 5.11.12-300.fc34.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.0.1 20210324 (Red Hat 11.0.1-0), GNU ld version 2.35.1-41.fc34) #1 SMP Wed Apr 7 16:31:13 UTC 2021
> 
> ubuntu-22.04.3-live-server-amd64.iso
> [    0.000000] Linux version 5.15.0-78-generic (buildd@lcy02-amd64-008) (gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #85-Ubuntu SMP Fri Jul 7 15:25:09 UTC 2023 (Ubuntu 5.15.0-78.85-generic 5.15.99)
> [    0.000000] Command line: BOOT_IMAGE=/casper/vmlinuz console=ttyS0,115200n8 console=tty0 ---

A bit of a long shot, but given your earlier console log, could you
please try Frederic's patches?

https://lore.kernel.org/lkml/20231019233543.1243121-1-frederic@kernel.org/

							Thanx, Paul

> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] x86/fpu: x87 FPU will use FXSAVE
> [    0.000000] signal: max sigframe size: 1440
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dffeffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dfff0000-0x00000000dfffffff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000019fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.5 present.
> [    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000000] kvm-clock: cpu 0, msr 18e01001, primary cpu clock
> [    0.000001] kvm-clock: using sched offset of 33909880646 cycles
> [    0.000004] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000006] tsc: Detected 2611.208 MHz processor
> [    0.001408] last_pfn = 0x1a0000 max_arch_pfn = 0x400000000
> [    0.001457] Disabled
> [    0.001458] x86/PAT: MTRRs disabled, skipping PAT initialization too.
> [    0.001463] CPU MTRRs all blank - virtualized system.
> [    0.001464] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
> [    0.001466] last_pfn = 0xdfff0 max_arch_pfn = 0x400000000
> [    0.001514] found SMP MP-table at [mem 0x0009fff0-0x0009ffff]
> [    0.001529] Incomplete global flushes, disabling PCID
> [    0.001751] RAMDISK: [mem 0x2a8db000-0x31464fff]
> [    0.001756] ACPI: Early table checksum verification disabled
> [    0.001760] ACPI: RSDP 0x00000000000E0000 000024 (v02 VBOX  )
> [    0.001764] ACPI: XSDT 0x00000000DFFF0030 00003C (v01 VBOX   VBOXXSDT 00000001 ASL  00000061)
> [    0.001769] ACPI: FACP 0x00000000DFFF00F0 0000F4 (v04 VBOX   VBOXFACP 00000001 ASL  00000061)
> [    0.001774] ACPI: DSDT 0x00000000DFFF0640 002353 (v02 VBOX   VBOXBIOS 00000002 INTL 20100528)
> [    0.001777] ACPI: FACS 0x00000000DFFF0200 000040
> [    0.001780] ACPI: FACS 0x00000000DFFF0200 000040
> [    0.001782] ACPI: APIC 0x00000000DFFF0240 00008C (v02 VBOX   VBOXAPIC 00000001 ASL  00000061)
> [    0.001785] ACPI: SSDT 0x00000000DFFF02D0 00036C (v01 VBOX   VBOXCPUT 00000002 INTL 20100528)
> [    0.001787] ACPI: Reserving FACP table memory at [mem 0xdfff00f0-0xdfff01e3]
> [    0.001789] ACPI: Reserving DSDT table memory at [mem 0xdfff0640-0xdfff2992]
> [    0.001789] ACPI: Reserving FACS table memory at [mem 0xdfff0200-0xdfff023f]
> [    0.001790] ACPI: Reserving FACS table memory at [mem 0xdfff0200-0xdfff023f]
> [    0.001791] ACPI: Reserving APIC table memory at [mem 0xdfff0240-0xdfff02cb]
> [    0.001792] ACPI: Reserving SSDT table memory at [mem 0xdfff02d0-0xdfff063b]
> [    0.002486] No NUMA configuration found
> [    0.002487] Faking a node at [mem 0x0000000000000000-0x000000019fffffff]
> [    0.002493] NODE_DATA(0) allocated [mem 0x19ffd2000-0x19fffbfff]
> [    0.003086] Zone ranges:
> [    0.003087]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.003089]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.003090]   Normal   [mem 0x0000000100000000-0x000000019fffffff]
> [    0.003091]   Device   empty
> [    0.003092] Movable zone start for each node
> [    0.003094] Early memory node ranges
> [    0.003094]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.003095]   node   0: [mem 0x0000000000100000-0x00000000dffeffff]
> [    0.003097]   node   0: [mem 0x0000000100000000-0x000000019fffffff]
> [    0.003098] Initmem setup node 0 [mem 0x0000000000001000-0x000000019fffffff]
> [    0.003128] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.003600] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.181055] On node 0, zone Normal: 16 pages in unavailable ranges
> [    0.182110] ACPI: PM-Timer IO Port: 0x4008
> [    0.182310] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.182313] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.182315] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.182318] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.182338] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.182433] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.182435] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.182435] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
> [    0.182436] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
> [    0.182437] PM: hibernation: Registered nosave memory: [mem 0xdfff0000-0xdfffffff]
> [    0.182438] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xfebfffff]
> [    0.182438] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.182439] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> [    0.182440] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.182440] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfffbffff]
> [    0.182441] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
> [    0.182442] [mem 0xe0000000-0xfebfffff] available for PCI devices
> [    0.182444] Booting paravirtualized kernel on KVM
> [    0.182446] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.182461] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> [    0.186444] percpu: Embedded 60 pages/cpu s208896 r8192 d28672 u262144
> [    0.186530] kvm-guest: PV spinlocks enabled
> [    0.186532] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
> [    0.186554] Built 1 zonelists, mobility grouping on.  Total pages: 1548016
> [    0.186555] Policy zone: Normal
> [    0.186556] Kernel command line: BOOT_IMAGE=/casper/vmlinuz console=ttyS0,115200n8 console=tty0 ---
> [    0.186591] Unknown kernel command line parameters "--- BOOT_IMAGE=/casper/vmlinuz", will be passed to user space.
> [    0.201567] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.208917] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.209043] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.284849] Memory: 5943520K/6291000K available (16393K kernel code, 4383K rwdata, 10844K rodata, 3248K init, 18832K bss, 347220K reserved, 0K cma-reserved)
> [    0.286016] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.286060] ftrace: allocating 50600 entries in 198 pages
> [    0.304937] ftrace: allocated 198 pages with 4 groups
> [    0.305656] rcu: Hierarchical RCU implementation.
> [    0.305658] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
> [    0.305659] 	Rude variant of Tasks RCU enabled.
> [    0.305660] 	Tracing variant of Tasks RCU enabled.
> [    0.305660] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.305661] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.309135] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
> [    0.309742] random: crng init done
> [    0.338006] Console: colour VGA+ 80x25
> [    0.508207] printk: console [tty0] enabled
> [    0.683408] printk: console [ttyS0] enabled
> [    0.685593] ACPI: Core revision 20210730
> [    0.687749] APIC: Switch to symmetric I/O mode setup
> [    0.700751] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.703694] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25a39815946, max_idle_ns: 440795282683 ns
> [    0.708547] Calibrating delay loop (skipped) preset value.. 5222.41 BogoMIPS (lpj=10444832)
> [    0.712492] pid_max: default: 32768 minimum: 301
> [    0.712542] LSM: Security Framework initializing
> [    0.712542] landlock: Up and running.
> [    0.712542] Yama: becoming mindful.
> [    0.712542] AppArmor: AppArmor initialized
> [    0.712542] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.712542] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.716559] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.719146] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.720548] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.724545] Spectre V2 : Mitigation: Enhanced IBRS
> [    0.726808] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.728544] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
> [    0.732544] RETBleed: Mitigation: Enhanced IBRS
> [    0.736546] Speculative Store Bypass: Vulnerable
> [    0.761213] Freeing SMP alternatives memory: 44K
> [    0.888543] APIC calibration not consistent with PM-Timer: 112ms instead of 100ms
> [    0.892542] APIC delta adjusted to PM-Timer: 6460077 (7235567)
> [    0.892738] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: 0x6, model: 0x9a, stepping: 0x4)
> [    0.897089] Performance Events: unsupported p6 CPU model 154 no PMU driver, software events only.
> [    0.900604] rcu: Hierarchical SRCU implementation.
> [    0.903574] NMI watchdog: Perf NMI watchdog permanently disabled
> [    0.904961] smp: Bringing up secondary CPUs ...
> [    0.909089] x86: Booting SMP configuration:
> [    0.911031] .... node  #0, CPUs:      #1
> [    0.402809] kvm-clock: cpu 1, msr 18e01041, secondary cpu clock
> [    0.916542] TSC synchronization [CPU#0 -> CPU#1]:
> [    0.916542] Measured 57359 cycles TSC warp between CPUs, turning off TSC clock.
> [    0.916542] tsc: Marking TSC unstable due to check_tsc_sync_source failed
> [    0.916968]  #2
> [    0.402809] kvm-clock: cpu 2, msr 18e01081, secondary cpu clock
> [    0.920985]  #3
> [    0.402809] kvm-clock: cpu 3, msr 18e010c1, secondary cpu clock
> [    0.926782]  #4
> [    0.402809] kvm-clock: cpu 4, msr 18e01101, secondary cpu clock
> [    0.935490]  #5
> [    0.402809] kvm-clock: cpu 5, msr 18e01141, secondary cpu clock
> [    0.939186]  #6
> [    0.402809] kvm-clock: cpu 6, msr 18e01181, secondary cpu clock
> [    0.948125]  #7
> [    0.402809] kvm-clock: cpu 7, msr 18e011c1, secondary cpu clock
> [    0.960542] smp: Brought up 1 node, 8 CPUs
> [    0.962451] smpboot: Max logical packages: 1
> [    0.964401] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
> 
