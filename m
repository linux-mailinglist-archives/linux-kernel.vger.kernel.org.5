Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5DD7DF5A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKBPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKBPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:06:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C07DC;
        Thu,  2 Nov 2023 08:06:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-694ed847889so1042357b3a.2;
        Thu, 02 Nov 2023 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937583; x=1699542383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pttMaal1wm2tTqrIRfxZM8jOCg2TAZ/KoEejO1t6wrA=;
        b=kPSG51P71I6wZQmuwSZY8YxRp9Gn/kSVal+fgu1Uy0L/P4+XhMZW39MWINIEn8HpD+
         6okHj9uXu+YxuSpsHYbxt4YGzhPJ7mT/z82Mulmzl8Llj19Tux2a/9QRquDt7TfIr45w
         GefokXCVsYvV8COHsA3ihMjWf6JGdQa91XLMXkXLASH3Ytyo4vLcN7WeiCnjteZzJsCb
         nAjyxq1vDnBzH2edq5VAWvDJRxsOVwWwwrFyn6aCPp07936HPwGML4TXjInGC9sArigW
         rhElA8wk83r3lGa8xuzwvuLEGs3DJkLggn4q90h3KTxO51Z8JsdiDMx3UCu5/vdiJEPj
         lYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937583; x=1699542383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pttMaal1wm2tTqrIRfxZM8jOCg2TAZ/KoEejO1t6wrA=;
        b=ZR1uv5NPJmtNUuIfpGbXhesaJ0TarCdv4mnrMG1pa2rj5Cw+X/YMlTmxrGFbxZBJSi
         nHgt+INfV98IOIHJoGtrsRnbebibEhwqZrSMhT1GL2FkNuuz0x47+HYUrEdX4hwYseT/
         wqeQsk8tG4GI9+peqty5Mmvma+1ZQGFXW/Uiaie2G+fVXsfWvS01V7zr3LH3E/Oxp3zQ
         WLQCTHcFSpvOy5vcCnOQYyReugkJzdghLim6u5wZeucn8sW2N7DNXrs5FihQxu4VJVBI
         jcRn1L96IVJEZJvKV2JIxo8e1xPfNpTZPdLfJFPZzK7zTMvVOgHdm/gVsZ6j+soQx0Lg
         jjSw==
X-Gm-Message-State: AOJu0YxJlFjCjVseXbiQkxxJaRIGLQiUK945FiYnPomZMwYyuSiNqn5C
        /OLQs9ec69xqYYi/7sXYH2w=
X-Google-Smtp-Source: AGHT+IEsr6/8/qWHRVeVcPnUGFs0Og1m8QQHF3axC9Al4YyMAowkR8tu1gb/vpRkY6GyBC2G1CKTuw==
X-Received: by 2002:a05:6a20:7287:b0:154:d3ac:2063 with SMTP id o7-20020a056a20728700b00154d3ac2063mr18621169pzk.27.1698937582989;
        Thu, 02 Nov 2023 08:06:22 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:d8b2:177c:4f50:5a0d])
        by smtp.gmail.com with ESMTPSA id w68-20020a636247000000b005bd36c0c23fsm603943pgb.37.2023.11.02.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:06:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools changes for v6.7
Date:   Thu,  2 Nov 2023 08:06:19 -0700
Message-ID: <20231102150620.940538-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the latest perf tools changes.

Thanks,
Namhyung

