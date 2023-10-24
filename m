Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F047D5467
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjJXOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjJXOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:52:35 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32210DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:52:24 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39OEqLNV074658;
        Tue, 24 Oct 2023 23:52:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 24 Oct 2023 23:52:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39OEqLD9074654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Oct 2023 23:52:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a1f1ec27-169a-4853-84d0-7d67d62a7741@I-love.SAKURA.ne.jp>
Date:   Tue, 24 Oct 2023 23:52:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
 <871qdkch0g.ffs@tglx>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <871qdkch0g.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/24 22:00, Thomas Gleixner wrote:
> Interesting. Can you please tell what the replacement clocksource is
> when the TSC is disabled?

Where can I find the replacement clocksource from?

This slowdown is timing dependent. The same kernel can sometimes boot without slowdown.
I put a small kernel config at https://I-love.SAKURA.ne.jp/tmp/config-6.6-rc7 .

---------- bad case ----------
[    0.000000][    T0] Linux version 6.6.0-rc7+ (root@ubuntu) (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1055 SMP PREEMPT_DYNAMIC Tue Oct 24 14:20:03 UTC 2023
[    0.000000][    T0] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ root=UUID=a2500e32-bbc8-4f32-bf86-94a6ae160b4b ro lsm=bpf console=ttyS0,115200n8 console=tty0
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai  
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000dffeffff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000dfff0000-0x00000000dfffffff] ACPI data
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000019fffffff] usable
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.5 present.
[    0.000000][    T0] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000][    T0] kvm-clock: using sched offset of 4651200357824 cycles
[    0.000002][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000004][    T0] tsc: Detected 2611.208 MHz processor
[    0.001251][    T0] last_pfn = 0x1a0000 max_arch_pfn = 0x400000000
[    0.001265][    T0] MTRRs disabled by BIOS
[    0.001267][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001290][    T0] last_pfn = 0xdfff0 max_arch_pfn = 0x400000000
[    0.001329][    T0] found SMP MP-table at [mem 0x0009fff0-0x0009ffff]
[    0.001340][    T0] Incomplete global flushes, disabling PCID
[    0.001500][    T0] RAMDISK: [mem 0x35563000-0x36aa8fff]
[    0.001509][    T0] No NUMA configuration found
[    0.001510][    T0] Faking a node at [mem 0x0000000000000000-0x000000019fffffff]
[    0.001515][    T0] NODE_DATA(0) allocated [mem 0x19ffda000-0x19fffbfff]
[    0.001676][    T0] Zone ranges:
[    0.001677][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001678][    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001679][    T0]   Normal   [mem 0x0000000100000000-0x000000019fffffff]
[    0.001680][    T0] Movable zone start for each node
[    0.001681][    T0] Early memory node ranges
[    0.001681][    T0]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.001682][    T0]   node   0: [mem 0x0000000000100000-0x00000000dffeffff]
[    0.001683][    T0]   node   0: [mem 0x0000000100000000-0x000000019fffffff]
[    0.001683][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000019fffffff]
[    0.001686][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001738][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.011334][    T0] On node 0, zone Normal: 16 pages in unavailable ranges
[    0.011338][    T0] Intel MultiProcessor Specification v1.4
[    0.011341][    T0] MPTABLE: OEM ID: VBOXCPU 
[    0.011342][    T0] MPTABLE: Product ID: VirtualBox  
[    0.011342][    T0] MPTABLE: APIC at: 0xFEE00000
[    0.011403][    T0] Processor #0 (Bootup-CPU)
[    0.011404][    T0] Processor #1
[    0.011405][    T0] Processor #2
[    0.011405][    T0] Processor #3
[    0.011405][    T0] Processor #4
[    0.011406][    T0] Processor #5
[    0.011406][    T0] Processor #6
[    0.011406][    T0] Processor #7
[    0.011558][    T0] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.011560][    T0] Processors: 8
[    0.011561][    T0] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.011738][    T0] [mem 0xe0000000-0xfebfffff] available for PCI devices
[    0.011739][    T0] Booting paravirtualized kernel on KVM
[    0.011740][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.011744][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.012191][    T0] percpu: Embedded 43 pages/cpu s147032 r0 d29096 u262144
[    0.012323][    T0] kvm-guest: PV spinlocks enabled
[    0.012324][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.012328][    T0] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ root=UUID=a2500e32-bbc8-4f32-bf86-94a6ae160b4b ro lsm=bpf console=ttyS0,115200n8 console=tty0
[    0.012344][    T0] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ lsm=bpf", will be passed to user space.
[    0.012359][    T0] random: crng init done
[    0.012937][    T0] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.013283][    T0] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.013400][    T0] Fallback order for Node 0: 0 
[    0.013403][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 1548016
[    0.013403][    T0] Policy zone: Normal
[    0.013407][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.013409][    T0] software IO TLB: area num 8.
[    0.034155][    T0] Memory: 6067192K/6291000K available (6144K kernel code, 7969K rwdata, 1888K rodata, 2240K init, 4064K bss, 223548K reserved, 0K cma-reserved)
[    0.034284][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.034321][    T0] Dynamic Preempt: full
[    0.034347][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.034348][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.034349][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.034350][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.034398][    T0] NR_IRQS: 4352, nr_irqs: 104, preallocated irqs: 16
[    0.034655][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.062932][    T0] Console: colour VGA+ 80x25
[    0.062937][    T0] printk: console [tty0] enabled
[    0.201799][    T0] printk: console [ttyS0] enabled
[    0.347985][    T0] APIC: Switch to symmetric I/O mode setup
[    0.358057][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.361420][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25a39815946, max_idle_ns: 440795282683 ns
[    0.366555][    T0] Calibrating delay loop (skipped) preset value.. 5222.41 BogoMIPS (lpj=2611208)
[    0.367549][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.368557][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.370554][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.372552][    T0] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.374551][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.376551][    T0] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.378552][    T0] RETBleed: Mitigation: Enhanced IBRS
[    0.380551][    T0] Speculative Store Bypass: Vulnerable
[    0.382553][    T0] x86/fpu: x87 FPU will use FXSAVE
[    0.391441][    T0] Freeing SMP alternatives memory: 16K
[    0.392553][    T0] pid_max: default: 32768 minimum: 301
[    0.394628][    T0] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.396566][    T0] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.601817][    T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: 0x6, model: 0x9a, stepping: 0x4)
[    0.603653][    T1] Performance Events: unsupported p6 CPU model 154 no PMU driver, software events only.
[    0.605559][    T1] signal: max sigframe size: 1440
[    0.607568][    T1] rcu: Hierarchical SRCU implementation.
[    0.609550][    T1] rcu: 	Max phase no-delay instances is 400.
[    0.611622][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.613627][    T1] smp: Bringing up secondary CPUs ...
[    0.616629][    T1] smpboot: x86: Booting SMP configuration:
[    0.619552][    T1] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.624549][    C0] TSC synchronization [CPU#0 -> CPU#1]:
[    0.624549][    C0] Measured 112923 cycles TSC warp between CPUs, turning off TSC clock.
[    0.624549][    T8] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[   11.793585][    T1] smp: Brought up 1 node, 8 CPUs
[   22.463567][    T1] smpboot: Max logical packages: 1
[   26.831718][    T1] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
(...too slow to wait...)
---------- bad case ----------

---------- another bad case (the same kernel, different try) ----------
(...snipped...)
[    0.624575][    T1] smp: Bringing up secondary CPUs ...
[    0.624575][    T1] smpboot: x86: Booting SMP configuration:
[    0.624575][    T1] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.626575][    C0] TSC synchronization [CPU#0 -> CPU#1]:
[    0.626575][    C0] Measured 61974 cycles TSC warp between CPUs, turning off TSC clock.
[    0.626575][    T8] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[   20.677606][    T1] smp: Brought up 1 node, 8 CPUs
[   31.942609][    T1] smpboot: Max logical packages: 1
[   46.890605][    T1] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
(...too slow to wait...)
---------- another bad case ----------

---------- good case (the same kernel, different try)  ----------
[    0.000000][    T0] Linux version 6.6.0-rc7+ (root@ubuntu) (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #1055 SMP PREEMPT_DYNAMIC Tue Oct 24 14:20:03 UTC 2023
[    0.000000][    T0] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ root=UUID=a2500e32-bbc8-4f32-bf86-94a6ae160b4b ro lsm=bpf console=ttyS0,115200n8 console=tty0
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai  
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x00000000dffeffff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x00000000dfff0000-0x00000000dfffffff] ACPI data
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000100000000-0x000000019fffffff] usable
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] APIC: Static calls initialized
[    0.000000][    T0] SMBIOS 2.5 present.
[    0.000000][    T0] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002][    T0] kvm-clock: using sched offset of 189117280516 cycles
[    0.000004][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000006][    T0] tsc: Detected 2611.208 MHz processor
[    0.001341][    T0] last_pfn = 0x1a0000 max_arch_pfn = 0x400000000
[    0.001356][    T0] MTRRs disabled by BIOS
[    0.001358][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001367][    T0] last_pfn = 0xdfff0 max_arch_pfn = 0x400000000
[    0.001409][    T0] found SMP MP-table at [mem 0x0009fff0-0x0009ffff]
[    0.001422][    T0] Incomplete global flushes, disabling PCID
[    0.001559][    T0] RAMDISK: [mem 0x35563000-0x36aa8fff]
[    0.001568][    T0] No NUMA configuration found
[    0.001568][    T0] Faking a node at [mem 0x0000000000000000-0x000000019fffffff]
[    0.001573][    T0] NODE_DATA(0) allocated [mem 0x19ffda000-0x19fffbfff]
[    0.001704][    T0] Zone ranges:
[    0.001704][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001706][    T0]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001707][    T0]   Normal   [mem 0x0000000100000000-0x000000019fffffff]
[    0.001707][    T0] Movable zone start for each node
[    0.001708][    T0] Early memory node ranges
[    0.001709][    T0]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.001709][    T0]   node   0: [mem 0x0000000000100000-0x00000000dffeffff]
[    0.001710][    T0]   node   0: [mem 0x0000000100000000-0x000000019fffffff]
[    0.001711][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000019fffffff]
[    0.001714][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.001738][    T0] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.011645][    T0] On node 0, zone Normal: 16 pages in unavailable ranges
[    0.011651][    T0] Intel MultiProcessor Specification v1.4
[    0.011653][    T0] MPTABLE: OEM ID: VBOXCPU 
[    0.011654][    T0] MPTABLE: Product ID: VirtualBox  
[    0.011654][    T0] MPTABLE: APIC at: 0xFEE00000
[    0.011736][    T0] Processor #0 (Bootup-CPU)
[    0.011737][    T0] Processor #1
[    0.011738][    T0] Processor #2
[    0.011738][    T0] Processor #3
[    0.011738][    T0] Processor #4
[    0.011739][    T0] Processor #5
[    0.011739][    T0] Processor #6
[    0.011739][    T0] Processor #7
[    0.011914][    T0] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.011917][    T0] Processors: 8
[    0.011918][    T0] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.012112][    T0] [mem 0xe0000000-0xfebfffff] available for PCI devices
[    0.012113][    T0] Booting paravirtualized kernel on KVM
[    0.012115][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.012119][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.012381][    T0] percpu: Embedded 43 pages/cpu s147032 r0 d29096 u262144
[    0.012533][    T0] kvm-guest: PV spinlocks enabled
[    0.012534][    T0] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.012539][    T0] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ root=UUID=a2500e32-bbc8-4f32-bf86-94a6ae160b4b ro lsm=bpf console=ttyS0,115200n8 console=tty0
[    0.012557][    T0] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc7+ lsm=bpf", will be passed to user space.
[    0.012574][    T0] random: crng init done
[    0.013371][    T0] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.013777][    T0] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.013889][    T0] Fallback order for Node 0: 0 
[    0.013892][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 1548016
[    0.013893][    T0] Policy zone: Normal
[    0.013896][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.013897][    T0] software IO TLB: area num 8.
[    0.035006][    T0] Memory: 6067192K/6291000K available (6144K kernel code, 7969K rwdata, 1888K rodata, 2240K init, 4064K bss, 223548K reserved, 0K cma-reserved)
[    0.035165][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.035212][    T0] Dynamic Preempt: full
[    0.035244][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.035245][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.035246][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.035247][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.035309][    T0] NR_IRQS: 4352, nr_irqs: 104, preallocated irqs: 16
[    0.035572][    T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.066412][    T0] Console: colour VGA+ 80x25
[    0.066416][    T0] printk: console [tty0] enabled
[    0.206184][    T0] printk: console [ttyS0] enabled
[    0.355879][    T0] APIC: Switch to symmetric I/O mode setup
[    0.365732][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.368881][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25a39815946, max_idle_ns: 440795282683 ns
[    0.373903][    T0] Calibrating delay loop (skipped) preset value.. 5222.41 BogoMIPS (lpj=2611208)
[    0.377974][    T0] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.379900][    T0] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.381903][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.383901][    T0] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.385900][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.387900][    T0] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.389900][    T0] RETBleed: Mitigation: Enhanced IBRS
[    0.391900][    T0] Speculative Store Bypass: Vulnerable
[    0.394902][    T0] x86/fpu: x87 FPU will use FXSAVE
[    0.403537][    T0] Freeing SMP alternatives memory: 16K
[    0.404902][    T0] pid_max: default: 32768 minimum: 301
[    0.406940][    T0] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.409131][    T0] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.617243][    T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: 0x6, model: 0x9a, stepping: 0x4)
[    0.617898][    T1] Performance Events: unsupported p6 CPU model 154 no PMU driver, software events only.
[    0.617898][    T1] signal: max sigframe size: 1440
[    0.617898][    T1] rcu: Hierarchical SRCU implementation.
[    0.617898][    T1] rcu: 	Max phase no-delay instances is 400.
[    0.617898][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.617898][    T1] smp: Bringing up secondary CPUs ...
[    0.617898][    T1] smpboot: x86: Booting SMP configuration:
[    0.617898][    T1] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.620898][    C0] TSC synchronization [CPU#0 -> CPU#1]:
[    0.620898][    C0] Measured 61957 cycles TSC warp between CPUs, turning off TSC clock.
[    0.620898][    T8] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.856914][    T1] smp: Brought up 1 node, 8 CPUs
[    0.910911][    T1] smpboot: Max logical packages: 1
[    1.041908][    T1] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
[    1.051188][    T1] devtmpfs: initialized
[    1.210943][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.234916][    T1] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    1.530084][    T1] cpuidle: using governor ladder
[    1.531920][    T1] cpuidle: using governor menu
[    1.577978][    T1] iommu: Default domain type: Translated
[    1.579900][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.585010][    T1] clocksource: Switched to clocksource kvm-clock
[    1.626044][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.626972][    T1] software IO TLB: mapped [mem 0x00000000dbff0000-0x00000000dfff0000] (64MB)
[    1.626972][    T1] platform rtc_cmos: registered platform RTC device (no PNP device found)
(...snipped...)
---------- good case ----------

