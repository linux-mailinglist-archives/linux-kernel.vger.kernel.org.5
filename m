Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98D7AE1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjIYWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIYWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:37:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BC9C;
        Mon, 25 Sep 2023 15:37:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c451541f23so55883625ad.2;
        Mon, 25 Sep 2023 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695681433; x=1696286233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fF62cHaNi3W2xQovQaO0LA7YiyfWPK2Km9Lc/ai4OE4=;
        b=fhj1FfNXAu0gh1j5+wgQad+kfwU4953Hg2ToMfbXHwk6KVQ2Itbiw/LsfijpjtX5Bn
         VIXtiObV65Se31X/EZHu6e/Cw1iO6jgGneIePj6Fbe6qEF2tFXYCkUIt1+mFxZwQEaIf
         1v8tRWlr+Tdjs8xEuFNvP+GXYE0VCBFtnZPCJV7Tg4fIOO1xc2yM/MVr0fC/7NeZXCKw
         ESQkUSv0w1MrvplTnfDbL6TnPgjHQT7lkBBu5aeAZm/rYsXnzpGWWZylHuyywzvLuxDV
         jz/wGPY2IllQbEmeqaMPDG4cKojTPjALrgDyDxXCUu0TfCt9xNtXB+2bYP87ysnOCZDF
         PMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695681433; x=1696286233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF62cHaNi3W2xQovQaO0LA7YiyfWPK2Km9Lc/ai4OE4=;
        b=V9ERcWztdaIp5uq/exNJCyKiwlpbQY/n5JwRELv35tVkVAuLdd8tAI9UIQ8J6gQmjx
         pBMq6mcTSQVbJtsOMQ8SmPCVsxeUn31wlcPEwesyzgP4GqwlMds7TLUUHEpMQ9saquB0
         KKcpE6NvQwzW5/RWJPnUpa5M6v6c2PwqQBQ/0IyiDBTdjC1MUhbMwyYItUeFZzProCFR
         8z6I1bvlbIOd3X+urAaTWixVI2P5vayrzK/nBvz5gPNQru2x63PGvKJfm5pdzznqgWWU
         NUe63ahYDYifEVhHklw76nCAxI+8DGEBdRBQE3f7RsBy9ZDXsfiRDFSDXt07RUn93mV4
         sCig==
X-Gm-Message-State: AOJu0Yy7qJEgEGxHndjAp7wHQ1nJvpMXcvdFCdP49rEZoqlNhRxEiVRl
        tX596/2jy69YsrxHvWVRP1X3S4D8Fu8=
X-Google-Smtp-Source: AGHT+IFCAvAf82dNC2zmvmOwiC+pb0xApAnQkicM28vVN9AyrPUFe048Op89W5aCwrHW9VS4ZuvO2g==
X-Received: by 2002:a17:902:d48f:b0:1c5:a60c:4ee with SMTP id c15-20020a170902d48f00b001c5a60c04eemr6631418plg.47.1695681432844;
        Mon, 25 Sep 2023 15:37:12 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:5987:ed86:60fe:f24f])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001c61901ed37sm2952104plb.191.2023.09.25.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:37:12 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools fixes for v6.6: 1st batch
Date:   Mon, 25 Sep 2023 15:37:09 -0700
Message-ID: <20230925223709.3417084-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling perf-tools fixes.

Thanks,
Namhyung


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-1-2023-09-25

for you to fetch changes up to e47749f1796d1df39a7eaae95f2784aaa43df57d:

  perf jevent: fix core dump on software events on s390 (2023-09-17 15:51:57 -0700)

----------------------------------------------------------------
perf tools fixes for v6.6: 1st batch

Build:

 - Update header files in the tools/**/include directory to sync with
   the kernel sources as usual.

 - Remove unused bpf-prologue files.  While it's not strictly a fix,
   but the functionality was removed in this cycle so better to get
   rid of the code together.

 - Other minor build fixes.

Misc:

 - Fix uninitialized memory access in PMU parsing code

 - Fix segfaults on software event

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (6):
      perf tools: Update copy of libbpf's hashmap.c
      tools headers UAPI: Sync files changed by new fchmodat2 and map_shadow_stack syscalls with the kernel sources
      tools headers UAPI: Copy seccomp.h to be able to build 'perf bench' in older systems
      perf bench sched-seccomp-notify: Use the tools copy of seccomp.h UAPI
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers

