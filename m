Return-Path: <linux-kernel+bounces-101708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0C87AAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AD5B2320E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3FE4C60C;
	Wed, 13 Mar 2024 16:00:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB304BAA6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345622; cv=none; b=rIzVtyAZSklGQK/OLKZaoR6Lbzd58MT9fVzbH/KWCmkzw2pyCyV5N5Z656AhHlSQrEiRygxFE6T9txLme1l4ZPyNnzTSsdYCVUgW2ZhPtb6q4VcMCxtdaKUrJ9P7rRTarpZ86ct9UGi3/LGnLsgrDwpGSbPsEkwawOJymmF0NPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345622; c=relaxed/simple;
	bh=yREVDGtMhrbZjskIIlnDLXnDOKjLf4OeZLNksziv5B0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cH/Bfs/LmJFqR3arAaq03HdfZhN2MUF4PAWJmsclzaR/2th5qV1jAsnDXLQszIxfrHdjq7C2E1QQQWS3IT9YtBlaQWZfdppVnU1ZQsJ0lUduK6x6r+WHXtqXwT58p8yeRiSM0aFEosiJQhjNXnZFlHeJd76BBDmbbJTL07c0js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9262EC43390;
	Wed, 13 Mar 2024 16:00:20 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates
Date: Wed, 13 Mar 2024 16:00:18 +0000
Message-Id: <20240313160018.2603344-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the arm64 updates below for 6.9-rc1. The major features are
support for LPA2 (52-bit VA/PA with 4K and 16K pages), the dpISA
extension and Rust enabled on arm64. The changes are mostly contained
within the usual arch/arm64/, drivers/perf, the arm64 Documentation and
kselftests. The exception is the Rust support which touches some generic
build files.

There are two last-minute reverts: enabling CPUMASK_OFFSTACK on arm64
seems to have caused some issue with the cpufreq/opp drivers (still
debugging); the other is SCTLR_EL1.WXN hardening on arm64, the feature
is no longer applicable with permissions indirection, so the approach
needs revisiting.

So far there's a single conflict with your tree in rust/Makefile:

------------------------8<-----------------------------
diff --cc rust/Makefile
index a78fcf4004b0,fe045dbc701e..1eaefc34f4b7
--- a/rust/Makefile
+++ b/rust/Makefile
@@@ -434,8 -435,11 +435,11 @@@ $(obj)/core.o: private skip_clippy = 
  $(obj)/core.o: private skip_flags = -Dunreachable_pub
  $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
  $(obj)/core.o: private rustc_target_flags = $(core-cfgs)
- $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
+ $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 -	$(call if_changed_dep,rustc_library)
 +	+$(call if_changed_dep,rustc_library)
+ ifneq ($(or $(CONFIG_X86_64),$(CONFIG_LOONGARCH)),)
+ $(obj)/core.o: scripts/target.json
+ endif
  
  $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
  $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
------------------------8<-----------------------------

I'll expect one or two more conflicts with the KVM tree when that gets
pulled in but the resolutions in -next are correct.

Thanks.

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to 1ef21fcd6a50f011680dbbd678c1bea8e3f67ab9:

  Revert "mm: add arch hook to validate mmap() prot flags" (2024-03-13 10:59:38 +0000)

----------------------------------------------------------------
arm64 updates for 6.9:

* Reorganise the arm64 kernel VA space and add support for LPA2 (at
  stage 1, KVM stage 2 was merged earlier) - 52-bit VA/PA address range
  with 4KB and 16KB pages

* Enable Rust on arm64

* Support for the 2023 dpISA extensions (data processing ISA), host only

* arm64 perf updates:

  - StarFive's StarLink (integrates one or more CPU cores with a shared
    L3 memory system) PMU support

  - Enable HiSilicon Erratum 162700402 quirk for HIP09

  - Several updates for the HiSilicon PCIe PMU driver

  - Arm CoreSight PMU support

  - Convert all drivers under drivers/perf/ to use .remove_new()

