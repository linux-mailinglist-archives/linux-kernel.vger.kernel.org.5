Return-Path: <linux-kernel+bounces-83050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F89868DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F51F21757
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BE13AA3C;
	Tue, 27 Feb 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NePjpJBE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433613A890
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030234; cv=none; b=RVrQQLgSe0InZUKvU0TkzNldVjk/0+1v6bZP3oiI/Pw01ZivdLgtSS/lH4AhnO/nyOEi7I6gmQrFqrAm6JngmfJFNTs7dpTg9WAMHTV1jMfqrfyoiPCBc/JivPuLAwk7TcPGkEAlQRkDa6am8R8k9NYBVXrFCpY360c3VKzKii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030234; c=relaxed/simple;
	bh=s2swVY4nLJxbdWPkZNLBLx/AGm2A2Ou6yPGQb8BzR5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=On5/00Pw1CoCf7xs/wzSavCUyFix1bTXXc80GlaW0ic4GzbRtGU3LZRpUBF8c3noBf8B4kw/UqlTDrwZ/D/sA1UD7zTHJ9DZgmElP2qSa32qvs6vFoyHnhRaVkNv07eENC4sV2H/2Dt8MUy7yPw2fynla6gxuk3erQ0wOTCKyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NePjpJBE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709030230; x=1740566230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s2swVY4nLJxbdWPkZNLBLx/AGm2A2Ou6yPGQb8BzR5w=;
  b=NePjpJBEMZKWM0k4YL4uz8Eg9HYmcT0RPogxoon1A7JOt4Zk9PsQfSqO
   kCwvbESn6Btwx2C8wDrEbC8FesceFVkFGT+8zPT0loCM1RSWNoJQFutTS
   Zy+fXIKAJx/K3JYguHpWYn8q6w6glDwU2I3+5zEXj2wRGX3iQrWOqBCzh
   8QUxQCmYjnHVnOzStgs2TVysf4UgbhDMD6V/H7Xi6lFlKxtHrSUyGQnK1
   jCa60KHYYkxIGpXWBFvU2VLn5Q0T40IfJo6zyCjE6sTw9j8IXgaby65EN
   YiUC+XVlwHFqmm/Cl+yoJcd2+8OpRx6GN9/vuUoir7iBWaRlEBf95DrA7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14002636"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14002636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:37:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11610927"
Received: from bdallmer-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.187])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:37:05 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>, intel-gfx@lists.freedesktop.org,
 ville.syrjala@linux.intel.com
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, lkml
 <linux-kernel@vger.kernel.org>
Subject: Re: BUG: sleeping function called from invalid context at
 drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
In-Reply-To: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local>
Date: Tue, 27 Feb 2024 12:37:02 +0200
Message-ID: <87jzmqjir5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 27 Feb 2024, Borislav Petkov <bp@alien8.de> wrote:
> Hi all,
>
> this lockdep splat at the end is from an old Atom 32-bit laptop with the
> latest Linus + tip lineup:

Is this a recent regression?

At a glance, I couldn't quite pinpoint the root cause. It depends on
cursor_needs_physical == true, which means quite a limited set of
platforms.

Ville probably has a better idea here.


BR,
Jani.

