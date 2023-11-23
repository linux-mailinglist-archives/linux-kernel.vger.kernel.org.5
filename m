Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2B7F645C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjKWQsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:48:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2F2C98;
        Thu, 23 Nov 2023 08:48:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC1B712FC;
        Thu, 23 Nov 2023 08:49:10 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B3353F7A6;
        Thu, 23 Nov 2023 08:48:23 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:48:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZV9gThJ52slPHqlV@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fW8exsmUg_9K09Oy6T4ZAvvD7ZbZN2sxODdqisZOR6mUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW8exsmUg_9K09Oy6T4ZAvvD7ZbZN2sxODdqisZOR6mUA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:14:21AM -0800, Ian Rogers wrote:
> On Thu, Nov 23, 2023 at 6:23 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Nov 21, 2023 at 03:24:25PM +0000, Marc Zyngier wrote:
> > > On Tue, 21 Nov 2023 13:40:31 +0000,
> > > Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > [Adding key people on Cc]
> > > >
> > > > On Tue, 21 Nov 2023 12:08:48 +0000,
> > > > Hector Martin <marcan@marcan.st> wrote:
> > > > >
> > > > > Perf broke on all Apple ARM64 systems (tested almost everything), and
> > > > > according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> > > >
> > > > I can confirm that at least on 6.7-rc2, perf is pretty busted on any
> > > > asymmetric ARM platform. It isn't clear what criteria is used to pick
> > > > the PMU, but nothing works anymore.
> > > >
> > > > The saving grace in my case is that Debian still ships a 6.1 perftool
> > > > package, but that's obviously not going to last.
> > > >
> > > > I'm happy to test potential fixes.
> > >
> > > At Mark's request, I've dumped a couple of perf (as of -rc2) runs with
> > > -vvv.  And it is quite entertaining (this is taskset to an 'icestorm'
> > > CPU):
> >
> > Looking at this with fresh(er) eyes, I think there's a userspace bug here,
> > regardless of whether one believes it's correct to convert a named-pmu event to
> > a PERF_TYPE_HARDWARE event directed at that PMU.
> >
> > It looks like the userspace tool is dropping the extended type ID after an
> > initial probe, and requests events with plain PERF_TYPE_HARDWARE (without an
> > extended type ID), which explains why we seem to get events from one PMU only.
> >
> > More detail below...
> >
> > Marc, if you have time, could you run the same commands (on the same kernel)
> > with a perf tool build from v6.4?
> >
> > > <quote>
> > > maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -c 0 ./perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
> > >  apple_firestorm_pmu/cycles/ -e cycles ls
> > > Using CPUID 0x00000000612f0280
> > > Attempt to add: apple_icestorm_pmu/cycles=0/
> > > ..after resolving event: apple_icestorm_pmu/cycles=0/
> > > Opening: unknown-hardware:HG
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   config                           0xb00000000
> > >   disabled                         1
> > > ------------------------------------------------------------
> >
> > Here config[31:0] is 0 (PERF_COUNT_HW_CPU_CYCLES), and config[63:32] is 0xb,
> > which is presumably the PMU ID for the apple_icestorm_pmu.
> >
> > The attr doesn't contain exclude_guest=1, so this will be rejected by the PMU
> > driver due to its mode exclusion requirements.
> >
> > > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > > sys_perf_event_open failed, error -95
> >
> > ... which is what we see here (this is EOPNOTSUPP, which __hw_perf_event_init()
> > in drivers/perf/arm_pmu.c returns when the mode requested mode exclusion
> > options aren't supported).
> >
> > So far, so good...
> >
> > > Attempt to add: apple_firestorm_pmu/cycles=0/
> > > ..after resolving event: apple_firestorm_pmu/cycles=0/
> > > Control descriptor is not initialized
> > > Opening: apple_icestorm_pmu/cycles/
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> >
> > ... but here, the extended type ID has been dropped, and this event is no
> > longer directed towards the apple_firestorm_pmu PMU, so the kernel can direct
> > this to *any* CPU PMU...
> >
> > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 3
> >
> > ... and *some* PMU accepts it.
> >
> > > Opening: apple_firestorm_pmu/cycles/
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> >
> > Likewise here, no extended type ID...
> >
> > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4
> > > Opening: cycles
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> >
> > Likewise here, no extended type ID...
> >
> > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 5
> > > arch                  builtin-diff.o      builtin-mem.o        common-cmds.h    perf-completion.sh
> > > bench                 builtin-evlist.c    builtin-probe.c      CREDITS          perf.h
> > > Build                 builtin-evlist.o    builtin-probe.o      design.txt       perf-in.o
> > > builtin-annotate.c    builtin-ftrace.c    builtin-record.c     dlfilters        perf-iostat
> > > builtin-annotate.o    builtin-ftrace.o    builtin-record.o     Documentation    perf-iostat.sh
> > > builtin-bench.c               builtin.h           builtin-report.c     FEATURE-DUMP     perf.o
> > > builtin-bench.o               builtin-help.c      builtin-report.o     include          perf-read-vdso.c
> > > builtin-buildid-cache.c  builtin-help.o      builtin-sched.c   jvmti            perf-sys.h
> > > builtin-buildid-cache.o  builtin-inject.c    builtin-script.c  libapi   PERF-VERSION-FILE
> > > builtin-buildid-list.c        builtin-inject.o    builtin-script.o     libperf          perf-with-kcore
> > > builtin-buildid-list.o        builtin-kallsyms.c  builtin-stat.c       libsubcmd        pmu-events
> > > builtin-c2c.c         builtin-kallsyms.o  builtin-stat.o       libsymbol        python
> > > builtin-c2c.o         builtin-kmem.c      builtin-timechart.c  Makefile         python_ext_build
> > > builtin-config.c      builtin-kvm.c       builtin-top.c        Makefile.config  scripts
> > > builtin-config.o      builtin-kvm.o       builtin-top.o        Makefile.perf    tests
> > > builtin-daemon.c      builtin-kwork.c     builtin-trace.c      MANIFEST         trace
> > > builtin-daemon.o      builtin-list.c      builtin-version.c    perf             ui
> > > builtin-data.c                builtin-list.o      builtin-version.o    perf-archive     util
> > > builtin-data.o                builtin-lock.c      check-headers.sh     perf-archive.sh
> > > builtin-diff.c                builtin-mem.c       command-list.txt     perf.c
> > > apple_icestorm_pmu/cycles/: -1: 0 873709 0
> > > apple_firestorm_pmu/cycles/: -1: 0 873709 0
> > > cycles: -1: 0 873709 0
> > > apple_icestorm_pmu/cycles/: 0 873709 0
> > > apple_firestorm_pmu/cycles/: 0 873709 0
> > > cycles: 0 873709 0
> > >
> > >  Performance counter stats for 'ls':
> > >
> > >      <not counted>      apple_icestorm_pmu/cycles/                                              (0.00%)
> > >      <not counted>      apple_firestorm_pmu/cycles/                                             (0.00%)
> > >      <not counted>      cycles                                                                  (0.00%)
> > >
> > >        0.000002250 seconds time elapsed
> > >
> > >        0.000000000 seconds user
> > >        0.000000000 seconds sys
> >
> > So it looks like the tool has expanded the requested
> > 'apple_icestorm_pmu/cycles/' event into three cycles events, each opened
> > without an extended type ID.
> >
> > AFAICT, the kernel has done exactly what it has always done for
> > PERF_TYPE_HARDWARE/PERF_COUNT_HW_CPU_CYCLES events: pick the first PMU which
> > said it can handle them.
> >
> > > If I run the same thing on another CPU cluster (firestorm), I get
> > > this:
> > >
> > > <quote>
> > > maz@valley-girl:~/hot-poop/arm-platforms/tools/perf$ sudo taskset -c 2 ./perf stat -vvv -e apple_icestorm_pmu/cycles/ -e
> > >  apple_firestorm_pmu/cycles/ -e cycles ls
> > > Using CPUID 0x00000000612f0280
> > > Attempt to add: apple_icestorm_pmu/cycles=0/
> > > ..after resolving event: apple_icestorm_pmu/cycles=0/
> > > Opening: unknown-hardware:HG
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   config                           0xb00000000
> > >   disabled                         1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > > sys_perf_event_open failed, error -95
> >
> > Again, we see one request with an extended type ID, which fails due to mode exclusion requirements...
> >
> > > Attempt to add: apple_firestorm_pmu/cycles=0/
> > > ..after resolving event: apple_firestorm_pmu/cycles=0/
> > > Control descriptor is not initialized
> > > Opening: apple_icestorm_pmu/cycles/
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 = 3
> > > Opening: apple_firestorm_pmu/cycles/
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 = 4
> > > Opening: cycles
> > > ------------------------------------------------------------
> > > perf_event_attr:
> > >   type                             0 (PERF_TYPE_HARDWARE)
> > >   size                             136
> > >   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >   sample_type                      IDENTIFIER
> > >   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> > >   disabled                         1
> > >   inherit                          1
> > >   enable_on_exec                   1
> > >   exclude_guest                    1
> > > ------------------------------------------------------------
> >
> > ... but all subsequent requests do not have an extended type ID, and the kernel
> > directs these to whichever PMU accepts the event first...
> >
> > > sys_perf_event_open: pid 1045925  cpu -1  group_fd -1  flags 0x8 = 5
> > > arch                  builtin-diff.o      builtin-mem.o        common-cmds.h    perf-completion.sh
> > > bench                 builtin-evlist.c    builtin-probe.c      CREDITS          perf.h
> > > Build                 builtin-evlist.o    builtin-probe.o      design.txt       perf-in.o
> > > builtin-annotate.c    builtin-ftrace.c    builtin-record.c     dlfilters        perf-iostat
> > > builtin-annotate.o    builtin-ftrace.o    builtin-record.o     Documentation    perf-iostat.sh
> > > builtin-bench.c               builtin.h           builtin-report.c     FEATURE-DUMP     perf.o
> > > builtin-bench.o               builtin-help.c      builtin-report.o     include          perf-read-vdso.c
> > > builtin-buildid-cache.c  builtin-help.o      builtin-sched.c   jvmti            perf-sys.h
> > > builtin-buildid-cache.o  builtin-inject.c    builtin-script.c  libapi   PERF-VERSION-FILE
> > > builtin-buildid-list.c        builtin-inject.o    builtin-script.o     libperf          perf-with-kcore
> > > builtin-buildid-list.o        builtin-kallsyms.c  builtin-stat.c       libsubcmd        pmu-events
> > > builtin-c2c.c         builtin-kallsyms.o  builtin-stat.o       libsymbol        python
> > > builtin-c2c.o         builtin-kmem.c      builtin-timechart.c  Makefile         python_ext_build
> > > builtin-config.c      builtin-kvm.c       builtin-top.c        Makefile.config  scripts
> > > builtin-config.o      builtin-kvm.o       builtin-top.o        Makefile.perf    tests
> > > builtin-daemon.c      builtin-kwork.c     builtin-trace.c      MANIFEST         trace
> > > builtin-daemon.o      builtin-list.c      builtin-version.c    perf             ui
> > > builtin-data.c                builtin-list.o      builtin-version.o    perf-archive     util
> > > builtin-data.o                builtin-lock.c      check-headers.sh     perf-archive.sh
> > > builtin-diff.c                builtin-mem.c       command-list.txt     perf.c
> > > apple_icestorm_pmu/cycles/: -1: 1035101 469125 469125
> > > apple_firestorm_pmu/cycles/: -1: 1035035 469125 469125
> > > cycles: -1: 1034653 469125 469125
> > > apple_icestorm_pmu/cycles/: 1035101 469125 469125
> > > apple_firestorm_pmu/cycles/: 1035035 469125 469125
> > > cycles: 1034653 469125 469125
> > >
> > >  Performance counter stats for 'ls':
> > >
> > >          1,035,101      apple_icestorm_pmu/cycles/
> > >          1,035,035      apple_firestorm_pmu/cycles/
> > >          1,034,653      cycles
> > >
> > >        0.000001333 seconds time elapsed
> > >
> > >        0.000000000 seconds user
> > >        0.000000000 seconds sys
> > > </quote>
> >
> > ... and in this case the workload was run on a CPU affine ot that arbitrary
> > PMU, hence we managed to count.
> >
> > So AFAICT, this is a userspace bug, maybe related to the way we probe for
> > supported PMU features?
> 
> Probing PMU features is done by trying to perf_event_open events. For
> extended types it is a cycles event on each core PMU:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n532
> 
> The is_event_supported logic is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/print-events.c?h=perf-tools-next#n232

Ah, so IIUC what's happening is:

1) Userspace tries to detect extended type support, with a cycles event
   directed to one of the CPU PMUs. The attr for this does not have
   exclude_guest set.

