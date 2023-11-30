Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E117FE5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbjK3BQZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:16:23 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69324D6C;
        Wed, 29 Nov 2023 17:16:28 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-285a64dcf3eso449732a91.1;
        Wed, 29 Nov 2023 17:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701306988; x=1701911788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AADdL8GMm04lsgkg52eJIhzZN8O2OMoPtzpBU/xKlHM=;
        b=bRghdlbnFDkkbK504Z6YFX0w8w+cwIVpymSz3lLtiL7U3BXnrwc/r/uIsXK0CMAaaN
         3D9xGPHN2/ZPE21jQtnX3SXiSoW0XH/6oVi8+AXx1lhZvIVpqsXd3nHLfbnL6I7Hdgzq
         n0Qy35vJDbmxeX0xoTw4Nh46chOnGnZLty9q2uaSUo9ZToEr7anjrWeA9uRjSYkTRZdi
         stLNnsRONVJnZ9Xth7Bosp4zzKqV7LAei3fAD6vCEa+t28+a6spp0m71w337NikdW7iI
         n0PclYH0CLBuFcMI+A0alwfFKKOzUkvRJuRvCoBe4p97cewPmNouoKof/FOOS3S6FZZz
         FNiQ==
X-Gm-Message-State: AOJu0Yy4OSciYgzDVBpY0gc4mUBn9p2InqMKGwDs5C517AUiu4M2rD5V
        ie+XPNbjJW7bPfoIiZV9FIm0Pdq5MLcMLej3M/0=
X-Google-Smtp-Source: AGHT+IFeD8YkmXUQvQ2+qyEuCbZrBD+M+x4PPE+ScjIGM9Wj9+LdGlqo8yxZQXL6h/GexGeJT/Ttpd+1kjowCfSailQ=
X-Received: by 2002:a17:90b:1c05:b0:285:a0aa:a73e with SMTP id
 oc5-20020a17090b1c0500b00285a0aaa73emr15748734pjb.44.1701306987702; Wed, 29
 Nov 2023 17:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:16:16 -0800
Message-ID: <CAM9d7cj=ojxxdbT095UiwaP+WCRCHMGCU_JYQCWBD-vGiKScjA@mail.gmail.com>
Subject: Re: [PATCH v5 00/50] Improvements to memory use
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> Fix memory leaks detected by address/leak sanitizer affecting LBR
> call-graphs, perf mem and BPF offcpu.
>
> Make branch_type_stat in callchain_list optional as it is large and
> not always necessary - in particular it isn't used by perf top.
>
> Make the allocations of zstd streams, kernel symbols and event copies
> lazier in order to save memory in cases like perf record.
>
> Handle the thread exit event and have it remove the thread from the
> threads set in machine. Don't do this for perf report as it causes a
> regression for task lists, which assume threads are never removed from
> the machine's set, and offcpu events, that may sythensize samples for
> threads that have exited.
>
> Avoid using 8kb buffers for filename__read_str which is excessive for
> reading CPU maps. Add io_dir as an allocation free readdir
> replacement, opendir allocating 32kb by default and the code uses it
> recursively.
>
> Shrink perf map using a two value byte to replace two function
> pointers. Modify the implementation of maps to not use an rbtree as
> the container for maps, instead use a sorted array. Improve locking
> and reference counting issues.
>
> Similar to maps separate out and reimplement threads to use a hashmap
> for lower memory consumption and faster look up. The fixes a
> regression in memory usage where reference count checking switched to
> using non-invasive tree nodes.  Reduce its default size by 32 times
> and improve locking discipline. Also, fix regressions where tids had
> become unordered to make `perf report --tasks` and
> `perf trace --summary` output easier to read.
>
> Better encapsulate the dsos abstraction. Remove the linked list and
> rbtree used for faster iteration and log(n) lookup to a sorted array
> for similar performance but half the memory usage per dso. Improve
> reference counting and locking discipline, adding reference count
> checking to dso. Experimented with, but abandoned, a hashmap
> implementation due to the need for extra storage and the keys not
> being stable.
>
> The overall effect is to reduce memory consumption significantly for
> perf top - with call graphs enabled running longer before 1GB of
> memory is consumed. For a perf record of 'true', the memory
> consumption goes from 39912kb max resident to 20096kb max resident -
> nearly halved. perf inject with -b of a system wide perf record of
> 'true' reduces the max resident by roughly 4.5% (3.4% in v4 due to
> branch_type_stat changes being merged). This is while improving
> correctness with locking discipline and reference count checking.
>
> Patch organization (v5):
>  - 50 patches is a lot, the patches aren't divided as they merge conflict and
>    later patches, for example in dsos, rely on the changes and fixes to maps.

You don't need to do it all at once.  AFAIK the io_dir changes are independent
and you can separate map/maps changes from others.  Maybe you can wait
for map changes merged before working on the dso changes.  I know it'd take
more time but it'd be easier to deal with smaller patches focusing on a single
factor both for you and the reviewers.