* Miscellaneous:

  - Don't enable workarounds for "rare" errata by default

  - Clean up the DAIF flags handling for EL0 returns (in preparation for
    NMI support)

  - Kselftest update for ptrace()

  - Update some of the sysreg field definitions

  - Slight improvement in the code generation for inline asm I/O
    accessors to permit offset addressing

  - kretprobes: acquire regs via a BRK exception (previously done via a
    trampoline handler)

  - SVE/SME cleanups, comment updates

  - Allow CALL_OPS+CC_OPTIMIZE_FOR_SIZE with clang (previously disabled
    due to gcc silently ignoring -falign-functions=N)

----------------------------------------------------------------
Anshuman Khandual (4):
      arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
      arm64/sysreg: Update ID_DFR0_EL1 register fields
      arm64/sysreg: Update ID_AA64DFR0_EL1 register
      arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an watchpoint exception

Ard Biesheuvel (53):
      arm64: mm: Move PCI I/O emulation region above the vmemmap region
      arm64: mm: Move fixmap region above vmemmap region
      arm64: ptdump: Allow all region boundaries to be defined at boot time
      arm64: ptdump: Discover start of vmemmap region at runtime
      arm64: vmemmap: Avoid base2 order of struct page size to dimension region
      arm64: mm: Reclaim unused vmemmap region for vmalloc use
      arm64: kaslr: Adjust randomization range dynamically
      arm64: kernel: Manage absolute relocations in code built under pi/
      arm64: kernel: Don't rely on objcopy to make code under pi/ __init
      arm64: head: move relocation handling to C code
      arm64: idreg-override: Move to early mini C runtime
      arm64: kernel: Remove early fdt remap code
      arm64: head: Clear BSS and the kernel page tables in one go
      arm64: Move feature overrides into the BSS section
      arm64: head: Run feature override detection before mapping the kernel
      arm64: head: move dynamic shadow call stack patching into early C runtime
      arm64: cpufeature: Add helper to test for CPU feature overrides
      arm64: kaslr: Use feature override instead of parsing the cmdline again
      arm64: idreg-override: Create a pseudo feature for rodata=off
      arm64: Add helpers to probe local CPU for PAC and BTI support
      arm64: head: allocate more pages for the kernel mapping
      arm64: head: move memstart_offset_seed handling to C code
      arm64: mm: Make kaslr_requires_kpti() a static inline
      arm64: mmu: Make __cpu_replace_ttbr1() out of line
      arm64: head: Move early kernel mapping routines into C code
      arm64: mm: Use 48-bit virtual addressing for the permanent ID map
      arm64: pgtable: Decouple PGDIR size macros from PGD/PUD/PMD levels
      arm64: kernel: Create initial ID map from C code
      arm64: mm: avoid fixmap for early swapper_pg_dir updates
      arm64: mm: omit redundant remap of kernel image
      arm64: Revert "mm: provide idmap pointer to cpu_replace_ttbr1()"
      arm64: mm: Handle LVA support as a CPU feature
      arm64: mm: Add feature override support for LVA
      arm64: Avoid #define'ing PTE_MAYBE_NG to 0x0 for asm use
      arm64: Add ESR decoding for exceptions involving translation level -1
      arm64: mm: Wire up TCR.DS bit to PTE shareability fields
      arm64: mm: Add LPA2 support to phys<->pte conversion routines
      arm64: mm: Add definitions to support 5 levels of paging
      arm64: mm: add LPA2 and 5 level paging support to G-to-nG conversion
      arm64: Enable LPA2 at boot if supported by the system
      arm64: mm: Add 5 level paging support to fixmap and swapper handling
      arm64: kasan: Reduce minimum shadow alignment and enable 5 level paging
      arm64: mm: Add support for folding PUDs at runtime
      arm64: ptdump: Disregard unaddressable VA space
      arm64: ptdump: Deal with translation levels folded at runtime
      arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for runtime levels
      arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs
      arm64: defconfig: Enable LPA2 support
      mm: add arch hook to validate mmap() prot flags
      arm64: mm: add support for WXN memory translation attribute
      arm64: mm: Make PUD folding check in set_pud() a runtime check
      arm64/mm: Use generic __pud_free() helper in pud_free() implementation
      arm64/mm: Avoid ID mapping of kpti flag if it is no longer needed

