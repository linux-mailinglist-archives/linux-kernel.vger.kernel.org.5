Return-Path: <linux-kernel+bounces-98902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBE8780DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5581F22377
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18273DB8C;
	Mon, 11 Mar 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0rwZJgN"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69F3D541
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164907; cv=none; b=WDIrDbSq4DymiafF2u/YpXmwGHJQ+5lz8KjisVjiD85gZ4iKjyrMzw/oCrbFGi3AFphZMDeiklzM5U0fwluN2wVw9R81K2YXfiL9tZxFBG6kf7ruURAVP1UKnNeudMESK+2qI1myGpCj5Vstz12ecjlIVDBAL8AeDZX4A4L98CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164907; c=relaxed/simple;
	bh=euQL+cP+AwcYrm2GJ2A/U8As+ITEFgdvlWEQVLYBjMA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XWAz9lcMB1wZ1llOxBwdwB3hyOzTlnjDslEoFod6bpKLYWi2YH57S1orYWQTZOdX/74xMdXyvAfhRVRYkzl6rwL/5zD/AtF1yxZkRMOBK+1jfbhctsGu/ZNIQ/1VvbUlkHGZjwoVkl9hLkH8WWMwGIGltxIisDF040Dpnrm0EzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0rwZJgN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d094bc2244so68081571fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710164903; x=1710769703; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Oppx35y3uzivjgcZJjBM+jxax0KHVm6iEdbMWAk7tSU=;
        b=M0rwZJgNmxMTTGOgyufEJmE9GADfnDnfBhMYLUx1OtOupXB89z8B1+XhAptuAbOqE5
         FWLsRkcshaBf9NuLh2JaA6CZyGhMg2BrKDhgOxRyAG8AkFx70TjZM7Sv358HIJrGy5Z1
         qhutZB5g9bkbzOncdRdPD5eHiuAHLtZH6V6Nyd9sq4wzSoXn/hDZy7uJnKf4Kj0V91qa
         H7I/B0N6AV5y/WkXmnX73nf24vakky7oMC2WrcGV1FWRl+Zx9Aq4Q8P0GoGpIJLaHmhN
         7Ig/Zvl2TWpsKmBvUfI+1uCquLSsEjHUJ32v/8gZixcap5j/uK3i5ITK/AKRT0WoFbOk
         Kekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710164903; x=1710769703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oppx35y3uzivjgcZJjBM+jxax0KHVm6iEdbMWAk7tSU=;
        b=R9vZM8MAJnjf25dMk4FoRZ/wUWPhQ4nLAufn1WXmu79yaRH1hrrb62pj8QW0knlu1X
         sOXe6iwGyHXhxx4cQQsGqA9dmUvRL13/XI3D9v6oJim72isXhuJxRFHT+bTi8pSOWno/
         80yWGSq6jxnm4izvHUHgDZVdP0zsw+x/EH0AhiFOx6r1FOqm5aCy6o8csgG21pQ9k5wR
         x298TRPBfleMA8yS1SjB1pXibFt2/WDjApXTqB1R7Qc6Z6AUariw9D6VNPk7TatI5sgJ
         EYmT95uIFKHnllPPKNWVjFOZfBElaNj+oP7TB7WYPWwJW/bqlA6QdLyi0NeG3Nt+Pf7s
         2pgQ==
X-Gm-Message-State: AOJu0YzVtCc90EdJ4vV5BMF0To+J/JPMdHrkfM4ujteCZ/T7noJrHboX
	jnS2viMJYEv1vtgLrbkNbW7CQWrLs4gs065w7O6Cv3YpJfsic8xH
X-Google-Smtp-Source: AGHT+IHK5NFmHOvglIseduVOk74q5+JjRQA9O5uKrMOBHyeO+l6g6vyTOnkdrSQcwFyrcPIEruIcoA==
X-Received: by 2002:a2e:7209:0:b0:2d2:ed31:9fa6 with SMTP id n9-20020a2e7209000000b002d2ed319fa6mr3688870ljc.49.1710164902888;
        Mon, 11 Mar 2024 06:48:22 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id g4-20020aa7d1c4000000b0056650031d94sm2914463edp.90.2024.03.11.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:48:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 14:48:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [GIT PULL] x86/core changes for v6.9
