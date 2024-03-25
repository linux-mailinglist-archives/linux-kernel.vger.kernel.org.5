Return-Path: <linux-kernel+bounces-116853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385C88A499
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A2C1F3E156
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971717C644;
	Mon, 25 Mar 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7hiHeBS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5140149C71
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363215; cv=none; b=e+lm0JPmzqhTCeTznDeB55z2B6ZNUJwJdABBWpnZ4HNVTc4M/uR0sJLkexV/TXyCwTMwcg1vOfeL5/7TsbFuRlxCi1raLXp+VwZYlBQQ7gze6sKhUzLKKHv4xRDloX956YU1HklHoaDI4eqWpfSieUDlBqP2gg2+sMe0tm2WcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363215; c=relaxed/simple;
	bh=s7aZUNqRwppoTYX7ExnA6g6RaH+20n8MZhm6CbYHZRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvNZnclU2sg9ldA6ZqV9yu1b3HSwBWtgeaOl+84PqWwZ3VK2swS3USb+9lLBKBZYz/gBDz/X32a6A1vwa/inOyUiNMStmqYFiZpNXFVFusTgCzCukV24c71sLhLhHMq84M5NHnasfG0CjRE7nOX2q3CkxSJ7vXU39esAAQRQRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7hiHeBS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363214; x=1742899214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s7aZUNqRwppoTYX7ExnA6g6RaH+20n8MZhm6CbYHZRU=;
  b=W7hiHeBSwZUcWHYDyjVs9cAXo1QWEpeE5tvHL/Ei2tx+4lD1MfXf3UBQ
   ebS1sUHRdwEVyG7i/nPNCRbqO1RhLgrdhN3XSeKbyOmn7VIs+tPNJ8sNL
   ETnpk1+bJoajP+Ae7b+UbpvxNUsF3HjAYNwouw1SUl5suN42d0sD5RlfE
   11e6MEqjOC/vhhBYN+5RYnU5v9kKIIOF+mVBRuvXEzjgECf5fbrmf7v/y
   M2LssxpKqdcInG+V3caLq6dIRgQmCPseV6EWFl29VBq/d+Fop/i0YwrpF
   ItBxM7fKt2KuLHNxlAjldA0hyYVCXPsap+3CmtsqQ+kxco1Tqs6C7brOR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561340"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070137"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070137"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C8A58228; Mon, 25 Mar 2024 12:40:04 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv9 00/17] x86/tdx: Add kexec support
Date: Mon, 25 Mar 2024 12:38:54 +0200
Message-ID: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adds bits and pieces to get kexec (and crashkernel) work on
TDX guest.

The last patch implements CPU offlining according to the approved ACPI
spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
kernel. It requires BIOS-side enabling. If it missing we fallback to booting
2nd kernel with single CPU.

Please review. I would be glad for any feedback.

