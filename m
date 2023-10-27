Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FA7D9FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJ0STn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0STl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEF5AC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:19:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70819C433C8;
        Fri, 27 Oct 2023 18:19:37 +0000 (UTC)
Date:   Fri, 27 Oct 2023 19:19:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.7
Message-ID: <ZTv_N8NKLb0ifLAj@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the main arm64 pull request for 6.7. No major architecture
features this time around, just some new HWCAP definitions, support for
the Ampere SoC PMUs and a few fixes/cleanups. The bulk of the changes is
reworking of the CPU capability checking code (cpus_have_cap() etc).
Thanks.

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 14dcf78a6c042dd9421b11485b394c6273568bca:

  Merge branch 'for-next/cpus_have_const_cap' into for-next/core (2023-10-26 17:10:18 +0100)

----------------------------------------------------------------
arm64 updates for 6.7:

* Major refactoring of the CPU capability detection logic resulting in
  the removal of the cpus_have_const_cap() function and migrating the
  code to "alternative" branches where possible

* Backtrace/kgdb: use IPIs and pseudo-NMI

* Perf and PMU:

  - Add support for Ampere SoC PMUs

  - Multi-DTC improvements for larger CMN configurations with multiple
    Debug & Trace Controllers

  - Rework the Arm CoreSight PMU driver to allow separate registration of
    vendor backend modules

  - Fixes: add missing MODULE_DEVICE_TABLE to the amlogic perf
    driver; use device_get_match_data() in the xgene driver; fix NULL
    pointer dereference in the hisi driver caused by calling
    cpuhp_state_remove_instance(); use-after-free in the hisi driver

* HWCAP updates:

  - FEAT_SVE_B16B16 (BFloat16)

  - FEAT_LRCPC3 (release consistency model)

  - FEAT_LSE128 (128-bit atomic instructions)

* SVE: remove a couple of pseudo registers from the cpufeature code.
  There is logic in place already to detect mismatched SVE features

* Miscellaneous:

  - Reduce the default swiotlb size (currently 64MB) if no ZONE_DMA
    bouncing is needed. The buffer is still required for small kmalloc()
    buffers

  - Fix module PLT counting with !RANDOMIZE_BASE

  - Restrict CPU_BIG_ENDIAN to LLVM IAS 15.x or newer move
    synchronisation code out of the set_ptes() loop

  - More compact cpufeature displaying enabled cores

  - Kselftest updates for the new CPU features

----------------------------------------------------------------
Andre Przywara (1):
      clocksource/drivers/arm_arch_timer: limit XGene-1 workaround

Anshuman Khandual (2):
      drivers: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
      drivers: perf: arm_pmuv3: Drop some unused arguments from armv8_pmu_init()

Besar Wicaksono (1):
      perf: arm_cspmu: Separate Arm and vendor module

Catalin Marinas (7):
      arm64: swiotlb: Reduce the default size if no ZONE_DMA bouncing needed
      arm64: Mark the 'addr' argument to set_ptes() and __set_pte_at() as unused
      Merge branches 'for-next/sve-remove-pseudo-regs', 'for-next/backtrace-ipi', 'for-next/kselftest', 'for-next/misc' and 'for-next/cpufeat-display-cores', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/feat_sve_b16b16' into for-next/core
      Merge branch 'for-next/feat_lrcpc3' into for-next/core
      Merge branch 'for-next/feat_lse128' into for-next/core
      Merge branch 'for-next/cpus_have_const_cap' into for-next/core

Douglas Anderson (7):
      irqchip/gic-v3: Enable support for SGIs to act as NMIs
      arm64: idle: Tag the arm64 idle functions as __cpuidle
      arm64: smp: Add arch support for backtrace using pseudo-NMI
      arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
      arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
      arm64: smp: Mark IPI globals as __ro_after_init
      arm64: smp: Don't directly call arch_smp_send_reschedule() for wakeup

Gavin Shan (1):
      arm64: Remove system_uses_lse_atomics()

Hao Chen (1):
      drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process

Ilkka Koskinen (5):
      perf: arm_cspmu: Split 64-bit write to 32-bit writes
      perf: arm_cspmu: Support implementation specific filters
      perf: arm_cspmu: Support implementation specific validation
      perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU
      docs/perf: Add ampere_cspmu to toctree to fix a build warning

James Morse (1):
      arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper

Jeremy Linton (2):
      arm64: cpufeature: Display the set of cores with a feature
      arm64: cpufeature: Change DBM to display enabled cores

