Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3A7DF947
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjKBR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjKBR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE01D1A2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:57:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a9012ab0adso16604387b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947876; x=1699552676; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3/KopTsiGc4Gb6Trzy6FsEwYomaQoIGIEHrZNhHytA=;
        b=UgVaDUypLSOdeX8Ytj/B4XZgfl2sZpin9OuUw3DWLkNixUAtolsFBz7qk+ZCkHBu0+
         ChdyfaGQrkGo5BUhWOI8hb/h9gmVPzD66bxbLbRNadnu1Q5g2JqMxVPGT8ZJjikQjGXJ
         h6+7Bl3lxuMA2cM4HVilLdxEueatagFYT0sOb4pbvc27LaPvE5kCp+m96uXQ0w0U35f+
         Nyv/yR/RKz+RkgUskw1qUd60AMaOWo4TpOkbadmdyAuIvcXHAU/5Vqq1PMbyyIl6wMQC
         C/mJO1aJ9sf1aT10T1lUyhaIFdCgXb0khyb/868GjmXq8T0MKG67f/z2+BT2jSxOGbWR
         t5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947876; x=1699552676;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3/KopTsiGc4Gb6Trzy6FsEwYomaQoIGIEHrZNhHytA=;
        b=Koc+NjLMkLpBxRCINlV5AmfFRAd1GCTI0HqJhCOW6DOcDbYkQChfiXg7Ygb3e/Sac9
         0T6j+yykBdPHqAlNmwOo2n0MSpNVe+uM8tcDU9yziJg9bo5oFfMGkZAo6yS1PCYsKoNl
         jJHJLL/D0cZuFSo3b0ZcQ+vqsK4TkSwOdmkexm6m16f7srVV6xrq/LmGRyUfwNvF0LBt
         Vk+nLBc/M+p4yR19QpcWrpjTwAnP43i6a7dxnIgEkRgm+djJS5aEWps0pFtr34O0n4ed
         W/Vnm8+ln5qsPatimwYmZrAZ71MtPzTekTg5qKW9ALTWz0Jc8qrtjVT8npJt4pETVJvg
         drpQ==
X-Gm-Message-State: AOJu0YwtgD8YnaHRxt/rAoONLT0TNnfODQ2txHos6qqBnbdnO1ExmLGT
        mc1uQJamMQPvqQaqdYhqzmWeB6KvR5Pd
X-Google-Smtp-Source: AGHT+IGcCW1DGNPI/3jOX7OHs4Z58N3u+D+CeRS1puq5fwE/ModxUxQfJxf8lYVw2CMxMr7eb+fBe8lO8+ki
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:4e4e:0:b0:5ad:25fc:b7c9 with SMTP id
 c75-20020a814e4e000000b005ad25fcb7c9mr8739ywb.1.1698947875924; Thu, 02 Nov
 2023 10:57:55 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:42 -0700
Message-Id: <20231102175735.2272696-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 00/53] Improvements to memory use
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
and reference counting issues.

Similar to maps separate out and reimplement threads to use a hashmap
for lower memory consumption and faster look up. The fixes a
regression in memory usage where reference count checking switched to
using non-invasive tree nodes.  Reduce its default size by 32 times
and improve locking discipline. Also, fix regressions where tids had
become unordered to make `perf report --tasks` and
`perf trace --summary` output easier to read.

Better encapsulate the dsos abstraction. Remove the linked list and
rbtree used for faster iteration and log(n) lookup to a sorted array
for similar performance but half the memory usage per dso. Improve
reference counting and locking discipline, adding reference count
checking to dso. Experimented with, but abandoned, a hashmap
implementation due to the need for extra storage and the keys not
being stable.

The overall effect is to reduce memory consumption significantly for
perf top - with call graphs enabled running longer before 1GB of
memory is consumed. For a perf record of 'true', the memory
consumption goes from 39912kb max resident to 20096kb max resident -
nearly halved. perf inject with -b of a system wide perf record of
'true' reduces the max resident by roughly 4.5% (3.4% in v4 due to
branch_type_stat changes being merged). This is while improving
correctness with locking discipline and reference count checking.

Patch organization (v4):
 - 53 patches is a lot, the patches aren't divided as they merge conflict and
   later patches, for example in dsos, rely on the changes and fixes to maps.
 - the dso reference count checking patch is larger due to switch use of dso to
   be by accessors, to encapsulate the reference count checker macros. The
   reference count checking changes within this largely mechanical change amount
   to a few lines and so weren't separated.
 - the first patch contains a build fix if the rwsem error checking is
   enabled missed from v3.
 - the next patches are an assortment of memory size fixes.
 - the next patches are the refactoring of maps.
 - the next patches are the refactoring of threads.
 - the next patches are the refactoring of dsos.
 - finally reference count checking is added to dso and some lock/reference
   count issues are resolved. This is done after changing the data structures,
   for example, as the single pointer on an array is easier to add reference
   count checking to compared to the 5 previous pointers.

v4: Rebased as 11 changes moved to perf-tools-next. Address comments
    from v3 such as error checking on zstd streams. Improve the
    dsos/dso in ways similar to threads and maps, with the addition of
    reference count checking on dso.
v3: Additional memory/speed improvements, in particular for maps and
    threads. Address review comments from namhyung@kernel.org and
    adrian.hunter@intel.com.
v2: Add additional memory fixes on top of initial LBR and rc check
    fixes.

