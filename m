Return-Path: <linux-kernel+bounces-15749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF5823146
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293291F22653
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CD1BDD8;
	Wed,  3 Jan 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIz1C13P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E191BDC5;
	Wed,  3 Jan 2024 16:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E1BC433C8;
	Wed,  3 Jan 2024 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704299315;
	bh=RXlP2qnf/bEUQgIJC4pti3NtKsmNjSF8fVgxjGvsXkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIz1C13PwqwaX1FBqzHPf6Xv5qy+XCfFGOO4n55WRalJxmv5YdX7Djzz0jJIHtO9e
	 bPdUjLX9FfNSwsVgcc7ve1QtPIyBIkSKH+NXubVN5Hw6jlVOOM07NvgMUy4OngpWUd
	 1LsjT5b4ttc9Ktv6gPjEveSNQJfNLe9fX3XZurK250Mge+e2J/Uv83MclCUKLqVC6c
	 OaAkQU2mBhzqA1MEQ/CRMVn/UYQYpdrT9q+PMx6UTdi4nWKlERH1KwxRrWoR4W2DeT
	 EsaBFyBFrEG4MfO1FwnqJb2XqmR7GiWLMlShhSXwIGfHFtpEAfx3H3iYZ/FmEXfBzI
	 QKmP9aLBKxiUQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 98618403EF; Wed,  3 Jan 2024 13:28:32 -0300 (-03)
Date: Wed, 3 Jan 2024 13:28:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test hybrid failing on 14700K
Message-ID: <ZZWLMKr6W8MpOPKT@kernel.org>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 02, 2024 at 02:41:07PM -0800, Ian Rogers escreveu:
> On Tue, Jan 2, 2024 at 7:43 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2023-12-23 8:55 a.m., Arnaldo Carvalho de Melo wrote:
> > > Hi Kan,
> > >
> > > I noticed the following problem, are you able to reproduce it?
> > >
> > > Happy solstice!
> >
> > Happy new year!
> >
> > >
> > > - Arnaldo
> > >
> > > root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
> > > model name    : Intel(R) Core(TM) i7-14700K
> > > root@number:/home/acme/Downloads# uname -a
> > > Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 18:13:11 UTC 2023 x86_64 GNU/Linux
> > > root@number:/home/acme/Downloads# perf -vv
> > > perf version 6.7.rc6.g63daba4e2861
> > >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> > >     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> > >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> > >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> > >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> > >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> > >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> > >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > >                libpfm4: [ on  ]  # HAVE_LIBPFM
> > >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> > >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> > > root@number:/home/acme/Downloads# perf test 75
> > >  75: x86 hybrid                                                      : FAILED!
> >
> > The failure should be a regression caused by the a24d9d9dc096 ("perf
> > parse-events: Make legacy events lower priority than sysfs/JSON")
> >
> > @@ -1004,10 +1012,19 @@ static int config_term_pmu(struct
> > perf_event_attr *attr,
> >                                                            err_str, /*help=*/NULL);
> >                         return -EINVAL;
> >                 }
> > -               attr->type = PERF_TYPE_HARDWARE;
> > -               attr->config = term->val.num;
> > -               if (perf_pmus__supports_extended_type())
> > -                       attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> > +               /*
> > +                * If the PMU has a sysfs or json event prefer it over
> > +                * legacy. ARM requires this.
> > +                */
> > +               if (perf_pmu__have_event(pmu, term->config))
> > For Intel hybrid, the perf_pmu__have_event() should be always true for
> > all hw events and hw cache events. So the patch will mistakenly update
> > the type to TYPE_USER. However, On Intel platforms, the type of the hw
> > events should be TYPE_HARDWARE.
> >
> > Seems ARM needs to find another way to distinguish the case.
> >
> > Ian, any suggestions?
> 
> Hi Kan/Mark,
> 
> Firstly, the perf_pmu__have_event is a test of whether
> /sys/devices/<pmu>/events or the equivalent json events have the
> specified event string like "inst_retired.any" - ie it isn't a test of
> whether the event is supported by the kernel. Mark was quite insistent
> that the behavior be changed so that if a legacy event is specified
> with a PMU, the PMU's sysfs/json event is the priority which is a big
> behavior change on x86.
> 
> To get the test passing again I've sent out a test update:
> https://lore.kernel.org/lkml/20240102215732.1125997-1-irogers@google.com/
> This switches the legacy events in the test to ones which don't have
> sysfs or json equivalents. The test is somewhat brittle as an x86 PMU
> change could decide to add /sys/devices/cpu/events/cycles alongside
> /sys/devices/cpu/events/cpu-cycles. Ideally we'd be testing all events
> on core PMUs, for legacy events they may have a sysfs/json override
> and the test expectation should expect this and assert that the type
> isn't PERF_TYPE_HARDWARE, etc. For now what I sent out is sufficient
> to get the "x86 hybrid" test passing. I should probably have done the
> whole Reported-by.. thing, sorry for missing that.

I can fix that once we're fine with that fix.

- Arnaldo
 
> Thanks,
> Ian
> 
> >
> > +                       term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
> > +                       term->no_value = true;
> > +               } else {
> > +                       attr->type = PERF_TYPE_HARDWARE;
> > +                       attr->config = term->val.num;
> > +                       if (perf_pmus__supports_extended_type())
> > +                               attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> > +               }
> >                 return 0;
> >         }
> >         if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
> >
> >
> > Thanks,
> > Kan
> > > root@number:/home/acme/Downloads# perf test -v 75
> > >  75: x86 hybrid                                                      :
> > > --- start ---
> > > test child forked, pid 4111587
> > > Using CPUID GenuineIntel-6-B7-1
> > > running test 0 'cpu_core/cpu-cycles/'
> > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> > > running test 6 'cpu_core/r1a/'
> > > running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> > > running test 8 'cpu_core/LLC-loads/'
> > > test child finished with -1
> > > ---- end ----
> > > x86 hybrid: FAILED!
> > > root@number:/home/acme/Downloads#
> > >
> > > root@number:/home/acme/Downloads# perf trace -e perf_event_open perf test -F -v 75
> > >  75: x86 hybrid                                                      :
> > > --- start ---
> > > Using CPUID GenuineIntel-6-B7-1
> > > running test 0 'cpu_core/cpu-cycles/'
> > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> > > running test 6 'cpu_core/r1a/'
> > > running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> > > running test 8 'cpu_core/LLC-loads/'
> > > ---- end ----
> > > x86 hybrid: FAILED!
> > >      0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
> > >      0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
> > > root@number:/home/acme/Downloads# strace -e perf_event_open perf test -F -v 75
> > >  75: x86 hybrid                                                      :
> > > --- start ---
> > > Using CPUID GenuineIntel-6-B7-1
> > > running test 0 'cpu_core/cpu-cycles/'
> > > FAILED arch/x86/tests/hybrid.c:30 wrong type
> > > Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
> > > FAILED arch/x86/tests/hybrid.c:42 wrong type
> > > Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
> > > FAILED arch/x86/tests/hybrid.c:65 wrong type
> > > Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
> > > FAILED arch/x86/tests/hybrid.c:78 wrong type
> > > Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
> > > FAILED arch/x86/tests/hybrid.c:95 wrong type
> > > Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
> > > running test 6 'cpu_core/r1a/'
> > > running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
> > > WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
> > > running test 8 'cpu_core/LLC-loads/'
> > > perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
> > > perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4
> > > ---- end ----
> > > x86 hybrid: FAILED!
> > > +++ exited with 0 +++
> > > root@number:/home/acme/Downloads#
> > >

-- 

- Arnaldo

