Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DAD7F3310
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjKUQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKUQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:03:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D102139;
        Tue, 21 Nov 2023 08:02:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF964FEC;
        Tue, 21 Nov 2023 08:03:45 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1173F6C4;
        Tue, 21 Nov 2023 08:02:57 -0800 (PST)
Date:   Tue, 21 Nov 2023 16:02:55 +0000
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
Message-ID: <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <86pm03z0kw.wl-maz@kernel.org>
 <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 07:46:57AM -0800, Ian Rogers wrote:
> On Tue, Nov 21, 2023 at 7:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
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
> > IIUC the tool is doing the wrong thing here and overriding explicit
> > ${pmu}/${event}/ events with PERF_TYPE_HARDWARE events rather than events using
> > that ${pmu}'s type and event namespace.
> >
> > Regardless of the *new* ABI that allows PERF_TYPE_HARDWARE events to be
> > targetted to a specific PMU, it's semantically wrong to rewrite events like
> > this since ${pmu}/${event}/ is not necessarily equivalent to a similarly-named
> > PERF_COUNT_HW_${EVENT}.
> 
> If you name a PMU and an event then the event should only be opened on
> that PMU, 100% agree. There's a bunch of output, but when the legacy
> cycles event is opened it appears to be because it was explicitly
> requested.

I think you've missed that the named PMU events are being erreously transformed
into PERF_TYPE_HARDWARE events. Look at the -vvv output, e.g.

  Opening: apple_firestorm_pmu/cycles/
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 4

... which should not be PERF_TYPE_HARDWARE && PERF_COUNT_HW_CPU_CYCLES.

Marc said that he bisected the issue down to commit:

  5ea8f2ccffb23983 ("perf parse-events: Support hardware events as terms")

... so it looks like something is going wrong when the events are being parsed,
e.g. losing the HW PMU information?

Thanks,
Mark.

>
> 
> Thanks,
> Ian
> 
> > Mark.
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
> > > sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> > > sys_perf_event_open failed, error -95
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
> > > sys_perf_event_open: pid 1045843  cpu -1  group_fd -1  flags 0x8 = 3
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
> > > </quote>
> > >
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
> > >
> > > which doesn't make any sense either. I really don't understand what
> > > this PERF_TYPE_HARDWARE does here (the *real* types are 10 and 11),
> > > nor what this 'cycle=0' stuff is.
> > >
> > > /puzzled
> > >
> > >       M.
> > >
> > > --
> > > Without deviation from the norm, progress is not possible.