Ian Rogers (53):
  perf comm: Use regular mutex
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
  perf thread: Add missing RC_CHK_EQUAL
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
  perf dsos: Attempt to better abstract dsos internals
  perf dsos: Tidy reference counting and locking
  perf dsos: Add dsos__for_each_dso
  perf dso: Move dso functions out of dsos
  perf dsos: Switch more loops to dsos__for_each_dso
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data
  perf env: Avoid recursively taking env->bpf_progs.lock

 tools/lib/api/Makefile                        |    2 +-
 tools/lib/api/fs/fs.c                         |   74 +-
 tools/lib/api/io.h                            |    9 +-
 tools/lib/api/io_dir.h                        |   75 +
 tools/lib/perf/include/internal/mmap.h        |    2 +-
 tools/lib/perf/mmap.c                         |    9 +
 tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
 tools/perf/arch/x86/util/event.c              |  103 +-
 tools/perf/builtin-annotate.c                 |    6 +-
 tools/perf/builtin-buildid-cache.c            |    2 +-
 tools/perf/builtin-buildid-list.c             |   18 +-
 tools/perf/builtin-inject.c                   |  102 +-
 tools/perf/builtin-kallsyms.c                 |    2 +-
 tools/perf/builtin-mem.c                      |    4 +-
 tools/perf/builtin-record.c                   |   59 +-
 tools/perf/builtin-report.c                   |  250 ++--
 tools/perf/builtin-script.c                   |    8 +-
 tools/perf/builtin-top.c                      |    4 +-
 tools/perf/builtin-trace.c                    |   41 +-
 tools/perf/tests/code-reading.c               |    8 +-
 tools/perf/tests/dso-data.c                   |   63 +-
 tools/perf/tests/hists_common.c               |    6 +-
 tools/perf/tests/hists_cumulate.c             |    4 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/maps.c                       |   64 +-
 tools/perf/tests/symbols.c                    |    2 +-
 tools/perf/tests/thread-maps-share.c          |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  181 +--
 tools/perf/ui/browsers/annotate.c             |    6 +-
 tools/perf/ui/browsers/hists.c                |    8 +-
 tools/perf/ui/browsers/map.c                  |    4 +-
 tools/perf/util/Build                         |    1 +
 tools/perf/util/annotate.c                    |   44 +-
 tools/perf/util/auxtrace.c                    |    2 +-
 tools/perf/util/block-info.c                  |    2 +-
 tools/perf/util/bpf-event.c                   |   20 +-
 tools/perf/util/bpf-event.h                   |   12 +-
 tools/perf/util/bpf_lock_contention.c         |   10 +-
 tools/perf/util/build-id.c                    |  136 +-
 tools/perf/util/build-id.h                    |    2 -
 tools/perf/util/callchain.c                   |    4 +-
 tools/perf/util/comm.c                        |   10 +-
 tools/perf/util/compress.h                    |    6 +-
 tools/perf/util/data-convert-json.c           |    2 +-
 tools/perf/util/db-export.c                   |    6 +-
 tools/perf/util/debug.c                       |   22 +-
 tools/perf/util/debug.h                       |    1 +
 tools/perf/util/dlfilter.c                    |   12 +-
 tools/perf/util/dso.c                         |  468 ++++---
 tools/perf/util/dso.h                         |  544 ++++++--
 tools/perf/util/dsos.c                        |  529 ++++---
 tools/perf/util/dsos.h                        |   40 +-
 tools/perf/util/env.c                         |   53 +-
 tools/perf/util/env.h                         |    4 +
 tools/perf/util/event.c                       |   16 +-
 tools/perf/util/header.c                      |   47 +-
 tools/perf/util/hist.c                        |    4 +-
 tools/perf/util/intel-pt.c                    |   22 +-
 tools/perf/util/machine.c                     |  662 +++------
 tools/perf/util/machine.h                     |   32 +-
 tools/perf/util/map.c                         |   93 +-
 tools/perf/util/map.h                         |   83 +-
 tools/perf/util/maps.c                        | 1239 +++++++++++++----
 tools/perf/util/maps.h                        |   95 +-
 tools/perf/util/mmap.c                        |    5 +-
 tools/perf/util/mmap.h                        |    1 -
 tools/perf/util/pmu.c                         |   48 +-
 tools/perf/util/pmus.c                        |   30 +-
 tools/perf/util/probe-event.c                 |   62 +-
 tools/perf/util/rb_resort.h                   |    5 -
 .../scripting-engines/trace-event-python.c    |   21 +-
 tools/perf/util/session.c                     |   26 +
 tools/perf/util/session.h                     |    2 +
 tools/perf/util/sort.c                        |   19 +-
 tools/perf/util/srcline.c                     |   65 +-
 tools/perf/util/symbol-elf.c                  |  138 +-
 tools/perf/util/symbol.c                      |  521 ++-----
 tools/perf/util/symbol.h                      |    1 -
 tools/perf/util/symbol_conf.h                 |    4 +-
 tools/perf/util/symbol_fprintf.c              |    4 +-
 tools/perf/util/synthetic-events.c            |  156 ++-
 tools/perf/util/thread.c                      |   48 +-
 tools/perf/util/thread.h                      |   20 +-
 tools/perf/util/threads.c                     |  186 +++
 tools/perf/util/threads.h                     |   35 +
 tools/perf/util/unwind-libunwind-local.c      |   50 +-
 tools/perf/util/unwind-libunwind.c            |    9 +-
 tools/perf/util/vdso.c                        |   89 +-
 tools/perf/util/zstd.c                        |   63 +-
 89 files changed, 4129 insertions(+), 2829 deletions(-)
 create mode 100644 tools/lib/api/io_dir.h
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.42.0.869.gea05f2083d-goog