>
> [    0.000000] Linux version 6.8.0-rc6+ (boris@zn) (gcc (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Tue Feb 27 10:43:15 CET 2024
> [    0.000000] Disabled fast string operations
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003f375fff] usable
> [    0.000000] BIOS-e820: [mem 0x000000003f376000-0x000000003f3befff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000003f3bf000-0x000000003f46cfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000003f46d000-0x000000003f4befff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000003f4bf000-0x000000003f4effff] usable
> [    0.000000] BIOS-e820: [mem 0x000000003f4f0000-0x000000003f4fefff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000003f4ff000-0x000000003f4fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000003f500000-0x000000003fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed14000-0x00000000fed19fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
> [    0.000000] APIC: Static calls initialized
> [    0.000000] SMBIOS 2.4 present.
> [    0.000000] DMI: Acer AOA150/, BIOS v0.3309 10/06/2008
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 1595.973 MHz processor
> [    0.006006] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.006046] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.006089] last_pfn = 0x3f500 max_arch_pfn = 0x100000
> [    0.006112] MTRR map: 9 entries (5 fixed + 4 variable; max 21), built from 8 variable MTRRs
> [    0.006125] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.006307] initial memory mapped: [mem 0x00000000-0x033fffff]
> [    0.006444] RAMDISK: [mem 0x36eeb000-0x3776cfff]
> [    0.006458] Allocated new RAMDISK: [mem 0x36669000-0x36eea545]
> [    0.017353] Move RAMDISK from [mem 0x36eeb000-0x3776c545] to [mem 0x36669000-0x36eea545]
> [    0.017396] ACPI: Early table checksum verification disabled
> [    0.017418] ACPI: RSDP 0x00000000000FE020 000024 (v02 ACRSYS)
> [    0.017452] ACPI: XSDT 0x000000003F4FE120 000064 (v01 ACRSYS ACRPRDCT 00000001      01000013)
> [    0.017489] ACPI: FACP 0x000000003F4FC000 0000F4 (v04 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017526] ACPI: DSDT 0x000000003F4F2000 005DE6 (v01 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017557] ACPI: FACS 0x000000003F488000 000040
> [    0.017584] ACPI: FACS 0x000000003F488000 000040
> [    0.017611] ACPI: SSDT 0x000000003F4FD000 0004C4 (v02 PmRef  CpuPm    00003000 INTL 20051117)
> [    0.017643] ACPI: HPET 0x000000003F4FB000 000038 (v01 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017672] ACPI: APIC 0x000000003F4FA000 000068 (v02 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017702] ACPI: MCFG 0x000000003F4F9000 00003C (v01 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017731] ACPI: ASF! 0x000000003F4F8000 0000A5 (v32 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017761] ACPI: SLIC 0x000000003F4F1000 000176 (v01 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017790] ACPI: BOOT 0x000000003F4F0000 000028 (v01 ACRSYS ACRPRDCT 00000001 1025 01000013)
> [    0.017818] ACPI: Reserving FACP table memory at [mem 0x3f4fc000-0x3f4fc0f3]
> [    0.017830] ACPI: Reserving DSDT table memory at [mem 0x3f4f2000-0x3f4f7de5]
> [    0.017840] ACPI: Reserving FACS table memory at [mem 0x3f488000-0x3f48803f]
> [    0.017850] ACPI: Reserving FACS table memory at [mem 0x3f488000-0x3f48803f]
> [    0.017860] ACPI: Reserving SSDT table memory at [mem 0x3f4fd000-0x3f4fd4c3]
> [    0.017870] ACPI: Reserving HPET table memory at [mem 0x3f4fb000-0x3f4fb037]
> [    0.017880] ACPI: Reserving APIC table memory at [mem 0x3f4fa000-0x3f4fa067]
> [    0.017890] ACPI: Reserving MCFG table memory at [mem 0x3f4f9000-0x3f4f903b]
> [    0.017900] ACPI: Reserving ASF! table memory at [mem 0x3f4f8000-0x3f4f80a4]
> [    0.017910] ACPI: Reserving SLIC table memory at [mem 0x3f4f1000-0x3f4f1175]
> [    0.017920] ACPI: Reserving BOOT table memory at [mem 0x3f4f0000-0x3f4f0027]
> [    0.017960] 129MB HIGHMEM available.
> [    0.017971] 883MB LOWMEM available.
> [    0.017979]   mapped low ram: 0 - 373fe000
> [    0.017987]   low ram: 0 - 373fe000
> [    0.018006] Zone ranges:
> [    0.018014]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.018031]   Normal   [mem 0x0000000001000000-0x00000000373fdfff]
> [    0.018048]   HighMem  [mem 0x00000000373fe000-0x000000003f4fffff]
> [    0.018064] Movable zone start for each node
> [    0.018071] Early memory node ranges
> [    0.018078]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.018088]   node   0: [mem 0x0000000000100000-0x000000003f375fff]
> [    0.018098]   node   0: [mem 0x000000003f3bf000-0x000000003f46cfff]
> [    0.018107]   node   0: [mem 0x000000003f4bf000-0x000000003f4effff]
> [    0.018117]   node   0: [mem 0x000000003f4ff000-0x000000003f4fffff]
> [    0.018129] Initmem setup node 0 [mem 0x0000000000001000-0x000000003f4fffff]
> [    0.027221] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.027404] On node 0, zone DMA: 97 pages in unavailable ranges
> [    0.037625] On node 0, zone HighMem: 73 pages in unavailable ranges
> [    0.037649] On node 0, zone HighMem: 82 pages in unavailable ranges
> [    0.037660] On node 0, zone HighMem: 15 pages in unavailable ranges
> [    0.037687] Reserving Intel graphics memory at [mem 0x3f800000-0x3fffffff]
> [    0.038115] ACPI: PM-Timer IO Port: 0x408
> [    0.038145] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.038158] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.038233] IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
> [    0.038263] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.038276] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.038296] ACPI: Using ACPI (MADT) for SMP configuration information
> [    0.038306] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.038330] CPU topo: Max. logical packages:   1
> [    0.038339] CPU topo: Max. logical dies:       1
> [    0.038347] CPU topo: Max. dies per package:   1
> [    0.038355] CPU topo: Max. threads per core:   2
> [    0.038363] CPU topo: Num. cores per package:     1
> [    0.038371] CPU topo: Num. threads per package:   2
> [    0.038379] CPU topo: Allowing 2 present CPUs plus 0 hotplug CPUs
> [    0.038485] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.038499] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.038509] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> [    0.038519] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> [    0.038530] PM: hibernation: Registered nosave memory: [mem 0x3f376000-0x3f3befff]
> [    0.038542] PM: hibernation: Registered nosave memory: [mem 0x3f46d000-0x3f4befff]
> [    0.038555] PM: hibernation: Registered nosave memory: [mem 0x3f4f0000-0x3f4fefff]
> [    0.038582] [mem 0x40000000-0xdfffffff] available for PCI devices
> [    0.038599] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.038650] setup_percpu: NR_CPUS:2 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
> [    0.045203] percpu: Embedded 353 pages/cpu s1417084 r0 d28804 u1445888
> [    0.045241] pcpu-alloc: s1417084 r0 d28804 u1445888 alloc=353*4096
> [    0.045263] pcpu-alloc: [0] 0 [0] 1 
> [    0.045341] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.8.0-rc6+ root=/dev/sda1 ro resume=/dev/sda2 log_bug_len=10M ignore_loglevel
> [    0.045640] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.8.0-rc6+ log_bug_len=10M", will be passed to user space.
> [    0.045669] printk: log_buf_len individual max cpu contribution: 2097152 bytes
> [    0.045681] printk: log_buf_len total cpu_extra contributions: 2097152 bytes
> [    0.045690] printk: log_buf_len min size: 2097152 bytes
> [    0.080466] printk: log_buf_len: 4194304 bytes
> [    0.080488] printk: early log buf free: 2089852(99%)
> [    0.081082] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
> [    0.081395] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.081514] Built 1 zonelists, mobility grouping on.  Total pages: 257292
> [    0.081559] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.081572] Initializing HighMem for node 0 (000373fe:0003f500)
> [    0.191017] Initializing Movable for node 0 (00000000:00000000)
> [    0.200975] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    0.201020] Memory: 965396K/1036240K available (10703K kernel code, 7233K rwdata, 3876K rodata, 2196K init, 8592K bss, 70844K reserved, 0K cma-reserved, 131424K highmem)
> [    0.201537] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.201700] ftrace: allocating 38723 entries in 76 pages
> [    0.215339] ftrace: allocated 76 pages with 3 groups
> [    0.215876] trace event string verifier disabled
> [    0.216046] Dynamic Preempt: full
> [    0.216414] Running RCU self tests
> [    0.216423] Running RCU synchronous self tests
> [    0.216459] rcu: Preemptible hierarchical RCU implementation.
> [    0.216467] rcu: 	RCU lockdep checking is enabled.
> [    0.216475] 	Trampoline variant of Tasks RCU enabled.
> [    0.216482] 	Rude variant of Tasks RCU enabled.
> [    0.216490] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.216617] Running RCU synchronous self tests
> [    0.223565] NR_IRQS: 2304, nr_irqs: 440, preallocated irqs: 16
> [    0.224284] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.227419] Console: colour VGA+ 80x25
> [    0.227493] printk: legacy console [tty0] enabled
> [    0.251847] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.252074] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.252219] ... MAX_LOCK_DEPTH:          48
> [    0.252365] ... MAX_LOCKDEP_KEYS:        8192
> [    0.252512] ... CLASSHASH_SIZE:          4096
> [    0.252660] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.252808] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.252959] ... CHAINHASH_SIZE:          32768
> [    0.253107]  memory used by lock dependency info: 4125 kB
> [    0.253268]  memory used for stack traces: 2112 kB
> [    0.253422]  per task-struct memory footprint: 2112 bytes
> [    0.253638] ACPI: Core revision 20230628
> [    0.254795] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.255154] APIC: Switch to symmetric I/O mode setup
> [    0.256619] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.261135] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x170148dc4d1, max_idle_ns: 440795285318 ns
> [    0.262584] Calibrating delay loop (skipped), value calculated using timer frequency.. 3191.94 BogoMIPS (lpj=1595973)
> [    0.262894] Disabled fast string operations
> [    0.263070] CPU0: Thermal monitoring enabled (TM1)
> [    0.263673] process: using mwait in idle threads
> [    0.263868] Last level iTLB entries: 4KB 32, 2MB 0, 4MB 0
> [    0.264049] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 8, 1GB 0
> [    0.264269] x86/fpu: x87 FPU will use FXSAVE
> [    0.266513] Freeing SMP alternatives memory: 32K
> [    0.266607] pid_max: default: 32768 minimum: 301
> [    0.267110] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.267363] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> [    0.270603] Running RCU synchronous self tests
> [    0.271617] Running RCU synchronous self tests
> [    0.374472] smpboot: CPU0: Intel(R) Atom(TM) CPU N270   @ 1.60GHz (family: 0x6, model: 0x1c, stepping: 0x2)
> [    0.377076] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
> [    0.377659] RCU Tasks Rude: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
> [    0.378318] Running RCU Tasks wait API self tests
> [    0.480815] Running RCU Tasks Rude wait API self tests
> [    0.481458] Performance Events: PEBS fmt0+, LBR disabled due to erratumAtom events, Intel PMU driver.
> [    0.481628] ... version:                3
> [    0.481793] ... bit width:              40
> [    0.481955] ... generic registers:      2
> [    0.482115] ... value mask:             000000ffffffffff
> [    0.482298] ... max period:             000000007fffffff
> [    0.482605] ... fixed-purpose events:   3
> [    0.482767] ... event mask:             0000000700000003
> [    0.484070] signal: max sigframe size: 1440
> [    0.486371] rcu: Hierarchical SRCU implementation.
> [    0.486612] rcu: 	Max phase no-delay instances is 400.
> [    0.489636] smp: Bringing up secondary CPUs ...
> [    0.492276] smpboot: x86: Booting SMP configuration:
> [    0.492508] .... node  #0, CPUs:      #1
> [    0.033236] Disabled fast string operations
> [    0.494765] smp: Brought up 1 node, 2 CPUs
> [    0.495152] smpboot: Total of 2 processors activated (6383.89 BogoMIPS)
> [    0.498897] devtmpfs: initialized
> [    0.505899] ACPI: PM: Registering ACPI NVS region [mem 0x3f46d000-0x3f4befff] (335872 bytes)
> [    0.508630] Running RCU synchronous self tests
> [    0.508884] Running RCU synchronous self tests
> [    0.509415] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.509642] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
> [    0.512895] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.520415] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.520443] thermal_sys: Registered thermal governor 'step_wise'
> [    0.520611] thermal_sys: Registered thermal governor 'user_space'
> [    0.521133] cpuidle: using governor ladder
> [    0.521741] cpuidle: using governor menu
> [    0.522317] Simple Boot Flag value 0x5 read from CMOS RAM was invalid
> [    0.522525] Simple Boot Flag at 0x44 set to 0x1
> [    0.523472] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
> [    0.523622] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as E820 entry
> [    0.523833] PCI: Using ECAM for extended config space
> [    0.524030] PCI: Using configuration type 1 for base access
> [    0.525282] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
> [    0.550659] ACPI: Added _OSI(Module Device)
> [    0.550898] ACPI: Added _OSI(Processor Device)
> [    0.551127] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.551361] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.591178] Callback from call_rcu_tasks_rude() invoked.
> [    0.638884] ACPI: 2 ACPI AML tables successfully acquired and loaded
> [    0.653941] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.670421] ACPI: Dynamic OEM Table Load:
> [    0.670667] ACPI: SSDT 0x00000000C35BC400 000239 (v02 PmRef  Cpu0Ist  00003000 INTL 20051117)
> [    0.684833] ACPI: Dynamic OEM Table Load:
> [    0.685114] ACPI: SSDT 0x00000000C371C800 0001C7 (v02 PmRef  Cpu0Cst  00003001 INTL 20051117)
> [    0.688870] Callback from call_rcu_tasks() invoked.
> [    0.701069] ACPI: Dynamic OEM Table Load:
> [    0.701336] ACPI: SSDT 0x00000000C3439900 0000D0 (v02 PmRef  Cpu1Ist  00003000 INTL 20051117)
> [    0.714777] ACPI: Dynamic OEM Table Load:
> [    0.715039] ACPI: SSDT 0x00000000C3510D80 000083 (v02 PmRef  Cpu1Cst  00003000 INTL 20051117)
> [    0.730296] ACPI: _OSC evaluated successfully for all CPUs
> [    0.732665] ACPI: EC: EC started
> [    0.732856] ACPI: EC: interrupt blocked
> [    0.754548] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.754786] ACPI: \_SB_.PCI0.LPC_.EC0_: Boot DSDT EC used to handle transactions
> [    0.755032] ACPI: Interpreter enabled
> [    0.755602] ACPI: PM: (supports S0 S3 S4 S5)
> [    0.755808] ACPI: Using IOAPIC for interrupt routing
> [    0.756443] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.756604] PCI: Using E820 reservations for host bridge windows
> [    0.760745] ACPI: Enabled 10 GPEs in block 00 to 1F
> [    0.906821] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.907130] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.908552] ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0._OSC.CAPB], AE_ALREADY_EXISTS (20230628/dsfield-184)
> [    0.908955] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20230628/dswload2-477)
> [    0.909272] ACPI Error: Aborting method \_SB.PCI0._OSC due to previous error (AE_ALREADY_EXISTS) (20230628/psparse-529)
> [    0.909697] acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
> [    0.909920] acpi PNP0A08:00: _OSC: platform willing to grant [PME AER PCIeCapability LTR]
> [    0.910203] acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_ALREADY_EXISTS)
> [    0.920472] PCI host bridge to bus 0000:00
> [    0.920615] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.920839] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.921076] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.921330] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
> [    0.921612] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.922199] pci 0000:00:00.0: [8086:27ac] type 00 class 0x060000 conventional PCI endpoint
> [    0.924202] pci 0000:00:02.0: [8086:27ae] type 00 class 0x030000 conventional PCI endpoint
> [    0.924519] pci 0000:00:02.0: BAR 0 [mem 0x58480000-0x584fffff]
> [    0.924628] pci 0000:00:02.0: BAR 1 [io  0x60c0-0x60c7]
> [    0.924839] pci 0000:00:02.0: BAR 2 [mem 0x40000000-0x4fffffff pref]
> [    0.925085] pci 0000:00:02.0: BAR 3 [mem 0x58500000-0x5853ffff]
> [    0.925609] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.928759] pci 0000:00:02.1: [8086:27a6] type 00 class 0x038000 conventional PCI endpoint
> [    0.929091] pci 0000:00:02.1: BAR 0 [mem 0x58400000-0x5847ffff]
> [    0.930948] pci 0000:00:1b.0: [8086:27d8] type 00 class 0x040300 PCIe Root Complex Integrated Endpoint
> [    0.931321] pci 0000:00:1b.0: BAR 0 [mem 0x58540000-0x58543fff 64bit]
> [    0.931986] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.934921] pci 0000:00:1c.0: [8086:27d0] type 01 class 0x060400 PCIe Root Port
> [    0.935307] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.935507] pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
> [    0.935615] pci 0000:00:1c.0:   bridge window [mem 0x57300000-0x583fffff]
> [    0.935866] pci 0000:00:1c.0:   bridge window [mem 0x50000000-0x50ffffff 64bit pref]
> [    0.936640] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.939606] pci 0000:00:1c.1: [8086:27d2] type 01 class 0x060400 PCIe Root Port
> [    0.939972] pci 0000:00:1c.1: PCI bridge to [bus 02]
> [    0.940187] pci 0000:00:1c.1:   bridge window [io  0x3000-0x4fff]
> [    0.940401] pci 0000:00:1c.1:   bridge window [mem 0x56300000-0x572fffff]
> [    0.940639] pci 0000:00:1c.1:   bridge window [mem 0x51000000-0x520fffff 64bit pref]
> [    0.941244] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> [    0.944146] pci 0000:00:1c.2: [8086:27d4] type 01 class 0x060400 PCIe Root Port
> [    0.944510] pci 0000:00:1c.2: PCI bridge to [bus 03]
> [    0.944618] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
> [    0.944830] pci 0000:00:1c.2:   bridge window [mem 0x55200000-0x562fffff]
> [    0.945098] pci 0000:00:1c.2:   bridge window [mem 0x52100000-0x530fffff 64bit pref]
> [    0.945846] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> [    0.948683] pci 0000:00:1c.3: [8086:27d6] type 01 class 0x060400 PCIe Root Port
> [    0.949055] pci 0000:00:1c.3: PCI bridge to [bus 04]
> [    0.949263] pci 0000:00:1c.3:   bridge window [io  0x1000-0x1fff]
> [    0.949475] pci 0000:00:1c.3:   bridge window [mem 0x54100000-0x551fffff]
> [    0.949639] pci 0000:00:1c.3:   bridge window [mem 0x53100000-0x540fffff 64bit pref]
> [    0.950244] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    0.953324] pci 0000:00:1d.0: [8086:27c8] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.953764] pci 0000:00:1d.0: BAR 4 [io  0x6080-0x609f]
> [    0.956336] pci 0000:00:1d.1: [8086:27c9] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.956764] pci 0000:00:1d.1: BAR 4 [io  0x6060-0x607f]
> [    0.959358] pci 0000:00:1d.2: [8086:27ca] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.959766] pci 0000:00:1d.2: BAR 4 [io  0x6040-0x605f]
> [    0.962373] pci 0000:00:1d.3: [8086:27cb] type 00 class 0x0c0300 conventional PCI endpoint
> [    0.962764] pci 0000:00:1d.3: BAR 4 [io  0x6020-0x603f]
> [    0.966517] pci 0000:00:1d.7: [8086:27cc] type 00 class 0x0c0320 conventional PCI endpoint
> [    0.966659] pci 0000:00:1d.7: BAR 0 [mem 0x58544400-0x585447ff]
> [    0.967209] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.969933] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401 conventional PCI bridge
> [    0.970331] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
> [    0.973061] pci 0000:00:1f.0: [8086:27b9] type 00 class 0x060100 conventional PCI endpoint
> [    0.973686] pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH6 ACPI/GPIO/TCO
> [    0.973960] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
> [    0.974223] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0068 (mask 0007)
> [    0.977944] pci 0000:00:1f.2: [8086:27c4] type 00 class 0x010180 conventional PCI endpoint
> [    0.978292] pci 0000:00:1f.2: BAR 0 [io  0x0000-0x0007]
> [    0.978510] pci 0000:00:1f.2: BAR 1 [io  0x0000-0x0003]
> [    0.978633] pci 0000:00:1f.2: BAR 2 [io  0x0000-0x0007]
> [    0.978848] pci 0000:00:1f.2: BAR 3 [io  0x0000-0x0003]
> [    0.979081] pci 0000:00:1f.2: BAR 4 [io  0x60a0-0x60af]
> [    0.979338] pci 0000:00:1f.2: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
> [    0.979604] pci 0000:00:1f.2: BAR 1 [io  0x03f6]: legacy IDE quirk
> [    0.979808] pci 0000:00:1f.2: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
> [    0.980038] pci 0000:00:1f.2: BAR 3 [io  0x0376]: legacy IDE quirk
> [    0.980395] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.983156] pci 0000:00:1f.3: [8086:27da] type 00 class 0x0c0500 conventional PCI endpoint
> [    0.983638] pci 0000:00:1f.3: BAR 4 [io  0x6000-0x601f]
> [    0.985505] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.986319] pci 0000:02:00.0: [10ec:8136] type 00 class 0x020000 PCIe Endpoint
> [    0.986664] pci 0000:02:00.0: BAR 0 [io  0x3000-0x30ff]
> [    0.986946] pci 0000:02:00.0: BAR 2 [mem 0x51010000-0x51010fff 64bit pref]
> [    0.987219] pci 0000:02:00.0: BAR 4 [mem 0x51000000-0x5100ffff 64bit pref]
> [    0.987625] pci 0000:02:00.0: ROM [mem 0xfffe0000-0xffffffff pref]
> [    0.988271] pci 0000:02:00.0: supports D1 D2
> [    0.988444] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.991644] pci 0000:00:1c.1: PCI bridge to [bus 02]
> [    0.992773] pci 0000:03:00.0: [168c:001c] type 00 class 0x020000 PCIe Legacy Endpoint
> [    0.993296] pci 0000:03:00.0: BAR 0 [mem 0x55200000-0x5520ffff 64bit]
> [    0.997989] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> [    0.998493] pci 0000:00:1c.2: PCI bridge to [bus 03]
> [    0.999387] pci 0000:04:00.0: [197b:2382] type 00 class 0x088000 PCIe Endpoint
> [    0.999681] pci 0000:04:00.0: BAR 0 [mem 0x54100300-0x541003ff]
> [    1.000128] pci 0000:04:00.0: ROM [mem 0xffff8000-0xffffffff pref]
> [    1.003190] pci 0000:04:00.2: [197b:2381] type 00 class 0x080501 PCIe Endpoint
> [    1.003520] pci 0000:04:00.2: BAR 0 [mem 0x54100200-0x541002ff]
> [    1.006542] pci 0000:04:00.3: [197b:2383] type 00 class 0x088000 PCIe Endpoint
> [    1.006906] pci 0000:04:00.3: BAR 0 [mem 0x54100100-0x541001ff]
> [    1.009885] pci 0000:04:00.4: [197b:2384] type 00 class 0x088000 PCIe Endpoint
> [    1.010228] pci 0000:04:00.4: BAR 0 [mem 0x54100000-0x541000ff]
> [    1.013449] pci 0000:00:1c.3: PCI bridge to [bus 04]
> [    1.013728] pci_bus 0000:05: extended config space not accessible
> [    1.014695] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
> [    1.014949] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
> [    1.015238] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
> [    1.015510] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
> [    1.015608] pci 0000:00:1e.0:   bridge window [mem 0x40000000-0xfebfffff window] (subtractive decode)
> [    1.016015] pci_bus 0000:00: on NUMA node 0
> [    1.018768] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
> [    1.020234] ACPI: PCI: Interrupt link LNKB configured for IRQ 11
> [    1.021658] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
> [    1.023072] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> [    1.024461] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
> [    1.024603] ACPI: PCI: Interrupt link LNKE disabled
> [    1.026072] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
> [    1.026286] ACPI: PCI: Interrupt link LNKF disabled
> [    1.027699] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
> [    1.027904] ACPI: PCI: Interrupt link LNKG disabled
> [    1.029270] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
> [    1.029474] ACPI: PCI: Interrupt link LNKH disabled
> [    1.039525] ACPI: EC: interrupt unblocked
> [    1.039611] ACPI: EC: event unblocked
> [    1.039774] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    1.039987] ACPI: EC: GPE=0x17
> [    1.040149] ACPI: \_SB_.PCI0.LPC_.EC0_: Boot DSDT EC initialization complete
> [    1.040381] ACPI: \_SB_.PCI0.LPC_.EC0_: EC: Used to handle transactions and events
> [    1.043711] SCSI subsystem initialized
> [    1.044229] libata version 3.00 loaded.
> [    1.044638] ACPI: bus type USB registered
> [    1.045360] usbcore: registered new interface driver usbfs
> [    1.045836] usbcore: registered new interface driver hub
> [    1.046246] usbcore: registered new device driver usb
> [    1.047081] EDAC MC: Ver: 3.0.0
> [    1.050409] Advanced Linux Sound Architecture Driver Initialized.
> [    1.054812] PCI: Using ACPI for IRQ routing
> [    1.086379] PCI: pci_cache_line_size set to 64 bytes
> [    1.086892] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
> [    1.087104] e820: reserve RAM buffer [mem 0x3f376000-0x3fffffff]
> [    1.087307] e820: reserve RAM buffer [mem 0x3f46d000-0x3fffffff]
> [    1.087505] e820: reserve RAM buffer [mem 0x3f4f0000-0x3fffffff]
> [    1.087606] e820: reserve RAM buffer [mem 0x3f500000-0x3fffffff]
> [    1.089193] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    1.089193] pci 0000:00:02.0: vgaarb: bridge control possible
> [    1.089254] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    1.089753] vgaarb: loaded
> [    1.105832] hpet: 3 channels of 0 reserved for per-cpu timers
> [    1.106059] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    1.106289] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
> [    1.109349] clocksource: Switched to clocksource tsc-early
> [    1.113686] pnp: PnP ACPI init
> [    1.118920] pnp 00:00: disabling [io  0x164e-0x164f] because it overlaps 0000:00:1c.3 BAR 7 [io  0x1000-0x1fff]
> [    1.120923] system 00:00: [io  0x0200-0x020f] has been reserved
> [    1.121225] system 00:00: [io  0x0600-0x060f] has been reserved
> [    1.121515] system 00:00: [io  0x0610] has been reserved
> [    1.121788] system 00:00: [io  0x0800-0x080f] has been reserved
> [    1.122120] system 00:00: [io  0x0400-0x047f] has been reserved
> [    1.122406] system 00:00: [io  0x0500-0x053f] has been reserved
> [    1.122700] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
> [    1.123052] system 00:00: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    1.123369] system 00:00: [mem 0xfed14000-0xfed17fff] has been reserved
> [    1.123687] system 00:00: [mem 0xfed18000-0xfed18fff] has been reserved
> [    1.124060] system 00:00: [mem 0xfed19000-0xfed19fff] has been reserved
> [    1.124373] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    1.124691] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
> [    1.131722] pnp: PnP ACPI: found 4 devices
> [    1.216745] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    1.217396] NET: Registered PF_INET protocol family
> [    1.218362] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    1.222210] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 24576 bytes, linear)
> [    1.222984] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    1.223268] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
> [    1.223759] TCP bind hash table entries: 8192 (order: 7, 786432 bytes, linear)
> [    1.226047] TCP: Hash tables configured (established 8192 bind 8192)
> [    1.226745] UDP hash table entries: 512 (order: 3, 57344 bytes, linear)
> [    1.227184] UDP-Lite hash table entries: 512 (order: 3, 57344 bytes, linear)
> [    1.228012] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    1.228374] pci 0000:02:00.0: ROM [mem 0xfffe0000-0xffffffff pref]: can't claim; no compatible bridge window
> [    1.228676] pci 0000:04:00.0: ROM [mem 0xffff8000-0xffffffff pref]: can't claim; no compatible bridge window
> [    1.229022] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    1.229215] pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
> [    1.229445] pci 0000:00:1c.0:   bridge window [mem 0x57300000-0x583fffff]
> [    1.229665] pci 0000:00:1c.0:   bridge window [mem 0x50000000-0x50ffffff 64bit pref]
> [    1.229976] pci 0000:02:00.0: ROM [mem 0x56300000-0x5631ffff pref]: assigned
> [    1.230199] pci 0000:00:1c.1: PCI bridge to [bus 02]
> [    1.230396] pci 0000:00:1c.1:   bridge window [io  0x3000-0x4fff]
> [    1.230609] pci 0000:00:1c.1:   bridge window [mem 0x56300000-0x572fffff]
> [    1.230828] pci 0000:00:1c.1:   bridge window [mem 0x51000000-0x520fffff 64bit pref]
> [    1.231126] pci 0000:00:1c.2: PCI bridge to [bus 03]
> [    1.231311] pci 0000:00:1c.2:   bridge window [io  0x2000-0x2fff]
> [    1.231532] pci 0000:00:1c.2:   bridge window [mem 0x55200000-0x562fffff]
> [    1.231751] pci 0000:00:1c.2:   bridge window [mem 0x52100000-0x530fffff 64bit pref]
> [    1.232057] pci 0000:04:00.0: ROM [mem 0x54108000-0x5410ffff pref]: assigned
> [    1.232277] pci 0000:00:1c.3: PCI bridge to [bus 04]
> [    1.232483] pci 0000:00:1c.3:   bridge window [io  0x1000-0x1fff]
> [    1.232694] pci 0000:00:1c.3:   bridge window [mem 0x54100000-0x551fffff]
> [    1.232954] pci 0000:00:1c.3:   bridge window [mem 0x53100000-0x540fffff 64bit pref]
> [    1.233222] pci 0000:00:1e.0: PCI bridge to [bus 05]
> [    1.233453] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    1.233656] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    1.233888] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    1.234105] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff window]
> [    1.234321] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
> [    1.234523] pci_bus 0000:01: resource 1 [mem 0x57300000-0x583fffff]
> [    1.235813] pci_bus 0000:01: resource 2 [mem 0x50000000-0x50ffffff 64bit pref]
> [    1.236081] pci_bus 0000:02: resource 0 [io  0x3000-0x4fff]
> [    1.236274] pci_bus 0000:02: resource 1 [mem 0x56300000-0x572fffff]
> [    1.236499] pci_bus 0000:02: resource 2 [mem 0x51000000-0x520fffff 64bit pref]
> [    1.236741] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
> [    1.236962] pci_bus 0000:03: resource 1 [mem 0x55200000-0x562fffff]
> [    1.237166] pci_bus 0000:03: resource 2 [mem 0x52100000-0x530fffff 64bit pref]
> [    1.237417] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
> [    1.237608] pci_bus 0000:04: resource 1 [mem 0x54100000-0x551fffff]
> [    1.237811] pci_bus 0000:04: resource 2 [mem 0x53100000-0x540fffff 64bit pref]
> [    1.238083] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
> [    1.238287] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
> [    1.238500] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
> [    1.238716] pci_bus 0000:05: resource 7 [mem 0x40000000-0xfebfffff window]
> [    1.264313] PCI: CLS 0 bytes, default 64
> [    1.266764] Unpacking initramfs...
> [    1.280213] Initialise system trusted keyrings
> [    1.282627] workingset: timestamp_bits=30 max_order=18 bucket_order=0
> [    1.287208] Key type asymmetric registered
> [    1.287644] Asymmetric key parser 'x509' registered
> [    1.288946] bounce: pool size: 64 pages
> [    1.290009] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> [    1.319904] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    1.322820] ACPI: button: Power Button [PWRB]
> [    1.325659] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
> [    1.328545] ACPI: button: Lid Switch [LID0]
> [    1.331479] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
> [    1.333167] ACPI: button: Sleep Button [SLPB]
> [    1.337229] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    1.343650] ACPI: button: Power Button [PWRF]
> [    1.349529] ACPI: video: Video Device [OVGA] (multi-head: yes  rom: yes  post: no)
> [    1.355499] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
> [    1.359938] ACPI: \_PR_.CPU0: Found 3 idle states
> [    1.360209] tsc: Marking TSC unstable due to TSC halts in idle
> [    1.363764] clocksource: Switched to clocksource hpet
> [    1.370453] ACPI: \_PR_.CPU1: Found 3 idle states
> [    1.381003] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    1.418789] Linux agpgart interface v0.103
> [    1.422233] ACPI: bus type drm_connector registered
> [    1.433229] pci 0000:00:00.0: Intel 945GME Chipset
> [    1.433696] pci 0000:00:00.0: detected gtt size: 262144K total, 262144K mappable
> [    1.434167] pci 0000:00:00.0: detected 8192K stolen memory
> [    1.434843] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    1.437682] Console: switching to colour dummy device 80x25
> [    1.454234] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    1.490838] i915 0000:00:02.0: [drm] Initialized overlay support.
> [    1.509203] [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 0
> [    1.519292] i915 display info: display version: 3
> [    1.519465] i915 display info: cursor_needs_physical: yes
> [    1.519635] i915 display info: has_cdclk_crawl: no
> [    1.519789] i915 display info: has_cdclk_squash: no
> [    1.519949] i915 display info: has_ddi: no
> [    1.520099] i915 display info: has_dp_mst: no
> [    1.520372] i915 display info: has_dsb: no
> [    1.520617] i915 display info: has_fpga_dbg: no
> [    1.520864] i915 display info: has_gmch: yes
> [    1.521009] i915 display info: has_hotplug: yes
> [    1.521305] i915 display info: has_hti: no
> [    1.521458] i915 display info: has_ipc: no
> [    1.521608] i915 display info: has_overlay: yes
> [    1.521757] i915 display info: has_psr: no
> [    1.521940] i915 display info: has_psr_hw_tracking: no
> [    1.522104] i915 display info: overlay_needs_physical: yes
> [    1.522370] i915 display info: supports_tv: yes
> [    1.522531] i915 display info: has_hdcp: no
> [    1.522685] i915 display info: has_dmc: no
> [    1.522831] i915 display info: has_dsc: no
> [    1.557545] fbcon: i915drmfb (fb0) is primary device
> [    1.578974] loop: module loaded
> [    1.583348] ata_piix 0000:00:1f.2: version 2.13
> [    1.587159] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> [    1.620155] scsi host0: ata_piix
> [    1.626412] scsi host1: ata_piix
> [    1.628456] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0x60a0 irq 14 lpm-pol 0
> [    1.628480] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x60a8 irq 15 lpm-pol 0
> [    1.634718] usbcore: registered new interface driver usb-storage
> [    1.635878] i8042: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MOUE] at 0x60,0x64 irq 1,12
> [    1.642588] i8042: Warning: Keylock active
> [    1.653054] i8042: Detected active multiplexing controller, rev 1.1
> [    1.659140] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.661382] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    1.661584] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    1.661622] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    1.661658] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    1.669835] mousedev: PS/2 mouse device common for all mice
> [    1.688669] rtc_cmos 00:01: RTC can wake from S4
> [    1.699553] rtc_cmos 00:01: registered as rtc0
> [    1.699808] rtc_cmos 00:01: setting system clock to 2024-02-27T09:47:06 UTC (1709027226)
> [    1.701563] rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
> [    1.703707] intel_pstate: CPU model not supported
> [    1.704213] hid: raw HID events driver (C) Jiri Kosina
> [    1.705980] usbcore: registered new interface driver usbhid
> [    1.706001] usbhid: USB HID core driver
> [    1.715215] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
> [    1.732768] NET: Registered PF_PACKET protocol family
> [    1.732886] Key type dns_resolver registered
> [    1.741992] microcode: Current revision: 0x00000218
> [    1.742014] microcode: Updated early from: 0x00000208
> [    1.744845] IPI shorthand broadcast: enabled
> [    1.781786] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC268: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [    1.781865] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    1.781887] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [    1.781907] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [    1.781924] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [    1.781940] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
> [    1.781958] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> [    1.809514] ata1.00: ATA-8: ST9160310AS, 0303, max UDMA/133
> [    1.809572] ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 0/32)
> [    1.915856] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
> [    1.924615] input: HDA Intel Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
> [    2.047638] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
> [    2.051953] registered taskstats version 1
> [    2.052002] Loading compiled-in X.509 certificates
> [    2.166195] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [    2.177890] printk: legacy console [netcon0] enabled
> [    2.177922] netconsole: network logging started
> [    2.191093] Freeing initrd memory: 8712K
> [    2.310117] Console: switching to colour frame buffer device 128x37
> [    2.412163] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [    2.419058] scsi 0:0:0:0: Direct-Access     ATA      ST9160310AS      0303 PQ: 0 ANSI: 5
> [    2.435091] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    2.438610] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
> [    2.442907] sd 0:0:0:0: [sda] Write Protect is off
> [    2.445648] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    2.448834] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    2.452714] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
> [    2.498992]  sda: sda1 sda2 sda3
> [    2.506357] sd 0:0:0:0: [sda] Attached SCSI disk
> [    2.565867] Unstable clock detected, switching default tracing clock to "global"
>                If you want to keep using the local clock, then add:
>                  "trace_clock=local"
>                on the kernel command line
> [    2.580790] clk: Disabling unused clocks
> [    2.583624] ALSA device list:
> [    2.586235]   #0: HDA Intel at 0x58540000 irq 24
> [    2.612030] Freeing unused kernel image (initmem) memory: 2196K
> [    2.616531] Write protecting kernel text and read-only data: 14580k
> [    2.619161] Run /init as init process
> [    2.621744]   with arguments:
> [    2.624290]     /init
> [    2.626803]   with environment:
> [    2.629309]     HOME=/
> [    2.631846]     TERM=linux
> [    2.634308]     BOOT_IMAGE=/boot/vmlinuz-6.8.0-rc6+
> [    2.636846]     log_bug_len=10M
> [    2.664059] process '/bin/mkdir' started with executable stack
> [    4.044786] psmouse serio2: synaptics: queried max coordinates: x [..5888], y [..5218]
> [    4.134994] psmouse serio2: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04771/0xa40000/0xa0000/0x0, board id: 0, fw id: 516037
> [    4.200859] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input13
> [    4.903120] sdhci: Secure Digital Host Controller Interface driver
> [    4.909907] sdhci: Copyright(c) Pierre Ossman
> [    4.989165] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    5.010902] sdhci-pci 0000:04:00.0: SDHCI controller found [197b:2382] (rev 0)
> [    5.010931] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 1
> [    5.017578] sdhci-pci 0000:04:00.2: SDHCI controller found [197b:2381] (rev 0)
> [    5.029361] ehci-pci 0000:00:1d.7: debug port 1
> [    5.037862] ehci-pci 0000:00:1d.7: irq 16, io mem 0x58544400
> [    5.040841] sdhci-pci 0000:04:00.2: Refusing to bind to secondary interface.
> [    5.053457] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    5.082391] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.08
> [    5.096533] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.112487] usb usb1: Product: EHCI Host Controller
> [    5.113921] mmc0: SDHCI controller on PCI [0000:04:00.0] using ADMA
> [    5.128164] usb usb1: Manufacturer: Linux 6.8.0-rc6+ ehci_hcd
> [    5.137361] usb usb1: SerialNumber: 0000:00:1d.7
> [    5.174219] hub 1-0:1.0: USB hub found
> [    5.182480] hub 1-0:1.0: 8 ports detected
> [    5.292127] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    5.461489] usb 1-5: new high-speed USB device number 2 using ehci-pci
> [    5.473125] r8169 0000:02:00.0 eth0: RTL8102e/RTL8103e, 00:1e:68:fe:2f:2b, XID 24a, IRQ 17
> [    5.823037] usb 1-5: New USB device found, idVendor=064e, idProduct=d101, bcdDevice= 0.01
> [    5.825820] usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=4
> [    5.829220] usb 1-5: Product: Acer Crystal Eye webcam
> [    5.832702] usb 1-5: Manufacturer: SuYin
> [    5.836040] usb 1-5: SerialNumber: CN0316-M608-OV01-VA-R02.00.00
> [    6.901206] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
> [    7.104215] EXT4-fs (sda1): mounted filesystem b8eed519-4906-49ad-bd88-fc9ffe355fce ro with ordered data mode. Quota mode: disabled.
> [    7.166402] random: crng init done
> [   13.798536] ACPI: battery: Slot [BAT1] (battery absent)
> [   13.839601] ACPI: AC: AC Adapter [ACAD] (on-line)
> [   16.317073] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   17.078926] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   17.088730] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   17.109813] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   17.114987] cfg80211: failed to load regulatory.db
> [   17.994887] RTL8201CP Ethernet r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
> [   18.067967] r8169 0000:02:00.0 eth0: Link is Down
> [   18.097473] ath5k 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
> [   18.112155] ath5k 0000:03:00.0: registered as 'phy0'
> [   18.769394] ath: EEPROM regdomain: 0x65
> [   18.772455] ath: EEPROM indicates we should expect a direct regpair map
> [   18.775490] ath: Country alpha2 being used: 00
> [   18.778832] ath: Regpair used: 0x65
> [   18.786165] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
> [   18.802882] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x70)
> [   19.655155] r8169 0000:02:00.0 eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> [   20.790672] NET: Registered PF_INET6 protocol family
> [   20.816033] Segment Routing with IPv6
> [   20.820835] In-situ OAM (IOAM) with IPv6
> [   22.162217] Adding 1951892k swap on /dev/sda2.  Priority:-2 extents:1 across:1951892k 
> [   22.610978] EXT4-fs (sda1): re-mounted b8eed519-4906-49ad-bd88-fc9ffe355fce r/w. Quota mode: disabled.
> [   29.255438] EXT4-fs (sda3): mounting ext3 file system using the ext4 subsystem
> [   29.803022] EXT4-fs (sda3): mounted filesystem d4778cd4-eb8a-458b-b518-f577e36f99c7 r/w with ordered data mode. Quota mode: disabled.
> [   35.273807] fuse: init (API version 7.39)
> [   35.443178] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
> [   60.040956] acerhdf: Acer Aspire One Fan driver, v.0.7.0
> [   60.044605] acerhdf: Fan control off, to enable do:
> [   60.048696] acerhdf: echo -n "enabled" > /sys/class/thermal/thermal_zoneN/mode # N=0,1,2...
> [   60.065656] acerhdf: kernel mode fan control ON
> [   66.972957] BUG: sleeping function called from invalid context at drivers/gpu/drm/i915/gem/i915_gem_pages.c:526
> [   66.973151] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2305, name: Xorg
> [   66.973190] preempt_count: 0, expected: 0
> [   66.973224] RCU nest depth: 0, expected: 0
> [   66.973258] 2 locks held by Xorg/2305:
> [   66.973294]  #0: c54bfd6c (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_cursor_common+0x77/0x210
> [   66.973303]  #1: c40f2054 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x61/0x1d4
> [   66.973303] irq event stamp: 216460
> [   66.973303] hardirqs last  enabled at (216459): [<c1a6fbc5>] _raw_spin_unlock_irqrestore+0x4d/0x90
> [   66.973303] hardirqs last disabled at (216460): [<c164f37d>] intel_pipe_update_start+0x365/0x550
> [   66.973303] softirqs last  enabled at (216436): [<c1a70e0b>] __do_softirq+0x2ab/0x419
> [   66.973303] softirqs last disabled at (216431): [<c102b53e>] call_on_stack+0x12/0x4c
> [   66.973303] CPU: 1 PID: 2305 Comm: Xorg Not tainted 6.8.0-rc6+ #1
> [   66.973303] Hardware name: Acer AOA150/, BIOS v0.3309 10/06/2008
> [   66.973303] Call Trace:
> [   66.973303]  dump_stack_lvl+0x6c/0xe8
> [   66.973303]  dump_stack+0x13/0x18
> [   66.973303]  __might_resched+0x1bc/0x2d0
> [   66.973303]  ? i915_get_vblank_counter+0xc7/0x180
> [   66.973303]  __might_sleep+0x35/0x6c
> [   66.973303]  __i915_gem_object_page_iter_get_sg+0x43/0x3f0
> [   66.973303]  ? __lock_acquire+0x402/0x24e0
> [   66.973303]  ? __lock_acquire+0x402/0x24e0
> [   66.973303]  __i915_gem_object_get_dma_address+0x20/0x40
> [   66.973303]  intel_cursor_base+0x47/0x50
> [   66.973303]  i9xx_cursor_update_arm+0x32b/0x93c
> [   66.973303]  ? i915_get_vblank_counter+0x148/0x180
> [   66.973303]  ? debug_smp_processor_id+0x12/0x14
> [   66.973303]  ? i845_cursor_disable_arm+0x14/0x14
> [   66.973303]  intel_plane_update_arm+0x76/0xd4
> [   66.973303]  ? _raw_spin_unlock_irqrestore+0x39/0x90
> [   66.973303]  intel_crtc_planes_update_arm+0x255/0x2f0
> [   66.973303]  ? debug_smp_processor_id+0x12/0x14
> [   66.973303]  ? intel_pipe_update_start+0x42e/0x550
> [   66.973303]  ? debug_smp_processor_id+0x12/0x14
> [   66.973303]  intel_update_crtc+0xad/0x3f8
> [   66.973303]  ? intel_pre_update_crtc+0x11e/0x2e4
> [   66.973303]  ? __mutex_unlock_slowpath+0x26/0x274
> [   66.973303]  ? intel_dbuf_pre_plane_update+0x38/0x1b0
> [   66.973303]  intel_commit_modeset_enables+0x93/0xac
> [   66.973303]  intel_atomic_commit_tail+0x6e2/0xf74
> [   66.973303]  ? debug_smp_processor_id+0x12/0x14
> [   66.973303]  ? _raw_spin_unlock+0x27/0x3c
> [   66.973303]  ? drm_atomic_helper_swap_state+0x245/0x378
> [   66.973303]  ? trace_preempt_on+0x2a/0x80
> [   66.973303]  ? preempt_count_sub+0xb1/0x100
> [   66.973303]  intel_atomic_commit+0x2e7/0x32c
> [   66.973303]  ? skl_commit_modeset_enables+0x4f8/0x4f8
> [   66.973303]  drm_atomic_commit+0x85/0x9c
> [   66.973303]  ? __drm_printfn_seq_file+0x28/0x28
> [   66.973303]  drm_atomic_helper_update_plane+0xc0/0x10c
> [   66.973303]  intel_legacy_cursor_update+0x287/0x2f4
> [   66.973303]  ? drm_internal_framebuffer_create+0x4c8/0x670
> [   66.973303]  ? intel_cursor_base+0x50/0x50
> [   66.973303]  __setplane_atomic+0xdd/0x110
> [   66.973303]  drm_mode_cursor_universal+0x13b/0x2e4
> [   66.973303]  drm_mode_cursor_common+0xbf/0x210
> [   66.973303]  ? drm_is_current_master+0x28/0x30
> [   66.973303]  ? drm_mode_setplane+0x328/0x328
> [   66.973303]  drm_mode_cursor_ioctl+0x52/0x5c
> [   66.973303]  drm_ioctl_kernel+0x77/0xc8
> [   66.973303]  ? drm_mode_setplane+0x328/0x328
> [   66.973303]  drm_ioctl+0x26e/0x5a4
> [   66.973303]  ? drm_mode_setplane+0x328/0x328
> [   66.973303]  ? __this_cpu_preempt_check+0xf/0x20
> [   66.973303]  ? __fget_files+0xc8/0x190
> [   66.973303]  ? __fget_files+0x5/0x190
> [   66.973303]  ? drm_ioctl_kernel+0xc8/0xc8
> [   66.973303]  __ia32_sys_ioctl+0x308/0xac0
> [   66.973303]  ? __this_cpu_preempt_check+0xf/0x20
> [   66.973303]  ? __might_fault+0x7d/0x84
> [   66.973303]  __do_fast_syscall_32+0x6e/0xf8
> [   66.973303]  do_fast_syscall_32+0x29/0x5c
> [   66.973303]  do_SYSENTER_32+0x15/0x18
> [   66.973303]  entry_SYSENTER_32+0x98/0xf8
> [   66.973303] EIP: 0xb7f2c579
> [   66.973303] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   66.973303] EAX: ffffffda EBX: 0000000d ECX: c01c64a3 EDX: bf8e96a0
> [   66.973303] ESI: 00dd5620 EDI: c01c64a3 EBP: 0000000d ESP: bf8e9618
> [   66.973303] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200296
> [   66.978952] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on pipe B (start=4062 end=4063) time 5725 us, min 590, max 599, scanline start 510, end 108

-- 
Jani Nikula, Intel

