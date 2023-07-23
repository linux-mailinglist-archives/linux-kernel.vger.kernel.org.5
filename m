Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A075E1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGWLzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 07:55:19 -0400
Received: from mailgw.gate-on.net (auth.gate-on.net [IPv6:2001:278:1033:4::74:21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F6E51
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 04:55:13 -0700 (PDT)
Received: from vega.pgw.jp (unknown [49.135.109.134])
        by mailgw.gate-on.net (Postfix) with ESMTP id 51A9F80281;
        Sun, 23 Jul 2023 20:55:09 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
        by vega.pgw.jp (Postfix) with SMTP
        id C865DA53D; Sun, 23 Jul 2023 20:55:06 +0900 (JST)
From:   <kkabe@vega.pgw.jp>
To:     rostedt@goodmis.org
Cc:     regressions@lists.linux.dev, bagasdotme@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        kkabe@vega.pgw.jp
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference,address:00000004
In-Reply-To: Your message of "Sat, 22 Jul 2023 11:30:14 +0900".
        <230722113014.M0204460@vega.pgw.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_002_06064_230723.205103"
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date:   Sun, 23 Jul 2023 20:55:06 +0900
Message-ID: <230723205506.M0106064@vega.pgw.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_002_06064_230723.205103
Content-Type: text/plain; charset=US-ASCII

Since the problem with enabling FTRACE_MCOUNT_MAX_OFFSET may be
test_for_valid_rec() returning wrong results, I made a small patch to 
catch the result:

================ patch-test_for_valid_rec-printk.patch
diff -up ./kernel/trace/ftrace.c.ft ./kernel/trace/ftrace.c
--- ./kernel/trace/ftrace.c.ft	2023-07-21 21:51:29.450928552 +0900
+++ ./kernel/trace/ftrace.c	2023-07-23 01:59:59.321558953 +0900
@@ -3678,6 +3678,7 @@ static int test_for_valid_rec(struct dyn
 	/* Weak functions can cause invalid addresses */
 	if (!ret || offset > FTRACE_MCOUNT_MAX_OFFSET) {
 		rec->flags |= FTRACE_FL_DISABLED;
+		printk("%s: disable ftrace for %s offset 0x%lx\n", __func__, str, offset);
 		return 0;
 	}
 	return 1;
================

I will attach the console output (with another panic).
Steve, does this look sane?


Another panic seems to occuring here:
    void drm_vblank_cancel_pending_works(struct drm_vblank_crtc *vblank)
    {
            struct drm_vblank_work *work, *next;

            assert_spin_locked(&vblank->dev->event_lock);   <<<probably here

            list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
                    list_del_init(&work->node);
                    drm_vblank_put(vblank->dev, vblank->pipe);
            }

            wake_up_all(&vblank->work_wait_queue);
    }


So I tried to trap NULL and return:

================ patch-drm_vblank_cancel_pending_works-printk-NULL-ret.patch
diff -up ./drivers/gpu/drm/drm_vblank_work.c.pk2 ./drivers/gpu/drm/drm_vblank_work.c
--- ./drivers/gpu/drm/drm_vblank_work.c.pk2	2023-06-06 20:50:40.000000000 +0900
+++ ./drivers/gpu/drm/drm_vblank_work.c	2023-07-23 14:29:56.383093673 +0900
@@ -71,6 +71,10 @@ void drm_vblank_cancel_pending_works(str
 {
 	struct drm_vblank_work *work, *next;
 
+	if (!vblank->dev) {
+		printk(KERN_WARNING "%s: vblank->dev == NULL? returning\n", __func__);
+		return;
+	}
 	assert_spin_locked(&vblank->dev->event_lock);
 
 	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
================

This time, the printk trap does not happen!! and radeon.ko works.
(NULL check for vblank->worker is still fireing though)

Now this is puzzling.
Is this a timing issue?
Is systemd-udevd doing something not favaorble to kernel?
Is drm vblank code running without enough initialization?

Puzzling is, that purely useland activity
(logging in on tty1 before radeon.ko load)
is affecting kernel panic/no-panic.

-- 
kabe
------=_NextPart_002_06064_230723.205103
Content-Type: text/plain; name=putty-5.18.0-13.4.log

[    0.000000] Linux version 5.18.0-13.4.el9.v1.i586 (kabe@rocky9.five.ten) (gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4), GNU ld version 2.35.2-24.el9.v1) #1 SMP PREEMPT_DYNAMIC Sun Jul 23 11:55:32 JST 2023
[    0.000000] x86/fpu: x87 FPU will use FSAVE
[    0.000000] signal: max sigframe size: 928
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffeffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003fff0000-0x000000003fff7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003fff8000-0x000000003fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffe0000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.0 present.
[    0.000000] DMI: System Manufacturer System Name/ALADDIN5, BIOS 0626 07/15/95
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 120.091 MHz processor
[    0.035691] last_pfn = 0x3fff0 max_arch_pfn = 0x100000
[    0.035797] Disabled
[    0.035867] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.035967] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
[    0.114904] RAMDISK: [mem 0x360a5000-0x3704afff]
[    0.115027] Allocated new RAMDISK: [mem 0x350ff000-0x360a47e0]
[    1.057630] Move RAMDISK from [mem 0x360a5000-0x3704a7e0] to [mem 0x350ff000-0x360a47e0]
[    1.057799] ACPI: Early table checksum verification disabled
[    1.058084] ACPI: RSDP 0x00000000000F6DF0 000014 (v00 AMIINT)
[    1.058297] ACPI: RSDT 0x000000003FFF0000 000028 (v01 ALi_            00000000 MSFT 00000097)
[    1.058576] ACPI: FACP 0x000000003FFF0030 000074 (v01 ALi_            00000000 MSFT 00000097)
[    1.058886] ACPI: DSDT 0x000000003FFF00B0 001FAA (v01 MSI    MSI-5169 00001000 MSFT 0100000A)
[    1.059139] ACPI: FACS 0x000000003FFF8000 000040
[    1.059335] ACPI: Reserving FACP table memory at [mem 0x3fff0030-0x3fff00a3]
[    1.059451] ACPI: Reserving DSDT table memory at [mem 0x3fff00b0-0x3fff2059]
[    1.059560] ACPI: Reserving FACS table memory at [mem 0x3fff8000-0x3fff803f]
[    1.059874] 143MB HIGHMEM available.
[    1.059961] 879MB LOWMEM available.
[    1.060039]   mapped low ram: 0 - 36ffe000
[    1.060119]   low ram: 0 - 36ffe000
[    1.060256] crashkernel: memory value expected
[    1.060555] Zone ranges:
[    1.060629]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    1.060764]   Normal   [mem 0x0000000001000000-0x0000000036ffdfff]
[    1.060899]   HighMem  [mem 0x0000000036ffe000-0x000000003ffeffff]
[    1.061035] Movable zone start for each node
[    1.061105] Early memory node ranges
[    1.061176]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    1.061278]   node   0: [mem 0x0000000000100000-0x000000003ffeffff]
[    1.061388] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffeffff]
[    1.061732] On node 0, zone DMA: 1 pages in unavailable ranges
[    1.066006] On node 0, zone DMA: 97 pages in unavailable ranges
[    1.338476] On node 0, zone HighMem: 16 pages in unavailable ranges
[    1.338620] Using APIC driver default
[    1.338877] ACPI: PM-Timer IO Port: 0x4008
[    1.339001] No local APIC present or hardware disabled
[    1.339077] APIC: disable apic facility
[    1.339146] APIC: switched to apic NOOP
[    1.339225] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    1.339578] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    1.339705] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    1.339813] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    1.339915] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    1.340038] [mem 0x40000000-0xfebfffff] available for PCI devices
[    1.340138] Booting paravirtualized kernel on bare hardware
[    1.340241] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.340545] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:1 nr_node_ids:1
[    1.353464] percpu: Embedded 32 pages/cpu s100436 r0 d30636 u131072
[    1.354401] Built 1 zonelists, mobility grouping on.  Total pages: 259830
[    1.354519] Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.18.0-13.4.el9.v1.i586 root=UUID=b16398f9-683d-4dfc-92e3-8aa1b1705d8b ro crashkernel=auto resume=UUID=ab7d867c-3efa-4569-848c-42d403950ade console=ttyS0,19200
[    1.357144] Unknown kernel command line parameters "BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.18.0-13.4.el9.v1.i586", will be passed to user space.
[    1.383566] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    1.396817] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.397264] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.397393] Initializing HighMem for node 0 (00036ffe:0003fff0)
[    1.722198] Initializing Movable for node 0 (00000000:00000000)
[    1.937068] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    1.937239] Memory: 994780K/1048120K available (9798K kernel code, 4096K rwdata, 8764K rodata, 988K init, 1700K bss, 53340K reserved, 0K cma-reserved, 147400K highmem)
[    1.939826] random: get_random_u32 called from cache_random_seq_create+0x81/0x130 with crng_init=0
[    1.945737] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    1.946192] ftrace: allocating 41020 entries in 81 pages
[    2.049049] ftrace: allocated 81 pages with 3 groups
[    2.051559] trace event string verifier disabled
[    2.052476] Dynamic Preempt: voluntary
[    2.053428] rcu: Preemptible hierarchical RCU implementation.
[    2.053510] rcu: RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
[    2.053603] Trampoline variant of Tasks RCU enabled.
[    2.053671] Rude variant of Tasks RCU enabled.
[    2.053737] Tracing variant of Tasks RCU enabled.
[    2.053810] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    2.053892] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    2.385988] NR_IRQS: 2304, nr_irqs: 32, preallocated irqs: 16
[    2.390555] Console: colour VGA+ 80x25
[    5.854465] printk: console [ttyS0] enabled
[    5.879801] ACPI: Core revision 20211217
[    5.905386] ACPI: setting ELCR to 0200 (from 0e00)
[    5.934453] APIC: Keep in PIC mode(8259)
[    5.958092] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3764b11158, max_idle_ns: 881590415748 ns
[    6.020859] Calibrating delay loop (skipped), value calculated using timer frequency.. 240.18 BogoMIPS (lpj=1200910)
[    6.030870] pid_max: default: 32768 minimum: 301
[    6.042476] LSM: Security Framework initializing
[    6.051450] Yama: becoming mindful.
[    6.061123] SELinux:  Initializing.
[    6.072976] LSM support for eBPF active
[    6.082059] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    6.090995] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    6.116431] Intel Pentium with F0 0F bug - workaround enabled.
[    6.121107] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    6.130865] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    6.285438] Freeing SMP alternatives memory: 32K
[    6.293008] smpboot: weird, boot CPU (#0) not listed by the BIOS
[    6.300889] smpboot: SMP disabled
[    6.317604] cblist_init_generic: Setting adjustable number of callback queues.
[    6.320871] cblist_init_generic: Setting shift to 0 and lim to 1.
[    6.331910] cblist_init_generic: Setting shift to 0 and lim to 1.
[    6.341865] cblist_init_generic: Setting shift to 0 and lim to 1.
[    6.351896] Performance Events: no PMU driver, software events only.
[    6.363336] rcu: Hierarchical SRCU implementation.
[    6.385008] NMI watchdog: Perf NMI watchdog permanently disabled
[    6.393623] smp: Bringing up secondary CPUs ...
[    6.400884] smp: Brought up 1 node, 1 CPU
[    6.410885] smpboot: Max logical packages: 1
[    6.420911] smpboot: Total of 1 processors activated (240.18 BogoMIPS)
[    6.455808] allocated 1048576 bytes of page_ext
[    6.463326] devtmpfs: initialized
[    6.484325] ACPI: PM: Registering ACPI NVS region [mem 0x3fff8000-0x3fffffff] (32768 bytes)
[    6.493051] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    6.500922] futex hash table entries: 256 (order: 1, 8192 bytes, linear)
[    6.512680] pinctrl core: initialized pinctrl subsystem
[    6.536701] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    6.546538] audit: initializing netlink subsys (disabled)
[    6.567049] thermal_sys: Registered thermal governor 'fair_share'
[    6.567117] thermal_sys: Registered thermal governor 'step_wise'
[    6.570891] thermal_sys: Registered thermal governor 'user_space'
[    6.580974] audit: type=2000 audit(1690088540.570:1): state=initialized audit_enabled=0 res=1
[    6.601353] cpuidle: using governor menu
[    6.612927] clocksource: pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1601818034827 ns
[    6.621142] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    6.673557] PCI: PCI BIOS revision 2.10 entry at 0xfdb41, last bus=1
[    6.680882] PCI: Using configuration type 1 for base access
[    6.789886] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    6.794170] test_for_valid_rec: disable ftrace for do_one_initcall offset 0x190
[    6.800961] test_for_valid_rec: disable ftrace for calibrate_delay_direct offset 0x1c0
[    6.842093] test_for_valid_rec: disable ftrace for put_task_stack offset 0x60
[    6.851201] test_for_valid_rec: disable ftrace for panic_smp_self_stop offset 0x10
[    6.860901] test_for_valid_rec: disable ftrace for panic_smp_self_stop offset 0x20
[    6.871419] test_for_valid_rec: disable ftrace for lockdep_assert_cpus_held offset 0x10
[    6.881060] test_for_valid_rec: disable ftrace for freeze_secondary_cpus offset 0xa0
[    6.890909] test_for_valid_rec: disable ftrace for freeze_secondary_cpus offset 0xb0
[    6.901812] test_for_valid_rec: disable ftrace for open_softirq offset 0x20
[    6.911136] test_for_valid_rec: disable ftrace for walk_system_ram_range offset 0xa0
[    6.921258] test_for_valid_rec: disable ftrace for proc_taint offset 0x120
[    6.941848] test_for_valid_rec: disable ftrace for __save_altstack offset 0x50
[    6.951375] test_for_valid_rec: disable ftrace for __ia32_sys_getrusage offset 0x70
[    6.960904] test_for_valid_rec: disable ftrace for __ia32_sys_getrusage offset 0x80
[    6.973655] test_for_valid_rec: disable ftrace for sys_ni_syscall offset 0x10
[    6.990909] test_for_valid_rec: disable ftrace for sys_ni_syscall offset 0x20
[    7.000910] test_for_valid_rec: disable ftrace for sys_ni_syscall offset 0x30
[    7.010911] test_for_valid_rec: disable ftrace for sys_ni_syscall offset 0x40
[    7.020909] test_for_valid_rec: disable ftrace for sys_ni_syscall offset 0x50
[    7.030998] test_for_valid_rec: disable ftrace for __ia32_sys_io_getevents offset 0x10
[    7.040912] test_for_valid_rec: disable ftrace for __ia32_sys_io_getevents offset 0x20
[    7.050912] test_for_valid_rec: disable ftrace for __ia32_sys_io_getevents offset 0x30
[    7.060911] test_for_valid_rec: disable ftrace for __ia32_sys_io_getevents offset 0x40
[    7.070911] test_for_valid_rec: disable ftrace for __ia32_sys_io_getevents offset 0x50
[    7.080925] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x10
[    7.090911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x20
[    7.100911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x30
[    7.110911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x40
[    7.120911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x50
[    7.130911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x60
[    7.140913] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x70
[    7.150911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x80
[    7.160912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x90
[    7.170912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xa0
[    7.180911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xb0
[    7.190912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xc0
[    7.200911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xd0
[    7.210912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xe0
[    7.220911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0xf0
[    7.230910] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x100
[    7.240912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x110
[    7.250911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x120
[    7.260912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x130
[    7.270911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x140
[    7.280969] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x150
[    7.290914] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x160
[    7.300911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x170
[    7.310910] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x180
[    7.320912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x190
[    7.330911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1a0
[    7.340911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1b0
[    7.350911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1c0
[    7.360911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1d0
[    7.370912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1e0
[    7.380911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x1f0
[    7.400906] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x200
[    7.410901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x210
[    7.420912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x220
[    7.430911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x230
[    7.440911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x240
[    7.450912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x250
[    7.460911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x260
[    7.470911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x270
[    7.480912] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x280
[    7.490911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x290
[    7.500911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2a0
[    7.510911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2b0
[    7.520911] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2c0
[    7.530919] clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc-early' as unstable because the skew is too large:
[    7.530985] clocksource:                       'pit' wd_nsec: 504793065 wd_now: eac62d58 wd_last: eabcfc92 mask: ffffffff
[    7.531069] clocksource:                       'tsc-early' cs_nsec: 2394758541 cs_now: 2b42012fb cs_last: 2a2fbd0a5 mask: ffffffffffffffff
[    7.531153] clocksource:                       No current clocksource.
[    7.531186] tsc: Marking TSC unstable due to clocksource watchdog
[    7.580901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2d0
[    7.590901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2e0
[    7.600901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x2f0
[    7.610901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x300
[    7.620901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x310
[    7.630901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x320
[    7.640900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x330
[    7.650901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x340
[    7.660901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x350
[    7.670901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x360
[    7.680901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x370
[    7.690900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x380
[    7.700900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x390
[    7.710901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3a0
[    7.720900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3b0
[    7.730901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3c0
[    7.740901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3d0
[    7.750901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3e0
[    7.760901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x3f0
[    7.770901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x400
[    7.780900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x410
[    7.790901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x420
[    7.800900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x430
[    7.810902] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x440
[    7.820901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x450
[    7.830901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x460
[    7.840901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x470
[    7.850901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x480
[    7.860900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x490
[    7.870900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4a0
[    7.880900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4b0
[    7.890901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4c0
[    7.900901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4d0
[    7.910901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4e0
[    7.920902] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x4f0
[    7.930901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x500
[    7.940901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x510
[    7.950901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x520
[    7.960900] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x530
[    7.970901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x540
[    7.980901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x550
[    7.990901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x560
[    8.000901] test_for_valid_rec: disable ftrace for __ia32_sys_lookup_dcookie offset 0x570
[    8.010946] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x10
[    8.020902] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x20
[    8.030933] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x30
[    8.040902] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x40
[    8.050903] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x50
[    8.060902] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x60
[    8.070976] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x70
[    8.080904] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x80
[    8.090902] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0x90
[    8.100903] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0xa0
[    8.110903] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0xb0
[    8.120903] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0xc0
[    8.130903] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0xd0
[    8.140902] test_for_valid_rec: disable ftrace for __ia32_sys_landlock_restrict_self offset 0xe0
[    8.151016] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x10
[    8.160903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x20
[    8.170903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x30
[    8.180902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x40
[    8.190902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x50
[    8.200903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x60
[    8.210902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x70
[    8.220903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x80
[    8.230903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x90
[    8.240902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xa0
[    8.250903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xb0
[    8.260902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xc0
[    8.270902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xd0
[    8.280902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xe0
[    8.290904] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0xf0
[    8.300903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x100
[    8.310903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x110
[    8.320903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x120
[    8.330903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x130
[    8.340903] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x140
[    8.350902] test_for_valid_rec: disable ftrace for __ia32_sys_set_mempolicy_home_node offset 0x150
[    8.360942] test_for_valid_rec: disable ftrace for __ia32_sys_pkey_free offset 0x10
[    8.380937] test_for_valid_rec: disable ftrace for __ia32_sys_pciconfig_iobase offset 0x10
[    8.400880] test_for_valid_rec: disable ftrace for __ia32_sys_vm86old offset 0x10
[    8.411025] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x10
[    8.420901] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x20
[    8.430902] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x30
[    8.440901] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x40
[    8.450901] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x50
[    8.460902] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x60
[    8.470901] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x70
[    8.480901] test_for_valid_rec: disable ftrace for __ia32_sys_subpage_prot offset 0x80
[    8.490913] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x10
[    8.500901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x20
[    8.510900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x30
[    8.520901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x40
[    8.530931] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x50
[    8.540901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x60
[    8.550901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x70
[    8.560901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x80
[    8.570900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x90
[    8.580901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xa0
[    8.590900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xb0
[    8.600901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xc0
[    8.610901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xd0
[    8.620901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xe0
[    8.630901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0xf0
[    8.640901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x100
[    8.650900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x110
[    8.660900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x120
[    8.670901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x130
[    8.680900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x140
[    8.690901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x150
[    8.700901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x160
[    8.710900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x170
[    8.720901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x180
[    8.730900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x190
[    8.740900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1a0
[    8.750901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1b0
[    8.760901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1c0
[    8.770901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1d0
[    8.780902] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1e0
[    8.790902] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x1f0
[    8.800901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x200
[    8.810901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x210
[    8.820902] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x220
[    8.830901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x230
[    8.840900] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x240
[    8.850901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x250
[    8.860901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x260
[    8.870902] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x270
[    8.880901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x280
[    8.890901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x290
[    8.900902] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x2a0
[    8.910901] test_for_valid_rec: disable ftrace for __ia32_sys_uselib offset 0x2b0
[    8.925788] test_for_valid_rec: disable ftrace for enqueue_task_fair offset 0x670
[    8.931906] test_for_valid_rec: disable ftrace for arch_cpu_idle_prepare offset 0x10
[    8.940906] test_for_valid_rec: disable ftrace for arch_cpu_idle_exit offset 0x10
[    8.950892] test_for_valid_rec: disable ftrace for arch_cpu_idle_exit offset 0x20
[    8.964099] test_for_valid_rec: disable ftrace for set_sched_topology offset 0x20
[    8.972666] test_for_valid_rec: disable ftrace for swsusp_show_speed offset 0x70
[    8.980915] test_for_valid_rec: disable ftrace for hibernation_snapshot offset 0x1e0
[    8.995699] test_for_valid_rec: disable ftrace for init_irq_proc offset 0x80
[    9.005198] test_for_valid_rec: disable ftrace for syscall_enter_from_user_mode_work offset 0x30
[    9.013084] test_for_valid_rec: disable ftrace for timekeeping_max_deferment offset 0x40
[    9.021113] test_for_valid_rec: disable ftrace for second_overflow offset 0x350
[    9.035286] test_for_valid_rec: disable ftrace for flush_smp_call_function_from_idle offset 0x60
[    9.051918] test_for_valid_rec: disable ftrace for do_free_init offset 0x40
[    9.060997] test_for_valid_rec: disable ftrace for layout_symtab offset 0x260
[    9.070995] test_for_valid_rec: disable ftrace for layout_and_allocate offset 0x120
[    9.081379] test_for_valid_rec: disable ftrace for crash_save_vmcoreinfo offset 0x80
[    9.107015] test_for_valid_rec: disable ftrace for kprobe_seq_stop offset 0x10
[    9.121406] test_for_valid_rec: disable ftrace for register_kprobe.part.0 offset 0x2d0
[    9.130982] test_for_valid_rec: disable ftrace for kprobe_free_init_mem offset 0x70
[    9.140888] test_for_valid_rec: disable ftrace for kprobe_free_init_mem offset 0x80
[    9.150908] test_for_valid_rec: disable ftrace for sysrq_handle_dbg offset 0x30
[    9.160899] test_for_valid_rec: disable ftrace for dbg_deactivate_sw_breakpoints offset 0x60
[    9.170936] test_for_valid_rec: disable ftrace for dbg_notify_reboot offset 0x40
[    9.180940] test_for_valid_rec: disable ftrace for kgdb_validate_break_address offset 0x80
[    9.190971] test_for_valid_rec: disable ftrace for kgdb_panic offset 0x50
[    9.202670] test_for_valid_rec: disable ftrace for __seccomp_filter offset 0x4f0
[    9.211837] test_for_valid_rec: disable ftrace for __bpf_prog_ret1 offset 0x10
[    9.221504] test_for_valid_rec: disable ftrace for bpf_get_raw_cpu_id offset 0x20
[    9.230895] test_for_valid_rec: disable ftrace for bpf_get_raw_cpu_id offset 0x30
[    9.240895] test_for_valid_rec: disable ftrace for bpf_get_raw_cpu_id offset 0x40
[    9.250916] test_for_valid_rec: disable ftrace for bpf_jit_compile offset 0x10
[    9.260895] test_for_valid_rec: disable ftrace for bpf_jit_compile offset 0x20
[    9.270895] test_for_valid_rec: disable ftrace for bpf_jit_compile offset 0x30
[    9.280896] test_for_valid_rec: disable ftrace for bpf_jit_compile offset 0x40
[    9.291826] test_for_valid_rec: disable ftrace for bpf_map_get_with_uref offset 0x80
[    9.301391] test_for_valid_rec: disable ftrace for bpf_link_by_id offset 0x20
[    9.326619] test_for_valid_rec: disable ftrace for perf_sample_event_took offset 0x160
[    9.330977] test_for_valid_rec: disable ftrace for perf_event_task_disable offset 0x170
[    9.341963] test_for_valid_rec: disable ftrace for alloc_callchain_buffers offset 0xc0
[    9.350899] test_for_valid_rec: disable ftrace for alloc_callchain_buffers offset 0xd0
[    9.361885] test_for_valid_rec: disable ftrace for arch_uprobe_ignore offset 0x10
[    9.371339] test_for_valid_rec: disable ftrace for static_key_slow_dec_cpuslocked offset 0x50
[    9.382813] test_for_valid_rec: disable ftrace for copy_from_kernel_nofault.part.0 offset 0xb0
[    9.413251] test_for_valid_rec: disable ftrace for generic_max_swapfile_size offset 0x10
[    9.455846] test_for_valid_rec: disable ftrace for c_start offset 0x60
[    9.460968] test_for_valid_rec: disable ftrace for loadavg_proc_show offset 0xc0
[    9.541242] test_for_valid_rec: disable ftrace for pci_bus_clip_resource offset 0x150
[    9.551357] test_for_valid_rec: disable ftrace for pci_scan_slot offset 0xe0
[    9.560888] test_for_valid_rec: disable ftrace for pci_scan_slot offset 0xf0
[    9.570885] test_for_valid_rec: disable ftrace for pci_scan_slot offset 0x100
[    9.580900] test_for_valid_rec: disable ftrace for pci_add_new_bus offset 0x60
[    9.601941] test_for_valid_rec: disable ftrace for __pci_reset_slot offset 0x200
[    9.610924] test_for_valid_rec: disable ftrace for pci_reenable_device offset 0x30
[    9.620897] test_for_valid_rec: disable ftrace for pci_reenable_device offset 0x40
[    9.630897] test_for_valid_rec: disable ftrace for pci_reenable_device offset 0x50
[    9.640924] test_for_valid_rec: disable ftrace for pcim_release offset 0xe0
[    9.651711] test_for_valid_rec: disable ftrace for pci_reassigndev_resource_alignment offset 0x140
[    9.670811] test_for_valid_rec: disable ftrace for pci_map_rom offset 0x1d0
[    9.680962] test_for_valid_rec: disable ftrace for pci_disable_bridge_window offset 0x50
[    9.692174] test_for_valid_rec: disable ftrace for pci_write_msi_msg offset 0x30
[    9.718708] test_for_valid_rec: disable ftrace for acpi_sleep_state_supported offset 0x80
[    9.723025] test_for_valid_rec: disable ftrace for acpi_processor_errata_piix4.isra.0 offset 0x250
[    9.730907] test_for_valid_rec: disable ftrace for acpi_processor_errata_piix4.isra.0 offset 0x260
[    9.740903] test_for_valid_rec: disable ftrace for acpi_processor_errata_piix4.isra.0 offset 0x270
[    9.750930] test_for_valid_rec: disable ftrace for acpi_processor_add offset 0x180
[    9.780302] test_for_valid_rec: disable ftrace for apei_exec_noop offset 0x10
[    9.780901] test_for_valid_rec: disable ftrace for apei_exec_noop offset 0x20
[    9.815459] test_for_valid_rec: disable ftrace for write_mem offset 0x1a0
[    9.838016] test_for_valid_rec: disable ftrace for crash_notes_size_show offset 0x20
[    9.840941] test_for_valid_rec: disable ftrace for get_cpu_device offset 0x40
[    9.850887] test_for_valid_rec: disable ftrace for get_cpu_device offset 0x60
[    9.860887] test_for_valid_rec: disable ftrace for get_cpu_device offset 0x80
[    9.870885] test_for_valid_rec: disable ftrace for get_cpu_device offset 0xa0
[    9.880886] test_for_valid_rec: disable ftrace for get_cpu_device offset 0xc0
[    9.890885] test_for_valid_rec: disable ftrace for get_cpu_device offset 0xe0
[    9.900886] test_for_valid_rec: disable ftrace for get_cpu_device offset 0x100
[    9.910886] test_for_valid_rec: disable ftrace for get_cpu_device offset 0x120
[    9.931180] test_for_valid_rec: disable ftrace for cache_shared_cpu_map_setup offset 0x140
[    9.940903] test_for_valid_rec: disable ftrace for cache_shared_cpu_map_setup offset 0x150
[    9.950902] test_for_valid_rec: disable ftrace for cache_shared_cpu_map_setup offset 0x160
[   10.022009] test_for_valid_rec: disable ftrace for therm_throt_process offset 0x190
[   10.044027] test_for_valid_rec: disable ftrace for cpufreq_cpu_acquire offset 0x50
[   10.050957] test_for_valid_rec: disable ftrace for cpufreq_driver_has_adjust_perf offset 0x20
[   10.075402] test_for_valid_rec: disable ftrace for read_hv_clock_tsc_cs offset 0x10
[   10.080895] test_for_valid_rec: disable ftrace for read_hv_clock_tsc_cs offset 0x20
[   10.093921] test_for_valid_rec: disable ftrace for hv_setup_dma_ops offset 0x10
[   10.110892] test_for_valid_rec: disable ftrace for hv_setup_dma_ops offset 0x20
[   10.120894] test_for_valid_rec: disable ftrace for hv_setup_dma_ops offset 0x30
[   10.130905] test_for_valid_rec: disable ftrace for hv_ghcb_hypercall offset 0x20
[   10.140895] test_for_valid_rec: disable ftrace for hv_ghcb_hypercall offset 0x30
[   10.150917] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0xd0
[   10.160896] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0xe0
[   10.170894] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0xf0
[   10.180895] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0x100
[   10.190895] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0x110
[   10.200895] test_for_valid_rec: disable ftrace for hv_query_ext_cap offset 0x120
[   10.303572] test_for_valid_rec: disable ftrace for parse_early_param offset 0x6c
[   10.310929] test_for_valid_rec: disable ftrace for arch_call_rest_init offset 0xf
[   10.320939] test_for_valid_rec: disable ftrace for mem_encrypt_init offset 0xa
[   10.331481] test_for_valid_rec: disable ftrace for reserve_initrd_mem offset 0xe2
[   10.346398] test_for_valid_rec: disable ftrace for softirq_init offset 0x63
[   10.350889] test_for_valid_rec: disable ftrace for softirq_init offset 0x6f
[   10.360886] test_for_valid_rec: disable ftrace for softirq_init offset 0x7e
[   10.373030] test_for_valid_rec: disable ftrace for init_optprobes offset 0x11
[   10.381732] test_for_valid_rec: disable ftrace for pcpu_embed_first_chunk offset 0x256
[   10.401693] test_for_valid_rec: disable ftrace for pci_realloc_setup_params offset 0x34
[   10.630966] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[   10.645310] cryptd: max_cpu_qlen set to 1000
[   10.662608] ACPI: Added _OSI(Module Device)
[   10.671066] ACPI: Added _OSI(Processor Device)
[   10.680917] ACPI: Added _OSI(3.0 _SCP Extensions)
[   10.690915] ACPI: Added _OSI(Processor Aggregator Device)
[   10.700921] ACPI: Added _OSI(Linux-Dell-Video)
[   10.710922] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[   10.720924] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   10.781324] ACPI: 1 ACPI AML tables successfully acquired and loaded
[   10.818721] ACPI: Interpreter enabled
[   10.831367] ACPI: PM: (supports S0 S1 S5)
[   10.841014] ACPI: Using PIC for interrupt routing
[   10.851375] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[   11.022964] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[   11.031043] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[   11.040910] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[   11.051052] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[   11.062866] acpi PNP0A03:00: ignoring host bridge window [mem 0x000cb000-0x000dffff window] (conflicts with Video ROM [mem 0x000c0000-0x000ccfff])
[   11.073133] PCI host bridge to bus 0000:00
[   11.080933] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[   11.090922] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   11.100922] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[   11.110921] pci_bus 0000:00: root bus resource [mem 0x40000000-0xffdfffff window]
[   11.120926] pci_bus 0000:00: root bus resource [bus 00-ff]
[   11.131164] pci 0000:00:00.0: [10b9:1541] type 00 class 0x060000
[   11.140936] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xe3ffffff]
[   11.152758] pci 0000:00:01.0: [10b9:5243] type 01 class 0x060400
[   11.162525] pci 0000:00:07.0: [10b9:1533] type 00 class 0x060100
[   11.182921] pci 0000:00:0f.0: [10b9:5229] type 00 class 0x0101fa
[   11.190994] pci 0000:00:0f.0: reg 0x20: [io  0xffa0-0xffaf]
[   11.200937] pci 0000:00:0f.0: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[   11.210893] pci 0000:00:0f.0: legacy IDE quirk: reg 0x14: [io  0x03f6]
[   11.220892] pci 0000:00:0f.0: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[   11.230891] pci 0000:00:0f.0: legacy IDE quirk: reg 0x1c: [io  0x0376]
[   11.242321] pci 0000:00:12.0: [8086:1229] type 00 class 0x020000
[   11.250937] pci 0000:00:12.0: reg 0x10: [mem 0xcf9ff000-0xcf9fffff pref]
[   11.260913] pci 0000:00:12.0: reg 0x14: [io  0xdf80-0xdf9f]
[   11.270914] pci 0000:00:12.0: reg 0x18: [mem 0xdfe00000-0xdfefffff]
[   11.280957] pci 0000:00:12.0: reg 0x30: [mem 0xdfd00000-0xdfdfffff pref]
[   11.292409] pci 0000:00:14.0: [1033:0035] type 00 class 0x0c0310
[   11.300938] pci 0000:00:14.0: reg 0x10: [mem 0xdfffd000-0xdfffdfff]
[   11.311238] pci 0000:00:14.0: supports D1 D2
[   11.320897] pci 0000:00:14.0: PME# supported from D0 D1 D2 D3hot
[   11.332456] pci 0000:00:14.1: [1033:0035] type 00 class 0x0c0310
[   11.340938] pci 0000:00:14.1: reg 0x10: [mem 0xdfffe000-0xdfffefff]
[   11.361227] pci 0000:00:14.1: supports D1 D2
[   11.370895] pci 0000:00:14.1: PME# supported from D0 D1 D2 D3hot
[   11.382445] pci 0000:00:14.2: [1033:00e0] type 00 class 0x0c0320
[   11.390936] pci 0000:00:14.2: reg 0x10: [mem 0xdfffff00-0xdfffffff]
[   11.401239] pci 0000:00:14.2: supports D1 D2
[   11.410897] pci 0000:00:14.2: PME# supported from D0 D1 D2 D3hot
[   11.422476] pci_bus 0000:01: extended config space not accessible
[   11.431622] pci 0000:01:00.0: [1002:5960] type 00 class 0x030000
[   11.440934] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xc7ffffff pref]
[   11.450914] pci 0000:01:00.0: reg 0x14: [io  0xcc00-0xccff]
[   11.460914] pci 0000:01:00.0: reg 0x18: [mem 0xcfaf0000-0xcfafffff]
[   11.470962] pci 0000:01:00.0: reg 0x30: [mem 0xcfac0000-0xcfadffff pref]
[   11.481095] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[   11.490981] pci 0000:01:00.0: supports D1 D2
[   11.502291] pci 0000:01:00.1: [1002:5940] type 00 class 0x038000
[   11.510933] pci 0000:01:00.1: reg 0x10: [mem 0xb8000000-0xbfffffff pref]
[   11.520915] pci 0000:01:00.1: reg 0x14: [mem 0xcfae0000-0xcfaeffff]
[   11.541107] pci 0000:01:00.1: supports D1 D2
[   11.552261] pci 0000:00:01.0: PCI bridge to [bus 01]
[   11.560907] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[   11.570898] pci 0000:00:01.0:   bridge window [mem 0xcfa00000-0xcfafffff]
[   11.580899] pci 0000:00:01.0:   bridge window [mem 0xaf800000-0xcf8fffff pref]
[   11.628244] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[   11.635101] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[   11.645096] ACPI: PCI: Interrupt link LNKC configured for IRQ 9
[   11.654996] ACPI: PCI: Interrupt link LNKD configured for IRQ 9
[   11.660961] ACPI: PCI: Interrupt link LNKD disabled
[   11.675163] ACPI: PCI: Interrupt link LNKU configured for IRQ 9
[   11.680887] ACPI: PCI: Interrupt link LNKU disabled
[   11.696671] iommu: Default domain type: Translated 
[   11.700936] iommu: DMA domain TLB invalidation policy: lazy mode 
[   11.711001] random: fast init done
[   11.724945] SCSI subsystem initialized
[   11.732140] ACPI: bus type USB registered
[   11.741682] usbcore: registered new interface driver usbfs
[   11.751328] usbcore: registered new interface driver hub
[   11.761268] usbcore: registered new device driver usb
[   11.772483] pps_core: LinuxPPS API ver. 1 registered
[   11.780879] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   11.791071] PTP clock support registered
[   11.802626] EDAC MC: Ver: 3.0.0
[   11.825049] NetLabel: Initializing
[   11.830883] NetLabel:  domain hash size = 128
[   11.840872] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[   11.851452] NetLabel:  unlabeled traffic allowed by default
[   11.860883] PCI: Using ACPI for IRQ routing
[   11.872575] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[   11.880802] pci 0000:01:00.0: vgaarb: bridge control possible
[   11.880802] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[   11.880883] vgaarb: loaded
[   11.894543] clocksource: Switched to clocksource pit
[   12.753896] VFS: Disk quotas dquot_6.6.0
[   12.776393] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   12.790203] pnp: PnP ACPI init
[   12.841065] pnp: PnP ACPI: found 6 devices
[   12.845863] PnPBIOS: Disabled
[   12.967091] PM-Timer running at invalid rate: 200% of normal - aborting.
[   12.979687] NET: Registered PF_INET protocol family
[   12.991902] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
[   13.006252] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[   13.017022] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[   13.024113] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[   13.038016] TCP: Hash tables configured (established 8192 bind 8192)
[   13.048314] MPTCP token hash table entries: 1024 (order: 2, 16384 bytes, linear)
[   13.063576] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[   13.073825] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[   13.087800] NET: Registered PF_UNIX/PF_LOCAL protocol family
[   13.102090] NET: Registered PF_XDP protocol family
[   13.111444] pci 0000:00:01.0: PCI bridge to [bus 01]
[   13.121494] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[   13.128237] pci 0000:00:01.0:   bridge window [mem 0xcfa00000-0xcfafffff]
[   13.139162] pci 0000:00:01.0:   bridge window [mem 0xaf800000-0xcf8fffff pref]
[   13.152715] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   13.159985] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   13.167223] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   13.178661] pci_bus 0000:00: resource 7 [mem 0x40000000-0xffdfffff window]
[   13.190100] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[   13.193809] pci_bus 0000:01: resource 1 [mem 0xcfa00000-0xcfafffff]
[   13.211589] pci_bus 0000:01: resource 2 [mem 0xaf800000-0xcf8fffff pref]
[   13.223229] pci 0000:00:07.0: Activating ISA DMA hang workarounds
[   13.239956] pci 0000:00:07.0: quirk_isa_dma_hangs+0x0/0x20 took 16336 usecs
[   13.252261] pci 0000:00:12.0: Firmware left e100 interrupts enabled; disabling
[   13.263753] ACPI: \_SB_.LNKA: Enabled at IRQ 11
[   13.282368] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x110 took 25864 usecs
[   13.294744] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   13.313540] pci 0000:00:14.1: quirk_usb_early_handoff+0x0/0x110 took 25846 usecs
[   13.335939] ACPI: \_SB_.LNKC: Enabled at IRQ 9
[   13.354123] pci 0000:00:14.2: quirk_usb_early_handoff+0x0/0x110 took 25267 usecs
[   13.368880] PCI: CLS 32 bytes, default 32
[   13.374951] Trying to unpack rootfs image as initramfs...
[   13.387815] ACPI: bus type thunderbolt registered
[   13.431076] Initialise system trusted keyrings
[   13.454070] Key type blacklist registered
[   13.484990] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[   13.720821] zbud: loaded
[   13.770908] integrity: Platform Keyring initialized
[   15.519012] NET: Registered PF_ALG protocol family
[   15.540013] xor: measuring software checksum speed
[   15.639956]    8regs           :   108 MB/sec
[   15.752649]    8regs_prefetch  :    92 MB/sec
[   15.849030]    32regs          :   109 MB/sec
[   15.957808]    32regs_prefetch :    96 MB/sec
[   15.964113] xor: using function: 32regs (109 MB/sec)
[   16.546820] Key type asymmetric registered
[   16.575561] Asymmetric key parser 'x509' registered
[   26.799248] Freeing initrd memory: 16024K
[   27.007880] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[   27.024914] bounce: pool size: 64 pages
[   27.039503] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[   27.045332] io scheduler mq-deadline registered
[   27.062807] io scheduler kyber registered
[   27.068847] io scheduler bfq registered
[   27.152292] atomic64_test: passed for i586+ platform with CX8 and without SSE
[   27.176699] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   27.190408] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[   27.196472] ACPI: button: Power Button [PWRF]
[   27.220924] isapnp: Scanning for PnP cards...
[   27.586726] isapnp: No Plug & Play device found
[   27.596829] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   27.606537] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   27.635232] Non-volatile memory driver v1.3
[   27.663687] hp_sw: device handler registered
[   27.684770] Floppy drive(s): fd0 is 1.44M
[   27.706738] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   27.716553] ehci-pci: EHCI PCI platform driver
[   27.725058] ehci-pci 0000:00:14.2: EHCI Host Controller
[   27.738388] ehci-pci 0000:00:14.2: new USB bus registered, assigned bus number 1
[   27.754294] FDC 0 is a post-1991 82077
[   27.767711] ehci-pci 0000:00:14.2: irq 9, io mem 0xdfffff00
[   27.803390] ehci-pci 0000:00:14.2: USB 2.0 started, EHCI 1.00
[   27.820142] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.18
[   27.829893] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   27.833389] usb usb1: Product: EHCI Host Controller
[   27.852812] usb usb1: Manufacturer: Linux 5.18.0-13.4.el9.v1.i586 ehci_hcd
[   27.854177] usb usb1: SerialNumber: 0000:00:14.2
[   27.876535] hub 1-0:1.0: USB hub found
[   27.889664] hub 1-0:1.0: 5 ports detected
[   27.901085] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   27.908461] ohci-pci: OHCI PCI platform driver
[   27.916808] ohci-pci 0000:00:14.0: OHCI PCI host controller
[   27.934222] ohci-pci 0000:00:14.0: new USB bus registered, assigned bus number 2
[   27.949286] ohci-pci 0000:00:14.0: irq 11, io mem 0xdfffd000
[   28.059143] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.18
[   28.068967] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   28.082440] usb usb2: Product: OHCI PCI host controller
[   28.083919] usb usb2: Manufacturer: Linux 5.18.0-13.4.el9.v1.i586 ohci_hcd
[   28.095321] usb usb2: SerialNumber: 0000:00:14.0
[   28.117252] hub 2-0:1.0: USB hub found
[   28.130369] hub 2-0:1.0: 3 ports detected
[   28.141561] ohci-pci 0000:00:14.1: OHCI PCI host controller
[   28.147001] ohci-pci 0000:00:14.1: new USB bus registered, assigned bus number 3
[   28.162087] ohci-pci 0000:00:14.1: irq 10, io mem 0xdfffe000
[   28.268905] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.18
[   28.278666] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   28.292166] usb usb3: Product: OHCI PCI host controller
[   28.293651] usb usb3: Manufacturer: Linux 5.18.0-13.4.el9.v1.i586 ohci_hcd
[   28.305056] usb usb3: SerialNumber: 0000:00:14.1
[   28.326766] hub 3-0:1.0: USB hub found
[   28.339876] hub 3-0:1.0: 2 ports detected
[   28.349136] uhci_hcd: USB Universal Host Controller Interface driver
[   28.360356] usbcore: registered new interface driver usbserial_generic
[   28.369899] usbserial: USB Serial support registered for generic
[   28.376422] usbcore: registered new interface driver oti6858
[   28.392185] usbserial: USB Serial support registered for oti6858
[   28.398712] usbcore: registered new interface driver pl2303
[   28.412541] usbserial: USB Serial support registered for pl2303
[   28.418545] usbcore: registered new interface driver spcp8x5
[   28.432888] usbserial: USB Serial support registered for SPCP8x5
[   28.439358] usbcore: registered new interface driver ssu100
[   28.453320] usbserial: USB Serial support registered for Quatech SSU-100 USB to Serial Driver
[   28.464900] usbcore: registered new interface driver ti_usb_3410_5052
[   28.473908] usbserial: USB Serial support registered for TI USB 3410 1 port adapter
[   28.490173] usbserial: USB Serial support registered for TI USB 5052 2 port adapter
[   28.496566] usbcore: registered new interface driver upd78f0730
[   28.512480] usbserial: USB Serial support registered for upd78f0730
[   28.522474] i8042: PNP: PS/2 Controller [PNP030b:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[   28.548813] serio: i8042 KBD port at 0x60,0x64 irq 1
[   28.558880] serio: i8042 AUX port at 0x60,0x64 irq 12
[   28.574068] mousedev: PS/2 mouse device common for all mice
[   28.590893] rtc_cmos 00:00: RTC can wake from S4
[   28.604202] rtc_cmos 00:00: registered as rtc0
[   28.621378] rtc_cmos 00:00: setting system clock to 2023-07-23T05:03:04 UTC (1690088584)
[   28.630911] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
[   28.639346] intel_pstate: CPU model not supported
[   28.657375] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[   28.670056] hid: raw HID events driver (C) Jiri Kosina
[   28.686864] usbcore: registered new interface driver usbhid
[   28.700459] usbhid: USB HID core driver
[   28.705124] drop_monitor: Initializing network drop monitor service
[   29.488360] Initializing XFRM netlink socket
[   29.500944] NET: Registered PF_INET6 protocol family
[   29.525363] Segment Routing with IPv6
[   29.538123] In-situ OAM (IOAM) with IPv6
[   29.552955] NET: Registered PF_PACKET protocol family
[   29.554972] mpls_gso: MPLS GSO support
[   29.568235] mce: Unable to init MCE device (rc: -5)
[   29.581790] IPI shorthand broadcast: enabled
[   29.591641] registered taskstats version 1
[   29.598690] Loading compiled-in X.509 certificates
[   30.772724] input: ImPS/2 Generic Wheel Mouse as /devices/platform/i8042/serio1/input/input3
[   40.761293] Loaded X.509 cert 'Rocky kernel signing key: cb59be4a535be8d854adf17814492325e7156045'
[   40.898440] Loaded X.509 cert 'Rocky kernel signing key: cb59be4a535be8d854adf17814492325e7156045'
[   40.917009] zswap: loaded using pool lzo/zbud
[   40.936660] page_owner is disabled
[   40.948037] Key type big_key registered
[   41.134975] Key type encrypted registered
[   41.149905] ima: No TPM chip found, activating TPM-bypass!
[   41.163270] Loading compiled-in module X.509 certificates
[   41.310040] Loaded X.509 cert 'Rocky kernel signing key: cb59be4a535be8d854adf17814492325e7156045'
[   41.314159] ima: Allocated hash algorithm: sha256
[   41.333053] ima: No architecture policies found
[   41.341024] evm: Initialising EVM extended attributes:
[   41.351980] evm: security.selinux
[   41.362031] evm: security.SMACK64 (disabled)
[   41.367798] evm: security.SMACK64EXEC (disabled)
[   41.375632] evm: security.SMACK64TRANSMUTE (disabled)
[   41.386101] evm: security.SMACK64MMAP (disabled)
[   41.393965] evm: security.apparmor (disabled)
[   41.410224] evm: security.ima
[   41.418157] evm: security.capability
[   41.429733] evm: HMAC attrs: 0x1
[   85.180872] Unstable clock detected, switching default tracing clock to "global"
[   85.180872] If you want to keep using the local clock, then add:
[   85.180872]   "trace_clock=local"
[   85.180872] on the kernel command line
[   85.267949] Freeing unused kernel image (initmem) memory: 988K
[   85.285141] Write protecting kernel text and read-only data: 18564k
[   85.302972] Run /init as init process
[   85.736838] systemd[1]: systemd 250-12.el9_1.v1.1 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[   85.759661] systemd[1]: Detected architecture x86.
[   85.769093] systemd[1]: Running in initial RAM disk.

Welcome to Rocky Linux 9.1 (Blue Onyx) dracut-057-13.git20220816.el9.v1 (Initramfs)!

[   85.881127] systemd[1]: Hostname set to <cygnus.five.ten>.
[   86.006075] systemd[1]: Failed to open libbpf, LSM BPF is not supported: Operation not supported
[   91.444472] systemd[1]: Queued start job for default target Initrd Default Target.
[   93.804436] random: crng init done
[   93.856248] systemd[1]: Created slice Slice /system/systemd-hibernate-resume.
[  OK  ] Created slice Slice /system/systemd-hibernate-resume.
[   93.953213] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Started Dispatch Password $B&t(Bs to Console Directory Watch.
[   94.053745] systemd[1]: Reached target Initrd /usr File System.
[  OK  ] Reached target Initrd /usr File System.
[   94.141715] systemd[1]: Reached target Path Units.
[  OK  ] Reached target Path Units.
[   94.212002] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[   94.281179] systemd[1]: Reached target Swaps.
[  OK  ] Reached target Swaps.
[   94.346855] systemd[1]: Reached target Timer Units.
[  OK  ] Reached target Timer Units.
[   94.426928] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[   94.527563] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[   94.608138] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[   94.691907] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[   94.780797] systemd[1]: Reached target Socket Units.
[  OK  ] Reached target Socket Units.
[   94.903731] systemd[1]: Starting Create List of Static Device Nodes...
         Starting Create List of Static Device Nodes...
[   95.097146] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   95.195537] systemd[1]: Load Kernel Modules was skipped because all trigger condition checks failed.
[   95.319609] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[   95.577715] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[   95.825627] systemd[1]: Finished Create List of Static Device Nodes.
[  OK  ] Finished Create List of Static Device Nodes.
[   96.159645] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[   96.645822] systemd[1]: Finished Apply Kernel Variables.
[  OK  ] Finished Apply Kernel Variables.
[   96.784975] systemd[1]: systemd-vconsole-setup.service: Main process exited, code=exited, status=1/FAILURE
[   96.853728] systemd[1]: systemd-vconsole-setup.service: Failed with result 'exit-code'.
[   96.916274] systemd[1]: Failed to start Setup Virtual Console.
[FAILED] Failed to start Setup Virtual Console.
See 'systemctl status systemd-vconsole-setup.service' for details.
[   97.093606] systemd[1]: dracut ask for additional cmdline parameters was skipped because all trigger condition checks failed.
[   97.291351] systemd[1]: Starting dracut cmdline hook...
         Starting dracut cmdline hook...
[   97.455809] systemd[1]: Finished Create Static Device Nodes in /dev.
[  OK  ] Finished Create Static Device Nodes in /dev.
[  101.505949] systemd[1]: Finished dracut cmdline hook.
[  OK  ] Finished dracut cmdline hook.
[  101.606707] systemd[1]: dracut pre-udev hook was skipped because all trigger condition checks failed.
[  101.810253] systemd[1]: Starting Rule-based Manager for Device Events and Files...
         Starting Rule-based Manage$B&f(Bor Device Events and Files...
[  103.006288] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Started Rule-based Manager for Device Events and Files.
         Starting Coldplug All udev Devices...
[  *** ] (2 of 3) A start job is running for2e3-8aa1b1705d8b (14s / no limit)
[   ***] (2 of 3) A start job is running for2e3-8aa1b1705d8b (15s / no limit)
[    **] (3 of 3) A start job is running for48c-42d403950ade (15s / no limit)
[     *] (3 of 3) A start job is running for48c-42d403950ade (16s / no limit)
[    **] (3 of 3) A start job is running for48c-42d403950ade (16s / no limit)
[   ***] (1 of 3) A start job is running forAll udev Devices (17s / no limit)
[  *** ] (1 of 3) A start job is running forAll udev Devices (17s / no limit)
[ ***  ] (1 of 3) A start job is running forAll udev Devices (18s / no limit)
[  OK  ] Finished Coldplug All udev Devices.
[  OK  ] Reached target Preparation for Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (20s / no limit)
[**    ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (21s / no limit)
[*     ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (21s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (22s / no limit)
[***   ] (2 of 2) A start job is running for48c-42d403950ade (22s / no limit)
[ ***  ] (2 of 2) A start job is running for48c-42d403950ade (23s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (23s / no limit)
[   ***] (1 of 2) A start job is running for2e3-8aa1b1705d8b (24s / no limit)
[    **] (1 of 2) A start job is running for2e3-8aa1b1705d8b (25s / no limit)
[     *] (2 of 2) A start job is running for48c-42d403950ade (25s / no limit)
[    **] (2 of 2) A start job is running for48c-42d403950ade (26s / no limit)
[   ***] (2 of 2) A start job is running for48c-42d403950ade (26s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (27s / no limit)
[ ***  ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (27s / no limit)
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (28s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (28s / no limit)
[*     ] (2 of 2) A start job is running for48c-42d403950ade (29s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (29s / no limit)
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (30s / no limit)
[ ***  ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (30s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (31s / no limit)
[   ***] (2 of 2) A start job is running for48c-42d403950ade (31s / no limit)
[    **] (2 of 2) A start job is running for48c-42d403950ade (32s / no limit)
[     *] (2 of 2) A start job is running for48c-42d403950ade (32s / no limit)
[    **] (1 of 2) A start job is running for2e3-8aa1b1705d8b (33s / no limit)
[   ***] (1 of 2) A start job is running for2e3-8aa1b1705d8b (33s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (34s / no limit)
[ ***  ] (2 of 2) A start job is running for48c-42d403950ade (34s / no limit)
[***   ] (2 of 2) A start job is running for48c-42d403950ade (35s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (35s / no limit)
[*     ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (36s / no limit)
[**    ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (36s / no limit)
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (37s / no limit)
[ ***  ] (2 of 2) A start job is running for48c-42d403950ade (37s / no limit)
[  *** ] (2 of 2) A start job is running for48c-42d403950ade (38s / no limit)
[   ***] (2 of 2) A start job is running for48c-42d403950ade (38s / no limit)
[    **] (1 of 2) A start job is running for2e3-8aa1b1705d8b (39s / no limit)
[     *] (1 of 2) A start job is running for2e3-8aa1b1705d8b (39s / no limit)
[    **] (1 of 2) A start job is running for2e3-8aa1b1705d8b (40s / no limit)
[   ***] (2 of 2) A start job is running for48c-42d403950ade (40s / no limit)
[  *** ] (2 of 2) A start job is running for48c-42d403950ade (41s / no limit)
[  133.131806] pata_ali 0000:00:0f.0: can't derive routing for PCI INT A
[  133.196242] scsi host0: pata_ali
[  133.246352] scsi host1: pata_ali
[  133.288795] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
[  133.300368] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
[ ***  ] (2 of 2) A start job is running for48c-42d403950ade (41s / no limit)
[  133.505943] ata1.00: ATA-6: WDC WD400BB-00JHA0, 05.01C05, max UDMA/100
[  133.518811] ata1.00: 78165360 sectors, multi 16: LBA 
[  133.529524] ata1.01: ATAPI: MATSHITADVD-RAM LF-M721, APQ2, max UDMA/33
[  133.538925] ata1.01: WARNING: ATAPI DMA disabled for reliability issues.  It can be enabled
[  133.549191] ata1.01: WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs node.
[  133.610976] scsi 0:0:0:0: Direct-Access     ATA      WDC WD400BB-00JH 1C05 PQ: 0 ANSI: 5
[  133.647061] scsi 0:0:1:0: CD-ROM            MATSHITA DVD-RAM LF-M721  APQ2 PQ: 0 ANSI: 5
[  133.925491] ata2.00: ATAPI: MATSHITA CD-RW CW-7586, 1.08, max MWDMA2
[  133.944050] ata2.00: WARNING: ATAPI DMA disabled for reliability issues.  It can be enabled
[  133.954372] ata2.00: WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs node.
[***   ] (1 of 2) A start job is running for2e3-8aa1b17[  134.019478] scsi 1:0:0:0: CD-ROM            MATSHITA CD-RW  CW-7586   1.08 PQ: 0 ANSI: 5
05d8b (42s / no limit)
[**    ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (43s / no limit)
[*     ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (43s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (44s / no limit)
[***   ] (2 of 2) A start job is running for48c-42d403950ade (44s / no limit)
[  136.047219] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[  136.099160] scsi 0:0:1:0: Attached scsi generic sg1 type 5
[  136.129706] scsi 1:0:0:0: Attached scsi generic sg2 type 5
[ ***  ] (2 of 2) A start job is running for48c-42d403950ade (45s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (45s / no limit)
[   ***] (1 of 2) A start job is running for2e3-8aa1b1705d8b (46s / no limit)
[    **] (1 of 2) A start job is running for2e3-8aa1b1705d8b (46s / no limit)
[     *] (2 of 2) A start job is running for48c-42d403950ade (47s / no limit)
[  138.678521] sr 0:0:1:0: [sr0] scsi3-mmc drive: 32x/32x writer dvd-ram cd/rw xa/form2 cdda tray
[  138.690478] cdrom: Uniform CD-ROM driver Revision: 3.20
[  138.868369] sr 1:0:0:0: [sr1] scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
[    **] (2 of 2) A start job is running for48c-42d403950ade (47s / no limit)
[   ***] (2 of 2) A start job is running for48c-42d403950ade (48s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (48s / no limit)
[  140.176107] sd 0:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.3 GiB)
[  140.225949] sd 0:0:0:0: [sda] Write Protect is off
[  140.276236] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  140.392824]  sda: sda1 sda2 sda3
[ ***  ] (1 of 2) A start job is running fo[  140.495456] sd 0:0:0:0: [sda] Attached SCSI disk
r2e3-8aa1b1705d8b (49s / no limit)
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (49s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (50s / no limit)
[*     ] (2 of 2) A start job is running for48c-42d403950ade (50s / no limit)
[**    ] (2 of 2) A start job is running for48c-42d403950ade (51s / no limit)
[***   ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (52s / no limit)
[ ***  ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (53s / no limit)
[  *** ] (1 of 2) A start job is running for2e3-8aa1b1705d8b (53s / no limit)
[  OK  ] Found device WDC_WD400BB-00JHA0 /r9swap.
[  OK  ] Found device WDC_WD400BB-00JHA0 /r9root.
[  OK  ] Reached target Initrd Root Device.
         Starting Resume from hiberefa-4569-848c-42d403950ade...
[  OK  ] Finished Resume from hiber$B&c(B-3efa-4569-848c-42d403950ade.
[  OK  ] Reached target Preparation for Local File Systems.
[  OK  ] Reached target Local File Systems.
         Starting File System Check83d-4dfc-92e3-8aa1b1705d8b...
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Create Volatile Files and Directories.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
[  OK  ] Finished File System Check-683d-4dfc-92e3-8aa1b1705d8b.
         Mounting /sysroot...
[   ***] A start job is running for /sysroot (1min 1s / 2min 28s)
[    **] A start job is running for /sysroot (1min 1s / 2min 28s)
[     *] A start job is running for /sysroot (1min 2s / 2min 28s)
[    **] A start job is running for /sysroot (1min 2s / 2min 28s)
[   ***] A start job is running for /sysroot (1min 3s / 2min 28s)
[  *** ] A start job is running for /sysroot (1min 5s / 2min 28s)
[  156.904316] EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Finished Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting Cleaning Up and Shutting Down Daemons...
[  OK  ] Finished Cleaning Up and Shutting Down Daemons.
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target Initrd Root Device.
[  OK  ] Stopped target Initrd /usr File System.
[  OK  ] Stopped target Path Units.
[  OK  ] Stopped Dispatch Password $B&t(Bs to Console Directory Watch.
[  OK  ] Stopped target Remote File Systems.
[  OK  ] Stopped target Preparation for Remote File Systems.
[  OK  ] Stopped target Slice Units.
[  OK  ] Stopped target Socket Units.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped target Swaps.
[  OK  ] Stopped target Timer Units.
[  OK  ] Stopped dracut cmdline hook.
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped target Preparation for Local File Systems.
[  OK  ] Stopped Coldplug All udev Devices.
         Stopping Rule-based Manage$B&f(Bor Device Events and Files...
[  OK  ] Stopped Rule-based Manager for Device Events and Files.
[  OK  ] Closed udev Control Socket.
[  OK  ] Closed udev Kernel Socket.
         Starting Cleanup udev Database...
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create List of Static Device Nodes.
[  OK  ] Finished Cleanup udev Database.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[  174.311889] systemd-journald[162]: Received SIGTERM from PID 1 (systemd).
[  177.107819] audit: type=1404 audit(1690088732.982:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
[  178.602815] SELinux:  Class mctp_socket not defined in policy.
[  178.608202] SELinux:  Class io_uring not defined in policy.
[  178.621865] SELinux: the above unknown classes and permissions will be allowed
[  178.862497] SELinux:  policy capability network_peer_controls=1
[  178.868409] SELinux:  policy capability open_perms=1
[  178.878352] SELinux:  policy capability extended_socket_class=1
[  178.894006] SELinux:  policy capability always_check_network=0
[  178.899133] SELinux:  policy capability cgroup_seclabel=1
[  178.911698] SELinux:  policy capability nnp_nosuid_transition=1
[  178.917362] SELinux:  policy capability genfs_seclabel_symlinks=0
[  178.934069] SELinux:  policy capability ioctl_skip_cloexec=0
[  180.614794] audit: type=1403 audit(1690088736.482:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
[  180.711494] systemd[1]: Successfully loaded SELinux policy in 3.629694s.
[  184.896325] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup in 3.559956s.
[  185.367354] systemd[1]: systemd 250-12.el9_1.v1.1 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS -FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[  185.388981] systemd[1]: Detected architecture x86.

Welcome to Rocky Linux 9.1 (Blue Onyx)!

[  191.121231] systemd[1]: Failed to link BPF program. Assuming BPF is not available
[  194.974348] systemd-rc-local-generator[312]: /etc/rc.d/rc.local is not marked executable, skipping.
[  208.285473] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[  208.299227] systemd[1]: Stopped Switch Root.
[  OK  ] Stopped Switch Root.
[  208.412159] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[  208.454283] systemd[1]: Created slice Slice /system/getty.
[  OK  ] Created slice Slice /system/getty.
[  208.557827] systemd[1]: Created slice Slice /system/modprobe.
[  OK  ] Created slice Slice /system/modprobe.
[  208.678154] systemd[1]: Created slice Slice /system/serial-getty.
[  OK  ] Created slice Slice /system/serial-getty.
[  208.793476] systemd[1]: Created slice Slice /system/sshd-keygen.
[  OK  ] Created slice Slice /system/sshd-keygen.
[  208.898401] systemd[1]: Created slice Slice /system/systemd-fsck.
[  OK  ] Created slice Slice /system/systemd-fsck.
[  209.013853] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[  209.101812] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password R$B&u(Bests to Wall Directory Watch.
[  209.212538] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[  OK  ] Set up automount Arbitrary$B&s(B File System Automount Point.
[  209.316394] systemd[1]: Stopped target Switch Root.
[  OK  ] Stopped target Switch Root.
[  209.398533] systemd[1]: Stopped target Initrd File Systems.
[  OK  ] Stopped target Initrd File Systems.
[  209.491769] systemd[1]: Stopped target Initrd Root File System.
[  OK  ] Stopped target Initrd Root File System.
[  209.572344] systemd[1]: Reached target Local Integrity Protected Volumes.
[  OK  ] Reached target Local Integrity Protected Volumes.
[  209.672321] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[  209.762534] systemd[1]: Reached target Slice Units.
[  OK  ] Reached target Slice Units.
[  209.835776] systemd[1]: Reached target Local Verity Protected Volumes.
[  OK  ] Reached target Local Verity Protected Volumes.
[  210.123050] systemd[1]: Listening on Process Core Dump Socket.
[  OK  ] Listening on Process Core Dump Socket.
[  210.208432] systemd[1]: Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[  210.355123] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[  210.445121] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[  210.580242] systemd[1]: Activating swap /dev/disk/by-uuid/ab7d867c-3efa-4569-848c-42d403950ade...
         Activating swap /dev/disk/efa-4569-848c-42d403950ade...
[  210.818816] systemd[1]: Mounting Huge Pages File System...
         Mounting Huge Pages File System...
[  210.945787] Adding 2299900k swap on /dev/sda2.  Priority:-2 extents:1 across:2299900k FS
[  211.098991] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
[  211.313463] systemd[1]: Mounting Kernel Debug File System...
         Mounting Kernel Debug File System...
[  211.487185] systemd[1]: Mounting Kernel Trace File System...
         Mounting Kernel Trace File System...
[  211.752443] systemd[1]: Starting Create List of Static Device Nodes...
         Starting Create List of Static Device Nodes...
[  212.009803] systemd[1]: Starting Load Kernel Module configfs...
         Starting Load Kernel Module configfs...
[  212.204665] systemd[1]: Starting Load Kernel Module drm...
         Starting Load Kernel Module drm...
[  212.465698] systemd[1]: Starting Load Kernel Module fuse...
         Starting Load Kernel Module fuse...
[  212.822008] systemd[1]: Starting Read and set NIS domainname from /etc/sysconfig/network...
         Starting Read and set NIS $B&f(Brom /etc/sysconfig/network...
[  212.984947] systemd[1]: Stopped Journal Service.
[  OK  ] Stopped Journal Service.
[  213.109655] systemd[1]: systemd-journald.service: Consumed 4.489s CPU time.
[  213.531592] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[  213.674380] systemd[1]: Load Kernel Modules was skipped because all trigger condition checks failed.
[  213.992849] systemd[1]: Starting Generate network units from Kernel command line...
         Starting Generate network $B&t(Bs from Kernel command line...
[  214.471473] systemd[1]: Starting Remount Root and Kernel File Systems...
         Starting Remount Root and Kernel File Systems...
[  214.630418] systemd[1]: Repartition Root Disk was skipped because all trigger condition checks failed.
[  215.091176] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[  215.781829] systemd[1]: Starting Coldplug All udev Devices...
         Starting Coldplug All udev Devices...
[  216.717549] EXT4-fs (sda3): re-mounted. Quota mode: none.
[  217.623441] systemd[1]: Activated swap /dev/disk/by-uuid/ab7d867c-3efa-4569-848c-42d403950ade.
[  OK  ] Activated sw[  217.729966] fuse: init (API version 7.36)
ap /dev/disk/b$B&c(B-3efa-4569-848c-42d403950ade.
[  217.850963] systemd[1]: Mounted Huge Pages File System.
[  OK  ] Mounted Huge Pages File System.
[  217.985282] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.
[  218.092659] systemd[1]: Mounted Kernel Debug File System.
[  OK  ] Mounted Kernel Debug File System.
[  218.222616] systemd[1]: Mounted Kernel Trace File System.
[  OK  ] Mounted Kernel Trace File System.
[  218.419214] systemd[1]: Finished Create List of Static Device Nodes.
[  OK  ] Finished Create List of Static Device Nodes.
[  218.554125] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[  218.617050] systemd[1]: Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module configfs.
[  218.794947] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[  218.899328] systemd[1]: Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Module fuse.
[  219.008885] systemd[1]: modprobe@fuse.service: Consumed 1.041s CPU time.
[  219.137663] systemd[1]: Finished Read and set NIS domainname from /etc/sysconfig/network.
[  OK  ] Finished Read and set NIS $B&e(B from /etc/sysconfig/network.
[  219.298406] systemd[1]: Finished Generate network units from Kernel command line.
[  OK  ] Finished Generate network units from Kernel command line.
[  219.498424] systemd[1]: Finished Remount Root and Kernel File Systems.
[  OK  ] Finished Remount Root and Kernel File Systems.
[  219.688158] systemd[1]: Finished Apply Kernel Variables.
[  OK  ] Finished Apply Kernel Variables.
[  219.830773] systemd[1]: Reached target Swaps.
[  OK  ] Reached target Swaps.
[  220.252381] systemd[1]: Mounting FUSE Control File System...
         Mounting FUSE Control File System...
[  220.909615] systemd[1]: Mounting Kernel Configuration File System...
         Mounting Kernel Configuration File System...
[  221.041252] systemd[1]: First Boot Wizard was skipped because of a failed condition check (ConditionFirstBoot=yes).
[  221.221066] systemd[1]: Rebuild Hardware Database was skipped because of a failed condition check (ConditionNeedsUpdate=/etc).
[  221.743316] systemd[1]: Starting Load/Save Random Seed...
         Starting Load/Save Random Seed...
[  221.860407] systemd[1]: Create System Users was skipped because of a failed condition check (ConditionNeedsUpdate=/etc).
[  222.135800] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[  222.542616] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
[  222.930460] systemd[1]: Started Journal Service.
[  OK  ] Started Journal Service.
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Load/Save Random Seed.
         Starting Flush Journal to Persistent Storage...
[  226.807042] systemd-journald[332]: Received client request to flush runtime journal.
[  OK  ] Finished Flush Journal to Persistent Storage.
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Preparation for Local File Systems.
         Starting File System Check$B&e(Bafd-4c29-b689-d677fd88b080...
         Starting Rule-based Manage$B&f(Bor Device Events and Files...
[*     ] (1 of 5) A start job is running for$B&b(B689-d677fd88b080 (22s / no limit)
[  231.288297] ACPI: bus type drm_connector registered
[**    ] (1 of 5) A start job is running for$B&b(B689-d677fd88b080 (23s / no limit)
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished File System Check-eafd-4c29-b689-d677fd88b080.
         Mounting /boot...
[  233.098193] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[  OK  ] Mounted /boot.
[  OK  ] Reached target Local File Systems.
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting Create Volatile Files and Directories...
[  OK  ] Finished Tell Plymouth To Write Out Runtime Data.
[  OK  ] Finished Coldplug All udev Devices.
[***   ] (1 of 3) A start job is running for$B&p(B Virtual Console (29s / no limit)
[ ***  ] (2 of 3) A start job is running for$B&s(B and Directories (29s / no limit)
[  *** ] (2 of 3) A start job is running for$B&s(B and Directories (30s / no limit)
[   ***] (2 of 3) A start job is running for$B&s(B and Directories (30s / no limit)
[    **] (3 of 3) A start job is running forEvents and Files (31s / 1min 51s)
[     *] (3 of 3) A start job is running forEvents and Files (31s / 1min 51s)
[    **] (3 of 3) A start job is running forEvents and Files (32s / 1min 51s)
[   ***] (1 of 3) A start job is running for$B&p(B Virtual Console (32s / no limit)
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Finished Setup Virtual Console.
         Starting Show Plymouth Boot Screen...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password R$B&s(B to Plymouth Directory Watch.
[  OK  ] Reached target Local Encrypted Volumes.
[  *** ] A start job is running for Create V$B&s(B and Directories (36s / no limit)
[ ***  ] A start job is running for Create V$B&s(B and Directories (37s / no limit)
[***   ] A start job is running for Create V$B&s(B and Directories (37s / no limit)
[**    ] A start job is running for Create V$B&s(B and Directories (38s / no limit)
[*     ] A start job is running for Create V$B&s(B and Directories (39s / no limit)
[**    ] A start job is running for Create V$B&s(B and Directories (39s / no limit)
[***   ] A start job is running for Create V$B&s(B and Directories (40s / no limit)
[ ***  ] A start job is running for Create V$B&s(B and Directories (40s / no limit)
[  OK  ] Finished Create Volatile Files and Directories.
         Starting Security Auditing Service...
[  *** ] A start job is running for Security Auditing Service (43s / 2min 13s)
[   ***] A start job is running for Security Auditing Service (43s / 2min 13s)
[    **] A start job is running for Security Auditing Service (44s / 2min 13s)
[     *] A start job is running for Security Auditing Service (44s / 2min 13s)
[    **] A start job is running for Security Auditing Service (45s / 2min 13s)
[   ***] A start job is running for Security Auditing Service (45s / 2min 13s)
[  *** ] A start job is running for Security Auditing Service (46s / 2min 13s)
[ ***  ] A start job is running for Security Auditing Service (46s / 2min 13s)
[  OK  ] Started Security Auditing Service.
         Starting Record System Boot/Shutdown in UTMP...
         Starting Load Kernel Module configfs...
[  OK  ] Finished Record System Boot/Shutdown in UTMP.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Reached target System Initialization.
[  OK  ] Started CUPS Scheduler.
[  OK  ] Started Daily rotation of log files.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started daily update of the root trust anchor for DNSSEC.
[  OK  ] Reached target Path Units.
[  OK  ] Reached target Timer Units.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Listening on CUPS Scheduler.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on SSSD Kerberos$B&a(Bche Manager responder socket.
[  OK  ] Reached target Socket Units.
[  OK  ] Reached target Basic System.
         Starting Avahi mDNS/DNS-SD Stack...
         Starting NTP client/server...
         Starting Restore /run/initramfs on shutdown...
         Starting Authorization Manager...
         Starting System Logging Service...
[  OK  ] Reached target sshd-keygen.target.
[  OK  ] Reached target User and Group Name Lookups.
         Starting User Login Management...
[  OK  ] Started System Logging Service.
[  OK  ] Finished Restore /run/initramfs on shutdown.
         Starting D-Bus System Message Bus...
[***   ] (4 of 5) A start job is running forLogin Management (55s / 5min 52s)
[**    ] (5 of 5) A start job is running for NTP client/server (55s / 2min 20s)
[*     ] (5 of 5) A start job is running for NTP client/server (56s / 2min 20s)
[**    ] (5 of 5) A start job is running for NTP client/server (56s / 2min 20s)
[***   ] (1 of 5) A start job is running for$B&m(BDNS/DNS-SD Stack (57s / 2min 19s)
[ ***  ] (1 of 5) A start job is running for$B&m(BDNS/DNS-SD Stack (57s / 2min 19s)
[  *** ] (1 of 5) A start job is running for$B&m(BDNS/DNS-SD Stack (58s / 2min 19s)
[   ***] (2 of 5) A start job is running for$B&S(Bystem Message Bus (5s / 1min 30s)
[    **] (2 of 5) A start job is running for$B&S(Bystem Message Bus (5s / 1min 30s)
[     *] (2 of 5) A start job is running for$B&S(Bystem Message Bus (6s / 1min 30s)
[    **] (3 of 5) A start job is running for$B&r(Bization Manager (1min / 5min 50s)
[   ***] (3 of 5) A start job is running for$B&r(Bization Manager (1min / 5min 50s)
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started NTP client/server.
[  *** ] (1 of 3) A start job is running forDNS-SD Stack (1min 7s / 2min 19s)
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[ ***  ] (2 of 2) A start job is running for$B&i(Bn Management (1min 9s / 5min 52s)
[  OK  ] Started User Login Management.
[***   ] A start job is running for Authorization Manager (1min 12s / 5min 50s)
[**    ] A start job is running for Authorization Manager (1min 12s / 5min 50s)
[*     ] A start job is running for Authorization Manager (1min 12s / 5min 50s)
[**    ] A start job is running for Authorization Manager (1min 13s / 5min 50s)
[***   ] A start job is running for Authorization Manager (1min 13s / 5min 50s)
[ ***  ] A start job is running for Authorization Manager (1min 14s / 5min 50s)
[  *** ] A start job is running for Authorization Manager (1min 14s / 5min 50s)
[   ***] A start job is running for Authorization Manager (1min 15s / 5min 50s)
[    **] A start job is running for Authorization Manager (1min 15s / 5min 50s)
[     *] A start job is running for Authorization Manager (1min 16s / 5min 50s)
[  OK  ] Started Authorization Manager.
         Starting Modem Manager...
         Starting firewalld - dynamic firewall daemon...
[    **] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 19s / 2min 47s)
[   ***] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 19s / 2min 46s)
[  *** ] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 20s / 2min 46s)
[ ***  ] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 20s / 2min 46s)
[***   ] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 21s / 2min 47s)
[**    ] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 21s / 2min 47s)
[*     ] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 22s / 2min 47s)
[**    ] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 22s / 2min 46s)
[***   ] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 23s / 2min 46s)
[ ***  ] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 23s / 2min 46s)
[  *** ] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 24s / 2min 47s)
[   ***] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 24s / 2min 47s)
[    **] (1 of 2) A start job is running for$B&e(Bwall daemon (1min 25s / 2min 47s)
[     *] (2 of 2) A start job is running for$B&o(Bdem Manager (1min 25s / 2min 46s)
[  294.180346] NET: Registered PF_QIPCRTR protocol family
[  OK  ] Started Modem Manager.
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 28s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 28s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 29s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 29s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 30s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 30s / 2min 47s)
[*     ] A start job is running for firewall$B&e(Bwall daemon (1min 31s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 31s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 32s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 32s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 33s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 33s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 34s / 2min 47s)
[     *] A start job is running for firewall$B&e(Bwall daemon (1min 34s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 35s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 35s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 36s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 36s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 37s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 37s / 2min 47s)
[*     ] A start job is running for firewall$B&e(Bwall daemon (1min 38s / 2min 47s)
[**   [  306.963400] parport_pc 00:04: reported by Plug and Play ACPI
 ] A start job is running for firewall$B&e(Bwall daemon (1min 38s / 2min 47s)
[  307.299137] parport0: PC-style at 0x378, irq 7 [PCSPP,EPP]
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 39s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 39s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 40s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 40s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 41s / 2min 47s)
[     *] A start job is running for firewall$B&e(Bwall daemon (1min 41s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 42s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 42s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 43s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 43s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 44s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 44s / 2min 47s)
[*     ] A start job is running for firewall$B&e(Bwall daemon (1min 45s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 45s / 2min 47s)
[  314.439761] e100: Intel(R) PRO/100 Network Driver
[  314.458563] e100: Copyright(c) 1999-2006 Intel Corporation
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 46s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 46s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 47s / 2min 47s)
[  315.778822] e100 0000:00:12.0 eth0: addr 0xcf9ff000, irq 10, MAC addr 00:a0:c9:8c:94:28
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 48s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 48s / 2min 47s)
[     *] A start job is running for firewall$B&e(Bwall daemon (1min 49s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 50s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 50s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 51s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 51s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 52s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 52s / 2min 47s)
[*     ] A start job is running for firewall$B&e(Bwall daemon (1min 53s / 2min 47s)
[  321.988852] input: PC Speaker as /devices/platform/pcspkr/input/input4
[**    ] A start job is running for firewall$B&e(Bwall daemon (1min 54s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (1min 55s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (1min 55s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (1min 56s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (1min 56s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 57s / 2min 47s)
[     *] A start job is running for firewall$B&e(Bwall daemon (1min 58s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (1min 59s / 2min 47s)
[   ***] A start job is running for firewallfirewall daemon (2min / 2min 47s)
[  *** ] A start job is running for firewallfirewall daemon (2min / 2min 47s)
[ ***  ] A start job is running for firewall$B&r(Bewall daemon (2min 1s / 2min 47s)
[***   ] A start job is running for firewall$B&r(Bewall daemon (2min 1s / 2min 47s)
[**    ] A start job is running for firewall$B&r(Bewall daemon (2min 2s / 2min 47s)
[*     ] A start job is running for firewall$B&r(Bewall daemon (2min 2s / 2min 47s)
[**    ] A start job is running for firewall$B&r(Bewall daemon (2min 3s / 2min 47s)
[***   ] A start job is running for firewall$B&r(Bewall daemon (2min 3s / 2min 47s)
[ ***  ] A start job is running for firewall$B&r(Bewall daemon (2min 4s / 2min 47s)
[  *** ] A start job is running for firewall$B&r(Bewall daemon (2min 4s / 2min 47s)
[   ***] A start job is running for firewall$B&r(Bewall daemon (2min 5s / 2min 47s)
[    **] A start job is running for firewall$B&r(Bewall daemon (2min 5s / 2min 47s)
[     *] A start job is running for firewall$B&r(Bewall daemon (2min 6s / 2min 47s)
[    **] A start job is running for firewall$B&r(Bewall daemon (2min 7s / 2min 47s)
[   ***] A start job is running for firewall$B&r(Bewall daemon (2min 7s / 2min 47s)
[  *** ] A start job is running for firewall$B&r(Bewall daemon (2min 8s / 2min 47s)
[ ***  ] A start job is running for firewall$B&r(Bewall daemon (2min 8s / 2min 47s)
[***   ] A start job is running for firewall$B&r(Bewall daemon (2min 9s / 2min 47s)
[**    ] A start job is running for firewall$B&r(Bewall daemon (2min 9s / 2min 47s)
[*     ] A start job is running for firewall$B&e(Bwall daemon (2min 10s / 2min 47s)
[**    ] A start job is running for firewall$B&e(Bwall daemon (2min 10s / 2min 47s)
[***   ] A start job is running for firewall$B&e(Bwall daemon (2min 11s / 2min 47s)
[ ***  ] A start job is running for firewall$B&e(Bwall daemon (2min 11s / 2min 47s)
[  *** ] A start job is running for firewall$B&e(Bwall daemon (2min 12s / 2min 47s)
[   ***] A start job is running for firewall$B&e(Bwall daemon (2min 12s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (2min 13s / 2min 47s)
[     *] A start job is running for firewall$B&e(Bwall daemon (2min 13s / 2min 47s)
[    **] A start job is running for firewall$B&e(Bwall daemon (2min 14s / 2min 47s)
[  OK  ] Started firewalld - dynamic firewall daemon.
[  OK  ] Reached target Preparation for Network.
         Starting Network Manager...
[   ***] A start job is running for Network Manager (2min 17s / 3min 44s)
[  *** ] A start job is running for Network Manager (2min 17s / 3min 44s)
[ ***  ] A start job is running for Network Manager (2min 18s / 3min 44s)
[***   ] A start job is running for Network Manager (2min 18s / 3min 44s)
[**    ] A start job is running for Network Manager (2min 19s / 3min 44s)
[*     ] A start job is running for Network Manager (2min 19s / 3min 44s)
[**    ] A start job is running for Network Manager (2min 20s / 3min 44s)
[***   ] A start job is running for Network Manager (2min 20s / 3min 44s)
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
         Starting CUPS Scheduler...
         Starting Crash recovery kernel arming...
         Starting OpenSSH server daemon...
         Starting Permit User Sessions...
[ ***  ] (1 of 4) A start job is running for$B&P(BS Scheduler (1min 37s / no limit)
         Starting Hostname Service...
[  OK  ] Finished Permit User Sessions.
[  OK  ] Started Command Scheduler.
         Starting Hold until boot process finishes up...
         Starting Terminate Plymouth Boot Screen...
[  OK  ] Started CUPS Scheduler.
[  OK  ] Finished Hold until boot process finishes up.
[  OK  ] Finished Terminate Plymouth Boot Screen.
[FAILED] Failed to start Crash recovery kernel arming.

Rocky Linux 9.1 (Blue Onyx)
Kernel 5.18.0-13.4.el9.v1.i586 on an i586

cygnus login: [  380.893285] e100 0000:00:12.0 enp0s18: renamed from eth0
[  383.290835] ppdev: user-space parallel port driver
[  389.510959] e100 0000:00:12.0 enp0s18: NIC Link is Up 100 Mbps Full Duplex
[  389.522877] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s18: link becomes ready
[  417.884024] systemd-journald[332]: Data hash table of /run/log/journal/9e16b5ac578a47b082279c76b767fcb2/system.journal has a fill level at 75.1 (3381 of 4501 items, 2592768 file size, 766 bytes per hash table item), suggesting rotation.
[  417.962127] systemd-journald[332]: /run/log/journal/9e16b5ac578a47b082279c76b767fcb2/system.journal: Journal header limits reached or header out-of-date, rotating.
[  481.644135] [drm] radeon kernel modesetting enabled.
[  481.687075] radeon 0000:01:00.0: vgaarb: deactivate vga console
[  481.780933] Console: switching to colour dummy device 80x25
[  481.916232] [drm] initializing kernel modesetting (RV280 0x1002:0x5960 0x148C:0x2094 0x01).
[  481.926652] radeon 0000:01:00.0: vram limit (0) must be a power of 2
[  481.945074] [drm] Forcing AGP to PCI mode
[  482.159595] [drm] Generation 2 PCI interface, using max accessible memory
[  482.170690] radeon 0000:01:00.0: VRAM: 128M 0x00000000C0000000 - 0x00000000C7FFFFFF (128M used)
[  482.183200] radeon 0000:01:00.0: GTT: 512M 0x00000000A0000000 - 0x00000000BFFFFFFF
[  482.305883] [drm] Detected VRAM RAM=128M, BAR=128M
[  482.324843] [drm] RAM width 64bits DDR
[  482.416688] [drm] radeon: 128M of VRAM memory ready
[  482.465653] [drm] radeon: 512M of GTT memory ready.
[  482.592899] [drm] GART: num cpu pages 131072, num gpu pages 131072
[  482.722176] [drm] PCI GART of 512M enabled (table at 0x0000000008800000).
[  482.785832] radeon 0000:01:00.0: WB disabled
[  482.801685] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x00000000a0000000
[  482.926407] radeon 0000:01:00.0: Disabling GPU acceleration
[  483.016860] [drm] radeon: cp finalized
[  483.215506] [drm] Radeon Display Connectors
[  483.230945] [drm] Connector 0:
[  483.240708] [drm]   VGA-1
[  483.245487] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[  483.261716] [drm]   Encoders:
[  483.269703] [drm]     CRT1: INTERNAL_DAC1
[  483.283966] [drm] Connector 1:
[  483.292497] [drm]   DVI-I-1
[  483.299440] [drm]   HPD1
[  483.314894] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[  483.321126] [drm]   Encoders:
[  483.329108] [drm]     CRT2: INTERNAL_DAC2
[  483.343340] [drm]     DFP1: INTERNAL_TMDS1
[  483.348086] [drm] Connector 2:
[  483.356597] [drm]   SVIDEO-1
[  483.374064] [drm]   Encoders:
[  483.382052] [drm]     TV1: INTERNAL_DAC2
[  484.065702] drm_vblank_flush_worker: vblank->worker NULL? returning
[  484.083550] __wake_up_common: wq_head->head.next=0x0 is NULL, returning immediately
[  484.093420] BUG: kernel NULL pointer dereference, address: 000000cc
[  484.093420] #PF: supervisor read access in kernel mode
[  484.093420] #PF: error_code(0x0000) - not-present page
[  484.093420] *pde = 00000000 
[  484.093420] Oops: 0000 [#1] PREEMPT SMP
[  484.093420] CPU: 0 PID: 361 Comm: systemd-udevd Not tainted 5.18.0-13.4.el9.v1.i586 #1
[  484.093420] Hardware name: System Manufacturer System Name/ALADDIN5, BIOS 0626 07/15/95
[  484.093420] EIP: drm_vblank_cancel_pending_works+0x13/0xa0 [drm]
[  484.093420] Code: f4 5b 5e 5f 5d c3 90 0f 0b 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 3e 8d 74 26 00 55 89 e5 57 56 53 83 ec 08 89 45 f0 8b 00 <8b> 80 cc 00 00 00 85 c0 74 7b 8b 45 f0 05 d4 00 00 00 8b 18 89 45
[  484.093420] EAX: 00000000 EBX: c558dcb0 ECX: c6e4df30 EDX: c558dcc4
[  484.093420] ESI: c558dcb0 EDI: c6e4df00 EBP: c3b41c74 ESP: c3b41c60
[  484.093420] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010086
[  484.093420] CR0: 80050033 CR2: 000000cc CR3: 0552b000 CR4: 00000010
[  484.093420] Call Trace:
[  484.093420]  drm_crtc_vblank_off+0x1ba/0x230 [drm]
[  484.093420]  radeon_crtc_dpms+0x197/0x1b0 [radeon]
[  484.093420]  radeon_crtc_disable+0x16/0xa0 [radeon]
[  484.093420]  __drm_helper_disable_unused_functions+0x74/0xc0 [drm_kms_helper]
[  484.093420]  drm_helper_disable_unused_functions+0x3c/0x50 [drm_kms_helper]
[  484.093420]  radeon_fbdev_init+0xb0/0x130 [radeon]
[  484.093420]  radeon_modeset_init+0x25d/0x320 [radeon]
[  484.093420]  radeon_driver_load_kms+0xc4/0x240 [radeon]
[  484.093420]  drm_dev_register+0xb4/0x1a0 [drm]
[  484.093420]  radeon_pci_probe+0xc0/0x100 [radeon]
[  484.093420]  pci_device_probe+0xaa/0x160
[  484.093420]  really_probe+0x15a/0x320
[  484.093420]  __driver_probe_device+0x109/0x1e0
[  484.093420]  ? pci_match_id.part.0+0x86/0xa0
[  484.093420]  driver_probe_device+0x1f/0x90
[  484.093420]  __driver_attach+0x93/0x170
[  484.093420]  ? __device_attach_driver+0xe0/0xe0
[  484.093420]  bus_for_each_dev+0x58/0x90
[  484.093420]  driver_attach+0x19/0x20
[  484.093420]  ? __device_attach_driver+0xe0/0xe0
[  484.093420]  bus_add_driver+0x12f/0x1d0
[  484.093420]  driver_register+0x79/0xc0
[  484.093420]  ? 0xf81cd000
[  484.093420]  __pci_register_driver+0x4c/0x50
[  484.093420]  radeon_module_init+0x5c/0x1000 [radeon]
[  484.093420]  do_one_initcall+0x3e/0x1c0
[  484.093420]  ? __vunmap+0x20b/0x2a0
[  484.093420]  ? __vunmap+0x20b/0x2a0
[  484.093420]  ? kmem_cache_alloc_trace+0x38/0x440
[  484.093420]  do_init_module+0x43/0x250
[  484.093420]  load_module+0x935/0x9e0
[  484.093420]  __ia32_sys_init_module+0x15d/0x180
[  484.093420]  do_int80_syscall_32+0x2e/0x80
[  484.093420]  entry_INT80_32+0xf0/0xf0
[  484.093420] EIP: 0xb792ae4e
[  484.093420] Code: 0f 83 d6 06 00 00 c3 66 90 66 90 90 57 56 53 8b 7c 24 20 8b 74 24 1c 8b 54 24 18 8b 4c 24 14 8b 5c 24 10 b8 80 00 00 00 cd 80 <5b> 5e 5f 3d 01 f0 ff ff 0f 83 a4 06 00 00 c3 66 90 90 53 8b 54 24
[  484.093420] EAX: ffffffda EBX: b5382010 ECX: 0022e942 EDX: b7b69274
[  484.093420] ESI: b79a1e96 EDI: b7b70dd8 EBP: 02188640 ESP: bfe917d0
[  484.093420] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[  484.093420] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib radeon(+) nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 gpu_sched i2c_algo_bit drm_dp_helper cec drm_ttm_helper ppdev ttm rfkill ip_set nf_tables libcrc32c nfnetlink drm_kms_helper pcspkr syscopyarea e100 sysfillrect parport_pc sysimgblt mii fb_sys_fops parport qrtr drm fuse drm_panel_orientation_quirks ext4 mbcache jbd2 sd_mod t10_pi sr_mod crc64_rocksoft_generic cdrom crc64_rocksoft crc64 sg ata_generic pata_ali libata serio_raw
[  484.093420] CR2: 00000000000000cc
[  484.093420] ---[ end trace 0000000000000000 ]---
[  484.093420] EIP: drm_vblank_cancel_pending_works+0x13/0xa0 [drm]
[  484.093420] Code: f4 5b 5e 5f 5d c3 90 0f 0b 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00 3e 8d 74 26 00 55 89 e5 57 56 53 83 ec 08 89 45 f0 8b 00 <8b> 80 cc 00 00 00 85 c0 74 7b 8b 45 f0 05 d4 00 00 00 8b 18 89 45
[  484.093420] EAX: 00000000 EBX: c558dcb0 ECX: c6e4df30 EDX: c558dcc4
[  484.093420] ESI: c558dcb0 EDI: c6e4df00 EBP: c3b41c74 ESP: c3b41c60
[  484.093420] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010086
[  484.093420] CR0: 80050033 CR2: 000000cc CR3: 0552b000 CR4: 00000010
[  484.093420] Kernel panic - not syncing: Fatal exception
[  484.093420] Kernel Offset: disabled
[  484.093420] ---[ end Kernel panic - not syncing: Fatal exception ]---
------=_NextPart_002_06064_230723.205103--
