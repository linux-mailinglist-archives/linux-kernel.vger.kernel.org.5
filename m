Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5326D78E371
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbjH3XsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjH3XsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:48:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FECF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693439277; x=1724975277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L0wej8rPj9anMXxjV/59tYFfOhZsGJInwPKEAM/ce60=;
  b=Gjo+tZqfeC1e6ri4UUhuz6L7I+QcEVN2b2nk9Z9p3hFzz3uWC/nSCPYr
   OXHvhpHnnee0ugpSBAVgTWSq+a+6LN293rIKPDfpP4BUurjU0OFLMZKsq
   Gzb7qVdE+EWklP0ksqf1Fn9hHnSGmDHStFzdfUc+xmIQyg55j5Bh3rbB2
   xxwsJq43+/TIw5v7JiqcPwQxtoFmlahiNY4+hLDdgCkAIWxQDYqIYR3RG
   OWlfD8zZECNE6PwyasAmuY+KeMRy/nuFGb7+iGIgX6PLEBHPRJD3Fvzlm
   7Pa3D5Q5AH/v2vyyBC+/7Jsi13qaIY3rqIVPbKYDGHzBMlrMhBvTeSYRE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462153735"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="462153735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809327675"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="809327675"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2023 16:47:55 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/shstk for 6.6-rc1
Date:   Wed, 30 Aug 2023 16:47:52 -0700
Message-Id: <20230830234752.19858-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the long awaited x86 shadow stack support.  We first sent this
your way for 6.4 in a form that was harder to review.

Since then, the main deltas addressed concerns around pte_mkwrite()
and the Dirty bit shifting logic. These are mostly unchanged from the
v9 version of the patchset in June[0].

There is one last-minute fix in here to clean up a sparse warnings,
but it should not even affect code generation.