The following changes since commit 4fa008a2db484024a5cb52676a1b1534dc82330c:

  tools build: Fix llvm feature detection, still used by bpftool (2023-10-19 22:33:58 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.7-1-2023-11-01

for you to fetch changes up to fed3a1be6433e15833068c701bfde7b422d8b988:

  Merge tag 'perf-tools-fixes-for-v6.6-2-2023-10-20' into perf-tools-next (2023-10-30 13:46:27 -0700)

----------------------------------------------------------------
perf tools changes for v6.7

Build
-----
* Compile BPF programs by default if clang (>= 12.0.1) is available to
  enable more features like kernel lock contention, off-cpu profiling,
  kwork, sample filtering and so on.  It can be disabled by passing
  BUILD_BPF_SKEL=0 to make.

* Produce better error messages for bison on debug build (make DEBUG=1)
  by defining YYDEBUG symbol internally.

perf record
-----------
* Track sideband events (like FORK/MMAP) from all CPUs even if perf record
  targets a subset of CPUs only (using -C option).  Otherwise it may lose
  some information happened on a CPU out of the target list.

* Fix checking raw sched_switch tracepoint argument using system BTF.
  This affects off-cpu profiling which attaches a BPF program to the raw
  tracepoint.

perf lock contention
--------------------
* Add --lock-cgroup option to see contention by cgroups.  This should be
  used with BPF only (using -b option).

    $ sudo perf lock con -ab --lock-cgroup -- sleep 1
     contended   total wait     max wait     avg wait   cgroup

           835     14.06 ms     41.19 us     16.83 us   /system.slice/led.service
            25    122.38 us     13.77 us      4.89 us   /
            44     23.73 us      3.87 us       539 ns   /user.slice/user-657345.slice/session-c4.scope
             1       491 ns       491 ns       491 ns   /system.slice/connectd.service

* Add -G/--cgroup-filter option to see contention only for given cgroups.
  This can be useful when you identified a cgroup in the above command and
  want to investigate more on it.  It also works with other output options
  like -t/--threads and -l/--lock-addr.

    $ sudo perf lock con -ab -G /user.slice/user-657345.slice/session-c4.scope -- sleep 1
     contended   total wait     max wait     avg wait         type   caller

             8     77.11 us     17.98 us      9.64 us     spinlock   futex_wake+0xc8
             2     24.56 us     14.66 us     12.28 us     spinlock   tick_do_update_jiffies64+0x25
             1      4.97 us      4.97 us      4.97 us     spinlock   futex_q_lock+0x2a

* Use per-cpu array for better spinlock tracking.  This is to improve
  performance of the BPF program and to avoid nested contention on a lock
  in the BPF hash map.

* Update callstack check for PowerPC.  To find a representative caller of a
  lock, it needs to look up the call stacks.  It ends the lookup when it sees
  0 in the call stack buffer.  However, PowerPC call stacks can have 0 values
  in the beginning so skip them when it expects valid call stacks after.

perf kwork
----------
* Support 'sched' class (for -k option) so that it can see task scheduling
  event (using sched_switch tracepoint) as well as irq and workqueue items.

* Add perf kwork top subcommand to show more accurate cpu utilization with
  sched class above.  It works both with a recorded data (using perf kwork
  record command) and BPF (using -b option).  Unlike perf top command, it
  does not support interactive mode (yet).

    $ sudo perf kwork top -b -k sched
    Starting trace, Hit <Ctrl+C> to stop and report
    ^C
    Total  : 160702.425 ms, 8 cpus
    %Cpu(s):  36.00% id,   0.00% hi,   0.00% si
    %Cpu0   [||||||||||||||||||              61.66%]
    %Cpu1   [||||||||||||||||||              61.27%]
    %Cpu2   [|||||||||||||||||||             66.40%]
    %Cpu3   [||||||||||||||||||              61.28%]
    %Cpu4   [||||||||||||||||||              61.82%]
    %Cpu5   [|||||||||||||||||||||||         77.41%]
    %Cpu6   [||||||||||||||||||              61.73%]
    %Cpu7   [||||||||||||||||||              63.25%]

          PID     SPID    %CPU           RUNTIME  COMMMAND
      -------------------------------------------------------------
            0        0   38.72       8089.463 ms  [swapper/1]
            0        0   38.71       8084.547 ms  [swapper/3]
            0        0   38.33       8007.532 ms  [swapper/0]
            0        0   38.26       7992.985 ms  [swapper/6]
            0        0   38.17       7971.865 ms  [swapper/4]
            0        0   36.74       7447.765 ms  [swapper/7]
            0        0   33.59       6486.942 ms  [swapper/2]
            0        0   22.58       3771.268 ms  [swapper/5]
         9545     9351    2.48        447.136 ms  sched-messaging
         9574     9351    2.09        418.583 ms  sched-messaging
         9724     9351    2.05        372.407 ms  sched-messaging
         9531     9351    2.01        368.804 ms  sched-messaging
         9512     9351    2.00        362.250 ms  sched-messaging
         9514     9351    1.95        357.767 ms  sched-messaging
         9538     9351    1.86        384.476 ms  sched-messaging
         9712     9351    1.84        386.490 ms  sched-messaging
         9723     9351    1.83        380.021 ms  sched-messaging
         9722     9351    1.82        382.738 ms  sched-messaging
         9517     9351    1.81        354.794 ms  sched-messaging
         9559     9351    1.79        344.305 ms  sched-messaging
         9725     9351    1.77        365.315 ms  sched-messaging
    <SNIP>

* Add hard/soft-irq statistics to perf kwork top.  This will show the
  total CPU utilization with IRQ stats like below:

    $ sudo perf kwork top -b -k sched,irq,softirq
    Starting trace, Hit <Ctrl+C> to stop and report
    ^C
    Total  :  12554.889 ms, 8 cpus
    %Cpu(s):  96.23% id,   0.10% hi,   0.19% si      <---- here
    %Cpu0   [|                                4.60%]
    %Cpu1   [|                                4.59%]
    %Cpu2   [                                 2.73%]
    %Cpu3   [|                                3.81%]
    <SNIP>

perf bench
----------
* Add -G/--cgroups option to perf bench sched pipe.  The pipe bench is
  good to measure context switch overhead.  With this option, it puts
  the reader and writer tasks in separate cgroups to enforce context
  switch between two different cgroups.

  Also it needs to set CPU affinity of the tasks in a CPU to accurately
  measure the impact of cgroup context switches.

    $ sudo perf stat -e context-switches,cgroup-switches -- \
    > taskset -c 0 perf bench sched pipe -l 100000
    # Running 'sched/pipe' benchmark:
    # Executed 100000 pipe operations between two processes

         Total time: 0.307 [sec]

           3.078180 usecs/op
             324867 ops/sec

     Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 100000':

               200,026      context-switches
                    63      cgroup-switches

           0.321637922 seconds time elapsed

  You can see small number of cgroup-switches because both write and read
  tasks are in the same cgroup.

    $ sudo mkdir /sys/fs/cgroup/{AAA,BBB}

    $ sudo perf stat -e context-switches,cgroup-switches -- \
    > taskset -c 0 perf bench sched pipe -l 100000 -G AAA,BBB
    # Running 'sched/pipe' benchmark:
    # Executed 100000 pipe operations between two processes

         Total time: 0.351 [sec]

           3.512990 usecs/op
             284657 ops/sec

     Performance counter stats for 'taskset -c 0 perf bench sched pipe -l 100000 -G AAA,BBB':

               200,020      context-switches
               200,019      cgroup-switches

           0.365034567 seconds time elapsed

  Now context-switches and cgroup-switches are almost same.  And you can
  see the pipe operation took little more.

* Kill child processes when perf bench sched messaging exited abnormally.
  Otherwise it'd leave the child doing unnecessary work.

perf test
---------
* Fix various shellcheck issues on the tests written in shell script.

* Skip tests when condition is not satisfied:
  - object code reading test for non-text section addresses.
  - CoreSight test if cs_etm// event is not available.
  - lock contention test if not enough CPUs.

Event parsing
-------------
* Make PMU alias name loading lazy to reduce the startup time in the
  event parsing code for perf record, stat and others in the general
  case.

* Lazily compute PMU default config.  In the same sense, delay PMU
  initialization until it's really needed to reduce the startup cost.

* Fix event term values that are raw events.  The event specification
  can have several terms including event name.  But sometimes it clashes
  with raw event encoding which starts with 'r' and has hex-digits.

  For example, an event named 'read' should be processed as a normal
  event but it was mis-treated as a raw encoding and caused a failure.

    $ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
    event syntax error: '..nning/event=read/'
                                      \___ parser error
    Run 'perf list' for a list of valid events

     Usage: perf stat [<options>] [<command>]

        -e, --event <event> event selector. use 'perf list' to list available events

Event metrics
-------------
* Add "Compat" regex to match event with multiple identifiers.

* Usual updates for Intel, Power10, Arm telemetry/CMN and AmpereOne.

Misc
----
* Assorted memory leak fixes and footprint reduction.

* Add "bpf_skeletons" to perf version --build-options so that users can
  check whether their perf tools have BPF support easily.

* Fix unaligned access in Intel-PT packet decoder found by undefined-behavior
  sanitizer.

* Avoid frequency mode for the dummy event.  Surprisingly it'd impact
  kernel timer tick handler performance by force iterating all PMU events.

* Update bash shell completion for events and metrics.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Adrian Hunter (6):
      perf intel-pt: Fix async branch flags
      perf tools: Add get_unaligned_leNN()
      perf intel-pt: Simplify intel_pt_get_vmcs()
      perf intel-pt: Use existing definitions of le16_to_cpu() etc
      perf intel-pt: Use get_unaligned_le16() etc
      perf intel-pt: Prefer get_unaligned_le64 to memcpy_le64

Arnaldo Carvalho de Melo (6):
      Merge tag 'perf-tools-fixes-for-v6.6-1-2023-09-25' into perf-tools-next
      perf symbols: Add 'intel_idle_ibrs' to the list of idle symbols
      perf build: Add missing comment about NO_LIBTRACEEVENT=1
      perf build: Address stray '\' before # that is warned about since grep 3.8
      perf python: Fix binding linkage due to rename and move of evsel__increase_rlimit()
      perf build: Disable BPF skeletons if clang version is < 12.0.1

Athira Rajeev (12):
      perf tools: Add includes for detected configs in Makefile.perf
      tests/shell: Fix shellcheck SC1090 to handle the location of sourced files
      tests/shell: Fix shellcheck issues in tests/shell/stat+shadow_stat.sh tetscase
      tests/shell: Fix shellcheck warnings for SC2153 in multiple scripts
      perf test: Fix parse-events tests to skip parametrized events
      tools/perf: Add text_end to "struct dso" to save .text section size
      tools/perf: Add "is_kmod" to struct dso to check if it is kernel module
      tools/perf/tests: Fix object code reading to skip address that falls out of text section
      tools/perf/arch/powerpc: Fix the CPU ID const char* value by adding 0x prefix
      perf tests: Ignore shellcheck warning in lock_contention
      perf tests: Fix shellcheck warning in record_sideband.sh
      perf tests: Fix shellcheck warning in stat_all_metricgroups

Besar Wicaksono (1):
      perf cs-etm: Fix incorrect or missing decoder for raw trace

Changbin Du (1):
      perf: script: fix missing ',' for fields option

Charles Han (1):
      perf vendors events: Remove repeated word in comments

Colin Ian King (4):
      perf kwork: Fix spelling mistake "COMMMAND" -> "COMMAND"
      perf kwork: Fix spelling mistake "Captuer" -> "Capture"
      perf report: Fix spelling mistake "heirachy" -> "hierarchy"
      perf callchain: Fix spelling mistake "statisitcs" -> "statistics"

Ian Rogers (79):
      perf stat: Fix aggr mode initialization
      perf shell completion: Restrict completion of events to events
      perf completion: Support completion of libpfm4 events
      perf shell completion: Support completion of metrics/metricgroups
      perf parse-events: Remove unnecessary __maybe_unused
      perf parse-events: Tidy up str parameter
      perf parse-events: Avoid enum casts
      perf parse-events: Copy fewer term lists
      perf parse-events: Introduce 'struct parse_events_terms'
      perf vendor events intel: Add lunarlake v1.0
      perf vendor events intel: Add emeraldrapids, update sapphirerapids to v1.16
      perf vendor events intel: Fix spelling mistakes
      perf list: Avoid a hardcoded cpu PMU name
      perf list pfm: Retry supported test with exclude_kernel
      perf parse-events: Remove unused header files
      perf parse-events: Make YYDEBUG dependent on doing a debug build
      perf expr: Make YYDEBUG dependent on doing a debug build
      perf pmu: Add YYDEBUG
      perf bpf-filter: Add YYDEBUG
      perf symbol: Avoid an undefined behavior warning
      perf version: Add status of bpf skeletons
      perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
      perf test: Update build test for changed BPF skeleton defaults
      perf test: Ensure EXTRA_TESTS is covered in build test
      perf test: Detect off-cpu support from build options
      perf parse-events: Fix tracepoint name memory leak
      perf evlist: Avoid frequency mode for the dummy event
      perf pmus: Make PMU alias name loading lazy
      perf test: Avoid system wide when not privileged
      perf parse-events: Avoid erange from hex numbers
      perf parse-events: Fix for term values that are raw events
      gen_compile_commands: Allow the line prefix to still be cmd_
      gen_compile_commands: Sort output compile commands by file name
      run-clang-tools: Add pass through checks and and header-filter arguments
      perf bench uprobe: Fix potential use of memory after free
      perf buildid-cache: Fix use of uninitialized value
      perf env: Remove unnecessary NULL tests
      perf jitdump: Avoid memory leak
      perf mem-events: Avoid uninitialized read
      perf dlfilter: Be defensive against potential NULL dereference
      perf hists browser: Reorder variables to reduce padding
      perf hists browser: Avoid potential NULL dereference
      perf svghelper: Avoid memory leak
      perf lock: Fix a memory leak on an error path
      perf parse-events: Fix unlikely memory leak when cloning terms
      tools api: Avoid potential double free
      perf trace-event-info: Avoid passing NULL value to closedir
      perf header: Fix various error path memory leaks
      perf bpf_counter: Fix a few memory leaks
      perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
      perf intel-pt: Move PMU initialization from default config code
      perf arm-spe: Move PMU initialization from default config code
      perf pmu: Const-ify file APIs
      perf pmu: Const-ify perf_pmu__config_terms
      perf pmu-events: Remember the perf_events_map for a PMU
      perf pmu: Lazily compute default config
      perf rwsem: Add debug mode that uses a mutex
      perf machine: Avoid out of bounds LBR memory read
      libperf rc_check: Make implicit enabling work for GCC
      libperf rc_check: Add RC_CHK_EQUAL
      perf hist: Add missing puts to hist__account_cycles
      perf threads: Remove unused dead thread list
      perf offcpu: Add missed btf_free
      perf callchain: Make display use of branch_type_stat const
      perf callchain: Make brtype_stat in callchain_list optional
      perf callchain: Minor layout changes to callchain_list
      perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
      perf vendor events intel: Fix broadwellde tma_info_system_dram_bw_use metric
      perf vendor events intel: Add broadwellde two metrics
      perf vendor events intel: Add tigerlake two metrics
      perf vendor events intel: Update alderlake/alderlake events to v1.23
      perf vendor events intel: Update emeraldrapids to v1.01
      perf vendor events intel: Update a spelling in haswell/haswellx
      perf vendor events intel: Add typo fix for ivybridge FP
      perf vendor events intel: Update knightslanding events to v16
      perf vendor events intel: Update meteorlake events to v1.06
      perf vendor events intel: Update westmereex events to v4
      perf vendor events intel: Update bonnell version number to v5
      perf vendor events intel: Update tsx_cycles_per_elision metrics

Ilkka Koskinen (1):
      perf vendor events arm64: Fix for AmpereOne metrics

James Clark (10):
      perf test: Check result of has_event(cycles) test
      perf jevents: Remove unused keyword
      perf util: Add a function for replacing characters in a string
      perf test: Add a test for strcmp_cpuid_str() expression
      perf vendor events arm64: Update V1 events using Arm telemetry repo
      perf vendor events arm64: Add V1 metrics using Arm telemetry repo
      perf pmu: Move pmu__find_core_pmu() to pmus.c
      perf pmus: Simplify perf_pmus__find_core_pmu()
      perf pmu: Remove unused function
      perf tests: test_arm_coresight: Simplify source iteration

Jiapeng Chong (1):
      perf machine: Use true and false for bool variable

Jing Zhang (7):
      perf pmu: "Compat" supports regular expression matching identifiers
      perf metric: "Compat" supports regular expression matching identifiers
      perf jevents: Support EventidCode and NodeType
      perf test: Make matching_pmu effective
      perf test: Add pmu-event test for "Compat" and new event_field.
      perf jevents: Add support for Arm CMN PMU aliasing
      perf vendor events: Add JSON metrics for Arm CMN

Jiri Olsa (2):
      tools/build: Fix -s detection code in tools/build/Makefile.build
      tools/build: Fix -s detection code in tools/scripts/Makefile.include

Kajol Jain (5):
      perf vendor events power10: Update JSON/events
      perf vendor events power10: Add extra data-source events
      perf vendor events: Update metric events for power10 platform
      tools/perf: Update call stack check in builtin-lock.c
      perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform

Kuan-Wei Chiu (1):
      perf hisi-ptt: Fix memory leak in lseek failure handling

Leo Yan (2):
      perf cs-etm: Validate timestamp tracing in per-thread mode
      perf cs-etm: Respect timestamp option

Michael Petlan (1):
      perf test: Skip CoreSight tests if cs_etm// event is not available

Namhyung Kim (14):
      perf tools: Add read_all_cgroups() and __cgroup_find()
      perf lock contention: Prepare to handle cgroups
      perf lock contention: Add --lock-cgroup option
      perf lock contention: Add -G/--cgroup-filter option
      perf test shell lock_contention: Add cgroup aggregation and filter tests
      perf annotate: Add more x86 mov instruction cases
      perf record: Fix BTF type checks in the off-cpu profiling
      perf tools: Do not ignore the default vmlinux.h
      perf bench sched pipe: Add -G/--cgroups option
      perf lock contention: Clear lock addr after use
      perf lock contention: Check race in tstamp elem creation
      perf lock contention: Use per-cpu array map for spinlocks
      perf report: Fix hierarchy mode on pipe input
      Merge tag 'perf-tools-fixes-for-v6.6-2-2023-10-20' into perf-tools-next

Ruidong Tian (1):
      perf test: Update cs_etm testcase for Arm ETE

Thomas Richter (1):
      perf trace: Use the right bpf_probe_read(_str) variant for reading user data

Veronika Molnarova (2):
      perf test stat+shadow_stat.sh: Add threshold for rounding errors
      perf test lock_contention.sh: Skip test if not enough CPUs

Xu Yang (1):
      perf jevents: fix no member named 'entries' issue

Yang Jihong (29):
      perf evlist: Add perf_evlist__go_system_wide() helper
      perf evlist: Add evlist__findnew_tracking_event() helper
      perf record: Move setting tracking events before record__init_thread_masks()
      perf record: Track sideband events for all CPUs when tracing selected CPUs
      perf test: Add test case for record sideband events
      perf test: Add perf_event_attr test for record dummy event
      perf kwork: Fix incorrect and missing free atom in work_push_atom()
      perf kwork: Add the supported subcommands to the document
      perf kwork: Set ordered_events to true in 'struct perf_tool'
      perf kwork: Add `kwork` and `src_type` to work_init() for 'struct kwork_class'
      perf kwork: Overwrite original atom in the list when a new atom is pushed.
      perf kwork: Set default events list if not specified in setup_event_list()
      perf kwork: Add sched record support
      perf kwork: Add `root` parameter to work_sort()
      perf kwork top: Introduce new top utility
      perf evsel: Add evsel__intval_common() helper
      perf kwork top: Add statistics on hardirq event support
      perf kwork top: Add statistics on softirq event support
      perf kwork top: Add -C/--cpu -i/--input -n/--name -s/--sort --time options
      perf kwork top: Implements BPF-based cpu usage statistics
      perf kwork top: Add BPF-based statistics on hardirq event support
      perf kwork top: Add BPF-based statistics on softirq event support
      perf test: Fix test-record-dummy-C0 failure for supported PERF_FORMAT_LOST feature kernel
      perf bench messaging: Fix coding style issues for sched-messaging
      perf bench messaging: Factor out create_worker()
      perf bench messaging: Store chlid process pid when creating worker for process mode
      perf bench messaging: Kill child processes when exit abnormally in process mode
      perf data: Increase RLIMIT_NOFILE limit when open too many files in perf_data__create_dir()
      perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile

Yang Li (1):
      perf kwork top: Simplify bool conversion

 scripts/clang-tools/gen_compile_commands.py        |    8 +-
 scripts/clang-tools/run-clang-tools.py             |   32 +-
 tools/build/Makefile.build                         |   10 +-
 tools/include/asm-generic/unaligned.h              |  145 +-
 tools/lib/api/io.h                                 |    1 +
 tools/lib/perf/evlist.c                            |    9 +
 tools/lib/perf/include/internal/evlist.h           |    2 +
 tools/lib/perf/include/internal/rc_check.h         |   13 +-
 tools/perf/Documentation/perf-bench.txt            |   19 +
 tools/perf/Documentation/perf-kwork.txt            |   38 +-
 tools/perf/Documentation/perf-lock.txt             |    7 +
 tools/perf/Documentation/perf-record.txt           |    3 +
 tools/perf/Makefile.config                         |   85 +-
 tools/perf/Makefile.perf                           |   18 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   35 +-
 tools/perf/arch/arm/util/pmu.c                     |   10 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   48 +-
 tools/perf/arch/arm64/util/pmu.c                   |   20 +-
 tools/perf/arch/powerpc/util/header.c              |    2 +-
 tools/perf/arch/s390/util/pmu.c                    |    3 +-
 tools/perf/arch/x86/annotate/instructions.c        |    9 +-
 tools/perf/arch/x86/util/intel-pt.c                |   42 +-
 tools/perf/arch/x86/util/pmu.c                     |  145 +-
 tools/perf/bench/sched-messaging.c                 |  102 +-
 tools/perf/bench/sched-pipe.c                      |  132 +-
 tools/perf/bench/uprobe.c                          |    1 +
 tools/perf/builtin-buildid-cache.c                 |    6 +-
 tools/perf/builtin-kwork.c                         |  760 ++-
 tools/perf/builtin-lock.c                          |  117 +-
 tools/perf/builtin-record.c                        |   92 +-
 tools/perf/builtin-report.c                        |   15 +
 tools/perf/builtin-sched.c                         |    2 +-
 tools/perf/builtin-script.c                        |    2 +-
 tools/perf/builtin-stat.c                          |    2 +-
 tools/perf/builtin-version.c                       |    1 +
 tools/perf/check-headers.sh                        |    1 +
 tools/perf/perf-completion.sh                      |   10 +-
 .../arch/arm64/ampere/ampereone/metrics.json       |  418 +-
 .../pmu-events/arch/arm64/arm/cmn/sys/cmn.json     |  266 +
 .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  |   74 +
 .../arch/arm64/arm/neoverse-v1/branch.json         |    8 -
 .../pmu-events/arch/arm64/arm/neoverse-v1/bus.json |   18 +-
 .../arch/arm64/arm/neoverse-v1/cache.json          |  155 -
 .../arch/arm64/arm/neoverse-v1/exception.json      |   45 +-
 .../arch/arm64/arm/neoverse-v1/fp_operation.json   |   10 +
 .../arch/arm64/arm/neoverse-v1/general.json        |   10 +
 .../arch/arm64/arm/neoverse-v1/instruction.json    |  119 -
 .../arch/arm64/arm/neoverse-v1/l1d_cache.json      |   54 +
 .../arch/arm64/arm/neoverse-v1/l1i_cache.json      |   14 +
 .../arch/arm64/arm/neoverse-v1/l2_cache.json       |   50 +
 .../arch/arm64/arm/neoverse-v1/l3_cache.json       |   22 +
 .../arch/arm64/arm/neoverse-v1/ll_cache.json       |   10 +
 .../arch/arm64/arm/neoverse-v1/memory.json         |   21 +-
 .../arch/arm64/arm/neoverse-v1/metrics.json        |  233 +
 .../arch/arm64/arm/neoverse-v1/pipeline.json       |   23 -
 .../arch/arm64/arm/neoverse-v1/retired.json        |   30 +
 .../pmu-events/arch/arm64/arm/neoverse-v1/spe.json |   18 +
 .../arch/arm64/arm/neoverse-v1/spec_operation.json |  110 +
 .../arch/arm64/arm/neoverse-v1/stall.json          |   30 +
 .../pmu-events/arch/arm64/arm/neoverse-v1/sve.json |   30 +
 .../pmu-events/arch/arm64/arm/neoverse-v1/tlb.json |   66 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    2 +-
 tools/perf/pmu-events/arch/nds32/mapfile.csv       |    2 +-
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |    8 +-
 .../arch/powerpc/power10/datasource.json           | 1787 ++++++
 .../pmu-events/arch/powerpc/power10/metrics.json   |  388 ++
 .../pmu-events/arch/powerpc/power10/others.json    |   10 -
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |    2 +-
 .../arch/powerpc/power10/translation.json          |    5 -
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |    8 +
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |    8 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |   42 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |    4 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   22 +-
 .../arch/x86/alderlake/uncore-interconnect.json    |    2 +
 .../arch/x86/alderlaken/adln-metrics.json          |    6 +-
 .../pmu-events/arch/x86/alderlaken/memory.json     |    4 +-
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   16 +
 .../arch/x86/alderlaken/uncore-interconnect.json   |   66 +
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |    2 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |   14 +-
 .../arch/x86/broadwellde/uncore-interconnect.json  |   18 +-
 .../arch/x86/broadwellx/uncore-interconnect.json   |   18 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |    2 +-
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |  888 +++
 .../arch/x86/emeraldrapids/floating-point.json     |  193 +
 .../arch/x86/emeraldrapids/frontend.json           |  389 ++
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |  343 ++
 .../pmu-events/arch/x86/emeraldrapids/other.json   |  315 +
 .../arch/x86/emeraldrapids/pipeline.json           |  975 +++
 .../arch/x86/emeraldrapids/uncore-cache.json       | 5988 +++++++++++++++++++
 .../arch/x86/emeraldrapids/uncore-cxl.json         |  450 ++
 .../x86/emeraldrapids/uncore-interconnect.json     | 6199 ++++++++++++++++++++
 .../arch/x86/emeraldrapids/uncore-io.json          | 3587 +++++++++++
 .../arch/x86/emeraldrapids/uncore-memory.json      | 3308 +++++++++++
 .../arch/x86/emeraldrapids/uncore-power.json       |  197 +
 .../arch/x86/emeraldrapids/virtual-memory.json     |  165 +
 .../arch/x86/haswellx/uncore-interconnect.json     |   18 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |    2 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |    2 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |    8 +-
 .../arch/x86/ivybridge/floating-point.json         |    2 +-
 .../pmu-events/arch/x86/ivybridge/frontend.json    |   18 +-
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |    4 +-
 .../arch/x86/ivytown/uncore-interconnect.json      |   20 +-
 .../arch/x86/jaketown/uncore-interconnect.json     |   18 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |   39 +-
 .../arch/x86/knightslanding/floating-point.json    |    8 +-
 .../arch/x86/knightslanding/pipeline.json          |   55 +-
 .../arch/x86/knightslanding/uncore-cache.json      |   26 +-
 .../arch/x86/knightslanding/virtual-memory.json    |    2 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |  219 +
 .../pmu-events/arch/x86/lunarlake/frontend.json    |   27 +
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |  183 +
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |   62 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |  217 +
 .../arch/x86/lunarlake/virtual-memory.json         |   56 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   38 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   30 +
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   29 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   37 +
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   40 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   68 +-
 .../arch/x86/meteorlake/uncore-other.json          |    9 +
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  |    2 +-
 .../arch/x86/nehalemep/floating-point.json         |    2 +-
 .../perf/pmu-events/arch/x86/nehalemex/cache.json  |    2 +-
 .../arch/x86/nehalemex/floating-point.json         |    2 +-
 .../arch/x86/rocketlake/rkl-metrics.json           |    2 +-
 .../arch/x86/sapphirerapids/frontend.json          |   39 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |    7 -
 .../arch/x86/sapphirerapids/uncore-cache.json      |   20 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |    2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    2 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   14 +-
 .../arch/x86/westmereep-dp/floating-point.json     |    2 +-
 .../pmu-events/arch/x86/westmereep-sp/cache.json   |    2 +-
 .../arch/x86/westmereep-sp/floating-point.json     |    2 +-
 .../perf/pmu-events/arch/x86/westmereex/cache.json |    2 +-
 .../arch/x86/westmereex/floating-point.json        |    2 +-
 .../pmu-events/arch/x86/westmereex/pipeline.json   |    2 +-
 tools/perf/pmu-events/empty-pmu-events.c           |    8 +
 tools/perf/pmu-events/jevents.py                   |  124 +-
 tools/perf/pmu-events/metric.py                    |    3 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/attr/system-wide-dummy            |   14 +-
 tools/perf/tests/attr/test-record-C0               |    4 +-
 tools/perf/tests/attr/test-record-dummy-C0         |   55 +
 tools/perf/tests/builtin-test.c                    |    1 +
 tools/perf/tests/code-reading.c                    |   10 +
 tools/perf/tests/expr.c                            |   33 +-
 tools/perf/tests/hists_link.c                      |    4 +-
 tools/perf/tests/make                              |    7 +-
 tools/perf/tests/parse-events.c                    |   51 +-
 tools/perf/tests/pmu-events.c                      |   65 +-
 tools/perf/tests/pmu.c                             |   23 +-
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |    4 +
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |    4 +
 .../shell/coresight/thread_loop_check_tid_10.sh    |    4 +
 .../shell/coresight/thread_loop_check_tid_2.sh     |    4 +
 .../tests/shell/coresight/unroll_loop_thread_10.sh |    4 +
 tools/perf/tests/shell/lib/coresight.sh            |    2 +
 tools/perf/tests/shell/lock_contention.sh          |   52 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |    2 +
 .../tests/shell/record+probe_libc_inet_pton.sh     |    2 +
 .../tests/shell/record+script_probe_vfs_getname.sh |    2 +
 tools/perf/tests/shell/record.sh                   |    1 +
 tools/perf/tests/shell/record_offcpu.sh            |    2 +-
 tools/perf/tests/shell/record_sideband.sh          |   58 +
 tools/perf/tests/shell/stat+csv_output.sh          |    1 +
 tools/perf/tests/shell/stat+csv_summary.sh         |    4 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |   34 +-
 tools/perf/tests/shell/stat+std_output.sh          |    1 +
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   16 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    4 +-
 tools/perf/tests/shell/test_intel_pt.sh            |    1 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    1 +
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/tests/thread-maps-share.c               |    9 +-
 tools/perf/tests/util.c                            |   31 +
 tools/perf/ui/browsers/hists.c                     |    6 +-
 tools/perf/util/Build                              |    2 +
 tools/perf/util/arm-spe.h                          |    4 +-
 tools/perf/util/bpf-filter.y                       |    4 +
 tools/perf/util/bpf_counter.c                      |    5 +-
 tools/perf/util/bpf_kwork_top.c                    |  308 +
 tools/perf/util/bpf_lock_contention.c              |   51 +-
 tools/perf/util/bpf_off_cpu.c                      |   13 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |   16 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c           |  338 ++
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |  145 +-
 tools/perf/util/bpf_skel/lock_data.h               |    3 +-
 tools/perf/util/bpf_skel/vmlinux/.gitignore        |    1 +
 tools/perf/util/branch.c                           |    4 +-
 tools/perf/util/branch.h                           |    4 +-
 tools/perf/util/callchain.c                        |   76 +-
 tools/perf/util/callchain.h                        |   18 +-
 tools/perf/util/cgroup.c                           |   63 +-
 tools/perf/util/cgroup.h                           |    5 +
 tools/perf/util/cs-etm.c                           |  106 +-
 tools/perf/util/cs-etm.h                           |    2 +-
 tools/perf/util/data.c                             |   12 +
 tools/perf/util/dlfilter.c                         |    4 +-
 tools/perf/util/dso.c                              |    2 +
 tools/perf/util/dso.h                              |    2 +
 tools/perf/util/env.c                              |    6 +-
 tools/perf/util/evlist.c                           |   23 +-
 tools/perf/util/evlist.h                           |    1 +
 tools/perf/util/evsel.c                            |   43 +-
 tools/perf/util/evsel.h                            |    5 +-
 tools/perf/util/expr.c                             |    2 +-
 tools/perf/util/expr.y                             |    2 +
 tools/perf/util/header.c                           |   60 +-
 tools/perf/util/hisi-ptt.c                         |    4 +-
 tools/perf/util/hist.c                             |   32 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   43 +-
 tools/perf/util/intel-pt.c                         |    2 +
 tools/perf/util/intel-pt.h                         |    3 +-
 tools/perf/util/jitdump.c                          |    1 +
 tools/perf/util/kwork.h                            |   61 +-
 tools/perf/util/lock-contention.h                  |   10 +-
 tools/perf/util/machine.c                          |   37 +-
 tools/perf/util/machine.h                          |    1 -
 tools/perf/util/map_symbol.c                       |   15 +
 tools/perf/util/map_symbol.h                       |    4 +
 tools/perf/util/mem-events.c                       |    3 +-
 tools/perf/util/metricgroup.c                      |    2 +-
 tools/perf/util/parse-events.c                     |  213 +-
 tools/perf/util/parse-events.h                     |   34 +-
 tools/perf/util/parse-events.l                     |    6 +-
 tools/perf/util/parse-events.y                     |   68 +-
 tools/perf/util/pfm.c                              |   15 +-
 tools/perf/util/pmu.c                              |  173 +-
 tools/perf/util/pmu.h                              |   34 +-
 tools/perf/util/pmu.y                              |    4 +
 tools/perf/util/pmus.c                             |   18 +-
 tools/perf/util/print-events.c                     |   28 +-
 tools/perf/util/python-ext-sources                 |    1 +
 tools/perf/util/python.c                           |    2 +-
 tools/perf/util/rlimit.c                           |   28 +
 tools/perf/util/rlimit.h                           |   11 +-
 tools/perf/util/rwsem.c                            |   34 +
 tools/perf/util/rwsem.h                            |   11 +
 tools/perf/util/sort.c                             |    2 +-
 tools/perf/util/string.c                           |   48 +
 tools/perf/util/string2.h                          |    1 +
 tools/perf/util/svghelper.c                        |    5 +-
 tools/perf/util/symbol-elf.c                       |    4 +-
 tools/perf/util/symbol.c                           |   15 +-
 tools/perf/util/trace-event-info.c                 |    3 +-
 tools/scripts/Makefile.include                     |   10 +-
 251 files changed, 31705 insertions(+), 1821 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/general.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/datasource.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/uncore-other.json
 create mode 100644 tools/perf/tests/attr/test-record-dummy-C0
 create mode 100755 tools/perf/tests/shell/record_sideband.sh
 create mode 100644 tools/perf/tests/util.c
 create mode 100644 tools/perf/util/bpf_kwork_top.c
 create mode 100644 tools/perf/util/bpf_skel/kwork_top.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/vmlinux/.gitignore
 create mode 100644 tools/perf/util/map_symbol.c
