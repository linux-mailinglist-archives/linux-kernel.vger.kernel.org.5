Return-Path: <linux-kernel+bounces-98370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0F877933
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E181F21A68
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6523FBAC;
	Sun, 10 Mar 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBNKMDlF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qLqvzbxx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC313BBF7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113953; cv=none; b=S2EgnhCwMIrO/fJdd2vozPQenv0n7NIQ9t6pBx3RG+aiAw95JApILk5lNRhHQp89ss1XKMhBbYf6GxH3jSUdQQZ5F/whlJ80S8NfpsKCdJIeZVtJaJLBuqmYRfy42paWdiHYTLyY2TDHsjZ389Ugu3IYWqojCy5DVEZ/mtC8NGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113953; c=relaxed/simple;
	bh=nYW1enJ5tO6u6psuklfPcxrlNwH5jNR8cqEam79YAqo=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=L1TTz0qosvBeIgS8Q6hF57ItKWysNDu3Fqmjaxkd1skhIyL0JztwNigpuKCSX9LvdQ8X5tc880ryezTur6mIBThlxau5dUupNSGZM2NoHoMWpZgDfOgO+bvZdumHv0Jx8wRbAiXMR8Xw4BrDujFpGYed0okzRI73kokoSBqiLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBNKMDlF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qLqvzbxx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=BK1btW5YTOApOdiTT9w3M1DvjgroOhk4IFRpYsb3S/Q=;
	b=cBNKMDlFrm2+hudIcw2DN7RNM8T9S51yhmZn7qWXgDsxbd8ujPhOWOhxdKAX9xZvj/HrFK
	8/5PdY8XFlSF9kgXQSSB6v+o2rkSkKPTAubVTkBKct0twa3c7PcM3j977jPrl6MV4cU950
	PVJisk0/26I1qlrVx3Llk6KFLVVlEe1BAy+U9SnG8//RI6waNAIQ2sCBm/GMNOnd2FSd3q
	ZlH/1VWxikvQt3Kh9/uCZmIuWBISg2iDX5AR9+d5S0ncoXNjFCvUa6wiabB2TtS8rBJlgX
	DXVyYogVw2AOkjviirwTuAkyTCwBXPMEtQVisY7O2ikC70QMDHe51YOHbzNmyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=BK1btW5YTOApOdiTT9w3M1DvjgroOhk4IFRpYsb3S/Q=;
	b=qLqvzbxxoLYEyL69XkdjBLBV/cdwiK5f1oStPvk7Cn4y+/NJwxHXNVCrfT+arWGHujxzmc
	EpE2LB8WZ0/v+1Aw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011361729.2468526.2426064486971501672.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:55 +0100 (CET)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-03-10

up to:  8ca1836769d7: timer/migration: Fix quick check reporting late expiry

A large set of updates and features for timers and timekeeping:

  - The hierarchical timer pull model

    When timer wheel timers are armed they are placed into the timer wheel
    of a CPU which is likely to be busy at the time of expiry. This is done
    to avoid wakeups on potentially idle CPUs.

    This is wrong in several aspects:

     1) The heuristics to select the target CPU are wrong by
        definition as the chance to get the prediction right is close
        to zero.

     2) Due to #1 it is possible that timers are accumulated on a
        single target CPU

     3) The required computation in the enqueue path is just overhead for
     	dubious value especially under the consideration that the vast
     	majority of timer wheel timers are either canceled or rearmed
     	before they expire.

    The timer pull model avoids the above by removing the target
    computation on enqueue and queueing timers always on the CPU on which
    they get armed.

    This is achieved by having separate wheels for CPU pinned timers and
    global timers which do not care about where they expire.

    As long as a CPU is busy it handles both the pinned and the global
    timers which are queued on the CPU local timer wheels.

    When a CPU goes idle it evaluates its own timer wheels:

      - If the first expiring timer is a pinned timer, then the global
      	timers can be ignored as the CPU will wake up before they expire.

      - If the first expiring timer is a global timer, then the expiry time
        is propagated into the timer pull hierarchy and the CPU makes sure
        to wake up for the first pinned timer.

    The timer pull hierarchy organizes CPUs in groups of eight at the
    lowest level and at the next levels groups of eight groups up to the
    point where no further aggregation of groups is required, i.e. the
    number of levels is log8(NR_CPUS). The magic number of eight has been
    established by experimention, but can be adjusted if needed.

    In each group one busy CPU acts as the migrator. It's only one CPU to
    avoid lock contention on remote timer wheels.

    The migrator CPU checks in its own timer wheel handling whether there
    are other CPUs in the group which have gone idle and have global timers
    to expire. If there are global timers to expire, the migrator locks the
    remote CPU timer wheel and handles the expiry.

    Depending on the group level in the hierarchy this handling can require
    to walk the hierarchy downwards to the CPU level.

    Special care is taken when the last CPU goes idle. At this point the
    CPU is the systemwide migrator at the top of the hierarchy and it
    therefore cannot delegate to the hierarchy. It needs to arm its own
    timer device to expire either at the first expiring timer in the
    hierarchy or at the first CPU local timer, which ever expires first.

    This completely removes the overhead from the enqueue path, which is
    e.g. for networking a true hotpath and trades it for a slightly more
    complex idle path.

    This has been in development for a couple of years and the final series
    has been extensively tested by various teams from silicon vendors and
    ran through extensive CI.

    There have been slight performance improvements observed on network
    centric workloads and an Intel team confirmed that this allows them to
    power down a die completely on a mult-die socket for the first time in
    a mostly idle scenario.

    There is only one outstanding ~1.5% regression on a specific overloaded
    netperf test which is currently investigated, but the rest is either
    positive or neutral performance wise and positive on the power
    management side.

  - Fixes for the timekeeping interpolation code for cross-timestamps:

    cross-timestamps are used for PTP to get snapshots from hardware timers
    and interpolated them back to clock MONOTONIC. The changes address a
    few corner cases in the interpolation code which got the math and logic
    wrong.

  - Simplifcation of the clocksource watchdog retry logic to automatically
    adjust to handle larger systems correctly instead of having more
    incomprehensible command line parameters.

  - Treewide consolidation of the VDSO data structures.

  - The usual small improvements and cleanups all over the place.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (34):
      hrtimers: Move hrtimer base related definitions into hrtimer_defs.h
      hrtimers: Update formatting of documentation
      tick/sched: Add function description for tick_nohz_next_event()
      timers: Add struct member description for timer_base
      jiffies: Transform comment about time_* functions into DOC block
      vdso/helpers: Fix grammar in comments
      s390/vdso/data: Drop unnecessary header include
      csky/vdso: Remove superfluous ifdeffery
      vdso/ARM: Make union vdso_data_store available for all architectures
      arm64: vdso: Use generic union vdso_data_store
      riscv: vdso: Use generic union vdso_data_store
      s390/vdso: Use generic union vdso_data_store
      LoongArch: vdso: Use generic union vdso_data_store
      MIPS: vdso: Use generic union vdso_data_store
      csky/vdso: Use generic union vdso_data_store
      timers: Restructure get_next_timer_interrupt()
      timers: Split out get next timer interrupt
      timers: Move marking timer bases idle into tick_nohz_stop_tick()
      timers: Optimization for timer_base_try_to_set_idle()
      timers: Introduce add_timer() variants which modify timer flags
      workqueue: Use global variant for add_timer()
      timers: Make sure TIMER_PINNED flag is set in add_timer_on()
      timers: Simplify code in run_local_timers()
      timers: Split next timer interrupt logic
      timers: Keep the pinned timers separate from the others
      timers: Retrieve next expiry of pinned/non-pinned timers separately
      timers: Split out "get next timer interrupt" functionality
      timers: Add get next timer interrupt functionality for remote CPUs
      timers: Check if timers base is handled already
      timers: Introduce function to check timer base is_idle flag
      timers: Implement the hierarchical pull model
      timer_migration: Add tracepoints
      timers: Always queue timers on the local CPU
      vdso/datapage: Quick fix - use asm/page-def.h for ARM64

Arnd Bergmann (1):
      tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=3Dn

Costa Shulyupin (1):
      hrtimer: Select housekeeping CPU during migration

David Gow (1):
      time/kunit: Use correct format specifier

Feng Tang (1):
      clocksource: Scale the watchdog read retries automatically

Frederic Weisbecker (15):
      tick/sched: Remove useless oneshot ifdeffery
      tick: Use IS_ENABLED() whenever possible
      tick/sched: Rename tick_nohz_stop_sched_tick() to tick_nohz_full_stop_t=
ick()
      tick/sched: Don't clear ts::next_tick again in can_stop_idle_tick()
      tick: Start centralizing tick related CPU hotplug operations
      tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
      tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING
      tick: Assume the tick can't be stopped in NOHZ_MODE_INACTIVE mode
      tick: Move got_idle_tick away from common flags
      tick: Move individual bit features to debuggable mask accesses
      tick: Split nohz and highres features from nohz_mode
      tick: Shut down low-res tick from dying CPU
      tick: Assume timekeeping is correctly handed over upon last offline idl=
e call
      timers: Assert no next dyntick timer look-up while CPU is offline
      timer/migration: Fix quick check reporting late expiry

Peng Liu (2):
      tick/nohz: Remove duplicate between tick_nohz_switch_to_nohz() and tick=
_setup_sched_timer()
      tick/nohz: Remove duplicate between lowres and highres handlers

Peter Hilber (3):
      timekeeping: Fix cross-timestamp interpolation on counter wrap
      timekeeping: Fix cross-timestamp interpolation corner case decision
      timekeeping: Fix cross-timestamp interpolation for non-x86

Ricardo B. Marliere (2):
      clocksource: Make clocksource_subsys const
      clockevents: Make clockevents_subsys const

Richard Cochran (linutronix GmbH) (2):
      timers: Restructure internal locking
      tick/sched: Split out jiffies update helper function


 Documentation/admin-guide/kernel-parameters.txt   |    6 -
 MAINTAINERS                                       |    1 +
 arch/arm/include/asm/elf.h                        |    1 -
 arch/arm/include/asm/vdso_datapage.h              |   26 -
 arch/arm/kernel/asm-offsets.c                     |    4 +-
 arch/arm/kernel/vdso.c                            |    4 -
 arch/arm64/kernel/vdso.c                          |    5 +-
 arch/csky/include/asm/vdso.h                      |    5 -
 arch/csky/kernel/vdso.c                           |   14 +-
 arch/loongarch/kernel/vdso.c                      |    6 +-
 arch/mips/include/asm/vdso.h                      |    5 -
 arch/mips/kernel/vdso.c                           |    2 +-
 arch/riscv/kernel/vdso.c                          |   10 +-
 arch/s390/include/asm/vdso/data.h                 |    1 -
 arch/s390/kernel/vdso.c                           |    5 +-
 include/linux/clocksource.h                       |   14 +-
 include/linux/cpuhotplug.h                        |    2 +
 include/linux/hrtimer.h                           |  119 +-
 include/linux/hrtimer_defs.h                      |  104 ++
 include/linux/jiffies.h                           |   15 +-
 include/linux/tick.h                              |   16 +-
 include/linux/timer.h                             |   16 +-
 include/trace/events/timer_migration.h            |  298 ++++
 include/vdso/datapage.h                           |   14 +
 include/vdso/helpers.h                            |    8 +-
 kernel/cpu.c                                      |   11 +-
 kernel/sched/idle.c                               |    1 -
 kernel/time/Makefile                              |    3 +
 kernel/time/clockevents.c                         |    2 +-
 kernel/time/clocksource-wdtest.c                  |   13 +-
 kernel/time/clocksource.c                         |   12 +-
 kernel/time/hrtimer.c                             |   25 +-
 kernel/time/tick-common.c                         |   31 +-
 kernel/time/tick-internal.h                       |   16 +
 kernel/time/tick-sched.c                          |  361 +++--
 kernel/time/tick-sched.h                          |   42 +-
 kernel/time/time_test.c                           |    2 +-
 kernel/time/timekeeping.c                         |   24 +-
 kernel/time/timer.c                               |  571 +++++--
 kernel/time/timer_list.c                          |   10 +-
 kernel/time/timer_migration.c                     | 1793 +++++++++++++++++++=
++
 kernel/time/timer_migration.h                     |  140 ++
 kernel/workqueue.c                                |    2 +-
 tools/testing/selftests/rcutorture/bin/torture.sh |    2 +-
 44 files changed, 3199 insertions(+), 563 deletions(-)
 delete mode 100644 arch/arm/include/asm/vdso_datapage.h
 create mode 100644 include/trace/events/timer_migration.h
 create mode 100644 kernel/time/timer_migration.c
 create mode 100644 kernel/time/timer_migration.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 31b3a25680d0..763e96dcf8b1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -679,12 +679,6 @@
 			loops can be debugged more effectively on production
 			systems.
=20
-	clocksource.max_cswd_read_retries=3D [KNL]
-			Number of clocksource_watchdog() retries due to
-			external delays before the clock will be marked
-			unstable.  Defaults to two retries, that is,
-			three attempts to read the clock under test.
-
 	clocksource.verify_n_cpus=3D [KNL]
 			Limit the number of CPUs checked for clocksources
 			marked with CLOCK_SOURCE_VERIFY_PERCPU that
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..70c07ae6e584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17499,6 +17499,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/=
tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
 F:	include/linux/timer*