Bartosz Golaszewski (1):
      arm64: gitignore: ignore relacheck

Catalin Marinas (5):
      Merge branches 'for-next/reorg-va-space', 'for-next/rust-for-arm64', 'for-next/misc', 'for-next/daif-cleanup', 'for-next/kselftest', 'for-next/documentation', 'for-next/sysreg' and 'for-next/dpisa', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/stage1-lpa2' into for-next/core
      Revert "ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512"
      Revert "arm64: mm: add support for WXN memory translation attribute"
      Revert "mm: add arch hook to validate mmap() prot flags"

Christoph Lameter (Ampere) (1):
      ARM64: Dynamically allocate cpumasks and increase supported CPUs to 512

Dawei Li (1):
      arm64: remove unneeded BUILD_BUG_ON assertion

Jamie Cunliffe (2):
      rust: Refactor the build target to allow the use of builtin targets
      arm64: rust: Enable Rust support for AArch64

Ji Sheng Teoh (4):
      perf: starfive: Add StarLink PMU support
      dt-bindings: perf: starfive: Add JH8100 StarLink PMU
      docs: perf: Add description for StarFive's StarLink PMU
      MAINTAINERS: Add entry for StarFive StarLink PMU

Jinjie Ruan (1):
      arm64: Remove enable_daif macro

Junhao He (5):
      drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
      drivers/perf: hisi_pcie: Check the target filter properly
      drivers/perf: hisi_pcie: Relax the check on related events
      drivers/perf: hisi_pcie: Merge find_related_event() and get_event_idx()
      docs: perf: Update usage for target filter of hisi-pcie-pmu

Kemeng Shi (1):
      arm64: make member of struct pt_regs and it's offset macro in the same order

Leonardo Bras (1):
      arm64: remove unnecessary ifdefs around is_compat_task()

Liao Chang (1):
      arm64: cpufeatures: Clean up temporary variable to simplify code

Marc Zyngier (1):
      arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and VARange

Mark Brown (17):
      kselftest/arm64: Test that ptrace takes effect in the target process
      arm64/sve: Remove bitrotted comment about syscall behaviour
      arm64/sme: Fix cut'n'paste in ABI document
      arm64/fp: Clarify effect of setting an unsupported system VL
      arm64/sme: Remove spurious 'is' in SME documentation
      arm64/sve: Document that __SVE_VQ_MAX is much larger than needed
      arm64/sve: Ensure that all fields in ZCR_EL1 are set to known values
      arm64/sme: Ensure that all fields in SMCR_EL1 are set to known values
      arm64/cpufeature: Hook new identification registers up to cpufeature
      arm64/fpsimd: Enable host kernel access to FPMR
      arm64/fpsimd: Support FEAT_FPMR
      arm64/signal: Add FPMR signal handling
      arm64/ptrace: Expose FPMR via ptrace
      arm64/hwcap: Define hwcaps for 2023 DPISA features
      kselftest/arm64: Handle FPMR context in generic signal frame parser
      kselftest/arm64: Add basic FPMR test
      kselftest/arm64: Add 2023 DPISA hwcap test coverage

Mark Rutland (5):
      arm64: io: permit offset addressing
      arm64: Simplify do_notify_resume() DAIF masking
      arm64: Move do_notify_resume() to entry-common.c
      arm64: Unmask Debug + SError in do_notify_resume()
      arm64: kretprobes: acquire the regs via a BRK exception