p.s. I know I also have a set of ~50 patches and feel sorry about saying
like this. ;-p  Maybe I need to split the data type profiling series too.

Thanks,
Namhyung


>  - the dso reference count checking patch is larger due to switch use of dso to
>    be by accessors, to encapsulate the reference count checker macros. The
>    reference count checking changes within this largely mechanical change amount
>    to a few lines and so weren't separated.
>  - the first patch contains a build fix if the rwsem error checking is
>    enabled missed from v3.
>  - the next patches are an assortment of memory size fixes.
>  - the next patches are the refactoring of maps.
>  - the next patches are the refactoring of threads.
>  - the next patches are the refactoring of dsos.
>  - finally reference count checking is added to dso and some lock/reference
>    count issues are resolved. This is done after changing the data structures,
>    for example, as the single pointer on an array is easier to add reference
>    count checking to compared to the 5 previous pointers.
>
> v5: 3 patches were merged. 2nd patch addressed feedback from
>     namhyung@kernel.org and Guilherme Amadio <amadio@gentoo.org>. 4th
>     patch rename function to getdelim as suggested by
>     namhyung@kernel.org. 5 patch adds the missing sysfs mountpoint as
>     suggested by namhyung@kernel.org. 49th patch fix a missed put in
>     the dso_data tests.
> v4: Rebased as 11 changes moved to perf-tools-next. Address comments
>     from v3 such as error checking on zstd streams. Improve the
>     dsos/dso in ways similar to threads and maps, with the addition of
>     reference count checking on dso.
> v3: Additional memory/speed improvements, in particular for maps and
>     threads. Address review comments from namhyung@kernel.org and
>     adrian.hunter@intel.com.
> v2: Add additional memory fixes on top of initial LBR and rc check
>     fixes.
>
> Ian Rogers (50):
>   perf comm: Use regular mutex
>   libperf: Lazily allocate/size mmap event copy
>   perf mmap: Lazily initialize zstd streams
>   tools api fs: Switch filename__read_str to use io.h
>   tools api fs: Avoid reading whole file for a 1 byte bool
>   tools lib api: Add io_dir an allocation free readdir alternative
>   perf maps: Switch modules tree walk to io_dir__readdir
>   perf record: Be lazier in allocating lost samples buffer
>   perf pmu: Switch to io_dir__readdir
>   perf header: Switch mem topology to io_dir__readdir
>   perf events: Remove scandir in thread synthesis
>   perf map: Simplify map_ip/unmap_ip and make map size smaller
>   perf maps: Move symbol maps functions to maps.c
>   perf thread: Add missing RC_CHK_EQUAL
>   perf maps: Add maps__for_each_map to call a function on each entry
>   perf maps: Add remove maps function to remove a map based on callback
>   perf debug: Expose debug file
>   perf maps: Refactor maps__fixup_overlappings
>   perf maps: Do simple merge if given map doesn't overlap
>   perf maps: Rename clone to copy from
>   perf maps: Add maps__load_first
>   perf maps: Add find next entry to give entry after the given map
>   perf maps: Reduce scope of map_rb_node and maps internals
>   perf maps: Fix up overlaps during fixup_end
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps
>   perf dso: Reorder variables to save space in struct dso
>   perf report: Sort child tasks by tid
>   perf trace: Ignore thread hashing in summary
>   perf machine: Move fprintf to for_each loop and a callback
>   perf threads: Move threads to its own files
>   perf threads: Switch from rbtree to hashmap
>   perf threads: Reduce table size from 256 to 8
>   perf dsos: Attempt to better abstract dsos internals
>   perf dsos: Tidy reference counting and locking
>   perf dsos: Add dsos__for_each_dso
>   perf dso: Move dso functions out of dsos
>   perf dsos: Switch more loops to dsos__for_each_dso
>   perf dsos: Switch backing storage to array from rbtree/list
>   perf dsos: Remove __dsos__addnew
>   perf dsos: Remove __dsos__findnew_link_by_longname_id
>   perf dsos: Switch hand code to bsearch
>   perf dso: Add reference count checking and accessor functions
>   perf dso: Reference counting related fixes
>   perf dso: Use container_of to avoid a pointer in dso_data
>   perf env: Avoid recursively taking env->bpf_progs.lock
>
>  tools/lib/api/Makefile                        |    2 +-
>  tools/lib/api/fs/fs.c                         |   80 +-
>  tools/lib/api/io.h                            |   11 +-
>  tools/lib/api/io_dir.h                        |   75 +
>  tools/lib/perf/include/internal/mmap.h        |    3 +-
>  tools/lib/perf/mmap.c                         |   21 +-
>  tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
>  tools/perf/arch/x86/util/event.c              |  103 +-
>  tools/perf/builtin-annotate.c                 |    6 +-
>  tools/perf/builtin-buildid-cache.c            |    2 +-
>  tools/perf/builtin-buildid-list.c             |   18 +-
>  tools/perf/builtin-inject.c                   |   96 +-
>  tools/perf/builtin-kallsyms.c                 |    2 +-
>  tools/perf/builtin-mem.c                      |    4 +-
>  tools/perf/builtin-record.c                   |   57 +-
>  tools/perf/builtin-report.c                   |  243 ++--
>  tools/perf/builtin-script.c                   |    8 +-
>  tools/perf/builtin-top.c                      |    4 +-
>  tools/perf/builtin-trace.c                    |   41 +-
>  tools/perf/tests/code-reading.c               |    8 +-
>  tools/perf/tests/dso-data.c                   |   67 +-
>  tools/perf/tests/hists_common.c               |    6 +-
>  tools/perf/tests/hists_cumulate.c             |    4 +-
>  tools/perf/tests/hists_output.c               |    2 +-
>  tools/perf/tests/maps.c                       |   64 +-
>  tools/perf/tests/symbols.c                    |    2 +-
>  tools/perf/tests/thread-maps-share.c          |    8 +-
>  tools/perf/tests/vmlinux-kallsyms.c           |  181 +--
>  tools/perf/ui/browsers/annotate.c             |    6 +-
>  tools/perf/ui/browsers/hists.c                |    8 +-
>  tools/perf/ui/browsers/map.c                  |    4 +-
>  tools/perf/util/Build                         |    1 +
>  tools/perf/util/annotate.c                    |   44 +-
>  tools/perf/util/auxtrace.c                    |    2 +-
>  tools/perf/util/block-info.c                  |    2 +-
>  tools/perf/util/bpf-event.c                   |   17 +-
>  tools/perf/util/bpf-event.h                   |   12 +-
>  tools/perf/util/bpf_lock_contention.c         |   10 +-
>  tools/perf/util/build-id.c                    |  136 +-
>  tools/perf/util/build-id.h                    |    2 -
>  tools/perf/util/callchain.c                   |    4 +-
>  tools/perf/util/comm.c                        |   10 +-
>  tools/perf/util/compress.h                    |    6 +-
>  tools/perf/util/data-convert-json.c           |    2 +-
>  tools/perf/util/db-export.c                   |    6 +-
>  tools/perf/util/debug.c                       |   22 +-
>  tools/perf/util/debug.h                       |    1 +
>  tools/perf/util/dlfilter.c                    |   12 +-
>  tools/perf/util/dso.c                         |  468 ++++---
>  tools/perf/util/dso.h                         |  544 ++++++--
>  tools/perf/util/dsos.c                        |  529 ++++---
>  tools/perf/util/dsos.h                        |   40 +-
>  tools/perf/util/env.c                         |   53 +-
>  tools/perf/util/env.h                         |    4 +
>  tools/perf/util/event.c                       |   12 +-
>  tools/perf/util/header.c                      |   47 +-
>  tools/perf/util/hist.c                        |    4 +-
>  tools/perf/util/intel-pt.c                    |   22 +-
>  tools/perf/util/machine.c                     |  652 +++------
>  tools/perf/util/machine.h                     |   32 +-
>  tools/perf/util/map.c                         |   93 +-
>  tools/perf/util/map.h                         |   83 +-
>  tools/perf/util/maps.c                        | 1239 +++++++++++++----
>  tools/perf/util/maps.h                        |   95 +-
>  tools/perf/util/mmap.c                        |    5 +-
>  tools/perf/util/mmap.h                        |    1 -
>  tools/perf/util/pmu.c                         |   48 +-
>  tools/perf/util/pmus.c                        |   30 +-
>  tools/perf/util/probe-event.c                 |   62 +-
>  tools/perf/util/rb_resort.h                   |    5 -
>  .../scripting-engines/trace-event-python.c    |   21 +-
>  tools/perf/util/session.c                     |   21 +
>  tools/perf/util/session.h                     |    2 +
>  tools/perf/util/sort.c                        |   19 +-
>  tools/perf/util/srcline.c                     |   65 +-
>  tools/perf/util/symbol-elf.c                  |  138 +-
>  tools/perf/util/symbol.c                      |  521 ++-----
>  tools/perf/util/symbol.h                      |    1 -
>  tools/perf/util/symbol_fprintf.c              |    4 +-
>  tools/perf/util/synthetic-events.c            |  156 ++-
>  tools/perf/util/thread.c                      |   48 +-
>  tools/perf/util/thread.h                      |    6 -
>  tools/perf/util/threads.c                     |  186 +++
>  tools/perf/util/threads.h                     |   35 +
>  tools/perf/util/unwind-libunwind-local.c      |   50 +-
>  tools/perf/util/unwind-libunwind.c            |    9 +-
>  tools/perf/util/vdso.c                        |   89 +-
>  tools/perf/util/zstd.c                        |   63 +-
>  88 files changed, 4101 insertions(+), 2827 deletions(-)
>  create mode 100644 tools/lib/api/io_dir.h
>  create mode 100644 tools/perf/util/threads.c
>  create mode 100644 tools/perf/util/threads.h
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
