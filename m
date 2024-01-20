Return-Path: <linux-kernel+bounces-31864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5238E8335A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB02C1F22141
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8E12B65;
	Sat, 20 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NNP/WfIR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A9125C7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705774644; cv=none; b=aPAgACiLsBg8MA/lUf6rXUA7TVpsgezZeQFEPudnlQGevuxn6aAy9p8F/c2n/4X6Ji8cg/rA/l3xpDe46xExtKyn/mttsFdl7fZkhvVAgL5yA3RLXMvmRhS2FmnzKU+RBYfiivdky+MJoV1cde1C/oXS0dbLtGSD9/U/bVjsHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705774644; c=relaxed/simple;
	bh=G8d2psAhUDSkXSCvExvGAmSxMAQ/eD89DdBM+jneF/g=;
	h=Date:Subject:CC:From:To:Message-ID; b=aC+99GjaMnjBJlYJlK1GUhCZ2tmgzyDW3V3+d9AGJ5E5GWtfWS/npA8GcP7CAT0xEti+JJ3YE3VjvdPexzWplqZiX+Gv0gflIJOSCep4xAdHvAXrfwT7U5bUAl2eaFQ2y725PWtSHzeWz9Y1ORRBjOuxChwgmQAwieNuIsj0HuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NNP/WfIR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dbd65d3db6so92343b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705774641; x=1706379441; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iJH1io3NSZOY6qDg0MIhAyX9Eo07Fv3oC0ABBnXG9g=;
        b=NNP/WfIRuWXXzXWrOhnun7QNfW8YB+pfzxXpxnQqPoCubGympmqqvQECplPuPNL0gu
         qmoGFNwm8Pv4iAV6BGIJoNML58h2VHQI2roz2HFk9e2KaXXcCUF55ikXvzhavlz6cRmg
         m6RSRvVkZwAYosMBgEQQ+As2iC+1CNy6WeRbY13iKLBIbFV/9i1cImRukEvSoh4++T+o
         Bk5dRrY0yXtSUE8b4rS1wBo+J+8ZMzF6RKdDoC0jsbGM/b+T6Kz9QXsCLhnS+yon3mt+
         T9KeR3M4i01O8p7yu7gn/wk1tRu0b7u4sJghRjLICUfby5NhYiDdYJJrFGU+N1CVwhcP
         braw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705774641; x=1706379441;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iJH1io3NSZOY6qDg0MIhAyX9Eo07Fv3oC0ABBnXG9g=;
        b=G72hnbAdOvIn0AaSdXfJtCH6uguZu4Ol6INtcsHj8w+J2PV+HpthW+tPhWSLlVNmn2
         z3RgWveaoPh2aQcm5c1FLMLEXpxuxbrEceATwe9SuIyRcfF4XZRf0+OSy61BVTGSD4Gw
         vD/3HAAvCoft28R6LeFm+Elm39J58ZngkgKzMDaXdl5mnvxD3yCFV4+W3QLKQgae/vbm
         W2+ZjVfQGJVm5IRVXaQPELsYSFtdR20S9jggjvCOCPm3z0H63y3HyfbkA1khBlNbDzfV
         GfSzd6hGUdP2qI4/Gps1ysJAJqYrUOG8EiU2XpHZLxEAqPljs9kJN3vX0lP0cvg4iWiC
         Fm/A==
X-Gm-Message-State: AOJu0YyUlDYoMAi3JAxECaigIPDbZ6cy/KJutB/ReqUxR34h5dMWn3q3
	OYyyhzrqPXc3arUUeBz8dMTIFnQGQHNx7QQxjLWkTrD8CaIN6dDXPZh+AzzEba0sLRkGJAOUyam
	Z
X-Google-Smtp-Source: AGHT+IFtt9unUh1DvkFYBlZXj6xWi7bHGU5dvZOY66x1YidSg+L9WJg6IK6AUNNuwROLoQPrQCdvpg==
X-Received: by 2002:a05:6a00:368a:b0:6d9:ba71:70a with SMTP id dw10-20020a056a00368a00b006d9ba71070amr1056790pfb.68.1705774641072;
        Sat, 20 Jan 2024 10:17:21 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006dae568baedsm7016319pfn.24.2024.01.20.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 10:17:18 -0800 (PST)