Robin Murphy (6):
      perf/arm-cmn: Improve debugfs pretty-printing for large configs
      perf/arm_cspmu: Simplify initialisation
      perf/arm_cspmu: Simplify attribute groups
      perf/arm_cspmu: Simplify counter reset
      dt-bindings/perf: Add Arm CoreSight PMU
      perf/arm_cspmu: Add devicetree support

Ryo Takakura (1):
      arm64: Update setup_arch() comment on interrupt masking

Stephen Boyd (1):
      arm64: ftrace: Don't forbid CALL_OPS+CC_OPTIMIZE_FOR_SIZE with Clang

Uwe Kleine-König (18):
      perf: alibaba_uncore_drw: Convert to platform remove callback returning void
      perf: amlogic: Convert to platform remove callback returning void
      perf: arm-cci: Convert to platform remove callback returning void
      perf: arm-ccn: Convert to platform remove callback returning void
      perf: arm-cmn: Convert to platform remove callback returning void
      perf: arm_cspmu: Convert to platform remove callback returning void
      perf: arm_dmc620: Convert to platform remove callback returning void
      perf: arm_dsu: Convert to platform remove callback returning void
      perf: arm_smmuv3: Convert to platform remove callback returning void
      perf: arm_spe: Convert to platform remove callback returning void
      perf: fsl_imx8_ddr: Convert to platform remove callback returning void
      perf: fsl_imx9_ddr: Convert to platform remove callback returning void
      perf: hisilicon: Convert to platform remove callback returning void
      perf: marvell_cn10k_ddr: Convert to platform remove callback returning void
      perf: marvell_cn10k_tad: Convert to platform remove callback returning void
      perf: qcom_l2: Convert to platform remove callback returning void
      perf: thunderx2: Convert to platform remove callback returning void
      perf: xgene: Convert to platform remove callback returning void

Will Deacon (2):
      arm64: errata: Don't enable workarounds for "rare" errata by default
      perf: starfive: Only allow COMPILE_TEST for 64-bit architectures