Joey Gouly (4):
      arm64: add FEAT_LRCPC3 HWCAP
      selftests/arm64: add HWCAP2_LRCPC3 test
      arm64: add FEAT_LSE128 HWCAP
      kselftest/arm64: add FEAT_LSE128 to hwcap test

Junhao He (1):
      perf: hisi: Fix use-after-free when register pmu fails

Marek Szyprowski (1):
      perf/amlogic: add missing MODULE_DEVICE_TABLE

Maria Yu (1):
      arm64: module: Fix PLT counting when CONFIG_RANDOMIZE_BASE=n

Mark Brown (5):
      arm64/sve: Remove ZCR pseudo register from cpufeature code
      arm64/sve: Remove SMCR pseudo register from cpufeature code
      kselftest/arm64: Validate SVCR in streaming SVE stress test
      arm64/sve: Report FEAT_SVE_B16B16 to userspace
      kselftest/arm64: Verify HWCAP2_SVE_B16B16

Mark Rutland (40):
      arm64: smp: Remove dedicated wakeup IPI
      arm64: smp: avoid NMI IPIs with broken MediaTek FW
      clocksource/drivers/arm_arch_timer: Initialize evtstrm after finalizing cpucaps
      arm64/arm: xen: enlighten: Fix KPTI checks
      arm64: Factor out cpucap definitions
      arm64: Add cpucap_is_possible()
      arm64: Add cpus_have_final_boot_cap()
      arm64: Rework setup_cpu_features()
      arm64: Fixup user features at boot time
      arm64: Split kpti_install_ng_mappings()
      arm64: kvm: Use cpus_have_final_cap() explicitly
      arm64: Explicitly save/restore CPACR when probing SVE and SME
      arm64: Use build-time assertions for cpucap ordering
      arm64: Rename SVE/SME cpu_enable functions
      arm64: Use a positive cpucap for FP/SIMD
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_{ADDRESS,GENERIC}_AUTH
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_ARMv8_4_TTL
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_BTI
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_CACHE_DIC
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_CNP
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_DIT
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_GIC_PRIO_MASKING
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_PAN
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_EPAN
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_RNG
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_WFXT
      arm64: Avoid cpus_have_const_cap() for ARM64_HAS_TLB_RANGE
      arm64: Avoid cpus_have_const_cap() for ARM64_MTE
      arm64: Avoid cpus_have_const_cap() for ARM64_SSBS
      arm64: Avoid cpus_have_const_cap() for ARM64_SPECTRE_V2
      arm64: Avoid cpus_have_const_cap() for ARM64_{SVE,SME,SME2,FA64}
      arm64: Avoid cpus_have_const_cap() for ARM64_UNMAP_KERNEL_AT_EL0
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_843419
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_1542419
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_1742098
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_2645198
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_CAVIUM_23154
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_NVIDIA_CARMEL_CNP
      arm64: Avoid cpus_have_const_cap() for ARM64_WORKAROUND_REPEAT_TLBI
      arm64: Remove cpus_have_const_cap()

Nathan Chancellor (1):
      arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer

Rob Herring (1):
      drivers/perf: xgene: Use device_get_match_data()

Robin Murphy (3):
      perf/arm-cmn: Fix DTC domain detection
      perf/arm-cmn: Rework DTC counters (again)
      perf/arm-cmn: Enable per-DTC counter allocation

Ryan Roberts (1):
      arm64/mm: Hoist synchronization out of set_ptes() loop