Message-ID: <Ze8LpCezZ4yHRBnk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2024-03-11

   # HEAD: 35ce64922c8263448e58a2b9e8d15a64e11e9b2d x86/idle: Select idle routine only once

Core x86 changes for v6.9:

- The biggest change is the rework of the percpu code,
  to support the 'Named Address Spaces' GCC feature,
  by Uros Bizjak:

   - This allows C code to access GS and FS segment relative
     memory via variables declared with such attributes,
     which allows the compiler to better optimize those accesses
     than the previous inline assembly code.

   - The series also includes a number of micro-optimizations
     for various percpu access methods, plus a number of
     cleanups of %gs accesses in assembly code.

   - These changes have been exposed to linux-next testing for
     the last ~5 months, with no known regressions in this area.

- Fix/clean up __switch_to()'s broken but accidentally
  working handling of FPU switching - which also generates
  better code.

- Propagate more RIP-relative addressing in assembly code,
  to generate slightly better code.

- Rework the CPU mitigations Kconfig space to be less idiosyncratic,
  to make it easier for distros to follow & maintain these options.

- Rework the x86 idle code to cure RCU violations and
  to clean up the logic.

- Clean up the vDSO Makefile logic.

- Misc cleanups and fixes.

MERGE NOTES:

Please note that there's three merge commits in this branch, which is 
higher than is typical in x86 topic trees. This happened due to the 
unusually long testing lifecycle of the percpu changes that involved 3 
merge windows, which generated a longer history and various interactions 
with other WIP core x86 changes that we felt better about to carry in a 
single tree. [ Should there be any conceptual problems with the percpu 
changes that we missed, then we can still unwind these dependencies in a 
relatively straightforward fashion, so there's no merge pressure on you. ]

This tree also has a new conflict with recent upstream in 
arch/x86/entry/entry.S, due to a recent x86/urgent VERW related fix.

The interaction is between:

  # upstream (x86/urgent)
  baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")

.. which added the new mds_verw_sel VERW method, and this commit in x86/core:

  # x86/core:
  4461438a8405 x86/retpoline: Ensure default return thunk isn't used at runtime

.. which added the __warn_thunk method.

The conflict is contextual only, it's fine to put the new __warn_thunk line 
anywhere in entry.S, as long as it's outside the other section blocks. 
Putting it last in the file is the most straightforward resolution.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/alternatives: Move apply_relocation() out of init section

Breno Leitao (10):
      x86/bugs: Rename CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE
      x86/bugs: Rename CONFIG_CPU_IBPB_ENTRY       => CONFIG_MITIGATION_IBPB_ENTRY
      x86/bugs: Rename CONFIG_CALL_DEPTH_TRACKING  => CONFIG_MITIGATION_CALL_DEPTH_TRACKING
      x86/bugs: Rename CONFIG_PAGE_TABLE_ISOLATION => CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
      x86/bugs: Rename CONFIG_RETPOLINE            => CONFIG_MITIGATION_RETPOLINE
      x86/bugs: Rename CONFIG_SLS                  => CONFIG_MITIGATION_SLS
      x86/bugs: Rename CONFIG_CPU_UNRET_ENTRY      => CONFIG_MITIGATION_UNRET_ENTRY
      x86/bugs: Rename CONFIG_CPU_IBRS_ENTRY       => CONFIG_MITIGATION_IBRS_ENTRY
      x86/bugs: Rename CONFIG_CPU_SRSO             => CONFIG_MITIGATION_SRSO
      x86/bugs: Rename CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK

Daniel Micay (1):
      x86/vdso: Move vDSO to mmap region

Ingo Molnar (2):
      x86/callthunks: Mark apply_relocation() as __init_or_module
      x86/vdso/kbuild: Group non-standard build attributes and primary object file rules together

Josh Poimboeuf (2):
      x86/retpoline: Ensure default return thunk isn't used at runtime
      x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o

Kees Cook (1):
      x86: Increase brk randomness entropy for 64-bit systems

Linus Torvalds (1):
      x86/fpu: Clean up FPU switching in the middle of task switching

Masahiro Yamada (4):
      x86/vdso: Consolidate targets and clean-files
      x86/vdso: Simplify obj-y addition
      x86/vdso: Use $(addprefix ) instead of $(foreach )
      x86/vdso: Use CONFIG_COMPAT_32 to specify vdso32

Nadav Amit (1):
      x86/percpu: Use compiler segment prefix qualifier

Thomas Gleixner (6):
      sched/idle: Conditionally handle tick broadcast in default_idle_call()
      x86/idle: Sanitize X86_BUG_AMD_E400 handling
      x86/idle: Clean up idle selection
      x86/idle: Cleanup idle_setup()
      x86/idle: Let prefer_mwait_c1_over_halt() return bool
      x86/idle: Select idle routine only once

Uros Bizjak (23):
      x86/percpu: Enable named address spaces with known compiler version
      x86/percpu: Use C for percpu read/write accessors
      x86/percpu: Disable named address spaces for KASAN
      x86/percpu: Rewrite arch_raw_cpu_ptr() to be easier for compilers to optimize
      x86/percpu: Use C for arch_raw_cpu_ptr(), to improve code generation
      x86/percpu: Use the correct asm operand modifier in percpu_stable_op()
      x86/percpu: Correct PER_CPU_VAR() usage to include symbol and its addend
      x86/percpu, xen: Correct PER_CPU_VAR() usage to include symbol and its addend
      x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()
      x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation
      x86/percpu: Return correct variable from current_top_of_stack()
      x86/percpu: Define PER_CPU_VAR macro also for !__ASSEMBLY__
      x86/callthunks: Handle %rip-relative relocations in call thunk template
      x86/callthunks: Fix and unify call thunks assembly snippets
      x86/acpi: Use %rip-relative addressing in wakeup_64.S
      x86/percpu: Declare const_pcpu_hot as extern const variable
      x86/smp: Move the call to smp_processor_id() after the early exit in native_stop_other_cpus()
      x86/smp: Use atomic_try_cmpxchg in native_stop_other_cpus()
      x86/callthunks: Correct calculation of dest address in is_callthunk()
      x86/percpu: Fix "const_pcpu_hot" version generation failure
      x86/traps: Use current_top_of_stack() helper in traps.c
      x86/percpu: Avoid sparse warning with cast to named address space
      x86/percpu: Use %RIP-relative address in untagged_addr()


 Documentation/admin-guide/hw-vuln/spectre.rst   |   8 +-
 Documentation/admin-guide/kernel-parameters.txt |   4 +-
 Documentation/arch/x86/pti.rst                  |   6 +-
 arch/x86/Kconfig                                |  45 ++++--
 arch/x86/Makefile                               |  11 +-
 arch/x86/boot/compressed/ident_map_64.c         |   4 +-
 arch/x86/configs/i386_defconfig                 |   2 +-
 arch/x86/entry/calling.h                        |  74 ++++++++-
 arch/x86/entry/entry.S                          |   4 +
 arch/x86/entry/entry_32.S                       |   2 +-
 arch/x86/entry/entry_64.S                       |   8 +-
 arch/x86/entry/thunk_32.S                       |  34 +----
 arch/x86/entry/thunk_64.S                       |  33 ----
 arch/x86/entry/vdso/Makefile                    |  57 +++----
 arch/x86/entry/vdso/vma.c                       |  57 +------
 arch/x86/include/asm/current.h                  |   9 +-
 arch/x86/include/asm/disabled-features.h        |  10 +-
 arch/x86/include/asm/elf.h                      |   1 -
 arch/x86/include/asm/fpu/sched.h                |  10 +-
 arch/x86/include/asm/linkage.h                  |  16 +-
 arch/x86/include/asm/nospec-branch.h            |  55 +++----
 arch/x86/include/asm/percpu.h                   | 191 ++++++++++++++++++------
 arch/x86/include/asm/pgalloc.h                  |   2 +-
 arch/x86/include/asm/pgtable-3level.h           |   2 +-
 arch/x86/include/asm/pgtable.h                  |  18 +--
 arch/x86/include/asm/pgtable_64.h               |   3 +-
 arch/x86/include/asm/preempt.h                  |   2 +-
 arch/x86/include/asm/processor-flags.h          |   2 +-
 arch/x86/include/asm/processor.h                |   5 +-
 arch/x86/include/asm/pti.h                      |   2 +-
 arch/x86/include/asm/static_call.h              |   2 +-
 arch/x86/include/asm/text-patching.h            |   2 +
 arch/x86/include/asm/uaccess_64.h               |  11 +-
 arch/x86/kernel/acpi/wakeup_64.S                |  24 +--
 arch/x86/kernel/alternative.c                   |  23 ++-
 arch/x86/kernel/asm-offsets.c                   |   2 +-
 arch/x86/kernel/callthunks.c                    |  32 +++-
 arch/x86/kernel/cpu/amd.c                       |   2 +-
 arch/x86/kernel/cpu/bugs.c                      |  48 +++---
 arch/x86/kernel/cpu/common.c                    |   5 +-
 arch/x86/kernel/dumpstack.c                     |   2 +-
 arch/x86/kernel/ftrace.c                        |   3 +-
 arch/x86/kernel/head_32.S                       |   4 +-
 arch/x86/kernel/head_64.S                       |   4 +-
 arch/x86/kernel/kprobes/opt.c                   |   2 +-
 arch/x86/kernel/ldt.c                           |   8 +-
 arch/x86/kernel/process.c                       |  99 +++++-------
 arch/x86/kernel/process_32.c                    |   7 +-
 arch/x86/kernel/process_64.c                    |   7 +-
 arch/x86/kernel/smp.c                           |  10 +-
 arch/x86/kernel/static_call.c                   |   2 +-
 arch/x86/kernel/sys_x86_64.c                    |   7 -
 arch/x86/kernel/traps.c                         |   4 +-
 arch/x86/kernel/vmlinux.lds.S                   |  11 +-
 arch/x86/kvm/mmu/mmu.c                          |   2 +-
 arch/x86/kvm/mmu/mmu_internal.h                 |   2 +-
 arch/x86/kvm/svm/svm.c                          |   2 +-
 arch/x86/kvm/svm/vmenter.S                      |   4 +-
 arch/x86/kvm/vmx/vmx.c                          |   2 +-
 arch/x86/lib/Makefile                           |   2 +-
 arch/x86/lib/cmpxchg16b_emu.S                   |  12 +-
 arch/x86/lib/cmpxchg8b_emu.S                    |  30 ++--
 arch/x86/lib/retpoline.S                        |  41 +++--
 arch/x86/mm/Makefile                            |   2 +-
 arch/x86/mm/debug_pagetables.c                  |   4 +-
 arch/x86/mm/dump_pagetables.c                   |   4 +-
 arch/x86/mm/pgtable.c                           |   4 +-
 arch/x86/mm/tlb.c                               |  10 +-
 arch/x86/net/bpf_jit_comp.c                     |   4 +-
 arch/x86/net/bpf_jit_comp32.c                   |   2 +-
 arch/x86/purgatory/Makefile                     |   2 +-
 arch/x86/xen/xen-asm.S                          |  10 +-
 include/linux/compiler-gcc.h                    |   2 +-
 include/linux/compiler.h                        |   2 +-
 include/linux/cpu.h                             |   2 +
 include/linux/indirect_call_wrapper.h           |   2 +-
 include/linux/module.h                          |   2 +-
 include/linux/objtool.h                         |   2 +-
 include/linux/pti.h                             |   2 +-
 include/linux/tick.h                            |   3 +
 include/net/netfilter/nf_tables_core.h          |   2 +-
 include/net/tc_wrapper.h                        |   2 +-
 kernel/sched/idle.c                             |  21 +++
 kernel/time/Kconfig                             |   5 +
 kernel/trace/ring_buffer.c                      |   2 +-
 net/netfilter/Makefile                          |   2 +-
 net/netfilter/nf_tables_core.c                  |   6 +-
 net/netfilter/nft_ct.c                          |   4 +-
 net/netfilter/nft_lookup.c                      |   2 +-
 net/sched/sch_api.c                             |   2 +-
 scripts/Makefile.lib                            |   8 +-
 scripts/Makefile.vmlinux_o                      |   2 +-
 scripts/generate_rust_target.rs                 |   2 +-
 scripts/mod/modpost.c                           |   2 +-
 tools/arch/x86/include/asm/disabled-features.h  |  10 +-
 tools/objtool/arch/x86/special.c                |   2 +-
 tools/objtool/check.c                           |   4 +-
 97 files changed, 669 insertions(+), 563 deletions(-)

