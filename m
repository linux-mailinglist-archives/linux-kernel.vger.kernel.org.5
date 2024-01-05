Return-Path: <linux-kernel+bounces-17851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B677825390
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D07B231AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377A2D610;
	Fri,  5 Jan 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlKr5Iqx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370A2D052
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC30C433C9;
	Fri,  5 Jan 2024 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704459928;
	bh=oTSS/EwPD5WuU+/fULluC8lTlN13w5rb+Or0+3VPvNU=;
	h=Date:From:To:Cc:Subject:From;
	b=TlKr5IqxPsQE3zvhSiA9wcCI+tIeU50I1AVHw7mbquyZL2AyMfih1RfIsXUecme7n
	 n1JP1D7iHzx8yFFkpEZQ96Xla0tv8vNT7xdtL0hjZ+jGm9hPm0syZIcxU5Kt9EMFxO
	 o5BxbyTCdubBHpmDOuAZwzLe5fhRaa+yCVy3u92ITorFI5ds84LS7nCD0wl/5hjVVs
	 2FNfrmy6FfnxsZaZeCbbKtJ0KjuYEYfVq9n6F/co5LoO7hq1U5TbH3ogcbcOX94U0T
	 2k02tak08mdAw40C2q9HC9q+igycaIsZYXC+vlK2pHYzUqLBeEo++TtoggAvrKwsNu
	 vZ8ghLjfLHJdw==
