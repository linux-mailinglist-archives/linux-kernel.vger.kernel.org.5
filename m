Return-Path: <linux-kernel+bounces-10434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00981D454
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AF91C20F29
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC83D536;
	Sat, 23 Dec 2023 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhQueJ9B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61310D50F;
	Sat, 23 Dec 2023 13:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78228C433C7;
	Sat, 23 Dec 2023 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703339751;
	bh=0mLuBLrBHAiW0ELmlviQtOxKG1lFb2q4zh910zddwv8=;
	h=Date:From:To:Cc:Subject:From;
	b=lhQueJ9BdTUXSG7DigPOrwmFPUKbPB8cDoUHtbdp5z3XUanUDAMjqa22Bih/RSzYZ
	 C5RoFUPjHHc2egs9+xUeL9Du8CPh6tADT9xjn4B8WUjZqdiUsCy+ydy8NDpGuKEGAN
	 zl9ph4FuqQeiUKFx6O+y4/uhOT2nr2SHHKPiJymM2VTPE3FVRzXI2KYJbit6a7VFDx
	 z+utsJo90Zn6oSf+D8lKxnCNixJWRWuEHIx/riZrlqxDVWoZOoOPvWW9jdEy431uU8
	 Ucr7/zlxu1dzL5amfmA7iGdNcdq7cEAVWT3MGNGn8z+ebXRbP6055nA9T3KCzndYR7
	 wSlzZKa1JBj8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3D48C403EF; Sat, 23 Dec 2023 10:55:48 -0300 (-03)
Date: Sat, 23 Dec 2023 10:55:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf test hybrid failing on 14700K
Message-ID: <ZYbm5L7tw7bdpDpE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

Hi Kan,

I noticed the following problem, are you able to reproduce it?

Happy solstice!

- Arnaldo

root@number:/home/acme/Downloads# grep "model name" -m1 /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-14700K
root@number:/home/acme/Downloads# uname -a
Linux number 6.6.4-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  3 18:13:11 UTC 2023 x86_64 GNU/Linux
root@number:/home/acme/Downloads# perf -vv
perf version 6.7.rc6.g63daba4e2861
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
root@number:/home/acme/Downloads# perf test 75
 75: x86 hybrid                                                      : FAILED!
root@number:/home/acme/Downloads# perf test -v 75
 75: x86 hybrid                                                      :
--- start ---
test child forked, pid 4111587
Using CPUID GenuineIntel-6-B7-1
running test 0 'cpu_core/cpu-cycles/'
FAILED arch/x86/tests/hybrid.c:30 wrong type
Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
FAILED arch/x86/tests/hybrid.c:42 wrong type
Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
FAILED arch/x86/tests/hybrid.c:65 wrong type
Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
FAILED arch/x86/tests/hybrid.c:78 wrong type
Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
FAILED arch/x86/tests/hybrid.c:95 wrong type
Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
running test 6 'cpu_core/r1a/'
running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
running test 8 'cpu_core/LLC-loads/'
test child finished with -1
---- end ----
x86 hybrid: FAILED!
root@number:/home/acme/Downloads#

root@number:/home/acme/Downloads# perf trace -e perf_event_open perf test -F -v 75
 75: x86 hybrid                                                      :
--- start ---
Using CPUID GenuineIntel-6-B7-1
running test 0 'cpu_core/cpu-cycles/'
FAILED arch/x86/tests/hybrid.c:30 wrong type
Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
FAILED arch/x86/tests/hybrid.c:42 wrong type
Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
FAILED arch/x86/tests/hybrid.c:65 wrong type
Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
FAILED arch/x86/tests/hybrid.c:78 wrong type
Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
FAILED arch/x86/tests/hybrid.c:95 wrong type
Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
running test 6 'cpu_core/r1a/'
running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
running test 8 'cpu_core/LLC-loads/'
---- end ----
x86 hybrid: FAILED!
     0.000 ( 0.008 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0xa00000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925535355, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
     0.010 ( 0.002 ms): :4115165/4115165 perf_event_open(attr_uptr: { type: 0 (PERF_TYPE_HARDWARE), config: 0x400000000, disabled: 1, { bp_len, config2 }: 0x900000000, branch_sample_type: USER|COUNTERS, sample_regs_user: 0x3ecaddffffffff, sample_stack_user: 4115165, clockid: 925538919, sample_regs_intr: 0x8140c90000a8f7, sample_max_stack: 8, sig_data: 120259084288 }, cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 4
root@number:/home/acme/Downloads# strace -e perf_event_open perf test -F -v 75
 75: x86 hybrid                                                      :
--- start ---
Using CPUID GenuineIntel-6-B7-1
running test 0 'cpu_core/cpu-cycles/'
FAILED arch/x86/tests/hybrid.c:30 wrong type
Event test failure: test 0 'cpu_core/cpu-cycles/'running test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'
FAILED arch/x86/tests/hybrid.c:42 wrong type
Event test failure: test 1 '{cpu_core/cpu-cycles/,cpu_core/instructions/}'running test 2 '{cpu-clock,cpu_core/cpu-cycles/}'
FAILED arch/x86/tests/hybrid.c:65 wrong type
Event test failure: test 2 '{cpu-clock,cpu_core/cpu-cycles/}'running test 3 '{cpu_core/cpu-cycles/,cpu-clock}'
FAILED arch/x86/tests/hybrid.c:78 wrong type
Event test failure: test 3 '{cpu_core/cpu-cycles/,cpu-clock}'running test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'
FAILED arch/x86/tests/hybrid.c:95 wrong type
Event test failure: test 4 '{cpu_core/cpu-cycles/k,cpu_core/instructions/u}'running test 5 'r1a'
running test 6 'cpu_core/r1a/'
running test 7 'cpu_core/config=10,config1,config2=3,period=1000/u'
WARNING: event 'N/A' not valid (bits 0-1 of config2 '3' not supported by kernel)!
running test 8 'cpu_core/LLC-loads/'
perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0xa<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x4<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4
---- end ----
x86 hybrid: FAILED!
+++ exited with 0 +++
root@number:/home/acme/Downloads#

