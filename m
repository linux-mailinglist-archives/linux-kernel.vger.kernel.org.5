Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C957D5E03
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjJXWYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjJXWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:24:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3710CB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so5874520276.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186253; x=1698791053; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I38FMaIe6u2yWP9wYjT1B5atKo4l/NPl7Myu1CFn8/E=;
        b=1nA0wNSbgR+ZA2tLViMaZp9BRU7HYItb7ud7PauGrD4uT3sxrxJxorQhuLCWe5RC4v
         3HPLQm9dj0m8V2mp/ClQR+hxQGgNt+vFWf0yF6ncqo3BDoozJv7J1QinFQ9Lq3rhW1pg
         adG63BaJHq7kEfGDu3G7sHnbIUTQ7CzFjAvkfiAALUgr/3hl9K7yXcHrAqMLngSb99Fv
         VfgWwtzkgKIAdR2fmoWttoUPbUou0ByPy8zwXw9yXyJtLg9842K8/cBDFF2ninL66cV5
         dGOsqdYkpmGd1PA09La+94zQIeIGni8izRT0KN7ksxj/52Vn7GBPoPHtr3eowlTYeaBO
         tZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186253; x=1698791053;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I38FMaIe6u2yWP9wYjT1B5atKo4l/NPl7Myu1CFn8/E=;
        b=uFWb3JJ/gbUYvJj2H32O3GiwKb6SSHgweX18T2S5/cpnETbg0LMC4DRM4h+MdHJxoR
         8Wx3pBjI3BOIFL6EcUkh6BNoBNlcJ0XvcXiduuI4icS45pjGgXMOPYXbaheyZNyL2dds
         pAxKnmyqX3k2f64MGEiW4yMNVnOoOXUuKwAmzmZlpbkI7CLgB4IyQNyOzkDRMShka/ZZ
         Iiw60q1yeTDwX7X3xSwipPczH6JmRUd7IaKKs5HN+QV3nY6abULBh47TxP1rH3c7ITPU
         2w/iboKoQI7qLsAGOjmRzWQMbb+/UBIWAyrgEn70VREjxn9s4XfallCliZO+UBpgWQ15
         kMyg==
X-Gm-Message-State: AOJu0YzoBQ1iudqgbAQoDTfu4XQ2e5eUJyut610KTp7K7ze1/fHMVsUo
        44aGfsYLxh5Ei5y//JVQYeGErBVnXzXj
X-Google-Smtp-Source: AGHT+IGgkkC7YcnUaRJWoIV9eV2kQjGb/YAZt4pcs6pKRmotzW+5m90yVottXy/Eq2A0jvX6uWin1l8kWOGL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:7755:0:b0:d9a:519f:d0e6 with SMTP id
 s82-20020a257755000000b00d9a519fd0e6mr261535ybc.6.1698186252931; Tue, 24 Oct
 2023 15:24:12 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:03 -0700
Message-Id: <20231024222353.3024098-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 00/50] Improvements to memory use
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leaks detected by address/leak sanitizer affecting LBR
call-graphs, perf mem and BPF offcpu.

Make branch_type_stat in callchain_list optional as it is large and
not always necessary - in particular it isn't used by perf top.

Make the allocations of zstd streams, kernel symbols and event copies
lazier in order to save memory in cases like perf record.

Handle the thread exit event and have it remove the thread from the
threads set in machine. Don't do this for perf report as it causes a
regression for task lists, which assume threads are never removed from
the machine's set, and offcpu events, that may sythensize samples for
threads that have exited.

Avoid using 8kb buffers for filename__read_str which is excessive for
reading CPU maps. Add io_dir as an allocation free readdir
replacement, opendir allocating 32kb by default and the code uses it
recursively.

Shrink perf map using a two value byte to replace two function
pointers. Modify the implementation of maps to not use an rbtree as
the container for maps, instead use a sorted array. Improve locking
and reference counting issues. Similarly separate out and reimplement
threads to use a hashmap for lower memory consumption and faster look
up. The fixes a regression in memory usage where reference count
checking switched to using non-invasive tree nodes.

The overall effect is to reduce memory consumption significantly for
perf top - with call graphs enabled running longer before 1GB of
memory is consumed. For a perf record of 'true', the memory
consumption goes from 39912kb max resident to 20820kb max resident -
nearly halved. perf inject with -b of a system wide perf record of
'true' reduces the max resident by roughly 4.5%.

v3: Additional memory/speed improvements, in particular for maps and
    threads. Address review comments from namhyung@kernel.org and
    adrian.hunter@intel.com.
v2: Add additional memory fixes on top of initial LBR and rc check
    fixes.

