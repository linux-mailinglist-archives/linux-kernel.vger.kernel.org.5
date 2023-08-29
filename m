Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE878BE11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjH2FzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjH2Fyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:54:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91021EC;
        Mon, 28 Aug 2023 22:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDE66173E;
        Tue, 29 Aug 2023 05:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F301C433C8;
        Tue, 29 Aug 2023 05:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693288472;
        bh=7CcI1WTWAf61s/P21ULlrQk2i5X581F5xzmo/dkhaIw=;
        h=Date:From:To:Cc:Subject:From;
        b=GFzK38egn+J3bfc/82aR+/G9THqoE3uvK7rEv/rikhurhEwWyNsQtug9yMg1JyqU+
         FkzhvfVkyEz119EFmriHxWzVUEJ1oER67n/u4ZuXnUlR1k+H7CChw0IOhiE6Akf9XK
         YvvO3+2UcsXlZUbAWNnb18M38N7smEZTvm04KdZQ=
Date:   Mon, 28 Aug 2023 22:54:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.6-rc1
Message-Id: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please pull mm.git's non-MM updates for this cycle.

I'm seeing a single conflict in arch/s390/Kconfig.  Stephen's
resolution at
https://lkml.kernel.org/r/20230731093724.1c75858d@canb.auug.org.au
looks a little different - just remove the kexec material and retain
CONFIG_CERT_STORE

Thanks.



The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-08-28-22-48

for you to fetch changes up to dce8f8ed1de1d9d6d27c5ccd202ce4ec163b100c:

  document while_each_thread(), change first_tid() to use for_each_thread() (2023-08-24 16:25:15 -0700)

----------------------------------------------------------------
- An extensive rework of kexec and crash Kconfig from Eric DeVolder
  ("refactor Kconfig to consolidate KEXEC and CRASH options").