2) In the kernel, the core perf code sees the extended hw type id, and directs
   this towards the correct PMU (apple_icestorm_pmu).

3) The PMU driver looks at the attr, sees exclude_guest is not set, and returns
   -EOPNOTSUPP, exactly as it would regardless of whether the extended hw type
   is used.

   Note: this happens to be a difference between x86 PMUs and the apple_* PMUs,
   but this is a legitimate part of the perf ABI, not an arm-specific quirk or
   bug.

4) Userspace receives -EOPNOTSUPP, and so decide the extended hw_type is not
   supported (even though the kernel does support the extended hw type id, and
   the event was rejected for orthogonal reasons).

5) Userspace avoids the extended hw type, but still uses
   PERF_EVENT_TYPE_HARDWARE events for named-pmu events.

Does that sound plausible to you, or have I misunderstood?

From Marc's reply at:

  https://lore.kernel.org/lkml/86edggzfxx.wl-maz@kernel.org/

... with perf built from v6.4, the perf tool can open named pmu events without
issue, and sets exclude_guest in the attr. So it seems like there's a mismatch
between regular opening of events and probing for extended hw type that causes
that to differ.

AFAICT, the kernel is doing the right thing here, but the userspace detection
of extended type id support happens to differ from regular event opening, and
mis-interprets -EOPNOTSUP as "the kernel doesn't support extended type IDs"
rather than "The kernel was able to consume the extended type ID, but the
specific PMU targetted said it doesn't support this attr".

IIUC that means this'll be broken on older kernels (those before the extended
hw type id support was introduced), too?

It sounds like we need to make (4) more robust? I'm not immediately sure how, 
given the rats nest of returns in perf_event_open(), but I'm happy to try to
help with that.

It also seems like (5) is a problem regardless. If the user asks for a named
PMU event on an older kernel (before the extended hw type id was a thing), and
the tool converts that to a plain PERF_EVENT_TYPE_HARDWARE event, it's liable
to be handled by a different PMU than the one the user asked for.

Thanks,
Mark.