Ian Rogers (50):
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
  perf record: Lazy load kernel symbols
  libperf: Lazily allocate mmap event copy
  perf mmap: Lazily initialize zstd streams
  perf machine thread: Remove exited threads by default
  tools api fs: Switch filename__read_str to use io.h
  tools api fs: Avoid reading whole file for a 1 byte bool
  tools lib api: Add io_dir an allocation free readdir alternative
  perf maps: Switch modules tree walk to io_dir__readdir
  perf record: Be lazier in allocating lost samples buffer
  perf pmu: Switch to io_dir__readdir
  perf bpf: Don't synthesize BPF events when disabled
  perf header: Switch mem topology to io_dir__readdir
  perf events: Remove scandir in thread synthesis
  perf map: Simplify map_ip/unmap_ip and make map size smaller
  perf maps: Move symbol maps functions to maps.c
  perf thread: Add missing RC_CHK_ACCESS
  perf maps: Add maps__for_each_map to call a function on each entry
  perf maps: Add remove maps function to remove a map based on callback
  perf debug: Expose debug file
  perf maps: Refactor maps__fixup_overlappings
  perf maps: Do simple merge if given map doesn't overlap
  perf maps: Rename clone to copy from
  perf maps: Add maps__load_first
  perf maps: Add find next entry to give entry after the given map
  perf maps: Reduce scope of map_rb_node and maps internals
  perf maps: Fix up overlaps during fixup_end
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps
  perf dso: Reorder variables to save space in struct dso
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/lib/api/Makefile                     |    2 +-
 tools/lib/api/fs/fs.c                      |   74 +-
 tools/lib/api/io.h                         |    9 +-
 tools/lib/api/io_dir.h                     |   72 ++
 tools/lib/perf/include/internal/mmap.h     |    2 +-
 tools/lib/perf/include/internal/rc_check.h |   13 +-
 tools/lib/perf/mmap.c                      |    9 +
 tools/perf/arch/x86/tests/dwarf-unwind.c   |    1 +
 tools/perf/arch/x86/util/event.c           |  103 +-
 tools/perf/builtin-inject.c                |    6 +
 tools/perf/builtin-record.c                |   57 +-
 tools/perf/builtin-report.c                |  246 ++--
 tools/perf/builtin-sched.c                 |    2 +-
 tools/perf/builtin-trace.c                 |   41 +-
 tools/perf/tests/hists_link.c              |    4 +-
 tools/perf/tests/maps.c                    |   64 +-
 tools/perf/tests/thread-maps-share.c       |    9 +-
 tools/perf/tests/vmlinux-kallsyms.c        |  181 +--
 tools/perf/util/Build                      |    2 +
 tools/perf/util/bpf-event.c                |    4 +
 tools/perf/util/bpf_lock_contention.c      |   10 +-
 tools/perf/util/bpf_off_cpu.c              |   10 +-
 tools/perf/util/branch.c                   |    4 +-
 tools/perf/util/branch.h                   |    4 +-
 tools/perf/util/callchain.c                |   76 +-
 tools/perf/util/callchain.h                |   18 +-
 tools/perf/util/compress.h                 |    6 +-
 tools/perf/util/debug.c                    |   22 +-
 tools/perf/util/debug.h                    |    1 +
 tools/perf/util/dso.h                      |   84 +-
 tools/perf/util/event.c                    |    8 +-
 tools/perf/util/header.c                   |   31 +-
 tools/perf/util/hist.c                     |   32 +-
 tools/perf/util/machine.c                  |  501 +++-----
 tools/perf/util/machine.h                  |   31 +-
 tools/perf/util/map.c                      |   21 +-
 tools/perf/util/map.h                      |   83 +-
 tools/perf/util/map_symbol.c               |   15 +
 tools/perf/util/map_symbol.h               |    4 +
 tools/perf/util/maps.c                     | 1239 +++++++++++++++-----
 tools/perf/util/maps.h                     |   95 +-
 tools/perf/util/mmap.c                     |    5 +-
 tools/perf/util/mmap.h                     |    1 -
 tools/perf/util/pmu.c                      |   48 +-
 tools/perf/util/pmus.c                     |   30 +-
 tools/perf/util/probe-event.c              |   41 +-
 tools/perf/util/rb_resort.h                |    5 -
 tools/perf/util/rwsem.c                    |   34 +
 tools/perf/util/rwsem.h                    |   11 +
 tools/perf/util/session.c                  |    5 +
 tools/perf/util/sort.c                     |    2 +-
 tools/perf/util/symbol-elf.c               |   10 +-
 tools/perf/util/symbol.c                   |  346 +-----
 tools/perf/util/symbol.h                   |    1 -
 tools/perf/util/symbol_conf.h              |    4 +-
 tools/perf/util/synthetic-events.c         |  140 ++-
 tools/perf/util/thread.c                   |   44 +-
 tools/perf/util/thread.h                   |   20 +-
 tools/perf/util/threads.c                  |  186 +++
 tools/perf/util/threads.h                  |   35 +
 tools/perf/util/unwind-libunwind-local.c   |   36 +-
 tools/perf/util/unwind-libunwind.c         |    7 +-
 tools/perf/util/vdso.c                     |   35 +-
 tools/perf/util/zstd.c                     |   63 +-
 64 files changed, 2549 insertions(+), 1756 deletions(-)
 create mode 100644 tools/lib/api/io_dir.h
 create mode 100644 tools/perf/util/map_symbol.c
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.42.0.758.gaed0368e0e-goog