There's also a fix in here to silence an objtool warning originating
from the IBT selftest.  IBT is functionally quite orthogonal to shadow
stacks except for their shared control protection handler (#CP), which
got moved around by the shadow stack series.  Since the fix touches
that handler, it was easiest to just provide it on top of shadow
stacks, so here it is.

[0] https://lore.kernel.org/lkml/CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com/

--

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_shstk_for_6.6-rc1

for you to fetch changes up to 1fe428d3692fb10a0e8d85fafe719b154e43ad4e:

  x86/shstk: Change order of __user in type (2023-08-30 10:35:53 -0700)

----------------------------------------------------------------
Add x86 shadow stack support
Convert IBT selftest to asm to fix objtool warning

----------------------------------------------------------------
Dave Hansen (1):
      x86/kbuild: Fix Documentation/ reference

Josh Poimboeuf (1):
      x86/ibt: Convert IBT selftest to asm

Mike Rapoport (1):
      x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (41):
      mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
      mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()
      mm: Make pte_mkwrite() take a VMA
      x86/shstk: Add Kconfig option for shadow stack
      x86/traps: Move control protection handler to separate file
      x86/cpufeatures: Add CPU feature flags for shadow stacks
      x86/mm: Move pmd_write(), pud_write() up in the file
      x86/mm: Introduce _PAGE_SAVED_DIRTY
      x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
      x86/mm: Start actually marking _PAGE_SAVED_DIRTY
      x86/mm: Remove _PAGE_DIRTY from kernel RO pages
      x86/mm: Check shadow stack page fault errors
      mm: Add guard pages around a shadow stack.
      mm: Warn on shadow stack memory in wrong vma
      x86/mm: Warn if create Write=0,Dirty=1 with raw prot
      mm/mmap: Add shadow stack pages to memory accounting
      x86/mm: Introduce MAP_ABOVE4G
      x86/mm: Teach pte_mkwrite() about stack memory
      mm: Don't allow write GUPs to shadow stack memory
      Documentation/x86: Add CET shadow stack description
      x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
      x86/fpu: Add helper for modifying xstate
      x86: Introduce userspace API for shadow stack
      x86/shstk: Add user control-protection fault handler
      x86/shstk: Add user-mode shadow stack support
      x86/shstk: Handle thread shadow stack
      x86/shstk: Introduce routines modifying shstk
      x86/shstk: Handle signals for shadow stack
      x86/shstk: Check that SSP is aligned on sigreturn
      x86/shstk: Check that signal frame is shadow stack mem
      x86/shstk: Introduce map_shadow_stack syscall
      x86/shstk: Support WRSS for userspace
      x86: Expose thread features in /proc/$PID/status
      x86/shstk: Wire in shadow stack interface
      x86/cpufeatures: Enable CET CR4 bit for shadow stack
      selftests/x86: Add shadow stack test
      x86: Add PTRACE interface for shadow stack
      x86/shstk: Add ARCH_SHSTK_STATUS
      x86/shstk: Move arch detail comment out of core mm
      x86/shstk: Don't retry vm_munmap() on -EINTR
      x86/shstk: Change order of __user in type

Yu-cheng Yu (3):
      mm: Re-introduce vm_flags to do_mmap()
      mm: Move VM_UFFD_MINOR_BIT from 37 to 38
      mm: Introduce VM_SHADOW_STACK for shadow stack memory

 Documentation/arch/x86/index.rst                |   1 +
 Documentation/arch/x86/shstk.rst                | 179 +++++
 Documentation/filesystems/proc.rst              |   1 +
 Documentation/mm/arch_pgtable_helpers.rst       |  12 +-
 arch/Kconfig                                    |   8 +
 arch/alpha/include/asm/pgtable.h                |   2 +-
 arch/arc/include/asm/hugepage.h                 |   2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h       |   2 +-
 arch/arm/include/asm/pgtable-3level.h           |   2 +-
 arch/arm/include/asm/pgtable.h                  |   2 +-
 arch/arm/kernel/signal.c                        |   2 +-
 arch/arm64/include/asm/pgtable.h                |   4 +-
 arch/arm64/kernel/signal.c                      |   2 +-
 arch/arm64/kernel/signal32.c                    |   2 +-
 arch/arm64/mm/trans_pgd.c                       |   4 +-
 arch/csky/include/asm/pgtable.h                 |   2 +-
 arch/hexagon/include/asm/pgtable.h              |   2 +-
 arch/ia64/include/asm/pgtable.h                 |   2 +-
 arch/loongarch/include/asm/pgtable.h            |   4 +-
 arch/m68k/include/asm/mcf_pgtable.h             |   2 +-
 arch/m68k/include/asm/motorola_pgtable.h        |   2 +-
 arch/m68k/include/asm/sun3_pgtable.h            |   2 +-
 arch/microblaze/include/asm/pgtable.h           |   2 +-
 arch/mips/include/asm/pgtable.h                 |   6 +-
 arch/nios2/include/asm/pgtable.h                |   2 +-
 arch/openrisc/include/asm/pgtable.h             |   2 +-
 arch/parisc/include/asm/pgtable.h               |   2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h    |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h    |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h    |   4 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h    |   4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h    |   2 +-
 arch/riscv/include/asm/pgtable.h                |   6 +-
 arch/s390/Kconfig                               |   1 +
 arch/s390/include/asm/hugetlb.h                 |   2 +-
 arch/s390/include/asm/pgtable.h                 |   4 +-
 arch/s390/mm/pageattr.c                         |   4 +-
 arch/sh/include/asm/pgtable_32.h                |   4 +-
 arch/sparc/include/asm/pgtable_32.h             |   2 +-
 arch/sparc/include/asm/pgtable_64.h             |   6 +-
 arch/sparc/kernel/signal32.c                    |   2 +-
 arch/sparc/kernel/signal_64.c                   |   2 +-
 arch/um/include/asm/pgtable.h                   |   2 +-
 arch/x86/Kconfig                                |  24 +
 arch/x86/Kconfig.assembler                      |   5 +
 arch/x86/entry/syscalls/syscall_64.tbl          |   1 +
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/disabled-features.h        |  16 +-
 arch/x86/include/asm/fpu/api.h                  |   9 +
 arch/x86/include/asm/fpu/regset.h               |   7 +-
 arch/x86/include/asm/fpu/sched.h                |   3 +-
 arch/x86/include/asm/fpu/types.h                |  16 +-
 arch/x86/include/asm/fpu/xstate.h               |   6 +-
 arch/x86/include/asm/idtentry.h                 |   2 +-
 arch/x86/include/asm/mmu_context.h              |   2 +
 arch/x86/include/asm/pgtable.h                  | 302 +++++++-
 arch/x86/include/asm/pgtable_types.h            |  42 +-
 arch/x86/include/asm/processor.h                |   8 +
 arch/x86/include/asm/shstk.h                    |  38 +
 arch/x86/include/asm/special_insns.h            |  13 +
 arch/x86/include/asm/tlbflush.h                 |   3 +-
 arch/x86/include/asm/trap_pf.h                  |   2 +
 arch/x86/include/asm/traps.h                    |  15 +-
 arch/x86/include/uapi/asm/mman.h                |   4 +
 arch/x86/include/uapi/asm/prctl.h               |  12 +
 arch/x86/kernel/Makefile                        |   5 +
 arch/x86/kernel/cet.c                           | 131 ++++
 arch/x86/kernel/cpu/common.c                    |  35 +-
 arch/x86/kernel/cpu/cpuid-deps.c                |   1 +
 arch/x86/kernel/cpu/proc.c                      |  23 +
 arch/x86/kernel/fpu/core.c                      |  54 +-
 arch/x86/kernel/fpu/regset.c                    |  81 +++
 arch/x86/kernel/fpu/xstate.c                    |  90 ++-
 arch/x86/kernel/ibt_selftest.S                  |  17 +
 arch/x86/kernel/idt.c                           |   2 +-
 arch/x86/kernel/process.c                       |  21 +-
 arch/x86/kernel/process_64.c                    |   8 +
 arch/x86/kernel/ptrace.c                        |  12 +
 arch/x86/kernel/shstk.c                         | 550 +++++++++++++++
 arch/x86/kernel/signal.c                        |   1 +
 arch/x86/kernel/signal_32.c                     |   2 +-
 arch/x86/kernel/signal_64.c                     |   8 +-
 arch/x86/kernel/sys_x86_64.c                    |   6 +-
 arch/x86/kernel/traps.c                         |  87 ---
 arch/x86/mm/fault.c                             |  22 +
 arch/x86/mm/pat/set_memory.c                    |   4 +-
 arch/x86/mm/pgtable.c                           |  40 ++
 arch/x86/xen/enlighten_pv.c                     |   2 +-
 arch/x86/xen/mmu_pv.c                           |   2 +-
 arch/x86/xen/xen-asm.S                          |   2 +-
 arch/xtensa/include/asm/pgtable.h               |   2 +-
 fs/aio.c                                        |   2 +-
 fs/proc/array.c                                 |   6 +
 fs/proc/task_mmu.c                              |   3 +
 include/asm-generic/hugetlb.h                   |   2 +-
 include/linux/mm.h                              |  47 +-
 include/linux/mman.h                            |   4 +
 include/linux/pgtable.h                         |  28 +
 include/linux/proc_fs.h                         |   1 +
 include/linux/syscalls.h                        |   1 +
 include/uapi/asm-generic/siginfo.h              |   3 +-
 include/uapi/linux/elf.h                        |   2 +
 ipc/shm.c                                       |   2 +-
 kernel/sys_ni.c                                 |   1 +
 mm/debug_vm_pgtable.c                           |  12 +-
 mm/gup.c                                        |   2 +-
 mm/huge_memory.c                                |  11 +-
 mm/internal.h                                   |   4 +-
 mm/memory.c                                     |   5 +-
 mm/migrate.c                                    |   2 +-
 mm/migrate_device.c                             |   2 +-
 mm/mmap.c                                       |  14 +-
 mm/mprotect.c                                   |   2 +-
 mm/nommu.c                                      |   4 +-
 mm/userfaultfd.c                                |   2 +-
 mm/util.c                                       |   2 +-
 tools/testing/selftests/x86/Makefile            |   2 +-
 tools/testing/selftests/x86/test_shadow_stack.c | 884 ++++++++++++++++++++++++
 118 files changed, 2789 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/arch/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/ibt_selftest.S
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c