Date: Sat, 20 Jan 2024 10:17:18 -0800 (PST)
X-Google-Original-Date: Sat, 20 Jan 2024 09:57:07 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 6.8 Merge Window, Part 4
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-878cc879-7aa0-473f-91e4-8288072cdd4e@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit cb51bfee7f62a8e26b694f9d84c0041b3e3ccc71:

  Merge patch series "riscv: hwprobe: add Zicond, Zacas and Ztso support" (2024-01-09 20:14:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.8-mw4

for you to fetch changes up to f24a70106dc1ad2a755b2d42f47cf1dcf24f0b27:

  lib: checksum: Fix build with CONFIG_NET=n (2024-01-19 08:12:38 -0800)

----------------------------------------------------------------
RISC-V Patches for the 6.8 Merge Window, Part 4

This includes everything from part 2:

* Support for tuning for systems with fast misaligned accesses.
* Support for SBI-based suspend.
* Support for the new SBI debug console extension.
* The T-Head CMOs now use PA-based flushes.
* Support for enabling the V extension in kernel code.
* Optimized IP checksum routines.
* Various ftrace improvements.
* Support for archrandom, which depends on the Zkr extension.

and then also a fix for those:

* The build is no longer broken under NET=n, KUNIT=y for ports that
  don't define their own ipv6 checksum.

----------------------------------------------------------------
This is essentially the same as part 3, except it doesn't have the back merge.
Thus there's a semantic merge conflict: the refactoring from f32fcbedbe92
("tty: hvc: convert to u8 and size_t") requires a change to 88ead68e764c ("tty:
Add SBI debug console support to HVC SBI driver") as we added another set of
HVC routines.

I used the following locally

diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
index 0abd964d380b..cede8a572594 100644
--- a/drivers/tty/hvc/hvc_riscv_sbi.c
+++ b/drivers/tty/hvc/hvc_riscv_sbi.c
@@ -45,12 +45,12 @@ static const struct hv_ops hvc_sbi_v01_ops = {
 	.put_chars = hvc_sbi_tty_put,
 };
 
-static int hvc_sbi_dbcn_tty_put(uint32_t vtermno, const char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_put(uint32_t vtermno, const u8 *buf, size_t count)
 {
 	return sbi_debug_console_write(buf, count);
 }
 
-static int hvc_sbi_dbcn_tty_get(uint32_t vtermno, char *buf, int count)
+static ssize_t hvc_sbi_dbcn_tty_get(uint32_t vtermno, u8 *buf, size_t count)
 {
 	return sbi_debug_console_read(buf, count);
 }

to avoid a local build failure along the lines of

  CC      drivers/tty/hvc/hvc_riscv_sbi.o
drivers/tty/hvc/hvc_riscv_sbi.c:59:22: error: initialization of ‘ssize_t (*)(uint32_t,  const u8 *, size_t)’ {aka ‘long int (*)(unsigned int,  const unsigned char *, long unsigned int)’} from incompatible pointer type ‘int (*)(uint32_t,  const char *, int)’ {aka ‘int (*)(unsigned int,  const char *, int)’} [-Werror=incompatible-pointer-types]
   59 |         .put_chars = hvc_sbi_dbcn_tty_put,
      |                      ^~~~~~~~~~~~~~~~~~~~
drivers/tty/hvc/hvc_riscv_sbi.c:59:22: note: (near initialization for ‘hvc_sbi_dbcn_ops.put_chars’)
drivers/tty/hvc/hvc_riscv_sbi.c:60:22: error: initialization of ‘ssize_t (*)(uint32_t,  u8 *, size_t)’ {aka ‘long int (*)(unsigned int,  unsigned char *, long unsigned int)’} from incompatible pointer type ‘int (*)(uint32_t,  char *, int)’ {aka ‘int (*)(unsigned int,  char *, int)’} [-Werror=incompatible-pointer-types]
   60 |         .get_chars = hvc_sbi_dbcn_tty_get,
      |                      ^~~~~~~~~~~~~~~~~~~~
drivers/tty/hvc/hvc_riscv_sbi.c:60:22: note: (near initialization for ‘hvc_sbi_dbcn_ops.get_chars’)

----------------------------------------------------------------
Alexandre Ghiti (3):
      riscv: Use hugepage mappings for vmemmap
      riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
      riscv: Fix build error on rv32 + XIP

Andrew Jones (2):
      riscv: sbi: Introduce system suspend support
      RISC-V: selftests: cbo: Ensure asm operands match constraints

Andy Chiu (8):
      riscv: vector: make Vector always available for softirq context
      riscv: sched: defer restoring Vector context for user
      riscv: lib: vectorize copy_to_user/copy_from_user
      riscv: fpu: drop SR_SD bit checking
      riscv: vector: do not pass task_struct into riscv_v_vstate_{save,restore}()
      riscv: vector: use a mask to write vstate_ctrl
      riscv: vector: use kmem_cache to manage vector context
      riscv: vector: allow kernel-mode Vector with preemption

Anup Patel (4):
      RISC-V: Add stubs for sbi_console_putchar/getchar()
      RISC-V: Add SBI debug console helper routines
      tty/serial: Add RISC-V SBI debug console based earlycon
      RISC-V: Enable SBI based earlycon support

Atish Patra (1):
      tty: Add SBI debug console support to HVC SBI driver

Charlie Jenkins (9):
      riscv: Fix module loading free order
      riscv: Correctly free relocation hashtable on error
      riscv: Fix relocation_hashtable size
      asm-generic: Improve csum_fold
      riscv: Add static key for misaligned accesses
      riscv: Add checksum header
      riscv: Add checksum library
      kunit: Add tests for csum_ipv6_magic and ip_fast_csum
      riscv: lib: Check if output in asm goto supported

Christoph Müllner (5):
      tools: selftests: riscv: Fix compile warnings in hwprobe
      tools: selftests: riscv: Fix compile warnings in cbo
      tools: selftests: riscv: Add missing include for vector test
      tools: selftests: riscv: Fix compile warnings in vector tests
      tools: selftests: riscv: Fix compile warnings in mm tests

Christophe JAILLET (1):
      riscv: Fix an off-by-one in get_early_cmdline()

Conor Dooley (1):
      dt-bindings: riscv: permit numbers in "riscv,isa"

Daniel Henrique Barboza (1):
      dt-bindings: riscv: Document cbop-block-size

Greentime Hu (2):
      riscv: Add support for kernel mode vector
      riscv: Add vector extension XOR implementation

Guo Ren (2):
      riscv: mm: Fixup compat mode boot failure
      riscv: mm: Fixup compat arch_get_mmap_end

Jisheng Zhang (4):
      riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
      riscv: select DCACHE_WORD_ACCESS for efficient unaligned access HW
      riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
      riscv: errata: thead: use pa based instructions for CMO

Masahiro Yamada (1):
      riscv: add dependency among Image(.gz), loader(.bin), and vmlinuz.efi

Maxim Kochetkov (1):
      riscv: optimize ELF relocation function in riscv

Nathan Chancellor (3):
      riscv: Hoist linker relaxation disabling logic into Kconfig
      riscv: Restrict DWARF5 when building with LLVM to known working versions
      lib/Kconfig.debug: Update AS_HAS_NON_CONST_LEB128 comment and name

Palmer Dabbelt (11):
      Merge patch series "riscv: enable EFFICIENT_UNALIGNED_ACCESS and DCACHE_WORD_ACCESS"
      Merge patch series "riscv: modules: Fix module loading error handling"
      Merge patch series "RISC-V SBI debug console extension support"
      Merge patch series "riscv: errata: thead: use riscv_nonstd_cache_ops for CMO"
      Merge patch series "tools: selftests: riscv: Fix compiler warnings"
      Merge patch series "riscv: mm: Fixup & Optimize COMPAT code"
      Merge patch series "riscv: support kernel-mode Vector"
      Merge patch series "riscv: Add fine-tuned checksum functions"
      Merge patch series "RISC-V: Disable DWARF5 with known broken LLVM versions"
      Merge patch series "riscv: ftrace: Miscellaneous ftrace improvements"
      lib: checksum: Fix build with CONFIG_NET=n

Samuel Holland (1):
      dt-bindings: riscv: cpus: Clarify mmu-type interpretation

Samuel Ortiz (1):
      RISC-V: Implement archrandom when Zkr is available

Song Shuai (4):
      riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
      riscv: ftrace: Make function graph use ftrace directly
      riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
      samples: ftrace: Add RISC-V support for SAMPLE_FTRACE_DIRECT[_MULTI]

Xiao Wang (1):
      riscv: Optimize hweight API with Zbb extension

 Documentation/devicetree/bindings/riscv/cpus.yaml  |   9 +-
 .../devicetree/bindings/riscv/extensions.yaml      |   2 +-
 Documentation/features/vm/TLB/arch-support.txt     |   2 +-
 arch/riscv/Kconfig                                 |  57 +++-
 arch/riscv/Kconfig.errata                          |   1 +
 arch/riscv/Makefile                                |   8 +-
 arch/riscv/configs/defconfig                       |   1 +
 arch/riscv/errata/thead/errata.c                   |  69 ++++-
 arch/riscv/include/asm/arch_hweight.h              |  78 +++++
 arch/riscv/include/asm/archrandom.h                |  72 +++++
 arch/riscv/include/asm/asm-extable.h               |  15 +
 arch/riscv/include/asm/asm-prototypes.h            |  27 ++
 arch/riscv/include/asm/bitops.h                    |   4 +-
 arch/riscv/include/asm/checksum.h                  |  93 ++++++
 arch/riscv/include/asm/cpufeature.h                |   2 +
 arch/riscv/include/asm/csr.h                       |   9 +
 arch/riscv/include/asm/entry-common.h              |  17 ++
 arch/riscv/include/asm/errata_list.h               |  50 +---
 arch/riscv/include/asm/ftrace.h                    |  18 +-
 arch/riscv/include/asm/pgtable.h                   |   2 +-
 arch/riscv/include/asm/processor.h                 |  43 ++-
 arch/riscv/include/asm/sbi.h                       |  19 ++
 arch/riscv/include/asm/simd.h                      |  64 ++++
 arch/riscv/include/asm/switch_to.h                 |   3 +-
 arch/riscv/include/asm/thread_info.h               |   2 +
 arch/riscv/include/asm/tlbbatch.h                  |  15 +
 arch/riscv/include/asm/tlbflush.h                  |   8 +
 arch/riscv/include/asm/vector.h                    |  90 +++++-
 arch/riscv/include/asm/word-at-a-time.h            |  27 ++
 arch/riscv/include/asm/xor.h                       |  68 +++++
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/cpufeature.c                     |  90 +++++-
 arch/riscv/kernel/entry.S                          |   8 +
 arch/riscv/kernel/ftrace.c                         |  30 +-
 arch/riscv/kernel/kernel_mode_vector.c             | 247 ++++++++++++++++
 arch/riscv/kernel/mcount-dyn.S                     | 198 ++++++++++---
 arch/riscv/kernel/module.c                         |  34 ++-
 arch/riscv/kernel/pi/cmdline_early.c               |   3 +-
 arch/riscv/kernel/process.c                        |  13 +-
 arch/riscv/kernel/ptrace.c                         |   7 +-
 arch/riscv/kernel/sbi.c                            |  66 +++++
 arch/riscv/kernel/signal.c                         |   7 +-
 arch/riscv/kernel/suspend.c                        |  44 +++
 arch/riscv/kernel/vector.c                         |  53 +++-
 arch/riscv/lib/Makefile                            |   6 +
 arch/riscv/lib/csum.c                              | 328 +++++++++++++++++++++
 arch/riscv/lib/riscv_v_helpers.c                   |  45 +++
 arch/riscv/lib/uaccess.S                           |  10 +
 arch/riscv/lib/uaccess_vector.S                    |  53 ++++
 arch/riscv/lib/xor.S                               |  81 +++++
 arch/riscv/mm/extable.c                            |  31 ++
 arch/riscv/mm/init.c                               |  25 +-
 arch/riscv/mm/tlbflush.c                           |  69 +++--
 drivers/tty/hvc/Kconfig                            |   2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c                    |  37 ++-
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c            |  27 +-
 include/asm-generic/checksum.h                     |   6 +-
 lib/Kconfig.debug                                  |  12 +-
 lib/checksum_kunit.c                               | 286 +++++++++++++++++-
 samples/ftrace/ftrace-direct-modify.c              |  35 +++
 samples/ftrace/ftrace-direct-multi-modify.c        |  41 +++
 samples/ftrace/ftrace-direct-multi.c               |  25 ++
 samples/ftrace/ftrace-direct-too.c                 |  28 ++
 samples/ftrace/ftrace-direct.c                     |  24 ++
 tools/testing/selftests/riscv/hwprobe/cbo.c        |  24 +-
 tools/testing/selftests/riscv/hwprobe/hwprobe.c    |   4 +-
 tools/testing/selftests/riscv/mm/mmap_test.h       |   3 +
 .../selftests/riscv/vector/v_initval_nolibc.c      |   2 +-
 .../selftests/riscv/vector/vstate_exec_nolibc.c    |   3 +
 .../testing/selftests/riscv/vector/vstate_prctl.c  |   4 +-
 71 files changed, 2676 insertions(+), 213 deletions(-)
 create mode 100644 arch/riscv/include/asm/arch_hweight.h
 create mode 100644 arch/riscv/include/asm/archrandom.h
 create mode 100644 arch/riscv/include/asm/checksum.h
 create mode 100644 arch/riscv/include/asm/simd.h
 create mode 100644 arch/riscv/include/asm/tlbbatch.h
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/lib/csum.c
 create mode 100644 arch/riscv/lib/riscv_v_helpers.c
 create mode 100644 arch/riscv/lib/uaccess_vector.S
 create mode 100644 arch/riscv/lib/xor.S