Ian Rogers (4):
      perf bpf-prologue: Remove unused file
      perf trace: Avoid compile error wrt redefining bool
      perf jevents metric: Fix type of strcmp_cpuid_str
      perf pmu: Ensure all alias variables are initialized

Thomas Richter (1):
      perf jevent: fix core dump on software events on s390

 tools/arch/x86/include/asm/msr-index.h             |  12 +
 tools/include/uapi/asm-generic/unistd.h            |   5 +-
 tools/include/uapi/drm/drm.h                       |  84 +++-
 tools/include/uapi/linux/seccomp.h                 | 157 +++++++
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   2 +
 tools/perf/bench/sched-seccomp-notify.c            |   2 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/pmu-events/jevents.py                   |   2 +-
 tools/perf/pmu-events/metric.py                    |   4 +-
 tools/perf/util/bpf-prologue.c                     | 508 ---------------------
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |   2 +
 tools/perf/util/hashmap.h                          |  10 -
 tools/perf/util/pmu.c                              |   2 +-
 16 files changed, 255 insertions(+), 539 deletions(-)
 create mode 100644 tools/include/uapi/linux/seccomp.h
 delete mode 100644 tools/perf/util/bpf-prologue.c

--------------------------------------------------------------
perf test results - we are working on the failure at 105.

  1: vmlinux symtab matches kallsyms                                 : Ok
  2: Detect openat syscall event                                     : Ok
  3: Detect openat syscall event on all cpus                         : Ok
  4: mmap interface tests                                            :
  4.1: Read samples using the mmap interface                         : Ok
  4.2: User space counter reading of instructions                    : Ok
  4.3: User space counter reading of cycles                          : Ok
  5: Test data source output                                         : Ok
  6: Parse event definition strings                                  :
  6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs                          : Ok
  6.3: Parsing of given PMU events from sysfs                        : Ok
  6.4: Parsing of aliased events from sysfs                          : Skip (no aliases in sysfs)
  6.5: Parsing of aliased events                                     : Ok
  6.6: Parsing of terms (event modifiers)                            : Ok
  7: Simple expression parser                                        : Ok
  8: PERF_RECORD_* events & perf_sample fields                       : Ok
  9: Parse perf pmu format                                           : Ok
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok
 11: DSO data read                                                   : Ok
 12: DSO data cache                                                  : Ok
 13: DSO data reopen                                                 : Ok
 14: Roundtrip evsel->name                                           : Ok
 15: Parse sched tracepoints fields                                  : Ok
 16: syscalls:sys_enter_openat event fields                          : Ok
 17: Setup struct perf_event_attr                                    : Ok
 18: Match and link multiple hists                                   : Ok
 19: 'import perf' in python                                         : Ok
 20: Breakpoint overflow signal handler                              : Ok
 21: Breakpoint overflow sampling                                    : Ok
 22: Breakpoint accounting                                           : Ok
 23: Watchpoint                                                      :
 23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
 23.2: Write Only Watchpoint                                         : Ok
 23.3: Read / Write Watchpoint                                       : Ok
 23.4: Modify Watchpoint                                             : Ok
 24: Number of exit events of a simple workload                      : Ok
 25: Software clock events period values                             : Ok
 26: Object code reading                                             : Ok
 27: Sample parsing                                                  : Ok
 28: Use a dummy software event to keep tracking                     : Ok
 29: Parse with no sample_id_all bit set                             : Ok
 30: Filter hist entries                                             : Ok
 31: Lookup mmap thread                                              : Ok
 32: Share thread maps                                               : Ok
 33: Sort output of hist entries                                     : Ok
 34: Cumulate child hist entries                                     : Ok
 35: Track with sched_switch                                         : Ok
 36: Filter fds with revents mask in a fdarray                       : Ok
 37: Add fd to a fdarray, making it autogrow                         : Ok
 38: kmod_path__parse                                                : Ok
 39: Thread map                                                      : Ok
 40: Session topology                                                : Ok
 41: Synthesize thread map                                           : Ok
 42: Remove thread map                                               : Ok
 43: CPU map                                                         :
 43.1: Synthesize cpu map                                            : Ok
 43.2: Print cpu map                                                 : Ok
 43.3: Merge cpu map                                                 : Ok
 43.4: Intersect cpu map                                             : Ok
 43.5: Equal cpu map                                                 : Ok
 44: Synthesize stat config                                          : Ok
 45: Synthesize stat                                                 : Ok
 46: Synthesize stat round                                           : Ok
 47: Synthesize attr update                                          : Ok
 48: Event times                                                     : Ok
 49: Read backward ring buffer                                       : Ok
 50: Probe SDT events                                                : Ok
 51: is_printable_array                                              : Ok
 52: Print bitmap                                                    : Ok
 53: perf hooks                                                      : Ok
 54: unit_number__scnprintf                                          : Ok
 55: mem2node                                                        : Ok
 56: time utils                                                      : Ok
 57: Test jit_write_elf                                              : Ok
 58: Test libpfm4 support                                            :
 58.1: test of individual --pfm-events                               : Ok
 58.2: test groups of --pfm-events                                   : Ok
 59: Test api io                                                     : Ok
 60: maps__merge_in                                                  : Ok
 61: Demangle Java                                                   : Ok
 62: Demangle OCaml                                                  : Ok
 63: Parse and process metrics                                       : Ok
 64: PE file support                                                 : Skip
 65: Event expansion for cgroups                                     : Ok
 66: Convert perf time to TSC                                        :
 66.1: TSC support                                                   : Ok
 66.2: Perf time to TSC                                              : Ok
 67: dlfilter C API                                                  : Ok
 68: Sigtrap                                                         : Ok
 69: Event groups                                                    : Skip
 70: Symbols                                                         : Ok
 71: Test dwarf unwind                                               : Ok
 72: Intel PT                                                        :
 72.1: Intel PT packet decoder                                       : Ok
 72.2: Intel PT hybrid CPU compatibility                             : Skip
 73: x86 bp modify                                                   : Ok
 74: x86 Sample parsing                                              : Ok
 75: AMD IBS via core pmu                                            : Skip
 76: x86 hybrid                                                      : Skip (not hybrid)
 77: build id cache operations                                       : Ok
 78: CoreSight / ASM Pure Loop                                       : Skip
 79: CoreSight / Memcpy 16k 10 Threads                               : Skip
 80: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
 81: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
 82: CoreSight / Unroll Loop Thread 10                               : Skip
 83: daemon operations                                               : Ok
 84: kernel lock contention analysis test                            : Ok
 85: perf pipe recording and injection test                          : Ok
 86: Add vfs_getname probe to get syscall args filenames             : Ok
 87: probe libc's inet_pton & backtrace it with ping                 : Ok
 88: Use vfs_getname probe to get syscall args filenames             : Ok
 89: Zstd perf.data compression/decompression                        : Ok
 90: perf record tests                                               : Ok
 91: perf record sample filtering (by BPF) tests                     : Ok
 92: perf record offcpu profiling tests                              : Ok
 93: perf stat CSV output linter                                     : Ok
 94: perf stat csv summary test                                      : Ok
 95: perf stat JSON output linter                                    : Ok
 96: perf stat metrics (shadow stat) test                            : Ok
 97: perf stat STD output linter                                     : Ok
 98: perf stat tests                                                 : Ok
 99: perf all metricgroups test                                      : Ok
100: perf all metrics test                                           : Ok
101: perf all libpfm4 events test                                    : Ok
102: perf all PMU test                                               : Ok
103: perf stat --bpf-counters test                                   : Ok
104: perf stat --bpf-counters --for-each-cgroup test                 : Ok
105: perf metrics value validation                                   : FAILED!
106: Check Arm64 callgraphs are complete in fp mode                  : Skip
107: Check Arm CoreSight trace data recording and synthesized samples: Skip
108: Check Arm SPE trace data recording and synthesized samples      : Skip
109: Check Arm SPE doesn't hang when there are forks                 : Skip
110: Check branch stack sampling                                     : Ok
111: Test data symbol                                                : Ok
112: Miscellaneous Intel PT testing                                  : Ok
113: Test java symbol                                                : Skip
114: 'perf data convert --to-json' command test                      : Ok
115: perf script task-analyzer tests                                 : Ok
116: test perf probe of function from different CU                   : Ok
117: Check open filename arg using perf trace + vfs_getname          : Ok