[1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

v9:
  - Rebased;
  - Keep page tables that maps E820_TYPE_ACPI (Ashish);
  - Ack/Reviewed/Tested-bys from Sathya, Kai, Tao;
  - Minor printk() message adjustments;
v8:
  - Rework serialization of around conversion memory back to private;
  - Print ACPI_MADT_TYPE_MULTIPROC_WAKEUP in acpi_table_print_madt_entry();
  - Drop debugfs interface to dump info on shared memory;
  - Adjust comments and commit messages;
  - Reviewed-bys by Baoquan, Dave and Thomas;
v7:
  - Call enc_kexec_stop_conversion() and enc_kexec_unshare_mem() after shutting
    down IO-APIC, lapic and hpet. It meets AMD requirements.
  - Minor style changes;
  - Add Acked/Reviewed-bys;
v6:
  - Rebased to v6.8-rc1;
  - Provide default noop callbacks from .enc_kexec_stop_conversion and
    .enc_kexec_unshare_mem;
  - Split off patch that introduces .enc_kexec_* callbacks;
  - asm_acpi_mp_play_dead(): program CR3 directly from RSI, no MOV to RAX
    required;
  - Restructure how smp_ops.stop_this_cpu() hooked up in crash_nmi_callback();
  - kvmclock patch got merged via KVM tree;
v5:
  - Rename smp_ops.crash_play_dead to smp_ops.stop_this_cpu and use it in
    stop_this_cpu();
  - Split off enc_kexec_stop_conversion() from enc_kexec_unshare_mem();
  - Introduce kernel_ident_mapping_free();
  - Add explicit include for alternatives and stringify.
  - Add barrier() after setting conversion_allowed to false;
  - Mark cpu_hotplug_offline_disabled __ro_after_init;
  - Print error if failed to hand over CPU to BIOS;
  - Update comments and commit messages;
v4:
  - Fix build for !KEXEC_CORE;
  - Cleaner ATLERNATIVE use;
  - Update commit messages and comments;
  - Add Reviewed-bys;
v3:
  - Rework acpi_mp_crash_stop_other_cpus() to avoid invoking hotplug state
    machine;
  - Free page tables if reset vector setup failed;
  - Change asm_acpi_mp_play_dead() to pass reset vector and PGD as arguments;
  - Mark acpi_mp_* variables as static and __ro_after_init;
  - Use u32 for apicid;
  - Disable CPU offlining if reset vector setup failed;
  - Rename madt.S -> madt_playdead.S;
  - Mark tdx_kexec_unshare_mem() as static;
  - Rebase onto up-to-date tip/master;
  - Whitespace fixes;
  - Reorder patches;
  - Add Reviewed-bys;
  - Update comments and commit messages;
v2:
  - Rework how unsharing hook ups into kexec codepath;
  - Rework kvmclock_disable() fix based on Sean's;
  - s/cpu_hotplug_not_supported()/cpu_hotplug_disable_offlining()/;
  - use play_dead_common() to implement acpi_mp_play_dead();
  - cond_resched() in tdx_shared_memory_show();
  - s/target kernel/second kernel/;
  - Update commit messages and comments;

Kirill A. Shutemov (17):
  x86/acpi: Extract ACPI MADT wakeup code into a separate file
  x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
  cpu/hotplug: Add support for declaring CPU offlining not supported
  cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
  x86/kexec: Keep CR4.MCE set during kexec for TDX guest
  x86/mm: Make x86_platform.guest.enc_status_change_*() return errno
  x86/mm: Return correct level from lookup_address() if pte is none
  x86/tdx: Account shared memory
  x86/mm: Adding callbacks to prepare encrypted memory for kexec
  x86/tdx: Convert shared memory back to private on kexec
  x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
  x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
  x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
  x86/smp: Add smp_ops.stop_this_cpu() callback
  x86/mm: Introduce kernel_ident_mapping_free()
  x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
  ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed

 arch/x86/Kconfig                     |   7 +
 arch/x86/coco/core.c                 |   1 -
 arch/x86/coco/tdx/tdx.c              |  99 ++++++++-
 arch/x86/hyperv/ivm.c                |   9 +-
 arch/x86/include/asm/acpi.h          |   7 +
 arch/x86/include/asm/init.h          |   3 +
 arch/x86/include/asm/pgtable.h       |   5 +
 arch/x86/include/asm/pgtable_types.h |   1 +
 arch/x86/include/asm/set_memory.h    |   3 +
 arch/x86/include/asm/smp.h           |   1 +
 arch/x86/include/asm/x86_init.h      |   6 +-
 arch/x86/kernel/acpi/Makefile        |  11 +-
 arch/x86/kernel/acpi/boot.c          |  86 +-------
 arch/x86/kernel/acpi/madt_playdead.S |  28 +++
 arch/x86/kernel/acpi/madt_wakeup.c   | 292 +++++++++++++++++++++++++++
 arch/x86/kernel/crash.c              |   6 +
 arch/x86/kernel/e820.c               |   9 +-
 arch/x86/kernel/process.c            |   7 +
 arch/x86/kernel/reboot.c             |  18 ++
 arch/x86/kernel/relocate_kernel_64.S |   5 +
 arch/x86/kernel/x86_init.c           |   8 +-
 arch/x86/mm/ident_map.c              |  73 +++++++
 arch/x86/mm/mem_encrypt_amd.c        |   8 +-
 arch/x86/mm/pat/set_memory.c         |  59 ++++--
 drivers/acpi/tables.c                |  14 ++
 include/acpi/actbl2.h                |  19 +-
 include/linux/cc_platform.h          |  10 -
 include/linux/cpu.h                  |   2 +
 kernel/cpu.c                         |  12 +-
 29 files changed, 663 insertions(+), 146 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c

-- 
2.43.0