+F:	include/trace/events/timer*
 F:	kernel/time/*timer*
 F:	kernel/time/namespace.c
=20
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d68101655b74..9f21e170320f 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -4,7 +4,6 @@
=20
 #include <asm/auxvec.h>
 #include <asm/hwcap.h>
-#include <asm/vdso_datapage.h>
=20
 /*
  * ELF register definitions..
diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso=
_datapage.h
deleted file mode 100644
index bef68f59928d..000000000000
--- a/arch/arm/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Adapted from arm64 version.
- *
- * Copyright (C) 2012 ARM Limited
- */
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-#include <vdso/datapage.h>
-#include <asm/page.h>
-
-union vdso_data_store {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 219cbc7e5d13..4915662842ff 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -21,10 +21,12 @@
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
-#include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+
+#include <vdso/datapage.h>
+
 #include "signal.h"
=20
 /*
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f297d66a8a76..d499ad461b00 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -21,7 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
 #include <clocksource/arm_arch_timer.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
@@ -35,9 +34,6 @@ extern char vdso_start[], vdso_end[];
 /* Total number of pages needed for the data and text portions of the VDSO. =
*/
 unsigned int vdso_total_pages __ro_after_init;
=20
-/*
- * The VDSO data page.
- */
 static union vdso_data_store vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5562daf38a22..89b6e7840002 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -69,10 +69,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init =
=3D {
 /*
  * The vDSO data page.
  */
-static union {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
 static int vdso_mremap(const struct vm_special_mapping *sm,
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index bdce581b5fcb..181a15edafe8 100644
--- a/arch/csky/include/asm/vdso.h
+++ b/arch/csky/include/asm/vdso.h
@@ -5,11 +5,6 @@
=20
 #include <linux/types.h>
=20
-#ifndef GENERIC_TIME_VSYSCALL
-struct vdso_data {
-};
-#endif
-
 /*
  * The VDSO symbols are mapped into Linux so we can just use regular symbol
  * addressing to get their offsets in userspace.  The symbols are mapped at =
an
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 16c20d64d165..2ca886e4a458 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -8,25 +8,15 @@
 #include <linux/slab.h>
=20
 #include <asm/page.h>
-#ifdef GENERIC_TIME_VSYSCALL
 #include <vdso/datapage.h>
-#else
-#include <asm/vdso.h>
-#endif
=20
 extern char vdso_start[], vdso_end[];
=20
 static unsigned int vdso_pages;
 static struct page **vdso_pagelist;
=20
-/*
- * The vDSO data page.
- */
-static union {
-	struct vdso_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D &vdso_data_store.data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
 static int __init vdso_init(void)
 {
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 14941e4be66d..90dfccb41c14 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -21,15 +21,13 @@
 #include <asm/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
+#include <vdso/datapage.h>
 #include <generated/vdso-offsets.h>
=20
 extern char vdso_start[], vdso_end[];
=20
 /* Kernel-provided data used by the VDSO. */
-static union {
-	u8 page[PAGE_SIZE];
-	struct vdso_data data[CS_BASES];
-} generic_vdso_data __page_aligned_data;
+static union vdso_data_store generic_vdso_data __page_aligned_data;
=20
 static union {
 	u8 page[LOONGARCH_VDSO_DATA_SIZE];
diff --git a/arch/mips/include/asm/vdso.h b/arch/mips/include/asm/vdso.h
index cc7b516129a8..afb03d45bcd0 100644
--- a/arch/mips/include/asm/vdso.h
+++ b/arch/mips/include/asm/vdso.h
@@ -50,9 +50,4 @@ extern struct mips_vdso_image vdso_image_o32;
 extern struct mips_vdso_image vdso_image_n32;
 #endif
=20
-union mips_vdso_data {
-	struct vdso_data data[CS_BASES];
-	u8 page[PAGE_SIZE];
-};
-
 #endif /* __ASM_VDSO_H */
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index f6d40e43f108..dda36fa26307 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -24,7 +24,7 @@
 #include <vdso/vsyscall.h>
=20
 /* Kernel-provided data used by the VDSO. */
-static union mips_vdso_data mips_vdso_data __page_aligned_data;
+static union vdso_data_store mips_vdso_data __page_aligned_data;
 struct vdso_data *vdso_data =3D mips_vdso_data.data;
=20
 /*
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 2cf76218a5bd..98315b98256d 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -30,14 +30,8 @@ enum rv_vdso_map {
=20
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
=20
-/*
- * The vDSO data page.
- */
-static union {
-	struct vdso_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D &vdso_data_store.data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
 struct __vdso_info {
 	const char *name;
diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/d=
ata.h
index 73ee89142666..0e2b40ef69b0 100644
--- a/arch/s390/include/asm/vdso/data.h
+++ b/arch/s390/include/asm/vdso/data.h
@@ -3,7 +3,6 @@
 #define __S390_ASM_VDSO_DATA_H
=20
 #include <linux/types.h>
-#include <vdso/datapage.h>
=20
 struct arch_vdso_data {
 	__s64 tod_steering_delta;
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index bbaefd84f15e..a45b3a4c91db 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -25,10 +25,7 @@ extern char vdso32_start[], vdso32_end[];
=20
 static struct vm_special_mapping vvar_mapping;
=20
-static union {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
+static union vdso_data_store vdso_data_store __page_aligned_data;
=20
 struct vdso_data *vdso_data =3D vdso_data_store.data;
=20
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..0ad8b550bb4b 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,19 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
=20
-extern ulong max_cswd_read_retries;
+static inline unsigned int clocksource_get_max_watchdog_retry(void)
+{
+	/*
+	 * When system is in the boot phase or under heavy workload, there
+	 * can be random big latencies during the clocksource/watchdog
+	 * read, so allow retries to filter the noise latency. As the
+	 * latency's frequency and maximum value goes up with the number of
+	 * CPUs, scale the number of retries with the number of online
+	 * CPUs.
+	 */
+	return (ilog2(num_online_cpus()) / 2) + 1;
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
=20
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 172d0a743e5d..35e78ddb2b37 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -184,6 +184,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
 	CPUHP_AP_HRTIMERS_DYING,
+	CPUHP_AP_TICK_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
@@ -231,6 +232,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
+	CPUHP_AP_TMIGR_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RANDOM_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 641c4567cfa7..aa1e65ccb615 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -18,12 +18,8 @@
 #include <linux/list.h>
 #include <linux/percpu-defs.h>
 #include <linux/rbtree.h>
-#include <linux/seqlock.h>
 #include <linux/timer.h>
=20
-struct hrtimer_clock_base;
-struct hrtimer_cpu_base;
-
 /*
  * Mode arguments of xxx_hrtimer functions:
  *
@@ -98,107 +94,6 @@ struct hrtimer_sleeper {
 	struct task_struct *task;
 };
=20
-#ifdef CONFIG_64BIT
-# define __hrtimer_clock_base_align	____cacheline_aligned
-#else
-# define __hrtimer_clock_base_align
-#endif
-
-/**
- * struct hrtimer_clock_base - the timer base for a specific clock
- * @cpu_base:		per cpu clock base
- * @index:		clock type index for per_cpu support when moving a
- *			timer to a base on another cpu.
- * @clockid:		clock id for per_cpu support
- * @seq:		seqcount around __run_hrtimer
- * @running:		pointer to the currently running hrtimer
- * @active:		red black tree root node for the active timers
- * @get_time:		function to retrieve the current time of the clock
- * @offset:		offset of this clock to the monotonic base
- */
-struct hrtimer_clock_base {
-	struct hrtimer_cpu_base	*cpu_base;
-	unsigned int		index;
-	clockid_t		clockid;
-	seqcount_raw_spinlock_t	seq;
-	struct hrtimer		*running;
-	struct timerqueue_head	active;
-	ktime_t			(*get_time)(void);
-	ktime_t			offset;
-} __hrtimer_clock_base_align;
-
-enum  hrtimer_base_type {
-	HRTIMER_BASE_MONOTONIC,
-	HRTIMER_BASE_REALTIME,
-	HRTIMER_BASE_BOOTTIME,
-	HRTIMER_BASE_TAI,
-	HRTIMER_BASE_MONOTONIC_SOFT,
-	HRTIMER_BASE_REALTIME_SOFT,
-	HRTIMER_BASE_BOOTTIME_SOFT,
-	HRTIMER_BASE_TAI_SOFT,
-	HRTIMER_MAX_CLOCK_BASES,
-};
-
-/**
- * struct hrtimer_cpu_base - the per cpu clock bases
- * @lock:		lock protecting the base and associated clock bases
- *			and timers
- * @cpu:		cpu number
- * @active_bases:	Bitfield to mark bases with active timers
- * @clock_was_set_seq:	Sequence counter of clock was set events
- * @hres_active:	State of high resolution mode
- * @in_hrtirq:		hrtimer_interrupt() is currently executing
- * @hang_detected:	The last hrtimer interrupt detected a hang
- * @softirq_activated:	displays, if the softirq is raised - update of softirq
- *			related settings is not required then.
- * @nr_events:		Total number of hrtimer interrupt events
- * @nr_retries:		Total number of hrtimer interrupt retries
- * @nr_hangs:		Total number of hrtimer interrupt hangs
- * @max_hang_time:	Maximum time spent in hrtimer_interrupt
- * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
- *			 expired
- * @online:		CPU is online from an hrtimers point of view
- * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
- *			callback to finish.
- * @expires_next:	absolute time of the next event, is required for remote
- *			hrtimer enqueue; it is the total first expiry time (hard
- *			and soft hrtimer are taken into account)
- * @next_timer:		Pointer to the first expiring timer
- * @softirq_expires_next: Time to check, if soft queues needs also to be exp=
ired
- * @softirq_next_timer: Pointer to the first expiring softirq based timer
- * @clock_base:		array of clock bases for this cpu
- *
- * Note: next_timer is just an optimization for __remove_hrtimer().
- *	 Do not dereference the pointer because it is not reliable on
- *	 cross cpu removals.
- */
-struct hrtimer_cpu_base {
-	raw_spinlock_t			lock;
-	unsigned int			cpu;
-	unsigned int			active_bases;
-	unsigned int			clock_was_set_seq;
-	unsigned int			hres_active		: 1,
-					in_hrtirq		: 1,
-					hang_detected		: 1,
-					softirq_activated       : 1,
-					online			: 1;
-#ifdef CONFIG_HIGH_RES_TIMERS
-	unsigned int			nr_events;
-	unsigned short			nr_retries;
-	unsigned short			nr_hangs;
-	unsigned int			max_hang_time;
-#endif
-#ifdef CONFIG_PREEMPT_RT
-	spinlock_t			softirq_expiry_lock;
-	atomic_t			timer_waiters;
-#endif
-	ktime_t				expires_next;
-	struct hrtimer			*next_timer;
-	ktime_t				softirq_expires_next;
-	struct hrtimer			*softirq_next_timer;
-	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
-} ____cacheline_aligned;
-
 static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
 {
 	timer->node.expires =3D time;
@@ -447,20 +342,12 @@ extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
=20
 /**
- * hrtimer_forward_now - forward the timer expiry so it expires after now
+ * hrtimer_forward_now() - forward the timer expiry so it expires after now
  * @timer:	hrtimer to forward
  * @interval:	the interval to forward
  *
- * Forward the timer expiry so it will expire after the current time
- * of the hrtimer clock base. Returns the number of overruns.
- *
- * Can be safely called from the callback function of @timer. If
- * called from other contexts @timer must neither be enqueued nor
- * running the callback and the caller needs to take care of
- * serialization.
- *
- * Note: This only updates the timer expiry value and does not requeue
- * the timer.
+ * It is a variant of hrtimer_forward(). The timer will expire after the cur=
rent
+ * time of the hrtimer clock base. See hrtimer_forward() for details.
  */
 static inline u64 hrtimer_forward_now(struct hrtimer *timer,
 				      ktime_t interval)
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 2d3e3c5fb946..c3b4b7ed7c16 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -3,6 +3,8 @@
 #define _LINUX_HRTIMER_DEFS_H
=20
 #include <linux/ktime.h>
+#include <linux/timerqueue.h>
+#include <linux/seqlock.h>
=20
 #ifdef CONFIG_HIGH_RES_TIMERS
=20
@@ -24,4 +26,106 @@
=20
 #endif
=20
+#ifdef CONFIG_64BIT
+# define __hrtimer_clock_base_align	____cacheline_aligned
+#else
+# define __hrtimer_clock_base_align
+#endif
+
+/**
+ * struct hrtimer_clock_base - the timer base for a specific clock
+ * @cpu_base:		per cpu clock base
+ * @index:		clock type index for per_cpu support when moving a
+ *			timer to a base on another cpu.
+ * @clockid:		clock id for per_cpu support
+ * @seq:		seqcount around __run_hrtimer
+ * @running:		pointer to the currently running hrtimer
+ * @active:		red black tree root node for the active timers
+ * @get_time:		function to retrieve the current time of the clock
+ * @offset:		offset of this clock to the monotonic base
+ */
+struct hrtimer_clock_base {
+	struct hrtimer_cpu_base	*cpu_base;
+	unsigned int		index;
+	clockid_t		clockid;
+	seqcount_raw_spinlock_t	seq;
+	struct hrtimer		*running;
+	struct timerqueue_head	active;
+	ktime_t			(*get_time)(void);
+	ktime_t			offset;
+} __hrtimer_clock_base_align;
+
+enum  hrtimer_base_type {
+	HRTIMER_BASE_MONOTONIC,
+	HRTIMER_BASE_REALTIME,
+	HRTIMER_BASE_BOOTTIME,
+	HRTIMER_BASE_TAI,
+	HRTIMER_BASE_MONOTONIC_SOFT,
+	HRTIMER_BASE_REALTIME_SOFT,
+	HRTIMER_BASE_BOOTTIME_SOFT,
+	HRTIMER_BASE_TAI_SOFT,
+	HRTIMER_MAX_CLOCK_BASES,
+};
+
+/**
+ * struct hrtimer_cpu_base - the per cpu clock bases
+ * @lock:		lock protecting the base and associated clock bases
+ *			and timers
+ * @cpu:		cpu number
+ * @active_bases:	Bitfield to mark bases with active timers
+ * @clock_was_set_seq:	Sequence counter of clock was set events
+ * @hres_active:	State of high resolution mode
+ * @in_hrtirq:		hrtimer_interrupt() is currently executing
+ * @hang_detected:	The last hrtimer interrupt detected a hang
+ * @softirq_activated:	displays, if the softirq is raised - update of softirq
+ *			related settings is not required then.
+ * @nr_events:		Total number of hrtimer interrupt events
+ * @nr_retries:		Total number of hrtimer interrupt retries
+ * @nr_hangs:		Total number of hrtimer interrupt hangs
+ * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
+ * @online:		CPU is online from an hrtimers point of view
+ * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
+ *			callback to finish.
+ * @expires_next:	absolute time of the next event, is required for remote
+ *			hrtimer enqueue; it is the total first expiry time (hard
+ *			and soft hrtimer are taken into account)
+ * @next_timer:		Pointer to the first expiring timer
+ * @softirq_expires_next: Time to check, if soft queues needs also to be exp=
ired
+ * @softirq_next_timer: Pointer to the first expiring softirq based timer
+ * @clock_base:		array of clock bases for this cpu
+ *
+ * Note: next_timer is just an optimization for __remove_hrtimer().
+ *	 Do not dereference the pointer because it is not reliable on
+ *	 cross cpu removals.
+ */
+struct hrtimer_cpu_base {
+	raw_spinlock_t			lock;
+	unsigned int			cpu;
+	unsigned int			active_bases;
+	unsigned int			clock_was_set_seq;
+	unsigned int			hres_active		: 1,
+					in_hrtirq		: 1,
+					hang_detected		: 1,
+					softirq_activated       : 1,
+					online			: 1;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	unsigned int			nr_events;
+	unsigned short			nr_retries;
+	unsigned short			nr_hangs;
+	unsigned int			max_hang_time;
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t			softirq_expiry_lock;
+	atomic_t			timer_waiters;
+#endif
+	ktime_t				expires_next;
+	struct hrtimer			*next_timer;
+	ktime_t				softirq_expires_next;
+	struct hrtimer			*softirq_next_timer;
+	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+} ____cacheline_aligned;
+
+
 #endif
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index e0ae2a43e0eb..d9f1435a5a13 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -102,12 +102,15 @@ static inline u64 get_jiffies_64(void)
 }
 #endif
=20
-/*
- *	These inlines deal with timer wrapping correctly. You are
- *	strongly encouraged to use them:
- *	1. Because people otherwise forget
- *	2. Because if the timer wrap changes in future you won't have to
- *	   alter your driver code.
+/**
+ * DOC: General information about time_* inlines
+ *
+ * These inlines deal with timer wrapping correctly. You are strongly encour=
aged
+ * to use them:
+ *
+ * #. Because people otherwise forget
+ * #. Because if the timer wrap changes in future you won't have to alter yo=
ur
+ *    driver code.
  */
=20
 /**
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f31c45..44fddfa93e18 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -19,16 +19,22 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it =
*/
 extern void tick_resume_local(void);
-extern void tick_handover_do_timer(void);
 extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_handover_do_timer(void) { }
 static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
=20
+#if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
+extern int tick_cpu_dying(unsigned int cpu);
+extern void tick_assert_timekeeping_handover(void);
+#else
+#define tick_cpu_dying	NULL
+static inline void tick_assert_timekeeping_handover(void) { }
+#endif
+
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_SUSPEND)
 extern void tick_freeze(void);
 extern void tick_unfreeze(void);
@@ -69,12 +75,6 @@ extern void tick_broadcast_control(enum tick_broadcast_mod=
e mode);
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
=20
-#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_=
CPU)
-extern void tick_offline_cpu(unsigned int cpu);
-#else
-static inline void tick_offline_cpu(unsigned int cpu) { }
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
 #else
diff --git a/include/linux/timer.h b/include/linux/timer.h
index f18a2f1eb79e..14a633ba61d6 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,16 +36,10 @@
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  *
- * @TIMER_PINNED: A pinned timer will not be affected by any timer
- * placement heuristics (like, NOHZ) and will always expire on the CPU
- * on which the timer was enqueued.
- *
- * Note: Because enqueuing of timers can migrate the timer from one
- * CPU to another, pinned timers are not guaranteed to stay on the
- * initialy selected CPU.  They move to the CPU on which the enqueue
- * function is invoked via mod_timer() or add_timer().  If the timer
- * should be placed on a particular CPU, then add_timer_on() has to be
- * used.
+ * @TIMER_PINNED: A pinned timer will always expire on the CPU on which the
+ * timer was enqueued. When a particular CPU is required, add_timer_on()
+ * has to be used. Enqueue via mod_timer() and add_timer() is always done
+ * on the local CPU.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
@@ -165,6 +159,8 @@ extern int timer_reduce(struct timer_list *timer, unsigne=
d long expires);
 #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
=20
 extern void add_timer(struct timer_list *timer);
+extern void add_timer_local(struct timer_list *timer);
+extern void add_timer_global(struct timer_list *timer);
=20
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
diff --git a/include/trace/events/timer_migration.h b/include/trace/events/ti=
mer_migration.h
new file mode 100644
index 000000000000..79f19e76a80b
--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,298 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+TRACE_EVENT(tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+	),
+
+	TP_fast_assign(
+		__entry->group		=3D group;
+		__entry->lvl		=3D group->level;
+		__entry->numa_node	=3D group->numa_node;
+	),
+
+	TP_printk("group=3D%p lvl=3D%d numa=3D%d",
+		  __entry->group, __entry->lvl, __entry->numa_node)
+);
+
+TRACE_EVENT(tmigr_connect_child_parent,
+
+	TP_PROTO(struct tmigr_group *child),
+
+	TP_ARGS(child),
+
+	TP_STRUCT__entry(
+		__field( void *,	child		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		=3D child;
+		__entry->parent		=3D child->parent;
+		__entry->lvl		=3D child->parent->level;
+		__entry->numa_node	=3D child->parent->numa_node;
+		__entry->num_children	=3D child->parent->num_children;
+		__entry->childmask	=3D child->childmask;
+	),
+
+	TP_printk("group=3D%p childmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_ch=
ildren=3D%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+TRACE_EVENT(tmigr_connect_cpu_parent,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent		)
+		__field( unsigned int,	cpu		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		=3D tmc->tmgroup;
+		__entry->cpu		=3D tmc->cpuevt.cpu;
+		__entry->lvl		=3D tmc->tmgroup->level;
+		__entry->numa_node	=3D tmc->tmgroup->numa_node;
+		__entry->num_children	=3D tmc->tmgroup->num_children;
+		__entry->childmask	=3D tmc->childmask;
+	),
+
+	TP_printk("cpu=3D%d childmask=3D%0x parent=3D%p lvl=3D%d numa=3D%d num_chil=
dren=3D%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( u32,		childmask	)
+		__field( u8,		active		)
+		__field( u8,		migrator	)
+	),
+
+	TP_fast_assign(
+		__entry->group		=3D group;
+		__entry->parent		=3D group->parent;
+		__entry->lvl		=3D group->level;
+		__entry->numa_node	=3D group->numa_node;
+		__entry->childmask	=3D childmask;
+		__entry->active		=3D state.active;
+		__entry->migrator	=3D state.migrator;
+	),
+
+	TP_printk("group=3D%p lvl=3D%d numa=3D%d active=3D%0x migrator=3D%0x "
+		  "parent=3D%p childmask=3D%0x",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator,
+		  __entry->parent, __entry->childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( u64,		wakeup	)
+		__field( void *,	parent	)
+		__field( unsigned int,	cpu	)
+
+	),
+
+	TP_fast_assign(
+		__entry->wakeup		=3D tmc->wakeup;
+		__entry->parent		=3D tmc->tmgroup;
+		__entry->cpu		=3D tmc->cpuevt.cpu;
+	),
+
+	TP_printk("cpu=3D%d parent=3D%p wakeup=3D%llu", __entry->cpu, __entry->pare=
nt, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DECLARE_EVENT_CLASS(tmigr_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt),
+
+	TP_STRUCT__entry(
+		__field( u64,		nextevt)
+		__field( u64,		wakeup)
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+	),
+
+	TP_fast_assign(
+		__entry->nextevt	=3D nextevt;
+		__entry->wakeup		=3D tmc->wakeup;
+		__entry->parent		=3D tmc->tmgroup;
+		__entry->cpu		=3D tmc->cpuevt.cpu;
+	),
+
+	TP_printk("cpu=3D%d parent=3D%p nextevt=3D%llu wakeup=3D%llu",
+		  __entry->cpu, __entry->parent, __entry->nextevt, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_new_timer_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+TRACE_EVENT(tmigr_update_events,
+
+	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
+		 union tmigr_state childstate,	union tmigr_state groupstate,
+		 u64 nextevt),
+
+	TP_ARGS(child, group, childstate, groupstate, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	child			)
+		__field( void *,	group			)
+		__field( u64,		nextevt			)
+		__field( u64,		group_next_expiry	)
+		__field( u64,		child_evt_expiry	)
+		__field( unsigned int,	group_lvl		)
+		__field( unsigned int,	child_evtcpu		)
+		__field( u8,		child_active		)
+		__field( u8,		group_active		)
+	),
+
+	TP_fast_assign(
+		__entry->child			=3D child;
+		__entry->group			=3D group;
+		__entry->nextevt		=3D nextevt;
+		__entry->group_next_expiry	=3D group->next_expiry;
+		__entry->child_evt_expiry	=3D child ? child->groupevt.nextevt.expires : 0;
+		__entry->group_lvl		=3D group->level;
+		__entry->child_evtcpu		=3D child ? child->groupevt.cpu : 0;
+		__entry->child_active		=3D childstate.active;
+		__entry->group_active		=3D groupstate.active;
+	),
+
+	TP_printk("child=3D%p group=3D%p group_lvl=3D%d child_active=3D%0x group_ac=
tive=3D%0x "
+		  "nextevt=3D%llu next_expiry=3D%llu child_evt_expiry=3D%llu child_evtcpu=
=3D%d",
+		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_activ=
e,
+		  __entry->group_active,
+		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
+		  __entry->child_evtcpu)
+);
+
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void * ,	group	)
+		__field( unsigned int ,	lvl	)
+	),
+
+	TP_fast_assign(
+		__entry->group		=3D group;
+		__entry->lvl		=3D group->level;
+	),
+
+	TP_printk("group=3D%p lvl=3D%d",
+		   __entry->group, __entry->lvl)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..5d5c0b8efff2 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,12 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
=20
+#ifdef CONFIG_ARM64
+#include <asm/page-def.h>
+#else
+#include <asm/page.h>
+#endif
+
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -121,6 +127,14 @@ struct vdso_data {
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidd=
en")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hi=
dden")));
=20
+/**
+ * union vdso_data_store - Generic vDSO data page
+ */
+union vdso_data_store {
+	struct vdso_data	data[CS_BASES];
+	u8			page[PAGE_SIZE];
+};
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 9a2af9fca45e..73501149439d 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -30,9 +30,9 @@ static __always_inline u32 vdso_read_retry(const struct vds=
o_data *vd,
 static __always_inline void vdso_write_begin(struct vdso_data *vd)
 {
 	/*
-	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader it is inconsistent.
+	 * reader is inconsistent.
 	 */
 	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
 	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
@@ -43,9 +43,9 @@ static __always_inline void vdso_write_end(struct vdso_data=
 *vd)
 {
 	smp_wmb();
 	/*
-	 * WRITE_ONCE it is required otherwise the compiler can validly tear
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader it is inconsistent.
+	 * reader is inconsistent.
 	 */
 	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
 	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..7e84a7b0675e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1324,10 +1324,6 @@ static int take_cpu_down(void *_param)
 	 */
 	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
=20
-	/* Give up timekeeping duties */
-	tick_handover_do_timer();
-	/* Remove CPU from timer broadcasting */
-	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
 	stop_machine_park(cpu);
 	return 0;
@@ -1403,6 +1399,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st =3D this_cpu_ptr(&cpuhp_state);
=20
 	BUG_ON(st->state !=3D CPUHP_AP_OFFLINE);
+	tick_assert_timekeeping_handover();
 	rcutree_report_cpu_dead();
 	st->state =3D CPUHP_AP_IDLE_DEAD;
 	/*
@@ -2205,7 +2202,11 @@ static struct cpuhp_step cpuhp_hp_states[] =3D {
 		.startup.single		=3D NULL,
 		.teardown.single	=3D hrtimers_cpu_dying,
 	},
-
+	[CPUHP_AP_TICK_DYING] =3D {
+		.name			=3D "tick:dying",
+		.startup.single		=3D NULL,
+		.teardown.single	=3D tick_cpu_dying,
+	},
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] =3D {
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 31231925f1ec..b15d40cad7ea 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -291,7 +291,6 @@ static void do_idle(void)
 		local_irq_disable();
=20
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 7e875e63ff3b..4af2a264a160 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -17,6 +17,9 @@ endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+=3D sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+=3D tick-oneshot.o tick-sched.o
 obj-$(CONFIG_LEGACY_TIMER_TICK)			+=3D tick-legacy.o
+ifeq ($(CONFIG_SMP),y)
+ obj-$(CONFIG_NO_HZ_COMMON)			+=3D timer_migration.o
+endif
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+=3D vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+=3D timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+=3D test_udelay.o
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 960143b183cd..a7ca458cdd9c 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -659,7 +659,7 @@ void tick_cleanup_dead_cpu(int cpu)
 #endif
=20
 #ifdef CONFIG_SYSFS
-static struct bus_type clockevents_subsys =3D {
+static const struct bus_type clockevents_subsys =3D {
 	.name		=3D "clockevents",
 	.dev_name       =3D "clockevent",
 };
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtes=
t.c
index df922f49d171..d06185e054ea 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -104,8 +104,8 @@ static void wdtest_ktime_clocksource_reset(void)
 static int wdtest_func(void *arg)
 {
 	unsigned long j1, j2;
+	int i, max_retries;
 	char *s;
-	int i;
=20
 	schedule_timeout_uninterruptible(holdoff * HZ);
=20
@@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
=20
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i =3D 0; i <=3D max_cswd_read_retries + 1; i++) {
-		if (i <=3D 1 && i < max_cswd_read_retries)
+	max_retries =3D clocksource_get_max_watchdog_retry();
+	for (i =3D 0; i <=3D max_retries + 1; i++) {
+		if (i <=3D 1 && i < max_retries)
 			s =3D "";
-		else if (i <=3D max_cswd_read_retries)
+		else if (i <=3D max_retries)
 			s =3D ", expect message";
 		else
 			s =3D ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_=
cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_r=
etries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <=3D max_cswd_read_retries) !=3D
+		WARN_ON_ONCE((i <=3D max_retries) !=3D
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3052b1f1168e..e5b260aa0e02 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -210,9 +210,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
=20
-ulong max_cswd_read_retries =3D 2;
-module_param(max_cswd_read_retries, ulong, 0644);
-EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus =3D 8;
 module_param(verify_n_cpus, int, 0644);
=20
@@ -224,11 +221,12 @@ enum wd_read_status {
=20
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csn=
ow, u64 *wdnow)
 {
-	unsigned int nretries;
+	unsigned int nretries, max_retries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
=20
-	for (nretries =3D 0; nretries <=3D max_cswd_read_retries; nretries++) {
+	max_retries =3D clocksource_get_max_watchdog_retry();
+	for (nretries =3D 0; nretries <=3D max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow =3D watchdog->read(watchdog);
 		*csnow =3D cs->read(cs);
@@ -240,7 +238,7 @@ static enum wd_read_status cs_watchdog_read(struct clocks=
ource *cs, u64 *csnow,
 		wd_delay =3D clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <=3D WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >=3D max_cswd_read_retries) {
+			if (nretries > 1 || nretries >=3D max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before succe=
ss\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
@@ -1468,7 +1466,7 @@ static struct attribute *clocksource_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(clocksource);
=20
-static struct bus_type clocksource_subsys =3D {
+static const struct bus_type clocksource_subsys =3D {
 	.name =3D "clocksource",
 	.dev_name =3D "clocksource",
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb0f821dcea..70625dff62ce 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -38,6 +38,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -746,7 +747,7 @@ static void hrtimer_switch_to_hres(void)
 	base->hres_active =3D 1;
 	hrtimer_resolution =3D HIGH_RES_NSEC;
=20
-	tick_setup_sched_timer();
+	tick_setup_sched_timer(true);
 	/* "Retrigger" the interrupt to get things going */
 	retrigger_next_event(NULL);
 }
@@ -1021,21 +1022,23 @@ void unlock_hrtimer_base(const struct hrtimer *timer,=
 unsigned long *flags)
 }
=20
 /**
- * hrtimer_forward - forward the timer expiry
+ * hrtimer_forward() - forward the timer expiry
  * @timer:	hrtimer to forward
  * @now:	forward past this time
  * @interval:	the interval to forward
  *
  * Forward the timer expiry so it will expire in the future.
- * Returns the number of overruns.
  *
- * Can be safely called from the callback function of @timer. If
- * called from other contexts @timer must neither be enqueued nor
- * running the callback and the caller needs to take care of
- * serialization.
+ * .. note::
+ *  This only updates the timer expiry value and does not requeue the timer.
  *
- * Note: This only updates the timer expiry value and does not requeue
- * the timer.
+ * There is also a variant of the function hrtimer_forward_now().
+ *
+ * Context: Can be safely called from the callback function of @timer. If ca=
lled
+ *          from other contexts @timer must neither be enqueued nor running =
the
+ *          callback and the caller needs to take care of serialization.
+ *
+ * Return: The number of overruns are returned.
  */
 u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 {
@@ -2223,10 +2226,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_=
base *old_base,
=20
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TY=
PE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu =3D cpumask_first(cpu_active_mask);
-
-	tick_cancel_sched_timer(dying_cpu);
=20
 	old_base =3D this_cpu_ptr(&hrtimer_bases);
 	new_base =3D &per_cpu(hrtimer_bases, ncpu);
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e9138cd7a0f5..fb0fdec8719a 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -111,15 +111,13 @@ void tick_handle_periodic(struct clock_event_device *de=
v)
=20
 	tick_periodic(cpu);
=20
-#if defined(CONFIG_HIGH_RES_TIMERS) || defined(CONFIG_NO_HZ_COMMON)
 	/*
 	 * The cpu might have transitioned to HIGHRES or NOHZ mode via
 	 * update_process_times() -> run_local_timers() ->
 	 * hrtimer_run_queues().
 	 */
-	if (dev->event_handler !=3D tick_handle_periodic)
+	if (IS_ENABLED(CONFIG_TICK_ONESHOT) && dev->event_handler !=3D tick_handle_=
periodic)
 		return;
-#endif
=20
 	if (!clockevent_state_oneshot(dev))
 		return;
@@ -398,16 +396,31 @@ int tick_broadcast_oneshot_control(enum tick_broadcast_=
state state)
 EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
=20
 #ifdef CONFIG_HOTPLUG_CPU
+void tick_assert_timekeeping_handover(void)
+{
+	WARN_ON_ONCE(tick_do_timer_cpu =3D=3D smp_processor_id());
+}
 /*
- * Transfer the do_timer job away from a dying cpu.
- *
- * Called with interrupts disabled. No locking required. If
- * tick_do_timer_cpu is owned by this cpu, nothing can change it.
+ * Stop the tick and transfer the timekeeping job away from a dying cpu.
  */
-void tick_handover_do_timer(void)
+int tick_cpu_dying(unsigned int dying_cpu)
 {
-	if (tick_do_timer_cpu =3D=3D smp_processor_id())
+	/*
+	 * If the current CPU is the timekeeper, it's the only one that
+	 * can safely hand over its duty. Also all online CPUs are in
+	 * stop machine, guaranteed not to be idle, therefore it's safe
+	 * to pick any online successor.
+	 */
+	if (tick_do_timer_cpu =3D=3D dying_cpu)
 		tick_do_timer_cpu =3D cpumask_first(cpu_online_mask);
+
+	/* Make sure the CPU won't try to retake the timekeeping duty */
+	tick_sched_timer_dying(dying_cpu);
+
+	/* Remove CPU from timer broadcasting */
+	tick_offline_cpu(dying_cpu);
+
+	return 0;
 }
=20
 /*
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 481b7ab65e2c..5f2105e637bd 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -8,6 +8,11 @@
 #include "timekeeping.h"
 #include "tick-sched.h"
=20
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
=20
 # define TICK_DO_TIMER_NONE	-1
@@ -137,8 +142,10 @@ static inline bool tick_broadcast_oneshot_available(void=
) { return tick_oneshot_
 #endif /* !(BROADCAST && ONESHOT) */
=20
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_=
CPU)
+extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_broadcast_offline(unsigned int cpu);
 #else
+static inline void tick_offline_cpu(unsigned int cpu) { }
 static inline void tick_broadcast_offline(unsigned int cpu) { }
 #endif
=20
@@ -152,8 +159,16 @@ static inline void tick_nohz_init(void) { }
 #ifdef CONFIG_NO_HZ_COMMON
 extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
+extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
+extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					      struct timer_events *tevt,
+					      unsigned int cpu);
+extern void timer_lock_remote_bases(unsigned int cpu);
+extern void timer_unlock_remote_bases(unsigned int cpu);
+extern bool timer_base_is_idle(void);
+extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
@@ -163,6 +178,7 @@ static inline void timers_update_nohz(void) { }
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
=20
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
=20
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c1b17e..269e21590df5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -43,7 +43,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 	return &per_cpu(tick_cpu_sched, cpu);
 }
=20
-#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
@@ -181,13 +180,32 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
=20
+static inline int tick_sched_flag_test(struct tick_sched *ts,
+				       unsigned long flag)
+{
+	return !!(ts->flags & flag);
+}
+
+static inline void tick_sched_flag_set(struct tick_sched *ts,
+				       unsigned long flag)
+{
+	lockdep_assert_irqs_disabled();
+	ts->flags |=3D flag;
+}
+
+static inline void tick_sched_flag_clear(struct tick_sched *ts,
+					 unsigned long flag)
+{
+	lockdep_assert_irqs_disabled();
+	ts->flags &=3D ~flag;
+}
+
 #define MAX_STALLED_JIFFIES 5
=20
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu =3D smp_processor_id();
=20
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * Check if the do_timer duty was dropped. We don't care about
 	 * concurrency: This happens only when the CPU in charge went
@@ -198,13 +216,13 @@ static void tick_sched_do_timer(struct tick_sched *ts, =
ktime_t now)
 	 * If nohz_full is enabled, this should not happen because the
 	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
-	if (unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
+	    unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
 		WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu =3D cpu;
 	}
-#endif
=20
 	/* Check if jiffies need an update */
 	if (tick_do_timer_cpu =3D=3D cpu)
@@ -225,13 +243,12 @@ static void tick_sched_do_timer(struct tick_sched *ts, =
ktime_t now)
 		}
 	}
=20
-	if (ts->inidle)
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
 		ts->got_idle_tick =3D 1;
 }
=20
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
 {
-#ifdef CONFIG_NO_HZ_COMMON
 	/*
 	 * When we are idle and the tick is stopped, we have to touch
 	 * the watchdog as we might not schedule for a really long
@@ -240,7 +257,8 @@ static void tick_sched_handle(struct tick_sched *ts, stru=
ct pt_regs *regs)
 	 * idle" jiffy stamp so the idle accounting adjustment we do
 	 * when we go busy again does not account too many ticks.
 	 */
-	if (ts->tick_stopped) {
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
+	    tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		touch_softlockup_watchdog_sched();
 		if (is_idle_task(current))
 			ts->idle_jiffies++;
@@ -251,11 +269,52 @@ static void tick_sched_handle(struct tick_sched *ts, st=
ruct pt_regs *regs)
 		 */
 		ts->next_tick =3D 0;
 	}
-#endif
+
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING);
 }
-#endif
+
+/*
+ * We rearm the timer until we get disabled by the idle code.
+ * Called with interrupts disabled.
+ */
+static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
+{
+	struct tick_sched *ts =3D	container_of(timer, struct tick_sched, sched_time=
r);
+	struct pt_regs *regs =3D get_irq_regs();
+	ktime_t now =3D ktime_get();
+
+	tick_sched_do_timer(ts, now);
+
+	/*
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
+	 */
+	if (regs)
+		tick_sched_handle(ts, regs);
+	else
+		ts->next_tick =3D 0;
+
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (unlikely(tick_sched_flag_test(ts, TS_FLAG_STOPPED)))
+		return HRTIMER_NORESTART;
+
+	hrtimer_forward(timer, now, TICK_NSEC);
+
+	return HRTIMER_RESTART;
+}
+
+static void tick_sched_timer_cancel(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
+	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		tick_program_event(KTIME_MAX, 1);
+}
=20
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
@@ -529,7 +588,7 @@ void __tick_nohz_task_switch(void)
=20
 	ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
-	if (ts->tick_stopped) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		if (atomic_read(&current->tick_dep_mask) ||
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
@@ -601,7 +660,7 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
-#endif
+#endif /* #ifdef CONFIG_NO_HZ_FULL */
=20
 /*
  * NOHZ - aka dynamic tick functionality
@@ -626,14 +685,14 @@ bool tick_nohz_tick_stopped(void)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
-	return ts->tick_stopped;
+	return tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 }
=20
 bool tick_nohz_tick_stopped_cpu(int cpu)
 {
 	struct tick_sched *ts =3D per_cpu_ptr(&tick_cpu_sched, cpu);
=20
-	return ts->tick_stopped;
+	return tick_sched_flag_test(ts, TS_FLAG_STOPPED);
 }
=20
 /**
@@ -663,7 +722,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, kt=
ime_t now)
 {
 	ktime_t delta;
=20
-	if (WARN_ON_ONCE(!ts->idle_active))
+	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
 		return;
=20
 	delta =3D ktime_sub(now, ts->idle_entrytime);
@@ -675,7 +734,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, kt=
ime_t now)
 		ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime, delta);
=20
 	ts->idle_entrytime =3D now;
-	ts->idle_active =3D 0;
+	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
 	write_seqcount_end(&ts->idle_sleeptime_seq);
=20
 	sched_clock_idle_wakeup_event();
@@ -685,7 +744,7 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 {
 	write_seqcount_begin(&ts->idle_sleeptime_seq);
 	ts->idle_entrytime =3D ktime_get();
-	ts->idle_active =3D 1;
+	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
 	write_seqcount_end(&ts->idle_sleeptime_seq);
=20
 	sched_clock_idle_sleep_event();
@@ -707,7 +766,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, k=
time_t *sleeptime,
 	do {
 		seq =3D read_seqcount_begin(&ts->idle_sleeptime_seq);
=20
-		if (ts->idle_active && compute_delta) {
+		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
 			ktime_t delta =3D ktime_sub(now, ts->idle_entrytime);
=20
 			idle =3D ktime_add(*sleeptime, delta);
@@ -780,7 +839,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktim=
e_t now)
 	/* Forward the time to expire in the future */
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
=20
-	if (ts->nohz_mode =3D=3D NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start_expires(&ts->sched_timer,
 				      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -799,18 +858,40 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
=20
-static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+/*
+ * Read jiffies and the time when jiffies were updated last
+ */
+u64 get_jiffies_update(unsigned long *basej)
 {
-	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
+	u64 basemono;
=20
-	/* Read jiffies and the time when jiffies were updated last */
 	do {
 		seq =3D read_seqcount_begin(&jiffies_seq);
 		basemono =3D last_jiffies_update;
 		basejiff =3D jiffies;
 	} while (read_seqcount_retry(&jiffies_seq, seq));
+	*basej =3D basejiff;
+	return basemono;
+}
+
+/**
+ * tick_nohz_next_event() - return the clock monotonic based next event
+ * @ts:		pointer to tick_sched struct
+ * @cpu:	CPU number
+ *
+ * Return:
+ * *%0		- When the next event is a maximum of TICK_NSEC in the future
+ *		  and the tick is not stopped yet
+ * *%next_event	- Next event based on clock monotonic
+ */
+static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
+{
+	u64 basemono, next_tick, delta, expires;
+	unsigned long basejiff;
+
+	basemono =3D get_jiffies_update(&basejiff);
 	ts->last_jiffies =3D basejiff;
 	ts->timer_expires_base =3D basemono;
=20
@@ -849,16 +930,11 @@ static ktime_t tick_nohz_next_event(struct tick_sched *=
ts, int cpu)
 	 */
 	delta =3D next_tick - basemono;
 	if (delta <=3D (u64)TICK_NSEC) {
-		/*
-		 * Tell the timer code that the base is not idle, i.e. undo
-		 * the effect of get_next_timer_interrupt():
-		 */
-		timer_clear_idle();
 		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
 		 */
-		if (!ts->tick_stopped) {
+		if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			ts->timer_expires =3D 0;
 			goto out;
 		}
@@ -871,7 +947,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts=
, int cpu)
 	 */
 	delta =3D timekeeping_max_deferment();
 	if (cpu !=3D tick_do_timer_cpu &&
-	    (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE || !ts->do_timer_last))
+	    (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE ||
+	     !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
 		delta =3D KTIME_MAX;
=20
 	/* Calculate the next expiry time */
@@ -889,12 +966,38 @@ static ktime_t tick_nohz_next_event(struct tick_sched *=
ts, int cpu)
 static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 {
 	struct clock_event_device *dev =3D __this_cpu_read(tick_cpu_device.evtdev);
+	unsigned long basejiff =3D ts->last_jiffies;
 	u64 basemono =3D ts->timer_expires_base;
-	u64 expires =3D ts->timer_expires;
+	bool timer_idle =3D tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	u64 expires;
=20
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base =3D 0;
=20
+	/*
+	 * Now the tick should be stopped definitely - so the timer base needs
+	 * to be marked idle as well to not miss a newly queued timer.
+	 */
+	expires =3D timer_base_try_to_set_idle(basejiff, basemono, &timer_idle);
+	if (expires > ts->timer_expires) {
+		/*
+		 * This path could only happen when the first timer was removed
+		 * between calculating the possible sleep length and now (when
+		 * high resolution mode is not active, timer could also be a
+		 * hrtimer).
+		 *
+		 * We have to stick to the original calculated expiry value to
+		 * not stop the tick for too long with a shallow C-state (which
+		 * was programmed by cpuidle because of an early next expiration
+		 * value).
+		 */
+		expires =3D ts->timer_expires;
+	}
+
+	/* If the timer base is not idle, retain the not yet stopped tick. */
+	if (!timer_idle)
+		return;
+
 	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
@@ -905,13 +1008,13 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 	 */
 	if (cpu =3D=3D tick_do_timer_cpu) {
 		tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
-		ts->do_timer_last =3D 1;
+		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
 	} else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
-		ts->do_timer_last =3D 0;
+		tick_sched_flag_clear(ts, TS_FLAG_DO_TIMER_LAST);
 	}
=20
 	/* Skip reprogram of event if it's not changed */
-	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED) && (expires =3D=3D ts->next_t=
ick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (expires =3D=3D KTIME_MAX || ts->next_tick =3D=3D hrtimer_get_expires(&=
ts->sched_timer))
 			return;
@@ -929,12 +1032,12 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 	 * call we save the current tick time, so we can restart the
 	 * scheduler tick in tick_nohz_restart_sched_tick().
 	 */
-	if (!ts->tick_stopped) {
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		calc_load_nohz_start();
 		quiet_vmstat();
=20
 		ts->last_tick =3D hrtimer_get_expires(&ts->sched_timer);
-		ts->tick_stopped =3D 1;
+		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
=20
@@ -945,14 +1048,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts,=
 int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires =3D=3D KTIME_MAX)) {
-		if (ts->nohz_mode =3D=3D NOHZ_MODE_HIGHRES)
-			hrtimer_cancel(&ts->sched_timer);
-		else
-			tick_program_event(KTIME_MAX, 1);
+		tick_sched_timer_cancel(ts);
 		return;
 	}
=20
-	if (ts->nohz_mode =3D=3D NOHZ_MODE_HIGHRES) {
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start(&ts->sched_timer, expires,
 			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
@@ -967,7 +1067,7 @@ static void tick_nohz_retain_tick(struct tick_sched *ts)
 }
=20
 #ifdef CONFIG_NO_HZ_FULL
-static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+static void tick_nohz_full_stop_tick(struct tick_sched *ts, int cpu)
 {
 	if (tick_nohz_next_event(ts, cpu))
 		tick_nohz_stop_tick(ts, cpu);
@@ -991,7 +1091,7 @@ static void tick_nohz_restart_sched_tick(struct tick_sch=
ed *ts, ktime_t now)
 	touch_softlockup_watchdog_sched();
=20
 	/* Cancel the scheduled timer and restore the tick: */
-	ts->tick_stopped  =3D 0;
+	tick_sched_flag_clear(ts, TS_FLAG_STOPPED);
 	tick_nohz_restart(ts, now);
 }
=20
@@ -1002,8 +1102,8 @@ static void __tick_nohz_full_update_tick(struct tick_sc=
hed *ts,
 	int cpu =3D smp_processor_id();
=20
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
+		tick_nohz_full_stop_tick(ts, cpu);
+	else if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		tick_nohz_restart_sched_tick(ts, now);
 #endif
 }
@@ -1013,7 +1113,7 @@ static void tick_nohz_full_update_tick(struct tick_sche=
d *ts)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
=20
-	if (!ts->tick_stopped && ts->nohz_mode =3D=3D NOHZ_MODE_INACTIVE)
+	if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return;
=20
 	__tick_nohz_full_update_tick(ts, ktime_get());
@@ -1060,25 +1160,9 @@ static bool report_idle_softirq(void)
=20
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
-	/*
-	 * If this CPU is offline and it is the one which updates
-	 * jiffies, then give up the assignment and let it be taken by
-	 * the CPU which runs the tick timer next. If we don't drop
-	 * this here, the jiffies might be stale and do_timer() never
-	 * gets invoked.
-	 */
-	if (unlikely(!cpu_online(cpu))) {
-		if (cpu =3D=3D tick_do_timer_cpu)
-			tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
-		/*
-		 * Make sure the CPU doesn't get fooled by obsolete tick
-		 * deadline if it comes back online later.
-		 */
-		ts->next_tick =3D 0;
-		return false;
-	}
+	WARN_ON_ONCE(cpu_is_offline(cpu));
=20
-	if (unlikely(ts->nohz_mode =3D=3D NOHZ_MODE_INACTIVE))
+	if (unlikely(!tick_sched_flag_test(ts, TS_FLAG_NOHZ)))
 		return false;
=20
 	if (need_resched())
@@ -1128,14 +1212,14 @@ void tick_nohz_idle_stop_tick(void)
 	ts->idle_calls++;
=20
 	if (expires > 0LL) {
-		int was_stopped =3D ts->tick_stopped;
+		int was_stopped =3D tick_sched_flag_test(ts, TS_FLAG_STOPPED);
=20
 		tick_nohz_stop_tick(ts, cpu);
=20
 		ts->idle_sleeps++;
 		ts->idle_expires =3D expires;
=20
-		if (!was_stopped && ts->tick_stopped) {
+		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			ts->idle_jiffies =3D ts->last_jiffies;
 			nohz_balance_enter_idle(cpu);
 		}
@@ -1147,11 +1231,6 @@ void tick_nohz_idle_stop_tick(void)
 void tick_nohz_idle_retain_tick(void)
 {
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
-	/*
-	 * Undo the effect of get_next_timer_interrupt() called from
-	 * tick_nohz_next_event().
-	 */
-	timer_clear_idle();
 }
=20
 /**
@@ -1171,7 +1250,7 @@ void tick_nohz_idle_enter(void)
=20
 	WARN_ON_ONCE(ts->timer_expires_base);
=20
-	ts->inidle =3D 1;
+	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
 	tick_nohz_start_idle(ts);
=20
 	local_irq_enable();
@@ -1200,7 +1279,7 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
-	if (ts->inidle)
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
 		tick_nohz_start_idle(ts);
 	else
 		tick_nohz_full_update_tick(ts);
@@ -1254,7 +1333,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	ktime_t now =3D ts->idle_entrytime;
 	ktime_t next_event;
=20
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_INIDLE));
=20
 	*delta_next =3D ktime_sub(dev->next_event, now);
=20
@@ -1326,7 +1405,7 @@ void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
=20
-	if (ts->tick_stopped) {
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		ktime_t now =3D ktime_get();
 		tick_nohz_restart_sched_tick(ts, now);
 		tick_nohz_account_idle_time(ts, now);
@@ -1367,12 +1446,12 @@ void tick_nohz_idle_exit(void)
=20
 	local_irq_disable();
=20
-	WARN_ON_ONCE(!ts->inidle);
+	WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_INIDLE));
 	WARN_ON_ONCE(ts->timer_expires_base);
=20
-	ts->inidle =3D 0;
-	idle_active =3D ts->idle_active;
-	tick_stopped =3D ts->tick_stopped;
+	tick_sched_flag_clear(ts, TS_FLAG_INIDLE);
+	idle_active =3D tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE);
+	tick_stopped =3D tick_sched_flag_test(ts, TS_FLAG_STOPPED);
=20
 	if (idle_active || tick_stopped)
 		now =3D ktime_get();
@@ -1391,38 +1470,22 @@ void tick_nohz_idle_exit(void)
  * at the clockevent level. hrtimer can't be used instead, because its
  * infrastructure actually relies on the tick itself as a backend in
  * low-resolution mode (see hrtimer_run_queues()).
- *
- * This low-resolution handler still makes use of some hrtimer APIs meanwhile
- * for convenience with expiration calculation and forwarding.
  */
 static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
-	struct pt_regs *regs =3D get_irq_regs();
-	ktime_t now =3D ktime_get();
=20
 	dev->next_event =3D KTIME_MAX;
=20
-	tick_sched_do_timer(ts, now);
-	tick_sched_handle(ts, regs);
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (likely(!ts->tick_stopped)) {
-		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	if (likely(tick_nohz_handler(&ts->sched_timer) =3D=3D HRTIMER_RESTART))
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	}
-
 }
=20
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
+static inline void tick_nohz_activate(struct tick_sched *ts)
 {
 	if (!tick_nohz_enabled)
 		return;
-	ts->nohz_mode =3D mode;
+	tick_sched_flag_set(ts, TS_FLAG_NOHZ);
 	/* One update is enough */
 	if (!test_and_set_bit(0, &tick_nohz_active))
 		timers_update_nohz();
@@ -1433,9 +1496,6 @@ static inline void tick_nohz_activate(struct tick_sched=
 *ts, int mode)
  */
 static void tick_nohz_switch_to_nohz(void)
 {
-	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
-	ktime_t next;
-
 	if (!tick_nohz_enabled)
 		return;
=20
@@ -1444,16 +1504,9 @@ static void tick_nohz_switch_to_nohz(void)
=20
 	/*
 	 * Recycle the hrtimer in 'ts', so we can share the
-	 * hrtimer_forward_now() function with the highres code.
+	 * highres code.
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	/* Get the next period */
-	next =3D tick_init_jiffy_update();
-
-	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
-	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
-	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
+	tick_setup_sched_timer(false);
 }
=20
 static inline void tick_nohz_irq_enter(void)
@@ -1461,10 +1514,10 @@ static inline void tick_nohz_irq_enter(void)
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
=20
-	if (!ts->idle_active && !ts->tick_stopped)
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
 		return;
 	now =3D ktime_get();
-	if (ts->idle_active)
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE))
 		tick_nohz_stop_idle(ts, now);
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
@@ -1473,7 +1526,7 @@ static inline void tick_nohz_irq_enter(void)
 	 * rare case (typically stop machine). So we must make sure we have a
 	 * last resort.
 	 */
-	if (ts->tick_stopped)
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		tick_nohz_update_jiffies(now);
 }
=20
@@ -1481,7 +1534,7 @@ static inline void tick_nohz_irq_enter(void)
=20
 static inline void tick_nohz_switch_to_nohz(void) { }
 static inline void tick_nohz_irq_enter(void) { }
-static inline void tick_nohz_activate(struct tick_sched *ts, int mode) { }
+static inline void tick_nohz_activate(struct tick_sched *ts) { }
=20
 #endif /* CONFIG_NO_HZ_COMMON */
=20
@@ -1494,45 +1547,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
=20
-/*
- * High resolution timer specific code
- */
-#ifdef CONFIG_HIGH_RES_TIMERS
-/*
- * We rearm the timer until we get disabled by the idle code.
- * Called with interrupts disabled.
- */
-static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
-{
-	struct tick_sched *ts =3D
-		container_of(timer, struct tick_sched, sched_timer);
-	struct pt_regs *regs =3D get_irq_regs();
-	ktime_t now =3D ktime_get();
-
-	tick_sched_do_timer(ts, now);
-
-	/*
-	 * Do not call when we are not in IRQ context and have
-	 * no valid 'regs' pointer
-	 */
-	if (regs)
-		tick_sched_handle(ts, regs);
-	else
-		ts->next_tick =3D 0;
-
-	/*
-	 * In dynticks mode, tick reprogram is deferred:
-	 * - to the idle task if in dynticks-idle
-	 * - to IRQ exit if in full-dynticks.
-	 */
-	if (unlikely(ts->tick_stopped))
-		return HRTIMER_NORESTART;
-
-	hrtimer_forward(timer, now, TICK_NSEC);
-
-	return HRTIMER_RESTART;
-}
-
 static int sched_skew_tick;
=20
 static int __init skew_tick(char *str)
@@ -1545,15 +1559,19 @@ early_param("skew_tick", skew_tick);
=20
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
+ * @mode: tick_nohz_mode to setup for
  */
-void tick_setup_sched_timer(void)
+void tick_setup_sched_timer(bool hrtimer)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
-	ktime_t now =3D ktime_get();
=20
 	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function =3D tick_nohz_highres_handler;
+
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer) {
+		tick_sched_flag_set(ts, TS_FLAG_HIGHRES);
+		ts->sched_timer.function =3D tick_nohz_handler;
+	}
=20
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
@@ -1566,23 +1584,35 @@ void tick_setup_sched_timer(void)
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
=20
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
-	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
+	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && hrtimer)
+		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
+	else
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
+	tick_nohz_activate(ts);
 }
-#endif /* HIGH_RES_TIMERS */
=20
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
-void tick_cancel_sched_timer(int cpu)
+/*
+ * Shut down the tick and make sure the CPU won't try to retake the timekeep=
ing
+ * duty before disabling IRQs in idle for the last time.
+ */
+void tick_sched_timer_dying(int cpu)
 {
+	struct tick_device *td =3D &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);
+	struct clock_event_device *dev =3D td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
=20
-# ifdef CONFIG_HIGH_RES_TIMERS
-	if (ts->sched_timer.base)
-		hrtimer_cancel(&ts->sched_timer);
-# endif
+	/* This must happen before hrtimers are migrated! */
+	tick_sched_timer_cancel(ts);
+
+	/*
+	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
+	 * make sure not to call low-res tick handler.
+	 */
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
+		dev->event_handler =3D clockevents_handle_noop;
=20
 	idle_sleeptime =3D ts->idle_sleeptime;
 	iowait_sleeptime =3D ts->iowait_sleeptime;
@@ -1594,7 +1624,6 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_calls =3D idle_calls;
 	ts->idle_sleeps =3D idle_sleeps;
 }
-#endif
=20
 /*
  * Async notification about clocksource changes
@@ -1632,7 +1661,7 @@ int tick_check_oneshot_change(int allow_nohz)
 	if (!test_and_clear_bit(0, &ts->check_clocks))
 		return 0;
=20
-	if (ts->nohz_mode !=3D NOHZ_MODE_INACTIVE)
+	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
 		return 0;
=20
 	if (!timekeeping_valid_for_hres() || !tick_is_oneshot_available())
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 5ed5a9d41d5a..e11c4dc65bcb 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -14,20 +14,26 @@ struct tick_device {
 	enum tick_device_mode mode;
 };
=20
-enum tick_nohz_mode {
-	NOHZ_MODE_INACTIVE,
-	NOHZ_MODE_LOWRES,
-	NOHZ_MODE_HIGHRES,
-};
+/* The CPU is in the tick idle mode */
+#define TS_FLAG_INIDLE		BIT(0)
+/* The idle tick has been stopped */
+#define TS_FLAG_STOPPED		BIT(1)
+/*
+ * Indicator that the CPU is actively in the tick idle mode;
+ * it is reset during irq handling phases.
+ */
+#define TS_FLAG_IDLE_ACTIVE	BIT(2)
+/* CPU was the last one doing do_timer before going idle */
+#define TS_FLAG_DO_TIMER_LAST	BIT(3)
+/* NO_HZ is enabled */
+#define TS_FLAG_NOHZ		BIT(4)
+/* High resolution tick mode */
+#define TS_FLAG_HIGHRES		BIT(5)
=20
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
  *
- * @inidle:		Indicator that the CPU is in the tick idle mode
- * @tick_stopped:	Indicator that the idle tick has been stopped
- * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
- *			it is reset during irq handling phases.
- * @do_timer_last:	CPU was the last one doing do_timer before going idle
+ * @flags:		State flags gathering the TS_FLAG_* features
  * @got_idle_tick:	Tick timer function has run with @inidle set
  * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  * @last_tick_jiffies:	Value of jiffies seen on last tick
@@ -57,11 +63,7 @@ enum tick_nohz_mode {
  */
 struct tick_sched {
 	/* Common flags */
-	unsigned int			inidle		: 1;
-	unsigned int			tick_stopped	: 1;
-	unsigned int			idle_active	: 1;
-	unsigned int			do_timer_last	: 1;
-	unsigned int			got_idle_tick	: 1;
+	unsigned long			flags;
=20
 	/* Tick handling: jiffies stall check */
 	unsigned int			stalled_jiffies;
@@ -73,13 +75,13 @@ struct tick_sched {
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
+	unsigned int			got_idle_tick;
=20
 	/* Idle entry */
 	seqcount_t			idle_sleeptime_seq;
 	ktime_t				idle_entrytime;
=20
 	/* Tick stop */
-	enum tick_nohz_mode		nohz_mode;
 	unsigned long			last_jiffies;
 	u64				timer_expires_base;
 	u64				timer_expires;
@@ -102,11 +104,11 @@ struct tick_sched {
=20
 extern struct tick_sched *tick_get_tick_sched(int cpu);
=20
-extern void tick_setup_sched_timer(void);
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
-extern void tick_cancel_sched_timer(int cpu);
+extern void tick_setup_sched_timer(bool hrtimer);
+#if defined CONFIG_TICK_ONESHOT
+extern void tick_sched_timer_dying(int cpu);
 #else
-static inline void tick_cancel_sched_timer(int cpu) { }
+static inline void tick_sched_timer_dying(int cpu) { }
 #endif
=20
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index ca058c8af6ba..3e5d422dd15c 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
=20
 		days =3D div_s64(secs, 86400);
=20
-		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
=20
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..8aab7ed41490 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1180,13 +1180,15 @@ static int adjust_historical_crosststamp(struct syste=
m_time_snapshot *history,
 }
=20
 /*
- * cycle_between - true if test occurs chronologically between before and af=
ter
+ * timestamp_in_interval - true if ts is chronologically in [start, end]
+ *
+ * True if ts occurs chronologically at or after start, and before or at end.
  */
-static bool cycle_between(u64 before, u64 test, u64 after)
+static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 {
-	if (test > before && test < after)
+	if (ts >=3D start && ts <=3D end)
 		return true;
-	if (test < before && before > after)
+	if (start > end && (ts >=3D start || ts <=3D end))
 		return true;
 	return false;
 }
@@ -1246,7 +1248,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now =3D tk_clock_read(&tk->tkr_mono);
 		interval_start =3D tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq =3D tk->clock_was_set_seq;
 			cs_was_changed_seq =3D tk->cs_was_changed_seq;
 			cycles =3D interval_start;
@@ -1259,10 +1261,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw =3D tk->tkr_raw.base;
=20
-		nsec_real =3D timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real =3D timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw =3D timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
=20
 	xtstamp->sys_realtime =3D ktime_add_ns(base_real, nsec_real);
@@ -1277,13 +1277,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		bool discontinuity;
=20
 		/*
-		 * Check that the counter value occurs after the provided
+		 * Check that the counter value is not before the provided
 		 * history reference and that the history doesn't cross a
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !cycle_between(history_begin->cycles,
-				   system_counterval.cycles, cycles) ||
+		    !timestamp_in_interval(history_begin->cycles,
+					   cycles, system_counterval.cycles) ||
 		    history_begin->cs_was_changed_seq !=3D cs_was_changed_seq)
 			return -EINVAL;
 		partial_history_cycles =3D cycles - system_counterval.cycles;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161113cd..e69e75d3858c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -53,6 +53,7 @@
 #include <asm/io.h>
=20
 #include "tick-internal.h"
+#include "timer_migration.h"
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/timer.h>
@@ -187,15 +188,66 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
=20
 #ifdef CONFIG_NO_HZ_COMMON
-# define NR_BASES	2
-# define BASE_STD	0
-# define BASE_DEF	1
+/*
+ * If multiple bases need to be locked, use the base ordering for lock
+ * nesting, i.e. lowest number first.
+ */
+# define NR_BASES	3
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	1
+# define BASE_DEF	2
 #else
 # define NR_BASES	1
-# define BASE_STD	0
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	0
 # define BASE_DEF	0
 #endif
=20
+/**
+ * struct timer_base - Per CPU timer base (number of base depends on config)
+ * @lock:		Lock protecting the timer_base
+ * @running_timer:	When expiring timers, the lock is dropped. To make
+ *			sure not to race agains deleting/modifying a
+ *			currently running timer, the pointer is set to the
+ *			timer, which expires at the moment. If no timer is
+ *			running, the pointer is NULL.
+ * @expiry_lock:	PREEMPT_RT only: Lock is taken in softirq around
+ *			timer expiry callback execution and when trying to
+ *			delete a running timer and it wasn't successful in
+ *			the first glance. It prevents priority inversion
+ *			when callback was preempted on a remote CPU and a
+ *			caller tries to delete the running timer. It also
+ *			prevents a life lock, when the task which tries to
+ *			delete a timer preempted the softirq thread which
+ *			is running the timer callback function.
+ * @timer_waiters:	PREEMPT_RT only: Tells, if there is a waiter
+ *			waiting for the end of the timer callback function
+ *			execution.
+ * @clk:		clock of the timer base; is updated before enqueue
+ *			of a timer; during expiry, it is 1 offset ahead of
+ *			jiffies to avoid endless requeuing to current
+ *			jiffies
+ * @next_expiry:	expiry value of the first timer; it is updated when
+ *			finding the next timer and during enqueue; the
+ *			value is not valid, when next_expiry_recalc is set
+ * @cpu:		Number of CPU the timer base belongs to
+ * @next_expiry_recalc: States, whether a recalculation of next_expiry is
+ *			required. Value is set true, when a timer was
+ *			deleted.
+ * @is_idle:		Is set, when timer_base is idle. It is triggered by NOHZ
+ *			code. This state is only used in standard
+ *			base. Deferrable timers, which are enqueued remotely
+ *			never wake up an idle CPU. So no matter of supporting it
+ *			for this base.
+ * @timers_pending:	Is set, when a timer is pending in the base. It is only
+ *			reliable when next_expiry_recalc is not set.
+ * @pending_map:	bitmap of the timer wheel; each bit reflects a
+ *			bucket of the wheel. When a bit is set, at least a
+ *			single timer is enqueued in the related bucket.
+ * @vectors:		Array of lists; Each array member reflects a bucket
+ *			of the timer wheel. The list contains all timers
+ *			which are enqueued into a specific bucket.
+ */
 struct timer_base {
 	raw_spinlock_t		lock;
 	struct timer_list	*running_timer;
@@ -583,11 +635,16 @@ trigger_dyntick_cpu(struct timer_base *base, struct tim=
er_list *timer)
=20
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-	 * timer is not deferrable. If the other CPU is on the way to idle
-	 * then it can't set base->is_idle as we hold the base lock:
+	 * timer is pinned. If it is a non pinned timer, it is only queued
+	 * on the remote CPU, when timer was running during queueing. Then
+	 * everything is handled by remote CPU anyway. If the other CPU is
+	 * on the way to idle then it can't set base->is_idle as we hold
+	 * the base lock:
 	 */
-	if (base->is_idle)
+	if (base->is_idle) {
+		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
 		wake_up_nohz_cpu(base->cpu);
+	}
 }
=20
 /*
@@ -899,7 +956,10 @@ static int detach_if_pending(struct timer_list *timer, s=
truct timer_base *base,
=20
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base =3D per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index =3D tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base =3D per_cpu_ptr(&timer_bases[index], cpu);
=20
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -912,7 +972,10 @@ static inline struct timer_base *get_timer_cpu_base(u32 =
tflags, u32 cpu)
=20
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index =3D tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base =3D this_cpu_ptr(&timer_bases[index]);
=20
 	/*
 	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
@@ -928,17 +991,6 @@ static inline struct timer_base *get_timer_base(u32 tfla=
gs)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
=20
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void __forward_timer_base(struct timer_base *base,
 					unsigned long basej)
 {
@@ -1093,7 +1145,7 @@ __mod_timer(struct timer_list *timer, unsigned long exp=
ires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
=20
-	new_base =3D get_target_base(base, timer->flags);
+	new_base =3D get_timer_this_cpu_base(timer->flags);
=20
 	if (base !=3D new_base) {
 		/*
@@ -1245,12 +1297,49 @@ void add_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(add_timer);
=20
+/**
+ * add_timer_local() - Start a timer on the local CPU
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is set.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_local(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags |=3D TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_local);
+
+/**
+ * add_timer_global() - Start a timer without TIMER_PINNED flag set
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is unset.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_global(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags &=3D ~TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_global);
+
 /**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on
  *
- * Same as add_timer() except that it starts the timer on the given CPU.
+ * Same as add_timer() except that it starts the timer on the given CPU and
+ * the TIMER_PINNED flag is set. When timer shouldn't be a pinned timer in
+ * the next round, add_timer_global() should be used instead as it unsets
+ * the TIMER_PINNED flag.
  *
  * See add_timer() for further details.
  */
@@ -1264,6 +1353,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
=20
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |=3D TIMER_PINNED;
+
 	new_base =3D get_timer_cpu_base(timer->flags, cpu);
=20
 	/*
@@ -1911,71 +2003,350 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 exp=
ires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
=20
+static unsigned long next_timer_interrupt(struct timer_base *base,
+					  unsigned long basej)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	/*
+	 * Move next_expiry for the empty base into the future to prevent an
+	 * unnecessary raise of the timer softirq when the next_expiry value
+	 * will be reached even if there is no timer pending.
+	 *
+	 * This update is also required to make timer_base::next_expiry values
+	 * easy comparable to find out which base holds the first pending timer.
+	 */
+	if (!base->timers_pending)
+		base->next_expiry =3D basej + NEXT_TIMER_MAX_DELTA;
+
+	return base->next_expiry;
+}
+
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 bas=
em,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
+{
+	unsigned long nextevt, nextevt_local, nextevt_global;
+	bool local_first;
+
+	nextevt_local =3D next_timer_interrupt(base_local, basej);
+	nextevt_global =3D next_timer_interrupt(base_global, basej);
+
+	local_first =3D time_before_eq(nextevt_local, nextevt_global);
+
+	nextevt =3D local_first ? nextevt_local : nextevt_global;
+
+	/*
+	 * If the @nextevt is at max. one tick away, use @nextevt and store
+	 * it in the local expiry value. The next global event is irrelevant in
+	 * this case and can be left as KTIME_MAX.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt =3D basej;
+		tevt->local =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
+
+		/*
+		 * This is required for the remote check only but it doesn't
+		 * hurt, when it is done for both call sites:
+		 *
+		 * * The remote callers will only take care of the global timers
+		 *   as local timers will be handled by CPU itself. When not
+		 *   updating tevt->global with the already missed first global
+		 *   timer, it is possible that it will be missed completely.
+		 *
+		 * * The local callers will ignore the tevt->global anyway, when
+		 *   nextevt is max. one tick away.
+		 */
+		if (!local_first)
+			tevt->global =3D tevt->local;
+		return nextevt;
+	}
+
+	/*
+	 * Update tevt.* values:
+	 *
+	 * If the local queue expires first, then the global event can be
+	 * ignored. If the global queue is empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt->global =3D basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt->local =3D basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return nextevt;
+}
+
+# ifdef CONFIG_SMP
 /**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
+ * fetch_next_timer_interrupt_remote() - Store next timers into @tevt
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Caller needs to make sure timer base locks are held (use
+ * timer_lock_remote_bases() for this purpose).
  */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				       struct timer_events *tevt,
+				       unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	/* Preset local / global events */
+	tevt->local =3D tevt->global =3D KTIME_MAX;
+
+	base_local =3D per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global =3D per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_held(&base_local->lock);
+	lockdep_assert_held(&base_global->lock);
+
+	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt);
+}
+
+/**
+ * timer_unlock_remote_bases - unlock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Unlocks the remote timer bases.
+ */
+void timer_unlock_remote_bases(unsigned int cpu)
+	__releases(timer_bases[BASE_LOCAL]->lock)
+	__releases(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local =3D per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global =3D per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+}
+
+/**
+ * timer_lock_remote_bases - lock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Locks the remote timer bases.
+ */
+void timer_lock_remote_bases(unsigned int cpu)
+	__acquires(timer_bases[BASE_LOCAL]->lock)
+	__acquires(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local =3D per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global =3D per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_irqs_disabled();
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+}
+
+/**
+ * timer_base_is_idle() - Return whether timer base is set idle
+ *
+ * Returns value of local timer base is_idle value.
+ */
+bool timer_base_is_idle(void)
+{
+	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
+}
+
+static void __run_timer_base(struct timer_base *base);
+
+/**
+ * timer_expire_remote() - expire global timers of cpu
+ * @cpu:	Remote CPU
+ *
+ * Expire timers of global base of remote CPU.
+ */
+void timer_expire_remote(unsigned int cpu)
+{
+	struct timer_base *base =3D per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	__run_timer_base(base);
+}
+
+static void timer_use_tmigr(unsigned long basej, u64 basem,
+			    unsigned long *nextevt, bool *tick_stop_path,
+			    bool timer_base_idle, struct timer_events *tevt)
 {
-	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
-	unsigned long nextevt =3D basej + NEXT_TIMER_MAX_DELTA;
-	u64 expires =3D KTIME_MAX;
-	bool was_idle;
+	u64 next_tmigr;
+
+	if (timer_base_idle)
+		next_tmigr =3D tmigr_cpu_new_timer(tevt->global);
+	else if (tick_stop_path)
+		next_tmigr =3D tmigr_cpu_deactivate(tevt->global);
+	else
+		next_tmigr =3D tmigr_quick_check(tevt->global);
=20
 	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
+	 * If the CPU is the last going idle in timer migration hierarchy, make
+	 * sure the CPU will wake up in time to handle remote timers.
+	 * next_tmigr =3D=3D KTIME_MAX if other CPUs are still active.
 	 */
-	if (cpu_is_offline(smp_processor_id()))
-		return expires;
+	if (next_tmigr < tevt->local) {
+		u64 tmp;
=20
-	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+		/* If we missed a tick already, force 0 delta */
+		if (next_tmigr < basem)
+			next_tmigr =3D basem;
+
+		tmp =3D div_u64(next_tmigr - basem, TICK_NSEC);
+
+		*nextevt =3D basej + (unsigned long)tmp;
+		tevt->local =3D next_tmigr;
+	}
+}
+# else
+static void timer_use_tmigr(unsigned long basej, u64 basem,
+			    unsigned long *nextevt, bool *tick_stop_path,
+			    bool timer_base_idle, struct timer_events *tevt)
+{
+	/*
+	 * Make sure first event is written into tevt->local to not miss a
+	 * timer on !SMP systems.
+	 */
+	tevt->local =3D min_t(u64, tevt->local, tevt->global);
+}
+# endif /* CONFIG_SMP */
+
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
+{
+	struct timer_events tevt =3D { .local =3D KTIME_MAX, .global =3D KTIME_MAX =
};
+	struct timer_base *base_local, *base_global;
+	unsigned long nextevt;
+	bool idle_is_possible;
+
+	/*
+	 * When the CPU is offline, the tick is cancelled and nothing is supposed
+	 * to try to stop it.
+	 */
+	if (WARN_ON_ONCE(cpu_is_offline(smp_processor_id()))) {
+		if (idle)
+			*idle =3D true;
+		return tevt.local;
+	}
+
+	base_local =3D this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global =3D this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt =3D fetch_next_timer_interrupt(basej, basem, base_local,
+					     base_global, &tevt);
+
+	/*
+	 * If the next event is only one jiffie ahead there is no need to call
+	 * timer migration hierarchy related functions. The value for the next
+	 * global timer in @tevt struct equals then KTIME_MAX. This is also
+	 * true, when the timer base is idle.
+	 *
+	 * The proper timer migration hierarchy function depends on the callsite
+	 * and whether timer base is idle or not. @nextevt will be updated when
+	 * this CPU needs to handle the first timer migration hierarchy
+	 * event. See timer_use_tmigr() for detailed information.
+	 */
+	idle_is_possible =3D time_after(nextevt, basej + 1);
+	if (idle_is_possible)
+		timer_use_tmigr(basej, basem, &nextevt, idle,
+				base_local->is_idle, &tevt);
=20
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
 	 */
-	__forward_timer_base(base, basej);
+	__forward_timer_base(base_local, basej);
+	__forward_timer_base(base_global, basej);
=20
-	if (base->timers_pending) {
-		nextevt =3D base->next_expiry;
+	/*
+	 * Set base->is_idle only when caller is timer_base_try_to_set_idle()
+	 */
+	if (idle) {
+		/*
+		 * Bases are idle if the next event is more than a tick
+		 * away. Caution: @nextevt could have changed by enqueueing a
+		 * global timer into timer migration hierarchy. Therefore a new
+		 * check is required here.
+		 *
+		 * If the base is marked idle then any timer add operation must
+		 * forward the base clk itself to keep granularity small. This
+		 * idle logic is only maintained for the BASE_LOCAL and
+		 * BASE_GLOBAL base, deferrable timers may still see large
+		 * granularity skew (by design).
+		 */
+		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
+			base_local->is_idle =3D true;
+			trace_timer_base_idle(true, base_local->cpu);
+		}
+		*idle =3D base_local->is_idle;
=20
-		/* If we missed a tick already, force 0 delta */
-		if (time_before(nextevt, basej))
-			nextevt =3D basej;
-		expires =3D basem + (u64)(nextevt - basej) * TICK_NSEC;
-	} else {
 		/*
-		 * Move next_expiry for the empty base into the future to
-		 * prevent a unnecessary raise of the timer softirq when the
-		 * next_expiry value will be reached even if there is no timer
-		 * pending.
+		 * When timer base is not set idle, undo the effect of
+		 * tmigr_cpu_deactivate() to prevent inconsitent states - active
+		 * timer base but inactive timer migration hierarchy.
+		 *
+		 * When timer base was already marked idle, nothing will be
+		 * changed here.
 		 */
-		base->next_expiry =3D nextevt;
+		if (!base_local->is_idle && idle_is_possible)
+			tmigr_cpu_activate();
 	}
=20
-	/*
-	 * Base is idle if the next event is more than a tick away.
-	 *
-	 * If the base is marked idle then any timer add operation must forward
-	 * the base clk itself to keep granularity small. This idle logic is
-	 * only maintained for the BASE_STD base, deferrable timers may still
-	 * see large granularity skew (by design).
-	 */
-	was_idle =3D base->is_idle;
-	base->is_idle =3D time_after(nextevt, basej + 1);
-	if (was_idle !=3D base->is_idle)
-		trace_timer_base_idle(base->is_idle, base->cpu);
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
=20
-	raw_spin_unlock(&base->lock);
+	return cmp_next_hrtimer_event(basem, tevt.local);
+}
=20
-	return cmp_next_hrtimer_event(basem, expires);
+/**
+ * get_next_timer_interrupt() - return the time (clock mono) of the next tim=
er
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ *
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. If timer of global base was queued into
+ * timer migration hierarchy, first global timer is not taken into account. =
If
+ * it was the last CPU of timer migration hierarchy going idle, first global
+ * event is taken into account.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+{
+	return __get_next_timer_interrupt(basej, basem, NULL);
+}
+
+/**
+ * timer_base_try_to_set_idle() - Try to set the idle state of the timer bas=
es
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @idle:	pointer to store the value of timer_base->is_idle on return;
+ *		*idle contains the information whether tick was already stopped
+ *
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX=
 is
+ * returned as well.
+ */
+u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
+{
+	if (*idle)
+		return KTIME_MAX;
+
+	return __get_next_timer_interrupt(basej, basem, idle);
 }
=20
 /**
@@ -1985,18 +2356,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64=
 basem)
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
-
 	/*
-	 * We do this unlocked. The worst outcome is a remote enqueue sending
-	 * a pointless IPI, but taking the lock would just make the window for
-	 * sending the IPI a few instructions smaller for the cost of taking
-	 * the lock in the exit from idle path.
+	 * We do this unlocked. The worst outcome is a remote pinned timer
+	 * enqueue sending a pointless IPI, but taking the lock would just
+	 * make the window for sending the IPI a few instructions smaller
+	 * for the cost of taking the lock in the exit from idle
+	 * path. Required for BASE_LOCAL only.
 	 */
-	if (base->is_idle) {
-		base->is_idle =3D false;
-		trace_timer_base_idle(false, smp_processor_id());
-	}
+	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	trace_timer_base_idle(false, smp_processor_id());
+
+	/* Activate without holding the timer_base->lock */
+	tmigr_cpu_activate();
 }
 #endif
=20
@@ -2009,11 +2380,10 @@ static inline void __run_timers(struct timer_base *ba=
se)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
=20
-	if (time_before(jiffies, base->next_expiry))
-		return;
+	lockdep_assert_held(&base->lock);
=20
-	timer_base_lock_expiry(base);
-	raw_spin_lock_irq(&base->lock);
+	if (base->running_timer)
+		return;
=20
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
@@ -2037,20 +2407,40 @@ static inline void __run_timers(struct timer_base *ba=
se)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+}
+
+static void __run_timer_base(struct timer_base *base)
+{
+	if (time_before(jiffies, base->next_expiry))
+		return;
+
+	timer_base_lock_expiry(base);
+	raw_spin_lock_irq(&base->lock);
+	__run_timers(base);
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
=20
+static void run_timer_base(int index)
+{
+	struct timer_base *base =3D this_cpu_ptr(&timer_bases[index]);
+
+	__run_timer_base(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
+	run_timer_base(BASE_LOCAL);
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
+		run_timer_base(BASE_GLOBAL);
+		run_timer_base(BASE_DEF);
=20
-	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		if (is_timers_nohz_active())
+			tmigr_handle_remote();
+	}
 }
=20
 /*
@@ -2058,19 +2448,18 @@ static __latent_entropy void run_timer_softirq(struct=
 softirq_action *h)
  */
 static void run_local_timers(void)
 {
-	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base =3D this_cpu_ptr(&timer_bases[BASE_LOCAL]);
=20
 	hrtimer_run_queues();
-	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->next_expiry)) {
-		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
-			return;
-		/* CPU is awake, so check the deferrable base. */
-		base++;
-		if (time_before(jiffies, base->next_expiry))
+
+	for (int i =3D 0; i < NR_BASES; i++, base++) {
+		/* Raise the softirq only if required. */
+		if (time_after_eq(jiffies, base->next_expiry) ||
+		    (i =3D=3D BASE_DEF && tmigr_requires_handle_remote())) {
+			raise_softirq(TIMER_SOFTIRQ);
 			return;
+		}
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
=20
 /*
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ed7d6ad694fb..1c311c46da50 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -147,11 +147,15 @@ static void print_cpu(struct seq_file *m, int cpu, u64 =
now)
 # define P_ns(x) \
 	SEQ_printf(m, "  .%-15s: %Lu nsecs\n", #x, \
 		   (unsigned long long)(ktime_to_ns(ts->x)))
+# define P_flag(x, f)			    \
+	SEQ_printf(m, "  .%-15s: %d\n", #x, !!(ts->flags & (f)))
+
 	{
 		struct tick_sched *ts =3D tick_get_tick_sched(cpu);
-		P(nohz_mode);
+		P_flag(nohz, TS_FLAG_NOHZ);
+		P_flag(highres, TS_FLAG_HIGHRES);
 		P_ns(last_tick);
-		P(tick_stopped);
+		P_flag(tick_stopped, TS_FLAG_STOPPED);
 		P(idle_jiffies);
 		P(idle_calls);
 		P(idle_sleeps);
@@ -256,7 +260,7 @@ static void timer_list_show_tickdevices_header(struct seq=
_file *m)
=20
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.9\n");
+	SEQ_printf(m, "Timer List Version: v0.10\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
new file mode 100644
index 000000000000..8f49b6b96dfd
--- /dev/null
+++ b/kernel/time/timer_migration.c
@@ -0,0 +1,1793 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Infrastructure for migratable timers
+ *
+ * Copyright(C) 2022 linutronix GmbH
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/timerqueue.h>
+#include <trace/events/ipi.h>
+
+#include "timer_migration.h"
+#include "tick-internal.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
+/*
+ * The timer migration mechanism is built on a hierarchy of groups. The
+ * lowest level group contains CPUs, the next level groups of CPU groups
+ * and so forth. The CPU groups are kept per node so for the normal case
+ * lock contention won't happen across nodes. Depending on the number of
+ * CPUs per node even the next level might be kept as groups of CPU groups
+ * per node and only the levels above cross the node topology.
+ *
+ * Example topology for a two node system with 24 CPUs each.
+ *
+ * LVL 2                           [GRP2:0]
+ *                              GRP1:0 =3D GRP1:M
+ *
+ * LVL 1            [GRP1:0]                      [GRP1:1]
+ *               GRP0:0 - GRP0:2               GRP0:3 - GRP0:5
+ *
+ * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
+ * CPUS     0-7       8-15      16-23     24-31     32-39     40-47
+ *
+ * The groups hold a timer queue of events sorted by expiry time. These
+ * queues are updated when CPUs go in idle. When they come out of idle
+ * ignore flag of events is set.
+ *
+ * Each group has a designated migrator CPU/group as long as a CPU/group is
+ * active in the group. This designated role is necessary to avoid that all
+ * active CPUs in a group try to migrate expired timers from other CPUs,
+ * which would result in massive lock bouncing.
+ *
+ * When a CPU is awake, it checks in it's own timer tick the group
+ * hierarchy up to the point where it is assigned the migrator role or if
+ * no CPU is active, it also checks the groups where no migrator is set
+ * (TMIGR_NONE).
+ *
+ * If it finds expired timers in one of the group queues it pulls them over
+ * from the idle CPU and runs the timer function. After that it updates the
+ * group and the parent groups if required.
+ *
+ * CPUs which go idle arm their CPU local timer hardware for the next local
+ * (pinned) timer event. If the next migratable timer expires after the
+ * next local timer or the CPU has no migratable timer pending then the
+ * CPU does not queue an event in the LVL0 group. If the next migratable
+ * timer expires before the next local timer then the CPU queues that timer
+ * in the LVL0 group. In both cases the CPU marks itself idle in the LVL0
+ * group.
+ *
+ * When CPU comes out of idle and when a group has at least a single active
+ * child, the ignore flag of the tmigr_event is set. This indicates, that
+ * the event is ignored even if it is still enqueued in the parent groups
+ * timer queue. It will be removed when touching the timer queue the next
+ * time. This spares locking in active path as the lock protects (after
+ * setup) only event information. For more information about locking,
+ * please read the section "Locking rules".
+ *
+ * If the CPU is the migrator of the group then it delegates that role to
+ * the next active CPU in the group or sets migrator to TMIGR_NONE when
+ * there is no active CPU in the group. This delegation needs to be
+ * propagated up the hierarchy so hand over from other leaves can happen at
+ * all hierarchy levels w/o doing a search.
+ *
+ * When the last CPU in the system goes idle, then it drops all migrator
+ * duties up to the top level of the hierarchy (LVL2 in the example). It
+ * then has to make sure, that it arms it's own local hardware timer for
+ * the earliest event in the system.
+ *
+ *
+ * Lifetime rules:
+ * ---------------
+ *
+ * The groups are built up at init time or when CPUs come online. They are
+ * not destroyed when a group becomes empty due to offlining. The group
+ * just won't participate in the hierarchy management anymore. Destroying
+ * groups would result in interesting race conditions which would just make
+ * the whole mechanism slow and complex.
+ *
+ *
+ * Locking rules:
+ * --------------
+ *
+ * For setting up new groups and handling events it's required to lock both
+ * child and parent group. The lock ordering is always bottom up. This also
+ * includes the per CPU locks in struct tmigr_cpu. For updating the migrator=
 and
+ * active CPU/group information atomic_try_cmpxchg() is used instead and only
+ * the per CPU tmigr_cpu->lock is held.
+ *
+ * During the setup of groups tmigr_level_list is required. It is protected =
by
+ * @tmigr_mutex.
+ *
+ * When @timer_base->lock as well as tmigr related locks are required, the l=
ock
+ * ordering is: first @timer_base->lock, afterwards tmigr related locks.
+ *
+ *
+ * Protection of the tmigr group state information:
+ * ------------------------------------------------
+ *
+ * The state information with the list of active children and migrator needs=
 to
+ * be protected by a sequence counter. It prevents a race when updates in ch=
ild
+ * groups are propagated in changed order. The state update is performed
+ * lockless and group wise. The following scenario describes what happens
+ * without updating the sequence counter:
+ *
+ * Therefore, let's take three groups and four CPUs (CPU2 and CPU3 as well
+ * as GRP0:1 will not change during the scenario):
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D CPU0           migrator =3D CPU2
+ *           active   =3D CPU0           active   =3D CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             active      idle           active      idle
+ *
+ *
+ * 1. CPU0 goes idle. As the update is performed group wise, in the first st=
ep
+ *    only GRP0:0 is updated. The update of GRP1:0 is pending as CPU0 has to
+ *    walk the hierarchy.
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator =3D TMIGR_NONE     migrator =3D CPU2
+ *       --> active   =3D                active   =3D CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *         --> idle        idle           active      idle
+ *
+ * 2. While CPU0 goes idle and continues to update the state, CPU1 comes out=
 of
+ *    idle. CPU1 updates GRP0:0. The update for GRP1:0 is pending as CPU1 al=
so
+ *    has to walk the hierarchy. Both CPUs (CPU0 and CPU1) now walk the
+ *    hierarchy to perform the needed update from their point of view. The
+ *    currently visible state looks the following:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *       --> migrator =3D CPU1           migrator =3D CPU2
+ *       --> active   =3D CPU1           active   =3D CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle    --> active         active      idle
+ *
+ * 3. Here is the race condition: CPU1 managed to propagate its changes (from
+ *    step 2) through the hierarchy to GRP1:0 before CPU0 (step 1) did. The
+ *    active members of GRP1:0 remain unchanged after the update since it is
+ *    still valid from CPU1 current point of view:
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator =3D GRP0:1
+ *                 --> active   =3D GRP0:0, GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D CPU1           migrator =3D CPU2
+ *           active   =3D CPU1           active   =3D CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        active         active      idle
+ *
+ * 4. Now CPU0 finally propagates its changes (from step 1) to GRP1:0.
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator =3D GRP0:1
+ *                 --> active   =3D GRP0:1
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D CPU1           migrator =3D CPU2
+ *           active   =3D CPU1           active   =3D CPU2
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        active         active      idle
+ *
+ *
+ * The race of CPU0 vs. CPU1 led to an inconsistent state in GRP1:0. CPU1 is
+ * active and is correctly listed as active in GRP0:0. However GRP1:0 does n=
ot
+ * have GRP0:0 listed as active, which is wrong. The sequence counter has be=
en
+ * added to avoid inconsistent states during updates. The state is updated
+ * atomically only if all members, including the sequence counter, match the
+ * expected value (compare-and-exchange).
+ *
+ * Looking back at the previous example with the addition of the sequence
+ * counter: The update as performed by CPU0 in step 4 will fail. CPU1 changed
+ * the sequence number during the update in step 3 so the expected old value=
 (as
+ * seen by CPU0 before starting the walk) does not match.
+ *
+ * Prevent race between new event and last CPU going inactive
+ * ----------------------------------------------------------
+ *
+ * When the last CPU is going idle and there is a concurrent update of a new
+ * first global timer of an idle CPU, the group and child states have to be =
read
+ * while holding the lock in tmigr_update_events(). The following scenario s=
hows
+ * what happens, when this is not done.
+ *
+ * 1. Only CPU2 is active:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:1
+ *                     next_expiry =3D KTIME_MAX
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D CPU2
+ *           active   =3D                active   =3D CPU2
+ *           next_expiry =3D KTIME_MAX   next_expiry =3D KTIME_MAX
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 2. Now CPU 2 goes idle (and has no global timer, that has to be handled) =
and
+ *    propagates that to GRP0:1:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:1
+ *                     next_expiry =3D KTIME_MAX
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE --> migrator =3D TMIGR_NONE
+ *           active   =3D            --> active   =3D
+ *           next_expiry =3D KTIME_MAX   next_expiry =3D KTIME_MAX
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle       --> idle        idle
+ *
+ * 3. Now the idle state is propagated up to GRP1:0. As this is now the last
+ *    child going idle in top level group, the expiry of the next group event
+ *    has to be handed back to make sure no event is lost. As there is no ev=
ent
+ *    enqueued, KTIME_MAX is handed back to CPU2.
+ *
+ *    LVL 1            [GRP1:0]
+ *                 --> migrator =3D TMIGR_NONE
+ *                 --> active   =3D
+ *                     next_expiry =3D KTIME_MAX
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D TMIGR_NONE
+ *           active   =3D                active   =3D
+ *           next_expiry =3D KTIME_MAX   next_expiry =3D KTIME_MAX
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle       --> idle        idle
+ *
+ * 4. CPU 0 has a new timer queued from idle and it expires at TIMER0. CPU0
+ *    propagates that to GRP0:0:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D TMIGR_NONE
+ *                     active   =3D
+ *                     next_expiry =3D KTIME_MAX
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D TMIGR_NONE
+ *           active   =3D                active   =3D
+ *       --> next_expiry =3D TIMER0      next_expiry  =3D KTIME_MAX
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           idle        idle
+ *
+ * 5. GRP0:0 is not active, so the new timer has to be propagated to
+ *    GRP1:0. Therefore the GRP1:0 state has to be read. When the stalled va=
lue
+ *    (from step 2) is read, the timer is enqueued into GRP1:0, but nothing =
is
+ *    handed back to CPU0, as it seems that there is still an active child in
+ *    top level group.
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D TMIGR_NONE
+ *                     active   =3D
+ *                 --> next_expiry =3D TIMER0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D TMIGR_NONE
+ *           active   =3D                active   =3D
+ *           next_expiry =3D TIMER0      next_expiry  =3D KTIME_MAX
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           idle        idle
+ *
+ * This is prevented by reading the state when holding the lock (when a new
+ * timer has to be propagated from idle path)::
+ *
+ *   CPU2 (tmigr_inactive_up())          CPU0 (tmigr_new_timer_up())
+ *   --------------------------          ---------------------------
+ *   // step 3:
+ *   cmpxchg(&GRP1:0->state);
+ *   tmigr_update_events() {
+ *       spin_lock(&GRP1:0->lock);
+ *       // ... update events ...
+ *       // hand back first expiry when GRP1:0 is idle
+ *       spin_unlock(&GRP1:0->lock);
+ *       // ^^^ release state modification
+ *   }
+ *                                       tmigr_update_events() {
+ *                                           spin_lock(&GRP1:0->lock)
+ *                                           // ^^^ acquire state modificati=
on
+ *                                           group_state =3D atomic_read(&GR=
P1:0->state)
+ *                                           // .... update events ...
+ *                                           // hand back first expiry when =
GRP1:0 is idle
+ *                                           spin_unlock(&GRP1:0->lock) <3>
+ *                                           // ^^^ makes state visible for =
other
+ *                                           // callers of tmigr_new_timer_u=
p()
+ *                                       }
+ *
+ * When CPU0 grabs the lock directly after cmpxchg, the first timer is repor=
ted
+ * back to CPU0 and also later on to CPU2. So no timer is missed. A concurre=
nt
+ * update of the group state from active path is no problem, as the upcoming=
 CPU
+ * will take care of the group events.
+ *
+ * Required event and timerqueue update after a remote expiry:
+ * -----------------------------------------------------------
+ *
+ * After expiring timers of a remote CPU, a walk through the hierarchy and
+ * update of events and timerqueues is required. It is obviously needed if t=
here
+ * is a 'new' global timer but also if there is no new global timer but the
+ * remote CPU is still idle.
+ *
+ * 1. CPU0 and CPU1 are idle and have both a global timer expiring at the sa=
me
+ *    time. So both have an event enqueued in the timerqueue of GRP0:0. CPU3=
 is
+ *    also idle and has no global timer pending. CPU2 is the only active CPU=
 and
+ *    thus also the migrator:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:1
+ *                 --> timerqueue =3D evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D CPU2
+ *           active   =3D                active   =3D CPU2
+ *           groupevt.ignore =3D false   groupevt.ignore =3D true
+ *           groupevt.cpu =3D CPU0       groupevt.cpu =3D
+ *           timerqueue =3D evt-CPU0,    timerqueue =3D
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 2. CPU2 starts to expire remote timers. It starts with LVL0 group
+ *    GRP0:1. There is no event queued in the timerqueue, so CPU2 continues =
with
+ *    the parent of GRP0:1: GRP1:0. In GRP1:0 it dequeues the first event. It
+ *    looks at tmigr_event::cpu struct member and expires the pending timer(=
s)
+ *    of CPU0.
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:1
+ *                 --> timerqueue =3D
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D CPU2
+ *           active   =3D                active   =3D CPU2
+ *           groupevt.ignore =3D false   groupevt.ignore =3D true
+ *       --> groupevt.cpu =3D CPU0       groupevt.cpu =3D
+ *           timerqueue =3D evt-CPU0,    timerqueue =3D
+ *                        evt-CPU1
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * 3. Some work has to be done after expiring the timers of CPU0. If we stop
+ *    here, then CPU1's pending global timer(s) will not expire in time and =
the
+ *    timerqueue of GRP0:0 has still an event for CPU0 enqueued which has ju=
st
+ *    been processed. So it is required to walk the hierarchy from CPU0's po=
int
+ *    of view and update it accordingly. CPU0's event will be removed from t=
he
+ *    timerqueue because it has no pending timer. If CPU0 would have a timer
+ *    pending then it has to expire after CPU1's first timer because all tim=
ers
+ *    from this period were just expired. Either way CPU1's event will be fi=
rst
+ *    in GRP0:0's timerqueue and therefore set in the CPU field of the group
+ *    event which is then enqueued in GRP1:0's timerqueue as GRP0:0 is still=
 not
+ *    active:
+ *
+ *    LVL 1            [GRP1:0]
+ *                     migrator =3D GRP0:1
+ *                     active   =3D GRP0:1
+ *                 --> timerqueue =3D evt-GRP0:0
+ *                   /                \
+ *    LVL 0  [GRP0:0]                  [GRP0:1]
+ *           migrator =3D TMIGR_NONE     migrator =3D CPU2
+ *           active   =3D                active   =3D CPU2
+ *           groupevt.ignore =3D false   groupevt.ignore =3D true
+ *       --> groupevt.cpu =3D CPU1       groupevt.cpu =3D
+ *       --> timerqueue =3D evt-CPU1     timerqueue =3D
+ *              /         \                /         \
+ *    CPUs     0           1              2           3
+ *             idle        idle           active      idle
+ *
+ * Now CPU2 (migrator) will continue step 2 at GRP1:0 and will expire the
+ * timer(s) of CPU1.
+ *
+ * The hierarchy walk in step 3 can be skipped if the migrator notices that a
+ * CPU of GRP0:0 is active again. The CPU will mark GRP0:0 active and take c=
are
+ * of the group as migrator and any needed updates within the hierarchy.
+ */
+
+static DEFINE_MUTEX(tmigr_mutex);
+static struct list_head *tmigr_level_list __read_mostly;
+
+static unsigned int tmigr_hierarchy_levels __read_mostly;
+static unsigned int tmigr_crossnode_level __read_mostly;
+
+static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
+
+#define TMIGR_NONE	0xFF
+#define BIT_CNT		8
+
+static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
+{
+	return !(tmc->tmgroup && tmc->online);
+}
+
+/*
+ * Returns true, when @childmask corresponds to the group migrator or when t=
he
+ * group is not active - so no migrator is set.
+ */
+static bool tmigr_check_migrator(struct tmigr_group *group, u8 childmask)
+{
+	union tmigr_state s;
+
+	s.state =3D atomic_read(&group->migr_state);
+
+	if ((s.migrator =3D=3D childmask) || (s.migrator =3D=3D TMIGR_NONE))
+		return true;
+
+	return false;
+}
+
+static bool tmigr_check_migrator_and_lonely(struct tmigr_group *group, u8 ch=
ildmask)
+{
+	bool lonely, migrator =3D false;
+	unsigned long active;
+	union tmigr_state s;
+
+	s.state =3D atomic_read(&group->migr_state);
+
+	if ((s.migrator =3D=3D childmask) || (s.migrator =3D=3D TMIGR_NONE))
+		migrator =3D true;
+
+	active =3D s.active;
+	lonely =3D bitmap_weight(&active, BIT_CNT) <=3D 1;
+
+	return (migrator && lonely);
+}
+
+static bool tmigr_check_lonely(struct tmigr_group *group)
+{
+	unsigned long active;
+	union tmigr_state s;
+
+	s.state =3D atomic_read(&group->migr_state);
+
+	active =3D s.active;
+
+	return bitmap_weight(&active, BIT_CNT) <=3D 1;
+}
+
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
+
+static void __walk_groups(up_f up, void *data,
+			  struct tmigr_cpu *tmc)
+{
+	struct tmigr_group *child =3D NULL, *group =3D tmc->tmgroup;
+
+	do {
+		WARN_ON_ONCE(group->level >=3D tmigr_hierarchy_levels);
+
+		if (up(group, child, data))
+			break;
+
+		child =3D group;
+		group =3D group->parent;
+	} while (group);
+}
+
+static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
+{
+	lockdep_assert_held(&tmc->lock);
+
+	__walk_groups(up, data, tmc);
+}
+
+/**
+ * struct tmigr_walk - data required for walking the hierarchy
+ * @nextexp:		Next CPU event expiry information which is handed into
+ *			the timer migration code by the timer code
+ *			(get_next_timer_interrupt())
+ * @firstexp:		Contains the first event expiry information when last
+ *			active CPU of hierarchy is on the way to idle to make
+ *			sure CPU will be back in time.
+ * @evt:		Pointer to tmigr_event which needs to be queued (of idle
+ *			child group)
+ * @childmask:		childmask of child group
+ * @remote:		Is set, when the new timer path is executed in
+ *			tmigr_handle_remote_cpu()
+ */
+struct tmigr_walk {
+	u64			nextexp;
+	u64			firstexp;
+	struct tmigr_event	*evt;
+	u8			childmask;
+	bool			remote;
+};
+
+/**
+ * struct tmigr_remote_data - data required for remote expiry hierarchy walk
+ * @basej:		timer base in jiffies
+ * @now:		timer base monotonic
+ * @firstexp:		returns expiry of the first timer in the idle timer
+ *			migration hierarchy to make sure the timer is handled in
+ *			time; it is stored in the per CPU tmigr_cpu struct of
+ *			CPU which expires remote timers
+ * @childmask:		childmask of child group
+ * @check:		is set if there is the need to handle remote timers;
+ *			required in tmigr_requires_handle_remote() only
+ * @tmc_active:		this flag indicates, whether the CPU which triggers
+ *			the hierarchy walk is !idle in the timer migration
+ *			hierarchy. When the CPU is idle and the whole hierarchy is
+ *			idle, only the first event of the top level has to be
+ *			considered.
+ */
+struct tmigr_remote_data {
+	unsigned long	basej;
+	u64		now;
+	u64		firstexp;
+	u8		childmask;
+	bool		check;
+	bool		tmc_active;
+};
+
+/*
+ * Returns the next event of the timerqueue @group->events
+ *
+ * Removes timers with ignore flag and update next_expiry of the group. Valu=
es
+ * of the group event are updated in tmigr_update_events() only.
+ */
+static struct tmigr_event *tmigr_next_groupevt(struct tmigr_group *group)
+{
+	struct timerqueue_node *node =3D NULL;
+	struct tmigr_event *evt =3D NULL;
+
+	lockdep_assert_held(&group->lock);
+
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+
+	while ((node =3D timerqueue_getnext(&group->events))) {
+		evt =3D container_of(node, struct tmigr_event, nextevt);
+
+		if (!evt->ignore) {
+			WRITE_ONCE(group->next_expiry, evt->nextevt.expires);
+			return evt;
+		}
+
+		/*
+		 * Remove next timers with ignore flag, because the group lock
+		 * is held anyway
+		 */
+		if (!timerqueue_del(&group->events, node))
+			break;
+	}
+
+	return NULL;
+}
+
+/*
+ * Return the next event (with the expiry equal or before @now)
+ *
+ * Event, which is returned, is also removed from the queue.
+ */
+static struct tmigr_event *tmigr_next_expired_groupevt(struct tmigr_group *g=
roup,
+						       u64 now)
+{
+	struct tmigr_event *evt =3D tmigr_next_groupevt(group);
+
+	if (!evt || now < evt->nextevt.expires)
+		return NULL;
+
+	/*
+	 * The event is ready to expire. Remove it and update next group event.
+	 */
+	timerqueue_del(&group->events, &evt->nextevt);
+	tmigr_next_groupevt(group);
+
+	return evt;
+}
+
+static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
+{
+	struct tmigr_event *evt;
+
+	evt =3D tmigr_next_groupevt(group);
+
+	if (!evt)
+		return KTIME_MAX;
+	else
+		return evt->nextevt.expires;
+}
+
+static bool tmigr_active_up(struct tmigr_group *group,
+			    struct tmigr_group *child,
+			    void *ptr)
+{
+	union tmigr_state curstate, newstate;
+	struct tmigr_walk *data =3D ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask =3D data->childmask;
+	/*
+	 * No memory barrier is required here in contrast to
+	 * tmigr_inactive_up(), as the group state change does not depend on the
+	 * child state.
+	 */
+	curstate.state =3D atomic_read(&group->migr_state);
+
+	do {
+		newstate =3D curstate;
+		walk_done =3D true;
+
+		if (newstate.migrator =3D=3D TMIGR_NONE) {
+			newstate.migrator =3D childmask;
+
+			/* Changes need to be propagated */
+			walk_done =3D false;
+		}
+
+		newstate.active |=3D childmask;
+		newstate.seq++;
+
+	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.=
state));
+
+	if ((walk_done =3D=3D false) && group->parent)
+		data->childmask =3D group->childmask;
+
+	/*
+	 * The group is active (again). The group event might be still queued
+	 * into the parent group's timerqueue but can now be handled by the
+	 * migrator of this group. Therefore the ignore flag for the group event
+	 * is updated to reflect this.
+	 *
+	 * The update of the ignore flag in the active path is done lockless. In
+	 * worst case the migrator of the parent group observes the change too
+	 * late and expires remotely all events belonging to this group. The
+	 * lock is held while updating the ignore flag in idle path. So this
+	 * state change will not be lost.
+	 */
+	group->groupevt.ignore =3D true;
+
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
+	return walk_done;
+}
+
+static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
+{
+	struct tmigr_walk data;
+
+	data.childmask =3D tmc->childmask;
+
+	trace_tmigr_cpu_active(tmc);
+
+	tmc->cpuevt.ignore =3D true;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	walk_groups(&tmigr_active_up, &data, tmc);
+}
+
+/**
+ * tmigr_cpu_activate() - set this CPU active in timer migration hierarchy
+ *
+ * Call site timer_clear_idle() is called with interrupts disabled.
+ */
+void tmigr_cpu_activate(void)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+
+	if (tmigr_is_not_available(tmc))
+		return;
+
+	if (WARN_ON_ONCE(!tmc->idle))
+		return;
+
+	raw_spin_lock(&tmc->lock);
+	tmc->idle =3D false;
+	__tmigr_cpu_activate(tmc);
+	raw_spin_unlock(&tmc->lock);
+}
+
+/*
+ * Returns true, if there is nothing to be propagated to the next level
+ *
+ * @data->firstexp is set to expiry of first gobal event of the (top level of
+ * the) hierarchy, but only when hierarchy is completely idle.
+ *
+ * The child and group states need to be read under the lock, to prevent a r=
ace
+ * against a concurrent tmigr_inactive_up() run when the last CPU goes idle.=
 See
+ * also section "Prevent race between new event and last CPU going inactive"=
 in
+ * the documentation at the top.
+ *
+ * This is the only place where the group event expiry value is set.
+ */
+static
+bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *chil=
d,
+			 struct tmigr_walk *data)
+{
+	struct tmigr_event *evt, *first_childevt;
+	union tmigr_state childstate, groupstate;
+	bool remote =3D data->remote;
+	bool walk_done =3D false;
+	u64 nextexp;
+
+	if (child) {
+		raw_spin_lock(&child->lock);
+		raw_spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
+
+		childstate.state =3D atomic_read(&child->migr_state);
+		groupstate.state =3D atomic_read(&group->migr_state);
+
+		if (childstate.active) {
+			walk_done =3D true;
+			goto unlock;
+		}
+
+		first_childevt =3D tmigr_next_groupevt(child);
+		nextexp =3D child->next_expiry;
+		evt =3D &child->groupevt;
+
+		evt->ignore =3D (nextexp =3D=3D KTIME_MAX) ? true : false;
+	} else {
+		nextexp =3D data->nextexp;
+
+		first_childevt =3D evt =3D data->evt;
+
+		/*
+		 * Walking the hierarchy is required in any case when a
+		 * remote expiry was done before. This ensures to not lose
+		 * already queued events in non active groups (see section
+		 * "Required event and timerqueue update after a remote
+		 * expiry" in the documentation at the top).
+		 *
+		 * The two call sites which are executed without a remote expiry
+		 * before, are not prevented from propagating changes through
+		 * the hierarchy by the return:
+		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
+		 *    is never set.
+		 *  - tmigr_inactive_up() takes care of the propagation by
+		 *    itself and ignores the return value. But an immediate
+		 *    return is required because nothing has to be done in this
+		 *    level as the event could be ignored.
+		 */
+		if (evt->ignore && !remote)
+			return true;
+
+		raw_spin_lock(&group->lock);
+
+		childstate.state =3D 0;
+		groupstate.state =3D atomic_read(&group->migr_state);
+	}
+
+	/*
+	 * If the child event is already queued in the group, remove it from the
+	 * queue when the expiry time changed only or when it could be ignored.
+	 */
+	if (timerqueue_node_queued(&evt->nextevt)) {
+		if ((evt->nextevt.expires =3D=3D nextexp) && !evt->ignore)
+			goto check_toplvl;
+
+		if (!timerqueue_del(&group->events, &evt->nextevt))
+			WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	}
+
+	if (evt->ignore) {
+		/*
+		 * When the next child event could be ignored (nextexp is
+		 * KTIME_MAX) and there was no remote timer handling before or
+		 * the group is already active, there is no need to walk the
+		 * hierarchy even if there is a parent group.
+		 *
+		 * The other way round: even if the event could be ignored, but
+		 * if a remote timer handling was executed before and the group
+		 * is not active, walking the hierarchy is required to not miss
+		 * an enqueued timer in the non active group. The enqueued timer
+		 * of the group needs to be propagated to a higher level to
+		 * ensure it is handled.
+		 */
+		if (!remote || groupstate.active)
+			walk_done =3D true;
+	} else {
+		evt->nextevt.expires =3D nextexp;
+		evt->cpu =3D first_childevt->cpu;
+
+		if (timerqueue_add(&group->events, &evt->nextevt))
+			WRITE_ONCE(group->next_expiry, nextexp);
+	}
+
+check_toplvl:
+	if (!group->parent && (groupstate.migrator =3D=3D TMIGR_NONE)) {
+		walk_done =3D true;
+
+		/*
+		 * Nothing to do when update was done during remote timer
+		 * handling. First timer in top level group which needs to be
+		 * handled when top level group is not active, is calculated
+		 * directly in tmigr_handle_remote_up().
+		 */
+		if (remote)
+			goto unlock;
+
+		/*
+		 * The top level group is idle and it has to be ensured the
+		 * global timers are handled in time. (This could be optimized
+		 * by keeping track of the last global scheduled event and only
+		 * arming it on the CPU if the new event is earlier. Not sure if
+		 * its worth the complexity.)
+		 */
+		data->firstexp =3D tmigr_next_groupevt_expires(group);
+	}
+
+	trace_tmigr_update_events(child, group, childstate, groupstate,
+				  nextexp);
+
+unlock:
+	raw_spin_unlock(&group->lock);
+
+	if (child)
+		raw_spin_unlock(&child->lock);
+
+	return walk_done;
+}
+
+static bool tmigr_new_timer_up(struct tmigr_group *group,
+			       struct tmigr_group *child,
+			       void *ptr)
+{
+	struct tmigr_walk *data =3D ptr;
+
+	return tmigr_update_events(group, child, data);
+}
+
+/*
+ * Returns the expiry of the next timer that needs to be handled. KTIME_MAX =
is
+ * returned, if an active CPU will handle all the timer migration hierarchy
+ * timers.
+ */
+static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data =3D { .nextexp =3D nextexp,
+				   .firstexp =3D KTIME_MAX,
+				   .evt =3D &tmc->cpuevt };
+
+	lockdep_assert_held(&tmc->lock);
+
+	if (tmc->remote)
+		return KTIME_MAX;
+
+	trace_tmigr_cpu_new_timer(tmc);
+
+	tmc->cpuevt.ignore =3D false;
+	data.remote =3D false;
+
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+	/* If there is a new first global event, make sure it is handled */
+	return data.firstexp;
+}
+
+static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
+				    unsigned long jif)
+{
+	struct timer_events tevt;
+	struct tmigr_walk data;
+	struct tmigr_cpu *tmc;
+
+	tmc =3D per_cpu_ptr(&tmigr_cpu, cpu);
+
+	raw_spin_lock_irq(&tmc->lock);
+
+	/*
+	 * If the remote CPU is offline then the timers have been migrated to
+	 * another CPU.
+	 *
+	 * If tmigr_cpu::remote is set, at the moment another CPU already
+	 * expires the timers of the remote CPU.
+	 *
+	 * If tmigr_event::ignore is set, then the CPU returns from idle and
+	 * takes care of its timers.
+	 *
+	 * If the next event expires in the future, then the event has been
+	 * updated and there are no timers to expire right now. The CPU which
+	 * updated the event takes care when hierarchy is completely
+	 * idle. Otherwise the migrator does it as the event is enqueued.
+	 */
+	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	    now < tmc->cpuevt.nextevt.expires) {
+		raw_spin_unlock_irq(&tmc->lock);
+		return;
+	}
+
+	trace_tmigr_handle_remote_cpu(tmc);
+
+	tmc->remote =3D true;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/* Drop the lock to allow the remote CPU to exit idle */
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (cpu !=3D smp_processor_id())
+		timer_expire_remote(cpu);
+
+	/*
+	 * Lock ordering needs to be preserved - timer_base locks before tmigr
+	 * related locks (see section "Locking rules" in the documentation at
+	 * the top). During fetching the next timer interrupt, also tmc->lock
+	 * needs to be held. Otherwise there is a possible race window against
+	 * the CPU itself when it comes out of idle, updates the first timer in
+	 * the hierarchy and goes back to idle.
+	 *
+	 * timer base locks are dropped as fast as possible: After checking
+	 * whether the remote CPU went offline in the meantime and after
+	 * fetching the next remote timer interrupt. Dropping the locks as fast
+	 * as possible keeps the locking region small and prevents holding
+	 * several (unnecessary) locks during walking the hierarchy for updating
+	 * the timerqueue and group events.
+	 */
+	local_irq_disable();
+	timer_lock_remote_bases(cpu);
+	raw_spin_lock(&tmc->lock);
+
+	/*
+	 * When the CPU went offline in the meantime, no hierarchy walk has to
+	 * be done for updating the queued events, because the walk was
+	 * already done during marking the CPU offline in the hierarchy.
+	 *
+	 * When the CPU is no longer idle, the CPU takes care of the timers and
+	 * also of the timers in the hierarchy.
+	 *
+	 * (See also section "Required event and timerqueue update after a
+	 * remote expiry" in the documentation at the top)
+	 */
+	if (!tmc->online || !tmc->idle) {
+		timer_unlock_remote_bases(cpu);
+		goto unlock;
+	}
+
+	/* next	event of CPU */
+	fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
+	timer_unlock_remote_bases(cpu);
+
+	data.nextexp =3D tevt.global;
+	data.firstexp =3D KTIME_MAX;
+	data.evt =3D &tmc->cpuevt;
+	data.remote =3D true;
+
+	/*
+	 * The update is done even when there is no 'new' global timer pending
+	 * on the remote CPU (see section "Required event and timerqueue update
+	 * after a remote expiry" in the documentation at the top)
+	 */
+	walk_groups(&tmigr_new_timer_up, &data, tmc);
+
+unlock:
+	tmc->remote =3D false;
+	raw_spin_unlock_irq(&tmc->lock);
+}
+
+static bool tmigr_handle_remote_up(struct tmigr_group *group,
+				   struct tmigr_group *child,
+				   void *ptr)
+{
+	struct tmigr_remote_data *data =3D ptr;
+	struct tmigr_event *evt;
+	unsigned long jif;
+	u8 childmask;
+	u64 now;
+
+	jif =3D data->basej;
+	now =3D data->now;
+
+	childmask =3D data->childmask;
+
+	trace_tmigr_handle_remote(group);
+again:
+	/*
+	 * Handle the group only if @childmask is the migrator or if the
+	 * group has no migrator. Otherwise the group is active and is
+	 * handled by its own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	raw_spin_lock_irq(&group->lock);
+
+	evt =3D tmigr_next_expired_groupevt(group, now);
+
+	if (evt) {
+		unsigned int remote_cpu =3D evt->cpu;
+
+		raw_spin_unlock_irq(&group->lock);
+
+		tmigr_handle_remote_cpu(remote_cpu, now, jif);
+
+		/* check if there is another event, that needs to be handled */
+		goto again;
+	}
+
+	/*
+	 * Update of childmask for the next level and keep track of the expiry
+	 * of the first event that needs to be handled (group->next_expiry was
+	 * updated by tmigr_next_expired_groupevt(), next was set by
+	 * tmigr_handle_remote_cpu()).
+	 */
+	data->childmask =3D group->childmask;
+	data->firstexp =3D group->next_expiry;
+
+	raw_spin_unlock_irq(&group->lock);
+
+	return false;
+}
+
+/**
+ * tmigr_handle_remote() - Handle global timers of remote idle CPUs
+ *
+ * Called from the timer soft interrupt with interrupts enabled.
+ */
+void tmigr_handle_remote(void)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+
+	if (tmigr_is_not_available(tmc))
+		return;
+
+	data.childmask =3D tmc->childmask;
+	data.firstexp =3D KTIME_MAX;
+
+	/*
+	 * NOTE: This is a doubled check because the migrator test will be done
+	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
+	 * return when nothing has to be done.
+	 */
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
+		return;
+
+	data.now =3D get_jiffies_update(&data.basej);
+
+	/*
+	 * Update @tmc->wakeup only at the end and do not reset @tmc->wakeup to
+	 * KTIME_MAX. Even if tmc->lock is not held during the whole remote
+	 * handling, tmc->wakeup is fine to be stale as it is called in
+	 * interrupt context and tick_nohz_next_event() is executed in interrupt
+	 * exit path only after processing the last pending interrupt.
+	 */
+
+	__walk_groups(&tmigr_handle_remote_up, &data, tmc);
+
+	raw_spin_lock_irq(&tmc->lock);
+	WRITE_ONCE(tmc->wakeup, data.firstexp);
+	raw_spin_unlock_irq(&tmc->lock);
+}
+
+static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
+					    struct tmigr_group *child,
+					    void *ptr)
+{
+	struct tmigr_remote_data *data =3D ptr;
+	u8 childmask;
+
+	childmask =3D data->childmask;
+
+	/*
+	 * Handle the group only if the child is the migrator or if the group
+	 * has no migrator. Otherwise the group is active and is handled by its
+	 * own migrator.
+	 */
+	if (!tmigr_check_migrator(group, childmask))
+		return true;
+
+	/*
+	 * When there is a parent group and the CPU which triggered the
+	 * hierarchy walk is not active, proceed the walk to reach the top level
+	 * group before reading the next_expiry value.
+	 */
+	if (group->parent && !data->tmc_active)
+		goto out;
+
+	/*
+	 * The lock is required on 32bit architectures to read the variable
+	 * consistently with a concurrent writer. On 64bit the lock is not
+	 * required because the read operation is not split and so it is always
+	 * consistent.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		data->firstexp =3D READ_ONCE(group->next_expiry);
+		if (data->now >=3D data->firstexp) {
+			data->check =3D true;
+			return true;
+		}
+	} else {
+		raw_spin_lock(&group->lock);
+		data->firstexp =3D group->next_expiry;
+		if (data->now >=3D group->next_expiry) {
+			data->check =3D true;
+			raw_spin_unlock(&group->lock);
+			return true;
+		}
+		raw_spin_unlock(&group->lock);
+	}
+
+out:
+	/* Update of childmask for the next level */
+	data->childmask =3D group->childmask;
+	return false;
+}
+
+/**
+ * tmigr_requires_handle_remote() - Check the need of remote timer handling
+ *
+ * Must be called with interrupts disabled.
+ */
+bool tmigr_requires_handle_remote(void)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_remote_data data;
+	unsigned long jif;
+	bool ret =3D false;
+
+	if (tmigr_is_not_available(tmc))
+		return ret;
+
+	data.now =3D get_jiffies_update(&jif);
+	data.childmask =3D tmc->childmask;
+	data.firstexp =3D KTIME_MAX;
+	data.tmc_active =3D !tmc->idle;
+	data.check =3D false;
+
+	/*
+	 * If the CPU is active, walk the hierarchy to check whether a remote
+	 * expiry is required.
+	 *
+	 * Check is done lockless as interrupts are disabled and @tmc->idle is
+	 * set only by the local CPU.
+	 */
+	if (!tmc->idle) {
+		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
+
+		return data.check;
+	}
+
+	/*
+	 * When the CPU is idle, compare @tmc->wakeup with @data.now. The lock
+	 * is required on 32bit architectures to read the variable consistently
+	 * with a concurrent writer. On 64bit the lock is not required because
+	 * the read operation is not split and so it is always consistent.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (data.now >=3D READ_ONCE(tmc->wakeup))
+			return true;
+	} else {
+		raw_spin_lock(&tmc->lock);
+		if (data.now >=3D tmc->wakeup)
+			ret =3D true;
+		raw_spin_unlock(&tmc->lock);
+	}
+
+	return ret;
+}
+
+/**
+ * tmigr_cpu_new_timer() - enqueue next global timer into hierarchy (idle tm=
c)
+ * @nextexp:	Next expiry of global timer (or KTIME_MAX if not)
+ *
+ * The CPU is already deactivated in the timer migration
+ * hierarchy. tick_nohz_get_sleep_length() calls tick_nohz_next_event()
+ * and thereby the timer idle path is executed once more. @tmc->wakeup
+ * holds the first timer, when the timer migration hierarchy is
+ * completely idle.
+ *
+ * Returns the first timer that needs to be handled by this CPU or KTIME_MAX=
 if
+ * nothing needs to be done.
+ */
+u64 tmigr_cpu_new_timer(u64 nextexp)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	u64 ret;
+
+	if (tmigr_is_not_available(tmc))
+		return nextexp;
+
+	raw_spin_lock(&tmc->lock);
+
+	ret =3D READ_ONCE(tmc->wakeup);
+	if (nextexp !=3D KTIME_MAX) {
+		if (nextexp !=3D tmc->cpuevt.nextevt.expires ||
+		    tmc->cpuevt.ignore) {
+			ret =3D tmigr_new_timer(tmc, nextexp);
+		}
+	}
+	/*
+	 * Make sure the reevaluation of timers in idle path will not miss an
+	 * event.
+	 */
+	WRITE_ONCE(tmc->wakeup, ret);
+
+	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
+	raw_spin_unlock(&tmc->lock);
+	return ret;
+}
+
+static bool tmigr_inactive_up(struct tmigr_group *group,
+			      struct tmigr_group *child,
+			      void *ptr)
+{
+	union tmigr_state curstate, newstate, childstate;
+	struct tmigr_walk *data =3D ptr;
+	bool walk_done;
+	u8 childmask;
+
+	childmask =3D data->childmask;
+	childstate.state =3D 0;
+
+	/*
+	 * The memory barrier is paired with the cmpxchg() in tmigr_active_up()
+	 * to make sure the updates of child and group states are ordered. The
+	 * ordering is mandatory, as the group state change depends on the child
+	 * state.
+	 */
+	curstate.state =3D atomic_read_acquire(&group->migr_state);
+
+	for (;;) {
+		if (child)
+			childstate.state =3D atomic_read(&child->migr_state);
+
+		newstate =3D curstate;
+		walk_done =3D true;
+
+		/* Reset active bit when the child is no longer active */
+		if (!childstate.active)
+			newstate.active &=3D ~childmask;
+
+		if (newstate.migrator =3D=3D childmask) {
+			/*
+			 * Find a new migrator for the group, because the child
+			 * group is idle!
+			 */
+			if (!childstate.active) {
+				unsigned long new_migr_bit, active =3D newstate.active;
+
+				new_migr_bit =3D find_first_bit(&active, BIT_CNT);
+
+				if (new_migr_bit !=3D BIT_CNT) {
+					newstate.migrator =3D BIT(new_migr_bit);
+				} else {
+					newstate.migrator =3D TMIGR_NONE;
+
+					/* Changes need to be propagated */
+					walk_done =3D false;
+				}
+			}
+		}
+
+		newstate.seq++;
+
+		WARN_ON_ONCE((newstate.migrator !=3D TMIGR_NONE) && !(newstate.active));
+
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
+				       newstate.state))
+			break;
+
+		/*
+		 * The memory barrier is paired with the cmpxchg() in
+		 * tmigr_active_up() to make sure the updates of child and group
+		 * states are ordered. It is required only when the above
+		 * try_cmpxchg() fails.
+		 */
+		smp_mb__after_atomic();
+	}
+
+	data->remote =3D false;
+
+	/* Event Handling */
+	tmigr_update_events(group, child, data);
+
+	if (group->parent && (walk_done =3D=3D false))
+		data->childmask =3D group->childmask;
+
+	/*
+	 * data->firstexp was set by tmigr_update_events() and contains the
+	 * expiry of the first global event which needs to be handled. It
+	 * differs from KTIME_MAX if:
+	 * - group is the top level group and
+	 * - group is idle (which means CPU was the last active CPU in the
+	 *   hierarchy) and
+	 * - there is a pending event in the hierarchy
+	 */
+	WARN_ON_ONCE(data->firstexp !=3D KTIME_MAX && group->parent);
+
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
+	return walk_done;
+}
+
+static u64 __tmigr_cpu_deactivate(struct tmigr_cpu *tmc, u64 nextexp)
+{
+	struct tmigr_walk data =3D { .nextexp =3D nextexp,
+				   .firstexp =3D KTIME_MAX,
+				   .evt =3D &tmc->cpuevt,
+				   .childmask =3D tmc->childmask };
+
+	/*
+	 * If nextexp is KTIME_MAX, the CPU event will be ignored because the
+	 * local timer expires before the global timer, no global timer is set
+	 * or CPU goes offline.
+	 */
+	if (nextexp !=3D KTIME_MAX)
+		tmc->cpuevt.ignore =3D false;
+
+	walk_groups(&tmigr_inactive_up, &data, tmc);
+	return data.firstexp;
+}
+
+/**
+ * tmigr_cpu_deactivate() - Put current CPU into inactive state
+ * @nextexp:	The next global timer expiry of the current CPU
+ *
+ * Must be called with interrupts disabled.
+ *
+ * Return: the next event expiry of the current CPU or the next event expiry
+ * from the hierarchy if this CPU is the top level migrator or the hierarchy=
 is
+ * completely idle.
+ */
+u64 tmigr_cpu_deactivate(u64 nextexp)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	u64 ret;
+
+	if (tmigr_is_not_available(tmc))
+		return nextexp;
+
+	raw_spin_lock(&tmc->lock);
+
+	ret =3D __tmigr_cpu_deactivate(tmc, nextexp);
+
+	tmc->idle =3D true;
+
+	/*
+	 * Make sure the reevaluation of timers in idle path will not miss an
+	 * event.
+	 */
+	WRITE_ONCE(tmc->wakeup, ret);
+
+	trace_tmigr_cpu_idle(tmc, nextexp);
+	raw_spin_unlock(&tmc->lock);
+	return ret;
+}
+
+/**
+ * tmigr_quick_check() - Quick forecast of next tmigr event when CPU wants to
+ *			 go idle
+ * @nextevt:	The next global timer expiry of the current CPU
+ *
+ * Return:
+ * * KTIME_MAX		- when it is probable that nothing has to be done (not
+ *			  the only one in the level 0 group; and if it is the
+ *			  only one in level 0 group, but there are more than a
+ *			  single group active on the way to top level)
+ * * nextevt		- when CPU is offline and has to handle timer on his own
+ *			  or when on the way to top in every group only a single
+ *			  child is active but @nextevt is before the lowest
+ *			  next_expiry encountered while walking up to top level.
+ * * next_expiry	- value of lowest expiry encountered while walking groups
+ *			  if only a single child is active on each and @nextevt
+ *			  is after this lowest expiry.
+ */
+u64 tmigr_quick_check(u64 nextevt)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *group =3D tmc->tmgroup;
+
+	if (tmigr_is_not_available(tmc))
+		return nextevt;
+
+	if (WARN_ON_ONCE(tmc->idle))
+		return nextevt;
+
+	if (!tmigr_check_migrator_and_lonely(tmc->tmgroup, tmc->childmask))
+		return KTIME_MAX;
+
+	do {
+		if (!tmigr_check_lonely(group)) {
+			return KTIME_MAX;
+		} else {
+			/*
+			 * Since current CPU is active, events may not be sorted
+			 * from bottom to the top because the CPU's event is ignored
+			 * up to the top and its sibling's events not propagated upwards.
+			 * Thus keep track of the lowest observed expiry.
+			 */
+			nextevt =3D min_t(u64, nextevt, READ_ONCE(group->next_expiry));
+			if (!group->parent)
+				return nextevt;
+		}
+		group =3D group->parent;
+	} while (group);
+
+	return KTIME_MAX;
+}
+
+static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
+			     int node)
+{
+	union tmigr_state s;
+
+	raw_spin_lock_init(&group->lock);
+
+	group->level =3D lvl;
+	group->numa_node =3D lvl < tmigr_crossnode_level ? node : NUMA_NO_NODE;
+
+	group->num_children =3D 0;
+
+	s.migrator =3D TMIGR_NONE;
+	s.active =3D 0;
+	s.seq =3D 0;
+	atomic_set(&group->migr_state, s.state);
+
+	timerqueue_init_head(&group->events);
+	timerqueue_init(&group->groupevt.nextevt);
+	group->groupevt.nextevt.expires =3D KTIME_MAX;
+	WRITE_ONCE(group->next_expiry, KTIME_MAX);
+	group->groupevt.ignore =3D true;
+}
+
+static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
+					   unsigned int lvl)
+{
+	struct tmigr_group *tmp, *group =3D NULL;
+
+	lockdep_assert_held(&tmigr_mutex);
+
+	/* Try to attach to an existing group first */
+	list_for_each_entry(tmp, &tmigr_level_list[lvl], list) {
+		/*
+		 * If @lvl is below the cross NUMA node level, check whether
+		 * this group belongs to the same NUMA node.
+		 */
+		if (lvl < tmigr_crossnode_level && tmp->numa_node !=3D node)
+			continue;
+
+		/* Capacity left? */
+		if (tmp->num_children >=3D TMIGR_CHILDREN_PER_GROUP)
+			continue;
+
+		/*
+		 * TODO: A possible further improvement: Make sure that all CPU
+		 * siblings end up in the same group of the lowest level of the
+		 * hierarchy. Rely on the topology sibling mask would be a
+		 * reasonable solution.
+		 */
+
+		group =3D tmp;
+		break;
+	}
+
+	if (group)
+		return group;
+
+	/* Allocate and	set up a new group */
+	group =3D kzalloc_node(sizeof(*group), GFP_KERNEL, node);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	tmigr_init_group(group, lvl, node);
+
+	/* Setup successful. Add it to the hierarchy */
+	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
+	return group;
+}
+
+static void tmigr_connect_child_parent(struct tmigr_group *child,
+				       struct tmigr_group *parent)
+{
+	union tmigr_state childstate;
+
+	raw_spin_lock_irq(&child->lock);
+	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+
+	child->parent =3D parent;
+	child->childmask =3D BIT(parent->num_children++);
+
+	raw_spin_unlock(&parent->lock);
+	raw_spin_unlock_irq(&child->lock);
+
+	trace_tmigr_connect_child_parent(child);
+
+	/*
+	 * To prevent inconsistent states, active children need to be active in
+	 * the new parent as well. Inactive children are already marked inactive
+	 * in the parent group:
+	 *
+	 * * When new groups were created by tmigr_setup_groups() starting from
+	 *   the lowest level (and not higher then one level below the current
+	 *   top level), then they are not active. They will be set active when
+	 *   the new online CPU comes active.
+	 *
+	 * * But if a new group above the current top level is required, it is
+	 *   mandatory to propagate the active state of the already existing
+	 *   child to the new parent. So tmigr_connect_child_parent() is
+	 *   executed with the formerly top level group (child) and the newly
+	 *   created group (parent).
+	 */
+	childstate.state =3D atomic_read(&child->migr_state);
+	if (childstate.migrator !=3D TMIGR_NONE) {
+		struct tmigr_walk data;
+
+		data.childmask =3D child->childmask;
+
+		/*
+		 * There is only one new level per time. When connecting the
+		 * child and the parent and set the child active when the parent
+		 * is inactive, the parent needs to be the uppermost
+		 * level. Otherwise there went something wrong!
+		 */
+		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
+	}
+}
+
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+{
+	struct tmigr_group *group, *child, **stack;
+	int top =3D 0, err =3D 0, i =3D 0;
+	struct list_head *lvllist;
+
+	stack =3D kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
+	if (!stack)
+		return -ENOMEM;
+
+	do {
+		group =3D tmigr_get_group(cpu, node, i);
+		if (IS_ERR(group)) {
+			err =3D PTR_ERR(group);
+			break;
+		}
+
+		top =3D i;
+		stack[i++] =3D group;
+
+		/*
+		 * When booting only less CPUs of a system than CPUs are
+		 * available, not all calculated hierarchy levels are required.
+		 *
+		 * The loop is aborted as soon as the highest level, which might
+		 * be different from tmigr_hierarchy_levels, contains only a
+		 * single group.
+		 */
+		if (group->parent || i =3D=3D tmigr_hierarchy_levels ||
+		    (list_empty(&tmigr_level_list[i]) &&
+		     list_is_singular(&tmigr_level_list[i - 1])))
+			break;
+
+	} while (i < tmigr_hierarchy_levels);
+
+	do {
+		group =3D stack[--i];
+
+		if (err < 0) {
+			list_del(&group->list);
+			kfree(group);
+			continue;
+		}
+
+		WARN_ON_ONCE(i !=3D group->level);
+
+		/*
+		 * Update tmc -> group / child -> group connection
+		 */
+		if (i =3D=3D 0) {
+			struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+
+			raw_spin_lock_irq(&group->lock);
+
+			tmc->tmgroup =3D group;
+			tmc->childmask =3D BIT(group->num_children++);
+
+			raw_spin_unlock_irq(&group->lock);
+
+			trace_tmigr_connect_cpu_parent(tmc);
+
+			/* There are no children that need to be connected */
+			continue;
+		} else {
+			child =3D stack[i - 1];
+			tmigr_connect_child_parent(child, group);
+		}
+
+		/* check if uppermost level was newly created */
+		if (top !=3D i)
+			continue;
+
+		WARN_ON_ONCE(top =3D=3D 0);
+
+		lvllist =3D &tmigr_level_list[top];
+		if (group->num_children =3D=3D 1 && list_is_singular(lvllist)) {
+			lvllist =3D &tmigr_level_list[top - 1];
+			list_for_each_entry(child, lvllist, list) {
+				if (child->parent)
+					continue;
+
+				tmigr_connect_child_parent(child, group);
+			}
+		}
+	} while (i > 0);
+
+	kfree(stack);
+
+	return err;
+}
+
+static int tmigr_add_cpu(unsigned int cpu)
+{
+	int node =3D cpu_to_node(cpu);
+	int ret;
+
+	mutex_lock(&tmigr_mutex);
+	ret =3D tmigr_setup_groups(cpu, node);
+	mutex_unlock(&tmigr_mutex);
+
+	return ret;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	int ret;
+
+	/* First online attempt? Initialize CPU data */
+	if (!tmc->tmgroup) {
+		raw_spin_lock_init(&tmc->lock);
+
+		ret =3D tmigr_add_cpu(cpu);
+		if (ret < 0)
+			return ret;
+
+		if (tmc->childmask =3D=3D 0)
+			return -EINVAL;
+
+		timerqueue_init(&tmc->cpuevt.nextevt);
+		tmc->cpuevt.nextevt.expires =3D KTIME_MAX;
+		tmc->cpuevt.ignore =3D true;
+		tmc->cpuevt.cpu =3D cpu;
+
+		tmc->remote =3D false;
+		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+	}
+	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
+	tmc->idle =3D timer_base_is_idle();
+	if (!tmc->idle)
+		__tmigr_cpu_activate(tmc);
+	tmc->online =3D true;
+	raw_spin_unlock_irq(&tmc->lock);
+	return 0;
+}
+
+/*
+ * tmigr_trigger_active() - trigger a CPU to become active again
+ *
+ * This function is executed on a CPU which is part of cpu_online_mask, when=
 the
+ * last active CPU in the hierarchy is offlining. With this, it is ensured t=
hat
+ * the other CPU is active and takes over the migrator duty.
+ */
+static long tmigr_trigger_active(void *unused)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+
+	WARN_ON_ONCE(!tmc->online || tmc->idle);
+
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
+	int migrator;
+	u64 firstexp;
+
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->online =3D false;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/*
+	 * CPU has to handle the local events on his own, when on the way to
+	 * offline; Therefore nextevt value is set to KTIME_MAX
+	 */
+	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (firstexp !=3D KTIME_MAX) {
+		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
+		work_on_cpu(migrator, tmigr_trigger_active, NULL);
+	}
+
+	return 0;
+}
+
+static int __init tmigr_init(void)
+{
+	unsigned int cpulvl, nodelvl, cpus_per_node, i;
+	unsigned int nnodes =3D num_possible_nodes();
+	unsigned int ncpus =3D num_possible_cpus();
+	int ret =3D -ENOMEM;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP);
+
+	/* Nothing to do if running on UP */
+	if (ncpus =3D=3D 1)
+		return 0;
+
+	/*
+	 * Calculate the required hierarchy levels. Unfortunately there is no
+	 * reliable information available, unless all possible CPUs have been
+	 * brought up and all NUMA nodes are populated.
+	 *
+	 * Estimate the number of levels with the number of possible nodes and
+	 * the number of possible CPUs. Assume CPUs are spread evenly across
+	 * nodes. We cannot rely on cpumask_of_node() because it only works for
+	 * online CPUs.
+	 */
+	cpus_per_node =3D DIV_ROUND_UP(ncpus, nnodes);
+
+	/* Calc the hierarchy levels required to hold the CPUs of a node */
+	cpulvl =3D DIV_ROUND_UP(order_base_2(cpus_per_node),
+			      ilog2(TMIGR_CHILDREN_PER_GROUP));
+
+	/* Calculate the extra levels to connect all nodes */
+	nodelvl =3D DIV_ROUND_UP(order_base_2(nnodes),
+			       ilog2(TMIGR_CHILDREN_PER_GROUP));
+
+	tmigr_hierarchy_levels =3D cpulvl + nodelvl;
+
+	/*
+	 * If a NUMA node spawns more than one CPU level group then the next
+	 * level(s) of the hierarchy contains groups which handle all CPU groups
+	 * of the same NUMA node. The level above goes across NUMA nodes. Store
+	 * this information for the setup code to decide in which level node
+	 * matching is no longer required.
+	 */
+	tmigr_crossnode_level =3D cpulvl;
+
+	tmigr_level_list =3D kcalloc(tmigr_hierarchy_levels, sizeof(struct list_hea=
d), GFP_KERNEL);
+	if (!tmigr_level_list)
+		goto err;
+
+	for (i =3D 0; i < tmigr_hierarchy_levels; i++)
+		INIT_LIST_HEAD(&tmigr_level_list[i]);
+
+	pr_info("Timer migration: %d hierarchy levels; %d children per group;"
+		" %d crossnode level\n",
+		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
+		tmigr_crossnode_level);
+
+	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+				tmigr_cpu_online, tmigr_cpu_offline);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	pr_err("Timer migration setup failed\n");
+	return ret;
+}
+late_initcall(tmigr_init);
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
new file mode 100644
index 000000000000..6c37d94a37d9
--- /dev/null
+++ b/kernel/time/timer_migration.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KERNEL_TIME_MIGRATION_H
+#define _KERNEL_TIME_MIGRATION_H
+
+/* Per group capacity. Must be a power of 2! */
+#define TMIGR_CHILDREN_PER_GROUP 8
+
+/**
+ * struct tmigr_event - a timer event associated to a CPU
+ * @nextevt:	The node to enqueue an event in the parent group queue
+ * @cpu:	The CPU to which this event belongs
+ * @ignore:	Hint whether the event could be ignored; it is set when
+ *		CPU or group is active;
+ */
+struct tmigr_event {
+	struct timerqueue_node	nextevt;
+	unsigned int		cpu;
+	bool			ignore;
+};
+
+/**
+ * struct tmigr_group - timer migration hierarchy group
+ * @lock:		Lock protecting the event information and group hierarchy
+ *			information during setup
+ * @parent:		Pointer to the parent group
+ * @groupevt:		Next event of the group which is only used when the
+ *			group is !active. The group event is then queued into
+ *			the parent timer queue.
+ *			Ignore bit of @groupevt is set when the group is active.
+ * @next_expiry:	Base monotonic expiry time of the next event of the
+ *			group; It is used for the racy lockless check whether a
+ *			remote expiry is required; it is always reliable
+ * @events:		Timer queue for child events queued in the group
+ * @migr_state:		State of the group (see union tmigr_state)
+ * @level:		Hierarchy level of the group; Required during setup
+ * @numa_node:		Required for setup only to make sure CPU and low level
+ *			group information is NUMA local. It is set to NUMA node
+ *			as long as the group level is per NUMA node (level <
+ *			tmigr_crossnode_level); otherwise it is set to
+ *			NUMA_NO_NODE
+ * @num_children:	Counter of group children to make sure the group is only
+ *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
+ *			only
+ * @childmask:		childmask of the group in the parent group; is set
+ *			during setup and will never change; can be read
+ *			lockless
+ * @list:		List head that is added to the per level
+ *			tmigr_level_list; is required during setup when a
+ *			new group needs to be connected to the existing
+ *			hierarchy groups
+ */
+struct tmigr_group {
+	raw_spinlock_t		lock;
+	struct tmigr_group	*parent;
+	struct tmigr_event	groupevt;
+	u64			next_expiry;
+	struct timerqueue_head	events;
+	atomic_t		migr_state;
+	unsigned int		level;
+	int			numa_node;
+	unsigned int		num_children;
+	u8			childmask;
+	struct list_head	list;
+};
+
+/**
+ * struct tmigr_cpu - timer migration per CPU group
+ * @lock:		Lock protecting the tmigr_cpu group information
+ * @online:		Indicates whether the CPU is online; In deactivate path
+ *			it is required to know whether the migrator in the top
+ *			level group is to be set offline, while a timer is
+ *			pending. Then another online CPU needs to be notified to
+ *			take over the migrator role. Furthermore the information
+ *			is required in CPU hotplug path as the CPU is able to go
+ *			idle before the timer migration hierarchy hotplug AP is
+ *			reached. During this phase, the CPU has to handle the
+ *			global timers on its own and must not act as a migrator.
+ * @idle:		Indicates whether the CPU is idle in the timer migration
+ *			hierarchy
+ * @remote:		Is set when timers of the CPU are expired remotely
+ * @tmgroup:		Pointer to the parent group
+ * @childmask:		childmask of tmigr_cpu in the parent group
+ * @wakeup:		Stores the first timer when the timer migration
+ *			hierarchy is completely idle and remote expiry was done;
+ *			is returned to timer code in the idle path and is only
+ *			used in idle path.
+ * @cpuevt:		CPU event which could be enqueued into the parent group
+ */
+struct tmigr_cpu {
+	raw_spinlock_t		lock;
+	bool			online;
+	bool			idle;
+	bool			remote;
+	struct tmigr_group	*tmgroup;
+	u8			childmask;
+	u64			wakeup;
+	struct tmigr_event	cpuevt;
+};
+
+/**
+ * union tmigr_state - state of tmigr_group
+ * @state:	Combined version of the state - only used for atomic
+ *		read/cmpxchg function
+ * @struct:	Split version of the state - only use the struct members to
+ *		update information to stay independent of endianness
+ */
+union tmigr_state {
+	u32 state;
+	/**
+	 * struct - split state of tmigr_group
+	 * @active:	Contains each childmask bit of the active children
+	 * @migrator:	Contains childmask of the child which is migrator
+	 * @seq:	Sequence counter needs to be increased when an update
+	 *		to the tmigr_state is done. It prevents a race when
+	 *		updates in the child groups are propagated in changed
+	 *		order. Detailed information about the scenario is
+	 *		given in the documentation at the begin of
+	 *		timer_migration.c.
+	 */
+	struct {
+		u8	active;
+		u8	migrator;
+		u16	seq;
+	} __packed;
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void tmigr_handle_remote(void);
+extern bool tmigr_requires_handle_remote(void);
+extern void tmigr_cpu_activate(void);
+extern u64 tmigr_cpu_deactivate(u64 nextevt);
+extern u64 tmigr_cpu_new_timer(u64 nextevt);
+extern u64 tmigr_quick_check(u64 nextevt);
+#else
+static inline void tmigr_handle_remote(void) { }
+static inline bool tmigr_requires_handle_remote(void) { return false; }
+static inline void tmigr_cpu_activate(void) { }
+#endif
+
+#endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..78eaea2e5d72 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1961,7 +1961,7 @@ static void __queue_delayed_work(int cpu, struct workqu=
eue_struct *wq,
 	if (unlikely(cpu !=3D WORK_CPU_UNBOUND))
 		add_timer_on(timer, cpu);
 	else
-		add_timer(timer);
+		add_timer_global(timer);
 }
=20
 /**
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testin=
g/selftests/rcutorture/bin/torture.sh
index d5a0d8a33c27..bbac5f4b03d0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -567,7 +567,7 @@ then
 	torture_bootargs=3D"rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.dis=
able_onoff_at_boot rcupdate.rcu_task_stall_timeout=3D30000 tsc=3Dwatchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh=
 --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE=
_WATCHDOG=3Dy" --trust-make
=20
-	torture_bootargs=3D"rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.dis=
able_onoff_at_boot rcupdate.rcu_task_stall_timeout=3D30000 clocksource.max_cs=
wd_read_retries=3D1 tsc=3Dwatchdog"
+	torture_bootargs=3D"rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.dis=
able_onoff_at_boot rcupdate.rcu_task_stall_timeout=3D30000 tsc=3Dwatchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh=
 --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE=
_WATCHDOG=3Dy" --trust-make
=20
 	# In case our work is already done...