Yicong Yang (5):
      drivers/perf: hisi_pcie: Rename hisi_pcie_pmu_{config,clear}_filter()
      drivers/perf: hisi_pcie: Introduce hisi_pcie_pmu_get_event_ctrl_val()
      drivers/perf: hisi_pcie: Fix incorrect counting under metric mode
      drivers/perf: hisi_pcie: Add more events for counting TLP bandwidth
      docs: perf: Fix build warning of hisi-pcie-pmu.rst

 Documentation/admin-guide/perf/hisi-pcie-pmu.rst   |   32 +-
 Documentation/admin-guide/perf/index.rst           |    1 +
 .../admin-guide/perf/starfive_starlink_pmu.rst     |   46 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   49 +
 Documentation/arch/arm64/silicon-errata.rst        |    5 +-
 Documentation/arch/arm64/sme.rst                   |   11 +-
 Documentation/arch/arm64/sve.rst                   |   10 +-
 .../bindings/perf/arm,coresight-pmu.yaml           |   39 +
 .../perf/starfive,jh8100-starlink-pmu.yaml         |   46 +
 Documentation/rust/arch-support.rst                |    1 +
 MAINTAINERS                                        |    7 +
 Makefile                                           |    1 -
 arch/arm64/Kconfig                                 |   55 +-
 arch/arm64/Makefile                                |    4 +
 arch/arm64/configs/defconfig                       |    1 -
 arch/arm64/include/asm/archrandom.h                |    2 -
 arch/arm64/include/asm/assembler.h                 |   59 +-
 arch/arm64/include/asm/brk-imm.h                   |    2 +
 arch/arm64/include/asm/cpu.h                       |    3 +
 arch/arm64/include/asm/cpufeature.h                |  113 ++
 arch/arm64/include/asm/elf.h                       |   10 +-
 arch/arm64/include/asm/esr.h                       |   13 +-
 arch/arm64/include/asm/exception.h                 |    2 +-
 arch/arm64/include/asm/fixmap.h                    |    2 +-
 arch/arm64/include/asm/fpsimd.h                    |    4 +-
 arch/arm64/include/asm/hw_breakpoint.h             |    1 -
 arch/arm64/include/asm/hwcap.h                     |   15 +
 arch/arm64/include/asm/io.h                        |   12 +-
 arch/arm64/include/asm/kasan.h                     |    2 -
 arch/arm64/include/asm/kernel-pgtable.h            |  103 +-
 arch/arm64/include/asm/kvm_arm.h                   |    2 +-
 arch/arm64/include/asm/kvm_emulate.h               |   10 +-
 arch/arm64/include/asm/kvm_host.h                  |    1 +
 arch/arm64/include/asm/memory.h                    |   31 +-
 arch/arm64/include/asm/mmu.h                       |   40 +-
 arch/arm64/include/asm/mmu_context.h               |   53 +-
 arch/arm64/include/asm/pgalloc.h                   |   52 +-
 arch/arm64/include/asm/pgtable-hwdef.h             |   33 +-
 arch/arm64/include/asm/pgtable-prot.h              |   20 +-
 arch/arm64/include/asm/pgtable-types.h             |    6 +
 arch/arm64/include/asm/pgtable.h                   |  237 ++-
 arch/arm64/include/asm/processor.h                 |    4 +
 arch/arm64/include/asm/scs.h                       |   36 +-
 arch/arm64/include/asm/setup.h                     |    3 -
 arch/arm64/include/asm/tlb.h                       |    3 +
 arch/arm64/include/uapi/asm/hwcap.h                |   15 +
 arch/arm64/include/uapi/asm/sigcontext.h           |    8 +
 arch/arm64/include/uapi/asm/sve_context.h          |   11 +
 arch/arm64/kernel/Makefile                         |   13 +-
 arch/arm64/kernel/asm-offsets.c                    |    2 +-
 arch/arm64/kernel/cpufeature.c                     |  182 ++-
 arch/arm64/kernel/cpuinfo.c                        |   18 +
 arch/arm64/kernel/entry-common.c                   |   36 +-
 arch/arm64/kernel/fpsimd.c                         |   18 +
 arch/arm64/kernel/head.S                           |  463 +-----
 arch/arm64/kernel/hw_breakpoint.c                  |    3 +-
 arch/arm64/kernel/image-vars.h                     |   35 +
 arch/arm64/kernel/kaslr.c                          |    4 +-
 arch/arm64/kernel/module.c                         |    2 +-
 arch/arm64/kernel/pi/.gitignore                    |    3 +
 arch/arm64/kernel/pi/Makefile                      |   27 +-
 arch/arm64/kernel/{ => pi}/idreg-override.c        |   78 +-
 arch/arm64/kernel/pi/kaslr_early.c                 |   82 +-
 arch/arm64/kernel/pi/map_kernel.c                  |  253 ++++
 arch/arm64/kernel/pi/map_range.c                   |  105 ++
 arch/arm64/kernel/{ => pi}/patch-scs.c             |   36 +-
 arch/arm64/kernel/pi/pi.h                          |   36 +
 arch/arm64/kernel/pi/relacheck.c                   |  130 ++
 arch/arm64/kernel/pi/relocate.c                    |   64 +
 arch/arm64/kernel/probes/kprobes.c                 |   21 +-
 arch/arm64/kernel/probes/kprobes_trampoline.S      |   78 +-
 arch/arm64/kernel/process.c                        |    3 -
 arch/arm64/kernel/ptrace.c                         |   50 +-
 arch/arm64/kernel/setup.c                          |   27 +-
 arch/arm64/kernel/signal.c                         |   98 +-
 arch/arm64/kernel/sleep.S                          |    3 -
 arch/arm64/kernel/syscall.c                        |    5 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   17 +-
 arch/arm64/kvm/fpsimd.c                            |    1 +
 arch/arm64/kvm/mmu.c                               |   17 +-
 arch/arm64/mm/fault.c                              |   30 +-
 arch/arm64/mm/fixmap.c                             |   39 +-
 arch/arm64/mm/init.c                               |    2 +-
 arch/arm64/mm/kasan_init.c                         |  165 ++-
 arch/arm64/mm/mmap.c                               |    4 +
 arch/arm64/mm/mmu.c                                |  255 ++--
 arch/arm64/mm/pgd.c                                |   17 +-
 arch/arm64/mm/proc.S                               |  116 +-
 arch/arm64/mm/ptdump.c                             |   77 +-
 arch/arm64/tools/cpucaps                           |    2 +
 arch/arm64/tools/sysreg                            |   43 +-
 arch/loongarch/Makefile                            |    1 +
 arch/x86/Makefile                                  |    1 +
 drivers/perf/Kconfig                               |    9 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |    6 +-
 drivers/perf/amlogic/meson_g12_ddr_pmu.c           |    6 +-
 drivers/perf/arm-cci.c                             |    8 +-
 drivers/perf/arm-ccn.c                             |    6 +-
 drivers/perf/arm-cmn.c                             |   14 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |  159 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h                 |    1 +
 drivers/perf/arm_cspmu/nvidia_cspmu.c              |    6 -
 drivers/perf/arm_dmc620_pmu.c                      |    6 +-
 drivers/perf/arm_dsu_pmu.c                         |    6 +-
 drivers/perf/arm_smmuv3_pmu.c                      |    6 +-
 drivers/perf/arm_spe_pmu.c                         |    5 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |    5 +-
 drivers/perf/fsl_imx9_ddr_perf.c                   |    6 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |  102 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c       |    5 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |    5 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |    5 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |    5 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |    5 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |    5 +-
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c        |   42 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c               |    5 +-
 drivers/perf/marvell_cn10k_tad_pmu.c               |    6 +-
 drivers/perf/qcom_l2_pmu.c                         |    5 +-
 drivers/perf/starfive_starlink_pmu.c               |  642 +++++++++
 drivers/perf/thunderx2_pmu.c                       |    5 +-
 drivers/perf/xgene_pmu.c                           |    6 +-
 include/uapi/linux/elf.h                           |    1 +
 rust/Makefile                                      |    6 +-
 scripts/Makefile                                   |    4 +-
 scripts/generate_rust_target.rs                    |    4 +-
 tools/testing/selftests/arm64/abi/hwcap.c          |  217 +++
 tools/testing/selftests/arm64/fp/.gitignore        |    1 +
 tools/testing/selftests/arm64/fp/Makefile          |    5 +-
 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S   |  279 ++++
 tools/testing/selftests/arm64/fp/fp-ptrace.c       | 1503 ++++++++++++++++++++
 tools/testing/selftests/arm64/fp/fp-ptrace.h       |   13 +
 tools/testing/selftests/arm64/signal/.gitignore    |    1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          |   82 ++
 .../selftests/arm64/signal/testcases/testcases.c   |    8 +
 .../selftests/arm64/signal/testcases/testcases.h   |    1 +
 137 files changed, 5513 insertions(+), 1583 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/starfive_starlink_pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/arm,coresight-pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
 create mode 100644 arch/arm64/kernel/pi/.gitignore
 rename arch/arm64/kernel/{ => pi}/idreg-override.c (84%)
 create mode 100644 arch/arm64/kernel/pi/map_kernel.c
 create mode 100644 arch/arm64/kernel/pi/map_range.c
 rename arch/arm64/kernel/{ => pi}/patch-scs.c (89%)
 create mode 100644 arch/arm64/kernel/pi/pi.h
 create mode 100644 arch/arm64/kernel/pi/relacheck.c
 create mode 100644 arch/arm64/kernel/pi/relocate.c
 create mode 100644 drivers/perf/starfive_starlink_pmu.c
 create mode 100644 tools/testing/selftests/arm64/fp/fp-ptrace-asm.S
 create mode 100644 tools/testing/selftests/arm64/fp/fp-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/fp-ptrace.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c