- kernel.h slimming work from Andy Shevchenko ("kernel.h: Split out a
  couple of macros to args.h").

- gdb feature work from Kuan-Ying Lee ("Add GDB memory helper
  commands").

- vsprintf inclusion rationalization from Andy Shevchenko
  ("lib/vsprintf: Rework header inclusions").

- Switch the handling of kdump from a udev scheme to in-kernel handling,
  by Eric DeVolder ("crash: Kernel handling of CPU and memory hot
  un/plug").

- Many singleton patches to various parts of the tree

----------------------------------------------------------------
Alexey Dobriyan (4):
      proc: support proc-empty-vm test on i386
      proc: skip proc-empty-vm on anything but amd64 and i386
      adfs: delete unused "union adfs_dirtail" definition
      drivers/char/mem.c: shrink character device's devlist[] array

Andy Shevchenko (9):
      kernel.h: split out COUNT_ARGS() and CONCATENATE() to args.h
      x86/asm: replace custom COUNT_ARGS() & CONCATENATE() implementations
      arm64: smccc: replace custom COUNT_ARGS() & CONCATENATE() implementations
      genetlink: replace custom CONCATENATE() implementation
      drm/i915: Move abs_diff() to math.h
      range.h: Move resource API and constant to respective files
      lib/vsprintf: split out sprintf() and friends
      lib/vsprintf: declare no_hash_pointers in sprintf.h
      kstrtox: consistently use _tolower()

Arnd Bergmann (1):
      gcov: shut up missing prototype warnings for internal stubs

Artem Chernyshev (1):
      fs: ocfs2: namei: check return value of ocfs2_add_entry()

Azeem Shaikh (1):
      acct: replace all non-returning strlcpy with strscpy

Baoquan He (2):
      net: altera-tse: make ALTERA_TSE depend on HAS_IOMEM
      irqchip/al-fic: make AL_FIC depend on HAS_IOMEM

Chengfeng Ye (2):
      ocfs2: cluster: fix potential deadlock on &qs->qs_lock
      ocfs2: cluster: fix potential deadlock on &o2net_debug_lock

Christophe JAILLET (3):
      ipc/sem: use flexible array in 'struct sem_undo'
      ocfs2: use flexible array in 'struct ocfs2_recovery_map'
      ocfs2: Use struct_size()

Colin Ian King (1):
      fs: hfsplus: make extend error rate limited

Douglas Anderson (2):
      nmi_backtrace: allow excluding an arbitrary CPU
      watchdog/hardlockup: avoid large stack frames in watchdog_hardlockup_check()

Eric DeVolder (23):
      kexec: consolidate kexec and crash options into kernel/Kconfig.kexec
      x86/kexec: refactor for kernel/Kconfig.kexec
      arm/kexec: refactor for kernel/Kconfig.kexec
      ia64/kexec: refactor for kernel/Kconfig.kexec
      arm64/kexec: refactor for kernel/Kconfig.kexec
      loongarch/kexec: refactor for kernel/Kconfig.kexec
      m68k/kexec: refactor for kernel/Kconfig.kexec
      mips/kexec: refactor for kernel/Kconfig.kexec
      parisc/kexec: refactor for kernel/Kconfig.kexec
      powerpc/kexec: refactor for kernel/Kconfig.kexec
      riscv/kexec: refactor for kernel/Kconfig.kexec
      s390/kexec: refactor for kernel/Kconfig.kexec
      sh/kexec: refactor for kernel/Kconfig.kexec
      kexec: rename ARCH_HAS_KEXEC_PURGATORY
      remove ARCH_DEFAULT_KEXEC from Kconfig.kexec
      crash: move a few code bits to setup support of crash hotplug
      crash: add generic infrastructure for crash hotplug support
      kexec: exclude elfcorehdr from the segment digest
      crash: memory and CPU hotplug sysfs attributes
      x86/crash: add x86 crash hotplug support
      crash: hotplug support for kexec_load()
      crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
      x86/crash: optimize CPU changes

Geert Uytterhoeven (1):
      scripts/bloat-o-meter: count weak symbol sizes

Greg Kroah-Hartman (1):
      kthread: unexport __kthread_should_park()

Helge Deller (1):
      lockdep: fix static memory detection even more

Jakob Koschel (1):
      arch: enable HAS_LTO_CLANG with KASAN and KCOV

Jim Cromie (2):
      checkpatch: special case extern struct in .c
      checkpatch: reword long-line warning about commit-msg

John Sanpe (1):
      lib/bch.c: use bitrev instead of internal logic

Kees Cook (1):
      ocfs2: use regular seq_show_option for osb_cluster_stack

Koudai Iwahori (1):
      scripts/gdb: fix lx-symbols command for arm64 LLVM

Kuan-Ying Lee (9):
      scripts/gdb: fix 'lx-lsmod' show the wrong size
      scripts/gdb/symbols: add specific ko module load command
      scripts/gdb/modules: add get module text support
      scripts/gdb/utils: add common type usage
      scripts/gdb/aarch64: add aarch64 page operation helper commands and configs
      scripts/gdb/stackdepot: add stackdepot support
      scripts/gdb/page_owner: add page owner support
      scripts/gdb/slab: add slab support
      scripts/gdb/vmalloc: add vmallocinfo support

Li kunyu (1):
      kernel: relay: remove unnecessary NULL values from relay_open_buf

Mateusz Guzik (1):
      kernel/fork: stop playing lockless games for exe_file replacement

Oleg Nesterov (2):
      kill do_each_thread()
      document while_each_thread(), change first_tid() to use for_each_thread()

Pengfei Xu (1):
      x86/kernel: increase kcov coverage under arch/x86/kernel folder

Randy Dunlap (1):
      treewide: drop CONFIG_EMBEDDED

Ryusuke Konishi (1):
      nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Sumitra Sharma (1):
      lib: replace kmap() with kmap_local_page()

Thomas Huth (1):
      arch/ia64/include: remove CONFIG_IA64_DEBUG_CMPXCHG from uapi header

Vincent Whitchurch (1):
      signal: print comm and exe name on fatal signals

Wang Ming (2):
      lib: remove error checking for debugfs_create_dir()
      lib: error-inject: remove error checking for debugfs_create_dir()

Zhu Wang (1):
      efs: clean up -Wunused-const-variable= warning

tiozhang (1):
      cred: convert printks to pr_<level>

 Documentation/ABI/testing/sysfs-devices-memory     |   8 +
 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 +
 Documentation/admin-guide/mm/memory-hotplug.rst    |   8 +
 Documentation/core-api/cpu_hotplug.rst             |  18 +
 arch/Kconfig                                       |  17 +-
 arch/arc/configs/axs101_defconfig                  |   2 +-
 arch/arc/configs/axs103_defconfig                  |   2 +-
 arch/arc/configs/axs103_smp_defconfig              |   2 +-
 arch/arc/configs/haps_hs_smp_defconfig             |   2 +-
 arch/arc/configs/hsdk_defconfig                    |   2 +-
 arch/arc/configs/nsim_700_defconfig                |   2 +-
 arch/arc/configs/nsimosci_defconfig                |   2 +-
 arch/arc/configs/nsimosci_hs_defconfig             |   2 +-
 arch/arc/configs/tb10x_defconfig                   |   2 +-
 arch/arc/configs/vdk_hs38_defconfig                |   2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig            |   2 +-
 arch/arm/Kconfig                                   |  31 +-
 arch/arm/configs/aspeed_g4_defconfig               |   2 +-
 arch/arm/configs/aspeed_g5_defconfig               |   2 +-
 arch/arm/configs/at91_dt_defconfig                 |   2 +-
 arch/arm/configs/axm55xx_defconfig                 |   2 +-
 arch/arm/configs/bcm2835_defconfig                 |   2 +-
 arch/arm/configs/clps711x_defconfig                |   2 +-
 arch/arm/configs/keystone_defconfig                |   2 +-
 arch/arm/configs/lpc18xx_defconfig                 |   2 +-
 arch/arm/configs/lpc32xx_defconfig                 |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig           |   2 +-
 arch/arm/configs/moxart_defconfig                  |   2 +-
 arch/arm/configs/multi_v4t_defconfig               |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/configs/pxa_defconfig                     |   2 +-
 arch/arm/configs/qcom_defconfig                    |   2 +-
 arch/arm/configs/sama5_defconfig                   |   2 +-
 arch/arm/configs/sama7_defconfig                   |   2 +-
 arch/arm/configs/socfpga_defconfig                 |   2 +-
 arch/arm/configs/stm32_defconfig                   |   2 +-
 arch/arm/configs/tegra_defconfig                   |   2 +-
 arch/arm/configs/vf610m4_defconfig                 |   2 +-
 arch/arm/include/asm/irq.h                         |   2 +-
 arch/arm/kernel/smp.c                              |   4 +-
 arch/arm64/Kconfig                                 |  64 +--
 arch/hexagon/configs/comet_defconfig               |   2 +-
 arch/ia64/Kconfig                                  |  28 +-
 arch/ia64/include/asm/cmpxchg.h                    |  17 +
 arch/ia64/include/uapi/asm/cmpxchg.h               |  17 -
 arch/ia64/kernel/mca.c                             |   4 +-
 arch/loongarch/Kconfig                             |  26 +-
 arch/loongarch/include/asm/irq.h                   |   2 +-
 arch/loongarch/kernel/process.c                    |   4 +-
 arch/m68k/Kconfig                                  |  19 +-
 arch/m68k/configs/amcore_defconfig                 |   2 +-
 arch/m68k/configs/m5475evb_defconfig               |   2 +-
 arch/m68k/configs/stmark2_defconfig                |   2 +-
 arch/microblaze/configs/mmu_defconfig              |   2 +-
 arch/mips/Kconfig                                  |  32 +-
 arch/mips/cavium-octeon/setup.c                    |   2 +-
 arch/mips/configs/ath25_defconfig                  |   2 +-
 arch/mips/configs/ath79_defconfig                  |   2 +-
 arch/mips/configs/bcm47xx_defconfig                |   2 +-
 arch/mips/configs/ci20_defconfig                   |   2 +-
 arch/mips/configs/cu1000-neo_defconfig             |   2 +-
 arch/mips/configs/cu1830-neo_defconfig             |   2 +-
 arch/mips/configs/db1xxx_defconfig                 |   2 +-
 arch/mips/configs/gcw0_defconfig                   |   2 +-
 arch/mips/configs/generic_defconfig                |   2 +-
 arch/mips/configs/loongson2k_defconfig             |   2 +-
 arch/mips/configs/loongson3_defconfig              |   2 +-
 arch/mips/configs/malta_qemu_32r6_defconfig        |   2 +-
 arch/mips/configs/maltaaprp_defconfig              |   2 +-
 arch/mips/configs/maltasmvp_defconfig              |   2 +-
 arch/mips/configs/maltasmvp_eva_defconfig          |   2 +-
 arch/mips/configs/maltaup_defconfig                |   2 +-
 arch/mips/configs/omega2p_defconfig                |   2 +-
 arch/mips/configs/pic32mzda_defconfig              |   2 +-
 arch/mips/configs/qi_lb60_defconfig                |   2 +-
 arch/mips/configs/rs90_defconfig                   |   2 +-
 arch/mips/configs/rt305x_defconfig                 |   2 +-
 arch/mips/configs/vocore2_defconfig                |   2 +-
 arch/mips/configs/xway_defconfig                   |   2 +-
 arch/mips/include/asm/irq.h                        |   2 +-
 arch/mips/kernel/process.c                         |   4 +-
 arch/nios2/configs/10m50_defconfig                 |   2 +-
 arch/nios2/configs/3c120_defconfig                 |   2 +-
 arch/openrisc/configs/or1klitex_defconfig          |   2 +-
 arch/parisc/Kconfig                                |  34 +-
 arch/powerpc/Kconfig                               |  57 +-
 arch/powerpc/configs/40x/klondike_defconfig        |   2 +-
 arch/powerpc/configs/44x/fsp2_defconfig            |   2 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig        |   2 +-
 arch/powerpc/configs/mgcoge_defconfig              |   2 +-
 arch/powerpc/configs/microwatt_defconfig           |   2 +-
 arch/powerpc/configs/ps3_defconfig                 |   2 +-
 arch/powerpc/include/asm/irq.h                     |   2 +-
 arch/powerpc/kernel/stacktrace.c                   |   4 +-
 arch/powerpc/kernel/watchdog.c                     |   4 +-
 arch/riscv/Kbuild                                  |   2 +-
 arch/riscv/Kconfig                                 |  46 +-
 arch/riscv/configs/nommu_k210_defconfig            |   2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   2 +-
 arch/riscv/kernel/elf_kexec.c                      |   4 +-
 arch/s390/Kbuild                                   |   2 +-
 arch/s390/Kconfig                                  |  66 +--
 arch/sh/Kconfig                                    |  46 +-
 arch/sh/configs/rsk7264_defconfig                  |   2 +-
 arch/sh/configs/rsk7269_defconfig                  |   2 +-
 arch/sparc/include/asm/irq_64.h                    |   2 +-
 arch/sparc/kernel/process_64.c                     |   6 +-
 arch/x86/Kconfig                                   |  95 +---
 arch/x86/include/asm/irq.h                         |   2 +-
 arch/x86/include/asm/kexec.h                       |  18 +
 arch/x86/include/asm/rmwcc.h                       |  11 +-
 arch/x86/include/asm/sections.h                    |  18 -
 arch/x86/kernel/Makefile                           |   9 +-
 arch/x86/kernel/apic/hw_nmi.c                      |   4 +-
 arch/x86/kernel/crash.c                            | 142 ++++-
 arch/x86/pci/amd_bus.c                             |   8 +
 arch/x86/pci/bus_numa.c                            |   2 +-
 arch/xtensa/configs/cadence_csp_defconfig          |   2 +-
 drivers/base/cpu.c                                 |  13 +
 drivers/base/memory.c                              |  13 +
 drivers/char/mem.c                                 |  18 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   1 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |   7 -
 drivers/gpu/ipu-v3/ipu-image-convert.c             |  15 +-
 drivers/irqchip/Kconfig                            |   1 +
 drivers/net/ethernet/altera/Kconfig                |   1 +
 drivers/tty/serial/omap-serial.c                   |   7 +-
 drivers/tty/tty_io.c                               |   4 +-
 drivers/video/fbdev/core/svgalib.c                 |   7 +-
 fs/adfs/dir_f.h                                    |   5 -
 fs/efs/efs.h                                       |   5 +-
 fs/exec.c                                          |   4 +-
 fs/fs_struct.c                                     |   4 +-
 fs/hfsplus/extents.c                               |   6 +-
 fs/nilfs2/alloc.c                                  |   3 +-
 fs/nilfs2/inode.c                                  |   7 +-
 fs/ocfs2/cluster/netdebug.c                        |  40 +-
 fs/ocfs2/cluster/quorum.c                          |  26 +-
 fs/ocfs2/journal.c                                 |  11 +-
 fs/ocfs2/journal.h                                 |   2 +-
 fs/ocfs2/namei.c                                   |   4 +
 fs/ocfs2/super.c                                   |   3 +-
 fs/proc/base.c                                     |   5 +-
 include/kunit/test.h                               |   1 +
 include/linux/args.h                               |  28 +
 include/linux/arm-smccc.h                          |  69 ++-
 include/linux/crash_core.h                         |  27 +
 include/linux/genl_magic_func.h                    |  27 +-
 include/linux/genl_magic_struct.h                  |   8 +-
 include/linux/kernel.h                             |  37 +-
 include/linux/kexec.h                              |  48 +-
 include/linux/kthread.h                            |   1 -
 include/linux/limits.h                             |   2 +
 include/linux/math.h                               |  19 +
 include/linux/nmi.h                                |  14 +-
 include/linux/pci.h                                |   2 +-
 include/linux/range.h                              |   8 -
 include/linux/sched/signal.h                       |   7 +-
 include/linux/sprintf.h                            |  27 +
 include/trace/bpf_probe.h                          |   2 +
 include/uapi/linux/kexec.h                         |   1 +
 init/Kconfig                                       |  10 +-
 ipc/sem.c                                          |   6 +-
 kernel/Kconfig.kexec                               | 150 ++++++
 kernel/acct.c                                      |   2 +-
 kernel/configs/tiny-base.config                    |   2 +-
 kernel/crash_core.c                                | 391 ++++++++++++++
 kernel/cred.c                                      |  27 +-
 kernel/fork.c                                      |  22 +-
 kernel/gcov/Makefile                               |   2 +
 kernel/kexec.c                                     |   5 +
 kernel/kexec_core.c                                |  43 +-
 kernel/kexec_file.c                                | 193 +------
 kernel/ksysfs.c                                    |  15 +
 kernel/kthread.c                                   |   3 +-
 kernel/locking/lockdep.c                           |  36 +-
 kernel/relay.c                                     |   2 +-
 kernel/signal.c                                    |  13 +-
 kernel/watchdog.c                                  |  11 +-
 lib/Kconfig                                        |   1 +
 lib/bch.c                                          |  38 +-
 lib/error-inject.c                                 |   2 -
 lib/kstrtox.c                                      |   2 +-
 lib/nmi_backtrace.c                                |   6 +-
 lib/notifier-error-inject.c                        |   3 -
 lib/test_hmm.c                                     |  10 +-
 lib/test_printf.c                                  |   3 +-
 lib/vsprintf.c                                     |   1 +
 mm/kfence/report.c                                 |   3 +-
 scripts/bloat-o-meter                              |  10 +-
 scripts/checkpatch.pl                              |  22 +-
 scripts/gdb/linux/constants.py.in                  |  55 ++
 scripts/gdb/linux/mm.py                            | 582 ++++++++++++++-------
 scripts/gdb/linux/modules.py                       |  44 +-
 scripts/gdb/linux/page_owner.py                    | 190 +++++++
 scripts/gdb/linux/pgtable.py                       | 222 ++++++++
 scripts/gdb/linux/slab.py                          | 326 ++++++++++++
 scripts/gdb/linux/stackdepot.py                    |  55 ++
 scripts/gdb/linux/symbols.py                       |  40 +-
 scripts/gdb/linux/utils.py                         |  20 +
 scripts/gdb/linux/vmalloc.py                       |  56 ++
 scripts/gdb/vmlinux-gdb.py                         |   7 +-
 scripts/headers_install.sh                         |   1 -
 tools/testing/selftests/proc/proc-empty-vm.c       |  23 +
 .../testing/selftests/wireguard/qemu/kernel.config |   1 -
 205 files changed, 2853 insertions(+), 1392 deletions(-)
 create mode 100644 include/linux/args.h
 create mode 100644 include/linux/sprintf.h
 create mode 100644 kernel/Kconfig.kexec
 create mode 100644 scripts/gdb/linux/page_owner.py
 create mode 100644 scripts/gdb/linux/pgtable.py
 create mode 100644 scripts/gdb/linux/slab.py
 create mode 100644 scripts/gdb/linux/stackdepot.py
 create mode 100644 scripts/gdb/linux/vmalloc.py