Yicong Yang (2):
      drivers/perf: hisi_pcie: Check the type first in pmu::event_init()
      drivers/perf: hisi_pcie: Initialize event->cpu only on success

 Documentation/admin-guide/perf/ampere_cspmu.rst    |  29 +++
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/arch/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   9 +
 arch/arm/xen/enlighten.c                           |  25 +-
 arch/arm64/Kconfig                                 |   2 +
 arch/arm64/include/asm/Kbuild                      |   2 +-
 arch/arm64/include/asm/alternative-macros.h        |   8 +-
 arch/arm64/include/asm/arch_gicv3.h                |   8 +
 arch/arm64/include/asm/archrandom.h                |   2 +-
 arch/arm64/include/asm/cacheflush.h                |   2 +-
 arch/arm64/include/asm/cpu.h                       |   6 -
 arch/arm64/include/asm/cpucaps.h                   |  67 +++++
 arch/arm64/include/asm/cpufeature.h                |  98 ++++----
 arch/arm64/include/asm/cputype.h                   |   3 +-
 arch/arm64/include/asm/fpsimd.h                    |  36 ++-
 arch/arm64/include/asm/hwcap.h                     |   3 +
 arch/arm64/include/asm/irq.h                       |   3 +
 arch/arm64/include/asm/irqflags.h                  |  20 +-
 arch/arm64/include/asm/kvm_emulate.h               |   4 +-
 arch/arm64/include/asm/kvm_host.h                  |   2 +-
 arch/arm64/include/asm/kvm_mmu.h                   |   2 +-
 arch/arm64/include/asm/lse.h                       |   9 +-
 arch/arm64/include/asm/mmu.h                       |   2 +-
 arch/arm64/include/asm/mmu_context.h               |  28 ++-
 arch/arm64/include/asm/module.h                    |   3 +-
 arch/arm64/include/asm/mte.h                       |   4 +-
 arch/arm64/include/asm/pgtable-prot.h              |   6 +-
 arch/arm64/include/asm/pgtable.h                   |  34 ++-
 arch/arm64/include/asm/smp.h                       |   4 +-
 arch/arm64/include/asm/spectre.h                   |   2 +-
 arch/arm64/include/asm/tlbflush.h                  |   7 +-
 arch/arm64/include/asm/vectors.h                   |   2 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   3 +
 arch/arm64/kernel/acpi_parking_protocol.c          |   2 +-
 arch/arm64/kernel/cpu_errata.c                     |  17 --
 arch/arm64/kernel/cpufeature.c                     | 272 ++++++++++-----------
 arch/arm64/kernel/cpuinfo.c                        |   3 +
 arch/arm64/kernel/efi.c                            |   3 +-
 arch/arm64/kernel/fpsimd.c                         | 149 +++++------
 arch/arm64/kernel/idle.c                           |   4 +-
 arch/arm64/kernel/module-plts.c                    |  13 +-
 arch/arm64/kernel/mte.c                            |   4 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/arm64/kernel/proton-pack.c                    |   2 +-
 arch/arm64/kernel/smp.c                            | 147 ++++++++---
 arch/arm64/kernel/suspend.c                        |  13 +-
 arch/arm64/kernel/sys_compat.c                     |   2 +-
 arch/arm64/kernel/traps.c                          |   2 +-
 arch/arm64/kernel/vdso.c                           |   2 +-
 arch/arm64/kvm/arm.c                               |  10 +-
 arch/arm64/kvm/guest.c                             |   6 +-
 arch/arm64/kvm/hyp/pgtable.c                       |   4 +-
 arch/arm64/kvm/mmu.c                               |   2 +-
 arch/arm64/kvm/sys_regs.c                          |   2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |   2 +-
 arch/arm64/lib/delay.c                             |   2 +-
 arch/arm64/mm/fault.c                              |   2 +-
 arch/arm64/mm/hugetlbpage.c                        |   3 +-
 arch/arm64/mm/init.c                               |  11 +-
 arch/arm64/mm/mmap.c                               |   2 +-
 arch/arm64/mm/mmu.c                                |   3 +-
 arch/arm64/mm/proc.S                               |   3 +-
 arch/arm64/tools/Makefile                          |   4 +-
 arch/arm64/tools/cpucaps                           |   2 +-
 arch/arm64/tools/gen-cpucaps.awk                   |   6 +-
 arch/arm64/tools/sysreg                            |   8 +-
 drivers/acpi/processor_core.c                      |   2 +-
 drivers/clocksource/arm_arch_timer.c               |  36 ++-
 drivers/irqchip/irq-gic-v3.c                       |  82 ++++---
 drivers/perf/amlogic/meson_g12_ddr_pmu.c           |   1 +
 drivers/perf/arm-cmn.c                             | 154 ++++++------
 drivers/perf/arm_cspmu/Kconfig                     |  19 +-
 drivers/perf/arm_cspmu/Makefile                    |   8 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c              | 272 +++++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.c                 | 201 +++++++++++----
 drivers/perf/arm_cspmu/arm_cspmu.h                 |  32 ++-
 drivers/perf/arm_cspmu/nvidia_cspmu.c              |  34 ++-
 drivers/perf/arm_cspmu/nvidia_cspmu.h              |  17 --
 drivers/perf/arm_pmuv3.c                           |  46 +---
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   9 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   4 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   4 +-
 drivers/perf/hisilicon/hns3_pmu.c                  |   8 +-
 drivers/perf/xgene_pmu.c                           |  37 +--
 include/linux/acpi.h                               |   5 +
 include/linux/cpuhotplug.h                         |   2 +
 tools/testing/selftests/arm64/abi/hwcap.c          |  54 ++++
 tools/testing/selftests/arm64/fp/sve-test.S        |  19 ++
 89 files changed, 1459 insertions(+), 734 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 arch/arm64/include/asm/cpucaps.h
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

-- 
Catalin