Date: Fri, 5 Jan 2024 13:05:23 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 6.8
Message-ID: <20240105130523.GA9015@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these New Year arm64 updates for 6.8. As per usual, there is
a summary in the tag, but here are a few minor things to be aware of:

  - There's a trivial conflict with the arm-soc tree in linux-next [1],
    since we're both touching the 32-bit Arm PMU code. The arm-soc tree
    removes support for the infamous 11MPcore CPU entirely (good
    riddance), so the change here in 5cd7da19cb97 ("arm: perf: Remove
    PMU locking") to remove unnecessary locking from
    armv6mpcore_pmu_disable_event() is touching code that is removed
    completely.

  - The for-next/lpa2-prep and for-next/sysregs branches are shared with
    kvmarm, as they build on top to enable 52-bit addressing (IPAs) and
    fine-grained traps for guests.

  - We've got a new PMU driver for the Synopsys DesignWare PCIe IP;
    Bjorn has Acked the PCI changes.

  - I've ended up merging our 6.7 fixes branch (for-next/fixes) so we
    could update some CPU capability-checking logic in the KPTI enabling
    code. Consequently, the diffstat is a tiny bit wonky due to the
    three fixes that were merged after -rc3. I don't particularly like
    changing that by hand, so you've got the raw thing (against -rc3)
    here.

Should all be straightforward, but please shout if not.

Cheers,

Will

[1] https://lore.kernel.org/r/20240103100324.05f47bb8@canb.auug.org.au

--->8

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to db32cf8e280b46726065c518e90761bb0229bacf:

  Merge branch 'for-next/fixes' into for-next/core (2024-01-04 12:32:33 +0000)

----------------------------------------------------------------
arm64 updates for 6.8

* for-next/cpufeature

  - Remove ARM64_HAS_NO_HW_PREFETCH copy_page() optimisation for ye olde
    Thunder-X machines.
  - Avoid mapping KPTI trampoline when it is not required.
  - Make CPU capability API more robust during early initialisation.

* for-next/early-idreg-overrides

  - Remove dependencies on core kernel helpers from the early
    command-line parsing logic in preparation for moving this code
    before the kernel is mapped.

* for-next/fpsimd

  - Restore kernel-mode fpsimd context lazily, allowing us to run fpsimd
    code sequences in the kernel with pre-emption enabled.

* for-next/kbuild

  - Install 'vmlinuz.efi' when CONFIG_EFI_ZBOOT=y.
  - Makefile cleanups.

* for-next/lpa2-prep

  - Preparatory work for enabling the 'LPA2' extension, which will
    introduce 52-bit virtual and physical addressing even with 4KiB
    pages (including for KVM guests).

* for-next/misc

  - Remove dead code and fix a typo.

* for-next/mm

  - Pass NUMA node information for IRQ stack allocations.

* for-next/perf

  - Add perf support for the Synopsys DesignWare PCIe PMU.
  - Add support for event counting thresholds (FEAT_PMUv3_TH) introduced
    in Armv8.8.
  - Add support for i.MX8DXL SoCs to the IMX DDR PMU driver.
  - Minor PMU driver fixes and optimisations.

* for-next/rip-vpipt

  - Remove what support we had for the obsolete VPIPT I-cache policy.

* for-next/selftests

  - Improvements to the SVE and SME selftests.

* for-next/stacktrace

  - Refactor kernel unwind logic so that it can used by BPF unwinding
    and, eventually, reliable backtracing.

* for-next/sysregs

  - Update a bunch of register definitions based on the latest XML drop
    from Arm.

----------------------------------------------------------------
Anshuman Khandual (4):
      arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
      drivers: perf: arm_pmuv3: Add new macro PMUV3_INIT_MAP_EVENT()
      arm: perf: Remove PMU locking
      drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'

Ard Biesheuvel (16):
      arm64: Avoid enabling KPTI unnecessarily
      arm64: mm: Only map KPTI trampoline if it is going to be used
      arm64: Kconfig: drop KAISER reference from KPTI option description
      arm64: kernel: Disable latent_entropy GCC plugin in early C runtime
      arm64: mm: Take potential load offset into account when KASLR is off
      arm64: mm: get rid of kimage_vaddr global variable
      arm64: idreg-override: Omit non-NULL checks for override pointer
      arm64: idreg-override: Prepare for place relative reloc patching
      arm64: idreg-override: Avoid parameq() and parameqn()
      arm64: idreg-override: avoid strlen() to check for empty strings
      arm64: idreg-override: Avoid sprintf() for simple string concatenation
      arm64: idreg-override: Avoid kstrtou64() to parse a single hex digit
      arm64/kernel: Move 'nokaslr' parsing out of early idreg code
      arm64: fpsimd: Drop unneeded 'busy' flag
      arm64: fpsimd: Preserve/restore kernel mode NEON at context switch
      arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD

Christophe JAILLET (1):
      drivers/perf: Remove usage of the deprecated ida_simple_xx() API

Fuad Tabba (6):
      arm64/sysreg: Update HFGITR_EL2 definiton to DDI0601 2023-09
      arm64/sysreg: Add definition for HAFGRTR_EL2
      arm64/sysreg: Add missing Pauth_LR field definitions to ID_AA64ISAR1_EL1
      arm64/sysreg: Add missing ExtTrcBuff field definition to ID_AA64DFR0_EL1
      arm64/sysreg: Add missing system register definitions for FGT
      arm64/sysreg: Add missing system instruction definitions for FGT

Huang Shijie (2):
      arm64: irq: set the correct node for VMAP stack
      arm64: irq: set the correct node for shadow call stack

James Clark (12):
      arm: perf: Remove inlines from arm_pmuv3.c
      arm: perf/kvm: Use GENMASK for ARMV8_PMU_PMCR_N
      arm: perf: Use GENMASK for PMMIR fields
      arm: perf: Convert remaining fields to use GENMASK
      arm64: perf: Include threshold control fields in PMEVTYPER mask
      arm: pmu: Share user ABI format mechanism with SPE
      perf/arm_dmc620: Remove duplicate format attribute #defines
      KVM: selftests: aarch64: Update tools copy of arm_pmuv3.h
      arm: pmu: Move error message and -EOPNOTSUPP to individual PMUs
      arm64: perf: Add support for event counting threshold
      Documentation: arm64: Document the PMU event counting threshold feature
      arm: perf: Fix ARCH=arm build with GCC

James Houghton (1):
      arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Joey Gouly (2):
      arm64/sysreg: add system register POR_EL{0,1}
      arm64/sysreg: update CPACR_EL1 register

Josef Bacik (1):
      arm64: properly install vmlinuz.efi

Junhao He (1):
      drivers/perf: hisi: Fix some event id for HiSilicon UC pmu

Marc Zyngier (4):
      KVM: arm64: Remove VPIPT I-cache handling
      arm64: Kill detection of VPIPT i-cache policy
      arm64: Rename reserved values for CTR_EL0.L1Ip
      arm64: Get rid of ARM64_HAS_NO_HW_PREFETCH

Mark Brown (12):
      kselftest/arm64: Improve output for skipped TPIDR2 ABI test
      kselftest/arm64: Log SVCR when the SME tests barf
      arm64/sysreg: Add definition for ID_AA64PFR2_EL1
      arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for DDI0601 2023-09
      arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
      arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
      arm64/sysreg: Update ID_AA64SMFR0_EL1 definition for DDI0601 2023-09
      arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
      arm64/sysreg: Update HCRX_EL2 definition for DDI0601 2023-09
      arm64/sysreg: Add definition for FPMR
      arm64/sysreg: Add new system registers for GCS
      kselftest/arm64: Don't probe the current VL for unsupported vector types

Mark Rutland (5):
      drivers/perf: pmuv3: don't expose SW_INCR event in sysfs
      arm64: stacktrace: factor out kernel unwind state
      arm64: stacktrace: factor out kunwind_stack_walk()
      arm64: Cleanup system cpucap handling
      arm64: Align boot cpucap handling with system cpucap handling

Masahiro Yamada (3):
      arm64: vdso32: rename 32-bit debug vdso to vdso32.so.dbg
      arm64: replace <asm-generic/export.h> with <linux/export.h>
      efi/libstub: zboot: do not use $(shell ...) in cmd_copy_and_pad

Robin Murphy (2):
      perf/arm-cmn: Fix HN-F class_occup_id events
      perf/arm-cmn: Fail DTC counter allocation correctly

Ryan Roberts (4):
      arm64/mm: Modify range-based tlbi to decrement scale
      arm64/mm: Add lpa2_is_enabled() kvm_lpa2_is_enabled() stubs
      arm64/mm: Update tlb invalidation routines for FEAT_LPA2
      arm64: Add ARM64_HAS_LPA2 CPU capability

Shuai Xue (5):
      docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
      PCI: Add Alibaba Vendor ID to linux/pci_ids.h
      PCI: Move pci_clear_and_set_dword() helper to PCI header
      drivers/perf: add DesignWare PCIe PMU driver
      MAINTAINERS: add maintainers for DesignWare PCIe PMU driver

Tsung-Han Lin (1):
      Documentation/arch/arm64: Fix typo

Wang Jinchao (1):
      arm64: memory: remove duplicated include

Will Deacon (15):
      drivers/perf: arm_dsu_pmu: Remove kerneldoc-style comment syntax
      Revert "perf/arm_dmc620: Remove duplicate format attribute #defines"
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/early-idreg-overrides' into for-next/core
      Merge branch 'for-next/fpsimd' into for-next/core
      Merge branch 'for-next/kbuild' into for-next/core
      Merge branch 'for-next/lpa2-prep' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/rip-vpipt' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/stacktrace' into for-next/core
      Merge branch 'for-next/sysregs' into for-next/core
      Merge branch 'for-next/fixes' into for-next/core

Xu Yang (4):
      perf: fsl_imx8_ddr: Add AXI ID PORT CHANNEL filter support
      docs/perf: Add explanation for DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER quirk
      dt-bindings: perf: fsl-imx-ddr: Add i.MX8DXL compatible
      perf: fsl_imx8_ddr: Add driver support for i.MX8DXL DDR Perf

Zenghui Yu (1):
      arm64: Delete the zero_za macro

 Documentation/admin-guide/perf/dwc_pcie_pmu.rst    |  94 +++
 Documentation/admin-guide/perf/imx-ddr.rst         |  45 +-
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/arch/arm64/arm-acpi.rst              |   2 +-
 Documentation/arch/arm64/perf.rst                  |  72 ++
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   3 +
 MAINTAINERS                                        |   7 +
 arch/arm/kernel/perf_event_v6.c                    |  28 +-
 arch/arm/kernel/perf_event_v7.c                    |  50 +-
 arch/arm/kernel/perf_event_xscale.c                |  44 +-
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/Makefile                                |   2 +-
 arch/arm64/boot/Makefile                           |   2 +-
 arch/arm64/boot/install.sh                         |   3 +-
 arch/arm64/include/asm/assembler.h                 |   2 +-
 arch/arm64/include/asm/cache.h                     |   6 -
 arch/arm64/include/asm/cpufeature.h                |   6 +
 arch/arm64/include/asm/fpsimdmacros.h              |   8 -
 arch/arm64/include/asm/kernel-pgtable.h            |  27 +-
 arch/arm64/include/asm/kvm_mmu.h                   |   7 -
 arch/arm64/include/asm/kvm_pgtable.h               |   2 +
 arch/arm64/include/asm/memory.h                    |   7 +-
 arch/arm64/include/asm/pgtable-prot.h              |   2 +
 arch/arm64/include/asm/pgtable.h                   |   6 +
 arch/arm64/include/asm/processor.h                 |   3 +
 arch/arm64/include/asm/simd.h                      |  11 +-
 arch/arm64/include/asm/stacktrace/common.h         |  19 +-
 arch/arm64/include/asm/stacktrace/nvhe.h           |   2 +-
 arch/arm64/include/asm/sysreg.h                    |  25 +
 arch/arm64/include/asm/thread_info.h               |   1 +
 arch/arm64/include/asm/tlb.h                       |  15 +-
 arch/arm64/include/asm/tlbflush.h                  | 100 ++-
 arch/arm64/kernel/cpufeature.c                     | 162 +++--
 arch/arm64/kernel/cpuinfo.c                        |   5 -
 arch/arm64/kernel/fpsimd.c                         | 169 +++--
 arch/arm64/kernel/head.S                           |   2 +-
 arch/arm64/kernel/idreg-override.c                 | 153 ++--
 arch/arm64/kernel/irq.c                            |   7 +-
 arch/arm64/kernel/kaslr.c                          |   7 +
 arch/arm64/kernel/pi/Makefile                      |   1 +
 arch/arm64/kernel/smp.c                            |  12 +-
 arch/arm64/kernel/stacktrace.c                     | 146 ++--
 arch/arm64/kernel/vdso32/Makefile                  |   8 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                      |  61 --
 arch/arm64/kvm/hyp/vhe/tlb.c                       |  13 -
 arch/arm64/kvm/pmu-emul.c                          |   8 +-
 arch/arm64/kvm/sys_regs.c                          |   4 +-
 arch/arm64/lib/copy_page.S                         |  11 -
 arch/arm64/mm/mmu.c                                |   6 +-
 arch/arm64/tools/cpucaps                           |   2 +-
 arch/arm64/tools/sysreg                            | 325 ++++++++-
 drivers/base/arch_numa.c                           |   2 +-
 drivers/firmware/efi/libstub/Makefile.zboot        |   4 +-
 drivers/infiniband/hw/erdma/erdma_hw.h             |   2 -
 drivers/pci/access.c                               |  12 +
 drivers/pci/pcie/aspm.c                            |  65 +-
 drivers/perf/Kconfig                               |   7 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/apple_m1_cpu_pmu.c                    |   6 +-
 drivers/perf/arm-cmn.c                             |   4 +-
 drivers/perf/arm_dsu_pmu.c                         |   6 +-
 drivers/perf/arm_pmu.c                             |  12 +-
 drivers/perf/arm_pmuv3.c                           | 240 ++++---
 drivers/perf/arm_spe_pmu.c                         |  22 -
 drivers/perf/dwc_pcie_pmu.c                        | 792 +++++++++++++++++++++
 drivers/perf/fsl_imx8_ddr_perf.c                   |  45 ++
 drivers/perf/fsl_imx9_ddr_perf.c                   |   6 +-
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c        |   4 +-
 include/asm-generic/numa.h                         |   2 +
 include/linux/pci.h                                |   2 +
 include/linux/pci_ids.h                            |   2 +
 include/linux/perf/arm_pmu.h                       |  28 +-
 include/linux/perf/arm_pmuv3.h                     |  34 +-
 tools/include/perf/arm_pmuv3.h                     |  43 +-
 tools/testing/selftests/arm64/abi/tpidr2.c         |  18 +-
 tools/testing/selftests/arm64/fp/sve-test.S        |  10 +
 tools/testing/selftests/arm64/fp/vec-syscfg.c      |  14 +-
 tools/testing/selftests/arm64/fp/za-test.S         |   6 +
 tools/testing/selftests/arm64/fp/zt-test.S         |   5 +
 .../selftests/kvm/aarch64/vpmu_counter_access.c    |   5 +-
 81 files changed, 2301 insertions(+), 806 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
 create mode 100644 drivers/perf/dwc_pcie_pmu.c

